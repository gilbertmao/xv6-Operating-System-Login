
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

char* argv[] = {"sh", 0};

int main(void) {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
    int pid, wpid;

    if (open("console", O_RDWR) < 0) {
      11:	83 ec 08             	sub    $0x8,%esp
      14:	6a 04                	push   $0x4
      16:	68 c3 1f 00 00       	push   $0x1fc3
      1b:	e8 29 01 00 00       	call   149 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
        mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 c3 1f 00 00       	push   $0x1fc3
      33:	e8 19 01 00 00       	call   151 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
        open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 04                	push   $0x4
      40:	68 c3 1f 00 00       	push   $0x1fc3
      45:	e8 ff 00 00 00       	call   149 <open>
      4a:	83 c4 10             	add    $0x10,%esp
    }
    dup(0);  // stdout
      4d:	83 ec 0c             	sub    $0xc,%esp
      50:	6a 00                	push   $0x0
      52:	e8 2a 01 00 00       	call   181 <dup>
      57:	83 c4 10             	add    $0x10,%esp
    dup(0);  // stderr
      5a:	83 ec 0c             	sub    $0xc,%esp
      5d:	6a 00                	push   $0x0
      5f:	e8 1d 01 00 00       	call   181 <dup>
      64:	83 c4 10             	add    $0x10,%esp

    for (;;) {
        printf(1, "init: starting sh\n");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 cb 1f 00 00       	push   $0x1fcb
      6f:	6a 01                	push   $0x1
      71:	e8 a3 06 00 00       	call   719 <printf>
      76:	83 c4 10             	add    $0x10,%esp
        pid = fork();
      79:	e8 83 00 00 00       	call   101 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (pid < 0) {
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
            printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 de 1f 00 00       	push   $0x1fde
      8f:	6a 01                	push   $0x1
      91:	e8 83 06 00 00       	call   719 <printf>
      96:	83 c4 10             	add    $0x10,%esp
            exit();
      99:	e8 6b 00 00 00       	call   109 <exit>
        }
        if (pid == 0) {
      9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a2:	75 3e                	jne    e2 <main+0xe2>
            exec("sh", argv);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	68 e8 29 00 00       	push   $0x29e8
      ac:	68 c0 1f 00 00       	push   $0x1fc0
      b1:	e8 8b 00 00 00       	call   141 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
            printf(1, "init: exec sh failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 f1 1f 00 00       	push   $0x1ff1
      c1:	6a 01                	push   $0x1
      c3:	e8 51 06 00 00       	call   719 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
            exit();
      cb:	e8 39 00 00 00       	call   109 <exit>
        }
        while ((wpid = wait()) >= 0 && wpid != pid) printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 07 20 00 00       	push   $0x2007
      d8:	6a 01                	push   $0x1
      da:	e8 3a 06 00 00       	call   719 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      e2:	e8 2a 00 00 00       	call   111 <wait>
      e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
      ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
      f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      fa:	75 d4                	jne    d0 <main+0xd0>
        printf(1, "init: starting sh\n");
      fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     101:	b8 01 00 00 00       	mov    $0x1,%eax
     106:	cd 40                	int    $0x40
     108:	c3                   	ret    

00000109 <exit>:
SYSCALL(exit)
     109:	b8 02 00 00 00       	mov    $0x2,%eax
     10e:	cd 40                	int    $0x40
     110:	c3                   	ret    

00000111 <wait>:
SYSCALL(wait)
     111:	b8 03 00 00 00       	mov    $0x3,%eax
     116:	cd 40                	int    $0x40
     118:	c3                   	ret    

00000119 <pipe>:
SYSCALL(pipe)
     119:	b8 04 00 00 00       	mov    $0x4,%eax
     11e:	cd 40                	int    $0x40
     120:	c3                   	ret    

00000121 <read>:
SYSCALL(read)
     121:	b8 05 00 00 00       	mov    $0x5,%eax
     126:	cd 40                	int    $0x40
     128:	c3                   	ret    

00000129 <write>:
SYSCALL(write)
     129:	b8 10 00 00 00       	mov    $0x10,%eax
     12e:	cd 40                	int    $0x40
     130:	c3                   	ret    

00000131 <close>:
SYSCALL(close)
     131:	b8 15 00 00 00       	mov    $0x15,%eax
     136:	cd 40                	int    $0x40
     138:	c3                   	ret    

00000139 <kill>:
SYSCALL(kill)
     139:	b8 06 00 00 00       	mov    $0x6,%eax
     13e:	cd 40                	int    $0x40
     140:	c3                   	ret    

00000141 <exec>:
SYSCALL(exec)
     141:	b8 07 00 00 00       	mov    $0x7,%eax
     146:	cd 40                	int    $0x40
     148:	c3                   	ret    

00000149 <open>:
SYSCALL(open)
     149:	b8 0f 00 00 00       	mov    $0xf,%eax
     14e:	cd 40                	int    $0x40
     150:	c3                   	ret    

00000151 <mknod>:
SYSCALL(mknod)
     151:	b8 11 00 00 00       	mov    $0x11,%eax
     156:	cd 40                	int    $0x40
     158:	c3                   	ret    

00000159 <unlink>:
SYSCALL(unlink)
     159:	b8 12 00 00 00       	mov    $0x12,%eax
     15e:	cd 40                	int    $0x40
     160:	c3                   	ret    

00000161 <fstat>:
SYSCALL(fstat)
     161:	b8 08 00 00 00       	mov    $0x8,%eax
     166:	cd 40                	int    $0x40
     168:	c3                   	ret    

00000169 <link>:
SYSCALL(link)
     169:	b8 13 00 00 00       	mov    $0x13,%eax
     16e:	cd 40                	int    $0x40
     170:	c3                   	ret    

00000171 <mkdir>:
SYSCALL(mkdir)
     171:	b8 14 00 00 00       	mov    $0x14,%eax
     176:	cd 40                	int    $0x40
     178:	c3                   	ret    

00000179 <chdir>:
SYSCALL(chdir)
     179:	b8 09 00 00 00       	mov    $0x9,%eax
     17e:	cd 40                	int    $0x40
     180:	c3                   	ret    

00000181 <dup>:
SYSCALL(dup)
     181:	b8 0a 00 00 00       	mov    $0xa,%eax
     186:	cd 40                	int    $0x40
     188:	c3                   	ret    

00000189 <getpid>:
SYSCALL(getpid)
     189:	b8 0b 00 00 00       	mov    $0xb,%eax
     18e:	cd 40                	int    $0x40
     190:	c3                   	ret    

00000191 <sbrk>:
SYSCALL(sbrk)
     191:	b8 0c 00 00 00       	mov    $0xc,%eax
     196:	cd 40                	int    $0x40
     198:	c3                   	ret    

00000199 <sleep>:
SYSCALL(sleep)
     199:	b8 0d 00 00 00       	mov    $0xd,%eax
     19e:	cd 40                	int    $0x40
     1a0:	c3                   	ret    

000001a1 <uptime>:
SYSCALL(uptime)
     1a1:	b8 0e 00 00 00       	mov    $0xe,%eax
     1a6:	cd 40                	int    $0x40
     1a8:	c3                   	ret    

000001a9 <setuid>:
SYSCALL(setuid)
     1a9:	b8 16 00 00 00       	mov    $0x16,%eax
     1ae:	cd 40                	int    $0x40
     1b0:	c3                   	ret    

000001b1 <getuid>:
SYSCALL(getuid)
     1b1:	b8 19 00 00 00       	mov    $0x19,%eax
     1b6:	cd 40                	int    $0x40
     1b8:	c3                   	ret    

000001b9 <chown>:
SYSCALL(chown)
     1b9:	b8 18 00 00 00       	mov    $0x18,%eax
     1be:	cd 40                	int    $0x40
     1c0:	c3                   	ret    

000001c1 <chmod>:
SYSCALL(chmod)
     1c1:	b8 17 00 00 00       	mov    $0x17,%eax
     1c6:	cd 40                	int    $0x40
     1c8:	c3                   	ret    

000001c9 <report_stats>:
SYSCALL(report_stats)
     1c9:	b8 1a 00 00 00       	mov    $0x1a,%eax
     1ce:	cd 40                	int    $0x40
     1d0:	c3                   	ret    

000001d1 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1d1:	55                   	push   %ebp
     1d2:	89 e5                	mov    %esp,%ebp
     1d4:	57                   	push   %edi
     1d5:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     1d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1d9:	8b 55 10             	mov    0x10(%ebp),%edx
     1dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     1df:	89 cb                	mov    %ecx,%ebx
     1e1:	89 df                	mov    %ebx,%edi
     1e3:	89 d1                	mov    %edx,%ecx
     1e5:	fc                   	cld    
     1e6:	f3 aa                	rep stos %al,%es:(%edi)
     1e8:	89 ca                	mov    %ecx,%edx
     1ea:	89 fb                	mov    %edi,%ebx
     1ec:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1ef:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1f2:	90                   	nop
     1f3:	5b                   	pop    %ebx
     1f4:	5f                   	pop    %edi
     1f5:	5d                   	pop    %ebp
     1f6:	c3                   	ret    

000001f7 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     1f7:	55                   	push   %ebp
     1f8:	89 e5                	mov    %esp,%ebp
     1fa:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     1fd:	8b 45 08             	mov    0x8(%ebp),%eax
     200:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     203:	90                   	nop
     204:	8b 55 0c             	mov    0xc(%ebp),%edx
     207:	8d 42 01             	lea    0x1(%edx),%eax
     20a:	89 45 0c             	mov    %eax,0xc(%ebp)
     20d:	8b 45 08             	mov    0x8(%ebp),%eax
     210:	8d 48 01             	lea    0x1(%eax),%ecx
     213:	89 4d 08             	mov    %ecx,0x8(%ebp)
     216:	0f b6 12             	movzbl (%edx),%edx
     219:	88 10                	mov    %dl,(%eax)
     21b:	0f b6 00             	movzbl (%eax),%eax
     21e:	84 c0                	test   %al,%al
     220:	75 e2                	jne    204 <strcpy+0xd>
        ;
    return os;
     222:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     225:	c9                   	leave  
     226:	c3                   	ret    

00000227 <strcmp>:

int strcmp(const char* p, const char* q) {
     227:	55                   	push   %ebp
     228:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     22a:	eb 08                	jmp    234 <strcmp+0xd>
     22c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     230:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     234:	8b 45 08             	mov    0x8(%ebp),%eax
     237:	0f b6 00             	movzbl (%eax),%eax
     23a:	84 c0                	test   %al,%al
     23c:	74 10                	je     24e <strcmp+0x27>
     23e:	8b 45 08             	mov    0x8(%ebp),%eax
     241:	0f b6 10             	movzbl (%eax),%edx
     244:	8b 45 0c             	mov    0xc(%ebp),%eax
     247:	0f b6 00             	movzbl (%eax),%eax
     24a:	38 c2                	cmp    %al,%dl
     24c:	74 de                	je     22c <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	0f b6 00             	movzbl (%eax),%eax
     254:	0f b6 d0             	movzbl %al,%edx
     257:	8b 45 0c             	mov    0xc(%ebp),%eax
     25a:	0f b6 00             	movzbl (%eax),%eax
     25d:	0f b6 c8             	movzbl %al,%ecx
     260:	89 d0                	mov    %edx,%eax
     262:	29 c8                	sub    %ecx,%eax
}
     264:	5d                   	pop    %ebp
     265:	c3                   	ret    

00000266 <strlen>:

uint strlen(const char* s) {
     266:	55                   	push   %ebp
     267:	89 e5                	mov    %esp,%ebp
     269:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     26c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     273:	eb 04                	jmp    279 <strlen+0x13>
     275:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     279:	8b 55 fc             	mov    -0x4(%ebp),%edx
     27c:	8b 45 08             	mov    0x8(%ebp),%eax
     27f:	01 d0                	add    %edx,%eax
     281:	0f b6 00             	movzbl (%eax),%eax
     284:	84 c0                	test   %al,%al
     286:	75 ed                	jne    275 <strlen+0xf>
        ;
    return n;
     288:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     28b:	c9                   	leave  
     28c:	c3                   	ret    

0000028d <memset>:

void* memset(void* dst, int c, uint n) {
     28d:	55                   	push   %ebp
     28e:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     290:	8b 45 10             	mov    0x10(%ebp),%eax
     293:	50                   	push   %eax
     294:	ff 75 0c             	push   0xc(%ebp)
     297:	ff 75 08             	push   0x8(%ebp)
     29a:	e8 32 ff ff ff       	call   1d1 <stosb>
     29f:	83 c4 0c             	add    $0xc,%esp
    return dst;
     2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2a5:	c9                   	leave  
     2a6:	c3                   	ret    

000002a7 <strchr>:

char* strchr(const char* s, char c) {
     2a7:	55                   	push   %ebp
     2a8:	89 e5                	mov    %esp,%ebp
     2aa:	83 ec 04             	sub    $0x4,%esp
     2ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b0:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     2b3:	eb 14                	jmp    2c9 <strchr+0x22>
        if (*s == c) return (char*) s;
     2b5:	8b 45 08             	mov    0x8(%ebp),%eax
     2b8:	0f b6 00             	movzbl (%eax),%eax
     2bb:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2be:	75 05                	jne    2c5 <strchr+0x1e>
     2c0:	8b 45 08             	mov    0x8(%ebp),%eax
     2c3:	eb 13                	jmp    2d8 <strchr+0x31>
    for (; *s; s++)
     2c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2c9:	8b 45 08             	mov    0x8(%ebp),%eax
     2cc:	0f b6 00             	movzbl (%eax),%eax
     2cf:	84 c0                	test   %al,%al
     2d1:	75 e2                	jne    2b5 <strchr+0xe>
    return 0;
     2d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2d8:	c9                   	leave  
     2d9:	c3                   	ret    

000002da <gets>:

char* gets(char* buf, int max) {
     2da:	55                   	push   %ebp
     2db:	89 e5                	mov    %esp,%ebp
     2dd:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     2e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2e7:	eb 42                	jmp    32b <gets+0x51>
        cc = read(0, &c, 1);
     2e9:	83 ec 04             	sub    $0x4,%esp
     2ec:	6a 01                	push   $0x1
     2ee:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2f1:	50                   	push   %eax
     2f2:	6a 00                	push   $0x0
     2f4:	e8 28 fe ff ff       	call   121 <read>
     2f9:	83 c4 10             	add    $0x10,%esp
     2fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     2ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     303:	7e 33                	jle    338 <gets+0x5e>
        buf[i++] = c;
     305:	8b 45 f4             	mov    -0xc(%ebp),%eax
     308:	8d 50 01             	lea    0x1(%eax),%edx
     30b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     30e:	89 c2                	mov    %eax,%edx
     310:	8b 45 08             	mov    0x8(%ebp),%eax
     313:	01 c2                	add    %eax,%edx
     315:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     319:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     31b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     31f:	3c 0a                	cmp    $0xa,%al
     321:	74 16                	je     339 <gets+0x5f>
     323:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     327:	3c 0d                	cmp    $0xd,%al
     329:	74 0e                	je     339 <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     32b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     32e:	83 c0 01             	add    $0x1,%eax
     331:	39 45 0c             	cmp    %eax,0xc(%ebp)
     334:	7f b3                	jg     2e9 <gets+0xf>
     336:	eb 01                	jmp    339 <gets+0x5f>
        if (cc < 1) break;
     338:	90                   	nop
    }
    buf[i] = '\0';
     339:	8b 55 f4             	mov    -0xc(%ebp),%edx
     33c:	8b 45 08             	mov    0x8(%ebp),%eax
     33f:	01 d0                	add    %edx,%eax
     341:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     344:	8b 45 08             	mov    0x8(%ebp),%eax
}
     347:	c9                   	leave  
     348:	c3                   	ret    

00000349 <stat>:

int stat(const char* n, struct stat* st) {
     349:	55                   	push   %ebp
     34a:	89 e5                	mov    %esp,%ebp
     34c:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     34f:	83 ec 08             	sub    $0x8,%esp
     352:	6a 01                	push   $0x1
     354:	ff 75 08             	push   0x8(%ebp)
     357:	e8 ed fd ff ff       	call   149 <open>
     35c:	83 c4 10             	add    $0x10,%esp
     35f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     362:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     366:	79 07                	jns    36f <stat+0x26>
     368:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     36d:	eb 25                	jmp    394 <stat+0x4b>
    r = fstat(fd, st);
     36f:	83 ec 08             	sub    $0x8,%esp
     372:	ff 75 0c             	push   0xc(%ebp)
     375:	ff 75 f4             	push   -0xc(%ebp)
     378:	e8 e4 fd ff ff       	call   161 <fstat>
     37d:	83 c4 10             	add    $0x10,%esp
     380:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     383:	83 ec 0c             	sub    $0xc,%esp
     386:	ff 75 f4             	push   -0xc(%ebp)
     389:	e8 a3 fd ff ff       	call   131 <close>
     38e:	83 c4 10             	add    $0x10,%esp
    return r;
     391:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     394:	c9                   	leave  
     395:	c3                   	ret    

00000396 <atoi>:

int atoi(const char* s) {
     396:	55                   	push   %ebp
     397:	89 e5                	mov    %esp,%ebp
     399:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     39c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     3a3:	eb 25                	jmp    3ca <atoi+0x34>
     3a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3a8:	89 d0                	mov    %edx,%eax
     3aa:	c1 e0 02             	shl    $0x2,%eax
     3ad:	01 d0                	add    %edx,%eax
     3af:	01 c0                	add    %eax,%eax
     3b1:	89 c1                	mov    %eax,%ecx
     3b3:	8b 45 08             	mov    0x8(%ebp),%eax
     3b6:	8d 50 01             	lea    0x1(%eax),%edx
     3b9:	89 55 08             	mov    %edx,0x8(%ebp)
     3bc:	0f b6 00             	movzbl (%eax),%eax
     3bf:	0f be c0             	movsbl %al,%eax
     3c2:	01 c8                	add    %ecx,%eax
     3c4:	83 e8 30             	sub    $0x30,%eax
     3c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
     3ca:	8b 45 08             	mov    0x8(%ebp),%eax
     3cd:	0f b6 00             	movzbl (%eax),%eax
     3d0:	3c 2f                	cmp    $0x2f,%al
     3d2:	7e 0a                	jle    3de <atoi+0x48>
     3d4:	8b 45 08             	mov    0x8(%ebp),%eax
     3d7:	0f b6 00             	movzbl (%eax),%eax
     3da:	3c 39                	cmp    $0x39,%al
     3dc:	7e c7                	jle    3a5 <atoi+0xf>
    return n;
     3de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e1:	c9                   	leave  
     3e2:	c3                   	ret    

000003e3 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     3e3:	55                   	push   %ebp
     3e4:	89 e5                	mov    %esp,%ebp
     3e6:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     3e9:	8b 45 08             	mov    0x8(%ebp),%eax
     3ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     3ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     3f5:	eb 17                	jmp    40e <memmove+0x2b>
     3f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     3fa:	8d 42 01             	lea    0x1(%edx),%eax
     3fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
     400:	8b 45 fc             	mov    -0x4(%ebp),%eax
     403:	8d 48 01             	lea    0x1(%eax),%ecx
     406:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     409:	0f b6 12             	movzbl (%edx),%edx
     40c:	88 10                	mov    %dl,(%eax)
     40e:	8b 45 10             	mov    0x10(%ebp),%eax
     411:	8d 50 ff             	lea    -0x1(%eax),%edx
     414:	89 55 10             	mov    %edx,0x10(%ebp)
     417:	85 c0                	test   %eax,%eax
     419:	7f dc                	jg     3f7 <memmove+0x14>
    return vdst;
     41b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     41e:	c9                   	leave  
     41f:	c3                   	ret    

00000420 <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     426:	8b 45 08             	mov    0x8(%ebp),%eax
     429:	83 e8 08             	sub    $0x8,%eax
     42c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     42f:	a1 28 2a 00 00       	mov    0x2a28,%eax
     434:	89 45 fc             	mov    %eax,-0x4(%ebp)
     437:	eb 24                	jmp    45d <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     439:	8b 45 fc             	mov    -0x4(%ebp),%eax
     43c:	8b 00                	mov    (%eax),%eax
     43e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     441:	72 12                	jb     455 <free+0x35>
     443:	8b 45 f8             	mov    -0x8(%ebp),%eax
     446:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     449:	77 24                	ja     46f <free+0x4f>
     44b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     44e:	8b 00                	mov    (%eax),%eax
     450:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     453:	72 1a                	jb     46f <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     455:	8b 45 fc             	mov    -0x4(%ebp),%eax
     458:	8b 00                	mov    (%eax),%eax
     45a:	89 45 fc             	mov    %eax,-0x4(%ebp)
     45d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     460:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     463:	76 d4                	jbe    439 <free+0x19>
     465:	8b 45 fc             	mov    -0x4(%ebp),%eax
     468:	8b 00                	mov    (%eax),%eax
     46a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     46d:	73 ca                	jae    439 <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     46f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     472:	8b 40 04             	mov    0x4(%eax),%eax
     475:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     47c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     47f:	01 c2                	add    %eax,%edx
     481:	8b 45 fc             	mov    -0x4(%ebp),%eax
     484:	8b 00                	mov    (%eax),%eax
     486:	39 c2                	cmp    %eax,%edx
     488:	75 24                	jne    4ae <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     48a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     48d:	8b 50 04             	mov    0x4(%eax),%edx
     490:	8b 45 fc             	mov    -0x4(%ebp),%eax
     493:	8b 00                	mov    (%eax),%eax
     495:	8b 40 04             	mov    0x4(%eax),%eax
     498:	01 c2                	add    %eax,%edx
     49a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     49d:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     4a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4a3:	8b 00                	mov    (%eax),%eax
     4a5:	8b 10                	mov    (%eax),%edx
     4a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4aa:	89 10                	mov    %edx,(%eax)
     4ac:	eb 0a                	jmp    4b8 <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     4ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4b1:	8b 10                	mov    (%eax),%edx
     4b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4b6:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     4b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4bb:	8b 40 04             	mov    0x4(%eax),%eax
     4be:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     4c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4c8:	01 d0                	add    %edx,%eax
     4ca:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     4cd:	75 20                	jne    4ef <free+0xcf>
        p->s.size += bp->s.size;
     4cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4d2:	8b 50 04             	mov    0x4(%eax),%edx
     4d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4d8:	8b 40 04             	mov    0x4(%eax),%eax
     4db:	01 c2                	add    %eax,%edx
     4dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4e0:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     4e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4e6:	8b 10                	mov    (%eax),%edx
     4e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4eb:	89 10                	mov    %edx,(%eax)
     4ed:	eb 08                	jmp    4f7 <free+0xd7>
    } else
        p->s.ptr = bp;
     4ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
     4f5:	89 10                	mov    %edx,(%eax)
    freep = p;
     4f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4fa:	a3 28 2a 00 00       	mov    %eax,0x2a28
}
     4ff:	90                   	nop
     500:	c9                   	leave  
     501:	c3                   	ret    

00000502 <morecore>:

static Header* morecore(uint nu) {
     502:	55                   	push   %ebp
     503:	89 e5                	mov    %esp,%ebp
     505:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     508:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     50f:	77 07                	ja     518 <morecore+0x16>
     511:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     518:	8b 45 08             	mov    0x8(%ebp),%eax
     51b:	c1 e0 03             	shl    $0x3,%eax
     51e:	83 ec 0c             	sub    $0xc,%esp
     521:	50                   	push   %eax
     522:	e8 6a fc ff ff       	call   191 <sbrk>
     527:	83 c4 10             	add    $0x10,%esp
     52a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     52d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     531:	75 07                	jne    53a <morecore+0x38>
     533:	b8 00 00 00 00       	mov    $0x0,%eax
     538:	eb 26                	jmp    560 <morecore+0x5e>
    hp = (Header*) p;
     53a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     53d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     540:	8b 45 f0             	mov    -0x10(%ebp),%eax
     543:	8b 55 08             	mov    0x8(%ebp),%edx
     546:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     549:	8b 45 f0             	mov    -0x10(%ebp),%eax
     54c:	83 c0 08             	add    $0x8,%eax
     54f:	83 ec 0c             	sub    $0xc,%esp
     552:	50                   	push   %eax
     553:	e8 c8 fe ff ff       	call   420 <free>
     558:	83 c4 10             	add    $0x10,%esp
    return freep;
     55b:	a1 28 2a 00 00       	mov    0x2a28,%eax
}
     560:	c9                   	leave  
     561:	c3                   	ret    

00000562 <malloc>:

void* malloc(uint nbytes) {
     562:	55                   	push   %ebp
     563:	89 e5                	mov    %esp,%ebp
     565:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     568:	8b 45 08             	mov    0x8(%ebp),%eax
     56b:	83 c0 07             	add    $0x7,%eax
     56e:	c1 e8 03             	shr    $0x3,%eax
     571:	83 c0 01             	add    $0x1,%eax
     574:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     577:	a1 28 2a 00 00       	mov    0x2a28,%eax
     57c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     57f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     583:	75 23                	jne    5a8 <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     585:	c7 45 f0 20 2a 00 00 	movl   $0x2a20,-0x10(%ebp)
     58c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     58f:	a3 28 2a 00 00       	mov    %eax,0x2a28
     594:	a1 28 2a 00 00       	mov    0x2a28,%eax
     599:	a3 20 2a 00 00       	mov    %eax,0x2a20
        base.s.size = 0;
     59e:	c7 05 24 2a 00 00 00 	movl   $0x0,0x2a24
     5a5:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     5a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5ab:	8b 00                	mov    (%eax),%eax
     5ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     5b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5b3:	8b 40 04             	mov    0x4(%eax),%eax
     5b6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     5b9:	77 4d                	ja     608 <malloc+0xa6>
            if (p->s.size == nunits)
     5bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5be:	8b 40 04             	mov    0x4(%eax),%eax
     5c1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     5c4:	75 0c                	jne    5d2 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     5c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5c9:	8b 10                	mov    (%eax),%edx
     5cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5ce:	89 10                	mov    %edx,(%eax)
     5d0:	eb 26                	jmp    5f8 <malloc+0x96>
            else {
                p->s.size -= nunits;
     5d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5d5:	8b 40 04             	mov    0x4(%eax),%eax
     5d8:	2b 45 ec             	sub    -0x14(%ebp),%eax
     5db:	89 c2                	mov    %eax,%edx
     5dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e0:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     5e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e6:	8b 40 04             	mov    0x4(%eax),%eax
     5e9:	c1 e0 03             	shl    $0x3,%eax
     5ec:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     5ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     5f5:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     5f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5fb:	a3 28 2a 00 00       	mov    %eax,0x2a28
            return (void*) (p + 1);
     600:	8b 45 f4             	mov    -0xc(%ebp),%eax
     603:	83 c0 08             	add    $0x8,%eax
     606:	eb 3b                	jmp    643 <malloc+0xe1>
        }
        if (p == freep)
     608:	a1 28 2a 00 00       	mov    0x2a28,%eax
     60d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     610:	75 1e                	jne    630 <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     612:	83 ec 0c             	sub    $0xc,%esp
     615:	ff 75 ec             	push   -0x14(%ebp)
     618:	e8 e5 fe ff ff       	call   502 <morecore>
     61d:	83 c4 10             	add    $0x10,%esp
     620:	89 45 f4             	mov    %eax,-0xc(%ebp)
     623:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     627:	75 07                	jne    630 <malloc+0xce>
     629:	b8 00 00 00 00       	mov    $0x0,%eax
     62e:	eb 13                	jmp    643 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	89 45 f0             	mov    %eax,-0x10(%ebp)
     636:	8b 45 f4             	mov    -0xc(%ebp),%eax
     639:	8b 00                	mov    (%eax),%eax
     63b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     63e:	e9 6d ff ff ff       	jmp    5b0 <malloc+0x4e>
    }
}
     643:	c9                   	leave  
     644:	c3                   	ret    

00000645 <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     645:	55                   	push   %ebp
     646:	89 e5                	mov    %esp,%ebp
     648:	83 ec 18             	sub    $0x18,%esp
     64b:	8b 45 0c             	mov    0xc(%ebp),%eax
     64e:	88 45 f4             	mov    %al,-0xc(%ebp)
     651:	83 ec 04             	sub    $0x4,%esp
     654:	6a 01                	push   $0x1
     656:	8d 45 f4             	lea    -0xc(%ebp),%eax
     659:	50                   	push   %eax
     65a:	ff 75 08             	push   0x8(%ebp)
     65d:	e8 c7 fa ff ff       	call   129 <write>
     662:	83 c4 10             	add    $0x10,%esp
     665:	90                   	nop
     666:	c9                   	leave  
     667:	c3                   	ret    

00000668 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     668:	55                   	push   %ebp
     669:	89 e5                	mov    %esp,%ebp
     66b:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     66e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     675:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     679:	74 17                	je     692 <printint+0x2a>
     67b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     67f:	79 11                	jns    692 <printint+0x2a>
        neg = 1;
     681:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     688:	8b 45 0c             	mov    0xc(%ebp),%eax
     68b:	f7 d8                	neg    %eax
     68d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     690:	eb 06                	jmp    698 <printint+0x30>
    } else {
        x = xx;
     692:	8b 45 0c             	mov    0xc(%ebp),%eax
     695:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     698:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     69f:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6a5:	ba 00 00 00 00       	mov    $0x0,%edx
     6aa:	f7 f1                	div    %ecx
     6ac:	89 d1                	mov    %edx,%ecx
     6ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b1:	8d 50 01             	lea    0x1(%eax),%edx
     6b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6b7:	0f b6 91 f0 29 00 00 	movzbl 0x29f0(%ecx),%edx
     6be:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     6c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6c8:	ba 00 00 00 00       	mov    $0x0,%edx
     6cd:	f7 f1                	div    %ecx
     6cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6d6:	75 c7                	jne    69f <printint+0x37>
    if (neg) buf[i++] = '-';
     6d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6dc:	74 2d                	je     70b <printint+0xa3>
     6de:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e1:	8d 50 01             	lea    0x1(%eax),%edx
     6e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6e7:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     6ec:	eb 1d                	jmp    70b <printint+0xa3>
     6ee:	8d 55 dc             	lea    -0x24(%ebp),%edx
     6f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f4:	01 d0                	add    %edx,%eax
     6f6:	0f b6 00             	movzbl (%eax),%eax
     6f9:	0f be c0             	movsbl %al,%eax
     6fc:	83 ec 08             	sub    $0x8,%esp
     6ff:	50                   	push   %eax
     700:	ff 75 08             	push   0x8(%ebp)
     703:	e8 3d ff ff ff       	call   645 <putc>
     708:	83 c4 10             	add    $0x10,%esp
     70b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     70f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     713:	79 d9                	jns    6ee <printint+0x86>
}
     715:	90                   	nop
     716:	90                   	nop
     717:	c9                   	leave  
     718:	c3                   	ret    

00000719 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     719:	55                   	push   %ebp
     71a:	89 e5                	mov    %esp,%ebp
     71c:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     71f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     726:	8d 45 0c             	lea    0xc(%ebp),%eax
     729:	83 c0 04             	add    $0x4,%eax
     72c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     72f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     736:	e9 59 01 00 00       	jmp    894 <printf+0x17b>
        c = fmt[i] & 0xff;
     73b:	8b 55 0c             	mov    0xc(%ebp),%edx
     73e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     741:	01 d0                	add    %edx,%eax
     743:	0f b6 00             	movzbl (%eax),%eax
     746:	0f be c0             	movsbl %al,%eax
     749:	25 ff 00 00 00       	and    $0xff,%eax
     74e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     751:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     755:	75 2c                	jne    783 <printf+0x6a>
            if (c == '%') {
     757:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     75b:	75 0c                	jne    769 <printf+0x50>
                state = '%';
     75d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     764:	e9 27 01 00 00       	jmp    890 <printf+0x177>
            } else {
                putc(fd, c);
     769:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     76c:	0f be c0             	movsbl %al,%eax
     76f:	83 ec 08             	sub    $0x8,%esp
     772:	50                   	push   %eax
     773:	ff 75 08             	push   0x8(%ebp)
     776:	e8 ca fe ff ff       	call   645 <putc>
     77b:	83 c4 10             	add    $0x10,%esp
     77e:	e9 0d 01 00 00       	jmp    890 <printf+0x177>
            }
        } else if (state == '%') {
     783:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     787:	0f 85 03 01 00 00    	jne    890 <printf+0x177>
            if (c == 'd') {
     78d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     791:	75 1e                	jne    7b1 <printf+0x98>
                printint(fd, *ap, 10, 1);
     793:	8b 45 e8             	mov    -0x18(%ebp),%eax
     796:	8b 00                	mov    (%eax),%eax
     798:	6a 01                	push   $0x1
     79a:	6a 0a                	push   $0xa
     79c:	50                   	push   %eax
     79d:	ff 75 08             	push   0x8(%ebp)
     7a0:	e8 c3 fe ff ff       	call   668 <printint>
     7a5:	83 c4 10             	add    $0x10,%esp
                ap++;
     7a8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7ac:	e9 d8 00 00 00       	jmp    889 <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     7b1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7b5:	74 06                	je     7bd <printf+0xa4>
     7b7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7bb:	75 1e                	jne    7db <printf+0xc2>
                printint(fd, *ap, 16, 0);
     7bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7c0:	8b 00                	mov    (%eax),%eax
     7c2:	6a 00                	push   $0x0
     7c4:	6a 10                	push   $0x10
     7c6:	50                   	push   %eax
     7c7:	ff 75 08             	push   0x8(%ebp)
     7ca:	e8 99 fe ff ff       	call   668 <printint>
     7cf:	83 c4 10             	add    $0x10,%esp
                ap++;
     7d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7d6:	e9 ae 00 00 00       	jmp    889 <printf+0x170>
            } else if (c == 's') {
     7db:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7df:	75 43                	jne    824 <printf+0x10b>
                s = (char*) *ap;
     7e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7e4:	8b 00                	mov    (%eax),%eax
     7e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     7e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     7ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7f1:	75 25                	jne    818 <printf+0xff>
     7f3:	c7 45 f4 10 20 00 00 	movl   $0x2010,-0xc(%ebp)
                while (*s != 0) {
     7fa:	eb 1c                	jmp    818 <printf+0xff>
                    putc(fd, *s);
     7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ff:	0f b6 00             	movzbl (%eax),%eax
     802:	0f be c0             	movsbl %al,%eax
     805:	83 ec 08             	sub    $0x8,%esp
     808:	50                   	push   %eax
     809:	ff 75 08             	push   0x8(%ebp)
     80c:	e8 34 fe ff ff       	call   645 <putc>
     811:	83 c4 10             	add    $0x10,%esp
                    s++;
     814:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     818:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81b:	0f b6 00             	movzbl (%eax),%eax
     81e:	84 c0                	test   %al,%al
     820:	75 da                	jne    7fc <printf+0xe3>
     822:	eb 65                	jmp    889 <printf+0x170>
                }
            } else if (c == 'c') {
     824:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     828:	75 1d                	jne    847 <printf+0x12e>
                putc(fd, *ap);
     82a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     82d:	8b 00                	mov    (%eax),%eax
     82f:	0f be c0             	movsbl %al,%eax
     832:	83 ec 08             	sub    $0x8,%esp
     835:	50                   	push   %eax
     836:	ff 75 08             	push   0x8(%ebp)
     839:	e8 07 fe ff ff       	call   645 <putc>
     83e:	83 c4 10             	add    $0x10,%esp
                ap++;
     841:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     845:	eb 42                	jmp    889 <printf+0x170>
            } else if (c == '%') {
     847:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     84b:	75 17                	jne    864 <printf+0x14b>
                putc(fd, c);
     84d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     850:	0f be c0             	movsbl %al,%eax
     853:	83 ec 08             	sub    $0x8,%esp
     856:	50                   	push   %eax
     857:	ff 75 08             	push   0x8(%ebp)
     85a:	e8 e6 fd ff ff       	call   645 <putc>
     85f:	83 c4 10             	add    $0x10,%esp
     862:	eb 25                	jmp    889 <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     864:	83 ec 08             	sub    $0x8,%esp
     867:	6a 25                	push   $0x25
     869:	ff 75 08             	push   0x8(%ebp)
     86c:	e8 d4 fd ff ff       	call   645 <putc>
     871:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     874:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     877:	0f be c0             	movsbl %al,%eax
     87a:	83 ec 08             	sub    $0x8,%esp
     87d:	50                   	push   %eax
     87e:	ff 75 08             	push   0x8(%ebp)
     881:	e8 bf fd ff ff       	call   645 <putc>
     886:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     889:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     890:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     894:	8b 55 0c             	mov    0xc(%ebp),%edx
     897:	8b 45 f0             	mov    -0x10(%ebp),%eax
     89a:	01 d0                	add    %edx,%eax
     89c:	0f b6 00             	movzbl (%eax),%eax
     89f:	84 c0                	test   %al,%al
     8a1:	0f 85 94 fe ff ff    	jne    73b <printf+0x22>
        }
    }
}
     8a7:	90                   	nop
     8a8:	90                   	nop
     8a9:	c9                   	leave  
     8aa:	c3                   	ret    

000008ab <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     8ab:	55                   	push   %ebp
     8ac:	89 e5                	mov    %esp,%ebp
     8ae:	83 ec 04             	sub    $0x4,%esp
     8b1:	8b 45 08             	mov    0x8(%ebp),%eax
     8b4:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     8b7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     8bb:	01 c0                	add    %eax,%eax
     8bd:	89 c1                	mov    %eax,%ecx
     8bf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     8c3:	c0 e8 07             	shr    $0x7,%al
     8c6:	89 c2                	mov    %eax,%edx
     8c8:	89 d0                	mov    %edx,%eax
     8ca:	01 c0                	add    %eax,%eax
     8cc:	01 d0                	add    %edx,%eax
     8ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     8d5:	01 d0                	add    %edx,%eax
     8d7:	31 c8                	xor    %ecx,%eax
}
     8d9:	c9                   	leave  
     8da:	c3                   	ret    

