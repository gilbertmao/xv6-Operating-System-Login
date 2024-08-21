
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:
#include "user.h"
#include "fcntl.h"

char buf[512];

void cat(int fd) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
    int n;

    while ((n = read(fd, buf, sizeof(buf))) > 0) {
       6:	eb 31                	jmp    39 <cat+0x39>
        if (write(1, buf, n) != n) {
       8:	83 ec 04             	sub    $0x4,%esp
       b:	ff 75 f4             	push   -0xc(%ebp)
       e:	68 40 2a 00 00       	push   $0x2a40
      13:	6a 01                	push   $0x1
      15:	e8 39 01 00 00       	call   153 <write>
      1a:	83 c4 10             	add    $0x10,%esp
      1d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
      20:	74 17                	je     39 <cat+0x39>
            printf(1, "cat: write error\n");
      22:	83 ec 08             	sub    $0x8,%esp
      25:	68 e0 1f 00 00       	push   $0x1fe0
      2a:	6a 01                	push   $0x1
      2c:	e8 12 07 00 00       	call   743 <printf>
      31:	83 c4 10             	add    $0x10,%esp
            exit();
      34:	e8 fa 00 00 00       	call   133 <exit>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
      39:	83 ec 04             	sub    $0x4,%esp
      3c:	68 00 02 00 00       	push   $0x200
      41:	68 40 2a 00 00       	push   $0x2a40
      46:	ff 75 08             	push   0x8(%ebp)
      49:	e8 fd 00 00 00       	call   14b <read>
      4e:	83 c4 10             	add    $0x10,%esp
      51:	89 45 f4             	mov    %eax,-0xc(%ebp)
      54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      58:	7f ae                	jg     8 <cat+0x8>
        }
    }
    if (n < 0) {
      5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      5e:	79 17                	jns    77 <cat+0x77>
        printf(1, "cat: read error\n");
      60:	83 ec 08             	sub    $0x8,%esp
      63:	68 f2 1f 00 00       	push   $0x1ff2
      68:	6a 01                	push   $0x1
      6a:	e8 d4 06 00 00       	call   743 <printf>
      6f:	83 c4 10             	add    $0x10,%esp
        exit();
      72:	e8 bc 00 00 00       	call   133 <exit>
    }
}
      77:	90                   	nop
      78:	c9                   	leave  
      79:	c3                   	ret    

0000007a <main>:

int main(int argc, char* argv[]) {
      7a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      7e:	83 e4 f0             	and    $0xfffffff0,%esp
      81:	ff 71 fc             	push   -0x4(%ecx)
      84:	55                   	push   %ebp
      85:	89 e5                	mov    %esp,%ebp
      87:	53                   	push   %ebx
      88:	51                   	push   %ecx
      89:	83 ec 10             	sub    $0x10,%esp
      8c:	89 cb                	mov    %ecx,%ebx
    int fd, i;

    if (argc <= 1) {
      8e:	83 3b 01             	cmpl   $0x1,(%ebx)
      91:	7f 12                	jg     a5 <main+0x2b>
        cat(0);
      93:	83 ec 0c             	sub    $0xc,%esp
      96:	6a 00                	push   $0x0
      98:	e8 63 ff ff ff       	call   0 <cat>
      9d:	83 c4 10             	add    $0x10,%esp
        exit();
      a0:	e8 8e 00 00 00       	call   133 <exit>
    }

    for (i = 1; i < argc; i++) {
      a5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      ac:	eb 71                	jmp    11f <main+0xa5>
        if ((fd = open(argv[i], O_RDONLY)) < 0) {
      ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
      b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      b8:	8b 43 04             	mov    0x4(%ebx),%eax
      bb:	01 d0                	add    %edx,%eax
      bd:	8b 00                	mov    (%eax),%eax
      bf:	83 ec 08             	sub    $0x8,%esp
      c2:	6a 01                	push   $0x1
      c4:	50                   	push   %eax
      c5:	e8 a9 00 00 00       	call   173 <open>
      ca:	83 c4 10             	add    $0x10,%esp
      cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
      d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      d4:	79 29                	jns    ff <main+0x85>
            printf(1, "cat: cannot open %s\n", argv[i]);
      d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
      d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      e0:	8b 43 04             	mov    0x4(%ebx),%eax
      e3:	01 d0                	add    %edx,%eax
      e5:	8b 00                	mov    (%eax),%eax
      e7:	83 ec 04             	sub    $0x4,%esp
      ea:	50                   	push   %eax
      eb:	68 03 20 00 00       	push   $0x2003
      f0:	6a 01                	push   $0x1
      f2:	e8 4c 06 00 00       	call   743 <printf>
      f7:	83 c4 10             	add    $0x10,%esp
            exit();
      fa:	e8 34 00 00 00       	call   133 <exit>
        }
        cat(fd);
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	ff 75 f0             	push   -0x10(%ebp)
     105:	e8 f6 fe ff ff       	call   0 <cat>
     10a:	83 c4 10             	add    $0x10,%esp
        close(fd);
     10d:	83 ec 0c             	sub    $0xc,%esp
     110:	ff 75 f0             	push   -0x10(%ebp)
     113:	e8 43 00 00 00       	call   15b <close>
     118:	83 c4 10             	add    $0x10,%esp
    for (i = 1; i < argc; i++) {
     11b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     11f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     122:	3b 03                	cmp    (%ebx),%eax
     124:	7c 88                	jl     ae <main+0x34>
    }
    exit();
     126:	e8 08 00 00 00       	call   133 <exit>

0000012b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     12b:	b8 01 00 00 00       	mov    $0x1,%eax
     130:	cd 40                	int    $0x40
     132:	c3                   	ret    

00000133 <exit>:
SYSCALL(exit)
     133:	b8 02 00 00 00       	mov    $0x2,%eax
     138:	cd 40                	int    $0x40
     13a:	c3                   	ret    

0000013b <wait>:
SYSCALL(wait)
     13b:	b8 03 00 00 00       	mov    $0x3,%eax
     140:	cd 40                	int    $0x40
     142:	c3                   	ret    

00000143 <pipe>:
SYSCALL(pipe)
     143:	b8 04 00 00 00       	mov    $0x4,%eax
     148:	cd 40                	int    $0x40
     14a:	c3                   	ret    

0000014b <read>:
SYSCALL(read)
     14b:	b8 05 00 00 00       	mov    $0x5,%eax
     150:	cd 40                	int    $0x40
     152:	c3                   	ret    

00000153 <write>:
SYSCALL(write)
     153:	b8 10 00 00 00       	mov    $0x10,%eax
     158:	cd 40                	int    $0x40
     15a:	c3                   	ret    

0000015b <close>:
SYSCALL(close)
     15b:	b8 15 00 00 00       	mov    $0x15,%eax
     160:	cd 40                	int    $0x40
     162:	c3                   	ret    

00000163 <kill>:
SYSCALL(kill)
     163:	b8 06 00 00 00       	mov    $0x6,%eax
     168:	cd 40                	int    $0x40
     16a:	c3                   	ret    

0000016b <exec>:
SYSCALL(exec)
     16b:	b8 07 00 00 00       	mov    $0x7,%eax
     170:	cd 40                	int    $0x40
     172:	c3                   	ret    

00000173 <open>:
SYSCALL(open)
     173:	b8 0f 00 00 00       	mov    $0xf,%eax
     178:	cd 40                	int    $0x40
     17a:	c3                   	ret    

0000017b <mknod>:
SYSCALL(mknod)
     17b:	b8 11 00 00 00       	mov    $0x11,%eax
     180:	cd 40                	int    $0x40
     182:	c3                   	ret    

00000183 <unlink>:
SYSCALL(unlink)
     183:	b8 12 00 00 00       	mov    $0x12,%eax
     188:	cd 40                	int    $0x40
     18a:	c3                   	ret    

0000018b <fstat>:
SYSCALL(fstat)
     18b:	b8 08 00 00 00       	mov    $0x8,%eax
     190:	cd 40                	int    $0x40
     192:	c3                   	ret    

00000193 <link>:
SYSCALL(link)
     193:	b8 13 00 00 00       	mov    $0x13,%eax
     198:	cd 40                	int    $0x40
     19a:	c3                   	ret    

0000019b <mkdir>:
SYSCALL(mkdir)
     19b:	b8 14 00 00 00       	mov    $0x14,%eax
     1a0:	cd 40                	int    $0x40
     1a2:	c3                   	ret    

000001a3 <chdir>:
SYSCALL(chdir)
     1a3:	b8 09 00 00 00       	mov    $0x9,%eax
     1a8:	cd 40                	int    $0x40
     1aa:	c3                   	ret    

000001ab <dup>:
SYSCALL(dup)
     1ab:	b8 0a 00 00 00       	mov    $0xa,%eax
     1b0:	cd 40                	int    $0x40
     1b2:	c3                   	ret    

000001b3 <getpid>:
SYSCALL(getpid)
     1b3:	b8 0b 00 00 00       	mov    $0xb,%eax
     1b8:	cd 40                	int    $0x40
     1ba:	c3                   	ret    

000001bb <sbrk>:
SYSCALL(sbrk)
     1bb:	b8 0c 00 00 00       	mov    $0xc,%eax
     1c0:	cd 40                	int    $0x40
     1c2:	c3                   	ret    

000001c3 <sleep>:
SYSCALL(sleep)
     1c3:	b8 0d 00 00 00       	mov    $0xd,%eax
     1c8:	cd 40                	int    $0x40
     1ca:	c3                   	ret    

000001cb <uptime>:
SYSCALL(uptime)
     1cb:	b8 0e 00 00 00       	mov    $0xe,%eax
     1d0:	cd 40                	int    $0x40
     1d2:	c3                   	ret    

000001d3 <setuid>:
SYSCALL(setuid)
     1d3:	b8 16 00 00 00       	mov    $0x16,%eax
     1d8:	cd 40                	int    $0x40
     1da:	c3                   	ret    

000001db <getuid>:
SYSCALL(getuid)
     1db:	b8 19 00 00 00       	mov    $0x19,%eax
     1e0:	cd 40                	int    $0x40
     1e2:	c3                   	ret    

000001e3 <chown>:
SYSCALL(chown)
     1e3:	b8 18 00 00 00       	mov    $0x18,%eax
     1e8:	cd 40                	int    $0x40
     1ea:	c3                   	ret    

000001eb <chmod>:
SYSCALL(chmod)
     1eb:	b8 17 00 00 00       	mov    $0x17,%eax
     1f0:	cd 40                	int    $0x40
     1f2:	c3                   	ret    

000001f3 <report_stats>:
SYSCALL(report_stats)
     1f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
     1f8:	cd 40                	int    $0x40
     1fa:	c3                   	ret    

000001fb <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1fb:	55                   	push   %ebp
     1fc:	89 e5                	mov    %esp,%ebp
     1fe:	57                   	push   %edi
     1ff:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     200:	8b 4d 08             	mov    0x8(%ebp),%ecx
     203:	8b 55 10             	mov    0x10(%ebp),%edx
     206:	8b 45 0c             	mov    0xc(%ebp),%eax
     209:	89 cb                	mov    %ecx,%ebx
     20b:	89 df                	mov    %ebx,%edi
     20d:	89 d1                	mov    %edx,%ecx
     20f:	fc                   	cld    
     210:	f3 aa                	rep stos %al,%es:(%edi)
     212:	89 ca                	mov    %ecx,%edx
     214:	89 fb                	mov    %edi,%ebx
     216:	89 5d 08             	mov    %ebx,0x8(%ebp)
     219:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     21c:	90                   	nop
     21d:	5b                   	pop    %ebx
     21e:	5f                   	pop    %edi
     21f:	5d                   	pop    %ebp
     220:	c3                   	ret    

00000221 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     221:	55                   	push   %ebp
     222:	89 e5                	mov    %esp,%ebp
     224:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     227:	8b 45 08             	mov    0x8(%ebp),%eax
     22a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     22d:	90                   	nop
     22e:	8b 55 0c             	mov    0xc(%ebp),%edx
     231:	8d 42 01             	lea    0x1(%edx),%eax
     234:	89 45 0c             	mov    %eax,0xc(%ebp)
     237:	8b 45 08             	mov    0x8(%ebp),%eax
     23a:	8d 48 01             	lea    0x1(%eax),%ecx
     23d:	89 4d 08             	mov    %ecx,0x8(%ebp)
     240:	0f b6 12             	movzbl (%edx),%edx
     243:	88 10                	mov    %dl,(%eax)
     245:	0f b6 00             	movzbl (%eax),%eax
     248:	84 c0                	test   %al,%al
     24a:	75 e2                	jne    22e <strcpy+0xd>
        ;
    return os;
     24c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     24f:	c9                   	leave  
     250:	c3                   	ret    

00000251 <strcmp>:

int strcmp(const char* p, const char* q) {
     251:	55                   	push   %ebp
     252:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     254:	eb 08                	jmp    25e <strcmp+0xd>
     256:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     25a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     25e:	8b 45 08             	mov    0x8(%ebp),%eax
     261:	0f b6 00             	movzbl (%eax),%eax
     264:	84 c0                	test   %al,%al
     266:	74 10                	je     278 <strcmp+0x27>
     268:	8b 45 08             	mov    0x8(%ebp),%eax
     26b:	0f b6 10             	movzbl (%eax),%edx
     26e:	8b 45 0c             	mov    0xc(%ebp),%eax
     271:	0f b6 00             	movzbl (%eax),%eax
     274:	38 c2                	cmp    %al,%dl
     276:	74 de                	je     256 <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     278:	8b 45 08             	mov    0x8(%ebp),%eax
     27b:	0f b6 00             	movzbl (%eax),%eax
     27e:	0f b6 d0             	movzbl %al,%edx
     281:	8b 45 0c             	mov    0xc(%ebp),%eax
     284:	0f b6 00             	movzbl (%eax),%eax
     287:	0f b6 c8             	movzbl %al,%ecx
     28a:	89 d0                	mov    %edx,%eax
     28c:	29 c8                	sub    %ecx,%eax
}
     28e:	5d                   	pop    %ebp
     28f:	c3                   	ret    

00000290 <strlen>:

uint strlen(const char* s) {
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     296:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     29d:	eb 04                	jmp    2a3 <strlen+0x13>
     29f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     2a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2a6:	8b 45 08             	mov    0x8(%ebp),%eax
     2a9:	01 d0                	add    %edx,%eax
     2ab:	0f b6 00             	movzbl (%eax),%eax
     2ae:	84 c0                	test   %al,%al
     2b0:	75 ed                	jne    29f <strlen+0xf>
        ;
    return n;
     2b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2b5:	c9                   	leave  
     2b6:	c3                   	ret    

000002b7 <memset>:

void* memset(void* dst, int c, uint n) {
     2b7:	55                   	push   %ebp
     2b8:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     2ba:	8b 45 10             	mov    0x10(%ebp),%eax
     2bd:	50                   	push   %eax
     2be:	ff 75 0c             	push   0xc(%ebp)
     2c1:	ff 75 08             	push   0x8(%ebp)
     2c4:	e8 32 ff ff ff       	call   1fb <stosb>
     2c9:	83 c4 0c             	add    $0xc,%esp
    return dst;
     2cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2cf:	c9                   	leave  
     2d0:	c3                   	ret    

000002d1 <strchr>:

char* strchr(const char* s, char c) {
     2d1:	55                   	push   %ebp
     2d2:	89 e5                	mov    %esp,%ebp
     2d4:	83 ec 04             	sub    $0x4,%esp
     2d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2da:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     2dd:	eb 14                	jmp    2f3 <strchr+0x22>
        if (*s == c) return (char*) s;
     2df:	8b 45 08             	mov    0x8(%ebp),%eax
     2e2:	0f b6 00             	movzbl (%eax),%eax
     2e5:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2e8:	75 05                	jne    2ef <strchr+0x1e>
     2ea:	8b 45 08             	mov    0x8(%ebp),%eax
     2ed:	eb 13                	jmp    302 <strchr+0x31>
    for (; *s; s++)
     2ef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2f3:	8b 45 08             	mov    0x8(%ebp),%eax
     2f6:	0f b6 00             	movzbl (%eax),%eax
     2f9:	84 c0                	test   %al,%al
     2fb:	75 e2                	jne    2df <strchr+0xe>
    return 0;
     2fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
     302:	c9                   	leave  
     303:	c3                   	ret    

00000304 <gets>:

char* gets(char* buf, int max) {
     304:	55                   	push   %ebp
     305:	89 e5                	mov    %esp,%ebp
     307:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     30a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     311:	eb 42                	jmp    355 <gets+0x51>
        cc = read(0, &c, 1);
     313:	83 ec 04             	sub    $0x4,%esp
     316:	6a 01                	push   $0x1
     318:	8d 45 ef             	lea    -0x11(%ebp),%eax
     31b:	50                   	push   %eax
     31c:	6a 00                	push   $0x0
     31e:	e8 28 fe ff ff       	call   14b <read>
     323:	83 c4 10             	add    $0x10,%esp
     326:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     329:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     32d:	7e 33                	jle    362 <gets+0x5e>
        buf[i++] = c;
     32f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     332:	8d 50 01             	lea    0x1(%eax),%edx
     335:	89 55 f4             	mov    %edx,-0xc(%ebp)
     338:	89 c2                	mov    %eax,%edx
     33a:	8b 45 08             	mov    0x8(%ebp),%eax
     33d:	01 c2                	add    %eax,%edx
     33f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     343:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     345:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     349:	3c 0a                	cmp    $0xa,%al
     34b:	74 16                	je     363 <gets+0x5f>
     34d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     351:	3c 0d                	cmp    $0xd,%al
     353:	74 0e                	je     363 <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     355:	8b 45 f4             	mov    -0xc(%ebp),%eax
     358:	83 c0 01             	add    $0x1,%eax
     35b:	39 45 0c             	cmp    %eax,0xc(%ebp)
     35e:	7f b3                	jg     313 <gets+0xf>
     360:	eb 01                	jmp    363 <gets+0x5f>
        if (cc < 1) break;
     362:	90                   	nop
    }
    buf[i] = '\0';
     363:	8b 55 f4             	mov    -0xc(%ebp),%edx
     366:	8b 45 08             	mov    0x8(%ebp),%eax
     369:	01 d0                	add    %edx,%eax
     36b:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     36e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     371:	c9                   	leave  
     372:	c3                   	ret    

00000373 <stat>:

int stat(const char* n, struct stat* st) {
     373:	55                   	push   %ebp
     374:	89 e5                	mov    %esp,%ebp
     376:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     379:	83 ec 08             	sub    $0x8,%esp
     37c:	6a 01                	push   $0x1
     37e:	ff 75 08             	push   0x8(%ebp)
     381:	e8 ed fd ff ff       	call   173 <open>
     386:	83 c4 10             	add    $0x10,%esp
     389:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     38c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     390:	79 07                	jns    399 <stat+0x26>
     392:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     397:	eb 25                	jmp    3be <stat+0x4b>
    r = fstat(fd, st);
     399:	83 ec 08             	sub    $0x8,%esp
     39c:	ff 75 0c             	push   0xc(%ebp)
     39f:	ff 75 f4             	push   -0xc(%ebp)
     3a2:	e8 e4 fd ff ff       	call   18b <fstat>
     3a7:	83 c4 10             	add    $0x10,%esp
     3aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     3ad:	83 ec 0c             	sub    $0xc,%esp
     3b0:	ff 75 f4             	push   -0xc(%ebp)
     3b3:	e8 a3 fd ff ff       	call   15b <close>
     3b8:	83 c4 10             	add    $0x10,%esp
    return r;
     3bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     3be:	c9                   	leave  
     3bf:	c3                   	ret    

000003c0 <atoi>:

int atoi(const char* s) {
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     3c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     3cd:	eb 25                	jmp    3f4 <atoi+0x34>
     3cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3d2:	89 d0                	mov    %edx,%eax
     3d4:	c1 e0 02             	shl    $0x2,%eax
     3d7:	01 d0                	add    %edx,%eax
     3d9:	01 c0                	add    %eax,%eax
     3db:	89 c1                	mov    %eax,%ecx
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
     3e0:	8d 50 01             	lea    0x1(%eax),%edx
     3e3:	89 55 08             	mov    %edx,0x8(%ebp)
     3e6:	0f b6 00             	movzbl (%eax),%eax
     3e9:	0f be c0             	movsbl %al,%eax
     3ec:	01 c8                	add    %ecx,%eax
     3ee:	83 e8 30             	sub    $0x30,%eax
     3f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
     3f4:	8b 45 08             	mov    0x8(%ebp),%eax
     3f7:	0f b6 00             	movzbl (%eax),%eax
     3fa:	3c 2f                	cmp    $0x2f,%al
     3fc:	7e 0a                	jle    408 <atoi+0x48>
     3fe:	8b 45 08             	mov    0x8(%ebp),%eax
     401:	0f b6 00             	movzbl (%eax),%eax
     404:	3c 39                	cmp    $0x39,%al
     406:	7e c7                	jle    3cf <atoi+0xf>
    return n;
     408:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     40b:	c9                   	leave  
     40c:	c3                   	ret    

0000040d <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     40d:	55                   	push   %ebp
     40e:	89 e5                	mov    %esp,%ebp
     410:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     413:	8b 45 08             	mov    0x8(%ebp),%eax
     416:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     41f:	eb 17                	jmp    438 <memmove+0x2b>
     421:	8b 55 f8             	mov    -0x8(%ebp),%edx
     424:	8d 42 01             	lea    0x1(%edx),%eax
     427:	89 45 f8             	mov    %eax,-0x8(%ebp)
     42a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     42d:	8d 48 01             	lea    0x1(%eax),%ecx
     430:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     433:	0f b6 12             	movzbl (%edx),%edx
     436:	88 10                	mov    %dl,(%eax)
     438:	8b 45 10             	mov    0x10(%ebp),%eax
     43b:	8d 50 ff             	lea    -0x1(%eax),%edx
     43e:	89 55 10             	mov    %edx,0x10(%ebp)
     441:	85 c0                	test   %eax,%eax
     443:	7f dc                	jg     421 <memmove+0x14>
    return vdst;
     445:	8b 45 08             	mov    0x8(%ebp),%eax
}
     448:	c9                   	leave  
     449:	c3                   	ret    

0000044a <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     44a:	55                   	push   %ebp
     44b:	89 e5                	mov    %esp,%ebp
     44d:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     450:	8b 45 08             	mov    0x8(%ebp),%eax
     453:	83 e8 08             	sub    $0x8,%eax
     456:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     459:	a1 48 2c 00 00       	mov    0x2c48,%eax
     45e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     461:	eb 24                	jmp    487 <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     463:	8b 45 fc             	mov    -0x4(%ebp),%eax
     466:	8b 00                	mov    (%eax),%eax
     468:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     46b:	72 12                	jb     47f <free+0x35>
     46d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     470:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     473:	77 24                	ja     499 <free+0x4f>
     475:	8b 45 fc             	mov    -0x4(%ebp),%eax
     478:	8b 00                	mov    (%eax),%eax
     47a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     47d:	72 1a                	jb     499 <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     47f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     482:	8b 00                	mov    (%eax),%eax
     484:	89 45 fc             	mov    %eax,-0x4(%ebp)
     487:	8b 45 f8             	mov    -0x8(%ebp),%eax
     48a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     48d:	76 d4                	jbe    463 <free+0x19>
     48f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     492:	8b 00                	mov    (%eax),%eax
     494:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     497:	73 ca                	jae    463 <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     499:	8b 45 f8             	mov    -0x8(%ebp),%eax
     49c:	8b 40 04             	mov    0x4(%eax),%eax
     49f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     4a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4a9:	01 c2                	add    %eax,%edx
     4ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4ae:	8b 00                	mov    (%eax),%eax
     4b0:	39 c2                	cmp    %eax,%edx
     4b2:	75 24                	jne    4d8 <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     4b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4b7:	8b 50 04             	mov    0x4(%eax),%edx
     4ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4bd:	8b 00                	mov    (%eax),%eax
     4bf:	8b 40 04             	mov    0x4(%eax),%eax
     4c2:	01 c2                	add    %eax,%edx
     4c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4c7:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     4ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4cd:	8b 00                	mov    (%eax),%eax
     4cf:	8b 10                	mov    (%eax),%edx
     4d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4d4:	89 10                	mov    %edx,(%eax)
     4d6:	eb 0a                	jmp    4e2 <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     4d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4db:	8b 10                	mov    (%eax),%edx
     4dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4e0:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     4e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4e5:	8b 40 04             	mov    0x4(%eax),%eax
     4e8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     4ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f2:	01 d0                	add    %edx,%eax
     4f4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     4f7:	75 20                	jne    519 <free+0xcf>
        p->s.size += bp->s.size;
     4f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4fc:	8b 50 04             	mov    0x4(%eax),%edx
     4ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
     502:	8b 40 04             	mov    0x4(%eax),%eax
     505:	01 c2                	add    %eax,%edx
     507:	8b 45 fc             	mov    -0x4(%ebp),%eax
     50a:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     50d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     510:	8b 10                	mov    (%eax),%edx
     512:	8b 45 fc             	mov    -0x4(%ebp),%eax
     515:	89 10                	mov    %edx,(%eax)
     517:	eb 08                	jmp    521 <free+0xd7>
    } else
        p->s.ptr = bp;
     519:	8b 45 fc             	mov    -0x4(%ebp),%eax
     51c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     51f:	89 10                	mov    %edx,(%eax)
    freep = p;
     521:	8b 45 fc             	mov    -0x4(%ebp),%eax
     524:	a3 48 2c 00 00       	mov    %eax,0x2c48
}
     529:	90                   	nop
     52a:	c9                   	leave  
     52b:	c3                   	ret    

0000052c <morecore>:

static Header* morecore(uint nu) {
     52c:	55                   	push   %ebp
     52d:	89 e5                	mov    %esp,%ebp
     52f:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     532:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     539:	77 07                	ja     542 <morecore+0x16>
     53b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     542:	8b 45 08             	mov    0x8(%ebp),%eax
     545:	c1 e0 03             	shl    $0x3,%eax
     548:	83 ec 0c             	sub    $0xc,%esp
     54b:	50                   	push   %eax
     54c:	e8 6a fc ff ff       	call   1bb <sbrk>
     551:	83 c4 10             	add    $0x10,%esp
     554:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     557:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     55b:	75 07                	jne    564 <morecore+0x38>
     55d:	b8 00 00 00 00       	mov    $0x0,%eax
     562:	eb 26                	jmp    58a <morecore+0x5e>
    hp = (Header*) p;
     564:	8b 45 f4             	mov    -0xc(%ebp),%eax
     567:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     56a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     56d:	8b 55 08             	mov    0x8(%ebp),%edx
     570:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     573:	8b 45 f0             	mov    -0x10(%ebp),%eax
     576:	83 c0 08             	add    $0x8,%eax
     579:	83 ec 0c             	sub    $0xc,%esp
     57c:	50                   	push   %eax
     57d:	e8 c8 fe ff ff       	call   44a <free>
     582:	83 c4 10             	add    $0x10,%esp
    return freep;
     585:	a1 48 2c 00 00       	mov    0x2c48,%eax
}
     58a:	c9                   	leave  
     58b:	c3                   	ret    

0000058c <malloc>:

void* malloc(uint nbytes) {
     58c:	55                   	push   %ebp
     58d:	89 e5                	mov    %esp,%ebp
     58f:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     592:	8b 45 08             	mov    0x8(%ebp),%eax
     595:	83 c0 07             	add    $0x7,%eax
     598:	c1 e8 03             	shr    $0x3,%eax
     59b:	83 c0 01             	add    $0x1,%eax
     59e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     5a1:	a1 48 2c 00 00       	mov    0x2c48,%eax
     5a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     5a9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     5ad:	75 23                	jne    5d2 <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     5af:	c7 45 f0 40 2c 00 00 	movl   $0x2c40,-0x10(%ebp)
     5b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5b9:	a3 48 2c 00 00       	mov    %eax,0x2c48
     5be:	a1 48 2c 00 00       	mov    0x2c48,%eax
     5c3:	a3 40 2c 00 00       	mov    %eax,0x2c40
        base.s.size = 0;
     5c8:	c7 05 44 2c 00 00 00 	movl   $0x0,0x2c44
     5cf:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     5d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5d5:	8b 00                	mov    (%eax),%eax
     5d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     5da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5dd:	8b 40 04             	mov    0x4(%eax),%eax
     5e0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     5e3:	77 4d                	ja     632 <malloc+0xa6>
            if (p->s.size == nunits)
     5e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e8:	8b 40 04             	mov    0x4(%eax),%eax
     5eb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     5ee:	75 0c                	jne    5fc <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     5f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f3:	8b 10                	mov    (%eax),%edx
     5f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5f8:	89 10                	mov    %edx,(%eax)
     5fa:	eb 26                	jmp    622 <malloc+0x96>
            else {
                p->s.size -= nunits;
     5fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ff:	8b 40 04             	mov    0x4(%eax),%eax
     602:	2b 45 ec             	sub    -0x14(%ebp),%eax
     605:	89 c2                	mov    %eax,%edx
     607:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60a:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     60d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     610:	8b 40 04             	mov    0x4(%eax),%eax
     613:	c1 e0 03             	shl    $0x3,%eax
     616:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     619:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     61f:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     622:	8b 45 f0             	mov    -0x10(%ebp),%eax
     625:	a3 48 2c 00 00       	mov    %eax,0x2c48
            return (void*) (p + 1);
     62a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62d:	83 c0 08             	add    $0x8,%eax
     630:	eb 3b                	jmp    66d <malloc+0xe1>
        }
        if (p == freep)
     632:	a1 48 2c 00 00       	mov    0x2c48,%eax
     637:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     63a:	75 1e                	jne    65a <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     63c:	83 ec 0c             	sub    $0xc,%esp
     63f:	ff 75 ec             	push   -0x14(%ebp)
     642:	e8 e5 fe ff ff       	call   52c <morecore>
     647:	83 c4 10             	add    $0x10,%esp
     64a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     64d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     651:	75 07                	jne    65a <malloc+0xce>
     653:	b8 00 00 00 00       	mov    $0x0,%eax
     658:	eb 13                	jmp    66d <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     65a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     660:	8b 45 f4             	mov    -0xc(%ebp),%eax
     663:	8b 00                	mov    (%eax),%eax
     665:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     668:	e9 6d ff ff ff       	jmp    5da <malloc+0x4e>
    }
}
     66d:	c9                   	leave  
     66e:	c3                   	ret    

0000066f <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     66f:	55                   	push   %ebp
     670:	89 e5                	mov    %esp,%ebp
     672:	83 ec 18             	sub    $0x18,%esp
     675:	8b 45 0c             	mov    0xc(%ebp),%eax
     678:	88 45 f4             	mov    %al,-0xc(%ebp)
     67b:	83 ec 04             	sub    $0x4,%esp
     67e:	6a 01                	push   $0x1
     680:	8d 45 f4             	lea    -0xc(%ebp),%eax
     683:	50                   	push   %eax
     684:	ff 75 08             	push   0x8(%ebp)
     687:	e8 c7 fa ff ff       	call   153 <write>
     68c:	83 c4 10             	add    $0x10,%esp
     68f:	90                   	nop
     690:	c9                   	leave  
     691:	c3                   	ret    

00000692 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     692:	55                   	push   %ebp
     693:	89 e5                	mov    %esp,%ebp
     695:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     698:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     69f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6a3:	74 17                	je     6bc <printint+0x2a>
     6a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6a9:	79 11                	jns    6bc <printint+0x2a>
        neg = 1;
     6ab:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     6b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     6b5:	f7 d8                	neg    %eax
     6b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6ba:	eb 06                	jmp    6c2 <printint+0x30>
    } else {
        x = xx;
     6bc:	8b 45 0c             	mov    0xc(%ebp),%eax
     6bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     6c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     6c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6cf:	ba 00 00 00 00       	mov    $0x0,%edx
     6d4:	f7 f1                	div    %ecx
     6d6:	89 d1                	mov    %edx,%ecx
     6d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6db:	8d 50 01             	lea    0x1(%eax),%edx
     6de:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6e1:	0f b6 91 0c 2a 00 00 	movzbl 0x2a0c(%ecx),%edx
     6e8:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     6ec:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6f2:	ba 00 00 00 00       	mov    $0x0,%edx
     6f7:	f7 f1                	div    %ecx
     6f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     700:	75 c7                	jne    6c9 <printint+0x37>
    if (neg) buf[i++] = '-';
     702:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     706:	74 2d                	je     735 <printint+0xa3>
     708:	8b 45 f4             	mov    -0xc(%ebp),%eax
     70b:	8d 50 01             	lea    0x1(%eax),%edx
     70e:	89 55 f4             	mov    %edx,-0xc(%ebp)
     711:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     716:	eb 1d                	jmp    735 <printint+0xa3>
     718:	8d 55 dc             	lea    -0x24(%ebp),%edx
     71b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71e:	01 d0                	add    %edx,%eax
     720:	0f b6 00             	movzbl (%eax),%eax
     723:	0f be c0             	movsbl %al,%eax
     726:	83 ec 08             	sub    $0x8,%esp
     729:	50                   	push   %eax
     72a:	ff 75 08             	push   0x8(%ebp)
     72d:	e8 3d ff ff ff       	call   66f <putc>
     732:	83 c4 10             	add    $0x10,%esp
     735:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     739:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     73d:	79 d9                	jns    718 <printint+0x86>
}
     73f:	90                   	nop
     740:	90                   	nop
     741:	c9                   	leave  
     742:	c3                   	ret    

00000743 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     743:	55                   	push   %ebp
     744:	89 e5                	mov    %esp,%ebp
     746:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     749:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     750:	8d 45 0c             	lea    0xc(%ebp),%eax
     753:	83 c0 04             	add    $0x4,%eax
     756:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     759:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     760:	e9 59 01 00 00       	jmp    8be <printf+0x17b>
        c = fmt[i] & 0xff;
     765:	8b 55 0c             	mov    0xc(%ebp),%edx
     768:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76b:	01 d0                	add    %edx,%eax
     76d:	0f b6 00             	movzbl (%eax),%eax
     770:	0f be c0             	movsbl %al,%eax
     773:	25 ff 00 00 00       	and    $0xff,%eax
     778:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     77b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     77f:	75 2c                	jne    7ad <printf+0x6a>
            if (c == '%') {
     781:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     785:	75 0c                	jne    793 <printf+0x50>
                state = '%';
     787:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     78e:	e9 27 01 00 00       	jmp    8ba <printf+0x177>
            } else {
                putc(fd, c);
     793:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     796:	0f be c0             	movsbl %al,%eax
     799:	83 ec 08             	sub    $0x8,%esp
     79c:	50                   	push   %eax
     79d:	ff 75 08             	push   0x8(%ebp)
     7a0:	e8 ca fe ff ff       	call   66f <putc>
     7a5:	83 c4 10             	add    $0x10,%esp
     7a8:	e9 0d 01 00 00       	jmp    8ba <printf+0x177>
            }
        } else if (state == '%') {
     7ad:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7b1:	0f 85 03 01 00 00    	jne    8ba <printf+0x177>
            if (c == 'd') {
     7b7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7bb:	75 1e                	jne    7db <printf+0x98>
                printint(fd, *ap, 10, 1);
     7bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7c0:	8b 00                	mov    (%eax),%eax
     7c2:	6a 01                	push   $0x1
     7c4:	6a 0a                	push   $0xa
     7c6:	50                   	push   %eax
     7c7:	ff 75 08             	push   0x8(%ebp)
     7ca:	e8 c3 fe ff ff       	call   692 <printint>
     7cf:	83 c4 10             	add    $0x10,%esp
                ap++;
     7d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7d6:	e9 d8 00 00 00       	jmp    8b3 <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     7db:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7df:	74 06                	je     7e7 <printf+0xa4>
     7e1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7e5:	75 1e                	jne    805 <printf+0xc2>
                printint(fd, *ap, 16, 0);
     7e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7ea:	8b 00                	mov    (%eax),%eax
     7ec:	6a 00                	push   $0x0
     7ee:	6a 10                	push   $0x10
     7f0:	50                   	push   %eax
     7f1:	ff 75 08             	push   0x8(%ebp)
     7f4:	e8 99 fe ff ff       	call   692 <printint>
     7f9:	83 c4 10             	add    $0x10,%esp
                ap++;
     7fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     800:	e9 ae 00 00 00       	jmp    8b3 <printf+0x170>
            } else if (c == 's') {
     805:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     809:	75 43                	jne    84e <printf+0x10b>
                s = (char*) *ap;
     80b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     80e:	8b 00                	mov    (%eax),%eax
     810:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     813:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     817:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     81b:	75 25                	jne    842 <printf+0xff>
     81d:	c7 45 f4 18 20 00 00 	movl   $0x2018,-0xc(%ebp)
                while (*s != 0) {
     824:	eb 1c                	jmp    842 <printf+0xff>
                    putc(fd, *s);
     826:	8b 45 f4             	mov    -0xc(%ebp),%eax
     829:	0f b6 00             	movzbl (%eax),%eax
     82c:	0f be c0             	movsbl %al,%eax
     82f:	83 ec 08             	sub    $0x8,%esp
     832:	50                   	push   %eax
     833:	ff 75 08             	push   0x8(%ebp)
     836:	e8 34 fe ff ff       	call   66f <putc>
     83b:	83 c4 10             	add    $0x10,%esp
                    s++;
     83e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     842:	8b 45 f4             	mov    -0xc(%ebp),%eax
     845:	0f b6 00             	movzbl (%eax),%eax
     848:	84 c0                	test   %al,%al
     84a:	75 da                	jne    826 <printf+0xe3>
     84c:	eb 65                	jmp    8b3 <printf+0x170>
                }
            } else if (c == 'c') {
     84e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     852:	75 1d                	jne    871 <printf+0x12e>
                putc(fd, *ap);
     854:	8b 45 e8             	mov    -0x18(%ebp),%eax
     857:	8b 00                	mov    (%eax),%eax
     859:	0f be c0             	movsbl %al,%eax
     85c:	83 ec 08             	sub    $0x8,%esp
     85f:	50                   	push   %eax
     860:	ff 75 08             	push   0x8(%ebp)
     863:	e8 07 fe ff ff       	call   66f <putc>
     868:	83 c4 10             	add    $0x10,%esp
                ap++;
     86b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     86f:	eb 42                	jmp    8b3 <printf+0x170>
            } else if (c == '%') {
     871:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     875:	75 17                	jne    88e <printf+0x14b>
                putc(fd, c);
     877:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     87a:	0f be c0             	movsbl %al,%eax
     87d:	83 ec 08             	sub    $0x8,%esp
     880:	50                   	push   %eax
     881:	ff 75 08             	push   0x8(%ebp)
     884:	e8 e6 fd ff ff       	call   66f <putc>
     889:	83 c4 10             	add    $0x10,%esp
     88c:	eb 25                	jmp    8b3 <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     88e:	83 ec 08             	sub    $0x8,%esp
     891:	6a 25                	push   $0x25
     893:	ff 75 08             	push   0x8(%ebp)
     896:	e8 d4 fd ff ff       	call   66f <putc>
     89b:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     89e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8a1:	0f be c0             	movsbl %al,%eax
     8a4:	83 ec 08             	sub    $0x8,%esp
     8a7:	50                   	push   %eax
     8a8:	ff 75 08             	push   0x8(%ebp)
     8ab:	e8 bf fd ff ff       	call   66f <putc>
     8b0:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     8b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     8ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8be:	8b 55 0c             	mov    0xc(%ebp),%edx
     8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c4:	01 d0                	add    %edx,%eax
     8c6:	0f b6 00             	movzbl (%eax),%eax
     8c9:	84 c0                	test   %al,%al
     8cb:	0f 85 94 fe ff ff    	jne    765 <printf+0x22>
        }
    }
}
     8d1:	90                   	nop
     8d2:	90                   	nop
     8d3:	c9                   	leave  
     8d4:	c3                   	ret    

