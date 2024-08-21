
_login_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h"
#include "login.h"

char* argv[] = {"login", 0};

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
      16:	68 c6 1f 00 00       	push   $0x1fc6
      1b:	e8 2e 01 00 00       	call   14e <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
        mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 c6 1f 00 00       	push   $0x1fc6
      33:	e8 1e 01 00 00       	call   156 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
        open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 04                	push   $0x4
      40:	68 c6 1f 00 00       	push   $0x1fc6
      45:	e8 04 01 00 00       	call   14e <open>
      4a:	83 c4 10             	add    $0x10,%esp
    }
    dup(0);  // stdout
      4d:	83 ec 0c             	sub    $0xc,%esp
      50:	6a 00                	push   $0x0
      52:	e8 2f 01 00 00       	call   186 <dup>
      57:	83 c4 10             	add    $0x10,%esp
    dup(0);  // stderr
      5a:	83 ec 0c             	sub    $0xc,%esp
      5d:	6a 00                	push   $0x0
      5f:	e8 22 01 00 00       	call   186 <dup>
      64:	83 c4 10             	add    $0x10,%esp

    init_hook();
      67:	e8 c6 1a 00 00       	call   1b32 <init_hook>

    for (;;) {
        printf(1, "\ninit: starting login\n");
      6c:	83 ec 08             	sub    $0x8,%esp
      6f:	68 ce 1f 00 00       	push   $0x1fce
      74:	6a 01                	push   $0x1
      76:	e8 a3 06 00 00       	call   71e <printf>
      7b:	83 c4 10             	add    $0x10,%esp
        pid = fork();
      7e:	e8 83 00 00 00       	call   106 <fork>
      83:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (pid < 0) {
      86:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      8a:	79 17                	jns    a3 <main+0xa3>
            printf(2, "init: fork failed\n");
      8c:	83 ec 08             	sub    $0x8,%esp
      8f:	68 e5 1f 00 00       	push   $0x1fe5
      94:	6a 02                	push   $0x2
      96:	e8 83 06 00 00       	call   71e <printf>
      9b:	83 c4 10             	add    $0x10,%esp
            exit();
      9e:	e8 6b 00 00 00       	call   10e <exit>
        }
        if (pid == 0) {
      a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a7:	75 3e                	jne    e7 <main+0xe7>
            exec("login", argv);
      a9:	83 ec 08             	sub    $0x8,%esp
      ac:	68 08 2a 00 00       	push   $0x2a08
      b1:	68 c0 1f 00 00       	push   $0x1fc0
      b6:	e8 8b 00 00 00       	call   146 <exec>
      bb:	83 c4 10             	add    $0x10,%esp
            printf(2, "init: exec login failed\n");
      be:	83 ec 08             	sub    $0x8,%esp
      c1:	68 f8 1f 00 00       	push   $0x1ff8
      c6:	6a 02                	push   $0x2
      c8:	e8 51 06 00 00       	call   71e <printf>
      cd:	83 c4 10             	add    $0x10,%esp
            exit();
      d0:	e8 39 00 00 00       	call   10e <exit>
        }
        while ((wpid = wait()) >= 0 && wpid != pid) {
            printf(2, "zombie!\n");
      d5:	83 ec 08             	sub    $0x8,%esp
      d8:	68 11 20 00 00       	push   $0x2011
      dd:	6a 02                	push   $0x2
      df:	e8 3a 06 00 00       	call   71e <printf>
      e4:	83 c4 10             	add    $0x10,%esp
        while ((wpid = wait()) >= 0 && wpid != pid) {
      e7:	e8 2a 00 00 00       	call   116 <wait>
      ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
      ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      f3:	0f 88 73 ff ff ff    	js     6c <main+0x6c>
      f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
      fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      ff:	75 d4                	jne    d5 <main+0xd5>
        printf(1, "\ninit: starting login\n");
     101:	e9 66 ff ff ff       	jmp    6c <main+0x6c>

00000106 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     106:	b8 01 00 00 00       	mov    $0x1,%eax
     10b:	cd 40                	int    $0x40
     10d:	c3                   	ret    

0000010e <exit>:
SYSCALL(exit)
     10e:	b8 02 00 00 00       	mov    $0x2,%eax
     113:	cd 40                	int    $0x40
     115:	c3                   	ret    

00000116 <wait>:
SYSCALL(wait)
     116:	b8 03 00 00 00       	mov    $0x3,%eax
     11b:	cd 40                	int    $0x40
     11d:	c3                   	ret    

0000011e <pipe>:
SYSCALL(pipe)
     11e:	b8 04 00 00 00       	mov    $0x4,%eax
     123:	cd 40                	int    $0x40
     125:	c3                   	ret    

00000126 <read>:
SYSCALL(read)
     126:	b8 05 00 00 00       	mov    $0x5,%eax
     12b:	cd 40                	int    $0x40
     12d:	c3                   	ret    

0000012e <write>:
SYSCALL(write)
     12e:	b8 10 00 00 00       	mov    $0x10,%eax
     133:	cd 40                	int    $0x40
     135:	c3                   	ret    

00000136 <close>:
SYSCALL(close)
     136:	b8 15 00 00 00       	mov    $0x15,%eax
     13b:	cd 40                	int    $0x40
     13d:	c3                   	ret    

0000013e <kill>:
SYSCALL(kill)
     13e:	b8 06 00 00 00       	mov    $0x6,%eax
     143:	cd 40                	int    $0x40
     145:	c3                   	ret    

00000146 <exec>:
SYSCALL(exec)
     146:	b8 07 00 00 00       	mov    $0x7,%eax
     14b:	cd 40                	int    $0x40
     14d:	c3                   	ret    

0000014e <open>:
SYSCALL(open)
     14e:	b8 0f 00 00 00       	mov    $0xf,%eax
     153:	cd 40                	int    $0x40
     155:	c3                   	ret    

00000156 <mknod>:
SYSCALL(mknod)
     156:	b8 11 00 00 00       	mov    $0x11,%eax
     15b:	cd 40                	int    $0x40
     15d:	c3                   	ret    

0000015e <unlink>:
SYSCALL(unlink)
     15e:	b8 12 00 00 00       	mov    $0x12,%eax
     163:	cd 40                	int    $0x40
     165:	c3                   	ret    

00000166 <fstat>:
SYSCALL(fstat)
     166:	b8 08 00 00 00       	mov    $0x8,%eax
     16b:	cd 40                	int    $0x40
     16d:	c3                   	ret    

0000016e <link>:
SYSCALL(link)
     16e:	b8 13 00 00 00       	mov    $0x13,%eax
     173:	cd 40                	int    $0x40
     175:	c3                   	ret    

00000176 <mkdir>:
SYSCALL(mkdir)
     176:	b8 14 00 00 00       	mov    $0x14,%eax
     17b:	cd 40                	int    $0x40
     17d:	c3                   	ret    

0000017e <chdir>:
SYSCALL(chdir)
     17e:	b8 09 00 00 00       	mov    $0x9,%eax
     183:	cd 40                	int    $0x40
     185:	c3                   	ret    

00000186 <dup>:
SYSCALL(dup)
     186:	b8 0a 00 00 00       	mov    $0xa,%eax
     18b:	cd 40                	int    $0x40
     18d:	c3                   	ret    

0000018e <getpid>:
SYSCALL(getpid)
     18e:	b8 0b 00 00 00       	mov    $0xb,%eax
     193:	cd 40                	int    $0x40
     195:	c3                   	ret    

00000196 <sbrk>:
SYSCALL(sbrk)
     196:	b8 0c 00 00 00       	mov    $0xc,%eax
     19b:	cd 40                	int    $0x40
     19d:	c3                   	ret    

0000019e <sleep>:
SYSCALL(sleep)
     19e:	b8 0d 00 00 00       	mov    $0xd,%eax
     1a3:	cd 40                	int    $0x40
     1a5:	c3                   	ret    

000001a6 <uptime>:
SYSCALL(uptime)
     1a6:	b8 0e 00 00 00       	mov    $0xe,%eax
     1ab:	cd 40                	int    $0x40
     1ad:	c3                   	ret    

000001ae <setuid>:
SYSCALL(setuid)
     1ae:	b8 16 00 00 00       	mov    $0x16,%eax
     1b3:	cd 40                	int    $0x40
     1b5:	c3                   	ret    

000001b6 <getuid>:
SYSCALL(getuid)
     1b6:	b8 19 00 00 00       	mov    $0x19,%eax
     1bb:	cd 40                	int    $0x40
     1bd:	c3                   	ret    

000001be <chown>:
SYSCALL(chown)
     1be:	b8 18 00 00 00       	mov    $0x18,%eax
     1c3:	cd 40                	int    $0x40
     1c5:	c3                   	ret    

000001c6 <chmod>:
SYSCALL(chmod)
     1c6:	b8 17 00 00 00       	mov    $0x17,%eax
     1cb:	cd 40                	int    $0x40
     1cd:	c3                   	ret    

000001ce <report_stats>:
SYSCALL(report_stats)
     1ce:	b8 1a 00 00 00       	mov    $0x1a,%eax
     1d3:	cd 40                	int    $0x40
     1d5:	c3                   	ret    

000001d6 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1d6:	55                   	push   %ebp
     1d7:	89 e5                	mov    %esp,%ebp
     1d9:	57                   	push   %edi
     1da:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     1db:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1de:	8b 55 10             	mov    0x10(%ebp),%edx
     1e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     1e4:	89 cb                	mov    %ecx,%ebx
     1e6:	89 df                	mov    %ebx,%edi
     1e8:	89 d1                	mov    %edx,%ecx
     1ea:	fc                   	cld    
     1eb:	f3 aa                	rep stos %al,%es:(%edi)
     1ed:	89 ca                	mov    %ecx,%edx
     1ef:	89 fb                	mov    %edi,%ebx
     1f1:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1f4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1f7:	90                   	nop
     1f8:	5b                   	pop    %ebx
     1f9:	5f                   	pop    %edi
     1fa:	5d                   	pop    %ebp
     1fb:	c3                   	ret    

000001fc <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     1fc:	55                   	push   %ebp
     1fd:	89 e5                	mov    %esp,%ebp
     1ff:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     202:	8b 45 08             	mov    0x8(%ebp),%eax
     205:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     208:	90                   	nop
     209:	8b 55 0c             	mov    0xc(%ebp),%edx
     20c:	8d 42 01             	lea    0x1(%edx),%eax
     20f:	89 45 0c             	mov    %eax,0xc(%ebp)
     212:	8b 45 08             	mov    0x8(%ebp),%eax
     215:	8d 48 01             	lea    0x1(%eax),%ecx
     218:	89 4d 08             	mov    %ecx,0x8(%ebp)
     21b:	0f b6 12             	movzbl (%edx),%edx
     21e:	88 10                	mov    %dl,(%eax)
     220:	0f b6 00             	movzbl (%eax),%eax
     223:	84 c0                	test   %al,%al
     225:	75 e2                	jne    209 <strcpy+0xd>
        ;
    return os;
     227:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     22a:	c9                   	leave  
     22b:	c3                   	ret    

0000022c <strcmp>:

int strcmp(const char* p, const char* q) {
     22c:	55                   	push   %ebp
     22d:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     22f:	eb 08                	jmp    239 <strcmp+0xd>
     231:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     235:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     239:	8b 45 08             	mov    0x8(%ebp),%eax
     23c:	0f b6 00             	movzbl (%eax),%eax
     23f:	84 c0                	test   %al,%al
     241:	74 10                	je     253 <strcmp+0x27>
     243:	8b 45 08             	mov    0x8(%ebp),%eax
     246:	0f b6 10             	movzbl (%eax),%edx
     249:	8b 45 0c             	mov    0xc(%ebp),%eax
     24c:	0f b6 00             	movzbl (%eax),%eax
     24f:	38 c2                	cmp    %al,%dl
     251:	74 de                	je     231 <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     253:	8b 45 08             	mov    0x8(%ebp),%eax
     256:	0f b6 00             	movzbl (%eax),%eax
     259:	0f b6 d0             	movzbl %al,%edx
     25c:	8b 45 0c             	mov    0xc(%ebp),%eax
     25f:	0f b6 00             	movzbl (%eax),%eax
     262:	0f b6 c8             	movzbl %al,%ecx
     265:	89 d0                	mov    %edx,%eax
     267:	29 c8                	sub    %ecx,%eax
}
     269:	5d                   	pop    %ebp
     26a:	c3                   	ret    

0000026b <strlen>:

uint strlen(const char* s) {
     26b:	55                   	push   %ebp
     26c:	89 e5                	mov    %esp,%ebp
     26e:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     271:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     278:	eb 04                	jmp    27e <strlen+0x13>
     27a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     27e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     281:	8b 45 08             	mov    0x8(%ebp),%eax
     284:	01 d0                	add    %edx,%eax
     286:	0f b6 00             	movzbl (%eax),%eax
     289:	84 c0                	test   %al,%al
     28b:	75 ed                	jne    27a <strlen+0xf>
        ;
    return n;
     28d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     290:	c9                   	leave  
     291:	c3                   	ret    

00000292 <memset>:

void* memset(void* dst, int c, uint n) {
     292:	55                   	push   %ebp
     293:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     295:	8b 45 10             	mov    0x10(%ebp),%eax
     298:	50                   	push   %eax
     299:	ff 75 0c             	push   0xc(%ebp)
     29c:	ff 75 08             	push   0x8(%ebp)
     29f:	e8 32 ff ff ff       	call   1d6 <stosb>
     2a4:	83 c4 0c             	add    $0xc,%esp
    return dst;
     2a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2aa:	c9                   	leave  
     2ab:	c3                   	ret    

000002ac <strchr>:

char* strchr(const char* s, char c) {
     2ac:	55                   	push   %ebp
     2ad:	89 e5                	mov    %esp,%ebp
     2af:	83 ec 04             	sub    $0x4,%esp
     2b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b5:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     2b8:	eb 14                	jmp    2ce <strchr+0x22>
        if (*s == c) return (char*) s;
     2ba:	8b 45 08             	mov    0x8(%ebp),%eax
     2bd:	0f b6 00             	movzbl (%eax),%eax
     2c0:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2c3:	75 05                	jne    2ca <strchr+0x1e>
     2c5:	8b 45 08             	mov    0x8(%ebp),%eax
     2c8:	eb 13                	jmp    2dd <strchr+0x31>
    for (; *s; s++)
     2ca:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2ce:	8b 45 08             	mov    0x8(%ebp),%eax
     2d1:	0f b6 00             	movzbl (%eax),%eax
     2d4:	84 c0                	test   %al,%al
     2d6:	75 e2                	jne    2ba <strchr+0xe>
    return 0;
     2d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2dd:	c9                   	leave  
     2de:	c3                   	ret    

000002df <gets>:

char* gets(char* buf, int max) {
     2df:	55                   	push   %ebp
     2e0:	89 e5                	mov    %esp,%ebp
     2e2:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     2e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2ec:	eb 42                	jmp    330 <gets+0x51>
        cc = read(0, &c, 1);
     2ee:	83 ec 04             	sub    $0x4,%esp
     2f1:	6a 01                	push   $0x1
     2f3:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2f6:	50                   	push   %eax
     2f7:	6a 00                	push   $0x0
     2f9:	e8 28 fe ff ff       	call   126 <read>
     2fe:	83 c4 10             	add    $0x10,%esp
     301:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     304:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     308:	7e 33                	jle    33d <gets+0x5e>
        buf[i++] = c;
     30a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     30d:	8d 50 01             	lea    0x1(%eax),%edx
     310:	89 55 f4             	mov    %edx,-0xc(%ebp)
     313:	89 c2                	mov    %eax,%edx
     315:	8b 45 08             	mov    0x8(%ebp),%eax
     318:	01 c2                	add    %eax,%edx
     31a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     31e:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     320:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     324:	3c 0a                	cmp    $0xa,%al
     326:	74 16                	je     33e <gets+0x5f>
     328:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     32c:	3c 0d                	cmp    $0xd,%al
     32e:	74 0e                	je     33e <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     330:	8b 45 f4             	mov    -0xc(%ebp),%eax
     333:	83 c0 01             	add    $0x1,%eax
     336:	39 45 0c             	cmp    %eax,0xc(%ebp)
     339:	7f b3                	jg     2ee <gets+0xf>
     33b:	eb 01                	jmp    33e <gets+0x5f>
        if (cc < 1) break;
     33d:	90                   	nop
    }
    buf[i] = '\0';
     33e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     341:	8b 45 08             	mov    0x8(%ebp),%eax
     344:	01 d0                	add    %edx,%eax
     346:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     349:	8b 45 08             	mov    0x8(%ebp),%eax
}
     34c:	c9                   	leave  
     34d:	c3                   	ret    

0000034e <stat>:

int stat(const char* n, struct stat* st) {
     34e:	55                   	push   %ebp
     34f:	89 e5                	mov    %esp,%ebp
     351:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     354:	83 ec 08             	sub    $0x8,%esp
     357:	6a 01                	push   $0x1
     359:	ff 75 08             	push   0x8(%ebp)
     35c:	e8 ed fd ff ff       	call   14e <open>
     361:	83 c4 10             	add    $0x10,%esp
     364:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     367:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     36b:	79 07                	jns    374 <stat+0x26>
     36d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     372:	eb 25                	jmp    399 <stat+0x4b>
    r = fstat(fd, st);
     374:	83 ec 08             	sub    $0x8,%esp
     377:	ff 75 0c             	push   0xc(%ebp)
     37a:	ff 75 f4             	push   -0xc(%ebp)
     37d:	e8 e4 fd ff ff       	call   166 <fstat>
     382:	83 c4 10             	add    $0x10,%esp
     385:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     388:	83 ec 0c             	sub    $0xc,%esp
     38b:	ff 75 f4             	push   -0xc(%ebp)
     38e:	e8 a3 fd ff ff       	call   136 <close>
     393:	83 c4 10             	add    $0x10,%esp
    return r;
     396:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     399:	c9                   	leave  
     39a:	c3                   	ret    

0000039b <atoi>:

int atoi(const char* s) {
     39b:	55                   	push   %ebp
     39c:	89 e5                	mov    %esp,%ebp
     39e:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     3a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     3a8:	eb 25                	jmp    3cf <atoi+0x34>
     3aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3ad:	89 d0                	mov    %edx,%eax
     3af:	c1 e0 02             	shl    $0x2,%eax
     3b2:	01 d0                	add    %edx,%eax
     3b4:	01 c0                	add    %eax,%eax
     3b6:	89 c1                	mov    %eax,%ecx
     3b8:	8b 45 08             	mov    0x8(%ebp),%eax
     3bb:	8d 50 01             	lea    0x1(%eax),%edx
     3be:	89 55 08             	mov    %edx,0x8(%ebp)
     3c1:	0f b6 00             	movzbl (%eax),%eax
     3c4:	0f be c0             	movsbl %al,%eax
     3c7:	01 c8                	add    %ecx,%eax
     3c9:	83 e8 30             	sub    $0x30,%eax
     3cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
     3cf:	8b 45 08             	mov    0x8(%ebp),%eax
     3d2:	0f b6 00             	movzbl (%eax),%eax
     3d5:	3c 2f                	cmp    $0x2f,%al
     3d7:	7e 0a                	jle    3e3 <atoi+0x48>
     3d9:	8b 45 08             	mov    0x8(%ebp),%eax
     3dc:	0f b6 00             	movzbl (%eax),%eax
     3df:	3c 39                	cmp    $0x39,%al
     3e1:	7e c7                	jle    3aa <atoi+0xf>
    return n;
     3e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e6:	c9                   	leave  
     3e7:	c3                   	ret    

000003e8 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     3e8:	55                   	push   %ebp
     3e9:	89 e5                	mov    %esp,%ebp
     3eb:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     3ee:	8b 45 08             	mov    0x8(%ebp),%eax
     3f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     3f4:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     3fa:	eb 17                	jmp    413 <memmove+0x2b>
     3fc:	8b 55 f8             	mov    -0x8(%ebp),%edx
     3ff:	8d 42 01             	lea    0x1(%edx),%eax
     402:	89 45 f8             	mov    %eax,-0x8(%ebp)
     405:	8b 45 fc             	mov    -0x4(%ebp),%eax
     408:	8d 48 01             	lea    0x1(%eax),%ecx
     40b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     40e:	0f b6 12             	movzbl (%edx),%edx
     411:	88 10                	mov    %dl,(%eax)
     413:	8b 45 10             	mov    0x10(%ebp),%eax
     416:	8d 50 ff             	lea    -0x1(%eax),%edx
     419:	89 55 10             	mov    %edx,0x10(%ebp)
     41c:	85 c0                	test   %eax,%eax
     41e:	7f dc                	jg     3fc <memmove+0x14>
    return vdst;
     420:	8b 45 08             	mov    0x8(%ebp),%eax
}
     423:	c9                   	leave  
     424:	c3                   	ret    

00000425 <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     425:	55                   	push   %ebp
     426:	89 e5                	mov    %esp,%ebp
     428:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     42b:	8b 45 08             	mov    0x8(%ebp),%eax
     42e:	83 e8 08             	sub    $0x8,%eax
     431:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     434:	a1 48 2a 00 00       	mov    0x2a48,%eax
     439:	89 45 fc             	mov    %eax,-0x4(%ebp)
     43c:	eb 24                	jmp    462 <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     43e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     441:	8b 00                	mov    (%eax),%eax
     443:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     446:	72 12                	jb     45a <free+0x35>
     448:	8b 45 f8             	mov    -0x8(%ebp),%eax
     44b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     44e:	77 24                	ja     474 <free+0x4f>
     450:	8b 45 fc             	mov    -0x4(%ebp),%eax
     453:	8b 00                	mov    (%eax),%eax
     455:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     458:	72 1a                	jb     474 <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     45a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     45d:	8b 00                	mov    (%eax),%eax
     45f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     462:	8b 45 f8             	mov    -0x8(%ebp),%eax
     465:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     468:	76 d4                	jbe    43e <free+0x19>
     46a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     46d:	8b 00                	mov    (%eax),%eax
     46f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     472:	73 ca                	jae    43e <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     474:	8b 45 f8             	mov    -0x8(%ebp),%eax
     477:	8b 40 04             	mov    0x4(%eax),%eax
     47a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     481:	8b 45 f8             	mov    -0x8(%ebp),%eax
     484:	01 c2                	add    %eax,%edx
     486:	8b 45 fc             	mov    -0x4(%ebp),%eax
     489:	8b 00                	mov    (%eax),%eax
     48b:	39 c2                	cmp    %eax,%edx
     48d:	75 24                	jne    4b3 <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     48f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     492:	8b 50 04             	mov    0x4(%eax),%edx
     495:	8b 45 fc             	mov    -0x4(%ebp),%eax
     498:	8b 00                	mov    (%eax),%eax
     49a:	8b 40 04             	mov    0x4(%eax),%eax
     49d:	01 c2                	add    %eax,%edx
     49f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4a2:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     4a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4a8:	8b 00                	mov    (%eax),%eax
     4aa:	8b 10                	mov    (%eax),%edx
     4ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4af:	89 10                	mov    %edx,(%eax)
     4b1:	eb 0a                	jmp    4bd <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     4b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4b6:	8b 10                	mov    (%eax),%edx
     4b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4bb:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     4bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4c0:	8b 40 04             	mov    0x4(%eax),%eax
     4c3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     4ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4cd:	01 d0                	add    %edx,%eax
     4cf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     4d2:	75 20                	jne    4f4 <free+0xcf>
        p->s.size += bp->s.size;
     4d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4d7:	8b 50 04             	mov    0x4(%eax),%edx
     4da:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4dd:	8b 40 04             	mov    0x4(%eax),%eax
     4e0:	01 c2                	add    %eax,%edx
     4e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4e5:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     4e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4eb:	8b 10                	mov    (%eax),%edx
     4ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f0:	89 10                	mov    %edx,(%eax)
     4f2:	eb 08                	jmp    4fc <free+0xd7>
    } else
        p->s.ptr = bp;
     4f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     4fa:	89 10                	mov    %edx,(%eax)
    freep = p;
     4fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4ff:	a3 48 2a 00 00       	mov    %eax,0x2a48
}
     504:	90                   	nop
     505:	c9                   	leave  
     506:	c3                   	ret    

00000507 <morecore>:

static Header* morecore(uint nu) {
     507:	55                   	push   %ebp
     508:	89 e5                	mov    %esp,%ebp
     50a:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     50d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     514:	77 07                	ja     51d <morecore+0x16>
     516:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     51d:	8b 45 08             	mov    0x8(%ebp),%eax
     520:	c1 e0 03             	shl    $0x3,%eax
     523:	83 ec 0c             	sub    $0xc,%esp
     526:	50                   	push   %eax
     527:	e8 6a fc ff ff       	call   196 <sbrk>
     52c:	83 c4 10             	add    $0x10,%esp
     52f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     532:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     536:	75 07                	jne    53f <morecore+0x38>
     538:	b8 00 00 00 00       	mov    $0x0,%eax
     53d:	eb 26                	jmp    565 <morecore+0x5e>
    hp = (Header*) p;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     545:	8b 45 f0             	mov    -0x10(%ebp),%eax
     548:	8b 55 08             	mov    0x8(%ebp),%edx
     54b:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     54e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     551:	83 c0 08             	add    $0x8,%eax
     554:	83 ec 0c             	sub    $0xc,%esp
     557:	50                   	push   %eax
     558:	e8 c8 fe ff ff       	call   425 <free>
     55d:	83 c4 10             	add    $0x10,%esp
    return freep;
     560:	a1 48 2a 00 00       	mov    0x2a48,%eax
}
     565:	c9                   	leave  
     566:	c3                   	ret    

00000567 <malloc>:

void* malloc(uint nbytes) {
     567:	55                   	push   %ebp
     568:	89 e5                	mov    %esp,%ebp
     56a:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     56d:	8b 45 08             	mov    0x8(%ebp),%eax
     570:	83 c0 07             	add    $0x7,%eax
     573:	c1 e8 03             	shr    $0x3,%eax
     576:	83 c0 01             	add    $0x1,%eax
     579:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     57c:	a1 48 2a 00 00       	mov    0x2a48,%eax
     581:	89 45 f0             	mov    %eax,-0x10(%ebp)
     584:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     588:	75 23                	jne    5ad <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     58a:	c7 45 f0 40 2a 00 00 	movl   $0x2a40,-0x10(%ebp)
     591:	8b 45 f0             	mov    -0x10(%ebp),%eax
     594:	a3 48 2a 00 00       	mov    %eax,0x2a48
     599:	a1 48 2a 00 00       	mov    0x2a48,%eax
     59e:	a3 40 2a 00 00       	mov    %eax,0x2a40
        base.s.size = 0;
     5a3:	c7 05 44 2a 00 00 00 	movl   $0x0,0x2a44
     5aa:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     5ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5b0:	8b 00                	mov    (%eax),%eax
     5b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     5b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5b8:	8b 40 04             	mov    0x4(%eax),%eax
     5bb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     5be:	77 4d                	ja     60d <malloc+0xa6>
            if (p->s.size == nunits)
     5c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5c3:	8b 40 04             	mov    0x4(%eax),%eax
     5c6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     5c9:	75 0c                	jne    5d7 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     5cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ce:	8b 10                	mov    (%eax),%edx
     5d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5d3:	89 10                	mov    %edx,(%eax)
     5d5:	eb 26                	jmp    5fd <malloc+0x96>
            else {
                p->s.size -= nunits;
     5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5da:	8b 40 04             	mov    0x4(%eax),%eax
     5dd:	2b 45 ec             	sub    -0x14(%ebp),%eax
     5e0:	89 c2                	mov    %eax,%edx
     5e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e5:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     5e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5eb:	8b 40 04             	mov    0x4(%eax),%eax
     5ee:	c1 e0 03             	shl    $0x3,%eax
     5f1:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     5f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     5fa:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     5fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     600:	a3 48 2a 00 00       	mov    %eax,0x2a48
            return (void*) (p + 1);
     605:	8b 45 f4             	mov    -0xc(%ebp),%eax
     608:	83 c0 08             	add    $0x8,%eax
     60b:	eb 3b                	jmp    648 <malloc+0xe1>
        }
        if (p == freep)
     60d:	a1 48 2a 00 00       	mov    0x2a48,%eax
     612:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     615:	75 1e                	jne    635 <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     617:	83 ec 0c             	sub    $0xc,%esp
     61a:	ff 75 ec             	push   -0x14(%ebp)
     61d:	e8 e5 fe ff ff       	call   507 <morecore>
     622:	83 c4 10             	add    $0x10,%esp
     625:	89 45 f4             	mov    %eax,-0xc(%ebp)
     628:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     62c:	75 07                	jne    635 <malloc+0xce>
     62e:	b8 00 00 00 00       	mov    $0x0,%eax
     633:	eb 13                	jmp    648 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     635:	8b 45 f4             	mov    -0xc(%ebp),%eax
     638:	89 45 f0             	mov    %eax,-0x10(%ebp)
     63b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63e:	8b 00                	mov    (%eax),%eax
     640:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     643:	e9 6d ff ff ff       	jmp    5b5 <malloc+0x4e>
    }
}
     648:	c9                   	leave  
     649:	c3                   	ret    

0000064a <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     64a:	55                   	push   %ebp
     64b:	89 e5                	mov    %esp,%ebp
     64d:	83 ec 18             	sub    $0x18,%esp
     650:	8b 45 0c             	mov    0xc(%ebp),%eax
     653:	88 45 f4             	mov    %al,-0xc(%ebp)
     656:	83 ec 04             	sub    $0x4,%esp
     659:	6a 01                	push   $0x1
     65b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     65e:	50                   	push   %eax
     65f:	ff 75 08             	push   0x8(%ebp)
     662:	e8 c7 fa ff ff       	call   12e <write>
     667:	83 c4 10             	add    $0x10,%esp
     66a:	90                   	nop
     66b:	c9                   	leave  
     66c:	c3                   	ret    

0000066d <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     66d:	55                   	push   %ebp
     66e:	89 e5                	mov    %esp,%ebp
     670:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     673:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     67a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     67e:	74 17                	je     697 <printint+0x2a>
     680:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     684:	79 11                	jns    697 <printint+0x2a>
        neg = 1;
     686:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     68d:	8b 45 0c             	mov    0xc(%ebp),%eax
     690:	f7 d8                	neg    %eax
     692:	89 45 ec             	mov    %eax,-0x14(%ebp)
     695:	eb 06                	jmp    69d <printint+0x30>
    } else {
        x = xx;
     697:	8b 45 0c             	mov    0xc(%ebp),%eax
     69a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     69d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     6a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6aa:	ba 00 00 00 00       	mov    $0x0,%edx
     6af:	f7 f1                	div    %ecx
     6b1:	89 d1                	mov    %edx,%ecx
     6b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b6:	8d 50 01             	lea    0x1(%eax),%edx
     6b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6bc:	0f b6 91 10 2a 00 00 	movzbl 0x2a10(%ecx),%edx
     6c3:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     6c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6cd:	ba 00 00 00 00       	mov    $0x0,%edx
     6d2:	f7 f1                	div    %ecx
     6d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6db:	75 c7                	jne    6a4 <printint+0x37>
    if (neg) buf[i++] = '-';
     6dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6e1:	74 2d                	je     710 <printint+0xa3>
     6e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e6:	8d 50 01             	lea    0x1(%eax),%edx
     6e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6ec:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     6f1:	eb 1d                	jmp    710 <printint+0xa3>
     6f3:	8d 55 dc             	lea    -0x24(%ebp),%edx
     6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f9:	01 d0                	add    %edx,%eax
     6fb:	0f b6 00             	movzbl (%eax),%eax
     6fe:	0f be c0             	movsbl %al,%eax
     701:	83 ec 08             	sub    $0x8,%esp
     704:	50                   	push   %eax
     705:	ff 75 08             	push   0x8(%ebp)
     708:	e8 3d ff ff ff       	call   64a <putc>
     70d:	83 c4 10             	add    $0x10,%esp
     710:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     714:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     718:	79 d9                	jns    6f3 <printint+0x86>
}
     71a:	90                   	nop
     71b:	90                   	nop
     71c:	c9                   	leave  
     71d:	c3                   	ret    

0000071e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     71e:	55                   	push   %ebp
     71f:	89 e5                	mov    %esp,%ebp
     721:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     724:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     72b:	8d 45 0c             	lea    0xc(%ebp),%eax
     72e:	83 c0 04             	add    $0x4,%eax
     731:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     734:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     73b:	e9 59 01 00 00       	jmp    899 <printf+0x17b>
        c = fmt[i] & 0xff;
     740:	8b 55 0c             	mov    0xc(%ebp),%edx
     743:	8b 45 f0             	mov    -0x10(%ebp),%eax
     746:	01 d0                	add    %edx,%eax
     748:	0f b6 00             	movzbl (%eax),%eax
     74b:	0f be c0             	movsbl %al,%eax
     74e:	25 ff 00 00 00       	and    $0xff,%eax
     753:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     756:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     75a:	75 2c                	jne    788 <printf+0x6a>
            if (c == '%') {
     75c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     760:	75 0c                	jne    76e <printf+0x50>
                state = '%';
     762:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     769:	e9 27 01 00 00       	jmp    895 <printf+0x177>
            } else {
                putc(fd, c);
     76e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     771:	0f be c0             	movsbl %al,%eax
     774:	83 ec 08             	sub    $0x8,%esp
     777:	50                   	push   %eax
     778:	ff 75 08             	push   0x8(%ebp)
     77b:	e8 ca fe ff ff       	call   64a <putc>
     780:	83 c4 10             	add    $0x10,%esp
     783:	e9 0d 01 00 00       	jmp    895 <printf+0x177>
            }
        } else if (state == '%') {
     788:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     78c:	0f 85 03 01 00 00    	jne    895 <printf+0x177>
            if (c == 'd') {
     792:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     796:	75 1e                	jne    7b6 <printf+0x98>
                printint(fd, *ap, 10, 1);
     798:	8b 45 e8             	mov    -0x18(%ebp),%eax
     79b:	8b 00                	mov    (%eax),%eax
     79d:	6a 01                	push   $0x1
     79f:	6a 0a                	push   $0xa
     7a1:	50                   	push   %eax
     7a2:	ff 75 08             	push   0x8(%ebp)
     7a5:	e8 c3 fe ff ff       	call   66d <printint>
     7aa:	83 c4 10             	add    $0x10,%esp
                ap++;
     7ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7b1:	e9 d8 00 00 00       	jmp    88e <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     7b6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7ba:	74 06                	je     7c2 <printf+0xa4>
     7bc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7c0:	75 1e                	jne    7e0 <printf+0xc2>
                printint(fd, *ap, 16, 0);
     7c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7c5:	8b 00                	mov    (%eax),%eax
     7c7:	6a 00                	push   $0x0
     7c9:	6a 10                	push   $0x10
     7cb:	50                   	push   %eax
     7cc:	ff 75 08             	push   0x8(%ebp)
     7cf:	e8 99 fe ff ff       	call   66d <printint>
     7d4:	83 c4 10             	add    $0x10,%esp
                ap++;
     7d7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7db:	e9 ae 00 00 00       	jmp    88e <printf+0x170>
            } else if (c == 's') {
     7e0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7e4:	75 43                	jne    829 <printf+0x10b>
                s = (char*) *ap;
     7e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7e9:	8b 00                	mov    (%eax),%eax
     7eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     7ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     7f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7f6:	75 25                	jne    81d <printf+0xff>
     7f8:	c7 45 f4 1a 20 00 00 	movl   $0x201a,-0xc(%ebp)
                while (*s != 0) {
     7ff:	eb 1c                	jmp    81d <printf+0xff>
                    putc(fd, *s);
     801:	8b 45 f4             	mov    -0xc(%ebp),%eax
     804:	0f b6 00             	movzbl (%eax),%eax
     807:	0f be c0             	movsbl %al,%eax
     80a:	83 ec 08             	sub    $0x8,%esp
     80d:	50                   	push   %eax
     80e:	ff 75 08             	push   0x8(%ebp)
     811:	e8 34 fe ff ff       	call   64a <putc>
     816:	83 c4 10             	add    $0x10,%esp
                    s++;
     819:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     820:	0f b6 00             	movzbl (%eax),%eax
     823:	84 c0                	test   %al,%al
     825:	75 da                	jne    801 <printf+0xe3>
     827:	eb 65                	jmp    88e <printf+0x170>
                }
            } else if (c == 'c') {
     829:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     82d:	75 1d                	jne    84c <printf+0x12e>
                putc(fd, *ap);
     82f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     832:	8b 00                	mov    (%eax),%eax
     834:	0f be c0             	movsbl %al,%eax
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	50                   	push   %eax
     83b:	ff 75 08             	push   0x8(%ebp)
     83e:	e8 07 fe ff ff       	call   64a <putc>
     843:	83 c4 10             	add    $0x10,%esp
                ap++;
     846:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     84a:	eb 42                	jmp    88e <printf+0x170>
            } else if (c == '%') {
     84c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     850:	75 17                	jne    869 <printf+0x14b>
                putc(fd, c);
     852:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     855:	0f be c0             	movsbl %al,%eax
     858:	83 ec 08             	sub    $0x8,%esp
     85b:	50                   	push   %eax
     85c:	ff 75 08             	push   0x8(%ebp)
     85f:	e8 e6 fd ff ff       	call   64a <putc>
     864:	83 c4 10             	add    $0x10,%esp
     867:	eb 25                	jmp    88e <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     869:	83 ec 08             	sub    $0x8,%esp
     86c:	6a 25                	push   $0x25
     86e:	ff 75 08             	push   0x8(%ebp)
     871:	e8 d4 fd ff ff       	call   64a <putc>
     876:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     879:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     87c:	0f be c0             	movsbl %al,%eax
     87f:	83 ec 08             	sub    $0x8,%esp
     882:	50                   	push   %eax
     883:	ff 75 08             	push   0x8(%ebp)
     886:	e8 bf fd ff ff       	call   64a <putc>
     88b:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     88e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     895:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     899:	8b 55 0c             	mov    0xc(%ebp),%edx
     89c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     89f:	01 d0                	add    %edx,%eax
     8a1:	0f b6 00             	movzbl (%eax),%eax
     8a4:	84 c0                	test   %al,%al
     8a6:	0f 85 94 fe ff ff    	jne    740 <printf+0x22>
        }
    }
}
     8ac:	90                   	nop
     8ad:	90                   	nop
     8ae:	c9                   	leave  
     8af:	c3                   	ret    