000008db <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     8db:	55                   	push   %ebp
     8dc:	89 e5                	mov    %esp,%ebp
     8de:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     8df:	bb 00 00 00 00       	mov    $0x0,%ebx
     8e4:	eb 24                	jmp    90a <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     8e6:	0f b6 d3             	movzbl %bl,%edx
     8e9:	8b 45 08             	mov    0x8(%ebp),%eax
     8ec:	01 d0                	add    %edx,%eax
     8ee:	0f b6 00             	movzbl (%eax),%eax
     8f1:	0f b6 c0             	movzbl %al,%eax
     8f4:	0f b6 cb             	movzbl %bl,%ecx
     8f7:	8b 55 08             	mov    0x8(%ebp),%edx
     8fa:	01 ca                	add    %ecx,%edx
     8fc:	0f b6 80 20 20 00 00 	movzbl 0x2020(%eax),%eax
     903:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     905:	89 d8                	mov    %ebx,%eax
     907:	8d 58 01             	lea    0x1(%eax),%ebx
     90a:	80 fb 0f             	cmp    $0xf,%bl
     90d:	76 d7                	jbe    8e6 <aes_subBytes+0xb>
    }
}
     90f:	90                   	nop
     910:	90                   	nop
     911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     914:	c9                   	leave  
     915:	c3                   	ret    