000008d5 <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     8d5:	55                   	push   %ebp
     8d6:	89 e5                	mov    %esp,%ebp
     8d8:	83 ec 04             	sub    $0x4,%esp
     8db:	8b 45 08             	mov    0x8(%ebp),%eax
     8de:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     8e1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     8e5:	01 c0                	add    %eax,%eax
     8e7:	89 c1                	mov    %eax,%ecx
     8e9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     8ed:	c0 e8 07             	shr    $0x7,%al
     8f0:	89 c2                	mov    %eax,%edx
     8f2:	89 d0                	mov    %edx,%eax
     8f4:	01 c0                	add    %eax,%eax
     8f6:	01 d0                	add    %edx,%eax
     8f8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     8ff:	01 d0                	add    %edx,%eax
     901:	31 c8                	xor    %ecx,%eax
}
     903:	c9                   	leave  
     904:	c3                   	ret    

00000905 <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     905:	55                   	push   %ebp
     906:	89 e5                	mov    %esp,%ebp
     908:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     909:	bb 00 00 00 00       	mov    $0x0,%ebx
     90e:	eb 24                	jmp    934 <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     910:	0f b6 d3             	movzbl %bl,%edx
     913:	8b 45 08             	mov    0x8(%ebp),%eax
     916:	01 d0                	add    %edx,%eax
     918:	0f b6 00             	movzbl (%eax),%eax
     91b:	0f b6 c0             	movzbl %al,%eax
     91e:	0f b6 cb             	movzbl %bl,%ecx
     921:	8b 55 08             	mov    0x8(%ebp),%edx
     924:	01 ca                	add    %ecx,%edx
     926:	0f b6 80 20 20 00 00 	movzbl 0x2020(%eax),%eax
     92d:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     92f:	89 d8                	mov    %ebx,%eax
     931:	8d 58 01             	lea    0x1(%eax),%ebx
     934:	80 fb 0f             	cmp    $0xf,%bl
     937:	76 d7                	jbe    910 <aes_subBytes+0xb>
    }
}
     939:	90                   	nop
     93a:	90                   	nop
     93b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     93e:	c9                   	leave  
     93f:	c3                   	ret    

00000940 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	56                   	push   %esi
     944:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     945:	bb 00 00 00 00       	mov    $0x0,%ebx
     94a:	eb 27                	jmp    973 <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     94c:	0f b6 d3             	movzbl %bl,%edx
     94f:	8b 45 08             	mov    0x8(%ebp),%eax
     952:	01 d0                	add    %edx,%eax
     954:	0f b6 08             	movzbl (%eax),%ecx
     957:	0f b6 d3             	movzbl %bl,%edx
     95a:	8b 45 0c             	mov    0xc(%ebp),%eax
     95d:	01 d0                	add    %edx,%eax
     95f:	0f b6 10             	movzbl (%eax),%edx
     962:	0f b6 f3             	movzbl %bl,%esi
     965:	8b 45 08             	mov    0x8(%ebp),%eax
     968:	01 f0                	add    %esi,%eax
     96a:	31 ca                	xor    %ecx,%edx
     96c:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     96e:	89 d8                	mov    %ebx,%eax
     970:	8d 58 01             	lea    0x1(%eax),%ebx
     973:	80 fb 0f             	cmp    $0xf,%bl
     976:	76 d4                	jbe    94c <aes_addRoundKey+0xc>
    }
}
     978:	90                   	nop
     979:	90                   	nop
     97a:	5b                   	pop    %ebx
     97b:	5e                   	pop    %esi
     97c:	5d                   	pop    %ebp
     97d:	c3                   	ret    

0000097e <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     97e:	55                   	push   %ebp
     97f:	89 e5                	mov    %esp,%ebp
     981:	56                   	push   %esi
     982:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     983:	bb 00 00 00 00       	mov    $0x0,%ebx
     988:	eb 5b                	jmp    9e5 <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     98a:	0f b6 d3             	movzbl %bl,%edx
     98d:	8b 45 0c             	mov    0xc(%ebp),%eax
     990:	01 d0                	add    %edx,%eax
     992:	0f b6 cb             	movzbl %bl,%ecx
     995:	8b 55 10             	mov    0x10(%ebp),%edx
     998:	01 ca                	add    %ecx,%edx
     99a:	0f b6 00             	movzbl (%eax),%eax
     99d:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     99f:	0f b6 d3             	movzbl %bl,%edx
     9a2:	8b 45 08             	mov    0x8(%ebp),%eax
     9a5:	01 d0                	add    %edx,%eax
     9a7:	0f b6 08             	movzbl (%eax),%ecx
     9aa:	0f b6 d3             	movzbl %bl,%edx
     9ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     9b0:	01 d0                	add    %edx,%eax
     9b2:	0f b6 10             	movzbl (%eax),%edx
     9b5:	0f b6 f3             	movzbl %bl,%esi
     9b8:	8b 45 08             	mov    0x8(%ebp),%eax
     9bb:	01 f0                	add    %esi,%eax
     9bd:	31 ca                	xor    %ecx,%edx
     9bf:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     9c1:	0f b6 c3             	movzbl %bl,%eax
     9c4:	83 c0 10             	add    $0x10,%eax
     9c7:	89 c2                	mov    %eax,%edx
     9c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     9cc:	01 d0                	add    %edx,%eax
     9ce:	0f b6 d3             	movzbl %bl,%edx
     9d1:	83 c2 10             	add    $0x10,%edx
     9d4:	89 d1                	mov    %edx,%ecx
     9d6:	8b 55 10             	mov    0x10(%ebp),%edx
     9d9:	01 ca                	add    %ecx,%edx
     9db:	0f b6 00             	movzbl (%eax),%eax
     9de:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     9e0:	89 d8                	mov    %ebx,%eax
     9e2:	8d 58 01             	lea    0x1(%eax),%ebx
     9e5:	80 fb 0f             	cmp    $0xf,%bl
     9e8:	76 a0                	jbe    98a <aes_addRoundKey_cpy+0xc>
    }
}
     9ea:	90                   	nop
     9eb:	90                   	nop
     9ec:	5b                   	pop    %ebx
     9ed:	5e                   	pop    %esi
     9ee:	5d                   	pop    %ebp
     9ef:	c3                   	ret    

000009f0 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	53                   	push   %ebx
     9f4:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     9f7:	8b 45 08             	mov    0x8(%ebp),%eax
     9fa:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     9fe:	8b 45 08             	mov    0x8(%ebp),%eax
     a01:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     a05:	88 45 fb             	mov    %al,-0x5(%ebp)
     a08:	8b 45 08             	mov    0x8(%ebp),%eax
     a0b:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     a0f:	88 5d fa             	mov    %bl,-0x6(%ebp)
     a12:	8b 45 08             	mov    0x8(%ebp),%eax
     a15:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     a19:	8b 45 08             	mov    0x8(%ebp),%eax
     a1c:	8d 50 01             	lea    0x1(%eax),%edx
     a1f:	8b 45 08             	mov    0x8(%ebp),%eax
     a22:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     a26:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     a28:	8b 45 08             	mov    0x8(%ebp),%eax
     a2b:	8d 50 05             	lea    0x5(%eax),%edx
     a2e:	8b 45 08             	mov    0x8(%ebp),%eax
     a31:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     a35:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     a37:	8b 45 08             	mov    0x8(%ebp),%eax
     a3a:	8d 50 09             	lea    0x9(%eax),%edx
     a3d:	8b 45 08             	mov    0x8(%ebp),%eax
     a40:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     a44:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     a46:	8b 45 08             	mov    0x8(%ebp),%eax
     a49:	83 c0 0d             	add    $0xd,%eax
     a4c:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     a4e:	8b 45 08             	mov    0x8(%ebp),%eax
     a51:	8d 50 03             	lea    0x3(%eax),%edx
     a54:	8b 45 08             	mov    0x8(%ebp),%eax
     a57:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     a5b:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     a5d:	8b 45 08             	mov    0x8(%ebp),%eax
     a60:	8d 50 0f             	lea    0xf(%eax),%edx
     a63:	8b 45 08             	mov    0x8(%ebp),%eax
     a66:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     a6a:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     a6c:	8b 45 08             	mov    0x8(%ebp),%eax
     a6f:	8d 50 0b             	lea    0xb(%eax),%edx
     a72:	8b 45 08             	mov    0x8(%ebp),%eax
     a75:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     a79:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     a7b:	8b 45 08             	mov    0x8(%ebp),%eax
     a7e:	83 c0 07             	add    $0x7,%eax
     a81:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     a85:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     a87:	8b 45 08             	mov    0x8(%ebp),%eax
     a8a:	8d 50 0a             	lea    0xa(%eax),%edx
     a8d:	8b 45 08             	mov    0x8(%ebp),%eax
     a90:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     a94:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     a96:	8b 45 08             	mov    0x8(%ebp),%eax
     a99:	83 c0 02             	add    $0x2,%eax
     a9c:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     aa0:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     aa2:	8b 45 08             	mov    0x8(%ebp),%eax
     aa5:	8d 50 0e             	lea    0xe(%eax),%edx
     aa8:	8b 45 08             	mov    0x8(%ebp),%eax
     aab:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     aaf:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     ab1:	8b 45 08             	mov    0x8(%ebp),%eax
     ab4:	83 c0 06             	add    $0x6,%eax
     ab7:	88 18                	mov    %bl,(%eax)
}
     ab9:	90                   	nop
     aba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     abd:	c9                   	leave  
     abe:	c3                   	ret    

00000abf <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     abf:	55                   	push   %ebp
     ac0:	89 e5                	mov    %esp,%ebp
     ac2:	56                   	push   %esi
     ac3:	53                   	push   %ebx
     ac4:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     ac7:	bb 00 00 00 00       	mov    $0x0,%ebx
     acc:	e9 42 01 00 00       	jmp    c13 <aes_mixColumns+0x154>
        a = buf[i];
     ad1:	0f b6 d3             	movzbl %bl,%edx
     ad4:	8b 45 08             	mov    0x8(%ebp),%eax
     ad7:	01 d0                	add    %edx,%eax
     ad9:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     adc:	0f b6 c3             	movzbl %bl,%eax
     adf:	8d 50 01             	lea    0x1(%eax),%edx
     ae2:	8b 45 08             	mov    0x8(%ebp),%eax
     ae5:	01 d0                	add    %edx,%eax
     ae7:	0f b6 10             	movzbl (%eax),%edx
     aea:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     aed:	0f b6 c3             	movzbl %bl,%eax
     af0:	8d 50 02             	lea    0x2(%eax),%edx
     af3:	8b 45 08             	mov    0x8(%ebp),%eax
     af6:	01 d0                	add    %edx,%eax
     af8:	0f b6 00             	movzbl (%eax),%eax
     afb:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     afe:	0f b6 c3             	movzbl %bl,%eax
     b01:	8d 50 03             	lea    0x3(%eax),%edx
     b04:	8b 45 08             	mov    0x8(%ebp),%eax
     b07:	01 d0                	add    %edx,%eax
     b09:	0f b6 00             	movzbl (%eax),%eax
     b0c:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     b0f:	89 c8                	mov    %ecx,%eax
     b11:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     b15:	31 d0                	xor    %edx,%eax
     b17:	32 45 f6             	xor    -0xa(%ebp),%al
     b1a:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     b1e:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     b20:	88 4d f4             	mov    %cl,-0xc(%ebp)
     b23:	89 c8                	mov    %ecx,%eax
     b25:	88 55 f7             	mov    %dl,-0x9(%ebp)
     b28:	32 45 f7             	xor    -0x9(%ebp),%al
     b2b:	0f b6 c0             	movzbl %al,%eax
     b2e:	50                   	push   %eax
     b2f:	e8 a1 fd ff ff       	call   8d5 <rj_xtime>
     b34:	83 c4 04             	add    $0x4,%esp
     b37:	31 f0                	xor    %esi,%eax
     b39:	0f b6 c8             	movzbl %al,%ecx
     b3c:	0f b6 d3             	movzbl %bl,%edx
     b3f:	8b 45 08             	mov    0x8(%ebp),%eax
     b42:	01 d0                	add    %edx,%eax
     b44:	0f b6 00             	movzbl (%eax),%eax
     b47:	89 c2                	mov    %eax,%edx
     b49:	89 c8                	mov    %ecx,%eax
     b4b:	89 d1                	mov    %edx,%ecx
     b4d:	31 c1                	xor    %eax,%ecx
     b4f:	0f b6 d3             	movzbl %bl,%edx
     b52:	8b 45 08             	mov    0x8(%ebp),%eax
     b55:	01 c2                	add    %eax,%edx
     b57:	89 c8                	mov    %ecx,%eax
     b59:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     b5b:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     b5f:	32 55 f6             	xor    -0xa(%ebp),%dl
     b62:	89 d0                	mov    %edx,%eax
     b64:	0f b6 c0             	movzbl %al,%eax
     b67:	50                   	push   %eax
     b68:	e8 68 fd ff ff       	call   8d5 <rj_xtime>
     b6d:	83 c4 04             	add    $0x4,%esp
     b70:	31 f0                	xor    %esi,%eax
     b72:	0f b6 c8             	movzbl %al,%ecx
     b75:	0f b6 c3             	movzbl %bl,%eax
     b78:	8d 50 01             	lea    0x1(%eax),%edx
     b7b:	8b 45 08             	mov    0x8(%ebp),%eax
     b7e:	01 d0                	add    %edx,%eax
     b80:	0f b6 00             	movzbl (%eax),%eax
     b83:	89 c2                	mov    %eax,%edx
     b85:	89 c8                	mov    %ecx,%eax
     b87:	31 c2                	xor    %eax,%edx
     b89:	89 d1                	mov    %edx,%ecx
     b8b:	0f b6 c3             	movzbl %bl,%eax
     b8e:	8d 50 01             	lea    0x1(%eax),%edx
     b91:	8b 45 08             	mov    0x8(%ebp),%eax
     b94:	01 c2                	add    %eax,%edx
     b96:	89 c8                	mov    %ecx,%eax
     b98:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     b9a:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     b9e:	32 45 f5             	xor    -0xb(%ebp),%al
     ba1:	0f b6 c0             	movzbl %al,%eax
     ba4:	50                   	push   %eax
     ba5:	e8 2b fd ff ff       	call   8d5 <rj_xtime>
     baa:	83 c4 04             	add    $0x4,%esp
     bad:	31 f0                	xor    %esi,%eax
     baf:	0f b6 d0             	movzbl %al,%edx
     bb2:	0f b6 c3             	movzbl %bl,%eax
     bb5:	8d 48 02             	lea    0x2(%eax),%ecx
     bb8:	8b 45 08             	mov    0x8(%ebp),%eax
     bbb:	01 c8                	add    %ecx,%eax
     bbd:	0f b6 00             	movzbl (%eax),%eax
     bc0:	89 c1                	mov    %eax,%ecx
     bc2:	89 d0                	mov    %edx,%eax
     bc4:	89 ca                	mov    %ecx,%edx
     bc6:	31 c2                	xor    %eax,%edx
     bc8:	0f b6 c3             	movzbl %bl,%eax
     bcb:	8d 48 02             	lea    0x2(%eax),%ecx
     bce:	8b 45 08             	mov    0x8(%ebp),%eax
     bd1:	01 c8                	add    %ecx,%eax
     bd3:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     bd5:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     bd9:	32 45 f4             	xor    -0xc(%ebp),%al
     bdc:	0f b6 c0             	movzbl %al,%eax
     bdf:	50                   	push   %eax
     be0:	e8 f0 fc ff ff       	call   8d5 <rj_xtime>
     be5:	83 c4 04             	add    $0x4,%esp
     be8:	31 f0                	xor    %esi,%eax
     bea:	0f b6 d0             	movzbl %al,%edx
     bed:	0f b6 c3             	movzbl %bl,%eax
     bf0:	8d 48 03             	lea    0x3(%eax),%ecx
     bf3:	8b 45 08             	mov    0x8(%ebp),%eax
     bf6:	01 c8                	add    %ecx,%eax
     bf8:	0f b6 00             	movzbl (%eax),%eax
     bfb:	89 c1                	mov    %eax,%ecx
     bfd:	89 d0                	mov    %edx,%eax
     bff:	31 c1                	xor    %eax,%ecx
     c01:	89 ca                	mov    %ecx,%edx
     c03:	0f b6 c3             	movzbl %bl,%eax
     c06:	8d 48 03             	lea    0x3(%eax),%ecx
     c09:	8b 45 08             	mov    0x8(%ebp),%eax
     c0c:	01 c8                	add    %ecx,%eax
     c0e:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     c10:	83 c3 04             	add    $0x4,%ebx
     c13:	80 fb 0f             	cmp    $0xf,%bl
     c16:	0f 86 b5 fe ff ff    	jbe    ad1 <aes_mixColumns+0x12>
    }
}
     c1c:	90                   	nop
     c1d:	90                   	nop
     c1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c21:	5b                   	pop    %ebx
     c22:	5e                   	pop    %esi
     c23:	5d                   	pop    %ebp
     c24:	c3                   	ret    

