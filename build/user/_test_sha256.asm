
_test_sha256:     file format elf32-i386


Disassembly of section .text:

00000000 <print_hex_char>:
//
#include "types.h"
#include "user.h"
#include "crypto.h"

void print_hex_char(uchar num) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
       6:	8b 45 08             	mov    0x8(%ebp),%eax
       9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    char* digits = "0123456789abcdef";
       c:	c7 45 f4 a0 20 00 00 	movl   $0x20a0,-0xc(%ebp)
    char hex_num[] = {digits[(num >> 4) & 0xf], digits[num & 0xf], '\0'};
      13:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
      17:	c0 e8 04             	shr    $0x4,%al
      1a:	0f b6 c0             	movzbl %al,%eax
      1d:	83 e0 0f             	and    $0xf,%eax
      20:	89 c2                	mov    %eax,%edx
      22:	8b 45 f4             	mov    -0xc(%ebp),%eax
      25:	01 d0                	add    %edx,%eax
      27:	0f b6 00             	movzbl (%eax),%eax
      2a:	88 45 f1             	mov    %al,-0xf(%ebp)
      2d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
      31:	83 e0 0f             	and    $0xf,%eax
      34:	89 c2                	mov    %eax,%edx
      36:	8b 45 f4             	mov    -0xc(%ebp),%eax
      39:	01 d0                	add    %edx,%eax
      3b:	0f b6 00             	movzbl (%eax),%eax
      3e:	88 45 f2             	mov    %al,-0xe(%ebp)
      41:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
    printf(1, "%s", (char*) hex_num);
      45:	83 ec 04             	sub    $0x4,%esp
      48:	8d 45 f1             	lea    -0xf(%ebp),%eax
      4b:	50                   	push   %eax
      4c:	68 b1 20 00 00       	push   $0x20b1
      51:	6a 01                	push   $0x1
      53:	e8 b3 07 00 00       	call   80b <printf>
      58:	83 c4 10             	add    $0x10,%esp
}
      5b:	90                   	nop
      5c:	c9                   	leave  
      5d:	c3                   	ret    

0000005e <main>:

