
_login:     file format elf32-i386


Disassembly of section .text:

00000000 <get_input>:
 * Prompt and get input from console
 * 
 * @param prompt Console output to display to user to prompt a response
 * @return heap allocated input response if success, else (char *) 0x0
 */
char* get_input(const char* prompt) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    memset(buf, 0, sizeof(MAX_INPUT_SIZE));
       6:	83 ec 04             	sub    $0x4,%esp
       9:	6a 04                	push   $0x4
       b:	6a 00                	push   $0x0
       d:	8d 45 8c             	lea    -0x74(%ebp),%eax
      10:	50                   	push   %eax
      11:	e8 35 03 00 00       	call   34b <memset>
      16:	83 c4 10             	add    $0x10,%esp

    printf(1, "%s", prompt);
      19:	83 ec 04             	sub    $0x4,%esp
      1c:	ff 75 08             	push   0x8(%ebp)
      1f:	68 80 20 00 00       	push   $0x2080
      24:	6a 01                	push   $0x1
      26:	e8 ac 07 00 00       	call   7d7 <printf>
      2b:	83 c4 10             	add    $0x10,%esp
    gets(buf, MAX_INPUT_SIZE);
      2e:	83 ec 08             	sub    $0x8,%esp
      31:	6a 64                	push   $0x64
      33:	8d 45 8c             	lea    -0x74(%ebp),%eax
      36:	50                   	push   %eax
      37:	e8 5c 03 00 00       	call   398 <gets>
      3c:	83 c4 10             	add    $0x10,%esp

    if (buf[0] != 0) {
      3f:	0f b6 45 8c          	movzbl -0x74(%ebp),%eax
      43:	84 c0                	test   %al,%al
      45:	74 59                	je     a0 <get_input+0xa0>
        buf[MAX_INPUT_SIZE - 1] = 0;
      47:	c6 45 ef 00          	movb   $0x0,-0x11(%ebp)
        uint input_length = strlen(buf);
      4b:	83 ec 0c             	sub    $0xc,%esp
      4e:	8d 45 8c             	lea    -0x74(%ebp),%eax
      51:	50                   	push   %eax
      52:	e8 cd 02 00 00       	call   324 <strlen>
      57:	83 c4 10             	add    $0x10,%esp
      5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        char* input = malloc(input_length);
      5d:	83 ec 0c             	sub    $0xc,%esp
      60:	ff 75 f4             	push   -0xc(%ebp)
      63:	e8 b8 05 00 00       	call   620 <malloc>
      68:	83 c4 10             	add    $0x10,%esp
      6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (input != (char*) 0x0) {
      6e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      72:	74 2c                	je     a0 <get_input+0xa0>
            memmove(input, buf, input_length - 1);
      74:	8b 45 f4             	mov    -0xc(%ebp),%eax
      77:	83 e8 01             	sub    $0x1,%eax
      7a:	83 ec 04             	sub    $0x4,%esp
      7d:	50                   	push   %eax
      7e:	8d 45 8c             	lea    -0x74(%ebp),%eax
      81:	50                   	push   %eax
      82:	ff 75 f0             	push   -0x10(%ebp)
      85:	e8 17 04 00 00       	call   4a1 <memmove>
      8a:	83 c4 10             	add    $0x10,%esp
            input[input_length - 1] = 0;
      8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      90:	8d 50 ff             	lea    -0x1(%eax),%edx
      93:	8b 45 f0             	mov    -0x10(%ebp),%eax
      96:	01 d0                	add    %edx,%eax
      98:	c6 00 00             	movb   $0x0,(%eax)
            return input;
      9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9e:	eb 05                	jmp    a5 <get_input+0xa5>
        }
    }

    return (char*) 0x0;
      a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
      a5:	c9                   	leave  
      a6:	c3                   	ret    

000000a7 <assert_char_ptr>:

static inline void assert_char_ptr(char* data, const char* err) {
      a7:	55                   	push   %ebp
      a8:	89 e5                	mov    %esp,%ebp
      aa:	83 ec 08             	sub    $0x8,%esp
    if (data == (char*) 0x0) {
      ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
      b1:	75 1a                	jne    cd <assert_char_ptr+0x26>
        printf(2, "%s\n", err);
      b3:	83 ec 04             	sub    $0x4,%esp
      b6:	ff 75 0c             	push   0xc(%ebp)
      b9:	68 83 20 00 00       	push   $0x2083
      be:	6a 02                	push   $0x2
      c0:	e8 12 07 00 00       	call   7d7 <printf>
      c5:	83 c4 10             	add    $0x10,%esp
        exit();
      c8:	e8 fa 00 00 00       	call   1c7 <exit>
    }
}
      cd:	90                   	nop
      ce:	c9                   	leave  
      cf:	c3                   	ret    

000000d0 <main>:

int main(void) {
      d0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      d4:	83 e4 f0             	and    $0xfffffff0,%esp
      d7:	ff 71 fc             	push   -0x4(%ecx)
      da:	55                   	push   %ebp
      db:	89 e5                	mov    %esp,%ebp
      dd:	51                   	push   %ecx
      de:	83 ec 14             	sub    $0x14,%esp
    char* username = get_input("\nxv6 login: ");
      e1:	83 ec 0c             	sub    $0xc,%esp
      e4:	68 87 20 00 00       	push   $0x2087
      e9:	e8 12 ff ff ff       	call   0 <get_input>
      ee:	83 c4 10             	add    $0x10,%esp
      f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert_char_ptr(username, "Unable to get username");
      f4:	83 ec 08             	sub    $0x8,%esp
      f7:	68 94 20 00 00       	push   $0x2094
      fc:	ff 75 f0             	push   -0x10(%ebp)
      ff:	e8 a3 ff ff ff       	call   a7 <assert_char_ptr>
     104:	83 c4 10             	add    $0x10,%esp

    // check if user exists or prompt to create new user
    char* password;
    if (does_user_exist(username) < 0) {
     107:	83 ec 0c             	sub    $0xc,%esp
     10a:	ff 75 f0             	push   -0x10(%ebp)
     10d:	e8 ff 1b 00 00       	call   1d11 <does_user_exist>
     112:	83 c4 10             	add    $0x10,%esp
     115:	85 c0                	test   %eax,%eax
     117:	79 55                	jns    16e <main+0x9e>
        password = get_input("User not found. Create with a password: ");
     119:	83 ec 0c             	sub    $0xc,%esp
     11c:	68 ac 20 00 00       	push   $0x20ac
     121:	e8 da fe ff ff       	call   0 <get_input>
     126:	83 c4 10             	add    $0x10,%esp
     129:	89 45 f4             	mov    %eax,-0xc(%ebp)
        assert_char_ptr(password, "Unable to get password");
     12c:	83 ec 08             	sub    $0x8,%esp
     12f:	68 d5 20 00 00       	push   $0x20d5
     134:	ff 75 f4             	push   -0xc(%ebp)
     137:	e8 6b ff ff ff       	call   a7 <assert_char_ptr>
     13c:	83 c4 10             	add    $0x10,%esp
        if (create_user(username, password) < 0) {
     13f:	83 ec 08             	sub    $0x8,%esp
     142:	ff 75 f4             	push   -0xc(%ebp)
     145:	ff 75 f0             	push   -0x10(%ebp)
     148:	e8 12 1c 00 00       	call   1d5f <create_user>
     14d:	83 c4 10             	add    $0x10,%esp
     150:	85 c0                	test   %eax,%eax
     152:	79 40                	jns    194 <main+0xc4>
            printf(2, "login: unable to create user '%s' with password '%s'\n",
     154:	ff 75 f4             	push   -0xc(%ebp)
     157:	ff 75 f0             	push   -0x10(%ebp)
     15a:	68 ec 20 00 00       	push   $0x20ec
     15f:	6a 02                	push   $0x2
     161:	e8 71 06 00 00       	call   7d7 <printf>
     166:	83 c4 10             	add    $0x10,%esp
                   username, password);
            exit();
     169:	e8 59 00 00 00       	call   1c7 <exit>
        }
    } else {
        password = get_input("password: ");
     16e:	83 ec 0c             	sub    $0xc,%esp
     171:	68 22 21 00 00       	push   $0x2122
     176:	e8 85 fe ff ff       	call   0 <get_input>
     17b:	83 c4 10             	add    $0x10,%esp
     17e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        assert_char_ptr(password, "Unable to get password");
     181:	83 ec 08             	sub    $0x8,%esp
     184:	68 d5 20 00 00       	push   $0x20d5
     189:	ff 75 f4             	push   -0xc(%ebp)
     18c:	e8 16 ff ff ff       	call   a7 <assert_char_ptr>
     191:	83 c4 10             	add    $0x10,%esp
    }

    login_user(username, password);
     194:	83 ec 08             	sub    $0x8,%esp
     197:	ff 75 f4             	push   -0xc(%ebp)
     19a:	ff 75 f0             	push   -0x10(%ebp)
     19d:	e8 1d 1d 00 00       	call   1ebf <login_user>
     1a2:	83 c4 10             	add    $0x10,%esp
    printf(2,
     1a5:	ff 75 f4             	push   -0xc(%ebp)
     1a8:	ff 75 f0             	push   -0x10(%ebp)
     1ab:	68 30 21 00 00       	push   $0x2130
     1b0:	6a 02                	push   $0x2
     1b2:	e8 20 06 00 00       	call   7d7 <printf>
     1b7:	83 c4 10             	add    $0x10,%esp
           "login: login_user failed to launch shell for user '%s' with "
           "password '%s'\n",
           username, password);
    exit();
     1ba:	e8 08 00 00 00       	call   1c7 <exit>

000001bf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     1bf:	b8 01 00 00 00       	mov    $0x1,%eax
     1c4:	cd 40                	int    $0x40
     1c6:	c3                   	ret    

000001c7 <exit>:
SYSCALL(exit)
     1c7:	b8 02 00 00 00       	mov    $0x2,%eax
     1cc:	cd 40                	int    $0x40
     1ce:	c3                   	ret    

000001cf <wait>:
SYSCALL(wait)
     1cf:	b8 03 00 00 00       	mov    $0x3,%eax
     1d4:	cd 40                	int    $0x40
     1d6:	c3                   	ret    

000001d7 <pipe>:
SYSCALL(pipe)
     1d7:	b8 04 00 00 00       	mov    $0x4,%eax
     1dc:	cd 40                	int    $0x40
     1de:	c3                   	ret    

000001df <read>:
SYSCALL(read)
     1df:	b8 05 00 00 00       	mov    $0x5,%eax
     1e4:	cd 40                	int    $0x40
     1e6:	c3                   	ret    

000001e7 <write>:
SYSCALL(write)
     1e7:	b8 10 00 00 00       	mov    $0x10,%eax
     1ec:	cd 40                	int    $0x40
     1ee:	c3                   	ret    

000001ef <close>:
SYSCALL(close)
     1ef:	b8 15 00 00 00       	mov    $0x15,%eax
     1f4:	cd 40                	int    $0x40
     1f6:	c3                   	ret    

000001f7 <kill>:
SYSCALL(kill)
     1f7:	b8 06 00 00 00       	mov    $0x6,%eax
     1fc:	cd 40                	int    $0x40
     1fe:	c3                   	ret    

000001ff <exec>:
SYSCALL(exec)
     1ff:	b8 07 00 00 00       	mov    $0x7,%eax
     204:	cd 40                	int    $0x40
     206:	c3                   	ret    

00000207 <open>:
SYSCALL(open)
     207:	b8 0f 00 00 00       	mov    $0xf,%eax
     20c:	cd 40                	int    $0x40
     20e:	c3                   	ret    

0000020f <mknod>:
SYSCALL(mknod)
     20f:	b8 11 00 00 00       	mov    $0x11,%eax
     214:	cd 40                	int    $0x40
     216:	c3                   	ret    

00000217 <unlink>:
SYSCALL(unlink)
     217:	b8 12 00 00 00       	mov    $0x12,%eax
     21c:	cd 40                	int    $0x40
     21e:	c3                   	ret    

0000021f <fstat>:
SYSCALL(fstat)
     21f:	b8 08 00 00 00       	mov    $0x8,%eax
     224:	cd 40                	int    $0x40
     226:	c3                   	ret    

00000227 <link>:
SYSCALL(link)
     227:	b8 13 00 00 00       	mov    $0x13,%eax
     22c:	cd 40                	int    $0x40
     22e:	c3                   	ret    

0000022f <mkdir>:
SYSCALL(mkdir)
     22f:	b8 14 00 00 00       	mov    $0x14,%eax
     234:	cd 40                	int    $0x40
     236:	c3                   	ret    

00000237 <chdir>:
SYSCALL(chdir)
     237:	b8 09 00 00 00       	mov    $0x9,%eax
     23c:	cd 40                	int    $0x40
     23e:	c3                   	ret    

0000023f <dup>:
SYSCALL(dup)
     23f:	b8 0a 00 00 00       	mov    $0xa,%eax
     244:	cd 40                	int    $0x40
     246:	c3                   	ret    

00000247 <getpid>:
SYSCALL(getpid)
     247:	b8 0b 00 00 00       	mov    $0xb,%eax
     24c:	cd 40                	int    $0x40
     24e:	c3                   	ret    

0000024f <sbrk>:
SYSCALL(sbrk)
     24f:	b8 0c 00 00 00       	mov    $0xc,%eax
     254:	cd 40                	int    $0x40
     256:	c3                   	ret    

00000257 <sleep>:
SYSCALL(sleep)
     257:	b8 0d 00 00 00       	mov    $0xd,%eax
     25c:	cd 40                	int    $0x40
     25e:	c3                   	ret    

0000025f <uptime>:
SYSCALL(uptime)
     25f:	b8 0e 00 00 00       	mov    $0xe,%eax
     264:	cd 40                	int    $0x40
     266:	c3                   	ret    

00000267 <setuid>:
SYSCALL(setuid)
     267:	b8 16 00 00 00       	mov    $0x16,%eax
     26c:	cd 40                	int    $0x40
     26e:	c3                   	ret    

0000026f <getuid>:
SYSCALL(getuid)
     26f:	b8 19 00 00 00       	mov    $0x19,%eax
     274:	cd 40                	int    $0x40
     276:	c3                   	ret    

00000277 <chown>:
SYSCALL(chown)
     277:	b8 18 00 00 00       	mov    $0x18,%eax
     27c:	cd 40                	int    $0x40
     27e:	c3                   	ret    

0000027f <chmod>:
SYSCALL(chmod)
     27f:	b8 17 00 00 00       	mov    $0x17,%eax
     284:	cd 40                	int    $0x40
     286:	c3                   	ret    

00000287 <report_stats>:
SYSCALL(report_stats)
     287:	b8 1a 00 00 00       	mov    $0x1a,%eax
     28c:	cd 40                	int    $0x40
     28e:	c3                   	ret    

0000028f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     28f:	55                   	push   %ebp
     290:	89 e5                	mov    %esp,%ebp
     292:	57                   	push   %edi
     293:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     294:	8b 4d 08             	mov    0x8(%ebp),%ecx
     297:	8b 55 10             	mov    0x10(%ebp),%edx
     29a:	8b 45 0c             	mov    0xc(%ebp),%eax
     29d:	89 cb                	mov    %ecx,%ebx
     29f:	89 df                	mov    %ebx,%edi
     2a1:	89 d1                	mov    %edx,%ecx
     2a3:	fc                   	cld    
     2a4:	f3 aa                	rep stos %al,%es:(%edi)
     2a6:	89 ca                	mov    %ecx,%edx
     2a8:	89 fb                	mov    %edi,%ebx
     2aa:	89 5d 08             	mov    %ebx,0x8(%ebp)
     2ad:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     2b0:	90                   	nop
     2b1:	5b                   	pop    %ebx
     2b2:	5f                   	pop    %edi
     2b3:	5d                   	pop    %ebp
     2b4:	c3                   	ret    

000002b5 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     2b5:	55                   	push   %ebp
     2b6:	89 e5                	mov    %esp,%ebp
     2b8:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     2bb:	8b 45 08             	mov    0x8(%ebp),%eax
     2be:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     2c1:	90                   	nop
     2c2:	8b 55 0c             	mov    0xc(%ebp),%edx
     2c5:	8d 42 01             	lea    0x1(%edx),%eax
     2c8:	89 45 0c             	mov    %eax,0xc(%ebp)
     2cb:	8b 45 08             	mov    0x8(%ebp),%eax
     2ce:	8d 48 01             	lea    0x1(%eax),%ecx
     2d1:	89 4d 08             	mov    %ecx,0x8(%ebp)
     2d4:	0f b6 12             	movzbl (%edx),%edx
     2d7:	88 10                	mov    %dl,(%eax)
     2d9:	0f b6 00             	movzbl (%eax),%eax
     2dc:	84 c0                	test   %al,%al
     2de:	75 e2                	jne    2c2 <strcpy+0xd>
        ;
    return os;
     2e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2e3:	c9                   	leave  
     2e4:	c3                   	ret    

000002e5 <strcmp>:

int strcmp(const char* p, const char* q) {
     2e5:	55                   	push   %ebp
     2e6:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     2e8:	eb 08                	jmp    2f2 <strcmp+0xd>
     2ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2ee:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     2f2:	8b 45 08             	mov    0x8(%ebp),%eax
     2f5:	0f b6 00             	movzbl (%eax),%eax
     2f8:	84 c0                	test   %al,%al
     2fa:	74 10                	je     30c <strcmp+0x27>
     2fc:	8b 45 08             	mov    0x8(%ebp),%eax
     2ff:	0f b6 10             	movzbl (%eax),%edx
     302:	8b 45 0c             	mov    0xc(%ebp),%eax
     305:	0f b6 00             	movzbl (%eax),%eax
     308:	38 c2                	cmp    %al,%dl
     30a:	74 de                	je     2ea <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     30c:	8b 45 08             	mov    0x8(%ebp),%eax
     30f:	0f b6 00             	movzbl (%eax),%eax
     312:	0f b6 d0             	movzbl %al,%edx
     315:	8b 45 0c             	mov    0xc(%ebp),%eax
     318:	0f b6 00             	movzbl (%eax),%eax
     31b:	0f b6 c8             	movzbl %al,%ecx
     31e:	89 d0                	mov    %edx,%eax
     320:	29 c8                	sub    %ecx,%eax
}
     322:	5d                   	pop    %ebp
     323:	c3                   	ret    

00000324 <strlen>:

uint strlen(const char* s) {
     324:	55                   	push   %ebp
     325:	89 e5                	mov    %esp,%ebp
     327:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     32a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     331:	eb 04                	jmp    337 <strlen+0x13>
     333:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     337:	8b 55 fc             	mov    -0x4(%ebp),%edx
     33a:	8b 45 08             	mov    0x8(%ebp),%eax
     33d:	01 d0                	add    %edx,%eax
     33f:	0f b6 00             	movzbl (%eax),%eax
     342:	84 c0                	test   %al,%al
     344:	75 ed                	jne    333 <strlen+0xf>
        ;
    return n;
     346:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     349:	c9                   	leave  
     34a:	c3                   	ret    

0000034b <memset>:

void* memset(void* dst, int c, uint n) {
     34b:	55                   	push   %ebp
     34c:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     34e:	8b 45 10             	mov    0x10(%ebp),%eax
     351:	50                   	push   %eax
     352:	ff 75 0c             	push   0xc(%ebp)
     355:	ff 75 08             	push   0x8(%ebp)
     358:	e8 32 ff ff ff       	call   28f <stosb>
     35d:	83 c4 0c             	add    $0xc,%esp
    return dst;
     360:	8b 45 08             	mov    0x8(%ebp),%eax
}
     363:	c9                   	leave  
     364:	c3                   	ret    

00000365 <strchr>:

char* strchr(const char* s, char c) {
     365:	55                   	push   %ebp
     366:	89 e5                	mov    %esp,%ebp
     368:	83 ec 04             	sub    $0x4,%esp
     36b:	8b 45 0c             	mov    0xc(%ebp),%eax
     36e:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     371:	eb 14                	jmp    387 <strchr+0x22>
        if (*s == c) return (char*) s;
     373:	8b 45 08             	mov    0x8(%ebp),%eax
     376:	0f b6 00             	movzbl (%eax),%eax
     379:	38 45 fc             	cmp    %al,-0x4(%ebp)
     37c:	75 05                	jne    383 <strchr+0x1e>
     37e:	8b 45 08             	mov    0x8(%ebp),%eax
     381:	eb 13                	jmp    396 <strchr+0x31>
    for (; *s; s++)
     383:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     387:	8b 45 08             	mov    0x8(%ebp),%eax
     38a:	0f b6 00             	movzbl (%eax),%eax
     38d:	84 c0                	test   %al,%al
     38f:	75 e2                	jne    373 <strchr+0xe>
    return 0;
     391:	b8 00 00 00 00       	mov    $0x0,%eax
}
     396:	c9                   	leave  
     397:	c3                   	ret    

00000398 <gets>:

char* gets(char* buf, int max) {
     398:	55                   	push   %ebp
     399:	89 e5                	mov    %esp,%ebp
     39b:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     39e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     3a5:	eb 42                	jmp    3e9 <gets+0x51>
        cc = read(0, &c, 1);
     3a7:	83 ec 04             	sub    $0x4,%esp
     3aa:	6a 01                	push   $0x1
     3ac:	8d 45 ef             	lea    -0x11(%ebp),%eax
     3af:	50                   	push   %eax
     3b0:	6a 00                	push   $0x0
     3b2:	e8 28 fe ff ff       	call   1df <read>
     3b7:	83 c4 10             	add    $0x10,%esp
     3ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     3bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3c1:	7e 33                	jle    3f6 <gets+0x5e>
        buf[i++] = c;
     3c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3c6:	8d 50 01             	lea    0x1(%eax),%edx
     3c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3cc:	89 c2                	mov    %eax,%edx
     3ce:	8b 45 08             	mov    0x8(%ebp),%eax
     3d1:	01 c2                	add    %eax,%edx
     3d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3d7:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     3d9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3dd:	3c 0a                	cmp    $0xa,%al
     3df:	74 16                	je     3f7 <gets+0x5f>
     3e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3e5:	3c 0d                	cmp    $0xd,%al
     3e7:	74 0e                	je     3f7 <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     3e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3ec:	83 c0 01             	add    $0x1,%eax
     3ef:	39 45 0c             	cmp    %eax,0xc(%ebp)
     3f2:	7f b3                	jg     3a7 <gets+0xf>
     3f4:	eb 01                	jmp    3f7 <gets+0x5f>
        if (cc < 1) break;
     3f6:	90                   	nop
    }
    buf[i] = '\0';
     3f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3fa:	8b 45 08             	mov    0x8(%ebp),%eax
     3fd:	01 d0                	add    %edx,%eax
     3ff:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     402:	8b 45 08             	mov    0x8(%ebp),%eax
}
     405:	c9                   	leave  
     406:	c3                   	ret    

00000407 <stat>:

int stat(const char* n, struct stat* st) {
     407:	55                   	push   %ebp
     408:	89 e5                	mov    %esp,%ebp
     40a:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     40d:	83 ec 08             	sub    $0x8,%esp
     410:	6a 01                	push   $0x1
     412:	ff 75 08             	push   0x8(%ebp)
     415:	e8 ed fd ff ff       	call   207 <open>
     41a:	83 c4 10             	add    $0x10,%esp
     41d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     420:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     424:	79 07                	jns    42d <stat+0x26>
     426:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     42b:	eb 25                	jmp    452 <stat+0x4b>
    r = fstat(fd, st);
     42d:	83 ec 08             	sub    $0x8,%esp
     430:	ff 75 0c             	push   0xc(%ebp)
     433:	ff 75 f4             	push   -0xc(%ebp)
     436:	e8 e4 fd ff ff       	call   21f <fstat>
     43b:	83 c4 10             	add    $0x10,%esp
     43e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     441:	83 ec 0c             	sub    $0xc,%esp
     444:	ff 75 f4             	push   -0xc(%ebp)
     447:	e8 a3 fd ff ff       	call   1ef <close>
     44c:	83 c4 10             	add    $0x10,%esp
    return r;
     44f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     452:	c9                   	leave  
     453:	c3                   	ret    

00000454 <atoi>:

int atoi(const char* s) {
     454:	55                   	push   %ebp
     455:	89 e5                	mov    %esp,%ebp
     457:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     45a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     461:	eb 25                	jmp    488 <atoi+0x34>
     463:	8b 55 fc             	mov    -0x4(%ebp),%edx
     466:	89 d0                	mov    %edx,%eax
     468:	c1 e0 02             	shl    $0x2,%eax
     46b:	01 d0                	add    %edx,%eax
     46d:	01 c0                	add    %eax,%eax
     46f:	89 c1                	mov    %eax,%ecx
     471:	8b 45 08             	mov    0x8(%ebp),%eax
     474:	8d 50 01             	lea    0x1(%eax),%edx
     477:	89 55 08             	mov    %edx,0x8(%ebp)
     47a:	0f b6 00             	movzbl (%eax),%eax
     47d:	0f be c0             	movsbl %al,%eax
     480:	01 c8                	add    %ecx,%eax
     482:	83 e8 30             	sub    $0x30,%eax
     485:	89 45 fc             	mov    %eax,-0x4(%ebp)
     488:	8b 45 08             	mov    0x8(%ebp),%eax
     48b:	0f b6 00             	movzbl (%eax),%eax
     48e:	3c 2f                	cmp    $0x2f,%al
     490:	7e 0a                	jle    49c <atoi+0x48>
     492:	8b 45 08             	mov    0x8(%ebp),%eax
     495:	0f b6 00             	movzbl (%eax),%eax
     498:	3c 39                	cmp    $0x39,%al
     49a:	7e c7                	jle    463 <atoi+0xf>
    return n;
     49c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     49f:	c9                   	leave  
     4a0:	c3                   	ret    

000004a1 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     4a1:	55                   	push   %ebp
     4a2:	89 e5                	mov    %esp,%ebp
     4a4:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     4a7:	8b 45 08             	mov    0x8(%ebp),%eax
     4aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     4ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     4b3:	eb 17                	jmp    4cc <memmove+0x2b>
     4b5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     4b8:	8d 42 01             	lea    0x1(%edx),%eax
     4bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
     4be:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4c1:	8d 48 01             	lea    0x1(%eax),%ecx
     4c4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     4c7:	0f b6 12             	movzbl (%edx),%edx
     4ca:	88 10                	mov    %dl,(%eax)
     4cc:	8b 45 10             	mov    0x10(%ebp),%eax
     4cf:	8d 50 ff             	lea    -0x1(%eax),%edx
     4d2:	89 55 10             	mov    %edx,0x10(%ebp)
     4d5:	85 c0                	test   %eax,%eax
     4d7:	7f dc                	jg     4b5 <memmove+0x14>
    return vdst;
     4d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4dc:	c9                   	leave  
     4dd:	c3                   	ret    

000004de <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     4de:	55                   	push   %ebp
     4df:	89 e5                	mov    %esp,%ebp
     4e1:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     4e4:	8b 45 08             	mov    0x8(%ebp),%eax
     4e7:	83 e8 08             	sub    $0x8,%eax
     4ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     4ed:	a1 e8 2b 00 00       	mov    0x2be8,%eax
     4f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     4f5:	eb 24                	jmp    51b <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     4f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4fa:	8b 00                	mov    (%eax),%eax
     4fc:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     4ff:	72 12                	jb     513 <free+0x35>
     501:	8b 45 f8             	mov    -0x8(%ebp),%eax
     504:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     507:	77 24                	ja     52d <free+0x4f>
     509:	8b 45 fc             	mov    -0x4(%ebp),%eax
     50c:	8b 00                	mov    (%eax),%eax
     50e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     511:	72 1a                	jb     52d <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     513:	8b 45 fc             	mov    -0x4(%ebp),%eax
     516:	8b 00                	mov    (%eax),%eax
     518:	89 45 fc             	mov    %eax,-0x4(%ebp)
     51b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     51e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     521:	76 d4                	jbe    4f7 <free+0x19>
     523:	8b 45 fc             	mov    -0x4(%ebp),%eax
     526:	8b 00                	mov    (%eax),%eax
     528:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     52b:	73 ca                	jae    4f7 <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     52d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     530:	8b 40 04             	mov    0x4(%eax),%eax
     533:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     53a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     53d:	01 c2                	add    %eax,%edx
     53f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     542:	8b 00                	mov    (%eax),%eax
     544:	39 c2                	cmp    %eax,%edx
     546:	75 24                	jne    56c <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     548:	8b 45 f8             	mov    -0x8(%ebp),%eax
     54b:	8b 50 04             	mov    0x4(%eax),%edx
     54e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     551:	8b 00                	mov    (%eax),%eax
     553:	8b 40 04             	mov    0x4(%eax),%eax
     556:	01 c2                	add    %eax,%edx
     558:	8b 45 f8             	mov    -0x8(%ebp),%eax
     55b:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     55e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     561:	8b 00                	mov    (%eax),%eax
     563:	8b 10                	mov    (%eax),%edx
     565:	8b 45 f8             	mov    -0x8(%ebp),%eax
     568:	89 10                	mov    %edx,(%eax)
     56a:	eb 0a                	jmp    576 <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     56c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     56f:	8b 10                	mov    (%eax),%edx
     571:	8b 45 f8             	mov    -0x8(%ebp),%eax
     574:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     576:	8b 45 fc             	mov    -0x4(%ebp),%eax
     579:	8b 40 04             	mov    0x4(%eax),%eax
     57c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     583:	8b 45 fc             	mov    -0x4(%ebp),%eax
     586:	01 d0                	add    %edx,%eax
     588:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     58b:	75 20                	jne    5ad <free+0xcf>
        p->s.size += bp->s.size;
     58d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     590:	8b 50 04             	mov    0x4(%eax),%edx
     593:	8b 45 f8             	mov    -0x8(%ebp),%eax
     596:	8b 40 04             	mov    0x4(%eax),%eax
     599:	01 c2                	add    %eax,%edx
     59b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     59e:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     5a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5a4:	8b 10                	mov    (%eax),%edx
     5a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5a9:	89 10                	mov    %edx,(%eax)
     5ab:	eb 08                	jmp    5b5 <free+0xd7>
    } else
        p->s.ptr = bp;
     5ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     5b3:	89 10                	mov    %edx,(%eax)
    freep = p;
     5b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5b8:	a3 e8 2b 00 00       	mov    %eax,0x2be8
}
     5bd:	90                   	nop
     5be:	c9                   	leave  
     5bf:	c3                   	ret    

000005c0 <morecore>:

static Header* morecore(uint nu) {
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     5c6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     5cd:	77 07                	ja     5d6 <morecore+0x16>
     5cf:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     5d6:	8b 45 08             	mov    0x8(%ebp),%eax
     5d9:	c1 e0 03             	shl    $0x3,%eax
     5dc:	83 ec 0c             	sub    $0xc,%esp
     5df:	50                   	push   %eax
     5e0:	e8 6a fc ff ff       	call   24f <sbrk>
     5e5:	83 c4 10             	add    $0x10,%esp
     5e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     5eb:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     5ef:	75 07                	jne    5f8 <morecore+0x38>
     5f1:	b8 00 00 00 00       	mov    $0x0,%eax
     5f6:	eb 26                	jmp    61e <morecore+0x5e>
    hp = (Header*) p;
     5f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     5fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     601:	8b 55 08             	mov    0x8(%ebp),%edx
     604:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     607:	8b 45 f0             	mov    -0x10(%ebp),%eax
     60a:	83 c0 08             	add    $0x8,%eax
     60d:	83 ec 0c             	sub    $0xc,%esp
     610:	50                   	push   %eax
     611:	e8 c8 fe ff ff       	call   4de <free>
     616:	83 c4 10             	add    $0x10,%esp
    return freep;
     619:	a1 e8 2b 00 00       	mov    0x2be8,%eax
}
     61e:	c9                   	leave  
     61f:	c3                   	ret    

00000620 <malloc>:

void* malloc(uint nbytes) {
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     626:	8b 45 08             	mov    0x8(%ebp),%eax
     629:	83 c0 07             	add    $0x7,%eax
     62c:	c1 e8 03             	shr    $0x3,%eax
     62f:	83 c0 01             	add    $0x1,%eax
     632:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     635:	a1 e8 2b 00 00       	mov    0x2be8,%eax
     63a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     63d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     641:	75 23                	jne    666 <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     643:	c7 45 f0 e0 2b 00 00 	movl   $0x2be0,-0x10(%ebp)
     64a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     64d:	a3 e8 2b 00 00       	mov    %eax,0x2be8
     652:	a1 e8 2b 00 00       	mov    0x2be8,%eax
     657:	a3 e0 2b 00 00       	mov    %eax,0x2be0
        base.s.size = 0;
     65c:	c7 05 e4 2b 00 00 00 	movl   $0x0,0x2be4
     663:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     666:	8b 45 f0             	mov    -0x10(%ebp),%eax
     669:	8b 00                	mov    (%eax),%eax
     66b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     66e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     671:	8b 40 04             	mov    0x4(%eax),%eax
     674:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     677:	77 4d                	ja     6c6 <malloc+0xa6>
            if (p->s.size == nunits)
     679:	8b 45 f4             	mov    -0xc(%ebp),%eax
     67c:	8b 40 04             	mov    0x4(%eax),%eax
     67f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     682:	75 0c                	jne    690 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     684:	8b 45 f4             	mov    -0xc(%ebp),%eax
     687:	8b 10                	mov    (%eax),%edx
     689:	8b 45 f0             	mov    -0x10(%ebp),%eax
     68c:	89 10                	mov    %edx,(%eax)
     68e:	eb 26                	jmp    6b6 <malloc+0x96>
            else {
                p->s.size -= nunits;
     690:	8b 45 f4             	mov    -0xc(%ebp),%eax
     693:	8b 40 04             	mov    0x4(%eax),%eax
     696:	2b 45 ec             	sub    -0x14(%ebp),%eax
     699:	89 c2                	mov    %eax,%edx
     69b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     69e:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     6a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a4:	8b 40 04             	mov    0x4(%eax),%eax
     6a7:	c1 e0 03             	shl    $0x3,%eax
     6aa:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     6ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     6b3:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     6b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6b9:	a3 e8 2b 00 00       	mov    %eax,0x2be8
            return (void*) (p + 1);
     6be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c1:	83 c0 08             	add    $0x8,%eax
     6c4:	eb 3b                	jmp    701 <malloc+0xe1>
        }
        if (p == freep)
     6c6:	a1 e8 2b 00 00       	mov    0x2be8,%eax
     6cb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     6ce:	75 1e                	jne    6ee <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     6d0:	83 ec 0c             	sub    $0xc,%esp
     6d3:	ff 75 ec             	push   -0x14(%ebp)
     6d6:	e8 e5 fe ff ff       	call   5c0 <morecore>
     6db:	83 c4 10             	add    $0x10,%esp
     6de:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6e5:	75 07                	jne    6ee <malloc+0xce>
     6e7:	b8 00 00 00 00       	mov    $0x0,%eax
     6ec:	eb 13                	jmp    701 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     6ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     6f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f7:	8b 00                	mov    (%eax),%eax
     6f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     6fc:	e9 6d ff ff ff       	jmp    66e <malloc+0x4e>
    }
}
     701:	c9                   	leave  
     702:	c3                   	ret    

00000703 <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     703:	55                   	push   %ebp
     704:	89 e5                	mov    %esp,%ebp
     706:	83 ec 18             	sub    $0x18,%esp
     709:	8b 45 0c             	mov    0xc(%ebp),%eax
     70c:	88 45 f4             	mov    %al,-0xc(%ebp)
     70f:	83 ec 04             	sub    $0x4,%esp
     712:	6a 01                	push   $0x1
     714:	8d 45 f4             	lea    -0xc(%ebp),%eax
     717:	50                   	push   %eax
     718:	ff 75 08             	push   0x8(%ebp)
     71b:	e8 c7 fa ff ff       	call   1e7 <write>
     720:	83 c4 10             	add    $0x10,%esp
     723:	90                   	nop
     724:	c9                   	leave  
     725:	c3                   	ret    

