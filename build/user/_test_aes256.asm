
_test_aes256:     file format elf32-i386


Disassembly of section .text:

00000000 <aes256_decrypt>:
 * 
 * @param key Symmetric key. Byte array of size AES256_KEY_SIZE_BYTES.
 * @param buf Data to encrypt. Byte array (either char or uchar) of size len.
 * @param len The length of the data to encrypt
 */
static inline void aes256_decrypt(uchar* key, void* buf, uint len) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
    aes256_encrypt(key, buf, len);
       6:	83 ec 04             	sub    $0x4,%esp
       9:	ff 75 10             	push   0x10(%ebp)
       c:	ff 75 0c             	push   0xc(%ebp)
       f:	ff 75 08             	push   0x8(%ebp)
      12:	e8 d9 0f 00 00       	call   ff0 <aes256_encrypt>
      17:	83 c4 10             	add    $0x10,%esp
}
      1a:	90                   	nop
      1b:	c9                   	leave  
      1c:	c3                   	ret    

0000001d <main>:
static const uchar expected_encrypted_buf[] = {
    0xEB, 0x6C, 0x52, 0x82, 0x1D, 0x0B, 0xBB, 0xF7, 0xCE, 0x75, 0x94, 0x46,
    0x2A, 0xCA, 0x4F, 0xAA, 0xB4, 0x07, 0xDF, 0x86, 0x65, 0x69, 0xFD, 0x07,
    0xF4, 0x8C, 0xC0, 0xB5, 0x83, 0xD6, 0x07, 0x1F, 0x1E, 0xC0, 0xE6, 0xB8};

