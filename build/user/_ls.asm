
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

char* fmtname(char* path) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 14             	sub    $0x14,%esp
    static char buf[DIRSIZ + 1];
    char* p;

    // Find first character after last slash.
    for (p = path + strlen(path); p >= path && *p != '/'; p--)
       7:	83 ec 0c             	sub    $0xc,%esp
       a:	ff 75 08             	push   0x8(%ebp)
       d:	e8 95 04 00 00       	call   4a7 <strlen>
      12:	83 c4 10             	add    $0x10,%esp
      15:	8b 55 08             	mov    0x8(%ebp),%edx
      18:	01 d0                	add    %edx,%eax
      1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      1d:	eb 04                	jmp    23 <fmtname+0x23>
      1f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
      23:	8b 45 f4             	mov    -0xc(%ebp),%eax
      26:	3b 45 08             	cmp    0x8(%ebp),%eax
      29:	72 0a                	jb     35 <fmtname+0x35>
      2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
      2e:	0f b6 00             	movzbl (%eax),%eax
      31:	3c 2f                	cmp    $0x2f,%al
      33:	75 ea                	jne    1f <fmtname+0x1f>
        ;
    p++;
      35:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

    // Return blank-padded name.
    if (strlen(p) >= DIRSIZ) return p;
      39:	83 ec 0c             	sub    $0xc,%esp
      3c:	ff 75 f4             	push   -0xc(%ebp)
      3f:	e8 63 04 00 00       	call   4a7 <strlen>
      44:	83 c4 10             	add    $0x10,%esp
      47:	83 f8 0d             	cmp    $0xd,%eax
      4a:	76 05                	jbe    51 <fmtname+0x51>
      4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4f:	eb 60                	jmp    b1 <fmtname+0xb1>
    memmove(buf, p, strlen(p));
      51:	83 ec 0c             	sub    $0xc,%esp
      54:	ff 75 f4             	push   -0xc(%ebp)
      57:	e8 4b 04 00 00       	call   4a7 <strlen>
      5c:	83 c4 10             	add    $0x10,%esp
      5f:	83 ec 04             	sub    $0x4,%esp
      62:	50                   	push   %eax
      63:	ff 75 f4             	push   -0xc(%ebp)
      66:	68 a0 2c 00 00       	push   $0x2ca0
      6b:	e8 b4 05 00 00       	call   624 <memmove>
      70:	83 c4 10             	add    $0x10,%esp
    memset(buf + strlen(p), ' ', DIRSIZ - strlen(p));
      73:	83 ec 0c             	sub    $0xc,%esp
      76:	ff 75 f4             	push   -0xc(%ebp)
      79:	e8 29 04 00 00       	call   4a7 <strlen>
      7e:	83 c4 10             	add    $0x10,%esp
      81:	ba 0e 00 00 00       	mov    $0xe,%edx
      86:	89 d3                	mov    %edx,%ebx
      88:	29 c3                	sub    %eax,%ebx
      8a:	83 ec 0c             	sub    $0xc,%esp
      8d:	ff 75 f4             	push   -0xc(%ebp)
      90:	e8 12 04 00 00       	call   4a7 <strlen>
      95:	83 c4 10             	add    $0x10,%esp
      98:	05 a0 2c 00 00       	add    $0x2ca0,%eax
      9d:	83 ec 04             	sub    $0x4,%esp
      a0:	53                   	push   %ebx
      a1:	6a 20                	push   $0x20
      a3:	50                   	push   %eax
      a4:	e8 25 04 00 00       	call   4ce <memset>
      a9:	83 c4 10             	add    $0x10,%esp
    return buf;
      ac:	b8 a0 2c 00 00       	mov    $0x2ca0,%eax
}
      b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      b4:	c9                   	leave  
      b5:	c3                   	ret    

000000b6 <ls>:

void ls(char* path) {
      b6:	55                   	push   %ebp
      b7:	89 e5                	mov    %esp,%ebp
      b9:	57                   	push   %edi
      ba:	56                   	push   %esi
      bb:	53                   	push   %ebx
      bc:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, O_RDONLY)) < 0) {
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	6a 01                	push   $0x1
      c7:	ff 75 08             	push   0x8(%ebp)
      ca:	e8 bb 02 00 00       	call   38a <open>
      cf:	83 c4 10             	add    $0x10,%esp
      d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      d9:	79 1a                	jns    f5 <ls+0x3f>
        printf(2, "ls: cannot open %s\n", path);
      db:	83 ec 04             	sub    $0x4,%esp
      de:	ff 75 08             	push   0x8(%ebp)
      e1:	68 00 22 00 00       	push   $0x2200
      e6:	6a 02                	push   $0x2
      e8:	e8 6d 08 00 00       	call   95a <printf>
      ed:	83 c4 10             	add    $0x10,%esp
        return;
      f0:	e9 e1 01 00 00       	jmp    2d6 <ls+0x220>
    }

    if (fstat(fd, &st) < 0) {
      f5:	83 ec 08             	sub    $0x8,%esp
      f8:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
      fe:	50                   	push   %eax
      ff:	ff 75 e4             	push   -0x1c(%ebp)
     102:	e8 9b 02 00 00       	call   3a2 <fstat>
     107:	83 c4 10             	add    $0x10,%esp
     10a:	85 c0                	test   %eax,%eax
     10c:	79 28                	jns    136 <ls+0x80>
        printf(2, "ls: cannot stat %s\n", path);
     10e:	83 ec 04             	sub    $0x4,%esp
     111:	ff 75 08             	push   0x8(%ebp)
     114:	68 14 22 00 00       	push   $0x2214
     119:	6a 02                	push   $0x2
     11b:	e8 3a 08 00 00       	call   95a <printf>
     120:	83 c4 10             	add    $0x10,%esp
        close(fd);
     123:	83 ec 0c             	sub    $0xc,%esp
     126:	ff 75 e4             	push   -0x1c(%ebp)
     129:	e8 44 02 00 00       	call   372 <close>
     12e:	83 c4 10             	add    $0x10,%esp
        return;
     131:	e9 a0 01 00 00       	jmp    2d6 <ls+0x220>
    }

    switch (st.type) {
     136:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     13d:	98                   	cwtl   
     13e:	83 f8 01             	cmp    $0x1,%eax
     141:	74 48                	je     18b <ls+0xd5>
     143:	83 f8 02             	cmp    $0x2,%eax
     146:	0f 85 7c 01 00 00    	jne    2c8 <ls+0x212>
        case T_FILE:
            printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     14c:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     152:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     158:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     15f:	0f bf d8             	movswl %ax,%ebx
     162:	83 ec 0c             	sub    $0xc,%esp
     165:	ff 75 08             	push   0x8(%ebp)
     168:	e8 93 fe ff ff       	call   0 <fmtname>
     16d:	83 c4 10             	add    $0x10,%esp
     170:	83 ec 08             	sub    $0x8,%esp
     173:	57                   	push   %edi
     174:	56                   	push   %esi
     175:	53                   	push   %ebx
     176:	50                   	push   %eax
     177:	68 28 22 00 00       	push   $0x2228
     17c:	6a 01                	push   $0x1
     17e:	e8 d7 07 00 00       	call   95a <printf>
     183:	83 c4 20             	add    $0x20,%esp
            break;
     186:	e9 3d 01 00 00       	jmp    2c8 <ls+0x212>

        case T_DIR:
            if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
     18b:	83 ec 0c             	sub    $0xc,%esp
     18e:	ff 75 08             	push   0x8(%ebp)
     191:	e8 11 03 00 00       	call   4a7 <strlen>
     196:	83 c4 10             	add    $0x10,%esp
     199:	83 c0 10             	add    $0x10,%eax
     19c:	3d 00 02 00 00       	cmp    $0x200,%eax
     1a1:	76 17                	jbe    1ba <ls+0x104>
                printf(1, "ls: path too long\n");
     1a3:	83 ec 08             	sub    $0x8,%esp
     1a6:	68 35 22 00 00       	push   $0x2235
     1ab:	6a 01                	push   $0x1
     1ad:	e8 a8 07 00 00       	call   95a <printf>
     1b2:	83 c4 10             	add    $0x10,%esp
                break;
     1b5:	e9 0e 01 00 00       	jmp    2c8 <ls+0x212>
            }
            strcpy(buf, path);
     1ba:	83 ec 08             	sub    $0x8,%esp
     1bd:	ff 75 08             	push   0x8(%ebp)
     1c0:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1c6:	50                   	push   %eax
     1c7:	e8 6c 02 00 00       	call   438 <strcpy>
     1cc:	83 c4 10             	add    $0x10,%esp
            p = buf + strlen(buf);
     1cf:	83 ec 0c             	sub    $0xc,%esp
     1d2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1d8:	50                   	push   %eax
     1d9:	e8 c9 02 00 00       	call   4a7 <strlen>
     1de:	83 c4 10             	add    $0x10,%esp
     1e1:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
     1e7:	01 d0                	add    %edx,%eax
     1e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
            *p++ = '/';
     1ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1ef:	8d 50 01             	lea    0x1(%eax),%edx
     1f2:	89 55 e0             	mov    %edx,-0x20(%ebp)
     1f5:	c6 00 2f             	movb   $0x2f,(%eax)
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
     1f8:	e9 aa 00 00 00       	jmp    2a7 <ls+0x1f1>
                if (de.inum == 0) continue;
     1fd:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
     204:	66 85 c0             	test   %ax,%ax
     207:	75 05                	jne    20e <ls+0x158>
     209:	e9 99 00 00 00       	jmp    2a7 <ls+0x1f1>
                memmove(p, de.name, DIRSIZ);
     20e:	83 ec 04             	sub    $0x4,%esp
     211:	6a 0e                	push   $0xe
     213:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     219:	83 c0 02             	add    $0x2,%eax
     21c:	50                   	push   %eax
     21d:	ff 75 e0             	push   -0x20(%ebp)
     220:	e8 ff 03 00 00       	call   624 <memmove>
     225:	83 c4 10             	add    $0x10,%esp
                p[DIRSIZ] = 0;
     228:	8b 45 e0             	mov    -0x20(%ebp),%eax
     22b:	83 c0 0e             	add    $0xe,%eax
     22e:	c6 00 00             	movb   $0x0,(%eax)
                if (stat(buf, &st) < 0) {
     231:	83 ec 08             	sub    $0x8,%esp
     234:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
     23a:	50                   	push   %eax
     23b:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     241:	50                   	push   %eax
     242:	e8 43 03 00 00       	call   58a <stat>
     247:	83 c4 10             	add    $0x10,%esp
     24a:	85 c0                	test   %eax,%eax
     24c:	79 1b                	jns    269 <ls+0x1b3>
                    printf(1, "ls: cannot stat %s\n", buf);
     24e:	83 ec 04             	sub    $0x4,%esp
     251:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     257:	50                   	push   %eax
     258:	68 14 22 00 00       	push   $0x2214
     25d:	6a 01                	push   $0x1
     25f:	e8 f6 06 00 00       	call   95a <printf>
     264:	83 c4 10             	add    $0x10,%esp
                    continue;
     267:	eb 3e                	jmp    2a7 <ls+0x1f1>
                }
                printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino,
     269:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     26f:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     275:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     27c:	0f bf d8             	movswl %ax,%ebx
     27f:	83 ec 0c             	sub    $0xc,%esp
     282:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     288:	50                   	push   %eax
     289:	e8 72 fd ff ff       	call   0 <fmtname>
     28e:	83 c4 10             	add    $0x10,%esp
     291:	83 ec 08             	sub    $0x8,%esp
     294:	57                   	push   %edi
     295:	56                   	push   %esi
     296:	53                   	push   %ebx
     297:	50                   	push   %eax
     298:	68 28 22 00 00       	push   $0x2228
     29d:	6a 01                	push   $0x1
     29f:	e8 b6 06 00 00       	call   95a <printf>
     2a4:	83 c4 20             	add    $0x20,%esp
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
     2a7:	83 ec 04             	sub    $0x4,%esp
     2aa:	6a 10                	push   $0x10
     2ac:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     2b2:	50                   	push   %eax
     2b3:	ff 75 e4             	push   -0x1c(%ebp)
     2b6:	e8 a7 00 00 00       	call   362 <read>
     2bb:	83 c4 10             	add    $0x10,%esp
     2be:	83 f8 10             	cmp    $0x10,%eax
     2c1:	0f 84 36 ff ff ff    	je     1fd <ls+0x147>
                       st.size);
            }
            break;
     2c7:	90                   	nop
    }
    close(fd);
     2c8:	83 ec 0c             	sub    $0xc,%esp
     2cb:	ff 75 e4             	push   -0x1c(%ebp)
     2ce:	e8 9f 00 00 00       	call   372 <close>
     2d3:	83 c4 10             	add    $0x10,%esp
}
     2d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2d9:	5b                   	pop    %ebx
     2da:	5e                   	pop    %esi
     2db:	5f                   	pop    %edi
     2dc:	5d                   	pop    %ebp
     2dd:	c3                   	ret    

000002de <main>:

int main(int argc, char* argv[]) {
     2de:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2e2:	83 e4 f0             	and    $0xfffffff0,%esp
     2e5:	ff 71 fc             	push   -0x4(%ecx)
     2e8:	55                   	push   %ebp
     2e9:	89 e5                	mov    %esp,%ebp
     2eb:	53                   	push   %ebx
     2ec:	51                   	push   %ecx
     2ed:	83 ec 10             	sub    $0x10,%esp
     2f0:	89 cb                	mov    %ecx,%ebx
    int i;

    if (argc < 2) {
     2f2:	83 3b 01             	cmpl   $0x1,(%ebx)
     2f5:	7f 15                	jg     30c <main+0x2e>
        ls(".");
     2f7:	83 ec 0c             	sub    $0xc,%esp
     2fa:	68 48 22 00 00       	push   $0x2248
     2ff:	e8 b2 fd ff ff       	call   b6 <ls>
     304:	83 c4 10             	add    $0x10,%esp
        exit();
     307:	e8 3e 00 00 00       	call   34a <exit>
    }
    for (i = 1; i < argc; i++) ls(argv[i]);
     30c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     313:	eb 21                	jmp    336 <main+0x58>
     315:	8b 45 f4             	mov    -0xc(%ebp),%eax
     318:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     31f:	8b 43 04             	mov    0x4(%ebx),%eax
     322:	01 d0                	add    %edx,%eax
     324:	8b 00                	mov    (%eax),%eax
     326:	83 ec 0c             	sub    $0xc,%esp
     329:	50                   	push   %eax
     32a:	e8 87 fd ff ff       	call   b6 <ls>
     32f:	83 c4 10             	add    $0x10,%esp
     332:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     336:	8b 45 f4             	mov    -0xc(%ebp),%eax
     339:	3b 03                	cmp    (%ebx),%eax
     33b:	7c d8                	jl     315 <main+0x37>
    exit();
     33d:	e8 08 00 00 00       	call   34a <exit>

00000342 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     342:	b8 01 00 00 00       	mov    $0x1,%eax
     347:	cd 40                	int    $0x40
     349:	c3                   	ret    

0000034a <exit>:
SYSCALL(exit)
     34a:	b8 02 00 00 00       	mov    $0x2,%eax
     34f:	cd 40                	int    $0x40
     351:	c3                   	ret    

00000352 <wait>:
SYSCALL(wait)
     352:	b8 03 00 00 00       	mov    $0x3,%eax
     357:	cd 40                	int    $0x40
     359:	c3                   	ret    

0000035a <pipe>:
SYSCALL(pipe)
     35a:	b8 04 00 00 00       	mov    $0x4,%eax
     35f:	cd 40                	int    $0x40
     361:	c3                   	ret    

00000362 <read>:
SYSCALL(read)
     362:	b8 05 00 00 00       	mov    $0x5,%eax
     367:	cd 40                	int    $0x40
     369:	c3                   	ret    

0000036a <write>:
SYSCALL(write)
     36a:	b8 10 00 00 00       	mov    $0x10,%eax
     36f:	cd 40                	int    $0x40
     371:	c3                   	ret    

00000372 <close>:
SYSCALL(close)
     372:	b8 15 00 00 00       	mov    $0x15,%eax
     377:	cd 40                	int    $0x40
     379:	c3                   	ret    

0000037a <kill>:
SYSCALL(kill)
     37a:	b8 06 00 00 00       	mov    $0x6,%eax
     37f:	cd 40                	int    $0x40
     381:	c3                   	ret    

00000382 <exec>:
SYSCALL(exec)
     382:	b8 07 00 00 00       	mov    $0x7,%eax
     387:	cd 40                	int    $0x40
     389:	c3                   	ret    

0000038a <open>:
SYSCALL(open)
     38a:	b8 0f 00 00 00       	mov    $0xf,%eax
     38f:	cd 40                	int    $0x40
     391:	c3                   	ret    

00000392 <mknod>:
SYSCALL(mknod)
     392:	b8 11 00 00 00       	mov    $0x11,%eax
     397:	cd 40                	int    $0x40
     399:	c3                   	ret    

0000039a <unlink>:
SYSCALL(unlink)
     39a:	b8 12 00 00 00       	mov    $0x12,%eax
     39f:	cd 40                	int    $0x40
     3a1:	c3                   	ret    

000003a2 <fstat>:
SYSCALL(fstat)
     3a2:	b8 08 00 00 00       	mov    $0x8,%eax
     3a7:	cd 40                	int    $0x40
     3a9:	c3                   	ret    

000003aa <link>:
SYSCALL(link)
     3aa:	b8 13 00 00 00       	mov    $0x13,%eax
     3af:	cd 40                	int    $0x40
     3b1:	c3                   	ret    

000003b2 <mkdir>:
SYSCALL(mkdir)
     3b2:	b8 14 00 00 00       	mov    $0x14,%eax
     3b7:	cd 40                	int    $0x40
     3b9:	c3                   	ret    

000003ba <chdir>:
SYSCALL(chdir)
     3ba:	b8 09 00 00 00       	mov    $0x9,%eax
     3bf:	cd 40                	int    $0x40
     3c1:	c3                   	ret    

000003c2 <dup>:
SYSCALL(dup)
     3c2:	b8 0a 00 00 00       	mov    $0xa,%eax
     3c7:	cd 40                	int    $0x40
     3c9:	c3                   	ret    

000003ca <getpid>:
SYSCALL(getpid)
     3ca:	b8 0b 00 00 00       	mov    $0xb,%eax
     3cf:	cd 40                	int    $0x40
     3d1:	c3                   	ret    

000003d2 <sbrk>:
SYSCALL(sbrk)
     3d2:	b8 0c 00 00 00       	mov    $0xc,%eax
     3d7:	cd 40                	int    $0x40
     3d9:	c3                   	ret    

000003da <sleep>:
SYSCALL(sleep)
     3da:	b8 0d 00 00 00       	mov    $0xd,%eax
     3df:	cd 40                	int    $0x40
     3e1:	c3                   	ret    

000003e2 <uptime>:
SYSCALL(uptime)
     3e2:	b8 0e 00 00 00       	mov    $0xe,%eax
     3e7:	cd 40                	int    $0x40
     3e9:	c3                   	ret    

000003ea <setuid>:
SYSCALL(setuid)
     3ea:	b8 16 00 00 00       	mov    $0x16,%eax
     3ef:	cd 40                	int    $0x40
     3f1:	c3                   	ret    

000003f2 <getuid>:
SYSCALL(getuid)
     3f2:	b8 19 00 00 00       	mov    $0x19,%eax
     3f7:	cd 40                	int    $0x40
     3f9:	c3                   	ret    

000003fa <chown>:
SYSCALL(chown)
     3fa:	b8 18 00 00 00       	mov    $0x18,%eax
     3ff:	cd 40                	int    $0x40
     401:	c3                   	ret    

00000402 <chmod>:
SYSCALL(chmod)
     402:	b8 17 00 00 00       	mov    $0x17,%eax
     407:	cd 40                	int    $0x40
     409:	c3                   	ret    

0000040a <report_stats>:
SYSCALL(report_stats)
     40a:	b8 1a 00 00 00       	mov    $0x1a,%eax
     40f:	cd 40                	int    $0x40
     411:	c3                   	ret    

00000412 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     412:	55                   	push   %ebp
     413:	89 e5                	mov    %esp,%ebp
     415:	57                   	push   %edi
     416:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     417:	8b 4d 08             	mov    0x8(%ebp),%ecx
     41a:	8b 55 10             	mov    0x10(%ebp),%edx
     41d:	8b 45 0c             	mov    0xc(%ebp),%eax
     420:	89 cb                	mov    %ecx,%ebx
     422:	89 df                	mov    %ebx,%edi
     424:	89 d1                	mov    %edx,%ecx
     426:	fc                   	cld    
     427:	f3 aa                	rep stos %al,%es:(%edi)
     429:	89 ca                	mov    %ecx,%edx
     42b:	89 fb                	mov    %edi,%ebx
     42d:	89 5d 08             	mov    %ebx,0x8(%ebp)
     430:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     433:	90                   	nop
     434:	5b                   	pop    %ebx
     435:	5f                   	pop    %edi
     436:	5d                   	pop    %ebp
     437:	c3                   	ret    

00000438 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     438:	55                   	push   %ebp
     439:	89 e5                	mov    %esp,%ebp
     43b:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     43e:	8b 45 08             	mov    0x8(%ebp),%eax
     441:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     444:	90                   	nop
     445:	8b 55 0c             	mov    0xc(%ebp),%edx
     448:	8d 42 01             	lea    0x1(%edx),%eax
     44b:	89 45 0c             	mov    %eax,0xc(%ebp)
     44e:	8b 45 08             	mov    0x8(%ebp),%eax
     451:	8d 48 01             	lea    0x1(%eax),%ecx
     454:	89 4d 08             	mov    %ecx,0x8(%ebp)
     457:	0f b6 12             	movzbl (%edx),%edx
     45a:	88 10                	mov    %dl,(%eax)
     45c:	0f b6 00             	movzbl (%eax),%eax
     45f:	84 c0                	test   %al,%al
     461:	75 e2                	jne    445 <strcpy+0xd>
        ;
    return os;
     463:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     466:	c9                   	leave  
     467:	c3                   	ret    

00000468 <strcmp>:

int strcmp(const char* p, const char* q) {
     468:	55                   	push   %ebp
     469:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     46b:	eb 08                	jmp    475 <strcmp+0xd>
     46d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     471:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     475:	8b 45 08             	mov    0x8(%ebp),%eax
     478:	0f b6 00             	movzbl (%eax),%eax
     47b:	84 c0                	test   %al,%al
     47d:	74 10                	je     48f <strcmp+0x27>
     47f:	8b 45 08             	mov    0x8(%ebp),%eax
     482:	0f b6 10             	movzbl (%eax),%edx
     485:	8b 45 0c             	mov    0xc(%ebp),%eax
     488:	0f b6 00             	movzbl (%eax),%eax
     48b:	38 c2                	cmp    %al,%dl
     48d:	74 de                	je     46d <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     48f:	8b 45 08             	mov    0x8(%ebp),%eax
     492:	0f b6 00             	movzbl (%eax),%eax
     495:	0f b6 d0             	movzbl %al,%edx
     498:	8b 45 0c             	mov    0xc(%ebp),%eax
     49b:	0f b6 00             	movzbl (%eax),%eax
     49e:	0f b6 c8             	movzbl %al,%ecx
     4a1:	89 d0                	mov    %edx,%eax
     4a3:	29 c8                	sub    %ecx,%eax
}
     4a5:	5d                   	pop    %ebp
     4a6:	c3                   	ret    

000004a7 <strlen>:

uint strlen(const char* s) {
     4a7:	55                   	push   %ebp
     4a8:	89 e5                	mov    %esp,%ebp
     4aa:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     4ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     4b4:	eb 04                	jmp    4ba <strlen+0x13>
     4b6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     4ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
     4c0:	01 d0                	add    %edx,%eax
     4c2:	0f b6 00             	movzbl (%eax),%eax
     4c5:	84 c0                	test   %al,%al
     4c7:	75 ed                	jne    4b6 <strlen+0xf>
        ;
    return n;
     4c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     4cc:	c9                   	leave  
     4cd:	c3                   	ret    

000004ce <memset>:

void* memset(void* dst, int c, uint n) {
     4ce:	55                   	push   %ebp
     4cf:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     4d1:	8b 45 10             	mov    0x10(%ebp),%eax
     4d4:	50                   	push   %eax
     4d5:	ff 75 0c             	push   0xc(%ebp)
     4d8:	ff 75 08             	push   0x8(%ebp)
     4db:	e8 32 ff ff ff       	call   412 <stosb>
     4e0:	83 c4 0c             	add    $0xc,%esp
    return dst;
     4e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4e6:	c9                   	leave  
     4e7:	c3                   	ret    

000004e8 <strchr>:

char* strchr(const char* s, char c) {
     4e8:	55                   	push   %ebp
     4e9:	89 e5                	mov    %esp,%ebp
     4eb:	83 ec 04             	sub    $0x4,%esp
     4ee:	8b 45 0c             	mov    0xc(%ebp),%eax
     4f1:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     4f4:	eb 14                	jmp    50a <strchr+0x22>
        if (*s == c) return (char*) s;
     4f6:	8b 45 08             	mov    0x8(%ebp),%eax
     4f9:	0f b6 00             	movzbl (%eax),%eax
     4fc:	38 45 fc             	cmp    %al,-0x4(%ebp)
     4ff:	75 05                	jne    506 <strchr+0x1e>
     501:	8b 45 08             	mov    0x8(%ebp),%eax
     504:	eb 13                	jmp    519 <strchr+0x31>
    for (; *s; s++)
     506:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     50a:	8b 45 08             	mov    0x8(%ebp),%eax
     50d:	0f b6 00             	movzbl (%eax),%eax
     510:	84 c0                	test   %al,%al
     512:	75 e2                	jne    4f6 <strchr+0xe>
    return 0;
     514:	b8 00 00 00 00       	mov    $0x0,%eax
}
     519:	c9                   	leave  
     51a:	c3                   	ret    

0000051b <gets>:

char* gets(char* buf, int max) {
     51b:	55                   	push   %ebp
     51c:	89 e5                	mov    %esp,%ebp
     51e:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     521:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     528:	eb 42                	jmp    56c <gets+0x51>
        cc = read(0, &c, 1);
     52a:	83 ec 04             	sub    $0x4,%esp
     52d:	6a 01                	push   $0x1
     52f:	8d 45 ef             	lea    -0x11(%ebp),%eax
     532:	50                   	push   %eax
     533:	6a 00                	push   $0x0
     535:	e8 28 fe ff ff       	call   362 <read>
     53a:	83 c4 10             	add    $0x10,%esp
     53d:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     540:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     544:	7e 33                	jle    579 <gets+0x5e>
        buf[i++] = c;
     546:	8b 45 f4             	mov    -0xc(%ebp),%eax
     549:	8d 50 01             	lea    0x1(%eax),%edx
     54c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     54f:	89 c2                	mov    %eax,%edx
     551:	8b 45 08             	mov    0x8(%ebp),%eax
     554:	01 c2                	add    %eax,%edx
     556:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     55a:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     55c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     560:	3c 0a                	cmp    $0xa,%al
     562:	74 16                	je     57a <gets+0x5f>
     564:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     568:	3c 0d                	cmp    $0xd,%al
     56a:	74 0e                	je     57a <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     56c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56f:	83 c0 01             	add    $0x1,%eax
     572:	39 45 0c             	cmp    %eax,0xc(%ebp)
     575:	7f b3                	jg     52a <gets+0xf>
     577:	eb 01                	jmp    57a <gets+0x5f>
        if (cc < 1) break;
     579:	90                   	nop
    }
    buf[i] = '\0';
     57a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     57d:	8b 45 08             	mov    0x8(%ebp),%eax
     580:	01 d0                	add    %edx,%eax
     582:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     585:	8b 45 08             	mov    0x8(%ebp),%eax
}
     588:	c9                   	leave  
     589:	c3                   	ret    

0000058a <stat>:

int stat(const char* n, struct stat* st) {
     58a:	55                   	push   %ebp
     58b:	89 e5                	mov    %esp,%ebp
     58d:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     590:	83 ec 08             	sub    $0x8,%esp
     593:	6a 01                	push   $0x1
     595:	ff 75 08             	push   0x8(%ebp)
     598:	e8 ed fd ff ff       	call   38a <open>
     59d:	83 c4 10             	add    $0x10,%esp
     5a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     5a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5a7:	79 07                	jns    5b0 <stat+0x26>
     5a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5ae:	eb 25                	jmp    5d5 <stat+0x4b>
    r = fstat(fd, st);
     5b0:	83 ec 08             	sub    $0x8,%esp
     5b3:	ff 75 0c             	push   0xc(%ebp)
     5b6:	ff 75 f4             	push   -0xc(%ebp)
     5b9:	e8 e4 fd ff ff       	call   3a2 <fstat>
     5be:	83 c4 10             	add    $0x10,%esp
     5c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     5c4:	83 ec 0c             	sub    $0xc,%esp
     5c7:	ff 75 f4             	push   -0xc(%ebp)
     5ca:	e8 a3 fd ff ff       	call   372 <close>
     5cf:	83 c4 10             	add    $0x10,%esp
    return r;
     5d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     5d5:	c9                   	leave  
     5d6:	c3                   	ret    

000005d7 <atoi>:

int atoi(const char* s) {
     5d7:	55                   	push   %ebp
     5d8:	89 e5                	mov    %esp,%ebp
     5da:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     5dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     5e4:	eb 25                	jmp    60b <atoi+0x34>
     5e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
     5e9:	89 d0                	mov    %edx,%eax
     5eb:	c1 e0 02             	shl    $0x2,%eax
     5ee:	01 d0                	add    %edx,%eax
     5f0:	01 c0                	add    %eax,%eax
     5f2:	89 c1                	mov    %eax,%ecx
     5f4:	8b 45 08             	mov    0x8(%ebp),%eax
     5f7:	8d 50 01             	lea    0x1(%eax),%edx
     5fa:	89 55 08             	mov    %edx,0x8(%ebp)
     5fd:	0f b6 00             	movzbl (%eax),%eax
     600:	0f be c0             	movsbl %al,%eax
     603:	01 c8                	add    %ecx,%eax
     605:	83 e8 30             	sub    $0x30,%eax
     608:	89 45 fc             	mov    %eax,-0x4(%ebp)
     60b:	8b 45 08             	mov    0x8(%ebp),%eax
     60e:	0f b6 00             	movzbl (%eax),%eax
     611:	3c 2f                	cmp    $0x2f,%al
     613:	7e 0a                	jle    61f <atoi+0x48>
     615:	8b 45 08             	mov    0x8(%ebp),%eax
     618:	0f b6 00             	movzbl (%eax),%eax
     61b:	3c 39                	cmp    $0x39,%al
     61d:	7e c7                	jle    5e6 <atoi+0xf>
    return n;
     61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     622:	c9                   	leave  
     623:	c3                   	ret    

00000624 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     624:	55                   	push   %ebp
     625:	89 e5                	mov    %esp,%ebp
     627:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     62a:	8b 45 08             	mov    0x8(%ebp),%eax
     62d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     630:	8b 45 0c             	mov    0xc(%ebp),%eax
     633:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     636:	eb 17                	jmp    64f <memmove+0x2b>
     638:	8b 55 f8             	mov    -0x8(%ebp),%edx
     63b:	8d 42 01             	lea    0x1(%edx),%eax
     63e:	89 45 f8             	mov    %eax,-0x8(%ebp)
     641:	8b 45 fc             	mov    -0x4(%ebp),%eax
     644:	8d 48 01             	lea    0x1(%eax),%ecx
     647:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     64a:	0f b6 12             	movzbl (%edx),%edx
     64d:	88 10                	mov    %dl,(%eax)
     64f:	8b 45 10             	mov    0x10(%ebp),%eax
     652:	8d 50 ff             	lea    -0x1(%eax),%edx
     655:	89 55 10             	mov    %edx,0x10(%ebp)
     658:	85 c0                	test   %eax,%eax
     65a:	7f dc                	jg     638 <memmove+0x14>
    return vdst;
     65c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     65f:	c9                   	leave  
     660:	c3                   	ret    

00000661 <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     661:	55                   	push   %ebp
     662:	89 e5                	mov    %esp,%ebp
     664:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     667:	8b 45 08             	mov    0x8(%ebp),%eax
     66a:	83 e8 08             	sub    $0x8,%eax
     66d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     670:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
     675:	89 45 fc             	mov    %eax,-0x4(%ebp)
     678:	eb 24                	jmp    69e <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67d:	8b 00                	mov    (%eax),%eax
     67f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     682:	72 12                	jb     696 <free+0x35>
     684:	8b 45 f8             	mov    -0x8(%ebp),%eax
     687:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     68a:	77 24                	ja     6b0 <free+0x4f>
     68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68f:	8b 00                	mov    (%eax),%eax
     691:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     694:	72 1a                	jb     6b0 <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     696:	8b 45 fc             	mov    -0x4(%ebp),%eax
     699:	8b 00                	mov    (%eax),%eax
     69b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6a4:	76 d4                	jbe    67a <free+0x19>
     6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a9:	8b 00                	mov    (%eax),%eax
     6ab:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6ae:	73 ca                	jae    67a <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b3:	8b 40 04             	mov    0x4(%eax),%eax
     6b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c0:	01 c2                	add    %eax,%edx
     6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c5:	8b 00                	mov    (%eax),%eax
     6c7:	39 c2                	cmp    %eax,%edx
     6c9:	75 24                	jne    6ef <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
     6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ce:	8b 50 04             	mov    0x4(%eax),%edx
     6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d4:	8b 00                	mov    (%eax),%eax
     6d6:	8b 40 04             	mov    0x4(%eax),%eax
     6d9:	01 c2                	add    %eax,%edx
     6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6de:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
     6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e4:	8b 00                	mov    (%eax),%eax
     6e6:	8b 10                	mov    (%eax),%edx
     6e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6eb:	89 10                	mov    %edx,(%eax)
     6ed:	eb 0a                	jmp    6f9 <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
     6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f2:	8b 10                	mov    (%eax),%edx
     6f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f7:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
     6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fc:	8b 40 04             	mov    0x4(%eax),%eax
     6ff:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     706:	8b 45 fc             	mov    -0x4(%ebp),%eax
     709:	01 d0                	add    %edx,%eax
     70b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     70e:	75 20                	jne    730 <free+0xcf>
        p->s.size += bp->s.size;
     710:	8b 45 fc             	mov    -0x4(%ebp),%eax
     713:	8b 50 04             	mov    0x4(%eax),%edx
     716:	8b 45 f8             	mov    -0x8(%ebp),%eax
     719:	8b 40 04             	mov    0x4(%eax),%eax
     71c:	01 c2                	add    %eax,%edx
     71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     721:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
     724:	8b 45 f8             	mov    -0x8(%ebp),%eax
     727:	8b 10                	mov    (%eax),%edx
     729:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72c:	89 10                	mov    %edx,(%eax)
     72e:	eb 08                	jmp    738 <free+0xd7>
    } else
        p->s.ptr = bp;
     730:	8b 45 fc             	mov    -0x4(%ebp),%eax
     733:	8b 55 f8             	mov    -0x8(%ebp),%edx
     736:	89 10                	mov    %edx,(%eax)
    freep = p;
     738:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73b:	a3 b8 2c 00 00       	mov    %eax,0x2cb8
}
     740:	90                   	nop
     741:	c9                   	leave  
     742:	c3                   	ret    

00000743 <morecore>:

static Header* morecore(uint nu) {
     743:	55                   	push   %ebp
     744:	89 e5                	mov    %esp,%ebp
     746:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
     749:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     750:	77 07                	ja     759 <morecore+0x16>
     752:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
     759:	8b 45 08             	mov    0x8(%ebp),%eax
     75c:	c1 e0 03             	shl    $0x3,%eax
     75f:	83 ec 0c             	sub    $0xc,%esp
     762:	50                   	push   %eax
     763:	e8 6a fc ff ff       	call   3d2 <sbrk>
     768:	83 c4 10             	add    $0x10,%esp
     76b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
     76e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     772:	75 07                	jne    77b <morecore+0x38>
     774:	b8 00 00 00 00       	mov    $0x0,%eax
     779:	eb 26                	jmp    7a1 <morecore+0x5e>
    hp = (Header*) p;
     77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
     781:	8b 45 f0             	mov    -0x10(%ebp),%eax
     784:	8b 55 08             	mov    0x8(%ebp),%edx
     787:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
     78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78d:	83 c0 08             	add    $0x8,%eax
     790:	83 ec 0c             	sub    $0xc,%esp
     793:	50                   	push   %eax
     794:	e8 c8 fe ff ff       	call   661 <free>
     799:	83 c4 10             	add    $0x10,%esp
    return freep;
     79c:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
}
     7a1:	c9                   	leave  
     7a2:	c3                   	ret    

000007a3 <malloc>:

void* malloc(uint nbytes) {
     7a3:	55                   	push   %ebp
     7a4:	89 e5                	mov    %esp,%ebp
     7a6:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     7a9:	8b 45 08             	mov    0x8(%ebp),%eax
     7ac:	83 c0 07             	add    $0x7,%eax
     7af:	c1 e8 03             	shr    $0x3,%eax
     7b2:	83 c0 01             	add    $0x1,%eax
     7b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
     7b8:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
     7bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7c4:	75 23                	jne    7e9 <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
     7c6:	c7 45 f0 b0 2c 00 00 	movl   $0x2cb0,-0x10(%ebp)
     7cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d0:	a3 b8 2c 00 00       	mov    %eax,0x2cb8
     7d5:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
     7da:	a3 b0 2c 00 00       	mov    %eax,0x2cb0
        base.s.size = 0;
     7df:	c7 05 b4 2c 00 00 00 	movl   $0x0,0x2cb4
     7e6:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ec:	8b 00                	mov    (%eax),%eax
     7ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f4:	8b 40 04             	mov    0x4(%eax),%eax
     7f7:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7fa:	77 4d                	ja     849 <malloc+0xa6>
            if (p->s.size == nunits)
     7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ff:	8b 40 04             	mov    0x4(%eax),%eax
     802:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     805:	75 0c                	jne    813 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
     807:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80a:	8b 10                	mov    (%eax),%edx
     80c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     80f:	89 10                	mov    %edx,(%eax)
     811:	eb 26                	jmp    839 <malloc+0x96>
            else {
                p->s.size -= nunits;
     813:	8b 45 f4             	mov    -0xc(%ebp),%eax
     816:	8b 40 04             	mov    0x4(%eax),%eax
     819:	2b 45 ec             	sub    -0x14(%ebp),%eax
     81c:	89 c2                	mov    %eax,%edx
     81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     821:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
     824:	8b 45 f4             	mov    -0xc(%ebp),%eax
     827:	8b 40 04             	mov    0x4(%eax),%eax
     82a:	c1 e0 03             	shl    $0x3,%eax
     82d:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
     830:	8b 45 f4             	mov    -0xc(%ebp),%eax
     833:	8b 55 ec             	mov    -0x14(%ebp),%edx
     836:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
     839:	8b 45 f0             	mov    -0x10(%ebp),%eax
     83c:	a3 b8 2c 00 00       	mov    %eax,0x2cb8
            return (void*) (p + 1);
     841:	8b 45 f4             	mov    -0xc(%ebp),%eax
     844:	83 c0 08             	add    $0x8,%eax
     847:	eb 3b                	jmp    884 <malloc+0xe1>
        }
        if (p == freep)
     849:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
     84e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     851:	75 1e                	jne    871 <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
     853:	83 ec 0c             	sub    $0xc,%esp
     856:	ff 75 ec             	push   -0x14(%ebp)
     859:	e8 e5 fe ff ff       	call   743 <morecore>
     85e:	83 c4 10             	add    $0x10,%esp
     861:	89 45 f4             	mov    %eax,-0xc(%ebp)
     864:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     868:	75 07                	jne    871 <malloc+0xce>
     86a:	b8 00 00 00 00       	mov    $0x0,%eax
     86f:	eb 13                	jmp    884 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
     871:	8b 45 f4             	mov    -0xc(%ebp),%eax
     874:	89 45 f0             	mov    %eax,-0x10(%ebp)
     877:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87a:	8b 00                	mov    (%eax),%eax
     87c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
     87f:	e9 6d ff ff ff       	jmp    7f1 <malloc+0x4e>
    }
}
     884:	c9                   	leave  
     885:	c3                   	ret    

00000886 <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
     886:	55                   	push   %ebp
     887:	89 e5                	mov    %esp,%ebp
     889:	83 ec 18             	sub    $0x18,%esp
     88c:	8b 45 0c             	mov    0xc(%ebp),%eax
     88f:	88 45 f4             	mov    %al,-0xc(%ebp)
     892:	83 ec 04             	sub    $0x4,%esp
     895:	6a 01                	push   $0x1
     897:	8d 45 f4             	lea    -0xc(%ebp),%eax
     89a:	50                   	push   %eax
     89b:	ff 75 08             	push   0x8(%ebp)
     89e:	e8 c7 fa ff ff       	call   36a <write>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	90                   	nop
     8a7:	c9                   	leave  
     8a8:	c3                   	ret    

000008a9 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
     8a9:	55                   	push   %ebp
     8aa:	89 e5                	mov    %esp,%ebp
     8ac:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
     8af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
     8b6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     8ba:	74 17                	je     8d3 <printint+0x2a>
     8bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8c0:	79 11                	jns    8d3 <printint+0x2a>
        neg = 1;
     8c2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
     8c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8cc:	f7 d8                	neg    %eax
     8ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
     8d1:	eb 06                	jmp    8d9 <printint+0x30>
    } else {
        x = xx;
     8d3:	8b 45 0c             	mov    0xc(%ebp),%eax
     8d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
     8d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
     8e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
     8e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     8e6:	ba 00 00 00 00       	mov    $0x0,%edx
     8eb:	f7 f1                	div    %ecx
     8ed:	89 d1                	mov    %edx,%ecx
     8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f2:	8d 50 01             	lea    0x1(%eax),%edx
     8f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
     8f8:	0f b6 91 80 2c 00 00 	movzbl 0x2c80(%ecx),%edx
     8ff:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
     903:	8b 4d 10             	mov    0x10(%ebp),%ecx
     906:	8b 45 ec             	mov    -0x14(%ebp),%eax
     909:	ba 00 00 00 00       	mov    $0x0,%edx
     90e:	f7 f1                	div    %ecx
     910:	89 45 ec             	mov    %eax,-0x14(%ebp)
     913:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     917:	75 c7                	jne    8e0 <printint+0x37>
    if (neg) buf[i++] = '-';
     919:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     91d:	74 2d                	je     94c <printint+0xa3>
     91f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     922:	8d 50 01             	lea    0x1(%eax),%edx
     925:	89 55 f4             	mov    %edx,-0xc(%ebp)
     928:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
     92d:	eb 1d                	jmp    94c <printint+0xa3>
     92f:	8d 55 dc             	lea    -0x24(%ebp),%edx
     932:	8b 45 f4             	mov    -0xc(%ebp),%eax
     935:	01 d0                	add    %edx,%eax
     937:	0f b6 00             	movzbl (%eax),%eax
     93a:	0f be c0             	movsbl %al,%eax
     93d:	83 ec 08             	sub    $0x8,%esp
     940:	50                   	push   %eax
     941:	ff 75 08             	push   0x8(%ebp)
     944:	e8 3d ff ff ff       	call   886 <putc>
     949:	83 c4 10             	add    $0x10,%esp
     94c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     950:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     954:	79 d9                	jns    92f <printint+0x86>
}
     956:	90                   	nop
     957:	90                   	nop
     958:	c9                   	leave  
     959:	c3                   	ret    