int main(int argc, char* argv[]) {
      5e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      62:	83 e4 f0             	and    $0xfffffff0,%esp
      65:	ff 71 fc             	push   -0x4(%ecx)
      68:	55                   	push   %ebp
      69:	89 e5                	mov    %esp,%ebp
      6b:	51                   	push   %ecx
      6c:	83 ec 64             	sub    $0x64,%esp
    printf(1, "test_sha256: begin\n");
      6f:	83 ec 08             	sub    $0x8,%esp
      72:	68 b4 20 00 00       	push   $0x20b4
      77:	6a 01                	push   $0x1
      79:	e8 8d 07 00 00       	call   80b <printf>
      7e:	83 c4 10             	add    $0x10,%esp
    char* buf[] = {
      81:	c7 45 bc c8 20 00 00 	movl   $0x20c8,-0x44(%ebp)
      88:	c7 45 c0 cc 20 00 00 	movl   $0x20cc,-0x40(%ebp)
      8f:	c7 45 c4 14 21 00 00 	movl   $0x2114,-0x3c(%ebp)
      96:	c7 45 c8 18 21 00 00 	movl   $0x2118,-0x38(%ebp)
      9d:	c7 45 cc 60 21 00 00 	movl   $0x2160,-0x34(%ebp)
      a4:	c7 45 d0 9c 21 00 00 	movl   $0x219c,-0x30(%ebp)
      ab:	c7 45 d4 e4 21 00 00 	movl   $0x21e4,-0x2c(%ebp)
      b2:	c7 45 d8 10 22 00 00 	movl   $0x2210,-0x28(%ebp)
      b9:	c7 45 dc 58 22 00 00 	movl   $0x2258,-0x24(%ebp)
      c0:	c7 45 e0 84 22 00 00 	movl   $0x2284,-0x20(%ebp)
      c7:	c7 45 e4 cc 22 00 00 	movl   $0x22cc,-0x1c(%ebp)
      ce:	c7 45 e8 28 23 00 00 	movl   $0x2328,-0x18(%ebp)
        "bhn5bjmoniertqea40wro2upyflkydsibsk8ylkmgbvwi420t44cq034eou1szc1k0mk46"
        "oeb7ktzmlxqkbte2sy",
        "9085df2f 02e0cc45 5928d0f5 1b27b4bf 1d9cd260 a66ed1fd a11b0a3f "
        "f5756d99"};

    const uint tests_total = sizeof(buf) / sizeof(buf[0]);
      d5:	c7 45 ec 0c 00 00 00 	movl   $0xc,-0x14(%ebp)
    uchar hash[SHA256_SIZE_BYTES];

    if (0 != (tests_total % 2)) {
      dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
      df:	83 e0 01             	and    $0x1,%eax
      e2:	85 c0                	test   %eax,%eax
      e4:	74 1c                	je     102 <main+0xa4>
        printf(2, "test_sha256: invalid tests\n");
      e6:	83 ec 08             	sub    $0x8,%esp
      e9:	68 70 23 00 00       	push   $0x2370
      ee:	6a 02                	push   $0x2
      f0:	e8 16 07 00 00       	call   80b <printf>
      f5:	83 c4 10             	add    $0x10,%esp
        return 1;
      f8:	b8 01 00 00 00       	mov    $0x1,%eax
      fd:	e9 e9 00 00 00       	jmp    1eb <main+0x18d>
    }

    for (uint i = 0; i < tests_total; i += 2) {
     102:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     109:	e9 ba 00 00 00       	jmp    1c8 <main+0x16a>
        // hash a string from buf using sha256 and store in hash
        sha256(buf[i], strlen(buf[i]), hash);
     10e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     111:	8b 44 85 bc          	mov    -0x44(%ebp,%eax,4),%eax
     115:	83 ec 0c             	sub    $0xc,%esp
     118:	50                   	push   %eax
     119:	e8 3a 02 00 00       	call   358 <strlen>
     11e:	83 c4 10             	add    $0x10,%esp
     121:	8b 55 f4             	mov    -0xc(%ebp),%edx
     124:	8b 54 95 bc          	mov    -0x44(%ebp,%edx,4),%edx
     128:	83 ec 04             	sub    $0x4,%esp
     12b:	8d 4d 9c             	lea    -0x64(%ebp),%ecx
     12e:	51                   	push   %ecx
     12f:	50                   	push   %eax
     130:	52                   	push   %edx
     131:	e8 d6 15 00 00       	call   170c <sha256>
     136:	83 c4 10             	add    $0x10,%esp
        printf(1, "input = '%s'\ndigest: %s\nresult: ", buf[i], buf[i + 1]);
     139:	8b 45 f4             	mov    -0xc(%ebp),%eax
     13c:	83 c0 01             	add    $0x1,%eax
     13f:	8b 54 85 bc          	mov    -0x44(%ebp,%eax,4),%edx
     143:	8b 45 f4             	mov    -0xc(%ebp),%eax
     146:	8b 44 85 bc          	mov    -0x44(%ebp,%eax,4),%eax
     14a:	52                   	push   %edx
     14b:	50                   	push   %eax
     14c:	68 8c 23 00 00       	push   $0x238c
     151:	6a 01                	push   $0x1
     153:	e8 b3 06 00 00       	call   80b <printf>
     158:	83 c4 10             	add    $0x10,%esp
        for (uint j = 0; j < SHA256_SIZE_BYTES; j++) {
     15b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     162:	eb 48                	jmp    1ac <main+0x14e>
            print_hex_char(hash[j]);
     164:	8d 55 9c             	lea    -0x64(%ebp),%edx
     167:	8b 45 f0             	mov    -0x10(%ebp),%eax
     16a:	01 d0                	add    %edx,%eax
     16c:	0f b6 00             	movzbl (%eax),%eax
     16f:	0f b6 c0             	movzbl %al,%eax
     172:	83 ec 0c             	sub    $0xc,%esp
     175:	50                   	push   %eax
     176:	e8 85 fe ff ff       	call   0 <print_hex_char>
     17b:	83 c4 10             	add    $0x10,%esp
            printf(1, "%s", ((j % 4) == 3) ? " " : "");
     17e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     181:	83 e0 03             	and    $0x3,%eax
     184:	83 f8 03             	cmp    $0x3,%eax
     187:	75 07                	jne    190 <main+0x132>
     189:	b8 ad 23 00 00       	mov    $0x23ad,%eax
     18e:	eb 05                	jmp    195 <main+0x137>
     190:	b8 c8 20 00 00       	mov    $0x20c8,%eax
     195:	83 ec 04             	sub    $0x4,%esp
     198:	50                   	push   %eax
     199:	68 b1 20 00 00       	push   $0x20b1
     19e:	6a 01                	push   $0x1
     1a0:	e8 66 06 00 00       	call   80b <printf>
     1a5:	83 c4 10             	add    $0x10,%esp
        for (uint j = 0; j < SHA256_SIZE_BYTES; j++) {
     1a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     1ac:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
     1b0:	76 b2                	jbe    164 <main+0x106>
        }
        printf(1, "\n\n");
     1b2:	83 ec 08             	sub    $0x8,%esp
     1b5:	68 af 23 00 00       	push   $0x23af
     1ba:	6a 01                	push   $0x1
     1bc:	e8 4a 06 00 00       	call   80b <printf>
     1c1:	83 c4 10             	add    $0x10,%esp
    for (uint i = 0; i < tests_total; i += 2) {
     1c4:	83 45 f4 02          	addl   $0x2,-0xc(%ebp)
     1c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1cb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     1ce:	0f 82 3a ff ff ff    	jb     10e <main+0xb0>
    }

    printf(1, "test_sha256: end, check the equivalence of hashes\n");
     1d4:	83 ec 08             	sub    $0x8,%esp
     1d7:	68 b4 23 00 00       	push   $0x23b4
     1dc:	6a 01                	push   $0x1
     1de:	e8 28 06 00 00       	call   80b <printf>
     1e3:	83 c4 10             	add    $0x10,%esp
    exit();
     1e6:	e8 10 00 00 00       	call   1fb <exit>
    return 0;
}
     1eb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
     1ee:	c9                   	leave  
     1ef:	8d 61 fc             	lea    -0x4(%ecx),%esp
     1f2:	c3                   	ret    

000001f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     1f3:	b8 01 00 00 00       	mov    $0x1,%eax
     1f8:	cd 40                	int    $0x40
     1fa:	c3                   	ret    

000001fb <exit>:
SYSCALL(exit)
     1fb:	b8 02 00 00 00       	mov    $0x2,%eax
     200:	cd 40                	int    $0x40
     202:	c3                   	ret    

00000203 <wait>:
SYSCALL(wait)
     203:	b8 03 00 00 00       	mov    $0x3,%eax
     208:	cd 40                	int    $0x40
     20a:	c3                   	ret    

0000020b <pipe>:
SYSCALL(pipe)
     20b:	b8 04 00 00 00       	mov    $0x4,%eax
     210:	cd 40                	int    $0x40
     212:	c3                   	ret    

00000213 <read>:
SYSCALL(read)
     213:	b8 05 00 00 00       	mov    $0x5,%eax
     218:	cd 40                	int    $0x40
     21a:	c3                   	ret    

0000021b <write>:
SYSCALL(write)
     21b:	b8 10 00 00 00       	mov    $0x10,%eax
     220:	cd 40                	int    $0x40
     222:	c3                   	ret    

00000223 <close>:
SYSCALL(close)
     223:	b8 15 00 00 00       	mov    $0x15,%eax
     228:	cd 40                	int    $0x40
     22a:	c3                   	ret    

0000022b <kill>:
SYSCALL(kill)
     22b:	b8 06 00 00 00       	mov    $0x6,%eax
     230:	cd 40                	int    $0x40
     232:	c3                   	ret    

00000233 <exec>:
SYSCALL(exec)
     233:	b8 07 00 00 00       	mov    $0x7,%eax
     238:	cd 40                	int    $0x40
     23a:	c3                   	ret    

0000023b <open>:
SYSCALL(open)
     23b:	b8 0f 00 00 00       	mov    $0xf,%eax
     240:	cd 40                	int    $0x40
     242:	c3                   	ret    

00000243 <mknod>:
SYSCALL(mknod)
     243:	b8 11 00 00 00       	mov    $0x11,%eax
     248:	cd 40                	int    $0x40
     24a:	c3                   	ret    

0000024b <unlink>:
SYSCALL(unlink)
     24b:	b8 12 00 00 00       	mov    $0x12,%eax
     250:	cd 40                	int    $0x40
     252:	c3                   	ret    

00000253 <fstat>:
SYSCALL(fstat)
     253:	b8 08 00 00 00       	mov    $0x8,%eax
     258:	cd 40                	int    $0x40
     25a:	c3                   	ret    

0000025b <link>:
SYSCALL(link)
     25b:	b8 13 00 00 00       	mov    $0x13,%eax
     260:	cd 40                	int    $0x40
     262:	c3                   	ret    

00000263 <mkdir>:
SYSCALL(mkdir)
     263:	b8 14 00 00 00       	mov    $0x14,%eax
     268:	cd 40                	int    $0x40
     26a:	c3                   	ret    

0000026b <chdir>:
SYSCALL(chdir)
     26b:	b8 09 00 00 00       	mov    $0x9,%eax
     270:	cd 40                	int    $0x40
     272:	c3                   	ret    

00000273 <dup>:
SYSCALL(dup)
     273:	b8 0a 00 00 00       	mov    $0xa,%eax
     278:	cd 40                	int    $0x40
     27a:	c3                   	ret    

0000027b <getpid>:
SYSCALL(getpid)
     27b:	b8 0b 00 00 00       	mov    $0xb,%eax
     280:	cd 40                	int    $0x40
     282:	c3                   	ret    

00000283 <sbrk>:
SYSCALL(sbrk)
     283:	b8 0c 00 00 00       	mov    $0xc,%eax
     288:	cd 40                	int    $0x40
     28a:	c3                   	ret    

0000028b <sleep>:
SYSCALL(sleep)
     28b:	b8 0d 00 00 00       	mov    $0xd,%eax
     290:	cd 40                	int    $0x40
     292:	c3                   	ret    

00000293 <uptime>:
SYSCALL(uptime)
     293:	b8 0e 00 00 00       	mov    $0xe,%eax
     298:	cd 40                	int    $0x40
     29a:	c3                   	ret    

0000029b <setuid>:
SYSCALL(setuid)
     29b:	b8 16 00 00 00       	mov    $0x16,%eax
     2a0:	cd 40                	int    $0x40
     2a2:	c3                   	ret    

000002a3 <getuid>:
SYSCALL(getuid)
     2a3:	b8 19 00 00 00       	mov    $0x19,%eax
     2a8:	cd 40                	int    $0x40
     2aa:	c3                   	ret    

000002ab <chown>:
SYSCALL(chown)
     2ab:	b8 18 00 00 00       	mov    $0x18,%eax
     2b0:	cd 40                	int    $0x40
     2b2:	c3                   	ret    

000002b3 <chmod>:
SYSCALL(chmod)
     2b3:	b8 17 00 00 00       	mov    $0x17,%eax
     2b8:	cd 40                	int    $0x40
     2ba:	c3                   	ret    

000002bb <report_stats>:
SYSCALL(report_stats)
     2bb:	b8 1a 00 00 00       	mov    $0x1a,%eax
     2c0:	cd 40                	int    $0x40
     2c2:	c3                   	ret    

000002c3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     2c3:	55                   	push   %ebp
     2c4:	89 e5                	mov    %esp,%ebp
     2c6:	57                   	push   %edi
     2c7:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     2c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
     2cb:	8b 55 10             	mov    0x10(%ebp),%edx
     2ce:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d1:	89 cb                	mov    %ecx,%ebx
     2d3:	89 df                	mov    %ebx,%edi
     2d5:	89 d1                	mov    %edx,%ecx
     2d7:	fc                   	cld    
     2d8:	f3 aa                	rep stos %al,%es:(%edi)
     2da:	89 ca                	mov    %ecx,%edx
     2dc:	89 fb                	mov    %edi,%ebx
     2de:	89 5d 08             	mov    %ebx,0x8(%ebp)
     2e1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     2e4:	90                   	nop
     2e5:	5b                   	pop    %ebx
     2e6:	5f                   	pop    %edi
     2e7:	5d                   	pop    %ebp
     2e8:	c3                   	ret    

000002e9 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     2e9:	55                   	push   %ebp
     2ea:	89 e5                	mov    %esp,%ebp
     2ec:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     2ef:	8b 45 08             	mov    0x8(%ebp),%eax
     2f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     2f5:	90                   	nop
     2f6:	8b 55 0c             	mov    0xc(%ebp),%edx
     2f9:	8d 42 01             	lea    0x1(%edx),%eax
     2fc:	89 45 0c             	mov    %eax,0xc(%ebp)
     2ff:	8b 45 08             	mov    0x8(%ebp),%eax
     302:	8d 48 01             	lea    0x1(%eax),%ecx
     305:	89 4d 08             	mov    %ecx,0x8(%ebp)
     308:	0f b6 12             	movzbl (%edx),%edx
     30b:	88 10                	mov    %dl,(%eax)
     30d:	0f b6 00             	movzbl (%eax),%eax
     310:	84 c0                	test   %al,%al
     312:	75 e2                	jne    2f6 <strcpy+0xd>
        ;
    return os;
     314:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     317:	c9                   	leave  
     318:	c3                   	ret    

00000319 <strcmp>:

int strcmp(const char* p, const char* q) {
     319:	55                   	push   %ebp
     31a:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     31c:	eb 08                	jmp    326 <strcmp+0xd>
     31e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     322:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     326:	8b 45 08             	mov    0x8(%ebp),%eax
     329:	0f b6 00             	movzbl (%eax),%eax
     32c:	84 c0                	test   %al,%al
     32e:	74 10                	je     340 <strcmp+0x27>
     330:	8b 45 08             	mov    0x8(%ebp),%eax
     333:	0f b6 10             	movzbl (%eax),%edx
     336:	8b 45 0c             	mov    0xc(%ebp),%eax
     339:	0f b6 00             	movzbl (%eax),%eax
     33c:	38 c2                	cmp    %al,%dl
     33e:	74 de                	je     31e <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     340:	8b 45 08             	mov    0x8(%ebp),%eax
     343:	0f b6 00             	movzbl (%eax),%eax
     346:	0f b6 d0             	movzbl %al,%edx
     349:	8b 45 0c             	mov    0xc(%ebp),%eax
     34c:	0f b6 00             	movzbl (%eax),%eax
     34f:	0f b6 c8             	movzbl %al,%ecx
     352:	89 d0                	mov    %edx,%eax
     354:	29 c8                	sub    %ecx,%eax
}
     356:	5d                   	pop    %ebp
     357:	c3                   	ret    

00000358 <strlen>:

uint strlen(const char* s) {
     358:	55                   	push   %ebp
     359:	89 e5                	mov    %esp,%ebp
     35b:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     35e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     365:	eb 04                	jmp    36b <strlen+0x13>
     367:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     36b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     36e:	8b 45 08             	mov    0x8(%ebp),%eax
     371:	01 d0                	add    %edx,%eax
     373:	0f b6 00             	movzbl (%eax),%eax
     376:	84 c0                	test   %al,%al
     378:	75 ed                	jne    367 <strlen+0xf>
        ;
    return n;
     37a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     37d:	c9                   	leave  
     37e:	c3                   	ret    

0000037f <memset>:

void* memset(void* dst, int c, uint n) {
     37f:	55                   	push   %ebp
     380:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     382:	8b 45 10             	mov    0x10(%ebp),%eax
     385:	50                   	push   %eax
     386:	ff 75 0c             	push   0xc(%ebp)
     389:	ff 75 08             	push   0x8(%ebp)
     38c:	e8 32 ff ff ff       	call   2c3 <stosb>
     391:	83 c4 0c             	add    $0xc,%esp
    return dst;
     394:	8b 45 08             	mov    0x8(%ebp),%eax
}
     397:	c9                   	leave  
     398:	c3                   	ret    

00000399 <strchr>:

char* strchr(const char* s, char c) {
     399:	55                   	push   %ebp
     39a:	89 e5                	mov    %esp,%ebp
     39c:	83 ec 04             	sub    $0x4,%esp
     39f:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a2:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     3a5:	eb 14                	jmp    3bb <strchr+0x22>
        if (*s == c) return (char*) s;
     3a7:	8b 45 08             	mov    0x8(%ebp),%eax
     3aa:	0f b6 00             	movzbl (%eax),%eax
     3ad:	38 45 fc             	cmp    %al,-0x4(%ebp)
     3b0:	75 05                	jne    3b7 <strchr+0x1e>
     3b2:	8b 45 08             	mov    0x8(%ebp),%eax
     3b5:	eb 13                	jmp    3ca <strchr+0x31>
    for (; *s; s++)
     3b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3bb:	8b 45 08             	mov    0x8(%ebp),%eax
     3be:	0f b6 00             	movzbl (%eax),%eax
     3c1:	84 c0                	test   %al,%al
     3c3:	75 e2                	jne    3a7 <strchr+0xe>
    return 0;
     3c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
     3ca:	c9                   	leave  
     3cb:	c3                   	ret    

000003cc <gets>:

char* gets(char* buf, int max) {
     3cc:	55                   	push   %ebp
     3cd:	89 e5                	mov    %esp,%ebp
     3cf:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     3d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     3d9:	eb 42                	jmp    41d <gets+0x51>
        cc = read(0, &c, 1);
     3db:	83 ec 04             	sub    $0x4,%esp
     3de:	6a 01                	push   $0x1
     3e0:	8d 45 ef             	lea    -0x11(%ebp),%eax
     3e3:	50                   	push   %eax
     3e4:	6a 00                	push   $0x0
     3e6:	e8 28 fe ff ff       	call   213 <read>
     3eb:	83 c4 10             	add    $0x10,%esp
     3ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     3f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3f5:	7e 33                	jle    42a <gets+0x5e>
        buf[i++] = c;
     3f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3fa:	8d 50 01             	lea    0x1(%eax),%edx
     3fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
     400:	89 c2                	mov    %eax,%edx
     402:	8b 45 08             	mov    0x8(%ebp),%eax
     405:	01 c2                	add    %eax,%edx
     407:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     40b:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     40d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     411:	3c 0a                	cmp    $0xa,%al
     413:	74 16                	je     42b <gets+0x5f>
     415:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     419:	3c 0d                	cmp    $0xd,%al
     41b:	74 0e                	je     42b <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     41d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     420:	83 c0 01             	add    $0x1,%eax
     423:	39 45 0c             	cmp    %eax,0xc(%ebp)
     426:	7f b3                	jg     3db <gets+0xf>
     428:	eb 01                	jmp    42b <gets+0x5f>
        if (cc < 1) break;
     42a:	90                   	nop
    }
    buf[i] = '\0';
     42b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     42e:	8b 45 08             	mov    0x8(%ebp),%eax
     431:	01 d0                	add    %edx,%eax
     433:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     436:	8b 45 08             	mov    0x8(%ebp),%eax
}
     439:	c9                   	leave  
     43a:	c3                   	ret    

0000043b <stat>:

int stat(const char* n, struct stat* st) {
     43b:	55                   	push   %ebp
     43c:	89 e5                	mov    %esp,%ebp
     43e:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     441:	83 ec 08             	sub    $0x8,%esp
     444:	6a 01                	push   $0x1
     446:	ff 75 08             	push   0x8(%ebp)
     449:	e8 ed fd ff ff       	call   23b <open>
     44e:	83 c4 10             	add    $0x10,%esp
     451:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     454:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     458:	79 07                	jns    461 <stat+0x26>
     45a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     45f:	eb 25                	jmp    486 <stat+0x4b>
    r = fstat(fd, st);
     461:	83 ec 08             	sub    $0x8,%esp
     464:	ff 75 0c             	push   0xc(%ebp)
     467:	ff 75 f4             	push   -0xc(%ebp)
     46a:	e8 e4 fd ff ff       	call   253 <fstat>
     46f:	83 c4 10             	add    $0x10,%esp
     472:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     475:	83 ec 0c             	sub    $0xc,%esp
     478:	ff 75 f4             	push   -0xc(%ebp)
     47b:	e8 a3 fd ff ff       	call   223 <close>
     480:	83 c4 10             	add    $0x10,%esp
    return r;
     483:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     486:	c9                   	leave  
     487:	c3                   	ret    

00000488 <atoi>:

int atoi(const char* s) {
     488:	55                   	push   %ebp
     489:	89 e5                	mov    %esp,%ebp
     48b:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     48e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     495:	eb 25                	jmp    4bc <atoi+0x34>
     497:	8b 55 fc             	mov    -0x4(%ebp),%edx
     49a:	89 d0                	mov    %edx,%eax
     49c:	c1 e0 02             	shl    $0x2,%eax
     49f:	01 d0                	add    %edx,%eax
     4a1:	01 c0                	add    %eax,%eax
     4a3:	89 c1                	mov    %eax,%ecx
     4a5:	8b 45 08             	mov    0x8(%ebp),%eax
     4a8:	8d 50 01             	lea    0x1(%eax),%edx
     4ab:	89 55 08             	mov    %edx,0x8(%ebp)
     4ae:	0f b6 00             	movzbl (%eax),%eax
     4b1:	0f be c0             	movsbl %al,%eax
     4b4:	01 c8                	add    %ecx,%eax
     4b6:	83 e8 30             	sub    $0x30,%eax
     4b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
     4bc:	8b 45 08             	mov    0x8(%ebp),%eax
     4bf:	0f b6 00             	movzbl (%eax),%eax
     4c2:	3c 2f                	cmp    $0x2f,%al
     4c4:	7e 0a                	jle    4d0 <atoi+0x48>
     4c6:	8b 45 08             	mov    0x8(%ebp),%eax
     4c9:	0f b6 00             	movzbl (%eax),%eax
     4cc:	3c 39                	cmp    $0x39,%al
     4ce:	7e c7                	jle    497 <atoi+0xf>
    return n;
     4d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     4d3:	c9                   	leave  
     4d4:	c3                   	ret    

000004d5 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     4d5:	55                   	push   %ebp
     4d6:	89 e5                	mov    %esp,%ebp
     4d8:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     4db:	8b 45 08             	mov    0x8(%ebp),%eax
     4de:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     4e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     4e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     4e7:	eb 17                	jmp    500 <memmove+0x2b>
     4e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     4ec:	8d 42 01             	lea    0x1(%edx),%eax
     4ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
     4f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f5:	8d 48 01             	lea    0x1(%eax),%ecx
     4f8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     4fb:	0f b6 12             	movzbl (%edx),%edx
     4fe:	88 10                	mov    %dl,(%eax)
     500:	8b 45 10             	mov    0x10(%ebp),%eax
     503:	8d 50 ff             	lea    -0x1(%eax),%edx
     506:	89 55 10             	mov    %edx,0x10(%ebp)
     509:	85 c0                	test   %eax,%eax
     50b:	7f dc                	jg     4e9 <memmove+0x14>
    return vdst;
     50d:	8b 45 08             	mov    0x8(%ebp),%eax
}
     510:	c9                   	leave  
     511:	c3                   	ret    

00000512 <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     512:	55                   	push   %ebp
     513:	89 e5                	mov    %esp,%ebp
     515:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     518:	8b 45 08             	mov    0x8(%ebp),%eax
     51b:	83 e8 08             	sub    $0x8,%eax
     51e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     521:	a1 28 2e 00 00       	mov    0x2e28,%eax
     526:	89 45 fc             	mov    %eax,-0x4(%ebp)
     529:	eb 24                	jmp    54f <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     52b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     52e:	8b 00                	mov    (%eax),%eax
     530:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     533:	72 12                	jb     547 <free+0x35>
     535:	8b 45 f8             	mov    -0x8(%ebp),%eax
     538:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     53b:	77 24                	ja     561 <free+0x4f>
     53d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     540:	8b 00                	mov    (%eax),%eax
     542:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     545:	72 1a                	jb     561 <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     547:	8b 45 fc             	mov    -0x4(%ebp),%eax
     54a:	8b 00                	mov    (%eax),%eax
     54c:	89 45 fc             	mov    %eax,-0x4(%ebp)
     54f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     552:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     555:	76 d4                	jbe    52b <free+0x19>
     557:	8b 45 fc             	mov    -0x4(%ebp),%eax
     55a:	8b 00                	mov    (%eax),%eax
     55c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     55f:	73 ca                	jae    52b <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     561:	8b 45 f8             	mov    -0x8(%ebp),%eax
     564:	8b 40 04             	mov    0x4(%eax),%eax
     567:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     56e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     571:	01 c2                	add    %eax,%edx
     573:	8b 45 fc             	mov    -0x4(%ebp),%eax
     576:	8b 00                	mov    (%eax),%eax
     578:	39 c2                	cmp    %eax,%edx
     57a:	75 24                	jne    5a0 <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     57c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     57f:	8b 50 04             	mov    0x4(%eax),%edx
     582:	8b 45 fc             	mov    -0x4(%ebp),%eax
     585:	8b 00                	mov    (%eax),%eax
     587:	8b 40 04             	mov    0x4(%eax),%eax
     58a:	01 c2                	add    %eax,%edx
     58c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     58f:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     592:	8b 45 fc             	mov    -0x4(%ebp),%eax
     595:	8b 00                	mov    (%eax),%eax
     597:	8b 10                	mov    (%eax),%edx
     599:	8b 45 f8             	mov    -0x8(%ebp),%eax
     59c:	89 10                	mov    %edx,(%eax)
     59e:	eb 0a                	jmp    5aa <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     5a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5a3:	8b 10                	mov    (%eax),%edx
     5a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5a8:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     5aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5ad:	8b 40 04             	mov    0x4(%eax),%eax
     5b0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     5b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5ba:	01 d0                	add    %edx,%eax
     5bc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     5bf:	75 20                	jne    5e1 <free+0xcf>
        p->s.size += bp->s.size;
     5c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5c4:	8b 50 04             	mov    0x4(%eax),%edx
     5c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5ca:	8b 40 04             	mov    0x4(%eax),%eax
     5cd:	01 c2                	add    %eax,%edx
     5cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5d2:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     5d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5d8:	8b 10                	mov    (%eax),%edx
     5da:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5dd:	89 10                	mov    %edx,(%eax)
     5df:	eb 08                	jmp    5e9 <free+0xd7>
    } else
        p->s.ptr = bp;
     5e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     5e7:	89 10                	mov    %edx,(%eax)
    freep = p;
     5e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5ec:	a3 28 2e 00 00       	mov    %eax,0x2e28
}
     5f1:	90                   	nop
     5f2:	c9                   	leave  
     5f3:	c3                   	ret    

000005f4 <morecore>:

static Header* morecore(uint nu) {
     5f4:	55                   	push   %ebp
     5f5:	89 e5                	mov    %esp,%ebp
     5f7:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     5fa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     601:	77 07                	ja     60a <morecore+0x16>
     603:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     60a:	8b 45 08             	mov    0x8(%ebp),%eax
     60d:	c1 e0 03             	shl    $0x3,%eax
     610:	83 ec 0c             	sub    $0xc,%esp
     613:	50                   	push   %eax
     614:	e8 6a fc ff ff       	call   283 <sbrk>
     619:	83 c4 10             	add    $0x10,%esp
     61c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     61f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     623:	75 07                	jne    62c <morecore+0x38>
     625:	b8 00 00 00 00       	mov    $0x0,%eax
     62a:	eb 26                	jmp    652 <morecore+0x5e>
    hp = (Header*) p;
     62c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     632:	8b 45 f0             	mov    -0x10(%ebp),%eax
     635:	8b 55 08             	mov    0x8(%ebp),%edx
     638:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     63b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     63e:	83 c0 08             	add    $0x8,%eax
     641:	83 ec 0c             	sub    $0xc,%esp
     644:	50                   	push   %eax
     645:	e8 c8 fe ff ff       	call   512 <free>
     64a:	83 c4 10             	add    $0x10,%esp
    return freep;
     64d:	a1 28 2e 00 00       	mov    0x2e28,%eax
}
     652:	c9                   	leave  
     653:	c3                   	ret    

00000654 <malloc>:

void* malloc(uint nbytes) {
     654:	55                   	push   %ebp
     655:	89 e5                	mov    %esp,%ebp
     657:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     65a:	8b 45 08             	mov    0x8(%ebp),%eax
     65d:	83 c0 07             	add    $0x7,%eax
     660:	c1 e8 03             	shr    $0x3,%eax
     663:	83 c0 01             	add    $0x1,%eax
     666:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     669:	a1 28 2e 00 00       	mov    0x2e28,%eax
     66e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     671:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     675:	75 23                	jne    69a <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     677:	c7 45 f0 20 2e 00 00 	movl   $0x2e20,-0x10(%ebp)
     67e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     681:	a3 28 2e 00 00       	mov    %eax,0x2e28
     686:	a1 28 2e 00 00       	mov    0x2e28,%eax
     68b:	a3 20 2e 00 00       	mov    %eax,0x2e20
        base.s.size = 0;
     690:	c7 05 24 2e 00 00 00 	movl   $0x0,0x2e24
     697:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     69a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     69d:	8b 00                	mov    (%eax),%eax
     69f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     6a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a5:	8b 40 04             	mov    0x4(%eax),%eax
     6a8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     6ab:	77 4d                	ja     6fa <malloc+0xa6>
            if (p->s.size == nunits)
     6ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b0:	8b 40 04             	mov    0x4(%eax),%eax
     6b3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     6b6:	75 0c                	jne    6c4 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     6b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bb:	8b 10                	mov    (%eax),%edx
     6bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6c0:	89 10                	mov    %edx,(%eax)
     6c2:	eb 26                	jmp    6ea <malloc+0x96>
            else {
                p->s.size -= nunits;
     6c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c7:	8b 40 04             	mov    0x4(%eax),%eax
     6ca:	2b 45 ec             	sub    -0x14(%ebp),%eax
     6cd:	89 c2                	mov    %eax,%edx
     6cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d2:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     6d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d8:	8b 40 04             	mov    0x4(%eax),%eax
     6db:	c1 e0 03             	shl    $0x3,%eax
     6de:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     6e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
     6e7:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     6ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6ed:	a3 28 2e 00 00       	mov    %eax,0x2e28
            return (void*) (p + 1);
     6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f5:	83 c0 08             	add    $0x8,%eax
     6f8:	eb 3b                	jmp    735 <malloc+0xe1>
        }
        if (p == freep)
     6fa:	a1 28 2e 00 00       	mov    0x2e28,%eax
     6ff:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     702:	75 1e                	jne    722 <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     704:	83 ec 0c             	sub    $0xc,%esp
     707:	ff 75 ec             	push   -0x14(%ebp)
     70a:	e8 e5 fe ff ff       	call   5f4 <morecore>
     70f:	83 c4 10             	add    $0x10,%esp
     712:	89 45 f4             	mov    %eax,-0xc(%ebp)
     715:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     719:	75 07                	jne    722 <malloc+0xce>
     71b:	b8 00 00 00 00       	mov    $0x0,%eax
     720:	eb 13                	jmp    735 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     722:	8b 45 f4             	mov    -0xc(%ebp),%eax
     725:	89 45 f0             	mov    %eax,-0x10(%ebp)
     728:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72b:	8b 00                	mov    (%eax),%eax
     72d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     730:	e9 6d ff ff ff       	jmp    6a2 <malloc+0x4e>
    }
}
     735:	c9                   	leave  
     736:	c3                   	ret    

00000737 <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     737:	55                   	push   %ebp
     738:	89 e5                	mov    %esp,%ebp
     73a:	83 ec 18             	sub    $0x18,%esp
     73d:	8b 45 0c             	mov    0xc(%ebp),%eax
     740:	88 45 f4             	mov    %al,-0xc(%ebp)
     743:	83 ec 04             	sub    $0x4,%esp
     746:	6a 01                	push   $0x1
     748:	8d 45 f4             	lea    -0xc(%ebp),%eax
     74b:	50                   	push   %eax
     74c:	ff 75 08             	push   0x8(%ebp)
     74f:	e8 c7 fa ff ff       	call   21b <write>
     754:	83 c4 10             	add    $0x10,%esp
     757:	90                   	nop
     758:	c9                   	leave  
     759:	c3                   	ret    

0000075a <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     75a:	55                   	push   %ebp
     75b:	89 e5                	mov    %esp,%ebp
     75d:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     760:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     767:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     76b:	74 17                	je     784 <printint+0x2a>
     76d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     771:	79 11                	jns    784 <printint+0x2a>
        neg = 1;
     773:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     77a:	8b 45 0c             	mov    0xc(%ebp),%eax
     77d:	f7 d8                	neg    %eax
     77f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     782:	eb 06                	jmp    78a <printint+0x30>
    } else {
        x = xx;
     784:	8b 45 0c             	mov    0xc(%ebp),%eax
     787:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     78a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     791:	8b 4d 10             	mov    0x10(%ebp),%ecx
     794:	8b 45 ec             	mov    -0x14(%ebp),%eax
     797:	ba 00 00 00 00       	mov    $0x0,%edx
     79c:	f7 f1                	div    %ecx
     79e:	89 d1                	mov    %edx,%ecx
     7a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a3:	8d 50 01             	lea    0x1(%eax),%edx
     7a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7a9:	0f b6 91 f4 2d 00 00 	movzbl 0x2df4(%ecx),%edx
     7b0:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     7b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     7b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7ba:	ba 00 00 00 00       	mov    $0x0,%edx
     7bf:	f7 f1                	div    %ecx
     7c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     7c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7c8:	75 c7                	jne    791 <printint+0x37>
    if (neg) buf[i++] = '-';
     7ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7ce:	74 2d                	je     7fd <printint+0xa3>
     7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d3:	8d 50 01             	lea    0x1(%eax),%edx
     7d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7d9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     7de:	eb 1d                	jmp    7fd <printint+0xa3>
     7e0:	8d 55 dc             	lea    -0x24(%ebp),%edx
     7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e6:	01 d0                	add    %edx,%eax
     7e8:	0f b6 00             	movzbl (%eax),%eax
     7eb:	0f be c0             	movsbl %al,%eax
     7ee:	83 ec 08             	sub    $0x8,%esp
     7f1:	50                   	push   %eax
     7f2:	ff 75 08             	push   0x8(%ebp)
     7f5:	e8 3d ff ff ff       	call   737 <putc>
     7fa:	83 c4 10             	add    $0x10,%esp
     7fd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     801:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     805:	79 d9                	jns    7e0 <printint+0x86>
}
     807:	90                   	nop
     808:	90                   	nop
     809:	c9                   	leave  
     80a:	c3                   	ret    