int main(int argc, char* argv[]) {
      1d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      21:	83 e4 f0             	and    $0xfffffff0,%esp
      24:	ff 71 fc             	push   -0x4(%ecx)
      27:	55                   	push   %ebp
      28:	89 e5                	mov    %esp,%ebp
      2a:	51                   	push   %ecx
      2b:	83 ec 34             	sub    $0x34,%esp
    uchar buf[sizeof(expected_buf)];

    printf(1, "test_aes256: begin\n");
      2e:	83 ec 08             	sub    $0x8,%esp
      31:	68 84 20 00 00       	push   $0x2084
      36:	6a 01                	push   $0x1
      38:	e8 4e 07 00 00       	call   78b <printf>
      3d:	83 c4 10             	add    $0x10,%esp

    for (uint i = 0; i < sizeof(buf); i++) {
      40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      47:	eb 19                	jmp    62 <main+0x45>
        buf[i] = expected_buf[i];
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	05 20 20 00 00       	add    $0x2020,%eax
      51:	0f b6 00             	movzbl (%eax),%eax
      54:	8d 4d d0             	lea    -0x30(%ebp),%ecx
      57:	8b 55 f4             	mov    -0xc(%ebp),%edx
      5a:	01 ca                	add    %ecx,%edx
      5c:	88 02                	mov    %al,(%edx)
    for (uint i = 0; i < sizeof(buf); i++) {
      5e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      62:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
      66:	76 e1                	jbe    49 <main+0x2c>
    }

    assert_equal(buf, expected_buf, sizeof(buf), "initial plaintext");
      68:	68 98 20 00 00       	push   $0x2098
      6d:	6a 24                	push   $0x24
      6f:	68 20 20 00 00       	push   $0x2020
      74:	8d 45 d0             	lea    -0x30(%ebp),%eax
      77:	50                   	push   %eax
      78:	e8 76 00 00 00       	call   f3 <assert_equal>
      7d:	83 c4 10             	add    $0x10,%esp

    // encrypt data in buf using key
    aes256_encrypt(key, buf, sizeof(buf));
      80:	83 ec 04             	sub    $0x4,%esp
      83:	6a 24                	push   $0x24
      85:	8d 45 d0             	lea    -0x30(%ebp),%eax
      88:	50                   	push   %eax
      89:	68 60 2b 00 00       	push   $0x2b60
      8e:	e8 5d 0f 00 00       	call   ff0 <aes256_encrypt>
      93:	83 c4 10             	add    $0x10,%esp
    assert_equal(buf, expected_encrypted_buf, sizeof(buf), "encrypted buf");
      96:	68 aa 20 00 00       	push   $0x20aa
      9b:	6a 24                	push   $0x24
      9d:	68 60 20 00 00       	push   $0x2060
      a2:	8d 45 d0             	lea    -0x30(%ebp),%eax
      a5:	50                   	push   %eax
      a6:	e8 48 00 00 00       	call   f3 <assert_equal>
      ab:	83 c4 10             	add    $0x10,%esp

    // decrypt data in buf using key
    aes256_decrypt(key, buf, sizeof(buf));
      ae:	83 ec 04             	sub    $0x4,%esp
      b1:	6a 24                	push   $0x24
      b3:	8d 45 d0             	lea    -0x30(%ebp),%eax
      b6:	50                   	push   %eax
      b7:	68 60 2b 00 00       	push   $0x2b60
      bc:	e8 3f ff ff ff       	call   0 <aes256_decrypt>
      c1:	83 c4 10             	add    $0x10,%esp
    assert_equal(buf, expected_buf, sizeof(buf), "decrypted buf");
      c4:	68 b8 20 00 00       	push   $0x20b8
      c9:	6a 24                	push   $0x24
      cb:	68 20 20 00 00       	push   $0x2020
      d0:	8d 45 d0             	lea    -0x30(%ebp),%eax
      d3:	50                   	push   %eax
      d4:	e8 1a 00 00 00       	call   f3 <assert_equal>
      d9:	83 c4 10             	add    $0x10,%esp

    printf(1, "test_aes256: pass\n");
      dc:	83 ec 08             	sub    $0x8,%esp
      df:	68 c6 20 00 00       	push   $0x20c6
      e4:	6a 01                	push   $0x1
      e6:	e8 a0 06 00 00       	call   78b <printf>
      eb:	83 c4 10             	add    $0x10,%esp
    exit();
      ee:	e8 88 00 00 00       	call   17b <exit>

000000f3 <assert_equal>:
}

static void assert_equal(const void* actual, const void* expected, uint len,
                         const char* err) {
      f3:	55                   	push   %ebp
      f4:	89 e5                	mov    %esp,%ebp
      f6:	83 ec 18             	sub    $0x18,%esp
    const uchar* actual_bytes = (const uchar*) actual;
      f9:	8b 45 08             	mov    0x8(%ebp),%eax
      fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    const uchar* expected_bytes = (const uchar*) expected;
      ff:	8b 45 0c             	mov    0xc(%ebp),%eax
     102:	89 45 ec             	mov    %eax,-0x14(%ebp)

    for (uint i = 0; i < len; i++) {
     105:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     10c:	eb 59                	jmp    167 <assert_equal+0x74>
        if (actual_bytes[i] != expected_bytes[i]) {
     10e:	8b 55 f0             	mov    -0x10(%ebp),%edx
     111:	8b 45 f4             	mov    -0xc(%ebp),%eax
     114:	01 d0                	add    %edx,%eax
     116:	0f b6 10             	movzbl (%eax),%edx
     119:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     11c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     11f:	01 c8                	add    %ecx,%eax
     121:	0f b6 00             	movzbl (%eax),%eax
     124:	38 c2                	cmp    %al,%dl
     126:	74 3b                	je     163 <assert_equal+0x70>
            printf(
                2,
                "test_aes256: fail on %s! mismatch byte %d, expected 0x%x but "
                "got 0x%x\n",
                err, i, expected_bytes[i], actual_bytes[i]);
     128:	8b 55 f0             	mov    -0x10(%ebp),%edx
     12b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     12e:	01 d0                	add    %edx,%eax
     130:	0f b6 00             	movzbl (%eax),%eax
            printf(
     133:	0f b6 d0             	movzbl %al,%edx
                err, i, expected_bytes[i], actual_bytes[i]);
     136:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     139:	8b 45 f4             	mov    -0xc(%ebp),%eax
     13c:	01 c8                	add    %ecx,%eax
     13e:	0f b6 00             	movzbl (%eax),%eax
            printf(
     141:	0f b6 c0             	movzbl %al,%eax
     144:	83 ec 08             	sub    $0x8,%esp
     147:	52                   	push   %edx
     148:	50                   	push   %eax
     149:	ff 75 f4             	push   -0xc(%ebp)
     14c:	ff 75 14             	push   0x14(%ebp)
     14f:	68 dc 20 00 00       	push   $0x20dc
     154:	6a 02                	push   $0x2
     156:	e8 30 06 00 00       	call   78b <printf>
     15b:	83 c4 20             	add    $0x20,%esp
            exit();
     15e:	e8 18 00 00 00       	call   17b <exit>
    for (uint i = 0; i < len; i++) {
     163:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     167:	8b 45 f4             	mov    -0xc(%ebp),%eax
     16a:	3b 45 10             	cmp    0x10(%ebp),%eax
     16d:	72 9f                	jb     10e <assert_equal+0x1b>
        }
    }
}
     16f:	90                   	nop
     170:	90                   	nop
     171:	c9                   	leave  
     172:	c3                   	ret    

00000173 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     173:	b8 01 00 00 00       	mov    $0x1,%eax
     178:	cd 40                	int    $0x40
     17a:	c3                   	ret    

0000017b <exit>:
SYSCALL(exit)
     17b:	b8 02 00 00 00       	mov    $0x2,%eax
     180:	cd 40                	int    $0x40
     182:	c3                   	ret    

00000183 <wait>:
SYSCALL(wait)
     183:	b8 03 00 00 00       	mov    $0x3,%eax
     188:	cd 40                	int    $0x40
     18a:	c3                   	ret    

0000018b <pipe>:
SYSCALL(pipe)
     18b:	b8 04 00 00 00       	mov    $0x4,%eax
     190:	cd 40                	int    $0x40
     192:	c3                   	ret    

00000193 <read>:
SYSCALL(read)
     193:	b8 05 00 00 00       	mov    $0x5,%eax
     198:	cd 40                	int    $0x40
     19a:	c3                   	ret    

0000019b <write>:
SYSCALL(write)
     19b:	b8 10 00 00 00       	mov    $0x10,%eax
     1a0:	cd 40                	int    $0x40
     1a2:	c3                   	ret    

000001a3 <close>:
SYSCALL(close)
     1a3:	b8 15 00 00 00       	mov    $0x15,%eax
     1a8:	cd 40                	int    $0x40
     1aa:	c3                   	ret    

000001ab <kill>:
SYSCALL(kill)
     1ab:	b8 06 00 00 00       	mov    $0x6,%eax
     1b0:	cd 40                	int    $0x40
     1b2:	c3                   	ret    

000001b3 <exec>:
SYSCALL(exec)
     1b3:	b8 07 00 00 00       	mov    $0x7,%eax
     1b8:	cd 40                	int    $0x40
     1ba:	c3                   	ret    

000001bb <open>:
SYSCALL(open)
     1bb:	b8 0f 00 00 00       	mov    $0xf,%eax
     1c0:	cd 40                	int    $0x40
     1c2:	c3                   	ret    

000001c3 <mknod>:
SYSCALL(mknod)
     1c3:	b8 11 00 00 00       	mov    $0x11,%eax
     1c8:	cd 40                	int    $0x40
     1ca:	c3                   	ret    

000001cb <unlink>:
SYSCALL(unlink)
     1cb:	b8 12 00 00 00       	mov    $0x12,%eax
     1d0:	cd 40                	int    $0x40
     1d2:	c3                   	ret    

000001d3 <fstat>:
SYSCALL(fstat)
     1d3:	b8 08 00 00 00       	mov    $0x8,%eax
     1d8:	cd 40                	int    $0x40
     1da:	c3                   	ret    

000001db <link>:
SYSCALL(link)
     1db:	b8 13 00 00 00       	mov    $0x13,%eax
     1e0:	cd 40                	int    $0x40
     1e2:	c3                   	ret    

000001e3 <mkdir>:
SYSCALL(mkdir)
     1e3:	b8 14 00 00 00       	mov    $0x14,%eax
     1e8:	cd 40                	int    $0x40
     1ea:	c3                   	ret    

000001eb <chdir>:
SYSCALL(chdir)
     1eb:	b8 09 00 00 00       	mov    $0x9,%eax
     1f0:	cd 40                	int    $0x40
     1f2:	c3                   	ret    

000001f3 <dup>:
SYSCALL(dup)
     1f3:	b8 0a 00 00 00       	mov    $0xa,%eax
     1f8:	cd 40                	int    $0x40
     1fa:	c3                   	ret    

000001fb <getpid>:
SYSCALL(getpid)
     1fb:	b8 0b 00 00 00       	mov    $0xb,%eax
     200:	cd 40                	int    $0x40
     202:	c3                   	ret    

00000203 <sbrk>:
SYSCALL(sbrk)
     203:	b8 0c 00 00 00       	mov    $0xc,%eax
     208:	cd 40                	int    $0x40
     20a:	c3                   	ret    

0000020b <sleep>:
SYSCALL(sleep)
     20b:	b8 0d 00 00 00       	mov    $0xd,%eax
     210:	cd 40                	int    $0x40
     212:	c3                   	ret    

00000213 <uptime>:
SYSCALL(uptime)
     213:	b8 0e 00 00 00       	mov    $0xe,%eax
     218:	cd 40                	int    $0x40
     21a:	c3                   	ret    

0000021b <setuid>:
SYSCALL(setuid)
     21b:	b8 16 00 00 00       	mov    $0x16,%eax
     220:	cd 40                	int    $0x40
     222:	c3                   	ret    

00000223 <getuid>:
SYSCALL(getuid)
     223:	b8 19 00 00 00       	mov    $0x19,%eax
     228:	cd 40                	int    $0x40
     22a:	c3                   	ret    

0000022b <chown>:
SYSCALL(chown)
     22b:	b8 18 00 00 00       	mov    $0x18,%eax
     230:	cd 40                	int    $0x40
     232:	c3                   	ret    

00000233 <chmod>:
SYSCALL(chmod)
     233:	b8 17 00 00 00       	mov    $0x17,%eax
     238:	cd 40                	int    $0x40
     23a:	c3                   	ret    

0000023b <report_stats>:
SYSCALL(report_stats)
     23b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     240:	cd 40                	int    $0x40
     242:	c3                   	ret    

00000243 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     243:	55                   	push   %ebp
     244:	89 e5                	mov    %esp,%ebp
     246:	57                   	push   %edi
     247:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     248:	8b 4d 08             	mov    0x8(%ebp),%ecx
     24b:	8b 55 10             	mov    0x10(%ebp),%edx
     24e:	8b 45 0c             	mov    0xc(%ebp),%eax
     251:	89 cb                	mov    %ecx,%ebx
     253:	89 df                	mov    %ebx,%edi
     255:	89 d1                	mov    %edx,%ecx
     257:	fc                   	cld    
     258:	f3 aa                	rep stos %al,%es:(%edi)
     25a:	89 ca                	mov    %ecx,%edx
     25c:	89 fb                	mov    %edi,%ebx
     25e:	89 5d 08             	mov    %ebx,0x8(%ebp)
     261:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     264:	90                   	nop
     265:	5b                   	pop    %ebx
     266:	5f                   	pop    %edi
     267:	5d                   	pop    %ebp
     268:	c3                   	ret    

00000269 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     269:	55                   	push   %ebp
     26a:	89 e5                	mov    %esp,%ebp
     26c:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     26f:	8b 45 08             	mov    0x8(%ebp),%eax
     272:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     275:	90                   	nop
     276:	8b 55 0c             	mov    0xc(%ebp),%edx
     279:	8d 42 01             	lea    0x1(%edx),%eax
     27c:	89 45 0c             	mov    %eax,0xc(%ebp)
     27f:	8b 45 08             	mov    0x8(%ebp),%eax
     282:	8d 48 01             	lea    0x1(%eax),%ecx
     285:	89 4d 08             	mov    %ecx,0x8(%ebp)
     288:	0f b6 12             	movzbl (%edx),%edx
     28b:	88 10                	mov    %dl,(%eax)
     28d:	0f b6 00             	movzbl (%eax),%eax
     290:	84 c0                	test   %al,%al
     292:	75 e2                	jne    276 <strcpy+0xd>
        ;
    return os;
     294:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     297:	c9                   	leave  
     298:	c3                   	ret    

00000299 <strcmp>:

int strcmp(const char* p, const char* q) {
     299:	55                   	push   %ebp
     29a:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     29c:	eb 08                	jmp    2a6 <strcmp+0xd>
     29e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2a2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     2a6:	8b 45 08             	mov    0x8(%ebp),%eax
     2a9:	0f b6 00             	movzbl (%eax),%eax
     2ac:	84 c0                	test   %al,%al
     2ae:	74 10                	je     2c0 <strcmp+0x27>
     2b0:	8b 45 08             	mov    0x8(%ebp),%eax
     2b3:	0f b6 10             	movzbl (%eax),%edx
     2b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b9:	0f b6 00             	movzbl (%eax),%eax
     2bc:	38 c2                	cmp    %al,%dl
     2be:	74 de                	je     29e <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     2c0:	8b 45 08             	mov    0x8(%ebp),%eax
     2c3:	0f b6 00             	movzbl (%eax),%eax
     2c6:	0f b6 d0             	movzbl %al,%edx
     2c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     2cc:	0f b6 00             	movzbl (%eax),%eax
     2cf:	0f b6 c8             	movzbl %al,%ecx
     2d2:	89 d0                	mov    %edx,%eax
     2d4:	29 c8                	sub    %ecx,%eax
}
     2d6:	5d                   	pop    %ebp
     2d7:	c3                   	ret    

000002d8 <strlen>:

uint strlen(const char* s) {
     2d8:	55                   	push   %ebp
     2d9:	89 e5                	mov    %esp,%ebp
     2db:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     2de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     2e5:	eb 04                	jmp    2eb <strlen+0x13>
     2e7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     2eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2ee:	8b 45 08             	mov    0x8(%ebp),%eax
     2f1:	01 d0                	add    %edx,%eax
     2f3:	0f b6 00             	movzbl (%eax),%eax
     2f6:	84 c0                	test   %al,%al
     2f8:	75 ed                	jne    2e7 <strlen+0xf>
        ;
    return n;
     2fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2fd:	c9                   	leave  
     2fe:	c3                   	ret    

000002ff <memset>:

void* memset(void* dst, int c, uint n) {
     2ff:	55                   	push   %ebp
     300:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     302:	8b 45 10             	mov    0x10(%ebp),%eax
     305:	50                   	push   %eax
     306:	ff 75 0c             	push   0xc(%ebp)
     309:	ff 75 08             	push   0x8(%ebp)
     30c:	e8 32 ff ff ff       	call   243 <stosb>
     311:	83 c4 0c             	add    $0xc,%esp
    return dst;
     314:	8b 45 08             	mov    0x8(%ebp),%eax
}
     317:	c9                   	leave  
     318:	c3                   	ret    

00000319 <strchr>:

char* strchr(const char* s, char c) {
     319:	55                   	push   %ebp
     31a:	89 e5                	mov    %esp,%ebp
     31c:	83 ec 04             	sub    $0x4,%esp
     31f:	8b 45 0c             	mov    0xc(%ebp),%eax
     322:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     325:	eb 14                	jmp    33b <strchr+0x22>
        if (*s == c) return (char*) s;
     327:	8b 45 08             	mov    0x8(%ebp),%eax
     32a:	0f b6 00             	movzbl (%eax),%eax
     32d:	38 45 fc             	cmp    %al,-0x4(%ebp)
     330:	75 05                	jne    337 <strchr+0x1e>
     332:	8b 45 08             	mov    0x8(%ebp),%eax
     335:	eb 13                	jmp    34a <strchr+0x31>
    for (; *s; s++)
     337:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     33b:	8b 45 08             	mov    0x8(%ebp),%eax
     33e:	0f b6 00             	movzbl (%eax),%eax
     341:	84 c0                	test   %al,%al
     343:	75 e2                	jne    327 <strchr+0xe>
    return 0;
     345:	b8 00 00 00 00       	mov    $0x0,%eax
}
     34a:	c9                   	leave  
     34b:	c3                   	ret    

0000034c <gets>:

char* gets(char* buf, int max) {
     34c:	55                   	push   %ebp
     34d:	89 e5                	mov    %esp,%ebp
     34f:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     352:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     359:	eb 42                	jmp    39d <gets+0x51>
        cc = read(0, &c, 1);
     35b:	83 ec 04             	sub    $0x4,%esp
     35e:	6a 01                	push   $0x1
     360:	8d 45 ef             	lea    -0x11(%ebp),%eax
     363:	50                   	push   %eax
     364:	6a 00                	push   $0x0
     366:	e8 28 fe ff ff       	call   193 <read>
     36b:	83 c4 10             	add    $0x10,%esp
     36e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     371:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     375:	7e 33                	jle    3aa <gets+0x5e>
        buf[i++] = c;
     377:	8b 45 f4             	mov    -0xc(%ebp),%eax
     37a:	8d 50 01             	lea    0x1(%eax),%edx
     37d:	89 55 f4             	mov    %edx,-0xc(%ebp)
     380:	89 c2                	mov    %eax,%edx
     382:	8b 45 08             	mov    0x8(%ebp),%eax
     385:	01 c2                	add    %eax,%edx
     387:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     38b:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     38d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     391:	3c 0a                	cmp    $0xa,%al
     393:	74 16                	je     3ab <gets+0x5f>
     395:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     399:	3c 0d                	cmp    $0xd,%al
     39b:	74 0e                	je     3ab <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     39d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3a0:	83 c0 01             	add    $0x1,%eax
     3a3:	39 45 0c             	cmp    %eax,0xc(%ebp)
     3a6:	7f b3                	jg     35b <gets+0xf>
     3a8:	eb 01                	jmp    3ab <gets+0x5f>
        if (cc < 1) break;
     3aa:	90                   	nop
    }
    buf[i] = '\0';
     3ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3ae:	8b 45 08             	mov    0x8(%ebp),%eax
     3b1:	01 d0                	add    %edx,%eax
     3b3:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     3b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3b9:	c9                   	leave  
     3ba:	c3                   	ret    

000003bb <stat>:

int stat(const char* n, struct stat* st) {
     3bb:	55                   	push   %ebp
     3bc:	89 e5                	mov    %esp,%ebp
     3be:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     3c1:	83 ec 08             	sub    $0x8,%esp
     3c4:	6a 01                	push   $0x1
     3c6:	ff 75 08             	push   0x8(%ebp)
     3c9:	e8 ed fd ff ff       	call   1bb <open>
     3ce:	83 c4 10             	add    $0x10,%esp
     3d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     3d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3d8:	79 07                	jns    3e1 <stat+0x26>
     3da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3df:	eb 25                	jmp    406 <stat+0x4b>
    r = fstat(fd, st);
     3e1:	83 ec 08             	sub    $0x8,%esp
     3e4:	ff 75 0c             	push   0xc(%ebp)
     3e7:	ff 75 f4             	push   -0xc(%ebp)
     3ea:	e8 e4 fd ff ff       	call   1d3 <fstat>
     3ef:	83 c4 10             	add    $0x10,%esp
     3f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     3f5:	83 ec 0c             	sub    $0xc,%esp
     3f8:	ff 75 f4             	push   -0xc(%ebp)
     3fb:	e8 a3 fd ff ff       	call   1a3 <close>
     400:	83 c4 10             	add    $0x10,%esp
    return r;
     403:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     406:	c9                   	leave  
     407:	c3                   	ret    

00000408 <atoi>:

int atoi(const char* s) {
     408:	55                   	push   %ebp
     409:	89 e5                	mov    %esp,%ebp
     40b:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     40e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     415:	eb 25                	jmp    43c <atoi+0x34>
     417:	8b 55 fc             	mov    -0x4(%ebp),%edx
     41a:	89 d0                	mov    %edx,%eax
     41c:	c1 e0 02             	shl    $0x2,%eax
     41f:	01 d0                	add    %edx,%eax
     421:	01 c0                	add    %eax,%eax
     423:	89 c1                	mov    %eax,%ecx
     425:	8b 45 08             	mov    0x8(%ebp),%eax
     428:	8d 50 01             	lea    0x1(%eax),%edx
     42b:	89 55 08             	mov    %edx,0x8(%ebp)
     42e:	0f b6 00             	movzbl (%eax),%eax
     431:	0f be c0             	movsbl %al,%eax
     434:	01 c8                	add    %ecx,%eax
     436:	83 e8 30             	sub    $0x30,%eax
     439:	89 45 fc             	mov    %eax,-0x4(%ebp)
     43c:	8b 45 08             	mov    0x8(%ebp),%eax
     43f:	0f b6 00             	movzbl (%eax),%eax
     442:	3c 2f                	cmp    $0x2f,%al
     444:	7e 0a                	jle    450 <atoi+0x48>
     446:	8b 45 08             	mov    0x8(%ebp),%eax
     449:	0f b6 00             	movzbl (%eax),%eax
     44c:	3c 39                	cmp    $0x39,%al
     44e:	7e c7                	jle    417 <atoi+0xf>
    return n;
     450:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     453:	c9                   	leave  
     454:	c3                   	ret    

00000455 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     455:	55                   	push   %ebp
     456:	89 e5                	mov    %esp,%ebp
     458:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     45b:	8b 45 08             	mov    0x8(%ebp),%eax
     45e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     461:	8b 45 0c             	mov    0xc(%ebp),%eax
     464:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     467:	eb 17                	jmp    480 <memmove+0x2b>
     469:	8b 55 f8             	mov    -0x8(%ebp),%edx
     46c:	8d 42 01             	lea    0x1(%edx),%eax
     46f:	89 45 f8             	mov    %eax,-0x8(%ebp)
     472:	8b 45 fc             	mov    -0x4(%ebp),%eax
     475:	8d 48 01             	lea    0x1(%eax),%ecx
     478:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     47b:	0f b6 12             	movzbl (%edx),%edx
     47e:	88 10                	mov    %dl,(%eax)
     480:	8b 45 10             	mov    0x10(%ebp),%eax
     483:	8d 50 ff             	lea    -0x1(%eax),%edx
     486:	89 55 10             	mov    %edx,0x10(%ebp)
     489:	85 c0                	test   %eax,%eax
     48b:	7f dc                	jg     469 <memmove+0x14>
    return vdst;
     48d:	8b 45 08             	mov    0x8(%ebp),%eax
}
     490:	c9                   	leave  
     491:	c3                   	ret    

00000492 <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     492:	55                   	push   %ebp
     493:	89 e5                	mov    %esp,%ebp
     495:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     498:	8b 45 08             	mov    0x8(%ebp),%eax
     49b:	83 e8 08             	sub    $0x8,%eax
     49e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     4a1:	a1 a8 2b 00 00       	mov    0x2ba8,%eax
     4a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     4a9:	eb 24                	jmp    4cf <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     4ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4ae:	8b 00                	mov    (%eax),%eax
     4b0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     4b3:	72 12                	jb     4c7 <free+0x35>
     4b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4b8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     4bb:	77 24                	ja     4e1 <free+0x4f>
     4bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4c0:	8b 00                	mov    (%eax),%eax
     4c2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     4c5:	72 1a                	jb     4e1 <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     4c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4ca:	8b 00                	mov    (%eax),%eax
     4cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
     4cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     4d5:	76 d4                	jbe    4ab <free+0x19>
     4d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4da:	8b 00                	mov    (%eax),%eax
     4dc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     4df:	73 ca                	jae    4ab <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     4e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4e4:	8b 40 04             	mov    0x4(%eax),%eax
     4e7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     4ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4f1:	01 c2                	add    %eax,%edx
     4f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f6:	8b 00                	mov    (%eax),%eax
     4f8:	39 c2                	cmp    %eax,%edx
     4fa:	75 24                	jne    520 <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     4fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4ff:	8b 50 04             	mov    0x4(%eax),%edx
     502:	8b 45 fc             	mov    -0x4(%ebp),%eax
     505:	8b 00                	mov    (%eax),%eax
     507:	8b 40 04             	mov    0x4(%eax),%eax
     50a:	01 c2                	add    %eax,%edx
     50c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     50f:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     512:	8b 45 fc             	mov    -0x4(%ebp),%eax
     515:	8b 00                	mov    (%eax),%eax
     517:	8b 10                	mov    (%eax),%edx
     519:	8b 45 f8             	mov    -0x8(%ebp),%eax
     51c:	89 10                	mov    %edx,(%eax)
     51e:	eb 0a                	jmp    52a <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     520:	8b 45 fc             	mov    -0x4(%ebp),%eax
     523:	8b 10                	mov    (%eax),%edx
     525:	8b 45 f8             	mov    -0x8(%ebp),%eax
     528:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     52a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     52d:	8b 40 04             	mov    0x4(%eax),%eax
     530:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     537:	8b 45 fc             	mov    -0x4(%ebp),%eax
     53a:	01 d0                	add    %edx,%eax
     53c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     53f:	75 20                	jne    561 <free+0xcf>
        p->s.size += bp->s.size;
     541:	8b 45 fc             	mov    -0x4(%ebp),%eax
     544:	8b 50 04             	mov    0x4(%eax),%edx
     547:	8b 45 f8             	mov    -0x8(%ebp),%eax
     54a:	8b 40 04             	mov    0x4(%eax),%eax
     54d:	01 c2                	add    %eax,%edx
     54f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     552:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     555:	8b 45 f8             	mov    -0x8(%ebp),%eax
     558:	8b 10                	mov    (%eax),%edx
     55a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     55d:	89 10                	mov    %edx,(%eax)
     55f:	eb 08                	jmp    569 <free+0xd7>
    } else
        p->s.ptr = bp;
     561:	8b 45 fc             	mov    -0x4(%ebp),%eax
     564:	8b 55 f8             	mov    -0x8(%ebp),%edx
     567:	89 10                	mov    %edx,(%eax)
    freep = p;
     569:	8b 45 fc             	mov    -0x4(%ebp),%eax
     56c:	a3 a8 2b 00 00       	mov    %eax,0x2ba8
}
     571:	90                   	nop
     572:	c9                   	leave  
     573:	c3                   	ret    

00000574 <morecore>:

static Header* morecore(uint nu) {
     574:	55                   	push   %ebp
     575:	89 e5                	mov    %esp,%ebp
     577:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     57a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     581:	77 07                	ja     58a <morecore+0x16>
     583:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     58a:	8b 45 08             	mov    0x8(%ebp),%eax
     58d:	c1 e0 03             	shl    $0x3,%eax
     590:	83 ec 0c             	sub    $0xc,%esp
     593:	50                   	push   %eax
     594:	e8 6a fc ff ff       	call   203 <sbrk>
     599:	83 c4 10             	add    $0x10,%esp
     59c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     59f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     5a3:	75 07                	jne    5ac <morecore+0x38>
     5a5:	b8 00 00 00 00       	mov    $0x0,%eax
     5aa:	eb 26                	jmp    5d2 <morecore+0x5e>
    hp = (Header*) p;
     5ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5af:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     5b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5b5:	8b 55 08             	mov    0x8(%ebp),%edx
     5b8:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     5bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5be:	83 c0 08             	add    $0x8,%eax
     5c1:	83 ec 0c             	sub    $0xc,%esp
     5c4:	50                   	push   %eax
     5c5:	e8 c8 fe ff ff       	call   492 <free>
     5ca:	83 c4 10             	add    $0x10,%esp
    return freep;
     5cd:	a1 a8 2b 00 00       	mov    0x2ba8,%eax
}
     5d2:	c9                   	leave  
     5d3:	c3                   	ret    

000005d4 <malloc>:

void* malloc(uint nbytes) {
     5d4:	55                   	push   %ebp
     5d5:	89 e5                	mov    %esp,%ebp
     5d7:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     5da:	8b 45 08             	mov    0x8(%ebp),%eax
     5dd:	83 c0 07             	add    $0x7,%eax
     5e0:	c1 e8 03             	shr    $0x3,%eax
     5e3:	83 c0 01             	add    $0x1,%eax
     5e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     5e9:	a1 a8 2b 00 00       	mov    0x2ba8,%eax
     5ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
     5f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     5f5:	75 23                	jne    61a <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     5f7:	c7 45 f0 a0 2b 00 00 	movl   $0x2ba0,-0x10(%ebp)
     5fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     601:	a3 a8 2b 00 00       	mov    %eax,0x2ba8
     606:	a1 a8 2b 00 00       	mov    0x2ba8,%eax
     60b:	a3 a0 2b 00 00       	mov    %eax,0x2ba0
        base.s.size = 0;
     610:	c7 05 a4 2b 00 00 00 	movl   $0x0,0x2ba4
     617:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     61a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     61d:	8b 00                	mov    (%eax),%eax
     61f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     622:	8b 45 f4             	mov    -0xc(%ebp),%eax
     625:	8b 40 04             	mov    0x4(%eax),%eax
     628:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     62b:	77 4d                	ja     67a <malloc+0xa6>
            if (p->s.size == nunits)
     62d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     630:	8b 40 04             	mov    0x4(%eax),%eax
     633:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     636:	75 0c                	jne    644 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     638:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63b:	8b 10                	mov    (%eax),%edx
     63d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     640:	89 10                	mov    %edx,(%eax)
     642:	eb 26                	jmp    66a <malloc+0x96>
            else {
                p->s.size -= nunits;
     644:	8b 45 f4             	mov    -0xc(%ebp),%eax
     647:	8b 40 04             	mov    0x4(%eax),%eax
     64a:	2b 45 ec             	sub    -0x14(%ebp),%eax
     64d:	89 c2                	mov    %eax,%edx
     64f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     652:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     655:	8b 45 f4             	mov    -0xc(%ebp),%eax
     658:	8b 40 04             	mov    0x4(%eax),%eax
     65b:	c1 e0 03             	shl    $0x3,%eax
     65e:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     661:	8b 45 f4             	mov    -0xc(%ebp),%eax
     664:	8b 55 ec             	mov    -0x14(%ebp),%edx
     667:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     66a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     66d:	a3 a8 2b 00 00       	mov    %eax,0x2ba8
            return (void*) (p + 1);
     672:	8b 45 f4             	mov    -0xc(%ebp),%eax
     675:	83 c0 08             	add    $0x8,%eax
     678:	eb 3b                	jmp    6b5 <malloc+0xe1>
        }
        if (p == freep)
     67a:	a1 a8 2b 00 00       	mov    0x2ba8,%eax
     67f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     682:	75 1e                	jne    6a2 <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     684:	83 ec 0c             	sub    $0xc,%esp
     687:	ff 75 ec             	push   -0x14(%ebp)
     68a:	e8 e5 fe ff ff       	call   574 <morecore>
     68f:	83 c4 10             	add    $0x10,%esp
     692:	89 45 f4             	mov    %eax,-0xc(%ebp)
     695:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     699:	75 07                	jne    6a2 <malloc+0xce>
     69b:	b8 00 00 00 00       	mov    $0x0,%eax
     6a0:	eb 13                	jmp    6b5 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     6a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     6a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ab:	8b 00                	mov    (%eax),%eax
     6ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     6b0:	e9 6d ff ff ff       	jmp    622 <malloc+0x4e>
    }
}
     6b5:	c9                   	leave  
     6b6:	c3                   	ret    

000006b7 <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     6b7:	55                   	push   %ebp
     6b8:	89 e5                	mov    %esp,%ebp
     6ba:	83 ec 18             	sub    $0x18,%esp
     6bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c0:	88 45 f4             	mov    %al,-0xc(%ebp)
     6c3:	83 ec 04             	sub    $0x4,%esp
     6c6:	6a 01                	push   $0x1
     6c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6cb:	50                   	push   %eax
     6cc:	ff 75 08             	push   0x8(%ebp)
     6cf:	e8 c7 fa ff ff       	call   19b <write>
     6d4:	83 c4 10             	add    $0x10,%esp
     6d7:	90                   	nop
     6d8:	c9                   	leave  
     6d9:	c3                   	ret    

000006da <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     6da:	55                   	push   %ebp
     6db:	89 e5                	mov    %esp,%ebp
     6dd:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     6e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     6e7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6eb:	74 17                	je     704 <printint+0x2a>
     6ed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6f1:	79 11                	jns    704 <printint+0x2a>
        neg = 1;
     6f3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     6fa:	8b 45 0c             	mov    0xc(%ebp),%eax
     6fd:	f7 d8                	neg    %eax
     6ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
     702:	eb 06                	jmp    70a <printint+0x30>
    } else {
        x = xx;
     704:	8b 45 0c             	mov    0xc(%ebp),%eax
     707:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     70a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     711:	8b 4d 10             	mov    0x10(%ebp),%ecx
     714:	8b 45 ec             	mov    -0x14(%ebp),%eax
     717:	ba 00 00 00 00       	mov    $0x0,%edx
     71c:	f7 f1                	div    %ecx
     71e:	89 d1                	mov    %edx,%ecx
     720:	8b 45 f4             	mov    -0xc(%ebp),%eax
     723:	8d 50 01             	lea    0x1(%eax),%edx
     726:	89 55 f4             	mov    %edx,-0xc(%ebp)
     729:	0f b6 91 80 2b 00 00 	movzbl 0x2b80(%ecx),%edx
     730:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     734:	8b 4d 10             	mov    0x10(%ebp),%ecx
     737:	8b 45 ec             	mov    -0x14(%ebp),%eax
     73a:	ba 00 00 00 00       	mov    $0x0,%edx
     73f:	f7 f1                	div    %ecx
     741:	89 45 ec             	mov    %eax,-0x14(%ebp)
     744:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     748:	75 c7                	jne    711 <printint+0x37>
    if (neg) buf[i++] = '-';
     74a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     74e:	74 2d                	je     77d <printint+0xa3>
     750:	8b 45 f4             	mov    -0xc(%ebp),%eax
     753:	8d 50 01             	lea    0x1(%eax),%edx
     756:	89 55 f4             	mov    %edx,-0xc(%ebp)
     759:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     75e:	eb 1d                	jmp    77d <printint+0xa3>
     760:	8d 55 dc             	lea    -0x24(%ebp),%edx
     763:	8b 45 f4             	mov    -0xc(%ebp),%eax
     766:	01 d0                	add    %edx,%eax
     768:	0f b6 00             	movzbl (%eax),%eax
     76b:	0f be c0             	movsbl %al,%eax
     76e:	83 ec 08             	sub    $0x8,%esp
     771:	50                   	push   %eax
     772:	ff 75 08             	push   0x8(%ebp)
     775:	e8 3d ff ff ff       	call   6b7 <putc>
     77a:	83 c4 10             	add    $0x10,%esp
     77d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     781:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     785:	79 d9                	jns    760 <printint+0x86>
}
     787:	90                   	nop
     788:	90                   	nop
     789:	c9                   	leave  
     78a:	c3                   	ret    

0000078b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     78b:	55                   	push   %ebp
     78c:	89 e5                	mov    %esp,%ebp
     78e:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     791:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     798:	8d 45 0c             	lea    0xc(%ebp),%eax
     79b:	83 c0 04             	add    $0x4,%eax
     79e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     7a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7a8:	e9 59 01 00 00       	jmp    906 <printf+0x17b>
        c = fmt[i] & 0xff;
     7ad:	8b 55 0c             	mov    0xc(%ebp),%edx
     7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b3:	01 d0                	add    %edx,%eax
     7b5:	0f b6 00             	movzbl (%eax),%eax
     7b8:	0f be c0             	movsbl %al,%eax
     7bb:	25 ff 00 00 00       	and    $0xff,%eax
     7c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     7c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7c7:	75 2c                	jne    7f5 <printf+0x6a>
            if (c == '%') {
     7c9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7cd:	75 0c                	jne    7db <printf+0x50>
                state = '%';
     7cf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7d6:	e9 27 01 00 00       	jmp    902 <printf+0x177>
            } else {
                putc(fd, c);
     7db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7de:	0f be c0             	movsbl %al,%eax
     7e1:	83 ec 08             	sub    $0x8,%esp
     7e4:	50                   	push   %eax
     7e5:	ff 75 08             	push   0x8(%ebp)
     7e8:	e8 ca fe ff ff       	call   6b7 <putc>
     7ed:	83 c4 10             	add    $0x10,%esp
     7f0:	e9 0d 01 00 00       	jmp    902 <printf+0x177>
            }
        } else if (state == '%') {
     7f5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7f9:	0f 85 03 01 00 00    	jne    902 <printf+0x177>
            if (c == 'd') {
     7ff:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     803:	75 1e                	jne    823 <printf+0x98>
                printint(fd, *ap, 10, 1);
     805:	8b 45 e8             	mov    -0x18(%ebp),%eax
     808:	8b 00                	mov    (%eax),%eax
     80a:	6a 01                	push   $0x1
     80c:	6a 0a                	push   $0xa
     80e:	50                   	push   %eax
     80f:	ff 75 08             	push   0x8(%ebp)
     812:	e8 c3 fe ff ff       	call   6da <printint>
     817:	83 c4 10             	add    $0x10,%esp
                ap++;
     81a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     81e:	e9 d8 00 00 00       	jmp    8fb <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     823:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     827:	74 06                	je     82f <printf+0xa4>
     829:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     82d:	75 1e                	jne    84d <printf+0xc2>
                printint(fd, *ap, 16, 0);
     82f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     832:	8b 00                	mov    (%eax),%eax
     834:	6a 00                	push   $0x0
     836:	6a 10                	push   $0x10
     838:	50                   	push   %eax
     839:	ff 75 08             	push   0x8(%ebp)
     83c:	e8 99 fe ff ff       	call   6da <printint>
     841:	83 c4 10             	add    $0x10,%esp
                ap++;
     844:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     848:	e9 ae 00 00 00       	jmp    8fb <printf+0x170>
            } else if (c == 's') {
     84d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     851:	75 43                	jne    896 <printf+0x10b>
                s = (char*) *ap;
     853:	8b 45 e8             	mov    -0x18(%ebp),%eax
     856:	8b 00                	mov    (%eax),%eax
     858:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     85b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     85f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     863:	75 25                	jne    88a <printf+0xff>
     865:	c7 45 f4 23 21 00 00 	movl   $0x2123,-0xc(%ebp)
                while (*s != 0) {
     86c:	eb 1c                	jmp    88a <printf+0xff>
                    putc(fd, *s);
     86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     871:	0f b6 00             	movzbl (%eax),%eax
     874:	0f be c0             	movsbl %al,%eax
     877:	83 ec 08             	sub    $0x8,%esp
     87a:	50                   	push   %eax
     87b:	ff 75 08             	push   0x8(%ebp)
     87e:	e8 34 fe ff ff       	call   6b7 <putc>
     883:	83 c4 10             	add    $0x10,%esp
                    s++;
     886:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     88a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88d:	0f b6 00             	movzbl (%eax),%eax
     890:	84 c0                	test   %al,%al
     892:	75 da                	jne    86e <printf+0xe3>
     894:	eb 65                	jmp    8fb <printf+0x170>
                }
            } else if (c == 'c') {
     896:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     89a:	75 1d                	jne    8b9 <printf+0x12e>
                putc(fd, *ap);
     89c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     89f:	8b 00                	mov    (%eax),%eax
     8a1:	0f be c0             	movsbl %al,%eax
     8a4:	83 ec 08             	sub    $0x8,%esp
     8a7:	50                   	push   %eax
     8a8:	ff 75 08             	push   0x8(%ebp)
     8ab:	e8 07 fe ff ff       	call   6b7 <putc>
     8b0:	83 c4 10             	add    $0x10,%esp
                ap++;
     8b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8b7:	eb 42                	jmp    8fb <printf+0x170>
            } else if (c == '%') {
     8b9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8bd:	75 17                	jne    8d6 <printf+0x14b>
                putc(fd, c);
     8bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8c2:	0f be c0             	movsbl %al,%eax
     8c5:	83 ec 08             	sub    $0x8,%esp
     8c8:	50                   	push   %eax
     8c9:	ff 75 08             	push   0x8(%ebp)
     8cc:	e8 e6 fd ff ff       	call   6b7 <putc>
     8d1:	83 c4 10             	add    $0x10,%esp
     8d4:	eb 25                	jmp    8fb <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     8d6:	83 ec 08             	sub    $0x8,%esp
     8d9:	6a 25                	push   $0x25
     8db:	ff 75 08             	push   0x8(%ebp)
     8de:	e8 d4 fd ff ff       	call   6b7 <putc>
     8e3:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     8e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8e9:	0f be c0             	movsbl %al,%eax
     8ec:	83 ec 08             	sub    $0x8,%esp
     8ef:	50                   	push   %eax
     8f0:	ff 75 08             	push   0x8(%ebp)
     8f3:	e8 bf fd ff ff       	call   6b7 <putc>
     8f8:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     8fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     902:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     906:	8b 55 0c             	mov    0xc(%ebp),%edx
     909:	8b 45 f0             	mov    -0x10(%ebp),%eax
     90c:	01 d0                	add    %edx,%eax
     90e:	0f b6 00             	movzbl (%eax),%eax
     911:	84 c0                	test   %al,%al
     913:	0f 85 94 fe ff ff    	jne    7ad <printf+0x22>
        }
    }
}
     919:	90                   	nop
     91a:	90                   	nop
     91b:	c9                   	leave  
     91c:	c3                   	ret    