0000095a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
     95a:	55                   	push   %ebp
     95b:	89 e5                	mov    %esp,%ebp
     95d:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
     960:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
     967:	8d 45 0c             	lea    0xc(%ebp),%eax
     96a:	83 c0 04             	add    $0x4,%eax
     96d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
     970:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     977:	e9 59 01 00 00       	jmp    ad5 <printf+0x17b>
        c = fmt[i] & 0xff;
     97c:	8b 55 0c             	mov    0xc(%ebp),%edx
     97f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     982:	01 d0                	add    %edx,%eax
     984:	0f b6 00             	movzbl (%eax),%eax
     987:	0f be c0             	movsbl %al,%eax
     98a:	25 ff 00 00 00       	and    $0xff,%eax
     98f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
     992:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     996:	75 2c                	jne    9c4 <printf+0x6a>
            if (c == '%') {
     998:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     99c:	75 0c                	jne    9aa <printf+0x50>
                state = '%';
     99e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     9a5:	e9 27 01 00 00       	jmp    ad1 <printf+0x177>
            } else {
                putc(fd, c);
     9aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9ad:	0f be c0             	movsbl %al,%eax
     9b0:	83 ec 08             	sub    $0x8,%esp
     9b3:	50                   	push   %eax
     9b4:	ff 75 08             	push   0x8(%ebp)
     9b7:	e8 ca fe ff ff       	call   886 <putc>
     9bc:	83 c4 10             	add    $0x10,%esp
     9bf:	e9 0d 01 00 00       	jmp    ad1 <printf+0x177>
            }
        } else if (state == '%') {
     9c4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     9c8:	0f 85 03 01 00 00    	jne    ad1 <printf+0x177>
            if (c == 'd') {
     9ce:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     9d2:	75 1e                	jne    9f2 <printf+0x98>
                printint(fd, *ap, 10, 1);
     9d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9d7:	8b 00                	mov    (%eax),%eax
     9d9:	6a 01                	push   $0x1
     9db:	6a 0a                	push   $0xa
     9dd:	50                   	push   %eax
     9de:	ff 75 08             	push   0x8(%ebp)
     9e1:	e8 c3 fe ff ff       	call   8a9 <printint>
     9e6:	83 c4 10             	add    $0x10,%esp
                ap++;
     9e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     9ed:	e9 d8 00 00 00       	jmp    aca <printf+0x170>
            } else if (c == 'x' || c == 'p') {
     9f2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     9f6:	74 06                	je     9fe <printf+0xa4>
     9f8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     9fc:	75 1e                	jne    a1c <printf+0xc2>
                printint(fd, *ap, 16, 0);
     9fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a01:	8b 00                	mov    (%eax),%eax
     a03:	6a 00                	push   $0x0
     a05:	6a 10                	push   $0x10
     a07:	50                   	push   %eax
     a08:	ff 75 08             	push   0x8(%ebp)
     a0b:	e8 99 fe ff ff       	call   8a9 <printint>
     a10:	83 c4 10             	add    $0x10,%esp
                ap++;
     a13:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a17:	e9 ae 00 00 00       	jmp    aca <printf+0x170>
            } else if (c == 's') {
     a1c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     a20:	75 43                	jne    a65 <printf+0x10b>
                s = (char*) *ap;
     a22:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a25:	8b 00                	mov    (%eax),%eax
     a27:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
     a2a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
     a2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a32:	75 25                	jne    a59 <printf+0xff>
     a34:	c7 45 f4 4a 22 00 00 	movl   $0x224a,-0xc(%ebp)
                while (*s != 0) {
     a3b:	eb 1c                	jmp    a59 <printf+0xff>
                    putc(fd, *s);
     a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a40:	0f b6 00             	movzbl (%eax),%eax
     a43:	0f be c0             	movsbl %al,%eax
     a46:	83 ec 08             	sub    $0x8,%esp
     a49:	50                   	push   %eax
     a4a:	ff 75 08             	push   0x8(%ebp)
     a4d:	e8 34 fe ff ff       	call   886 <putc>
     a52:	83 c4 10             	add    $0x10,%esp
                    s++;
     a55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
     a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5c:	0f b6 00             	movzbl (%eax),%eax
     a5f:	84 c0                	test   %al,%al
     a61:	75 da                	jne    a3d <printf+0xe3>
     a63:	eb 65                	jmp    aca <printf+0x170>
                }
            } else if (c == 'c') {
     a65:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     a69:	75 1d                	jne    a88 <printf+0x12e>
                putc(fd, *ap);
     a6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a6e:	8b 00                	mov    (%eax),%eax
     a70:	0f be c0             	movsbl %al,%eax
     a73:	83 ec 08             	sub    $0x8,%esp
     a76:	50                   	push   %eax
     a77:	ff 75 08             	push   0x8(%ebp)
     a7a:	e8 07 fe ff ff       	call   886 <putc>
     a7f:	83 c4 10             	add    $0x10,%esp
                ap++;
     a82:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a86:	eb 42                	jmp    aca <printf+0x170>
            } else if (c == '%') {
     a88:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     a8c:	75 17                	jne    aa5 <printf+0x14b>
                putc(fd, c);
     a8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a91:	0f be c0             	movsbl %al,%eax
     a94:	83 ec 08             	sub    $0x8,%esp
     a97:	50                   	push   %eax
     a98:	ff 75 08             	push   0x8(%ebp)
     a9b:	e8 e6 fd ff ff       	call   886 <putc>
     aa0:	83 c4 10             	add    $0x10,%esp
     aa3:	eb 25                	jmp    aca <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     aa5:	83 ec 08             	sub    $0x8,%esp
     aa8:	6a 25                	push   $0x25
     aaa:	ff 75 08             	push   0x8(%ebp)
     aad:	e8 d4 fd ff ff       	call   886 <putc>
     ab2:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
     ab5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ab8:	0f be c0             	movsbl %al,%eax
     abb:	83 ec 08             	sub    $0x8,%esp
     abe:	50                   	push   %eax
     abf:	ff 75 08             	push   0x8(%ebp)
     ac2:	e8 bf fd ff ff       	call   886 <putc>
     ac7:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
     aca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
     ad1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ad5:	8b 55 0c             	mov    0xc(%ebp),%edx
     ad8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     adb:	01 d0                	add    %edx,%eax
     add:	0f b6 00             	movzbl (%eax),%eax
     ae0:	84 c0                	test   %al,%al
     ae2:	0f 85 94 fe ff ff    	jne    97c <printf+0x22>
        }
    }
}
     ae8:	90                   	nop
     ae9:	90                   	nop
     aea:	c9                   	leave  
     aeb:	c3                   	ret    

00000aec <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
     aec:	55                   	push   %ebp
     aed:	89 e5                	mov    %esp,%ebp
     aef:	83 ec 04             	sub    $0x4,%esp
     af2:	8b 45 08             	mov    0x8(%ebp),%eax
     af5:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
     af8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     afc:	01 c0                	add    %eax,%eax
     afe:	89 c1                	mov    %eax,%ecx
     b00:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     b04:	c0 e8 07             	shr    $0x7,%al
     b07:	89 c2                	mov    %eax,%edx
     b09:	89 d0                	mov    %edx,%eax
     b0b:	01 c0                	add    %eax,%eax
     b0d:	01 d0                	add    %edx,%eax
     b0f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     b16:	01 d0                	add    %edx,%eax
     b18:	31 c8                	xor    %ecx,%eax
}
     b1a:	c9                   	leave  
     b1b:	c3                   	ret    

00000b1c <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
     b1c:	55                   	push   %ebp
     b1d:	89 e5                	mov    %esp,%ebp
     b1f:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     b20:	bb 00 00 00 00       	mov    $0x0,%ebx
     b25:	eb 24                	jmp    b4b <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
     b27:	0f b6 d3             	movzbl %bl,%edx
     b2a:	8b 45 08             	mov    0x8(%ebp),%eax
     b2d:	01 d0                	add    %edx,%eax
     b2f:	0f b6 00             	movzbl (%eax),%eax
     b32:	0f b6 c0             	movzbl %al,%eax
     b35:	0f b6 cb             	movzbl %bl,%ecx
     b38:	8b 55 08             	mov    0x8(%ebp),%edx
     b3b:	01 ca                	add    %ecx,%edx
     b3d:	0f b6 80 60 22 00 00 	movzbl 0x2260(%eax),%eax
     b44:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     b46:	89 d8                	mov    %ebx,%eax
     b48:	8d 58 01             	lea    0x1(%eax),%ebx
     b4b:	80 fb 0f             	cmp    $0xf,%bl
     b4e:	76 d7                	jbe    b27 <aes_subBytes+0xb>
    }
}
     b50:	90                   	nop
     b51:	90                   	nop
     b52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b55:	c9                   	leave  
     b56:	c3                   	ret    

00000b57 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
     b57:	55                   	push   %ebp
     b58:	89 e5                	mov    %esp,%ebp
     b5a:	56                   	push   %esi
     b5b:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
     b5c:	bb 00 00 00 00       	mov    $0x0,%ebx
     b61:	eb 27                	jmp    b8a <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
     b63:	0f b6 d3             	movzbl %bl,%edx
     b66:	8b 45 08             	mov    0x8(%ebp),%eax
     b69:	01 d0                	add    %edx,%eax
     b6b:	0f b6 08             	movzbl (%eax),%ecx
     b6e:	0f b6 d3             	movzbl %bl,%edx
     b71:	8b 45 0c             	mov    0xc(%ebp),%eax
     b74:	01 d0                	add    %edx,%eax
     b76:	0f b6 10             	movzbl (%eax),%edx
     b79:	0f b6 f3             	movzbl %bl,%esi
     b7c:	8b 45 08             	mov    0x8(%ebp),%eax
     b7f:	01 f0                	add    %esi,%eax
     b81:	31 ca                	xor    %ecx,%edx
     b83:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
     b85:	89 d8                	mov    %ebx,%eax
     b87:	8d 58 01             	lea    0x1(%eax),%ebx
     b8a:	80 fb 0f             	cmp    $0xf,%bl
     b8d:	76 d4                	jbe    b63 <aes_addRoundKey+0xc>
    }
}
     b8f:	90                   	nop
     b90:	90                   	nop
     b91:	5b                   	pop    %ebx
     b92:	5e                   	pop    %esi
     b93:	5d                   	pop    %ebp
     b94:	c3                   	ret    

00000b95 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
     b95:	55                   	push   %ebp
     b96:	89 e5                	mov    %esp,%ebp
     b98:	56                   	push   %esi
     b99:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
     b9a:	bb 00 00 00 00       	mov    $0x0,%ebx
     b9f:	eb 5b                	jmp    bfc <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
     ba1:	0f b6 d3             	movzbl %bl,%edx
     ba4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba7:	01 d0                	add    %edx,%eax
     ba9:	0f b6 cb             	movzbl %bl,%ecx
     bac:	8b 55 10             	mov    0x10(%ebp),%edx
     baf:	01 ca                	add    %ecx,%edx
     bb1:	0f b6 00             	movzbl (%eax),%eax
     bb4:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
     bb6:	0f b6 d3             	movzbl %bl,%edx
     bb9:	8b 45 08             	mov    0x8(%ebp),%eax
     bbc:	01 d0                	add    %edx,%eax
     bbe:	0f b6 08             	movzbl (%eax),%ecx
     bc1:	0f b6 d3             	movzbl %bl,%edx
     bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc7:	01 d0                	add    %edx,%eax
     bc9:	0f b6 10             	movzbl (%eax),%edx
     bcc:	0f b6 f3             	movzbl %bl,%esi
     bcf:	8b 45 08             	mov    0x8(%ebp),%eax
     bd2:	01 f0                	add    %esi,%eax
     bd4:	31 ca                	xor    %ecx,%edx
     bd6:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
     bd8:	0f b6 c3             	movzbl %bl,%eax
     bdb:	83 c0 10             	add    $0x10,%eax
     bde:	89 c2                	mov    %eax,%edx
     be0:	8b 45 0c             	mov    0xc(%ebp),%eax
     be3:	01 d0                	add    %edx,%eax
     be5:	0f b6 d3             	movzbl %bl,%edx
     be8:	83 c2 10             	add    $0x10,%edx
     beb:	89 d1                	mov    %edx,%ecx
     bed:	8b 55 10             	mov    0x10(%ebp),%edx
     bf0:	01 ca                	add    %ecx,%edx
     bf2:	0f b6 00             	movzbl (%eax),%eax
     bf5:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
     bf7:	89 d8                	mov    %ebx,%eax
     bf9:	8d 58 01             	lea    0x1(%eax),%ebx
     bfc:	80 fb 0f             	cmp    $0xf,%bl
     bff:	76 a0                	jbe    ba1 <aes_addRoundKey_cpy+0xc>
    }
}
     c01:	90                   	nop
     c02:	90                   	nop
     c03:	5b                   	pop    %ebx
     c04:	5e                   	pop    %esi
     c05:	5d                   	pop    %ebp
     c06:	c3                   	ret    