0000080b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     80b:	55                   	push   %ebp
     80c:	89 e5                	mov    %esp,%ebp
     80e:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     811:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     818:	8d 45 0c             	lea    0xc(%ebp),%eax
     81b:	83 c0 04             	add    $0x4,%eax
     81e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     821:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     828:	e9 59 01 00 00       	jmp    986 <printf+0x17b>
        c = fmt[i] & 0xff;
     82d:	8b 55 0c             	mov    0xc(%ebp),%edx
     830:	8b 45 f0             	mov    -0x10(%ebp),%eax
     833:	01 d0                	add    %edx,%eax
     835:	0f b6 00             	movzbl (%eax),%eax
     838:	0f be c0             	movsbl %al,%eax
     83b:	25 ff 00 00 00       	and    $0xff,%eax
     840:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     843:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     847:	75 2c                	jne    875 <printf+0x6a>
            if (c == '%') {
     849:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     84d:	75 0c                	jne    85b <printf+0x50>
                state = '%';
     84f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     856:	e9 27 01 00 00       	jmp    982 <printf+0x177>
            } else {
                putc(fd, c);
     85b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     85e:	0f be c0             	movsbl %al,%eax
     861:	83 ec 08             	sub    $0x8,%esp
     864:	50                   	push   %eax
     865:	ff 75 08             	push   0x8(%ebp)
     868:	e8 ca fe ff ff       	call   737 <putc>
     86d:	83 c4 10             	add    $0x10,%esp
     870:	e9 0d 01 00 00       	jmp    982 <printf+0x177>
            }
        } else if (state == '%') {
     875:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     879:	0f 85 03 01 00 00    	jne    982 <printf+0x177>
            if (c == 'd') {
     87f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     883:	75 1e                	jne    8a3 <printf+0x98>
                printint(fd, *ap, 10, 1);
     885:	8b 45 e8             	mov    -0x18(%ebp),%eax
     888:	8b 00                	mov    (%eax),%eax
     88a:	6a 01                	push   $0x1
     88c:	6a 0a                	push   $0xa
     88e:	50                   	push   %eax
     88f:	ff 75 08             	push   0x8(%ebp)
     892:	e8 c3 fe ff ff       	call   75a <printint>
     897:	83 c4 10             	add    $0x10,%esp
                ap++;
     89a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     89e:	e9 d8 00 00 00       	jmp    97b <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     8a3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     8a7:	74 06                	je     8af <printf+0xa4>
     8a9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     8ad:	75 1e                	jne    8cd <printf+0xc2>
                printint(fd, *ap, 16, 0);
     8af:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8b2:	8b 00                	mov    (%eax),%eax
     8b4:	6a 00                	push   $0x0
     8b6:	6a 10                	push   $0x10
     8b8:	50                   	push   %eax
     8b9:	ff 75 08             	push   0x8(%ebp)
     8bc:	e8 99 fe ff ff       	call   75a <printint>
     8c1:	83 c4 10             	add    $0x10,%esp
                ap++;
     8c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8c8:	e9 ae 00 00 00       	jmp    97b <printf+0x170>
            } else if (c == 's') {
     8cd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     8d1:	75 43                	jne    916 <printf+0x10b>
                s = (char*) *ap;
     8d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8d6:	8b 00                	mov    (%eax),%eax
     8d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     8db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     8df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8e3:	75 25                	jne    90a <printf+0xff>
     8e5:	c7 45 f4 e7 23 00 00 	movl   $0x23e7,-0xc(%ebp)
                while (*s != 0) {
     8ec:	eb 1c                	jmp    90a <printf+0xff>
                    putc(fd, *s);
     8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f1:	0f b6 00             	movzbl (%eax),%eax
     8f4:	0f be c0             	movsbl %al,%eax
     8f7:	83 ec 08             	sub    $0x8,%esp
     8fa:	50                   	push   %eax
     8fb:	ff 75 08             	push   0x8(%ebp)
     8fe:	e8 34 fe ff ff       	call   737 <putc>
     903:	83 c4 10             	add    $0x10,%esp
                    s++;
     906:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90d:	0f b6 00             	movzbl (%eax),%eax
     910:	84 c0                	test   %al,%al
     912:	75 da                	jne    8ee <printf+0xe3>
     914:	eb 65                	jmp    97b <printf+0x170>
                }
            } else if (c == 'c') {
     916:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     91a:	75 1d                	jne    939 <printf+0x12e>
                putc(fd, *ap);
     91c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     91f:	8b 00                	mov    (%eax),%eax
     921:	0f be c0             	movsbl %al,%eax
     924:	83 ec 08             	sub    $0x8,%esp
     927:	50                   	push   %eax
     928:	ff 75 08             	push   0x8(%ebp)
     92b:	e8 07 fe ff ff       	call   737 <putc>
     930:	83 c4 10             	add    $0x10,%esp
                ap++;
     933:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     937:	eb 42                	jmp    97b <printf+0x170>
            } else if (c == '%') {
     939:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     93d:	75 17                	jne    956 <printf+0x14b>
                putc(fd, c);
     93f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     942:	0f be c0             	movsbl %al,%eax
     945:	83 ec 08             	sub    $0x8,%esp
     948:	50                   	push   %eax
     949:	ff 75 08             	push   0x8(%ebp)
     94c:	e8 e6 fd ff ff       	call   737 <putc>
     951:	83 c4 10             	add    $0x10,%esp
     954:	eb 25                	jmp    97b <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     956:	83 ec 08             	sub    $0x8,%esp
     959:	6a 25                	push   $0x25
     95b:	ff 75 08             	push   0x8(%ebp)
     95e:	e8 d4 fd ff ff       	call   737 <putc>
     963:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     966:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     969:	0f be c0             	movsbl %al,%eax
     96c:	83 ec 08             	sub    $0x8,%esp
     96f:	50                   	push   %eax
     970:	ff 75 08             	push   0x8(%ebp)
     973:	e8 bf fd ff ff       	call   737 <putc>
     978:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     97b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     982:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     986:	8b 55 0c             	mov    0xc(%ebp),%edx
     989:	8b 45 f0             	mov    -0x10(%ebp),%eax
     98c:	01 d0                	add    %edx,%eax
     98e:	0f b6 00             	movzbl (%eax),%eax
     991:	84 c0                	test   %al,%al
     993:	0f 85 94 fe ff ff    	jne    82d <printf+0x22>
        }
    }
}
     999:	90                   	nop
     99a:	90                   	nop
     99b:	c9                   	leave  
     99c:	c3                   	ret    

0000099d <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     99d:	55                   	push   %ebp
     99e:	89 e5                	mov    %esp,%ebp
     9a0:	83 ec 04             	sub    $0x4,%esp
     9a3:	8b 45 08             	mov    0x8(%ebp),%eax
     9a6:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     9a9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     9ad:	01 c0                	add    %eax,%eax
     9af:	89 c1                	mov    %eax,%ecx
     9b1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     9b5:	c0 e8 07             	shr    $0x7,%al
     9b8:	89 c2                	mov    %eax,%edx
     9ba:	89 d0                	mov    %edx,%eax
     9bc:	01 c0                	add    %eax,%eax
     9be:	01 d0                	add    %edx,%eax
     9c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9c7:	01 d0                	add    %edx,%eax
     9c9:	31 c8                	xor    %ecx,%eax
}
     9cb:	c9                   	leave  
     9cc:	c3                   	ret    

000009cd <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     9cd:	55                   	push   %ebp
     9ce:	89 e5                	mov    %esp,%ebp
     9d0:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     9d1:	bb 00 00 00 00       	mov    $0x0,%ebx
     9d6:	eb 24                	jmp    9fc <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     9d8:	0f b6 d3             	movzbl %bl,%edx
     9db:	8b 45 08             	mov    0x8(%ebp),%eax
     9de:	01 d0                	add    %edx,%eax
     9e0:	0f b6 00             	movzbl (%eax),%eax
     9e3:	0f b6 c0             	movzbl %al,%eax
     9e6:	0f b6 cb             	movzbl %bl,%ecx
     9e9:	8b 55 08             	mov    0x8(%ebp),%edx
     9ec:	01 ca                	add    %ecx,%edx
     9ee:	0f b6 80 00 24 00 00 	movzbl 0x2400(%eax),%eax
     9f5:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     9f7:	89 d8                	mov    %ebx,%eax
     9f9:	8d 58 01             	lea    0x1(%eax),%ebx
     9fc:	80 fb 0f             	cmp    $0xf,%bl
     9ff:	76 d7                	jbe    9d8 <aes_subBytes+0xb>
    }
}
     a01:	90                   	nop
     a02:	90                   	nop
     a03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a06:	c9                   	leave  
     a07:	c3                   	ret    

00000a08 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     a08:	55                   	push   %ebp
     a09:	89 e5                	mov    %esp,%ebp
     a0b:	56                   	push   %esi
     a0c:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     a0d:	bb 00 00 00 00       	mov    $0x0,%ebx
     a12:	eb 27                	jmp    a3b <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     a14:	0f b6 d3             	movzbl %bl,%edx
     a17:	8b 45 08             	mov    0x8(%ebp),%eax
     a1a:	01 d0                	add    %edx,%eax
     a1c:	0f b6 08             	movzbl (%eax),%ecx
     a1f:	0f b6 d3             	movzbl %bl,%edx
     a22:	8b 45 0c             	mov    0xc(%ebp),%eax
     a25:	01 d0                	add    %edx,%eax
     a27:	0f b6 10             	movzbl (%eax),%edx
     a2a:	0f b6 f3             	movzbl %bl,%esi
     a2d:	8b 45 08             	mov    0x8(%ebp),%eax
     a30:	01 f0                	add    %esi,%eax
     a32:	31 ca                	xor    %ecx,%edx
     a34:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     a36:	89 d8                	mov    %ebx,%eax
     a38:	8d 58 01             	lea    0x1(%eax),%ebx
     a3b:	80 fb 0f             	cmp    $0xf,%bl
     a3e:	76 d4                	jbe    a14 <aes_addRoundKey+0xc>
    }
}
     a40:	90                   	nop
     a41:	90                   	nop
     a42:	5b                   	pop    %ebx
     a43:	5e                   	pop    %esi
     a44:	5d                   	pop    %ebp
     a45:	c3                   	ret    

00000a46 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     a46:	55                   	push   %ebp
     a47:	89 e5                	mov    %esp,%ebp
     a49:	56                   	push   %esi
     a4a:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     a4b:	bb 00 00 00 00       	mov    $0x0,%ebx
     a50:	eb 5b                	jmp    aad <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     a52:	0f b6 d3             	movzbl %bl,%edx
     a55:	8b 45 0c             	mov    0xc(%ebp),%eax
     a58:	01 d0                	add    %edx,%eax
     a5a:	0f b6 cb             	movzbl %bl,%ecx
     a5d:	8b 55 10             	mov    0x10(%ebp),%edx
     a60:	01 ca                	add    %ecx,%edx
     a62:	0f b6 00             	movzbl (%eax),%eax
     a65:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     a67:	0f b6 d3             	movzbl %bl,%edx
     a6a:	8b 45 08             	mov    0x8(%ebp),%eax
     a6d:	01 d0                	add    %edx,%eax
     a6f:	0f b6 08             	movzbl (%eax),%ecx
     a72:	0f b6 d3             	movzbl %bl,%edx
     a75:	8b 45 0c             	mov    0xc(%ebp),%eax
     a78:	01 d0                	add    %edx,%eax
     a7a:	0f b6 10             	movzbl (%eax),%edx
     a7d:	0f b6 f3             	movzbl %bl,%esi
     a80:	8b 45 08             	mov    0x8(%ebp),%eax
     a83:	01 f0                	add    %esi,%eax
     a85:	31 ca                	xor    %ecx,%edx
     a87:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     a89:	0f b6 c3             	movzbl %bl,%eax
     a8c:	83 c0 10             	add    $0x10,%eax
     a8f:	89 c2                	mov    %eax,%edx
     a91:	8b 45 0c             	mov    0xc(%ebp),%eax
     a94:	01 d0                	add    %edx,%eax
     a96:	0f b6 d3             	movzbl %bl,%edx
     a99:	83 c2 10             	add    $0x10,%edx
     a9c:	89 d1                	mov    %edx,%ecx
     a9e:	8b 55 10             	mov    0x10(%ebp),%edx
     aa1:	01 ca                	add    %ecx,%edx
     aa3:	0f b6 00             	movzbl (%eax),%eax
     aa6:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     aa8:	89 d8                	mov    %ebx,%eax
     aaa:	8d 58 01             	lea    0x1(%eax),%ebx
     aad:	80 fb 0f             	cmp    $0xf,%bl
     ab0:	76 a0                	jbe    a52 <aes_addRoundKey_cpy+0xc>
    }
}
     ab2:	90                   	nop
     ab3:	90                   	nop
     ab4:	5b                   	pop    %ebx
     ab5:	5e                   	pop    %esi
     ab6:	5d                   	pop    %ebp
     ab7:	c3                   	ret    

00000ab8 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     ab8:	55                   	push   %ebp
     ab9:	89 e5                	mov    %esp,%ebp
     abb:	53                   	push   %ebx
     abc:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     abf:	8b 45 08             	mov    0x8(%ebp),%eax
     ac2:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     ac6:	8b 45 08             	mov    0x8(%ebp),%eax
     ac9:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     acd:	88 45 fb             	mov    %al,-0x5(%ebp)
     ad0:	8b 45 08             	mov    0x8(%ebp),%eax
     ad3:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     ad7:	88 5d fa             	mov    %bl,-0x6(%ebp)
     ada:	8b 45 08             	mov    0x8(%ebp),%eax
     add:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     ae1:	8b 45 08             	mov    0x8(%ebp),%eax
     ae4:	8d 50 01             	lea    0x1(%eax),%edx
     ae7:	8b 45 08             	mov    0x8(%ebp),%eax
     aea:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     aee:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     af0:	8b 45 08             	mov    0x8(%ebp),%eax
     af3:	8d 50 05             	lea    0x5(%eax),%edx
     af6:	8b 45 08             	mov    0x8(%ebp),%eax
     af9:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     afd:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     aff:	8b 45 08             	mov    0x8(%ebp),%eax
     b02:	8d 50 09             	lea    0x9(%eax),%edx
     b05:	8b 45 08             	mov    0x8(%ebp),%eax
     b08:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     b0c:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     b0e:	8b 45 08             	mov    0x8(%ebp),%eax
     b11:	83 c0 0d             	add    $0xd,%eax
     b14:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     b16:	8b 45 08             	mov    0x8(%ebp),%eax
     b19:	8d 50 03             	lea    0x3(%eax),%edx
     b1c:	8b 45 08             	mov    0x8(%ebp),%eax
     b1f:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     b23:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     b25:	8b 45 08             	mov    0x8(%ebp),%eax
     b28:	8d 50 0f             	lea    0xf(%eax),%edx
     b2b:	8b 45 08             	mov    0x8(%ebp),%eax
     b2e:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     b32:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     b34:	8b 45 08             	mov    0x8(%ebp),%eax
     b37:	8d 50 0b             	lea    0xb(%eax),%edx
     b3a:	8b 45 08             	mov    0x8(%ebp),%eax
     b3d:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     b41:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     b43:	8b 45 08             	mov    0x8(%ebp),%eax
     b46:	83 c0 07             	add    $0x7,%eax
     b49:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     b4d:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     b4f:	8b 45 08             	mov    0x8(%ebp),%eax
     b52:	8d 50 0a             	lea    0xa(%eax),%edx
     b55:	8b 45 08             	mov    0x8(%ebp),%eax
     b58:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     b5c:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     b5e:	8b 45 08             	mov    0x8(%ebp),%eax
     b61:	83 c0 02             	add    $0x2,%eax
     b64:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     b68:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     b6a:	8b 45 08             	mov    0x8(%ebp),%eax
     b6d:	8d 50 0e             	lea    0xe(%eax),%edx
     b70:	8b 45 08             	mov    0x8(%ebp),%eax
     b73:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     b77:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     b79:	8b 45 08             	mov    0x8(%ebp),%eax
     b7c:	83 c0 06             	add    $0x6,%eax
     b7f:	88 18                	mov    %bl,(%eax)
}
     b81:	90                   	nop
     b82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b85:	c9                   	leave  
     b86:	c3                   	ret    