00000726 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     726:	55                   	push   %ebp
     727:	89 e5                	mov    %esp,%ebp
     729:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     72c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     733:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     737:	74 17                	je     750 <printint+0x2a>
     739:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     73d:	79 11                	jns    750 <printint+0x2a>
        neg = 1;
     73f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     746:	8b 45 0c             	mov    0xc(%ebp),%eax
     749:	f7 d8                	neg    %eax
     74b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     74e:	eb 06                	jmp    756 <printint+0x30>
    } else {
        x = xx;
     750:	8b 45 0c             	mov    0xc(%ebp),%eax
     753:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     756:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     75d:	8b 4d 10             	mov    0x10(%ebp),%ecx
     760:	8b 45 ec             	mov    -0x14(%ebp),%eax
     763:	ba 00 00 00 00       	mov    $0x0,%edx
     768:	f7 f1                	div    %ecx
     76a:	89 d1                	mov    %edx,%ecx
     76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     76f:	8d 50 01             	lea    0x1(%eax),%edx
     772:	89 55 f4             	mov    %edx,-0xc(%ebp)
     775:	0f b6 91 a8 2b 00 00 	movzbl 0x2ba8(%ecx),%edx
     77c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     780:	8b 4d 10             	mov    0x10(%ebp),%ecx
     783:	8b 45 ec             	mov    -0x14(%ebp),%eax
     786:	ba 00 00 00 00       	mov    $0x0,%edx
     78b:	f7 f1                	div    %ecx
     78d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     790:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     794:	75 c7                	jne    75d <printint+0x37>
    if (neg) buf[i++] = '-';
     796:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     79a:	74 2d                	je     7c9 <printint+0xa3>
     79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79f:	8d 50 01             	lea    0x1(%eax),%edx
     7a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7a5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     7aa:	eb 1d                	jmp    7c9 <printint+0xa3>
     7ac:	8d 55 dc             	lea    -0x24(%ebp),%edx
     7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b2:	01 d0                	add    %edx,%eax
     7b4:	0f b6 00             	movzbl (%eax),%eax
     7b7:	0f be c0             	movsbl %al,%eax
     7ba:	83 ec 08             	sub    $0x8,%esp
     7bd:	50                   	push   %eax
     7be:	ff 75 08             	push   0x8(%ebp)
     7c1:	e8 3d ff ff ff       	call   703 <putc>
     7c6:	83 c4 10             	add    $0x10,%esp
     7c9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     7cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7d1:	79 d9                	jns    7ac <printint+0x86>
}
     7d3:	90                   	nop
     7d4:	90                   	nop
     7d5:	c9                   	leave  
     7d6:	c3                   	ret    

000007d7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     7d7:	55                   	push   %ebp
     7d8:	89 e5                	mov    %esp,%ebp
     7da:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     7dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     7e4:	8d 45 0c             	lea    0xc(%ebp),%eax
     7e7:	83 c0 04             	add    $0x4,%eax
     7ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     7ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7f4:	e9 59 01 00 00       	jmp    952 <printf+0x17b>
        c = fmt[i] & 0xff;
     7f9:	8b 55 0c             	mov    0xc(%ebp),%edx
     7fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ff:	01 d0                	add    %edx,%eax
     801:	0f b6 00             	movzbl (%eax),%eax
     804:	0f be c0             	movsbl %al,%eax
     807:	25 ff 00 00 00       	and    $0xff,%eax
     80c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     80f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     813:	75 2c                	jne    841 <printf+0x6a>
            if (c == '%') {
     815:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     819:	75 0c                	jne    827 <printf+0x50>
                state = '%';
     81b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     822:	e9 27 01 00 00       	jmp    94e <printf+0x177>
            } else {
                putc(fd, c);
     827:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     82a:	0f be c0             	movsbl %al,%eax
     82d:	83 ec 08             	sub    $0x8,%esp
     830:	50                   	push   %eax
     831:	ff 75 08             	push   0x8(%ebp)
     834:	e8 ca fe ff ff       	call   703 <putc>
     839:	83 c4 10             	add    $0x10,%esp
     83c:	e9 0d 01 00 00       	jmp    94e <printf+0x177>
            }
        } else if (state == '%') {
     841:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     845:	0f 85 03 01 00 00    	jne    94e <printf+0x177>
            if (c == 'd') {
     84b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     84f:	75 1e                	jne    86f <printf+0x98>
                printint(fd, *ap, 10, 1);
     851:	8b 45 e8             	mov    -0x18(%ebp),%eax
     854:	8b 00                	mov    (%eax),%eax
     856:	6a 01                	push   $0x1
     858:	6a 0a                	push   $0xa
     85a:	50                   	push   %eax
     85b:	ff 75 08             	push   0x8(%ebp)
     85e:	e8 c3 fe ff ff       	call   726 <printint>
     863:	83 c4 10             	add    $0x10,%esp
                ap++;
     866:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     86a:	e9 d8 00 00 00       	jmp    947 <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     86f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     873:	74 06                	je     87b <printf+0xa4>
     875:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     879:	75 1e                	jne    899 <printf+0xc2>
                printint(fd, *ap, 16, 0);
     87b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     87e:	8b 00                	mov    (%eax),%eax
     880:	6a 00                	push   $0x0
     882:	6a 10                	push   $0x10
     884:	50                   	push   %eax
     885:	ff 75 08             	push   0x8(%ebp)
     888:	e8 99 fe ff ff       	call   726 <printint>
     88d:	83 c4 10             	add    $0x10,%esp
                ap++;
     890:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     894:	e9 ae 00 00 00       	jmp    947 <printf+0x170>
            } else if (c == 's') {
     899:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     89d:	75 43                	jne    8e2 <printf+0x10b>
                s = (char*) *ap;
     89f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8a2:	8b 00                	mov    (%eax),%eax
     8a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     8a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     8ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8af:	75 25                	jne    8d6 <printf+0xff>
     8b1:	c7 45 f4 7b 21 00 00 	movl   $0x217b,-0xc(%ebp)
                while (*s != 0) {
     8b8:	eb 1c                	jmp    8d6 <printf+0xff>
                    putc(fd, *s);
     8ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bd:	0f b6 00             	movzbl (%eax),%eax
     8c0:	0f be c0             	movsbl %al,%eax
     8c3:	83 ec 08             	sub    $0x8,%esp
     8c6:	50                   	push   %eax
     8c7:	ff 75 08             	push   0x8(%ebp)
     8ca:	e8 34 fe ff ff       	call   703 <putc>
     8cf:	83 c4 10             	add    $0x10,%esp
                    s++;
     8d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     8d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d9:	0f b6 00             	movzbl (%eax),%eax
     8dc:	84 c0                	test   %al,%al
     8de:	75 da                	jne    8ba <printf+0xe3>
     8e0:	eb 65                	jmp    947 <printf+0x170>
                }
            } else if (c == 'c') {
     8e2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     8e6:	75 1d                	jne    905 <printf+0x12e>
                putc(fd, *ap);
     8e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8eb:	8b 00                	mov    (%eax),%eax
     8ed:	0f be c0             	movsbl %al,%eax
     8f0:	83 ec 08             	sub    $0x8,%esp
     8f3:	50                   	push   %eax
     8f4:	ff 75 08             	push   0x8(%ebp)
     8f7:	e8 07 fe ff ff       	call   703 <putc>
     8fc:	83 c4 10             	add    $0x10,%esp
                ap++;
     8ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     903:	eb 42                	jmp    947 <printf+0x170>
            } else if (c == '%') {
     905:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     909:	75 17                	jne    922 <printf+0x14b>
                putc(fd, c);
     90b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     90e:	0f be c0             	movsbl %al,%eax
     911:	83 ec 08             	sub    $0x8,%esp
     914:	50                   	push   %eax
     915:	ff 75 08             	push   0x8(%ebp)
     918:	e8 e6 fd ff ff       	call   703 <putc>
     91d:	83 c4 10             	add    $0x10,%esp
     920:	eb 25                	jmp    947 <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     922:	83 ec 08             	sub    $0x8,%esp
     925:	6a 25                	push   $0x25
     927:	ff 75 08             	push   0x8(%ebp)
     92a:	e8 d4 fd ff ff       	call   703 <putc>
     92f:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     932:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     935:	0f be c0             	movsbl %al,%eax
     938:	83 ec 08             	sub    $0x8,%esp
     93b:	50                   	push   %eax
     93c:	ff 75 08             	push   0x8(%ebp)
     93f:	e8 bf fd ff ff       	call   703 <putc>
     944:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     947:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     94e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     952:	8b 55 0c             	mov    0xc(%ebp),%edx
     955:	8b 45 f0             	mov    -0x10(%ebp),%eax
     958:	01 d0                	add    %edx,%eax
     95a:	0f b6 00             	movzbl (%eax),%eax
     95d:	84 c0                	test   %al,%al
     95f:	0f 85 94 fe ff ff    	jne    7f9 <printf+0x22>
        }
    }
}
     965:	90                   	nop
     966:	90                   	nop
     967:	c9                   	leave  
     968:	c3                   	ret    

00000969 <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     969:	55                   	push   %ebp
     96a:	89 e5                	mov    %esp,%ebp
     96c:	83 ec 04             	sub    $0x4,%esp
     96f:	8b 45 08             	mov    0x8(%ebp),%eax
     972:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     975:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     979:	01 c0                	add    %eax,%eax
     97b:	89 c1                	mov    %eax,%ecx
     97d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     981:	c0 e8 07             	shr    $0x7,%al
     984:	89 c2                	mov    %eax,%edx
     986:	89 d0                	mov    %edx,%eax
     988:	01 c0                	add    %eax,%eax
     98a:	01 d0                	add    %edx,%eax
     98c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     993:	01 d0                	add    %edx,%eax
     995:	31 c8                	xor    %ecx,%eax
}
     997:	c9                   	leave  
     998:	c3                   	ret    

00000999 <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     999:	55                   	push   %ebp
     99a:	89 e5                	mov    %esp,%ebp
     99c:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     99d:	bb 00 00 00 00       	mov    $0x0,%ebx
     9a2:	eb 24                	jmp    9c8 <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     9a4:	0f b6 d3             	movzbl %bl,%edx
     9a7:	8b 45 08             	mov    0x8(%ebp),%eax
     9aa:	01 d0                	add    %edx,%eax
     9ac:	0f b6 00             	movzbl (%eax),%eax
     9af:	0f b6 c0             	movzbl %al,%eax
     9b2:	0f b6 cb             	movzbl %bl,%ecx
     9b5:	8b 55 08             	mov    0x8(%ebp),%edx
     9b8:	01 ca                	add    %ecx,%edx
     9ba:	0f b6 80 a0 21 00 00 	movzbl 0x21a0(%eax),%eax
     9c1:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     9c3:	89 d8                	mov    %ebx,%eax
     9c5:	8d 58 01             	lea    0x1(%eax),%ebx
     9c8:	80 fb 0f             	cmp    $0xf,%bl
     9cb:	76 d7                	jbe    9a4 <aes_subBytes+0xb>
    }
}
     9cd:	90                   	nop
     9ce:	90                   	nop
     9cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9d2:	c9                   	leave  
     9d3:	c3                   	ret    

000009d4 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     9d4:	55                   	push   %ebp
     9d5:	89 e5                	mov    %esp,%ebp
     9d7:	56                   	push   %esi
     9d8:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     9d9:	bb 00 00 00 00       	mov    $0x0,%ebx
     9de:	eb 27                	jmp    a07 <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     9e0:	0f b6 d3             	movzbl %bl,%edx
     9e3:	8b 45 08             	mov    0x8(%ebp),%eax
     9e6:	01 d0                	add    %edx,%eax
     9e8:	0f b6 08             	movzbl (%eax),%ecx
     9eb:	0f b6 d3             	movzbl %bl,%edx
     9ee:	8b 45 0c             	mov    0xc(%ebp),%eax
     9f1:	01 d0                	add    %edx,%eax
     9f3:	0f b6 10             	movzbl (%eax),%edx
     9f6:	0f b6 f3             	movzbl %bl,%esi
     9f9:	8b 45 08             	mov    0x8(%ebp),%eax
     9fc:	01 f0                	add    %esi,%eax
     9fe:	31 ca                	xor    %ecx,%edx
     a00:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     a02:	89 d8                	mov    %ebx,%eax
     a04:	8d 58 01             	lea    0x1(%eax),%ebx
     a07:	80 fb 0f             	cmp    $0xf,%bl
     a0a:	76 d4                	jbe    9e0 <aes_addRoundKey+0xc>
    }
}
     a0c:	90                   	nop
     a0d:	90                   	nop
     a0e:	5b                   	pop    %ebx
     a0f:	5e                   	pop    %esi
     a10:	5d                   	pop    %ebp
     a11:	c3                   	ret    

00000a12 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     a12:	55                   	push   %ebp
     a13:	89 e5                	mov    %esp,%ebp
     a15:	56                   	push   %esi
     a16:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     a17:	bb 00 00 00 00       	mov    $0x0,%ebx
     a1c:	eb 5b                	jmp    a79 <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     a1e:	0f b6 d3             	movzbl %bl,%edx
     a21:	8b 45 0c             	mov    0xc(%ebp),%eax
     a24:	01 d0                	add    %edx,%eax
     a26:	0f b6 cb             	movzbl %bl,%ecx
     a29:	8b 55 10             	mov    0x10(%ebp),%edx
     a2c:	01 ca                	add    %ecx,%edx
     a2e:	0f b6 00             	movzbl (%eax),%eax
     a31:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     a33:	0f b6 d3             	movzbl %bl,%edx
     a36:	8b 45 08             	mov    0x8(%ebp),%eax
     a39:	01 d0                	add    %edx,%eax
     a3b:	0f b6 08             	movzbl (%eax),%ecx
     a3e:	0f b6 d3             	movzbl %bl,%edx
     a41:	8b 45 0c             	mov    0xc(%ebp),%eax
     a44:	01 d0                	add    %edx,%eax
     a46:	0f b6 10             	movzbl (%eax),%edx
     a49:	0f b6 f3             	movzbl %bl,%esi
     a4c:	8b 45 08             	mov    0x8(%ebp),%eax
     a4f:	01 f0                	add    %esi,%eax
     a51:	31 ca                	xor    %ecx,%edx
     a53:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     a55:	0f b6 c3             	movzbl %bl,%eax
     a58:	83 c0 10             	add    $0x10,%eax
     a5b:	89 c2                	mov    %eax,%edx
     a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     a60:	01 d0                	add    %edx,%eax
     a62:	0f b6 d3             	movzbl %bl,%edx
     a65:	83 c2 10             	add    $0x10,%edx
     a68:	89 d1                	mov    %edx,%ecx
     a6a:	8b 55 10             	mov    0x10(%ebp),%edx
     a6d:	01 ca                	add    %ecx,%edx
     a6f:	0f b6 00             	movzbl (%eax),%eax
     a72:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     a74:	89 d8                	mov    %ebx,%eax
     a76:	8d 58 01             	lea    0x1(%eax),%ebx
     a79:	80 fb 0f             	cmp    $0xf,%bl
     a7c:	76 a0                	jbe    a1e <aes_addRoundKey_cpy+0xc>
    }
}
     a7e:	90                   	nop
     a7f:	90                   	nop
     a80:	5b                   	pop    %ebx
     a81:	5e                   	pop    %esi
     a82:	5d                   	pop    %ebp
     a83:	c3                   	ret    

00000a84 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     a84:	55                   	push   %ebp
     a85:	89 e5                	mov    %esp,%ebp
     a87:	53                   	push   %ebx
     a88:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     a8b:	8b 45 08             	mov    0x8(%ebp),%eax
     a8e:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     a92:	8b 45 08             	mov    0x8(%ebp),%eax
     a95:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     a99:	88 45 fb             	mov    %al,-0x5(%ebp)
     a9c:	8b 45 08             	mov    0x8(%ebp),%eax
     a9f:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     aa3:	88 5d fa             	mov    %bl,-0x6(%ebp)
     aa6:	8b 45 08             	mov    0x8(%ebp),%eax
     aa9:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     aad:	8b 45 08             	mov    0x8(%ebp),%eax
     ab0:	8d 50 01             	lea    0x1(%eax),%edx
     ab3:	8b 45 08             	mov    0x8(%ebp),%eax
     ab6:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     aba:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     abc:	8b 45 08             	mov    0x8(%ebp),%eax
     abf:	8d 50 05             	lea    0x5(%eax),%edx
     ac2:	8b 45 08             	mov    0x8(%ebp),%eax
     ac5:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     ac9:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     acb:	8b 45 08             	mov    0x8(%ebp),%eax
     ace:	8d 50 09             	lea    0x9(%eax),%edx
     ad1:	8b 45 08             	mov    0x8(%ebp),%eax
     ad4:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     ad8:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     ada:	8b 45 08             	mov    0x8(%ebp),%eax
     add:	83 c0 0d             	add    $0xd,%eax
     ae0:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     ae2:	8b 45 08             	mov    0x8(%ebp),%eax
     ae5:	8d 50 03             	lea    0x3(%eax),%edx
     ae8:	8b 45 08             	mov    0x8(%ebp),%eax
     aeb:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     aef:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     af1:	8b 45 08             	mov    0x8(%ebp),%eax
     af4:	8d 50 0f             	lea    0xf(%eax),%edx
     af7:	8b 45 08             	mov    0x8(%ebp),%eax
     afa:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     afe:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     b00:	8b 45 08             	mov    0x8(%ebp),%eax
     b03:	8d 50 0b             	lea    0xb(%eax),%edx
     b06:	8b 45 08             	mov    0x8(%ebp),%eax
     b09:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     b0d:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     b0f:	8b 45 08             	mov    0x8(%ebp),%eax
     b12:	83 c0 07             	add    $0x7,%eax
     b15:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     b19:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     b1b:	8b 45 08             	mov    0x8(%ebp),%eax
     b1e:	8d 50 0a             	lea    0xa(%eax),%edx
     b21:	8b 45 08             	mov    0x8(%ebp),%eax
     b24:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     b28:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     b2a:	8b 45 08             	mov    0x8(%ebp),%eax
     b2d:	83 c0 02             	add    $0x2,%eax
     b30:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     b34:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     b36:	8b 45 08             	mov    0x8(%ebp),%eax
     b39:	8d 50 0e             	lea    0xe(%eax),%edx
     b3c:	8b 45 08             	mov    0x8(%ebp),%eax
     b3f:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     b43:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     b45:	8b 45 08             	mov    0x8(%ebp),%eax
     b48:	83 c0 06             	add    $0x6,%eax
     b4b:	88 18                	mov    %bl,(%eax)
}
     b4d:	90                   	nop
     b4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b51:	c9                   	leave  
     b52:	c3                   	ret    