00000c25 <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     c25:	55                   	push   %ebp
     c26:	89 e5                	mov    %esp,%ebp
     c28:	56                   	push   %esi
     c29:	53                   	push   %ebx
     c2a:	83 ec 04             	sub    $0x4,%esp
     c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     c30:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	0f b6 10             	movzbl (%eax),%edx
     c39:	8b 45 08             	mov    0x8(%ebp),%eax
     c3c:	83 c0 1d             	add    $0x1d,%eax
     c3f:	0f b6 00             	movzbl (%eax),%eax
     c42:	0f b6 c0             	movzbl %al,%eax
     c45:	0f b6 80 20 20 00 00 	movzbl 0x2020(%eax),%eax
     c4c:	32 45 f4             	xor    -0xc(%ebp),%al
     c4f:	31 c2                	xor    %eax,%edx
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     c56:	8b 45 08             	mov    0x8(%ebp),%eax
     c59:	83 c0 01             	add    $0x1,%eax
     c5c:	0f b6 08             	movzbl (%eax),%ecx
     c5f:	8b 45 08             	mov    0x8(%ebp),%eax
     c62:	83 c0 1e             	add    $0x1e,%eax
     c65:	0f b6 00             	movzbl (%eax),%eax
     c68:	0f b6 c0             	movzbl %al,%eax
     c6b:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     c72:	8b 45 08             	mov    0x8(%ebp),%eax
     c75:	83 c0 01             	add    $0x1,%eax
     c78:	31 ca                	xor    %ecx,%edx
     c7a:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     c7c:	8b 45 08             	mov    0x8(%ebp),%eax
     c7f:	83 c0 02             	add    $0x2,%eax
     c82:	0f b6 08             	movzbl (%eax),%ecx
     c85:	8b 45 08             	mov    0x8(%ebp),%eax
     c88:	83 c0 1f             	add    $0x1f,%eax
     c8b:	0f b6 00             	movzbl (%eax),%eax
     c8e:	0f b6 c0             	movzbl %al,%eax
     c91:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     c98:	8b 45 08             	mov    0x8(%ebp),%eax
     c9b:	83 c0 02             	add    $0x2,%eax
     c9e:	31 ca                	xor    %ecx,%edx
     ca0:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     ca2:	8b 45 08             	mov    0x8(%ebp),%eax
     ca5:	83 c0 03             	add    $0x3,%eax
     ca8:	0f b6 08             	movzbl (%eax),%ecx
     cab:	8b 45 08             	mov    0x8(%ebp),%eax
     cae:	83 c0 1c             	add    $0x1c,%eax
     cb1:	0f b6 00             	movzbl (%eax),%eax
     cb4:	0f b6 c0             	movzbl %al,%eax
     cb7:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     cbe:	8b 45 08             	mov    0x8(%ebp),%eax
     cc1:	83 c0 03             	add    $0x3,%eax
     cc4:	31 ca                	xor    %ecx,%edx
     cc6:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     cc8:	bb 04 00 00 00       	mov    $0x4,%ebx
     ccd:	e9 a9 00 00 00       	jmp    d7b <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     cd2:	0f b6 d3             	movzbl %bl,%edx
     cd5:	8b 45 08             	mov    0x8(%ebp),%eax
     cd8:	01 d0                	add    %edx,%eax
     cda:	0f b6 08             	movzbl (%eax),%ecx
     cdd:	0f b6 c3             	movzbl %bl,%eax
     ce0:	8d 50 fc             	lea    -0x4(%eax),%edx
     ce3:	8b 45 08             	mov    0x8(%ebp),%eax
     ce6:	01 d0                	add    %edx,%eax
     ce8:	0f b6 10             	movzbl (%eax),%edx
     ceb:	0f b6 f3             	movzbl %bl,%esi
     cee:	8b 45 08             	mov    0x8(%ebp),%eax
     cf1:	01 f0                	add    %esi,%eax
     cf3:	31 ca                	xor    %ecx,%edx
     cf5:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     cf7:	0f b6 c3             	movzbl %bl,%eax
     cfa:	8d 50 01             	lea    0x1(%eax),%edx
     cfd:	8b 45 08             	mov    0x8(%ebp),%eax
     d00:	01 d0                	add    %edx,%eax
     d02:	0f b6 08             	movzbl (%eax),%ecx
     d05:	0f b6 c3             	movzbl %bl,%eax
     d08:	8d 50 fd             	lea    -0x3(%eax),%edx
     d0b:	8b 45 08             	mov    0x8(%ebp),%eax
     d0e:	01 d0                	add    %edx,%eax
     d10:	0f b6 10             	movzbl (%eax),%edx
     d13:	0f b6 c3             	movzbl %bl,%eax
     d16:	8d 70 01             	lea    0x1(%eax),%esi
     d19:	8b 45 08             	mov    0x8(%ebp),%eax
     d1c:	01 f0                	add    %esi,%eax
     d1e:	31 ca                	xor    %ecx,%edx
     d20:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     d22:	0f b6 c3             	movzbl %bl,%eax
     d25:	8d 50 02             	lea    0x2(%eax),%edx
     d28:	8b 45 08             	mov    0x8(%ebp),%eax
     d2b:	01 d0                	add    %edx,%eax
     d2d:	0f b6 08             	movzbl (%eax),%ecx
     d30:	0f b6 c3             	movzbl %bl,%eax
     d33:	8d 50 fe             	lea    -0x2(%eax),%edx
     d36:	8b 45 08             	mov    0x8(%ebp),%eax
     d39:	01 d0                	add    %edx,%eax
     d3b:	0f b6 10             	movzbl (%eax),%edx
     d3e:	0f b6 c3             	movzbl %bl,%eax
     d41:	8d 70 02             	lea    0x2(%eax),%esi
     d44:	8b 45 08             	mov    0x8(%ebp),%eax
     d47:	01 f0                	add    %esi,%eax
     d49:	31 ca                	xor    %ecx,%edx
     d4b:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     d4d:	0f b6 c3             	movzbl %bl,%eax
     d50:	8d 50 03             	lea    0x3(%eax),%edx
     d53:	8b 45 08             	mov    0x8(%ebp),%eax
     d56:	01 d0                	add    %edx,%eax
     d58:	0f b6 08             	movzbl (%eax),%ecx
     d5b:	0f b6 c3             	movzbl %bl,%eax
     d5e:	8d 50 ff             	lea    -0x1(%eax),%edx
     d61:	8b 45 08             	mov    0x8(%ebp),%eax
     d64:	01 d0                	add    %edx,%eax
     d66:	0f b6 10             	movzbl (%eax),%edx
     d69:	0f b6 c3             	movzbl %bl,%eax
     d6c:	8d 70 03             	lea    0x3(%eax),%esi
     d6f:	8b 45 08             	mov    0x8(%ebp),%eax
     d72:	01 f0                	add    %esi,%eax
     d74:	31 ca                	xor    %ecx,%edx
     d76:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     d78:	83 c3 04             	add    $0x4,%ebx
     d7b:	80 fb 0f             	cmp    $0xf,%bl
     d7e:	0f 86 4e ff ff ff    	jbe    cd2 <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     d84:	8b 45 08             	mov    0x8(%ebp),%eax
     d87:	83 c0 10             	add    $0x10,%eax
     d8a:	0f b6 08             	movzbl (%eax),%ecx
     d8d:	8b 45 08             	mov    0x8(%ebp),%eax
     d90:	83 c0 0c             	add    $0xc,%eax
     d93:	0f b6 00             	movzbl (%eax),%eax
     d96:	0f b6 c0             	movzbl %al,%eax
     d99:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     da0:	8b 45 08             	mov    0x8(%ebp),%eax
     da3:	83 c0 10             	add    $0x10,%eax
     da6:	31 ca                	xor    %ecx,%edx
     da8:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     daa:	8b 45 08             	mov    0x8(%ebp),%eax
     dad:	83 c0 11             	add    $0x11,%eax
     db0:	0f b6 08             	movzbl (%eax),%ecx
     db3:	8b 45 08             	mov    0x8(%ebp),%eax
     db6:	83 c0 0d             	add    $0xd,%eax
     db9:	0f b6 00             	movzbl (%eax),%eax
     dbc:	0f b6 c0             	movzbl %al,%eax
     dbf:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     dc6:	8b 45 08             	mov    0x8(%ebp),%eax
     dc9:	83 c0 11             	add    $0x11,%eax
     dcc:	31 ca                	xor    %ecx,%edx
     dce:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     dd0:	8b 45 08             	mov    0x8(%ebp),%eax
     dd3:	83 c0 12             	add    $0x12,%eax
     dd6:	0f b6 08             	movzbl (%eax),%ecx
     dd9:	8b 45 08             	mov    0x8(%ebp),%eax
     ddc:	83 c0 0e             	add    $0xe,%eax
     ddf:	0f b6 00             	movzbl (%eax),%eax
     de2:	0f b6 c0             	movzbl %al,%eax
     de5:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     dec:	8b 45 08             	mov    0x8(%ebp),%eax
     def:	83 c0 12             	add    $0x12,%eax
     df2:	31 ca                	xor    %ecx,%edx
     df4:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
     df6:	8b 45 08             	mov    0x8(%ebp),%eax
     df9:	83 c0 13             	add    $0x13,%eax
     dfc:	0f b6 08             	movzbl (%eax),%ecx
     dff:	8b 45 08             	mov    0x8(%ebp),%eax
     e02:	83 c0 0f             	add    $0xf,%eax
     e05:	0f b6 00             	movzbl (%eax),%eax
     e08:	0f b6 c0             	movzbl %al,%eax
     e0b:	0f b6 90 20 20 00 00 	movzbl 0x2020(%eax),%edx
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	83 c0 13             	add    $0x13,%eax
     e18:	31 ca                	xor    %ecx,%edx
     e1a:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
     e1c:	bb 14 00 00 00       	mov    $0x14,%ebx
     e21:	e9 a9 00 00 00       	jmp    ecf <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
     e26:	0f b6 d3             	movzbl %bl,%edx
     e29:	8b 45 08             	mov    0x8(%ebp),%eax
     e2c:	01 d0                	add    %edx,%eax
     e2e:	0f b6 08             	movzbl (%eax),%ecx
     e31:	0f b6 c3             	movzbl %bl,%eax
     e34:	8d 50 fc             	lea    -0x4(%eax),%edx
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	01 d0                	add    %edx,%eax
     e3c:	0f b6 10             	movzbl (%eax),%edx
     e3f:	0f b6 f3             	movzbl %bl,%esi
     e42:	8b 45 08             	mov    0x8(%ebp),%eax
     e45:	01 f0                	add    %esi,%eax
     e47:	31 ca                	xor    %ecx,%edx
     e49:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     e4b:	0f b6 c3             	movzbl %bl,%eax
     e4e:	8d 50 01             	lea    0x1(%eax),%edx
     e51:	8b 45 08             	mov    0x8(%ebp),%eax
     e54:	01 d0                	add    %edx,%eax
     e56:	0f b6 08             	movzbl (%eax),%ecx
     e59:	0f b6 c3             	movzbl %bl,%eax
     e5c:	8d 50 fd             	lea    -0x3(%eax),%edx
     e5f:	8b 45 08             	mov    0x8(%ebp),%eax
     e62:	01 d0                	add    %edx,%eax
     e64:	0f b6 10             	movzbl (%eax),%edx
     e67:	0f b6 c3             	movzbl %bl,%eax
     e6a:	8d 70 01             	lea    0x1(%eax),%esi
     e6d:	8b 45 08             	mov    0x8(%ebp),%eax
     e70:	01 f0                	add    %esi,%eax
     e72:	31 ca                	xor    %ecx,%edx
     e74:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     e76:	0f b6 c3             	movzbl %bl,%eax
     e79:	8d 50 02             	lea    0x2(%eax),%edx
     e7c:	8b 45 08             	mov    0x8(%ebp),%eax
     e7f:	01 d0                	add    %edx,%eax
     e81:	0f b6 08             	movzbl (%eax),%ecx
     e84:	0f b6 c3             	movzbl %bl,%eax
     e87:	8d 50 fe             	lea    -0x2(%eax),%edx
     e8a:	8b 45 08             	mov    0x8(%ebp),%eax
     e8d:	01 d0                	add    %edx,%eax
     e8f:	0f b6 10             	movzbl (%eax),%edx
     e92:	0f b6 c3             	movzbl %bl,%eax
     e95:	8d 70 02             	lea    0x2(%eax),%esi
     e98:	8b 45 08             	mov    0x8(%ebp),%eax
     e9b:	01 f0                	add    %esi,%eax
     e9d:	31 ca                	xor    %ecx,%edx
     e9f:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     ea1:	0f b6 c3             	movzbl %bl,%eax
     ea4:	8d 50 03             	lea    0x3(%eax),%edx
     ea7:	8b 45 08             	mov    0x8(%ebp),%eax
     eaa:	01 d0                	add    %edx,%eax
     eac:	0f b6 08             	movzbl (%eax),%ecx
     eaf:	0f b6 c3             	movzbl %bl,%eax
     eb2:	8d 50 ff             	lea    -0x1(%eax),%edx
     eb5:	8b 45 08             	mov    0x8(%ebp),%eax
     eb8:	01 d0                	add    %edx,%eax
     eba:	0f b6 10             	movzbl (%eax),%edx
     ebd:	0f b6 c3             	movzbl %bl,%eax
     ec0:	8d 70 03             	lea    0x3(%eax),%esi
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	01 f0                	add    %esi,%eax
     ec8:	31 ca                	xor    %ecx,%edx
     eca:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
     ecc:	83 c3 04             	add    $0x4,%ebx
     ecf:	80 fb 1f             	cmp    $0x1f,%bl
     ed2:	0f 86 4e ff ff ff    	jbe    e26 <aes_expandEncKey+0x201>
    }
}
     ed8:	90                   	nop
     ed9:	90                   	nop
     eda:	83 c4 04             	add    $0x4,%esp
     edd:	5b                   	pop    %ebx
     ede:	5e                   	pop    %esi
     edf:	5d                   	pop    %ebp
     ee0:	c3                   	ret    