00000b87 <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     b87:	55                   	push   %ebp
     b88:	89 e5                	mov    %esp,%ebp
     b8a:	56                   	push   %esi
     b8b:	53                   	push   %ebx
     b8c:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     b8f:	bb 00 00 00 00       	mov    $0x0,%ebx
     b94:	e9 42 01 00 00       	jmp    cdb <aes_mixColumns+0x154>
        a = buf[i];
     b99:	0f b6 d3             	movzbl %bl,%edx
     b9c:	8b 45 08             	mov    0x8(%ebp),%eax
     b9f:	01 d0                	add    %edx,%eax
     ba1:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     ba4:	0f b6 c3             	movzbl %bl,%eax
     ba7:	8d 50 01             	lea    0x1(%eax),%edx
     baa:	8b 45 08             	mov    0x8(%ebp),%eax
     bad:	01 d0                	add    %edx,%eax
     baf:	0f b6 10             	movzbl (%eax),%edx
     bb2:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     bb5:	0f b6 c3             	movzbl %bl,%eax
     bb8:	8d 50 02             	lea    0x2(%eax),%edx
     bbb:	8b 45 08             	mov    0x8(%ebp),%eax
     bbe:	01 d0                	add    %edx,%eax
     bc0:	0f b6 00             	movzbl (%eax),%eax
     bc3:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     bc6:	0f b6 c3             	movzbl %bl,%eax
     bc9:	8d 50 03             	lea    0x3(%eax),%edx
     bcc:	8b 45 08             	mov    0x8(%ebp),%eax
     bcf:	01 d0                	add    %edx,%eax
     bd1:	0f b6 00             	movzbl (%eax),%eax
     bd4:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     bd7:	89 c8                	mov    %ecx,%eax
     bd9:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     bdd:	31 d0                	xor    %edx,%eax
     bdf:	32 45 f6             	xor    -0xa(%ebp),%al
     be2:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     be6:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     be8:	88 4d f4             	mov    %cl,-0xc(%ebp)
     beb:	89 c8                	mov    %ecx,%eax
     bed:	88 55 f7             	mov    %dl,-0x9(%ebp)
     bf0:	32 45 f7             	xor    -0x9(%ebp),%al
     bf3:	0f b6 c0             	movzbl %al,%eax
     bf6:	50                   	push   %eax
     bf7:	e8 a1 fd ff ff       	call   99d <rj_xtime>
     bfc:	83 c4 04             	add    $0x4,%esp
     bff:	31 f0                	xor    %esi,%eax
     c01:	0f b6 c8             	movzbl %al,%ecx
     c04:	0f b6 d3             	movzbl %bl,%edx
     c07:	8b 45 08             	mov    0x8(%ebp),%eax
     c0a:	01 d0                	add    %edx,%eax
     c0c:	0f b6 00             	movzbl (%eax),%eax
     c0f:	89 c2                	mov    %eax,%edx
     c11:	89 c8                	mov    %ecx,%eax
     c13:	89 d1                	mov    %edx,%ecx
     c15:	31 c1                	xor    %eax,%ecx
     c17:	0f b6 d3             	movzbl %bl,%edx
     c1a:	8b 45 08             	mov    0x8(%ebp),%eax
     c1d:	01 c2                	add    %eax,%edx
     c1f:	89 c8                	mov    %ecx,%eax
     c21:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     c23:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     c27:	32 55 f6             	xor    -0xa(%ebp),%dl
     c2a:	89 d0                	mov    %edx,%eax
     c2c:	0f b6 c0             	movzbl %al,%eax
     c2f:	50                   	push   %eax
     c30:	e8 68 fd ff ff       	call   99d <rj_xtime>
     c35:	83 c4 04             	add    $0x4,%esp
     c38:	31 f0                	xor    %esi,%eax
     c3a:	0f b6 c8             	movzbl %al,%ecx
     c3d:	0f b6 c3             	movzbl %bl,%eax
     c40:	8d 50 01             	lea    0x1(%eax),%edx
     c43:	8b 45 08             	mov    0x8(%ebp),%eax
     c46:	01 d0                	add    %edx,%eax
     c48:	0f b6 00             	movzbl (%eax),%eax
     c4b:	89 c2                	mov    %eax,%edx
     c4d:	89 c8                	mov    %ecx,%eax
     c4f:	31 c2                	xor    %eax,%edx
     c51:	89 d1                	mov    %edx,%ecx
     c53:	0f b6 c3             	movzbl %bl,%eax
     c56:	8d 50 01             	lea    0x1(%eax),%edx
     c59:	8b 45 08             	mov    0x8(%ebp),%eax
     c5c:	01 c2                	add    %eax,%edx
     c5e:	89 c8                	mov    %ecx,%eax
     c60:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     c62:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     c66:	32 45 f5             	xor    -0xb(%ebp),%al
     c69:	0f b6 c0             	movzbl %al,%eax
     c6c:	50                   	push   %eax
     c6d:	e8 2b fd ff ff       	call   99d <rj_xtime>
     c72:	83 c4 04             	add    $0x4,%esp
     c75:	31 f0                	xor    %esi,%eax
     c77:	0f b6 d0             	movzbl %al,%edx
     c7a:	0f b6 c3             	movzbl %bl,%eax
     c7d:	8d 48 02             	lea    0x2(%eax),%ecx
     c80:	8b 45 08             	mov    0x8(%ebp),%eax
     c83:	01 c8                	add    %ecx,%eax
     c85:	0f b6 00             	movzbl (%eax),%eax
     c88:	89 c1                	mov    %eax,%ecx
     c8a:	89 d0                	mov    %edx,%eax
     c8c:	89 ca                	mov    %ecx,%edx
     c8e:	31 c2                	xor    %eax,%edx
     c90:	0f b6 c3             	movzbl %bl,%eax
     c93:	8d 48 02             	lea    0x2(%eax),%ecx
     c96:	8b 45 08             	mov    0x8(%ebp),%eax
     c99:	01 c8                	add    %ecx,%eax
     c9b:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     c9d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     ca1:	32 45 f4             	xor    -0xc(%ebp),%al
     ca4:	0f b6 c0             	movzbl %al,%eax
     ca7:	50                   	push   %eax
     ca8:	e8 f0 fc ff ff       	call   99d <rj_xtime>
     cad:	83 c4 04             	add    $0x4,%esp
     cb0:	31 f0                	xor    %esi,%eax
     cb2:	0f b6 d0             	movzbl %al,%edx
     cb5:	0f b6 c3             	movzbl %bl,%eax
     cb8:	8d 48 03             	lea    0x3(%eax),%ecx
     cbb:	8b 45 08             	mov    0x8(%ebp),%eax
     cbe:	01 c8                	add    %ecx,%eax
     cc0:	0f b6 00             	movzbl (%eax),%eax
     cc3:	89 c1                	mov    %eax,%ecx
     cc5:	89 d0                	mov    %edx,%eax
     cc7:	31 c1                	xor    %eax,%ecx
     cc9:	89 ca                	mov    %ecx,%edx
     ccb:	0f b6 c3             	movzbl %bl,%eax
     cce:	8d 48 03             	lea    0x3(%eax),%ecx
     cd1:	8b 45 08             	mov    0x8(%ebp),%eax
     cd4:	01 c8                	add    %ecx,%eax
     cd6:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     cd8:	83 c3 04             	add    $0x4,%ebx
     cdb:	80 fb 0f             	cmp    $0xf,%bl
     cde:	0f 86 b5 fe ff ff    	jbe    b99 <aes_mixColumns+0x12>
    }
}
     ce4:	90                   	nop
     ce5:	90                   	nop
     ce6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ce9:	5b                   	pop    %ebx
     cea:	5e                   	pop    %esi
     ceb:	5d                   	pop    %ebp
     cec:	c3                   	ret    

00000ced <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     ced:	55                   	push   %ebp
     cee:	89 e5                	mov    %esp,%ebp
     cf0:	56                   	push   %esi
     cf1:	53                   	push   %ebx
     cf2:	83 ec 04             	sub    $0x4,%esp
     cf5:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf8:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     cfb:	8b 45 08             	mov    0x8(%ebp),%eax
     cfe:	0f b6 10             	movzbl (%eax),%edx
     d01:	8b 45 08             	mov    0x8(%ebp),%eax
     d04:	83 c0 1d             	add    $0x1d,%eax
     d07:	0f b6 00             	movzbl (%eax),%eax
     d0a:	0f b6 c0             	movzbl %al,%eax
     d0d:	0f b6 80 00 24 00 00 	movzbl 0x2400(%eax),%eax
     d14:	32 45 f4             	xor    -0xc(%ebp),%al
     d17:	31 c2                	xor    %eax,%edx
     d19:	8b 45 08             	mov    0x8(%ebp),%eax
     d1c:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     d1e:	8b 45 08             	mov    0x8(%ebp),%eax
     d21:	83 c0 01             	add    $0x1,%eax
     d24:	0f b6 08             	movzbl (%eax),%ecx
     d27:	8b 45 08             	mov    0x8(%ebp),%eax
     d2a:	83 c0 1e             	add    $0x1e,%eax
     d2d:	0f b6 00             	movzbl (%eax),%eax
     d30:	0f b6 c0             	movzbl %al,%eax
     d33:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     d3a:	8b 45 08             	mov    0x8(%ebp),%eax
     d3d:	83 c0 01             	add    $0x1,%eax
     d40:	31 ca                	xor    %ecx,%edx
     d42:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     d44:	8b 45 08             	mov    0x8(%ebp),%eax
     d47:	83 c0 02             	add    $0x2,%eax
     d4a:	0f b6 08             	movzbl (%eax),%ecx
     d4d:	8b 45 08             	mov    0x8(%ebp),%eax
     d50:	83 c0 1f             	add    $0x1f,%eax
     d53:	0f b6 00             	movzbl (%eax),%eax
     d56:	0f b6 c0             	movzbl %al,%eax
     d59:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     d60:	8b 45 08             	mov    0x8(%ebp),%eax
     d63:	83 c0 02             	add    $0x2,%eax
     d66:	31 ca                	xor    %ecx,%edx
     d68:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     d6a:	8b 45 08             	mov    0x8(%ebp),%eax
     d6d:	83 c0 03             	add    $0x3,%eax
     d70:	0f b6 08             	movzbl (%eax),%ecx
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	83 c0 1c             	add    $0x1c,%eax
     d79:	0f b6 00             	movzbl (%eax),%eax
     d7c:	0f b6 c0             	movzbl %al,%eax
     d7f:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     d86:	8b 45 08             	mov    0x8(%ebp),%eax
     d89:	83 c0 03             	add    $0x3,%eax
     d8c:	31 ca                	xor    %ecx,%edx
     d8e:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     d90:	bb 04 00 00 00       	mov    $0x4,%ebx
     d95:	e9 a9 00 00 00       	jmp    e43 <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     d9a:	0f b6 d3             	movzbl %bl,%edx
     d9d:	8b 45 08             	mov    0x8(%ebp),%eax
     da0:	01 d0                	add    %edx,%eax
     da2:	0f b6 08             	movzbl (%eax),%ecx
     da5:	0f b6 c3             	movzbl %bl,%eax
     da8:	8d 50 fc             	lea    -0x4(%eax),%edx
     dab:	8b 45 08             	mov    0x8(%ebp),%eax
     dae:	01 d0                	add    %edx,%eax
     db0:	0f b6 10             	movzbl (%eax),%edx
     db3:	0f b6 f3             	movzbl %bl,%esi
     db6:	8b 45 08             	mov    0x8(%ebp),%eax
     db9:	01 f0                	add    %esi,%eax
     dbb:	31 ca                	xor    %ecx,%edx
     dbd:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     dbf:	0f b6 c3             	movzbl %bl,%eax
     dc2:	8d 50 01             	lea    0x1(%eax),%edx
     dc5:	8b 45 08             	mov    0x8(%ebp),%eax
     dc8:	01 d0                	add    %edx,%eax
     dca:	0f b6 08             	movzbl (%eax),%ecx
     dcd:	0f b6 c3             	movzbl %bl,%eax
     dd0:	8d 50 fd             	lea    -0x3(%eax),%edx
     dd3:	8b 45 08             	mov    0x8(%ebp),%eax
     dd6:	01 d0                	add    %edx,%eax
     dd8:	0f b6 10             	movzbl (%eax),%edx
     ddb:	0f b6 c3             	movzbl %bl,%eax
     dde:	8d 70 01             	lea    0x1(%eax),%esi
     de1:	8b 45 08             	mov    0x8(%ebp),%eax
     de4:	01 f0                	add    %esi,%eax
     de6:	31 ca                	xor    %ecx,%edx
     de8:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     dea:	0f b6 c3             	movzbl %bl,%eax
     ded:	8d 50 02             	lea    0x2(%eax),%edx
     df0:	8b 45 08             	mov    0x8(%ebp),%eax
     df3:	01 d0                	add    %edx,%eax
     df5:	0f b6 08             	movzbl (%eax),%ecx
     df8:	0f b6 c3             	movzbl %bl,%eax
     dfb:	8d 50 fe             	lea    -0x2(%eax),%edx
     dfe:	8b 45 08             	mov    0x8(%ebp),%eax
     e01:	01 d0                	add    %edx,%eax
     e03:	0f b6 10             	movzbl (%eax),%edx
     e06:	0f b6 c3             	movzbl %bl,%eax
     e09:	8d 70 02             	lea    0x2(%eax),%esi
     e0c:	8b 45 08             	mov    0x8(%ebp),%eax
     e0f:	01 f0                	add    %esi,%eax
     e11:	31 ca                	xor    %ecx,%edx
     e13:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     e15:	0f b6 c3             	movzbl %bl,%eax
     e18:	8d 50 03             	lea    0x3(%eax),%edx
     e1b:	8b 45 08             	mov    0x8(%ebp),%eax
     e1e:	01 d0                	add    %edx,%eax
     e20:	0f b6 08             	movzbl (%eax),%ecx
     e23:	0f b6 c3             	movzbl %bl,%eax
     e26:	8d 50 ff             	lea    -0x1(%eax),%edx
     e29:	8b 45 08             	mov    0x8(%ebp),%eax
     e2c:	01 d0                	add    %edx,%eax
     e2e:	0f b6 10             	movzbl (%eax),%edx
     e31:	0f b6 c3             	movzbl %bl,%eax
     e34:	8d 70 03             	lea    0x3(%eax),%esi
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	01 f0                	add    %esi,%eax
     e3c:	31 ca                	xor    %ecx,%edx
     e3e:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     e40:	83 c3 04             	add    $0x4,%ebx
     e43:	80 fb 0f             	cmp    $0xf,%bl
     e46:	0f 86 4e ff ff ff    	jbe    d9a <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     e4c:	8b 45 08             	mov    0x8(%ebp),%eax
     e4f:	83 c0 10             	add    $0x10,%eax
     e52:	0f b6 08             	movzbl (%eax),%ecx
     e55:	8b 45 08             	mov    0x8(%ebp),%eax
     e58:	83 c0 0c             	add    $0xc,%eax
     e5b:	0f b6 00             	movzbl (%eax),%eax
     e5e:	0f b6 c0             	movzbl %al,%eax
     e61:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	83 c0 10             	add    $0x10,%eax
     e6e:	31 ca                	xor    %ecx,%edx
     e70:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     e72:	8b 45 08             	mov    0x8(%ebp),%eax
     e75:	83 c0 11             	add    $0x11,%eax
     e78:	0f b6 08             	movzbl (%eax),%ecx
     e7b:	8b 45 08             	mov    0x8(%ebp),%eax
     e7e:	83 c0 0d             	add    $0xd,%eax
     e81:	0f b6 00             	movzbl (%eax),%eax
     e84:	0f b6 c0             	movzbl %al,%eax
     e87:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     e8e:	8b 45 08             	mov    0x8(%ebp),%eax
     e91:	83 c0 11             	add    $0x11,%eax
     e94:	31 ca                	xor    %ecx,%edx
     e96:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     e98:	8b 45 08             	mov    0x8(%ebp),%eax
     e9b:	83 c0 12             	add    $0x12,%eax
     e9e:	0f b6 08             	movzbl (%eax),%ecx
     ea1:	8b 45 08             	mov    0x8(%ebp),%eax
     ea4:	83 c0 0e             	add    $0xe,%eax
     ea7:	0f b6 00             	movzbl (%eax),%eax
     eaa:	0f b6 c0             	movzbl %al,%eax
     ead:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     eb4:	8b 45 08             	mov    0x8(%ebp),%eax
     eb7:	83 c0 12             	add    $0x12,%eax
     eba:	31 ca                	xor    %ecx,%edx
     ebc:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
     ebe:	8b 45 08             	mov    0x8(%ebp),%eax
     ec1:	83 c0 13             	add    $0x13,%eax
     ec4:	0f b6 08             	movzbl (%eax),%ecx
     ec7:	8b 45 08             	mov    0x8(%ebp),%eax
     eca:	83 c0 0f             	add    $0xf,%eax
     ecd:	0f b6 00             	movzbl (%eax),%eax
     ed0:	0f b6 c0             	movzbl %al,%eax
     ed3:	0f b6 90 00 24 00 00 	movzbl 0x2400(%eax),%edx
     eda:	8b 45 08             	mov    0x8(%ebp),%eax
     edd:	83 c0 13             	add    $0x13,%eax
     ee0:	31 ca                	xor    %ecx,%edx
     ee2:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
     ee4:	bb 14 00 00 00       	mov    $0x14,%ebx
     ee9:	e9 a9 00 00 00       	jmp    f97 <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
     eee:	0f b6 d3             	movzbl %bl,%edx
     ef1:	8b 45 08             	mov    0x8(%ebp),%eax
     ef4:	01 d0                	add    %edx,%eax
     ef6:	0f b6 08             	movzbl (%eax),%ecx
     ef9:	0f b6 c3             	movzbl %bl,%eax
     efc:	8d 50 fc             	lea    -0x4(%eax),%edx
     eff:	8b 45 08             	mov    0x8(%ebp),%eax
     f02:	01 d0                	add    %edx,%eax
     f04:	0f b6 10             	movzbl (%eax),%edx
     f07:	0f b6 f3             	movzbl %bl,%esi
     f0a:	8b 45 08             	mov    0x8(%ebp),%eax
     f0d:	01 f0                	add    %esi,%eax
     f0f:	31 ca                	xor    %ecx,%edx
     f11:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     f13:	0f b6 c3             	movzbl %bl,%eax
     f16:	8d 50 01             	lea    0x1(%eax),%edx
     f19:	8b 45 08             	mov    0x8(%ebp),%eax
     f1c:	01 d0                	add    %edx,%eax
     f1e:	0f b6 08             	movzbl (%eax),%ecx
     f21:	0f b6 c3             	movzbl %bl,%eax
     f24:	8d 50 fd             	lea    -0x3(%eax),%edx
     f27:	8b 45 08             	mov    0x8(%ebp),%eax
     f2a:	01 d0                	add    %edx,%eax
     f2c:	0f b6 10             	movzbl (%eax),%edx
     f2f:	0f b6 c3             	movzbl %bl,%eax
     f32:	8d 70 01             	lea    0x1(%eax),%esi
     f35:	8b 45 08             	mov    0x8(%ebp),%eax
     f38:	01 f0                	add    %esi,%eax
     f3a:	31 ca                	xor    %ecx,%edx
     f3c:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     f3e:	0f b6 c3             	movzbl %bl,%eax
     f41:	8d 50 02             	lea    0x2(%eax),%edx
     f44:	8b 45 08             	mov    0x8(%ebp),%eax
     f47:	01 d0                	add    %edx,%eax
     f49:	0f b6 08             	movzbl (%eax),%ecx
     f4c:	0f b6 c3             	movzbl %bl,%eax
     f4f:	8d 50 fe             	lea    -0x2(%eax),%edx
     f52:	8b 45 08             	mov    0x8(%ebp),%eax
     f55:	01 d0                	add    %edx,%eax
     f57:	0f b6 10             	movzbl (%eax),%edx
     f5a:	0f b6 c3             	movzbl %bl,%eax
     f5d:	8d 70 02             	lea    0x2(%eax),%esi
     f60:	8b 45 08             	mov    0x8(%ebp),%eax
     f63:	01 f0                	add    %esi,%eax
     f65:	31 ca                	xor    %ecx,%edx
     f67:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     f69:	0f b6 c3             	movzbl %bl,%eax
     f6c:	8d 50 03             	lea    0x3(%eax),%edx
     f6f:	8b 45 08             	mov    0x8(%ebp),%eax
     f72:	01 d0                	add    %edx,%eax
     f74:	0f b6 08             	movzbl (%eax),%ecx
     f77:	0f b6 c3             	movzbl %bl,%eax
     f7a:	8d 50 ff             	lea    -0x1(%eax),%edx
     f7d:	8b 45 08             	mov    0x8(%ebp),%eax
     f80:	01 d0                	add    %edx,%eax
     f82:	0f b6 10             	movzbl (%eax),%edx
     f85:	0f b6 c3             	movzbl %bl,%eax
     f88:	8d 70 03             	lea    0x3(%eax),%esi
     f8b:	8b 45 08             	mov    0x8(%ebp),%eax
     f8e:	01 f0                	add    %esi,%eax
     f90:	31 ca                	xor    %ecx,%edx
     f92:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
     f94:	83 c3 04             	add    $0x4,%ebx
     f97:	80 fb 1f             	cmp    $0x1f,%bl
     f9a:	0f 86 4e ff ff ff    	jbe    eee <aes_expandEncKey+0x201>
    }
}
     fa0:	90                   	nop
     fa1:	90                   	nop
     fa2:	83 c4 04             	add    $0x4,%esp
     fa5:	5b                   	pop    %ebx
     fa6:	5e                   	pop    %esi
     fa7:	5d                   	pop    %ebp
     fa8:	c3                   	ret    