00000b53 <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     b53:	55                   	push   %ebp
     b54:	89 e5                	mov    %esp,%ebp
     b56:	56                   	push   %esi
     b57:	53                   	push   %ebx
     b58:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     b5b:	bb 00 00 00 00       	mov    $0x0,%ebx
     b60:	e9 42 01 00 00       	jmp    ca7 <aes_mixColumns+0x154>
        a = buf[i];
     b65:	0f b6 d3             	movzbl %bl,%edx
     b68:	8b 45 08             	mov    0x8(%ebp),%eax
     b6b:	01 d0                	add    %edx,%eax
     b6d:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     b70:	0f b6 c3             	movzbl %bl,%eax
     b73:	8d 50 01             	lea    0x1(%eax),%edx
     b76:	8b 45 08             	mov    0x8(%ebp),%eax
     b79:	01 d0                	add    %edx,%eax
     b7b:	0f b6 10             	movzbl (%eax),%edx
     b7e:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     b81:	0f b6 c3             	movzbl %bl,%eax
     b84:	8d 50 02             	lea    0x2(%eax),%edx
     b87:	8b 45 08             	mov    0x8(%ebp),%eax
     b8a:	01 d0                	add    %edx,%eax
     b8c:	0f b6 00             	movzbl (%eax),%eax
     b8f:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     b92:	0f b6 c3             	movzbl %bl,%eax
     b95:	8d 50 03             	lea    0x3(%eax),%edx
     b98:	8b 45 08             	mov    0x8(%ebp),%eax
     b9b:	01 d0                	add    %edx,%eax
     b9d:	0f b6 00             	movzbl (%eax),%eax
     ba0:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     ba3:	89 c8                	mov    %ecx,%eax
     ba5:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     ba9:	31 d0                	xor    %edx,%eax
     bab:	32 45 f6             	xor    -0xa(%ebp),%al
     bae:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     bb2:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     bb4:	88 4d f4             	mov    %cl,-0xc(%ebp)
     bb7:	89 c8                	mov    %ecx,%eax
     bb9:	88 55 f7             	mov    %dl,-0x9(%ebp)
     bbc:	32 45 f7             	xor    -0x9(%ebp),%al
     bbf:	0f b6 c0             	movzbl %al,%eax
     bc2:	50                   	push   %eax
     bc3:	e8 a1 fd ff ff       	call   969 <rj_xtime>
     bc8:	83 c4 04             	add    $0x4,%esp
     bcb:	31 f0                	xor    %esi,%eax
     bcd:	0f b6 c8             	movzbl %al,%ecx
     bd0:	0f b6 d3             	movzbl %bl,%edx
     bd3:	8b 45 08             	mov    0x8(%ebp),%eax
     bd6:	01 d0                	add    %edx,%eax
     bd8:	0f b6 00             	movzbl (%eax),%eax
     bdb:	89 c2                	mov    %eax,%edx
     bdd:	89 c8                	mov    %ecx,%eax
     bdf:	89 d1                	mov    %edx,%ecx
     be1:	31 c1                	xor    %eax,%ecx
     be3:	0f b6 d3             	movzbl %bl,%edx
     be6:	8b 45 08             	mov    0x8(%ebp),%eax
     be9:	01 c2                	add    %eax,%edx
     beb:	89 c8                	mov    %ecx,%eax
     bed:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     bef:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     bf3:	32 55 f6             	xor    -0xa(%ebp),%dl
     bf6:	89 d0                	mov    %edx,%eax
     bf8:	0f b6 c0             	movzbl %al,%eax
     bfb:	50                   	push   %eax
     bfc:	e8 68 fd ff ff       	call   969 <rj_xtime>
     c01:	83 c4 04             	add    $0x4,%esp
     c04:	31 f0                	xor    %esi,%eax
     c06:	0f b6 c8             	movzbl %al,%ecx
     c09:	0f b6 c3             	movzbl %bl,%eax
     c0c:	8d 50 01             	lea    0x1(%eax),%edx
     c0f:	8b 45 08             	mov    0x8(%ebp),%eax
     c12:	01 d0                	add    %edx,%eax
     c14:	0f b6 00             	movzbl (%eax),%eax
     c17:	89 c2                	mov    %eax,%edx
     c19:	89 c8                	mov    %ecx,%eax
     c1b:	31 c2                	xor    %eax,%edx
     c1d:	89 d1                	mov    %edx,%ecx
     c1f:	0f b6 c3             	movzbl %bl,%eax
     c22:	8d 50 01             	lea    0x1(%eax),%edx
     c25:	8b 45 08             	mov    0x8(%ebp),%eax
     c28:	01 c2                	add    %eax,%edx
     c2a:	89 c8                	mov    %ecx,%eax
     c2c:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     c2e:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     c32:	32 45 f5             	xor    -0xb(%ebp),%al
     c35:	0f b6 c0             	movzbl %al,%eax
     c38:	50                   	push   %eax
     c39:	e8 2b fd ff ff       	call   969 <rj_xtime>
     c3e:	83 c4 04             	add    $0x4,%esp
     c41:	31 f0                	xor    %esi,%eax
     c43:	0f b6 d0             	movzbl %al,%edx
     c46:	0f b6 c3             	movzbl %bl,%eax
     c49:	8d 48 02             	lea    0x2(%eax),%ecx
     c4c:	8b 45 08             	mov    0x8(%ebp),%eax
     c4f:	01 c8                	add    %ecx,%eax
     c51:	0f b6 00             	movzbl (%eax),%eax
     c54:	89 c1                	mov    %eax,%ecx
     c56:	89 d0                	mov    %edx,%eax
     c58:	89 ca                	mov    %ecx,%edx
     c5a:	31 c2                	xor    %eax,%edx
     c5c:	0f b6 c3             	movzbl %bl,%eax
     c5f:	8d 48 02             	lea    0x2(%eax),%ecx
     c62:	8b 45 08             	mov    0x8(%ebp),%eax
     c65:	01 c8                	add    %ecx,%eax
     c67:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     c69:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     c6d:	32 45 f4             	xor    -0xc(%ebp),%al
     c70:	0f b6 c0             	movzbl %al,%eax
     c73:	50                   	push   %eax
     c74:	e8 f0 fc ff ff       	call   969 <rj_xtime>
     c79:	83 c4 04             	add    $0x4,%esp
     c7c:	31 f0                	xor    %esi,%eax
     c7e:	0f b6 d0             	movzbl %al,%edx
     c81:	0f b6 c3             	movzbl %bl,%eax
     c84:	8d 48 03             	lea    0x3(%eax),%ecx
     c87:	8b 45 08             	mov    0x8(%ebp),%eax
     c8a:	01 c8                	add    %ecx,%eax
     c8c:	0f b6 00             	movzbl (%eax),%eax
     c8f:	89 c1                	mov    %eax,%ecx
     c91:	89 d0                	mov    %edx,%eax
     c93:	31 c1                	xor    %eax,%ecx
     c95:	89 ca                	mov    %ecx,%edx
     c97:	0f b6 c3             	movzbl %bl,%eax
     c9a:	8d 48 03             	lea    0x3(%eax),%ecx
     c9d:	8b 45 08             	mov    0x8(%ebp),%eax
     ca0:	01 c8                	add    %ecx,%eax
     ca2:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     ca4:	83 c3 04             	add    $0x4,%ebx
     ca7:	80 fb 0f             	cmp    $0xf,%bl
     caa:	0f 86 b5 fe ff ff    	jbe    b65 <aes_mixColumns+0x12>
    }
}
     cb0:	90                   	nop
     cb1:	90                   	nop
     cb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cb5:	5b                   	pop    %ebx
     cb6:	5e                   	pop    %esi
     cb7:	5d                   	pop    %ebp
     cb8:	c3                   	ret    

00000cb9 <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     cb9:	55                   	push   %ebp
     cba:	89 e5                	mov    %esp,%ebp
     cbc:	56                   	push   %esi
     cbd:	53                   	push   %ebx
     cbe:	83 ec 04             	sub    $0x4,%esp
     cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc4:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     cc7:	8b 45 08             	mov    0x8(%ebp),%eax
     cca:	0f b6 10             	movzbl (%eax),%edx
     ccd:	8b 45 08             	mov    0x8(%ebp),%eax
     cd0:	83 c0 1d             	add    $0x1d,%eax
     cd3:	0f b6 00             	movzbl (%eax),%eax
     cd6:	0f b6 c0             	movzbl %al,%eax
     cd9:	0f b6 80 a0 21 00 00 	movzbl 0x21a0(%eax),%eax
     ce0:	32 45 f4             	xor    -0xc(%ebp),%al
     ce3:	31 c2                	xor    %eax,%edx
     ce5:	8b 45 08             	mov    0x8(%ebp),%eax
     ce8:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     cea:	8b 45 08             	mov    0x8(%ebp),%eax
     ced:	83 c0 01             	add    $0x1,%eax
     cf0:	0f b6 08             	movzbl (%eax),%ecx
     cf3:	8b 45 08             	mov    0x8(%ebp),%eax
     cf6:	83 c0 1e             	add    $0x1e,%eax
     cf9:	0f b6 00             	movzbl (%eax),%eax
     cfc:	0f b6 c0             	movzbl %al,%eax
     cff:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     d06:	8b 45 08             	mov    0x8(%ebp),%eax
     d09:	83 c0 01             	add    $0x1,%eax
     d0c:	31 ca                	xor    %ecx,%edx
     d0e:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	83 c0 02             	add    $0x2,%eax
     d16:	0f b6 08             	movzbl (%eax),%ecx
     d19:	8b 45 08             	mov    0x8(%ebp),%eax
     d1c:	83 c0 1f             	add    $0x1f,%eax
     d1f:	0f b6 00             	movzbl (%eax),%eax
     d22:	0f b6 c0             	movzbl %al,%eax
     d25:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     d2c:	8b 45 08             	mov    0x8(%ebp),%eax
     d2f:	83 c0 02             	add    $0x2,%eax
     d32:	31 ca                	xor    %ecx,%edx
     d34:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     d36:	8b 45 08             	mov    0x8(%ebp),%eax
     d39:	83 c0 03             	add    $0x3,%eax
     d3c:	0f b6 08             	movzbl (%eax),%ecx
     d3f:	8b 45 08             	mov    0x8(%ebp),%eax
     d42:	83 c0 1c             	add    $0x1c,%eax
     d45:	0f b6 00             	movzbl (%eax),%eax
     d48:	0f b6 c0             	movzbl %al,%eax
     d4b:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     d52:	8b 45 08             	mov    0x8(%ebp),%eax
     d55:	83 c0 03             	add    $0x3,%eax
     d58:	31 ca                	xor    %ecx,%edx
     d5a:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     d5c:	bb 04 00 00 00       	mov    $0x4,%ebx
     d61:	e9 a9 00 00 00       	jmp    e0f <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     d66:	0f b6 d3             	movzbl %bl,%edx
     d69:	8b 45 08             	mov    0x8(%ebp),%eax
     d6c:	01 d0                	add    %edx,%eax
     d6e:	0f b6 08             	movzbl (%eax),%ecx
     d71:	0f b6 c3             	movzbl %bl,%eax
     d74:	8d 50 fc             	lea    -0x4(%eax),%edx
     d77:	8b 45 08             	mov    0x8(%ebp),%eax
     d7a:	01 d0                	add    %edx,%eax
     d7c:	0f b6 10             	movzbl (%eax),%edx
     d7f:	0f b6 f3             	movzbl %bl,%esi
     d82:	8b 45 08             	mov    0x8(%ebp),%eax
     d85:	01 f0                	add    %esi,%eax
     d87:	31 ca                	xor    %ecx,%edx
     d89:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     d8b:	0f b6 c3             	movzbl %bl,%eax
     d8e:	8d 50 01             	lea    0x1(%eax),%edx
     d91:	8b 45 08             	mov    0x8(%ebp),%eax
     d94:	01 d0                	add    %edx,%eax
     d96:	0f b6 08             	movzbl (%eax),%ecx
     d99:	0f b6 c3             	movzbl %bl,%eax
     d9c:	8d 50 fd             	lea    -0x3(%eax),%edx
     d9f:	8b 45 08             	mov    0x8(%ebp),%eax
     da2:	01 d0                	add    %edx,%eax
     da4:	0f b6 10             	movzbl (%eax),%edx
     da7:	0f b6 c3             	movzbl %bl,%eax
     daa:	8d 70 01             	lea    0x1(%eax),%esi
     dad:	8b 45 08             	mov    0x8(%ebp),%eax
     db0:	01 f0                	add    %esi,%eax
     db2:	31 ca                	xor    %ecx,%edx
     db4:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     db6:	0f b6 c3             	movzbl %bl,%eax
     db9:	8d 50 02             	lea    0x2(%eax),%edx
     dbc:	8b 45 08             	mov    0x8(%ebp),%eax
     dbf:	01 d0                	add    %edx,%eax
     dc1:	0f b6 08             	movzbl (%eax),%ecx
     dc4:	0f b6 c3             	movzbl %bl,%eax
     dc7:	8d 50 fe             	lea    -0x2(%eax),%edx
     dca:	8b 45 08             	mov    0x8(%ebp),%eax
     dcd:	01 d0                	add    %edx,%eax
     dcf:	0f b6 10             	movzbl (%eax),%edx
     dd2:	0f b6 c3             	movzbl %bl,%eax
     dd5:	8d 70 02             	lea    0x2(%eax),%esi
     dd8:	8b 45 08             	mov    0x8(%ebp),%eax
     ddb:	01 f0                	add    %esi,%eax
     ddd:	31 ca                	xor    %ecx,%edx
     ddf:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     de1:	0f b6 c3             	movzbl %bl,%eax
     de4:	8d 50 03             	lea    0x3(%eax),%edx
     de7:	8b 45 08             	mov    0x8(%ebp),%eax
     dea:	01 d0                	add    %edx,%eax
     dec:	0f b6 08             	movzbl (%eax),%ecx
     def:	0f b6 c3             	movzbl %bl,%eax
     df2:	8d 50 ff             	lea    -0x1(%eax),%edx
     df5:	8b 45 08             	mov    0x8(%ebp),%eax
     df8:	01 d0                	add    %edx,%eax
     dfa:	0f b6 10             	movzbl (%eax),%edx
     dfd:	0f b6 c3             	movzbl %bl,%eax
     e00:	8d 70 03             	lea    0x3(%eax),%esi
     e03:	8b 45 08             	mov    0x8(%ebp),%eax
     e06:	01 f0                	add    %esi,%eax
     e08:	31 ca                	xor    %ecx,%edx
     e0a:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     e0c:	83 c3 04             	add    $0x4,%ebx
     e0f:	80 fb 0f             	cmp    $0xf,%bl
     e12:	0f 86 4e ff ff ff    	jbe    d66 <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     e18:	8b 45 08             	mov    0x8(%ebp),%eax
     e1b:	83 c0 10             	add    $0x10,%eax
     e1e:	0f b6 08             	movzbl (%eax),%ecx
     e21:	8b 45 08             	mov    0x8(%ebp),%eax
     e24:	83 c0 0c             	add    $0xc,%eax
     e27:	0f b6 00             	movzbl (%eax),%eax
     e2a:	0f b6 c0             	movzbl %al,%eax
     e2d:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     e34:	8b 45 08             	mov    0x8(%ebp),%eax
     e37:	83 c0 10             	add    $0x10,%eax
     e3a:	31 ca                	xor    %ecx,%edx
     e3c:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     e3e:	8b 45 08             	mov    0x8(%ebp),%eax
     e41:	83 c0 11             	add    $0x11,%eax
     e44:	0f b6 08             	movzbl (%eax),%ecx
     e47:	8b 45 08             	mov    0x8(%ebp),%eax
     e4a:	83 c0 0d             	add    $0xd,%eax
     e4d:	0f b6 00             	movzbl (%eax),%eax
     e50:	0f b6 c0             	movzbl %al,%eax
     e53:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     e5a:	8b 45 08             	mov    0x8(%ebp),%eax
     e5d:	83 c0 11             	add    $0x11,%eax
     e60:	31 ca                	xor    %ecx,%edx
     e62:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     e64:	8b 45 08             	mov    0x8(%ebp),%eax
     e67:	83 c0 12             	add    $0x12,%eax
     e6a:	0f b6 08             	movzbl (%eax),%ecx
     e6d:	8b 45 08             	mov    0x8(%ebp),%eax
     e70:	83 c0 0e             	add    $0xe,%eax
     e73:	0f b6 00             	movzbl (%eax),%eax
     e76:	0f b6 c0             	movzbl %al,%eax
     e79:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     e80:	8b 45 08             	mov    0x8(%ebp),%eax
     e83:	83 c0 12             	add    $0x12,%eax
     e86:	31 ca                	xor    %ecx,%edx
     e88:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
     e8a:	8b 45 08             	mov    0x8(%ebp),%eax
     e8d:	83 c0 13             	add    $0x13,%eax
     e90:	0f b6 08             	movzbl (%eax),%ecx
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	83 c0 0f             	add    $0xf,%eax
     e99:	0f b6 00             	movzbl (%eax),%eax
     e9c:	0f b6 c0             	movzbl %al,%eax
     e9f:	0f b6 90 a0 21 00 00 	movzbl 0x21a0(%eax),%edx
     ea6:	8b 45 08             	mov    0x8(%ebp),%eax
     ea9:	83 c0 13             	add    $0x13,%eax
     eac:	31 ca                	xor    %ecx,%edx
     eae:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
     eb0:	bb 14 00 00 00       	mov    $0x14,%ebx
     eb5:	e9 a9 00 00 00       	jmp    f63 <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
     eba:	0f b6 d3             	movzbl %bl,%edx
     ebd:	8b 45 08             	mov    0x8(%ebp),%eax
     ec0:	01 d0                	add    %edx,%eax
     ec2:	0f b6 08             	movzbl (%eax),%ecx
     ec5:	0f b6 c3             	movzbl %bl,%eax
     ec8:	8d 50 fc             	lea    -0x4(%eax),%edx
     ecb:	8b 45 08             	mov    0x8(%ebp),%eax
     ece:	01 d0                	add    %edx,%eax
     ed0:	0f b6 10             	movzbl (%eax),%edx
     ed3:	0f b6 f3             	movzbl %bl,%esi
     ed6:	8b 45 08             	mov    0x8(%ebp),%eax
     ed9:	01 f0                	add    %esi,%eax
     edb:	31 ca                	xor    %ecx,%edx
     edd:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     edf:	0f b6 c3             	movzbl %bl,%eax
     ee2:	8d 50 01             	lea    0x1(%eax),%edx
     ee5:	8b 45 08             	mov    0x8(%ebp),%eax
     ee8:	01 d0                	add    %edx,%eax
     eea:	0f b6 08             	movzbl (%eax),%ecx
     eed:	0f b6 c3             	movzbl %bl,%eax
     ef0:	8d 50 fd             	lea    -0x3(%eax),%edx
     ef3:	8b 45 08             	mov    0x8(%ebp),%eax
     ef6:	01 d0                	add    %edx,%eax
     ef8:	0f b6 10             	movzbl (%eax),%edx
     efb:	0f b6 c3             	movzbl %bl,%eax
     efe:	8d 70 01             	lea    0x1(%eax),%esi
     f01:	8b 45 08             	mov    0x8(%ebp),%eax
     f04:	01 f0                	add    %esi,%eax
     f06:	31 ca                	xor    %ecx,%edx
     f08:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     f0a:	0f b6 c3             	movzbl %bl,%eax
     f0d:	8d 50 02             	lea    0x2(%eax),%edx
     f10:	8b 45 08             	mov    0x8(%ebp),%eax
     f13:	01 d0                	add    %edx,%eax
     f15:	0f b6 08             	movzbl (%eax),%ecx
     f18:	0f b6 c3             	movzbl %bl,%eax
     f1b:	8d 50 fe             	lea    -0x2(%eax),%edx
     f1e:	8b 45 08             	mov    0x8(%ebp),%eax
     f21:	01 d0                	add    %edx,%eax
     f23:	0f b6 10             	movzbl (%eax),%edx
     f26:	0f b6 c3             	movzbl %bl,%eax
     f29:	8d 70 02             	lea    0x2(%eax),%esi
     f2c:	8b 45 08             	mov    0x8(%ebp),%eax
     f2f:	01 f0                	add    %esi,%eax
     f31:	31 ca                	xor    %ecx,%edx
     f33:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     f35:	0f b6 c3             	movzbl %bl,%eax
     f38:	8d 50 03             	lea    0x3(%eax),%edx
     f3b:	8b 45 08             	mov    0x8(%ebp),%eax
     f3e:	01 d0                	add    %edx,%eax
     f40:	0f b6 08             	movzbl (%eax),%ecx
     f43:	0f b6 c3             	movzbl %bl,%eax
     f46:	8d 50 ff             	lea    -0x1(%eax),%edx
     f49:	8b 45 08             	mov    0x8(%ebp),%eax
     f4c:	01 d0                	add    %edx,%eax
     f4e:	0f b6 10             	movzbl (%eax),%edx
     f51:	0f b6 c3             	movzbl %bl,%eax
     f54:	8d 70 03             	lea    0x3(%eax),%esi
     f57:	8b 45 08             	mov    0x8(%ebp),%eax
     f5a:	01 f0                	add    %esi,%eax
     f5c:	31 ca                	xor    %ecx,%edx
     f5e:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
     f60:	83 c3 04             	add    $0x4,%ebx
     f63:	80 fb 1f             	cmp    $0x1f,%bl
     f66:	0f 86 4e ff ff ff    	jbe    eba <aes_expandEncKey+0x201>
    }
}
     f6c:	90                   	nop
     f6d:	90                   	nop
     f6e:	83 c4 04             	add    $0x4,%esp
     f71:	5b                   	pop    %ebx
     f72:	5e                   	pop    %esi
     f73:	5d                   	pop    %ebp
     f74:	c3                   	ret    