0000091d <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     91d:	55                   	push   %ebp
     91e:	89 e5                	mov    %esp,%ebp
     920:	83 ec 04             	sub    $0x4,%esp
     923:	8b 45 08             	mov    0x8(%ebp),%eax
     926:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     929:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     92d:	01 c0                	add    %eax,%eax
     92f:	89 c1                	mov    %eax,%ecx
     931:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     935:	c0 e8 07             	shr    $0x7,%al
     938:	89 c2                	mov    %eax,%edx
     93a:	89 d0                	mov    %edx,%eax
     93c:	01 c0                	add    %eax,%eax
     93e:	01 d0                	add    %edx,%eax
     940:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     947:	01 d0                	add    %edx,%eax
     949:	31 c8                	xor    %ecx,%eax
}
     94b:	c9                   	leave  
     94c:	c3                   	ret    

0000094d <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     94d:	55                   	push   %ebp
     94e:	89 e5                	mov    %esp,%ebp
     950:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     951:	bb 00 00 00 00       	mov    $0x0,%ebx
     956:	eb 24                	jmp    97c <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     958:	0f b6 d3             	movzbl %bl,%edx
     95b:	8b 45 08             	mov    0x8(%ebp),%eax
     95e:	01 d0                	add    %edx,%eax
     960:	0f b6 00             	movzbl (%eax),%eax
     963:	0f b6 c0             	movzbl %al,%eax
     966:	0f b6 cb             	movzbl %bl,%ecx
     969:	8b 55 08             	mov    0x8(%ebp),%edx
     96c:	01 ca                	add    %ecx,%edx
     96e:	0f b6 80 40 21 00 00 	movzbl 0x2140(%eax),%eax
     975:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     977:	89 d8                	mov    %ebx,%eax
     979:	8d 58 01             	lea    0x1(%eax),%ebx
     97c:	80 fb 0f             	cmp    $0xf,%bl
     97f:	76 d7                	jbe    958 <aes_subBytes+0xb>
    }
}
     981:	90                   	nop
     982:	90                   	nop
     983:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     986:	c9                   	leave  
     987:	c3                   	ret    

00000988 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     988:	55                   	push   %ebp
     989:	89 e5                	mov    %esp,%ebp
     98b:	56                   	push   %esi
     98c:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     98d:	bb 00 00 00 00       	mov    $0x0,%ebx
     992:	eb 27                	jmp    9bb <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     994:	0f b6 d3             	movzbl %bl,%edx
     997:	8b 45 08             	mov    0x8(%ebp),%eax
     99a:	01 d0                	add    %edx,%eax
     99c:	0f b6 08             	movzbl (%eax),%ecx
     99f:	0f b6 d3             	movzbl %bl,%edx
     9a2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a5:	01 d0                	add    %edx,%eax
     9a7:	0f b6 10             	movzbl (%eax),%edx
     9aa:	0f b6 f3             	movzbl %bl,%esi
     9ad:	8b 45 08             	mov    0x8(%ebp),%eax
     9b0:	01 f0                	add    %esi,%eax
     9b2:	31 ca                	xor    %ecx,%edx
     9b4:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     9b6:	89 d8                	mov    %ebx,%eax
     9b8:	8d 58 01             	lea    0x1(%eax),%ebx
     9bb:	80 fb 0f             	cmp    $0xf,%bl
     9be:	76 d4                	jbe    994 <aes_addRoundKey+0xc>
    }
}
     9c0:	90                   	nop
     9c1:	90                   	nop
     9c2:	5b                   	pop    %ebx
     9c3:	5e                   	pop    %esi
     9c4:	5d                   	pop    %ebp
     9c5:	c3                   	ret    

000009c6 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     9c6:	55                   	push   %ebp
     9c7:	89 e5                	mov    %esp,%ebp
     9c9:	56                   	push   %esi
     9ca:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     9cb:	bb 00 00 00 00       	mov    $0x0,%ebx
     9d0:	eb 5b                	jmp    a2d <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     9d2:	0f b6 d3             	movzbl %bl,%edx
     9d5:	8b 45 0c             	mov    0xc(%ebp),%eax
     9d8:	01 d0                	add    %edx,%eax
     9da:	0f b6 cb             	movzbl %bl,%ecx
     9dd:	8b 55 10             	mov    0x10(%ebp),%edx
     9e0:	01 ca                	add    %ecx,%edx
     9e2:	0f b6 00             	movzbl (%eax),%eax
     9e5:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     9e7:	0f b6 d3             	movzbl %bl,%edx
     9ea:	8b 45 08             	mov    0x8(%ebp),%eax
     9ed:	01 d0                	add    %edx,%eax
     9ef:	0f b6 08             	movzbl (%eax),%ecx
     9f2:	0f b6 d3             	movzbl %bl,%edx
     9f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     9f8:	01 d0                	add    %edx,%eax
     9fa:	0f b6 10             	movzbl (%eax),%edx
     9fd:	0f b6 f3             	movzbl %bl,%esi
     a00:	8b 45 08             	mov    0x8(%ebp),%eax
     a03:	01 f0                	add    %esi,%eax
     a05:	31 ca                	xor    %ecx,%edx
     a07:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     a09:	0f b6 c3             	movzbl %bl,%eax
     a0c:	83 c0 10             	add    $0x10,%eax
     a0f:	89 c2                	mov    %eax,%edx
     a11:	8b 45 0c             	mov    0xc(%ebp),%eax
     a14:	01 d0                	add    %edx,%eax
     a16:	0f b6 d3             	movzbl %bl,%edx
     a19:	83 c2 10             	add    $0x10,%edx
     a1c:	89 d1                	mov    %edx,%ecx
     a1e:	8b 55 10             	mov    0x10(%ebp),%edx
     a21:	01 ca                	add    %ecx,%edx
     a23:	0f b6 00             	movzbl (%eax),%eax
     a26:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     a28:	89 d8                	mov    %ebx,%eax
     a2a:	8d 58 01             	lea    0x1(%eax),%ebx
     a2d:	80 fb 0f             	cmp    $0xf,%bl
     a30:	76 a0                	jbe    9d2 <aes_addRoundKey_cpy+0xc>
    }
}
     a32:	90                   	nop
     a33:	90                   	nop
     a34:	5b                   	pop    %ebx
     a35:	5e                   	pop    %esi
     a36:	5d                   	pop    %ebp
     a37:	c3                   	ret    

00000a38 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     a38:	55                   	push   %ebp
     a39:	89 e5                	mov    %esp,%ebp
     a3b:	53                   	push   %ebx
     a3c:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     a3f:	8b 45 08             	mov    0x8(%ebp),%eax
     a42:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     a46:	8b 45 08             	mov    0x8(%ebp),%eax
     a49:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     a4d:	88 45 fb             	mov    %al,-0x5(%ebp)
     a50:	8b 45 08             	mov    0x8(%ebp),%eax
     a53:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     a57:	88 5d fa             	mov    %bl,-0x6(%ebp)
     a5a:	8b 45 08             	mov    0x8(%ebp),%eax
     a5d:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     a61:	8b 45 08             	mov    0x8(%ebp),%eax
     a64:	8d 50 01             	lea    0x1(%eax),%edx
     a67:	8b 45 08             	mov    0x8(%ebp),%eax
     a6a:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     a6e:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     a70:	8b 45 08             	mov    0x8(%ebp),%eax
     a73:	8d 50 05             	lea    0x5(%eax),%edx
     a76:	8b 45 08             	mov    0x8(%ebp),%eax
     a79:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     a7d:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     a7f:	8b 45 08             	mov    0x8(%ebp),%eax
     a82:	8d 50 09             	lea    0x9(%eax),%edx
     a85:	8b 45 08             	mov    0x8(%ebp),%eax
     a88:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     a8c:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     a8e:	8b 45 08             	mov    0x8(%ebp),%eax
     a91:	83 c0 0d             	add    $0xd,%eax
     a94:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     a96:	8b 45 08             	mov    0x8(%ebp),%eax
     a99:	8d 50 03             	lea    0x3(%eax),%edx
     a9c:	8b 45 08             	mov    0x8(%ebp),%eax
     a9f:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     aa3:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     aa5:	8b 45 08             	mov    0x8(%ebp),%eax
     aa8:	8d 50 0f             	lea    0xf(%eax),%edx
     aab:	8b 45 08             	mov    0x8(%ebp),%eax
     aae:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     ab2:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     ab4:	8b 45 08             	mov    0x8(%ebp),%eax
     ab7:	8d 50 0b             	lea    0xb(%eax),%edx
     aba:	8b 45 08             	mov    0x8(%ebp),%eax
     abd:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     ac1:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     ac3:	8b 45 08             	mov    0x8(%ebp),%eax
     ac6:	83 c0 07             	add    $0x7,%eax
     ac9:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     acd:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     acf:	8b 45 08             	mov    0x8(%ebp),%eax
     ad2:	8d 50 0a             	lea    0xa(%eax),%edx
     ad5:	8b 45 08             	mov    0x8(%ebp),%eax
     ad8:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     adc:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     ade:	8b 45 08             	mov    0x8(%ebp),%eax
     ae1:	83 c0 02             	add    $0x2,%eax
     ae4:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     ae8:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     aea:	8b 45 08             	mov    0x8(%ebp),%eax
     aed:	8d 50 0e             	lea    0xe(%eax),%edx
     af0:	8b 45 08             	mov    0x8(%ebp),%eax
     af3:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     af7:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     af9:	8b 45 08             	mov    0x8(%ebp),%eax
     afc:	83 c0 06             	add    $0x6,%eax
     aff:	88 18                	mov    %bl,(%eax)
}
     b01:	90                   	nop
     b02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b05:	c9                   	leave  
     b06:	c3                   	ret    