00000ee1 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
     ee1:	55                   	push   %ebp
     ee2:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
     ee4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     ee8:	74 4d                	je     f37 <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
     eea:	8b 45 08             	mov    0x8(%ebp),%eax
     eed:	83 c0 03             	add    $0x3,%eax
     ef0:	0f b6 10             	movzbl (%eax),%edx
     ef3:	83 c2 01             	add    $0x1,%edx
     ef6:	88 10                	mov    %dl,(%eax)
     ef8:	0f b6 00             	movzbl (%eax),%eax
     efb:	84 c0                	test   %al,%al
     efd:	75 38                	jne    f37 <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
     eff:	8b 45 08             	mov    0x8(%ebp),%eax
     f02:	83 c0 02             	add    $0x2,%eax
     f05:	0f b6 10             	movzbl (%eax),%edx
     f08:	83 c2 01             	add    $0x1,%edx
     f0b:	88 10                	mov    %dl,(%eax)
     f0d:	0f b6 00             	movzbl (%eax),%eax
     f10:	84 c0                	test   %al,%al
     f12:	75 23                	jne    f37 <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
     f14:	8b 45 08             	mov    0x8(%ebp),%eax
     f17:	83 c0 01             	add    $0x1,%eax
     f1a:	0f b6 10             	movzbl (%eax),%edx
     f1d:	83 c2 01             	add    $0x1,%edx
     f20:	88 10                	mov    %dl,(%eax)
     f22:	0f b6 00             	movzbl (%eax),%eax
     f25:	84 c0                	test   %al,%al
     f27:	75 0e                	jne    f37 <ctr_inc_ctr+0x56>
                    val[0]++;
     f29:	8b 45 08             	mov    0x8(%ebp),%eax
     f2c:	0f b6 00             	movzbl (%eax),%eax
     f2f:	8d 50 01             	lea    0x1(%eax),%edx
     f32:	8b 45 08             	mov    0x8(%ebp),%eax
     f35:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
     f37:	90                   	nop
     f38:	5d                   	pop    %ebp
     f39:	c3                   	ret    

00000f3a <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
     f3a:	55                   	push   %ebp
     f3b:	89 e5                	mov    %esp,%ebp
     f3d:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
     f40:	8b 45 08             	mov    0x8(%ebp),%eax
     f43:	83 c0 40             	add    $0x40,%eax
     f46:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
     f49:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f4d:	74 56                	je     fa5 <ctr_clock_keystream+0x6b>
     f4f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f53:	74 50                	je     fa5 <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f55:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
     f59:	eb 21                	jmp    f7c <ctr_clock_keystream+0x42>
            ks[i] = p[i];
     f5b:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     f5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f62:	01 d0                	add    %edx,%eax
     f64:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
     f68:	8b 55 0c             	mov    0xc(%ebp),%edx
     f6b:	01 ca                	add    %ecx,%edx
     f6d:	0f b6 00             	movzbl (%eax),%eax
     f70:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f72:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     f76:	83 c0 01             	add    $0x1,%eax
     f79:	88 45 f7             	mov    %al,-0x9(%ebp)
     f7c:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
     f80:	76 d9                	jbe    f5b <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
     f82:	83 ec 08             	sub    $0x8,%esp
     f85:	ff 75 0c             	push   0xc(%ebp)
     f88:	ff 75 08             	push   0x8(%ebp)
     f8b:	e8 16 01 00 00       	call   10a6 <aes256_encrypt_ecb>
     f90:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
     f93:	8b 45 08             	mov    0x8(%ebp),%eax
     f96:	83 c0 4c             	add    $0x4c,%eax
     f99:	83 ec 0c             	sub    $0xc,%esp
     f9c:	50                   	push   %eax
     f9d:	e8 3f ff ff ff       	call   ee1 <ctr_inc_ctr>
     fa2:	83 c4 10             	add    $0x10,%esp
    }
}
     fa5:	90                   	nop
     fa6:	c9                   	leave  
     fa7:	c3                   	ret    

00000fa8 <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
     fa8:	55                   	push   %ebp
     fa9:	89 e5                	mov    %esp,%ebp
     fab:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
     fae:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
     fb4:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
     fbb:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
     fc2:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
     fc9:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
     fd0:	83 ec 08             	sub    $0x8,%esp
     fd3:	ff 75 08             	push   0x8(%ebp)
     fd6:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fd9:	50                   	push   %eax
     fda:	e8 2e 00 00 00       	call   100d <aes256_init>
     fdf:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
     fe2:	83 ec 08             	sub    $0x8,%esp
     fe5:	8d 45 94             	lea    -0x6c(%ebp),%eax
     fe8:	50                   	push   %eax
     fe9:	8d 45 a4             	lea    -0x5c(%ebp),%eax
     fec:	50                   	push   %eax
     fed:	e8 8d 01 00 00       	call   117f <aes256_setCtrBlk>
     ff2:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
     ff5:	83 ec 04             	sub    $0x4,%esp
     ff8:	ff 75 10             	push   0x10(%ebp)
     ffb:	ff 75 f4             	push   -0xc(%ebp)
     ffe:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1001:	50                   	push   %eax
    1002:	e8 c9 01 00 00       	call   11d0 <aes256_encrypt_ctr>
    1007:	83 c4 10             	add    $0x10,%esp
}
    100a:	90                   	nop
    100b:	c9                   	leave  
    100c:	c3                   	ret    

0000100d <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
    100d:	55                   	push   %ebp
    100e:	89 e5                	mov    %esp,%ebp
    1010:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1011:	bb 00 00 00 00       	mov    $0x0,%ebx
    1016:	eb 1a                	jmp    1032 <aes256_init+0x25>
        ctx->enckey[i] = key[i];
    1018:	0f b6 d3             	movzbl %bl,%edx
    101b:	8b 45 0c             	mov    0xc(%ebp),%eax
    101e:	01 c2                	add    %eax,%edx
    1020:	0f b6 c3             	movzbl %bl,%eax
    1023:	0f b6 0a             	movzbl (%edx),%ecx
    1026:	8b 55 08             	mov    0x8(%ebp),%edx
    1029:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    102d:	89 d8                	mov    %ebx,%eax
    102f:	8d 58 01             	lea    0x1(%eax),%ebx
    1032:	80 fb 1f             	cmp    $0x1f,%bl
    1035:	76 e1                	jbe    1018 <aes256_init+0xb>
    }
}
    1037:	90                   	nop
    1038:	90                   	nop
    1039:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    103c:	c9                   	leave  
    103d:	c3                   	ret    

0000103e <aes256_done>:

void aes256_done(aes256_context* ctx) {
    103e:	55                   	push   %ebp
    103f:	89 e5                	mov    %esp,%ebp
    1041:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1042:	bb 00 00 00 00       	mov    $0x0,%ebx
    1047:	eb 51                	jmp    109a <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    1049:	0f b6 c3             	movzbl %bl,%eax
    104c:	8b 55 08             	mov    0x8(%ebp),%edx
    104f:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    1054:	0f b6 d3             	movzbl %bl,%edx
    1057:	8b 4d 08             	mov    0x8(%ebp),%ecx
    105a:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    105f:	8b 45 08             	mov    0x8(%ebp),%eax
    1062:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    1065:	0f b6 c3             	movzbl %bl,%eax
    1068:	83 e0 03             	and    $0x3,%eax
    106b:	89 c2                	mov    %eax,%edx
    106d:	8b 45 08             	mov    0x8(%ebp),%eax
    1070:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    1075:	0f b6 c3             	movzbl %bl,%eax
    1078:	83 e0 07             	and    $0x7,%eax
    107b:	89 c2                	mov    %eax,%edx
    107d:	8b 45 08             	mov    0x8(%ebp),%eax
    1080:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    1085:	0f b6 c3             	movzbl %bl,%eax
    1088:	83 e0 03             	and    $0x3,%eax
    108b:	89 c2                	mov    %eax,%edx
    108d:	8b 45 08             	mov    0x8(%ebp),%eax
    1090:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1095:	89 d8                	mov    %ebx,%eax
    1097:	8d 58 01             	lea    0x1(%eax),%ebx
    109a:	80 fb 1f             	cmp    $0x1f,%bl
    109d:	76 aa                	jbe    1049 <aes256_done+0xb>
    }
}
    109f:	90                   	nop
    10a0:	90                   	nop
    10a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10a4:	c9                   	leave  
    10a5:	c3                   	ret    

000010a6 <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    10a6:	55                   	push   %ebp
    10a7:	89 e5                	mov    %esp,%ebp
    10a9:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    10ac:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    10b0:	8b 45 08             	mov    0x8(%ebp),%eax
    10b3:	8b 55 08             	mov    0x8(%ebp),%edx
    10b6:	83 c2 20             	add    $0x20,%edx
    10b9:	50                   	push   %eax
    10ba:	52                   	push   %edx
    10bb:	ff 75 0c             	push   0xc(%ebp)
    10be:	e8 bb f8 ff ff       	call   97e <aes_addRoundKey_cpy>
    10c3:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    10c6:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    10ca:	eb 74                	jmp    1140 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    10cc:	ff 75 0c             	push   0xc(%ebp)
    10cf:	e8 31 f8 ff ff       	call   905 <aes_subBytes>
    10d4:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    10d7:	ff 75 0c             	push   0xc(%ebp)
    10da:	e8 11 f9 ff ff       	call   9f0 <aes_shiftRows>
    10df:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    10e2:	ff 75 0c             	push   0xc(%ebp)
    10e5:	e8 d5 f9 ff ff       	call   abf <aes_mixColumns>
    10ea:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    10ed:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    10f1:	83 e0 01             	and    $0x1,%eax
    10f4:	85 c0                	test   %eax,%eax
    10f6:	74 14                	je     110c <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    10f8:	8b 45 08             	mov    0x8(%ebp),%eax
    10fb:	83 c0 10             	add    $0x10,%eax
    10fe:	50                   	push   %eax
    10ff:	ff 75 0c             	push   0xc(%ebp)
    1102:	e8 39 f8 ff ff       	call   940 <aes_addRoundKey>
    1107:	83 c4 08             	add    $0x8,%esp
    110a:	eb 30                	jmp    113c <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    110c:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1110:	8b 45 08             	mov    0x8(%ebp),%eax
    1113:	52                   	push   %edx
    1114:	50                   	push   %eax
    1115:	e8 0b fb ff ff       	call   c25 <aes_expandEncKey>
    111a:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    111d:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    1121:	50                   	push   %eax
    1122:	e8 ae f7 ff ff       	call   8d5 <rj_xtime>
    1127:	83 c4 04             	add    $0x4,%esp
    112a:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    112d:	8b 45 08             	mov    0x8(%ebp),%eax
    1130:	50                   	push   %eax
    1131:	ff 75 0c             	push   0xc(%ebp)
    1134:	e8 07 f8 ff ff       	call   940 <aes_addRoundKey>
    1139:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    113c:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    1140:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    1144:	76 86                	jbe    10cc <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    1146:	ff 75 0c             	push   0xc(%ebp)
    1149:	e8 b7 f7 ff ff       	call   905 <aes_subBytes>
    114e:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    1151:	ff 75 0c             	push   0xc(%ebp)
    1154:	e8 97 f8 ff ff       	call   9f0 <aes_shiftRows>
    1159:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    115c:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	52                   	push   %edx
    1164:	50                   	push   %eax
    1165:	e8 bb fa ff ff       	call   c25 <aes_expandEncKey>
    116a:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    116d:	8b 45 08             	mov    0x8(%ebp),%eax
    1170:	50                   	push   %eax
    1171:	ff 75 0c             	push   0xc(%ebp)
    1174:	e8 c7 f7 ff ff       	call   940 <aes_addRoundKey>
    1179:	83 c4 08             	add    $0x8,%esp
}
    117c:	90                   	nop
    117d:	c9                   	leave  
    117e:	c3                   	ret    

0000117f <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    117f:	55                   	push   %ebp
    1180:	89 e5                	mov    %esp,%ebp
    1182:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1185:	8b 45 08             	mov    0x8(%ebp),%eax
    1188:	83 c0 40             	add    $0x40,%eax
    118b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    118e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1191:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    1194:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1198:	74 33                	je     11cd <aes256_setCtrBlk+0x4e>
    119a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    119e:	74 2d                	je     11cd <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    11a0:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    11a4:	eb 21                	jmp    11c7 <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    11a6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    11aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ad:	01 d0                	add    %edx,%eax
    11af:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    11b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    11b6:	01 ca                	add    %ecx,%edx
    11b8:	0f b6 00             	movzbl (%eax),%eax
    11bb:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    11bd:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    11c1:	83 c0 01             	add    $0x1,%eax
    11c4:	88 45 ff             	mov    %al,-0x1(%ebp)
    11c7:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    11cb:	76 d9                	jbe    11a6 <aes256_setCtrBlk+0x27>
        }
    }
}
    11cd:	90                   	nop
    11ce:	c9                   	leave  
    11cf:	c3                   	ret    

000011d0 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	53                   	push   %ebx
    11d4:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    11d7:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    11db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11e2:	eb 49                	jmp    122d <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    11e4:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    11e8:	75 16                	jne    1200 <aes256_encrypt_ctr+0x30>
            j = 0;
    11ea:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    11ee:	83 ec 08             	sub    $0x8,%esp
    11f1:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    11f4:	50                   	push   %eax
    11f5:	ff 75 08             	push   0x8(%ebp)
    11f8:	e8 3d fd ff ff       	call   f3a <ctr_clock_keystream>
    11fd:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    1200:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    1204:	8d 50 01             	lea    0x1(%eax),%edx
    1207:	88 55 f3             	mov    %dl,-0xd(%ebp)
    120a:	0f b6 c0             	movzbl %al,%eax
    120d:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    1212:	8b 55 0c             	mov    0xc(%ebp),%edx
    1215:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1218:	01 d0                	add    %edx,%eax
    121a:	0f b6 10             	movzbl (%eax),%edx
    121d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1220:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1223:	01 d8                	add    %ebx,%eax
    1225:	31 ca                	xor    %ecx,%edx
    1227:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    1229:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    122d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1230:	3b 45 10             	cmp    0x10(%ebp),%eax
    1233:	72 af                	jb     11e4 <aes256_encrypt_ctr+0x14>
    }
}
    1235:	90                   	nop
    1236:	90                   	nop
    1237:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    123a:	c9                   	leave  
    123b:	c3                   	ret    

0000123c <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    123c:	55                   	push   %ebp
    123d:	89 e5                	mov    %esp,%ebp
    123f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1242:	83 e0 1f             	and    $0x1f,%eax
    1245:	8b 55 08             	mov    0x8(%ebp),%edx
    1248:	89 c1                	mov    %eax,%ecx
    124a:	d3 ea                	shr    %cl,%edx
    124c:	89 d0                	mov    %edx,%eax
    124e:	5d                   	pop    %ebp
    124f:	c3                   	ret    

00001250 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	8b 45 0c             	mov    0xc(%ebp),%eax
    1256:	83 e0 1f             	and    $0x1f,%eax
    1259:	8b 55 08             	mov    0x8(%ebp),%edx
    125c:	89 c1                	mov    %eax,%ecx
    125e:	d3 e2                	shl    %cl,%edx
    1260:	89 d0                	mov    %edx,%eax
    1262:	5d                   	pop    %ebp
    1263:	c3                   	ret    

00001264 <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    1264:	55                   	push   %ebp
    1265:	89 e5                	mov    %esp,%ebp
    1267:	53                   	push   %ebx
    1268:	83 ec 04             	sub    $0x4,%esp
    126b:	8b 45 0c             	mov    0xc(%ebp),%eax
    126e:	88 45 f8             	mov    %al,-0x8(%ebp)
    1271:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    1275:	8b 55 08             	mov    0x8(%ebp),%edx
    1278:	89 d3                	mov    %edx,%ebx
    127a:	89 c1                	mov    %eax,%ecx
    127c:	d3 eb                	shr    %cl,%ebx
    127e:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    1282:	b8 20 00 00 00       	mov    $0x20,%eax
    1287:	29 d0                	sub    %edx,%eax
    1289:	50                   	push   %eax
    128a:	ff 75 08             	push   0x8(%ebp)
    128d:	e8 be ff ff ff       	call   1250 <_shw>
    1292:	83 c4 08             	add    $0x8,%esp
    1295:	09 d8                	or     %ebx,%eax
    1297:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    129a:	c9                   	leave  
    129b:	c3                   	ret    

0000129c <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    129c:	55                   	push   %ebp
    129d:	89 e5                	mov    %esp,%ebp
    129f:	8b 45 08             	mov    0x8(%ebp),%eax
    12a2:	23 45 0c             	and    0xc(%ebp),%eax
    12a5:	89 c2                	mov    %eax,%edx
    12a7:	8b 45 08             	mov    0x8(%ebp),%eax
    12aa:	f7 d0                	not    %eax
    12ac:	23 45 10             	and    0x10(%ebp),%eax
    12af:	31 d0                	xor    %edx,%eax
    12b1:	5d                   	pop    %ebp
    12b2:	c3                   	ret    

000012b3 <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    12b3:	55                   	push   %ebp
    12b4:	89 e5                	mov    %esp,%ebp
    12b6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b9:	33 45 10             	xor    0x10(%ebp),%eax
    12bc:	23 45 08             	and    0x8(%ebp),%eax
    12bf:	89 c2                	mov    %eax,%edx
    12c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c4:	23 45 10             	and    0x10(%ebp),%eax
    12c7:	31 d0                	xor    %edx,%eax
    12c9:	5d                   	pop    %ebp
    12ca:	c3                   	ret    

