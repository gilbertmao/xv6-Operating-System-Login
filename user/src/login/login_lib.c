#include "types.h"
#include "user.h"
#include "login.h"
#include "fcntl.h"
#include "crypto/sha256.h"

#define MAX_LOGINS (0xFFFF - 1)
#define HASH_SIZE  (32)

int fd;
int num_users;
char usernames[MAX_LOGINS][MAX_INPUT_SIZE];
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);

    int i = 0;
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        if (i % 2 == 0) {  // Username on even lines
            strcpy(usernames[i / 2], buf);
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
        i++;
    }

    num_users = i / 2;

    if (n < 0) {
        printf(1, "cat: read error\n");
        exit();
    }
}

void writeback() {
    fd = open(SECRETS, O_CREATE | O_RDWR);
    for (int i = 0; i < num_users; i++) {
        write(fd, usernames[i], MAX_INPUT_SIZE);
        write(fd, passwords[i], MAX_INPUT_SIZE);
    }
    close(fd);
}

/**
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    strcpy(usernames[0], "root");
    const char* root_passwd = "admin";
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    salted_password[MAX_PASSWD_LEN] = 'c';

    sha256_init(&context);
    sha256_hash(&context, salted_password, strlen(salted_password));
    sha256_done(&context, hash);
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    memmove(passwords[0], hash, HASH_SIZE);

    read_info();
    fd = open(SECRETS, O_RDWR);
    write(fd, usernames[0], MAX_INPUT_SIZE);
    write(fd, passwords[0], MAX_INPUT_SIZE);
    close(fd);
}

/**
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    read_info();

    for (int i = 0; i < num_users; i++) {
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
            return 0;
        }
    }
    return -1;
}

/**
 * Create a user in the system associated with the username and password. Cannot
 * overwrite an existing username with a new password. Expectation is for
 * created users to have a unique non-root uid.
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    read_info();

    int open = -1;
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
        if (strcmp(username, usernames[i]) == 0) {
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
        }

        if (usernames[i][0] == 0) {
            open = i;
            break;
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
        salted_password[MAX_PASSWD_LEN] = 'c';

        sha256_init(&context);
        sha256_hash(&context, salted_password, strlen(salted_password));
        sha256_done(&context, hash);

        strcpy(usernames[open], username);
        memset(passwords[open], 0, MAX_INPUT_SIZE);
        memmove(passwords[open], hash, HASH_SIZE);

        num_users++;
        writeback();
        return 0;
    }

    return -1;
}

/**
 * Login a user in the system associated with the username and password. Launch
 * the shell under the right permissions for the user. If no such user exists
 * or the password is incorrect, then login will fail.
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    read_info();

    for (int i = 0; i < MAX_LOGINS; i++) {
        
        if (strcmp(username, usernames[i]) == 0) {
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
            salted_password[MAX_PASSWD_LEN] = 'c';
            
            sha256_init(&context);
            sha256_hash(&context, salted_password, strlen(salted_password));
            sha256_done(&context, hash);

            for (int j = 0; j < 32; j++) {
                if ((char) hash[j] != (char) passwords[i][j]) {
                    return -1;
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
            pid = fork();
            if (pid < 0) {
                printf(1, "init: fork failed\n");
                exit();
            }
            if (pid == 0) {
                setuid(i);
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
                printf(1, "init: exec sh failed\n");
                exit();
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
        }
    }

    return -1;
}