00000f75 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
     f75:	55                   	push   %ebp
     f76:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
     f78:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f7c:	74 4d                	je     fcb <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
     f7e:	8b 45 08             	mov    0x8(%ebp),%eax
     f81:	83 c0 03             	add    $0x3,%eax
     f84:	0f b6 10             	movzbl (%eax),%edx
     f87:	83 c2 01             	add    $0x1,%edx
     f8a:	88 10                	mov    %dl,(%eax)
     f8c:	0f b6 00             	movzbl (%eax),%eax
     f8f:	84 c0                	test   %al,%al
     f91:	75 38                	jne    fcb <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
     f93:	8b 45 08             	mov    0x8(%ebp),%eax
     f96:	83 c0 02             	add    $0x2,%eax
     f99:	0f b6 10             	movzbl (%eax),%edx
     f9c:	83 c2 01             	add    $0x1,%edx
     f9f:	88 10                	mov    %dl,(%eax)
     fa1:	0f b6 00             	movzbl (%eax),%eax
     fa4:	84 c0                	test   %al,%al
     fa6:	75 23                	jne    fcb <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
     fa8:	8b 45 08             	mov    0x8(%ebp),%eax
     fab:	83 c0 01             	add    $0x1,%eax
     fae:	0f b6 10             	movzbl (%eax),%edx
     fb1:	83 c2 01             	add    $0x1,%edx
     fb4:	88 10                	mov    %dl,(%eax)
     fb6:	0f b6 00             	movzbl (%eax),%eax
     fb9:	84 c0                	test   %al,%al
     fbb:	75 0e                	jne    fcb <ctr_inc_ctr+0x56>
                    val[0]++;
     fbd:	8b 45 08             	mov    0x8(%ebp),%eax
     fc0:	0f b6 00             	movzbl (%eax),%eax
     fc3:	8d 50 01             	lea    0x1(%eax),%edx
     fc6:	8b 45 08             	mov    0x8(%ebp),%eax
     fc9:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
     fcb:	90                   	nop
     fcc:	5d                   	pop    %ebp
     fcd:	c3                   	ret    

00000fce <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
     fce:	55                   	push   %ebp
     fcf:	89 e5                	mov    %esp,%ebp
     fd1:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
     fd4:	8b 45 08             	mov    0x8(%ebp),%eax
     fd7:	83 c0 40             	add    $0x40,%eax
     fda:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
     fdd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     fe1:	74 56                	je     1039 <ctr_clock_keystream+0x6b>
     fe3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fe7:	74 50                	je     1039 <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
     fe9:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
     fed:	eb 21                	jmp    1010 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
     fef:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     ff3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ff6:	01 d0                	add    %edx,%eax
     ff8:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
     ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
     fff:	01 ca                	add    %ecx,%edx
    1001:	0f b6 00             	movzbl (%eax),%eax
    1004:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1006:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
    100a:	83 c0 01             	add    $0x1,%eax
    100d:	88 45 f7             	mov    %al,-0x9(%ebp)
    1010:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
    1014:	76 d9                	jbe    fef <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
    1016:	83 ec 08             	sub    $0x8,%esp
    1019:	ff 75 0c             	push   0xc(%ebp)
    101c:	ff 75 08             	push   0x8(%ebp)
    101f:	e8 16 01 00 00       	call   113a <aes256_encrypt_ecb>
    1024:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
    1027:	8b 45 08             	mov    0x8(%ebp),%eax
    102a:	83 c0 4c             	add    $0x4c,%eax
    102d:	83 ec 0c             	sub    $0xc,%esp
    1030:	50                   	push   %eax
    1031:	e8 3f ff ff ff       	call   f75 <ctr_inc_ctr>
    1036:	83 c4 10             	add    $0x10,%esp
    }
}
    1039:	90                   	nop
    103a:	c9                   	leave  
    103b:	c3                   	ret    

0000103c <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
    103c:	55                   	push   %ebp
    103d:	89 e5                	mov    %esp,%ebp
    103f:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
    1042:	8b 45 0c             	mov    0xc(%ebp),%eax
    1045:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
    1048:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
    104f:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
    1056:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
    105d:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
    1064:	83 ec 08             	sub    $0x8,%esp
    1067:	ff 75 08             	push   0x8(%ebp)
    106a:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    106d:	50                   	push   %eax
    106e:	e8 2e 00 00 00       	call   10a1 <aes256_init>
    1073:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
    1076:	83 ec 08             	sub    $0x8,%esp
    1079:	8d 45 94             	lea    -0x6c(%ebp),%eax
    107c:	50                   	push   %eax
    107d:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1080:	50                   	push   %eax
    1081:	e8 8d 01 00 00       	call   1213 <aes256_setCtrBlk>
    1086:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
    1089:	83 ec 04             	sub    $0x4,%esp
    108c:	ff 75 10             	push   0x10(%ebp)
    108f:	ff 75 f4             	push   -0xc(%ebp)
    1092:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1095:	50                   	push   %eax
    1096:	e8 c9 01 00 00       	call   1264 <aes256_encrypt_ctr>
    109b:	83 c4 10             	add    $0x10,%esp
}
    109e:	90                   	nop
    109f:	c9                   	leave  
    10a0:	c3                   	ret    

000010a1 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
    10a1:	55                   	push   %ebp
    10a2:	89 e5                	mov    %esp,%ebp
    10a4:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    10a5:	bb 00 00 00 00       	mov    $0x0,%ebx
    10aa:	eb 1a                	jmp    10c6 <aes256_init+0x25>
        ctx->enckey[i] = key[i];
    10ac:	0f b6 d3             	movzbl %bl,%edx
    10af:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b2:	01 c2                	add    %eax,%edx
    10b4:	0f b6 c3             	movzbl %bl,%eax
    10b7:	0f b6 0a             	movzbl (%edx),%ecx
    10ba:	8b 55 08             	mov    0x8(%ebp),%edx
    10bd:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    10c1:	89 d8                	mov    %ebx,%eax
    10c3:	8d 58 01             	lea    0x1(%eax),%ebx
    10c6:	80 fb 1f             	cmp    $0x1f,%bl
    10c9:	76 e1                	jbe    10ac <aes256_init+0xb>
    }
}
    10cb:	90                   	nop
    10cc:	90                   	nop
    10cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10d0:	c9                   	leave  
    10d1:	c3                   	ret    

000010d2 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    10d2:	55                   	push   %ebp
    10d3:	89 e5                	mov    %esp,%ebp
    10d5:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    10d6:	bb 00 00 00 00       	mov    $0x0,%ebx
    10db:	eb 51                	jmp    112e <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    10dd:	0f b6 c3             	movzbl %bl,%eax
    10e0:	8b 55 08             	mov    0x8(%ebp),%edx
    10e3:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    10e8:	0f b6 d3             	movzbl %bl,%edx
    10eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10ee:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    10f9:	0f b6 c3             	movzbl %bl,%eax
    10fc:	83 e0 03             	and    $0x3,%eax
    10ff:	89 c2                	mov    %eax,%edx
    1101:	8b 45 08             	mov    0x8(%ebp),%eax
    1104:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    1109:	0f b6 c3             	movzbl %bl,%eax
    110c:	83 e0 07             	and    $0x7,%eax
    110f:	89 c2                	mov    %eax,%edx
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    1119:	0f b6 c3             	movzbl %bl,%eax
    111c:	83 e0 03             	and    $0x3,%eax
    111f:	89 c2                	mov    %eax,%edx
    1121:	8b 45 08             	mov    0x8(%ebp),%eax
    1124:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1129:	89 d8                	mov    %ebx,%eax
    112b:	8d 58 01             	lea    0x1(%eax),%ebx
    112e:	80 fb 1f             	cmp    $0x1f,%bl
    1131:	76 aa                	jbe    10dd <aes256_done+0xb>
    }
}
    1133:	90                   	nop
    1134:	90                   	nop
    1135:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1138:	c9                   	leave  
    1139:	c3                   	ret    

0000113a <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    113a:	55                   	push   %ebp
    113b:	89 e5                	mov    %esp,%ebp
    113d:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    1140:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    1144:	8b 45 08             	mov    0x8(%ebp),%eax
    1147:	8b 55 08             	mov    0x8(%ebp),%edx
    114a:	83 c2 20             	add    $0x20,%edx
    114d:	50                   	push   %eax
    114e:	52                   	push   %edx
    114f:	ff 75 0c             	push   0xc(%ebp)
    1152:	e8 bb f8 ff ff       	call   a12 <aes_addRoundKey_cpy>
    1157:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    115a:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    115e:	eb 74                	jmp    11d4 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    1160:	ff 75 0c             	push   0xc(%ebp)
    1163:	e8 31 f8 ff ff       	call   999 <aes_subBytes>
    1168:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    116b:	ff 75 0c             	push   0xc(%ebp)
    116e:	e8 11 f9 ff ff       	call   a84 <aes_shiftRows>
    1173:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    1176:	ff 75 0c             	push   0xc(%ebp)
    1179:	e8 d5 f9 ff ff       	call   b53 <aes_mixColumns>
    117e:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    1181:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1185:	83 e0 01             	and    $0x1,%eax
    1188:	85 c0                	test   %eax,%eax
    118a:	74 14                	je     11a0 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    118c:	8b 45 08             	mov    0x8(%ebp),%eax
    118f:	83 c0 10             	add    $0x10,%eax
    1192:	50                   	push   %eax
    1193:	ff 75 0c             	push   0xc(%ebp)
    1196:	e8 39 f8 ff ff       	call   9d4 <aes_addRoundKey>
    119b:	83 c4 08             	add    $0x8,%esp
    119e:	eb 30                	jmp    11d0 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    11a0:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    11a4:	8b 45 08             	mov    0x8(%ebp),%eax
    11a7:	52                   	push   %edx
    11a8:	50                   	push   %eax
    11a9:	e8 0b fb ff ff       	call   cb9 <aes_expandEncKey>
    11ae:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    11b1:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    11b5:	50                   	push   %eax
    11b6:	e8 ae f7 ff ff       	call   969 <rj_xtime>
    11bb:	83 c4 04             	add    $0x4,%esp
    11be:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    11c1:	8b 45 08             	mov    0x8(%ebp),%eax
    11c4:	50                   	push   %eax
    11c5:	ff 75 0c             	push   0xc(%ebp)
    11c8:	e8 07 f8 ff ff       	call   9d4 <aes_addRoundKey>
    11cd:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    11d0:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    11d4:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    11d8:	76 86                	jbe    1160 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    11da:	ff 75 0c             	push   0xc(%ebp)
    11dd:	e8 b7 f7 ff ff       	call   999 <aes_subBytes>
    11e2:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    11e5:	ff 75 0c             	push   0xc(%ebp)
    11e8:	e8 97 f8 ff ff       	call   a84 <aes_shiftRows>
    11ed:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    11f0:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
    11f7:	52                   	push   %edx
    11f8:	50                   	push   %eax
    11f9:	e8 bb fa ff ff       	call   cb9 <aes_expandEncKey>
    11fe:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    1201:	8b 45 08             	mov    0x8(%ebp),%eax
    1204:	50                   	push   %eax
    1205:	ff 75 0c             	push   0xc(%ebp)
    1208:	e8 c7 f7 ff ff       	call   9d4 <aes_addRoundKey>
    120d:	83 c4 08             	add    $0x8,%esp
}
    1210:	90                   	nop
    1211:	c9                   	leave  
    1212:	c3                   	ret    

00001213 <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    1213:	55                   	push   %ebp
    1214:	89 e5                	mov    %esp,%ebp
    1216:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	83 c0 40             	add    $0x40,%eax
    121f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    1222:	8b 45 0c             	mov    0xc(%ebp),%eax
    1225:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    1228:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    122c:	74 33                	je     1261 <aes256_setCtrBlk+0x4e>
    122e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1232:	74 2d                	je     1261 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1234:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    1238:	eb 21                	jmp    125b <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    123a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    123e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1241:	01 d0                	add    %edx,%eax
    1243:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    1247:	8b 55 f8             	mov    -0x8(%ebp),%edx
    124a:	01 ca                	add    %ecx,%edx
    124c:	0f b6 00             	movzbl (%eax),%eax
    124f:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1251:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1255:	83 c0 01             	add    $0x1,%eax
    1258:	88 45 ff             	mov    %al,-0x1(%ebp)
    125b:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    125f:	76 d9                	jbe    123a <aes256_setCtrBlk+0x27>
        }
    }
}
    1261:	90                   	nop
    1262:	c9                   	leave  
    1263:	c3                   	ret    

00001264 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    1264:	55                   	push   %ebp
    1265:	89 e5                	mov    %esp,%ebp
    1267:	53                   	push   %ebx
    1268:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    126b:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    126f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1276:	eb 49                	jmp    12c1 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    1278:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    127c:	75 16                	jne    1294 <aes256_encrypt_ctr+0x30>
            j = 0;
    127e:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    1282:	83 ec 08             	sub    $0x8,%esp
    1285:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1288:	50                   	push   %eax
    1289:	ff 75 08             	push   0x8(%ebp)
    128c:	e8 3d fd ff ff       	call   fce <ctr_clock_keystream>
    1291:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    1294:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    1298:	8d 50 01             	lea    0x1(%eax),%edx
    129b:	88 55 f3             	mov    %dl,-0xd(%ebp)
    129e:	0f b6 c0             	movzbl %al,%eax
    12a1:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    12a6:	8b 55 0c             	mov    0xc(%ebp),%edx
    12a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ac:	01 d0                	add    %edx,%eax
    12ae:	0f b6 10             	movzbl (%eax),%edx
    12b1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    12b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12b7:	01 d8                	add    %ebx,%eax
    12b9:	31 ca                	xor    %ecx,%edx
    12bb:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    12bd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12c4:	3b 45 10             	cmp    0x10(%ebp),%eax
    12c7:	72 af                	jb     1278 <aes256_encrypt_ctr+0x14>
    }
}
    12c9:	90                   	nop
    12ca:	90                   	nop
    12cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12ce:	c9                   	leave  
    12cf:	c3                   	ret    

000012d0 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d6:	83 e0 1f             	and    $0x1f,%eax
    12d9:	8b 55 08             	mov    0x8(%ebp),%edx
    12dc:	89 c1                	mov    %eax,%ecx
    12de:	d3 ea                	shr    %cl,%edx
    12e0:	89 d0                	mov    %edx,%eax
    12e2:	5d                   	pop    %ebp
    12e3:	c3                   	ret    

000012e4 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    12e4:	55                   	push   %ebp
    12e5:	89 e5                	mov    %esp,%ebp
    12e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ea:	83 e0 1f             	and    $0x1f,%eax
    12ed:	8b 55 08             	mov    0x8(%ebp),%edx
    12f0:	89 c1                	mov    %eax,%ecx
    12f2:	d3 e2                	shl    %cl,%edx
    12f4:	89 d0                	mov    %edx,%eax
    12f6:	5d                   	pop    %ebp
    12f7:	c3                   	ret    

000012f8 <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    12f8:	55                   	push   %ebp
    12f9:	89 e5                	mov    %esp,%ebp
    12fb:	53                   	push   %ebx
    12fc:	83 ec 04             	sub    $0x4,%esp
    12ff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1302:	88 45 f8             	mov    %al,-0x8(%ebp)
    1305:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    1309:	8b 55 08             	mov    0x8(%ebp),%edx
    130c:	89 d3                	mov    %edx,%ebx
    130e:	89 c1                	mov    %eax,%ecx
    1310:	d3 eb                	shr    %cl,%ebx
    1312:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    1316:	b8 20 00 00 00       	mov    $0x20,%eax
    131b:	29 d0                	sub    %edx,%eax
    131d:	50                   	push   %eax
    131e:	ff 75 08             	push   0x8(%ebp)
    1321:	e8 be ff ff ff       	call   12e4 <_shw>
    1326:	83 c4 08             	add    $0x8,%esp
    1329:	09 d8                	or     %ebx,%eax
    132b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    132e:	c9                   	leave  
    132f:	c3                   	ret    