00000fa9 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
     fa9:	55                   	push   %ebp
     faa:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
     fac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     fb0:	74 4d                	je     fff <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
     fb2:	8b 45 08             	mov    0x8(%ebp),%eax
     fb5:	83 c0 03             	add    $0x3,%eax
     fb8:	0f b6 10             	movzbl (%eax),%edx
     fbb:	83 c2 01             	add    $0x1,%edx
     fbe:	88 10                	mov    %dl,(%eax)
     fc0:	0f b6 00             	movzbl (%eax),%eax
     fc3:	84 c0                	test   %al,%al
     fc5:	75 38                	jne    fff <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
     fc7:	8b 45 08             	mov    0x8(%ebp),%eax
     fca:	83 c0 02             	add    $0x2,%eax
     fcd:	0f b6 10             	movzbl (%eax),%edx
     fd0:	83 c2 01             	add    $0x1,%edx
     fd3:	88 10                	mov    %dl,(%eax)
     fd5:	0f b6 00             	movzbl (%eax),%eax
     fd8:	84 c0                	test   %al,%al
     fda:	75 23                	jne    fff <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
     fdc:	8b 45 08             	mov    0x8(%ebp),%eax
     fdf:	83 c0 01             	add    $0x1,%eax
     fe2:	0f b6 10             	movzbl (%eax),%edx
     fe5:	83 c2 01             	add    $0x1,%edx
     fe8:	88 10                	mov    %dl,(%eax)
     fea:	0f b6 00             	movzbl (%eax),%eax
     fed:	84 c0                	test   %al,%al
     fef:	75 0e                	jne    fff <ctr_inc_ctr+0x56>
                    val[0]++;
     ff1:	8b 45 08             	mov    0x8(%ebp),%eax
     ff4:	0f b6 00             	movzbl (%eax),%eax
     ff7:	8d 50 01             	lea    0x1(%eax),%edx
     ffa:	8b 45 08             	mov    0x8(%ebp),%eax
     ffd:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
     fff:	90                   	nop
    1000:	5d                   	pop    %ebp
    1001:	c3                   	ret    

00001002 <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
    1002:	55                   	push   %ebp
    1003:	89 e5                	mov    %esp,%ebp
    1005:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1008:	8b 45 08             	mov    0x8(%ebp),%eax
    100b:	83 c0 40             	add    $0x40,%eax
    100e:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
    1011:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1015:	74 56                	je     106d <ctr_clock_keystream+0x6b>
    1017:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    101b:	74 50                	je     106d <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    101d:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
    1021:	eb 21                	jmp    1044 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
    1023:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
    1027:	8b 45 f0             	mov    -0x10(%ebp),%eax
    102a:	01 d0                	add    %edx,%eax
    102c:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
    1030:	8b 55 0c             	mov    0xc(%ebp),%edx
    1033:	01 ca                	add    %ecx,%edx
    1035:	0f b6 00             	movzbl (%eax),%eax
    1038:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    103a:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
    103e:	83 c0 01             	add    $0x1,%eax
    1041:	88 45 f7             	mov    %al,-0x9(%ebp)
    1044:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
    1048:	76 d9                	jbe    1023 <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
    104a:	83 ec 08             	sub    $0x8,%esp
    104d:	ff 75 0c             	push   0xc(%ebp)
    1050:	ff 75 08             	push   0x8(%ebp)
    1053:	e8 16 01 00 00       	call   116e <aes256_encrypt_ecb>
    1058:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
    105b:	8b 45 08             	mov    0x8(%ebp),%eax
    105e:	83 c0 4c             	add    $0x4c,%eax
    1061:	83 ec 0c             	sub    $0xc,%esp
    1064:	50                   	push   %eax
    1065:	e8 3f ff ff ff       	call   fa9 <ctr_inc_ctr>
    106a:	83 c4 10             	add    $0x10,%esp
    }
}
    106d:	90                   	nop
    106e:	c9                   	leave  
    106f:	c3                   	ret    

00001070 <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
    1076:	8b 45 0c             	mov    0xc(%ebp),%eax
    1079:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
    107c:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
    1083:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
    108a:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
    1091:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
    1098:	83 ec 08             	sub    $0x8,%esp
    109b:	ff 75 08             	push   0x8(%ebp)
    109e:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    10a1:	50                   	push   %eax
    10a2:	e8 2e 00 00 00       	call   10d5 <aes256_init>
    10a7:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
    10aa:	83 ec 08             	sub    $0x8,%esp
    10ad:	8d 45 94             	lea    -0x6c(%ebp),%eax
    10b0:	50                   	push   %eax
    10b1:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    10b4:	50                   	push   %eax
    10b5:	e8 8d 01 00 00       	call   1247 <aes256_setCtrBlk>
    10ba:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
    10bd:	83 ec 04             	sub    $0x4,%esp
    10c0:	ff 75 10             	push   0x10(%ebp)
    10c3:	ff 75 f4             	push   -0xc(%ebp)
    10c6:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    10c9:	50                   	push   %eax
    10ca:	e8 c9 01 00 00       	call   1298 <aes256_encrypt_ctr>
    10cf:	83 c4 10             	add    $0x10,%esp
}
    10d2:	90                   	nop
    10d3:	c9                   	leave  
    10d4:	c3                   	ret    

000010d5 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
    10d5:	55                   	push   %ebp
    10d6:	89 e5                	mov    %esp,%ebp
    10d8:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    10d9:	bb 00 00 00 00       	mov    $0x0,%ebx
    10de:	eb 1a                	jmp    10fa <aes256_init+0x25>
        ctx->enckey[i] = key[i];
    10e0:	0f b6 d3             	movzbl %bl,%edx
    10e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e6:	01 c2                	add    %eax,%edx
    10e8:	0f b6 c3             	movzbl %bl,%eax
    10eb:	0f b6 0a             	movzbl (%edx),%ecx
    10ee:	8b 55 08             	mov    0x8(%ebp),%edx
    10f1:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    10f5:	89 d8                	mov    %ebx,%eax
    10f7:	8d 58 01             	lea    0x1(%eax),%ebx
    10fa:	80 fb 1f             	cmp    $0x1f,%bl
    10fd:	76 e1                	jbe    10e0 <aes256_init+0xb>
    }
}
    10ff:	90                   	nop
    1100:	90                   	nop
    1101:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1104:	c9                   	leave  
    1105:	c3                   	ret    

00001106 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    1106:	55                   	push   %ebp
    1107:	89 e5                	mov    %esp,%ebp
    1109:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    110a:	bb 00 00 00 00       	mov    $0x0,%ebx
    110f:	eb 51                	jmp    1162 <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    1111:	0f b6 c3             	movzbl %bl,%eax
    1114:	8b 55 08             	mov    0x8(%ebp),%edx
    1117:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    111c:	0f b6 d3             	movzbl %bl,%edx
    111f:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1122:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    1127:	8b 45 08             	mov    0x8(%ebp),%eax
    112a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    112d:	0f b6 c3             	movzbl %bl,%eax
    1130:	83 e0 03             	and    $0x3,%eax
    1133:	89 c2                	mov    %eax,%edx
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    113d:	0f b6 c3             	movzbl %bl,%eax
    1140:	83 e0 07             	and    $0x7,%eax
    1143:	89 c2                	mov    %eax,%edx
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    114d:	0f b6 c3             	movzbl %bl,%eax
    1150:	83 e0 03             	and    $0x3,%eax
    1153:	89 c2                	mov    %eax,%edx
    1155:	8b 45 08             	mov    0x8(%ebp),%eax
    1158:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    115d:	89 d8                	mov    %ebx,%eax
    115f:	8d 58 01             	lea    0x1(%eax),%ebx
    1162:	80 fb 1f             	cmp    $0x1f,%bl
    1165:	76 aa                	jbe    1111 <aes256_done+0xb>
    }
}
    1167:	90                   	nop
    1168:	90                   	nop
    1169:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    116c:	c9                   	leave  
    116d:	c3                   	ret    

0000116e <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    116e:	55                   	push   %ebp
    116f:	89 e5                	mov    %esp,%ebp
    1171:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    1174:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    1178:	8b 45 08             	mov    0x8(%ebp),%eax
    117b:	8b 55 08             	mov    0x8(%ebp),%edx
    117e:	83 c2 20             	add    $0x20,%edx
    1181:	50                   	push   %eax
    1182:	52                   	push   %edx
    1183:	ff 75 0c             	push   0xc(%ebp)
    1186:	e8 bb f8 ff ff       	call   a46 <aes_addRoundKey_cpy>
    118b:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    118e:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    1192:	eb 74                	jmp    1208 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    1194:	ff 75 0c             	push   0xc(%ebp)
    1197:	e8 31 f8 ff ff       	call   9cd <aes_subBytes>
    119c:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    119f:	ff 75 0c             	push   0xc(%ebp)
    11a2:	e8 11 f9 ff ff       	call   ab8 <aes_shiftRows>
    11a7:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    11aa:	ff 75 0c             	push   0xc(%ebp)
    11ad:	e8 d5 f9 ff ff       	call   b87 <aes_mixColumns>
    11b2:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    11b5:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    11b9:	83 e0 01             	and    $0x1,%eax
    11bc:	85 c0                	test   %eax,%eax
    11be:	74 14                	je     11d4 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    11c0:	8b 45 08             	mov    0x8(%ebp),%eax
    11c3:	83 c0 10             	add    $0x10,%eax
    11c6:	50                   	push   %eax
    11c7:	ff 75 0c             	push   0xc(%ebp)
    11ca:	e8 39 f8 ff ff       	call   a08 <aes_addRoundKey>
    11cf:	83 c4 08             	add    $0x8,%esp
    11d2:	eb 30                	jmp    1204 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    11d4:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    11d8:	8b 45 08             	mov    0x8(%ebp),%eax
    11db:	52                   	push   %edx
    11dc:	50                   	push   %eax
    11dd:	e8 0b fb ff ff       	call   ced <aes_expandEncKey>
    11e2:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    11e5:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    11e9:	50                   	push   %eax
    11ea:	e8 ae f7 ff ff       	call   99d <rj_xtime>
    11ef:	83 c4 04             	add    $0x4,%esp
    11f2:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	50                   	push   %eax
    11f9:	ff 75 0c             	push   0xc(%ebp)
    11fc:	e8 07 f8 ff ff       	call   a08 <aes_addRoundKey>
    1201:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    1204:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    1208:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    120c:	76 86                	jbe    1194 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    120e:	ff 75 0c             	push   0xc(%ebp)
    1211:	e8 b7 f7 ff ff       	call   9cd <aes_subBytes>
    1216:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    1219:	ff 75 0c             	push   0xc(%ebp)
    121c:	e8 97 f8 ff ff       	call   ab8 <aes_shiftRows>
    1221:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    1224:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1228:	8b 45 08             	mov    0x8(%ebp),%eax
    122b:	52                   	push   %edx
    122c:	50                   	push   %eax
    122d:	e8 bb fa ff ff       	call   ced <aes_expandEncKey>
    1232:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    1235:	8b 45 08             	mov    0x8(%ebp),%eax
    1238:	50                   	push   %eax
    1239:	ff 75 0c             	push   0xc(%ebp)
    123c:	e8 c7 f7 ff ff       	call   a08 <aes_addRoundKey>
    1241:	83 c4 08             	add    $0x8,%esp
}
    1244:	90                   	nop
    1245:	c9                   	leave  
    1246:	c3                   	ret    

00001247 <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    1247:	55                   	push   %ebp
    1248:	89 e5                	mov    %esp,%ebp
    124a:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	83 c0 40             	add    $0x40,%eax
    1253:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    1256:	8b 45 0c             	mov    0xc(%ebp),%eax
    1259:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    125c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1260:	74 33                	je     1295 <aes256_setCtrBlk+0x4e>
    1262:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1266:	74 2d                	je     1295 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1268:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    126c:	eb 21                	jmp    128f <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    126e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1272:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1275:	01 d0                	add    %edx,%eax
    1277:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    127b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    127e:	01 ca                	add    %ecx,%edx
    1280:	0f b6 00             	movzbl (%eax),%eax
    1283:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1285:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1289:	83 c0 01             	add    $0x1,%eax
    128c:	88 45 ff             	mov    %al,-0x1(%ebp)
    128f:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    1293:	76 d9                	jbe    126e <aes256_setCtrBlk+0x27>
        }
    }
}
    1295:	90                   	nop
    1296:	c9                   	leave  
    1297:	c3                   	ret    

00001298 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    1298:	55                   	push   %ebp
    1299:	89 e5                	mov    %esp,%ebp
    129b:	53                   	push   %ebx
    129c:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    129f:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    12a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12aa:	eb 49                	jmp    12f5 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    12ac:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    12b0:	75 16                	jne    12c8 <aes256_encrypt_ctr+0x30>
            j = 0;
    12b2:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    12b6:	83 ec 08             	sub    $0x8,%esp
    12b9:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    12bc:	50                   	push   %eax
    12bd:	ff 75 08             	push   0x8(%ebp)
    12c0:	e8 3d fd ff ff       	call   1002 <ctr_clock_keystream>
    12c5:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    12c8:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    12cc:	8d 50 01             	lea    0x1(%eax),%edx
    12cf:	88 55 f3             	mov    %dl,-0xd(%ebp)
    12d2:	0f b6 c0             	movzbl %al,%eax
    12d5:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    12da:	8b 55 0c             	mov    0xc(%ebp),%edx
    12dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e0:	01 d0                	add    %edx,%eax
    12e2:	0f b6 10             	movzbl (%eax),%edx
    12e5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    12e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12eb:	01 d8                	add    %ebx,%eax
    12ed:	31 ca                	xor    %ecx,%edx
    12ef:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    12f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12f8:	3b 45 10             	cmp    0x10(%ebp),%eax
    12fb:	72 af                	jb     12ac <aes256_encrypt_ctr+0x14>
    }
}
    12fd:	90                   	nop
    12fe:	90                   	nop
    12ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1302:	c9                   	leave  
    1303:	c3                   	ret    

00001304 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    1304:	55                   	push   %ebp
    1305:	89 e5                	mov    %esp,%ebp
    1307:	8b 45 0c             	mov    0xc(%ebp),%eax
    130a:	83 e0 1f             	and    $0x1f,%eax
    130d:	8b 55 08             	mov    0x8(%ebp),%edx
    1310:	89 c1                	mov    %eax,%ecx
    1312:	d3 ea                	shr    %cl,%edx
    1314:	89 d0                	mov    %edx,%eax
    1316:	5d                   	pop    %ebp
    1317:	c3                   	ret    

00001318 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    1318:	55                   	push   %ebp
    1319:	89 e5                	mov    %esp,%ebp
    131b:	8b 45 0c             	mov    0xc(%ebp),%eax
    131e:	83 e0 1f             	and    $0x1f,%eax
    1321:	8b 55 08             	mov    0x8(%ebp),%edx
    1324:	89 c1                	mov    %eax,%ecx
    1326:	d3 e2                	shl    %cl,%edx
    1328:	89 d0                	mov    %edx,%eax
    132a:	5d                   	pop    %ebp
    132b:	c3                   	ret    