000012cb <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    12cb:	55                   	push   %ebp
    12cc:	89 e5                	mov    %esp,%ebp
    12ce:	53                   	push   %ebx
    12cf:	6a 02                	push   $0x2
    12d1:	ff 75 08             	push   0x8(%ebp)
    12d4:	e8 8b ff ff ff       	call   1264 <_r>
    12d9:	83 c4 08             	add    $0x8,%esp
    12dc:	89 c3                	mov    %eax,%ebx
    12de:	6a 0d                	push   $0xd
    12e0:	ff 75 08             	push   0x8(%ebp)
    12e3:	e8 7c ff ff ff       	call   1264 <_r>
    12e8:	83 c4 08             	add    $0x8,%esp
    12eb:	31 c3                	xor    %eax,%ebx
    12ed:	6a 16                	push   $0x16
    12ef:	ff 75 08             	push   0x8(%ebp)
    12f2:	e8 6d ff ff ff       	call   1264 <_r>
    12f7:	83 c4 08             	add    $0x8,%esp
    12fa:	31 d8                	xor    %ebx,%eax
    12fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12ff:	c9                   	leave  
    1300:	c3                   	ret    

00001301 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    1301:	55                   	push   %ebp
    1302:	89 e5                	mov    %esp,%ebp
    1304:	53                   	push   %ebx
    1305:	6a 06                	push   $0x6
    1307:	ff 75 08             	push   0x8(%ebp)
    130a:	e8 55 ff ff ff       	call   1264 <_r>
    130f:	83 c4 08             	add    $0x8,%esp
    1312:	89 c3                	mov    %eax,%ebx
    1314:	6a 0b                	push   $0xb
    1316:	ff 75 08             	push   0x8(%ebp)
    1319:	e8 46 ff ff ff       	call   1264 <_r>
    131e:	83 c4 08             	add    $0x8,%esp
    1321:	31 c3                	xor    %eax,%ebx
    1323:	6a 19                	push   $0x19
    1325:	ff 75 08             	push   0x8(%ebp)
    1328:	e8 37 ff ff ff       	call   1264 <_r>
    132d:	83 c4 08             	add    $0x8,%esp
    1330:	31 d8                	xor    %ebx,%eax
    1332:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1335:	c9                   	leave  
    1336:	c3                   	ret    

00001337 <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    1337:	55                   	push   %ebp
    1338:	89 e5                	mov    %esp,%ebp
    133a:	53                   	push   %ebx
    133b:	6a 07                	push   $0x7
    133d:	ff 75 08             	push   0x8(%ebp)
    1340:	e8 1f ff ff ff       	call   1264 <_r>
    1345:	83 c4 08             	add    $0x8,%esp
    1348:	89 c3                	mov    %eax,%ebx
    134a:	6a 12                	push   $0x12
    134c:	ff 75 08             	push   0x8(%ebp)
    134f:	e8 10 ff ff ff       	call   1264 <_r>
    1354:	83 c4 08             	add    $0x8,%esp
    1357:	89 da                	mov    %ebx,%edx
    1359:	31 c2                	xor    %eax,%edx
    135b:	8b 45 08             	mov    0x8(%ebp),%eax
    135e:	c1 e8 03             	shr    $0x3,%eax
    1361:	31 d0                	xor    %edx,%eax
    1363:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1366:	c9                   	leave  
    1367:	c3                   	ret    

00001368 <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    1368:	55                   	push   %ebp
    1369:	89 e5                	mov    %esp,%ebp
    136b:	53                   	push   %ebx
    136c:	6a 11                	push   $0x11
    136e:	ff 75 08             	push   0x8(%ebp)
    1371:	e8 ee fe ff ff       	call   1264 <_r>
    1376:	83 c4 08             	add    $0x8,%esp
    1379:	89 c3                	mov    %eax,%ebx
    137b:	6a 13                	push   $0x13
    137d:	ff 75 08             	push   0x8(%ebp)
    1380:	e8 df fe ff ff       	call   1264 <_r>
    1385:	83 c4 08             	add    $0x8,%esp
    1388:	89 da                	mov    %ebx,%edx
    138a:	31 c2                	xor    %eax,%edx
    138c:	8b 45 08             	mov    0x8(%ebp),%eax
    138f:	c1 e8 0a             	shr    $0xa,%eax
    1392:	31 d0                	xor    %edx,%eax
    1394:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1397:	c9                   	leave  
    1398:	c3                   	ret    

00001399 <_word>:

FN_ uint _word(uchar* c) {
    1399:	55                   	push   %ebp
    139a:	89 e5                	mov    %esp,%ebp
    139c:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    139d:	8b 45 08             	mov    0x8(%ebp),%eax
    13a0:	0f b6 00             	movzbl (%eax),%eax
    13a3:	0f b6 c0             	movzbl %al,%eax
    13a6:	6a 18                	push   $0x18
    13a8:	50                   	push   %eax
    13a9:	e8 a2 fe ff ff       	call   1250 <_shw>
    13ae:	83 c4 08             	add    $0x8,%esp
    13b1:	89 c3                	mov    %eax,%ebx
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
    13b6:	83 c0 01             	add    $0x1,%eax
    13b9:	0f b6 00             	movzbl (%eax),%eax
    13bc:	0f b6 c0             	movzbl %al,%eax
    13bf:	6a 10                	push   $0x10
    13c1:	50                   	push   %eax
    13c2:	e8 89 fe ff ff       	call   1250 <_shw>
    13c7:	83 c4 08             	add    $0x8,%esp
    13ca:	09 c3                	or     %eax,%ebx
    13cc:	8b 45 08             	mov    0x8(%ebp),%eax
    13cf:	83 c0 02             	add    $0x2,%eax
    13d2:	0f b6 00             	movzbl (%eax),%eax
    13d5:	0f b6 c0             	movzbl %al,%eax
    13d8:	6a 08                	push   $0x8
    13da:	50                   	push   %eax
    13db:	e8 70 fe ff ff       	call   1250 <_shw>
    13e0:	83 c4 08             	add    $0x8,%esp
    13e3:	89 da                	mov    %ebx,%edx
    13e5:	09 c2                	or     %eax,%edx
    13e7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ea:	83 c0 03             	add    $0x3,%eax
    13ed:	0f b6 00             	movzbl (%eax),%eax
    13f0:	0f b6 c0             	movzbl %al,%eax
    13f3:	09 d0                	or     %edx,%eax
}
    13f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13f8:	c9                   	leave  
    13f9:	c3                   	ret    

000013fa <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    13fa:	55                   	push   %ebp
    13fb:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    13fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1400:	8b 40 60             	mov    0x60(%eax),%eax
    1403:	8b 55 0c             	mov    0xc(%ebp),%edx
    1406:	f7 d2                	not    %edx
    1408:	39 d0                	cmp    %edx,%eax
    140a:	76 0f                	jbe    141b <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    140c:	8b 45 08             	mov    0x8(%ebp),%eax
    140f:	8b 40 64             	mov    0x64(%eax),%eax
    1412:	8d 50 01             	lea    0x1(%eax),%edx
    1415:	8b 45 08             	mov    0x8(%ebp),%eax
    1418:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    141b:	8b 45 08             	mov    0x8(%ebp),%eax
    141e:	8b 50 60             	mov    0x60(%eax),%edx
    1421:	8b 45 0c             	mov    0xc(%ebp),%eax
    1424:	01 c2                	add    %eax,%edx
    1426:	8b 45 08             	mov    0x8(%ebp),%eax
    1429:	89 50 60             	mov    %edx,0x60(%eax)
}
    142c:	90                   	nop
    142d:	5d                   	pop    %ebp
    142e:	c3                   	ret    

0000142f <_hash>:

static void _hash(sha256_context* ctx) {
    142f:	55                   	push   %ebp
    1430:	89 e5                	mov    %esp,%ebp
    1432:	57                   	push   %edi
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
    1435:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    1438:	8b 45 08             	mov    0x8(%ebp),%eax
    143b:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    143e:	8b 45 08             	mov    0x8(%ebp),%eax
    1441:	8b 40 44             	mov    0x44(%eax),%eax
    1444:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    1447:	8b 45 08             	mov    0x8(%ebp),%eax
    144a:	8b 40 48             	mov    0x48(%eax),%eax
    144d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    1450:	8b 45 08             	mov    0x8(%ebp),%eax
    1453:	8b 40 4c             	mov    0x4c(%eax),%eax
    1456:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    145f:	8b 45 08             	mov    0x8(%ebp),%eax
    1462:	8b 40 54             	mov    0x54(%eax),%eax
    1465:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    1468:	8b 45 08             	mov    0x8(%ebp),%eax
    146b:	8b 40 58             	mov    0x58(%eax),%eax
    146e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    1471:	8b 45 08             	mov    0x8(%ebp),%eax
    1474:	8b 40 5c             	mov    0x5c(%eax),%eax
    1477:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    147a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1481:	e9 27 01 00 00       	jmp    15ad <_hash+0x17e>
        if (i < 16) {
    1486:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    148a:	77 2d                	ja     14b9 <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    148c:	6a 02                	push   $0x2
    148e:	ff 75 f0             	push   -0x10(%ebp)
    1491:	e8 ba fd ff ff       	call   1250 <_shw>
    1496:	83 c4 08             	add    $0x8,%esp
    1499:	89 c2                	mov    %eax,%edx
    149b:	8b 45 08             	mov    0x8(%ebp),%eax
    149e:	01 d0                	add    %edx,%eax
    14a0:	50                   	push   %eax
    14a1:	e8 f3 fe ff ff       	call   1399 <_word>
    14a6:	83 c4 04             	add    $0x4,%esp
    14a9:	89 c1                	mov    %eax,%ecx
    14ab:	8b 55 08             	mov    0x8(%ebp),%edx
    14ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14b1:	83 c0 1c             	add    $0x1c,%eax
    14b4:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    14b7:	eb 64                	jmp    151d <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    14b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14bc:	83 e8 02             	sub    $0x2,%eax
    14bf:	8b 55 08             	mov    0x8(%ebp),%edx
    14c2:	83 c0 1c             	add    $0x1c,%eax
    14c5:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14c8:	50                   	push   %eax
    14c9:	e8 9a fe ff ff       	call   1368 <_G1>
    14ce:	83 c4 04             	add    $0x4,%esp
    14d1:	89 c1                	mov    %eax,%ecx
    14d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14d6:	83 e8 07             	sub    $0x7,%eax
    14d9:	8b 55 08             	mov    0x8(%ebp),%edx
    14dc:	83 c0 1c             	add    $0x1c,%eax
    14df:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14e2:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    14e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14e8:	83 e8 0f             	sub    $0xf,%eax
    14eb:	8b 55 08             	mov    0x8(%ebp),%edx
    14ee:	83 c0 1c             	add    $0x1c,%eax
    14f1:	8b 04 82             	mov    (%edx,%eax,4),%eax
    14f4:	50                   	push   %eax
    14f5:	e8 3d fe ff ff       	call   1337 <_G0>
    14fa:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    14fd:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    1500:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1503:	83 e8 10             	sub    $0x10,%eax
    1506:	8b 55 08             	mov    0x8(%ebp),%edx
    1509:	83 c0 1c             	add    $0x1c,%eax
    150c:	8b 04 82             	mov    (%edx,%eax,4),%eax
    150f:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1511:	8b 55 08             	mov    0x8(%ebp),%edx
    1514:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1517:	83 c0 1c             	add    $0x1c,%eax
    151a:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    151d:	57                   	push   %edi
    151e:	e8 de fd ff ff       	call   1301 <_S1>
    1523:	83 c4 04             	add    $0x4,%esp
    1526:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    1529:	01 c3                	add    %eax,%ebx
    152b:	ff 75 d4             	push   -0x2c(%ebp)
    152e:	ff 75 d8             	push   -0x28(%ebp)
    1531:	57                   	push   %edi
    1532:	e8 65 fd ff ff       	call   129c <_Ch>
    1537:	83 c4 0c             	add    $0xc,%esp
    153a:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    153d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1540:	8b 04 85 20 21 00 00 	mov    0x2120(,%eax,4),%eax
    1547:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    154a:	8b 55 08             	mov    0x8(%ebp),%edx
    154d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1550:	83 c0 1c             	add    $0x1c,%eax
    1553:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1556:	01 c8                	add    %ecx,%eax
    1558:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    155b:	56                   	push   %esi
    155c:	e8 6a fd ff ff       	call   12cb <_S0>
    1561:	83 c4 04             	add    $0x4,%esp
    1564:	89 c3                	mov    %eax,%ebx
    1566:	ff 75 dc             	push   -0x24(%ebp)
    1569:	ff 75 e0             	push   -0x20(%ebp)
    156c:	56                   	push   %esi
    156d:	e8 41 fd ff ff       	call   12b3 <_Ma>
    1572:	83 c4 0c             	add    $0xc,%esp
    1575:	01 d8                	add    %ebx,%eax
    1577:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    157a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    157d:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    1580:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1583:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    1586:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    1589:	8b 45 e8             	mov    -0x18(%ebp),%eax
    158c:	8b 7d d0             	mov    -0x30(%ebp),%edi
    158f:	01 c7                	add    %eax,%edi
        d = c;
    1591:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1594:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    1597:	8b 45 e0             	mov    -0x20(%ebp),%eax
    159a:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    159d:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    15a0:	8b 55 e8             	mov    -0x18(%ebp),%edx
    15a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15a6:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    15a9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15ad:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    15b1:	0f 86 cf fe ff ff    	jbe    1486 <_hash+0x57>
    }

    ctx->hash[0] += a;
    15b7:	8b 45 08             	mov    0x8(%ebp),%eax
    15ba:	8b 40 40             	mov    0x40(%eax),%eax
    15bd:	8d 14 06             	lea    (%esi,%eax,1),%edx
    15c0:	8b 45 08             	mov    0x8(%ebp),%eax
    15c3:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    15c6:	8b 45 08             	mov    0x8(%ebp),%eax
    15c9:	8b 40 44             	mov    0x44(%eax),%eax
    15cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
    15cf:	01 c2                	add    %eax,%edx
    15d1:	8b 45 08             	mov    0x8(%ebp),%eax
    15d4:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    15d7:	8b 45 08             	mov    0x8(%ebp),%eax
    15da:	8b 40 48             	mov    0x48(%eax),%eax
    15dd:	8b 55 dc             	mov    -0x24(%ebp),%edx
    15e0:	01 c2                	add    %eax,%edx
    15e2:	8b 45 08             	mov    0x8(%ebp),%eax
    15e5:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    15e8:	8b 45 08             	mov    0x8(%ebp),%eax
    15eb:	8b 40 4c             	mov    0x4c(%eax),%eax
    15ee:	8b 55 d0             	mov    -0x30(%ebp),%edx
    15f1:	01 c2                	add    %eax,%edx
    15f3:	8b 45 08             	mov    0x8(%ebp),%eax
    15f6:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    15f9:	8b 45 08             	mov    0x8(%ebp),%eax
    15fc:	8b 40 50             	mov    0x50(%eax),%eax
    15ff:	8d 14 07             	lea    (%edi,%eax,1),%edx
    1602:	8b 45 08             	mov    0x8(%ebp),%eax
    1605:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    1608:	8b 45 08             	mov    0x8(%ebp),%eax
    160b:	8b 40 54             	mov    0x54(%eax),%eax
    160e:	8b 55 d8             	mov    -0x28(%ebp),%edx
    1611:	01 c2                	add    %eax,%edx
    1613:	8b 45 08             	mov    0x8(%ebp),%eax
    1616:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    1619:	8b 45 08             	mov    0x8(%ebp),%eax
    161c:	8b 40 58             	mov    0x58(%eax),%eax
    161f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1622:	01 c2                	add    %eax,%edx
    1624:	8b 45 08             	mov    0x8(%ebp),%eax
    1627:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    162a:	8b 45 08             	mov    0x8(%ebp),%eax
    162d:	8b 40 5c             	mov    0x5c(%eax),%eax
    1630:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1633:	01 c2                	add    %eax,%edx
    1635:	8b 45 08             	mov    0x8(%ebp),%eax
    1638:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    163b:	90                   	nop
    163c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    163f:	5b                   	pop    %ebx
    1640:	5e                   	pop    %esi
    1641:	5f                   	pop    %edi
    1642:	5d                   	pop    %ebp
    1643:	c3                   	ret    

00001644 <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    1644:	55                   	push   %ebp
    1645:	89 e5                	mov    %esp,%ebp
    1647:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    164d:	83 ec 0c             	sub    $0xc,%esp
    1650:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1656:	50                   	push   %eax
    1657:	e8 33 00 00 00       	call   168f <sha256_init>
    165c:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    165f:	83 ec 04             	sub    $0x4,%esp
    1662:	ff 75 0c             	push   0xc(%ebp)
    1665:	ff 75 08             	push   0x8(%ebp)
    1668:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    166e:	50                   	push   %eax
    166f:	e8 99 00 00 00       	call   170d <sha256_hash>
    1674:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    1677:	83 ec 08             	sub    $0x8,%esp
    167a:	ff 75 10             	push   0x10(%ebp)
    167d:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1683:	50                   	push   %eax
    1684:	e8 14 01 00 00       	call   179d <sha256_done>
    1689:	83 c4 10             	add    $0x10,%esp
}
    168c:	90                   	nop
    168d:	c9                   	leave  
    168e:	c3                   	ret    

0000168f <sha256_init>:

void sha256_init(sha256_context* ctx) {
    168f:	55                   	push   %ebp
    1690:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    1692:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1696:	74 72                	je     170a <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    1698:	8b 45 08             	mov    0x8(%ebp),%eax
    169b:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    16a2:	8b 45 08             	mov    0x8(%ebp),%eax
    16a5:	8b 50 68             	mov    0x68(%eax),%edx
    16a8:	8b 45 08             	mov    0x8(%ebp),%eax
    16ab:	89 50 64             	mov    %edx,0x64(%eax)
    16ae:	8b 45 08             	mov    0x8(%ebp),%eax
    16b1:	8b 50 64             	mov    0x64(%eax),%edx
    16b4:	8b 45 08             	mov    0x8(%ebp),%eax
    16b7:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    16ba:	8b 45 08             	mov    0x8(%ebp),%eax
    16bd:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    16c4:	8b 45 08             	mov    0x8(%ebp),%eax
    16c7:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    16d8:	8b 45 08             	mov    0x8(%ebp),%eax
    16db:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    16e2:	8b 45 08             	mov    0x8(%ebp),%eax
    16e5:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    16ec:	8b 45 08             	mov    0x8(%ebp),%eax
    16ef:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    1700:	8b 45 08             	mov    0x8(%ebp),%eax
    1703:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    170a:	90                   	nop
    170b:	5d                   	pop    %ebp
    170c:	c3                   	ret    

0000170d <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    170d:	55                   	push   %ebp
    170e:	89 e5                	mov    %esp,%ebp
    1710:	53                   	push   %ebx
    1711:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    1714:	8b 45 0c             	mov    0xc(%ebp),%eax
    1717:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    171a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    171e:	74 77                	je     1797 <sha256_hash+0x8a>
    1720:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1724:	74 71                	je     1797 <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    1726:	8b 45 08             	mov    0x8(%ebp),%eax
    1729:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    172c:	83 f8 3f             	cmp    $0x3f,%eax
    172f:	77 66                	ja     1797 <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    1731:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    1738:	eb 55                	jmp    178f <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    173a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    173d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1740:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    1743:	8b 45 08             	mov    0x8(%ebp),%eax
    1746:	8b 40 68             	mov    0x68(%eax),%eax
    1749:	8d 48 01             	lea    0x1(%eax),%ecx
    174c:	8b 55 08             	mov    0x8(%ebp),%edx
    174f:	89 4a 68             	mov    %ecx,0x68(%edx)
    1752:	0f b6 0b             	movzbl (%ebx),%ecx
    1755:	8b 55 08             	mov    0x8(%ebp),%edx
    1758:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    175b:	8b 45 08             	mov    0x8(%ebp),%eax
    175e:	8b 40 68             	mov    0x68(%eax),%eax
    1761:	83 f8 40             	cmp    $0x40,%eax
    1764:	75 25                	jne    178b <sha256_hash+0x7e>
                _hash(ctx);
    1766:	ff 75 08             	push   0x8(%ebp)
    1769:	e8 c1 fc ff ff       	call   142f <_hash>
    176e:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    1771:	68 00 02 00 00       	push   $0x200
    1776:	ff 75 08             	push   0x8(%ebp)
    1779:	e8 7c fc ff ff       	call   13fa <_addbits>
    177e:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    1781:	8b 45 08             	mov    0x8(%ebp),%eax
    1784:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    178b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    178f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1792:	3b 45 10             	cmp    0x10(%ebp),%eax
    1795:	72 a3                	jb     173a <sha256_hash+0x2d>
            }
        }
    }
}
    1797:	90                   	nop
    1798:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    179b:	c9                   	leave  
    179c:	c3                   	ret    

0000179d <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    179d:	55                   	push   %ebp
    179e:	89 e5                	mov    %esp,%ebp
    17a0:	57                   	push   %edi
    17a1:	56                   	push   %esi
    17a2:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    17a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    17a7:	0f 84 27 02 00 00    	je     19d4 <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    17ad:	8b 45 08             	mov    0x8(%ebp),%eax
    17b0:	8b 40 68             	mov    0x68(%eax),%eax
    17b3:	83 e0 3f             	and    $0x3f,%eax
    17b6:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    17b8:	8b 45 08             	mov    0x8(%ebp),%eax
    17bb:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    17bf:	8d 73 01             	lea    0x1(%ebx),%esi
    17c2:	eb 0a                	jmp    17ce <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    17c4:	8b 45 08             	mov    0x8(%ebp),%eax
    17c7:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    17cb:	83 c6 01             	add    $0x1,%esi
    17ce:	83 fe 3f             	cmp    $0x3f,%esi
    17d1:	76 f1                	jbe    17c4 <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    17d3:	8b 45 08             	mov    0x8(%ebp),%eax
    17d6:	8b 40 68             	mov    0x68(%eax),%eax
    17d9:	83 f8 37             	cmp    $0x37,%eax
    17dc:	76 21                	jbe    17ff <sha256_done+0x62>
            _hash(ctx);
    17de:	ff 75 08             	push   0x8(%ebp)
    17e1:	e8 49 fc ff ff       	call   142f <_hash>
    17e6:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    17e9:	bb 00 00 00 00       	mov    $0x0,%ebx
    17ee:	eb 0a                	jmp    17fa <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    17f0:	8b 45 08             	mov    0x8(%ebp),%eax
    17f3:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    17f7:	83 c3 01             	add    $0x1,%ebx
    17fa:	83 fb 3f             	cmp    $0x3f,%ebx
    17fd:	76 f1                	jbe    17f0 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    17ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1802:	8b 40 68             	mov    0x68(%eax),%eax
    1805:	c1 e0 03             	shl    $0x3,%eax
    1808:	50                   	push   %eax
    1809:	ff 75 08             	push   0x8(%ebp)
    180c:	e8 e9 fb ff ff       	call   13fa <_addbits>
    1811:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    1814:	8b 45 08             	mov    0x8(%ebp),%eax
    1817:	8b 40 60             	mov    0x60(%eax),%eax
    181a:	6a 00                	push   $0x0
    181c:	50                   	push   %eax
    181d:	e8 1a fa ff ff       	call   123c <_shb>
    1822:	83 c4 08             	add    $0x8,%esp
    1825:	8b 55 08             	mov    0x8(%ebp),%edx
    1828:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    182b:	8b 45 08             	mov    0x8(%ebp),%eax
    182e:	8b 40 60             	mov    0x60(%eax),%eax
    1831:	6a 08                	push   $0x8
    1833:	50                   	push   %eax
    1834:	e8 03 fa ff ff       	call   123c <_shb>
    1839:	83 c4 08             	add    $0x8,%esp
    183c:	8b 55 08             	mov    0x8(%ebp),%edx
    183f:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    1842:	8b 45 08             	mov    0x8(%ebp),%eax
    1845:	8b 40 60             	mov    0x60(%eax),%eax
    1848:	6a 10                	push   $0x10
    184a:	50                   	push   %eax
    184b:	e8 ec f9 ff ff       	call   123c <_shb>
    1850:	83 c4 08             	add    $0x8,%esp
    1853:	8b 55 08             	mov    0x8(%ebp),%edx
    1856:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    1859:	8b 45 08             	mov    0x8(%ebp),%eax
    185c:	8b 40 60             	mov    0x60(%eax),%eax
    185f:	6a 18                	push   $0x18
    1861:	50                   	push   %eax
    1862:	e8 d5 f9 ff ff       	call   123c <_shb>
    1867:	83 c4 08             	add    $0x8,%esp
    186a:	8b 55 08             	mov    0x8(%ebp),%edx
    186d:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    1870:	8b 45 08             	mov    0x8(%ebp),%eax
    1873:	8b 40 64             	mov    0x64(%eax),%eax
    1876:	6a 00                	push   $0x0
    1878:	50                   	push   %eax
    1879:	e8 be f9 ff ff       	call   123c <_shb>
    187e:	83 c4 08             	add    $0x8,%esp
    1881:	8b 55 08             	mov    0x8(%ebp),%edx
    1884:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    1887:	8b 45 08             	mov    0x8(%ebp),%eax
    188a:	8b 40 64             	mov    0x64(%eax),%eax
    188d:	6a 08                	push   $0x8
    188f:	50                   	push   %eax
    1890:	e8 a7 f9 ff ff       	call   123c <_shb>
    1895:	83 c4 08             	add    $0x8,%esp
    1898:	8b 55 08             	mov    0x8(%ebp),%edx
    189b:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    189e:	8b 45 08             	mov    0x8(%ebp),%eax
    18a1:	8b 40 64             	mov    0x64(%eax),%eax
    18a4:	6a 10                	push   $0x10
    18a6:	50                   	push   %eax
    18a7:	e8 90 f9 ff ff       	call   123c <_shb>
    18ac:	83 c4 08             	add    $0x8,%esp
    18af:	8b 55 08             	mov    0x8(%ebp),%edx
    18b2:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    18b5:	8b 45 08             	mov    0x8(%ebp),%eax
    18b8:	8b 40 64             	mov    0x64(%eax),%eax
    18bb:	6a 18                	push   $0x18
    18bd:	50                   	push   %eax
    18be:	e8 79 f9 ff ff       	call   123c <_shb>
    18c3:	83 c4 08             	add    $0x8,%esp
    18c6:	8b 55 08             	mov    0x8(%ebp),%edx
    18c9:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    18cc:	ff 75 08             	push   0x8(%ebp)
    18cf:	e8 5b fb ff ff       	call   142f <_hash>
    18d4:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    18d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18db:	0f 84 f3 00 00 00    	je     19d4 <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    18e1:	be 00 00 00 00       	mov    $0x0,%esi
    18e6:	bb 18 00 00 00       	mov    $0x18,%ebx
    18eb:	e9 db 00 00 00       	jmp    19cb <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    18f0:	8b 45 08             	mov    0x8(%ebp),%eax
    18f3:	8b 40 40             	mov    0x40(%eax),%eax
    18f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    18f9:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    18fc:	53                   	push   %ebx
    18fd:	50                   	push   %eax
    18fe:	e8 39 f9 ff ff       	call   123c <_shb>
    1903:	83 c4 08             	add    $0x8,%esp
    1906:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    1908:	8b 45 08             	mov    0x8(%ebp),%eax
    190b:	8b 40 44             	mov    0x44(%eax),%eax
    190e:	8d 4e 04             	lea    0x4(%esi),%ecx
    1911:	8b 55 0c             	mov    0xc(%ebp),%edx
    1914:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1917:	53                   	push   %ebx
    1918:	50                   	push   %eax
    1919:	e8 1e f9 ff ff       	call   123c <_shb>
    191e:	83 c4 08             	add    $0x8,%esp
    1921:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    1923:	8b 45 08             	mov    0x8(%ebp),%eax
    1926:	8b 40 48             	mov    0x48(%eax),%eax
    1929:	8d 4e 08             	lea    0x8(%esi),%ecx
    192c:	8b 55 0c             	mov    0xc(%ebp),%edx
    192f:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1932:	53                   	push   %ebx
    1933:	50                   	push   %eax
    1934:	e8 03 f9 ff ff       	call   123c <_shb>
    1939:	83 c4 08             	add    $0x8,%esp
    193c:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    193e:	8b 45 08             	mov    0x8(%ebp),%eax
    1941:	8b 40 4c             	mov    0x4c(%eax),%eax
    1944:	8d 4e 0c             	lea    0xc(%esi),%ecx
    1947:	8b 55 0c             	mov    0xc(%ebp),%edx
    194a:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    194d:	53                   	push   %ebx
    194e:	50                   	push   %eax
    194f:	e8 e8 f8 ff ff       	call   123c <_shb>
    1954:	83 c4 08             	add    $0x8,%esp
    1957:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	8b 40 50             	mov    0x50(%eax),%eax
    195f:	8d 4e 10             	lea    0x10(%esi),%ecx
    1962:	8b 55 0c             	mov    0xc(%ebp),%edx
    1965:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1968:	53                   	push   %ebx
    1969:	50                   	push   %eax
    196a:	e8 cd f8 ff ff       	call   123c <_shb>
    196f:	83 c4 08             	add    $0x8,%esp
    1972:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    1974:	8b 45 08             	mov    0x8(%ebp),%eax
    1977:	8b 40 54             	mov    0x54(%eax),%eax
    197a:	8d 4e 14             	lea    0x14(%esi),%ecx
    197d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1980:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1983:	53                   	push   %ebx
    1984:	50                   	push   %eax
    1985:	e8 b2 f8 ff ff       	call   123c <_shb>
    198a:	83 c4 08             	add    $0x8,%esp
    198d:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    198f:	8b 45 08             	mov    0x8(%ebp),%eax
    1992:	8b 40 58             	mov    0x58(%eax),%eax
    1995:	8d 4e 18             	lea    0x18(%esi),%ecx
    1998:	8b 55 0c             	mov    0xc(%ebp),%edx
    199b:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    199e:	53                   	push   %ebx
    199f:	50                   	push   %eax
    19a0:	e8 97 f8 ff ff       	call   123c <_shb>
    19a5:	83 c4 08             	add    $0x8,%esp
    19a8:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    19aa:	8b 45 08             	mov    0x8(%ebp),%eax
    19ad:	8b 40 5c             	mov    0x5c(%eax),%eax
    19b0:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    19b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    19b6:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19b9:	53                   	push   %ebx
    19ba:	50                   	push   %eax
    19bb:	e8 7c f8 ff ff       	call   123c <_shb>
    19c0:	83 c4 08             	add    $0x8,%esp
    19c3:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    19c5:	83 c6 01             	add    $0x1,%esi
    19c8:	83 eb 08             	sub    $0x8,%ebx
    19cb:	83 fe 03             	cmp    $0x3,%esi
    19ce:	0f 86 1c ff ff ff    	jbe    18f0 <sha256_done+0x153>
            }
        }
    }
}
    19d4:	90                   	nop
    19d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19d8:	5b                   	pop    %ebx
    19d9:	5e                   	pop    %esi
    19da:	5f                   	pop    %edi
    19db:	5d                   	pop    %ebp
    19dc:	c3                   	ret    

000019dd <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    19dd:	55                   	push   %ebp
    19de:	89 e5                	mov    %esp,%ebp
    19e0:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    19e3:	a1 20 2a 00 00       	mov    0x2a20,%eax
    19e8:	83 ec 08             	sub    $0x8,%esp
    19eb:	68 04 02 00 00       	push   $0x204
    19f0:	50                   	push   %eax
    19f1:	e8 7d e7 ff ff       	call   173 <open>
    19f6:	83 c4 10             	add    $0x10,%esp
    19f9:	a3 60 2c 00 00       	mov    %eax,0x2c60

    int i = 0;
    19fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1a05:	eb 6f                	jmp    1a76 <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    1a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0a:	83 e0 01             	and    $0x1,%eax
    1a0d:	85 c0                	test   %eax,%eax
    1a0f:	75 27                	jne    1a38 <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    1a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a14:	89 c2                	mov    %eax,%edx
    1a16:	c1 ea 1f             	shr    $0x1f,%edx
    1a19:	01 d0                	add    %edx,%eax
    1a1b:	d1 f8                	sar    %eax
    1a1d:	6b c0 64             	imul   $0x64,%eax,%eax
    1a20:	8d 90 80 2c 00 00    	lea    0x2c80(%eax),%edx
    1a26:	83 ec 08             	sub    $0x8,%esp
    1a29:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a2c:	50                   	push   %eax
    1a2d:	52                   	push   %edx
    1a2e:	e8 ee e7 ff ff       	call   221 <strcpy>
    1a33:	83 c4 10             	add    $0x10,%esp
    1a36:	eb 27                	jmp    1a5f <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3b:	89 c2                	mov    %eax,%edx
    1a3d:	c1 ea 1f             	shr    $0x1f,%edx
    1a40:	01 d0                	add    %edx,%eax
    1a42:	d1 f8                	sar    %eax
    1a44:	6b c0 64             	imul   $0x64,%eax,%eax
    1a47:	8d 90 c0 2b 64 00    	lea    0x642bc0(%eax),%edx
    1a4d:	83 ec 04             	sub    $0x4,%esp
    1a50:	6a 64                	push   $0x64
    1a52:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a55:	50                   	push   %eax
    1a56:	52                   	push   %edx
    1a57:	e8 b1 e9 ff ff       	call   40d <memmove>
    1a5c:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1a5f:	83 ec 04             	sub    $0x4,%esp
    1a62:	6a 64                	push   $0x64
    1a64:	6a 00                	push   $0x0
    1a66:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a69:	50                   	push   %eax
    1a6a:	e8 48 e8 ff ff       	call   2b7 <memset>
    1a6f:	83 c4 10             	add    $0x10,%esp
        i++;
    1a72:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1a76:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1a7b:	83 ec 04             	sub    $0x4,%esp
    1a7e:	6a 64                	push   $0x64
    1a80:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1a83:	52                   	push   %edx
    1a84:	50                   	push   %eax
    1a85:	e8 c1 e6 ff ff       	call   14b <read>
    1a8a:	83 c4 10             	add    $0x10,%esp
    1a8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a90:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a94:	0f 8f 6d ff ff ff    	jg     1a07 <read_info+0x2a>
    }

    num_users = i / 2;
    1a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9d:	89 c2                	mov    %eax,%edx
    1a9f:	c1 ea 1f             	shr    $0x1f,%edx
    1aa2:	01 d0                	add    %edx,%eax
    1aa4:	d1 f8                	sar    %eax
    1aa6:	a3 64 2c 00 00       	mov    %eax,0x2c64

    if (n < 0) {
    1aab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1aaf:	79 17                	jns    1ac8 <read_info+0xeb>
        printf(1, "cat: read error\n");
    1ab1:	83 ec 08             	sub    $0x8,%esp
    1ab4:	68 2b 22 00 00       	push   $0x222b
    1ab9:	6a 01                	push   $0x1
    1abb:	e8 83 ec ff ff       	call   743 <printf>
    1ac0:	83 c4 10             	add    $0x10,%esp
        exit();
    1ac3:	e8 6b e6 ff ff       	call   133 <exit>
    }
}
    1ac8:	90                   	nop
    1ac9:	c9                   	leave  
    1aca:	c3                   	ret    

00001acb <writeback>:

void writeback() {
    1acb:	55                   	push   %ebp
    1acc:	89 e5                	mov    %esp,%ebp
    1ace:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1ad1:	a1 20 2a 00 00       	mov    0x2a20,%eax
    1ad6:	83 ec 08             	sub    $0x8,%esp
    1ad9:	68 04 02 00 00       	push   $0x204
    1ade:	50                   	push   %eax
    1adf:	e8 8f e6 ff ff       	call   173 <open>
    1ae4:	83 c4 10             	add    $0x10,%esp
    1ae7:	a3 60 2c 00 00       	mov    %eax,0x2c60
    for (int i = 0; i < num_users; i++) {
    1aec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1af3:	eb 44                	jmp    1b39 <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af8:	6b c0 64             	imul   $0x64,%eax,%eax
    1afb:	8d 90 80 2c 00 00    	lea    0x2c80(%eax),%edx
    1b01:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1b06:	83 ec 04             	sub    $0x4,%esp
    1b09:	6a 64                	push   $0x64
    1b0b:	52                   	push   %edx
    1b0c:	50                   	push   %eax
    1b0d:	e8 41 e6 ff ff       	call   153 <write>
    1b12:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b18:	6b c0 64             	imul   $0x64,%eax,%eax
    1b1b:	8d 90 c0 2b 64 00    	lea    0x642bc0(%eax),%edx
    1b21:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1b26:	83 ec 04             	sub    $0x4,%esp
    1b29:	6a 64                	push   $0x64
    1b2b:	52                   	push   %edx
    1b2c:	50                   	push   %eax
    1b2d:	e8 21 e6 ff ff       	call   153 <write>
    1b32:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1b35:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b39:	a1 64 2c 00 00       	mov    0x2c64,%eax
    1b3e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1b41:	7c b2                	jl     1af5 <writeback+0x2a>
    }
    close(fd);
    1b43:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1b48:	83 ec 0c             	sub    $0xc,%esp
    1b4b:	50                   	push   %eax
    1b4c:	e8 0a e6 ff ff       	call   15b <close>
    1b51:	83 c4 10             	add    $0x10,%esp
}
    1b54:	90                   	nop
    1b55:	c9                   	leave  
    1b56:	c3                   	ret    

00001b57 <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1b57:	55                   	push   %ebp
    1b58:	89 e5                	mov    %esp,%ebp
    1b5a:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1b60:	83 ec 08             	sub    $0x8,%esp
    1b63:	68 3c 22 00 00       	push   $0x223c
    1b68:	68 80 2c 00 00       	push   $0x2c80
    1b6d:	e8 af e6 ff ff       	call   221 <strcpy>
    1b72:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1b75:	c7 45 f4 41 22 00 00 	movl   $0x2241,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1b7c:	83 ec 08             	sub    $0x8,%esp
    1b7f:	ff 75 f4             	push   -0xc(%ebp)
    1b82:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1b88:	50                   	push   %eax
    1b89:	e8 93 e6 ff ff       	call   221 <strcpy>
    1b8e:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1b91:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1b98:	83 ec 0c             	sub    $0xc,%esp
    1b9b:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1ba1:	50                   	push   %eax
    1ba2:	e8 e8 fa ff ff       	call   168f <sha256_init>
    1ba7:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1baa:	83 ec 0c             	sub    $0xc,%esp
    1bad:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1bb3:	50                   	push   %eax
    1bb4:	e8 d7 e6 ff ff       	call   290 <strlen>
    1bb9:	83 c4 10             	add    $0x10,%esp
    1bbc:	83 ec 04             	sub    $0x4,%esp
    1bbf:	50                   	push   %eax
    1bc0:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1bc6:	50                   	push   %eax
    1bc7:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1bcd:	50                   	push   %eax
    1bce:	e8 3a fb ff ff       	call   170d <sha256_hash>
    1bd3:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1bd6:	83 ec 08             	sub    $0x8,%esp
    1bd9:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1bdf:	50                   	push   %eax
    1be0:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1be6:	50                   	push   %eax
    1be7:	e8 b1 fb ff ff       	call   179d <sha256_done>
    1bec:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1bef:	83 ec 04             	sub    $0x4,%esp
    1bf2:	6a 64                	push   $0x64
    1bf4:	6a 00                	push   $0x0
    1bf6:	68 c0 2b 64 00       	push   $0x642bc0
    1bfb:	e8 b7 e6 ff ff       	call   2b7 <memset>
    1c00:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1c03:	83 ec 04             	sub    $0x4,%esp
    1c06:	6a 20                	push   $0x20
    1c08:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1c0e:	50                   	push   %eax
    1c0f:	68 c0 2b 64 00       	push   $0x642bc0
    1c14:	e8 f4 e7 ff ff       	call   40d <memmove>
    1c19:	83 c4 10             	add    $0x10,%esp

    read_info();
    1c1c:	e8 bc fd ff ff       	call   19dd <read_info>
    fd = open(SECRETS, O_RDWR);
    1c21:	a1 20 2a 00 00       	mov    0x2a20,%eax
    1c26:	83 ec 08             	sub    $0x8,%esp
    1c29:	6a 04                	push   $0x4
    1c2b:	50                   	push   %eax
    1c2c:	e8 42 e5 ff ff       	call   173 <open>
    1c31:	83 c4 10             	add    $0x10,%esp
    1c34:	a3 60 2c 00 00       	mov    %eax,0x2c60
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1c39:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1c3e:	83 ec 04             	sub    $0x4,%esp
    1c41:	6a 64                	push   $0x64
    1c43:	68 80 2c 00 00       	push   $0x2c80
    1c48:	50                   	push   %eax
    1c49:	e8 05 e5 ff ff       	call   153 <write>
    1c4e:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1c51:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1c56:	83 ec 04             	sub    $0x4,%esp
    1c59:	6a 64                	push   $0x64
    1c5b:	68 c0 2b 64 00       	push   $0x642bc0
    1c60:	50                   	push   %eax
    1c61:	e8 ed e4 ff ff       	call   153 <write>
    1c66:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1c69:	a1 60 2c 00 00       	mov    0x2c60,%eax
    1c6e:	83 ec 0c             	sub    $0xc,%esp
    1c71:	50                   	push   %eax
    1c72:	e8 e4 e4 ff ff       	call   15b <close>
    1c77:	83 c4 10             	add    $0x10,%esp
}
    1c7a:	90                   	nop
    1c7b:	c9                   	leave  
    1c7c:	c3                   	ret    

00001c7d <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1c7d:	55                   	push   %ebp
    1c7e:	89 e5                	mov    %esp,%ebp
    1c80:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1c83:	e8 55 fd ff ff       	call   19dd <read_info>

    for (int i = 0; i < num_users; i++) {
    1c88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c8f:	eb 29                	jmp    1cba <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1c91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c94:	6b c0 64             	imul   $0x64,%eax,%eax
    1c97:	05 80 2c 00 00       	add    $0x2c80,%eax
    1c9c:	83 ec 08             	sub    $0x8,%esp
    1c9f:	50                   	push   %eax
    1ca0:	ff 75 08             	push   0x8(%ebp)
    1ca3:	e8 a9 e5 ff ff       	call   251 <strcmp>
    1ca8:	83 c4 10             	add    $0x10,%esp
    1cab:	85 c0                	test   %eax,%eax
    1cad:	75 07                	jne    1cb6 <does_user_exist+0x39>
            return 0;
    1caf:	b8 00 00 00 00       	mov    $0x0,%eax
    1cb4:	eb 13                	jmp    1cc9 <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1cb6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cba:	a1 64 2c 00 00       	mov    0x2c64,%eax
    1cbf:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1cc2:	7c cd                	jl     1c91 <does_user_exist+0x14>
        }
    }
    return -1;
    1cc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1cc9:	c9                   	leave  
    1cca:	c3                   	ret    

00001ccb <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1ccb:	55                   	push   %ebp
    1ccc:	89 e5                	mov    %esp,%ebp
    1cce:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1cd4:	e8 04 fd ff ff       	call   19dd <read_info>

    int open = -1;
    1cd9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1ce0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ce7:	eb 46                	jmp    1d2f <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1ce9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cec:	6b c0 64             	imul   $0x64,%eax,%eax
    1cef:	05 80 2c 00 00       	add    $0x2c80,%eax
    1cf4:	83 ec 08             	sub    $0x8,%esp
    1cf7:	50                   	push   %eax
    1cf8:	ff 75 08             	push   0x8(%ebp)
    1cfb:	e8 51 e5 ff ff       	call   251 <strcmp>
    1d00:	83 c4 10             	add    $0x10,%esp
    1d03:	85 c0                	test   %eax,%eax
    1d05:	75 0a                	jne    1d11 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1d07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1d0c:	e9 18 01 00 00       	jmp    1e29 <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1d11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d14:	6b c0 64             	imul   $0x64,%eax,%eax
    1d17:	05 80 2c 00 00       	add    $0x2c80,%eax
    1d1c:	0f b6 00             	movzbl (%eax),%eax
    1d1f:	84 c0                	test   %al,%al
    1d21:	75 08                	jne    1d2b <create_user+0x60>
            open = i;
    1d23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d26:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1d29:	eb 0d                	jmp    1d38 <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1d2b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1d2f:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1d36:	7e b1                	jle    1ce9 <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1d38:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1d3c:	0f 84 e2 00 00 00    	je     1e24 <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1d42:	83 ec 08             	sub    $0x8,%esp
    1d45:	ff 75 0c             	push   0xc(%ebp)
    1d48:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d4e:	50                   	push   %eax
    1d4f:	e8 cd e4 ff ff       	call   221 <strcpy>
    1d54:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1d57:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1d5e:	83 ec 0c             	sub    $0xc,%esp
    1d61:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d67:	50                   	push   %eax
    1d68:	e8 22 f9 ff ff       	call   168f <sha256_init>
    1d6d:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1d70:	83 ec 0c             	sub    $0xc,%esp
    1d73:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d79:	50                   	push   %eax
    1d7a:	e8 11 e5 ff ff       	call   290 <strlen>
    1d7f:	83 c4 10             	add    $0x10,%esp
    1d82:	83 ec 04             	sub    $0x4,%esp
    1d85:	50                   	push   %eax
    1d86:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d8c:	50                   	push   %eax
    1d8d:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1d93:	50                   	push   %eax
    1d94:	e8 74 f9 ff ff       	call   170d <sha256_hash>
    1d99:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1d9c:	83 ec 08             	sub    $0x8,%esp
    1d9f:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1da5:	50                   	push   %eax
    1da6:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1dac:	50                   	push   %eax
    1dad:	e8 eb f9 ff ff       	call   179d <sha256_done>
    1db2:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1db5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db8:	6b c0 64             	imul   $0x64,%eax,%eax
    1dbb:	05 80 2c 00 00       	add    $0x2c80,%eax
    1dc0:	83 ec 08             	sub    $0x8,%esp
    1dc3:	ff 75 08             	push   0x8(%ebp)
    1dc6:	50                   	push   %eax
    1dc7:	e8 55 e4 ff ff       	call   221 <strcpy>
    1dcc:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1dcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd2:	6b c0 64             	imul   $0x64,%eax,%eax
    1dd5:	05 c0 2b 64 00       	add    $0x642bc0,%eax
    1dda:	83 ec 04             	sub    $0x4,%esp
    1ddd:	6a 64                	push   $0x64
    1ddf:	6a 00                	push   $0x0
    1de1:	50                   	push   %eax
    1de2:	e8 d0 e4 ff ff       	call   2b7 <memset>
    1de7:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    1dea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ded:	6b c0 64             	imul   $0x64,%eax,%eax
    1df0:	8d 90 c0 2b 64 00    	lea    0x642bc0(%eax),%edx
    1df6:	83 ec 04             	sub    $0x4,%esp
    1df9:	6a 20                	push   $0x20
    1dfb:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1e01:	50                   	push   %eax
    1e02:	52                   	push   %edx
    1e03:	e8 05 e6 ff ff       	call   40d <memmove>
    1e08:	83 c4 10             	add    $0x10,%esp

        num_users++;
    1e0b:	a1 64 2c 00 00       	mov    0x2c64,%eax
    1e10:	83 c0 01             	add    $0x1,%eax
    1e13:	a3 64 2c 00 00       	mov    %eax,0x2c64
        writeback();
    1e18:	e8 ae fc ff ff       	call   1acb <writeback>
        return 0;
    1e1d:	b8 00 00 00 00       	mov    $0x0,%eax
    1e22:	eb 05                	jmp    1e29 <create_user+0x15e>
    }

    return -1;
    1e24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1e29:	c9                   	leave  
    1e2a:	c3                   	ret    

00001e2b <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    1e2b:	55                   	push   %ebp
    1e2c:	89 e5                	mov    %esp,%ebp
    1e2e:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    1e34:	e8 a4 fb ff ff       	call   19dd <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    1e39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e40:	e9 7b 01 00 00       	jmp    1fc0 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    1e45:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e48:	6b c0 64             	imul   $0x64,%eax,%eax
    1e4b:	05 80 2c 00 00       	add    $0x2c80,%eax
    1e50:	83 ec 08             	sub    $0x8,%esp
    1e53:	50                   	push   %eax
    1e54:	ff 75 08             	push   0x8(%ebp)
    1e57:	e8 f5 e3 ff ff       	call   251 <strcmp>
    1e5c:	83 c4 10             	add    $0x10,%esp
    1e5f:	85 c0                	test   %eax,%eax
    1e61:	0f 85 55 01 00 00    	jne    1fbc <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    1e67:	83 ec 08             	sub    $0x8,%esp
    1e6a:	ff 75 0c             	push   0xc(%ebp)
    1e6d:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e73:	50                   	push   %eax
    1e74:	e8 a8 e3 ff ff       	call   221 <strcpy>
    1e79:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    1e7c:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    1e83:	83 ec 0c             	sub    $0xc,%esp
    1e86:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1e8c:	50                   	push   %eax
    1e8d:	e8 fd f7 ff ff       	call   168f <sha256_init>
    1e92:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    1e95:	83 ec 0c             	sub    $0xc,%esp
    1e98:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1e9e:	50                   	push   %eax
    1e9f:	e8 ec e3 ff ff       	call   290 <strlen>
    1ea4:	83 c4 10             	add    $0x10,%esp
    1ea7:	83 ec 04             	sub    $0x4,%esp
    1eaa:	50                   	push   %eax
    1eab:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1eb1:	50                   	push   %eax
    1eb2:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1eb8:	50                   	push   %eax
    1eb9:	e8 4f f8 ff ff       	call   170d <sha256_hash>
    1ebe:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    1ec1:	83 ec 08             	sub    $0x8,%esp
    1ec4:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    1eca:	50                   	push   %eax
    1ecb:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1ed1:	50                   	push   %eax
    1ed2:	e8 c6 f8 ff ff       	call   179d <sha256_done>
    1ed7:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    1eda:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ee1:	eb 34                	jmp    1f17 <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    1ee3:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    1ee9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eec:	01 d0                	add    %edx,%eax
    1eee:	0f b6 00             	movzbl (%eax),%eax
    1ef1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ef4:	6b ca 64             	imul   $0x64,%edx,%ecx
    1ef7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1efa:	01 ca                	add    %ecx,%edx
    1efc:	81 c2 c0 2b 64 00    	add    $0x642bc0,%edx
    1f02:	0f b6 12             	movzbl (%edx),%edx
    1f05:	38 d0                	cmp    %dl,%al
    1f07:	74 0a                	je     1f13 <login_user+0xe8>
                    return -1;
    1f09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1f0e:	e9 bf 00 00 00       	jmp    1fd2 <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    1f13:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f17:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    1f1b:	7e c6                	jle    1ee3 <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    1f1d:	83 ec 08             	sub    $0x8,%esp
    1f20:	68 47 22 00 00       	push   $0x2247
    1f25:	6a 01                	push   $0x1
    1f27:	e8 17 e8 ff ff       	call   743 <printf>
    1f2c:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    1f2f:	e8 f7 e1 ff ff       	call   12b <fork>
    1f34:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    1f37:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f3b:	79 17                	jns    1f54 <login_user+0x129>
                printf(1, "init: fork failed\n");
    1f3d:	83 ec 08             	sub    $0x8,%esp
    1f40:	68 5a 22 00 00       	push   $0x225a
    1f45:	6a 01                	push   $0x1
    1f47:	e8 f7 e7 ff ff       	call   743 <printf>
    1f4c:	83 c4 10             	add    $0x10,%esp
                exit();
    1f4f:	e8 df e1 ff ff       	call   133 <exit>
            }
            if (pid == 0) {
    1f54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f58:	75 4c                	jne    1fa6 <login_user+0x17b>
                setuid(i);
    1f5a:	83 ec 0c             	sub    $0xc,%esp
    1f5d:	ff 75 f4             	push   -0xc(%ebp)
    1f60:	e8 6e e2 ff ff       	call   1d3 <setuid>
    1f65:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    1f68:	83 ec 08             	sub    $0x8,%esp
    1f6b:	68 24 2a 00 00       	push   $0x2a24
    1f70:	68 28 22 00 00       	push   $0x2228
    1f75:	e8 f1 e1 ff ff       	call   16b <exec>
    1f7a:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    1f7d:	83 ec 08             	sub    $0x8,%esp
    1f80:	68 6d 22 00 00       	push   $0x226d
    1f85:	6a 01                	push   $0x1
    1f87:	e8 b7 e7 ff ff       	call   743 <printf>
    1f8c:	83 c4 10             	add    $0x10,%esp
                exit();
    1f8f:	e8 9f e1 ff ff       	call   133 <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    1f94:	83 ec 08             	sub    $0x8,%esp
    1f97:	68 83 22 00 00       	push   $0x2283
    1f9c:	6a 01                	push   $0x1
    1f9e:	e8 a0 e7 ff ff       	call   743 <printf>
    1fa3:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    1fa6:	e8 90 e1 ff ff       	call   13b <wait>
    1fab:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1fae:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1fb2:	78 08                	js     1fbc <login_user+0x191>
    1fb4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1fb7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1fba:	75 d8                	jne    1f94 <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1fbc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1fc0:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    1fc7:	0f 8e 78 fe ff ff    	jle    1e45 <login_user+0x1a>
        }
    }

    return -1;
    1fcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1fd2:	c9                   	leave  
    1fd3:	c3                   	ret    