00000b07 <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     b07:	55                   	push   %ebp
     b08:	89 e5                	mov    %esp,%ebp
     b0a:	56                   	push   %esi
     b0b:	53                   	push   %ebx
     b0c:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     b0f:	bb 00 00 00 00       	mov    $0x0,%ebx
     b14:	e9 42 01 00 00       	jmp    c5b <aes_mixColumns+0x154>
        a = buf[i];
     b19:	0f b6 d3             	movzbl %bl,%edx
     b1c:	8b 45 08             	mov    0x8(%ebp),%eax
     b1f:	01 d0                	add    %edx,%eax
     b21:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     b24:	0f b6 c3             	movzbl %bl,%eax
     b27:	8d 50 01             	lea    0x1(%eax),%edx
     b2a:	8b 45 08             	mov    0x8(%ebp),%eax
     b2d:	01 d0                	add    %edx,%eax
     b2f:	0f b6 10             	movzbl (%eax),%edx
     b32:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     b35:	0f b6 c3             	movzbl %bl,%eax
     b38:	8d 50 02             	lea    0x2(%eax),%edx
     b3b:	8b 45 08             	mov    0x8(%ebp),%eax
     b3e:	01 d0                	add    %edx,%eax
     b40:	0f b6 00             	movzbl (%eax),%eax
     b43:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     b46:	0f b6 c3             	movzbl %bl,%eax
     b49:	8d 50 03             	lea    0x3(%eax),%edx
     b4c:	8b 45 08             	mov    0x8(%ebp),%eax
     b4f:	01 d0                	add    %edx,%eax
     b51:	0f b6 00             	movzbl (%eax),%eax
     b54:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     b57:	89 c8                	mov    %ecx,%eax
     b59:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     b5d:	31 d0                	xor    %edx,%eax
     b5f:	32 45 f6             	xor    -0xa(%ebp),%al
     b62:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     b66:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     b68:	88 4d f4             	mov    %cl,-0xc(%ebp)
     b6b:	89 c8                	mov    %ecx,%eax
     b6d:	88 55 f7             	mov    %dl,-0x9(%ebp)
     b70:	32 45 f7             	xor    -0x9(%ebp),%al
     b73:	0f b6 c0             	movzbl %al,%eax
     b76:	50                   	push   %eax
     b77:	e8 a1 fd ff ff       	call   91d <rj_xtime>
     b7c:	83 c4 04             	add    $0x4,%esp
     b7f:	31 f0                	xor    %esi,%eax
     b81:	0f b6 c8             	movzbl %al,%ecx
     b84:	0f b6 d3             	movzbl %bl,%edx
     b87:	8b 45 08             	mov    0x8(%ebp),%eax
     b8a:	01 d0                	add    %edx,%eax
     b8c:	0f b6 00             	movzbl (%eax),%eax
     b8f:	89 c2                	mov    %eax,%edx
     b91:	89 c8                	mov    %ecx,%eax
     b93:	89 d1                	mov    %edx,%ecx
     b95:	31 c1                	xor    %eax,%ecx
     b97:	0f b6 d3             	movzbl %bl,%edx
     b9a:	8b 45 08             	mov    0x8(%ebp),%eax
     b9d:	01 c2                	add    %eax,%edx
     b9f:	89 c8                	mov    %ecx,%eax
     ba1:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     ba3:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     ba7:	32 55 f6             	xor    -0xa(%ebp),%dl
     baa:	89 d0                	mov    %edx,%eax
     bac:	0f b6 c0             	movzbl %al,%eax
     baf:	50                   	push   %eax
     bb0:	e8 68 fd ff ff       	call   91d <rj_xtime>
     bb5:	83 c4 04             	add    $0x4,%esp
     bb8:	31 f0                	xor    %esi,%eax
     bba:	0f b6 c8             	movzbl %al,%ecx
     bbd:	0f b6 c3             	movzbl %bl,%eax
     bc0:	8d 50 01             	lea    0x1(%eax),%edx
     bc3:	8b 45 08             	mov    0x8(%ebp),%eax
     bc6:	01 d0                	add    %edx,%eax
     bc8:	0f b6 00             	movzbl (%eax),%eax
     bcb:	89 c2                	mov    %eax,%edx
     bcd:	89 c8                	mov    %ecx,%eax
     bcf:	31 c2                	xor    %eax,%edx
     bd1:	89 d1                	mov    %edx,%ecx
     bd3:	0f b6 c3             	movzbl %bl,%eax
     bd6:	8d 50 01             	lea    0x1(%eax),%edx
     bd9:	8b 45 08             	mov    0x8(%ebp),%eax
     bdc:	01 c2                	add    %eax,%edx
     bde:	89 c8                	mov    %ecx,%eax
     be0:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     be2:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     be6:	32 45 f5             	xor    -0xb(%ebp),%al
     be9:	0f b6 c0             	movzbl %al,%eax
     bec:	50                   	push   %eax
     bed:	e8 2b fd ff ff       	call   91d <rj_xtime>
     bf2:	83 c4 04             	add    $0x4,%esp
     bf5:	31 f0                	xor    %esi,%eax
     bf7:	0f b6 d0             	movzbl %al,%edx
     bfa:	0f b6 c3             	movzbl %bl,%eax
     bfd:	8d 48 02             	lea    0x2(%eax),%ecx
     c00:	8b 45 08             	mov    0x8(%ebp),%eax
     c03:	01 c8                	add    %ecx,%eax
     c05:	0f b6 00             	movzbl (%eax),%eax
     c08:	89 c1                	mov    %eax,%ecx
     c0a:	89 d0                	mov    %edx,%eax
     c0c:	89 ca                	mov    %ecx,%edx
     c0e:	31 c2                	xor    %eax,%edx
     c10:	0f b6 c3             	movzbl %bl,%eax
     c13:	8d 48 02             	lea    0x2(%eax),%ecx
     c16:	8b 45 08             	mov    0x8(%ebp),%eax
     c19:	01 c8                	add    %ecx,%eax
     c1b:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     c1d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     c21:	32 45 f4             	xor    -0xc(%ebp),%al
     c24:	0f b6 c0             	movzbl %al,%eax
     c27:	50                   	push   %eax
     c28:	e8 f0 fc ff ff       	call   91d <rj_xtime>
     c2d:	83 c4 04             	add    $0x4,%esp
     c30:	31 f0                	xor    %esi,%eax
     c32:	0f b6 d0             	movzbl %al,%edx
     c35:	0f b6 c3             	movzbl %bl,%eax
     c38:	8d 48 03             	lea    0x3(%eax),%ecx
     c3b:	8b 45 08             	mov    0x8(%ebp),%eax
     c3e:	01 c8                	add    %ecx,%eax
     c40:	0f b6 00             	movzbl (%eax),%eax
     c43:	89 c1                	mov    %eax,%ecx
     c45:	89 d0                	mov    %edx,%eax
     c47:	31 c1                	xor    %eax,%ecx
     c49:	89 ca                	mov    %ecx,%edx
     c4b:	0f b6 c3             	movzbl %bl,%eax
     c4e:	8d 48 03             	lea    0x3(%eax),%ecx
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	01 c8                	add    %ecx,%eax
     c56:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     c58:	83 c3 04             	add    $0x4,%ebx
     c5b:	80 fb 0f             	cmp    $0xf,%bl
     c5e:	0f 86 b5 fe ff ff    	jbe    b19 <aes_mixColumns+0x12>
    }
}
     c64:	90                   	nop
     c65:	90                   	nop
     c66:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c69:	5b                   	pop    %ebx
     c6a:	5e                   	pop    %esi
     c6b:	5d                   	pop    %ebp
     c6c:	c3                   	ret    

00000c6d <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     c6d:	55                   	push   %ebp
     c6e:	89 e5                	mov    %esp,%ebp
     c70:	56                   	push   %esi
     c71:	53                   	push   %ebx
     c72:	83 ec 04             	sub    $0x4,%esp
     c75:	8b 45 0c             	mov    0xc(%ebp),%eax
     c78:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     c7b:	8b 45 08             	mov    0x8(%ebp),%eax
     c7e:	0f b6 10             	movzbl (%eax),%edx
     c81:	8b 45 08             	mov    0x8(%ebp),%eax
     c84:	83 c0 1d             	add    $0x1d,%eax
     c87:	0f b6 00             	movzbl (%eax),%eax
     c8a:	0f b6 c0             	movzbl %al,%eax
     c8d:	0f b6 80 40 21 00 00 	movzbl 0x2140(%eax),%eax
     c94:	32 45 f4             	xor    -0xc(%ebp),%al
     c97:	31 c2                	xor    %eax,%edx
     c99:	8b 45 08             	mov    0x8(%ebp),%eax
     c9c:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     c9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ca1:	83 c0 01             	add    $0x1,%eax
     ca4:	0f b6 08             	movzbl (%eax),%ecx
     ca7:	8b 45 08             	mov    0x8(%ebp),%eax
     caa:	83 c0 1e             	add    $0x1e,%eax
     cad:	0f b6 00             	movzbl (%eax),%eax
     cb0:	0f b6 c0             	movzbl %al,%eax
     cb3:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     cba:	8b 45 08             	mov    0x8(%ebp),%eax
     cbd:	83 c0 01             	add    $0x1,%eax
     cc0:	31 ca                	xor    %ecx,%edx
     cc2:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     cc4:	8b 45 08             	mov    0x8(%ebp),%eax
     cc7:	83 c0 02             	add    $0x2,%eax
     cca:	0f b6 08             	movzbl (%eax),%ecx
     ccd:	8b 45 08             	mov    0x8(%ebp),%eax
     cd0:	83 c0 1f             	add    $0x1f,%eax
     cd3:	0f b6 00             	movzbl (%eax),%eax
     cd6:	0f b6 c0             	movzbl %al,%eax
     cd9:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     ce0:	8b 45 08             	mov    0x8(%ebp),%eax
     ce3:	83 c0 02             	add    $0x2,%eax
     ce6:	31 ca                	xor    %ecx,%edx
     ce8:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     cea:	8b 45 08             	mov    0x8(%ebp),%eax
     ced:	83 c0 03             	add    $0x3,%eax
     cf0:	0f b6 08             	movzbl (%eax),%ecx
     cf3:	8b 45 08             	mov    0x8(%ebp),%eax
     cf6:	83 c0 1c             	add    $0x1c,%eax
     cf9:	0f b6 00             	movzbl (%eax),%eax
     cfc:	0f b6 c0             	movzbl %al,%eax
     cff:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     d06:	8b 45 08             	mov    0x8(%ebp),%eax
     d09:	83 c0 03             	add    $0x3,%eax
     d0c:	31 ca                	xor    %ecx,%edx
     d0e:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     d10:	bb 04 00 00 00       	mov    $0x4,%ebx
     d15:	e9 a9 00 00 00       	jmp    dc3 <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     d1a:	0f b6 d3             	movzbl %bl,%edx
     d1d:	8b 45 08             	mov    0x8(%ebp),%eax
     d20:	01 d0                	add    %edx,%eax
     d22:	0f b6 08             	movzbl (%eax),%ecx
     d25:	0f b6 c3             	movzbl %bl,%eax
     d28:	8d 50 fc             	lea    -0x4(%eax),%edx
     d2b:	8b 45 08             	mov    0x8(%ebp),%eax
     d2e:	01 d0                	add    %edx,%eax
     d30:	0f b6 10             	movzbl (%eax),%edx
     d33:	0f b6 f3             	movzbl %bl,%esi
     d36:	8b 45 08             	mov    0x8(%ebp),%eax
     d39:	01 f0                	add    %esi,%eax
     d3b:	31 ca                	xor    %ecx,%edx
     d3d:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     d3f:	0f b6 c3             	movzbl %bl,%eax
     d42:	8d 50 01             	lea    0x1(%eax),%edx
     d45:	8b 45 08             	mov    0x8(%ebp),%eax
     d48:	01 d0                	add    %edx,%eax
     d4a:	0f b6 08             	movzbl (%eax),%ecx
     d4d:	0f b6 c3             	movzbl %bl,%eax
     d50:	8d 50 fd             	lea    -0x3(%eax),%edx
     d53:	8b 45 08             	mov    0x8(%ebp),%eax
     d56:	01 d0                	add    %edx,%eax
     d58:	0f b6 10             	movzbl (%eax),%edx
     d5b:	0f b6 c3             	movzbl %bl,%eax
     d5e:	8d 70 01             	lea    0x1(%eax),%esi
     d61:	8b 45 08             	mov    0x8(%ebp),%eax
     d64:	01 f0                	add    %esi,%eax
     d66:	31 ca                	xor    %ecx,%edx
     d68:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     d6a:	0f b6 c3             	movzbl %bl,%eax
     d6d:	8d 50 02             	lea    0x2(%eax),%edx
     d70:	8b 45 08             	mov    0x8(%ebp),%eax
     d73:	01 d0                	add    %edx,%eax
     d75:	0f b6 08             	movzbl (%eax),%ecx
     d78:	0f b6 c3             	movzbl %bl,%eax
     d7b:	8d 50 fe             	lea    -0x2(%eax),%edx
     d7e:	8b 45 08             	mov    0x8(%ebp),%eax
     d81:	01 d0                	add    %edx,%eax
     d83:	0f b6 10             	movzbl (%eax),%edx
     d86:	0f b6 c3             	movzbl %bl,%eax
     d89:	8d 70 02             	lea    0x2(%eax),%esi
     d8c:	8b 45 08             	mov    0x8(%ebp),%eax
     d8f:	01 f0                	add    %esi,%eax
     d91:	31 ca                	xor    %ecx,%edx
     d93:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     d95:	0f b6 c3             	movzbl %bl,%eax
     d98:	8d 50 03             	lea    0x3(%eax),%edx
     d9b:	8b 45 08             	mov    0x8(%ebp),%eax
     d9e:	01 d0                	add    %edx,%eax
     da0:	0f b6 08             	movzbl (%eax),%ecx
     da3:	0f b6 c3             	movzbl %bl,%eax
     da6:	8d 50 ff             	lea    -0x1(%eax),%edx
     da9:	8b 45 08             	mov    0x8(%ebp),%eax
     dac:	01 d0                	add    %edx,%eax
     dae:	0f b6 10             	movzbl (%eax),%edx
     db1:	0f b6 c3             	movzbl %bl,%eax
     db4:	8d 70 03             	lea    0x3(%eax),%esi
     db7:	8b 45 08             	mov    0x8(%ebp),%eax
     dba:	01 f0                	add    %esi,%eax
     dbc:	31 ca                	xor    %ecx,%edx
     dbe:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     dc0:	83 c3 04             	add    $0x4,%ebx
     dc3:	80 fb 0f             	cmp    $0xf,%bl
     dc6:	0f 86 4e ff ff ff    	jbe    d1a <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     dcc:	8b 45 08             	mov    0x8(%ebp),%eax
     dcf:	83 c0 10             	add    $0x10,%eax
     dd2:	0f b6 08             	movzbl (%eax),%ecx
     dd5:	8b 45 08             	mov    0x8(%ebp),%eax
     dd8:	83 c0 0c             	add    $0xc,%eax
     ddb:	0f b6 00             	movzbl (%eax),%eax
     dde:	0f b6 c0             	movzbl %al,%eax
     de1:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     de8:	8b 45 08             	mov    0x8(%ebp),%eax
     deb:	83 c0 10             	add    $0x10,%eax
     dee:	31 ca                	xor    %ecx,%edx
     df0:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     df2:	8b 45 08             	mov    0x8(%ebp),%eax
     df5:	83 c0 11             	add    $0x11,%eax
     df8:	0f b6 08             	movzbl (%eax),%ecx
     dfb:	8b 45 08             	mov    0x8(%ebp),%eax
     dfe:	83 c0 0d             	add    $0xd,%eax
     e01:	0f b6 00             	movzbl (%eax),%eax
     e04:	0f b6 c0             	movzbl %al,%eax
     e07:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     e0e:	8b 45 08             	mov    0x8(%ebp),%eax
     e11:	83 c0 11             	add    $0x11,%eax
     e14:	31 ca                	xor    %ecx,%edx
     e16:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     e18:	8b 45 08             	mov    0x8(%ebp),%eax
     e1b:	83 c0 12             	add    $0x12,%eax
     e1e:	0f b6 08             	movzbl (%eax),%ecx
     e21:	8b 45 08             	mov    0x8(%ebp),%eax
     e24:	83 c0 0e             	add    $0xe,%eax
     e27:	0f b6 00             	movzbl (%eax),%eax
     e2a:	0f b6 c0             	movzbl %al,%eax
     e2d:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     e34:	8b 45 08             	mov    0x8(%ebp),%eax
     e37:	83 c0 12             	add    $0x12,%eax
     e3a:	31 ca                	xor    %ecx,%edx
     e3c:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
     e3e:	8b 45 08             	mov    0x8(%ebp),%eax
     e41:	83 c0 13             	add    $0x13,%eax
     e44:	0f b6 08             	movzbl (%eax),%ecx
     e47:	8b 45 08             	mov    0x8(%ebp),%eax
     e4a:	83 c0 0f             	add    $0xf,%eax
     e4d:	0f b6 00             	movzbl (%eax),%eax
     e50:	0f b6 c0             	movzbl %al,%eax
     e53:	0f b6 90 40 21 00 00 	movzbl 0x2140(%eax),%edx
     e5a:	8b 45 08             	mov    0x8(%ebp),%eax
     e5d:	83 c0 13             	add    $0x13,%eax
     e60:	31 ca                	xor    %ecx,%edx
     e62:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
     e64:	bb 14 00 00 00       	mov    $0x14,%ebx
     e69:	e9 a9 00 00 00       	jmp    f17 <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
     e6e:	0f b6 d3             	movzbl %bl,%edx
     e71:	8b 45 08             	mov    0x8(%ebp),%eax
     e74:	01 d0                	add    %edx,%eax
     e76:	0f b6 08             	movzbl (%eax),%ecx
     e79:	0f b6 c3             	movzbl %bl,%eax
     e7c:	8d 50 fc             	lea    -0x4(%eax),%edx
     e7f:	8b 45 08             	mov    0x8(%ebp),%eax
     e82:	01 d0                	add    %edx,%eax
     e84:	0f b6 10             	movzbl (%eax),%edx
     e87:	0f b6 f3             	movzbl %bl,%esi
     e8a:	8b 45 08             	mov    0x8(%ebp),%eax
     e8d:	01 f0                	add    %esi,%eax
     e8f:	31 ca                	xor    %ecx,%edx
     e91:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     e93:	0f b6 c3             	movzbl %bl,%eax
     e96:	8d 50 01             	lea    0x1(%eax),%edx
     e99:	8b 45 08             	mov    0x8(%ebp),%eax
     e9c:	01 d0                	add    %edx,%eax
     e9e:	0f b6 08             	movzbl (%eax),%ecx
     ea1:	0f b6 c3             	movzbl %bl,%eax
     ea4:	8d 50 fd             	lea    -0x3(%eax),%edx
     ea7:	8b 45 08             	mov    0x8(%ebp),%eax
     eaa:	01 d0                	add    %edx,%eax
     eac:	0f b6 10             	movzbl (%eax),%edx
     eaf:	0f b6 c3             	movzbl %bl,%eax
     eb2:	8d 70 01             	lea    0x1(%eax),%esi
     eb5:	8b 45 08             	mov    0x8(%ebp),%eax
     eb8:	01 f0                	add    %esi,%eax
     eba:	31 ca                	xor    %ecx,%edx
     ebc:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     ebe:	0f b6 c3             	movzbl %bl,%eax
     ec1:	8d 50 02             	lea    0x2(%eax),%edx
     ec4:	8b 45 08             	mov    0x8(%ebp),%eax
     ec7:	01 d0                	add    %edx,%eax
     ec9:	0f b6 08             	movzbl (%eax),%ecx
     ecc:	0f b6 c3             	movzbl %bl,%eax
     ecf:	8d 50 fe             	lea    -0x2(%eax),%edx
     ed2:	8b 45 08             	mov    0x8(%ebp),%eax
     ed5:	01 d0                	add    %edx,%eax
     ed7:	0f b6 10             	movzbl (%eax),%edx
     eda:	0f b6 c3             	movzbl %bl,%eax
     edd:	8d 70 02             	lea    0x2(%eax),%esi
     ee0:	8b 45 08             	mov    0x8(%ebp),%eax
     ee3:	01 f0                	add    %esi,%eax
     ee5:	31 ca                	xor    %ecx,%edx
     ee7:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     ee9:	0f b6 c3             	movzbl %bl,%eax
     eec:	8d 50 03             	lea    0x3(%eax),%edx
     eef:	8b 45 08             	mov    0x8(%ebp),%eax
     ef2:	01 d0                	add    %edx,%eax
     ef4:	0f b6 08             	movzbl (%eax),%ecx
     ef7:	0f b6 c3             	movzbl %bl,%eax
     efa:	8d 50 ff             	lea    -0x1(%eax),%edx
     efd:	8b 45 08             	mov    0x8(%ebp),%eax
     f00:	01 d0                	add    %edx,%eax
     f02:	0f b6 10             	movzbl (%eax),%edx
     f05:	0f b6 c3             	movzbl %bl,%eax
     f08:	8d 70 03             	lea    0x3(%eax),%esi
     f0b:	8b 45 08             	mov    0x8(%ebp),%eax
     f0e:	01 f0                	add    %esi,%eax
     f10:	31 ca                	xor    %ecx,%edx
     f12:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
     f14:	83 c3 04             	add    $0x4,%ebx
     f17:	80 fb 1f             	cmp    $0x1f,%bl
     f1a:	0f 86 4e ff ff ff    	jbe    e6e <aes_expandEncKey+0x201>
    }
}
     f20:	90                   	nop
     f21:	90                   	nop
     f22:	83 c4 04             	add    $0x4,%esp
     f25:	5b                   	pop    %ebx
     f26:	5e                   	pop    %esi
     f27:	5d                   	pop    %ebp
     f28:	c3                   	ret    