00001330 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    1330:	55                   	push   %ebp
    1331:	89 e5                	mov    %esp,%ebp
    1333:	8b 45 08             	mov    0x8(%ebp),%eax
    1336:	23 45 0c             	and    0xc(%ebp),%eax
    1339:	89 c2                	mov    %eax,%edx
    133b:	8b 45 08             	mov    0x8(%ebp),%eax
    133e:	f7 d0                	not    %eax
    1340:	23 45 10             	and    0x10(%ebp),%eax
    1343:	31 d0                	xor    %edx,%eax
    1345:	5d                   	pop    %ebp
    1346:	c3                   	ret    

00001347 <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    1347:	55                   	push   %ebp
    1348:	89 e5                	mov    %esp,%ebp
    134a:	8b 45 0c             	mov    0xc(%ebp),%eax
    134d:	33 45 10             	xor    0x10(%ebp),%eax
    1350:	23 45 08             	and    0x8(%ebp),%eax
    1353:	89 c2                	mov    %eax,%edx
    1355:	8b 45 0c             	mov    0xc(%ebp),%eax
    1358:	23 45 10             	and    0x10(%ebp),%eax
    135b:	31 d0                	xor    %edx,%eax
    135d:	5d                   	pop    %ebp
    135e:	c3                   	ret    

0000135f <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    135f:	55                   	push   %ebp
    1360:	89 e5                	mov    %esp,%ebp
    1362:	53                   	push   %ebx
    1363:	6a 02                	push   $0x2
    1365:	ff 75 08             	push   0x8(%ebp)
    1368:	e8 8b ff ff ff       	call   12f8 <_r>
    136d:	83 c4 08             	add    $0x8,%esp
    1370:	89 c3                	mov    %eax,%ebx
    1372:	6a 0d                	push   $0xd
    1374:	ff 75 08             	push   0x8(%ebp)
    1377:	e8 7c ff ff ff       	call   12f8 <_r>
    137c:	83 c4 08             	add    $0x8,%esp
    137f:	31 c3                	xor    %eax,%ebx
    1381:	6a 16                	push   $0x16
    1383:	ff 75 08             	push   0x8(%ebp)
    1386:	e8 6d ff ff ff       	call   12f8 <_r>
    138b:	83 c4 08             	add    $0x8,%esp
    138e:	31 d8                	xor    %ebx,%eax
    1390:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1393:	c9                   	leave  
    1394:	c3                   	ret    

00001395 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    1395:	55                   	push   %ebp
    1396:	89 e5                	mov    %esp,%ebp
    1398:	53                   	push   %ebx
    1399:	6a 06                	push   $0x6
    139b:	ff 75 08             	push   0x8(%ebp)
    139e:	e8 55 ff ff ff       	call   12f8 <_r>
    13a3:	83 c4 08             	add    $0x8,%esp
    13a6:	89 c3                	mov    %eax,%ebx
    13a8:	6a 0b                	push   $0xb
    13aa:	ff 75 08             	push   0x8(%ebp)
    13ad:	e8 46 ff ff ff       	call   12f8 <_r>
    13b2:	83 c4 08             	add    $0x8,%esp
    13b5:	31 c3                	xor    %eax,%ebx
    13b7:	6a 19                	push   $0x19
    13b9:	ff 75 08             	push   0x8(%ebp)
    13bc:	e8 37 ff ff ff       	call   12f8 <_r>
    13c1:	83 c4 08             	add    $0x8,%esp
    13c4:	31 d8                	xor    %ebx,%eax
    13c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13c9:	c9                   	leave  
    13ca:	c3                   	ret    

000013cb <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    13cb:	55                   	push   %ebp
    13cc:	89 e5                	mov    %esp,%ebp
    13ce:	53                   	push   %ebx
    13cf:	6a 07                	push   $0x7
    13d1:	ff 75 08             	push   0x8(%ebp)
    13d4:	e8 1f ff ff ff       	call   12f8 <_r>
    13d9:	83 c4 08             	add    $0x8,%esp
    13dc:	89 c3                	mov    %eax,%ebx
    13de:	6a 12                	push   $0x12
    13e0:	ff 75 08             	push   0x8(%ebp)
    13e3:	e8 10 ff ff ff       	call   12f8 <_r>
    13e8:	83 c4 08             	add    $0x8,%esp
    13eb:	89 da                	mov    %ebx,%edx
    13ed:	31 c2                	xor    %eax,%edx
    13ef:	8b 45 08             	mov    0x8(%ebp),%eax
    13f2:	c1 e8 03             	shr    $0x3,%eax
    13f5:	31 d0                	xor    %edx,%eax
    13f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13fa:	c9                   	leave  
    13fb:	c3                   	ret    

000013fc <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    13fc:	55                   	push   %ebp
    13fd:	89 e5                	mov    %esp,%ebp
    13ff:	53                   	push   %ebx
    1400:	6a 11                	push   $0x11
    1402:	ff 75 08             	push   0x8(%ebp)
    1405:	e8 ee fe ff ff       	call   12f8 <_r>
    140a:	83 c4 08             	add    $0x8,%esp
    140d:	89 c3                	mov    %eax,%ebx
    140f:	6a 13                	push   $0x13
    1411:	ff 75 08             	push   0x8(%ebp)
    1414:	e8 df fe ff ff       	call   12f8 <_r>
    1419:	83 c4 08             	add    $0x8,%esp
    141c:	89 da                	mov    %ebx,%edx
    141e:	31 c2                	xor    %eax,%edx
    1420:	8b 45 08             	mov    0x8(%ebp),%eax
    1423:	c1 e8 0a             	shr    $0xa,%eax
    1426:	31 d0                	xor    %edx,%eax
    1428:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    142b:	c9                   	leave  
    142c:	c3                   	ret    

0000142d <_word>:

FN_ uint _word(uchar* c) {
    142d:	55                   	push   %ebp
    142e:	89 e5                	mov    %esp,%ebp
    1430:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    1431:	8b 45 08             	mov    0x8(%ebp),%eax
    1434:	0f b6 00             	movzbl (%eax),%eax
    1437:	0f b6 c0             	movzbl %al,%eax
    143a:	6a 18                	push   $0x18
    143c:	50                   	push   %eax
    143d:	e8 a2 fe ff ff       	call   12e4 <_shw>
    1442:	83 c4 08             	add    $0x8,%esp
    1445:	89 c3                	mov    %eax,%ebx
    1447:	8b 45 08             	mov    0x8(%ebp),%eax
    144a:	83 c0 01             	add    $0x1,%eax
    144d:	0f b6 00             	movzbl (%eax),%eax
    1450:	0f b6 c0             	movzbl %al,%eax
    1453:	6a 10                	push   $0x10
    1455:	50                   	push   %eax
    1456:	e8 89 fe ff ff       	call   12e4 <_shw>
    145b:	83 c4 08             	add    $0x8,%esp
    145e:	09 c3                	or     %eax,%ebx
    1460:	8b 45 08             	mov    0x8(%ebp),%eax
    1463:	83 c0 02             	add    $0x2,%eax
    1466:	0f b6 00             	movzbl (%eax),%eax
    1469:	0f b6 c0             	movzbl %al,%eax
    146c:	6a 08                	push   $0x8
    146e:	50                   	push   %eax
    146f:	e8 70 fe ff ff       	call   12e4 <_shw>
    1474:	83 c4 08             	add    $0x8,%esp
    1477:	89 da                	mov    %ebx,%edx
    1479:	09 c2                	or     %eax,%edx
    147b:	8b 45 08             	mov    0x8(%ebp),%eax
    147e:	83 c0 03             	add    $0x3,%eax
    1481:	0f b6 00             	movzbl (%eax),%eax
    1484:	0f b6 c0             	movzbl %al,%eax
    1487:	09 d0                	or     %edx,%eax
}
    1489:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    148c:	c9                   	leave  
    148d:	c3                   	ret    

0000148e <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    148e:	55                   	push   %ebp
    148f:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
    1494:	8b 40 60             	mov    0x60(%eax),%eax
    1497:	8b 55 0c             	mov    0xc(%ebp),%edx
    149a:	f7 d2                	not    %edx
    149c:	39 d0                	cmp    %edx,%eax
    149e:	76 0f                	jbe    14af <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    14a0:	8b 45 08             	mov    0x8(%ebp),%eax
    14a3:	8b 40 64             	mov    0x64(%eax),%eax
    14a6:	8d 50 01             	lea    0x1(%eax),%edx
    14a9:	8b 45 08             	mov    0x8(%ebp),%eax
    14ac:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    14af:	8b 45 08             	mov    0x8(%ebp),%eax
    14b2:	8b 50 60             	mov    0x60(%eax),%edx
    14b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    14b8:	01 c2                	add    %eax,%edx
    14ba:	8b 45 08             	mov    0x8(%ebp),%eax
    14bd:	89 50 60             	mov    %edx,0x60(%eax)
}
    14c0:	90                   	nop
    14c1:	5d                   	pop    %ebp
    14c2:	c3                   	ret    

000014c3 <_hash>:

static void _hash(sha256_context* ctx) {
    14c3:	55                   	push   %ebp
    14c4:	89 e5                	mov    %esp,%ebp
    14c6:	57                   	push   %edi
    14c7:	56                   	push   %esi
    14c8:	53                   	push   %ebx
    14c9:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    14cc:	8b 45 08             	mov    0x8(%ebp),%eax
    14cf:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    14d2:	8b 45 08             	mov    0x8(%ebp),%eax
    14d5:	8b 40 44             	mov    0x44(%eax),%eax
    14d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    14db:	8b 45 08             	mov    0x8(%ebp),%eax
    14de:	8b 40 48             	mov    0x48(%eax),%eax
    14e1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    14e4:	8b 45 08             	mov    0x8(%ebp),%eax
    14e7:	8b 40 4c             	mov    0x4c(%eax),%eax
    14ea:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    14ed:	8b 45 08             	mov    0x8(%ebp),%eax
    14f0:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    14f3:	8b 45 08             	mov    0x8(%ebp),%eax
    14f6:	8b 40 54             	mov    0x54(%eax),%eax
    14f9:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    14fc:	8b 45 08             	mov    0x8(%ebp),%eax
    14ff:	8b 40 58             	mov    0x58(%eax),%eax
    1502:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    1505:	8b 45 08             	mov    0x8(%ebp),%eax
    1508:	8b 40 5c             	mov    0x5c(%eax),%eax
    150b:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    150e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1515:	e9 27 01 00 00       	jmp    1641 <_hash+0x17e>
        if (i < 16) {
    151a:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    151e:	77 2d                	ja     154d <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    1520:	6a 02                	push   $0x2
    1522:	ff 75 f0             	push   -0x10(%ebp)
    1525:	e8 ba fd ff ff       	call   12e4 <_shw>
    152a:	83 c4 08             	add    $0x8,%esp
    152d:	89 c2                	mov    %eax,%edx
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	01 d0                	add    %edx,%eax
    1534:	50                   	push   %eax
    1535:	e8 f3 fe ff ff       	call   142d <_word>
    153a:	83 c4 04             	add    $0x4,%esp
    153d:	89 c1                	mov    %eax,%ecx
    153f:	8b 55 08             	mov    0x8(%ebp),%edx
    1542:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1545:	83 c0 1c             	add    $0x1c,%eax
    1548:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    154b:	eb 64                	jmp    15b1 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    154d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1550:	83 e8 02             	sub    $0x2,%eax
    1553:	8b 55 08             	mov    0x8(%ebp),%edx
    1556:	83 c0 1c             	add    $0x1c,%eax
    1559:	8b 04 82             	mov    (%edx,%eax,4),%eax
    155c:	50                   	push   %eax
    155d:	e8 9a fe ff ff       	call   13fc <_G1>
    1562:	83 c4 04             	add    $0x4,%esp
    1565:	89 c1                	mov    %eax,%ecx
    1567:	8b 45 f0             	mov    -0x10(%ebp),%eax
    156a:	83 e8 07             	sub    $0x7,%eax
    156d:	8b 55 08             	mov    0x8(%ebp),%edx
    1570:	83 c0 1c             	add    $0x1c,%eax
    1573:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1576:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    1579:	8b 45 f0             	mov    -0x10(%ebp),%eax
    157c:	83 e8 0f             	sub    $0xf,%eax
    157f:	8b 55 08             	mov    0x8(%ebp),%edx
    1582:	83 c0 1c             	add    $0x1c,%eax
    1585:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1588:	50                   	push   %eax
    1589:	e8 3d fe ff ff       	call   13cb <_G0>
    158e:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1591:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    1594:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1597:	83 e8 10             	sub    $0x10,%eax
    159a:	8b 55 08             	mov    0x8(%ebp),%edx
    159d:	83 c0 1c             	add    $0x1c,%eax
    15a0:	8b 04 82             	mov    (%edx,%eax,4),%eax
    15a3:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    15a5:	8b 55 08             	mov    0x8(%ebp),%edx
    15a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ab:	83 c0 1c             	add    $0x1c,%eax
    15ae:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    15b1:	57                   	push   %edi
    15b2:	e8 de fd ff ff       	call   1395 <_S1>
    15b7:	83 c4 04             	add    $0x4,%esp
    15ba:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    15bd:	01 c3                	add    %eax,%ebx
    15bf:	ff 75 d4             	push   -0x2c(%ebp)
    15c2:	ff 75 d8             	push   -0x28(%ebp)
    15c5:	57                   	push   %edi
    15c6:	e8 65 fd ff ff       	call   1330 <_Ch>
    15cb:	83 c4 0c             	add    $0xc,%esp
    15ce:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    15d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15d4:	8b 04 85 a0 22 00 00 	mov    0x22a0(,%eax,4),%eax
    15db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    15de:	8b 55 08             	mov    0x8(%ebp),%edx
    15e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e4:	83 c0 1c             	add    $0x1c,%eax
    15e7:	8b 04 82             	mov    (%edx,%eax,4),%eax
    15ea:	01 c8                	add    %ecx,%eax
    15ec:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    15ef:	56                   	push   %esi
    15f0:	e8 6a fd ff ff       	call   135f <_S0>
    15f5:	83 c4 04             	add    $0x4,%esp
    15f8:	89 c3                	mov    %eax,%ebx
    15fa:	ff 75 dc             	push   -0x24(%ebp)
    15fd:	ff 75 e0             	push   -0x20(%ebp)
    1600:	56                   	push   %esi
    1601:	e8 41 fd ff ff       	call   1347 <_Ma>
    1606:	83 c4 0c             	add    $0xc,%esp
    1609:	01 d8                	add    %ebx,%eax
    160b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    160e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1611:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    1614:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1617:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    161a:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    161d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1620:	8b 7d d0             	mov    -0x30(%ebp),%edi
    1623:	01 c7                	add    %eax,%edi
        d = c;
    1625:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    162b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    162e:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    1631:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    1634:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1637:	8b 45 ec             	mov    -0x14(%ebp),%eax
    163a:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    163d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1641:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    1645:	0f 86 cf fe ff ff    	jbe    151a <_hash+0x57>
    }

    ctx->hash[0] += a;
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	8b 40 40             	mov    0x40(%eax),%eax
    1651:	8d 14 06             	lea    (%esi,%eax,1),%edx
    1654:	8b 45 08             	mov    0x8(%ebp),%eax
    1657:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    165a:	8b 45 08             	mov    0x8(%ebp),%eax
    165d:	8b 40 44             	mov    0x44(%eax),%eax
    1660:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1663:	01 c2                	add    %eax,%edx
    1665:	8b 45 08             	mov    0x8(%ebp),%eax
    1668:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    166b:	8b 45 08             	mov    0x8(%ebp),%eax
    166e:	8b 40 48             	mov    0x48(%eax),%eax
    1671:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1674:	01 c2                	add    %eax,%edx
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    167c:	8b 45 08             	mov    0x8(%ebp),%eax
    167f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1682:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1685:	01 c2                	add    %eax,%edx
    1687:	8b 45 08             	mov    0x8(%ebp),%eax
    168a:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    168d:	8b 45 08             	mov    0x8(%ebp),%eax
    1690:	8b 40 50             	mov    0x50(%eax),%eax
    1693:	8d 14 07             	lea    (%edi,%eax,1),%edx
    1696:	8b 45 08             	mov    0x8(%ebp),%eax
    1699:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    169c:	8b 45 08             	mov    0x8(%ebp),%eax
    169f:	8b 40 54             	mov    0x54(%eax),%eax
    16a2:	8b 55 d8             	mov    -0x28(%ebp),%edx
    16a5:	01 c2                	add    %eax,%edx
    16a7:	8b 45 08             	mov    0x8(%ebp),%eax
    16aa:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    16ad:	8b 45 08             	mov    0x8(%ebp),%eax
    16b0:	8b 40 58             	mov    0x58(%eax),%eax
    16b3:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    16b6:	01 c2                	add    %eax,%edx
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    16be:	8b 45 08             	mov    0x8(%ebp),%eax
    16c1:	8b 40 5c             	mov    0x5c(%eax),%eax
    16c4:	8b 55 cc             	mov    -0x34(%ebp),%edx
    16c7:	01 c2                	add    %eax,%edx
    16c9:	8b 45 08             	mov    0x8(%ebp),%eax
    16cc:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    16cf:	90                   	nop
    16d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16d3:	5b                   	pop    %ebx
    16d4:	5e                   	pop    %esi
    16d5:	5f                   	pop    %edi
    16d6:	5d                   	pop    %ebp
    16d7:	c3                   	ret    

000016d8 <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    16d8:	55                   	push   %ebp
    16d9:	89 e5                	mov    %esp,%ebp
    16db:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    16e1:	83 ec 0c             	sub    $0xc,%esp
    16e4:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    16ea:	50                   	push   %eax
    16eb:	e8 33 00 00 00       	call   1723 <sha256_init>
    16f0:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    16f3:	83 ec 04             	sub    $0x4,%esp
    16f6:	ff 75 0c             	push   0xc(%ebp)
    16f9:	ff 75 08             	push   0x8(%ebp)
    16fc:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1702:	50                   	push   %eax
    1703:	e8 99 00 00 00       	call   17a1 <sha256_hash>
    1708:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    170b:	83 ec 08             	sub    $0x8,%esp
    170e:	ff 75 10             	push   0x10(%ebp)
    1711:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1717:	50                   	push   %eax
    1718:	e8 14 01 00 00       	call   1831 <sha256_done>
    171d:	83 c4 10             	add    $0x10,%esp
}
    1720:	90                   	nop
    1721:	c9                   	leave  
    1722:	c3                   	ret    