000008b0 <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	83 ec 04             	sub    $0x4,%esp
     8b6:	8b 45 08             	mov    0x8(%ebp),%eax
     8b9:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     8bc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     8c0:	01 c0                	add    %eax,%eax
     8c2:	89 c1                	mov    %eax,%ecx
     8c4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     8c8:	c0 e8 07             	shr    $0x7,%al
     8cb:	89 c2                	mov    %eax,%edx
     8cd:	89 d0                	mov    %edx,%eax
     8cf:	01 c0                	add    %eax,%eax
     8d1:	01 d0                	add    %edx,%eax
     8d3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     8da:	01 d0                	add    %edx,%eax
     8dc:	31 c8                	xor    %ecx,%eax
}
     8de:	c9                   	leave  
     8df:	c3                   	ret    

000008e0 <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     8e4:	bb 00 00 00 00       	mov    $0x0,%ebx
     8e9:	eb 24                	jmp    90f <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     8eb:	0f b6 d3             	movzbl %bl,%edx
     8ee:	8b 45 08             	mov    0x8(%ebp),%eax
     8f1:	01 d0                	add    %edx,%eax
     8f3:	0f b6 00             	movzbl (%eax),%eax
     8f6:	0f b6 c0             	movzbl %al,%eax
     8f9:	0f b6 cb             	movzbl %bl,%ecx
     8fc:	8b 55 08             	mov    0x8(%ebp),%edx
     8ff:	01 ca                	add    %ecx,%edx
     901:	0f b6 80 40 20 00 00 	movzbl 0x2040(%eax),%eax
     908:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     90a:	89 d8                	mov    %ebx,%eax
     90c:	8d 58 01             	lea    0x1(%eax),%ebx
     90f:	80 fb 0f             	cmp    $0xf,%bl
     912:	76 d7                	jbe    8eb <aes_subBytes+0xb>
    }
}
     914:	90                   	nop
     915:	90                   	nop
     916:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     919:	c9                   	leave  
     91a:	c3                   	ret    