00000916 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     916:	55                   	push   %ebp
     917:	89 e5                	mov    %esp,%ebp
     919:	56                   	push   %esi
     91a:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     91b:	bb 00 00 00 00       	mov    $0x0,%ebx
     920:	eb 27                	jmp    949 <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     922:	0f b6 d3             	movzbl %bl,%edx
     925:	8b 45 08             	mov    0x8(%ebp),%eax
     928:	01 d0                	add    %edx,%eax
     92a:	0f b6 08             	movzbl (%eax),%ecx
     92d:	0f b6 d3             	movzbl %bl,%edx
     930:	8b 45 0c             	mov    0xc(%ebp),%eax
     933:	01 d0                	add    %edx,%eax
     935:	0f b6 10             	movzbl (%eax),%edx
     938:	0f b6 f3             	movzbl %bl,%esi
     93b:	8b 45 08             	mov    0x8(%ebp),%eax
     93e:	01 f0                	add    %esi,%eax
     940:	31 ca                	xor    %ecx,%edx
     942:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     944:	89 d8                	mov    %ebx,%eax
     946:	8d 58 01             	lea    0x1(%eax),%ebx
     949:	80 fb 0f             	cmp    $0xf,%bl
     94c:	76 d4                	jbe    922 <aes_addRoundKey+0xc>
    }
}
     94e:	90                   	nop
     94f:	90                   	nop
     950:	5b                   	pop    %ebx
     951:	5e                   	pop    %esi
     952:	5d                   	pop    %ebp
     953:	c3                   	ret    

00000954 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     954:	55                   	push   %ebp
     955:	89 e5                	mov    %esp,%ebp
     957:	56                   	push   %esi
     958:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     959:	bb 00 00 00 00       	mov    $0x0,%ebx
     95e:	eb 5b                	jmp    9bb <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     960:	0f b6 d3             	movzbl %bl,%edx
     963:	8b 45 0c             	mov    0xc(%ebp),%eax
     966:	01 d0                	add    %edx,%eax
     968:	0f b6 cb             	movzbl %bl,%ecx
     96b:	8b 55 10             	mov    0x10(%ebp),%edx
     96e:	01 ca                	add    %ecx,%edx
     970:	0f b6 00             	movzbl (%eax),%eax
     973:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     975:	0f b6 d3             	movzbl %bl,%edx
     978:	8b 45 08             	mov    0x8(%ebp),%eax
     97b:	01 d0                	add    %edx,%eax
     97d:	0f b6 08             	movzbl (%eax),%ecx
     980:	0f b6 d3             	movzbl %bl,%edx
     983:	8b 45 0c             	mov    0xc(%ebp),%eax
     986:	01 d0                	add    %edx,%eax
     988:	0f b6 10             	movzbl (%eax),%edx
     98b:	0f b6 f3             	movzbl %bl,%esi
     98e:	8b 45 08             	mov    0x8(%ebp),%eax
     991:	01 f0                	add    %esi,%eax
     993:	31 ca                	xor    %ecx,%edx
     995:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     997:	0f b6 c3             	movzbl %bl,%eax
     99a:	83 c0 10             	add    $0x10,%eax
     99d:	89 c2                	mov    %eax,%edx
     99f:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a2:	01 d0                	add    %edx,%eax
     9a4:	0f b6 d3             	movzbl %bl,%edx
     9a7:	83 c2 10             	add    $0x10,%edx
     9aa:	89 d1                	mov    %edx,%ecx
     9ac:	8b 55 10             	mov    0x10(%ebp),%edx
     9af:	01 ca                	add    %ecx,%edx
     9b1:	0f b6 00             	movzbl (%eax),%eax
     9b4:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     9b6:	89 d8                	mov    %ebx,%eax
     9b8:	8d 58 01             	lea    0x1(%eax),%ebx
     9bb:	80 fb 0f             	cmp    $0xf,%bl
     9be:	76 a0                	jbe    960 <aes_addRoundKey_cpy+0xc>
    }
}
     9c0:	90                   	nop
     9c1:	90                   	nop
     9c2:	5b                   	pop    %ebx
     9c3:	5e                   	pop    %esi
     9c4:	5d                   	pop    %ebp
     9c5:	c3                   	ret    

000009c6 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     9c6:	55                   	push   %ebp
     9c7:	89 e5                	mov    %esp,%ebp
     9c9:	53                   	push   %ebx
     9ca:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     9cd:	8b 45 08             	mov    0x8(%ebp),%eax
     9d0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     9d4:	8b 45 08             	mov    0x8(%ebp),%eax
     9d7:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     9db:	88 45 fb             	mov    %al,-0x5(%ebp)
     9de:	8b 45 08             	mov    0x8(%ebp),%eax
     9e1:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     9e5:	88 5d fa             	mov    %bl,-0x6(%ebp)
     9e8:	8b 45 08             	mov    0x8(%ebp),%eax
     9eb:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     9ef:	8b 45 08             	mov    0x8(%ebp),%eax
     9f2:	8d 50 01             	lea    0x1(%eax),%edx
     9f5:	8b 45 08             	mov    0x8(%ebp),%eax
     9f8:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     9fc:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     9fe:	8b 45 08             	mov    0x8(%ebp),%eax
     a01:	8d 50 05             	lea    0x5(%eax),%edx
     a04:	8b 45 08             	mov    0x8(%ebp),%eax
     a07:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     a0b:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     a0d:	8b 45 08             	mov    0x8(%ebp),%eax
     a10:	8d 50 09             	lea    0x9(%eax),%edx
     a13:	8b 45 08             	mov    0x8(%ebp),%eax
     a16:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     a1a:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     a1c:	8b 45 08             	mov    0x8(%ebp),%eax
     a1f:	83 c0 0d             	add    $0xd,%eax
     a22:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     a24:	8b 45 08             	mov    0x8(%ebp),%eax
     a27:	8d 50 03             	lea    0x3(%eax),%edx
     a2a:	8b 45 08             	mov    0x8(%ebp),%eax
     a2d:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     a31:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     a33:	8b 45 08             	mov    0x8(%ebp),%eax
     a36:	8d 50 0f             	lea    0xf(%eax),%edx
     a39:	8b 45 08             	mov    0x8(%ebp),%eax
     a3c:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     a40:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     a42:	8b 45 08             	mov    0x8(%ebp),%eax
     a45:	8d 50 0b             	lea    0xb(%eax),%edx
     a48:	8b 45 08             	mov    0x8(%ebp),%eax
     a4b:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     a4f:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     a51:	8b 45 08             	mov    0x8(%ebp),%eax
     a54:	83 c0 07             	add    $0x7,%eax
     a57:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     a5b:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     a5d:	8b 45 08             	mov    0x8(%ebp),%eax
     a60:	8d 50 0a             	lea    0xa(%eax),%edx
     a63:	8b 45 08             	mov    0x8(%ebp),%eax
     a66:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     a6a:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     a6c:	8b 45 08             	mov    0x8(%ebp),%eax
     a6f:	83 c0 02             	add    $0x2,%eax
     a72:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     a76:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     a78:	8b 45 08             	mov    0x8(%ebp),%eax
     a7b:	8d 50 0e             	lea    0xe(%eax),%edx
     a7e:	8b 45 08             	mov    0x8(%ebp),%eax
     a81:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     a85:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     a87:	8b 45 08             	mov    0x8(%ebp),%eax
     a8a:	83 c0 06             	add    $0x6,%eax
     a8d:	88 18                	mov    %bl,(%eax)
}
     a8f:	90                   	nop
     a90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a93:	c9                   	leave  
     a94:	c3                   	ret    

00000a95 <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     a95:	55                   	push   %ebp
     a96:	89 e5                	mov    %esp,%ebp
     a98:	56                   	push   %esi
     a99:	53                   	push   %ebx
     a9a:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     a9d:	bb 00 00 00 00       	mov    $0x0,%ebx
     aa2:	e9 42 01 00 00       	jmp    be9 <aes_mixColumns+0x154>
        a = buf[i];
     aa7:	0f b6 d3             	movzbl %bl,%edx
     aaa:	8b 45 08             	mov    0x8(%ebp),%eax
     aad:	01 d0                	add    %edx,%eax
     aaf:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     ab2:	0f b6 c3             	movzbl %bl,%eax
     ab5:	8d 50 01             	lea    0x1(%eax),%edx
     ab8:	8b 45 08             	mov    0x8(%ebp),%eax
     abb:	01 d0                	add    %edx,%eax
     abd:	0f b6 10             	movzbl (%eax),%edx
     ac0:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     ac3:	0f b6 c3             	movzbl %bl,%eax
     ac6:	8d 50 02             	lea    0x2(%eax),%edx
     ac9:	8b 45 08             	mov    0x8(%ebp),%eax
     acc:	01 d0                	add    %edx,%eax
     ace:	0f b6 00             	movzbl (%eax),%eax
     ad1:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     ad4:	0f b6 c3             	movzbl %bl,%eax
     ad7:	8d 50 03             	lea    0x3(%eax),%edx
     ada:	8b 45 08             	mov    0x8(%ebp),%eax
     add:	01 d0                	add    %edx,%eax
     adf:	0f b6 00             	movzbl (%eax),%eax
     ae2:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     ae5:	89 c8                	mov    %ecx,%eax
     ae7:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     aeb:	31 d0                	xor    %edx,%eax
     aed:	32 45 f6             	xor    -0xa(%ebp),%al
     af0:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     af4:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     af6:	88 4d f4             	mov    %cl,-0xc(%ebp)
     af9:	89 c8                	mov    %ecx,%eax
     afb:	88 55 f7             	mov    %dl,-0x9(%ebp)
     afe:	32 45 f7             	xor    -0x9(%ebp),%al
     b01:	0f b6 c0             	movzbl %al,%eax
     b04:	50                   	push   %eax
     b05:	e8 a1 fd ff ff       	call   8ab <rj_xtime>
     b0a:	83 c4 04             	add    $0x4,%esp
     b0d:	31 f0                	xor    %esi,%eax
     b0f:	0f b6 c8             	movzbl %al,%ecx
     b12:	0f b6 d3             	movzbl %bl,%edx
     b15:	8b 45 08             	mov    0x8(%ebp),%eax
     b18:	01 d0                	add    %edx,%eax
     b1a:	0f b6 00             	movzbl (%eax),%eax
     b1d:	89 c2                	mov    %eax,%edx
     b1f:	89 c8                	mov    %ecx,%eax
     b21:	89 d1                	mov    %edx,%ecx
     b23:	31 c1                	xor    %eax,%ecx
     b25:	0f b6 d3             	movzbl %bl,%edx
     b28:	8b 45 08             	mov    0x8(%ebp),%eax
     b2b:	01 c2                	add    %eax,%edx
     b2d:	89 c8                	mov    %ecx,%eax
     b2f:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     b31:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     b35:	32 55 f6             	xor    -0xa(%ebp),%dl
     b38:	89 d0                	mov    %edx,%eax
     b3a:	0f b6 c0             	movzbl %al,%eax
     b3d:	50                   	push   %eax
     b3e:	e8 68 fd ff ff       	call   8ab <rj_xtime>
     b43:	83 c4 04             	add    $0x4,%esp
     b46:	31 f0                	xor    %esi,%eax
     b48:	0f b6 c8             	movzbl %al,%ecx
     b4b:	0f b6 c3             	movzbl %bl,%eax
     b4e:	8d 50 01             	lea    0x1(%eax),%edx
     b51:	8b 45 08             	mov    0x8(%ebp),%eax
     b54:	01 d0                	add    %edx,%eax
     b56:	0f b6 00             	movzbl (%eax),%eax
     b59:	89 c2                	mov    %eax,%edx
     b5b:	89 c8                	mov    %ecx,%eax
     b5d:	31 c2                	xor    %eax,%edx
     b5f:	89 d1                	mov    %edx,%ecx
     b61:	0f b6 c3             	movzbl %bl,%eax
     b64:	8d 50 01             	lea    0x1(%eax),%edx
     b67:	8b 45 08             	mov    0x8(%ebp),%eax
     b6a:	01 c2                	add    %eax,%edx
     b6c:	89 c8                	mov    %ecx,%eax
     b6e:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     b70:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     b74:	32 45 f5             	xor    -0xb(%ebp),%al
     b77:	0f b6 c0             	movzbl %al,%eax
     b7a:	50                   	push   %eax
     b7b:	e8 2b fd ff ff       	call   8ab <rj_xtime>
     b80:	83 c4 04             	add    $0x4,%esp
     b83:	31 f0                	xor    %esi,%eax
     b85:	0f b6 d0             	movzbl %al,%edx
     b88:	0f b6 c3             	movzbl %bl,%eax
     b8b:	8d 48 02             	lea    0x2(%eax),%ecx
     b8e:	8b 45 08             	mov    0x8(%ebp),%eax
     b91:	01 c8                	add    %ecx,%eax
     b93:	0f b6 00             	movzbl (%eax),%eax
     b96:	89 c1                	mov    %eax,%ecx
     b98:	89 d0                	mov    %edx,%eax
     b9a:	89 ca                	mov    %ecx,%edx
     b9c:	31 c2                	xor    %eax,%edx
     b9e:	0f b6 c3             	movzbl %bl,%eax
     ba1:	8d 48 02             	lea    0x2(%eax),%ecx
     ba4:	8b 45 08             	mov    0x8(%ebp),%eax
     ba7:	01 c8                	add    %ecx,%eax
     ba9:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     bab:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     baf:	32 45 f4             	xor    -0xc(%ebp),%al
     bb2:	0f b6 c0             	movzbl %al,%eax
     bb5:	50                   	push   %eax
     bb6:	e8 f0 fc ff ff       	call   8ab <rj_xtime>
     bbb:	83 c4 04             	add    $0x4,%esp
     bbe:	31 f0                	xor    %esi,%eax
     bc0:	0f b6 d0             	movzbl %al,%edx
     bc3:	0f b6 c3             	movzbl %bl,%eax
     bc6:	8d 48 03             	lea    0x3(%eax),%ecx
     bc9:	8b 45 08             	mov    0x8(%ebp),%eax
     bcc:	01 c8                	add    %ecx,%eax
     bce:	0f b6 00             	movzbl (%eax),%eax
     bd1:	89 c1                	mov    %eax,%ecx
     bd3:	89 d0                	mov    %edx,%eax
     bd5:	31 c1                	xor    %eax,%ecx
     bd7:	89 ca                	mov    %ecx,%edx
     bd9:	0f b6 c3             	movzbl %bl,%eax
     bdc:	8d 48 03             	lea    0x3(%eax),%ecx
     bdf:	8b 45 08             	mov    0x8(%ebp),%eax
     be2:	01 c8                	add    %ecx,%eax
     be4:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     be6:	83 c3 04             	add    $0x4,%ebx
     be9:	80 fb 0f             	cmp    $0xf,%bl
     bec:	0f 86 b5 fe ff ff    	jbe    aa7 <aes_mixColumns+0x12>
    }
}
     bf2:	90                   	nop
     bf3:	90                   	nop
     bf4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bf7:	5b                   	pop    %ebx
     bf8:	5e                   	pop    %esi
     bf9:	5d                   	pop    %ebp
     bfa:	c3                   	ret    