00001723 <sha256_init>:

void sha256_init(sha256_context* ctx) {
    1723:	55                   	push   %ebp
    1724:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    1726:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    172a:	74 72                	je     179e <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    172c:	8b 45 08             	mov    0x8(%ebp),%eax
    172f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	8b 50 68             	mov    0x68(%eax),%edx
    173c:	8b 45 08             	mov    0x8(%ebp),%eax
    173f:	89 50 64             	mov    %edx,0x64(%eax)
    1742:	8b 45 08             	mov    0x8(%ebp),%eax
    1745:	8b 50 64             	mov    0x64(%eax),%edx
    1748:	8b 45 08             	mov    0x8(%ebp),%eax
    174b:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    174e:	8b 45 08             	mov    0x8(%ebp),%eax
    1751:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    1758:	8b 45 08             	mov    0x8(%ebp),%eax
    175b:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    1762:	8b 45 08             	mov    0x8(%ebp),%eax
    1765:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    176c:	8b 45 08             	mov    0x8(%ebp),%eax
    176f:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    1776:	8b 45 08             	mov    0x8(%ebp),%eax
    1779:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    1780:	8b 45 08             	mov    0x8(%ebp),%eax
    1783:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    178a:	8b 45 08             	mov    0x8(%ebp),%eax
    178d:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    1794:	8b 45 08             	mov    0x8(%ebp),%eax
    1797:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    179e:	90                   	nop
    179f:	5d                   	pop    %ebp
    17a0:	c3                   	ret    

000017a1 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    17a1:	55                   	push   %ebp
    17a2:	89 e5                	mov    %esp,%ebp
    17a4:	53                   	push   %ebx
    17a5:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    17a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ab:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    17ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    17b2:	74 77                	je     182b <sha256_hash+0x8a>
    17b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17b8:	74 71                	je     182b <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    17ba:	8b 45 08             	mov    0x8(%ebp),%eax
    17bd:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    17c0:	83 f8 3f             	cmp    $0x3f,%eax
    17c3:	77 66                	ja     182b <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    17c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    17cc:	eb 55                	jmp    1823 <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    17ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d4:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    17d7:	8b 45 08             	mov    0x8(%ebp),%eax
    17da:	8b 40 68             	mov    0x68(%eax),%eax
    17dd:	8d 48 01             	lea    0x1(%eax),%ecx
    17e0:	8b 55 08             	mov    0x8(%ebp),%edx
    17e3:	89 4a 68             	mov    %ecx,0x68(%edx)
    17e6:	0f b6 0b             	movzbl (%ebx),%ecx
    17e9:	8b 55 08             	mov    0x8(%ebp),%edx
    17ec:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    17ef:	8b 45 08             	mov    0x8(%ebp),%eax
    17f2:	8b 40 68             	mov    0x68(%eax),%eax
    17f5:	83 f8 40             	cmp    $0x40,%eax
    17f8:	75 25                	jne    181f <sha256_hash+0x7e>
                _hash(ctx);
    17fa:	ff 75 08             	push   0x8(%ebp)
    17fd:	e8 c1 fc ff ff       	call   14c3 <_hash>
    1802:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    1805:	68 00 02 00 00       	push   $0x200
    180a:	ff 75 08             	push   0x8(%ebp)
    180d:	e8 7c fc ff ff       	call   148e <_addbits>
    1812:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    1815:	8b 45 08             	mov    0x8(%ebp),%eax
    1818:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    181f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1823:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1826:	3b 45 10             	cmp    0x10(%ebp),%eax
    1829:	72 a3                	jb     17ce <sha256_hash+0x2d>
            }
        }
    }
}
    182b:	90                   	nop
    182c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    182f:	c9                   	leave  
    1830:	c3                   	ret    

00001831 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    1831:	55                   	push   %ebp
    1832:	89 e5                	mov    %esp,%ebp
    1834:	57                   	push   %edi
    1835:	56                   	push   %esi
    1836:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    1837:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    183b:	0f 84 27 02 00 00    	je     1a68 <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    1841:	8b 45 08             	mov    0x8(%ebp),%eax
    1844:	8b 40 68             	mov    0x68(%eax),%eax
    1847:	83 e0 3f             	and    $0x3f,%eax
    184a:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    184c:	8b 45 08             	mov    0x8(%ebp),%eax
    184f:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    1853:	8d 73 01             	lea    0x1(%ebx),%esi
    1856:	eb 0a                	jmp    1862 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    1858:	8b 45 08             	mov    0x8(%ebp),%eax
    185b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    185f:	83 c6 01             	add    $0x1,%esi
    1862:	83 fe 3f             	cmp    $0x3f,%esi
    1865:	76 f1                	jbe    1858 <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    1867:	8b 45 08             	mov    0x8(%ebp),%eax
    186a:	8b 40 68             	mov    0x68(%eax),%eax
    186d:	83 f8 37             	cmp    $0x37,%eax
    1870:	76 21                	jbe    1893 <sha256_done+0x62>
            _hash(ctx);
    1872:	ff 75 08             	push   0x8(%ebp)
    1875:	e8 49 fc ff ff       	call   14c3 <_hash>
    187a:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    187d:	bb 00 00 00 00       	mov    $0x0,%ebx
    1882:	eb 0a                	jmp    188e <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    1884:	8b 45 08             	mov    0x8(%ebp),%eax
    1887:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    188b:	83 c3 01             	add    $0x1,%ebx
    188e:	83 fb 3f             	cmp    $0x3f,%ebx
    1891:	76 f1                	jbe    1884 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    1893:	8b 45 08             	mov    0x8(%ebp),%eax
    1896:	8b 40 68             	mov    0x68(%eax),%eax
    1899:	c1 e0 03             	shl    $0x3,%eax
    189c:	50                   	push   %eax
    189d:	ff 75 08             	push   0x8(%ebp)
    18a0:	e8 e9 fb ff ff       	call   148e <_addbits>
    18a5:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    18a8:	8b 45 08             	mov    0x8(%ebp),%eax
    18ab:	8b 40 60             	mov    0x60(%eax),%eax
    18ae:	6a 00                	push   $0x0
    18b0:	50                   	push   %eax
    18b1:	e8 1a fa ff ff       	call   12d0 <_shb>
    18b6:	83 c4 08             	add    $0x8,%esp
    18b9:	8b 55 08             	mov    0x8(%ebp),%edx
    18bc:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    18bf:	8b 45 08             	mov    0x8(%ebp),%eax
    18c2:	8b 40 60             	mov    0x60(%eax),%eax
    18c5:	6a 08                	push   $0x8
    18c7:	50                   	push   %eax
    18c8:	e8 03 fa ff ff       	call   12d0 <_shb>
    18cd:	83 c4 08             	add    $0x8,%esp
    18d0:	8b 55 08             	mov    0x8(%ebp),%edx
    18d3:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    18d6:	8b 45 08             	mov    0x8(%ebp),%eax
    18d9:	8b 40 60             	mov    0x60(%eax),%eax
    18dc:	6a 10                	push   $0x10
    18de:	50                   	push   %eax
    18df:	e8 ec f9 ff ff       	call   12d0 <_shb>
    18e4:	83 c4 08             	add    $0x8,%esp
    18e7:	8b 55 08             	mov    0x8(%ebp),%edx
    18ea:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    18ed:	8b 45 08             	mov    0x8(%ebp),%eax
    18f0:	8b 40 60             	mov    0x60(%eax),%eax
    18f3:	6a 18                	push   $0x18
    18f5:	50                   	push   %eax
    18f6:	e8 d5 f9 ff ff       	call   12d0 <_shb>
    18fb:	83 c4 08             	add    $0x8,%esp
    18fe:	8b 55 08             	mov    0x8(%ebp),%edx
    1901:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    1904:	8b 45 08             	mov    0x8(%ebp),%eax
    1907:	8b 40 64             	mov    0x64(%eax),%eax
    190a:	6a 00                	push   $0x0
    190c:	50                   	push   %eax
    190d:	e8 be f9 ff ff       	call   12d0 <_shb>
    1912:	83 c4 08             	add    $0x8,%esp
    1915:	8b 55 08             	mov    0x8(%ebp),%edx
    1918:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    191b:	8b 45 08             	mov    0x8(%ebp),%eax
    191e:	8b 40 64             	mov    0x64(%eax),%eax
    1921:	6a 08                	push   $0x8
    1923:	50                   	push   %eax
    1924:	e8 a7 f9 ff ff       	call   12d0 <_shb>
    1929:	83 c4 08             	add    $0x8,%esp
    192c:	8b 55 08             	mov    0x8(%ebp),%edx
    192f:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    1932:	8b 45 08             	mov    0x8(%ebp),%eax
    1935:	8b 40 64             	mov    0x64(%eax),%eax
    1938:	6a 10                	push   $0x10
    193a:	50                   	push   %eax
    193b:	e8 90 f9 ff ff       	call   12d0 <_shb>
    1940:	83 c4 08             	add    $0x8,%esp
    1943:	8b 55 08             	mov    0x8(%ebp),%edx
    1946:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    1949:	8b 45 08             	mov    0x8(%ebp),%eax
    194c:	8b 40 64             	mov    0x64(%eax),%eax
    194f:	6a 18                	push   $0x18
    1951:	50                   	push   %eax
    1952:	e8 79 f9 ff ff       	call   12d0 <_shb>
    1957:	83 c4 08             	add    $0x8,%esp
    195a:	8b 55 08             	mov    0x8(%ebp),%edx
    195d:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    1960:	ff 75 08             	push   0x8(%ebp)
    1963:	e8 5b fb ff ff       	call   14c3 <_hash>
    1968:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    196b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    196f:	0f 84 f3 00 00 00    	je     1a68 <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1975:	be 00 00 00 00       	mov    $0x0,%esi
    197a:	bb 18 00 00 00       	mov    $0x18,%ebx
    197f:	e9 db 00 00 00       	jmp    1a5f <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8b 40 40             	mov    0x40(%eax),%eax
    198a:	8b 55 0c             	mov    0xc(%ebp),%edx
    198d:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    1990:	53                   	push   %ebx
    1991:	50                   	push   %eax
    1992:	e8 39 f9 ff ff       	call   12d0 <_shb>
    1997:	83 c4 08             	add    $0x8,%esp
    199a:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    199c:	8b 45 08             	mov    0x8(%ebp),%eax
    199f:	8b 40 44             	mov    0x44(%eax),%eax
    19a2:	8d 4e 04             	lea    0x4(%esi),%ecx
    19a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    19a8:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19ab:	53                   	push   %ebx
    19ac:	50                   	push   %eax
    19ad:	e8 1e f9 ff ff       	call   12d0 <_shb>
    19b2:	83 c4 08             	add    $0x8,%esp
    19b5:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	8b 40 48             	mov    0x48(%eax),%eax
    19bd:	8d 4e 08             	lea    0x8(%esi),%ecx
    19c0:	8b 55 0c             	mov    0xc(%ebp),%edx
    19c3:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19c6:	53                   	push   %ebx
    19c7:	50                   	push   %eax
    19c8:	e8 03 f9 ff ff       	call   12d0 <_shb>
    19cd:	83 c4 08             	add    $0x8,%esp
    19d0:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	8b 40 4c             	mov    0x4c(%eax),%eax
    19d8:	8d 4e 0c             	lea    0xc(%esi),%ecx
    19db:	8b 55 0c             	mov    0xc(%ebp),%edx
    19de:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19e1:	53                   	push   %ebx
    19e2:	50                   	push   %eax
    19e3:	e8 e8 f8 ff ff       	call   12d0 <_shb>
    19e8:	83 c4 08             	add    $0x8,%esp
    19eb:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    19ed:	8b 45 08             	mov    0x8(%ebp),%eax
    19f0:	8b 40 50             	mov    0x50(%eax),%eax
    19f3:	8d 4e 10             	lea    0x10(%esi),%ecx
    19f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    19f9:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19fc:	53                   	push   %ebx
    19fd:	50                   	push   %eax
    19fe:	e8 cd f8 ff ff       	call   12d0 <_shb>
    1a03:	83 c4 08             	add    $0x8,%esp
    1a06:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    1a08:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0b:	8b 40 54             	mov    0x54(%eax),%eax
    1a0e:	8d 4e 14             	lea    0x14(%esi),%ecx
    1a11:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a14:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a17:	53                   	push   %ebx
    1a18:	50                   	push   %eax
    1a19:	e8 b2 f8 ff ff       	call   12d0 <_shb>
    1a1e:	83 c4 08             	add    $0x8,%esp
    1a21:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    1a23:	8b 45 08             	mov    0x8(%ebp),%eax
    1a26:	8b 40 58             	mov    0x58(%eax),%eax
    1a29:	8d 4e 18             	lea    0x18(%esi),%ecx
    1a2c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a2f:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a32:	53                   	push   %ebx
    1a33:	50                   	push   %eax
    1a34:	e8 97 f8 ff ff       	call   12d0 <_shb>
    1a39:	83 c4 08             	add    $0x8,%esp
    1a3c:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	8b 40 5c             	mov    0x5c(%eax),%eax
    1a44:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    1a47:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a4a:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a4d:	53                   	push   %ebx
    1a4e:	50                   	push   %eax
    1a4f:	e8 7c f8 ff ff       	call   12d0 <_shb>
    1a54:	83 c4 08             	add    $0x8,%esp
    1a57:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1a59:	83 c6 01             	add    $0x1,%esi
    1a5c:	83 eb 08             	sub    $0x8,%ebx
    1a5f:	83 fe 03             	cmp    $0x3,%esi
    1a62:	0f 86 1c ff ff ff    	jbe    1984 <sha256_done+0x153>
            }
        }
    }
}
    1a68:	90                   	nop
    1a69:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a6c:	5b                   	pop    %ebx
    1a6d:	5e                   	pop    %esi
    1a6e:	5f                   	pop    %edi
    1a6f:	5d                   	pop    %ebp
    1a70:	c3                   	ret    

00001a71 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    1a71:	55                   	push   %ebp
    1a72:	89 e5                	mov    %esp,%ebp
    1a74:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1a77:	a1 bc 2b 00 00       	mov    0x2bbc,%eax
    1a7c:	83 ec 08             	sub    $0x8,%esp
    1a7f:	68 04 02 00 00       	push   $0x204
    1a84:	50                   	push   %eax
    1a85:	e8 7d e7 ff ff       	call   207 <open>
    1a8a:	83 c4 10             	add    $0x10,%esp
    1a8d:	a3 00 2c 00 00       	mov    %eax,0x2c00

    int i = 0;
    1a92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1a99:	eb 6f                	jmp    1b0a <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    1a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9e:	83 e0 01             	and    $0x1,%eax
    1aa1:	85 c0                	test   %eax,%eax
    1aa3:	75 27                	jne    1acc <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    1aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa8:	89 c2                	mov    %eax,%edx
    1aaa:	c1 ea 1f             	shr    $0x1f,%edx
    1aad:	01 d0                	add    %edx,%eax
    1aaf:	d1 f8                	sar    %eax
    1ab1:	6b c0 64             	imul   $0x64,%eax,%eax
    1ab4:	8d 90 20 2c 00 00    	lea    0x2c20(%eax),%edx
    1aba:	83 ec 08             	sub    $0x8,%esp
    1abd:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1ac0:	50                   	push   %eax
    1ac1:	52                   	push   %edx
    1ac2:	e8 ee e7 ff ff       	call   2b5 <strcpy>
    1ac7:	83 c4 10             	add    $0x10,%esp
    1aca:	eb 27                	jmp    1af3 <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1acf:	89 c2                	mov    %eax,%edx
    1ad1:	c1 ea 1f             	shr    $0x1f,%edx
    1ad4:	01 d0                	add    %edx,%eax
    1ad6:	d1 f8                	sar    %eax
    1ad8:	6b c0 64             	imul   $0x64,%eax,%eax
    1adb:	8d 90 60 2b 64 00    	lea    0x642b60(%eax),%edx
    1ae1:	83 ec 04             	sub    $0x4,%esp
    1ae4:	6a 64                	push   $0x64
    1ae6:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1ae9:	50                   	push   %eax
    1aea:	52                   	push   %edx
    1aeb:	e8 b1 e9 ff ff       	call   4a1 <memmove>
    1af0:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1af3:	83 ec 04             	sub    $0x4,%esp
    1af6:	6a 64                	push   $0x64
    1af8:	6a 00                	push   $0x0
    1afa:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1afd:	50                   	push   %eax
    1afe:	e8 48 e8 ff ff       	call   34b <memset>
    1b03:	83 c4 10             	add    $0x10,%esp
        i++;
    1b06:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1b0a:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1b0f:	83 ec 04             	sub    $0x4,%esp
    1b12:	6a 64                	push   $0x64
    1b14:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1b17:	52                   	push   %edx
    1b18:	50                   	push   %eax
    1b19:	e8 c1 e6 ff ff       	call   1df <read>
    1b1e:	83 c4 10             	add    $0x10,%esp
    1b21:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b28:	0f 8f 6d ff ff ff    	jg     1a9b <read_info+0x2a>
    }

    num_users = i / 2;
    1b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b31:	89 c2                	mov    %eax,%edx
    1b33:	c1 ea 1f             	shr    $0x1f,%edx
    1b36:	01 d0                	add    %edx,%eax
    1b38:	d1 f8                	sar    %eax
    1b3a:	a3 04 2c 00 00       	mov    %eax,0x2c04

    if (n < 0) {
    1b3f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b43:	79 17                	jns    1b5c <read_info+0xeb>
        printf(1, "cat: read error\n");
    1b45:	83 ec 08             	sub    $0x8,%esp
    1b48:	68 ab 23 00 00       	push   $0x23ab
    1b4d:	6a 01                	push   $0x1
    1b4f:	e8 83 ec ff ff       	call   7d7 <printf>
    1b54:	83 c4 10             	add    $0x10,%esp
        exit();
    1b57:	e8 6b e6 ff ff       	call   1c7 <exit>
    }
}
    1b5c:	90                   	nop
    1b5d:	c9                   	leave  
    1b5e:	c3                   	ret    