0000091b <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     91b:	55                   	push   %ebp
     91c:	89 e5                	mov    %esp,%ebp
     91e:	56                   	push   %esi
     91f:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     920:	bb 00 00 00 00       	mov    $0x0,%ebx
     925:	eb 27                	jmp    94e <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     927:	0f b6 d3             	movzbl %bl,%edx
     92a:	8b 45 08             	mov    0x8(%ebp),%eax
     92d:	01 d0                	add    %edx,%eax
     92f:	0f b6 08             	movzbl (%eax),%ecx
     932:	0f b6 d3             	movzbl %bl,%edx
     935:	8b 45 0c             	mov    0xc(%ebp),%eax
     938:	01 d0                	add    %edx,%eax
     93a:	0f b6 10             	movzbl (%eax),%edx
     93d:	0f b6 f3             	movzbl %bl,%esi
     940:	8b 45 08             	mov    0x8(%ebp),%eax
     943:	01 f0                	add    %esi,%eax
     945:	31 ca                	xor    %ecx,%edx
     947:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     949:	89 d8                	mov    %ebx,%eax
     94b:	8d 58 01             	lea    0x1(%eax),%ebx
     94e:	80 fb 0f             	cmp    $0xf,%bl
     951:	76 d4                	jbe    927 <aes_addRoundKey+0xc>
    }
}
     953:	90                   	nop
     954:	90                   	nop
     955:	5b                   	pop    %ebx
     956:	5e                   	pop    %esi
     957:	5d                   	pop    %ebp
     958:	c3                   	ret    

00000959 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     959:	55                   	push   %ebp
     95a:	89 e5                	mov    %esp,%ebp
     95c:	56                   	push   %esi
     95d:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     95e:	bb 00 00 00 00       	mov    $0x0,%ebx
     963:	eb 5b                	jmp    9c0 <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     965:	0f b6 d3             	movzbl %bl,%edx
     968:	8b 45 0c             	mov    0xc(%ebp),%eax
     96b:	01 d0                	add    %edx,%eax
     96d:	0f b6 cb             	movzbl %bl,%ecx
     970:	8b 55 10             	mov    0x10(%ebp),%edx
     973:	01 ca                	add    %ecx,%edx
     975:	0f b6 00             	movzbl (%eax),%eax
     978:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     97a:	0f b6 d3             	movzbl %bl,%edx
     97d:	8b 45 08             	mov    0x8(%ebp),%eax
     980:	01 d0                	add    %edx,%eax
     982:	0f b6 08             	movzbl (%eax),%ecx
     985:	0f b6 d3             	movzbl %bl,%edx
     988:	8b 45 0c             	mov    0xc(%ebp),%eax
     98b:	01 d0                	add    %edx,%eax
     98d:	0f b6 10             	movzbl (%eax),%edx
     990:	0f b6 f3             	movzbl %bl,%esi
     993:	8b 45 08             	mov    0x8(%ebp),%eax
     996:	01 f0                	add    %esi,%eax
     998:	31 ca                	xor    %ecx,%edx
     99a:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     99c:	0f b6 c3             	movzbl %bl,%eax
     99f:	83 c0 10             	add    $0x10,%eax
     9a2:	89 c2                	mov    %eax,%edx
     9a4:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a7:	01 d0                	add    %edx,%eax
     9a9:	0f b6 d3             	movzbl %bl,%edx
     9ac:	83 c2 10             	add    $0x10,%edx
     9af:	89 d1                	mov    %edx,%ecx
     9b1:	8b 55 10             	mov    0x10(%ebp),%edx
     9b4:	01 ca                	add    %ecx,%edx
     9b6:	0f b6 00             	movzbl (%eax),%eax
     9b9:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     9bb:	89 d8                	mov    %ebx,%eax
     9bd:	8d 58 01             	lea    0x1(%eax),%ebx
     9c0:	80 fb 0f             	cmp    $0xf,%bl
     9c3:	76 a0                	jbe    965 <aes_addRoundKey_cpy+0xc>
    }
}
     9c5:	90                   	nop
     9c6:	90                   	nop
     9c7:	5b                   	pop    %ebx
     9c8:	5e                   	pop    %esi
     9c9:	5d                   	pop    %ebp
     9ca:	c3                   	ret    

000009cb <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     9cb:	55                   	push   %ebp
     9cc:	89 e5                	mov    %esp,%ebp
     9ce:	53                   	push   %ebx
     9cf:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     9d2:	8b 45 08             	mov    0x8(%ebp),%eax
     9d5:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     9d9:	8b 45 08             	mov    0x8(%ebp),%eax
     9dc:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     9e0:	88 45 fb             	mov    %al,-0x5(%ebp)
     9e3:	8b 45 08             	mov    0x8(%ebp),%eax
     9e6:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     9ea:	88 5d fa             	mov    %bl,-0x6(%ebp)
     9ed:	8b 45 08             	mov    0x8(%ebp),%eax
     9f0:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     9f4:	8b 45 08             	mov    0x8(%ebp),%eax
     9f7:	8d 50 01             	lea    0x1(%eax),%edx
     9fa:	8b 45 08             	mov    0x8(%ebp),%eax
     9fd:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     a01:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     a03:	8b 45 08             	mov    0x8(%ebp),%eax
     a06:	8d 50 05             	lea    0x5(%eax),%edx
     a09:	8b 45 08             	mov    0x8(%ebp),%eax
     a0c:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     a10:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     a12:	8b 45 08             	mov    0x8(%ebp),%eax
     a15:	8d 50 09             	lea    0x9(%eax),%edx
     a18:	8b 45 08             	mov    0x8(%ebp),%eax
     a1b:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     a1f:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     a21:	8b 45 08             	mov    0x8(%ebp),%eax
     a24:	83 c0 0d             	add    $0xd,%eax
     a27:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     a29:	8b 45 08             	mov    0x8(%ebp),%eax
     a2c:	8d 50 03             	lea    0x3(%eax),%edx
     a2f:	8b 45 08             	mov    0x8(%ebp),%eax
     a32:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     a36:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     a38:	8b 45 08             	mov    0x8(%ebp),%eax
     a3b:	8d 50 0f             	lea    0xf(%eax),%edx
     a3e:	8b 45 08             	mov    0x8(%ebp),%eax
     a41:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     a45:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     a47:	8b 45 08             	mov    0x8(%ebp),%eax
     a4a:	8d 50 0b             	lea    0xb(%eax),%edx
     a4d:	8b 45 08             	mov    0x8(%ebp),%eax
     a50:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     a54:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     a56:	8b 45 08             	mov    0x8(%ebp),%eax
     a59:	83 c0 07             	add    $0x7,%eax
     a5c:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     a60:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     a62:	8b 45 08             	mov    0x8(%ebp),%eax
     a65:	8d 50 0a             	lea    0xa(%eax),%edx
     a68:	8b 45 08             	mov    0x8(%ebp),%eax
     a6b:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     a6f:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     a71:	8b 45 08             	mov    0x8(%ebp),%eax
     a74:	83 c0 02             	add    $0x2,%eax
     a77:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     a7b:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     a7d:	8b 45 08             	mov    0x8(%ebp),%eax
     a80:	8d 50 0e             	lea    0xe(%eax),%edx
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     a8a:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     a8c:	8b 45 08             	mov    0x8(%ebp),%eax
     a8f:	83 c0 06             	add    $0x6,%eax
     a92:	88 18                	mov    %bl,(%eax)
}
     a94:	90                   	nop
     a95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a98:	c9                   	leave  
     a99:	c3                   	ret    

00000a9a <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     a9a:	55                   	push   %ebp
     a9b:	89 e5                	mov    %esp,%ebp
     a9d:	56                   	push   %esi
     a9e:	53                   	push   %ebx
     a9f:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     aa2:	bb 00 00 00 00       	mov    $0x0,%ebx
     aa7:	e9 42 01 00 00       	jmp    bee <aes_mixColumns+0x154>
        a = buf[i];
     aac:	0f b6 d3             	movzbl %bl,%edx
     aaf:	8b 45 08             	mov    0x8(%ebp),%eax
     ab2:	01 d0                	add    %edx,%eax
     ab4:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     ab7:	0f b6 c3             	movzbl %bl,%eax
     aba:	8d 50 01             	lea    0x1(%eax),%edx
     abd:	8b 45 08             	mov    0x8(%ebp),%eax
     ac0:	01 d0                	add    %edx,%eax
     ac2:	0f b6 10             	movzbl (%eax),%edx
     ac5:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     ac8:	0f b6 c3             	movzbl %bl,%eax
     acb:	8d 50 02             	lea    0x2(%eax),%edx
     ace:	8b 45 08             	mov    0x8(%ebp),%eax
     ad1:	01 d0                	add    %edx,%eax
     ad3:	0f b6 00             	movzbl (%eax),%eax
     ad6:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     ad9:	0f b6 c3             	movzbl %bl,%eax
     adc:	8d 50 03             	lea    0x3(%eax),%edx
     adf:	8b 45 08             	mov    0x8(%ebp),%eax
     ae2:	01 d0                	add    %edx,%eax
     ae4:	0f b6 00             	movzbl (%eax),%eax
     ae7:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     aea:	89 c8                	mov    %ecx,%eax
     aec:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     af0:	31 d0                	xor    %edx,%eax
     af2:	32 45 f6             	xor    -0xa(%ebp),%al
     af5:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     af9:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     afb:	88 4d f4             	mov    %cl,-0xc(%ebp)
     afe:	89 c8                	mov    %ecx,%eax
     b00:	88 55 f7             	mov    %dl,-0x9(%ebp)
     b03:	32 45 f7             	xor    -0x9(%ebp),%al
     b06:	0f b6 c0             	movzbl %al,%eax
     b09:	50                   	push   %eax
     b0a:	e8 a1 fd ff ff       	call   8b0 <rj_xtime>
     b0f:	83 c4 04             	add    $0x4,%esp
     b12:	31 f0                	xor    %esi,%eax
     b14:	0f b6 c8             	movzbl %al,%ecx
     b17:	0f b6 d3             	movzbl %bl,%edx
     b1a:	8b 45 08             	mov    0x8(%ebp),%eax
     b1d:	01 d0                	add    %edx,%eax
     b1f:	0f b6 00             	movzbl (%eax),%eax
     b22:	89 c2                	mov    %eax,%edx
     b24:	89 c8                	mov    %ecx,%eax
     b26:	89 d1                	mov    %edx,%ecx
     b28:	31 c1                	xor    %eax,%ecx
     b2a:	0f b6 d3             	movzbl %bl,%edx
     b2d:	8b 45 08             	mov    0x8(%ebp),%eax
     b30:	01 c2                	add    %eax,%edx
     b32:	89 c8                	mov    %ecx,%eax
     b34:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     b36:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     b3a:	32 55 f6             	xor    -0xa(%ebp),%dl
     b3d:	89 d0                	mov    %edx,%eax
     b3f:	0f b6 c0             	movzbl %al,%eax
     b42:	50                   	push   %eax
     b43:	e8 68 fd ff ff       	call   8b0 <rj_xtime>
     b48:	83 c4 04             	add    $0x4,%esp
     b4b:	31 f0                	xor    %esi,%eax
     b4d:	0f b6 c8             	movzbl %al,%ecx
     b50:	0f b6 c3             	movzbl %bl,%eax
     b53:	8d 50 01             	lea    0x1(%eax),%edx
     b56:	8b 45 08             	mov    0x8(%ebp),%eax
     b59:	01 d0                	add    %edx,%eax
     b5b:	0f b6 00             	movzbl (%eax),%eax
     b5e:	89 c2                	mov    %eax,%edx
     b60:	89 c8                	mov    %ecx,%eax
     b62:	31 c2                	xor    %eax,%edx
     b64:	89 d1                	mov    %edx,%ecx
     b66:	0f b6 c3             	movzbl %bl,%eax
     b69:	8d 50 01             	lea    0x1(%eax),%edx
     b6c:	8b 45 08             	mov    0x8(%ebp),%eax
     b6f:	01 c2                	add    %eax,%edx
     b71:	89 c8                	mov    %ecx,%eax
     b73:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     b75:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     b79:	32 45 f5             	xor    -0xb(%ebp),%al
     b7c:	0f b6 c0             	movzbl %al,%eax
     b7f:	50                   	push   %eax
     b80:	e8 2b fd ff ff       	call   8b0 <rj_xtime>
     b85:	83 c4 04             	add    $0x4,%esp
     b88:	31 f0                	xor    %esi,%eax
     b8a:	0f b6 d0             	movzbl %al,%edx
     b8d:	0f b6 c3             	movzbl %bl,%eax
     b90:	8d 48 02             	lea    0x2(%eax),%ecx
     b93:	8b 45 08             	mov    0x8(%ebp),%eax
     b96:	01 c8                	add    %ecx,%eax
     b98:	0f b6 00             	movzbl (%eax),%eax
     b9b:	89 c1                	mov    %eax,%ecx
     b9d:	89 d0                	mov    %edx,%eax
     b9f:	89 ca                	mov    %ecx,%edx
     ba1:	31 c2                	xor    %eax,%edx
     ba3:	0f b6 c3             	movzbl %bl,%eax
     ba6:	8d 48 02             	lea    0x2(%eax),%ecx
     ba9:	8b 45 08             	mov    0x8(%ebp),%eax
     bac:	01 c8                	add    %ecx,%eax
     bae:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     bb0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     bb4:	32 45 f4             	xor    -0xc(%ebp),%al
     bb7:	0f b6 c0             	movzbl %al,%eax
     bba:	50                   	push   %eax
     bbb:	e8 f0 fc ff ff       	call   8b0 <rj_xtime>
     bc0:	83 c4 04             	add    $0x4,%esp
     bc3:	31 f0                	xor    %esi,%eax
     bc5:	0f b6 d0             	movzbl %al,%edx
     bc8:	0f b6 c3             	movzbl %bl,%eax
     bcb:	8d 48 03             	lea    0x3(%eax),%ecx
     bce:	8b 45 08             	mov    0x8(%ebp),%eax
     bd1:	01 c8                	add    %ecx,%eax
     bd3:	0f b6 00             	movzbl (%eax),%eax
     bd6:	89 c1                	mov    %eax,%ecx
     bd8:	89 d0                	mov    %edx,%eax
     bda:	31 c1                	xor    %eax,%ecx
     bdc:	89 ca                	mov    %ecx,%edx
     bde:	0f b6 c3             	movzbl %bl,%eax
     be1:	8d 48 03             	lea    0x3(%eax),%ecx
     be4:	8b 45 08             	mov    0x8(%ebp),%eax
     be7:	01 c8                	add    %ecx,%eax
     be9:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     beb:	83 c3 04             	add    $0x4,%ebx
     bee:	80 fb 0f             	cmp    $0xf,%bl
     bf1:	0f 86 b5 fe ff ff    	jbe    aac <aes_mixColumns+0x12>
    }
}
     bf7:	90                   	nop
     bf8:	90                   	nop
     bf9:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bfc:	5b                   	pop    %ebx
     bfd:	5e                   	pop    %esi
     bfe:	5d                   	pop    %ebp
     bff:	c3                   	ret    