00000c07 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
     c07:	55                   	push   %ebp
     c08:	89 e5                	mov    %esp,%ebp
     c0a:	53                   	push   %ebx
     c0b:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
     c0e:	8b 45 08             	mov    0x8(%ebp),%eax
     c11:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
     c15:	8b 45 08             	mov    0x8(%ebp),%eax
     c18:	0f b6 40 03          	movzbl 0x3(%eax),%eax
     c1c:	88 45 fb             	mov    %al,-0x5(%ebp)
     c1f:	8b 45 08             	mov    0x8(%ebp),%eax
     c22:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
     c26:	88 5d fa             	mov    %bl,-0x6(%ebp)
     c29:	8b 45 08             	mov    0x8(%ebp),%eax
     c2c:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
     c30:	8b 45 08             	mov    0x8(%ebp),%eax
     c33:	8d 50 01             	lea    0x1(%eax),%edx
     c36:	8b 45 08             	mov    0x8(%ebp),%eax
     c39:	0f b6 40 05          	movzbl 0x5(%eax),%eax
     c3d:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
     c3f:	8b 45 08             	mov    0x8(%ebp),%eax
     c42:	8d 50 05             	lea    0x5(%eax),%edx
     c45:	8b 45 08             	mov    0x8(%ebp),%eax
     c48:	0f b6 40 09          	movzbl 0x9(%eax),%eax
     c4c:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
     c4e:	8b 45 08             	mov    0x8(%ebp),%eax
     c51:	8d 50 09             	lea    0x9(%eax),%edx
     c54:	8b 45 08             	mov    0x8(%ebp),%eax
     c57:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
     c5b:	88 02                	mov    %al,(%edx)
    buf[13] = i;
     c5d:	8b 45 08             	mov    0x8(%ebp),%eax
     c60:	83 c0 0d             	add    $0xd,%eax
     c63:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
     c65:	8b 45 08             	mov    0x8(%ebp),%eax
     c68:	8d 50 03             	lea    0x3(%eax),%edx
     c6b:	8b 45 08             	mov    0x8(%ebp),%eax
     c6e:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
     c72:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
     c74:	8b 45 08             	mov    0x8(%ebp),%eax
     c77:	8d 50 0f             	lea    0xf(%eax),%edx
     c7a:	8b 45 08             	mov    0x8(%ebp),%eax
     c7d:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
     c81:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
     c83:	8b 45 08             	mov    0x8(%ebp),%eax
     c86:	8d 50 0b             	lea    0xb(%eax),%edx
     c89:	8b 45 08             	mov    0x8(%ebp),%eax
     c8c:	0f b6 40 07          	movzbl 0x7(%eax),%eax
     c90:	88 02                	mov    %al,(%edx)
    buf[7] = j;
     c92:	8b 45 08             	mov    0x8(%ebp),%eax
     c95:	83 c0 07             	add    $0x7,%eax
     c98:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
     c9c:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
     c9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ca1:	8d 50 0a             	lea    0xa(%eax),%edx
     ca4:	8b 45 08             	mov    0x8(%ebp),%eax
     ca7:	0f b6 40 02          	movzbl 0x2(%eax),%eax
     cab:	88 02                	mov    %al,(%edx)
    buf[2] = k;
     cad:	8b 45 08             	mov    0x8(%ebp),%eax
     cb0:	83 c0 02             	add    $0x2,%eax
     cb3:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
     cb7:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
     cb9:	8b 45 08             	mov    0x8(%ebp),%eax
     cbc:	8d 50 0e             	lea    0xe(%eax),%edx
     cbf:	8b 45 08             	mov    0x8(%ebp),%eax
     cc2:	0f b6 40 06          	movzbl 0x6(%eax),%eax
     cc6:	88 02                	mov    %al,(%edx)
    buf[6] = l;
     cc8:	8b 45 08             	mov    0x8(%ebp),%eax
     ccb:	83 c0 06             	add    $0x6,%eax
     cce:	88 18                	mov    %bl,(%eax)
}
     cd0:	90                   	nop
     cd1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cd4:	c9                   	leave  
     cd5:	c3                   	ret    

00000cd6 <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
     cd6:	55                   	push   %ebp
     cd7:	89 e5                	mov    %esp,%ebp
     cd9:	56                   	push   %esi
     cda:	53                   	push   %ebx
     cdb:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
     cde:	bb 00 00 00 00       	mov    $0x0,%ebx
     ce3:	e9 42 01 00 00       	jmp    e2a <aes_mixColumns+0x154>
        a = buf[i];
     ce8:	0f b6 d3             	movzbl %bl,%edx
     ceb:	8b 45 08             	mov    0x8(%ebp),%eax
     cee:	01 d0                	add    %edx,%eax
     cf0:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
     cf3:	0f b6 c3             	movzbl %bl,%eax
     cf6:	8d 50 01             	lea    0x1(%eax),%edx
     cf9:	8b 45 08             	mov    0x8(%ebp),%eax
     cfc:	01 d0                	add    %edx,%eax
     cfe:	0f b6 10             	movzbl (%eax),%edx
     d01:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
     d04:	0f b6 c3             	movzbl %bl,%eax
     d07:	8d 50 02             	lea    0x2(%eax),%edx
     d0a:	8b 45 08             	mov    0x8(%ebp),%eax
     d0d:	01 d0                	add    %edx,%eax
     d0f:	0f b6 00             	movzbl (%eax),%eax
     d12:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
     d15:	0f b6 c3             	movzbl %bl,%eax
     d18:	8d 50 03             	lea    0x3(%eax),%edx
     d1b:	8b 45 08             	mov    0x8(%ebp),%eax
     d1e:	01 d0                	add    %edx,%eax
     d20:	0f b6 00             	movzbl (%eax),%eax
     d23:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
     d26:	89 c8                	mov    %ecx,%eax
     d28:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     d2c:	31 d0                	xor    %edx,%eax
     d2e:	32 45 f6             	xor    -0xa(%ebp),%al
     d31:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
     d35:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
     d37:	88 4d f4             	mov    %cl,-0xc(%ebp)
     d3a:	89 c8                	mov    %ecx,%eax
     d3c:	88 55 f7             	mov    %dl,-0x9(%ebp)
     d3f:	32 45 f7             	xor    -0x9(%ebp),%al
     d42:	0f b6 c0             	movzbl %al,%eax
     d45:	50                   	push   %eax
     d46:	e8 a1 fd ff ff       	call   aec <rj_xtime>
     d4b:	83 c4 04             	add    $0x4,%esp
     d4e:	31 f0                	xor    %esi,%eax
     d50:	0f b6 c8             	movzbl %al,%ecx
     d53:	0f b6 d3             	movzbl %bl,%edx
     d56:	8b 45 08             	mov    0x8(%ebp),%eax
     d59:	01 d0                	add    %edx,%eax
     d5b:	0f b6 00             	movzbl (%eax),%eax
     d5e:	89 c2                	mov    %eax,%edx
     d60:	89 c8                	mov    %ecx,%eax
     d62:	89 d1                	mov    %edx,%ecx
     d64:	31 c1                	xor    %eax,%ecx
     d66:	0f b6 d3             	movzbl %bl,%edx
     d69:	8b 45 08             	mov    0x8(%ebp),%eax
     d6c:	01 c2                	add    %eax,%edx
     d6e:	89 c8                	mov    %ecx,%eax
     d70:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
     d72:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
     d76:	32 55 f6             	xor    -0xa(%ebp),%dl
     d79:	89 d0                	mov    %edx,%eax
     d7b:	0f b6 c0             	movzbl %al,%eax
     d7e:	50                   	push   %eax
     d7f:	e8 68 fd ff ff       	call   aec <rj_xtime>
     d84:	83 c4 04             	add    $0x4,%esp
     d87:	31 f0                	xor    %esi,%eax
     d89:	0f b6 c8             	movzbl %al,%ecx
     d8c:	0f b6 c3             	movzbl %bl,%eax
     d8f:	8d 50 01             	lea    0x1(%eax),%edx
     d92:	8b 45 08             	mov    0x8(%ebp),%eax
     d95:	01 d0                	add    %edx,%eax
     d97:	0f b6 00             	movzbl (%eax),%eax
     d9a:	89 c2                	mov    %eax,%edx
     d9c:	89 c8                	mov    %ecx,%eax
     d9e:	31 c2                	xor    %eax,%edx
     da0:	89 d1                	mov    %edx,%ecx
     da2:	0f b6 c3             	movzbl %bl,%eax
     da5:	8d 50 01             	lea    0x1(%eax),%edx
     da8:	8b 45 08             	mov    0x8(%ebp),%eax
     dab:	01 c2                	add    %eax,%edx
     dad:	89 c8                	mov    %ecx,%eax
     daf:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
     db1:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     db5:	32 45 f5             	xor    -0xb(%ebp),%al
     db8:	0f b6 c0             	movzbl %al,%eax
     dbb:	50                   	push   %eax
     dbc:	e8 2b fd ff ff       	call   aec <rj_xtime>
     dc1:	83 c4 04             	add    $0x4,%esp
     dc4:	31 f0                	xor    %esi,%eax
     dc6:	0f b6 d0             	movzbl %al,%edx
     dc9:	0f b6 c3             	movzbl %bl,%eax
     dcc:	8d 48 02             	lea    0x2(%eax),%ecx
     dcf:	8b 45 08             	mov    0x8(%ebp),%eax
     dd2:	01 c8                	add    %ecx,%eax
     dd4:	0f b6 00             	movzbl (%eax),%eax
     dd7:	89 c1                	mov    %eax,%ecx
     dd9:	89 d0                	mov    %edx,%eax
     ddb:	89 ca                	mov    %ecx,%edx
     ddd:	31 c2                	xor    %eax,%edx
     ddf:	0f b6 c3             	movzbl %bl,%eax
     de2:	8d 48 02             	lea    0x2(%eax),%ecx
     de5:	8b 45 08             	mov    0x8(%ebp),%eax
     de8:	01 c8                	add    %ecx,%eax
     dea:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
     dec:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
     df0:	32 45 f4             	xor    -0xc(%ebp),%al
     df3:	0f b6 c0             	movzbl %al,%eax
     df6:	50                   	push   %eax
     df7:	e8 f0 fc ff ff       	call   aec <rj_xtime>
     dfc:	83 c4 04             	add    $0x4,%esp
     dff:	31 f0                	xor    %esi,%eax
     e01:	0f b6 d0             	movzbl %al,%edx
     e04:	0f b6 c3             	movzbl %bl,%eax
     e07:	8d 48 03             	lea    0x3(%eax),%ecx
     e0a:	8b 45 08             	mov    0x8(%ebp),%eax
     e0d:	01 c8                	add    %ecx,%eax
     e0f:	0f b6 00             	movzbl (%eax),%eax
     e12:	89 c1                	mov    %eax,%ecx
     e14:	89 d0                	mov    %edx,%eax
     e16:	31 c1                	xor    %eax,%ecx
     e18:	89 ca                	mov    %ecx,%edx
     e1a:	0f b6 c3             	movzbl %bl,%eax
     e1d:	8d 48 03             	lea    0x3(%eax),%ecx
     e20:	8b 45 08             	mov    0x8(%ebp),%eax
     e23:	01 c8                	add    %ecx,%eax
     e25:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
     e27:	83 c3 04             	add    $0x4,%ebx
     e2a:	80 fb 0f             	cmp    $0xf,%bl
     e2d:	0f 86 b5 fe ff ff    	jbe    ce8 <aes_mixColumns+0x12>
    }
}
     e33:	90                   	nop
     e34:	90                   	nop
     e35:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e38:	5b                   	pop    %ebx
     e39:	5e                   	pop    %esi
     e3a:	5d                   	pop    %ebp
     e3b:	c3                   	ret    

00000e3c <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
     e3c:	55                   	push   %ebp
     e3d:	89 e5                	mov    %esp,%ebp
     e3f:	56                   	push   %esi
     e40:	53                   	push   %ebx
     e41:	83 ec 04             	sub    $0x4,%esp
     e44:	8b 45 0c             	mov    0xc(%ebp),%eax
     e47:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
     e4a:	8b 45 08             	mov    0x8(%ebp),%eax
     e4d:	0f b6 10             	movzbl (%eax),%edx
     e50:	8b 45 08             	mov    0x8(%ebp),%eax
     e53:	83 c0 1d             	add    $0x1d,%eax
     e56:	0f b6 00             	movzbl (%eax),%eax
     e59:	0f b6 c0             	movzbl %al,%eax
     e5c:	0f b6 80 60 22 00 00 	movzbl 0x2260(%eax),%eax
     e63:	32 45 f4             	xor    -0xc(%ebp),%al
     e66:	31 c2                	xor    %eax,%edx
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
     e6d:	8b 45 08             	mov    0x8(%ebp),%eax
     e70:	83 c0 01             	add    $0x1,%eax
     e73:	0f b6 08             	movzbl (%eax),%ecx
     e76:	8b 45 08             	mov    0x8(%ebp),%eax
     e79:	83 c0 1e             	add    $0x1e,%eax
     e7c:	0f b6 00             	movzbl (%eax),%eax
     e7f:	0f b6 c0             	movzbl %al,%eax
     e82:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
     e89:	8b 45 08             	mov    0x8(%ebp),%eax
     e8c:	83 c0 01             	add    $0x1,%eax
     e8f:	31 ca                	xor    %ecx,%edx
     e91:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	83 c0 02             	add    $0x2,%eax
     e99:	0f b6 08             	movzbl (%eax),%ecx
     e9c:	8b 45 08             	mov    0x8(%ebp),%eax
     e9f:	83 c0 1f             	add    $0x1f,%eax
     ea2:	0f b6 00             	movzbl (%eax),%eax
     ea5:	0f b6 c0             	movzbl %al,%eax
     ea8:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
     eaf:	8b 45 08             	mov    0x8(%ebp),%eax
     eb2:	83 c0 02             	add    $0x2,%eax
     eb5:	31 ca                	xor    %ecx,%edx
     eb7:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
     eb9:	8b 45 08             	mov    0x8(%ebp),%eax
     ebc:	83 c0 03             	add    $0x3,%eax
     ebf:	0f b6 08             	movzbl (%eax),%ecx
     ec2:	8b 45 08             	mov    0x8(%ebp),%eax
     ec5:	83 c0 1c             	add    $0x1c,%eax
     ec8:	0f b6 00             	movzbl (%eax),%eax
     ecb:	0f b6 c0             	movzbl %al,%eax
     ece:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	83 c0 03             	add    $0x3,%eax
     edb:	31 ca                	xor    %ecx,%edx
     edd:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
     edf:	bb 04 00 00 00       	mov    $0x4,%ebx
     ee4:	e9 a9 00 00 00       	jmp    f92 <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
     ee9:	0f b6 d3             	movzbl %bl,%edx
     eec:	8b 45 08             	mov    0x8(%ebp),%eax
     eef:	01 d0                	add    %edx,%eax
     ef1:	0f b6 08             	movzbl (%eax),%ecx
     ef4:	0f b6 c3             	movzbl %bl,%eax
     ef7:	8d 50 fc             	lea    -0x4(%eax),%edx
     efa:	8b 45 08             	mov    0x8(%ebp),%eax
     efd:	01 d0                	add    %edx,%eax
     eff:	0f b6 10             	movzbl (%eax),%edx
     f02:	0f b6 f3             	movzbl %bl,%esi
     f05:	8b 45 08             	mov    0x8(%ebp),%eax
     f08:	01 f0                	add    %esi,%eax
     f0a:	31 ca                	xor    %ecx,%edx
     f0c:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
     f0e:	0f b6 c3             	movzbl %bl,%eax
     f11:	8d 50 01             	lea    0x1(%eax),%edx
     f14:	8b 45 08             	mov    0x8(%ebp),%eax
     f17:	01 d0                	add    %edx,%eax
     f19:	0f b6 08             	movzbl (%eax),%ecx
     f1c:	0f b6 c3             	movzbl %bl,%eax
     f1f:	8d 50 fd             	lea    -0x3(%eax),%edx
     f22:	8b 45 08             	mov    0x8(%ebp),%eax
     f25:	01 d0                	add    %edx,%eax
     f27:	0f b6 10             	movzbl (%eax),%edx
     f2a:	0f b6 c3             	movzbl %bl,%eax
     f2d:	8d 70 01             	lea    0x1(%eax),%esi
     f30:	8b 45 08             	mov    0x8(%ebp),%eax
     f33:	01 f0                	add    %esi,%eax
     f35:	31 ca                	xor    %ecx,%edx
     f37:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
     f39:	0f b6 c3             	movzbl %bl,%eax
     f3c:	8d 50 02             	lea    0x2(%eax),%edx
     f3f:	8b 45 08             	mov    0x8(%ebp),%eax
     f42:	01 d0                	add    %edx,%eax
     f44:	0f b6 08             	movzbl (%eax),%ecx
     f47:	0f b6 c3             	movzbl %bl,%eax
     f4a:	8d 50 fe             	lea    -0x2(%eax),%edx
     f4d:	8b 45 08             	mov    0x8(%ebp),%eax
     f50:	01 d0                	add    %edx,%eax
     f52:	0f b6 10             	movzbl (%eax),%edx
     f55:	0f b6 c3             	movzbl %bl,%eax
     f58:	8d 70 02             	lea    0x2(%eax),%esi
     f5b:	8b 45 08             	mov    0x8(%ebp),%eax
     f5e:	01 f0                	add    %esi,%eax
     f60:	31 ca                	xor    %ecx,%edx
     f62:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
     f64:	0f b6 c3             	movzbl %bl,%eax
     f67:	8d 50 03             	lea    0x3(%eax),%edx
     f6a:	8b 45 08             	mov    0x8(%ebp),%eax
     f6d:	01 d0                	add    %edx,%eax
     f6f:	0f b6 08             	movzbl (%eax),%ecx
     f72:	0f b6 c3             	movzbl %bl,%eax
     f75:	8d 50 ff             	lea    -0x1(%eax),%edx
     f78:	8b 45 08             	mov    0x8(%ebp),%eax
     f7b:	01 d0                	add    %edx,%eax
     f7d:	0f b6 10             	movzbl (%eax),%edx
     f80:	0f b6 c3             	movzbl %bl,%eax
     f83:	8d 70 03             	lea    0x3(%eax),%esi
     f86:	8b 45 08             	mov    0x8(%ebp),%eax
     f89:	01 f0                	add    %esi,%eax
     f8b:	31 ca                	xor    %ecx,%edx
     f8d:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
     f8f:	83 c3 04             	add    $0x4,%ebx
     f92:	80 fb 0f             	cmp    $0xf,%bl
     f95:	0f 86 4e ff ff ff    	jbe    ee9 <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
     f9b:	8b 45 08             	mov    0x8(%ebp),%eax
     f9e:	83 c0 10             	add    $0x10,%eax
     fa1:	0f b6 08             	movzbl (%eax),%ecx
     fa4:	8b 45 08             	mov    0x8(%ebp),%eax
     fa7:	83 c0 0c             	add    $0xc,%eax
     faa:	0f b6 00             	movzbl (%eax),%eax
     fad:	0f b6 c0             	movzbl %al,%eax
     fb0:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
     fb7:	8b 45 08             	mov    0x8(%ebp),%eax
     fba:	83 c0 10             	add    $0x10,%eax
     fbd:	31 ca                	xor    %ecx,%edx
     fbf:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
     fc1:	8b 45 08             	mov    0x8(%ebp),%eax
     fc4:	83 c0 11             	add    $0x11,%eax
     fc7:	0f b6 08             	movzbl (%eax),%ecx
     fca:	8b 45 08             	mov    0x8(%ebp),%eax
     fcd:	83 c0 0d             	add    $0xd,%eax
     fd0:	0f b6 00             	movzbl (%eax),%eax
     fd3:	0f b6 c0             	movzbl %al,%eax
     fd6:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
     fdd:	8b 45 08             	mov    0x8(%ebp),%eax
     fe0:	83 c0 11             	add    $0x11,%eax
     fe3:	31 ca                	xor    %ecx,%edx
     fe5:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
     fe7:	8b 45 08             	mov    0x8(%ebp),%eax
     fea:	83 c0 12             	add    $0x12,%eax
     fed:	0f b6 08             	movzbl (%eax),%ecx
     ff0:	8b 45 08             	mov    0x8(%ebp),%eax
     ff3:	83 c0 0e             	add    $0xe,%eax
     ff6:	0f b6 00             	movzbl (%eax),%eax
     ff9:	0f b6 c0             	movzbl %al,%eax
     ffc:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
    1003:	8b 45 08             	mov    0x8(%ebp),%eax
    1006:	83 c0 12             	add    $0x12,%eax
    1009:	31 ca                	xor    %ecx,%edx
    100b:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
    100d:	8b 45 08             	mov    0x8(%ebp),%eax
    1010:	83 c0 13             	add    $0x13,%eax
    1013:	0f b6 08             	movzbl (%eax),%ecx
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	83 c0 0f             	add    $0xf,%eax
    101c:	0f b6 00             	movzbl (%eax),%eax
    101f:	0f b6 c0             	movzbl %al,%eax
    1022:	0f b6 90 60 22 00 00 	movzbl 0x2260(%eax),%edx
    1029:	8b 45 08             	mov    0x8(%ebp),%eax
    102c:	83 c0 13             	add    $0x13,%eax
    102f:	31 ca                	xor    %ecx,%edx
    1031:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
    1033:	bb 14 00 00 00       	mov    $0x14,%ebx
    1038:	e9 a9 00 00 00       	jmp    10e6 <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
    103d:	0f b6 d3             	movzbl %bl,%edx
    1040:	8b 45 08             	mov    0x8(%ebp),%eax
    1043:	01 d0                	add    %edx,%eax
    1045:	0f b6 08             	movzbl (%eax),%ecx
    1048:	0f b6 c3             	movzbl %bl,%eax
    104b:	8d 50 fc             	lea    -0x4(%eax),%edx
    104e:	8b 45 08             	mov    0x8(%ebp),%eax
    1051:	01 d0                	add    %edx,%eax
    1053:	0f b6 10             	movzbl (%eax),%edx
    1056:	0f b6 f3             	movzbl %bl,%esi
    1059:	8b 45 08             	mov    0x8(%ebp),%eax
    105c:	01 f0                	add    %esi,%eax
    105e:	31 ca                	xor    %ecx,%edx
    1060:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
    1062:	0f b6 c3             	movzbl %bl,%eax
    1065:	8d 50 01             	lea    0x1(%eax),%edx
    1068:	8b 45 08             	mov    0x8(%ebp),%eax
    106b:	01 d0                	add    %edx,%eax
    106d:	0f b6 08             	movzbl (%eax),%ecx
    1070:	0f b6 c3             	movzbl %bl,%eax
    1073:	8d 50 fd             	lea    -0x3(%eax),%edx
    1076:	8b 45 08             	mov    0x8(%ebp),%eax
    1079:	01 d0                	add    %edx,%eax
    107b:	0f b6 10             	movzbl (%eax),%edx
    107e:	0f b6 c3             	movzbl %bl,%eax
    1081:	8d 70 01             	lea    0x1(%eax),%esi
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	01 f0                	add    %esi,%eax
    1089:	31 ca                	xor    %ecx,%edx
    108b:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
    108d:	0f b6 c3             	movzbl %bl,%eax
    1090:	8d 50 02             	lea    0x2(%eax),%edx
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	01 d0                	add    %edx,%eax
    1098:	0f b6 08             	movzbl (%eax),%ecx
    109b:	0f b6 c3             	movzbl %bl,%eax
    109e:	8d 50 fe             	lea    -0x2(%eax),%edx
    10a1:	8b 45 08             	mov    0x8(%ebp),%eax
    10a4:	01 d0                	add    %edx,%eax
    10a6:	0f b6 10             	movzbl (%eax),%edx
    10a9:	0f b6 c3             	movzbl %bl,%eax
    10ac:	8d 70 02             	lea    0x2(%eax),%esi
    10af:	8b 45 08             	mov    0x8(%ebp),%eax
    10b2:	01 f0                	add    %esi,%eax
    10b4:	31 ca                	xor    %ecx,%edx
    10b6:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
    10b8:	0f b6 c3             	movzbl %bl,%eax
    10bb:	8d 50 03             	lea    0x3(%eax),%edx
    10be:	8b 45 08             	mov    0x8(%ebp),%eax
    10c1:	01 d0                	add    %edx,%eax
    10c3:	0f b6 08             	movzbl (%eax),%ecx
    10c6:	0f b6 c3             	movzbl %bl,%eax
    10c9:	8d 50 ff             	lea    -0x1(%eax),%edx
    10cc:	8b 45 08             	mov    0x8(%ebp),%eax
    10cf:	01 d0                	add    %edx,%eax
    10d1:	0f b6 10             	movzbl (%eax),%edx
    10d4:	0f b6 c3             	movzbl %bl,%eax
    10d7:	8d 70 03             	lea    0x3(%eax),%esi
    10da:	8b 45 08             	mov    0x8(%ebp),%eax
    10dd:	01 f0                	add    %esi,%eax
    10df:	31 ca                	xor    %ecx,%edx
    10e1:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
    10e3:	83 c3 04             	add    $0x4,%ebx
    10e6:	80 fb 1f             	cmp    $0x1f,%bl
    10e9:	0f 86 4e ff ff ff    	jbe    103d <aes_expandEncKey+0x201>
    }
}
    10ef:	90                   	nop
    10f0:	90                   	nop
    10f1:	83 c4 04             	add    $0x4,%esp
    10f4:	5b                   	pop    %ebx
    10f5:	5e                   	pop    %esi
    10f6:	5d                   	pop    %ebp
    10f7:	c3                   	ret    