00000f29 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
     f29:	55                   	push   %ebp
     f2a:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
     f2c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f30:	74 4d                	je     f7f <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
     f32:	8b 45 08             	mov    0x8(%ebp),%eax
     f35:	83 c0 03             	add    $0x3,%eax
     f38:	0f b6 10             	movzbl (%eax),%edx
     f3b:	83 c2 01             	add    $0x1,%edx
     f3e:	88 10                	mov    %dl,(%eax)
     f40:	0f b6 00             	movzbl (%eax),%eax
     f43:	84 c0                	test   %al,%al
     f45:	75 38                	jne    f7f <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
     f47:	8b 45 08             	mov    0x8(%ebp),%eax
     f4a:	83 c0 02             	add    $0x2,%eax
     f4d:	0f b6 10             	movzbl (%eax),%edx
     f50:	83 c2 01             	add    $0x1,%edx
     f53:	88 10                	mov    %dl,(%eax)
     f55:	0f b6 00             	movzbl (%eax),%eax
     f58:	84 c0                	test   %al,%al
     f5a:	75 23                	jne    f7f <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
     f5c:	8b 45 08             	mov    0x8(%ebp),%eax
     f5f:	83 c0 01             	add    $0x1,%eax
     f62:	0f b6 10             	movzbl (%eax),%edx
     f65:	83 c2 01             	add    $0x1,%edx
     f68:	88 10                	mov    %dl,(%eax)
     f6a:	0f b6 00             	movzbl (%eax),%eax
     f6d:	84 c0                	test   %al,%al
     f6f:	75 0e                	jne    f7f <ctr_inc_ctr+0x56>
                    val[0]++;
     f71:	8b 45 08             	mov    0x8(%ebp),%eax
     f74:	0f b6 00             	movzbl (%eax),%eax
     f77:	8d 50 01             	lea    0x1(%eax),%edx
     f7a:	8b 45 08             	mov    0x8(%ebp),%eax
     f7d:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
     f7f:	90                   	nop
     f80:	5d                   	pop    %ebp
     f81:	c3                   	ret    

00000f82 <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
     f82:	55                   	push   %ebp
     f83:	89 e5                	mov    %esp,%ebp
     f85:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
     f88:	8b 45 08             	mov    0x8(%ebp),%eax
     f8b:	83 c0 40             	add    $0x40,%eax
     f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
     f91:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f95:	74 56                	je     fed <ctr_clock_keystream+0x6b>
     f97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f9b:	74 50                	je     fed <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
     f9d:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
     fa1:	eb 21                	jmp    fc4 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
     fa3:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     fa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     faa:	01 d0                	add    %edx,%eax
     fac:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
     fb0:	8b 55 0c             	mov    0xc(%ebp),%edx
     fb3:	01 ca                	add    %ecx,%edx
     fb5:	0f b6 00             	movzbl (%eax),%eax
     fb8:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
     fba:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     fbe:	83 c0 01             	add    $0x1,%eax
     fc1:	88 45 f7             	mov    %al,-0x9(%ebp)
     fc4:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
     fc8:	76 d9                	jbe    fa3 <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
     fca:	83 ec 08             	sub    $0x8,%esp
     fcd:	ff 75 0c             	push   0xc(%ebp)
     fd0:	ff 75 08             	push   0x8(%ebp)
     fd3:	e8 16 01 00 00       	call   10ee <aes256_encrypt_ecb>
     fd8:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
     fdb:	8b 45 08             	mov    0x8(%ebp),%eax
     fde:	83 c0 4c             	add    $0x4c,%eax
     fe1:	83 ec 0c             	sub    $0xc,%esp
     fe4:	50                   	push   %eax
     fe5:	e8 3f ff ff ff       	call   f29 <ctr_inc_ctr>
     fea:	83 c4 10             	add    $0x10,%esp
    }
}
     fed:	90                   	nop
     fee:	c9                   	leave  
     fef:	c3                   	ret    

00000ff0 <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
     ff6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
     ffc:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
    1003:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
    100a:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
    1011:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
    1018:	83 ec 08             	sub    $0x8,%esp
    101b:	ff 75 08             	push   0x8(%ebp)
    101e:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1021:	50                   	push   %eax
    1022:	e8 2e 00 00 00       	call   1055 <aes256_init>
    1027:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
    102a:	83 ec 08             	sub    $0x8,%esp
    102d:	8d 45 94             	lea    -0x6c(%ebp),%eax
    1030:	50                   	push   %eax
    1031:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1034:	50                   	push   %eax
    1035:	e8 8d 01 00 00       	call   11c7 <aes256_setCtrBlk>
    103a:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
    103d:	83 ec 04             	sub    $0x4,%esp
    1040:	ff 75 10             	push   0x10(%ebp)
    1043:	ff 75 f4             	push   -0xc(%ebp)
    1046:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1049:	50                   	push   %eax
    104a:	e8 c9 01 00 00       	call   1218 <aes256_encrypt_ctr>
    104f:	83 c4 10             	add    $0x10,%esp
}
    1052:	90                   	nop
    1053:	c9                   	leave  
    1054:	c3                   	ret    

00001055 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
    1055:	55                   	push   %ebp
    1056:	89 e5                	mov    %esp,%ebp
    1058:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1059:	bb 00 00 00 00       	mov    $0x0,%ebx
    105e:	eb 1a                	jmp    107a <aes256_init+0x25>
        ctx->enckey[i] = key[i];
    1060:	0f b6 d3             	movzbl %bl,%edx
    1063:	8b 45 0c             	mov    0xc(%ebp),%eax
    1066:	01 c2                	add    %eax,%edx
    1068:	0f b6 c3             	movzbl %bl,%eax
    106b:	0f b6 0a             	movzbl (%edx),%ecx
    106e:	8b 55 08             	mov    0x8(%ebp),%edx
    1071:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1075:	89 d8                	mov    %ebx,%eax
    1077:	8d 58 01             	lea    0x1(%eax),%ebx
    107a:	80 fb 1f             	cmp    $0x1f,%bl
    107d:	76 e1                	jbe    1060 <aes256_init+0xb>
    }
}
    107f:	90                   	nop
    1080:	90                   	nop
    1081:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1084:	c9                   	leave  
    1085:	c3                   	ret    

00001086 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    1086:	55                   	push   %ebp
    1087:	89 e5                	mov    %esp,%ebp
    1089:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    108a:	bb 00 00 00 00       	mov    $0x0,%ebx
    108f:	eb 51                	jmp    10e2 <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    1091:	0f b6 c3             	movzbl %bl,%eax
    1094:	8b 55 08             	mov    0x8(%ebp),%edx
    1097:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    109c:	0f b6 d3             	movzbl %bl,%edx
    109f:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a2:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    10a7:	8b 45 08             	mov    0x8(%ebp),%eax
    10aa:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    10ad:	0f b6 c3             	movzbl %bl,%eax
    10b0:	83 e0 03             	and    $0x3,%eax
    10b3:	89 c2                	mov    %eax,%edx
    10b5:	8b 45 08             	mov    0x8(%ebp),%eax
    10b8:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    10bd:	0f b6 c3             	movzbl %bl,%eax
    10c0:	83 e0 07             	and    $0x7,%eax
    10c3:	89 c2                	mov    %eax,%edx
    10c5:	8b 45 08             	mov    0x8(%ebp),%eax
    10c8:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    10cd:	0f b6 c3             	movzbl %bl,%eax
    10d0:	83 e0 03             	and    $0x3,%eax
    10d3:	89 c2                	mov    %eax,%edx
    10d5:	8b 45 08             	mov    0x8(%ebp),%eax
    10d8:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    10dd:	89 d8                	mov    %ebx,%eax
    10df:	8d 58 01             	lea    0x1(%eax),%ebx
    10e2:	80 fb 1f             	cmp    $0x1f,%bl
    10e5:	76 aa                	jbe    1091 <aes256_done+0xb>
    }
}
    10e7:	90                   	nop
    10e8:	90                   	nop
    10e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10ec:	c9                   	leave  
    10ed:	c3                   	ret    

000010ee <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    10ee:	55                   	push   %ebp
    10ef:	89 e5                	mov    %esp,%ebp
    10f1:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    10f4:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    10f8:	8b 45 08             	mov    0x8(%ebp),%eax
    10fb:	8b 55 08             	mov    0x8(%ebp),%edx
    10fe:	83 c2 20             	add    $0x20,%edx
    1101:	50                   	push   %eax
    1102:	52                   	push   %edx
    1103:	ff 75 0c             	push   0xc(%ebp)
    1106:	e8 bb f8 ff ff       	call   9c6 <aes_addRoundKey_cpy>
    110b:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    110e:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    1112:	eb 74                	jmp    1188 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    1114:	ff 75 0c             	push   0xc(%ebp)
    1117:	e8 31 f8 ff ff       	call   94d <aes_subBytes>
    111c:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    111f:	ff 75 0c             	push   0xc(%ebp)
    1122:	e8 11 f9 ff ff       	call   a38 <aes_shiftRows>
    1127:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    112a:	ff 75 0c             	push   0xc(%ebp)
    112d:	e8 d5 f9 ff ff       	call   b07 <aes_mixColumns>
    1132:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    1135:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1139:	83 e0 01             	and    $0x1,%eax
    113c:	85 c0                	test   %eax,%eax
    113e:	74 14                	je     1154 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	83 c0 10             	add    $0x10,%eax
    1146:	50                   	push   %eax
    1147:	ff 75 0c             	push   0xc(%ebp)
    114a:	e8 39 f8 ff ff       	call   988 <aes_addRoundKey>
    114f:	83 c4 08             	add    $0x8,%esp
    1152:	eb 30                	jmp    1184 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    1154:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	52                   	push   %edx
    115c:	50                   	push   %eax
    115d:	e8 0b fb ff ff       	call   c6d <aes_expandEncKey>
    1162:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    1165:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    1169:	50                   	push   %eax
    116a:	e8 ae f7 ff ff       	call   91d <rj_xtime>
    116f:	83 c4 04             	add    $0x4,%esp
    1172:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    1175:	8b 45 08             	mov    0x8(%ebp),%eax
    1178:	50                   	push   %eax
    1179:	ff 75 0c             	push   0xc(%ebp)
    117c:	e8 07 f8 ff ff       	call   988 <aes_addRoundKey>
    1181:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    1184:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    1188:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    118c:	76 86                	jbe    1114 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    118e:	ff 75 0c             	push   0xc(%ebp)
    1191:	e8 b7 f7 ff ff       	call   94d <aes_subBytes>
    1196:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    1199:	ff 75 0c             	push   0xc(%ebp)
    119c:	e8 97 f8 ff ff       	call   a38 <aes_shiftRows>
    11a1:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    11a4:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    11a8:	8b 45 08             	mov    0x8(%ebp),%eax
    11ab:	52                   	push   %edx
    11ac:	50                   	push   %eax
    11ad:	e8 bb fa ff ff       	call   c6d <aes_expandEncKey>
    11b2:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    11b5:	8b 45 08             	mov    0x8(%ebp),%eax
    11b8:	50                   	push   %eax
    11b9:	ff 75 0c             	push   0xc(%ebp)
    11bc:	e8 c7 f7 ff ff       	call   988 <aes_addRoundKey>
    11c1:	83 c4 08             	add    $0x8,%esp
}
    11c4:	90                   	nop
    11c5:	c9                   	leave  
    11c6:	c3                   	ret    

000011c7 <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    11c7:	55                   	push   %ebp
    11c8:	89 e5                	mov    %esp,%ebp
    11ca:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
    11d0:	83 c0 40             	add    $0x40,%eax
    11d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    11d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d9:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    11dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    11e0:	74 33                	je     1215 <aes256_setCtrBlk+0x4e>
    11e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11e6:	74 2d                	je     1215 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    11e8:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    11ec:	eb 21                	jmp    120f <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    11ee:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    11f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11f5:	01 d0                	add    %edx,%eax
    11f7:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    11fb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    11fe:	01 ca                	add    %ecx,%edx
    1200:	0f b6 00             	movzbl (%eax),%eax
    1203:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1205:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1209:	83 c0 01             	add    $0x1,%eax
    120c:	88 45 ff             	mov    %al,-0x1(%ebp)
    120f:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    1213:	76 d9                	jbe    11ee <aes256_setCtrBlk+0x27>
        }
    }
}
    1215:	90                   	nop
    1216:	c9                   	leave  
    1217:	c3                   	ret    

00001218 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    1218:	55                   	push   %ebp
    1219:	89 e5                	mov    %esp,%ebp
    121b:	53                   	push   %ebx
    121c:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    121f:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    1223:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    122a:	eb 49                	jmp    1275 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    122c:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    1230:	75 16                	jne    1248 <aes256_encrypt_ctr+0x30>
            j = 0;
    1232:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    1236:	83 ec 08             	sub    $0x8,%esp
    1239:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    123c:	50                   	push   %eax
    123d:	ff 75 08             	push   0x8(%ebp)
    1240:	e8 3d fd ff ff       	call   f82 <ctr_clock_keystream>
    1245:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    1248:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    124c:	8d 50 01             	lea    0x1(%eax),%edx
    124f:	88 55 f3             	mov    %dl,-0xd(%ebp)
    1252:	0f b6 c0             	movzbl %al,%eax
    1255:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    125a:	8b 55 0c             	mov    0xc(%ebp),%edx
    125d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1260:	01 d0                	add    %edx,%eax
    1262:	0f b6 10             	movzbl (%eax),%edx
    1265:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1268:	8b 45 f4             	mov    -0xc(%ebp),%eax
    126b:	01 d8                	add    %ebx,%eax
    126d:	31 ca                	xor    %ecx,%edx
    126f:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    1271:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1275:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1278:	3b 45 10             	cmp    0x10(%ebp),%eax
    127b:	72 af                	jb     122c <aes256_encrypt_ctr+0x14>
    }
}
    127d:	90                   	nop
    127e:	90                   	nop
    127f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1282:	c9                   	leave  
    1283:	c3                   	ret    

00001284 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    1284:	55                   	push   %ebp
    1285:	89 e5                	mov    %esp,%ebp
    1287:	8b 45 0c             	mov    0xc(%ebp),%eax
    128a:	83 e0 1f             	and    $0x1f,%eax
    128d:	8b 55 08             	mov    0x8(%ebp),%edx
    1290:	89 c1                	mov    %eax,%ecx
    1292:	d3 ea                	shr    %cl,%edx
    1294:	89 d0                	mov    %edx,%eax
    1296:	5d                   	pop    %ebp
    1297:	c3                   	ret    

00001298 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    1298:	55                   	push   %ebp
    1299:	89 e5                	mov    %esp,%ebp
    129b:	8b 45 0c             	mov    0xc(%ebp),%eax
    129e:	83 e0 1f             	and    $0x1f,%eax
    12a1:	8b 55 08             	mov    0x8(%ebp),%edx
    12a4:	89 c1                	mov    %eax,%ecx
    12a6:	d3 e2                	shl    %cl,%edx
    12a8:	89 d0                	mov    %edx,%eax
    12aa:	5d                   	pop    %ebp
    12ab:	c3                   	ret    

