<!-- Added -->
# Lab 4 -- User-Isolation, File Permissions and Large File Support

Create a simple (but realistic) user system, a file permission system, a
a user-space login system, and add support for large files.

## Part 1 -- Adding Users

```c
/**
 * Sets the uid of the current process
 * 
 * @param uid The uid to change to. Valid ranges are 0x0 - 0xFFFF
 * @returns 0 on success, -1 on failure
 */
int setuid(int);

/**
 * Gets the uid of the currently running process.
 *
 * @returns The current process's uid.
 */
int getuid(void);
```

Beyond this description the following rules should be applied for uids:

- The uid of `init` is 0 and is considered the root process.
- Each child process inherits its parent's `uid`
- Only processes with `uid` 0 may change their `uid` through `setuid`

## Part 2 -- File Permissions

Add several properties to each file and directory within xv6.
First, the `owner` field will determine which uid `owns` a specific file.
Second, the `permission` field will determine the access privileges non-owners
have for a specific file.

### Logical Permissions

The permission system logically works in the following way:

- If a file is accessed by its owner or `uid` 0 (henceforth `root`), then that
  access is permitted
- If a file is accessed for reading by another user (not its owner or root)
  and its read permission is set, that access is permitted
- If a file is accessed for writing by another user (not its owner or root)
  and its write permission is set, that access is permitted
- All other accesses are not permitted

A sample of operations involving
file accesses are included below:

- directory reads (read)
- open (read and/or write, depending on the flags)
- file creation (write to file's directory)
- exec (read)

If an operation is not permitted, the system call should return -1, and no
changes to the disk or file-system state should occur. If an operation is
permitted, the operation should complete as it did before the permission system
was added.

### System Call Interface

Add two new system calls to the xv6 filesystem:

```c
/**
 * Changes the owner of the file at filename to uid. On failure, no permissions
 * are changed.
 *
 * @param filename A filesystem path naming the file to change
 * @param uid The new owner of the file, valid range is 0x0-0xFFFF
 * @returns 0 on success, -1 on failure
 */

int chown(const char *filename, int uid);

/**
 * Changes the permissions of the file at filename to perm. On failure, no
 * permissions are changed.
 *
 * @param filename A filesystem path naming the file to change
 * @param perm The new permissions for the file.
 * @returns 0 on success, -1 on failure.
 */

int chmod(const char *filename, int perm);
```

### Physical Disk Layout Requirements

All changes to file ownership or permissions should be atomically persisted to
disk
The on-disk layout of the file's inode must be:

```txt
+0x00 - 2bytes - type  -- file type
+0x02 - 2bytes - major -- major device number
+0x04 - 2bytes - minor -- minor device number
+0x06 - 2bytes - nlink -- number of links to inode in the file system
+0x08 - 4bytes - size  -- size of the file in bytes
+0x0c - 2bytes - owner -- Owner uid of the file
+0x0e - 2bytes - perms -- Permissions of the file
+0x10 - 48bytes - addres -- Array of data block addresses + indirect block address
```

Additionally, the following requirements must be followed for all file system
operations:

- Operations must persist across restarts
- All filesystem operations (including `chown` and `chmod`) must be persistent
  and atomic. 

## Part 3 -- Login

In xv6, the initial user-space process launches the shell directly without
considering what user is currently logged in. 

```txt
init -> login -> (downgrade permission from root to user's uid) -> shell
```

This existing login infrastructure will hook into user-space functions which
you will be expected to implement. The lifecycle of the login system interleaved
with these functions (which are denoted with square brackets e.g. \[init_hook\])
looks like the following:

```txt
init:
  [init_hook()]
  <infinite loop> {
    login:
      <fetch username from console>
      if [does_user_exist(username)] {
        <prompt for password>
      } else {
        <prompt for new password>
        [create_user(username, password)]
      }
      [login_user(username, password)]
  }
```

```c
/**
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook();

/**
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char *username);

/**
 * Create a user in the system associated with the username and password. Cannot
 * overwrite an existing username with a new password. Expectation is for
 * created users to have a unique non-root uid.
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char *username, char *password);

/**
 * Login a user in the system associated with the username and password. Launch
 * the shell under the right permissions for the user. If no such user exists
 * or the password is incorrect, then login will fail.
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char *username, char *password);
```

<!-- Added -->
## Part 4 -- Large File Support

The file system in xv6 is designed such that the maximum file size is only 140 sectors/blocks (in xv6, the size of a block and disk sector coincide). Add support for much larger file sizes. 

### Free Blocks on Disk

```c
/**
 * Report the number of free blocks on the disk
 * 
 * @return number of free blocks (integer)
 */
int get_free_blocks();
```