00000bfb <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     bfb:	55                   	push   %ebp
     bfc:	89 e5                	mov    %esp,%ebp
     bfe:	56                   	push   %esi
     bff:	53                   	push   %ebx
     c00:	83 ec 04             	sub    $0x4,%esp
     c03:	8b 45 0c             	mov    0xc(%ebp),%eax
     c06:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     c09:	8b 45 08             	mov    0x8(%ebp),%eax
     c0c:	0f b6 10             	movzbl (%eax),%edx
     c0f:	8b 45 08             	mov    0x8(%ebp),%eax
     c12:	83 c0 1d             	add    $0x1d,%eax
     c15:	0f b6 00             	movzbl (%eax),%eax
     c18:	0f b6 c0             	movzbl %al,%eax
     c1b:	0f b6 80 20 20 00 00 	movzbl 0x2020(%eax),%eax
     c22:	32 45 f4             	xor    -0xc(%ebp),%al
     c25:	31 c2                	xor    %eax,%edx
     c27:	8b 45 08             	mov    0x8(%ebp),%eax
     c2a:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     c2c:	8b 45 08             	mov    0x8(%ebp),%eax
     c2f:	83 c0 01             	add    $0x1,%eax
     c32:	0f b6 08             	movzbl (%eax),%ecx
     c35:	8b 45 08             	mov    0x8(%ebp),%eax
     c38:	83 c0 1e             	add    $0x1e,%eax
     c3b:	0f b6 00             	movzbl (%eax),%eax
     c3e:	0f b6 c0             	movzbl %al,%eax
     c41:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     c48:	8b 45 08             	mov    0x8(%ebp),%eax
     c4b:	83 c0 01             	add    $0x1,%eax
     c4e:	31 ca                	xor    %ecx,%edx
     c50:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     c52:	8b 45 08             	mov    0x8(%ebp),%eax
     c55:	83 c0 02             	add    $0x2,%eax
     c58:	0f b6 08             	movzbl (%eax),%ecx
     c5b:	8b 45 08             	mov    0x8(%ebp),%eax
     c5e:	83 c0 1f             	add    $0x1f,%eax
     c61:	0f b6 00             	movzbl (%eax),%eax
     c64:	0f b6 c0             	movzbl %al,%eax
     c67:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     c6e:	8b 45 08             	mov    0x8(%ebp),%eax
     c71:	83 c0 02             	add    $0x2,%eax
     c74:	31 ca                	xor    %ecx,%edx
     c76:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	83 c0 03             	add    $0x3,%eax
     c7e:	0f b6 08             	movzbl (%eax),%ecx
     c81:	8b 45 08             	mov    0x8(%ebp),%eax
     c84:	83 c0 1c             	add    $0x1c,%eax
     c87:	0f b6 00             	movzbl (%eax),%eax
     c8a:	0f b6 c0             	movzbl %al,%eax
     c8d:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	83 c0 03             	add    $0x3,%eax
     c9a:	31 ca                	xor    %ecx,%edx
     c9c:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     c9e:	bb 04 00 00 00       	mov    $0x4,%ebx
     ca3:	e9 a9 00 00 00       	jmp    d51 <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     ca8:	0f b6 d3             	movzbl %bl,%edx
     cab:	8b 45 08             	mov    0x8(%ebp),%eax
     cae:	01 d0                	add    %edx,%eax
     cb0:	0f b6 08             	movzbl (%eax),%ecx
     cb3:	0f b6 c3             	movzbl %bl,%eax
     cb6:	8d 50 fc             	lea    -0x4(%eax),%edx
     cb9:	8b 45 08             	mov    0x8(%ebp),%eax
     cbc:	01 d0                	add    %edx,%eax
     cbe:	0f b6 10             	movzbl (%eax),%edx
     cc1:	0f b6 f3             	movzbl %bl,%esi
     cc4:	8b 45 08             	mov    0x8(%ebp),%eax
     cc7:	01 f0                	add    %esi,%eax
     cc9:	31 ca                	xor    %ecx,%edx
     ccb:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     ccd:	0f b6 c3             	movzbl %bl,%eax
     cd0:	8d 50 01             	lea    0x1(%eax),%edx
     cd3:	8b 45 08             	mov    0x8(%ebp),%eax
     cd6:	01 d0                	add    %edx,%eax
     cd8:	0f b6 08             	movzbl (%eax),%ecx
     cdb:	0f b6 c3             	movzbl %bl,%eax
     cde:	8d 50 fd             	lea    -0x3(%eax),%edx
     ce1:	8b 45 08             	mov    0x8(%ebp),%eax
     ce4:	01 d0                	add    %edx,%eax
     ce6:	0f b6 10             	movzbl (%eax),%edx
     ce9:	0f b6 c3             	movzbl %bl,%eax
     cec:	8d 70 01             	lea    0x1(%eax),%esi
     cef:	8b 45 08             	mov    0x8(%ebp),%eax
     cf2:	01 f0                	add    %esi,%eax
     cf4:	31 ca                	xor    %ecx,%edx
     cf6:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     cf8:	0f b6 c3             	movzbl %bl,%eax
     cfb:	8d 50 02             	lea    0x2(%eax),%edx
     cfe:	8b 45 08             	mov    0x8(%ebp),%eax
     d01:	01 d0                	add    %edx,%eax
     d03:	0f b6 08             	movzbl (%eax),%ecx
     d06:	0f b6 c3             	movzbl %bl,%eax
     d09:	8d 50 fe             	lea    -0x2(%eax),%edx
     d0c:	8b 45 08             	mov    0x8(%ebp),%eax
     d0f:	01 d0                	add    %edx,%eax
     d11:	0f b6 10             	movzbl (%eax),%edx
     d14:	0f b6 c3             	movzbl %bl,%eax
     d17:	8d 70 02             	lea    0x2(%eax),%esi
     d1a:	8b 45 08             	mov    0x8(%ebp),%eax
     d1d:	01 f0                	add    %esi,%eax
     d1f:	31 ca                	xor    %ecx,%edx
     d21:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     d23:	0f b6 c3             	movzbl %bl,%eax
     d26:	8d 50 03             	lea    0x3(%eax),%edx
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	01 d0                	add    %edx,%eax
     d2e:	0f b6 08             	movzbl (%eax),%ecx
     d31:	0f b6 c3             	movzbl %bl,%eax
     d34:	8d 50 ff             	lea    -0x1(%eax),%edx
     d37:	8b 45 08             	mov    0x8(%ebp),%eax
     d3a:	01 d0                	add    %edx,%eax
     d3c:	0f b6 10             	movzbl (%eax),%edx
     d3f:	0f b6 c3             	movzbl %bl,%eax
     d42:	8d 70 03             	lea    0x3(%eax),%esi
     d45:	8b 45 08             	mov    0x8(%ebp),%eax
     d48:	01 f0                	add    %esi,%eax
     d4a:	31 ca                	xor    %ecx,%edx
     d4c:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     d4e:	83 c3 04             	add    $0x4,%ebx
     d51:	80 fb 0f             	cmp    $0xf,%bl
     d54:	0f 86 4e ff ff ff    	jbe    ca8 <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     d5a:	8b 45 08             	mov    0x8(%ebp),%eax
     d5d:	83 c0 10             	add    $0x10,%eax
     d60:	0f b6 08             	movzbl (%eax),%ecx
     d63:	8b 45 08             	mov    0x8(%ebp),%eax
     d66:	83 c0 0c             	add    $0xc,%eax
     d69:	0f b6 00             	movzbl (%eax),%eax
     d6c:	0f b6 c0             	movzbl %al,%eax
     d6f:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     d76:	8b 45 08             	mov    0x8(%ebp),%eax
     d79:	83 c0 10             	add    $0x10,%eax
     d7c:	31 ca                	xor    %ecx,%edx
     d7e:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     d80:	8b 45 08             	mov    0x8(%ebp),%eax
     d83:	83 c0 11             	add    $0x11,%eax
     d86:	0f b6 08             	movzbl (%eax),%ecx
     d89:	8b 45 08             	mov    0x8(%ebp),%eax
     d8c:	83 c0 0d             	add    $0xd,%eax
     d8f:	0f b6 00             	movzbl (%eax),%eax
     d92:	0f b6 c0             	movzbl %al,%eax
     d95:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     d9c:	8b 45 08             	mov    0x8(%ebp),%eax
     d9f:	83 c0 11             	add    $0x11,%eax
     da2:	31 ca                	xor    %ecx,%edx
     da4:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	83 c0 12             	add    $0x12,%eax
     dac:	0f b6 08             	movzbl (%eax),%ecx
     daf:	8b 45 08             	mov    0x8(%ebp),%eax
     db2:	83 c0 0e             	add    $0xe,%eax
     db5:	0f b6 00             	movzbl (%eax),%eax
     db8:	0f b6 c0             	movzbl %al,%eax
     dbb:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	83 c0 12             	add    $0x12,%eax
     dc8:	31 ca                	xor    %ecx,%edx
     dca:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
     dcc:	8b 45 08             	mov    0x8(%ebp),%eax
     dcf:	83 c0 13             	add    $0x13,%eax
     dd2:	0f b6 08             	movzbl (%eax),%ecx
     dd5:	8b 45 08             	mov    0x8(%ebp),%eax
     dd8:	83 c0 0f             	add    $0xf,%eax
     ddb:	0f b6 00             	movzbl (%eax),%eax
     dde:	0f b6 c0             	movzbl %al,%eax
     de1:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     de8:	8b 45 08             	mov    0x8(%ebp),%eax
     deb:	83 c0 13             	add    $0x13,%eax
     dee:	31 ca                	xor    %ecx,%edx
     df0:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
     df2:	bb 14 00 00 00       	mov    $0x14,%ebx
     df7:	e9 a9 00 00 00       	jmp    ea5 <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
     dfc:	0f b6 d3             	movzbl %bl,%edx
     dff:	8b 45 08             	mov    0x8(%ebp),%eax
     e02:	01 d0                	add    %edx,%eax
     e04:	0f b6 08             	movzbl (%eax),%ecx
     e07:	0f b6 c3             	movzbl %bl,%eax
     e0a:	8d 50 fc             	lea    -0x4(%eax),%edx
     e0d:	8b 45 08             	mov    0x8(%ebp),%eax
     e10:	01 d0                	add    %edx,%eax
     e12:	0f b6 10             	movzbl (%eax),%edx
     e15:	0f b6 f3             	movzbl %bl,%esi
     e18:	8b 45 08             	mov    0x8(%ebp),%eax
     e1b:	01 f0                	add    %esi,%eax
     e1d:	31 ca                	xor    %ecx,%edx
     e1f:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     e21:	0f b6 c3             	movzbl %bl,%eax
     e24:	8d 50 01             	lea    0x1(%eax),%edx
     e27:	8b 45 08             	mov    0x8(%ebp),%eax
     e2a:	01 d0                	add    %edx,%eax
     e2c:	0f b6 08             	movzbl (%eax),%ecx
     e2f:	0f b6 c3             	movzbl %bl,%eax
     e32:	8d 50 fd             	lea    -0x3(%eax),%edx
     e35:	8b 45 08             	mov    0x8(%ebp),%eax
     e38:	01 d0                	add    %edx,%eax
     e3a:	0f b6 10             	movzbl (%eax),%edx
     e3d:	0f b6 c3             	movzbl %bl,%eax
     e40:	8d 70 01             	lea    0x1(%eax),%esi
     e43:	8b 45 08             	mov    0x8(%ebp),%eax
     e46:	01 f0                	add    %esi,%eax
     e48:	31 ca                	xor    %ecx,%edx
     e4a:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     e4c:	0f b6 c3             	movzbl %bl,%eax
     e4f:	8d 50 02             	lea    0x2(%eax),%edx
     e52:	8b 45 08             	mov    0x8(%ebp),%eax
     e55:	01 d0                	add    %edx,%eax
     e57:	0f b6 08             	movzbl (%eax),%ecx
     e5a:	0f b6 c3             	movzbl %bl,%eax
     e5d:	8d 50 fe             	lea    -0x2(%eax),%edx
     e60:	8b 45 08             	mov    0x8(%ebp),%eax
     e63:	01 d0                	add    %edx,%eax
     e65:	0f b6 10             	movzbl (%eax),%edx
     e68:	0f b6 c3             	movzbl %bl,%eax
     e6b:	8d 70 02             	lea    0x2(%eax),%esi
     e6e:	8b 45 08             	mov    0x8(%ebp),%eax
     e71:	01 f0                	add    %esi,%eax
     e73:	31 ca                	xor    %ecx,%edx
     e75:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     e77:	0f b6 c3             	movzbl %bl,%eax
     e7a:	8d 50 03             	lea    0x3(%eax),%edx
     e7d:	8b 45 08             	mov    0x8(%ebp),%eax
     e80:	01 d0                	add    %edx,%eax
     e82:	0f b6 08             	movzbl (%eax),%ecx
     e85:	0f b6 c3             	movzbl %bl,%eax
     e88:	8d 50 ff             	lea    -0x1(%eax),%edx
     e8b:	8b 45 08             	mov    0x8(%ebp),%eax
     e8e:	01 d0                	add    %edx,%eax
     e90:	0f b6 10             	movzbl (%eax),%edx
     e93:	0f b6 c3             	movzbl %bl,%eax
     e96:	8d 70 03             	lea    0x3(%eax),%esi
     e99:	8b 45 08             	mov    0x8(%ebp),%eax
     e9c:	01 f0                	add    %esi,%eax
     e9e:	31 ca                	xor    %ecx,%edx
     ea0:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
     ea2:	83 c3 04             	add    $0x4,%ebx
     ea5:	80 fb 1f             	cmp    $0x1f,%bl
     ea8:	0f 86 4e ff ff ff    	jbe    dfc <aes_expandEncKey+0x201>
    }
}
     eae:	90                   	nop
     eaf:	90                   	nop
     eb0:	83 c4 04             	add    $0x4,%esp
     eb3:	5b                   	pop    %ebx
     eb4:	5e                   	pop    %esi
     eb5:	5d                   	pop    %ebp
     eb6:	c3                   	ret    

00000eb7 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
     eb7:	55                   	push   %ebp
     eb8:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
     eba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     ebe:	74 4d                	je     f0d <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
     ec0:	8b 45 08             	mov    0x8(%ebp),%eax
     ec3:	83 c0 03             	add    $0x3,%eax
     ec6:	0f b6 10             	movzbl (%eax),%edx
     ec9:	83 c2 01             	add    $0x1,%edx
     ecc:	88 10                	mov    %dl,(%eax)
     ece:	0f b6 00             	movzbl (%eax),%eax
     ed1:	84 c0                	test   %al,%al
     ed3:	75 38                	jne    f0d <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	83 c0 02             	add    $0x2,%eax
     edb:	0f b6 10             	movzbl (%eax),%edx
     ede:	83 c2 01             	add    $0x1,%edx
     ee1:	88 10                	mov    %dl,(%eax)
     ee3:	0f b6 00             	movzbl (%eax),%eax
     ee6:	84 c0                	test   %al,%al
     ee8:	75 23                	jne    f0d <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
     eea:	8b 45 08             	mov    0x8(%ebp),%eax
     eed:	83 c0 01             	add    $0x1,%eax
     ef0:	0f b6 10             	movzbl (%eax),%edx
     ef3:	83 c2 01             	add    $0x1,%edx
     ef6:	88 10                	mov    %dl,(%eax)
     ef8:	0f b6 00             	movzbl (%eax),%eax
     efb:	84 c0                	test   %al,%al
     efd:	75 0e                	jne    f0d <ctr_inc_ctr+0x56>
                    val[0]++;
     eff:	8b 45 08             	mov    0x8(%ebp),%eax
     f02:	0f b6 00             	movzbl (%eax),%eax
     f05:	8d 50 01             	lea    0x1(%eax),%edx
     f08:	8b 45 08             	mov    0x8(%ebp),%eax
     f0b:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
     f0d:	90                   	nop
     f0e:	5d                   	pop    %ebp
     f0f:	c3                   	ret    