000012ac <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    12ac:	55                   	push   %ebp
    12ad:	89 e5                	mov    %esp,%ebp
    12af:	53                   	push   %ebx
    12b0:	83 ec 04             	sub    $0x4,%esp
    12b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b6:	88 45 f8             	mov    %al,-0x8(%ebp)
    12b9:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    12bd:	8b 55 08             	mov    0x8(%ebp),%edx
    12c0:	89 d3                	mov    %edx,%ebx
    12c2:	89 c1                	mov    %eax,%ecx
    12c4:	d3 eb                	shr    %cl,%ebx
    12c6:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    12ca:	b8 20 00 00 00       	mov    $0x20,%eax
    12cf:	29 d0                	sub    %edx,%eax
    12d1:	50                   	push   %eax
    12d2:	ff 75 08             	push   0x8(%ebp)
    12d5:	e8 be ff ff ff       	call   1298 <_shw>
    12da:	83 c4 08             	add    $0x8,%esp
    12dd:	09 d8                	or     %ebx,%eax
    12df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12e2:	c9                   	leave  
    12e3:	c3                   	ret    

000012e4 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    12e4:	55                   	push   %ebp
    12e5:	89 e5                	mov    %esp,%ebp
    12e7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ea:	23 45 0c             	and    0xc(%ebp),%eax
    12ed:	89 c2                	mov    %eax,%edx
    12ef:	8b 45 08             	mov    0x8(%ebp),%eax
    12f2:	f7 d0                	not    %eax
    12f4:	23 45 10             	and    0x10(%ebp),%eax
    12f7:	31 d0                	xor    %edx,%eax
    12f9:	5d                   	pop    %ebp
    12fa:	c3                   	ret    

000012fb <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    12fb:	55                   	push   %ebp
    12fc:	89 e5                	mov    %esp,%ebp
    12fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1301:	33 45 10             	xor    0x10(%ebp),%eax
    1304:	23 45 08             	and    0x8(%ebp),%eax
    1307:	89 c2                	mov    %eax,%edx
    1309:	8b 45 0c             	mov    0xc(%ebp),%eax
    130c:	23 45 10             	and    0x10(%ebp),%eax
    130f:	31 d0                	xor    %edx,%eax
    1311:	5d                   	pop    %ebp
    1312:	c3                   	ret    

00001313 <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    1313:	55                   	push   %ebp
    1314:	89 e5                	mov    %esp,%ebp
    1316:	53                   	push   %ebx
    1317:	6a 02                	push   $0x2
    1319:	ff 75 08             	push   0x8(%ebp)
    131c:	e8 8b ff ff ff       	call   12ac <_r>
    1321:	83 c4 08             	add    $0x8,%esp
    1324:	89 c3                	mov    %eax,%ebx
    1326:	6a 0d                	push   $0xd
    1328:	ff 75 08             	push   0x8(%ebp)
    132b:	e8 7c ff ff ff       	call   12ac <_r>
    1330:	83 c4 08             	add    $0x8,%esp
    1333:	31 c3                	xor    %eax,%ebx
    1335:	6a 16                	push   $0x16
    1337:	ff 75 08             	push   0x8(%ebp)
    133a:	e8 6d ff ff ff       	call   12ac <_r>
    133f:	83 c4 08             	add    $0x8,%esp
    1342:	31 d8                	xor    %ebx,%eax
    1344:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1347:	c9                   	leave  
    1348:	c3                   	ret    

00001349 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    1349:	55                   	push   %ebp
    134a:	89 e5                	mov    %esp,%ebp
    134c:	53                   	push   %ebx
    134d:	6a 06                	push   $0x6
    134f:	ff 75 08             	push   0x8(%ebp)
    1352:	e8 55 ff ff ff       	call   12ac <_r>
    1357:	83 c4 08             	add    $0x8,%esp
    135a:	89 c3                	mov    %eax,%ebx
    135c:	6a 0b                	push   $0xb
    135e:	ff 75 08             	push   0x8(%ebp)
    1361:	e8 46 ff ff ff       	call   12ac <_r>
    1366:	83 c4 08             	add    $0x8,%esp
    1369:	31 c3                	xor    %eax,%ebx
    136b:	6a 19                	push   $0x19
    136d:	ff 75 08             	push   0x8(%ebp)
    1370:	e8 37 ff ff ff       	call   12ac <_r>
    1375:	83 c4 08             	add    $0x8,%esp
    1378:	31 d8                	xor    %ebx,%eax
    137a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    137d:	c9                   	leave  
    137e:	c3                   	ret    

0000137f <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    137f:	55                   	push   %ebp
    1380:	89 e5                	mov    %esp,%ebp
    1382:	53                   	push   %ebx
    1383:	6a 07                	push   $0x7
    1385:	ff 75 08             	push   0x8(%ebp)
    1388:	e8 1f ff ff ff       	call   12ac <_r>
    138d:	83 c4 08             	add    $0x8,%esp
    1390:	89 c3                	mov    %eax,%ebx
    1392:	6a 12                	push   $0x12
    1394:	ff 75 08             	push   0x8(%ebp)
    1397:	e8 10 ff ff ff       	call   12ac <_r>
    139c:	83 c4 08             	add    $0x8,%esp
    139f:	89 da                	mov    %ebx,%edx
    13a1:	31 c2                	xor    %eax,%edx
    13a3:	8b 45 08             	mov    0x8(%ebp),%eax
    13a6:	c1 e8 03             	shr    $0x3,%eax
    13a9:	31 d0                	xor    %edx,%eax
    13ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13ae:	c9                   	leave  
    13af:	c3                   	ret    

000013b0 <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	53                   	push   %ebx
    13b4:	6a 11                	push   $0x11
    13b6:	ff 75 08             	push   0x8(%ebp)
    13b9:	e8 ee fe ff ff       	call   12ac <_r>
    13be:	83 c4 08             	add    $0x8,%esp
    13c1:	89 c3                	mov    %eax,%ebx
    13c3:	6a 13                	push   $0x13
    13c5:	ff 75 08             	push   0x8(%ebp)
    13c8:	e8 df fe ff ff       	call   12ac <_r>
    13cd:	83 c4 08             	add    $0x8,%esp
    13d0:	89 da                	mov    %ebx,%edx
    13d2:	31 c2                	xor    %eax,%edx
    13d4:	8b 45 08             	mov    0x8(%ebp),%eax
    13d7:	c1 e8 0a             	shr    $0xa,%eax
    13da:	31 d0                	xor    %edx,%eax
    13dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13df:	c9                   	leave  
    13e0:	c3                   	ret    

000013e1 <_word>:

FN_ uint _word(uchar* c) {
    13e1:	55                   	push   %ebp
    13e2:	89 e5                	mov    %esp,%ebp
    13e4:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    13e5:	8b 45 08             	mov    0x8(%ebp),%eax
    13e8:	0f b6 00             	movzbl (%eax),%eax
    13eb:	0f b6 c0             	movzbl %al,%eax
    13ee:	6a 18                	push   $0x18
    13f0:	50                   	push   %eax
    13f1:	e8 a2 fe ff ff       	call   1298 <_shw>
    13f6:	83 c4 08             	add    $0x8,%esp
    13f9:	89 c3                	mov    %eax,%ebx
    13fb:	8b 45 08             	mov    0x8(%ebp),%eax
    13fe:	83 c0 01             	add    $0x1,%eax
    1401:	0f b6 00             	movzbl (%eax),%eax
    1404:	0f b6 c0             	movzbl %al,%eax
    1407:	6a 10                	push   $0x10
    1409:	50                   	push   %eax
    140a:	e8 89 fe ff ff       	call   1298 <_shw>
    140f:	83 c4 08             	add    $0x8,%esp
    1412:	09 c3                	or     %eax,%ebx
    1414:	8b 45 08             	mov    0x8(%ebp),%eax
    1417:	83 c0 02             	add    $0x2,%eax
    141a:	0f b6 00             	movzbl (%eax),%eax
    141d:	0f b6 c0             	movzbl %al,%eax
    1420:	6a 08                	push   $0x8
    1422:	50                   	push   %eax
    1423:	e8 70 fe ff ff       	call   1298 <_shw>
    1428:	83 c4 08             	add    $0x8,%esp
    142b:	89 da                	mov    %ebx,%edx
    142d:	09 c2                	or     %eax,%edx
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	83 c0 03             	add    $0x3,%eax
    1435:	0f b6 00             	movzbl (%eax),%eax
    1438:	0f b6 c0             	movzbl %al,%eax
    143b:	09 d0                	or     %edx,%eax
}
    143d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1440:	c9                   	leave  
    1441:	c3                   	ret    

00001442 <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    1442:	55                   	push   %ebp
    1443:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    1445:	8b 45 08             	mov    0x8(%ebp),%eax
    1448:	8b 40 60             	mov    0x60(%eax),%eax
    144b:	8b 55 0c             	mov    0xc(%ebp),%edx
    144e:	f7 d2                	not    %edx
    1450:	39 d0                	cmp    %edx,%eax
    1452:	76 0f                	jbe    1463 <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    1454:	8b 45 08             	mov    0x8(%ebp),%eax
    1457:	8b 40 64             	mov    0x64(%eax),%eax
    145a:	8d 50 01             	lea    0x1(%eax),%edx
    145d:	8b 45 08             	mov    0x8(%ebp),%eax
    1460:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    1463:	8b 45 08             	mov    0x8(%ebp),%eax
    1466:	8b 50 60             	mov    0x60(%eax),%edx
    1469:	8b 45 0c             	mov    0xc(%ebp),%eax
    146c:	01 c2                	add    %eax,%edx
    146e:	8b 45 08             	mov    0x8(%ebp),%eax
    1471:	89 50 60             	mov    %edx,0x60(%eax)
}
    1474:	90                   	nop
    1475:	5d                   	pop    %ebp
    1476:	c3                   	ret    

00001477 <_hash>:

static void _hash(sha256_context* ctx) {
    1477:	55                   	push   %ebp
    1478:	89 e5                	mov    %esp,%ebp
    147a:	57                   	push   %edi
    147b:	56                   	push   %esi
    147c:	53                   	push   %ebx
    147d:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
    1483:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	8b 40 44             	mov    0x44(%eax),%eax
    148c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    148f:	8b 45 08             	mov    0x8(%ebp),%eax
    1492:	8b 40 48             	mov    0x48(%eax),%eax
    1495:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    1498:	8b 45 08             	mov    0x8(%ebp),%eax
    149b:	8b 40 4c             	mov    0x4c(%eax),%eax
    149e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    14a1:	8b 45 08             	mov    0x8(%ebp),%eax
    14a4:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    14a7:	8b 45 08             	mov    0x8(%ebp),%eax
    14aa:	8b 40 54             	mov    0x54(%eax),%eax
    14ad:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    14b0:	8b 45 08             	mov    0x8(%ebp),%eax
    14b3:	8b 40 58             	mov    0x58(%eax),%eax
    14b6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    14b9:	8b 45 08             	mov    0x8(%ebp),%eax
    14bc:	8b 40 5c             	mov    0x5c(%eax),%eax
    14bf:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    14c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14c9:	e9 27 01 00 00       	jmp    15f5 <_hash+0x17e>
        if (i < 16) {
    14ce:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    14d2:	77 2d                	ja     1501 <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    14d4:	6a 02                	push   $0x2
    14d6:	ff 75 f0             	push   -0x10(%ebp)
    14d9:	e8 ba fd ff ff       	call   1298 <_shw>
    14de:	83 c4 08             	add    $0x8,%esp
    14e1:	89 c2                	mov    %eax,%edx
    14e3:	8b 45 08             	mov    0x8(%ebp),%eax
    14e6:	01 d0                	add    %edx,%eax
    14e8:	50                   	push   %eax
    14e9:	e8 f3 fe ff ff       	call   13e1 <_word>
    14ee:	83 c4 04             	add    $0x4,%esp
    14f1:	89 c1                	mov    %eax,%ecx
    14f3:	8b 55 08             	mov    0x8(%ebp),%edx
    14f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14f9:	83 c0 1c             	add    $0x1c,%eax
    14fc:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    14ff:	eb 64                	jmp    1565 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1501:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1504:	83 e8 02             	sub    $0x2,%eax
    1507:	8b 55 08             	mov    0x8(%ebp),%edx
    150a:	83 c0 1c             	add    $0x1c,%eax
    150d:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1510:	50                   	push   %eax
    1511:	e8 9a fe ff ff       	call   13b0 <_G1>
    1516:	83 c4 04             	add    $0x4,%esp
    1519:	89 c1                	mov    %eax,%ecx
    151b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    151e:	83 e8 07             	sub    $0x7,%eax
    1521:	8b 55 08             	mov    0x8(%ebp),%edx
    1524:	83 c0 1c             	add    $0x1c,%eax
    1527:	8b 04 82             	mov    (%edx,%eax,4),%eax
    152a:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    152d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1530:	83 e8 0f             	sub    $0xf,%eax
    1533:	8b 55 08             	mov    0x8(%ebp),%edx
    1536:	83 c0 1c             	add    $0x1c,%eax
    1539:	8b 04 82             	mov    (%edx,%eax,4),%eax
    153c:	50                   	push   %eax
    153d:	e8 3d fe ff ff       	call   137f <_G0>
    1542:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1545:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    1548:	8b 45 f0             	mov    -0x10(%ebp),%eax
    154b:	83 e8 10             	sub    $0x10,%eax
    154e:	8b 55 08             	mov    0x8(%ebp),%edx
    1551:	83 c0 1c             	add    $0x1c,%eax
    1554:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1557:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1559:	8b 55 08             	mov    0x8(%ebp),%edx
    155c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    155f:	83 c0 1c             	add    $0x1c,%eax
    1562:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    1565:	57                   	push   %edi
    1566:	e8 de fd ff ff       	call   1349 <_S1>
    156b:	83 c4 04             	add    $0x4,%esp
    156e:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    1571:	01 c3                	add    %eax,%ebx
    1573:	ff 75 d4             	push   -0x2c(%ebp)
    1576:	ff 75 d8             	push   -0x28(%ebp)
    1579:	57                   	push   %edi
    157a:	e8 65 fd ff ff       	call   12e4 <_Ch>
    157f:	83 c4 0c             	add    $0xc,%esp
    1582:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    1585:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1588:	8b 04 85 40 22 00 00 	mov    0x2240(,%eax,4),%eax
    158f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1592:	8b 55 08             	mov    0x8(%ebp),%edx
    1595:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1598:	83 c0 1c             	add    $0x1c,%eax
    159b:	8b 04 82             	mov    (%edx,%eax,4),%eax
    159e:	01 c8                	add    %ecx,%eax
    15a0:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    15a3:	56                   	push   %esi
    15a4:	e8 6a fd ff ff       	call   1313 <_S0>
    15a9:	83 c4 04             	add    $0x4,%esp
    15ac:	89 c3                	mov    %eax,%ebx
    15ae:	ff 75 dc             	push   -0x24(%ebp)
    15b1:	ff 75 e0             	push   -0x20(%ebp)
    15b4:	56                   	push   %esi
    15b5:	e8 41 fd ff ff       	call   12fb <_Ma>
    15ba:	83 c4 0c             	add    $0xc,%esp
    15bd:	01 d8                	add    %ebx,%eax
    15bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    15c2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15c5:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    15c8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    15cb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    15ce:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    15d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d4:	8b 7d d0             	mov    -0x30(%ebp),%edi
    15d7:	01 c7                	add    %eax,%edi
        d = c;
    15d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    15dc:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    15df:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15e2:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    15e5:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    15e8:	8b 55 e8             	mov    -0x18(%ebp),%edx
    15eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15ee:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    15f1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15f5:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    15f9:	0f 86 cf fe ff ff    	jbe    14ce <_hash+0x57>
    }

    ctx->hash[0] += a;
    15ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1602:	8b 40 40             	mov    0x40(%eax),%eax
    1605:	8d 14 06             	lea    (%esi,%eax,1),%edx
    1608:	8b 45 08             	mov    0x8(%ebp),%eax
    160b:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    160e:	8b 45 08             	mov    0x8(%ebp),%eax
    1611:	8b 40 44             	mov    0x44(%eax),%eax
    1614:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1617:	01 c2                	add    %eax,%edx
    1619:	8b 45 08             	mov    0x8(%ebp),%eax
    161c:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    161f:	8b 45 08             	mov    0x8(%ebp),%eax
    1622:	8b 40 48             	mov    0x48(%eax),%eax
    1625:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1628:	01 c2                	add    %eax,%edx
    162a:	8b 45 08             	mov    0x8(%ebp),%eax
    162d:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    1630:	8b 45 08             	mov    0x8(%ebp),%eax
    1633:	8b 40 4c             	mov    0x4c(%eax),%eax
    1636:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1639:	01 c2                	add    %eax,%edx
    163b:	8b 45 08             	mov    0x8(%ebp),%eax
    163e:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    1641:	8b 45 08             	mov    0x8(%ebp),%eax
    1644:	8b 40 50             	mov    0x50(%eax),%eax
    1647:	8d 14 07             	lea    (%edi,%eax,1),%edx
    164a:	8b 45 08             	mov    0x8(%ebp),%eax
    164d:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    1650:	8b 45 08             	mov    0x8(%ebp),%eax
    1653:	8b 40 54             	mov    0x54(%eax),%eax
    1656:	8b 55 d8             	mov    -0x28(%ebp),%edx
    1659:	01 c2                	add    %eax,%edx
    165b:	8b 45 08             	mov    0x8(%ebp),%eax
    165e:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    1661:	8b 45 08             	mov    0x8(%ebp),%eax
    1664:	8b 40 58             	mov    0x58(%eax),%eax
    1667:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    166a:	01 c2                	add    %eax,%edx
    166c:	8b 45 08             	mov    0x8(%ebp),%eax
    166f:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    1672:	8b 45 08             	mov    0x8(%ebp),%eax
    1675:	8b 40 5c             	mov    0x5c(%eax),%eax
    1678:	8b 55 cc             	mov    -0x34(%ebp),%edx
    167b:	01 c2                	add    %eax,%edx
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    1683:	90                   	nop
    1684:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1687:	5b                   	pop    %ebx
    1688:	5e                   	pop    %esi
    1689:	5f                   	pop    %edi
    168a:	5d                   	pop    %ebp
    168b:	c3                   	ret    

0000168c <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    168c:	55                   	push   %ebp
    168d:	89 e5                	mov    %esp,%ebp
    168f:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    1695:	83 ec 0c             	sub    $0xc,%esp
    1698:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    169e:	50                   	push   %eax
    169f:	e8 33 00 00 00       	call   16d7 <sha256_init>
    16a4:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    16a7:	83 ec 04             	sub    $0x4,%esp
    16aa:	ff 75 0c             	push   0xc(%ebp)
    16ad:	ff 75 08             	push   0x8(%ebp)
    16b0:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    16b6:	50                   	push   %eax
    16b7:	e8 99 00 00 00       	call   1755 <sha256_hash>
    16bc:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    16bf:	83 ec 08             	sub    $0x8,%esp
    16c2:	ff 75 10             	push   0x10(%ebp)
    16c5:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    16cb:	50                   	push   %eax
    16cc:	e8 14 01 00 00       	call   17e5 <sha256_done>
    16d1:	83 c4 10             	add    $0x10,%esp
}
    16d4:	90                   	nop
    16d5:	c9                   	leave  
    16d6:	c3                   	ret    