0000132c <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    132c:	55                   	push   %ebp
    132d:	89 e5                	mov    %esp,%ebp
    132f:	53                   	push   %ebx
    1330:	83 ec 04             	sub    $0x4,%esp
    1333:	8b 45 0c             	mov    0xc(%ebp),%eax
    1336:	88 45 f8             	mov    %al,-0x8(%ebp)
    1339:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    133d:	8b 55 08             	mov    0x8(%ebp),%edx
    1340:	89 d3                	mov    %edx,%ebx
    1342:	89 c1                	mov    %eax,%ecx
    1344:	d3 eb                	shr    %cl,%ebx
    1346:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    134a:	b8 20 00 00 00       	mov    $0x20,%eax
    134f:	29 d0                	sub    %edx,%eax
    1351:	50                   	push   %eax
    1352:	ff 75 08             	push   0x8(%ebp)
    1355:	e8 be ff ff ff       	call   1318 <_shw>
    135a:	83 c4 08             	add    $0x8,%esp
    135d:	09 d8                	or     %ebx,%eax
    135f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1362:	c9                   	leave  
    1363:	c3                   	ret    

00001364 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    1364:	55                   	push   %ebp
    1365:	89 e5                	mov    %esp,%ebp
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
    136a:	23 45 0c             	and    0xc(%ebp),%eax
    136d:	89 c2                	mov    %eax,%edx
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	f7 d0                	not    %eax
    1374:	23 45 10             	and    0x10(%ebp),%eax
    1377:	31 d0                	xor    %edx,%eax
    1379:	5d                   	pop    %ebp
    137a:	c3                   	ret    

0000137b <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    137b:	55                   	push   %ebp
    137c:	89 e5                	mov    %esp,%ebp
    137e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1381:	33 45 10             	xor    0x10(%ebp),%eax
    1384:	23 45 08             	and    0x8(%ebp),%eax
    1387:	89 c2                	mov    %eax,%edx
    1389:	8b 45 0c             	mov    0xc(%ebp),%eax
    138c:	23 45 10             	and    0x10(%ebp),%eax
    138f:	31 d0                	xor    %edx,%eax
    1391:	5d                   	pop    %ebp
    1392:	c3                   	ret    

00001393 <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    1393:	55                   	push   %ebp
    1394:	89 e5                	mov    %esp,%ebp
    1396:	53                   	push   %ebx
    1397:	6a 02                	push   $0x2
    1399:	ff 75 08             	push   0x8(%ebp)
    139c:	e8 8b ff ff ff       	call   132c <_r>
    13a1:	83 c4 08             	add    $0x8,%esp
    13a4:	89 c3                	mov    %eax,%ebx
    13a6:	6a 0d                	push   $0xd
    13a8:	ff 75 08             	push   0x8(%ebp)
    13ab:	e8 7c ff ff ff       	call   132c <_r>
    13b0:	83 c4 08             	add    $0x8,%esp
    13b3:	31 c3                	xor    %eax,%ebx
    13b5:	6a 16                	push   $0x16
    13b7:	ff 75 08             	push   0x8(%ebp)
    13ba:	e8 6d ff ff ff       	call   132c <_r>
    13bf:	83 c4 08             	add    $0x8,%esp
    13c2:	31 d8                	xor    %ebx,%eax
    13c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13c7:	c9                   	leave  
    13c8:	c3                   	ret    

000013c9 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    13c9:	55                   	push   %ebp
    13ca:	89 e5                	mov    %esp,%ebp
    13cc:	53                   	push   %ebx
    13cd:	6a 06                	push   $0x6
    13cf:	ff 75 08             	push   0x8(%ebp)
    13d2:	e8 55 ff ff ff       	call   132c <_r>
    13d7:	83 c4 08             	add    $0x8,%esp
    13da:	89 c3                	mov    %eax,%ebx
    13dc:	6a 0b                	push   $0xb
    13de:	ff 75 08             	push   0x8(%ebp)
    13e1:	e8 46 ff ff ff       	call   132c <_r>
    13e6:	83 c4 08             	add    $0x8,%esp
    13e9:	31 c3                	xor    %eax,%ebx
    13eb:	6a 19                	push   $0x19
    13ed:	ff 75 08             	push   0x8(%ebp)
    13f0:	e8 37 ff ff ff       	call   132c <_r>
    13f5:	83 c4 08             	add    $0x8,%esp
    13f8:	31 d8                	xor    %ebx,%eax
    13fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13fd:	c9                   	leave  
    13fe:	c3                   	ret    

000013ff <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    13ff:	55                   	push   %ebp
    1400:	89 e5                	mov    %esp,%ebp
    1402:	53                   	push   %ebx
    1403:	6a 07                	push   $0x7
    1405:	ff 75 08             	push   0x8(%ebp)
    1408:	e8 1f ff ff ff       	call   132c <_r>
    140d:	83 c4 08             	add    $0x8,%esp
    1410:	89 c3                	mov    %eax,%ebx
    1412:	6a 12                	push   $0x12
    1414:	ff 75 08             	push   0x8(%ebp)
    1417:	e8 10 ff ff ff       	call   132c <_r>
    141c:	83 c4 08             	add    $0x8,%esp
    141f:	89 da                	mov    %ebx,%edx
    1421:	31 c2                	xor    %eax,%edx
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	c1 e8 03             	shr    $0x3,%eax
    1429:	31 d0                	xor    %edx,%eax
    142b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    142e:	c9                   	leave  
    142f:	c3                   	ret    

00001430 <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	53                   	push   %ebx
    1434:	6a 11                	push   $0x11
    1436:	ff 75 08             	push   0x8(%ebp)
    1439:	e8 ee fe ff ff       	call   132c <_r>
    143e:	83 c4 08             	add    $0x8,%esp
    1441:	89 c3                	mov    %eax,%ebx
    1443:	6a 13                	push   $0x13
    1445:	ff 75 08             	push   0x8(%ebp)
    1448:	e8 df fe ff ff       	call   132c <_r>
    144d:	83 c4 08             	add    $0x8,%esp
    1450:	89 da                	mov    %ebx,%edx
    1452:	31 c2                	xor    %eax,%edx
    1454:	8b 45 08             	mov    0x8(%ebp),%eax
    1457:	c1 e8 0a             	shr    $0xa,%eax
    145a:	31 d0                	xor    %edx,%eax
    145c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    145f:	c9                   	leave  
    1460:	c3                   	ret    

00001461 <_word>:

FN_ uint _word(uchar* c) {
    1461:	55                   	push   %ebp
    1462:	89 e5                	mov    %esp,%ebp
    1464:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    1465:	8b 45 08             	mov    0x8(%ebp),%eax
    1468:	0f b6 00             	movzbl (%eax),%eax
    146b:	0f b6 c0             	movzbl %al,%eax
    146e:	6a 18                	push   $0x18
    1470:	50                   	push   %eax
    1471:	e8 a2 fe ff ff       	call   1318 <_shw>
    1476:	83 c4 08             	add    $0x8,%esp
    1479:	89 c3                	mov    %eax,%ebx
    147b:	8b 45 08             	mov    0x8(%ebp),%eax
    147e:	83 c0 01             	add    $0x1,%eax
    1481:	0f b6 00             	movzbl (%eax),%eax
    1484:	0f b6 c0             	movzbl %al,%eax
    1487:	6a 10                	push   $0x10
    1489:	50                   	push   %eax
    148a:	e8 89 fe ff ff       	call   1318 <_shw>
    148f:	83 c4 08             	add    $0x8,%esp
    1492:	09 c3                	or     %eax,%ebx
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
    1497:	83 c0 02             	add    $0x2,%eax
    149a:	0f b6 00             	movzbl (%eax),%eax
    149d:	0f b6 c0             	movzbl %al,%eax
    14a0:	6a 08                	push   $0x8
    14a2:	50                   	push   %eax
    14a3:	e8 70 fe ff ff       	call   1318 <_shw>
    14a8:	83 c4 08             	add    $0x8,%esp
    14ab:	89 da                	mov    %ebx,%edx
    14ad:	09 c2                	or     %eax,%edx
    14af:	8b 45 08             	mov    0x8(%ebp),%eax
    14b2:	83 c0 03             	add    $0x3,%eax
    14b5:	0f b6 00             	movzbl (%eax),%eax
    14b8:	0f b6 c0             	movzbl %al,%eax
    14bb:	09 d0                	or     %edx,%eax
}
    14bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14c0:	c9                   	leave  
    14c1:	c3                   	ret    

000014c2 <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    14c2:	55                   	push   %ebp
    14c3:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    14c5:	8b 45 08             	mov    0x8(%ebp),%eax
    14c8:	8b 40 60             	mov    0x60(%eax),%eax
    14cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    14ce:	f7 d2                	not    %edx
    14d0:	39 d0                	cmp    %edx,%eax
    14d2:	76 0f                	jbe    14e3 <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    14d4:	8b 45 08             	mov    0x8(%ebp),%eax
    14d7:	8b 40 64             	mov    0x64(%eax),%eax
    14da:	8d 50 01             	lea    0x1(%eax),%edx
    14dd:	8b 45 08             	mov    0x8(%ebp),%eax
    14e0:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    14e3:	8b 45 08             	mov    0x8(%ebp),%eax
    14e6:	8b 50 60             	mov    0x60(%eax),%edx
    14e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ec:	01 c2                	add    %eax,%edx
    14ee:	8b 45 08             	mov    0x8(%ebp),%eax
    14f1:	89 50 60             	mov    %edx,0x60(%eax)
}
    14f4:	90                   	nop
    14f5:	5d                   	pop    %ebp
    14f6:	c3                   	ret    

000014f7 <_hash>:

static void _hash(sha256_context* ctx) {
    14f7:	55                   	push   %ebp
    14f8:	89 e5                	mov    %esp,%ebp
    14fa:	57                   	push   %edi
    14fb:	56                   	push   %esi
    14fc:	53                   	push   %ebx
    14fd:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    1500:	8b 45 08             	mov    0x8(%ebp),%eax
    1503:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    1506:	8b 45 08             	mov    0x8(%ebp),%eax
    1509:	8b 40 44             	mov    0x44(%eax),%eax
    150c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    150f:	8b 45 08             	mov    0x8(%ebp),%eax
    1512:	8b 40 48             	mov    0x48(%eax),%eax
    1515:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    1518:	8b 45 08             	mov    0x8(%ebp),%eax
    151b:	8b 40 4c             	mov    0x4c(%eax),%eax
    151e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    1521:	8b 45 08             	mov    0x8(%ebp),%eax
    1524:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	8b 40 54             	mov    0x54(%eax),%eax
    152d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    1530:	8b 45 08             	mov    0x8(%ebp),%eax
    1533:	8b 40 58             	mov    0x58(%eax),%eax
    1536:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    1539:	8b 45 08             	mov    0x8(%ebp),%eax
    153c:	8b 40 5c             	mov    0x5c(%eax),%eax
    153f:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    1542:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1549:	e9 27 01 00 00       	jmp    1675 <_hash+0x17e>
        if (i < 16) {
    154e:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    1552:	77 2d                	ja     1581 <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    1554:	6a 02                	push   $0x2
    1556:	ff 75 f0             	push   -0x10(%ebp)
    1559:	e8 ba fd ff ff       	call   1318 <_shw>
    155e:	83 c4 08             	add    $0x8,%esp
    1561:	89 c2                	mov    %eax,%edx
    1563:	8b 45 08             	mov    0x8(%ebp),%eax
    1566:	01 d0                	add    %edx,%eax
    1568:	50                   	push   %eax
    1569:	e8 f3 fe ff ff       	call   1461 <_word>
    156e:	83 c4 04             	add    $0x4,%esp
    1571:	89 c1                	mov    %eax,%ecx
    1573:	8b 55 08             	mov    0x8(%ebp),%edx
    1576:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1579:	83 c0 1c             	add    $0x1c,%eax
    157c:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    157f:	eb 64                	jmp    15e5 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1581:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1584:	83 e8 02             	sub    $0x2,%eax
    1587:	8b 55 08             	mov    0x8(%ebp),%edx
    158a:	83 c0 1c             	add    $0x1c,%eax
    158d:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1590:	50                   	push   %eax
    1591:	e8 9a fe ff ff       	call   1430 <_G1>
    1596:	83 c4 04             	add    $0x4,%esp
    1599:	89 c1                	mov    %eax,%ecx
    159b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    159e:	83 e8 07             	sub    $0x7,%eax
    15a1:	8b 55 08             	mov    0x8(%ebp),%edx
    15a4:	83 c0 1c             	add    $0x1c,%eax
    15a7:	8b 04 82             	mov    (%edx,%eax,4),%eax
    15aa:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    15ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b0:	83 e8 0f             	sub    $0xf,%eax
    15b3:	8b 55 08             	mov    0x8(%ebp),%edx
    15b6:	83 c0 1c             	add    $0x1c,%eax
    15b9:	8b 04 82             	mov    (%edx,%eax,4),%eax
    15bc:	50                   	push   %eax
    15bd:	e8 3d fe ff ff       	call   13ff <_G0>
    15c2:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    15c5:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    15c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15cb:	83 e8 10             	sub    $0x10,%eax
    15ce:	8b 55 08             	mov    0x8(%ebp),%edx
    15d1:	83 c0 1c             	add    $0x1c,%eax
    15d4:	8b 04 82             	mov    (%edx,%eax,4),%eax
    15d7:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    15d9:	8b 55 08             	mov    0x8(%ebp),%edx
    15dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15df:	83 c0 1c             	add    $0x1c,%eax
    15e2:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    15e5:	57                   	push   %edi
    15e6:	e8 de fd ff ff       	call   13c9 <_S1>
    15eb:	83 c4 04             	add    $0x4,%esp
    15ee:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    15f1:	01 c3                	add    %eax,%ebx
    15f3:	ff 75 d4             	push   -0x2c(%ebp)
    15f6:	ff 75 d8             	push   -0x28(%ebp)
    15f9:	57                   	push   %edi
    15fa:	e8 65 fd ff ff       	call   1364 <_Ch>
    15ff:	83 c4 0c             	add    $0xc,%esp
    1602:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    1605:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1608:	8b 04 85 00 25 00 00 	mov    0x2500(,%eax,4),%eax
    160f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1612:	8b 55 08             	mov    0x8(%ebp),%edx
    1615:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1618:	83 c0 1c             	add    $0x1c,%eax
    161b:	8b 04 82             	mov    (%edx,%eax,4),%eax
    161e:	01 c8                	add    %ecx,%eax
    1620:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    1623:	56                   	push   %esi
    1624:	e8 6a fd ff ff       	call   1393 <_S0>
    1629:	83 c4 04             	add    $0x4,%esp
    162c:	89 c3                	mov    %eax,%ebx
    162e:	ff 75 dc             	push   -0x24(%ebp)
    1631:	ff 75 e0             	push   -0x20(%ebp)
    1634:	56                   	push   %esi
    1635:	e8 41 fd ff ff       	call   137b <_Ma>
    163a:	83 c4 0c             	add    $0xc,%esp
    163d:	01 d8                	add    %ebx,%eax
    163f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    1642:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1645:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    1648:	8b 45 d8             	mov    -0x28(%ebp),%eax
    164b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    164e:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    1651:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1654:	8b 7d d0             	mov    -0x30(%ebp),%edi
    1657:	01 c7                	add    %eax,%edi
        d = c;
    1659:	8b 45 dc             	mov    -0x24(%ebp),%eax
    165c:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    165f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1662:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    1665:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    1668:	8b 55 e8             	mov    -0x18(%ebp),%edx
    166b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    166e:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    1671:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1675:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    1679:	0f 86 cf fe ff ff    	jbe    154e <_hash+0x57>
    }

    ctx->hash[0] += a;
    167f:	8b 45 08             	mov    0x8(%ebp),%eax
    1682:	8b 40 40             	mov    0x40(%eax),%eax
    1685:	8d 14 06             	lea    (%esi,%eax,1),%edx
    1688:	8b 45 08             	mov    0x8(%ebp),%eax
    168b:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    168e:	8b 45 08             	mov    0x8(%ebp),%eax
    1691:	8b 40 44             	mov    0x44(%eax),%eax
    1694:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1697:	01 c2                	add    %eax,%edx
    1699:	8b 45 08             	mov    0x8(%ebp),%eax
    169c:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    169f:	8b 45 08             	mov    0x8(%ebp),%eax
    16a2:	8b 40 48             	mov    0x48(%eax),%eax
    16a5:	8b 55 dc             	mov    -0x24(%ebp),%edx
    16a8:	01 c2                	add    %eax,%edx
    16aa:	8b 45 08             	mov    0x8(%ebp),%eax
    16ad:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	8b 40 4c             	mov    0x4c(%eax),%eax
    16b6:	8b 55 d0             	mov    -0x30(%ebp),%edx
    16b9:	01 c2                	add    %eax,%edx
    16bb:	8b 45 08             	mov    0x8(%ebp),%eax
    16be:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    16c1:	8b 45 08             	mov    0x8(%ebp),%eax
    16c4:	8b 40 50             	mov    0x50(%eax),%eax
    16c7:	8d 14 07             	lea    (%edi,%eax,1),%edx
    16ca:	8b 45 08             	mov    0x8(%ebp),%eax
    16cd:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    16d0:	8b 45 08             	mov    0x8(%ebp),%eax
    16d3:	8b 40 54             	mov    0x54(%eax),%eax
    16d6:	8b 55 d8             	mov    -0x28(%ebp),%edx
    16d9:	01 c2                	add    %eax,%edx
    16db:	8b 45 08             	mov    0x8(%ebp),%eax
    16de:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    16e1:	8b 45 08             	mov    0x8(%ebp),%eax
    16e4:	8b 40 58             	mov    0x58(%eax),%eax
    16e7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    16ea:	01 c2                	add    %eax,%edx
    16ec:	8b 45 08             	mov    0x8(%ebp),%eax
    16ef:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    16f2:	8b 45 08             	mov    0x8(%ebp),%eax
    16f5:	8b 40 5c             	mov    0x5c(%eax),%eax
    16f8:	8b 55 cc             	mov    -0x34(%ebp),%edx
    16fb:	01 c2                	add    %eax,%edx
    16fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1700:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    1703:	90                   	nop
    1704:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1707:	5b                   	pop    %ebx
    1708:	5e                   	pop    %esi
    1709:	5f                   	pop    %edi
    170a:	5d                   	pop    %ebp
    170b:	c3                   	ret    

0000170c <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    170c:	55                   	push   %ebp
    170d:	89 e5                	mov    %esp,%ebp
    170f:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    1715:	83 ec 0c             	sub    $0xc,%esp
    1718:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    171e:	50                   	push   %eax
    171f:	e8 33 00 00 00       	call   1757 <sha256_init>
    1724:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    1727:	83 ec 04             	sub    $0x4,%esp
    172a:	ff 75 0c             	push   0xc(%ebp)
    172d:	ff 75 08             	push   0x8(%ebp)
    1730:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1736:	50                   	push   %eax
    1737:	e8 99 00 00 00       	call   17d5 <sha256_hash>
    173c:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    173f:	83 ec 08             	sub    $0x8,%esp
    1742:	ff 75 10             	push   0x10(%ebp)
    1745:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    174b:	50                   	push   %eax
    174c:	e8 14 01 00 00       	call   1865 <sha256_done>
    1751:	83 c4 10             	add    $0x10,%esp
}
    1754:	90                   	nop
    1755:	c9                   	leave  
    1756:	c3                   	ret    