00000c00 <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	56                   	push   %esi
     c04:	53                   	push   %ebx
     c05:	83 ec 04             	sub    $0x4,%esp
     c08:	8b 45 0c             	mov    0xc(%ebp),%eax
     c0b:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     c0e:	8b 45 08             	mov    0x8(%ebp),%eax
     c11:	0f b6 10             	movzbl (%eax),%edx
     c14:	8b 45 08             	mov    0x8(%ebp),%eax
     c17:	83 c0 1d             	add    $0x1d,%eax
     c1a:	0f b6 00             	movzbl (%eax),%eax
     c1d:	0f b6 c0             	movzbl %al,%eax
     c20:	0f b6 80 40 20 00 00 	movzbl 0x2040(%eax),%eax
     c27:	32 45 f4             	xor    -0xc(%ebp),%al
     c2a:	31 c2                	xor    %eax,%edx
     c2c:	8b 45 08             	mov    0x8(%ebp),%eax
     c2f:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     c31:	8b 45 08             	mov    0x8(%ebp),%eax
     c34:	83 c0 01             	add    $0x1,%eax
     c37:	0f b6 08             	movzbl (%eax),%ecx
     c3a:	8b 45 08             	mov    0x8(%ebp),%eax
     c3d:	83 c0 1e             	add    $0x1e,%eax
     c40:	0f b6 00             	movzbl (%eax),%eax
     c43:	0f b6 c0             	movzbl %al,%eax
     c46:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     c4d:	8b 45 08             	mov    0x8(%ebp),%eax
     c50:	83 c0 01             	add    $0x1,%eax
     c53:	31 ca                	xor    %ecx,%edx
     c55:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     c57:	8b 45 08             	mov    0x8(%ebp),%eax
     c5a:	83 c0 02             	add    $0x2,%eax
     c5d:	0f b6 08             	movzbl (%eax),%ecx
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
     c63:	83 c0 1f             	add    $0x1f,%eax
     c66:	0f b6 00             	movzbl (%eax),%eax
     c69:	0f b6 c0             	movzbl %al,%eax
     c6c:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     c73:	8b 45 08             	mov    0x8(%ebp),%eax
     c76:	83 c0 02             	add    $0x2,%eax
     c79:	31 ca                	xor    %ecx,%edx
     c7b:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     c7d:	8b 45 08             	mov    0x8(%ebp),%eax
     c80:	83 c0 03             	add    $0x3,%eax
     c83:	0f b6 08             	movzbl (%eax),%ecx
     c86:	8b 45 08             	mov    0x8(%ebp),%eax
     c89:	83 c0 1c             	add    $0x1c,%eax
     c8c:	0f b6 00             	movzbl (%eax),%eax
     c8f:	0f b6 c0             	movzbl %al,%eax
     c92:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     c99:	8b 45 08             	mov    0x8(%ebp),%eax
     c9c:	83 c0 03             	add    $0x3,%eax
     c9f:	31 ca                	xor    %ecx,%edx
     ca1:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     ca3:	bb 04 00 00 00       	mov    $0x4,%ebx
     ca8:	e9 a9 00 00 00       	jmp    d56 <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     cad:	0f b6 d3             	movzbl %bl,%edx
     cb0:	8b 45 08             	mov    0x8(%ebp),%eax
     cb3:	01 d0                	add    %edx,%eax
     cb5:	0f b6 08             	movzbl (%eax),%ecx
     cb8:	0f b6 c3             	movzbl %bl,%eax
     cbb:	8d 50 fc             	lea    -0x4(%eax),%edx
     cbe:	8b 45 08             	mov    0x8(%ebp),%eax
     cc1:	01 d0                	add    %edx,%eax
     cc3:	0f b6 10             	movzbl (%eax),%edx
     cc6:	0f b6 f3             	movzbl %bl,%esi
     cc9:	8b 45 08             	mov    0x8(%ebp),%eax
     ccc:	01 f0                	add    %esi,%eax
     cce:	31 ca                	xor    %ecx,%edx
     cd0:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     cd2:	0f b6 c3             	movzbl %bl,%eax
     cd5:	8d 50 01             	lea    0x1(%eax),%edx
     cd8:	8b 45 08             	mov    0x8(%ebp),%eax
     cdb:	01 d0                	add    %edx,%eax
     cdd:	0f b6 08             	movzbl (%eax),%ecx
     ce0:	0f b6 c3             	movzbl %bl,%eax
     ce3:	8d 50 fd             	lea    -0x3(%eax),%edx
     ce6:	8b 45 08             	mov    0x8(%ebp),%eax
     ce9:	01 d0                	add    %edx,%eax
     ceb:	0f b6 10             	movzbl (%eax),%edx
     cee:	0f b6 c3             	movzbl %bl,%eax
     cf1:	8d 70 01             	lea    0x1(%eax),%esi
     cf4:	8b 45 08             	mov    0x8(%ebp),%eax
     cf7:	01 f0                	add    %esi,%eax
     cf9:	31 ca                	xor    %ecx,%edx
     cfb:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     cfd:	0f b6 c3             	movzbl %bl,%eax
     d00:	8d 50 02             	lea    0x2(%eax),%edx
     d03:	8b 45 08             	mov    0x8(%ebp),%eax
     d06:	01 d0                	add    %edx,%eax
     d08:	0f b6 08             	movzbl (%eax),%ecx
     d0b:	0f b6 c3             	movzbl %bl,%eax
     d0e:	8d 50 fe             	lea    -0x2(%eax),%edx
     d11:	8b 45 08             	mov    0x8(%ebp),%eax
     d14:	01 d0                	add    %edx,%eax
     d16:	0f b6 10             	movzbl (%eax),%edx
     d19:	0f b6 c3             	movzbl %bl,%eax
     d1c:	8d 70 02             	lea    0x2(%eax),%esi
     d1f:	8b 45 08             	mov    0x8(%ebp),%eax
     d22:	01 f0                	add    %esi,%eax
     d24:	31 ca                	xor    %ecx,%edx
     d26:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     d28:	0f b6 c3             	movzbl %bl,%eax
     d2b:	8d 50 03             	lea    0x3(%eax),%edx
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	01 d0                	add    %edx,%eax
     d33:	0f b6 08             	movzbl (%eax),%ecx
     d36:	0f b6 c3             	movzbl %bl,%eax
     d39:	8d 50 ff             	lea    -0x1(%eax),%edx
     d3c:	8b 45 08             	mov    0x8(%ebp),%eax
     d3f:	01 d0                	add    %edx,%eax
     d41:	0f b6 10             	movzbl (%eax),%edx
     d44:	0f b6 c3             	movzbl %bl,%eax
     d47:	8d 70 03             	lea    0x3(%eax),%esi
     d4a:	8b 45 08             	mov    0x8(%ebp),%eax
     d4d:	01 f0                	add    %esi,%eax
     d4f:	31 ca                	xor    %ecx,%edx
     d51:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     d53:	83 c3 04             	add    $0x4,%ebx
     d56:	80 fb 0f             	cmp    $0xf,%bl
     d59:	0f 86 4e ff ff ff    	jbe    cad <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     d5f:	8b 45 08             	mov    0x8(%ebp),%eax
     d62:	83 c0 10             	add    $0x10,%eax
     d65:	0f b6 08             	movzbl (%eax),%ecx
     d68:	8b 45 08             	mov    0x8(%ebp),%eax
     d6b:	83 c0 0c             	add    $0xc,%eax
     d6e:	0f b6 00             	movzbl (%eax),%eax
     d71:	0f b6 c0             	movzbl %al,%eax
     d74:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     d7b:	8b 45 08             	mov    0x8(%ebp),%eax
     d7e:	83 c0 10             	add    $0x10,%eax
     d81:	31 ca                	xor    %ecx,%edx
     d83:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     d85:	8b 45 08             	mov    0x8(%ebp),%eax
     d88:	83 c0 11             	add    $0x11,%eax
     d8b:	0f b6 08             	movzbl (%eax),%ecx
     d8e:	8b 45 08             	mov    0x8(%ebp),%eax
     d91:	83 c0 0d             	add    $0xd,%eax
     d94:	0f b6 00             	movzbl (%eax),%eax
     d97:	0f b6 c0             	movzbl %al,%eax
     d9a:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     da1:	8b 45 08             	mov    0x8(%ebp),%eax
     da4:	83 c0 11             	add    $0x11,%eax
     da7:	31 ca                	xor    %ecx,%edx
     da9:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     dab:	8b 45 08             	mov    0x8(%ebp),%eax
     dae:	83 c0 12             	add    $0x12,%eax
     db1:	0f b6 08             	movzbl (%eax),%ecx
     db4:	8b 45 08             	mov    0x8(%ebp),%eax
     db7:	83 c0 0e             	add    $0xe,%eax
     dba:	0f b6 00             	movzbl (%eax),%eax
     dbd:	0f b6 c0             	movzbl %al,%eax
     dc0:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     dc7:	8b 45 08             	mov    0x8(%ebp),%eax
     dca:	83 c0 12             	add    $0x12,%eax
     dcd:	31 ca                	xor    %ecx,%edx
     dcf:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
     dd1:	8b 45 08             	mov    0x8(%ebp),%eax
     dd4:	83 c0 13             	add    $0x13,%eax
     dd7:	0f b6 08             	movzbl (%eax),%ecx
     dda:	8b 45 08             	mov    0x8(%ebp),%eax
     ddd:	83 c0 0f             	add    $0xf,%eax
     de0:	0f b6 00             	movzbl (%eax),%eax
     de3:	0f b6 c0             	movzbl %al,%eax
     de6:	0f b6 90 40 20 00 00 	movzbl 0x2040(%eax),%edx
     ded:	8b 45 08             	mov    0x8(%ebp),%eax
     df0:	83 c0 13             	add    $0x13,%eax
     df3:	31 ca                	xor    %ecx,%edx
     df5:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
     df7:	bb 14 00 00 00       	mov    $0x14,%ebx
     dfc:	e9 a9 00 00 00       	jmp    eaa <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
     e01:	0f b6 d3             	movzbl %bl,%edx
     e04:	8b 45 08             	mov    0x8(%ebp),%eax
     e07:	01 d0                	add    %edx,%eax
     e09:	0f b6 08             	movzbl (%eax),%ecx
     e0c:	0f b6 c3             	movzbl %bl,%eax
     e0f:	8d 50 fc             	lea    -0x4(%eax),%edx
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	01 d0                	add    %edx,%eax
     e17:	0f b6 10             	movzbl (%eax),%edx
     e1a:	0f b6 f3             	movzbl %bl,%esi
     e1d:	8b 45 08             	mov    0x8(%ebp),%eax
     e20:	01 f0                	add    %esi,%eax
     e22:	31 ca                	xor    %ecx,%edx
     e24:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     e26:	0f b6 c3             	movzbl %bl,%eax
     e29:	8d 50 01             	lea    0x1(%eax),%edx
     e2c:	8b 45 08             	mov    0x8(%ebp),%eax
     e2f:	01 d0                	add    %edx,%eax
     e31:	0f b6 08             	movzbl (%eax),%ecx
     e34:	0f b6 c3             	movzbl %bl,%eax
     e37:	8d 50 fd             	lea    -0x3(%eax),%edx
     e3a:	8b 45 08             	mov    0x8(%ebp),%eax
     e3d:	01 d0                	add    %edx,%eax
     e3f:	0f b6 10             	movzbl (%eax),%edx
     e42:	0f b6 c3             	movzbl %bl,%eax
     e45:	8d 70 01             	lea    0x1(%eax),%esi
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	01 f0                	add    %esi,%eax
     e4d:	31 ca                	xor    %ecx,%edx
     e4f:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     e51:	0f b6 c3             	movzbl %bl,%eax
     e54:	8d 50 02             	lea    0x2(%eax),%edx
     e57:	8b 45 08             	mov    0x8(%ebp),%eax
     e5a:	01 d0                	add    %edx,%eax
     e5c:	0f b6 08             	movzbl (%eax),%ecx
     e5f:	0f b6 c3             	movzbl %bl,%eax
     e62:	8d 50 fe             	lea    -0x2(%eax),%edx
     e65:	8b 45 08             	mov    0x8(%ebp),%eax
     e68:	01 d0                	add    %edx,%eax
     e6a:	0f b6 10             	movzbl (%eax),%edx
     e6d:	0f b6 c3             	movzbl %bl,%eax
     e70:	8d 70 02             	lea    0x2(%eax),%esi
     e73:	8b 45 08             	mov    0x8(%ebp),%eax
     e76:	01 f0                	add    %esi,%eax
     e78:	31 ca                	xor    %ecx,%edx
     e7a:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     e7c:	0f b6 c3             	movzbl %bl,%eax
     e7f:	8d 50 03             	lea    0x3(%eax),%edx
     e82:	8b 45 08             	mov    0x8(%ebp),%eax
     e85:	01 d0                	add    %edx,%eax
     e87:	0f b6 08             	movzbl (%eax),%ecx
     e8a:	0f b6 c3             	movzbl %bl,%eax
     e8d:	8d 50 ff             	lea    -0x1(%eax),%edx
     e90:	8b 45 08             	mov    0x8(%ebp),%eax
     e93:	01 d0                	add    %edx,%eax
     e95:	0f b6 10             	movzbl (%eax),%edx
     e98:	0f b6 c3             	movzbl %bl,%eax
     e9b:	8d 70 03             	lea    0x3(%eax),%esi
     e9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ea1:	01 f0                	add    %esi,%eax
     ea3:	31 ca                	xor    %ecx,%edx
     ea5:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
     ea7:	83 c3 04             	add    $0x4,%ebx
     eaa:	80 fb 1f             	cmp    $0x1f,%bl
     ead:	0f 86 4e ff ff ff    	jbe    e01 <aes_expandEncKey+0x201>
    }
}
     eb3:	90                   	nop
     eb4:	90                   	nop
     eb5:	83 c4 04             	add    $0x4,%esp
     eb8:	5b                   	pop    %ebx
     eb9:	5e                   	pop    %esi
     eba:	5d                   	pop    %ebp
     ebb:	c3                   	ret    