000010f8 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
    10f8:	55                   	push   %ebp
    10f9:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
    10fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    10ff:	74 4d                	je     114e <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
    1101:	8b 45 08             	mov    0x8(%ebp),%eax
    1104:	83 c0 03             	add    $0x3,%eax
    1107:	0f b6 10             	movzbl (%eax),%edx
    110a:	83 c2 01             	add    $0x1,%edx
    110d:	88 10                	mov    %dl,(%eax)
    110f:	0f b6 00             	movzbl (%eax),%eax
    1112:	84 c0                	test   %al,%al
    1114:	75 38                	jne    114e <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
    1116:	8b 45 08             	mov    0x8(%ebp),%eax
    1119:	83 c0 02             	add    $0x2,%eax
    111c:	0f b6 10             	movzbl (%eax),%edx
    111f:	83 c2 01             	add    $0x1,%edx
    1122:	88 10                	mov    %dl,(%eax)
    1124:	0f b6 00             	movzbl (%eax),%eax
    1127:	84 c0                	test   %al,%al
    1129:	75 23                	jne    114e <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
    112b:	8b 45 08             	mov    0x8(%ebp),%eax
    112e:	83 c0 01             	add    $0x1,%eax
    1131:	0f b6 10             	movzbl (%eax),%edx
    1134:	83 c2 01             	add    $0x1,%edx
    1137:	88 10                	mov    %dl,(%eax)
    1139:	0f b6 00             	movzbl (%eax),%eax
    113c:	84 c0                	test   %al,%al
    113e:	75 0e                	jne    114e <ctr_inc_ctr+0x56>
                    val[0]++;
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	0f b6 00             	movzbl (%eax),%eax
    1146:	8d 50 01             	lea    0x1(%eax),%edx
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
    114c:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
    114e:	90                   	nop
    114f:	5d                   	pop    %ebp
    1150:	c3                   	ret    

00001151 <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
    1151:	55                   	push   %ebp
    1152:	89 e5                	mov    %esp,%ebp
    1154:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1157:	8b 45 08             	mov    0x8(%ebp),%eax
    115a:	83 c0 40             	add    $0x40,%eax
    115d:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
    1160:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1164:	74 56                	je     11bc <ctr_clock_keystream+0x6b>
    1166:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    116a:	74 50                	je     11bc <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    116c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
    1170:	eb 21                	jmp    1193 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
    1172:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
    1176:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1179:	01 d0                	add    %edx,%eax
    117b:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
    117f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1182:	01 ca                	add    %ecx,%edx
    1184:	0f b6 00             	movzbl (%eax),%eax
    1187:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1189:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
    118d:	83 c0 01             	add    $0x1,%eax
    1190:	88 45 f7             	mov    %al,-0x9(%ebp)
    1193:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
    1197:	76 d9                	jbe    1172 <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
    1199:	83 ec 08             	sub    $0x8,%esp
    119c:	ff 75 0c             	push   0xc(%ebp)
    119f:	ff 75 08             	push   0x8(%ebp)
    11a2:	e8 16 01 00 00       	call   12bd <aes256_encrypt_ecb>
    11a7:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
    11aa:	8b 45 08             	mov    0x8(%ebp),%eax
    11ad:	83 c0 4c             	add    $0x4c,%eax
    11b0:	83 ec 0c             	sub    $0xc,%esp
    11b3:	50                   	push   %eax
    11b4:	e8 3f ff ff ff       	call   10f8 <ctr_inc_ctr>
    11b9:	83 c4 10             	add    $0x10,%esp
    }
}
    11bc:	90                   	nop
    11bd:	c9                   	leave  
    11be:	c3                   	ret    

000011bf <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
    11bf:	55                   	push   %ebp
    11c0:	89 e5                	mov    %esp,%ebp
    11c2:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
    11c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
    11cb:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
    11d2:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
    11d9:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
    11e0:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
    11e7:	83 ec 08             	sub    $0x8,%esp
    11ea:	ff 75 08             	push   0x8(%ebp)
    11ed:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    11f0:	50                   	push   %eax
    11f1:	e8 2e 00 00 00       	call   1224 <aes256_init>
    11f6:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
    11f9:	83 ec 08             	sub    $0x8,%esp
    11fc:	8d 45 94             	lea    -0x6c(%ebp),%eax
    11ff:	50                   	push   %eax
    1200:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1203:	50                   	push   %eax
    1204:	e8 8d 01 00 00       	call   1396 <aes256_setCtrBlk>
    1209:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
    120c:	83 ec 04             	sub    $0x4,%esp
    120f:	ff 75 10             	push   0x10(%ebp)
    1212:	ff 75 f4             	push   -0xc(%ebp)
    1215:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1218:	50                   	push   %eax
    1219:	e8 c9 01 00 00       	call   13e7 <aes256_encrypt_ctr>
    121e:	83 c4 10             	add    $0x10,%esp
}
    1221:	90                   	nop
    1222:	c9                   	leave  
    1223:	c3                   	ret    

00001224 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
    1224:	55                   	push   %ebp
    1225:	89 e5                	mov    %esp,%ebp
    1227:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1228:	bb 00 00 00 00       	mov    $0x0,%ebx
    122d:	eb 1a                	jmp    1249 <aes256_init+0x25>
        ctx->enckey[i] = key[i];
    122f:	0f b6 d3             	movzbl %bl,%edx
    1232:	8b 45 0c             	mov    0xc(%ebp),%eax
    1235:	01 c2                	add    %eax,%edx
    1237:	0f b6 c3             	movzbl %bl,%eax
    123a:	0f b6 0a             	movzbl (%edx),%ecx
    123d:	8b 55 08             	mov    0x8(%ebp),%edx
    1240:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1244:	89 d8                	mov    %ebx,%eax
    1246:	8d 58 01             	lea    0x1(%eax),%ebx
    1249:	80 fb 1f             	cmp    $0x1f,%bl
    124c:	76 e1                	jbe    122f <aes256_init+0xb>
    }
}
    124e:	90                   	nop
    124f:	90                   	nop
    1250:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1253:	c9                   	leave  
    1254:	c3                   	ret    

00001255 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    1255:	55                   	push   %ebp
    1256:	89 e5                	mov    %esp,%ebp
    1258:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1259:	bb 00 00 00 00       	mov    $0x0,%ebx
    125e:	eb 51                	jmp    12b1 <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    1260:	0f b6 c3             	movzbl %bl,%eax
    1263:	8b 55 08             	mov    0x8(%ebp),%edx
    1266:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    126b:	0f b6 d3             	movzbl %bl,%edx
    126e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1271:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    127c:	0f b6 c3             	movzbl %bl,%eax
    127f:	83 e0 03             	and    $0x3,%eax
    1282:	89 c2                	mov    %eax,%edx
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    128c:	0f b6 c3             	movzbl %bl,%eax
    128f:	83 e0 07             	and    $0x7,%eax
    1292:	89 c2                	mov    %eax,%edx
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    129c:	0f b6 c3             	movzbl %bl,%eax
    129f:	83 e0 03             	and    $0x3,%eax
    12a2:	89 c2                	mov    %eax,%edx
    12a4:	8b 45 08             	mov    0x8(%ebp),%eax
    12a7:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    12ac:	89 d8                	mov    %ebx,%eax
    12ae:	8d 58 01             	lea    0x1(%eax),%ebx
    12b1:	80 fb 1f             	cmp    $0x1f,%bl
    12b4:	76 aa                	jbe    1260 <aes256_done+0xb>
    }
}
    12b6:	90                   	nop
    12b7:	90                   	nop
    12b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12bb:	c9                   	leave  
    12bc:	c3                   	ret    

000012bd <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    12bd:	55                   	push   %ebp
    12be:	89 e5                	mov    %esp,%ebp
    12c0:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    12c3:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    12c7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ca:	8b 55 08             	mov    0x8(%ebp),%edx
    12cd:	83 c2 20             	add    $0x20,%edx
    12d0:	50                   	push   %eax
    12d1:	52                   	push   %edx
    12d2:	ff 75 0c             	push   0xc(%ebp)
    12d5:	e8 bb f8 ff ff       	call   b95 <aes_addRoundKey_cpy>
    12da:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    12dd:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    12e1:	eb 74                	jmp    1357 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    12e3:	ff 75 0c             	push   0xc(%ebp)
    12e6:	e8 31 f8 ff ff       	call   b1c <aes_subBytes>
    12eb:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    12ee:	ff 75 0c             	push   0xc(%ebp)
    12f1:	e8 11 f9 ff ff       	call   c07 <aes_shiftRows>
    12f6:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    12f9:	ff 75 0c             	push   0xc(%ebp)
    12fc:	e8 d5 f9 ff ff       	call   cd6 <aes_mixColumns>
    1301:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    1304:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1308:	83 e0 01             	and    $0x1,%eax
    130b:	85 c0                	test   %eax,%eax
    130d:	74 14                	je     1323 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	83 c0 10             	add    $0x10,%eax
    1315:	50                   	push   %eax
    1316:	ff 75 0c             	push   0xc(%ebp)
    1319:	e8 39 f8 ff ff       	call   b57 <aes_addRoundKey>
    131e:	83 c4 08             	add    $0x8,%esp
    1321:	eb 30                	jmp    1353 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    1323:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1327:	8b 45 08             	mov    0x8(%ebp),%eax
    132a:	52                   	push   %edx
    132b:	50                   	push   %eax
    132c:	e8 0b fb ff ff       	call   e3c <aes_expandEncKey>
    1331:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    1334:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    1338:	50                   	push   %eax
    1339:	e8 ae f7 ff ff       	call   aec <rj_xtime>
    133e:	83 c4 04             	add    $0x4,%esp
    1341:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    1344:	8b 45 08             	mov    0x8(%ebp),%eax
    1347:	50                   	push   %eax
    1348:	ff 75 0c             	push   0xc(%ebp)
    134b:	e8 07 f8 ff ff       	call   b57 <aes_addRoundKey>
    1350:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    1353:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    1357:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    135b:	76 86                	jbe    12e3 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    135d:	ff 75 0c             	push   0xc(%ebp)
    1360:	e8 b7 f7 ff ff       	call   b1c <aes_subBytes>
    1365:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    1368:	ff 75 0c             	push   0xc(%ebp)
    136b:	e8 97 f8 ff ff       	call   c07 <aes_shiftRows>
    1370:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    1373:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1377:	8b 45 08             	mov    0x8(%ebp),%eax
    137a:	52                   	push   %edx
    137b:	50                   	push   %eax
    137c:	e8 bb fa ff ff       	call   e3c <aes_expandEncKey>
    1381:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    1384:	8b 45 08             	mov    0x8(%ebp),%eax
    1387:	50                   	push   %eax
    1388:	ff 75 0c             	push   0xc(%ebp)
    138b:	e8 c7 f7 ff ff       	call   b57 <aes_addRoundKey>
    1390:	83 c4 08             	add    $0x8,%esp
}
    1393:	90                   	nop
    1394:	c9                   	leave  
    1395:	c3                   	ret    

00001396 <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    1396:	55                   	push   %ebp
    1397:	89 e5                	mov    %esp,%ebp
    1399:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    139c:	8b 45 08             	mov    0x8(%ebp),%eax
    139f:	83 c0 40             	add    $0x40,%eax
    13a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    13a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a8:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    13ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    13af:	74 33                	je     13e4 <aes256_setCtrBlk+0x4e>
    13b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13b5:	74 2d                	je     13e4 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    13b7:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    13bb:	eb 21                	jmp    13de <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    13bd:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c4:	01 d0                	add    %edx,%eax
    13c6:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    13ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
    13cd:	01 ca                	add    %ecx,%edx
    13cf:	0f b6 00             	movzbl (%eax),%eax
    13d2:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    13d4:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    13d8:	83 c0 01             	add    $0x1,%eax
    13db:	88 45 ff             	mov    %al,-0x1(%ebp)
    13de:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    13e2:	76 d9                	jbe    13bd <aes256_setCtrBlk+0x27>
        }
    }
}
    13e4:	90                   	nop
    13e5:	c9                   	leave  
    13e6:	c3                   	ret    

000013e7 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    13e7:	55                   	push   %ebp
    13e8:	89 e5                	mov    %esp,%ebp
    13ea:	53                   	push   %ebx
    13eb:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    13ee:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    13f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13f9:	eb 49                	jmp    1444 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    13fb:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    13ff:	75 16                	jne    1417 <aes256_encrypt_ctr+0x30>
            j = 0;
    1401:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    140b:	50                   	push   %eax
    140c:	ff 75 08             	push   0x8(%ebp)
    140f:	e8 3d fd ff ff       	call   1151 <ctr_clock_keystream>
    1414:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    1417:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    141b:	8d 50 01             	lea    0x1(%eax),%edx
    141e:	88 55 f3             	mov    %dl,-0xd(%ebp)
    1421:	0f b6 c0             	movzbl %al,%eax
    1424:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    1429:	8b 55 0c             	mov    0xc(%ebp),%edx
    142c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142f:	01 d0                	add    %edx,%eax
    1431:	0f b6 10             	movzbl (%eax),%edx
    1434:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1437:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143a:	01 d8                	add    %ebx,%eax
    143c:	31 ca                	xor    %ecx,%edx
    143e:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    1440:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1447:	3b 45 10             	cmp    0x10(%ebp),%eax
    144a:	72 af                	jb     13fb <aes256_encrypt_ctr+0x14>
    }
}
    144c:	90                   	nop
    144d:	90                   	nop
    144e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1451:	c9                   	leave  
    1452:	c3                   	ret    