00001b5f <writeback>:

void writeback() {
    1b5f:	55                   	push   %ebp
    1b60:	89 e5                	mov    %esp,%ebp
    1b62:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1b65:	a1 bc 2b 00 00       	mov    0x2bbc,%eax
    1b6a:	83 ec 08             	sub    $0x8,%esp
    1b6d:	68 04 02 00 00       	push   $0x204
    1b72:	50                   	push   %eax
    1b73:	e8 8f e6 ff ff       	call   207 <open>
    1b78:	83 c4 10             	add    $0x10,%esp
    1b7b:	a3 00 2c 00 00       	mov    %eax,0x2c00
    for (int i = 0; i < num_users; i++) {
    1b80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b87:	eb 44                	jmp    1bcd <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1b89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b8c:	6b c0 64             	imul   $0x64,%eax,%eax
    1b8f:	8d 90 20 2c 00 00    	lea    0x2c20(%eax),%edx
    1b95:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1b9a:	83 ec 04             	sub    $0x4,%esp
    1b9d:	6a 64                	push   $0x64
    1b9f:	52                   	push   %edx
    1ba0:	50                   	push   %eax
    1ba1:	e8 41 e6 ff ff       	call   1e7 <write>
    1ba6:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bac:	6b c0 64             	imul   $0x64,%eax,%eax
    1baf:	8d 90 60 2b 64 00    	lea    0x642b60(%eax),%edx
    1bb5:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1bba:	83 ec 04             	sub    $0x4,%esp
    1bbd:	6a 64                	push   $0x64
    1bbf:	52                   	push   %edx
    1bc0:	50                   	push   %eax
    1bc1:	e8 21 e6 ff ff       	call   1e7 <write>
    1bc6:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1bc9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1bcd:	a1 04 2c 00 00       	mov    0x2c04,%eax
    1bd2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1bd5:	7c b2                	jl     1b89 <writeback+0x2a>
    }
    close(fd);
    1bd7:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1bdc:	83 ec 0c             	sub    $0xc,%esp
    1bdf:	50                   	push   %eax
    1be0:	e8 0a e6 ff ff       	call   1ef <close>
    1be5:	83 c4 10             	add    $0x10,%esp
}
    1be8:	90                   	nop
    1be9:	c9                   	leave  
    1bea:	c3                   	ret    

00001beb <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1beb:	55                   	push   %ebp
    1bec:	89 e5                	mov    %esp,%ebp
    1bee:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1bf4:	83 ec 08             	sub    $0x8,%esp
    1bf7:	68 bc 23 00 00       	push   $0x23bc
    1bfc:	68 20 2c 00 00       	push   $0x2c20
    1c01:	e8 af e6 ff ff       	call   2b5 <strcpy>
    1c06:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1c09:	c7 45 f4 c1 23 00 00 	movl   $0x23c1,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1c10:	83 ec 08             	sub    $0x8,%esp
    1c13:	ff 75 f4             	push   -0xc(%ebp)
    1c16:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c1c:	50                   	push   %eax
    1c1d:	e8 93 e6 ff ff       	call   2b5 <strcpy>
    1c22:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1c25:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1c2c:	83 ec 0c             	sub    $0xc,%esp
    1c2f:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c35:	50                   	push   %eax
    1c36:	e8 e8 fa ff ff       	call   1723 <sha256_init>
    1c3b:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1c3e:	83 ec 0c             	sub    $0xc,%esp
    1c41:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c47:	50                   	push   %eax
    1c48:	e8 d7 e6 ff ff       	call   324 <strlen>
    1c4d:	83 c4 10             	add    $0x10,%esp
    1c50:	83 ec 04             	sub    $0x4,%esp
    1c53:	50                   	push   %eax
    1c54:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c5a:	50                   	push   %eax
    1c5b:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c61:	50                   	push   %eax
    1c62:	e8 3a fb ff ff       	call   17a1 <sha256_hash>
    1c67:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1c6a:	83 ec 08             	sub    $0x8,%esp
    1c6d:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1c73:	50                   	push   %eax
    1c74:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c7a:	50                   	push   %eax
    1c7b:	e8 b1 fb ff ff       	call   1831 <sha256_done>
    1c80:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1c83:	83 ec 04             	sub    $0x4,%esp
    1c86:	6a 64                	push   $0x64
    1c88:	6a 00                	push   $0x0
    1c8a:	68 60 2b 64 00       	push   $0x642b60
    1c8f:	e8 b7 e6 ff ff       	call   34b <memset>
    1c94:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1c97:	83 ec 04             	sub    $0x4,%esp
    1c9a:	6a 20                	push   $0x20
    1c9c:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1ca2:	50                   	push   %eax
    1ca3:	68 60 2b 64 00       	push   $0x642b60
    1ca8:	e8 f4 e7 ff ff       	call   4a1 <memmove>
    1cad:	83 c4 10             	add    $0x10,%esp

    read_info();
    1cb0:	e8 bc fd ff ff       	call   1a71 <read_info>
    fd = open(SECRETS, O_RDWR);
    1cb5:	a1 bc 2b 00 00       	mov    0x2bbc,%eax
    1cba:	83 ec 08             	sub    $0x8,%esp
    1cbd:	6a 04                	push   $0x4
    1cbf:	50                   	push   %eax
    1cc0:	e8 42 e5 ff ff       	call   207 <open>
    1cc5:	83 c4 10             	add    $0x10,%esp
    1cc8:	a3 00 2c 00 00       	mov    %eax,0x2c00
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1ccd:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1cd2:	83 ec 04             	sub    $0x4,%esp
    1cd5:	6a 64                	push   $0x64
    1cd7:	68 20 2c 00 00       	push   $0x2c20
    1cdc:	50                   	push   %eax
    1cdd:	e8 05 e5 ff ff       	call   1e7 <write>
    1ce2:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1ce5:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1cea:	83 ec 04             	sub    $0x4,%esp
    1ced:	6a 64                	push   $0x64
    1cef:	68 60 2b 64 00       	push   $0x642b60
    1cf4:	50                   	push   %eax
    1cf5:	e8 ed e4 ff ff       	call   1e7 <write>
    1cfa:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1cfd:	a1 00 2c 00 00       	mov    0x2c00,%eax
    1d02:	83 ec 0c             	sub    $0xc,%esp
    1d05:	50                   	push   %eax
    1d06:	e8 e4 e4 ff ff       	call   1ef <close>
    1d0b:	83 c4 10             	add    $0x10,%esp
}
    1d0e:	90                   	nop
    1d0f:	c9                   	leave  
    1d10:	c3                   	ret    

00001d11 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1d11:	55                   	push   %ebp
    1d12:	89 e5                	mov    %esp,%ebp
    1d14:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1d17:	e8 55 fd ff ff       	call   1a71 <read_info>

    for (int i = 0; i < num_users; i++) {
    1d1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d23:	eb 29                	jmp    1d4e <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d28:	6b c0 64             	imul   $0x64,%eax,%eax
    1d2b:	05 20 2c 00 00       	add    $0x2c20,%eax
    1d30:	83 ec 08             	sub    $0x8,%esp
    1d33:	50                   	push   %eax
    1d34:	ff 75 08             	push   0x8(%ebp)
    1d37:	e8 a9 e5 ff ff       	call   2e5 <strcmp>
    1d3c:	83 c4 10             	add    $0x10,%esp
    1d3f:	85 c0                	test   %eax,%eax
    1d41:	75 07                	jne    1d4a <does_user_exist+0x39>
            return 0;
    1d43:	b8 00 00 00 00       	mov    $0x0,%eax
    1d48:	eb 13                	jmp    1d5d <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1d4a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d4e:	a1 04 2c 00 00       	mov    0x2c04,%eax
    1d53:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1d56:	7c cd                	jl     1d25 <does_user_exist+0x14>
        }
    }
    return -1;
    1d58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d5d:	c9                   	leave  
    1d5e:	c3                   	ret    

00001d5f <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1d5f:	55                   	push   %ebp
    1d60:	89 e5                	mov    %esp,%ebp
    1d62:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1d68:	e8 04 fd ff ff       	call   1a71 <read_info>

    int open = -1;
    1d6d:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1d74:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1d7b:	eb 46                	jmp    1dc3 <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1d7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d80:	6b c0 64             	imul   $0x64,%eax,%eax
    1d83:	05 20 2c 00 00       	add    $0x2c20,%eax
    1d88:	83 ec 08             	sub    $0x8,%esp
    1d8b:	50                   	push   %eax
    1d8c:	ff 75 08             	push   0x8(%ebp)
    1d8f:	e8 51 e5 ff ff       	call   2e5 <strcmp>
    1d94:	83 c4 10             	add    $0x10,%esp
    1d97:	85 c0                	test   %eax,%eax
    1d99:	75 0a                	jne    1da5 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1d9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1da0:	e9 18 01 00 00       	jmp    1ebd <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1da5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1da8:	6b c0 64             	imul   $0x64,%eax,%eax
    1dab:	05 20 2c 00 00       	add    $0x2c20,%eax
    1db0:	0f b6 00             	movzbl (%eax),%eax
    1db3:	84 c0                	test   %al,%al
    1db5:	75 08                	jne    1dbf <create_user+0x60>
            open = i;
    1db7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dba:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1dbd:	eb 0d                	jmp    1dcc <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1dbf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1dc3:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1dca:	7e b1                	jle    1d7d <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1dcc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1dd0:	0f 84 e2 00 00 00    	je     1eb8 <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1dd6:	83 ec 08             	sub    $0x8,%esp
    1dd9:	ff 75 0c             	push   0xc(%ebp)
    1ddc:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1de2:	50                   	push   %eax
    1de3:	e8 cd e4 ff ff       	call   2b5 <strcpy>
    1de8:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1deb:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1df2:	83 ec 0c             	sub    $0xc,%esp
    1df5:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1dfb:	50                   	push   %eax
    1dfc:	e8 22 f9 ff ff       	call   1723 <sha256_init>
    1e01:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1e04:	83 ec 0c             	sub    $0xc,%esp
    1e07:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1e0d:	50                   	push   %eax
    1e0e:	e8 11 e5 ff ff       	call   324 <strlen>
    1e13:	83 c4 10             	add    $0x10,%esp
    1e16:	83 ec 04             	sub    $0x4,%esp
    1e19:	50                   	push   %eax
    1e1a:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1e20:	50                   	push   %eax
    1e21:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1e27:	50                   	push   %eax
    1e28:	e8 74 f9 ff ff       	call   17a1 <sha256_hash>
    1e2d:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1e30:	83 ec 08             	sub    $0x8,%esp
    1e33:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1e39:	50                   	push   %eax
    1e3a:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1e40:	50                   	push   %eax
    1e41:	e8 eb f9 ff ff       	call   1831 <sha256_done>
    1e46:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e4c:	6b c0 64             	imul   $0x64,%eax,%eax
    1e4f:	05 20 2c 00 00       	add    $0x2c20,%eax
    1e54:	83 ec 08             	sub    $0x8,%esp
    1e57:	ff 75 08             	push   0x8(%ebp)
    1e5a:	50                   	push   %eax
    1e5b:	e8 55 e4 ff ff       	call   2b5 <strcpy>
    1e60:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e66:	6b c0 64             	imul   $0x64,%eax,%eax
    1e69:	05 60 2b 64 00       	add    $0x642b60,%eax
    1e6e:	83 ec 04             	sub    $0x4,%esp
    1e71:	6a 64                	push   $0x64
    1e73:	6a 00                	push   $0x0
    1e75:	50                   	push   %eax
    1e76:	e8 d0 e4 ff ff       	call   34b <memset>
    1e7b:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    1e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e81:	6b c0 64             	imul   $0x64,%eax,%eax
    1e84:	8d 90 60 2b 64 00    	lea    0x642b60(%eax),%edx
    1e8a:	83 ec 04             	sub    $0x4,%esp
    1e8d:	6a 20                	push   $0x20
    1e8f:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1e95:	50                   	push   %eax
    1e96:	52                   	push   %edx
    1e97:	e8 05 e6 ff ff       	call   4a1 <memmove>
    1e9c:	83 c4 10             	add    $0x10,%esp

        num_users++;
    1e9f:	a1 04 2c 00 00       	mov    0x2c04,%eax
    1ea4:	83 c0 01             	add    $0x1,%eax
    1ea7:	a3 04 2c 00 00       	mov    %eax,0x2c04
        writeback();
    1eac:	e8 ae fc ff ff       	call   1b5f <writeback>
        return 0;
    1eb1:	b8 00 00 00 00       	mov    $0x0,%eax
    1eb6:	eb 05                	jmp    1ebd <create_user+0x15e>
    }

    return -1;
    1eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ebd:	c9                   	leave  
    1ebe:	c3                   	ret    

00001ebf <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    1ebf:	55                   	push   %ebp
    1ec0:	89 e5                	mov    %esp,%ebp
    1ec2:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    1ec8:	e8 a4 fb ff ff       	call   1a71 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    1ecd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ed4:	e9 7b 01 00 00       	jmp    2054 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    1ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1edc:	6b c0 64             	imul   $0x64,%eax,%eax
    1edf:	05 20 2c 00 00       	add    $0x2c20,%eax
    1ee4:	83 ec 08             	sub    $0x8,%esp
    1ee7:	50                   	push   %eax
    1ee8:	ff 75 08             	push   0x8(%ebp)
    1eeb:	e8 f5 e3 ff ff       	call   2e5 <strcmp>
    1ef0:	83 c4 10             	add    $0x10,%esp
    1ef3:	85 c0                	test   %eax,%eax
    1ef5:	0f 85 55 01 00 00    	jne    2050 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    1efb:	83 ec 08             	sub    $0x8,%esp
    1efe:	ff 75 0c             	push   0xc(%ebp)
    1f01:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1f07:	50                   	push   %eax
    1f08:	e8 a8 e3 ff ff       	call   2b5 <strcpy>
    1f0d:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    1f10:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    1f17:	83 ec 0c             	sub    $0xc,%esp
    1f1a:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f20:	50                   	push   %eax
    1f21:	e8 fd f7 ff ff       	call   1723 <sha256_init>
    1f26:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    1f29:	83 ec 0c             	sub    $0xc,%esp
    1f2c:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1f32:	50                   	push   %eax
    1f33:	e8 ec e3 ff ff       	call   324 <strlen>
    1f38:	83 c4 10             	add    $0x10,%esp
    1f3b:	83 ec 04             	sub    $0x4,%esp
    1f3e:	50                   	push   %eax
    1f3f:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1f45:	50                   	push   %eax
    1f46:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f4c:	50                   	push   %eax
    1f4d:	e8 4f f8 ff ff       	call   17a1 <sha256_hash>
    1f52:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    1f55:	83 ec 08             	sub    $0x8,%esp
    1f58:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    1f5e:	50                   	push   %eax
    1f5f:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f65:	50                   	push   %eax
    1f66:	e8 c6 f8 ff ff       	call   1831 <sha256_done>
    1f6b:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    1f6e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1f75:	eb 34                	jmp    1fab <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    1f77:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    1f7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f80:	01 d0                	add    %edx,%eax
    1f82:	0f b6 00             	movzbl (%eax),%eax
    1f85:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1f88:	6b ca 64             	imul   $0x64,%edx,%ecx
    1f8b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1f8e:	01 ca                	add    %ecx,%edx
    1f90:	81 c2 60 2b 64 00    	add    $0x642b60,%edx
    1f96:	0f b6 12             	movzbl (%edx),%edx
    1f99:	38 d0                	cmp    %dl,%al
    1f9b:	74 0a                	je     1fa7 <login_user+0xe8>
                    return -1;
    1f9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1fa2:	e9 bf 00 00 00       	jmp    2066 <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    1fa7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1fab:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    1faf:	7e c6                	jle    1f77 <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    1fb1:	83 ec 08             	sub    $0x8,%esp
    1fb4:	68 c7 23 00 00       	push   $0x23c7
    1fb9:	6a 01                	push   $0x1
    1fbb:	e8 17 e8 ff ff       	call   7d7 <printf>
    1fc0:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    1fc3:	e8 f7 e1 ff ff       	call   1bf <fork>
    1fc8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    1fcb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fcf:	79 17                	jns    1fe8 <login_user+0x129>
                printf(1, "init: fork failed\n");
    1fd1:	83 ec 08             	sub    $0x8,%esp
    1fd4:	68 da 23 00 00       	push   $0x23da
    1fd9:	6a 01                	push   $0x1
    1fdb:	e8 f7 e7 ff ff       	call   7d7 <printf>
    1fe0:	83 c4 10             	add    $0x10,%esp
                exit();
    1fe3:	e8 df e1 ff ff       	call   1c7 <exit>
            }
            if (pid == 0) {
    1fe8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fec:	75 4c                	jne    203a <login_user+0x17b>
                setuid(i);
    1fee:	83 ec 0c             	sub    $0xc,%esp
    1ff1:	ff 75 f4             	push   -0xc(%ebp)
    1ff4:	e8 6e e2 ff ff       	call   267 <setuid>
    1ff9:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    1ffc:	83 ec 08             	sub    $0x8,%esp
    1fff:	68 c0 2b 00 00       	push   $0x2bc0
    2004:	68 a8 23 00 00       	push   $0x23a8
    2009:	e8 f1 e1 ff ff       	call   1ff <exec>
    200e:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    2011:	83 ec 08             	sub    $0x8,%esp
    2014:	68 ed 23 00 00       	push   $0x23ed
    2019:	6a 01                	push   $0x1
    201b:	e8 b7 e7 ff ff       	call   7d7 <printf>
    2020:	83 c4 10             	add    $0x10,%esp
                exit();
    2023:	e8 9f e1 ff ff       	call   1c7 <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    2028:	83 ec 08             	sub    $0x8,%esp
    202b:	68 03 24 00 00       	push   $0x2403
    2030:	6a 01                	push   $0x1
    2032:	e8 a0 e7 ff ff       	call   7d7 <printf>
    2037:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    203a:	e8 90 e1 ff ff       	call   1cf <wait>
    203f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2042:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2046:	78 08                	js     2050 <login_user+0x191>
    2048:	8b 45 e8             	mov    -0x18(%ebp),%eax
    204b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    204e:	75 d8                	jne    2028 <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    2050:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2054:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    205b:	0f 8e 78 fe ff ff    	jle    1ed9 <login_user+0x1a>
        }
    }

    return -1;
    2061:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2066:	c9                   	leave  
    2067:	c3                   	ret    