00001757 <sha256_init>:

void sha256_init(sha256_context* ctx) {
    1757:	55                   	push   %ebp
    1758:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    175a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    175e:	74 72                	je     17d2 <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    1760:	8b 45 08             	mov    0x8(%ebp),%eax
    1763:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    176a:	8b 45 08             	mov    0x8(%ebp),%eax
    176d:	8b 50 68             	mov    0x68(%eax),%edx
    1770:	8b 45 08             	mov    0x8(%ebp),%eax
    1773:	89 50 64             	mov    %edx,0x64(%eax)
    1776:	8b 45 08             	mov    0x8(%ebp),%eax
    1779:	8b 50 64             	mov    0x64(%eax),%edx
    177c:	8b 45 08             	mov    0x8(%ebp),%eax
    177f:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    1782:	8b 45 08             	mov    0x8(%ebp),%eax
    1785:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    178c:	8b 45 08             	mov    0x8(%ebp),%eax
    178f:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    1796:	8b 45 08             	mov    0x8(%ebp),%eax
    1799:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    17a0:	8b 45 08             	mov    0x8(%ebp),%eax
    17a3:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    17aa:	8b 45 08             	mov    0x8(%ebp),%eax
    17ad:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    17b4:	8b 45 08             	mov    0x8(%ebp),%eax
    17b7:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    17be:	8b 45 08             	mov    0x8(%ebp),%eax
    17c1:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    17c8:	8b 45 08             	mov    0x8(%ebp),%eax
    17cb:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    17d2:	90                   	nop
    17d3:	5d                   	pop    %ebp
    17d4:	c3                   	ret    

000017d5 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    17d5:	55                   	push   %ebp
    17d6:	89 e5                	mov    %esp,%ebp
    17d8:	53                   	push   %ebx
    17d9:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    17dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    17df:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    17e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    17e6:	74 77                	je     185f <sha256_hash+0x8a>
    17e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17ec:	74 71                	je     185f <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    17ee:	8b 45 08             	mov    0x8(%ebp),%eax
    17f1:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    17f4:	83 f8 3f             	cmp    $0x3f,%eax
    17f7:	77 66                	ja     185f <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    17f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    1800:	eb 55                	jmp    1857 <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    1802:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1805:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1808:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	8b 40 68             	mov    0x68(%eax),%eax
    1811:	8d 48 01             	lea    0x1(%eax),%ecx
    1814:	8b 55 08             	mov    0x8(%ebp),%edx
    1817:	89 4a 68             	mov    %ecx,0x68(%edx)
    181a:	0f b6 0b             	movzbl (%ebx),%ecx
    181d:	8b 55 08             	mov    0x8(%ebp),%edx
    1820:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    1823:	8b 45 08             	mov    0x8(%ebp),%eax
    1826:	8b 40 68             	mov    0x68(%eax),%eax
    1829:	83 f8 40             	cmp    $0x40,%eax
    182c:	75 25                	jne    1853 <sha256_hash+0x7e>
                _hash(ctx);
    182e:	ff 75 08             	push   0x8(%ebp)
    1831:	e8 c1 fc ff ff       	call   14f7 <_hash>
    1836:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    1839:	68 00 02 00 00       	push   $0x200
    183e:	ff 75 08             	push   0x8(%ebp)
    1841:	e8 7c fc ff ff       	call   14c2 <_addbits>
    1846:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
    184c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    1853:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1857:	8b 45 f8             	mov    -0x8(%ebp),%eax
    185a:	3b 45 10             	cmp    0x10(%ebp),%eax
    185d:	72 a3                	jb     1802 <sha256_hash+0x2d>
            }
        }
    }
}
    185f:	90                   	nop
    1860:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1863:	c9                   	leave  
    1864:	c3                   	ret    

00001865 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    1865:	55                   	push   %ebp
    1866:	89 e5                	mov    %esp,%ebp
    1868:	57                   	push   %edi
    1869:	56                   	push   %esi
    186a:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    186b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    186f:	0f 84 27 02 00 00    	je     1a9c <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    1875:	8b 45 08             	mov    0x8(%ebp),%eax
    1878:	8b 40 68             	mov    0x68(%eax),%eax
    187b:	83 e0 3f             	and    $0x3f,%eax
    187e:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    1880:	8b 45 08             	mov    0x8(%ebp),%eax
    1883:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    1887:	8d 73 01             	lea    0x1(%ebx),%esi
    188a:	eb 0a                	jmp    1896 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    188c:	8b 45 08             	mov    0x8(%ebp),%eax
    188f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    1893:	83 c6 01             	add    $0x1,%esi
    1896:	83 fe 3f             	cmp    $0x3f,%esi
    1899:	76 f1                	jbe    188c <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    189b:	8b 45 08             	mov    0x8(%ebp),%eax
    189e:	8b 40 68             	mov    0x68(%eax),%eax
    18a1:	83 f8 37             	cmp    $0x37,%eax
    18a4:	76 21                	jbe    18c7 <sha256_done+0x62>
            _hash(ctx);
    18a6:	ff 75 08             	push   0x8(%ebp)
    18a9:	e8 49 fc ff ff       	call   14f7 <_hash>
    18ae:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    18b1:	bb 00 00 00 00       	mov    $0x0,%ebx
    18b6:	eb 0a                	jmp    18c2 <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    18b8:	8b 45 08             	mov    0x8(%ebp),%eax
    18bb:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    18bf:	83 c3 01             	add    $0x1,%ebx
    18c2:	83 fb 3f             	cmp    $0x3f,%ebx
    18c5:	76 f1                	jbe    18b8 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    18c7:	8b 45 08             	mov    0x8(%ebp),%eax
    18ca:	8b 40 68             	mov    0x68(%eax),%eax
    18cd:	c1 e0 03             	shl    $0x3,%eax
    18d0:	50                   	push   %eax
    18d1:	ff 75 08             	push   0x8(%ebp)
    18d4:	e8 e9 fb ff ff       	call   14c2 <_addbits>
    18d9:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    18dc:	8b 45 08             	mov    0x8(%ebp),%eax
    18df:	8b 40 60             	mov    0x60(%eax),%eax
    18e2:	6a 00                	push   $0x0
    18e4:	50                   	push   %eax
    18e5:	e8 1a fa ff ff       	call   1304 <_shb>
    18ea:	83 c4 08             	add    $0x8,%esp
    18ed:	8b 55 08             	mov    0x8(%ebp),%edx
    18f0:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    18f3:	8b 45 08             	mov    0x8(%ebp),%eax
    18f6:	8b 40 60             	mov    0x60(%eax),%eax
    18f9:	6a 08                	push   $0x8
    18fb:	50                   	push   %eax
    18fc:	e8 03 fa ff ff       	call   1304 <_shb>
    1901:	83 c4 08             	add    $0x8,%esp
    1904:	8b 55 08             	mov    0x8(%ebp),%edx
    1907:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    190a:	8b 45 08             	mov    0x8(%ebp),%eax
    190d:	8b 40 60             	mov    0x60(%eax),%eax
    1910:	6a 10                	push   $0x10
    1912:	50                   	push   %eax
    1913:	e8 ec f9 ff ff       	call   1304 <_shb>
    1918:	83 c4 08             	add    $0x8,%esp
    191b:	8b 55 08             	mov    0x8(%ebp),%edx
    191e:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    1921:	8b 45 08             	mov    0x8(%ebp),%eax
    1924:	8b 40 60             	mov    0x60(%eax),%eax
    1927:	6a 18                	push   $0x18
    1929:	50                   	push   %eax
    192a:	e8 d5 f9 ff ff       	call   1304 <_shb>
    192f:	83 c4 08             	add    $0x8,%esp
    1932:	8b 55 08             	mov    0x8(%ebp),%edx
    1935:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    1938:	8b 45 08             	mov    0x8(%ebp),%eax
    193b:	8b 40 64             	mov    0x64(%eax),%eax
    193e:	6a 00                	push   $0x0
    1940:	50                   	push   %eax
    1941:	e8 be f9 ff ff       	call   1304 <_shb>
    1946:	83 c4 08             	add    $0x8,%esp
    1949:	8b 55 08             	mov    0x8(%ebp),%edx
    194c:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    194f:	8b 45 08             	mov    0x8(%ebp),%eax
    1952:	8b 40 64             	mov    0x64(%eax),%eax
    1955:	6a 08                	push   $0x8
    1957:	50                   	push   %eax
    1958:	e8 a7 f9 ff ff       	call   1304 <_shb>
    195d:	83 c4 08             	add    $0x8,%esp
    1960:	8b 55 08             	mov    0x8(%ebp),%edx
    1963:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    1966:	8b 45 08             	mov    0x8(%ebp),%eax
    1969:	8b 40 64             	mov    0x64(%eax),%eax
    196c:	6a 10                	push   $0x10
    196e:	50                   	push   %eax
    196f:	e8 90 f9 ff ff       	call   1304 <_shb>
    1974:	83 c4 08             	add    $0x8,%esp
    1977:	8b 55 08             	mov    0x8(%ebp),%edx
    197a:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    197d:	8b 45 08             	mov    0x8(%ebp),%eax
    1980:	8b 40 64             	mov    0x64(%eax),%eax
    1983:	6a 18                	push   $0x18
    1985:	50                   	push   %eax
    1986:	e8 79 f9 ff ff       	call   1304 <_shb>
    198b:	83 c4 08             	add    $0x8,%esp
    198e:	8b 55 08             	mov    0x8(%ebp),%edx
    1991:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    1994:	ff 75 08             	push   0x8(%ebp)
    1997:	e8 5b fb ff ff       	call   14f7 <_hash>
    199c:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    199f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19a3:	0f 84 f3 00 00 00    	je     1a9c <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    19a9:	be 00 00 00 00       	mov    $0x0,%esi
    19ae:	bb 18 00 00 00       	mov    $0x18,%ebx
    19b3:	e9 db 00 00 00       	jmp    1a93 <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    19b8:	8b 45 08             	mov    0x8(%ebp),%eax
    19bb:	8b 40 40             	mov    0x40(%eax),%eax
    19be:	8b 55 0c             	mov    0xc(%ebp),%edx
    19c1:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    19c4:	53                   	push   %ebx
    19c5:	50                   	push   %eax
    19c6:	e8 39 f9 ff ff       	call   1304 <_shb>
    19cb:	83 c4 08             	add    $0x8,%esp
    19ce:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    19d0:	8b 45 08             	mov    0x8(%ebp),%eax
    19d3:	8b 40 44             	mov    0x44(%eax),%eax
    19d6:	8d 4e 04             	lea    0x4(%esi),%ecx
    19d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    19dc:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19df:	53                   	push   %ebx
    19e0:	50                   	push   %eax
    19e1:	e8 1e f9 ff ff       	call   1304 <_shb>
    19e6:	83 c4 08             	add    $0x8,%esp
    19e9:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	8b 40 48             	mov    0x48(%eax),%eax
    19f1:	8d 4e 08             	lea    0x8(%esi),%ecx
    19f4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19f7:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19fa:	53                   	push   %ebx
    19fb:	50                   	push   %eax
    19fc:	e8 03 f9 ff ff       	call   1304 <_shb>
    1a01:	83 c4 08             	add    $0x8,%esp
    1a04:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    1a06:	8b 45 08             	mov    0x8(%ebp),%eax
    1a09:	8b 40 4c             	mov    0x4c(%eax),%eax
    1a0c:	8d 4e 0c             	lea    0xc(%esi),%ecx
    1a0f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a12:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a15:	53                   	push   %ebx
    1a16:	50                   	push   %eax
    1a17:	e8 e8 f8 ff ff       	call   1304 <_shb>
    1a1c:	83 c4 08             	add    $0x8,%esp
    1a1f:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    1a21:	8b 45 08             	mov    0x8(%ebp),%eax
    1a24:	8b 40 50             	mov    0x50(%eax),%eax
    1a27:	8d 4e 10             	lea    0x10(%esi),%ecx
    1a2a:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a2d:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a30:	53                   	push   %ebx
    1a31:	50                   	push   %eax
    1a32:	e8 cd f8 ff ff       	call   1304 <_shb>
    1a37:	83 c4 08             	add    $0x8,%esp
    1a3a:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    1a3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3f:	8b 40 54             	mov    0x54(%eax),%eax
    1a42:	8d 4e 14             	lea    0x14(%esi),%ecx
    1a45:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a48:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a4b:	53                   	push   %ebx
    1a4c:	50                   	push   %eax
    1a4d:	e8 b2 f8 ff ff       	call   1304 <_shb>
    1a52:	83 c4 08             	add    $0x8,%esp
    1a55:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    1a57:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5a:	8b 40 58             	mov    0x58(%eax),%eax
    1a5d:	8d 4e 18             	lea    0x18(%esi),%ecx
    1a60:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a63:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a66:	53                   	push   %ebx
    1a67:	50                   	push   %eax
    1a68:	e8 97 f8 ff ff       	call   1304 <_shb>
    1a6d:	83 c4 08             	add    $0x8,%esp
    1a70:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	8b 40 5c             	mov    0x5c(%eax),%eax
    1a78:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    1a7b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a7e:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a81:	53                   	push   %ebx
    1a82:	50                   	push   %eax
    1a83:	e8 7c f8 ff ff       	call   1304 <_shb>
    1a88:	83 c4 08             	add    $0x8,%esp
    1a8b:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1a8d:	83 c6 01             	add    $0x1,%esi
    1a90:	83 eb 08             	sub    $0x8,%ebx
    1a93:	83 fe 03             	cmp    $0x3,%esi
    1a96:	0f 86 1c ff ff ff    	jbe    19b8 <sha256_done+0x153>
            }
        }
    }
}
    1a9c:	90                   	nop
    1a9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1aa0:	5b                   	pop    %ebx
    1aa1:	5e                   	pop    %esi
    1aa2:	5f                   	pop    %edi
    1aa3:	5d                   	pop    %ebp
    1aa4:	c3                   	ret    

00001aa5 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    1aa5:	55                   	push   %ebp
    1aa6:	89 e5                	mov    %esp,%ebp
    1aa8:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1aab:	a1 08 2e 00 00       	mov    0x2e08,%eax
    1ab0:	83 ec 08             	sub    $0x8,%esp
    1ab3:	68 04 02 00 00       	push   $0x204
    1ab8:	50                   	push   %eax
    1ab9:	e8 7d e7 ff ff       	call   23b <open>
    1abe:	83 c4 10             	add    $0x10,%esp
    1ac1:	a3 40 2e 00 00       	mov    %eax,0x2e40

    int i = 0;
    1ac6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1acd:	eb 6f                	jmp    1b3e <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    1acf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad2:	83 e0 01             	and    $0x1,%eax
    1ad5:	85 c0                	test   %eax,%eax
    1ad7:	75 27                	jne    1b00 <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    1ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1adc:	89 c2                	mov    %eax,%edx
    1ade:	c1 ea 1f             	shr    $0x1f,%edx
    1ae1:	01 d0                	add    %edx,%eax
    1ae3:	d1 f8                	sar    %eax
    1ae5:	6b c0 64             	imul   $0x64,%eax,%eax
    1ae8:	8d 90 60 2e 00 00    	lea    0x2e60(%eax),%edx
    1aee:	83 ec 08             	sub    $0x8,%esp
    1af1:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1af4:	50                   	push   %eax
    1af5:	52                   	push   %edx
    1af6:	e8 ee e7 ff ff       	call   2e9 <strcpy>
    1afb:	83 c4 10             	add    $0x10,%esp
    1afe:	eb 27                	jmp    1b27 <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b03:	89 c2                	mov    %eax,%edx
    1b05:	c1 ea 1f             	shr    $0x1f,%edx
    1b08:	01 d0                	add    %edx,%eax
    1b0a:	d1 f8                	sar    %eax
    1b0c:	6b c0 64             	imul   $0x64,%eax,%eax
    1b0f:	8d 90 a0 2d 64 00    	lea    0x642da0(%eax),%edx
    1b15:	83 ec 04             	sub    $0x4,%esp
    1b18:	6a 64                	push   $0x64
    1b1a:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1b1d:	50                   	push   %eax
    1b1e:	52                   	push   %edx
    1b1f:	e8 b1 e9 ff ff       	call   4d5 <memmove>
    1b24:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1b27:	83 ec 04             	sub    $0x4,%esp
    1b2a:	6a 64                	push   $0x64
    1b2c:	6a 00                	push   $0x0
    1b2e:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1b31:	50                   	push   %eax
    1b32:	e8 48 e8 ff ff       	call   37f <memset>
    1b37:	83 c4 10             	add    $0x10,%esp
        i++;
    1b3a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1b3e:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1b43:	83 ec 04             	sub    $0x4,%esp
    1b46:	6a 64                	push   $0x64
    1b48:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1b4b:	52                   	push   %edx
    1b4c:	50                   	push   %eax
    1b4d:	e8 c1 e6 ff ff       	call   213 <read>
    1b52:	83 c4 10             	add    $0x10,%esp
    1b55:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b5c:	0f 8f 6d ff ff ff    	jg     1acf <read_info+0x2a>
    }

    num_users = i / 2;
    1b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b65:	89 c2                	mov    %eax,%edx
    1b67:	c1 ea 1f             	shr    $0x1f,%edx
    1b6a:	01 d0                	add    %edx,%eax
    1b6c:	d1 f8                	sar    %eax
    1b6e:	a3 44 2e 00 00       	mov    %eax,0x2e44

    if (n < 0) {
    1b73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b77:	79 17                	jns    1b90 <read_info+0xeb>
        printf(1, "cat: read error\n");
    1b79:	83 ec 08             	sub    $0x8,%esp
    1b7c:	68 0b 26 00 00       	push   $0x260b
    1b81:	6a 01                	push   $0x1
    1b83:	e8 83 ec ff ff       	call   80b <printf>
    1b88:	83 c4 10             	add    $0x10,%esp
        exit();
    1b8b:	e8 6b e6 ff ff       	call   1fb <exit>
    }
}
    1b90:	90                   	nop
    1b91:	c9                   	leave  
    1b92:	c3                   	ret    