000016d7 <sha256_init>:

void sha256_init(sha256_context* ctx) {
    16d7:	55                   	push   %ebp
    16d8:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    16da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    16de:	74 72                	je     1752 <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    16e0:	8b 45 08             	mov    0x8(%ebp),%eax
    16e3:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    16ea:	8b 45 08             	mov    0x8(%ebp),%eax
    16ed:	8b 50 68             	mov    0x68(%eax),%edx
    16f0:	8b 45 08             	mov    0x8(%ebp),%eax
    16f3:	89 50 64             	mov    %edx,0x64(%eax)
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	8b 50 64             	mov    0x64(%eax),%edx
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    1702:	8b 45 08             	mov    0x8(%ebp),%eax
    1705:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    170c:	8b 45 08             	mov    0x8(%ebp),%eax
    170f:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    1716:	8b 45 08             	mov    0x8(%ebp),%eax
    1719:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    1720:	8b 45 08             	mov    0x8(%ebp),%eax
    1723:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    1734:	8b 45 08             	mov    0x8(%ebp),%eax
    1737:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    173e:	8b 45 08             	mov    0x8(%ebp),%eax
    1741:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    1748:	8b 45 08             	mov    0x8(%ebp),%eax
    174b:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    1752:	90                   	nop
    1753:	5d                   	pop    %ebp
    1754:	c3                   	ret    

00001755 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    1755:	55                   	push   %ebp
    1756:	89 e5                	mov    %esp,%ebp
    1758:	53                   	push   %ebx
    1759:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    175c:	8b 45 0c             	mov    0xc(%ebp),%eax
    175f:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    1762:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1766:	74 77                	je     17df <sha256_hash+0x8a>
    1768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    176c:	74 71                	je     17df <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    176e:	8b 45 08             	mov    0x8(%ebp),%eax
    1771:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    1774:	83 f8 3f             	cmp    $0x3f,%eax
    1777:	77 66                	ja     17df <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    1779:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    1780:	eb 55                	jmp    17d7 <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    1782:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1785:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1788:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    178b:	8b 45 08             	mov    0x8(%ebp),%eax
    178e:	8b 40 68             	mov    0x68(%eax),%eax
    1791:	8d 48 01             	lea    0x1(%eax),%ecx
    1794:	8b 55 08             	mov    0x8(%ebp),%edx
    1797:	89 4a 68             	mov    %ecx,0x68(%edx)
    179a:	0f b6 0b             	movzbl (%ebx),%ecx
    179d:	8b 55 08             	mov    0x8(%ebp),%edx
    17a0:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    17a3:	8b 45 08             	mov    0x8(%ebp),%eax
    17a6:	8b 40 68             	mov    0x68(%eax),%eax
    17a9:	83 f8 40             	cmp    $0x40,%eax
    17ac:	75 25                	jne    17d3 <sha256_hash+0x7e>
                _hash(ctx);
    17ae:	ff 75 08             	push   0x8(%ebp)
    17b1:	e8 c1 fc ff ff       	call   1477 <_hash>
    17b6:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    17b9:	68 00 02 00 00       	push   $0x200
    17be:	ff 75 08             	push   0x8(%ebp)
    17c1:	e8 7c fc ff ff       	call   1442 <_addbits>
    17c6:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    17c9:	8b 45 08             	mov    0x8(%ebp),%eax
    17cc:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    17d3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    17d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17da:	3b 45 10             	cmp    0x10(%ebp),%eax
    17dd:	72 a3                	jb     1782 <sha256_hash+0x2d>
            }
        }
    }
}
    17df:	90                   	nop
    17e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17e3:	c9                   	leave  
    17e4:	c3                   	ret    

000017e5 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    17e5:	55                   	push   %ebp
    17e6:	89 e5                	mov    %esp,%ebp
    17e8:	57                   	push   %edi
    17e9:	56                   	push   %esi
    17ea:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    17eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    17ef:	0f 84 27 02 00 00    	je     1a1c <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    17f5:	8b 45 08             	mov    0x8(%ebp),%eax
    17f8:	8b 40 68             	mov    0x68(%eax),%eax
    17fb:	83 e0 3f             	and    $0x3f,%eax
    17fe:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    1800:	8b 45 08             	mov    0x8(%ebp),%eax
    1803:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    1807:	8d 73 01             	lea    0x1(%ebx),%esi
    180a:	eb 0a                	jmp    1816 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    180c:	8b 45 08             	mov    0x8(%ebp),%eax
    180f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    1813:	83 c6 01             	add    $0x1,%esi
    1816:	83 fe 3f             	cmp    $0x3f,%esi
    1819:	76 f1                	jbe    180c <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	8b 40 68             	mov    0x68(%eax),%eax
    1821:	83 f8 37             	cmp    $0x37,%eax
    1824:	76 21                	jbe    1847 <sha256_done+0x62>
            _hash(ctx);
    1826:	ff 75 08             	push   0x8(%ebp)
    1829:	e8 49 fc ff ff       	call   1477 <_hash>
    182e:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    1831:	bb 00 00 00 00       	mov    $0x0,%ebx
    1836:	eb 0a                	jmp    1842 <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    1838:	8b 45 08             	mov    0x8(%ebp),%eax
    183b:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    183f:	83 c3 01             	add    $0x1,%ebx
    1842:	83 fb 3f             	cmp    $0x3f,%ebx
    1845:	76 f1                	jbe    1838 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    1847:	8b 45 08             	mov    0x8(%ebp),%eax
    184a:	8b 40 68             	mov    0x68(%eax),%eax
    184d:	c1 e0 03             	shl    $0x3,%eax
    1850:	50                   	push   %eax
    1851:	ff 75 08             	push   0x8(%ebp)
    1854:	e8 e9 fb ff ff       	call   1442 <_addbits>
    1859:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    185c:	8b 45 08             	mov    0x8(%ebp),%eax
    185f:	8b 40 60             	mov    0x60(%eax),%eax
    1862:	6a 00                	push   $0x0
    1864:	50                   	push   %eax
    1865:	e8 1a fa ff ff       	call   1284 <_shb>
    186a:	83 c4 08             	add    $0x8,%esp
    186d:	8b 55 08             	mov    0x8(%ebp),%edx
    1870:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    1873:	8b 45 08             	mov    0x8(%ebp),%eax
    1876:	8b 40 60             	mov    0x60(%eax),%eax
    1879:	6a 08                	push   $0x8
    187b:	50                   	push   %eax
    187c:	e8 03 fa ff ff       	call   1284 <_shb>
    1881:	83 c4 08             	add    $0x8,%esp
    1884:	8b 55 08             	mov    0x8(%ebp),%edx
    1887:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    188a:	8b 45 08             	mov    0x8(%ebp),%eax
    188d:	8b 40 60             	mov    0x60(%eax),%eax
    1890:	6a 10                	push   $0x10
    1892:	50                   	push   %eax
    1893:	e8 ec f9 ff ff       	call   1284 <_shb>
    1898:	83 c4 08             	add    $0x8,%esp
    189b:	8b 55 08             	mov    0x8(%ebp),%edx
    189e:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    18a1:	8b 45 08             	mov    0x8(%ebp),%eax
    18a4:	8b 40 60             	mov    0x60(%eax),%eax
    18a7:	6a 18                	push   $0x18
    18a9:	50                   	push   %eax
    18aa:	e8 d5 f9 ff ff       	call   1284 <_shb>
    18af:	83 c4 08             	add    $0x8,%esp
    18b2:	8b 55 08             	mov    0x8(%ebp),%edx
    18b5:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    18b8:	8b 45 08             	mov    0x8(%ebp),%eax
    18bb:	8b 40 64             	mov    0x64(%eax),%eax
    18be:	6a 00                	push   $0x0
    18c0:	50                   	push   %eax
    18c1:	e8 be f9 ff ff       	call   1284 <_shb>
    18c6:	83 c4 08             	add    $0x8,%esp
    18c9:	8b 55 08             	mov    0x8(%ebp),%edx
    18cc:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    18cf:	8b 45 08             	mov    0x8(%ebp),%eax
    18d2:	8b 40 64             	mov    0x64(%eax),%eax
    18d5:	6a 08                	push   $0x8
    18d7:	50                   	push   %eax
    18d8:	e8 a7 f9 ff ff       	call   1284 <_shb>
    18dd:	83 c4 08             	add    $0x8,%esp
    18e0:	8b 55 08             	mov    0x8(%ebp),%edx
    18e3:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    18e6:	8b 45 08             	mov    0x8(%ebp),%eax
    18e9:	8b 40 64             	mov    0x64(%eax),%eax
    18ec:	6a 10                	push   $0x10
    18ee:	50                   	push   %eax
    18ef:	e8 90 f9 ff ff       	call   1284 <_shb>
    18f4:	83 c4 08             	add    $0x8,%esp
    18f7:	8b 55 08             	mov    0x8(%ebp),%edx
    18fa:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    18fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1900:	8b 40 64             	mov    0x64(%eax),%eax
    1903:	6a 18                	push   $0x18
    1905:	50                   	push   %eax
    1906:	e8 79 f9 ff ff       	call   1284 <_shb>
    190b:	83 c4 08             	add    $0x8,%esp
    190e:	8b 55 08             	mov    0x8(%ebp),%edx
    1911:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    1914:	ff 75 08             	push   0x8(%ebp)
    1917:	e8 5b fb ff ff       	call   1477 <_hash>
    191c:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    191f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1923:	0f 84 f3 00 00 00    	je     1a1c <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1929:	be 00 00 00 00       	mov    $0x0,%esi
    192e:	bb 18 00 00 00       	mov    $0x18,%ebx
    1933:	e9 db 00 00 00       	jmp    1a13 <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    1938:	8b 45 08             	mov    0x8(%ebp),%eax
    193b:	8b 40 40             	mov    0x40(%eax),%eax
    193e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1941:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    1944:	53                   	push   %ebx
    1945:	50                   	push   %eax
    1946:	e8 39 f9 ff ff       	call   1284 <_shb>
    194b:	83 c4 08             	add    $0x8,%esp
    194e:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    1950:	8b 45 08             	mov    0x8(%ebp),%eax
    1953:	8b 40 44             	mov    0x44(%eax),%eax
    1956:	8d 4e 04             	lea    0x4(%esi),%ecx
    1959:	8b 55 0c             	mov    0xc(%ebp),%edx
    195c:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    195f:	53                   	push   %ebx
    1960:	50                   	push   %eax
    1961:	e8 1e f9 ff ff       	call   1284 <_shb>
    1966:	83 c4 08             	add    $0x8,%esp
    1969:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    196b:	8b 45 08             	mov    0x8(%ebp),%eax
    196e:	8b 40 48             	mov    0x48(%eax),%eax
    1971:	8d 4e 08             	lea    0x8(%esi),%ecx
    1974:	8b 55 0c             	mov    0xc(%ebp),%edx
    1977:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    197a:	53                   	push   %ebx
    197b:	50                   	push   %eax
    197c:	e8 03 f9 ff ff       	call   1284 <_shb>
    1981:	83 c4 08             	add    $0x8,%esp
    1984:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    1986:	8b 45 08             	mov    0x8(%ebp),%eax
    1989:	8b 40 4c             	mov    0x4c(%eax),%eax
    198c:	8d 4e 0c             	lea    0xc(%esi),%ecx
    198f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1992:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1995:	53                   	push   %ebx
    1996:	50                   	push   %eax
    1997:	e8 e8 f8 ff ff       	call   1284 <_shb>
    199c:	83 c4 08             	add    $0x8,%esp
    199f:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    19a1:	8b 45 08             	mov    0x8(%ebp),%eax
    19a4:	8b 40 50             	mov    0x50(%eax),%eax
    19a7:	8d 4e 10             	lea    0x10(%esi),%ecx
    19aa:	8b 55 0c             	mov    0xc(%ebp),%edx
    19ad:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19b0:	53                   	push   %ebx
    19b1:	50                   	push   %eax
    19b2:	e8 cd f8 ff ff       	call   1284 <_shb>
    19b7:	83 c4 08             	add    $0x8,%esp
    19ba:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    19bc:	8b 45 08             	mov    0x8(%ebp),%eax
    19bf:	8b 40 54             	mov    0x54(%eax),%eax
    19c2:	8d 4e 14             	lea    0x14(%esi),%ecx
    19c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    19c8:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19cb:	53                   	push   %ebx
    19cc:	50                   	push   %eax
    19cd:	e8 b2 f8 ff ff       	call   1284 <_shb>
    19d2:	83 c4 08             	add    $0x8,%esp
    19d5:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    19d7:	8b 45 08             	mov    0x8(%ebp),%eax
    19da:	8b 40 58             	mov    0x58(%eax),%eax
    19dd:	8d 4e 18             	lea    0x18(%esi),%ecx
    19e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    19e3:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    19e6:	53                   	push   %ebx
    19e7:	50                   	push   %eax
    19e8:	e8 97 f8 ff ff       	call   1284 <_shb>
    19ed:	83 c4 08             	add    $0x8,%esp
    19f0:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    19f2:	8b 45 08             	mov    0x8(%ebp),%eax
    19f5:	8b 40 5c             	mov    0x5c(%eax),%eax
    19f8:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    19fb:	8b 55 0c             	mov    0xc(%ebp),%edx
    19fe:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1a01:	53                   	push   %ebx
    1a02:	50                   	push   %eax
    1a03:	e8 7c f8 ff ff       	call   1284 <_shb>
    1a08:	83 c4 08             	add    $0x8,%esp
    1a0b:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1a0d:	83 c6 01             	add    $0x1,%esi
    1a10:	83 eb 08             	sub    $0x8,%ebx
    1a13:	83 fe 03             	cmp    $0x3,%esi
    1a16:	0f 86 1c ff ff ff    	jbe    1938 <sha256_done+0x153>
            }
        }
    }
}
    1a1c:	90                   	nop
    1a1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a20:	5b                   	pop    %ebx
    1a21:	5e                   	pop    %esi
    1a22:	5f                   	pop    %edi
    1a23:	5d                   	pop    %ebp
    1a24:	c3                   	ret    

00001a25 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    1a25:	55                   	push   %ebp
    1a26:	89 e5                	mov    %esp,%ebp
    1a28:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1a2b:	a1 94 2b 00 00       	mov    0x2b94,%eax
    1a30:	83 ec 08             	sub    $0x8,%esp
    1a33:	68 04 02 00 00       	push   $0x204
    1a38:	50                   	push   %eax
    1a39:	e8 7d e7 ff ff       	call   1bb <open>
    1a3e:	83 c4 10             	add    $0x10,%esp
    1a41:	a3 c0 2b 00 00       	mov    %eax,0x2bc0

    int i = 0;
    1a46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1a4d:	eb 6f                	jmp    1abe <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    1a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a52:	83 e0 01             	and    $0x1,%eax
    1a55:	85 c0                	test   %eax,%eax
    1a57:	75 27                	jne    1a80 <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    1a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5c:	89 c2                	mov    %eax,%edx
    1a5e:	c1 ea 1f             	shr    $0x1f,%edx
    1a61:	01 d0                	add    %edx,%eax
    1a63:	d1 f8                	sar    %eax
    1a65:	6b c0 64             	imul   $0x64,%eax,%eax
    1a68:	8d 90 e0 2b 00 00    	lea    0x2be0(%eax),%edx
    1a6e:	83 ec 08             	sub    $0x8,%esp
    1a71:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a74:	50                   	push   %eax
    1a75:	52                   	push   %edx
    1a76:	e8 ee e7 ff ff       	call   269 <strcpy>
    1a7b:	83 c4 10             	add    $0x10,%esp
    1a7e:	eb 27                	jmp    1aa7 <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a83:	89 c2                	mov    %eax,%edx
    1a85:	c1 ea 1f             	shr    $0x1f,%edx
    1a88:	01 d0                	add    %edx,%eax
    1a8a:	d1 f8                	sar    %eax
    1a8c:	6b c0 64             	imul   $0x64,%eax,%eax
    1a8f:	8d 90 20 2b 64 00    	lea    0x642b20(%eax),%edx
    1a95:	83 ec 04             	sub    $0x4,%esp
    1a98:	6a 64                	push   $0x64
    1a9a:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1a9d:	50                   	push   %eax
    1a9e:	52                   	push   %edx
    1a9f:	e8 b1 e9 ff ff       	call   455 <memmove>
    1aa4:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1aa7:	83 ec 04             	sub    $0x4,%esp
    1aaa:	6a 64                	push   $0x64
    1aac:	6a 00                	push   $0x0
    1aae:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1ab1:	50                   	push   %eax
    1ab2:	e8 48 e8 ff ff       	call   2ff <memset>
    1ab7:	83 c4 10             	add    $0x10,%esp
        i++;
    1aba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1abe:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1ac3:	83 ec 04             	sub    $0x4,%esp
    1ac6:	6a 64                	push   $0x64
    1ac8:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1acb:	52                   	push   %edx
    1acc:	50                   	push   %eax
    1acd:	e8 c1 e6 ff ff       	call   193 <read>
    1ad2:	83 c4 10             	add    $0x10,%esp
    1ad5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ad8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1adc:	0f 8f 6d ff ff ff    	jg     1a4f <read_info+0x2a>
    }

    num_users = i / 2;
    1ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae5:	89 c2                	mov    %eax,%edx
    1ae7:	c1 ea 1f             	shr    $0x1f,%edx
    1aea:	01 d0                	add    %edx,%eax
    1aec:	d1 f8                	sar    %eax
    1aee:	a3 c4 2b 00 00       	mov    %eax,0x2bc4

    if (n < 0) {
    1af3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1af7:	79 17                	jns    1b10 <read_info+0xeb>
        printf(1, "cat: read error\n");
    1af9:	83 ec 08             	sub    $0x8,%esp
    1afc:	68 4b 23 00 00       	push   $0x234b
    1b01:	6a 01                	push   $0x1
    1b03:	e8 83 ec ff ff       	call   78b <printf>
    1b08:	83 c4 10             	add    $0x10,%esp
        exit();
    1b0b:	e8 6b e6 ff ff       	call   17b <exit>
    }
}
    1b10:	90                   	nop
    1b11:	c9                   	leave  
    1b12:	c3                   	ret    