00001453 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    1453:	55                   	push   %ebp
    1454:	89 e5                	mov    %esp,%ebp
    1456:	8b 45 0c             	mov    0xc(%ebp),%eax
    1459:	83 e0 1f             	and    $0x1f,%eax
    145c:	8b 55 08             	mov    0x8(%ebp),%edx
    145f:	89 c1                	mov    %eax,%ecx
    1461:	d3 ea                	shr    %cl,%edx
    1463:	89 d0                	mov    %edx,%eax
    1465:	5d                   	pop    %ebp
    1466:	c3                   	ret    

00001467 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    1467:	55                   	push   %ebp
    1468:	89 e5                	mov    %esp,%ebp
    146a:	8b 45 0c             	mov    0xc(%ebp),%eax
    146d:	83 e0 1f             	and    $0x1f,%eax
    1470:	8b 55 08             	mov    0x8(%ebp),%edx
    1473:	89 c1                	mov    %eax,%ecx
    1475:	d3 e2                	shl    %cl,%edx
    1477:	89 d0                	mov    %edx,%eax
    1479:	5d                   	pop    %ebp
    147a:	c3                   	ret    

0000147b <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    147b:	55                   	push   %ebp
    147c:	89 e5                	mov    %esp,%ebp
    147e:	53                   	push   %ebx
    147f:	83 ec 04             	sub    $0x4,%esp
    1482:	8b 45 0c             	mov    0xc(%ebp),%eax
    1485:	88 45 f8             	mov    %al,-0x8(%ebp)
    1488:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    148c:	8b 55 08             	mov    0x8(%ebp),%edx
    148f:	89 d3                	mov    %edx,%ebx
    1491:	89 c1                	mov    %eax,%ecx
    1493:	d3 eb                	shr    %cl,%ebx
    1495:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    1499:	b8 20 00 00 00       	mov    $0x20,%eax
    149e:	29 d0                	sub    %edx,%eax
    14a0:	50                   	push   %eax
    14a1:	ff 75 08             	push   0x8(%ebp)
    14a4:	e8 be ff ff ff       	call   1467 <_shw>
    14a9:	83 c4 08             	add    $0x8,%esp
    14ac:	09 d8                	or     %ebx,%eax
    14ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14b1:	c9                   	leave  
    14b2:	c3                   	ret    

000014b3 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    14b3:	55                   	push   %ebp
    14b4:	89 e5                	mov    %esp,%ebp
    14b6:	8b 45 08             	mov    0x8(%ebp),%eax
    14b9:	23 45 0c             	and    0xc(%ebp),%eax
    14bc:	89 c2                	mov    %eax,%edx
    14be:	8b 45 08             	mov    0x8(%ebp),%eax
    14c1:	f7 d0                	not    %eax
    14c3:	23 45 10             	and    0x10(%ebp),%eax
    14c6:	31 d0                	xor    %edx,%eax
    14c8:	5d                   	pop    %ebp
    14c9:	c3                   	ret    

000014ca <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    14ca:	55                   	push   %ebp
    14cb:	89 e5                	mov    %esp,%ebp
    14cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    14d0:	33 45 10             	xor    0x10(%ebp),%eax
    14d3:	23 45 08             	and    0x8(%ebp),%eax
    14d6:	89 c2                	mov    %eax,%edx
    14d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    14db:	23 45 10             	and    0x10(%ebp),%eax
    14de:	31 d0                	xor    %edx,%eax
    14e0:	5d                   	pop    %ebp
    14e1:	c3                   	ret    

000014e2 <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    14e2:	55                   	push   %ebp
    14e3:	89 e5                	mov    %esp,%ebp
    14e5:	53                   	push   %ebx
    14e6:	6a 02                	push   $0x2
    14e8:	ff 75 08             	push   0x8(%ebp)
    14eb:	e8 8b ff ff ff       	call   147b <_r>
    14f0:	83 c4 08             	add    $0x8,%esp
    14f3:	89 c3                	mov    %eax,%ebx
    14f5:	6a 0d                	push   $0xd
    14f7:	ff 75 08             	push   0x8(%ebp)
    14fa:	e8 7c ff ff ff       	call   147b <_r>
    14ff:	83 c4 08             	add    $0x8,%esp
    1502:	31 c3                	xor    %eax,%ebx
    1504:	6a 16                	push   $0x16
    1506:	ff 75 08             	push   0x8(%ebp)
    1509:	e8 6d ff ff ff       	call   147b <_r>
    150e:	83 c4 08             	add    $0x8,%esp
    1511:	31 d8                	xor    %ebx,%eax
    1513:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1516:	c9                   	leave  
    1517:	c3                   	ret    

00001518 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    1518:	55                   	push   %ebp
    1519:	89 e5                	mov    %esp,%ebp
    151b:	53                   	push   %ebx
    151c:	6a 06                	push   $0x6
    151e:	ff 75 08             	push   0x8(%ebp)
    1521:	e8 55 ff ff ff       	call   147b <_r>
    1526:	83 c4 08             	add    $0x8,%esp
    1529:	89 c3                	mov    %eax,%ebx
    152b:	6a 0b                	push   $0xb
    152d:	ff 75 08             	push   0x8(%ebp)
    1530:	e8 46 ff ff ff       	call   147b <_r>
    1535:	83 c4 08             	add    $0x8,%esp
    1538:	31 c3                	xor    %eax,%ebx
    153a:	6a 19                	push   $0x19
    153c:	ff 75 08             	push   0x8(%ebp)
    153f:	e8 37 ff ff ff       	call   147b <_r>
    1544:	83 c4 08             	add    $0x8,%esp
    1547:	31 d8                	xor    %ebx,%eax
    1549:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    154c:	c9                   	leave  
    154d:	c3                   	ret    

0000154e <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    154e:	55                   	push   %ebp
    154f:	89 e5                	mov    %esp,%ebp
    1551:	53                   	push   %ebx
    1552:	6a 07                	push   $0x7
    1554:	ff 75 08             	push   0x8(%ebp)
    1557:	e8 1f ff ff ff       	call   147b <_r>
    155c:	83 c4 08             	add    $0x8,%esp
    155f:	89 c3                	mov    %eax,%ebx
    1561:	6a 12                	push   $0x12
    1563:	ff 75 08             	push   0x8(%ebp)
    1566:	e8 10 ff ff ff       	call   147b <_r>
    156b:	83 c4 08             	add    $0x8,%esp
    156e:	89 da                	mov    %ebx,%edx
    1570:	31 c2                	xor    %eax,%edx
    1572:	8b 45 08             	mov    0x8(%ebp),%eax
    1575:	c1 e8 03             	shr    $0x3,%eax
    1578:	31 d0                	xor    %edx,%eax
    157a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    157d:	c9                   	leave  
    157e:	c3                   	ret    

0000157f <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    157f:	55                   	push   %ebp
    1580:	89 e5                	mov    %esp,%ebp
    1582:	53                   	push   %ebx
    1583:	6a 11                	push   $0x11
    1585:	ff 75 08             	push   0x8(%ebp)
    1588:	e8 ee fe ff ff       	call   147b <_r>
    158d:	83 c4 08             	add    $0x8,%esp
    1590:	89 c3                	mov    %eax,%ebx
    1592:	6a 13                	push   $0x13
    1594:	ff 75 08             	push   0x8(%ebp)
    1597:	e8 df fe ff ff       	call   147b <_r>
    159c:	83 c4 08             	add    $0x8,%esp
    159f:	89 da                	mov    %ebx,%edx
    15a1:	31 c2                	xor    %eax,%edx
    15a3:	8b 45 08             	mov    0x8(%ebp),%eax
    15a6:	c1 e8 0a             	shr    $0xa,%eax
    15a9:	31 d0                	xor    %edx,%eax
    15ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15ae:	c9                   	leave  
    15af:	c3                   	ret    

000015b0 <_word>:

FN_ uint _word(uchar* c) {
    15b0:	55                   	push   %ebp
    15b1:	89 e5                	mov    %esp,%ebp
    15b3:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    15b4:	8b 45 08             	mov    0x8(%ebp),%eax
    15b7:	0f b6 00             	movzbl (%eax),%eax
    15ba:	0f b6 c0             	movzbl %al,%eax
    15bd:	6a 18                	push   $0x18
    15bf:	50                   	push   %eax
    15c0:	e8 a2 fe ff ff       	call   1467 <_shw>
    15c5:	83 c4 08             	add    $0x8,%esp
    15c8:	89 c3                	mov    %eax,%ebx
    15ca:	8b 45 08             	mov    0x8(%ebp),%eax
    15cd:	83 c0 01             	add    $0x1,%eax
    15d0:	0f b6 00             	movzbl (%eax),%eax
    15d3:	0f b6 c0             	movzbl %al,%eax
    15d6:	6a 10                	push   $0x10
    15d8:	50                   	push   %eax
    15d9:	e8 89 fe ff ff       	call   1467 <_shw>
    15de:	83 c4 08             	add    $0x8,%esp
    15e1:	09 c3                	or     %eax,%ebx
    15e3:	8b 45 08             	mov    0x8(%ebp),%eax
    15e6:	83 c0 02             	add    $0x2,%eax
    15e9:	0f b6 00             	movzbl (%eax),%eax
    15ec:	0f b6 c0             	movzbl %al,%eax
    15ef:	6a 08                	push   $0x8
    15f1:	50                   	push   %eax
    15f2:	e8 70 fe ff ff       	call   1467 <_shw>
    15f7:	83 c4 08             	add    $0x8,%esp
    15fa:	89 da                	mov    %ebx,%edx
    15fc:	09 c2                	or     %eax,%edx
    15fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1601:	83 c0 03             	add    $0x3,%eax
    1604:	0f b6 00             	movzbl (%eax),%eax
    1607:	0f b6 c0             	movzbl %al,%eax
    160a:	09 d0                	or     %edx,%eax
}
    160c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    160f:	c9                   	leave  
    1610:	c3                   	ret    

00001611 <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    1611:	55                   	push   %ebp
    1612:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    1614:	8b 45 08             	mov    0x8(%ebp),%eax
    1617:	8b 40 60             	mov    0x60(%eax),%eax
    161a:	8b 55 0c             	mov    0xc(%ebp),%edx
    161d:	f7 d2                	not    %edx
    161f:	39 d0                	cmp    %edx,%eax
    1621:	76 0f                	jbe    1632 <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    1623:	8b 45 08             	mov    0x8(%ebp),%eax
    1626:	8b 40 64             	mov    0x64(%eax),%eax
    1629:	8d 50 01             	lea    0x1(%eax),%edx
    162c:	8b 45 08             	mov    0x8(%ebp),%eax
    162f:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    1632:	8b 45 08             	mov    0x8(%ebp),%eax
    1635:	8b 50 60             	mov    0x60(%eax),%edx
    1638:	8b 45 0c             	mov    0xc(%ebp),%eax
    163b:	01 c2                	add    %eax,%edx
    163d:	8b 45 08             	mov    0x8(%ebp),%eax
    1640:	89 50 60             	mov    %edx,0x60(%eax)
}
    1643:	90                   	nop
    1644:	5d                   	pop    %ebp
    1645:	c3                   	ret    

00001646 <_hash>:

static void _hash(sha256_context* ctx) {
    1646:	55                   	push   %ebp
    1647:	89 e5                	mov    %esp,%ebp
    1649:	57                   	push   %edi
    164a:	56                   	push   %esi
    164b:	53                   	push   %ebx
    164c:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    164f:	8b 45 08             	mov    0x8(%ebp),%eax
    1652:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    1655:	8b 45 08             	mov    0x8(%ebp),%eax
    1658:	8b 40 44             	mov    0x44(%eax),%eax
    165b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    165e:	8b 45 08             	mov    0x8(%ebp),%eax
    1661:	8b 40 48             	mov    0x48(%eax),%eax
    1664:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    1667:	8b 45 08             	mov    0x8(%ebp),%eax
    166a:	8b 40 4c             	mov    0x4c(%eax),%eax
    166d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    1670:	8b 45 08             	mov    0x8(%ebp),%eax
    1673:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	8b 40 54             	mov    0x54(%eax),%eax
    167c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    167f:	8b 45 08             	mov    0x8(%ebp),%eax
    1682:	8b 40 58             	mov    0x58(%eax),%eax
    1685:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    1688:	8b 45 08             	mov    0x8(%ebp),%eax
    168b:	8b 40 5c             	mov    0x5c(%eax),%eax
    168e:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    1691:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1698:	e9 27 01 00 00       	jmp    17c4 <_hash+0x17e>
        if (i < 16) {
    169d:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    16a1:	77 2d                	ja     16d0 <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    16a3:	6a 02                	push   $0x2
    16a5:	ff 75 f0             	push   -0x10(%ebp)
    16a8:	e8 ba fd ff ff       	call   1467 <_shw>
    16ad:	83 c4 08             	add    $0x8,%esp
    16b0:	89 c2                	mov    %eax,%edx
    16b2:	8b 45 08             	mov    0x8(%ebp),%eax
    16b5:	01 d0                	add    %edx,%eax
    16b7:	50                   	push   %eax
    16b8:	e8 f3 fe ff ff       	call   15b0 <_word>
    16bd:	83 c4 04             	add    $0x4,%esp
    16c0:	89 c1                	mov    %eax,%ecx
    16c2:	8b 55 08             	mov    0x8(%ebp),%edx
    16c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c8:	83 c0 1c             	add    $0x1c,%eax
    16cb:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    16ce:	eb 64                	jmp    1734 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    16d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16d3:	83 e8 02             	sub    $0x2,%eax
    16d6:	8b 55 08             	mov    0x8(%ebp),%edx
    16d9:	83 c0 1c             	add    $0x1c,%eax
    16dc:	8b 04 82             	mov    (%edx,%eax,4),%eax
    16df:	50                   	push   %eax
    16e0:	e8 9a fe ff ff       	call   157f <_G1>
    16e5:	83 c4 04             	add    $0x4,%esp
    16e8:	89 c1                	mov    %eax,%ecx
    16ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16ed:	83 e8 07             	sub    $0x7,%eax
    16f0:	8b 55 08             	mov    0x8(%ebp),%edx
    16f3:	83 c0 1c             	add    $0x1c,%eax
    16f6:	8b 04 82             	mov    (%edx,%eax,4),%eax
    16f9:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    16fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16ff:	83 e8 0f             	sub    $0xf,%eax
    1702:	8b 55 08             	mov    0x8(%ebp),%edx
    1705:	83 c0 1c             	add    $0x1c,%eax
    1708:	8b 04 82             	mov    (%edx,%eax,4),%eax
    170b:	50                   	push   %eax
    170c:	e8 3d fe ff ff       	call   154e <_G0>
    1711:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1714:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    1717:	8b 45 f0             	mov    -0x10(%ebp),%eax
    171a:	83 e8 10             	sub    $0x10,%eax
    171d:	8b 55 08             	mov    0x8(%ebp),%edx
    1720:	83 c0 1c             	add    $0x1c,%eax
    1723:	8b 04 82             	mov    (%edx,%eax,4),%eax
    1726:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    1728:	8b 55 08             	mov    0x8(%ebp),%edx
    172b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    172e:	83 c0 1c             	add    $0x1c,%eax
    1731:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    1734:	57                   	push   %edi
    1735:	e8 de fd ff ff       	call   1518 <_S1>
    173a:	83 c4 04             	add    $0x4,%esp
    173d:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    1740:	01 c3                	add    %eax,%ebx
    1742:	ff 75 d4             	push   -0x2c(%ebp)
    1745:	ff 75 d8             	push   -0x28(%ebp)
    1748:	57                   	push   %edi
    1749:	e8 65 fd ff ff       	call   14b3 <_Ch>
    174e:	83 c4 0c             	add    $0xc,%esp
    1751:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    1754:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1757:	8b 04 85 60 23 00 00 	mov    0x2360(,%eax,4),%eax
    175e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1761:	8b 55 08             	mov    0x8(%ebp),%edx
    1764:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1767:	83 c0 1c             	add    $0x1c,%eax
    176a:	8b 04 82             	mov    (%edx,%eax,4),%eax
    176d:	01 c8                	add    %ecx,%eax
    176f:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    1772:	56                   	push   %esi
    1773:	e8 6a fd ff ff       	call   14e2 <_S0>
    1778:	83 c4 04             	add    $0x4,%esp
    177b:	89 c3                	mov    %eax,%ebx
    177d:	ff 75 dc             	push   -0x24(%ebp)
    1780:	ff 75 e0             	push   -0x20(%ebp)
    1783:	56                   	push   %esi
    1784:	e8 41 fd ff ff       	call   14ca <_Ma>
    1789:	83 c4 0c             	add    $0xc,%esp
    178c:	01 d8                	add    %ebx,%eax
    178e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    1791:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1794:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    1797:	8b 45 d8             	mov    -0x28(%ebp),%eax
    179a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    179d:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    17a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17a3:	8b 7d d0             	mov    -0x30(%ebp),%edi
    17a6:	01 c7                	add    %eax,%edi
        d = c;
    17a8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    17ab:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    17ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    17b1:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    17b4:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    17b7:	8b 55 e8             	mov    -0x18(%ebp),%edx
    17ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17bd:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    17c0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    17c4:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    17c8:	0f 86 cf fe ff ff    	jbe    169d <_hash+0x57>
    }

    ctx->hash[0] += a;
    17ce:	8b 45 08             	mov    0x8(%ebp),%eax
    17d1:	8b 40 40             	mov    0x40(%eax),%eax
    17d4:	8d 14 06             	lea    (%esi,%eax,1),%edx
    17d7:	8b 45 08             	mov    0x8(%ebp),%eax
    17da:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    17dd:	8b 45 08             	mov    0x8(%ebp),%eax
    17e0:	8b 40 44             	mov    0x44(%eax),%eax
    17e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    17e6:	01 c2                	add    %eax,%edx
    17e8:	8b 45 08             	mov    0x8(%ebp),%eax
    17eb:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    17ee:	8b 45 08             	mov    0x8(%ebp),%eax
    17f1:	8b 40 48             	mov    0x48(%eax),%eax
    17f4:	8b 55 dc             	mov    -0x24(%ebp),%edx
    17f7:	01 c2                	add    %eax,%edx
    17f9:	8b 45 08             	mov    0x8(%ebp),%eax
    17fc:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    17ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1802:	8b 40 4c             	mov    0x4c(%eax),%eax
    1805:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1808:	01 c2                	add    %eax,%edx
    180a:	8b 45 08             	mov    0x8(%ebp),%eax
    180d:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    1810:	8b 45 08             	mov    0x8(%ebp),%eax
    1813:	8b 40 50             	mov    0x50(%eax),%eax
    1816:	8d 14 07             	lea    (%edi,%eax,1),%edx
    1819:	8b 45 08             	mov    0x8(%ebp),%eax
    181c:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    181f:	8b 45 08             	mov    0x8(%ebp),%eax
    1822:	8b 40 54             	mov    0x54(%eax),%eax
    1825:	8b 55 d8             	mov    -0x28(%ebp),%edx
    1828:	01 c2                	add    %eax,%edx
    182a:	8b 45 08             	mov    0x8(%ebp),%eax
    182d:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    1830:	8b 45 08             	mov    0x8(%ebp),%eax
    1833:	8b 40 58             	mov    0x58(%eax),%eax
    1836:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1839:	01 c2                	add    %eax,%edx
    183b:	8b 45 08             	mov    0x8(%ebp),%eax
    183e:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    1841:	8b 45 08             	mov    0x8(%ebp),%eax
    1844:	8b 40 5c             	mov    0x5c(%eax),%eax
    1847:	8b 55 cc             	mov    -0x34(%ebp),%edx
    184a:	01 c2                	add    %eax,%edx
    184c:	8b 45 08             	mov    0x8(%ebp),%eax
    184f:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    1852:	90                   	nop
    1853:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1856:	5b                   	pop    %ebx
    1857:	5e                   	pop    %esi
    1858:	5f                   	pop    %edi
    1859:	5d                   	pop    %ebp
    185a:	c3                   	ret    

0000185b <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    185b:	55                   	push   %ebp
    185c:	89 e5                	mov    %esp,%ebp
    185e:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    1864:	83 ec 0c             	sub    $0xc,%esp
    1867:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    186d:	50                   	push   %eax
    186e:	e8 33 00 00 00       	call   18a6 <sha256_init>
    1873:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    1876:	83 ec 04             	sub    $0x4,%esp
    1879:	ff 75 0c             	push   0xc(%ebp)
    187c:	ff 75 08             	push   0x8(%ebp)
    187f:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    1885:	50                   	push   %eax
    1886:	e8 99 00 00 00       	call   1924 <sha256_hash>
    188b:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    188e:	83 ec 08             	sub    $0x8,%esp
    1891:	ff 75 10             	push   0x10(%ebp)
    1894:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    189a:	50                   	push   %eax
    189b:	e8 14 01 00 00       	call   19b4 <sha256_done>
    18a0:	83 c4 10             	add    $0x10,%esp
}
    18a3:	90                   	nop
    18a4:	c9                   	leave  
    18a5:	c3                   	ret    