00000f10 <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
     f16:	8b 45 08             	mov    0x8(%ebp),%eax
     f19:	83 c0 40             	add    $0x40,%eax
     f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
     f1f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f23:	74 56                	je     f7b <ctr_clock_keystream+0x6b>
     f25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f29:	74 50                	je     f7b <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f2b:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
     f2f:	eb 21                	jmp    f52 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
     f31:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     f35:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f38:	01 d0                	add    %edx,%eax
     f3a:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
     f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
     f41:	01 ca                	add    %ecx,%edx
     f43:	0f b6 00             	movzbl (%eax),%eax
     f46:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f48:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     f4c:	83 c0 01             	add    $0x1,%eax
     f4f:	88 45 f7             	mov    %al,-0x9(%ebp)
     f52:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
     f56:	76 d9                	jbe    f31 <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
     f58:	83 ec 08             	sub    $0x8,%esp
     f5b:	ff 75 0c             	push   0xc(%ebp)
     f5e:	ff 75 08             	push   0x8(%ebp)
     f61:	e8 16 01 00 00       	call   107c <aes256_encrypt_ecb>
     f66:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
     f69:	8b 45 08             	mov    0x8(%ebp),%eax
     f6c:	83 c0 4c             	add    $0x4c,%eax
     f6f:	83 ec 0c             	sub    $0xc,%esp
     f72:	50                   	push   %eax
     f73:	e8 3f ff ff ff       	call   eb7 <ctr_inc_ctr>
     f78:	83 c4 10             	add    $0x10,%esp
    }
}
     f7b:	90                   	nop
     f7c:	c9                   	leave  
     f7d:	c3                   	ret    

00000f7e <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
     f7e:	55                   	push   %ebp
     f7f:	89 e5                	mov    %esp,%ebp
     f81:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
     f84:	8b 45 0c             	mov    0xc(%ebp),%eax
     f87:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
     f8a:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
     f91:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
     f98:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
     f9f:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
     fa6:	83 ec 08             	sub    $0x8,%esp
     fa9:	ff 75 08             	push   0x8(%ebp)
     fac:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     faf:	50                   	push   %eax
     fb0:	e8 2e 00 00 00       	call   fe3 <aes256_init>
     fb5:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
     fb8:	83 ec 08             	sub    $0x8,%esp
     fbb:	8d 45 94             	lea    -0x6c(%ebp),%eax
     fbe:	50                   	push   %eax
     fbf:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fc2:	50                   	push   %eax
     fc3:	e8 8d 01 00 00       	call   1155 <aes256_setCtrBlk>
     fc8:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
     fcb:	83 ec 04             	sub    $0x4,%esp
     fce:	ff 75 10             	push   0x10(%ebp)
     fd1:	ff 75 f4             	push   -0xc(%ebp)
     fd4:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fd7:	50                   	push   %eax
     fd8:	e8 c9 01 00 00       	call   11a6 <aes256_encrypt_ctr>
     fdd:	83 c4 10             	add    $0x10,%esp
}
     fe0:	90                   	nop
     fe1:	c9                   	leave  
     fe2:	c3                   	ret    

00000fe3 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
     fe3:	55                   	push   %ebp
     fe4:	89 e5                	mov    %esp,%ebp
     fe6:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
     fe7:	bb 00 00 00 00       	mov    $0x0,%ebx
     fec:	eb 1a                	jmp    1008 <aes256_init+0x25>
        ctx->enckey[i] = key[i];
     fee:	0f b6 d3             	movzbl %bl,%edx
     ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff4:	01 c2                	add    %eax,%edx
     ff6:	0f b6 c3             	movzbl %bl,%eax
     ff9:	0f b6 0a             	movzbl (%edx),%ecx
     ffc:	8b 55 08             	mov    0x8(%ebp),%edx
     fff:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1003:	89 d8                	mov    %ebx,%eax
    1005:	8d 58 01             	lea    0x1(%eax),%ebx
    1008:	80 fb 1f             	cmp    $0x1f,%bl
    100b:	76 e1                	jbe    fee <aes256_init+0xb>
    }
}
    100d:	90                   	nop
    100e:	90                   	nop
    100f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1012:	c9                   	leave  
    1013:	c3                   	ret    

00001014 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    1014:	55                   	push   %ebp
    1015:	89 e5                	mov    %esp,%ebp
    1017:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1018:	bb 00 00 00 00       	mov    $0x0,%ebx
    101d:	eb 51                	jmp    1070 <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    101f:	0f b6 c3             	movzbl %bl,%eax
    1022:	8b 55 08             	mov    0x8(%ebp),%edx
    1025:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    102a:	0f b6 d3             	movzbl %bl,%edx
    102d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1030:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    1035:	8b 45 08             	mov    0x8(%ebp),%eax
    1038:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    103b:	0f b6 c3             	movzbl %bl,%eax
    103e:	83 e0 03             	and    $0x3,%eax
    1041:	89 c2                	mov    %eax,%edx
    1043:	8b 45 08             	mov    0x8(%ebp),%eax
    1046:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    104b:	0f b6 c3             	movzbl %bl,%eax
    104e:	83 e0 07             	and    $0x7,%eax
    1051:	89 c2                	mov    %eax,%edx
    1053:	8b 45 08             	mov    0x8(%ebp),%eax
    1056:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    105b:	0f b6 c3             	movzbl %bl,%eax
    105e:	83 e0 03             	and    $0x3,%eax
    1061:	89 c2                	mov    %eax,%edx
    1063:	8b 45 08             	mov    0x8(%ebp),%eax
    1066:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    106b:	89 d8                	mov    %ebx,%eax
    106d:	8d 58 01             	lea    0x1(%eax),%ebx
    1070:	80 fb 1f             	cmp    $0x1f,%bl
    1073:	76 aa                	jbe    101f <aes256_done+0xb>
    }
}
    1075:	90                   	nop
    1076:	90                   	nop
    1077:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    107a:	c9                   	leave  
    107b:	c3                   	ret    

0000107c <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
    107f:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    1082:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    1086:	8b 45 08             	mov    0x8(%ebp),%eax
    1089:	8b 55 08             	mov    0x8(%ebp),%edx
    108c:	83 c2 20             	add    $0x20,%edx
    108f:	50                   	push   %eax
    1090:	52                   	push   %edx
    1091:	ff 75 0c             	push   0xc(%ebp)
    1094:	e8 bb f8 ff ff       	call   954 <aes_addRoundKey_cpy>
    1099:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    109c:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    10a0:	eb 74                	jmp    1116 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    10a2:	ff 75 0c             	push   0xc(%ebp)
    10a5:	e8 31 f8 ff ff       	call   8db <aes_subBytes>
    10aa:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    10ad:	ff 75 0c             	push   0xc(%ebp)
    10b0:	e8 11 f9 ff ff       	call   9c6 <aes_shiftRows>
    10b5:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    10b8:	ff 75 0c             	push   0xc(%ebp)
    10bb:	e8 d5 f9 ff ff       	call   a95 <aes_mixColumns>
    10c0:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    10c3:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    10c7:	83 e0 01             	and    $0x1,%eax
    10ca:	85 c0                	test   %eax,%eax
    10cc:	74 14                	je     10e2 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	83 c0 10             	add    $0x10,%eax
    10d4:	50                   	push   %eax
    10d5:	ff 75 0c             	push   0xc(%ebp)
    10d8:	e8 39 f8 ff ff       	call   916 <aes_addRoundKey>
    10dd:	83 c4 08             	add    $0x8,%esp
    10e0:	eb 30                	jmp    1112 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    10e2:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    10e6:	8b 45 08             	mov    0x8(%ebp),%eax
    10e9:	52                   	push   %edx
    10ea:	50                   	push   %eax
    10eb:	e8 0b fb ff ff       	call   bfb <aes_expandEncKey>
    10f0:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    10f3:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    10f7:	50                   	push   %eax
    10f8:	e8 ae f7 ff ff       	call   8ab <rj_xtime>
    10fd:	83 c4 04             	add    $0x4,%esp
    1100:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    1103:	8b 45 08             	mov    0x8(%ebp),%eax
    1106:	50                   	push   %eax
    1107:	ff 75 0c             	push   0xc(%ebp)
    110a:	e8 07 f8 ff ff       	call   916 <aes_addRoundKey>
    110f:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    1112:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    1116:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    111a:	76 86                	jbe    10a2 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    111c:	ff 75 0c             	push   0xc(%ebp)
    111f:	e8 b7 f7 ff ff       	call   8db <aes_subBytes>
    1124:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    1127:	ff 75 0c             	push   0xc(%ebp)
    112a:	e8 97 f8 ff ff       	call   9c6 <aes_shiftRows>
    112f:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    1132:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1136:	8b 45 08             	mov    0x8(%ebp),%eax
    1139:	52                   	push   %edx
    113a:	50                   	push   %eax
    113b:	e8 bb fa ff ff       	call   bfb <aes_expandEncKey>
    1140:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	50                   	push   %eax
    1147:	ff 75 0c             	push   0xc(%ebp)
    114a:	e8 c7 f7 ff ff       	call   916 <aes_addRoundKey>
    114f:	83 c4 08             	add    $0x8,%esp
}
    1152:	90                   	nop
    1153:	c9                   	leave  
    1154:	c3                   	ret    

00001155 <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    1155:	55                   	push   %ebp
    1156:	89 e5                	mov    %esp,%ebp
    1158:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    115b:	8b 45 08             	mov    0x8(%ebp),%eax
    115e:	83 c0 40             	add    $0x40,%eax
    1161:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    1164:	8b 45 0c             	mov    0xc(%ebp),%eax
    1167:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    116a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    116e:	74 33                	je     11a3 <aes256_setCtrBlk+0x4e>
    1170:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1174:	74 2d                	je     11a3 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1176:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    117a:	eb 21                	jmp    119d <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    117c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1180:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1183:	01 d0                	add    %edx,%eax
    1185:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    1189:	8b 55 f8             	mov    -0x8(%ebp),%edx
    118c:	01 ca                	add    %ecx,%edx
    118e:	0f b6 00             	movzbl (%eax),%eax
    1191:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1193:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1197:	83 c0 01             	add    $0x1,%eax
    119a:	88 45 ff             	mov    %al,-0x1(%ebp)
    119d:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    11a1:	76 d9                	jbe    117c <aes256_setCtrBlk+0x27>
        }
    }
}
    11a3:	90                   	nop
    11a4:	c9                   	leave  
    11a5:	c3                   	ret    

000011a6 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    11a6:	55                   	push   %ebp
    11a7:	89 e5                	mov    %esp,%ebp
    11a9:	53                   	push   %ebx
    11aa:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    11ad:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    11b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11b8:	eb 49                	jmp    1203 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    11ba:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    11be:	75 16                	jne    11d6 <aes256_encrypt_ctr+0x30>
            j = 0;
    11c0:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    11c4:	83 ec 08             	sub    $0x8,%esp
    11c7:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    11ca:	50                   	push   %eax
    11cb:	ff 75 08             	push   0x8(%ebp)
    11ce:	e8 3d fd ff ff       	call   f10 <ctr_clock_keystream>
    11d3:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    11d6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    11da:	8d 50 01             	lea    0x1(%eax),%edx
    11dd:	88 55 f3             	mov    %dl,-0xd(%ebp)
    11e0:	0f b6 c0             	movzbl %al,%eax
    11e3:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    11e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    11eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ee:	01 d0                	add    %edx,%eax
    11f0:	0f b6 10             	movzbl (%eax),%edx
    11f3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    11f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11f9:	01 d8                	add    %ebx,%eax
    11fb:	31 ca                	xor    %ecx,%edx
    11fd:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    11ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1203:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1206:	3b 45 10             	cmp    0x10(%ebp),%eax
    1209:	72 af                	jb     11ba <aes256_encrypt_ctr+0x14>
    }
}
    120b:	90                   	nop
    120c:	90                   	nop
    120d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1210:	c9                   	leave  
    1211:	c3                   	ret    

00001212 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    1212:	55                   	push   %ebp
    1213:	89 e5                	mov    %esp,%ebp
    1215:	8b 45 0c             	mov    0xc(%ebp),%eax
    1218:	83 e0 1f             	and    $0x1f,%eax
    121b:	8b 55 08             	mov    0x8(%ebp),%edx
    121e:	89 c1                	mov    %eax,%ecx
    1220:	d3 ea                	shr    %cl,%edx
    1222:	89 d0                	mov    %edx,%eax
    1224:	5d                   	pop    %ebp
    1225:	c3                   	ret    

00001226 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    1226:	55                   	push   %ebp
    1227:	89 e5                	mov    %esp,%ebp
    1229:	8b 45 0c             	mov    0xc(%ebp),%eax
    122c:	83 e0 1f             	and    $0x1f,%eax
    122f:	8b 55 08             	mov    0x8(%ebp),%edx
    1232:	89 c1                	mov    %eax,%ecx
    1234:	d3 e2                	shl    %cl,%edx
    1236:	89 d0                	mov    %edx,%eax
    1238:	5d                   	pop    %ebp
    1239:	c3                   	ret    

0000123a <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    123a:	55                   	push   %ebp
    123b:	89 e5                	mov    %esp,%ebp
    123d:	53                   	push   %ebx
    123e:	83 ec 04             	sub    $0x4,%esp
    1241:	8b 45 0c             	mov    0xc(%ebp),%eax
    1244:	88 45 f8             	mov    %al,-0x8(%ebp)
    1247:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    124b:	8b 55 08             	mov    0x8(%ebp),%edx
    124e:	89 d3                	mov    %edx,%ebx
    1250:	89 c1                	mov    %eax,%ecx
    1252:	d3 eb                	shr    %cl,%ebx
    1254:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    1258:	b8 20 00 00 00       	mov    $0x20,%eax
    125d:	29 d0                	sub    %edx,%eax
    125f:	50                   	push   %eax
    1260:	ff 75 08             	push   0x8(%ebp)
    1263:	e8 be ff ff ff       	call   1226 <_shw>
    1268:	83 c4 08             	add    $0x8,%esp
    126b:	09 d8                	or     %ebx,%eax
    126d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1270:	c9                   	leave  
    1271:	c3                   	ret    

00001272 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    1272:	55                   	push   %ebp
    1273:	89 e5                	mov    %esp,%ebp
    1275:	8b 45 08             	mov    0x8(%ebp),%eax
    1278:	23 45 0c             	and    0xc(%ebp),%eax
    127b:	89 c2                	mov    %eax,%edx
    127d:	8b 45 08             	mov    0x8(%ebp),%eax
    1280:	f7 d0                	not    %eax
    1282:	23 45 10             	and    0x10(%ebp),%eax
    1285:	31 d0                	xor    %edx,%eax
    1287:	5d                   	pop    %ebp
    1288:	c3                   	ret    

00001289 <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    1289:	55                   	push   %ebp
    128a:	89 e5                	mov    %esp,%ebp
    128c:	8b 45 0c             	mov    0xc(%ebp),%eax
    128f:	33 45 10             	xor    0x10(%ebp),%eax
    1292:	23 45 08             	and    0x8(%ebp),%eax
    1295:	89 c2                	mov    %eax,%edx
    1297:	8b 45 0c             	mov    0xc(%ebp),%eax
    129a:	23 45 10             	and    0x10(%ebp),%eax
    129d:	31 d0                	xor    %edx,%eax
    129f:	5d                   	pop    %ebp
    12a0:	c3                   	ret    

000012a1 <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    12a1:	55                   	push   %ebp
    12a2:	89 e5                	mov    %esp,%ebp
    12a4:	53                   	push   %ebx
    12a5:	6a 02                	push   $0x2
    12a7:	ff 75 08             	push   0x8(%ebp)
    12aa:	e8 8b ff ff ff       	call   123a <_r>
    12af:	83 c4 08             	add    $0x8,%esp
    12b2:	89 c3                	mov    %eax,%ebx
    12b4:	6a 0d                	push   $0xd
    12b6:	ff 75 08             	push   0x8(%ebp)
    12b9:	e8 7c ff ff ff       	call   123a <_r>
    12be:	83 c4 08             	add    $0x8,%esp
    12c1:	31 c3                	xor    %eax,%ebx
    12c3:	6a 16                	push   $0x16
    12c5:	ff 75 08             	push   0x8(%ebp)
    12c8:	e8 6d ff ff ff       	call   123a <_r>
    12cd:	83 c4 08             	add    $0x8,%esp
    12d0:	31 d8                	xor    %ebx,%eax
    12d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12d5:	c9                   	leave  
    12d6:	c3                   	ret    