00000ebc <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
     ebc:	55                   	push   %ebp
     ebd:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
     ebf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     ec3:	74 4d                	je     f12 <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
     ec5:	8b 45 08             	mov    0x8(%ebp),%eax
     ec8:	83 c0 03             	add    $0x3,%eax
     ecb:	0f b6 10             	movzbl (%eax),%edx
     ece:	83 c2 01             	add    $0x1,%edx
     ed1:	88 10                	mov    %dl,(%eax)
     ed3:	0f b6 00             	movzbl (%eax),%eax
     ed6:	84 c0                	test   %al,%al
     ed8:	75 38                	jne    f12 <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
     eda:	8b 45 08             	mov    0x8(%ebp),%eax
     edd:	83 c0 02             	add    $0x2,%eax
     ee0:	0f b6 10             	movzbl (%eax),%edx
     ee3:	83 c2 01             	add    $0x1,%edx
     ee6:	88 10                	mov    %dl,(%eax)
     ee8:	0f b6 00             	movzbl (%eax),%eax
     eeb:	84 c0                	test   %al,%al
     eed:	75 23                	jne    f12 <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
     eef:	8b 45 08             	mov    0x8(%ebp),%eax
     ef2:	83 c0 01             	add    $0x1,%eax
     ef5:	0f b6 10             	movzbl (%eax),%edx
     ef8:	83 c2 01             	add    $0x1,%edx
     efb:	88 10                	mov    %dl,(%eax)
     efd:	0f b6 00             	movzbl (%eax),%eax
     f00:	84 c0                	test   %al,%al
     f02:	75 0e                	jne    f12 <ctr_inc_ctr+0x56>
                    val[0]++;
     f04:	8b 45 08             	mov    0x8(%ebp),%eax
     f07:	0f b6 00             	movzbl (%eax),%eax
     f0a:	8d 50 01             	lea    0x1(%eax),%edx
     f0d:	8b 45 08             	mov    0x8(%ebp),%eax
     f10:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
     f12:	90                   	nop
     f13:	5d                   	pop    %ebp
     f14:	c3                   	ret    

00000f15 <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
     f15:	55                   	push   %ebp
     f16:	89 e5                	mov    %esp,%ebp
     f18:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
     f1b:	8b 45 08             	mov    0x8(%ebp),%eax
     f1e:	83 c0 40             	add    $0x40,%eax
     f21:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
     f24:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f28:	74 56                	je     f80 <ctr_clock_keystream+0x6b>
     f2a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f2e:	74 50                	je     f80 <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f30:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
     f34:	eb 21                	jmp    f57 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
     f36:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     f3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f3d:	01 d0                	add    %edx,%eax
     f3f:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
     f43:	8b 55 0c             	mov    0xc(%ebp),%edx
     f46:	01 ca                	add    %ecx,%edx
     f48:	0f b6 00             	movzbl (%eax),%eax
     f4b:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f4d:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     f51:	83 c0 01             	add    $0x1,%eax
     f54:	88 45 f7             	mov    %al,-0x9(%ebp)
     f57:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
     f5b:	76 d9                	jbe    f36 <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
     f5d:	83 ec 08             	sub    $0x8,%esp
     f60:	ff 75 0c             	push   0xc(%ebp)
     f63:	ff 75 08             	push   0x8(%ebp)
     f66:	e8 16 01 00 00       	call   1081 <aes256_encrypt_ecb>
     f6b:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
     f6e:	8b 45 08             	mov    0x8(%ebp),%eax
     f71:	83 c0 4c             	add    $0x4c,%eax
     f74:	83 ec 0c             	sub    $0xc,%esp
     f77:	50                   	push   %eax
     f78:	e8 3f ff ff ff       	call   ebc <ctr_inc_ctr>
     f7d:	83 c4 10             	add    $0x10,%esp
    }
}
     f80:	90                   	nop
     f81:	c9                   	leave  
     f82:	c3                   	ret    

00000f83 <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
     f83:	55                   	push   %ebp
     f84:	89 e5                	mov    %esp,%ebp
     f86:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
     f89:	8b 45 0c             	mov    0xc(%ebp),%eax
     f8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
     f8f:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
     f96:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
     f9d:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
     fa4:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
     fab:	83 ec 08             	sub    $0x8,%esp
     fae:	ff 75 08             	push   0x8(%ebp)
     fb1:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fb4:	50                   	push   %eax
     fb5:	e8 2e 00 00 00       	call   fe8 <aes256_init>
     fba:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
     fbd:	83 ec 08             	sub    $0x8,%esp
     fc0:	8d 45 94             	lea    -0x6c(%ebp),%eax
     fc3:	50                   	push   %eax
     fc4:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fc7:	50                   	push   %eax
     fc8:	e8 8d 01 00 00       	call   115a <aes256_setCtrBlk>
     fcd:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
     fd0:	83 ec 04             	sub    $0x4,%esp
     fd3:	ff 75 10             	push   0x10(%ebp)
     fd6:	ff 75 f4             	push   -0xc(%ebp)
     fd9:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fdc:	50                   	push   %eax
     fdd:	e8 c9 01 00 00       	call   11ab <aes256_encrypt_ctr>
     fe2:	83 c4 10             	add    $0x10,%esp
}
     fe5:	90                   	nop
     fe6:	c9                   	leave  
     fe7:	c3                   	ret    

00000fe8 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
     fe8:	55                   	push   %ebp
     fe9:	89 e5                	mov    %esp,%ebp
     feb:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
     fec:	bb 00 00 00 00       	mov    $0x0,%ebx
     ff1:	eb 1a                	jmp    100d <aes256_init+0x25>
        ctx->enckey[i] = key[i];
     ff3:	0f b6 d3             	movzbl %bl,%edx
     ff6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff9:	01 c2                	add    %eax,%edx
     ffb:	0f b6 c3             	movzbl %bl,%eax
     ffe:	0f b6 0a             	movzbl (%edx),%ecx
    1001:	8b 55 08             	mov    0x8(%ebp),%edx
    1004:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1008:	89 d8                	mov    %ebx,%eax
    100a:	8d 58 01             	lea    0x1(%eax),%ebx
    100d:	80 fb 1f             	cmp    $0x1f,%bl
    1010:	76 e1                	jbe    ff3 <aes256_init+0xb>
    }
}
    1012:	90                   	nop
    1013:	90                   	nop
    1014:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1017:	c9                   	leave  
    1018:	c3                   	ret    

00001019 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    1019:	55                   	push   %ebp
    101a:	89 e5                	mov    %esp,%ebp
    101c:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    101d:	bb 00 00 00 00       	mov    $0x0,%ebx
    1022:	eb 51                	jmp    1075 <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    1024:	0f b6 c3             	movzbl %bl,%eax
    1027:	8b 55 08             	mov    0x8(%ebp),%edx
    102a:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    102f:	0f b6 d3             	movzbl %bl,%edx
    1032:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1035:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    103a:	8b 45 08             	mov    0x8(%ebp),%eax
    103d:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    1040:	0f b6 c3             	movzbl %bl,%eax
    1043:	83 e0 03             	and    $0x3,%eax
    1046:	89 c2                	mov    %eax,%edx
    1048:	8b 45 08             	mov    0x8(%ebp),%eax
    104b:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    1050:	0f b6 c3             	movzbl %bl,%eax
    1053:	83 e0 07             	and    $0x7,%eax
    1056:	89 c2                	mov    %eax,%edx
    1058:	8b 45 08             	mov    0x8(%ebp),%eax
    105b:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    1060:	0f b6 c3             	movzbl %bl,%eax
    1063:	83 e0 03             	and    $0x3,%eax
    1066:	89 c2                	mov    %eax,%edx
    1068:	8b 45 08             	mov    0x8(%ebp),%eax
    106b:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1070:	89 d8                	mov    %ebx,%eax
    1072:	8d 58 01             	lea    0x1(%eax),%ebx
    1075:	80 fb 1f             	cmp    $0x1f,%bl
    1078:	76 aa                	jbe    1024 <aes256_done+0xb>
    }
}
    107a:	90                   	nop
    107b:	90                   	nop
    107c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    107f:	c9                   	leave  
    1080:	c3                   	ret    

00001081 <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    1081:	55                   	push   %ebp
    1082:	89 e5                	mov    %esp,%ebp
    1084:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    1087:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    108b:	8b 45 08             	mov    0x8(%ebp),%eax
    108e:	8b 55 08             	mov    0x8(%ebp),%edx
    1091:	83 c2 20             	add    $0x20,%edx
    1094:	50                   	push   %eax
    1095:	52                   	push   %edx
    1096:	ff 75 0c             	push   0xc(%ebp)
    1099:	e8 bb f8 ff ff       	call   959 <aes_addRoundKey_cpy>
    109e:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    10a1:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    10a5:	eb 74                	jmp    111b <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    10a7:	ff 75 0c             	push   0xc(%ebp)
    10aa:	e8 31 f8 ff ff       	call   8e0 <aes_subBytes>
    10af:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    10b2:	ff 75 0c             	push   0xc(%ebp)
    10b5:	e8 11 f9 ff ff       	call   9cb <aes_shiftRows>
    10ba:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    10bd:	ff 75 0c             	push   0xc(%ebp)
    10c0:	e8 d5 f9 ff ff       	call   a9a <aes_mixColumns>
    10c5:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    10c8:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    10cc:	83 e0 01             	and    $0x1,%eax
    10cf:	85 c0                	test   %eax,%eax
    10d1:	74 14                	je     10e7 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    10d3:	8b 45 08             	mov    0x8(%ebp),%eax
    10d6:	83 c0 10             	add    $0x10,%eax
    10d9:	50                   	push   %eax
    10da:	ff 75 0c             	push   0xc(%ebp)
    10dd:	e8 39 f8 ff ff       	call   91b <aes_addRoundKey>
    10e2:	83 c4 08             	add    $0x8,%esp
    10e5:	eb 30                	jmp    1117 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    10e7:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    10eb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ee:	52                   	push   %edx
    10ef:	50                   	push   %eax
    10f0:	e8 0b fb ff ff       	call   c00 <aes_expandEncKey>
    10f5:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    10f8:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    10fc:	50                   	push   %eax
    10fd:	e8 ae f7 ff ff       	call   8b0 <rj_xtime>
    1102:	83 c4 04             	add    $0x4,%esp
    1105:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    1108:	8b 45 08             	mov    0x8(%ebp),%eax
    110b:	50                   	push   %eax
    110c:	ff 75 0c             	push   0xc(%ebp)
    110f:	e8 07 f8 ff ff       	call   91b <aes_addRoundKey>
    1114:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    1117:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    111b:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    111f:	76 86                	jbe    10a7 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    1121:	ff 75 0c             	push   0xc(%ebp)
    1124:	e8 b7 f7 ff ff       	call   8e0 <aes_subBytes>
    1129:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    112c:	ff 75 0c             	push   0xc(%ebp)
    112f:	e8 97 f8 ff ff       	call   9cb <aes_shiftRows>
    1134:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    1137:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	52                   	push   %edx
    113f:	50                   	push   %eax
    1140:	e8 bb fa ff ff       	call   c00 <aes_expandEncKey>
    1145:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    1148:	8b 45 08             	mov    0x8(%ebp),%eax
    114b:	50                   	push   %eax
    114c:	ff 75 0c             	push   0xc(%ebp)
    114f:	e8 c7 f7 ff ff       	call   91b <aes_addRoundKey>
    1154:	83 c4 08             	add    $0x8,%esp
}
    1157:	90                   	nop
    1158:	c9                   	leave  
    1159:	c3                   	ret    

0000115a <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    115a:	55                   	push   %ebp
    115b:	89 e5                	mov    %esp,%ebp
    115d:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	83 c0 40             	add    $0x40,%eax
    1166:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    1169:	8b 45 0c             	mov    0xc(%ebp),%eax
    116c:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    116f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1173:	74 33                	je     11a8 <aes256_setCtrBlk+0x4e>
    1175:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1179:	74 2d                	je     11a8 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    117b:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    117f:	eb 21                	jmp    11a2 <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    1181:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1185:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1188:	01 d0                	add    %edx,%eax
    118a:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    118e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1191:	01 ca                	add    %ecx,%edx
    1193:	0f b6 00             	movzbl (%eax),%eax
    1196:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1198:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    119c:	83 c0 01             	add    $0x1,%eax
    119f:	88 45 ff             	mov    %al,-0x1(%ebp)
    11a2:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    11a6:	76 d9                	jbe    1181 <aes256_setCtrBlk+0x27>
        }
    }
}
    11a8:	90                   	nop
    11a9:	c9                   	leave  
    11aa:	c3                   	ret    

000011ab <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    11ab:	55                   	push   %ebp
    11ac:	89 e5                	mov    %esp,%ebp
    11ae:	53                   	push   %ebx
    11af:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    11b2:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    11b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11bd:	eb 49                	jmp    1208 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    11bf:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    11c3:	75 16                	jne    11db <aes256_encrypt_ctr+0x30>
            j = 0;
    11c5:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    11c9:	83 ec 08             	sub    $0x8,%esp
    11cc:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    11cf:	50                   	push   %eax
    11d0:	ff 75 08             	push   0x8(%ebp)
    11d3:	e8 3d fd ff ff       	call   f15 <ctr_clock_keystream>
    11d8:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    11db:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    11df:	8d 50 01             	lea    0x1(%eax),%edx
    11e2:	88 55 f3             	mov    %dl,-0xd(%ebp)
    11e5:	0f b6 c0             	movzbl %al,%eax
    11e8:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    11ed:	8b 55 0c             	mov    0xc(%ebp),%edx
    11f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11f3:	01 d0                	add    %edx,%eax
    11f5:	0f b6 10             	movzbl (%eax),%edx
    11f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    11fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11fe:	01 d8                	add    %ebx,%eax
    1200:	31 ca                	xor    %ecx,%edx
    1202:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    1204:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1208:	8b 45 f4             	mov    -0xc(%ebp),%eax
    120b:	3b 45 10             	cmp    0x10(%ebp),%eax
    120e:	72 af                	jb     11bf <aes256_encrypt_ctr+0x14>
    }
}
    1210:	90                   	nop
    1211:	90                   	nop
    1212:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1215:	c9                   	leave  
    1216:	c3                   	ret    

00001217 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    1217:	55                   	push   %ebp
    1218:	89 e5                	mov    %esp,%ebp
    121a:	8b 45 0c             	mov    0xc(%ebp),%eax
    121d:	83 e0 1f             	and    $0x1f,%eax
    1220:	8b 55 08             	mov    0x8(%ebp),%edx
    1223:	89 c1                	mov    %eax,%ecx
    1225:	d3 ea                	shr    %cl,%edx
    1227:	89 d0                	mov    %edx,%eax
    1229:	5d                   	pop    %ebp
    122a:	c3                   	ret    

0000122b <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    122b:	55                   	push   %ebp
    122c:	89 e5                	mov    %esp,%ebp
    122e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1231:	83 e0 1f             	and    $0x1f,%eax
    1234:	8b 55 08             	mov    0x8(%ebp),%edx
    1237:	89 c1                	mov    %eax,%ecx
    1239:	d3 e2                	shl    %cl,%edx
    123b:	89 d0                	mov    %edx,%eax
    123d:	5d                   	pop    %ebp
    123e:	c3                   	ret    

0000123f <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    123f:	55                   	push   %ebp
    1240:	89 e5                	mov    %esp,%ebp
    1242:	53                   	push   %ebx
    1243:	83 ec 04             	sub    $0x4,%esp
    1246:	8b 45 0c             	mov    0xc(%ebp),%eax
    1249:	88 45 f8             	mov    %al,-0x8(%ebp)
    124c:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    1250:	8b 55 08             	mov    0x8(%ebp),%edx
    1253:	89 d3                	mov    %edx,%ebx
    1255:	89 c1                	mov    %eax,%ecx
    1257:	d3 eb                	shr    %cl,%ebx
    1259:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    125d:	b8 20 00 00 00       	mov    $0x20,%eax
    1262:	29 d0                	sub    %edx,%eax
    1264:	50                   	push   %eax
    1265:	ff 75 08             	push   0x8(%ebp)
    1268:	e8 be ff ff ff       	call   122b <_shw>
    126d:	83 c4 08             	add    $0x8,%esp
    1270:	09 d8                	or     %ebx,%eax
    1272:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1275:	c9                   	leave  
    1276:	c3                   	ret    

00001277 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    1277:	55                   	push   %ebp
    1278:	89 e5                	mov    %esp,%ebp
    127a:	8b 45 08             	mov    0x8(%ebp),%eax
    127d:	23 45 0c             	and    0xc(%ebp),%eax
    1280:	89 c2                	mov    %eax,%edx
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	f7 d0                	not    %eax
    1287:	23 45 10             	and    0x10(%ebp),%eax
    128a:	31 d0                	xor    %edx,%eax
    128c:	5d                   	pop    %ebp
    128d:	c3                   	ret    

0000128e <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    128e:	55                   	push   %ebp
    128f:	89 e5                	mov    %esp,%ebp
    1291:	8b 45 0c             	mov    0xc(%ebp),%eax
    1294:	33 45 10             	xor    0x10(%ebp),%eax
    1297:	23 45 08             	and    0x8(%ebp),%eax
    129a:	89 c2                	mov    %eax,%edx
    129c:	8b 45 0c             	mov    0xc(%ebp),%eax
    129f:	23 45 10             	and    0x10(%ebp),%eax
    12a2:	31 d0                	xor    %edx,%eax
    12a4:	5d                   	pop    %ebp
    12a5:	c3                   	ret    

000012a6 <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    12a6:	55                   	push   %ebp
    12a7:	89 e5                	mov    %esp,%ebp
    12a9:	53                   	push   %ebx
    12aa:	6a 02                	push   $0x2
    12ac:	ff 75 08             	push   0x8(%ebp)
    12af:	e8 8b ff ff ff       	call   123f <_r>
    12b4:	83 c4 08             	add    $0x8,%esp
    12b7:	89 c3                	mov    %eax,%ebx
    12b9:	6a 0d                	push   $0xd
    12bb:	ff 75 08             	push   0x8(%ebp)
    12be:	e8 7c ff ff ff       	call   123f <_r>
    12c3:	83 c4 08             	add    $0x8,%esp
    12c6:	31 c3                	xor    %eax,%ebx
    12c8:	6a 16                	push   $0x16
    12ca:	ff 75 08             	push   0x8(%ebp)
    12cd:	e8 6d ff ff ff       	call   123f <_r>
    12d2:	83 c4 08             	add    $0x8,%esp
    12d5:	31 d8                	xor    %ebx,%eax
    12d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12da:	c9                   	leave  
    12db:	c3                   	ret    