000018a6 <sha256_init>:

void sha256_init(sha256_context* ctx) {
    18a6:	55                   	push   %ebp
    18a7:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    18a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    18ad:	74 72                	je     1921 <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    18af:	8b 45 08             	mov    0x8(%ebp),%eax
    18b2:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    18b9:	8b 45 08             	mov    0x8(%ebp),%eax
    18bc:	8b 50 68             	mov    0x68(%eax),%edx
    18bf:	8b 45 08             	mov    0x8(%ebp),%eax
    18c2:	89 50 64             	mov    %edx,0x64(%eax)
    18c5:	8b 45 08             	mov    0x8(%ebp),%eax
    18c8:	8b 50 64             	mov    0x64(%eax),%edx
    18cb:	8b 45 08             	mov    0x8(%ebp),%eax
    18ce:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    18d1:	8b 45 08             	mov    0x8(%ebp),%eax
    18d4:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    18db:	8b 45 08             	mov    0x8(%ebp),%eax
    18de:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    18e5:	8b 45 08             	mov    0x8(%ebp),%eax
    18e8:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    18ef:	8b 45 08             	mov    0x8(%ebp),%eax
    18f2:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
    18fc:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    1903:	8b 45 08             	mov    0x8(%ebp),%eax
    1906:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    190d:	8b 45 08             	mov    0x8(%ebp),%eax
    1910:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    1917:	8b 45 08             	mov    0x8(%ebp),%eax
    191a:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    1921:	90                   	nop
    1922:	5d                   	pop    %ebp
    1923:	c3                   	ret    

00001924 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    1924:	55                   	push   %ebp
    1925:	89 e5                	mov    %esp,%ebp
    1927:	53                   	push   %ebx
    1928:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    192b:	8b 45 0c             	mov    0xc(%ebp),%eax
    192e:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    1931:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1935:	74 77                	je     19ae <sha256_hash+0x8a>
    1937:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    193b:	74 71                	je     19ae <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    193d:	8b 45 08             	mov    0x8(%ebp),%eax
    1940:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    1943:	83 f8 3f             	cmp    $0x3f,%eax
    1946:	77 66                	ja     19ae <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    1948:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    194f:	eb 55                	jmp    19a6 <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    1951:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1954:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1957:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    195a:	8b 45 08             	mov    0x8(%ebp),%eax
    195d:	8b 40 68             	mov    0x68(%eax),%eax
    1960:	8d 48 01             	lea    0x1(%eax),%ecx
    1963:	8b 55 08             	mov    0x8(%ebp),%edx
    1966:	89 4a 68             	mov    %ecx,0x68(%edx)
    1969:	0f b6 0b             	movzbl (%ebx),%ecx
    196c:	8b 55 08             	mov    0x8(%ebp),%edx
    196f:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    1972:	8b 45 08             	mov    0x8(%ebp),%eax
    1975:	8b 40 68             	mov    0x68(%eax),%eax
    1978:	83 f8 40             	cmp    $0x40,%eax
    197b:	75 25                	jne    19a2 <sha256_hash+0x7e>
                _hash(ctx);
    197d:	ff 75 08             	push   0x8(%ebp)
    1980:	e8 c1 fc ff ff       	call   1646 <_hash>
    1985:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    1988:	68 00 02 00 00       	push   $0x200
    198d:	ff 75 08             	push   0x8(%ebp)
    1990:	e8 7c fc ff ff       	call   1611 <_addbits>
    1995:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    1998:	8b 45 08             	mov    0x8(%ebp),%eax
    199b:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    19a2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    19a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a9:	3b 45 10             	cmp    0x10(%ebp),%eax
    19ac:	72 a3                	jb     1951 <sha256_hash+0x2d>
            }
        }
    }
}
    19ae:	90                   	nop
    19af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    19b2:	c9                   	leave  
    19b3:	c3                   	ret    

000019b4 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    19b4:	55                   	push   %ebp
    19b5:	89 e5                	mov    %esp,%ebp
    19b7:	57                   	push   %edi
    19b8:	56                   	push   %esi
    19b9:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    19ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    19be:	0f 84 27 02 00 00    	je     1beb <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    19c4:	8b 45 08             	mov    0x8(%ebp),%eax
    19c7:	8b 40 68             	mov    0x68(%eax),%eax
    19ca:	83 e0 3f             	and    $0x3f,%eax
    19cd:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    19cf:	8b 45 08             	mov    0x8(%ebp),%eax
    19d2:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    19d6:	8d 73 01             	lea    0x1(%ebx),%esi
    19d9:	eb 0a                	jmp    19e5 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    19db:	8b 45 08             	mov    0x8(%ebp),%eax
    19de:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    19e2:	83 c6 01             	add    $0x1,%esi
    19e5:	83 fe 3f             	cmp    $0x3f,%esi
    19e8:	76 f1                	jbe    19db <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    19ea:	8b 45 08             	mov    0x8(%ebp),%eax
    19ed:	8b 40 68             	mov    0x68(%eax),%eax
    19f0:	83 f8 37             	cmp    $0x37,%eax
    19f3:	76 21                	jbe    1a16 <sha256_done+0x62>
            _hash(ctx);
    19f5:	ff 75 08             	push   0x8(%ebp)
    19f8:	e8 49 fc ff ff       	call   1646 <_hash>
    19fd:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    1a00:	bb 00 00 00 00       	mov    $0x0,%ebx
    1a05:	eb 0a                	jmp    1a11 <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    1a0e:	83 c3 01             	add    $0x1,%ebx
    1a11:	83 fb 3f             	cmp    $0x3f,%ebx
    1a14:	76 f1                	jbe    1a07 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    1a16:	8b 45 08             	mov    0x8(%ebp),%eax
    1a19:	8b 40 68             	mov    0x68(%eax),%eax
    1a1c:	c1 e0 03             	shl    $0x3,%eax
    1a1f:	50                   	push   %eax
    1a20:	ff 75 08             	push   0x8(%ebp)
    1a23:	e8 e9 fb ff ff       	call   1611 <_addbits>
    1a28:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    1a2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2e:	8b 40 60             	mov    0x60(%eax),%eax
    1a31:	6a 00                	push   $0x0
    1a33:	50                   	push   %eax
    1a34:	e8 1a fa ff ff       	call   1453 <_shb>
    1a39:	83 c4 08             	add    $0x8,%esp
    1a3c:	8b 55 08             	mov    0x8(%ebp),%edx
    1a3f:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    1a42:	8b 45 08             	mov    0x8(%ebp),%eax
    1a45:	8b 40 60             	mov    0x60(%eax),%eax
    1a48:	6a 08                	push   $0x8
    1a4a:	50                   	push   %eax
    1a4b:	e8 03 fa ff ff       	call   1453 <_shb>
    1a50:	83 c4 08             	add    $0x8,%esp
    1a53:	8b 55 08             	mov    0x8(%ebp),%edx
    1a56:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    1a59:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5c:	8b 40 60             	mov    0x60(%eax),%eax
    1a5f:	6a 10                	push   $0x10
    1a61:	50                   	push   %eax
    1a62:	e8 ec f9 ff ff       	call   1453 <_shb>
    1a67:	83 c4 08             	add    $0x8,%esp
    1a6a:	8b 55 08             	mov    0x8(%ebp),%edx
    1a6d:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    1a70:	8b 45 08             	mov    0x8(%ebp),%eax
    1a73:	8b 40 60             	mov    0x60(%eax),%eax
    1a76:	6a 18                	push   $0x18
    1a78:	50                   	push   %eax
    1a79:	e8 d5 f9 ff ff       	call   1453 <_shb>
    1a7e:	83 c4 08             	add    $0x8,%esp
    1a81:	8b 55 08             	mov    0x8(%ebp),%edx
    1a84:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	8b 40 64             	mov    0x64(%eax),%eax
    1a8d:	6a 00                	push   $0x0
    1a8f:	50                   	push   %eax
    1a90:	e8 be f9 ff ff       	call   1453 <_shb>
    1a95:	83 c4 08             	add    $0x8,%esp
    1a98:	8b 55 08             	mov    0x8(%ebp),%edx
    1a9b:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    1a9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa1:	8b 40 64             	mov    0x64(%eax),%eax
    1aa4:	6a 08                	push   $0x8
    1aa6:	50                   	push   %eax
    1aa7:	e8 a7 f9 ff ff       	call   1453 <_shb>
    1aac:	83 c4 08             	add    $0x8,%esp
    1aaf:	8b 55 08             	mov    0x8(%ebp),%edx
    1ab2:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    1ab5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab8:	8b 40 64             	mov    0x64(%eax),%eax
    1abb:	6a 10                	push   $0x10
    1abd:	50                   	push   %eax
    1abe:	e8 90 f9 ff ff       	call   1453 <_shb>
    1ac3:	83 c4 08             	add    $0x8,%esp
    1ac6:	8b 55 08             	mov    0x8(%ebp),%edx
    1ac9:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    1acc:	8b 45 08             	mov    0x8(%ebp),%eax
    1acf:	8b 40 64             	mov    0x64(%eax),%eax
    1ad2:	6a 18                	push   $0x18
    1ad4:	50                   	push   %eax
    1ad5:	e8 79 f9 ff ff       	call   1453 <_shb>
    1ada:	83 c4 08             	add    $0x8,%esp
    1add:	8b 55 08             	mov    0x8(%ebp),%edx
    1ae0:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    1ae3:	ff 75 08             	push   0x8(%ebp)
    1ae6:	e8 5b fb ff ff       	call   1646 <_hash>
    1aeb:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    1aee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1af2:	0f 84 f3 00 00 00    	je     1beb <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1af8:	be 00 00 00 00       	mov    $0x0,%esi
    1afd:	bb 18 00 00 00       	mov    $0x18,%ebx
    1b02:	e9 db 00 00 00       	jmp    1be2 <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    1b07:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0a:	8b 40 40             	mov    0x40(%eax),%eax
    1b0d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b10:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    1b13:	53                   	push   %ebx
    1b14:	50                   	push   %eax
    1b15:	e8 39 f9 ff ff       	call   1453 <_shb>
    1b1a:	83 c4 08             	add    $0x8,%esp
    1b1d:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    1b1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b22:	8b 40 44             	mov    0x44(%eax),%eax
    1b25:	8d 4e 04             	lea    0x4(%esi),%ecx
    1b28:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b2b:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1b2e:	53                   	push   %ebx
    1b2f:	50                   	push   %eax
    1b30:	e8 1e f9 ff ff       	call   1453 <_shb>
    1b35:	83 c4 08             	add    $0x8,%esp
    1b38:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    1b3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3d:	8b 40 48             	mov    0x48(%eax),%eax
    1b40:	8d 4e 08             	lea    0x8(%esi),%ecx
    1b43:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b46:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1b49:	53                   	push   %ebx
    1b4a:	50                   	push   %eax
    1b4b:	e8 03 f9 ff ff       	call   1453 <_shb>
    1b50:	83 c4 08             	add    $0x8,%esp
    1b53:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    1b55:	8b 45 08             	mov    0x8(%ebp),%eax
    1b58:	8b 40 4c             	mov    0x4c(%eax),%eax
    1b5b:	8d 4e 0c             	lea    0xc(%esi),%ecx
    1b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b61:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1b64:	53                   	push   %ebx
    1b65:	50                   	push   %eax
    1b66:	e8 e8 f8 ff ff       	call   1453 <_shb>
    1b6b:	83 c4 08             	add    $0x8,%esp
    1b6e:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    1b70:	8b 45 08             	mov    0x8(%ebp),%eax
    1b73:	8b 40 50             	mov    0x50(%eax),%eax
    1b76:	8d 4e 10             	lea    0x10(%esi),%ecx
    1b79:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b7c:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1b7f:	53                   	push   %ebx
    1b80:	50                   	push   %eax
    1b81:	e8 cd f8 ff ff       	call   1453 <_shb>
    1b86:	83 c4 08             	add    $0x8,%esp
    1b89:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    1b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8e:	8b 40 54             	mov    0x54(%eax),%eax
    1b91:	8d 4e 14             	lea    0x14(%esi),%ecx
    1b94:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b97:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1b9a:	53                   	push   %ebx
    1b9b:	50                   	push   %eax
    1b9c:	e8 b2 f8 ff ff       	call   1453 <_shb>
    1ba1:	83 c4 08             	add    $0x8,%esp
    1ba4:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    1ba6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba9:	8b 40 58             	mov    0x58(%eax),%eax
    1bac:	8d 4e 18             	lea    0x18(%esi),%ecx
    1baf:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bb2:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1bb5:	53                   	push   %ebx
    1bb6:	50                   	push   %eax
    1bb7:	e8 97 f8 ff ff       	call   1453 <_shb>
    1bbc:	83 c4 08             	add    $0x8,%esp
    1bbf:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    1bc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc4:	8b 40 5c             	mov    0x5c(%eax),%eax
    1bc7:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    1bca:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bcd:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    1bd0:	53                   	push   %ebx
    1bd1:	50                   	push   %eax
    1bd2:	e8 7c f8 ff ff       	call   1453 <_shb>
    1bd7:	83 c4 08             	add    $0x8,%esp
    1bda:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    1bdc:	83 c6 01             	add    $0x1,%esi
    1bdf:	83 eb 08             	sub    $0x8,%ebx
    1be2:	83 fe 03             	cmp    $0x3,%esi
    1be5:	0f 86 1c ff ff ff    	jbe    1b07 <sha256_done+0x153>
            }
        }
    }
}
    1beb:	90                   	nop
    1bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bef:	5b                   	pop    %ebx
    1bf0:	5e                   	pop    %esi
    1bf1:	5f                   	pop    %edi
    1bf2:	5d                   	pop    %ebp
    1bf3:	c3                   	ret    

00001bf4 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    1bf4:	55                   	push   %ebp
    1bf5:	89 e5                	mov    %esp,%ebp
    1bf7:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1bfa:	a1 94 2c 00 00       	mov    0x2c94,%eax
    1bff:	83 ec 08             	sub    $0x8,%esp
    1c02:	68 04 02 00 00       	push   $0x204
    1c07:	50                   	push   %eax
    1c08:	e8 7d e7 ff ff       	call   38a <open>
    1c0d:	83 c4 10             	add    $0x10,%esp
    1c10:	a3 c0 2c 00 00       	mov    %eax,0x2cc0

    int i = 0;
    1c15:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1c1c:	eb 6f                	jmp    1c8d <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    1c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c21:	83 e0 01             	and    $0x1,%eax
    1c24:	85 c0                	test   %eax,%eax
    1c26:	75 27                	jne    1c4f <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    1c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2b:	89 c2                	mov    %eax,%edx
    1c2d:	c1 ea 1f             	shr    $0x1f,%edx
    1c30:	01 d0                	add    %edx,%eax
    1c32:	d1 f8                	sar    %eax
    1c34:	6b c0 64             	imul   $0x64,%eax,%eax
    1c37:	8d 90 e0 2c 00 00    	lea    0x2ce0(%eax),%edx
    1c3d:	83 ec 08             	sub    $0x8,%esp
    1c40:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1c43:	50                   	push   %eax
    1c44:	52                   	push   %edx
    1c45:	e8 ee e7 ff ff       	call   438 <strcpy>
    1c4a:	83 c4 10             	add    $0x10,%esp
    1c4d:	eb 27                	jmp    1c76 <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    1c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c52:	89 c2                	mov    %eax,%edx
    1c54:	c1 ea 1f             	shr    $0x1f,%edx
    1c57:	01 d0                	add    %edx,%eax
    1c59:	d1 f8                	sar    %eax
    1c5b:	6b c0 64             	imul   $0x64,%eax,%eax
    1c5e:	8d 90 20 2c 64 00    	lea    0x642c20(%eax),%edx
    1c64:	83 ec 04             	sub    $0x4,%esp
    1c67:	6a 64                	push   $0x64
    1c69:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1c6c:	50                   	push   %eax
    1c6d:	52                   	push   %edx
    1c6e:	e8 b1 e9 ff ff       	call   624 <memmove>
    1c73:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    1c76:	83 ec 04             	sub    $0x4,%esp
    1c79:	6a 64                	push   $0x64
    1c7b:	6a 00                	push   $0x0
    1c7d:	8d 45 8c             	lea    -0x74(%ebp),%eax
    1c80:	50                   	push   %eax
    1c81:	e8 48 e8 ff ff       	call   4ce <memset>
    1c86:	83 c4 10             	add    $0x10,%esp
        i++;
    1c89:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    1c8d:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1c92:	83 ec 04             	sub    $0x4,%esp
    1c95:	6a 64                	push   $0x64
    1c97:	8d 55 8c             	lea    -0x74(%ebp),%edx
    1c9a:	52                   	push   %edx
    1c9b:	50                   	push   %eax
    1c9c:	e8 c1 e6 ff ff       	call   362 <read>
    1ca1:	83 c4 10             	add    $0x10,%esp
    1ca4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ca7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1cab:	0f 8f 6d ff ff ff    	jg     1c1e <read_info+0x2a>
    }

    num_users = i / 2;
    1cb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb4:	89 c2                	mov    %eax,%edx
    1cb6:	c1 ea 1f             	shr    $0x1f,%edx
    1cb9:	01 d0                	add    %edx,%eax
    1cbb:	d1 f8                	sar    %eax
    1cbd:	a3 c4 2c 00 00       	mov    %eax,0x2cc4

    if (n < 0) {
    1cc2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1cc6:	79 17                	jns    1cdf <read_info+0xeb>
        printf(1, "cat: read error\n");
    1cc8:	83 ec 08             	sub    $0x8,%esp
    1ccb:	68 6b 24 00 00       	push   $0x246b
    1cd0:	6a 01                	push   $0x1
    1cd2:	e8 83 ec ff ff       	call   95a <printf>
    1cd7:	83 c4 10             	add    $0x10,%esp
        exit();
    1cda:	e8 6b e6 ff ff       	call   34a <exit>
    }
}
    1cdf:	90                   	nop
    1ce0:	c9                   	leave  
    1ce1:	c3                   	ret    