00001b13 <writeback>:

void writeback() {
    1b13:	55                   	push   %ebp
    1b14:	89 e5                	mov    %esp,%ebp
    1b16:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1b19:	a1 94 2b 00 00       	mov    0x2b94,%eax
    1b1e:	83 ec 08             	sub    $0x8,%esp
    1b21:	68 04 02 00 00       	push   $0x204
    1b26:	50                   	push   %eax
    1b27:	e8 8f e6 ff ff       	call   1bb <open>
    1b2c:	83 c4 10             	add    $0x10,%esp
    1b2f:	a3 c0 2b 00 00       	mov    %eax,0x2bc0
    for (int i = 0; i < num_users; i++) {
    1b34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b3b:	eb 44                	jmp    1b81 <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b40:	6b c0 64             	imul   $0x64,%eax,%eax
    1b43:	8d 90 e0 2b 00 00    	lea    0x2be0(%eax),%edx
    1b49:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1b4e:	83 ec 04             	sub    $0x4,%esp
    1b51:	6a 64                	push   $0x64
    1b53:	52                   	push   %edx
    1b54:	50                   	push   %eax
    1b55:	e8 41 e6 ff ff       	call   19b <write>
    1b5a:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b60:	6b c0 64             	imul   $0x64,%eax,%eax
    1b63:	8d 90 20 2b 64 00    	lea    0x642b20(%eax),%edx
    1b69:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1b6e:	83 ec 04             	sub    $0x4,%esp
    1b71:	6a 64                	push   $0x64
    1b73:	52                   	push   %edx
    1b74:	50                   	push   %eax
    1b75:	e8 21 e6 ff ff       	call   19b <write>
    1b7a:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1b7d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b81:	a1 c4 2b 00 00       	mov    0x2bc4,%eax
    1b86:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1b89:	7c b2                	jl     1b3d <writeback+0x2a>
    }
    close(fd);
    1b8b:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1b90:	83 ec 0c             	sub    $0xc,%esp
    1b93:	50                   	push   %eax
    1b94:	e8 0a e6 ff ff       	call   1a3 <close>
    1b99:	83 c4 10             	add    $0x10,%esp
}
    1b9c:	90                   	nop
    1b9d:	c9                   	leave  
    1b9e:	c3                   	ret    

00001b9f <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1b9f:	55                   	push   %ebp
    1ba0:	89 e5                	mov    %esp,%ebp
    1ba2:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1ba8:	83 ec 08             	sub    $0x8,%esp
    1bab:	68 5c 23 00 00       	push   $0x235c
    1bb0:	68 e0 2b 00 00       	push   $0x2be0
    1bb5:	e8 af e6 ff ff       	call   269 <strcpy>
    1bba:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1bbd:	c7 45 f4 61 23 00 00 	movl   $0x2361,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1bc4:	83 ec 08             	sub    $0x8,%esp
    1bc7:	ff 75 f4             	push   -0xc(%ebp)
    1bca:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1bd0:	50                   	push   %eax
    1bd1:	e8 93 e6 ff ff       	call   269 <strcpy>
    1bd6:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1bd9:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1be0:	83 ec 0c             	sub    $0xc,%esp
    1be3:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1be9:	50                   	push   %eax
    1bea:	e8 e8 fa ff ff       	call   16d7 <sha256_init>
    1bef:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1bf2:	83 ec 0c             	sub    $0xc,%esp
    1bf5:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1bfb:	50                   	push   %eax
    1bfc:	e8 d7 e6 ff ff       	call   2d8 <strlen>
    1c01:	83 c4 10             	add    $0x10,%esp
    1c04:	83 ec 04             	sub    $0x4,%esp
    1c07:	50                   	push   %eax
    1c08:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1c0e:	50                   	push   %eax
    1c0f:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c15:	50                   	push   %eax
    1c16:	e8 3a fb ff ff       	call   1755 <sha256_hash>
    1c1b:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1c1e:	83 ec 08             	sub    $0x8,%esp
    1c21:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1c27:	50                   	push   %eax
    1c28:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1c2e:	50                   	push   %eax
    1c2f:	e8 b1 fb ff ff       	call   17e5 <sha256_done>
    1c34:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1c37:	83 ec 04             	sub    $0x4,%esp
    1c3a:	6a 64                	push   $0x64
    1c3c:	6a 00                	push   $0x0
    1c3e:	68 20 2b 64 00       	push   $0x642b20
    1c43:	e8 b7 e6 ff ff       	call   2ff <memset>
    1c48:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1c4b:	83 ec 04             	sub    $0x4,%esp
    1c4e:	6a 20                	push   $0x20
    1c50:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1c56:	50                   	push   %eax
    1c57:	68 20 2b 64 00       	push   $0x642b20
    1c5c:	e8 f4 e7 ff ff       	call   455 <memmove>
    1c61:	83 c4 10             	add    $0x10,%esp

    read_info();
    1c64:	e8 bc fd ff ff       	call   1a25 <read_info>
    fd = open(SECRETS, O_RDWR);
    1c69:	a1 94 2b 00 00       	mov    0x2b94,%eax
    1c6e:	83 ec 08             	sub    $0x8,%esp
    1c71:	6a 04                	push   $0x4
    1c73:	50                   	push   %eax
    1c74:	e8 42 e5 ff ff       	call   1bb <open>
    1c79:	83 c4 10             	add    $0x10,%esp
    1c7c:	a3 c0 2b 00 00       	mov    %eax,0x2bc0
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1c81:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1c86:	83 ec 04             	sub    $0x4,%esp
    1c89:	6a 64                	push   $0x64
    1c8b:	68 e0 2b 00 00       	push   $0x2be0
    1c90:	50                   	push   %eax
    1c91:	e8 05 e5 ff ff       	call   19b <write>
    1c96:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1c99:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1c9e:	83 ec 04             	sub    $0x4,%esp
    1ca1:	6a 64                	push   $0x64
    1ca3:	68 20 2b 64 00       	push   $0x642b20
    1ca8:	50                   	push   %eax
    1ca9:	e8 ed e4 ff ff       	call   19b <write>
    1cae:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1cb1:	a1 c0 2b 00 00       	mov    0x2bc0,%eax
    1cb6:	83 ec 0c             	sub    $0xc,%esp
    1cb9:	50                   	push   %eax
    1cba:	e8 e4 e4 ff ff       	call   1a3 <close>
    1cbf:	83 c4 10             	add    $0x10,%esp
}
    1cc2:	90                   	nop
    1cc3:	c9                   	leave  
    1cc4:	c3                   	ret    

00001cc5 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1cc5:	55                   	push   %ebp
    1cc6:	89 e5                	mov    %esp,%ebp
    1cc8:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1ccb:	e8 55 fd ff ff       	call   1a25 <read_info>

    for (int i = 0; i < num_users; i++) {
    1cd0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1cd7:	eb 29                	jmp    1d02 <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cdc:	6b c0 64             	imul   $0x64,%eax,%eax
    1cdf:	05 e0 2b 00 00       	add    $0x2be0,%eax
    1ce4:	83 ec 08             	sub    $0x8,%esp
    1ce7:	50                   	push   %eax
    1ce8:	ff 75 08             	push   0x8(%ebp)
    1ceb:	e8 a9 e5 ff ff       	call   299 <strcmp>
    1cf0:	83 c4 10             	add    $0x10,%esp
    1cf3:	85 c0                	test   %eax,%eax
    1cf5:	75 07                	jne    1cfe <does_user_exist+0x39>
            return 0;
    1cf7:	b8 00 00 00 00       	mov    $0x0,%eax
    1cfc:	eb 13                	jmp    1d11 <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1cfe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d02:	a1 c4 2b 00 00       	mov    0x2bc4,%eax
    1d07:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1d0a:	7c cd                	jl     1cd9 <does_user_exist+0x14>
        }
    }
    return -1;
    1d0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d11:	c9                   	leave  
    1d12:	c3                   	ret    

00001d13 <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1d13:	55                   	push   %ebp
    1d14:	89 e5                	mov    %esp,%ebp
    1d16:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1d1c:	e8 04 fd ff ff       	call   1a25 <read_info>

    int open = -1;
    1d21:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1d28:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1d2f:	eb 46                	jmp    1d77 <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d34:	6b c0 64             	imul   $0x64,%eax,%eax
    1d37:	05 e0 2b 00 00       	add    $0x2be0,%eax
    1d3c:	83 ec 08             	sub    $0x8,%esp
    1d3f:	50                   	push   %eax
    1d40:	ff 75 08             	push   0x8(%ebp)
    1d43:	e8 51 e5 ff ff       	call   299 <strcmp>
    1d48:	83 c4 10             	add    $0x10,%esp
    1d4b:	85 c0                	test   %eax,%eax
    1d4d:	75 0a                	jne    1d59 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1d4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1d54:	e9 18 01 00 00       	jmp    1e71 <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1d59:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d5c:	6b c0 64             	imul   $0x64,%eax,%eax
    1d5f:	05 e0 2b 00 00       	add    $0x2be0,%eax
    1d64:	0f b6 00             	movzbl (%eax),%eax
    1d67:	84 c0                	test   %al,%al
    1d69:	75 08                	jne    1d73 <create_user+0x60>
            open = i;
    1d6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1d71:	eb 0d                	jmp    1d80 <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1d73:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1d77:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1d7e:	7e b1                	jle    1d31 <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1d80:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1d84:	0f 84 e2 00 00 00    	je     1e6c <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1d8a:	83 ec 08             	sub    $0x8,%esp
    1d8d:	ff 75 0c             	push   0xc(%ebp)
    1d90:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1d96:	50                   	push   %eax
    1d97:	e8 cd e4 ff ff       	call   269 <strcpy>
    1d9c:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1d9f:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1da6:	83 ec 0c             	sub    $0xc,%esp
    1da9:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1daf:	50                   	push   %eax
    1db0:	e8 22 f9 ff ff       	call   16d7 <sha256_init>
    1db5:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1db8:	83 ec 0c             	sub    $0xc,%esp
    1dbb:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1dc1:	50                   	push   %eax
    1dc2:	e8 11 e5 ff ff       	call   2d8 <strlen>
    1dc7:	83 c4 10             	add    $0x10,%esp
    1dca:	83 ec 04             	sub    $0x4,%esp
    1dcd:	50                   	push   %eax
    1dce:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1dd4:	50                   	push   %eax
    1dd5:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1ddb:	50                   	push   %eax
    1ddc:	e8 74 f9 ff ff       	call   1755 <sha256_hash>
    1de1:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1de4:	83 ec 08             	sub    $0x8,%esp
    1de7:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1ded:	50                   	push   %eax
    1dee:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1df4:	50                   	push   %eax
    1df5:	e8 eb f9 ff ff       	call   17e5 <sha256_done>
    1dfa:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1dfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e00:	6b c0 64             	imul   $0x64,%eax,%eax
    1e03:	05 e0 2b 00 00       	add    $0x2be0,%eax
    1e08:	83 ec 08             	sub    $0x8,%esp
    1e0b:	ff 75 08             	push   0x8(%ebp)
    1e0e:	50                   	push   %eax
    1e0f:	e8 55 e4 ff ff       	call   269 <strcpy>
    1e14:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1e17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e1a:	6b c0 64             	imul   $0x64,%eax,%eax
    1e1d:	05 20 2b 64 00       	add    $0x642b20,%eax
    1e22:	83 ec 04             	sub    $0x4,%esp
    1e25:	6a 64                	push   $0x64
    1e27:	6a 00                	push   $0x0
    1e29:	50                   	push   %eax
    1e2a:	e8 d0 e4 ff ff       	call   2ff <memset>
    1e2f:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    1e32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e35:	6b c0 64             	imul   $0x64,%eax,%eax
    1e38:	8d 90 20 2b 64 00    	lea    0x642b20(%eax),%edx
    1e3e:	83 ec 04             	sub    $0x4,%esp
    1e41:	6a 20                	push   $0x20
    1e43:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1e49:	50                   	push   %eax
    1e4a:	52                   	push   %edx
    1e4b:	e8 05 e6 ff ff       	call   455 <memmove>
    1e50:	83 c4 10             	add    $0x10,%esp

        num_users++;
    1e53:	a1 c4 2b 00 00       	mov    0x2bc4,%eax
    1e58:	83 c0 01             	add    $0x1,%eax
    1e5b:	a3 c4 2b 00 00       	mov    %eax,0x2bc4
        writeback();
    1e60:	e8 ae fc ff ff       	call   1b13 <writeback>
        return 0;
    1e65:	b8 00 00 00 00       	mov    $0x0,%eax
    1e6a:	eb 05                	jmp    1e71 <create_user+0x15e>
    }

    return -1;
    1e6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1e71:	c9                   	leave  
    1e72:	c3                   	ret    

00001e73 <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    1e73:	55                   	push   %ebp
    1e74:	89 e5                	mov    %esp,%ebp
    1e76:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    1e7c:	e8 a4 fb ff ff       	call   1a25 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    1e81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e88:	e9 7b 01 00 00       	jmp    2008 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    1e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e90:	6b c0 64             	imul   $0x64,%eax,%eax
    1e93:	05 e0 2b 00 00       	add    $0x2be0,%eax
    1e98:	83 ec 08             	sub    $0x8,%esp
    1e9b:	50                   	push   %eax
    1e9c:	ff 75 08             	push   0x8(%ebp)
    1e9f:	e8 f5 e3 ff ff       	call   299 <strcmp>
    1ea4:	83 c4 10             	add    $0x10,%esp
    1ea7:	85 c0                	test   %eax,%eax
    1ea9:	0f 85 55 01 00 00    	jne    2004 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    1eaf:	83 ec 08             	sub    $0x8,%esp
    1eb2:	ff 75 0c             	push   0xc(%ebp)
    1eb5:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1ebb:	50                   	push   %eax
    1ebc:	e8 a8 e3 ff ff       	call   269 <strcpy>
    1ec1:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    1ec4:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    1ecb:	83 ec 0c             	sub    $0xc,%esp
    1ece:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1ed4:	50                   	push   %eax
    1ed5:	e8 fd f7 ff ff       	call   16d7 <sha256_init>
    1eda:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    1edd:	83 ec 0c             	sub    $0xc,%esp
    1ee0:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1ee6:	50                   	push   %eax
    1ee7:	e8 ec e3 ff ff       	call   2d8 <strlen>
    1eec:	83 c4 10             	add    $0x10,%esp
    1eef:	83 ec 04             	sub    $0x4,%esp
    1ef2:	50                   	push   %eax
    1ef3:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    1ef9:	50                   	push   %eax
    1efa:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f00:	50                   	push   %eax
    1f01:	e8 4f f8 ff ff       	call   1755 <sha256_hash>
    1f06:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    1f09:	83 ec 08             	sub    $0x8,%esp
    1f0c:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    1f12:	50                   	push   %eax
    1f13:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    1f19:	50                   	push   %eax
    1f1a:	e8 c6 f8 ff ff       	call   17e5 <sha256_done>
    1f1f:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    1f22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1f29:	eb 34                	jmp    1f5f <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    1f2b:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    1f31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f34:	01 d0                	add    %edx,%eax
    1f36:	0f b6 00             	movzbl (%eax),%eax
    1f39:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1f3c:	6b ca 64             	imul   $0x64,%edx,%ecx
    1f3f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1f42:	01 ca                	add    %ecx,%edx
    1f44:	81 c2 20 2b 64 00    	add    $0x642b20,%edx
    1f4a:	0f b6 12             	movzbl (%edx),%edx
    1f4d:	38 d0                	cmp    %dl,%al
    1f4f:	74 0a                	je     1f5b <login_user+0xe8>
                    return -1;
    1f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1f56:	e9 bf 00 00 00       	jmp    201a <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    1f5b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f5f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    1f63:	7e c6                	jle    1f2b <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    1f65:	83 ec 08             	sub    $0x8,%esp
    1f68:	68 67 23 00 00       	push   $0x2367
    1f6d:	6a 01                	push   $0x1
    1f6f:	e8 17 e8 ff ff       	call   78b <printf>
    1f74:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    1f77:	e8 f7 e1 ff ff       	call   173 <fork>
    1f7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    1f7f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f83:	79 17                	jns    1f9c <login_user+0x129>
                printf(1, "init: fork failed\n");
    1f85:	83 ec 08             	sub    $0x8,%esp
    1f88:	68 7a 23 00 00       	push   $0x237a
    1f8d:	6a 01                	push   $0x1
    1f8f:	e8 f7 e7 ff ff       	call   78b <printf>
    1f94:	83 c4 10             	add    $0x10,%esp
                exit();
    1f97:	e8 df e1 ff ff       	call   17b <exit>
            }
            if (pid == 0) {
    1f9c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fa0:	75 4c                	jne    1fee <login_user+0x17b>
                setuid(i);
    1fa2:	83 ec 0c             	sub    $0xc,%esp
    1fa5:	ff 75 f4             	push   -0xc(%ebp)
    1fa8:	e8 6e e2 ff ff       	call   21b <setuid>
    1fad:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    1fb0:	83 ec 08             	sub    $0x8,%esp
    1fb3:	68 98 2b 00 00       	push   $0x2b98
    1fb8:	68 48 23 00 00       	push   $0x2348
    1fbd:	e8 f1 e1 ff ff       	call   1b3 <exec>
    1fc2:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    1fc5:	83 ec 08             	sub    $0x8,%esp
    1fc8:	68 8d 23 00 00       	push   $0x238d
    1fcd:	6a 01                	push   $0x1
    1fcf:	e8 b7 e7 ff ff       	call   78b <printf>
    1fd4:	83 c4 10             	add    $0x10,%esp
                exit();
    1fd7:	e8 9f e1 ff ff       	call   17b <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    1fdc:	83 ec 08             	sub    $0x8,%esp
    1fdf:	68 a3 23 00 00       	push   $0x23a3
    1fe4:	6a 01                	push   $0x1
    1fe6:	e8 a0 e7 ff ff       	call   78b <printf>
    1feb:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    1fee:	e8 90 e1 ff ff       	call   183 <wait>
    1ff3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1ff6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ffa:	78 08                	js     2004 <login_user+0x191>
    1ffc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1fff:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2002:	75 d8                	jne    1fdc <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    2004:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2008:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    200f:	0f 8e 78 fe ff ff    	jle    1e8d <login_user+0x1a>
        }
    }

    return -1;
    2015:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    201a:	c9                   	leave  
    201b:	c3                   	ret    