000012dc <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    12dc:	55                   	push   %ebp
    12dd:	89 e5                	mov    %esp,%ebp
    12df:	53                   	push   %ebx
    12e0:	6a 06                	push   $0x6
    12e2:	ff 75 08             	push   0x8(%ebp)
    12e5:	e8 55 ff ff ff       	call   123f <_r>
    12ea:	83 c4 08             	add    $0x8,%esp
    12ed:	89 c3                	mov    %eax,%ebx
    12ef:	6a 0b                	push   $0xb
    12f1:	ff 75 08             	push   0x8(%ebp)
    12f4:	e8 46 ff ff ff       	call   123f <_r>
    12f9:	83 c4 08             	add    $0x8,%esp
    12fc:	31 c3                	xor    %eax,%ebx
    12fe:	6a 19                	push   $0x19
    1300:	ff 75 08             	push   0x8(%ebp)
    1303:	e8 37 ff ff ff       	call   123f <_r>
    1308:	83 c4 08             	add    $0x8,%esp
    130b:	31 d8                	xor    %ebx,%eax
    130d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1310:	c9                   	leave  
    1311:	c3                   	ret    

00001312 <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    1312:	55                   	push   %ebp
    1313:	89 e5                	mov    %esp,%ebp
    1315:	53                   	push   %ebx
    1316:	6a 07                	push   $0x7
    1318:	ff 75 08             	push   0x8(%ebp)
    131b:	e8 1f ff ff ff       	call   123f <_r>
    1320:	83 c4 08             	add    $0x8,%esp
    1323:	89 c3                	mov    %eax,%ebx
    1325:	6a 12                	push   $0x12
    1327:	ff 75 08             	push   0x8(%ebp)
    132a:	e8 10 ff ff ff       	call   123f <_r>
    132f:	83 c4 08             	add    $0x8,%esp
    1332:	89 da                	mov    %ebx,%edx
    1334:	31 c2                	xor    %eax,%edx
    1336:	8b 45 08             	mov    0x8(%ebp),%eax
    1339:	c1 e8 03             	shr    $0x3,%eax
    133c:	31 d0                	xor    %edx,%eax
    133e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1341:	c9                   	leave  
    1342:	c3                   	ret    

00001343 <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    1343:	55                   	push   %ebp
    1344:	89 e5                	mov    %esp,%ebp
    1346:	53                   	push   %ebx
    1347:	6a 11                	push   $0x11
    1349:	ff 75 08             	push   0x8(%ebp)
    134c:	e8 ee fe ff ff       	call   123f <_r>
    1351:	83 c4 08             	add    $0x8,%esp
    1354:	89 c3                	mov    %eax,%ebx
    1356:	6a 13                	push   $0x13
    1358:	ff 75 08             	push   0x8(%ebp)
    135b:	e8 df fe ff ff       	call   123f <_r>
    1360:	83 c4 08             	add    $0x8,%esp
    1363:	89 da                	mov    %ebx,%edx
    1365:	31 c2                	xor    %eax,%edx
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
    136a:	c1 e8 0a             	shr    $0xa,%eax
    136d:	31 d0                	xor    %edx,%eax
    136f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1372:	c9                   	leave  
    1373:	c3                   	ret    

00001374 <_word>:

FN_ uint _word(uchar* c) {
    1374:	55                   	push   %ebp
    1375:	89 e5                	mov    %esp,%ebp
    1377:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    1378:	8b 45 08             	mov    0x8(%ebp),%eax
    137b:	0f b6 00             	movzbl (%eax),%eax
    137e:	0f b6 c0             	movzbl %al,%eax
    1381:	6a 18                	push   $0x18
    1383:	50                   	push   %eax
    1384:	e8 a2 fe ff ff       	call   122b <_shw>
    1389:	83 c4 08             	add    $0x8,%esp
    138c:	89 c3                	mov    %eax,%ebx
    138e:	8b 45 08             	mov    0x8(%ebp),%eax
    1391:	83 c0 01             	add    $0x1,%eax
    1394:	0f b6 00             	movzbl (%eax),%eax
    1397:	0f b6 c0             	movzbl %al,%eax
    139a:	6a 10                	push   $0x10
    139c:	50                   	push   %eax
    139d:	e8 89 fe ff ff       	call   122b <_shw>
    13a2:	83 c4 08             	add    $0x8,%esp
    13a5:	09 c3                	or     %eax,%ebx
    13a7:	8b 45 08             	mov    0x8(%ebp),%eax
    13aa:	83 c0 02             	add    $0x2,%eax
    13ad:	0f b6 00             	movzbl (%eax),%eax
    13b0:	0f b6 c0             	movzbl %al,%eax
    13b3:	6a 08                	push   $0x8
    13b5:	50                   	push   %eax
    13b6:	e8 70 fe ff ff       	call   122b <_shw>
    13bb:	83 c4 08             	add    $0x8,%esp
    13be:	89 da                	mov    %ebx,%edx
    13c0:	09 c2                	or     %eax,%edx
    13c2:	8b 45 08             	mov    0x8(%ebp),%eax
    13c5:	83 c0 03             	add    $0x3,%eax
    13c8:	0f b6 00             	movzbl (%eax),%eax
    13cb:	0f b6 c0             	movzbl %al,%eax
    13ce:	09 d0                	or     %edx,%eax
}
    13d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13d3:	c9                   	leave  
    13d4:	c3                   	ret    

000013d5 <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    13d5:	55                   	push   %ebp
    13d6:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	8b 40 60             	mov    0x60(%eax),%eax
    13de:	8b 55 0c             	mov    0xc(%ebp),%edx
    13e1:	f7 d2                	not    %edx
    13e3:	39 d0                	cmp    %edx,%eax
    13e5:	76 0f                	jbe    13f6 <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    13e7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ea:	8b 40 64             	mov    0x64(%eax),%eax
    13ed:	8d 50 01             	lea    0x1(%eax),%edx
    13f0:	8b 45 08             	mov    0x8(%ebp),%eax
    13f3:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    13f6:	8b 45 08             	mov    0x8(%ebp),%eax
    13f9:	8b 50 60             	mov    0x60(%eax),%edx
    13fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ff:	01 c2                	add    %eax,%edx
    1401:	8b 45 08             	mov    0x8(%ebp),%eax
    1404:	89 50 60             	mov    %edx,0x60(%eax)
}
    1407:	90                   	nop
    1408:	5d                   	pop    %ebp
    1409:	c3                   	ret    

0000140a <_hash>:

static void _hash(sha256_context* ctx) {
    140a:	55                   	push   %ebp
    140b:	89 e5                	mov    %esp,%ebp
    140d:	57                   	push   %edi
    140e:	56                   	push   %esi
    140f:	53                   	push   %ebx
    1410:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    1413:	8b 45 08             	mov    0x8(%ebp),%eax
    1416:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
    141c:	8b 40 44             	mov    0x44(%eax),%eax
    141f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	8b 40 48             	mov    0x48(%eax),%eax
    1428:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    142b:	8b 45 08             	mov    0x8(%ebp),%eax
    142e:	8b 40 4c             	mov    0x4c(%eax),%eax
    1431:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    1434:	8b 45 08             	mov    0x8(%ebp),%eax
    1437:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    143a:	8b 45 08             	mov    0x8(%ebp),%eax
    143d:	8b 40 54             	mov    0x54(%eax),%eax
    1440:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	8b 40 58             	mov    0x58(%eax),%eax
    1449:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    144c:	8b 45 08             	mov    0x8(%ebp),%eax
    144f:	8b 40 5c             	mov    0x5c(%eax),%eax
    1452:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    1455:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    145c:	e9 27 01 00 00       	jmp    1588 <_hash+0x17e>
        if (i < 16) {
    1461:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    1465:	77 2d                	ja     1494 <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    1467:	6a 02                	push   $0x2
    1469:	ff 75 f0             	push   -0x10(%ebp)
    146c:	e8 ba fd ff ff       	call   122b <_shw>
    1471:	83 c4 08             	add    $0x8,%esp
    1474:	89 c2                	mov    %eax,%edx
    1476:	8b 45 08             	mov    0x8(%ebp),%eax
    1479:	01 d0                	add    %edx,%eax
    147b:	50                   	push   %eax
    147c:	e8 f3 fe ff ff       	call   1374 <_word>
    1481:	83 c4 04             	add    $0x4,%esp
    1484:	89 c1                	mov    %eax,%ecx
    1486:	8b 55 08             	mov    0x8(%ebp),%edx
    1489:	8b 45 f0             	mov    -0x10(%ebp),%eax
    148c:	83 c0 1c             	add    $0x1c,%eax
    148f:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    1492:	eb 64                	jmp    14f8 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1494:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1497:	83 e8 02             	sub    $0x2,%eax
    149a:	8b 55 08             	mov    0x8(%ebp),%edx
    149d:	83 c0 1c             	add    $0x1c,%eax
    14a0:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14a3:	50                   	push   %eax
    14a4:	e8 9a fe ff ff       	call   1343 <_G1>
    14a9:	83 c4 04             	add    $0x4,%esp
    14ac:	89 c1                	mov    %eax,%ecx
    14ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14b1:	83 e8 07             	sub    $0x7,%eax
    14b4:	8b 55 08             	mov    0x8(%ebp),%edx
    14b7:	83 c0 1c             	add    $0x1c,%eax
    14ba:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14bd:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    14c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c3:	83 e8 0f             	sub    $0xf,%eax
    14c6:	8b 55 08             	mov    0x8(%ebp),%edx
    14c9:	83 c0 1c             	add    $0x1c,%eax
    14cc:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14cf:	50                   	push   %eax
    14d0:	e8 3d fe ff ff       	call   1312 <_G0>
    14d5:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    14d8:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    14db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14de:	83 e8 10             	sub    $0x10,%eax
    14e1:	8b 55 08             	mov    0x8(%ebp),%edx
    14e4:	83 c0 1c             	add    $0x1c,%eax
    14e7:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14ea:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    14ec:	8b 55 08             	mov    0x8(%ebp),%edx
    14ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14f2:	83 c0 1c             	add    $0x1c,%eax
    14f5:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    14f8:	57                   	push   %edi
    14f9:	e8 de fd ff ff       	call   12dc <_S1>
    14fe:	83 c4 04             	add    $0x4,%esp
    1501:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    1504:	01 c3                	add    %eax,%ebx
    1506:	ff 75 d4             	push   -0x2c(%ebp)
    1509:	ff 75 d8             	push   -0x28(%ebp)
    150c:	57                   	push   %edi
    150d:	e8 65 fd ff ff       	call   1277 <_Ch>
    1512:	83 c4 0c             	add    $0xc,%esp
    1515:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    1518:	8b 45 f0             	mov    -0x10(%ebp),%eax
    151b:	8b 04 85 40 21 00 00 	mov    0x2140(,%eax,4),%eax
    1522:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1525:	8b 55 08             	mov    0x8(%ebp),%edx
    1528:	8b 45 f0             	mov    -0x10(%ebp),%eax
    152b:	83 c0 1c             	add    $0x1c,%eax
    152e:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1531:	01 c8                	add    %ecx,%eax
    1533:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    1536:	56                   	push   %esi
    1537:	e8 6a fd ff ff       	call   12a6 <_S0>
    153c:	83 c4 04             	add    $0x4,%esp
    153f:	89 c3                	mov    %eax,%ebx
    1541:	ff 75 dc             	push   -0x24(%ebp)
    1544:	ff 75 e0             	push   -0x20(%ebp)
    1547:	56                   	push   %esi
    1548:	e8 41 fd ff ff       	call   128e <_Ma>
    154d:	83 c4 0c             	add    $0xc,%esp
    1550:	01 d8                	add    %ebx,%eax
    1552:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    1555:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1558:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    155b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    155e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    1561:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    1564:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1567:	8b 7d d0             	mov    -0x30(%ebp),%edi
    156a:	01 c7                	add    %eax,%edi
        d = c;
    156c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    156f:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    1572:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1575:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    1578:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    157b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    157e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1581:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    1584:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1588:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    158c:	0f 86 cf fe ff ff    	jbe    1461 <_hash+0x57>
    }

    ctx->hash[0] += a;
    1592:	8b 45 08             	mov    0x8(%ebp),%eax
    1595:	8b 40 40             	mov    0x40(%eax),%eax
    1598:	8d 14 06             	lea    (%esi,%eax,1),%edx
    159b:	8b 45 08             	mov    0x8(%ebp),%eax
    159e:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    15a1:	8b 45 08             	mov    0x8(%ebp),%eax
    15a4:	8b 40 44             	mov    0x44(%eax),%eax
    15a7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    15aa:	01 c2                	add    %eax,%edx
    15ac:	8b 45 08             	mov    0x8(%ebp),%eax
    15af:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    15b2:	8b 45 08             	mov    0x8(%ebp),%eax
    15b5:	8b 40 48             	mov    0x48(%eax),%eax
    15b8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    15bb:	01 c2                	add    %eax,%edx
    15bd:	8b 45 08             	mov    0x8(%ebp),%eax
    15c0:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    15c3:	8b 45 08             	mov    0x8(%ebp),%eax
    15c6:	8b 40 4c             	mov    0x4c(%eax),%eax
    15c9:	8b 55 d0             	mov    -0x30(%ebp),%edx
    15cc:	01 c2                	add    %eax,%edx
    15ce:	8b 45 08             	mov    0x8(%ebp),%eax
    15d1:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    15d4:	8b 45 08             	mov    0x8(%ebp),%eax
    15d7:	8b 40 50             	mov    0x50(%eax),%eax
    15da:	8d 14 07             	lea    (%edi,%eax,1),%edx
    15dd:	8b 45 08             	mov    0x8(%ebp),%eax
    15e0:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    15e3:	8b 45 08             	mov    0x8(%ebp),%eax
    15e6:	8b 40 54             	mov    0x54(%eax),%eax
    15e9:	8b 55 d8             	mov    -0x28(%ebp),%edx
    15ec:	01 c2                	add    %eax,%edx
    15ee:	8b 45 08             	mov    0x8(%ebp),%eax
    15f1:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    15f4:	8b 45 08             	mov    0x8(%ebp),%eax
    15f7:	8b 40 58             	mov    0x58(%eax),%eax
    15fa:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    15fd:	01 c2                	add    %eax,%edx
    15ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1602:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    1605:	8b 45 08             	mov    0x8(%ebp),%eax
    1608:	8b 40 5c             	mov    0x5c(%eax),%eax
    160b:	8b 55 cc             	mov    -0x34(%ebp),%edx
    160e:	01 c2                	add    %eax,%edx
    1610:	8b 45 08             	mov    0x8(%ebp),%eax
    1613:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    1616:	90                   	nop
    1617:	8d 65 f4             	lea    -0xc(%ebp),%esp
    161a:	5b                   	pop    %ebx
    161b:	5e                   	pop    %esi
    161c:	5f                   	pop    %edi
    161d:	5d                   	pop    %ebp
    161e:	c3                   	ret    

0000161f <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    161f:	55                   	push   %ebp
    1620:	89 e5                	mov    %esp,%ebp
    1622:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    1628:	83 ec 0c             	sub    $0xc,%esp
    162b:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1631:	50                   	push   %eax
    1632:	e8 33 00 00 00       	call   166a <sha256_init>
    1637:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    163a:	83 ec 04             	sub    $0x4,%esp
    163d:	ff 75 0c             	push   0xc(%ebp)
    1640:	ff 75 08             	push   0x8(%ebp)
    1643:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1649:	50                   	push   %eax
    164a:	e8 99 00 00 00       	call   16e8 <sha256_hash>
    164f:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    1652:	83 ec 08             	sub    $0x8,%esp
    1655:	ff 75 10             	push   0x10(%ebp)
    1658:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    165e:	50                   	push   %eax
    165f:	e8 14 01 00 00       	call   1778 <sha256_done>
    1664:	83 c4 10             	add    $0x10,%esp
}
    1667:	90                   	nop
    1668:	c9                   	leave  
    1669:	c3                   	ret    

0000166a <sha256_init>:

void sha256_init(sha256_context* ctx) {
    166a:	55                   	push   %ebp
    166b:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    166d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1671:	74 72                	je     16e5 <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    1673:	8b 45 08             	mov    0x8(%ebp),%eax
    1676:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	8b 50 68             	mov    0x68(%eax),%edx
    1683:	8b 45 08             	mov    0x8(%ebp),%eax
    1686:	89 50 64             	mov    %edx,0x64(%eax)
    1689:	8b 45 08             	mov    0x8(%ebp),%eax
    168c:	8b 50 64             	mov    0x64(%eax),%edx
    168f:	8b 45 08             	mov    0x8(%ebp),%eax
    1692:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    1695:	8b 45 08             	mov    0x8(%ebp),%eax
    1698:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    169f:	8b 45 08             	mov    0x8(%ebp),%eax
    16a2:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ac:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    16b3:	8b 45 08             	mov    0x8(%ebp),%eax
    16b6:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    16bd:	8b 45 08             	mov    0x8(%ebp),%eax
    16c0:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    16c7:	8b 45 08             	mov    0x8(%ebp),%eax
    16ca:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    16d1:	8b 45 08             	mov    0x8(%ebp),%eax
    16d4:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    16db:	8b 45 08             	mov    0x8(%ebp),%eax
    16de:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    16e5:	90                   	nop
    16e6:	5d                   	pop    %ebp
    16e7:	c3                   	ret    

000016e8 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    16e8:	55                   	push   %ebp
    16e9:	89 e5                	mov    %esp,%ebp
    16eb:	53                   	push   %ebx
    16ec:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    16ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    16f2:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    16f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    16f9:	74 77                	je     1772 <sha256_hash+0x8a>
    16fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16ff:	74 71                	je     1772 <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    1701:	8b 45 08             	mov    0x8(%ebp),%eax
    1704:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    1707:	83 f8 3f             	cmp    $0x3f,%eax
    170a:	77 66                	ja     1772 <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    170c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    1713:	eb 55                	jmp    176a <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    1715:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1718:	8b 45 f8             	mov    -0x8(%ebp),%eax
    171b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    171e:	8b 45 08             	mov    0x8(%ebp),%eax
    1721:	8b 40 68             	mov    0x68(%eax),%eax
    1724:	8d 48 01             	lea    0x1(%eax),%ecx
    1727:	8b 55 08             	mov    0x8(%ebp),%edx
    172a:	89 4a 68             	mov    %ecx,0x68(%edx)
    172d:	0f b6 0b             	movzbl (%ebx),%ecx
    1730:	8b 55 08             	mov    0x8(%ebp),%edx
    1733:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	8b 40 68             	mov    0x68(%eax),%eax
    173c:	83 f8 40             	cmp    $0x40,%eax
    173f:	75 25                	jne    1766 <sha256_hash+0x7e>
                _hash(ctx);
    1741:	ff 75 08             	push   0x8(%ebp)
    1744:	e8 c1 fc ff ff       	call   140a <_hash>
    1749:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    174c:	68 00 02 00 00       	push   $0x200
    1751:	ff 75 08             	push   0x8(%ebp)
    1754:	e8 7c fc ff ff       	call   13d5 <_addbits>
    1759:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    175c:	8b 45 08             	mov    0x8(%ebp),%eax
    175f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    1766:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    176a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176d:	3b 45 10             	cmp    0x10(%ebp),%eax
    1770:	72 a3                	jb     1715 <sha256_hash+0x2d>
            }
        }
    }
}
    1772:	90                   	nop
    1773:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1776:	c9                   	leave  
    1777:	c3                   	ret    

00001778 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    1778:	55                   	push   %ebp
    1779:	89 e5                	mov    %esp,%ebp
    177b:	57                   	push   %edi
    177c:	56                   	push   %esi
    177d:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    177e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1782:	0f 84 27 02 00 00    	je     19af <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    1788:	8b 45 08             	mov    0x8(%ebp),%eax
    178b:	8b 40 68             	mov    0x68(%eax),%eax
    178e:	83 e0 3f             	and    $0x3f,%eax
    1791:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    1793:	8b 45 08             	mov    0x8(%ebp),%eax
    1796:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    179a:	8d 73 01             	lea    0x1(%ebx),%esi
    179d:	eb 0a                	jmp    17a9 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    179f:	8b 45 08             	mov    0x8(%ebp),%eax
    17a2:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    17a6:	83 c6 01             	add    $0x1,%esi
    17a9:	83 fe 3f             	cmp    $0x3f,%esi
    17ac:	76 f1                	jbe    179f <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    17ae:	8b 45 08             	mov    0x8(%ebp),%eax
    17b1:	8b 40 68             	mov    0x68(%eax),%eax
    17b4:	83 f8 37             	cmp    $0x37,%eax
    17b7:	76 21                	jbe    17da <sha256_done+0x62>
            _hash(ctx);
    17b9:	ff 75 08             	push   0x8(%ebp)
    17bc:	e8 49 fc ff ff       	call   140a <_hash>
    17c1:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    17c4:	bb 00 00 00 00       	mov    $0x0,%ebx
    17c9:	eb 0a                	jmp    17d5 <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    17cb:	8b 45 08             	mov    0x8(%ebp),%eax
    17ce:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    17d2:	83 c3 01             	add    $0x1,%ebx
    17d5:	83 fb 3f             	cmp    $0x3f,%ebx
    17d8:	76 f1                	jbe    17cb <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    17da:	8b 45 08             	mov    0x8(%ebp),%eax
    17dd:	8b 40 68             	mov    0x68(%eax),%eax
    17e0:	c1 e0 03             	shl    $0x3,%eax
    17e3:	50                   	push   %eax
    17e4:	ff 75 08             	push   0x8(%ebp)
    17e7:	e8 e9 fb ff ff       	call   13d5 <_addbits>
    17ec:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    17ef:	8b 45 08             	mov    0x8(%ebp),%eax
    17f2:	8b 40 60             	mov    0x60(%eax),%eax
    17f5:	6a 00                	push   $0x0
    17f7:	50                   	push   %eax
    17f8:	e8 1a fa ff ff       	call   1217 <_shb>
    17fd:	83 c4 08             	add    $0x8,%esp
    1800:	8b 55 08             	mov    0x8(%ebp),%edx
    1803:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    1806:	8b 45 08             	mov    0x8(%ebp),%eax
    1809:	8b 40 60             	mov    0x60(%eax),%eax
    180c:	6a 08                	push   $0x8
    180e:	50                   	push   %eax
    180f:	e8 03 fa ff ff       	call   1217 <_shb>
    1814:	83 c4 08             	add    $0x8,%esp
    1817:	8b 55 08             	mov    0x8(%ebp),%edx
    181a:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    181d:	8b 45 08             	mov    0x8(%ebp),%eax
    1820:	8b 40 60             	mov    0x60(%eax),%eax
    1823:	6a 10                	push   $0x10
    1825:	50                   	push   %eax
    1826:	e8 ec f9 ff ff       	call   1217 <_shb>
    182b:	83 c4 08             	add    $0x8,%esp
    182e:	8b 55 08             	mov    0x8(%ebp),%edx
    1831:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    1834:	8b 45 08             	mov    0x8(%ebp),%eax
    1837:	8b 40 60             	mov    0x60(%eax),%eax
    183a:	6a 18                	push   $0x18
    183c:	50                   	push   %eax
    183d:	e8 d5 f9 ff ff       	call   1217 <_shb>
    1842:	83 c4 08             	add    $0x8,%esp
    1845:	8b 55 08             	mov    0x8(%ebp),%edx
    1848:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    184b:	8b 45 08             	mov    0x8(%ebp),%eax
    184e:	8b 40 64             	mov    0x64(%eax),%eax
    1851:	6a 00                	push   $0x0
    1853:	50                   	push   %eax
    1854:	e8 be f9 ff ff       	call   1217 <_shb>
    1859:	83 c4 08             	add    $0x8,%esp
    185c:	8b 55 08             	mov    0x8(%ebp),%edx
    185f:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	8b 40 64             	mov    0x64(%eax),%eax
    1868:	6a 08                	push   $0x8
    186a:	50                   	push   %eax
    186b:	e8 a7 f9 ff ff       	call   1217 <_shb>
    1870:	83 c4 08             	add    $0x8,%esp
    1873:	8b 55 08             	mov    0x8(%ebp),%edx
    1876:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    1879:	8b 45 08             	mov    0x8(%ebp),%eax
    187c:	8b 40 64             	mov    0x64(%eax),%eax
    187f:	6a 10                	push   $0x10
    1881:	50                   	push   %eax
    1882:	e8 90 f9 ff ff       	call   1217 <_shb>
    1887:	83 c4 08             	add    $0x8,%esp
    188a:	8b 55 08             	mov    0x8(%ebp),%edx
    188d:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    1890:	8b 45 08             	mov    0x8(%ebp),%eax
    1893:	8b 40 64             	mov    0x64(%eax),%eax
    1896:	6a 18                	push   $0x18
    1898:	50                   	push   %eax
    1899:	e8 79 f9 ff ff       	call   1217 <_shb>
    189e:	83 c4 08             	add    $0x8,%esp
    18a1:	8b 55 08             	mov    0x8(%ebp),%edx
    18a4:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    18a7:	ff 75 08             	push   0x8(%ebp)
    18aa:	e8 5b fb ff ff       	call   140a <_hash>
    18af:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    18b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18b6:	0f 84 f3 00 00 00    	je     19af <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    18bc:	be 00 00 00 00       	mov    $0x0,%esi
    18c1:	bb 18 00 00 00       	mov    $0x18,%ebx
    18c6:	e9 db 00 00 00       	jmp    19a6 <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    18cb:	8b 45 08             	mov    0x8(%ebp),%eax
    18ce:	8b 40 40             	mov    0x40(%eax),%eax
    18d1:	8b 55 0c             	mov    0xc(%ebp),%edx
    18d4:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    18d7:	53                   	push   %ebx
    18d8:	50                   	push   %eax
    18d9:	e8 39 f9 ff ff       	call   1217 <_shb>
    18de:	83 c4 08             	add    $0x8,%esp
    18e1:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    18e3:	8b 45 08             	mov    0x8(%ebp),%eax
    18e6:	8b 40 44             	mov    0x44(%eax),%eax
    18e9:	8d 4e 04             	lea    0x4(%esi),%ecx
    18ec:	8b 55 0c             	mov    0xc(%ebp),%edx
    18ef:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    18f2:	53                   	push   %ebx
    18f3:	50                   	push   %eax
    18f4:	e8 1e f9 ff ff       	call   1217 <_shb>
    18f9:	83 c4 08             	add    $0x8,%esp
    18fc:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    18fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1901:	8b 40 48             	mov    0x48(%eax),%eax
    1904:	8d 4e 08             	lea    0x8(%esi),%ecx
    1907:	8b 55 0c             	mov    0xc(%ebp),%edx
    190a:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    190d:	53                   	push   %ebx
    190e:	50                   	push   %eax
    190f:	e8 03 f9 ff ff       	call   1217 <_shb>
    1914:	83 c4 08             	add    $0x8,%esp
    1917:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    1919:	8b 45 08             	mov    0x8(%ebp),%eax
    191c:	8b 40 4c             	mov    0x4c(%eax),%eax
    191f:	8d 4e 0c             	lea    0xc(%esi),%ecx
    1922:	8b 55 0c             	mov    0xc(%ebp),%edx
    1925:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1928:	53                   	push   %ebx
    1929:	50                   	push   %eax
    192a:	e8 e8 f8 ff ff       	call   1217 <_shb>
    192f:	83 c4 08             	add    $0x8,%esp
    1932:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    1934:	8b 45 08             	mov    0x8(%ebp),%eax
    1937:	8b 40 50             	mov    0x50(%eax),%eax
    193a:	8d 4e 10             	lea    0x10(%esi),%ecx
    193d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1940:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1943:	53                   	push   %ebx
    1944:	50                   	push   %eax
    1945:	e8 cd f8 ff ff       	call   1217 <_shb>
    194a:	83 c4 08             	add    $0x8,%esp
    194d:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    194f:	8b 45 08             	mov    0x8(%ebp),%eax
    1952:	8b 40 54             	mov    0x54(%eax),%eax
    1955:	8d 4e 14             	lea    0x14(%esi),%ecx
    1958:	8b 55 0c             	mov    0xc(%ebp),%edx
    195b:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    195e:	53                   	push   %ebx
    195f:	50                   	push   %eax
    1960:	e8 b2 f8 ff ff       	call   1217 <_shb>
    1965:	83 c4 08             	add    $0x8,%esp
    1968:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    196a:	8b 45 08             	mov    0x8(%ebp),%eax
    196d:	8b 40 58             	mov    0x58(%eax),%eax
    1970:	8d 4e 18             	lea    0x18(%esi),%ecx
    1973:	8b 55 0c             	mov    0xc(%ebp),%edx
    1976:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1979:	53                   	push   %ebx
    197a:	50                   	push   %eax
    197b:	e8 97 f8 ff ff       	call   1217 <_shb>
    1980:	83 c4 08             	add    $0x8,%esp
    1983:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    1985:	8b 45 08             	mov    0x8(%ebp),%eax
    1988:	8b 40 5c             	mov    0x5c(%eax),%eax
    198b:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    198e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1991:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1994:	53                   	push   %ebx
    1995:	50                   	push   %eax
    1996:	e8 7c f8 ff ff       	call   1217 <_shb>
    199b:	83 c4 08             	add    $0x8,%esp
    199e:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    19a0:	83 c6 01             	add    $0x1,%esi
    19a3:	83 eb 08             	sub    $0x8,%ebx
    19a6:	83 fe 03             	cmp    $0x3,%esi
    19a9:	0f 86 1c ff ff ff    	jbe    18cb <sha256_done+0x153>
            }
        }
    }
}
    19af:	90                   	nop
    19b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19b3:	5b                   	pop    %ebx
    19b4:	5e                   	pop    %esi
    19b5:	5f                   	pop    %edi
    19b6:	5d                   	pop    %ebp
    19b7:	c3                   	ret    

000019b8 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    19b8:	55                   	push   %ebp
    19b9:	89 e5                	mov    %esp,%ebp
    19bb:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    19be:	a1 24 2a 00 00       	mov    0x2a24,%eax
    19c3:	83 ec 08             	sub    $0x8,%esp
    19c6:	68 04 02 00 00       	push   $0x204
    19cb:	50                   	push   %eax
    19cc:	e8 7d e7 ff ff       	call   14e <open>
    19d1:	83 c4 10             	add    $0x10,%esp
    19d4:	a3 60 2a 00 00       	mov    %eax,0x2a60

    int i = 0;
    19d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    19e0:	eb 6f                	jmp    1a51 <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    19e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e5:	83 e0 01             	and    $0x1,%eax
    19e8:	85 c0                	test   %eax,%eax
    19ea:	75 27                	jne    1a13 <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    19ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ef:	89 c2                	mov    %eax,%edx
    19f1:	c1 ea 1f             	shr    $0x1f,%edx
    19f4:	01 d0                	add    %edx,%eax
    19f6:	d1 f8                	sar    %eax
    19f8:	6b c0 64             	imul   $0x64,%eax,%eax
    19fb:	8d 90 80 2a 00 00    	lea    0x2a80(%eax),%edx
    1a01:	83 ec 08             	sub    $0x8,%esp
    1a04:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a07:	50                   	push   %eax
    1a08:	52                   	push   %edx
    1a09:	e8 ee e7 ff ff       	call   1fc <strcpy>
    1a0e:	83 c4 10             	add    $0x10,%esp
    1a11:	eb 27                	jmp    1a3a <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a16:	89 c2                	mov    %eax,%edx
    1a18:	c1 ea 1f             	shr    $0x1f,%edx
    1a1b:	01 d0                	add    %edx,%eax
    1a1d:	d1 f8                	sar    %eax
    1a1f:	6b c0 64             	imul   $0x64,%eax,%eax
    1a22:	8d 90 c0 29 64 00    	lea    0x6429c0(%eax),%edx
    1a28:	83 ec 04             	sub    $0x4,%esp
    1a2b:	6a 64                	push   $0x64
    1a2d:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a30:	50                   	push   %eax
    1a31:	52                   	push   %edx
    1a32:	e8 b1 e9 ff ff       	call   3e8 <memmove>
    1a37:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1a3a:	83 ec 04             	sub    $0x4,%esp
    1a3d:	6a 64                	push   $0x64
    1a3f:	6a 00                	push   $0x0
    1a41:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a44:	50                   	push   %eax
    1a45:	e8 48 e8 ff ff       	call   292 <memset>
    1a4a:	83 c4 10             	add    $0x10,%esp
        i++;
    1a4d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1a51:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1a56:	83 ec 04             	sub    $0x4,%esp
    1a59:	6a 64                	push   $0x64
    1a5b:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1a5e:	52                   	push   %edx
    1a5f:	50                   	push   %eax
    1a60:	e8 c1 e6 ff ff       	call   126 <read>
    1a65:	83 c4 10             	add    $0x10,%esp
    1a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a6b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a6f:	0f 8f 6d ff ff ff    	jg     19e2 <read_info+0x2a>
    }

    num_users = i / 2;
    1a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a78:	89 c2                	mov    %eax,%edx
    1a7a:	c1 ea 1f             	shr    $0x1f,%edx
    1a7d:	01 d0                	add    %edx,%eax
    1a7f:	d1 f8                	sar    %eax
    1a81:	a3 64 2a 00 00       	mov    %eax,0x2a64

    if (n < 0) {
    1a86:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a8a:	79 17                	jns    1aa3 <read_info+0xeb>
        printf(1, "cat: read error\n");
    1a8c:	83 ec 08             	sub    $0x8,%esp
    1a8f:	68 4b 22 00 00       	push   $0x224b
    1a94:	6a 01                	push   $0x1
    1a96:	e8 83 ec ff ff       	call   71e <printf>
    1a9b:	83 c4 10             	add    $0x10,%esp
        exit();
    1a9e:	e8 6b e6 ff ff       	call   10e <exit>
    }
}
    1aa3:	90                   	nop
    1aa4:	c9                   	leave  
    1aa5:	c3                   	ret    

00001aa6 <writeback>:

void writeback() {
    1aa6:	55                   	push   %ebp
    1aa7:	89 e5                	mov    %esp,%ebp
    1aa9:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1aac:	a1 24 2a 00 00       	mov    0x2a24,%eax
    1ab1:	83 ec 08             	sub    $0x8,%esp
    1ab4:	68 04 02 00 00       	push   $0x204
    1ab9:	50                   	push   %eax
    1aba:	e8 8f e6 ff ff       	call   14e <open>
    1abf:	83 c4 10             	add    $0x10,%esp
    1ac2:	a3 60 2a 00 00       	mov    %eax,0x2a60
    for (int i = 0; i < num_users; i++) {
    1ac7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ace:	eb 44                	jmp    1b14 <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1ad0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad3:	6b c0 64             	imul   $0x64,%eax,%eax
    1ad6:	8d 90 80 2a 00 00    	lea    0x2a80(%eax),%edx
    1adc:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1ae1:	83 ec 04             	sub    $0x4,%esp
    1ae4:	6a 64                	push   $0x64
    1ae6:	52                   	push   %edx
    1ae7:	50                   	push   %eax
    1ae8:	e8 41 e6 ff ff       	call   12e <write>
    1aed:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1af0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af3:	6b c0 64             	imul   $0x64,%eax,%eax
    1af6:	8d 90 c0 29 64 00    	lea    0x6429c0(%eax),%edx
    1afc:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1b01:	83 ec 04             	sub    $0x4,%esp
    1b04:	6a 64                	push   $0x64
    1b06:	52                   	push   %edx
    1b07:	50                   	push   %eax
    1b08:	e8 21 e6 ff ff       	call   12e <write>
    1b0d:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1b10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b14:	a1 64 2a 00 00       	mov    0x2a64,%eax
    1b19:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1b1c:	7c b2                	jl     1ad0 <writeback+0x2a>
    }
    close(fd);
    1b1e:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1b23:	83 ec 0c             	sub    $0xc,%esp
    1b26:	50                   	push   %eax
    1b27:	e8 0a e6 ff ff       	call   136 <close>
    1b2c:	83 c4 10             	add    $0x10,%esp
}
    1b2f:	90                   	nop
    1b30:	c9                   	leave  
    1b31:	c3                   	ret    

00001b32 <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1b32:	55                   	push   %ebp
    1b33:	89 e5                	mov    %esp,%ebp
    1b35:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1b3b:	83 ec 08             	sub    $0x8,%esp
    1b3e:	68 5c 22 00 00       	push   $0x225c
    1b43:	68 80 2a 00 00       	push   $0x2a80
    1b48:	e8 af e6 ff ff       	call   1fc <strcpy>
    1b4d:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1b50:	c7 45 f4 61 22 00 00 	movl   $0x2261,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1b57:	83 ec 08             	sub    $0x8,%esp
    1b5a:	ff 75 f4             	push   -0xc(%ebp)
    1b5d:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1b63:	50                   	push   %eax
    1b64:	e8 93 e6 ff ff       	call   1fc <strcpy>
    1b69:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1b6c:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1b73:	83 ec 0c             	sub    $0xc,%esp
    1b76:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1b7c:	50                   	push   %eax
    1b7d:	e8 e8 fa ff ff       	call   166a <sha256_init>
    1b82:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1b85:	83 ec 0c             	sub    $0xc,%esp
    1b88:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1b8e:	50                   	push   %eax
    1b8f:	e8 d7 e6 ff ff       	call   26b <strlen>
    1b94:	83 c4 10             	add    $0x10,%esp
    1b97:	83 ec 04             	sub    $0x4,%esp
    1b9a:	50                   	push   %eax
    1b9b:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1ba1:	50                   	push   %eax
    1ba2:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1ba8:	50                   	push   %eax
    1ba9:	e8 3a fb ff ff       	call   16e8 <sha256_hash>
    1bae:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1bb1:	83 ec 08             	sub    $0x8,%esp
    1bb4:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1bba:	50                   	push   %eax
    1bbb:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1bc1:	50                   	push   %eax
    1bc2:	e8 b1 fb ff ff       	call   1778 <sha256_done>
    1bc7:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1bca:	83 ec 04             	sub    $0x4,%esp
    1bcd:	6a 64                	push   $0x64
    1bcf:	6a 00                	push   $0x0
    1bd1:	68 c0 29 64 00       	push   $0x6429c0
    1bd6:	e8 b7 e6 ff ff       	call   292 <memset>
    1bdb:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1bde:	83 ec 04             	sub    $0x4,%esp
    1be1:	6a 20                	push   $0x20
    1be3:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1be9:	50                   	push   %eax
    1bea:	68 c0 29 64 00       	push   $0x6429c0
    1bef:	e8 f4 e7 ff ff       	call   3e8 <memmove>
    1bf4:	83 c4 10             	add    $0x10,%esp

    read_info();
    1bf7:	e8 bc fd ff ff       	call   19b8 <read_info>
    fd = open(SECRETS, O_RDWR);
    1bfc:	a1 24 2a 00 00       	mov    0x2a24,%eax
    1c01:	83 ec 08             	sub    $0x8,%esp
    1c04:	6a 04                	push   $0x4
    1c06:	50                   	push   %eax
    1c07:	e8 42 e5 ff ff       	call   14e <open>
    1c0c:	83 c4 10             	add    $0x10,%esp
    1c0f:	a3 60 2a 00 00       	mov    %eax,0x2a60
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1c14:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1c19:	83 ec 04             	sub    $0x4,%esp
    1c1c:	6a 64                	push   $0x64
    1c1e:	68 80 2a 00 00       	push   $0x2a80
    1c23:	50                   	push   %eax
    1c24:	e8 05 e5 ff ff       	call   12e <write>
    1c29:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1c2c:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1c31:	83 ec 04             	sub    $0x4,%esp
    1c34:	6a 64                	push   $0x64
    1c36:	68 c0 29 64 00       	push   $0x6429c0
    1c3b:	50                   	push   %eax
    1c3c:	e8 ed e4 ff ff       	call   12e <write>
    1c41:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1c44:	a1 60 2a 00 00       	mov    0x2a60,%eax
    1c49:	83 ec 0c             	sub    $0xc,%esp
    1c4c:	50                   	push   %eax
    1c4d:	e8 e4 e4 ff ff       	call   136 <close>
    1c52:	83 c4 10             	add    $0x10,%esp
}
    1c55:	90                   	nop
    1c56:	c9                   	leave  
    1c57:	c3                   	ret    

00001c58 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1c58:	55                   	push   %ebp
    1c59:	89 e5                	mov    %esp,%ebp
    1c5b:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1c5e:	e8 55 fd ff ff       	call   19b8 <read_info>

    for (int i = 0; i < num_users; i++) {
    1c63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c6a:	eb 29                	jmp    1c95 <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c6f:	6b c0 64             	imul   $0x64,%eax,%eax
    1c72:	05 80 2a 00 00       	add    $0x2a80,%eax
    1c77:	83 ec 08             	sub    $0x8,%esp
    1c7a:	50                   	push   %eax
    1c7b:	ff 75 08             	push   0x8(%ebp)
    1c7e:	e8 a9 e5 ff ff       	call   22c <strcmp>
    1c83:	83 c4 10             	add    $0x10,%esp
    1c86:	85 c0                	test   %eax,%eax
    1c88:	75 07                	jne    1c91 <does_user_exist+0x39>
            return 0;
    1c8a:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8f:	eb 13                	jmp    1ca4 <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1c91:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c95:	a1 64 2a 00 00       	mov    0x2a64,%eax
    1c9a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1c9d:	7c cd                	jl     1c6c <does_user_exist+0x14>
        }
    }
    return -1;
    1c9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ca4:	c9                   	leave  
    1ca5:	c3                   	ret    

00001ca6 <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1ca6:	55                   	push   %ebp
    1ca7:	89 e5                	mov    %esp,%ebp
    1ca9:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1caf:	e8 04 fd ff ff       	call   19b8 <read_info>

    int open = -1;
    1cb4:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1cbb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1cc2:	eb 46                	jmp    1d0a <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1cc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc7:	6b c0 64             	imul   $0x64,%eax,%eax
    1cca:	05 80 2a 00 00       	add    $0x2a80,%eax
    1ccf:	83 ec 08             	sub    $0x8,%esp
    1cd2:	50                   	push   %eax
    1cd3:	ff 75 08             	push   0x8(%ebp)
    1cd6:	e8 51 e5 ff ff       	call   22c <strcmp>
    1cdb:	83 c4 10             	add    $0x10,%esp
    1cde:	85 c0                	test   %eax,%eax
    1ce0:	75 0a                	jne    1cec <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1ce2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ce7:	e9 18 01 00 00       	jmp    1e04 <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1cec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cef:	6b c0 64             	imul   $0x64,%eax,%eax
    1cf2:	05 80 2a 00 00       	add    $0x2a80,%eax
    1cf7:	0f b6 00             	movzbl (%eax),%eax
    1cfa:	84 c0                	test   %al,%al
    1cfc:	75 08                	jne    1d06 <create_user+0x60>
            open = i;
    1cfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d01:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1d04:	eb 0d                	jmp    1d13 <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1d06:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1d0a:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1d11:	7e b1                	jle    1cc4 <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1d13:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1d17:	0f 84 e2 00 00 00    	je     1dff <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1d1d:	83 ec 08             	sub    $0x8,%esp
    1d20:	ff 75 0c             	push   0xc(%ebp)
    1d23:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d29:	50                   	push   %eax
    1d2a:	e8 cd e4 ff ff       	call   1fc <strcpy>
    1d2f:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1d32:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1d39:	83 ec 0c             	sub    $0xc,%esp
    1d3c:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d42:	50                   	push   %eax
    1d43:	e8 22 f9 ff ff       	call   166a <sha256_init>
    1d48:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1d4b:	83 ec 0c             	sub    $0xc,%esp
    1d4e:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d54:	50                   	push   %eax
    1d55:	e8 11 e5 ff ff       	call   26b <strlen>
    1d5a:	83 c4 10             	add    $0x10,%esp
    1d5d:	83 ec 04             	sub    $0x4,%esp
    1d60:	50                   	push   %eax
    1d61:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d67:	50                   	push   %eax
    1d68:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d6e:	50                   	push   %eax
    1d6f:	e8 74 f9 ff ff       	call   16e8 <sha256_hash>
    1d74:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1d77:	83 ec 08             	sub    $0x8,%esp
    1d7a:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1d80:	50                   	push   %eax
    1d81:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d87:	50                   	push   %eax
    1d88:	e8 eb f9 ff ff       	call   1778 <sha256_done>
    1d8d:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1d90:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d93:	6b c0 64             	imul   $0x64,%eax,%eax
    1d96:	05 80 2a 00 00       	add    $0x2a80,%eax
    1d9b:	83 ec 08             	sub    $0x8,%esp
    1d9e:	ff 75 08             	push   0x8(%ebp)
    1da1:	50                   	push   %eax
    1da2:	e8 55 e4 ff ff       	call   1fc <strcpy>
    1da7:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dad:	6b c0 64             	imul   $0x64,%eax,%eax
    1db0:	05 c0 29 64 00       	add    $0x6429c0,%eax
    1db5:	83 ec 04             	sub    $0x4,%esp
    1db8:	6a 64                	push   $0x64
    1dba:	6a 00                	push   $0x0
    1dbc:	50                   	push   %eax
    1dbd:	e8 d0 e4 ff ff       	call   292 <memset>
    1dc2:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    1dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dc8:	6b c0 64             	imul   $0x64,%eax,%eax
    1dcb:	8d 90 c0 29 64 00    	lea    0x6429c0(%eax),%edx
    1dd1:	83 ec 04             	sub    $0x4,%esp
    1dd4:	6a 20                	push   $0x20
    1dd6:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1ddc:	50                   	push   %eax
    1ddd:	52                   	push   %edx
    1dde:	e8 05 e6 ff ff       	call   3e8 <memmove>
    1de3:	83 c4 10             	add    $0x10,%esp

        num_users++;
    1de6:	a1 64 2a 00 00       	mov    0x2a64,%eax
    1deb:	83 c0 01             	add    $0x1,%eax
    1dee:	a3 64 2a 00 00       	mov    %eax,0x2a64
        writeback();
    1df3:	e8 ae fc ff ff       	call   1aa6 <writeback>
        return 0;
    1df8:	b8 00 00 00 00       	mov    $0x0,%eax
    1dfd:	eb 05                	jmp    1e04 <create_user+0x15e>
    }

    return -1;
    1dff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1e04:	c9                   	leave  
    1e05:	c3                   	ret    

00001e06 <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    1e06:	55                   	push   %ebp
    1e07:	89 e5                	mov    %esp,%ebp
    1e09:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    1e0f:	e8 a4 fb ff ff       	call   19b8 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    1e14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e1b:	e9 7b 01 00 00       	jmp    1f9b <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    1e20:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e23:	6b c0 64             	imul   $0x64,%eax,%eax
    1e26:	05 80 2a 00 00       	add    $0x2a80,%eax
    1e2b:	83 ec 08             	sub    $0x8,%esp
    1e2e:	50                   	push   %eax
    1e2f:	ff 75 08             	push   0x8(%ebp)
    1e32:	e8 f5 e3 ff ff       	call   22c <strcmp>
    1e37:	83 c4 10             	add    $0x10,%esp
    1e3a:	85 c0                	test   %eax,%eax
    1e3c:	0f 85 55 01 00 00    	jne    1f97 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    1e42:	83 ec 08             	sub    $0x8,%esp
    1e45:	ff 75 0c             	push   0xc(%ebp)
    1e48:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e4e:	50                   	push   %eax
    1e4f:	e8 a8 e3 ff ff       	call   1fc <strcpy>
    1e54:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    1e57:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    1e5e:	83 ec 0c             	sub    $0xc,%esp
    1e61:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1e67:	50                   	push   %eax
    1e68:	e8 fd f7 ff ff       	call   166a <sha256_init>
    1e6d:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    1e70:	83 ec 0c             	sub    $0xc,%esp
    1e73:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e79:	50                   	push   %eax
    1e7a:	e8 ec e3 ff ff       	call   26b <strlen>
    1e7f:	83 c4 10             	add    $0x10,%esp
    1e82:	83 ec 04             	sub    $0x4,%esp
    1e85:	50                   	push   %eax
    1e86:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e8c:	50                   	push   %eax
    1e8d:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1e93:	50                   	push   %eax
    1e94:	e8 4f f8 ff ff       	call   16e8 <sha256_hash>
    1e99:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    1e9c:	83 ec 08             	sub    $0x8,%esp
    1e9f:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    1ea5:	50                   	push   %eax
    1ea6:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1eac:	50                   	push   %eax
    1ead:	e8 c6 f8 ff ff       	call   1778 <sha256_done>
    1eb2:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    1eb5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ebc:	eb 34                	jmp    1ef2 <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    1ebe:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    1ec4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ec7:	01 d0                	add    %edx,%eax
    1ec9:	0f b6 00             	movzbl (%eax),%eax
    1ecc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ecf:	6b ca 64             	imul   $0x64,%edx,%ecx
    1ed2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1ed5:	01 ca                	add    %ecx,%edx
    1ed7:	81 c2 c0 29 64 00    	add    $0x6429c0,%edx
    1edd:	0f b6 12             	movzbl (%edx),%edx
    1ee0:	38 d0                	cmp    %dl,%al
    1ee2:	74 0a                	je     1eee <login_user+0xe8>
                    return -1;
    1ee4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ee9:	e9 bf 00 00 00       	jmp    1fad <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    1eee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1ef2:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    1ef6:	7e c6                	jle    1ebe <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    1ef8:	83 ec 08             	sub    $0x8,%esp
    1efb:	68 67 22 00 00       	push   $0x2267
    1f00:	6a 01                	push   $0x1
    1f02:	e8 17 e8 ff ff       	call   71e <printf>
    1f07:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    1f0a:	e8 f7 e1 ff ff       	call   106 <fork>
    1f0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    1f12:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f16:	79 17                	jns    1f2f <login_user+0x129>
                printf(1, "init: fork failed\n");
    1f18:	83 ec 08             	sub    $0x8,%esp
    1f1b:	68 7a 22 00 00       	push   $0x227a
    1f20:	6a 01                	push   $0x1
    1f22:	e8 f7 e7 ff ff       	call   71e <printf>
    1f27:	83 c4 10             	add    $0x10,%esp
                exit();
    1f2a:	e8 df e1 ff ff       	call   10e <exit>
            }
            if (pid == 0) {
    1f2f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f33:	75 4c                	jne    1f81 <login_user+0x17b>
                setuid(i);
    1f35:	83 ec 0c             	sub    $0xc,%esp
    1f38:	ff 75 f4             	push   -0xc(%ebp)
    1f3b:	e8 6e e2 ff ff       	call   1ae <setuid>
    1f40:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    1f43:	83 ec 08             	sub    $0x8,%esp
    1f46:	68 28 2a 00 00       	push   $0x2a28
    1f4b:	68 48 22 00 00       	push   $0x2248
    1f50:	e8 f1 e1 ff ff       	call   146 <exec>
    1f55:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    1f58:	83 ec 08             	sub    $0x8,%esp
    1f5b:	68 8d 22 00 00       	push   $0x228d
    1f60:	6a 01                	push   $0x1
    1f62:	e8 b7 e7 ff ff       	call   71e <printf>
    1f67:	83 c4 10             	add    $0x10,%esp
                exit();
    1f6a:	e8 9f e1 ff ff       	call   10e <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    1f6f:	83 ec 08             	sub    $0x8,%esp
    1f72:	68 a3 22 00 00       	push   $0x22a3
    1f77:	6a 01                	push   $0x1
    1f79:	e8 a0 e7 ff ff       	call   71e <printf>
    1f7e:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    1f81:	e8 90 e1 ff ff       	call   116 <wait>
    1f86:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1f89:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f8d:	78 08                	js     1f97 <login_user+0x191>
    1f8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f92:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1f95:	75 d8                	jne    1f6f <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1f97:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f9b:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    1fa2:	0f 8e 78 fe ff ff    	jle    1e20 <login_user+0x1a>
        }
    }

    return -1;
    1fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1fad:	c9                   	leave  
    1fae:	c3                   	ret    