00001ce2 <writeback>:

void writeback() {
    1ce2:	55                   	push   %ebp
    1ce3:	89 e5                	mov    %esp,%ebp
    1ce5:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    1ce8:	a1 94 2c 00 00       	mov    0x2c94,%eax
    1ced:	83 ec 08             	sub    $0x8,%esp
    1cf0:	68 04 02 00 00       	push   $0x204
    1cf5:	50                   	push   %eax
    1cf6:	e8 8f e6 ff ff       	call   38a <open>
    1cfb:	83 c4 10             	add    $0x10,%esp
    1cfe:	a3 c0 2c 00 00       	mov    %eax,0x2cc0
    for (int i = 0; i < num_users; i++) {
    1d03:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d0a:	eb 44                	jmp    1d50 <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    1d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d0f:	6b c0 64             	imul   $0x64,%eax,%eax
    1d12:	8d 90 e0 2c 00 00    	lea    0x2ce0(%eax),%edx
    1d18:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1d1d:	83 ec 04             	sub    $0x4,%esp
    1d20:	6a 64                	push   $0x64
    1d22:	52                   	push   %edx
    1d23:	50                   	push   %eax
    1d24:	e8 41 e6 ff ff       	call   36a <write>
    1d29:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    1d2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d2f:	6b c0 64             	imul   $0x64,%eax,%eax
    1d32:	8d 90 20 2c 64 00    	lea    0x642c20(%eax),%edx
    1d38:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1d3d:	83 ec 04             	sub    $0x4,%esp
    1d40:	6a 64                	push   $0x64
    1d42:	52                   	push   %edx
    1d43:	50                   	push   %eax
    1d44:	e8 21 e6 ff ff       	call   36a <write>
    1d49:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    1d4c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d50:	a1 c4 2c 00 00       	mov    0x2cc4,%eax
    1d55:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1d58:	7c b2                	jl     1d0c <writeback+0x2a>
    }
    close(fd);
    1d5a:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1d5f:	83 ec 0c             	sub    $0xc,%esp
    1d62:	50                   	push   %eax
    1d63:	e8 0a e6 ff ff       	call   372 <close>
    1d68:	83 c4 10             	add    $0x10,%esp
}
    1d6b:	90                   	nop
    1d6c:	c9                   	leave  
    1d6d:	c3                   	ret    

00001d6e <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    1d6e:	55                   	push   %ebp
    1d6f:	89 e5                	mov    %esp,%ebp
    1d71:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    1d77:	83 ec 08             	sub    $0x8,%esp
    1d7a:	68 7c 24 00 00       	push   $0x247c
    1d7f:	68 e0 2c 00 00       	push   $0x2ce0
    1d84:	e8 af e6 ff ff       	call   438 <strcpy>
    1d89:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    1d8c:	c7 45 f4 81 24 00 00 	movl   $0x2481,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    1d93:	83 ec 08             	sub    $0x8,%esp
    1d96:	ff 75 f4             	push   -0xc(%ebp)
    1d99:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1d9f:	50                   	push   %eax
    1da0:	e8 93 e6 ff ff       	call   438 <strcpy>
    1da5:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    1da8:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    1daf:	83 ec 0c             	sub    $0xc,%esp
    1db2:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1db8:	50                   	push   %eax
    1db9:	e8 e8 fa ff ff       	call   18a6 <sha256_init>
    1dbe:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    1dc1:	83 ec 0c             	sub    $0xc,%esp
    1dc4:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1dca:	50                   	push   %eax
    1dcb:	e8 d7 e6 ff ff       	call   4a7 <strlen>
    1dd0:	83 c4 10             	add    $0x10,%esp
    1dd3:	83 ec 04             	sub    $0x4,%esp
    1dd6:	50                   	push   %eax
    1dd7:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    1ddd:	50                   	push   %eax
    1dde:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1de4:	50                   	push   %eax
    1de5:	e8 3a fb ff ff       	call   1924 <sha256_hash>
    1dea:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    1ded:	83 ec 08             	sub    $0x8,%esp
    1df0:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1df6:	50                   	push   %eax
    1df7:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    1dfd:	50                   	push   %eax
    1dfe:	e8 b1 fb ff ff       	call   19b4 <sha256_done>
    1e03:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    1e06:	83 ec 04             	sub    $0x4,%esp
    1e09:	6a 64                	push   $0x64
    1e0b:	6a 00                	push   $0x0
    1e0d:	68 20 2c 64 00       	push   $0x642c20
    1e12:	e8 b7 e6 ff ff       	call   4ce <memset>
    1e17:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    1e1a:	83 ec 04             	sub    $0x4,%esp
    1e1d:	6a 20                	push   $0x20
    1e1f:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    1e25:	50                   	push   %eax
    1e26:	68 20 2c 64 00       	push   $0x642c20
    1e2b:	e8 f4 e7 ff ff       	call   624 <memmove>
    1e30:	83 c4 10             	add    $0x10,%esp

    read_info();
    1e33:	e8 bc fd ff ff       	call   1bf4 <read_info>
    fd = open(SECRETS, O_RDWR);
    1e38:	a1 94 2c 00 00       	mov    0x2c94,%eax
    1e3d:	83 ec 08             	sub    $0x8,%esp
    1e40:	6a 04                	push   $0x4
    1e42:	50                   	push   %eax
    1e43:	e8 42 e5 ff ff       	call   38a <open>
    1e48:	83 c4 10             	add    $0x10,%esp
    1e4b:	a3 c0 2c 00 00       	mov    %eax,0x2cc0
    write(fd, usernames[0], MAX_INPUT_SIZE);
    1e50:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1e55:	83 ec 04             	sub    $0x4,%esp
    1e58:	6a 64                	push   $0x64
    1e5a:	68 e0 2c 00 00       	push   $0x2ce0
    1e5f:	50                   	push   %eax
    1e60:	e8 05 e5 ff ff       	call   36a <write>
    1e65:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    1e68:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1e6d:	83 ec 04             	sub    $0x4,%esp
    1e70:	6a 64                	push   $0x64
    1e72:	68 20 2c 64 00       	push   $0x642c20
    1e77:	50                   	push   %eax
    1e78:	e8 ed e4 ff ff       	call   36a <write>
    1e7d:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1e80:	a1 c0 2c 00 00       	mov    0x2cc0,%eax
    1e85:	83 ec 0c             	sub    $0xc,%esp
    1e88:	50                   	push   %eax
    1e89:	e8 e4 e4 ff ff       	call   372 <close>
    1e8e:	83 c4 10             	add    $0x10,%esp
}
    1e91:	90                   	nop
    1e92:	c9                   	leave  
    1e93:	c3                   	ret    

00001e94 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    1e94:	55                   	push   %ebp
    1e95:	89 e5                	mov    %esp,%ebp
    1e97:	83 ec 18             	sub    $0x18,%esp
    read_info();
    1e9a:	e8 55 fd ff ff       	call   1bf4 <read_info>

    for (int i = 0; i < num_users; i++) {
    1e9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ea6:	eb 29                	jmp    1ed1 <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    1ea8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eab:	6b c0 64             	imul   $0x64,%eax,%eax
    1eae:	05 e0 2c 00 00       	add    $0x2ce0,%eax
    1eb3:	83 ec 08             	sub    $0x8,%esp
    1eb6:	50                   	push   %eax
    1eb7:	ff 75 08             	push   0x8(%ebp)
    1eba:	e8 a9 e5 ff ff       	call   468 <strcmp>
    1ebf:	83 c4 10             	add    $0x10,%esp
    1ec2:	85 c0                	test   %eax,%eax
    1ec4:	75 07                	jne    1ecd <does_user_exist+0x39>
            return 0;
    1ec6:	b8 00 00 00 00       	mov    $0x0,%eax
    1ecb:	eb 13                	jmp    1ee0 <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    1ecd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ed1:	a1 c4 2c 00 00       	mov    0x2cc4,%eax
    1ed6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1ed9:	7c cd                	jl     1ea8 <does_user_exist+0x14>
        }
    }
    return -1;
    1edb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1ee0:	c9                   	leave  
    1ee1:	c3                   	ret    

00001ee2 <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    1ee2:	55                   	push   %ebp
    1ee3:	89 e5                	mov    %esp,%ebp
    1ee5:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    1eeb:	e8 04 fd ff ff       	call   1bf4 <read_info>

    int open = -1;
    1ef0:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    1ef7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1efe:	eb 46                	jmp    1f46 <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    1f00:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f03:	6b c0 64             	imul   $0x64,%eax,%eax
    1f06:	05 e0 2c 00 00       	add    $0x2ce0,%eax
    1f0b:	83 ec 08             	sub    $0x8,%esp
    1f0e:	50                   	push   %eax
    1f0f:	ff 75 08             	push   0x8(%ebp)
    1f12:	e8 51 e5 ff ff       	call   468 <strcmp>
    1f17:	83 c4 10             	add    $0x10,%esp
    1f1a:	85 c0                	test   %eax,%eax
    1f1c:	75 0a                	jne    1f28 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    1f1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1f23:	e9 18 01 00 00       	jmp    2040 <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    1f28:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f2b:	6b c0 64             	imul   $0x64,%eax,%eax
    1f2e:	05 e0 2c 00 00       	add    $0x2ce0,%eax
    1f33:	0f b6 00             	movzbl (%eax),%eax
    1f36:	84 c0                	test   %al,%al
    1f38:	75 08                	jne    1f42 <create_user+0x60>
            open = i;
    1f3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    1f40:	eb 0d                	jmp    1f4f <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    1f42:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f46:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    1f4d:	7e b1                	jle    1f00 <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    1f4f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1f53:	0f 84 e2 00 00 00    	je     203b <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    1f59:	83 ec 08             	sub    $0x8,%esp
    1f5c:	ff 75 0c             	push   0xc(%ebp)
    1f5f:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1f65:	50                   	push   %eax
    1f66:	e8 cd e4 ff ff       	call   438 <strcpy>
    1f6b:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    1f6e:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    1f75:	83 ec 0c             	sub    $0xc,%esp
    1f78:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1f7e:	50                   	push   %eax
    1f7f:	e8 22 f9 ff ff       	call   18a6 <sha256_init>
    1f84:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    1f87:	83 ec 0c             	sub    $0xc,%esp
    1f8a:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1f90:	50                   	push   %eax
    1f91:	e8 11 e5 ff ff       	call   4a7 <strlen>
    1f96:	83 c4 10             	add    $0x10,%esp
    1f99:	83 ec 04             	sub    $0x4,%esp
    1f9c:	50                   	push   %eax
    1f9d:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    1fa3:	50                   	push   %eax
    1fa4:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1faa:	50                   	push   %eax
    1fab:	e8 74 f9 ff ff       	call   1924 <sha256_hash>
    1fb0:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    1fb3:	83 ec 08             	sub    $0x8,%esp
    1fb6:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    1fbc:	50                   	push   %eax
    1fbd:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    1fc3:	50                   	push   %eax
    1fc4:	e8 eb f9 ff ff       	call   19b4 <sha256_done>
    1fc9:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    1fcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fcf:	6b c0 64             	imul   $0x64,%eax,%eax
    1fd2:	05 e0 2c 00 00       	add    $0x2ce0,%eax
    1fd7:	83 ec 08             	sub    $0x8,%esp
    1fda:	ff 75 08             	push   0x8(%ebp)
    1fdd:	50                   	push   %eax
    1fde:	e8 55 e4 ff ff       	call   438 <strcpy>
    1fe3:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    1fe6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fe9:	6b c0 64             	imul   $0x64,%eax,%eax
    1fec:	05 20 2c 64 00       	add    $0x642c20,%eax
    1ff1:	83 ec 04             	sub    $0x4,%esp
    1ff4:	6a 64                	push   $0x64
    1ff6:	6a 00                	push   $0x0
    1ff8:	50                   	push   %eax
    1ff9:	e8 d0 e4 ff ff       	call   4ce <memset>
    1ffe:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    2001:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2004:	6b c0 64             	imul   $0x64,%eax,%eax
    2007:	8d 90 20 2c 64 00    	lea    0x642c20(%eax),%edx
    200d:	83 ec 04             	sub    $0x4,%esp
    2010:	6a 20                	push   $0x20
    2012:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    2018:	50                   	push   %eax
    2019:	52                   	push   %edx
    201a:	e8 05 e6 ff ff       	call   624 <memmove>
    201f:	83 c4 10             	add    $0x10,%esp

        num_users++;
    2022:	a1 c4 2c 00 00       	mov    0x2cc4,%eax
    2027:	83 c0 01             	add    $0x1,%eax
    202a:	a3 c4 2c 00 00       	mov    %eax,0x2cc4
        writeback();
    202f:	e8 ae fc ff ff       	call   1ce2 <writeback>
        return 0;
    2034:	b8 00 00 00 00       	mov    $0x0,%eax
    2039:	eb 05                	jmp    2040 <create_user+0x15e>
    }

    return -1;
    203b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    2040:	c9                   	leave  
    2041:	c3                   	ret    

00002042 <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    2042:	55                   	push   %ebp
    2043:	89 e5                	mov    %esp,%ebp
    2045:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    204b:	e8 a4 fb ff ff       	call   1bf4 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    2050:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2057:	e9 7b 01 00 00       	jmp    21d7 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    205c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205f:	6b c0 64             	imul   $0x64,%eax,%eax
    2062:	05 e0 2c 00 00       	add    $0x2ce0,%eax
    2067:	83 ec 08             	sub    $0x8,%esp
    206a:	50                   	push   %eax
    206b:	ff 75 08             	push   0x8(%ebp)
    206e:	e8 f5 e3 ff ff       	call   468 <strcmp>
    2073:	83 c4 10             	add    $0x10,%esp
    2076:	85 c0                	test   %eax,%eax
    2078:	0f 85 55 01 00 00    	jne    21d3 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    207e:	83 ec 08             	sub    $0x8,%esp
    2081:	ff 75 0c             	push   0xc(%ebp)
    2084:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    208a:	50                   	push   %eax
    208b:	e8 a8 e3 ff ff       	call   438 <strcpy>
    2090:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    2093:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    209a:	83 ec 0c             	sub    $0xc,%esp
    209d:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    20a3:	50                   	push   %eax
    20a4:	e8 fd f7 ff ff       	call   18a6 <sha256_init>
    20a9:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    20ac:	83 ec 0c             	sub    $0xc,%esp
    20af:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    20b5:	50                   	push   %eax
    20b6:	e8 ec e3 ff ff       	call   4a7 <strlen>
    20bb:	83 c4 10             	add    $0x10,%esp
    20be:	83 ec 04             	sub    $0x4,%esp
    20c1:	50                   	push   %eax
    20c2:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    20c8:	50                   	push   %eax
    20c9:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    20cf:	50                   	push   %eax
    20d0:	e8 4f f8 ff ff       	call   1924 <sha256_hash>
    20d5:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    20d8:	83 ec 08             	sub    $0x8,%esp
    20db:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    20e1:	50                   	push   %eax
    20e2:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    20e8:	50                   	push   %eax
    20e9:	e8 c6 f8 ff ff       	call   19b4 <sha256_done>
    20ee:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    20f1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    20f8:	eb 34                	jmp    212e <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    20fa:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    2100:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2103:	01 d0                	add    %edx,%eax
    2105:	0f b6 00             	movzbl (%eax),%eax
    2108:	8b 55 f4             	mov    -0xc(%ebp),%edx
    210b:	6b ca 64             	imul   $0x64,%edx,%ecx
    210e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    2111:	01 ca                	add    %ecx,%edx
    2113:	81 c2 20 2c 64 00    	add    $0x642c20,%edx
    2119:	0f b6 12             	movzbl (%edx),%edx
    211c:	38 d0                	cmp    %dl,%al
    211e:	74 0a                	je     212a <login_user+0xe8>
                    return -1;
    2120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2125:	e9 bf 00 00 00       	jmp    21e9 <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    212a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    212e:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    2132:	7e c6                	jle    20fa <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    2134:	83 ec 08             	sub    $0x8,%esp
    2137:	68 87 24 00 00       	push   $0x2487
    213c:	6a 01                	push   $0x1
    213e:	e8 17 e8 ff ff       	call   95a <printf>
    2143:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    2146:	e8 f7 e1 ff ff       	call   342 <fork>
    214b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    214e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2152:	79 17                	jns    216b <login_user+0x129>
                printf(1, "init: fork failed\n");
    2154:	83 ec 08             	sub    $0x8,%esp
    2157:	68 9a 24 00 00       	push   $0x249a
    215c:	6a 01                	push   $0x1
    215e:	e8 f7 e7 ff ff       	call   95a <printf>
    2163:	83 c4 10             	add    $0x10,%esp
                exit();
    2166:	e8 df e1 ff ff       	call   34a <exit>
            }
            if (pid == 0) {
    216b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    216f:	75 4c                	jne    21bd <login_user+0x17b>
                setuid(i);
    2171:	83 ec 0c             	sub    $0xc,%esp
    2174:	ff 75 f4             	push   -0xc(%ebp)
    2177:	e8 6e e2 ff ff       	call   3ea <setuid>
    217c:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    217f:	83 ec 08             	sub    $0x8,%esp
    2182:	68 98 2c 00 00       	push   $0x2c98
    2187:	68 68 24 00 00       	push   $0x2468
    218c:	e8 f1 e1 ff ff       	call   382 <exec>
    2191:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    2194:	83 ec 08             	sub    $0x8,%esp
    2197:	68 ad 24 00 00       	push   $0x24ad
    219c:	6a 01                	push   $0x1
    219e:	e8 b7 e7 ff ff       	call   95a <printf>
    21a3:	83 c4 10             	add    $0x10,%esp
                exit();
    21a6:	e8 9f e1 ff ff       	call   34a <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    21ab:	83 ec 08             	sub    $0x8,%esp
    21ae:	68 c3 24 00 00       	push   $0x24c3
    21b3:	6a 01                	push   $0x1
    21b5:	e8 a0 e7 ff ff       	call   95a <printf>
    21ba:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    21bd:	e8 90 e1 ff ff       	call   352 <wait>
    21c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    21c5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    21c9:	78 08                	js     21d3 <login_user+0x191>
    21cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    21ce:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    21d1:	75 d8                	jne    21ab <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    21d3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    21d7:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    21de:	0f 8e 78 fe ff ff    	jle    205c <login_user+0x1a>
        }
    }

    return -1;
    21e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    21e9:	c9                   	leave  
    21ea:	c3                   	ret    