000012d7 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    12d7:	55                   	push   %ebp
    12d8:	89 e5                	mov    %esp,%ebp
    12da:	53                   	push   %ebx
    12db:	6a 06                	push   $0x6
    12dd:	ff 75 08             	push   0x8(%ebp)
    12e0:	e8 55 ff ff ff       	call   123a <_r>
    12e5:	83 c4 08             	add    $0x8,%esp
    12e8:	89 c3                	mov    %eax,%ebx
    12ea:	6a 0b                	push   $0xb
    12ec:	ff 75 08             	push   0x8(%ebp)
    12ef:	e8 46 ff ff ff       	call   123a <_r>
    12f4:	83 c4 08             	add    $0x8,%esp
    12f7:	31 c3                	xor    %eax,%ebx
    12f9:	6a 19                	push   $0x19
    12fb:	ff 75 08             	push   0x8(%ebp)
    12fe:	e8 37 ff ff ff       	call   123a <_r>
    1303:	83 c4 08             	add    $0x8,%esp
    1306:	31 d8                	xor    %ebx,%eax
    1308:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    130b:	c9                   	leave  
    130c:	c3                   	ret    

0000130d <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    130d:	55                   	push   %ebp
    130e:	89 e5                	mov    %esp,%ebp
    1310:	53                   	push   %ebx
    1311:	6a 07                	push   $0x7
    1313:	ff 75 08             	push   0x8(%ebp)
    1316:	e8 1f ff ff ff       	call   123a <_r>
    131b:	83 c4 08             	add    $0x8,%esp
    131e:	89 c3                	mov    %eax,%ebx
    1320:	6a 12                	push   $0x12
    1322:	ff 75 08             	push   0x8(%ebp)
    1325:	e8 10 ff ff ff       	call   123a <_r>
    132a:	83 c4 08             	add    $0x8,%esp
    132d:	89 da                	mov    %ebx,%edx
    132f:	31 c2                	xor    %eax,%edx
    1331:	8b 45 08             	mov    0x8(%ebp),%eax
    1334:	c1 e8 03             	shr    $0x3,%eax
    1337:	31 d0                	xor    %edx,%eax
    1339:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    133c:	c9                   	leave  
    133d:	c3                   	ret    

0000133e <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    133e:	55                   	push   %ebp
    133f:	89 e5                	mov    %esp,%ebp
    1341:	53                   	push   %ebx
    1342:	6a 11                	push   $0x11
    1344:	ff 75 08             	push   0x8(%ebp)
    1347:	e8 ee fe ff ff       	call   123a <_r>
    134c:	83 c4 08             	add    $0x8,%esp
    134f:	89 c3                	mov    %eax,%ebx
    1351:	6a 13                	push   $0x13
    1353:	ff 75 08             	push   0x8(%ebp)
    1356:	e8 df fe ff ff       	call   123a <_r>
    135b:	83 c4 08             	add    $0x8,%esp
    135e:	89 da                	mov    %ebx,%edx
    1360:	31 c2                	xor    %eax,%edx
    1362:	8b 45 08             	mov    0x8(%ebp),%eax
    1365:	c1 e8 0a             	shr    $0xa,%eax
    1368:	31 d0                	xor    %edx,%eax
    136a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    136d:	c9                   	leave  
    136e:	c3                   	ret    

0000136f <_word>:

FN_ uint _word(uchar* c) {
    136f:	55                   	push   %ebp
    1370:	89 e5                	mov    %esp,%ebp
    1372:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    1373:	8b 45 08             	mov    0x8(%ebp),%eax
    1376:	0f b6 00             	movzbl (%eax),%eax
    1379:	0f b6 c0             	movzbl %al,%eax
    137c:	6a 18                	push   $0x18
    137e:	50                   	push   %eax
    137f:	e8 a2 fe ff ff       	call   1226 <_shw>
    1384:	83 c4 08             	add    $0x8,%esp
    1387:	89 c3                	mov    %eax,%ebx
    1389:	8b 45 08             	mov    0x8(%ebp),%eax
    138c:	83 c0 01             	add    $0x1,%eax
    138f:	0f b6 00             	movzbl (%eax),%eax
    1392:	0f b6 c0             	movzbl %al,%eax
    1395:	6a 10                	push   $0x10
    1397:	50                   	push   %eax
    1398:	e8 89 fe ff ff       	call   1226 <_shw>
    139d:	83 c4 08             	add    $0x8,%esp
    13a0:	09 c3                	or     %eax,%ebx
    13a2:	8b 45 08             	mov    0x8(%ebp),%eax
    13a5:	83 c0 02             	add    $0x2,%eax
    13a8:	0f b6 00             	movzbl (%eax),%eax
    13ab:	0f b6 c0             	movzbl %al,%eax
    13ae:	6a 08                	push   $0x8
    13b0:	50                   	push   %eax
    13b1:	e8 70 fe ff ff       	call   1226 <_shw>
    13b6:	83 c4 08             	add    $0x8,%esp
    13b9:	89 da                	mov    %ebx,%edx
    13bb:	09 c2                	or     %eax,%edx
    13bd:	8b 45 08             	mov    0x8(%ebp),%eax
    13c0:	83 c0 03             	add    $0x3,%eax
    13c3:	0f b6 00             	movzbl (%eax),%eax
    13c6:	0f b6 c0             	movzbl %al,%eax
    13c9:	09 d0                	or     %edx,%eax
}
    13cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13ce:	c9                   	leave  
    13cf:	c3                   	ret    

000013d0 <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	8b 40 60             	mov    0x60(%eax),%eax
    13d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    13dc:	f7 d2                	not    %edx
    13de:	39 d0                	cmp    %edx,%eax
    13e0:	76 0f                	jbe    13f1 <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    13e2:	8b 45 08             	mov    0x8(%ebp),%eax
    13e5:	8b 40 64             	mov    0x64(%eax),%eax
    13e8:	8d 50 01             	lea    0x1(%eax),%edx
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    13f1:	8b 45 08             	mov    0x8(%ebp),%eax
    13f4:	8b 50 60             	mov    0x60(%eax),%edx
    13f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fa:	01 c2                	add    %eax,%edx
    13fc:	8b 45 08             	mov    0x8(%ebp),%eax
    13ff:	89 50 60             	mov    %edx,0x60(%eax)
}
    1402:	90                   	nop
    1403:	5d                   	pop    %ebp
    1404:	c3                   	ret    

00001405 <_hash>:

static void _hash(sha256_context* ctx) {
    1405:	55                   	push   %ebp
    1406:	89 e5                	mov    %esp,%ebp
    1408:	57                   	push   %edi
    1409:	56                   	push   %esi
    140a:	53                   	push   %ebx
    140b:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    140e:	8b 45 08             	mov    0x8(%ebp),%eax
    1411:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    1414:	8b 45 08             	mov    0x8(%ebp),%eax
    1417:	8b 40 44             	mov    0x44(%eax),%eax
    141a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    141d:	8b 45 08             	mov    0x8(%ebp),%eax
    1420:	8b 40 48             	mov    0x48(%eax),%eax
    1423:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    1426:	8b 45 08             	mov    0x8(%ebp),%eax
    1429:	8b 40 4c             	mov    0x4c(%eax),%eax
    142c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    1435:	8b 45 08             	mov    0x8(%ebp),%eax
    1438:	8b 40 54             	mov    0x54(%eax),%eax
    143b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    143e:	8b 45 08             	mov    0x8(%ebp),%eax
    1441:	8b 40 58             	mov    0x58(%eax),%eax
    1444:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    1447:	8b 45 08             	mov    0x8(%ebp),%eax
    144a:	8b 40 5c             	mov    0x5c(%eax),%eax
    144d:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    1450:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1457:	e9 27 01 00 00       	jmp    1583 <_hash+0x17e>
        if (i < 16) {
    145c:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    1460:	77 2d                	ja     148f <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    1462:	6a 02                	push   $0x2
    1464:	ff 75 f0             	push   -0x10(%ebp)
    1467:	e8 ba fd ff ff       	call   1226 <_shw>
    146c:	83 c4 08             	add    $0x8,%esp
    146f:	89 c2                	mov    %eax,%edx
    1471:	8b 45 08             	mov    0x8(%ebp),%eax
    1474:	01 d0                	add    %edx,%eax
    1476:	50                   	push   %eax
    1477:	e8 f3 fe ff ff       	call   136f <_word>
    147c:	83 c4 04             	add    $0x4,%esp
    147f:	89 c1                	mov    %eax,%ecx
    1481:	8b 55 08             	mov    0x8(%ebp),%edx
    1484:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1487:	83 c0 1c             	add    $0x1c,%eax
    148a:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    148d:	eb 64                	jmp    14f3 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    148f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1492:	83 e8 02             	sub    $0x2,%eax
    1495:	8b 55 08             	mov    0x8(%ebp),%edx
    1498:	83 c0 1c             	add    $0x1c,%eax
    149b:	8b 04 82             	mov    (%edx,%eax,4),%eax
    149e:	50                   	push   %eax
    149f:	e8 9a fe ff ff       	call   133e <_G1>
    14a4:	83 c4 04             	add    $0x4,%esp
    14a7:	89 c1                	mov    %eax,%ecx
    14a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ac:	83 e8 07             	sub    $0x7,%eax
    14af:	8b 55 08             	mov    0x8(%ebp),%edx
    14b2:	83 c0 1c             	add    $0x1c,%eax
    14b5:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14b8:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    14bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14be:	83 e8 0f             	sub    $0xf,%eax
    14c1:	8b 55 08             	mov    0x8(%ebp),%edx
    14c4:	83 c0 1c             	add    $0x1c,%eax
    14c7:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14ca:	50                   	push   %eax
    14cb:	e8 3d fe ff ff       	call   130d <_G0>
    14d0:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    14d3:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    14d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14d9:	83 e8 10             	sub    $0x10,%eax
    14dc:	8b 55 08             	mov    0x8(%ebp),%edx
    14df:	83 c0 1c             	add    $0x1c,%eax
    14e2:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14e5:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    14e7:	8b 55 08             	mov    0x8(%ebp),%edx
    14ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ed:	83 c0 1c             	add    $0x1c,%eax
    14f0:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    14f3:	57                   	push   %edi
    14f4:	e8 de fd ff ff       	call   12d7 <_S1>
    14f9:	83 c4 04             	add    $0x4,%esp
    14fc:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    14ff:	01 c3                	add    %eax,%ebx
    1501:	ff 75 d4             	push   -0x2c(%ebp)
    1504:	ff 75 d8             	push   -0x28(%ebp)
    1507:	57                   	push   %edi
    1508:	e8 65 fd ff ff       	call   1272 <_Ch>
    150d:	83 c4 0c             	add    $0xc,%esp
    1510:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    1513:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1516:	8b 04 85 20 21 00 00 	mov    0x2120(,%eax,4),%eax
    151d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1520:	8b 55 08             	mov    0x8(%ebp),%edx
    1523:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1526:	83 c0 1c             	add    $0x1c,%eax
    1529:	8b 04 82             	mov    (%edx,%eax,4),%eax
    152c:	01 c8                	add    %ecx,%eax
    152e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    1531:	56                   	push   %esi
    1532:	e8 6a fd ff ff       	call   12a1 <_S0>
    1537:	83 c4 04             	add    $0x4,%esp
    153a:	89 c3                	mov    %eax,%ebx
    153c:	ff 75 dc             	push   -0x24(%ebp)
    153f:	ff 75 e0             	push   -0x20(%ebp)
    1542:	56                   	push   %esi
    1543:	e8 41 fd ff ff       	call   1289 <_Ma>
    1548:	83 c4 0c             	add    $0xc,%esp
    154b:	01 d8                	add    %ebx,%eax
    154d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    1550:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1553:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    1556:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1559:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    155c:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    155f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1562:	8b 7d d0             	mov    -0x30(%ebp),%edi
    1565:	01 c7                	add    %eax,%edi
        d = c;
    1567:	8b 45 dc             	mov    -0x24(%ebp),%eax
    156a:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    156d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1570:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    1573:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    1576:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1579:	8b 45 ec             	mov    -0x14(%ebp),%eax
    157c:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    157f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1583:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    1587:	0f 86 cf fe ff ff    	jbe    145c <_hash+0x57>
    }

    ctx->hash[0] += a;
    158d:	8b 45 08             	mov    0x8(%ebp),%eax
    1590:	8b 40 40             	mov    0x40(%eax),%eax
    1593:	8d 14 06             	lea    (%esi,%eax,1),%edx
    1596:	8b 45 08             	mov    0x8(%ebp),%eax
    1599:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
    159f:	8b 40 44             	mov    0x44(%eax),%eax
    15a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    15a5:	01 c2                	add    %eax,%edx
    15a7:	8b 45 08             	mov    0x8(%ebp),%eax
    15aa:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    15ad:	8b 45 08             	mov    0x8(%ebp),%eax
    15b0:	8b 40 48             	mov    0x48(%eax),%eax
    15b3:	8b 55 dc             	mov    -0x24(%ebp),%edx
    15b6:	01 c2                	add    %eax,%edx
    15b8:	8b 45 08             	mov    0x8(%ebp),%eax
    15bb:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    15be:	8b 45 08             	mov    0x8(%ebp),%eax
    15c1:	8b 40 4c             	mov    0x4c(%eax),%eax
    15c4:	8b 55 d0             	mov    -0x30(%ebp),%edx
    15c7:	01 c2                	add    %eax,%edx
    15c9:	8b 45 08             	mov    0x8(%ebp),%eax
    15cc:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    15cf:	8b 45 08             	mov    0x8(%ebp),%eax
    15d2:	8b 40 50             	mov    0x50(%eax),%eax
    15d5:	8d 14 07             	lea    (%edi,%eax,1),%edx
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    15de:	8b 45 08             	mov    0x8(%ebp),%eax
    15e1:	8b 40 54             	mov    0x54(%eax),%eax
    15e4:	8b 55 d8             	mov    -0x28(%ebp),%edx
    15e7:	01 c2                	add    %eax,%edx
    15e9:	8b 45 08             	mov    0x8(%ebp),%eax
    15ec:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    15ef:	8b 45 08             	mov    0x8(%ebp),%eax
    15f2:	8b 40 58             	mov    0x58(%eax),%eax
    15f5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    15f8:	01 c2                	add    %eax,%edx
    15fa:	8b 45 08             	mov    0x8(%ebp),%eax
    15fd:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	8b 40 5c             	mov    0x5c(%eax),%eax
    1606:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1609:	01 c2                	add    %eax,%edx
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    1611:	90                   	nop
    1612:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1615:	5b                   	pop    %ebx
    1616:	5e                   	pop    %esi
    1617:	5f                   	pop    %edi
    1618:	5d                   	pop    %ebp
    1619:	c3                   	ret    

0000161a <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    161a:	55                   	push   %ebp
    161b:	89 e5                	mov    %esp,%ebp
    161d:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    1623:	83 ec 0c             	sub    $0xc,%esp
    1626:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    162c:	50                   	push   %eax
    162d:	e8 33 00 00 00       	call   1665 <sha256_init>
    1632:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    1635:	83 ec 04             	sub    $0x4,%esp
    1638:	ff 75 0c             	push   0xc(%ebp)
    163b:	ff 75 08             	push   0x8(%ebp)
    163e:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1644:	50                   	push   %eax
    1645:	e8 99 00 00 00       	call   16e3 <sha256_hash>
    164a:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    164d:	83 ec 08             	sub    $0x8,%esp
    1650:	ff 75 10             	push   0x10(%ebp)
    1653:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1659:	50                   	push   %eax
    165a:	e8 14 01 00 00       	call   1773 <sha256_done>
    165f:	83 c4 10             	add    $0x10,%esp
}
    1662:	90                   	nop
    1663:	c9                   	leave  
    1664:	c3                   	ret    

00001665 <sha256_init>:

void sha256_init(sha256_context* ctx) {
    1665:	55                   	push   %ebp
    1666:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    1668:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    166c:	74 72                	je     16e0 <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    166e:	8b 45 08             	mov    0x8(%ebp),%eax
    1671:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    1678:	8b 45 08             	mov    0x8(%ebp),%eax
    167b:	8b 50 68             	mov    0x68(%eax),%edx
    167e:	8b 45 08             	mov    0x8(%ebp),%eax
    1681:	89 50 64             	mov    %edx,0x64(%eax)
    1684:	8b 45 08             	mov    0x8(%ebp),%eax
    1687:	8b 50 64             	mov    0x64(%eax),%edx
    168a:	8b 45 08             	mov    0x8(%ebp),%eax
    168d:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    1690:	8b 45 08             	mov    0x8(%ebp),%eax
    1693:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    169a:	8b 45 08             	mov    0x8(%ebp),%eax
    169d:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    16a4:	8b 45 08             	mov    0x8(%ebp),%eax
    16a7:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    16ae:	8b 45 08             	mov    0x8(%ebp),%eax
    16b1:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    16b8:	8b 45 08             	mov    0x8(%ebp),%eax
    16bb:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    16c2:	8b 45 08             	mov    0x8(%ebp),%eax
    16c5:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    16cc:	8b 45 08             	mov    0x8(%ebp),%eax
    16cf:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    16d6:	8b 45 08             	mov    0x8(%ebp),%eax
    16d9:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    16e0:	90                   	nop
    16e1:	5d                   	pop    %ebp
    16e2:	c3                   	ret    

000016e3 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    16e3:	55                   	push   %ebp
    16e4:	89 e5                	mov    %esp,%ebp
    16e6:	53                   	push   %ebx
    16e7:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    16ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ed:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    16f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    16f4:	74 77                	je     176d <sha256_hash+0x8a>
    16f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16fa:	74 71                	je     176d <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    1702:	83 f8 3f             	cmp    $0x3f,%eax
    1705:	77 66                	ja     176d <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    1707:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    170e:	eb 55                	jmp    1765 <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    1710:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1713:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1716:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
    171c:	8b 40 68             	mov    0x68(%eax),%eax
    171f:	8d 48 01             	lea    0x1(%eax),%ecx
    1722:	8b 55 08             	mov    0x8(%ebp),%edx
    1725:	89 4a 68             	mov    %ecx,0x68(%edx)
    1728:	0f b6 0b             	movzbl (%ebx),%ecx
    172b:	8b 55 08             	mov    0x8(%ebp),%edx
    172e:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    1731:	8b 45 08             	mov    0x8(%ebp),%eax
    1734:	8b 40 68             	mov    0x68(%eax),%eax
    1737:	83 f8 40             	cmp    $0x40,%eax
    173a:	75 25                	jne    1761 <sha256_hash+0x7e>
                _hash(ctx);
    173c:	ff 75 08             	push   0x8(%ebp)
    173f:	e8 c1 fc ff ff       	call   1405 <_hash>
    1744:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    1747:	68 00 02 00 00       	push   $0x200
    174c:	ff 75 08             	push   0x8(%ebp)
    174f:	e8 7c fc ff ff       	call   13d0 <_addbits>
    1754:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    1757:	8b 45 08             	mov    0x8(%ebp),%eax
    175a:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    1761:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1765:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1768:	3b 45 10             	cmp    0x10(%ebp),%eax
    176b:	72 a3                	jb     1710 <sha256_hash+0x2d>
            }
        }
    }
}
    176d:	90                   	nop
    176e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1771:	c9                   	leave  
    1772:	c3                   	ret    

00001773 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    1773:	55                   	push   %ebp
    1774:	89 e5                	mov    %esp,%ebp
    1776:	57                   	push   %edi
    1777:	56                   	push   %esi
    1778:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    1779:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    177d:	0f 84 27 02 00 00    	je     19aa <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    1783:	8b 45 08             	mov    0x8(%ebp),%eax
    1786:	8b 40 68             	mov    0x68(%eax),%eax
    1789:	83 e0 3f             	and    $0x3f,%eax
    178c:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    178e:	8b 45 08             	mov    0x8(%ebp),%eax
    1791:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    1795:	8d 73 01             	lea    0x1(%ebx),%esi
    1798:	eb 0a                	jmp    17a4 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    179a:	8b 45 08             	mov    0x8(%ebp),%eax
    179d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    17a1:	83 c6 01             	add    $0x1,%esi
    17a4:	83 fe 3f             	cmp    $0x3f,%esi
    17a7:	76 f1                	jbe    179a <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    17a9:	8b 45 08             	mov    0x8(%ebp),%eax
    17ac:	8b 40 68             	mov    0x68(%eax),%eax
    17af:	83 f8 37             	cmp    $0x37,%eax
    17b2:	76 21                	jbe    17d5 <sha256_done+0x62>
            _hash(ctx);
    17b4:	ff 75 08             	push   0x8(%ebp)
    17b7:	e8 49 fc ff ff       	call   1405 <_hash>
    17bc:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    17bf:	bb 00 00 00 00       	mov    $0x0,%ebx
    17c4:	eb 0a                	jmp    17d0 <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    17c6:	8b 45 08             	mov    0x8(%ebp),%eax
    17c9:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    17cd:	83 c3 01             	add    $0x1,%ebx
    17d0:	83 fb 3f             	cmp    $0x3f,%ebx
    17d3:	76 f1                	jbe    17c6 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    17d5:	8b 45 08             	mov    0x8(%ebp),%eax
    17d8:	8b 40 68             	mov    0x68(%eax),%eax
    17db:	c1 e0 03             	shl    $0x3,%eax
    17de:	50                   	push   %eax
    17df:	ff 75 08             	push   0x8(%ebp)
    17e2:	e8 e9 fb ff ff       	call   13d0 <_addbits>
    17e7:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    17ea:	8b 45 08             	mov    0x8(%ebp),%eax
    17ed:	8b 40 60             	mov    0x60(%eax),%eax
    17f0:	6a 00                	push   $0x0
    17f2:	50                   	push   %eax
    17f3:	e8 1a fa ff ff       	call   1212 <_shb>
    17f8:	83 c4 08             	add    $0x8,%esp
    17fb:	8b 55 08             	mov    0x8(%ebp),%edx
    17fe:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    1801:	8b 45 08             	mov    0x8(%ebp),%eax
    1804:	8b 40 60             	mov    0x60(%eax),%eax
    1807:	6a 08                	push   $0x8
    1809:	50                   	push   %eax
    180a:	e8 03 fa ff ff       	call   1212 <_shb>
    180f:	83 c4 08             	add    $0x8,%esp
    1812:	8b 55 08             	mov    0x8(%ebp),%edx
    1815:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    1818:	8b 45 08             	mov    0x8(%ebp),%eax
    181b:	8b 40 60             	mov    0x60(%eax),%eax
    181e:	6a 10                	push   $0x10
    1820:	50                   	push   %eax
    1821:	e8 ec f9 ff ff       	call   1212 <_shb>
    1826:	83 c4 08             	add    $0x8,%esp
    1829:	8b 55 08             	mov    0x8(%ebp),%edx
    182c:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    182f:	8b 45 08             	mov    0x8(%ebp),%eax
    1832:	8b 40 60             	mov    0x60(%eax),%eax
    1835:	6a 18                	push   $0x18
    1837:	50                   	push   %eax
    1838:	e8 d5 f9 ff ff       	call   1212 <_shb>
    183d:	83 c4 08             	add    $0x8,%esp
    1840:	8b 55 08             	mov    0x8(%ebp),%edx
    1843:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    1846:	8b 45 08             	mov    0x8(%ebp),%eax
    1849:	8b 40 64             	mov    0x64(%eax),%eax
    184c:	6a 00                	push   $0x0
    184e:	50                   	push   %eax
    184f:	e8 be f9 ff ff       	call   1212 <_shb>
    1854:	83 c4 08             	add    $0x8,%esp
    1857:	8b 55 08             	mov    0x8(%ebp),%edx
    185a:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    185d:	8b 45 08             	mov    0x8(%ebp),%eax
    1860:	8b 40 64             	mov    0x64(%eax),%eax
    1863:	6a 08                	push   $0x8
    1865:	50                   	push   %eax
    1866:	e8 a7 f9 ff ff       	call   1212 <_shb>
    186b:	83 c4 08             	add    $0x8,%esp
    186e:	8b 55 08             	mov    0x8(%ebp),%edx
    1871:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    1874:	8b 45 08             	mov    0x8(%ebp),%eax
    1877:	8b 40 64             	mov    0x64(%eax),%eax
    187a:	6a 10                	push   $0x10
    187c:	50                   	push   %eax
    187d:	e8 90 f9 ff ff       	call   1212 <_shb>
    1882:	83 c4 08             	add    $0x8,%esp
    1885:	8b 55 08             	mov    0x8(%ebp),%edx
    1888:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    188b:	8b 45 08             	mov    0x8(%ebp),%eax
    188e:	8b 40 64             	mov    0x64(%eax),%eax
    1891:	6a 18                	push   $0x18
    1893:	50                   	push   %eax
    1894:	e8 79 f9 ff ff       	call   1212 <_shb>
    1899:	83 c4 08             	add    $0x8,%esp
    189c:	8b 55 08             	mov    0x8(%ebp),%edx
    189f:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    18a2:	ff 75 08             	push   0x8(%ebp)
    18a5:	e8 5b fb ff ff       	call   1405 <_hash>
    18aa:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    18ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18b1:	0f 84 f3 00 00 00    	je     19aa <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    18b7:	be 00 00 00 00       	mov    $0x0,%esi
    18bc:	bb 18 00 00 00       	mov    $0x18,%ebx
    18c1:	e9 db 00 00 00       	jmp    19a1 <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    18c6:	8b 45 08             	mov    0x8(%ebp),%eax
    18c9:	8b 40 40             	mov    0x40(%eax),%eax
    18cc:	8b 55 0c             	mov    0xc(%ebp),%edx
    18cf:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    18d2:	53                   	push   %ebx
    18d3:	50                   	push   %eax
    18d4:	e8 39 f9 ff ff       	call   1212 <_shb>
    18d9:	83 c4 08             	add    $0x8,%esp
    18dc:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    18de:	8b 45 08             	mov    0x8(%ebp),%eax
    18e1:	8b 40 44             	mov    0x44(%eax),%eax
    18e4:	8d 4e 04             	lea    0x4(%esi),%ecx
    18e7:	8b 55 0c             	mov    0xc(%ebp),%edx
    18ea:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    18ed:	53                   	push   %ebx
    18ee:	50                   	push   %eax
    18ef:	e8 1e f9 ff ff       	call   1212 <_shb>
    18f4:	83 c4 08             	add    $0x8,%esp
    18f7:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
    18fc:	8b 40 48             	mov    0x48(%eax),%eax
    18ff:	8d 4e 08             	lea    0x8(%esi),%ecx
    1902:	8b 55 0c             	mov    0xc(%ebp),%edx
    1905:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1908:	53                   	push   %ebx
    1909:	50                   	push   %eax
    190a:	e8 03 f9 ff ff       	call   1212 <_shb>
    190f:	83 c4 08             	add    $0x8,%esp
    1912:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    1914:	8b 45 08             	mov    0x8(%ebp),%eax
    1917:	8b 40 4c             	mov    0x4c(%eax),%eax
    191a:	8d 4e 0c             	lea    0xc(%esi),%ecx
    191d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1920:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1923:	53                   	push   %ebx
    1924:	50                   	push   %eax
    1925:	e8 e8 f8 ff ff       	call   1212 <_shb>
    192a:	83 c4 08             	add    $0x8,%esp
    192d:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    192f:	8b 45 08             	mov    0x8(%ebp),%eax
    1932:	8b 40 50             	mov    0x50(%eax),%eax
    1935:	8d 4e 10             	lea    0x10(%esi),%ecx
    1938:	8b 55 0c             	mov    0xc(%ebp),%edx
    193b:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    193e:	53                   	push   %ebx
    193f:	50                   	push   %eax
    1940:	e8 cd f8 ff ff       	call   1212 <_shb>
    1945:	83 c4 08             	add    $0x8,%esp
    1948:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    194a:	8b 45 08             	mov    0x8(%ebp),%eax
    194d:	8b 40 54             	mov    0x54(%eax),%eax
    1950:	8d 4e 14             	lea    0x14(%esi),%ecx
    1953:	8b 55 0c             	mov    0xc(%ebp),%edx
    1956:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1959:	53                   	push   %ebx
    195a:	50                   	push   %eax
    195b:	e8 b2 f8 ff ff       	call   1212 <_shb>
    1960:	83 c4 08             	add    $0x8,%esp
    1963:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    1965:	8b 45 08             	mov    0x8(%ebp),%eax
    1968:	8b 40 58             	mov    0x58(%eax),%eax
    196b:	8d 4e 18             	lea    0x18(%esi),%ecx
    196e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1971:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1974:	53                   	push   %ebx
    1975:	50                   	push   %eax
    1976:	e8 97 f8 ff ff       	call   1212 <_shb>
    197b:	83 c4 08             	add    $0x8,%esp
    197e:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    1980:	8b 45 08             	mov    0x8(%ebp),%eax
    1983:	8b 40 5c             	mov    0x5c(%eax),%eax
    1986:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    1989:	8b 55 0c             	mov    0xc(%ebp),%edx
    198c:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    198f:	53                   	push   %ebx
    1990:	50                   	push   %eax
    1991:	e8 7c f8 ff ff       	call   1212 <_shb>
    1996:	83 c4 08             	add    $0x8,%esp
    1999:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    199b:	83 c6 01             	add    $0x1,%esi
    199e:	83 eb 08             	sub    $0x8,%ebx
    19a1:	83 fe 03             	cmp    $0x3,%esi
    19a4:	0f 86 1c ff ff ff    	jbe    18c6 <sha256_done+0x153>
            }
        }
    }
}
    19aa:	90                   	nop
    19ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19ae:	5b                   	pop    %ebx
    19af:	5e                   	pop    %esi
    19b0:	5f                   	pop    %edi
    19b1:	5d                   	pop    %ebp
    19b2:	c3                   	ret    

000019b3 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    19b3:	55                   	push   %ebp
    19b4:	89 e5                	mov    %esp,%ebp
    19b6:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    19b9:	a1 04 2a 00 00       	mov    0x2a04,%eax
    19be:	83 ec 08             	sub    $0x8,%esp
    19c1:	68 04 02 00 00       	push   $0x204
    19c6:	50                   	push   %eax
    19c7:	e8 7d e7 ff ff       	call   149 <open>
    19cc:	83 c4 10             	add    $0x10,%esp
    19cf:	a3 40 2a 00 00       	mov    %eax,0x2a40

    int i = 0;
    19d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    19db:	eb 6f                	jmp    1a4c <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    19dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e0:	83 e0 01             	and    $0x1,%eax
    19e3:	85 c0                	test   %eax,%eax
    19e5:	75 27                	jne    1a0e <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    19e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ea:	89 c2                	mov    %eax,%edx
    19ec:	c1 ea 1f             	shr    $0x1f,%edx
    19ef:	01 d0                	add    %edx,%eax
    19f1:	d1 f8                	sar    %eax
    19f3:	6b c0 64             	imul   $0x64,%eax,%eax
    19f6:	8d 90 60 2a 00 00    	lea    0x2a60(%eax),%edx
    19fc:	83 ec 08             	sub    $0x8,%esp
    19ff:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a02:	50                   	push   %eax
    1a03:	52                   	push   %edx
    1a04:	e8 ee e7 ff ff       	call   1f7 <strcpy>
    1a09:	83 c4 10             	add    $0x10,%esp
    1a0c:	eb 27                	jmp    1a35 <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a11:	89 c2                	mov    %eax,%edx
    1a13:	c1 ea 1f             	shr    $0x1f,%edx
    1a16:	01 d0                	add    %edx,%eax
    1a18:	d1 f8                	sar    %eax
    1a1a:	6b c0 64             	imul   $0x64,%eax,%eax
    1a1d:	8d 90 a0 29 64 00    	lea    0x6429a0(%eax),%edx
    1a23:	83 ec 04             	sub    $0x4,%esp
    1a26:	6a 64                	push   $0x64
    1a28:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a2b:	50                   	push   %eax
    1a2c:	52                   	push   %edx
    1a2d:	e8 b1 e9 ff ff       	call   3e3 <memmove>
    1a32:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1a35:	83 ec 04             	sub    $0x4,%esp
    1a38:	6a 64                	push   $0x64
    1a3a:	6a 00                	push   $0x0
    1a3c:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a3f:	50                   	push   %eax
    1a40:	e8 48 e8 ff ff       	call   28d <memset>
    1a45:	83 c4 10             	add    $0x10,%esp
        i++;
    1a48:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1a4c:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1a51:	83 ec 04             	sub    $0x4,%esp
    1a54:	6a 64                	push   $0x64
    1a56:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1a59:	52                   	push   %edx
    1a5a:	50                   	push   %eax
    1a5b:	e8 c1 e6 ff ff       	call   121 <read>
    1a60:	83 c4 10             	add    $0x10,%esp
    1a63:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a66:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a6a:	0f 8f 6d ff ff ff    	jg     19dd <read_info+0x2a>
    }

    num_users = i / 2;
    1a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a73:	89 c2                	mov    %eax,%edx
    1a75:	c1 ea 1f             	shr    $0x1f,%edx
    1a78:	01 d0                	add    %edx,%eax
    1a7a:	d1 f8                	sar    %eax
    1a7c:	a3 44 2a 00 00       	mov    %eax,0x2a44

    if (n < 0) {
    1a81:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a85:	79 17                	jns    1a9e <read_info+0xeb>
        printf(1, "cat: read error\n");
    1a87:	83 ec 08             	sub    $0x8,%esp
    1a8a:	68 2b 22 00 00       	push   $0x222b
    1a8f:	6a 01                	push   $0x1
    1a91:	e8 83 ec ff ff       	call   719 <printf>
    1a96:	83 c4 10             	add    $0x10,%esp
        exit();
    1a99:	e8 6b e6 ff ff       	call   109 <exit>
    }
}
    1a9e:	90                   	nop
    1a9f:	c9                   	leave  
    1aa0:	c3                   	ret    

00001aa1 <writeback>:

void writeback() {
    1aa1:	55                   	push   %ebp
    1aa2:	89 e5                	mov    %esp,%ebp
    1aa4:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1aa7:	a1 04 2a 00 00       	mov    0x2a04,%eax
    1aac:	83 ec 08             	sub    $0x8,%esp
    1aaf:	68 04 02 00 00       	push   $0x204
    1ab4:	50                   	push   %eax
    1ab5:	e8 8f e6 ff ff       	call   149 <open>
    1aba:	83 c4 10             	add    $0x10,%esp
    1abd:	a3 40 2a 00 00       	mov    %eax,0x2a40
    for (int i = 0; i < num_users; i++) {
    1ac2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ac9:	eb 44                	jmp    1b0f <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ace:	6b c0 64             	imul   $0x64,%eax,%eax
    1ad1:	8d 90 60 2a 00 00    	lea    0x2a60(%eax),%edx
    1ad7:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1adc:	83 ec 04             	sub    $0x4,%esp
    1adf:	6a 64                	push   $0x64
    1ae1:	52                   	push   %edx
    1ae2:	50                   	push   %eax
    1ae3:	e8 41 e6 ff ff       	call   129 <write>
    1ae8:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aee:	6b c0 64             	imul   $0x64,%eax,%eax
    1af1:	8d 90 a0 29 64 00    	lea    0x6429a0(%eax),%edx
    1af7:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1afc:	83 ec 04             	sub    $0x4,%esp
    1aff:	6a 64                	push   $0x64
    1b01:	52                   	push   %edx
    1b02:	50                   	push   %eax
    1b03:	e8 21 e6 ff ff       	call   129 <write>
    1b08:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1b0b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b0f:	a1 44 2a 00 00       	mov    0x2a44,%eax
    1b14:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1b17:	7c b2                	jl     1acb <writeback+0x2a>
    }
    close(fd);
    1b19:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1b1e:	83 ec 0c             	sub    $0xc,%esp
    1b21:	50                   	push   %eax
    1b22:	e8 0a e6 ff ff       	call   131 <close>
    1b27:	83 c4 10             	add    $0x10,%esp
}
    1b2a:	90                   	nop
    1b2b:	c9                   	leave  
    1b2c:	c3                   	ret    

00001b2d <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1b2d:	55                   	push   %ebp
    1b2e:	89 e5                	mov    %esp,%ebp
    1b30:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1b36:	83 ec 08             	sub    $0x8,%esp
    1b39:	68 3c 22 00 00       	push   $0x223c
    1b3e:	68 60 2a 00 00       	push   $0x2a60
    1b43:	e8 af e6 ff ff       	call   1f7 <strcpy>
    1b48:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1b4b:	c7 45 f4 41 22 00 00 	movl   $0x2241,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1b52:	83 ec 08             	sub    $0x8,%esp
    1b55:	ff 75 f4             	push   -0xc(%ebp)
    1b58:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1b5e:	50                   	push   %eax
    1b5f:	e8 93 e6 ff ff       	call   1f7 <strcpy>
    1b64:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1b67:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1b6e:	83 ec 0c             	sub    $0xc,%esp
    1b71:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1b77:	50                   	push   %eax
    1b78:	e8 e8 fa ff ff       	call   1665 <sha256_init>
    1b7d:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1b80:	83 ec 0c             	sub    $0xc,%esp
    1b83:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1b89:	50                   	push   %eax
    1b8a:	e8 d7 e6 ff ff       	call   266 <strlen>
    1b8f:	83 c4 10             	add    $0x10,%esp
    1b92:	83 ec 04             	sub    $0x4,%esp
    1b95:	50                   	push   %eax
    1b96:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1b9c:	50                   	push   %eax
    1b9d:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1ba3:	50                   	push   %eax
    1ba4:	e8 3a fb ff ff       	call   16e3 <sha256_hash>
    1ba9:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1bac:	83 ec 08             	sub    $0x8,%esp
    1baf:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1bb5:	50                   	push   %eax
    1bb6:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1bbc:	50                   	push   %eax
    1bbd:	e8 b1 fb ff ff       	call   1773 <sha256_done>
    1bc2:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1bc5:	83 ec 04             	sub    $0x4,%esp
    1bc8:	6a 64                	push   $0x64
    1bca:	6a 00                	push   $0x0
    1bcc:	68 a0 29 64 00       	push   $0x6429a0
    1bd1:	e8 b7 e6 ff ff       	call   28d <memset>
    1bd6:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1bd9:	83 ec 04             	sub    $0x4,%esp
    1bdc:	6a 20                	push   $0x20
    1bde:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1be4:	50                   	push   %eax
    1be5:	68 a0 29 64 00       	push   $0x6429a0
    1bea:	e8 f4 e7 ff ff       	call   3e3 <memmove>
    1bef:	83 c4 10             	add    $0x10,%esp

    read_info();
    1bf2:	e8 bc fd ff ff       	call   19b3 <read_info>
    fd = open(SECRETS, O_RDWR);
    1bf7:	a1 04 2a 00 00       	mov    0x2a04,%eax
    1bfc:	83 ec 08             	sub    $0x8,%esp
    1bff:	6a 04                	push   $0x4
    1c01:	50                   	push   %eax
    1c02:	e8 42 e5 ff ff       	call   149 <open>
    1c07:	83 c4 10             	add    $0x10,%esp
    1c0a:	a3 40 2a 00 00       	mov    %eax,0x2a40
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1c0f:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1c14:	83 ec 04             	sub    $0x4,%esp
    1c17:	6a 64                	push   $0x64
    1c19:	68 60 2a 00 00       	push   $0x2a60
    1c1e:	50                   	push   %eax
    1c1f:	e8 05 e5 ff ff       	call   129 <write>
    1c24:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1c27:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1c2c:	83 ec 04             	sub    $0x4,%esp
    1c2f:	6a 64                	push   $0x64
    1c31:	68 a0 29 64 00       	push   $0x6429a0
    1c36:	50                   	push   %eax
    1c37:	e8 ed e4 ff ff       	call   129 <write>
    1c3c:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1c3f:	a1 40 2a 00 00       	mov    0x2a40,%eax
    1c44:	83 ec 0c             	sub    $0xc,%esp
    1c47:	50                   	push   %eax
    1c48:	e8 e4 e4 ff ff       	call   131 <close>
    1c4d:	83 c4 10             	add    $0x10,%esp
}
    1c50:	90                   	nop
    1c51:	c9                   	leave  
    1c52:	c3                   	ret    

00001c53 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1c53:	55                   	push   %ebp
    1c54:	89 e5                	mov    %esp,%ebp
    1c56:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1c59:	e8 55 fd ff ff       	call   19b3 <read_info>

    for (int i = 0; i < num_users; i++) {
    1c5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c65:	eb 29                	jmp    1c90 <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c6a:	6b c0 64             	imul   $0x64,%eax,%eax
    1c6d:	05 60 2a 00 00       	add    $0x2a60,%eax
    1c72:	83 ec 08             	sub    $0x8,%esp
    1c75:	50                   	push   %eax
    1c76:	ff 75 08             	push   0x8(%ebp)
    1c79:	e8 a9 e5 ff ff       	call   227 <strcmp>
    1c7e:	83 c4 10             	add    $0x10,%esp
    1c81:	85 c0                	test   %eax,%eax
    1c83:	75 07                	jne    1c8c <does_user_exist+0x39>
            return 0;
    1c85:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8a:	eb 13                	jmp    1c9f <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1c8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c90:	a1 44 2a 00 00       	mov    0x2a44,%eax
    1c95:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1c98:	7c cd                	jl     1c67 <does_user_exist+0x14>
        }
    }
    return -1;
    1c9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c9f:	c9                   	leave  
    1ca0:	c3                   	ret    

00001ca1 <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1ca1:	55                   	push   %ebp
    1ca2:	89 e5                	mov    %esp,%ebp
    1ca4:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1caa:	e8 04 fd ff ff       	call   19b3 <read_info>

    int open = -1;
    1caf:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1cb6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1cbd:	eb 46                	jmp    1d05 <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1cbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc2:	6b c0 64             	imul   $0x64,%eax,%eax
    1cc5:	05 60 2a 00 00       	add    $0x2a60,%eax
    1cca:	83 ec 08             	sub    $0x8,%esp
    1ccd:	50                   	push   %eax
    1cce:	ff 75 08             	push   0x8(%ebp)
    1cd1:	e8 51 e5 ff ff       	call   227 <strcmp>
    1cd6:	83 c4 10             	add    $0x10,%esp
    1cd9:	85 c0                	test   %eax,%eax
    1cdb:	75 0a                	jne    1ce7 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1cdd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ce2:	e9 18 01 00 00       	jmp    1dff <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1ce7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cea:	6b c0 64             	imul   $0x64,%eax,%eax
    1ced:	05 60 2a 00 00       	add    $0x2a60,%eax
    1cf2:	0f b6 00             	movzbl (%eax),%eax
    1cf5:	84 c0                	test   %al,%al
    1cf7:	75 08                	jne    1d01 <create_user+0x60>
            open = i;
    1cf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1cff:	eb 0d                	jmp    1d0e <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1d01:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1d05:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1d0c:	7e b1                	jle    1cbf <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1d0e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1d12:	0f 84 e2 00 00 00    	je     1dfa <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1d18:	83 ec 08             	sub    $0x8,%esp
    1d1b:	ff 75 0c             	push   0xc(%ebp)
    1d1e:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d24:	50                   	push   %eax
    1d25:	e8 cd e4 ff ff       	call   1f7 <strcpy>
    1d2a:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1d2d:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1d34:	83 ec 0c             	sub    $0xc,%esp
    1d37:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d3d:	50                   	push   %eax
    1d3e:	e8 22 f9 ff ff       	call   1665 <sha256_init>
    1d43:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1d46:	83 ec 0c             	sub    $0xc,%esp
    1d49:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d4f:	50                   	push   %eax
    1d50:	e8 11 e5 ff ff       	call   266 <strlen>
    1d55:	83 c4 10             	add    $0x10,%esp
    1d58:	83 ec 04             	sub    $0x4,%esp
    1d5b:	50                   	push   %eax
    1d5c:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d62:	50                   	push   %eax
    1d63:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d69:	50                   	push   %eax
    1d6a:	e8 74 f9 ff ff       	call   16e3 <sha256_hash>
    1d6f:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1d72:	83 ec 08             	sub    $0x8,%esp
    1d75:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1d7b:	50                   	push   %eax
    1d7c:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d82:	50                   	push   %eax
    1d83:	e8 eb f9 ff ff       	call   1773 <sha256_done>
    1d88:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1d8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d8e:	6b c0 64             	imul   $0x64,%eax,%eax
    1d91:	05 60 2a 00 00       	add    $0x2a60,%eax
    1d96:	83 ec 08             	sub    $0x8,%esp
    1d99:	ff 75 08             	push   0x8(%ebp)
    1d9c:	50                   	push   %eax
    1d9d:	e8 55 e4 ff ff       	call   1f7 <strcpy>
    1da2:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1da8:	6b c0 64             	imul   $0x64,%eax,%eax
    1dab:	05 a0 29 64 00       	add    $0x6429a0,%eax
    1db0:	83 ec 04             	sub    $0x4,%esp
    1db3:	6a 64                	push   $0x64
    1db5:	6a 00                	push   $0x0
    1db7:	50                   	push   %eax
    1db8:	e8 d0 e4 ff ff       	call   28d <memset>
    1dbd:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    1dc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dc3:	6b c0 64             	imul   $0x64,%eax,%eax
    1dc6:	8d 90 a0 29 64 00    	lea    0x6429a0(%eax),%edx
    1dcc:	83 ec 04             	sub    $0x4,%esp
    1dcf:	6a 20                	push   $0x20
    1dd1:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1dd7:	50                   	push   %eax
    1dd8:	52                   	push   %edx
    1dd9:	e8 05 e6 ff ff       	call   3e3 <memmove>
    1dde:	83 c4 10             	add    $0x10,%esp

        num_users++;
    1de1:	a1 44 2a 00 00       	mov    0x2a44,%eax
    1de6:	83 c0 01             	add    $0x1,%eax
    1de9:	a3 44 2a 00 00       	mov    %eax,0x2a44
        writeback();
    1dee:	e8 ae fc ff ff       	call   1aa1 <writeback>
        return 0;
    1df3:	b8 00 00 00 00       	mov    $0x0,%eax
    1df8:	eb 05                	jmp    1dff <create_user+0x15e>
    }

    return -1;
    1dfa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1dff:	c9                   	leave  
    1e00:	c3                   	ret    

00001e01 <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    1e01:	55                   	push   %ebp
    1e02:	89 e5                	mov    %esp,%ebp
    1e04:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    1e0a:	e8 a4 fb ff ff       	call   19b3 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    1e0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e16:	e9 7b 01 00 00       	jmp    1f96 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    1e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e1e:	6b c0 64             	imul   $0x64,%eax,%eax
    1e21:	05 60 2a 00 00       	add    $0x2a60,%eax
    1e26:	83 ec 08             	sub    $0x8,%esp
    1e29:	50                   	push   %eax
    1e2a:	ff 75 08             	push   0x8(%ebp)
    1e2d:	e8 f5 e3 ff ff       	call   227 <strcmp>
    1e32:	83 c4 10             	add    $0x10,%esp
    1e35:	85 c0                	test   %eax,%eax
    1e37:	0f 85 55 01 00 00    	jne    1f92 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    1e3d:	83 ec 08             	sub    $0x8,%esp
    1e40:	ff 75 0c             	push   0xc(%ebp)
    1e43:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e49:	50                   	push   %eax
    1e4a:	e8 a8 e3 ff ff       	call   1f7 <strcpy>
    1e4f:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    1e52:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    1e59:	83 ec 0c             	sub    $0xc,%esp
    1e5c:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1e62:	50                   	push   %eax
    1e63:	e8 fd f7 ff ff       	call   1665 <sha256_init>
    1e68:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    1e6b:	83 ec 0c             	sub    $0xc,%esp
    1e6e:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e74:	50                   	push   %eax
    1e75:	e8 ec e3 ff ff       	call   266 <strlen>
    1e7a:	83 c4 10             	add    $0x10,%esp
    1e7d:	83 ec 04             	sub    $0x4,%esp
    1e80:	50                   	push   %eax
    1e81:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e87:	50                   	push   %eax
    1e88:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1e8e:	50                   	push   %eax
    1e8f:	e8 4f f8 ff ff       	call   16e3 <sha256_hash>
    1e94:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    1e97:	83 ec 08             	sub    $0x8,%esp
    1e9a:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    1ea0:	50                   	push   %eax
    1ea1:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1ea7:	50                   	push   %eax
    1ea8:	e8 c6 f8 ff ff       	call   1773 <sha256_done>
    1ead:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    1eb0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1eb7:	eb 34                	jmp    1eed <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    1eb9:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    1ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ec2:	01 d0                	add    %edx,%eax
    1ec4:	0f b6 00             	movzbl (%eax),%eax
    1ec7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1eca:	6b ca 64             	imul   $0x64,%edx,%ecx
    1ecd:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1ed0:	01 ca                	add    %ecx,%edx
    1ed2:	81 c2 a0 29 64 00    	add    $0x6429a0,%edx
    1ed8:	0f b6 12             	movzbl (%edx),%edx
    1edb:	38 d0                	cmp    %dl,%al
    1edd:	74 0a                	je     1ee9 <login_user+0xe8>
                    return -1;
    1edf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ee4:	e9 bf 00 00 00       	jmp    1fa8 <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    1ee9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1eed:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    1ef1:	7e c6                	jle    1eb9 <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    1ef3:	83 ec 08             	sub    $0x8,%esp
    1ef6:	68 47 22 00 00       	push   $0x2247
    1efb:	6a 01                	push   $0x1
    1efd:	e8 17 e8 ff ff       	call   719 <printf>
    1f02:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    1f05:	e8 f7 e1 ff ff       	call   101 <fork>
    1f0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    1f0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f11:	79 17                	jns    1f2a <login_user+0x129>
                printf(1, "init: fork failed\n");
    1f13:	83 ec 08             	sub    $0x8,%esp
    1f16:	68 5a 22 00 00       	push   $0x225a
    1f1b:	6a 01                	push   $0x1
    1f1d:	e8 f7 e7 ff ff       	call   719 <printf>
    1f22:	83 c4 10             	add    $0x10,%esp
                exit();
    1f25:	e8 df e1 ff ff       	call   109 <exit>
            }
            if (pid == 0) {
    1f2a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f2e:	75 4c                	jne    1f7c <login_user+0x17b>
                setuid(i);
    1f30:	83 ec 0c             	sub    $0xc,%esp
    1f33:	ff 75 f4             	push   -0xc(%ebp)
    1f36:	e8 6e e2 ff ff       	call   1a9 <setuid>
    1f3b:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    1f3e:	83 ec 08             	sub    $0x8,%esp
    1f41:	68 08 2a 00 00       	push   $0x2a08
    1f46:	68 28 22 00 00       	push   $0x2228
    1f4b:	e8 f1 e1 ff ff       	call   141 <exec>
    1f50:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    1f53:	83 ec 08             	sub    $0x8,%esp
    1f56:	68 6d 22 00 00       	push   $0x226d
    1f5b:	6a 01                	push   $0x1
    1f5d:	e8 b7 e7 ff ff       	call   719 <printf>
    1f62:	83 c4 10             	add    $0x10,%esp
                exit();
    1f65:	e8 9f e1 ff ff       	call   109 <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    1f6a:	83 ec 08             	sub    $0x8,%esp
    1f6d:	68 83 22 00 00       	push   $0x2283
    1f72:	6a 01                	push   $0x1
    1f74:	e8 a0 e7 ff ff       	call   719 <printf>
    1f79:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    1f7c:	e8 90 e1 ff ff       	call   111 <wait>
    1f81:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1f84:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f88:	78 08                	js     1f92 <login_user+0x191>
    1f8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f8d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1f90:	75 d8                	jne    1f6a <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1f92:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f96:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    1f9d:	0f 8e 78 fe ff ff    	jle    1e1b <login_user+0x1a>
        }
    }

    return -1;
    1fa3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1fa8:	c9                   	leave  
    1fa9:	c3                   	ret    