00001b93 <writeback>:

void writeback() {
    1b93:	55                   	push   %ebp
    1b94:	89 e5                	mov    %esp,%ebp
    1b96:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1b99:	a1 08 2e 00 00       	mov    0x2e08,%eax
    1b9e:	83 ec 08             	sub    $0x8,%esp
    1ba1:	68 04 02 00 00       	push   $0x204
    1ba6:	50                   	push   %eax
    1ba7:	e8 8f e6 ff ff       	call   23b <open>
    1bac:	83 c4 10             	add    $0x10,%esp
    1baf:	a3 40 2e 00 00       	mov    %eax,0x2e40
    for (int i = 0; i < num_users; i++) {
    1bb4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bbb:	eb 44                	jmp    1c01 <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc0:	6b c0 64             	imul   $0x64,%eax,%eax
    1bc3:	8d 90 60 2e 00 00    	lea    0x2e60(%eax),%edx
    1bc9:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1bce:	83 ec 04             	sub    $0x4,%esp
    1bd1:	6a 64                	push   $0x64
    1bd3:	52                   	push   %edx
    1bd4:	50                   	push   %eax
    1bd5:	e8 41 e6 ff ff       	call   21b <write>
    1bda:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1be0:	6b c0 64             	imul   $0x64,%eax,%eax
    1be3:	8d 90 a0 2d 64 00    	lea    0x642da0(%eax),%edx
    1be9:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1bee:	83 ec 04             	sub    $0x4,%esp
    1bf1:	6a 64                	push   $0x64
    1bf3:	52                   	push   %edx
    1bf4:	50                   	push   %eax
    1bf5:	e8 21 e6 ff ff       	call   21b <write>
    1bfa:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1bfd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c01:	a1 44 2e 00 00       	mov    0x2e44,%eax
    1c06:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1c09:	7c b2                	jl     1bbd <writeback+0x2a>
    }
    close(fd);
    1c0b:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1c10:	83 ec 0c             	sub    $0xc,%esp
    1c13:	50                   	push   %eax
    1c14:	e8 0a e6 ff ff       	call   223 <close>
    1c19:	83 c4 10             	add    $0x10,%esp
}
    1c1c:	90                   	nop
    1c1d:	c9                   	leave  
    1c1e:	c3                   	ret    

00001c1f <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1c1f:	55                   	push   %ebp
    1c20:	89 e5                	mov    %esp,%ebp
    1c22:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1c28:	83 ec 08             	sub    $0x8,%esp
    1c2b:	68 1c 26 00 00       	push   $0x261c
    1c30:	68 60 2e 00 00       	push   $0x2e60
    1c35:	e8 af e6 ff ff       	call   2e9 <strcpy>
    1c3a:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1c3d:	c7 45 f4 21 26 00 00 	movl   $0x2621,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1c44:	83 ec 08             	sub    $0x8,%esp
    1c47:	ff 75 f4             	push   -0xc(%ebp)
    1c4a:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c50:	50                   	push   %eax
    1c51:	e8 93 e6 ff ff       	call   2e9 <strcpy>
    1c56:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1c59:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1c60:	83 ec 0c             	sub    $0xc,%esp
    1c63:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c69:	50                   	push   %eax
    1c6a:	e8 e8 fa ff ff       	call   1757 <sha256_init>
    1c6f:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1c72:	83 ec 0c             	sub    $0xc,%esp
    1c75:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c7b:	50                   	push   %eax
    1c7c:	e8 d7 e6 ff ff       	call   358 <strlen>
    1c81:	83 c4 10             	add    $0x10,%esp
    1c84:	83 ec 04             	sub    $0x4,%esp
    1c87:	50                   	push   %eax
    1c88:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c8e:	50                   	push   %eax
    1c8f:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c95:	50                   	push   %eax
    1c96:	e8 3a fb ff ff       	call   17d5 <sha256_hash>
    1c9b:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1c9e:	83 ec 08             	sub    $0x8,%esp
    1ca1:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1ca7:	50                   	push   %eax
    1ca8:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1cae:	50                   	push   %eax
    1caf:	e8 b1 fb ff ff       	call   1865 <sha256_done>
    1cb4:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1cb7:	83 ec 04             	sub    $0x4,%esp
    1cba:	6a 64                	push   $0x64
    1cbc:	6a 00                	push   $0x0
    1cbe:	68 a0 2d 64 00       	push   $0x642da0
    1cc3:	e8 b7 e6 ff ff       	call   37f <memset>
    1cc8:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1ccb:	83 ec 04             	sub    $0x4,%esp
    1cce:	6a 20                	push   $0x20
    1cd0:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1cd6:	50                   	push   %eax
    1cd7:	68 a0 2d 64 00       	push   $0x642da0
    1cdc:	e8 f4 e7 ff ff       	call   4d5 <memmove>
    1ce1:	83 c4 10             	add    $0x10,%esp

    read_info();
    1ce4:	e8 bc fd ff ff       	call   1aa5 <read_info>
    fd = open(SECRETS, O_RDWR);
    1ce9:	a1 08 2e 00 00       	mov    0x2e08,%eax
    1cee:	83 ec 08             	sub    $0x8,%esp
    1cf1:	6a 04                	push   $0x4
    1cf3:	50                   	push   %eax
    1cf4:	e8 42 e5 ff ff       	call   23b <open>
    1cf9:	83 c4 10             	add    $0x10,%esp
    1cfc:	a3 40 2e 00 00       	mov    %eax,0x2e40
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1d01:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1d06:	83 ec 04             	sub    $0x4,%esp
    1d09:	6a 64                	push   $0x64
    1d0b:	68 60 2e 00 00       	push   $0x2e60
    1d10:	50                   	push   %eax
    1d11:	e8 05 e5 ff ff       	call   21b <write>
    1d16:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1d19:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1d1e:	83 ec 04             	sub    $0x4,%esp
    1d21:	6a 64                	push   $0x64
    1d23:	68 a0 2d 64 00       	push   $0x642da0
    1d28:	50                   	push   %eax
    1d29:	e8 ed e4 ff ff       	call   21b <write>
    1d2e:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1d31:	a1 40 2e 00 00       	mov    0x2e40,%eax
    1d36:	83 ec 0c             	sub    $0xc,%esp
    1d39:	50                   	push   %eax
    1d3a:	e8 e4 e4 ff ff       	call   223 <close>
    1d3f:	83 c4 10             	add    $0x10,%esp
}
    1d42:	90                   	nop
    1d43:	c9                   	leave  
    1d44:	c3                   	ret    

00001d45 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1d45:	55                   	push   %ebp
    1d46:	89 e5                	mov    %esp,%ebp
    1d48:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1d4b:	e8 55 fd ff ff       	call   1aa5 <read_info>

    for (int i = 0; i < num_users; i++) {
    1d50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d57:	eb 29                	jmp    1d82 <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d5c:	6b c0 64             	imul   $0x64,%eax,%eax
    1d5f:	05 60 2e 00 00       	add    $0x2e60,%eax
    1d64:	83 ec 08             	sub    $0x8,%esp
    1d67:	50                   	push   %eax
    1d68:	ff 75 08             	push   0x8(%ebp)
    1d6b:	e8 a9 e5 ff ff       	call   319 <strcmp>
    1d70:	83 c4 10             	add    $0x10,%esp
    1d73:	85 c0                	test   %eax,%eax
    1d75:	75 07                	jne    1d7e <does_user_exist+0x39>
            return 0;
    1d77:	b8 00 00 00 00       	mov    $0x0,%eax
    1d7c:	eb 13                	jmp    1d91 <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1d7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d82:	a1 44 2e 00 00       	mov    0x2e44,%eax
    1d87:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1d8a:	7c cd                	jl     1d59 <does_user_exist+0x14>
        }
    }
    return -1;
    1d8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d91:	c9                   	leave  
    1d92:	c3                   	ret    

00001d93 <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1d93:	55                   	push   %ebp
    1d94:	89 e5                	mov    %esp,%ebp
    1d96:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1d9c:	e8 04 fd ff ff       	call   1aa5 <read_info>

    int open = -1;
    1da1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1da8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1daf:	eb 46                	jmp    1df7 <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1db1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1db4:	6b c0 64             	imul   $0x64,%eax,%eax
    1db7:	05 60 2e 00 00       	add    $0x2e60,%eax
    1dbc:	83 ec 08             	sub    $0x8,%esp
    1dbf:	50                   	push   %eax
    1dc0:	ff 75 08             	push   0x8(%ebp)
    1dc3:	e8 51 e5 ff ff       	call   319 <strcmp>
    1dc8:	83 c4 10             	add    $0x10,%esp
    1dcb:	85 c0                	test   %eax,%eax
    1dcd:	75 0a                	jne    1dd9 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1dcf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1dd4:	e9 18 01 00 00       	jmp    1ef1 <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ddc:	6b c0 64             	imul   $0x64,%eax,%eax
    1ddf:	05 60 2e 00 00       	add    $0x2e60,%eax
    1de4:	0f b6 00             	movzbl (%eax),%eax
    1de7:	84 c0                	test   %al,%al
    1de9:	75 08                	jne    1df3 <create_user+0x60>
            open = i;
    1deb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dee:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1df1:	eb 0d                	jmp    1e00 <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1df3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1df7:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1dfe:	7e b1                	jle    1db1 <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1e00:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1e04:	0f 84 e2 00 00 00    	je     1eec <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1e0a:	83 ec 08             	sub    $0x8,%esp
    1e0d:	ff 75 0c             	push   0xc(%ebp)
    1e10:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1e16:	50                   	push   %eax
    1e17:	e8 cd e4 ff ff       	call   2e9 <strcpy>
    1e1c:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1e1f:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1e26:	83 ec 0c             	sub    $0xc,%esp
    1e29:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1e2f:	50                   	push   %eax
    1e30:	e8 22 f9 ff ff       	call   1757 <sha256_init>
    1e35:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1e38:	83 ec 0c             	sub    $0xc,%esp
    1e3b:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1e41:	50                   	push   %eax
    1e42:	e8 11 e5 ff ff       	call   358 <strlen>
    1e47:	83 c4 10             	add    $0x10,%esp
    1e4a:	83 ec 04             	sub    $0x4,%esp
    1e4d:	50                   	push   %eax
    1e4e:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1e54:	50                   	push   %eax
    1e55:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1e5b:	50                   	push   %eax
    1e5c:	e8 74 f9 ff ff       	call   17d5 <sha256_hash>
    1e61:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1e64:	83 ec 08             	sub    $0x8,%esp
    1e67:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1e6d:	50                   	push   %eax
    1e6e:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1e74:	50                   	push   %eax
    1e75:	e8 eb f9 ff ff       	call   1865 <sha256_done>
    1e7a:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1e7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e80:	6b c0 64             	imul   $0x64,%eax,%eax
    1e83:	05 60 2e 00 00       	add    $0x2e60,%eax
    1e88:	83 ec 08             	sub    $0x8,%esp
    1e8b:	ff 75 08             	push   0x8(%ebp)
    1e8e:	50                   	push   %eax
    1e8f:	e8 55 e4 ff ff       	call   2e9 <strcpy>
    1e94:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1e97:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e9a:	6b c0 64             	imul   $0x64,%eax,%eax
    1e9d:	05 a0 2d 64 00       	add    $0x642da0,%eax
    1ea2:	83 ec 04             	sub    $0x4,%esp
    1ea5:	6a 64                	push   $0x64
    1ea7:	6a 00                	push   $0x0
    1ea9:	50                   	push   %eax
    1eaa:	e8 d0 e4 ff ff       	call   37f <memset>
    1eaf:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    1eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb5:	6b c0 64             	imul   $0x64,%eax,%eax
    1eb8:	8d 90 a0 2d 64 00    	lea    0x642da0(%eax),%edx
    1ebe:	83 ec 04             	sub    $0x4,%esp
    1ec1:	6a 20                	push   $0x20
    1ec3:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1ec9:	50                   	push   %eax
    1eca:	52                   	push   %edx
    1ecb:	e8 05 e6 ff ff       	call   4d5 <memmove>
    1ed0:	83 c4 10             	add    $0x10,%esp

        num_users++;
    1ed3:	a1 44 2e 00 00       	mov    0x2e44,%eax
    1ed8:	83 c0 01             	add    $0x1,%eax
    1edb:	a3 44 2e 00 00       	mov    %eax,0x2e44
        writeback();
    1ee0:	e8 ae fc ff ff       	call   1b93 <writeback>
        return 0;
    1ee5:	b8 00 00 00 00       	mov    $0x0,%eax
    1eea:	eb 05                	jmp    1ef1 <create_user+0x15e>
    }

    return -1;
    1eec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ef1:	c9                   	leave  
    1ef2:	c3                   	ret    

00001ef3 <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    1ef3:	55                   	push   %ebp
    1ef4:	89 e5                	mov    %esp,%ebp
    1ef6:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    1efc:	e8 a4 fb ff ff       	call   1aa5 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    1f01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f08:	e9 7b 01 00 00       	jmp    2088 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    1f0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f10:	6b c0 64             	imul   $0x64,%eax,%eax
    1f13:	05 60 2e 00 00       	add    $0x2e60,%eax
    1f18:	83 ec 08             	sub    $0x8,%esp
    1f1b:	50                   	push   %eax
    1f1c:	ff 75 08             	push   0x8(%ebp)
    1f1f:	e8 f5 e3 ff ff       	call   319 <strcmp>
    1f24:	83 c4 10             	add    $0x10,%esp
    1f27:	85 c0                	test   %eax,%eax
    1f29:	0f 85 55 01 00 00    	jne    2084 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    1f2f:	83 ec 08             	sub    $0x8,%esp
    1f32:	ff 75 0c             	push   0xc(%ebp)
    1f35:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1f3b:	50                   	push   %eax
    1f3c:	e8 a8 e3 ff ff       	call   2e9 <strcpy>
    1f41:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    1f44:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    1f4b:	83 ec 0c             	sub    $0xc,%esp
    1f4e:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f54:	50                   	push   %eax
    1f55:	e8 fd f7 ff ff       	call   1757 <sha256_init>
    1f5a:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    1f5d:	83 ec 0c             	sub    $0xc,%esp
    1f60:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1f66:	50                   	push   %eax
    1f67:	e8 ec e3 ff ff       	call   358 <strlen>
    1f6c:	83 c4 10             	add    $0x10,%esp
    1f6f:	83 ec 04             	sub    $0x4,%esp
    1f72:	50                   	push   %eax
    1f73:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1f79:	50                   	push   %eax
    1f7a:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f80:	50                   	push   %eax
    1f81:	e8 4f f8 ff ff       	call   17d5 <sha256_hash>
    1f86:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    1f89:	83 ec 08             	sub    $0x8,%esp
    1f8c:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    1f92:	50                   	push   %eax
    1f93:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f99:	50                   	push   %eax
    1f9a:	e8 c6 f8 ff ff       	call   1865 <sha256_done>
    1f9f:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    1fa2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1fa9:	eb 34                	jmp    1fdf <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    1fab:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    1fb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fb4:	01 d0                	add    %edx,%eax
    1fb6:	0f b6 00             	movzbl (%eax),%eax
    1fb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1fbc:	6b ca 64             	imul   $0x64,%edx,%ecx
    1fbf:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1fc2:	01 ca                	add    %ecx,%edx
    1fc4:	81 c2 a0 2d 64 00    	add    $0x642da0,%edx
    1fca:	0f b6 12             	movzbl (%edx),%edx
    1fcd:	38 d0                	cmp    %dl,%al
    1fcf:	74 0a                	je     1fdb <login_user+0xe8>
                    return -1;
    1fd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1fd6:	e9 bf 00 00 00       	jmp    209a <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    1fdb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1fdf:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    1fe3:	7e c6                	jle    1fab <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    1fe5:	83 ec 08             	sub    $0x8,%esp
    1fe8:	68 27 26 00 00       	push   $0x2627
    1fed:	6a 01                	push   $0x1
    1fef:	e8 17 e8 ff ff       	call   80b <printf>
    1ff4:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    1ff7:	e8 f7 e1 ff ff       	call   1f3 <fork>
    1ffc:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    1fff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2003:	79 17                	jns    201c <login_user+0x129>
                printf(1, "init: fork failed\n");
    2005:	83 ec 08             	sub    $0x8,%esp
    2008:	68 3a 26 00 00       	push   $0x263a
    200d:	6a 01                	push   $0x1
    200f:	e8 f7 e7 ff ff       	call   80b <printf>
    2014:	83 c4 10             	add    $0x10,%esp
                exit();
    2017:	e8 df e1 ff ff       	call   1fb <exit>
            }
            if (pid == 0) {
    201c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2020:	75 4c                	jne    206e <login_user+0x17b>
                setuid(i);
    2022:	83 ec 0c             	sub    $0xc,%esp
    2025:	ff 75 f4             	push   -0xc(%ebp)
    2028:	e8 6e e2 ff ff       	call   29b <setuid>
    202d:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    2030:	83 ec 08             	sub    $0x8,%esp
    2033:	68 0c 2e 00 00       	push   $0x2e0c
    2038:	68 08 26 00 00       	push   $0x2608
    203d:	e8 f1 e1 ff ff       	call   233 <exec>
    2042:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    2045:	83 ec 08             	sub    $0x8,%esp
    2048:	68 4d 26 00 00       	push   $0x264d
    204d:	6a 01                	push   $0x1
    204f:	e8 b7 e7 ff ff       	call   80b <printf>
    2054:	83 c4 10             	add    $0x10,%esp
                exit();
    2057:	e8 9f e1 ff ff       	call   1fb <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    205c:	83 ec 08             	sub    $0x8,%esp
    205f:	68 63 26 00 00       	push   $0x2663
    2064:	6a 01                	push   $0x1
    2066:	e8 a0 e7 ff ff       	call   80b <printf>
    206b:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    206e:	e8 90 e1 ff ff       	call   203 <wait>
    2073:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2076:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    207a:	78 08                	js     2084 <login_user+0x191>
    207c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    207f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2082:	75 d8                	jne    205c <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    2084:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2088:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    208f:	0f 8e 78 fe ff ff    	jle    1f0d <login_user+0x1a>
        }
    }

    return -1;
    2095:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    209a:	c9                   	leave  
    209b:	c3                   	ret    
