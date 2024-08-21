
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd* parsecmd(char*);

// Execute cmd.  Never returns.
void runcmd(struct cmd* cmd) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
    struct execcmd* ecmd;
    struct listcmd* lcmd;
    struct pipecmd* pcmd;
    struct redircmd* rcmd;

    if (cmd == 0) exit();
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
       c:	e8 78 0c 00 00       	call   c89 <exit>

    switch (cmd->type) {
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 6c 2b 00 00 	mov    0x2b6c(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
        default:
            panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 40 2b 00 00       	push   $0x2b40
      2c:	e8 6b 03 00 00       	call   39c <panic>
      31:	83 c4 10             	add    $0x10,%esp

        case EXEC:
            ecmd = (struct execcmd*) cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            if (ecmd->argv[0] == 0) exit();
      3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      44:	e8 40 0c 00 00       	call   c89 <exit>
            exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 62 0c 00 00       	call   cc1 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
            printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 47 2b 00 00       	push   $0x2b47
      71:	6a 02                	push   $0x2
      73:	e8 21 12 00 00       	call   1299 <printf>
      78:	83 c4 10             	add    $0x10,%esp
            break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

        case REDIR:
            rcmd = (struct redircmd*) cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 e8             	mov    %eax,-0x18(%ebp)
            close(rcmd->fd);
      86:	8b 45 e8             	mov    -0x18(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 1c 0c 00 00       	call   cb1 <close>
      95:	83 c4 10             	add    $0x10,%esp
            if (open(rcmd->file, rcmd->mode) < 0) {
      98:	8b 45 e8             	mov    -0x18(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 1b 0c 00 00       	call   cc9 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
                printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 57 2b 00 00       	push   $0x2b57
      c4:	6a 02                	push   $0x2
      c6:	e8 ce 11 00 00       	call   1299 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
                exit();
      ce:	e8 b6 0b 00 00       	call   c89 <exit>
            }
            runcmd(rcmd->cmd);
      d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
            break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

        case LIST:
            lcmd = (struct listcmd*) cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
            if (fork1() == 0) runcmd(lcmd->left);
      f0:	e8 c7 02 00 00       	call   3bc <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
            wait();
     10b:	e8 81 0b 00 00       	call   c91 <wait>
            runcmd(lcmd->right);
     110:	8b 45 f0             	mov    -0x10(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
            break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

        case PIPE:
            pcmd = (struct pipecmd*) cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pipe(p) < 0) panic("pipe");
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 60 0b 00 00       	call   c99 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 67 2b 00 00       	push   $0x2b67
     148:	e8 4f 02 00 00       	call   39c <panic>
     14d:	83 c4 10             	add    $0x10,%esp
            if (fork1() == 0) {
     150:	e8 67 02 00 00       	call   3bc <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
                close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 4e 0b 00 00       	call   cb1 <close>
     163:	83 c4 10             	add    $0x10,%esp
                dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 8f 0b 00 00       	call   d01 <dup>
     172:	83 c4 10             	add    $0x10,%esp
                close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 30 0b 00 00       	call   cb1 <close>
     181:	83 c4 10             	add    $0x10,%esp
                close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 21 0b 00 00       	call   cb1 <close>
     190:	83 c4 10             	add    $0x10,%esp
                runcmd(pcmd->left);
     193:	8b 45 ec             	mov    -0x14(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
            }
            if (fork1() == 0) {
     1a5:	e8 12 02 00 00       	call   3bc <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
                close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 f9 0a 00 00       	call   cb1 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
                dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 3a 0b 00 00       	call   d01 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
                close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 db 0a 00 00       	call   cb1 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
                close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 cc 0a 00 00       	call   cb1 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
                runcmd(pcmd->right);
     1e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
            }
            close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 ab 0a 00 00       	call   cb1 <close>
     206:	83 c4 10             	add    $0x10,%esp
            close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 9c 0a 00 00       	call   cb1 <close>
     215:	83 c4 10             	add    $0x10,%esp
            wait();
     218:	e8 74 0a 00 00       	call   c91 <wait>
            wait();
     21d:	e8 6f 0a 00 00       	call   c91 <wait>
            break;
     222:	eb 22                	jmp    246 <runcmd+0x246>

        case BACK:
            bcmd = (struct backcmd*) cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (fork1() == 0) runcmd(bcmd->cmd);
     22a:	e8 8d 01 00 00       	call   3bc <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
     233:	8b 45 f4             	mov    -0xc(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
            break;
     245:	90                   	nop
    }
    exit();
     246:	e8 3e 0a 00 00       	call   c89 <exit>

0000024b <getcmd>:
}

int getcmd(char* buf, int nbuf) {
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
    printf(2, "$ ");
     251:	83 ec 08             	sub    $0x8,%esp
     254:	68 84 2b 00 00       	push   $0x2b84
     259:	6a 02                	push   $0x2
     25b:	e8 39 10 00 00       	call   1299 <printf>
     260:	83 c4 10             	add    $0x10,%esp
    memset(buf, 0, nbuf);
     263:	8b 45 0c             	mov    0xc(%ebp),%eax
     266:	83 ec 04             	sub    $0x4,%esp
     269:	50                   	push   %eax
     26a:	6a 00                	push   $0x0
     26c:	ff 75 08             	push   0x8(%ebp)
     26f:	e8 99 0b 00 00       	call   e0d <memset>
     274:	83 c4 10             	add    $0x10,%esp
    gets(buf, nbuf);
     277:	83 ec 08             	sub    $0x8,%esp
     27a:	ff 75 0c             	push   0xc(%ebp)
     27d:	ff 75 08             	push   0x8(%ebp)
     280:	e8 d5 0b 00 00       	call   e5a <gets>
     285:	83 c4 10             	add    $0x10,%esp
    if (buf[0] == 0)  // EOF
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	75 07                	jne    299 <getcmd+0x4e>
        return -1;
     292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     297:	eb 05                	jmp    29e <getcmd+0x53>
    return 0;
     299:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29e:	c9                   	leave  
     29f:	c3                   	ret    

000002a0 <main>:

int main(void) {
     2a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a4:	83 e4 f0             	and    $0xfffffff0,%esp
     2a7:	ff 71 fc             	push   -0x4(%ecx)
     2aa:	55                   	push   %ebp
     2ab:	89 e5                	mov    %esp,%ebp
     2ad:	51                   	push   %ecx
     2ae:	83 ec 14             	sub    $0x14,%esp
    static char buf[100];
    int fd;

    // Ensure that three file descriptors are open.
    while ((fd = open("console", O_RDWR)) >= 0) {
     2b1:	eb 16                	jmp    2c9 <main+0x29>
        if (fd >= 3) {
     2b3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b7:	7e 10                	jle    2c9 <main+0x29>
            close(fd);
     2b9:	83 ec 0c             	sub    $0xc,%esp
     2bc:	ff 75 f4             	push   -0xc(%ebp)
     2bf:	e8 ed 09 00 00       	call   cb1 <close>
     2c4:	83 c4 10             	add    $0x10,%esp
            break;
     2c7:	eb 1b                	jmp    2e4 <main+0x44>
    while ((fd = open("console", O_RDWR)) >= 0) {
     2c9:	83 ec 08             	sub    $0x8,%esp
     2cc:	6a 04                	push   $0x4
     2ce:	68 87 2b 00 00       	push   $0x2b87
     2d3:	e8 f1 09 00 00       	call   cc9 <open>
     2d8:	83 c4 10             	add    $0x10,%esp
     2db:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e2:	79 cf                	jns    2b3 <main+0x13>
        }
    }

    // Read and run input commands.
    while (getcmd(buf, sizeof(buf)) >= 0) {
     2e4:	e9 94 00 00 00       	jmp    37d <main+0xdd>
        if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ') {
     2e9:	0f b6 05 80 38 00 00 	movzbl 0x3880,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 81 38 00 00 	movzbl 0x3881,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 82 38 00 00 	movzbl 0x3882,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
            // Chdir must be called by the parent, not the child.
            buf[strlen(buf) - 1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 80 38 00 00       	push   $0x3880
     312:	e8 cf 0a 00 00       	call   de6 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 80 38 00 00 00 	movb   $0x0,0x3880(%eax)
            if (chdir(buf + 3) < 0) printf(2, "cannot cd %s\n", buf + 3);
     324:	b8 83 38 00 00       	mov    $0x3883,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 c7 09 00 00       	call   cf9 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
     339:	b8 83 38 00 00       	mov    $0x3883,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 8f 2b 00 00       	push   $0x2b8f
     347:	6a 02                	push   $0x2
     349:	e8 4b 0f 00 00       	call   1299 <printf>
     34e:	83 c4 10             	add    $0x10,%esp
            continue;
     351:	eb 2a                	jmp    37d <main+0xdd>
        }
        if (fork1() == 0) runcmd(parsecmd(buf));
     353:	e8 64 00 00 00       	call   3bc <fork1>
     358:	85 c0                	test   %eax,%eax
     35a:	75 1c                	jne    378 <main+0xd8>
     35c:	83 ec 0c             	sub    $0xc,%esp
     35f:	68 80 38 00 00       	push   $0x3880
     364:	e8 aa 03 00 00       	call   713 <parsecmd>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	83 ec 0c             	sub    $0xc,%esp
     36f:	50                   	push   %eax
     370:	e8 8b fc ff ff       	call   0 <runcmd>
     375:	83 c4 10             	add    $0x10,%esp
        wait();
     378:	e8 14 09 00 00       	call   c91 <wait>
    while (getcmd(buf, sizeof(buf)) >= 0) {
     37d:	83 ec 08             	sub    $0x8,%esp
     380:	6a 64                	push   $0x64
     382:	68 80 38 00 00       	push   $0x3880
     387:	e8 bf fe ff ff       	call   24b <getcmd>
     38c:	83 c4 10             	add    $0x10,%esp
     38f:	85 c0                	test   %eax,%eax
     391:	0f 89 52 ff ff ff    	jns    2e9 <main+0x49>
    }
    exit();
     397:	e8 ed 08 00 00       	call   c89 <exit>

0000039c <panic>:
}

void panic(char* s) {
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
     39f:	83 ec 08             	sub    $0x8,%esp
    printf(2, "%s\n", s);
     3a2:	83 ec 04             	sub    $0x4,%esp
     3a5:	ff 75 08             	push   0x8(%ebp)
     3a8:	68 9d 2b 00 00       	push   $0x2b9d
     3ad:	6a 02                	push   $0x2
     3af:	e8 e5 0e 00 00       	call   1299 <printf>
     3b4:	83 c4 10             	add    $0x10,%esp
    exit();
     3b7:	e8 cd 08 00 00       	call   c89 <exit>

000003bc <fork1>:
}

int fork1(void) {
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 18             	sub    $0x18,%esp
    int pid;

    pid = fork();
     3c2:	e8 ba 08 00 00       	call   c81 <fork>
     3c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (pid == -1) panic("fork");
     3ca:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3ce:	75 10                	jne    3e0 <fork1+0x24>
     3d0:	83 ec 0c             	sub    $0xc,%esp
     3d3:	68 a1 2b 00 00       	push   $0x2ba1
     3d8:	e8 bf ff ff ff       	call   39c <panic>
     3dd:	83 c4 10             	add    $0x10,%esp
    return pid;
     3e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3e3:	c9                   	leave  
     3e4:	c3                   	ret    

000003e5 <execcmd>:

//PAGEBREAK!
// Constructors

struct cmd* execcmd(void) {
     3e5:	55                   	push   %ebp
     3e6:	89 e5                	mov    %esp,%ebp
     3e8:	83 ec 18             	sub    $0x18,%esp
    struct execcmd* cmd;

    cmd = malloc(sizeof(*cmd));
     3eb:	83 ec 0c             	sub    $0xc,%esp
     3ee:	6a 54                	push   $0x54
     3f0:	e8 ed 0c 00 00       	call   10e2 <malloc>
     3f5:	83 c4 10             	add    $0x10,%esp
     3f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memset(cmd, 0, sizeof(*cmd));
     3fb:	83 ec 04             	sub    $0x4,%esp
     3fe:	6a 54                	push   $0x54
     400:	6a 00                	push   $0x0
     402:	ff 75 f4             	push   -0xc(%ebp)
     405:	e8 03 0a 00 00       	call   e0d <memset>
     40a:	83 c4 10             	add    $0x10,%esp
    cmd->type = EXEC;
     40d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     410:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    return (struct cmd*) cmd;
     416:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     419:	c9                   	leave  
     41a:	c3                   	ret    

0000041b <redircmd>:

struct cmd* redircmd(struct cmd* subcmd, char* file, char* efile, int mode,
                     int fd) {
     41b:	55                   	push   %ebp
     41c:	89 e5                	mov    %esp,%ebp
     41e:	83 ec 18             	sub    $0x18,%esp
    struct redircmd* cmd;

    cmd = malloc(sizeof(*cmd));
     421:	83 ec 0c             	sub    $0xc,%esp
     424:	6a 18                	push   $0x18
     426:	e8 b7 0c 00 00       	call   10e2 <malloc>
     42b:	83 c4 10             	add    $0x10,%esp
     42e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memset(cmd, 0, sizeof(*cmd));
     431:	83 ec 04             	sub    $0x4,%esp
     434:	6a 18                	push   $0x18
     436:	6a 00                	push   $0x0
     438:	ff 75 f4             	push   -0xc(%ebp)
     43b:	e8 cd 09 00 00       	call   e0d <memset>
     440:	83 c4 10             	add    $0x10,%esp
    cmd->type = REDIR;
     443:	8b 45 f4             	mov    -0xc(%ebp),%eax
     446:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
    cmd->cmd = subcmd;
     44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44f:	8b 55 08             	mov    0x8(%ebp),%edx
     452:	89 50 04             	mov    %edx,0x4(%eax)
    cmd->file = file;
     455:	8b 45 f4             	mov    -0xc(%ebp),%eax
     458:	8b 55 0c             	mov    0xc(%ebp),%edx
     45b:	89 50 08             	mov    %edx,0x8(%eax)
    cmd->efile = efile;
     45e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     461:	8b 55 10             	mov    0x10(%ebp),%edx
     464:	89 50 0c             	mov    %edx,0xc(%eax)
    cmd->mode = mode;
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	8b 55 14             	mov    0x14(%ebp),%edx
     46d:	89 50 10             	mov    %edx,0x10(%eax)
    cmd->fd = fd;
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
     473:	8b 55 18             	mov    0x18(%ebp),%edx
     476:	89 50 14             	mov    %edx,0x14(%eax)
    return (struct cmd*) cmd;
     479:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     47c:	c9                   	leave  
     47d:	c3                   	ret    

0000047e <pipecmd>:

struct cmd* pipecmd(struct cmd* left, struct cmd* right) {
     47e:	55                   	push   %ebp
     47f:	89 e5                	mov    %esp,%ebp
     481:	83 ec 18             	sub    $0x18,%esp
    struct pipecmd* cmd;

    cmd = malloc(sizeof(*cmd));
     484:	83 ec 0c             	sub    $0xc,%esp
     487:	6a 0c                	push   $0xc
     489:	e8 54 0c 00 00       	call   10e2 <malloc>
     48e:	83 c4 10             	add    $0x10,%esp
     491:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memset(cmd, 0, sizeof(*cmd));
     494:	83 ec 04             	sub    $0x4,%esp
     497:	6a 0c                	push   $0xc
     499:	6a 00                	push   $0x0
     49b:	ff 75 f4             	push   -0xc(%ebp)
     49e:	e8 6a 09 00 00       	call   e0d <memset>
     4a3:	83 c4 10             	add    $0x10,%esp
    cmd->type = PIPE;
     4a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a9:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
    cmd->left = left;
     4af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b2:	8b 55 08             	mov    0x8(%ebp),%edx
     4b5:	89 50 04             	mov    %edx,0x4(%eax)
    cmd->right = right;
     4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4bb:	8b 55 0c             	mov    0xc(%ebp),%edx
     4be:	89 50 08             	mov    %edx,0x8(%eax)
    return (struct cmd*) cmd;
     4c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4c4:	c9                   	leave  
     4c5:	c3                   	ret    

000004c6 <listcmd>:

struct cmd* listcmd(struct cmd* left, struct cmd* right) {
     4c6:	55                   	push   %ebp
     4c7:	89 e5                	mov    %esp,%ebp
     4c9:	83 ec 18             	sub    $0x18,%esp
    struct listcmd* cmd;

    cmd = malloc(sizeof(*cmd));
     4cc:	83 ec 0c             	sub    $0xc,%esp
     4cf:	6a 0c                	push   $0xc
     4d1:	e8 0c 0c 00 00       	call   10e2 <malloc>
     4d6:	83 c4 10             	add    $0x10,%esp
     4d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memset(cmd, 0, sizeof(*cmd));
     4dc:	83 ec 04             	sub    $0x4,%esp
     4df:	6a 0c                	push   $0xc
     4e1:	6a 00                	push   $0x0
     4e3:	ff 75 f4             	push   -0xc(%ebp)
     4e6:	e8 22 09 00 00       	call   e0d <memset>
     4eb:	83 c4 10             	add    $0x10,%esp
    cmd->type = LIST;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
    cmd->left = left;
     4f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fa:	8b 55 08             	mov    0x8(%ebp),%edx
     4fd:	89 50 04             	mov    %edx,0x4(%eax)
    cmd->right = right;
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	8b 55 0c             	mov    0xc(%ebp),%edx
     506:	89 50 08             	mov    %edx,0x8(%eax)
    return (struct cmd*) cmd;
     509:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     50c:	c9                   	leave  
     50d:	c3                   	ret    

0000050e <backcmd>:

struct cmd* backcmd(struct cmd* subcmd) {
     50e:	55                   	push   %ebp
     50f:	89 e5                	mov    %esp,%ebp
     511:	83 ec 18             	sub    $0x18,%esp
    struct backcmd* cmd;

    cmd = malloc(sizeof(*cmd));
     514:	83 ec 0c             	sub    $0xc,%esp
     517:	6a 08                	push   $0x8
     519:	e8 c4 0b 00 00       	call   10e2 <malloc>
     51e:	83 c4 10             	add    $0x10,%esp
     521:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memset(cmd, 0, sizeof(*cmd));
     524:	83 ec 04             	sub    $0x4,%esp
     527:	6a 08                	push   $0x8
     529:	6a 00                	push   $0x0
     52b:	ff 75 f4             	push   -0xc(%ebp)
     52e:	e8 da 08 00 00       	call   e0d <memset>
     533:	83 c4 10             	add    $0x10,%esp
    cmd->type = BACK;
     536:	8b 45 f4             	mov    -0xc(%ebp),%eax
     539:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
    cmd->cmd = subcmd;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	8b 55 08             	mov    0x8(%ebp),%edx
     545:	89 50 04             	mov    %edx,0x4(%eax)
    return (struct cmd*) cmd;
     548:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     54b:	c9                   	leave  
     54c:	c3                   	ret    

0000054d <gettoken>:
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int gettoken(char** ps, char* es, char** q, char** eq) {
     54d:	55                   	push   %ebp
     54e:	89 e5                	mov    %esp,%ebp
     550:	83 ec 18             	sub    $0x18,%esp
    char* s;
    int ret;

    s = *ps;
     553:	8b 45 08             	mov    0x8(%ebp),%eax
     556:	8b 00                	mov    (%eax),%eax
     558:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (s < es && strchr(whitespace, *s)) s++;
     55b:	eb 04                	jmp    561 <gettoken+0x14>
     55d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     561:	8b 45 f4             	mov    -0xc(%ebp),%eax
     564:	3b 45 0c             	cmp    0xc(%ebp),%eax
     567:	73 1e                	jae    587 <gettoken+0x3a>
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	0f be c0             	movsbl %al,%eax
     572:	83 ec 08             	sub    $0x8,%esp
     575:	50                   	push   %eax
     576:	68 44 38 00 00       	push   $0x3844
     57b:	e8 a7 08 00 00       	call   e27 <strchr>
     580:	83 c4 10             	add    $0x10,%esp
     583:	85 c0                	test   %eax,%eax
     585:	75 d6                	jne    55d <gettoken+0x10>
    if (q) *q = s;
     587:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     58b:	74 08                	je     595 <gettoken+0x48>
     58d:	8b 45 10             	mov    0x10(%ebp),%eax
     590:	8b 55 f4             	mov    -0xc(%ebp),%edx
     593:	89 10                	mov    %edx,(%eax)
    ret = *s;
     595:	8b 45 f4             	mov    -0xc(%ebp),%eax
     598:	0f b6 00             	movzbl (%eax),%eax
     59b:	0f be c0             	movsbl %al,%eax
     59e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    switch (*s) {
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	0f b6 00             	movzbl (%eax),%eax
     5a7:	0f be c0             	movsbl %al,%eax
     5aa:	83 f8 7c             	cmp    $0x7c,%eax
     5ad:	74 2c                	je     5db <gettoken+0x8e>
     5af:	83 f8 7c             	cmp    $0x7c,%eax
     5b2:	7f 48                	jg     5fc <gettoken+0xaf>
     5b4:	83 f8 3e             	cmp    $0x3e,%eax
     5b7:	74 28                	je     5e1 <gettoken+0x94>
     5b9:	83 f8 3e             	cmp    $0x3e,%eax
     5bc:	7f 3e                	jg     5fc <gettoken+0xaf>
     5be:	83 f8 3c             	cmp    $0x3c,%eax
     5c1:	7f 39                	jg     5fc <gettoken+0xaf>
     5c3:	83 f8 3b             	cmp    $0x3b,%eax
     5c6:	7d 13                	jge    5db <gettoken+0x8e>
     5c8:	83 f8 29             	cmp    $0x29,%eax
     5cb:	7f 2f                	jg     5fc <gettoken+0xaf>
     5cd:	83 f8 28             	cmp    $0x28,%eax
     5d0:	7d 09                	jge    5db <gettoken+0x8e>
     5d2:	85 c0                	test   %eax,%eax
     5d4:	74 79                	je     64f <gettoken+0x102>
     5d6:	83 f8 26             	cmp    $0x26,%eax
     5d9:	75 21                	jne    5fc <gettoken+0xaf>
        case '(':
        case ')':
        case ';':
        case '&':
        case '<':
            s++;
     5db:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            break;
     5df:	eb 75                	jmp    656 <gettoken+0x109>
        case '>':
            s++;
     5e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            if (*s == '>') {
     5e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e8:	0f b6 00             	movzbl (%eax),%eax
     5eb:	3c 3e                	cmp    $0x3e,%al
     5ed:	75 63                	jne    652 <gettoken+0x105>
                ret = '+';
     5ef:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
                s++;
     5f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            }
            break;
     5fa:	eb 56                	jmp    652 <gettoken+0x105>
        default:
            ret = 'a';
     5fc:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
            while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     603:	eb 04                	jmp    609 <gettoken+0xbc>
                s++;
     605:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     609:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     60f:	73 44                	jae    655 <gettoken+0x108>
     611:	8b 45 f4             	mov    -0xc(%ebp),%eax
     614:	0f b6 00             	movzbl (%eax),%eax
     617:	0f be c0             	movsbl %al,%eax
     61a:	83 ec 08             	sub    $0x8,%esp
     61d:	50                   	push   %eax
     61e:	68 44 38 00 00       	push   $0x3844
     623:	e8 ff 07 00 00       	call   e27 <strchr>
     628:	83 c4 10             	add    $0x10,%esp
     62b:	85 c0                	test   %eax,%eax
     62d:	75 26                	jne    655 <gettoken+0x108>
     62f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     632:	0f b6 00             	movzbl (%eax),%eax
     635:	0f be c0             	movsbl %al,%eax
     638:	83 ec 08             	sub    $0x8,%esp
     63b:	50                   	push   %eax
     63c:	68 4c 38 00 00       	push   $0x384c
     641:	e8 e1 07 00 00       	call   e27 <strchr>
     646:	83 c4 10             	add    $0x10,%esp
     649:	85 c0                	test   %eax,%eax
     64b:	74 b8                	je     605 <gettoken+0xb8>
            break;
     64d:	eb 06                	jmp    655 <gettoken+0x108>
            break;
     64f:	90                   	nop
     650:	eb 04                	jmp    656 <gettoken+0x109>
            break;
     652:	90                   	nop
     653:	eb 01                	jmp    656 <gettoken+0x109>
            break;
     655:	90                   	nop
    }
    if (eq) *eq = s;
     656:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     65a:	74 0e                	je     66a <gettoken+0x11d>
     65c:	8b 45 14             	mov    0x14(%ebp),%eax
     65f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     662:	89 10                	mov    %edx,(%eax)

    while (s < es && strchr(whitespace, *s)) s++;
     664:	eb 04                	jmp    66a <gettoken+0x11d>
     666:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     66a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     670:	73 1e                	jae    690 <gettoken+0x143>
     672:	8b 45 f4             	mov    -0xc(%ebp),%eax
     675:	0f b6 00             	movzbl (%eax),%eax
     678:	0f be c0             	movsbl %al,%eax
     67b:	83 ec 08             	sub    $0x8,%esp
     67e:	50                   	push   %eax
     67f:	68 44 38 00 00       	push   $0x3844
     684:	e8 9e 07 00 00       	call   e27 <strchr>
     689:	83 c4 10             	add    $0x10,%esp
     68c:	85 c0                	test   %eax,%eax
     68e:	75 d6                	jne    666 <gettoken+0x119>
    *ps = s;
     690:	8b 45 08             	mov    0x8(%ebp),%eax
     693:	8b 55 f4             	mov    -0xc(%ebp),%edx
     696:	89 10                	mov    %edx,(%eax)
    return ret;
     698:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     69b:	c9                   	leave  
     69c:	c3                   	ret    

0000069d <peek>:

int peek(char** ps, char* es, char* toks) {
     69d:	55                   	push   %ebp
     69e:	89 e5                	mov    %esp,%ebp
     6a0:	83 ec 18             	sub    $0x18,%esp
    char* s;

    s = *ps;
     6a3:	8b 45 08             	mov    0x8(%ebp),%eax
     6a6:	8b 00                	mov    (%eax),%eax
     6a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (s < es && strchr(whitespace, *s)) s++;
     6ab:	eb 04                	jmp    6b1 <peek+0x14>
     6ad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     6b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6b7:	73 1e                	jae    6d7 <peek+0x3a>
     6b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bc:	0f b6 00             	movzbl (%eax),%eax
     6bf:	0f be c0             	movsbl %al,%eax
     6c2:	83 ec 08             	sub    $0x8,%esp
     6c5:	50                   	push   %eax
     6c6:	68 44 38 00 00       	push   $0x3844
     6cb:	e8 57 07 00 00       	call   e27 <strchr>
     6d0:	83 c4 10             	add    $0x10,%esp
     6d3:	85 c0                	test   %eax,%eax
     6d5:	75 d6                	jne    6ad <peek+0x10>
    *ps = s;
     6d7:	8b 45 08             	mov    0x8(%ebp),%eax
     6da:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6dd:	89 10                	mov    %edx,(%eax)
    return *s && strchr(toks, *s);
     6df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e2:	0f b6 00             	movzbl (%eax),%eax
     6e5:	84 c0                	test   %al,%al
     6e7:	74 23                	je     70c <peek+0x6f>
     6e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ec:	0f b6 00             	movzbl (%eax),%eax
     6ef:	0f be c0             	movsbl %al,%eax
     6f2:	83 ec 08             	sub    $0x8,%esp
     6f5:	50                   	push   %eax
     6f6:	ff 75 10             	push   0x10(%ebp)
     6f9:	e8 29 07 00 00       	call   e27 <strchr>
     6fe:	83 c4 10             	add    $0x10,%esp
     701:	85 c0                	test   %eax,%eax
     703:	74 07                	je     70c <peek+0x6f>
     705:	b8 01 00 00 00       	mov    $0x1,%eax
     70a:	eb 05                	jmp    711 <peek+0x74>
     70c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     711:	c9                   	leave  
     712:	c3                   	ret    

00000713 <parsecmd>:
struct cmd* parseline(char**, char*);
struct cmd* parsepipe(char**, char*);
struct cmd* parseexec(char**, char*);
struct cmd* nulterminate(struct cmd*);

struct cmd* parsecmd(char* s) {
     713:	55                   	push   %ebp
     714:	89 e5                	mov    %esp,%ebp
     716:	53                   	push   %ebx
     717:	83 ec 14             	sub    $0x14,%esp
    char* es;
    struct cmd* cmd;

    es = s + strlen(s);
     71a:	8b 5d 08             	mov    0x8(%ebp),%ebx
     71d:	8b 45 08             	mov    0x8(%ebp),%eax
     720:	83 ec 0c             	sub    $0xc,%esp
     723:	50                   	push   %eax
     724:	e8 bd 06 00 00       	call   de6 <strlen>
     729:	83 c4 10             	add    $0x10,%esp
     72c:	01 d8                	add    %ebx,%eax
     72e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cmd = parseline(&s, es);
     731:	83 ec 08             	sub    $0x8,%esp
     734:	ff 75 f4             	push   -0xc(%ebp)
     737:	8d 45 08             	lea    0x8(%ebp),%eax
     73a:	50                   	push   %eax
     73b:	e8 61 00 00 00       	call   7a1 <parseline>
     740:	83 c4 10             	add    $0x10,%esp
     743:	89 45 f0             	mov    %eax,-0x10(%ebp)
    peek(&s, es, "");
     746:	83 ec 04             	sub    $0x4,%esp
     749:	68 a6 2b 00 00       	push   $0x2ba6
     74e:	ff 75 f4             	push   -0xc(%ebp)
     751:	8d 45 08             	lea    0x8(%ebp),%eax
     754:	50                   	push   %eax
     755:	e8 43 ff ff ff       	call   69d <peek>
     75a:	83 c4 10             	add    $0x10,%esp
    if (s != es) {
     75d:	8b 45 08             	mov    0x8(%ebp),%eax
     760:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     763:	74 26                	je     78b <parsecmd+0x78>
        printf(2, "leftovers: %s\n", s);
     765:	8b 45 08             	mov    0x8(%ebp),%eax
     768:	83 ec 04             	sub    $0x4,%esp
     76b:	50                   	push   %eax
     76c:	68 a7 2b 00 00       	push   $0x2ba7
     771:	6a 02                	push   $0x2
     773:	e8 21 0b 00 00       	call   1299 <printf>
     778:	83 c4 10             	add    $0x10,%esp
        panic("syntax");
     77b:	83 ec 0c             	sub    $0xc,%esp
     77e:	68 b6 2b 00 00       	push   $0x2bb6
     783:	e8 14 fc ff ff       	call   39c <panic>
     788:	83 c4 10             	add    $0x10,%esp
    }
    nulterminate(cmd);
     78b:	83 ec 0c             	sub    $0xc,%esp
     78e:	ff 75 f0             	push   -0x10(%ebp)
     791:	e8 ef 03 00 00       	call   b85 <nulterminate>
     796:	83 c4 10             	add    $0x10,%esp
    return cmd;
     799:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     79c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     79f:	c9                   	leave  
     7a0:	c3                   	ret    

000007a1 <parseline>:

struct cmd* parseline(char** ps, char* es) {
     7a1:	55                   	push   %ebp
     7a2:	89 e5                	mov    %esp,%ebp
     7a4:	83 ec 18             	sub    $0x18,%esp
    struct cmd* cmd;

    cmd = parsepipe(ps, es);
     7a7:	83 ec 08             	sub    $0x8,%esp
     7aa:	ff 75 0c             	push   0xc(%ebp)
     7ad:	ff 75 08             	push   0x8(%ebp)
     7b0:	e8 99 00 00 00       	call   84e <parsepipe>
     7b5:	83 c4 10             	add    $0x10,%esp
     7b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (peek(ps, es, "&")) {
     7bb:	eb 23                	jmp    7e0 <parseline+0x3f>
        gettoken(ps, es, 0, 0);
     7bd:	6a 00                	push   $0x0
     7bf:	6a 00                	push   $0x0
     7c1:	ff 75 0c             	push   0xc(%ebp)
     7c4:	ff 75 08             	push   0x8(%ebp)
     7c7:	e8 81 fd ff ff       	call   54d <gettoken>
     7cc:	83 c4 10             	add    $0x10,%esp
        cmd = backcmd(cmd);
     7cf:	83 ec 0c             	sub    $0xc,%esp
     7d2:	ff 75 f4             	push   -0xc(%ebp)
     7d5:	e8 34 fd ff ff       	call   50e <backcmd>
     7da:	83 c4 10             	add    $0x10,%esp
     7dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (peek(ps, es, "&")) {
     7e0:	83 ec 04             	sub    $0x4,%esp
     7e3:	68 bd 2b 00 00       	push   $0x2bbd
     7e8:	ff 75 0c             	push   0xc(%ebp)
     7eb:	ff 75 08             	push   0x8(%ebp)
     7ee:	e8 aa fe ff ff       	call   69d <peek>
     7f3:	83 c4 10             	add    $0x10,%esp
     7f6:	85 c0                	test   %eax,%eax
     7f8:	75 c3                	jne    7bd <parseline+0x1c>
    }
    if (peek(ps, es, ";")) {
     7fa:	83 ec 04             	sub    $0x4,%esp
     7fd:	68 bf 2b 00 00       	push   $0x2bbf
     802:	ff 75 0c             	push   0xc(%ebp)
     805:	ff 75 08             	push   0x8(%ebp)
     808:	e8 90 fe ff ff       	call   69d <peek>
     80d:	83 c4 10             	add    $0x10,%esp
     810:	85 c0                	test   %eax,%eax
     812:	74 35                	je     849 <parseline+0xa8>
        gettoken(ps, es, 0, 0);
     814:	6a 00                	push   $0x0
     816:	6a 00                	push   $0x0
     818:	ff 75 0c             	push   0xc(%ebp)
     81b:	ff 75 08             	push   0x8(%ebp)
     81e:	e8 2a fd ff ff       	call   54d <gettoken>
     823:	83 c4 10             	add    $0x10,%esp
        cmd = listcmd(cmd, parseline(ps, es));
     826:	83 ec 08             	sub    $0x8,%esp
     829:	ff 75 0c             	push   0xc(%ebp)
     82c:	ff 75 08             	push   0x8(%ebp)
     82f:	e8 6d ff ff ff       	call   7a1 <parseline>
     834:	83 c4 10             	add    $0x10,%esp
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	50                   	push   %eax
     83b:	ff 75 f4             	push   -0xc(%ebp)
     83e:	e8 83 fc ff ff       	call   4c6 <listcmd>
     843:	83 c4 10             	add    $0x10,%esp
     846:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    return cmd;
     849:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     84c:	c9                   	leave  
     84d:	c3                   	ret    

0000084e <parsepipe>:

struct cmd* parsepipe(char** ps, char* es) {
     84e:	55                   	push   %ebp
     84f:	89 e5                	mov    %esp,%ebp
     851:	83 ec 18             	sub    $0x18,%esp
    struct cmd* cmd;

    cmd = parseexec(ps, es);
     854:	83 ec 08             	sub    $0x8,%esp
     857:	ff 75 0c             	push   0xc(%ebp)
     85a:	ff 75 08             	push   0x8(%ebp)
     85d:	e8 f0 01 00 00       	call   a52 <parseexec>
     862:	83 c4 10             	add    $0x10,%esp
     865:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (peek(ps, es, "|")) {
     868:	83 ec 04             	sub    $0x4,%esp
     86b:	68 c1 2b 00 00       	push   $0x2bc1
     870:	ff 75 0c             	push   0xc(%ebp)
     873:	ff 75 08             	push   0x8(%ebp)
     876:	e8 22 fe ff ff       	call   69d <peek>
     87b:	83 c4 10             	add    $0x10,%esp
     87e:	85 c0                	test   %eax,%eax
     880:	74 35                	je     8b7 <parsepipe+0x69>
        gettoken(ps, es, 0, 0);
     882:	6a 00                	push   $0x0
     884:	6a 00                	push   $0x0
     886:	ff 75 0c             	push   0xc(%ebp)
     889:	ff 75 08             	push   0x8(%ebp)
     88c:	e8 bc fc ff ff       	call   54d <gettoken>
     891:	83 c4 10             	add    $0x10,%esp
        cmd = pipecmd(cmd, parsepipe(ps, es));
     894:	83 ec 08             	sub    $0x8,%esp
     897:	ff 75 0c             	push   0xc(%ebp)
     89a:	ff 75 08             	push   0x8(%ebp)
     89d:	e8 ac ff ff ff       	call   84e <parsepipe>
     8a2:	83 c4 10             	add    $0x10,%esp
     8a5:	83 ec 08             	sub    $0x8,%esp
     8a8:	50                   	push   %eax
     8a9:	ff 75 f4             	push   -0xc(%ebp)
     8ac:	e8 cd fb ff ff       	call   47e <pipecmd>
     8b1:	83 c4 10             	add    $0x10,%esp
     8b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    return cmd;
     8b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8ba:	c9                   	leave  
     8bb:	c3                   	ret    

000008bc <parseredirs>:

struct cmd* parseredirs(struct cmd* cmd, char** ps, char* es) {
     8bc:	55                   	push   %ebp
     8bd:	89 e5                	mov    %esp,%ebp
     8bf:	83 ec 18             	sub    $0x18,%esp
    int tok;
    char *q, *eq;

    while (peek(ps, es, "<>")) {
     8c2:	e9 ba 00 00 00       	jmp    981 <parseredirs+0xc5>
        tok = gettoken(ps, es, 0, 0);
     8c7:	6a 00                	push   $0x0
     8c9:	6a 00                	push   $0x0
     8cb:	ff 75 10             	push   0x10(%ebp)
     8ce:	ff 75 0c             	push   0xc(%ebp)
     8d1:	e8 77 fc ff ff       	call   54d <gettoken>
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (gettoken(ps, es, &q, &eq) != 'a')
     8dc:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8df:	50                   	push   %eax
     8e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8e3:	50                   	push   %eax
     8e4:	ff 75 10             	push   0x10(%ebp)
     8e7:	ff 75 0c             	push   0xc(%ebp)
     8ea:	e8 5e fc ff ff       	call   54d <gettoken>
     8ef:	83 c4 10             	add    $0x10,%esp
     8f2:	83 f8 61             	cmp    $0x61,%eax
     8f5:	74 10                	je     907 <parseredirs+0x4b>
            panic("missing file for redirection");
     8f7:	83 ec 0c             	sub    $0xc,%esp
     8fa:	68 c3 2b 00 00       	push   $0x2bc3
     8ff:	e8 98 fa ff ff       	call   39c <panic>
     904:	83 c4 10             	add    $0x10,%esp
        switch (tok) {
     907:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     90b:	74 31                	je     93e <parseredirs+0x82>
     90d:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     911:	7f 6e                	jg     981 <parseredirs+0xc5>
     913:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
     917:	74 47                	je     960 <parseredirs+0xa4>
     919:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
     91d:	75 62                	jne    981 <parseredirs+0xc5>
            case '<':
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     91f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     922:	8b 45 f0             	mov    -0x10(%ebp),%eax
     925:	83 ec 0c             	sub    $0xc,%esp
     928:	6a 00                	push   $0x0
     92a:	6a 01                	push   $0x1
     92c:	52                   	push   %edx
     92d:	50                   	push   %eax
     92e:	ff 75 08             	push   0x8(%ebp)
     931:	e8 e5 fa ff ff       	call   41b <redircmd>
     936:	83 c4 20             	add    $0x20,%esp
     939:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     93c:	eb 43                	jmp    981 <parseredirs+0xc5>
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE, 1);
     93e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     941:	8b 45 f0             	mov    -0x10(%ebp),%eax
     944:	83 ec 0c             	sub    $0xc,%esp
     947:	6a 01                	push   $0x1
     949:	68 02 02 00 00       	push   $0x202
     94e:	52                   	push   %edx
     94f:	50                   	push   %eax
     950:	ff 75 08             	push   0x8(%ebp)
     953:	e8 c3 fa ff ff       	call   41b <redircmd>
     958:	83 c4 20             	add    $0x20,%esp
     95b:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     95e:	eb 21                	jmp    981 <parseredirs+0xc5>
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE, 1);
     960:	8b 55 ec             	mov    -0x14(%ebp),%edx
     963:	8b 45 f0             	mov    -0x10(%ebp),%eax
     966:	83 ec 0c             	sub    $0xc,%esp
     969:	6a 01                	push   $0x1
     96b:	68 02 02 00 00       	push   $0x202
     970:	52                   	push   %edx
     971:	50                   	push   %eax
     972:	ff 75 08             	push   0x8(%ebp)
     975:	e8 a1 fa ff ff       	call   41b <redircmd>
     97a:	83 c4 20             	add    $0x20,%esp
     97d:	89 45 08             	mov    %eax,0x8(%ebp)
                break;
     980:	90                   	nop
    while (peek(ps, es, "<>")) {
     981:	83 ec 04             	sub    $0x4,%esp
     984:	68 e0 2b 00 00       	push   $0x2be0
     989:	ff 75 10             	push   0x10(%ebp)
     98c:	ff 75 0c             	push   0xc(%ebp)
     98f:	e8 09 fd ff ff       	call   69d <peek>
     994:	83 c4 10             	add    $0x10,%esp
     997:	85 c0                	test   %eax,%eax
     999:	0f 85 28 ff ff ff    	jne    8c7 <parseredirs+0xb>
        }
    }
    return cmd;
     99f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9a2:	c9                   	leave  
     9a3:	c3                   	ret    

000009a4 <parseblock>:

struct cmd* parseblock(char** ps, char* es) {
     9a4:	55                   	push   %ebp
     9a5:	89 e5                	mov    %esp,%ebp
     9a7:	83 ec 18             	sub    $0x18,%esp
    struct cmd* cmd;

    if (!peek(ps, es, "(")) panic("parseblock");
     9aa:	83 ec 04             	sub    $0x4,%esp
     9ad:	68 e3 2b 00 00       	push   $0x2be3
     9b2:	ff 75 0c             	push   0xc(%ebp)
     9b5:	ff 75 08             	push   0x8(%ebp)
     9b8:	e8 e0 fc ff ff       	call   69d <peek>
     9bd:	83 c4 10             	add    $0x10,%esp
     9c0:	85 c0                	test   %eax,%eax
     9c2:	75 10                	jne    9d4 <parseblock+0x30>
     9c4:	83 ec 0c             	sub    $0xc,%esp
     9c7:	68 e5 2b 00 00       	push   $0x2be5
     9cc:	e8 cb f9 ff ff       	call   39c <panic>
     9d1:	83 c4 10             	add    $0x10,%esp
    gettoken(ps, es, 0, 0);
     9d4:	6a 00                	push   $0x0
     9d6:	6a 00                	push   $0x0
     9d8:	ff 75 0c             	push   0xc(%ebp)
     9db:	ff 75 08             	push   0x8(%ebp)
     9de:	e8 6a fb ff ff       	call   54d <gettoken>
     9e3:	83 c4 10             	add    $0x10,%esp
    cmd = parseline(ps, es);
     9e6:	83 ec 08             	sub    $0x8,%esp
     9e9:	ff 75 0c             	push   0xc(%ebp)
     9ec:	ff 75 08             	push   0x8(%ebp)
     9ef:	e8 ad fd ff ff       	call   7a1 <parseline>
     9f4:	83 c4 10             	add    $0x10,%esp
     9f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (!peek(ps, es, ")")) panic("syntax - missing )");
     9fa:	83 ec 04             	sub    $0x4,%esp
     9fd:	68 f0 2b 00 00       	push   $0x2bf0
     a02:	ff 75 0c             	push   0xc(%ebp)
     a05:	ff 75 08             	push   0x8(%ebp)
     a08:	e8 90 fc ff ff       	call   69d <peek>
     a0d:	83 c4 10             	add    $0x10,%esp
     a10:	85 c0                	test   %eax,%eax
     a12:	75 10                	jne    a24 <parseblock+0x80>
     a14:	83 ec 0c             	sub    $0xc,%esp
     a17:	68 f2 2b 00 00       	push   $0x2bf2
     a1c:	e8 7b f9 ff ff       	call   39c <panic>
     a21:	83 c4 10             	add    $0x10,%esp
    gettoken(ps, es, 0, 0);
     a24:	6a 00                	push   $0x0
     a26:	6a 00                	push   $0x0
     a28:	ff 75 0c             	push   0xc(%ebp)
     a2b:	ff 75 08             	push   0x8(%ebp)
     a2e:	e8 1a fb ff ff       	call   54d <gettoken>
     a33:	83 c4 10             	add    $0x10,%esp
    cmd = parseredirs(cmd, ps, es);
     a36:	83 ec 04             	sub    $0x4,%esp
     a39:	ff 75 0c             	push   0xc(%ebp)
     a3c:	ff 75 08             	push   0x8(%ebp)
     a3f:	ff 75 f4             	push   -0xc(%ebp)
     a42:	e8 75 fe ff ff       	call   8bc <parseredirs>
     a47:	83 c4 10             	add    $0x10,%esp
     a4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return cmd;
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a50:	c9                   	leave  
     a51:	c3                   	ret    

00000a52 <parseexec>:

struct cmd* parseexec(char** ps, char* es) {
     a52:	55                   	push   %ebp
     a53:	89 e5                	mov    %esp,%ebp
     a55:	83 ec 28             	sub    $0x28,%esp
    char *q, *eq;
    int tok, argc;
    struct execcmd* cmd;
    struct cmd* ret;

    if (peek(ps, es, "(")) return parseblock(ps, es);
     a58:	83 ec 04             	sub    $0x4,%esp
     a5b:	68 e3 2b 00 00       	push   $0x2be3
     a60:	ff 75 0c             	push   0xc(%ebp)
     a63:	ff 75 08             	push   0x8(%ebp)
     a66:	e8 32 fc ff ff       	call   69d <peek>
     a6b:	83 c4 10             	add    $0x10,%esp
     a6e:	85 c0                	test   %eax,%eax
     a70:	74 16                	je     a88 <parseexec+0x36>
     a72:	83 ec 08             	sub    $0x8,%esp
     a75:	ff 75 0c             	push   0xc(%ebp)
     a78:	ff 75 08             	push   0x8(%ebp)
     a7b:	e8 24 ff ff ff       	call   9a4 <parseblock>
     a80:	83 c4 10             	add    $0x10,%esp
     a83:	e9 fb 00 00 00       	jmp    b83 <parseexec+0x131>

    ret = execcmd();
     a88:	e8 58 f9 ff ff       	call   3e5 <execcmd>
     a8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cmd = (struct execcmd*) ret;
     a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a93:	89 45 ec             	mov    %eax,-0x14(%ebp)

    argc = 0;
     a96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    ret = parseredirs(ret, ps, es);
     a9d:	83 ec 04             	sub    $0x4,%esp
     aa0:	ff 75 0c             	push   0xc(%ebp)
     aa3:	ff 75 08             	push   0x8(%ebp)
     aa6:	ff 75 f0             	push   -0x10(%ebp)
     aa9:	e8 0e fe ff ff       	call   8bc <parseredirs>
     aae:	83 c4 10             	add    $0x10,%esp
     ab1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (!peek(ps, es, "|)&;")) {
     ab4:	e9 87 00 00 00       	jmp    b40 <parseexec+0xee>
        if ((tok = gettoken(ps, es, &q, &eq)) == 0) break;
     ab9:	8d 45 e0             	lea    -0x20(%ebp),%eax
     abc:	50                   	push   %eax
     abd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ac0:	50                   	push   %eax
     ac1:	ff 75 0c             	push   0xc(%ebp)
     ac4:	ff 75 08             	push   0x8(%ebp)
     ac7:	e8 81 fa ff ff       	call   54d <gettoken>
     acc:	83 c4 10             	add    $0x10,%esp
     acf:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ad2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ad6:	0f 84 84 00 00 00    	je     b60 <parseexec+0x10e>
        if (tok != 'a') panic("syntax");
     adc:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     ae0:	74 10                	je     af2 <parseexec+0xa0>
     ae2:	83 ec 0c             	sub    $0xc,%esp
     ae5:	68 b6 2b 00 00       	push   $0x2bb6
     aea:	e8 ad f8 ff ff       	call   39c <panic>
     aef:	83 c4 10             	add    $0x10,%esp
        cmd->argv[argc] = q;
     af2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     af5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     afb:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
        cmd->eargv[argc] = eq;
     aff:	8b 55 e0             	mov    -0x20(%ebp),%edx
     b02:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b05:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     b08:	83 c1 08             	add    $0x8,%ecx
     b0b:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
        argc++;
     b0f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        if (argc >= MAXARGS) panic("too many args");
     b13:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     b17:	7e 10                	jle    b29 <parseexec+0xd7>
     b19:	83 ec 0c             	sub    $0xc,%esp
     b1c:	68 05 2c 00 00       	push   $0x2c05
     b21:	e8 76 f8 ff ff       	call   39c <panic>
     b26:	83 c4 10             	add    $0x10,%esp
        ret = parseredirs(ret, ps, es);
     b29:	83 ec 04             	sub    $0x4,%esp
     b2c:	ff 75 0c             	push   0xc(%ebp)
     b2f:	ff 75 08             	push   0x8(%ebp)
     b32:	ff 75 f0             	push   -0x10(%ebp)
     b35:	e8 82 fd ff ff       	call   8bc <parseredirs>
     b3a:	83 c4 10             	add    $0x10,%esp
     b3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (!peek(ps, es, "|)&;")) {
     b40:	83 ec 04             	sub    $0x4,%esp
     b43:	68 13 2c 00 00       	push   $0x2c13
     b48:	ff 75 0c             	push   0xc(%ebp)
     b4b:	ff 75 08             	push   0x8(%ebp)
     b4e:	e8 4a fb ff ff       	call   69d <peek>
     b53:	83 c4 10             	add    $0x10,%esp
     b56:	85 c0                	test   %eax,%eax
     b58:	0f 84 5b ff ff ff    	je     ab9 <parseexec+0x67>
     b5e:	eb 01                	jmp    b61 <parseexec+0x10f>
        if ((tok = gettoken(ps, es, &q, &eq)) == 0) break;
     b60:	90                   	nop
    }
    cmd->argv[argc] = 0;
     b61:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b64:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b67:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b6e:	00 
    cmd->eargv[argc] = 0;
     b6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b72:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b75:	83 c2 08             	add    $0x8,%edx
     b78:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b7f:	00 
    return ret;
     b80:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b83:	c9                   	leave  
     b84:	c3                   	ret    

00000b85 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd* nulterminate(struct cmd* cmd) {
     b85:	55                   	push   %ebp
     b86:	89 e5                	mov    %esp,%ebp
     b88:	83 ec 28             	sub    $0x28,%esp
    struct execcmd* ecmd;
    struct listcmd* lcmd;
    struct pipecmd* pcmd;
    struct redircmd* rcmd;

    if (cmd == 0) return 0;
     b8b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b8f:	75 0a                	jne    b9b <nulterminate+0x16>
     b91:	b8 00 00 00 00       	mov    $0x0,%eax
     b96:	e9 e4 00 00 00       	jmp    c7f <nulterminate+0xfa>

    switch (cmd->type) {
     b9b:	8b 45 08             	mov    0x8(%ebp),%eax
     b9e:	8b 00                	mov    (%eax),%eax
     ba0:	83 f8 05             	cmp    $0x5,%eax
     ba3:	0f 87 d3 00 00 00    	ja     c7c <nulterminate+0xf7>
     ba9:	8b 04 85 18 2c 00 00 	mov    0x2c18(,%eax,4),%eax
     bb0:	ff e0                	jmp    *%eax
        case EXEC:
            ecmd = (struct execcmd*) cmd;
     bb2:	8b 45 08             	mov    0x8(%ebp),%eax
     bb5:	89 45 e0             	mov    %eax,-0x20(%ebp)
            for (i = 0; ecmd->argv[i]; i++) *ecmd->eargv[i] = 0;
     bb8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bbf:	eb 14                	jmp    bd5 <nulterminate+0x50>
     bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bc4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc7:	83 c2 08             	add    $0x8,%edx
     bca:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bce:	c6 00 00             	movb   $0x0,(%eax)
     bd1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bd8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bdb:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bdf:	85 c0                	test   %eax,%eax
     be1:	75 de                	jne    bc1 <nulterminate+0x3c>
            break;
     be3:	e9 94 00 00 00       	jmp    c7c <nulterminate+0xf7>

        case REDIR:
            rcmd = (struct redircmd*) cmd;
     be8:	8b 45 08             	mov    0x8(%ebp),%eax
     beb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            nulterminate(rcmd->cmd);
     bee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bf1:	8b 40 04             	mov    0x4(%eax),%eax
     bf4:	83 ec 0c             	sub    $0xc,%esp
     bf7:	50                   	push   %eax
     bf8:	e8 88 ff ff ff       	call   b85 <nulterminate>
     bfd:	83 c4 10             	add    $0x10,%esp
            *rcmd->efile = 0;
     c00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c03:	8b 40 0c             	mov    0xc(%eax),%eax
     c06:	c6 00 00             	movb   $0x0,(%eax)
            break;
     c09:	eb 71                	jmp    c7c <nulterminate+0xf7>

        case PIPE:
            pcmd = (struct pipecmd*) cmd;
     c0b:	8b 45 08             	mov    0x8(%ebp),%eax
     c0e:	89 45 e8             	mov    %eax,-0x18(%ebp)
            nulterminate(pcmd->left);
     c11:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c14:	8b 40 04             	mov    0x4(%eax),%eax
     c17:	83 ec 0c             	sub    $0xc,%esp
     c1a:	50                   	push   %eax
     c1b:	e8 65 ff ff ff       	call   b85 <nulterminate>
     c20:	83 c4 10             	add    $0x10,%esp
            nulterminate(pcmd->right);
     c23:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c26:	8b 40 08             	mov    0x8(%eax),%eax
     c29:	83 ec 0c             	sub    $0xc,%esp
     c2c:	50                   	push   %eax
     c2d:	e8 53 ff ff ff       	call   b85 <nulterminate>
     c32:	83 c4 10             	add    $0x10,%esp
            break;
     c35:	eb 45                	jmp    c7c <nulterminate+0xf7>

        case LIST:
            lcmd = (struct listcmd*) cmd;
     c37:	8b 45 08             	mov    0x8(%ebp),%eax
     c3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            nulterminate(lcmd->left);
     c3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c40:	8b 40 04             	mov    0x4(%eax),%eax
     c43:	83 ec 0c             	sub    $0xc,%esp
     c46:	50                   	push   %eax
     c47:	e8 39 ff ff ff       	call   b85 <nulterminate>
     c4c:	83 c4 10             	add    $0x10,%esp
            nulterminate(lcmd->right);
     c4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c52:	8b 40 08             	mov    0x8(%eax),%eax
     c55:	83 ec 0c             	sub    $0xc,%esp
     c58:	50                   	push   %eax
     c59:	e8 27 ff ff ff       	call   b85 <nulterminate>
     c5e:	83 c4 10             	add    $0x10,%esp
            break;
     c61:	eb 19                	jmp    c7c <nulterminate+0xf7>

        case BACK:
            bcmd = (struct backcmd*) cmd;
     c63:	8b 45 08             	mov    0x8(%ebp),%eax
     c66:	89 45 f0             	mov    %eax,-0x10(%ebp)
            nulterminate(bcmd->cmd);
     c69:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c6c:	8b 40 04             	mov    0x4(%eax),%eax
     c6f:	83 ec 0c             	sub    $0xc,%esp
     c72:	50                   	push   %eax
     c73:	e8 0d ff ff ff       	call   b85 <nulterminate>
     c78:	83 c4 10             	add    $0x10,%esp
            break;
     c7b:	90                   	nop
    }
    return cmd;
     c7c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c7f:	c9                   	leave  
     c80:	c3                   	ret    

00000c81 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     c81:	b8 01 00 00 00       	mov    $0x1,%eax
     c86:	cd 40                	int    $0x40
     c88:	c3                   	ret    

00000c89 <exit>:
SYSCALL(exit)
     c89:	b8 02 00 00 00       	mov    $0x2,%eax
     c8e:	cd 40                	int    $0x40
     c90:	c3                   	ret    

00000c91 <wait>:
SYSCALL(wait)
     c91:	b8 03 00 00 00       	mov    $0x3,%eax
     c96:	cd 40                	int    $0x40
     c98:	c3                   	ret    

00000c99 <pipe>:
SYSCALL(pipe)
     c99:	b8 04 00 00 00       	mov    $0x4,%eax
     c9e:	cd 40                	int    $0x40
     ca0:	c3                   	ret    

00000ca1 <read>:
SYSCALL(read)
     ca1:	b8 05 00 00 00       	mov    $0x5,%eax
     ca6:	cd 40                	int    $0x40
     ca8:	c3                   	ret    

00000ca9 <write>:
SYSCALL(write)
     ca9:	b8 10 00 00 00       	mov    $0x10,%eax
     cae:	cd 40                	int    $0x40
     cb0:	c3                   	ret    

00000cb1 <close>:
SYSCALL(close)
     cb1:	b8 15 00 00 00       	mov    $0x15,%eax
     cb6:	cd 40                	int    $0x40
     cb8:	c3                   	ret    

00000cb9 <kill>:
SYSCALL(kill)
     cb9:	b8 06 00 00 00       	mov    $0x6,%eax
     cbe:	cd 40                	int    $0x40
     cc0:	c3                   	ret    

00000cc1 <exec>:
SYSCALL(exec)
     cc1:	b8 07 00 00 00       	mov    $0x7,%eax
     cc6:	cd 40                	int    $0x40
     cc8:	c3                   	ret    

00000cc9 <open>:
SYSCALL(open)
     cc9:	b8 0f 00 00 00       	mov    $0xf,%eax
     cce:	cd 40                	int    $0x40
     cd0:	c3                   	ret    

00000cd1 <mknod>:
SYSCALL(mknod)
     cd1:	b8 11 00 00 00       	mov    $0x11,%eax
     cd6:	cd 40                	int    $0x40
     cd8:	c3                   	ret    

00000cd9 <unlink>:
SYSCALL(unlink)
     cd9:	b8 12 00 00 00       	mov    $0x12,%eax
     cde:	cd 40                	int    $0x40
     ce0:	c3                   	ret    

00000ce1 <fstat>:
SYSCALL(fstat)
     ce1:	b8 08 00 00 00       	mov    $0x8,%eax
     ce6:	cd 40                	int    $0x40
     ce8:	c3                   	ret    

00000ce9 <link>:
SYSCALL(link)
     ce9:	b8 13 00 00 00       	mov    $0x13,%eax
     cee:	cd 40                	int    $0x40
     cf0:	c3                   	ret    

00000cf1 <mkdir>:
SYSCALL(mkdir)
     cf1:	b8 14 00 00 00       	mov    $0x14,%eax
     cf6:	cd 40                	int    $0x40
     cf8:	c3                   	ret    

00000cf9 <chdir>:
SYSCALL(chdir)
     cf9:	b8 09 00 00 00       	mov    $0x9,%eax
     cfe:	cd 40                	int    $0x40
     d00:	c3                   	ret    

00000d01 <dup>:
SYSCALL(dup)
     d01:	b8 0a 00 00 00       	mov    $0xa,%eax
     d06:	cd 40                	int    $0x40
     d08:	c3                   	ret    

00000d09 <getpid>:
SYSCALL(getpid)
     d09:	b8 0b 00 00 00       	mov    $0xb,%eax
     d0e:	cd 40                	int    $0x40
     d10:	c3                   	ret    

00000d11 <sbrk>:
SYSCALL(sbrk)
     d11:	b8 0c 00 00 00       	mov    $0xc,%eax
     d16:	cd 40                	int    $0x40
     d18:	c3                   	ret    

00000d19 <sleep>:
SYSCALL(sleep)
     d19:	b8 0d 00 00 00       	mov    $0xd,%eax
     d1e:	cd 40                	int    $0x40
     d20:	c3                   	ret    

00000d21 <uptime>:
SYSCALL(uptime)
     d21:	b8 0e 00 00 00       	mov    $0xe,%eax
     d26:	cd 40                	int    $0x40
     d28:	c3                   	ret    

00000d29 <setuid>:
SYSCALL(setuid)
     d29:	b8 16 00 00 00       	mov    $0x16,%eax
     d2e:	cd 40                	int    $0x40
     d30:	c3                   	ret    

00000d31 <getuid>:
SYSCALL(getuid)
     d31:	b8 19 00 00 00       	mov    $0x19,%eax
     d36:	cd 40                	int    $0x40
     d38:	c3                   	ret    

00000d39 <chown>:
SYSCALL(chown)
     d39:	b8 18 00 00 00       	mov    $0x18,%eax
     d3e:	cd 40                	int    $0x40
     d40:	c3                   	ret    

00000d41 <chmod>:
SYSCALL(chmod)
     d41:	b8 17 00 00 00       	mov    $0x17,%eax
     d46:	cd 40                	int    $0x40
     d48:	c3                   	ret    

00000d49 <report_stats>:
SYSCALL(report_stats)
     d49:	b8 1a 00 00 00       	mov    $0x1a,%eax
     d4e:	cd 40                	int    $0x40
     d50:	c3                   	ret    

00000d51 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     d51:	55                   	push   %ebp
     d52:	89 e5                	mov    %esp,%ebp
     d54:	57                   	push   %edi
     d55:	53                   	push   %ebx
  __asm__ volatile("cld; rep stosb" :
     d56:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d59:	8b 55 10             	mov    0x10(%ebp),%edx
     d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5f:	89 cb                	mov    %ecx,%ebx
     d61:	89 df                	mov    %ebx,%edi
     d63:	89 d1                	mov    %edx,%ecx
     d65:	fc                   	cld    
     d66:	f3 aa                	rep stos %al,%es:(%edi)
     d68:	89 ca                	mov    %ecx,%edx
     d6a:	89 fb                	mov    %edi,%ebx
     d6c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     d6f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     d72:	90                   	nop
     d73:	5b                   	pop    %ebx
     d74:	5f                   	pop    %edi
     d75:	5d                   	pop    %ebp
     d76:	c3                   	ret    

00000d77 <strcpy>:
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "asm/x86.h"

char* strcpy(char* s, const char* t) {
     d77:	55                   	push   %ebp
     d78:	89 e5                	mov    %esp,%ebp
     d7a:	83 ec 10             	sub    $0x10,%esp
    char* os;

    os = s;
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
     d80:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while ((*s++ = *t++) != 0)
     d83:	90                   	nop
     d84:	8b 55 0c             	mov    0xc(%ebp),%edx
     d87:	8d 42 01             	lea    0x1(%edx),%eax
     d8a:	89 45 0c             	mov    %eax,0xc(%ebp)
     d8d:	8b 45 08             	mov    0x8(%ebp),%eax
     d90:	8d 48 01             	lea    0x1(%eax),%ecx
     d93:	89 4d 08             	mov    %ecx,0x8(%ebp)
     d96:	0f b6 12             	movzbl (%edx),%edx
     d99:	88 10                	mov    %dl,(%eax)
     d9b:	0f b6 00             	movzbl (%eax),%eax
     d9e:	84 c0                	test   %al,%al
     da0:	75 e2                	jne    d84 <strcpy+0xd>
        ;
    return os;
     da2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     da5:	c9                   	leave  
     da6:	c3                   	ret    

00000da7 <strcmp>:

int strcmp(const char* p, const char* q) {
     da7:	55                   	push   %ebp
     da8:	89 e5                	mov    %esp,%ebp
    while (*p && *p == *q) p++, q++;
     daa:	eb 08                	jmp    db4 <strcmp+0xd>
     dac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     db0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     db4:	8b 45 08             	mov    0x8(%ebp),%eax
     db7:	0f b6 00             	movzbl (%eax),%eax
     dba:	84 c0                	test   %al,%al
     dbc:	74 10                	je     dce <strcmp+0x27>
     dbe:	8b 45 08             	mov    0x8(%ebp),%eax
     dc1:	0f b6 10             	movzbl (%eax),%edx
     dc4:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc7:	0f b6 00             	movzbl (%eax),%eax
     dca:	38 c2                	cmp    %al,%dl
     dcc:	74 de                	je     dac <strcmp+0x5>
    return (uchar) *p - (uchar) *q;
     dce:	8b 45 08             	mov    0x8(%ebp),%eax
     dd1:	0f b6 00             	movzbl (%eax),%eax
     dd4:	0f b6 d0             	movzbl %al,%edx
     dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
     dda:	0f b6 00             	movzbl (%eax),%eax
     ddd:	0f b6 c8             	movzbl %al,%ecx
     de0:	89 d0                	mov    %edx,%eax
     de2:	29 c8                	sub    %ecx,%eax
}
     de4:	5d                   	pop    %ebp
     de5:	c3                   	ret    

00000de6 <strlen>:

uint strlen(const char* s) {
     de6:	55                   	push   %ebp
     de7:	89 e5                	mov    %esp,%ebp
     de9:	83 ec 10             	sub    $0x10,%esp
    int n;

    for (n = 0; s[n]; n++)
     dec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     df3:	eb 04                	jmp    df9 <strlen+0x13>
     df5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     df9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     dfc:	8b 45 08             	mov    0x8(%ebp),%eax
     dff:	01 d0                	add    %edx,%eax
     e01:	0f b6 00             	movzbl (%eax),%eax
     e04:	84 c0                	test   %al,%al
     e06:	75 ed                	jne    df5 <strlen+0xf>
        ;
    return n;
     e08:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e0b:	c9                   	leave  
     e0c:	c3                   	ret    

00000e0d <memset>:

void* memset(void* dst, int c, uint n) {
     e0d:	55                   	push   %ebp
     e0e:	89 e5                	mov    %esp,%ebp
    stosb(dst, c, n);
     e10:	8b 45 10             	mov    0x10(%ebp),%eax
     e13:	50                   	push   %eax
     e14:	ff 75 0c             	push   0xc(%ebp)
     e17:	ff 75 08             	push   0x8(%ebp)
     e1a:	e8 32 ff ff ff       	call   d51 <stosb>
     e1f:	83 c4 0c             	add    $0xc,%esp
    return dst;
     e22:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e25:	c9                   	leave  
     e26:	c3                   	ret    

00000e27 <strchr>:

char* strchr(const char* s, char c) {
     e27:	55                   	push   %ebp
     e28:	89 e5                	mov    %esp,%ebp
     e2a:	83 ec 04             	sub    $0x4,%esp
     e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e30:	88 45 fc             	mov    %al,-0x4(%ebp)
    for (; *s; s++)
     e33:	eb 14                	jmp    e49 <strchr+0x22>
        if (*s == c) return (char*) s;
     e35:	8b 45 08             	mov    0x8(%ebp),%eax
     e38:	0f b6 00             	movzbl (%eax),%eax
     e3b:	38 45 fc             	cmp    %al,-0x4(%ebp)
     e3e:	75 05                	jne    e45 <strchr+0x1e>
     e40:	8b 45 08             	mov    0x8(%ebp),%eax
     e43:	eb 13                	jmp    e58 <strchr+0x31>
    for (; *s; s++)
     e45:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e49:	8b 45 08             	mov    0x8(%ebp),%eax
     e4c:	0f b6 00             	movzbl (%eax),%eax
     e4f:	84 c0                	test   %al,%al
     e51:	75 e2                	jne    e35 <strchr+0xe>
    return 0;
     e53:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e58:	c9                   	leave  
     e59:	c3                   	ret    

00000e5a <gets>:

char* gets(char* buf, int max) {
     e5a:	55                   	push   %ebp
     e5b:	89 e5                	mov    %esp,%ebp
     e5d:	83 ec 18             	sub    $0x18,%esp
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
     e60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e67:	eb 42                	jmp    eab <gets+0x51>
        cc = read(0, &c, 1);
     e69:	83 ec 04             	sub    $0x4,%esp
     e6c:	6a 01                	push   $0x1
     e6e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     e71:	50                   	push   %eax
     e72:	6a 00                	push   $0x0
     e74:	e8 28 fe ff ff       	call   ca1 <read>
     e79:	83 c4 10             	add    $0x10,%esp
     e7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (cc < 1) break;
     e7f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e83:	7e 33                	jle    eb8 <gets+0x5e>
        buf[i++] = c;
     e85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e88:	8d 50 01             	lea    0x1(%eax),%edx
     e8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     e8e:	89 c2                	mov    %eax,%edx
     e90:	8b 45 08             	mov    0x8(%ebp),%eax
     e93:	01 c2                	add    %eax,%edx
     e95:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e99:	88 02                	mov    %al,(%edx)
        if (c == '\n' || c == '\r') break;
     e9b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e9f:	3c 0a                	cmp    $0xa,%al
     ea1:	74 16                	je     eb9 <gets+0x5f>
     ea3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     ea7:	3c 0d                	cmp    $0xd,%al
     ea9:	74 0e                	je     eb9 <gets+0x5f>
    for (i = 0; i + 1 < max;) {
     eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eae:	83 c0 01             	add    $0x1,%eax
     eb1:	39 45 0c             	cmp    %eax,0xc(%ebp)
     eb4:	7f b3                	jg     e69 <gets+0xf>
     eb6:	eb 01                	jmp    eb9 <gets+0x5f>
        if (cc < 1) break;
     eb8:	90                   	nop
    }
    buf[i] = '\0';
     eb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ebc:	8b 45 08             	mov    0x8(%ebp),%eax
     ebf:	01 d0                	add    %edx,%eax
     ec1:	c6 00 00             	movb   $0x0,(%eax)
    return buf;
     ec4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ec7:	c9                   	leave  
     ec8:	c3                   	ret    

00000ec9 <stat>:

int stat(const char* n, struct stat* st) {
     ec9:	55                   	push   %ebp
     eca:	89 e5                	mov    %esp,%ebp
     ecc:	83 ec 18             	sub    $0x18,%esp
    int fd;
    int r;

    fd = open(n, O_RDONLY);
     ecf:	83 ec 08             	sub    $0x8,%esp
     ed2:	6a 01                	push   $0x1
     ed4:	ff 75 08             	push   0x8(%ebp)
     ed7:	e8 ed fd ff ff       	call   cc9 <open>
     edc:	83 c4 10             	add    $0x10,%esp
     edf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fd < 0) return -1;
     ee2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ee6:	79 07                	jns    eef <stat+0x26>
     ee8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     eed:	eb 25                	jmp    f14 <stat+0x4b>
    r = fstat(fd, st);
     eef:	83 ec 08             	sub    $0x8,%esp
     ef2:	ff 75 0c             	push   0xc(%ebp)
     ef5:	ff 75 f4             	push   -0xc(%ebp)
     ef8:	e8 e4 fd ff ff       	call   ce1 <fstat>
     efd:	83 c4 10             	add    $0x10,%esp
     f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     f03:	83 ec 0c             	sub    $0xc,%esp
     f06:	ff 75 f4             	push   -0xc(%ebp)
     f09:	e8 a3 fd ff ff       	call   cb1 <close>
     f0e:	83 c4 10             	add    $0x10,%esp
    return r;
     f11:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f14:	c9                   	leave  
     f15:	c3                   	ret    

00000f16 <atoi>:

int atoi(const char* s) {
     f16:	55                   	push   %ebp
     f17:	89 e5                	mov    %esp,%ebp
     f19:	83 ec 10             	sub    $0x10,%esp
    int n;

    n = 0;
     f1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
     f23:	eb 25                	jmp    f4a <atoi+0x34>
     f25:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f28:	89 d0                	mov    %edx,%eax
     f2a:	c1 e0 02             	shl    $0x2,%eax
     f2d:	01 d0                	add    %edx,%eax
     f2f:	01 c0                	add    %eax,%eax
     f31:	89 c1                	mov    %eax,%ecx
     f33:	8b 45 08             	mov    0x8(%ebp),%eax
     f36:	8d 50 01             	lea    0x1(%eax),%edx
     f39:	89 55 08             	mov    %edx,0x8(%ebp)
     f3c:	0f b6 00             	movzbl (%eax),%eax
     f3f:	0f be c0             	movsbl %al,%eax
     f42:	01 c8                	add    %ecx,%eax
     f44:	83 e8 30             	sub    $0x30,%eax
     f47:	89 45 fc             	mov    %eax,-0x4(%ebp)
     f4a:	8b 45 08             	mov    0x8(%ebp),%eax
     f4d:	0f b6 00             	movzbl (%eax),%eax
     f50:	3c 2f                	cmp    $0x2f,%al
     f52:	7e 0a                	jle    f5e <atoi+0x48>
     f54:	8b 45 08             	mov    0x8(%ebp),%eax
     f57:	0f b6 00             	movzbl (%eax),%eax
     f5a:	3c 39                	cmp    $0x39,%al
     f5c:	7e c7                	jle    f25 <atoi+0xf>
    return n;
     f5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     f61:	c9                   	leave  
     f62:	c3                   	ret    

00000f63 <memmove>:

void* memmove(void* vdst, const void* vsrc, int n) {
     f63:	55                   	push   %ebp
     f64:	89 e5                	mov    %esp,%ebp
     f66:	83 ec 10             	sub    $0x10,%esp
    char* dst;
    const char* src;

    dst = vdst;
     f69:	8b 45 08             	mov    0x8(%ebp),%eax
     f6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    src = vsrc;
     f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f72:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n-- > 0) *dst++ = *src++;
     f75:	eb 17                	jmp    f8e <memmove+0x2b>
     f77:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f7a:	8d 42 01             	lea    0x1(%edx),%eax
     f7d:	89 45 f8             	mov    %eax,-0x8(%ebp)
     f80:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f83:	8d 48 01             	lea    0x1(%eax),%ecx
     f86:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     f89:	0f b6 12             	movzbl (%edx),%edx
     f8c:	88 10                	mov    %dl,(%eax)
     f8e:	8b 45 10             	mov    0x10(%ebp),%eax
     f91:	8d 50 ff             	lea    -0x1(%eax),%edx
     f94:	89 55 10             	mov    %edx,0x10(%ebp)
     f97:	85 c0                	test   %eax,%eax
     f99:	7f dc                	jg     f77 <memmove+0x14>
    return vdst;
     f9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f9e:	c9                   	leave  
     f9f:	c3                   	ret    

00000fa0 <free>:
typedef union header Header;

static Header base;
static Header* freep;

void free(void* ap) {
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	83 ec 10             	sub    $0x10,%esp
    Header *bp, *p;

    bp = (Header*) ap - 1;
     fa6:	8b 45 08             	mov    0x8(%ebp),%eax
     fa9:	83 e8 08             	sub    $0x8,%eax
     fac:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     faf:	a1 ec 38 00 00       	mov    0x38ec,%eax
     fb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
     fb7:	eb 24                	jmp    fdd <free+0x3d>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
     fb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fbc:	8b 00                	mov    (%eax),%eax
     fbe:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     fc1:	72 12                	jb     fd5 <free+0x35>
     fc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fc6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fc9:	77 24                	ja     fef <free+0x4f>
     fcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fce:	8b 00                	mov    (%eax),%eax
     fd0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     fd3:	72 1a                	jb     fef <free+0x4f>
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fd8:	8b 00                	mov    (%eax),%eax
     fda:	89 45 fc             	mov    %eax,-0x4(%ebp)
     fdd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fe0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fe3:	76 d4                	jbe    fb9 <free+0x19>
     fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fe8:	8b 00                	mov    (%eax),%eax
     fea:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     fed:	73 ca                	jae    fb9 <free+0x19>
    if (bp + bp->s.size == p->s.ptr) {
     fef:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ff2:	8b 40 04             	mov    0x4(%eax),%eax
     ff5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     ffc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fff:	01 c2                	add    %eax,%edx
    1001:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1004:	8b 00                	mov    (%eax),%eax
    1006:	39 c2                	cmp    %eax,%edx
    1008:	75 24                	jne    102e <free+0x8e>
        bp->s.size += p->s.ptr->s.size;
    100a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    100d:	8b 50 04             	mov    0x4(%eax),%edx
    1010:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1013:	8b 00                	mov    (%eax),%eax
    1015:	8b 40 04             	mov    0x4(%eax),%eax
    1018:	01 c2                	add    %eax,%edx
    101a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    101d:	89 50 04             	mov    %edx,0x4(%eax)
        bp->s.ptr = p->s.ptr->s.ptr;
    1020:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1023:	8b 00                	mov    (%eax),%eax
    1025:	8b 10                	mov    (%eax),%edx
    1027:	8b 45 f8             	mov    -0x8(%ebp),%eax
    102a:	89 10                	mov    %edx,(%eax)
    102c:	eb 0a                	jmp    1038 <free+0x98>
    } else
        bp->s.ptr = p->s.ptr;
    102e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1031:	8b 10                	mov    (%eax),%edx
    1033:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1036:	89 10                	mov    %edx,(%eax)
    if (p + p->s.size == bp) {
    1038:	8b 45 fc             	mov    -0x4(%ebp),%eax
    103b:	8b 40 04             	mov    0x4(%eax),%eax
    103e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1045:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1048:	01 d0                	add    %edx,%eax
    104a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    104d:	75 20                	jne    106f <free+0xcf>
        p->s.size += bp->s.size;
    104f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1052:	8b 50 04             	mov    0x4(%eax),%edx
    1055:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1058:	8b 40 04             	mov    0x4(%eax),%eax
    105b:	01 c2                	add    %eax,%edx
    105d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1060:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
    1063:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1066:	8b 10                	mov    (%eax),%edx
    1068:	8b 45 fc             	mov    -0x4(%ebp),%eax
    106b:	89 10                	mov    %edx,(%eax)
    106d:	eb 08                	jmp    1077 <free+0xd7>
    } else
        p->s.ptr = bp;
    106f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1072:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1075:	89 10                	mov    %edx,(%eax)
    freep = p;
    1077:	8b 45 fc             	mov    -0x4(%ebp),%eax
    107a:	a3 ec 38 00 00       	mov    %eax,0x38ec
}
    107f:	90                   	nop
    1080:	c9                   	leave  
    1081:	c3                   	ret    

00001082 <morecore>:

static Header* morecore(uint nu) {
    1082:	55                   	push   %ebp
    1083:	89 e5                	mov    %esp,%ebp
    1085:	83 ec 18             	sub    $0x18,%esp
    char* p;
    Header* hp;

    if (nu < 4096) nu = 4096;
    1088:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    108f:	77 07                	ja     1098 <morecore+0x16>
    1091:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    p = sbrk(nu * sizeof(Header));
    1098:	8b 45 08             	mov    0x8(%ebp),%eax
    109b:	c1 e0 03             	shl    $0x3,%eax
    109e:	83 ec 0c             	sub    $0xc,%esp
    10a1:	50                   	push   %eax
    10a2:	e8 6a fc ff ff       	call   d11 <sbrk>
    10a7:	83 c4 10             	add    $0x10,%esp
    10aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == (char*) -1) return 0;
    10ad:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    10b1:	75 07                	jne    10ba <morecore+0x38>
    10b3:	b8 00 00 00 00       	mov    $0x0,%eax
    10b8:	eb 26                	jmp    10e0 <morecore+0x5e>
    hp = (Header*) p;
    10ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    hp->s.size = nu;
    10c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10c3:	8b 55 08             	mov    0x8(%ebp),%edx
    10c6:	89 50 04             	mov    %edx,0x4(%eax)
    free((void*) (hp + 1));
    10c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10cc:	83 c0 08             	add    $0x8,%eax
    10cf:	83 ec 0c             	sub    $0xc,%esp
    10d2:	50                   	push   %eax
    10d3:	e8 c8 fe ff ff       	call   fa0 <free>
    10d8:	83 c4 10             	add    $0x10,%esp
    return freep;
    10db:	a1 ec 38 00 00       	mov    0x38ec,%eax
}
    10e0:	c9                   	leave  
    10e1:	c3                   	ret    

000010e2 <malloc>:

void* malloc(uint nbytes) {
    10e2:	55                   	push   %ebp
    10e3:	89 e5                	mov    %esp,%ebp
    10e5:	83 ec 18             	sub    $0x18,%esp
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    10e8:	8b 45 08             	mov    0x8(%ebp),%eax
    10eb:	83 c0 07             	add    $0x7,%eax
    10ee:	c1 e8 03             	shr    $0x3,%eax
    10f1:	83 c0 01             	add    $0x1,%eax
    10f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if ((prevp = freep) == 0) {
    10f7:	a1 ec 38 00 00       	mov    0x38ec,%eax
    10fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1103:	75 23                	jne    1128 <malloc+0x46>
        base.s.ptr = freep = prevp = &base;
    1105:	c7 45 f0 e4 38 00 00 	movl   $0x38e4,-0x10(%ebp)
    110c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    110f:	a3 ec 38 00 00       	mov    %eax,0x38ec
    1114:	a1 ec 38 00 00       	mov    0x38ec,%eax
    1119:	a3 e4 38 00 00       	mov    %eax,0x38e4
        base.s.size = 0;
    111e:	c7 05 e8 38 00 00 00 	movl   $0x0,0x38e8
    1125:	00 00 00 
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    1128:	8b 45 f0             	mov    -0x10(%ebp),%eax
    112b:	8b 00                	mov    (%eax),%eax
    112d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
    1130:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1133:	8b 40 04             	mov    0x4(%eax),%eax
    1136:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1139:	77 4d                	ja     1188 <malloc+0xa6>
            if (p->s.size == nunits)
    113b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    113e:	8b 40 04             	mov    0x4(%eax),%eax
    1141:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1144:	75 0c                	jne    1152 <malloc+0x70>
                prevp->s.ptr = p->s.ptr;
    1146:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1149:	8b 10                	mov    (%eax),%edx
    114b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    114e:	89 10                	mov    %edx,(%eax)
    1150:	eb 26                	jmp    1178 <malloc+0x96>
            else {
                p->s.size -= nunits;
    1152:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1155:	8b 40 04             	mov    0x4(%eax),%eax
    1158:	2b 45 ec             	sub    -0x14(%ebp),%eax
    115b:	89 c2                	mov    %eax,%edx
    115d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1160:	89 50 04             	mov    %edx,0x4(%eax)
                p += p->s.size;
    1163:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1166:	8b 40 04             	mov    0x4(%eax),%eax
    1169:	c1 e0 03             	shl    $0x3,%eax
    116c:	01 45 f4             	add    %eax,-0xc(%ebp)
                p->s.size = nunits;
    116f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1172:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1175:	89 50 04             	mov    %edx,0x4(%eax)
            }
            freep = prevp;
    1178:	8b 45 f0             	mov    -0x10(%ebp),%eax
    117b:	a3 ec 38 00 00       	mov    %eax,0x38ec
            return (void*) (p + 1);
    1180:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1183:	83 c0 08             	add    $0x8,%eax
    1186:	eb 3b                	jmp    11c3 <malloc+0xe1>
        }
        if (p == freep)
    1188:	a1 ec 38 00 00       	mov    0x38ec,%eax
    118d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1190:	75 1e                	jne    11b0 <malloc+0xce>
            if ((p = morecore(nunits)) == 0) return 0;
    1192:	83 ec 0c             	sub    $0xc,%esp
    1195:	ff 75 ec             	push   -0x14(%ebp)
    1198:	e8 e5 fe ff ff       	call   1082 <morecore>
    119d:	83 c4 10             	add    $0x10,%esp
    11a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    11a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11a7:	75 07                	jne    11b0 <malloc+0xce>
    11a9:	b8 00 00 00 00       	mov    $0x0,%eax
    11ae:	eb 13                	jmp    11c3 <malloc+0xe1>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    11b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    11b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b9:	8b 00                	mov    (%eax),%eax
    11bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p->s.size >= nunits) {
    11be:	e9 6d ff ff ff       	jmp    1130 <malloc+0x4e>
    }
}
    11c3:	c9                   	leave  
    11c4:	c3                   	ret    

000011c5 <putc>:
#include "types.h"
#include "stat.h"
#include "user.h"

static void putc(int fd, char c) { write(fd, &c, 1); }
    11c5:	55                   	push   %ebp
    11c6:	89 e5                	mov    %esp,%ebp
    11c8:	83 ec 18             	sub    $0x18,%esp
    11cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ce:	88 45 f4             	mov    %al,-0xc(%ebp)
    11d1:	83 ec 04             	sub    $0x4,%esp
    11d4:	6a 01                	push   $0x1
    11d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    11d9:	50                   	push   %eax
    11da:	ff 75 08             	push   0x8(%ebp)
    11dd:	e8 c7 fa ff ff       	call   ca9 <write>
    11e2:	83 c4 10             	add    $0x10,%esp
    11e5:	90                   	nop
    11e6:	c9                   	leave  
    11e7:	c3                   	ret    

000011e8 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
    11e8:	55                   	push   %ebp
    11e9:	89 e5                	mov    %esp,%ebp
    11eb:	83 ec 28             	sub    $0x28,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    11ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (sgn && xx < 0) {
    11f5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    11f9:	74 17                	je     1212 <printint+0x2a>
    11fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11ff:	79 11                	jns    1212 <printint+0x2a>
        neg = 1;
    1201:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        x = -xx;
    1208:	8b 45 0c             	mov    0xc(%ebp),%eax
    120b:	f7 d8                	neg    %eax
    120d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1210:	eb 06                	jmp    1218 <printint+0x30>
    } else {
        x = xx;
    1212:	8b 45 0c             	mov    0xc(%ebp),%eax
    1215:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    i = 0;
    1218:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    do {
        buf[i++] = digits[x % base];
    121f:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1222:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1225:	ba 00 00 00 00       	mov    $0x0,%edx
    122a:	f7 f1                	div    %ecx
    122c:	89 d1                	mov    %edx,%ecx
    122e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1231:	8d 50 01             	lea    0x1(%eax),%edx
    1234:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1237:	0f b6 91 54 38 00 00 	movzbl 0x3854(%ecx),%edx
    123e:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
    } while ((x /= base) != 0);
    1242:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1245:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1248:	ba 00 00 00 00       	mov    $0x0,%edx
    124d:	f7 f1                	div    %ecx
    124f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1252:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1256:	75 c7                	jne    121f <printint+0x37>
    if (neg) buf[i++] = '-';
    1258:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    125c:	74 2d                	je     128b <printint+0xa3>
    125e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1261:	8d 50 01             	lea    0x1(%eax),%edx
    1264:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1267:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

    while (--i >= 0) putc(fd, buf[i]);
    126c:	eb 1d                	jmp    128b <printint+0xa3>
    126e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1271:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1274:	01 d0                	add    %edx,%eax
    1276:	0f b6 00             	movzbl (%eax),%eax
    1279:	0f be c0             	movsbl %al,%eax
    127c:	83 ec 08             	sub    $0x8,%esp
    127f:	50                   	push   %eax
    1280:	ff 75 08             	push   0x8(%ebp)
    1283:	e8 3d ff ff ff       	call   11c5 <putc>
    1288:	83 c4 10             	add    $0x10,%esp
    128b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    128f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1293:	79 d9                	jns    126e <printint+0x86>
}
    1295:	90                   	nop
    1296:	90                   	nop
    1297:	c9                   	leave  
    1298:	c3                   	ret    

00001299 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void printf(int fd, const char* fmt, ...) {
    1299:	55                   	push   %ebp
    129a:	89 e5                	mov    %esp,%ebp
    129c:	83 ec 28             	sub    $0x28,%esp
    char* s;
    int c, i, state;
    uint* ap;

    state = 0;
    129f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ap = (uint*) (void*) &fmt + 1;
    12a6:	8d 45 0c             	lea    0xc(%ebp),%eax
    12a9:	83 c0 04             	add    $0x4,%eax
    12ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (i = 0; fmt[i]; i++) {
    12af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12b6:	e9 59 01 00 00       	jmp    1414 <printf+0x17b>
        c = fmt[i] & 0xff;
    12bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    12be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c1:	01 d0                	add    %edx,%eax
    12c3:	0f b6 00             	movzbl (%eax),%eax
    12c6:	0f be c0             	movsbl %al,%eax
    12c9:	25 ff 00 00 00       	and    $0xff,%eax
    12ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (state == 0) {
    12d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12d5:	75 2c                	jne    1303 <printf+0x6a>
            if (c == '%') {
    12d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    12db:	75 0c                	jne    12e9 <printf+0x50>
                state = '%';
    12dd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    12e4:	e9 27 01 00 00       	jmp    1410 <printf+0x177>
            } else {
                putc(fd, c);
    12e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12ec:	0f be c0             	movsbl %al,%eax
    12ef:	83 ec 08             	sub    $0x8,%esp
    12f2:	50                   	push   %eax
    12f3:	ff 75 08             	push   0x8(%ebp)
    12f6:	e8 ca fe ff ff       	call   11c5 <putc>
    12fb:	83 c4 10             	add    $0x10,%esp
    12fe:	e9 0d 01 00 00       	jmp    1410 <printf+0x177>
            }
        } else if (state == '%') {
    1303:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1307:	0f 85 03 01 00 00    	jne    1410 <printf+0x177>
            if (c == 'd') {
    130d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1311:	75 1e                	jne    1331 <printf+0x98>
                printint(fd, *ap, 10, 1);
    1313:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1316:	8b 00                	mov    (%eax),%eax
    1318:	6a 01                	push   $0x1
    131a:	6a 0a                	push   $0xa
    131c:	50                   	push   %eax
    131d:	ff 75 08             	push   0x8(%ebp)
    1320:	e8 c3 fe ff ff       	call   11e8 <printint>
    1325:	83 c4 10             	add    $0x10,%esp
                ap++;
    1328:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    132c:	e9 d8 00 00 00       	jmp    1409 <printf+0x170>
            } else if (c == 'x' || c == 'p') {
    1331:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1335:	74 06                	je     133d <printf+0xa4>
    1337:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    133b:	75 1e                	jne    135b <printf+0xc2>
                printint(fd, *ap, 16, 0);
    133d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1340:	8b 00                	mov    (%eax),%eax
    1342:	6a 00                	push   $0x0
    1344:	6a 10                	push   $0x10
    1346:	50                   	push   %eax
    1347:	ff 75 08             	push   0x8(%ebp)
    134a:	e8 99 fe ff ff       	call   11e8 <printint>
    134f:	83 c4 10             	add    $0x10,%esp
                ap++;
    1352:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1356:	e9 ae 00 00 00       	jmp    1409 <printf+0x170>
            } else if (c == 's') {
    135b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    135f:	75 43                	jne    13a4 <printf+0x10b>
                s = (char*) *ap;
    1361:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1364:	8b 00                	mov    (%eax),%eax
    1366:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1369:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
                if (s == 0) s = "(null)";
    136d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1371:	75 25                	jne    1398 <printf+0xff>
    1373:	c7 45 f4 30 2c 00 00 	movl   $0x2c30,-0xc(%ebp)
                while (*s != 0) {
    137a:	eb 1c                	jmp    1398 <printf+0xff>
                    putc(fd, *s);
    137c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    137f:	0f b6 00             	movzbl (%eax),%eax
    1382:	0f be c0             	movsbl %al,%eax
    1385:	83 ec 08             	sub    $0x8,%esp
    1388:	50                   	push   %eax
    1389:	ff 75 08             	push   0x8(%ebp)
    138c:	e8 34 fe ff ff       	call   11c5 <putc>
    1391:	83 c4 10             	add    $0x10,%esp
                    s++;
    1394:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                while (*s != 0) {
    1398:	8b 45 f4             	mov    -0xc(%ebp),%eax
    139b:	0f b6 00             	movzbl (%eax),%eax
    139e:	84 c0                	test   %al,%al
    13a0:	75 da                	jne    137c <printf+0xe3>
    13a2:	eb 65                	jmp    1409 <printf+0x170>
                }
            } else if (c == 'c') {
    13a4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    13a8:	75 1d                	jne    13c7 <printf+0x12e>
                putc(fd, *ap);
    13aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13ad:	8b 00                	mov    (%eax),%eax
    13af:	0f be c0             	movsbl %al,%eax
    13b2:	83 ec 08             	sub    $0x8,%esp
    13b5:	50                   	push   %eax
    13b6:	ff 75 08             	push   0x8(%ebp)
    13b9:	e8 07 fe ff ff       	call   11c5 <putc>
    13be:	83 c4 10             	add    $0x10,%esp
                ap++;
    13c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13c5:	eb 42                	jmp    1409 <printf+0x170>
            } else if (c == '%') {
    13c7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    13cb:	75 17                	jne    13e4 <printf+0x14b>
                putc(fd, c);
    13cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13d0:	0f be c0             	movsbl %al,%eax
    13d3:	83 ec 08             	sub    $0x8,%esp
    13d6:	50                   	push   %eax
    13d7:	ff 75 08             	push   0x8(%ebp)
    13da:	e8 e6 fd ff ff       	call   11c5 <putc>
    13df:	83 c4 10             	add    $0x10,%esp
    13e2:	eb 25                	jmp    1409 <printf+0x170>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
    13e4:	83 ec 08             	sub    $0x8,%esp
    13e7:	6a 25                	push   $0x25
    13e9:	ff 75 08             	push   0x8(%ebp)
    13ec:	e8 d4 fd ff ff       	call   11c5 <putc>
    13f1:	83 c4 10             	add    $0x10,%esp
                putc(fd, c);
    13f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13f7:	0f be c0             	movsbl %al,%eax
    13fa:	83 ec 08             	sub    $0x8,%esp
    13fd:	50                   	push   %eax
    13fe:	ff 75 08             	push   0x8(%ebp)
    1401:	e8 bf fd ff ff       	call   11c5 <putc>
    1406:	83 c4 10             	add    $0x10,%esp
            }
            state = 0;
    1409:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    for (i = 0; fmt[i]; i++) {
    1410:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1414:	8b 55 0c             	mov    0xc(%ebp),%edx
    1417:	8b 45 f0             	mov    -0x10(%ebp),%eax
    141a:	01 d0                	add    %edx,%eax
    141c:	0f b6 00             	movzbl (%eax),%eax
    141f:	84 c0                	test   %al,%al
    1421:	0f 85 94 fe ff ff    	jne    12bb <printf+0x22>
        }
    }
}
    1427:	90                   	nop
    1428:	90                   	nop
    1429:	c9                   	leave  
    142a:	c3                   	ret    

0000142b <rj_xtime>:
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
    0xb0, 0x54, 0xbb, 0x16};

#define rj_sbox(x) sbox[(x)]

static uchar rj_xtime(uchar x) {
    142b:	55                   	push   %ebp
    142c:	89 e5                	mov    %esp,%ebp
    142e:	83 ec 04             	sub    $0x4,%esp
    1431:	8b 45 08             	mov    0x8(%ebp),%eax
    1434:	88 45 fc             	mov    %al,-0x4(%ebp)
    return ((x << 1) & 0xFF) ^ (0x1b * ((x & 0x80) >> 7));
    1437:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
    143b:	01 c0                	add    %eax,%eax
    143d:	89 c1                	mov    %eax,%ecx
    143f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
    1443:	c0 e8 07             	shr    $0x7,%al
    1446:	89 c2                	mov    %eax,%edx
    1448:	89 d0                	mov    %edx,%eax
    144a:	01 c0                	add    %eax,%eax
    144c:	01 d0                	add    %edx,%eax
    144e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1455:	01 d0                	add    %edx,%eax
    1457:	31 c8                	xor    %ecx,%eax
}
    1459:	c9                   	leave  
    145a:	c3                   	ret    

0000145b <aes_subBytes>:

static void aes_subBytes(uchar* buf) {
    145b:	55                   	push   %ebp
    145c:	89 e5                	mov    %esp,%ebp
    145e:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
    145f:	bb 00 00 00 00       	mov    $0x0,%ebx
    1464:	eb 24                	jmp    148a <aes_subBytes+0x2f>
        buf[i] = rj_sbox(buf[i]);
    1466:	0f b6 d3             	movzbl %bl,%edx
    1469:	8b 45 08             	mov    0x8(%ebp),%eax
    146c:	01 d0                	add    %edx,%eax
    146e:	0f b6 00             	movzbl (%eax),%eax
    1471:	0f b6 c0             	movzbl %al,%eax
    1474:	0f b6 cb             	movzbl %bl,%ecx
    1477:	8b 55 08             	mov    0x8(%ebp),%edx
    147a:	01 ca                	add    %ecx,%edx
    147c:	0f b6 80 40 2c 00 00 	movzbl 0x2c40(%eax),%eax
    1483:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
    1485:	89 d8                	mov    %ebx,%eax
    1487:	8d 58 01             	lea    0x1(%eax),%ebx
    148a:	80 fb 0f             	cmp    $0xf,%bl
    148d:	76 d7                	jbe    1466 <aes_subBytes+0xb>
    }
}
    148f:	90                   	nop
    1490:	90                   	nop
    1491:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1494:	c9                   	leave  
    1495:	c3                   	ret    

00001496 <aes_addRoundKey>:

static void aes_addRoundKey(uchar* buf, uchar* key) {
    1496:	55                   	push   %ebp
    1497:	89 e5                	mov    %esp,%ebp
    1499:	56                   	push   %esi
    149a:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < 16; i++) {
    149b:	bb 00 00 00 00       	mov    $0x0,%ebx
    14a0:	eb 27                	jmp    14c9 <aes_addRoundKey+0x33>
        buf[i] ^= key[i];
    14a2:	0f b6 d3             	movzbl %bl,%edx
    14a5:	8b 45 08             	mov    0x8(%ebp),%eax
    14a8:	01 d0                	add    %edx,%eax
    14aa:	0f b6 08             	movzbl (%eax),%ecx
    14ad:	0f b6 d3             	movzbl %bl,%edx
    14b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    14b3:	01 d0                	add    %edx,%eax
    14b5:	0f b6 10             	movzbl (%eax),%edx
    14b8:	0f b6 f3             	movzbl %bl,%esi
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	01 f0                	add    %esi,%eax
    14c0:	31 ca                	xor    %ecx,%edx
    14c2:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i++) {
    14c4:	89 d8                	mov    %ebx,%eax
    14c6:	8d 58 01             	lea    0x1(%eax),%ebx
    14c9:	80 fb 0f             	cmp    $0xf,%bl
    14cc:	76 d4                	jbe    14a2 <aes_addRoundKey+0xc>
    }
}
    14ce:	90                   	nop
    14cf:	90                   	nop
    14d0:	5b                   	pop    %ebx
    14d1:	5e                   	pop    %esi
    14d2:	5d                   	pop    %ebp
    14d3:	c3                   	ret    

000014d4 <aes_addRoundKey_cpy>:

static void aes_addRoundKey_cpy(uchar* buf, uchar* key, uchar* cpk) {
    14d4:	55                   	push   %ebp
    14d5:	89 e5                	mov    %esp,%ebp
    14d7:	56                   	push   %esi
    14d8:	53                   	push   %ebx
    register uchar i = 16;

    for (i = 0; i < 16; i++) {
    14d9:	bb 00 00 00 00       	mov    $0x0,%ebx
    14de:	eb 5b                	jmp    153b <aes_addRoundKey_cpy+0x67>
        cpk[i] = key[i];
    14e0:	0f b6 d3             	movzbl %bl,%edx
    14e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e6:	01 d0                	add    %edx,%eax
    14e8:	0f b6 cb             	movzbl %bl,%ecx
    14eb:	8b 55 10             	mov    0x10(%ebp),%edx
    14ee:	01 ca                	add    %ecx,%edx
    14f0:	0f b6 00             	movzbl (%eax),%eax
    14f3:	88 02                	mov    %al,(%edx)
        buf[i] ^= key[i];
    14f5:	0f b6 d3             	movzbl %bl,%edx
    14f8:	8b 45 08             	mov    0x8(%ebp),%eax
    14fb:	01 d0                	add    %edx,%eax
    14fd:	0f b6 08             	movzbl (%eax),%ecx
    1500:	0f b6 d3             	movzbl %bl,%edx
    1503:	8b 45 0c             	mov    0xc(%ebp),%eax
    1506:	01 d0                	add    %edx,%eax
    1508:	0f b6 10             	movzbl (%eax),%edx
    150b:	0f b6 f3             	movzbl %bl,%esi
    150e:	8b 45 08             	mov    0x8(%ebp),%eax
    1511:	01 f0                	add    %esi,%eax
    1513:	31 ca                	xor    %ecx,%edx
    1515:	88 10                	mov    %dl,(%eax)
        cpk[16 + i] = key[16 + i];
    1517:	0f b6 c3             	movzbl %bl,%eax
    151a:	83 c0 10             	add    $0x10,%eax
    151d:	89 c2                	mov    %eax,%edx
    151f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1522:	01 d0                	add    %edx,%eax
    1524:	0f b6 d3             	movzbl %bl,%edx
    1527:	83 c2 10             	add    $0x10,%edx
    152a:	89 d1                	mov    %edx,%ecx
    152c:	8b 55 10             	mov    0x10(%ebp),%edx
    152f:	01 ca                	add    %ecx,%edx
    1531:	0f b6 00             	movzbl (%eax),%eax
    1534:	88 02                	mov    %al,(%edx)
    for (i = 0; i < 16; i++) {
    1536:	89 d8                	mov    %ebx,%eax
    1538:	8d 58 01             	lea    0x1(%eax),%ebx
    153b:	80 fb 0f             	cmp    $0xf,%bl
    153e:	76 a0                	jbe    14e0 <aes_addRoundKey_cpy+0xc>
    }
}
    1540:	90                   	nop
    1541:	90                   	nop
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5d                   	pop    %ebp
    1545:	c3                   	ret    

00001546 <aes_shiftRows>:

static void aes_shiftRows(uchar* buf) {
    1546:	55                   	push   %ebp
    1547:	89 e5                	mov    %esp,%ebp
    1549:	53                   	push   %ebx
    154a:	83 ec 04             	sub    $0x4,%esp
    register uchar i = buf[1], j = buf[3], k = buf[10], l = buf[14];
    154d:	8b 45 08             	mov    0x8(%ebp),%eax
    1550:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
    1554:	8b 45 08             	mov    0x8(%ebp),%eax
    1557:	0f b6 40 03          	movzbl 0x3(%eax),%eax
    155b:	88 45 fb             	mov    %al,-0x5(%ebp)
    155e:	8b 45 08             	mov    0x8(%ebp),%eax
    1561:	0f b6 58 0a          	movzbl 0xa(%eax),%ebx
    1565:	88 5d fa             	mov    %bl,-0x6(%ebp)
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	0f b6 58 0e          	movzbl 0xe(%eax),%ebx

    buf[1] = buf[5];
    156f:	8b 45 08             	mov    0x8(%ebp),%eax
    1572:	8d 50 01             	lea    0x1(%eax),%edx
    1575:	8b 45 08             	mov    0x8(%ebp),%eax
    1578:	0f b6 40 05          	movzbl 0x5(%eax),%eax
    157c:	88 02                	mov    %al,(%edx)
    buf[5] = buf[9];
    157e:	8b 45 08             	mov    0x8(%ebp),%eax
    1581:	8d 50 05             	lea    0x5(%eax),%edx
    1584:	8b 45 08             	mov    0x8(%ebp),%eax
    1587:	0f b6 40 09          	movzbl 0x9(%eax),%eax
    158b:	88 02                	mov    %al,(%edx)
    buf[9] = buf[13];
    158d:	8b 45 08             	mov    0x8(%ebp),%eax
    1590:	8d 50 09             	lea    0x9(%eax),%edx
    1593:	8b 45 08             	mov    0x8(%ebp),%eax
    1596:	0f b6 40 0d          	movzbl 0xd(%eax),%eax
    159a:	88 02                	mov    %al,(%edx)
    buf[13] = i;
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
    159f:	83 c0 0d             	add    $0xd,%eax
    15a2:	88 08                	mov    %cl,(%eax)
    buf[3] = buf[15];
    15a4:	8b 45 08             	mov    0x8(%ebp),%eax
    15a7:	8d 50 03             	lea    0x3(%eax),%edx
    15aa:	8b 45 08             	mov    0x8(%ebp),%eax
    15ad:	0f b6 40 0f          	movzbl 0xf(%eax),%eax
    15b1:	88 02                	mov    %al,(%edx)
    buf[15] = buf[11];
    15b3:	8b 45 08             	mov    0x8(%ebp),%eax
    15b6:	8d 50 0f             	lea    0xf(%eax),%edx
    15b9:	8b 45 08             	mov    0x8(%ebp),%eax
    15bc:	0f b6 40 0b          	movzbl 0xb(%eax),%eax
    15c0:	88 02                	mov    %al,(%edx)
    buf[11] = buf[7];
    15c2:	8b 45 08             	mov    0x8(%ebp),%eax
    15c5:	8d 50 0b             	lea    0xb(%eax),%edx
    15c8:	8b 45 08             	mov    0x8(%ebp),%eax
    15cb:	0f b6 40 07          	movzbl 0x7(%eax),%eax
    15cf:	88 02                	mov    %al,(%edx)
    buf[7] = j;
    15d1:	8b 45 08             	mov    0x8(%ebp),%eax
    15d4:	83 c0 07             	add    $0x7,%eax
    15d7:	0f b6 4d fb          	movzbl -0x5(%ebp),%ecx
    15db:	88 08                	mov    %cl,(%eax)
    buf[10] = buf[2];
    15dd:	8b 45 08             	mov    0x8(%ebp),%eax
    15e0:	8d 50 0a             	lea    0xa(%eax),%edx
    15e3:	8b 45 08             	mov    0x8(%ebp),%eax
    15e6:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15ea:	88 02                	mov    %al,(%edx)
    buf[2] = k;
    15ec:	8b 45 08             	mov    0x8(%ebp),%eax
    15ef:	83 c0 02             	add    $0x2,%eax
    15f2:	0f b6 4d fa          	movzbl -0x6(%ebp),%ecx
    15f6:	88 08                	mov    %cl,(%eax)
    buf[14] = buf[6];
    15f8:	8b 45 08             	mov    0x8(%ebp),%eax
    15fb:	8d 50 0e             	lea    0xe(%eax),%edx
    15fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1601:	0f b6 40 06          	movzbl 0x6(%eax),%eax
    1605:	88 02                	mov    %al,(%edx)
    buf[6] = l;
    1607:	8b 45 08             	mov    0x8(%ebp),%eax
    160a:	83 c0 06             	add    $0x6,%eax
    160d:	88 18                	mov    %bl,(%eax)
}
    160f:	90                   	nop
    1610:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1613:	c9                   	leave  
    1614:	c3                   	ret    

00001615 <aes_mixColumns>:

static void aes_mixColumns(uchar* buf) {
    1615:	55                   	push   %ebp
    1616:	89 e5                	mov    %esp,%ebp
    1618:	56                   	push   %esi
    1619:	53                   	push   %ebx
    161a:	83 ec 04             	sub    $0x4,%esp
    register uchar i, a, b, c, d, e;

    for (i = 0; i < 16; i += 4) {
    161d:	bb 00 00 00 00       	mov    $0x0,%ebx
    1622:	e9 42 01 00 00       	jmp    1769 <aes_mixColumns+0x154>
        a = buf[i];
    1627:	0f b6 d3             	movzbl %bl,%edx
    162a:	8b 45 08             	mov    0x8(%ebp),%eax
    162d:	01 d0                	add    %edx,%eax
    162f:	0f b6 08             	movzbl (%eax),%ecx
        b = buf[i + 1];
    1632:	0f b6 c3             	movzbl %bl,%eax
    1635:	8d 50 01             	lea    0x1(%eax),%edx
    1638:	8b 45 08             	mov    0x8(%ebp),%eax
    163b:	01 d0                	add    %edx,%eax
    163d:	0f b6 10             	movzbl (%eax),%edx
    1640:	88 55 f7             	mov    %dl,-0x9(%ebp)
        c = buf[i + 2];
    1643:	0f b6 c3             	movzbl %bl,%eax
    1646:	8d 50 02             	lea    0x2(%eax),%edx
    1649:	8b 45 08             	mov    0x8(%ebp),%eax
    164c:	01 d0                	add    %edx,%eax
    164e:	0f b6 00             	movzbl (%eax),%eax
    1651:	88 45 f6             	mov    %al,-0xa(%ebp)
        d = buf[i + 3];
    1654:	0f b6 c3             	movzbl %bl,%eax
    1657:	8d 50 03             	lea    0x3(%eax),%edx
    165a:	8b 45 08             	mov    0x8(%ebp),%eax
    165d:	01 d0                	add    %edx,%eax
    165f:	0f b6 00             	movzbl (%eax),%eax
    1662:	88 45 f5             	mov    %al,-0xb(%ebp)
        e = a ^ b ^ c ^ d;
    1665:	89 c8                	mov    %ecx,%eax
    1667:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
    166b:	31 d0                	xor    %edx,%eax
    166d:	32 45 f6             	xor    -0xa(%ebp),%al
    1670:	0f b6 75 f5          	movzbl -0xb(%ebp),%esi
    1674:	31 c6                	xor    %eax,%esi
        buf[i] ^= e ^ rj_xtime(a ^ b);
    1676:	88 4d f4             	mov    %cl,-0xc(%ebp)
    1679:	89 c8                	mov    %ecx,%eax
    167b:	88 55 f7             	mov    %dl,-0x9(%ebp)
    167e:	32 45 f7             	xor    -0x9(%ebp),%al
    1681:	0f b6 c0             	movzbl %al,%eax
    1684:	50                   	push   %eax
    1685:	e8 a1 fd ff ff       	call   142b <rj_xtime>
    168a:	83 c4 04             	add    $0x4,%esp
    168d:	31 f0                	xor    %esi,%eax
    168f:	0f b6 c8             	movzbl %al,%ecx
    1692:	0f b6 d3             	movzbl %bl,%edx
    1695:	8b 45 08             	mov    0x8(%ebp),%eax
    1698:	01 d0                	add    %edx,%eax
    169a:	0f b6 00             	movzbl (%eax),%eax
    169d:	89 c2                	mov    %eax,%edx
    169f:	89 c8                	mov    %ecx,%eax
    16a1:	89 d1                	mov    %edx,%ecx
    16a3:	31 c1                	xor    %eax,%ecx
    16a5:	0f b6 d3             	movzbl %bl,%edx
    16a8:	8b 45 08             	mov    0x8(%ebp),%eax
    16ab:	01 c2                	add    %eax,%edx
    16ad:	89 c8                	mov    %ecx,%eax
    16af:	88 02                	mov    %al,(%edx)
        buf[i + 1] ^= e ^ rj_xtime(b ^ c);
    16b1:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
    16b5:	32 55 f6             	xor    -0xa(%ebp),%dl
    16b8:	89 d0                	mov    %edx,%eax
    16ba:	0f b6 c0             	movzbl %al,%eax
    16bd:	50                   	push   %eax
    16be:	e8 68 fd ff ff       	call   142b <rj_xtime>
    16c3:	83 c4 04             	add    $0x4,%esp
    16c6:	31 f0                	xor    %esi,%eax
    16c8:	0f b6 c8             	movzbl %al,%ecx
    16cb:	0f b6 c3             	movzbl %bl,%eax
    16ce:	8d 50 01             	lea    0x1(%eax),%edx
    16d1:	8b 45 08             	mov    0x8(%ebp),%eax
    16d4:	01 d0                	add    %edx,%eax
    16d6:	0f b6 00             	movzbl (%eax),%eax
    16d9:	89 c2                	mov    %eax,%edx
    16db:	89 c8                	mov    %ecx,%eax
    16dd:	31 c2                	xor    %eax,%edx
    16df:	89 d1                	mov    %edx,%ecx
    16e1:	0f b6 c3             	movzbl %bl,%eax
    16e4:	8d 50 01             	lea    0x1(%eax),%edx
    16e7:	8b 45 08             	mov    0x8(%ebp),%eax
    16ea:	01 c2                	add    %eax,%edx
    16ec:	89 c8                	mov    %ecx,%eax
    16ee:	88 02                	mov    %al,(%edx)
        buf[i + 2] ^= e ^ rj_xtime(c ^ d);
    16f0:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
    16f4:	32 45 f5             	xor    -0xb(%ebp),%al
    16f7:	0f b6 c0             	movzbl %al,%eax
    16fa:	50                   	push   %eax
    16fb:	e8 2b fd ff ff       	call   142b <rj_xtime>
    1700:	83 c4 04             	add    $0x4,%esp
    1703:	31 f0                	xor    %esi,%eax
    1705:	0f b6 d0             	movzbl %al,%edx
    1708:	0f b6 c3             	movzbl %bl,%eax
    170b:	8d 48 02             	lea    0x2(%eax),%ecx
    170e:	8b 45 08             	mov    0x8(%ebp),%eax
    1711:	01 c8                	add    %ecx,%eax
    1713:	0f b6 00             	movzbl (%eax),%eax
    1716:	89 c1                	mov    %eax,%ecx
    1718:	89 d0                	mov    %edx,%eax
    171a:	89 ca                	mov    %ecx,%edx
    171c:	31 c2                	xor    %eax,%edx
    171e:	0f b6 c3             	movzbl %bl,%eax
    1721:	8d 48 02             	lea    0x2(%eax),%ecx
    1724:	8b 45 08             	mov    0x8(%ebp),%eax
    1727:	01 c8                	add    %ecx,%eax
    1729:	88 10                	mov    %dl,(%eax)
        buf[i + 3] ^= e ^ rj_xtime(d ^ a);
    172b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    172f:	32 45 f4             	xor    -0xc(%ebp),%al
    1732:	0f b6 c0             	movzbl %al,%eax
    1735:	50                   	push   %eax
    1736:	e8 f0 fc ff ff       	call   142b <rj_xtime>
    173b:	83 c4 04             	add    $0x4,%esp
    173e:	31 f0                	xor    %esi,%eax
    1740:	0f b6 d0             	movzbl %al,%edx
    1743:	0f b6 c3             	movzbl %bl,%eax
    1746:	8d 48 03             	lea    0x3(%eax),%ecx
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
    174c:	01 c8                	add    %ecx,%eax
    174e:	0f b6 00             	movzbl (%eax),%eax
    1751:	89 c1                	mov    %eax,%ecx
    1753:	89 d0                	mov    %edx,%eax
    1755:	31 c1                	xor    %eax,%ecx
    1757:	89 ca                	mov    %ecx,%edx
    1759:	0f b6 c3             	movzbl %bl,%eax
    175c:	8d 48 03             	lea    0x3(%eax),%ecx
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	01 c8                	add    %ecx,%eax
    1764:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < 16; i += 4) {
    1766:	83 c3 04             	add    $0x4,%ebx
    1769:	80 fb 0f             	cmp    $0xf,%bl
    176c:	0f 86 b5 fe ff ff    	jbe    1627 <aes_mixColumns+0x12>
    }
}
    1772:	90                   	nop
    1773:	90                   	nop
    1774:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1777:	5b                   	pop    %ebx
    1778:	5e                   	pop    %esi
    1779:	5d                   	pop    %ebp
    177a:	c3                   	ret    

0000177b <aes_expandEncKey>:

static void aes_expandEncKey(uchar* k, uchar rc) {
    177b:	55                   	push   %ebp
    177c:	89 e5                	mov    %esp,%ebp
    177e:	56                   	push   %esi
    177f:	53                   	push   %ebx
    1780:	83 ec 04             	sub    $0x4,%esp
    1783:	8b 45 0c             	mov    0xc(%ebp),%eax
    1786:	88 45 f4             	mov    %al,-0xc(%ebp)
    register uchar i;

    k[0] ^= rj_sbox(k[29]) ^ rc;
    1789:	8b 45 08             	mov    0x8(%ebp),%eax
    178c:	0f b6 10             	movzbl (%eax),%edx
    178f:	8b 45 08             	mov    0x8(%ebp),%eax
    1792:	83 c0 1d             	add    $0x1d,%eax
    1795:	0f b6 00             	movzbl (%eax),%eax
    1798:	0f b6 c0             	movzbl %al,%eax
    179b:	0f b6 80 40 2c 00 00 	movzbl 0x2c40(%eax),%eax
    17a2:	32 45 f4             	xor    -0xc(%ebp),%al
    17a5:	31 c2                	xor    %eax,%edx
    17a7:	8b 45 08             	mov    0x8(%ebp),%eax
    17aa:	88 10                	mov    %dl,(%eax)
    k[1] ^= rj_sbox(k[30]);
    17ac:	8b 45 08             	mov    0x8(%ebp),%eax
    17af:	83 c0 01             	add    $0x1,%eax
    17b2:	0f b6 08             	movzbl (%eax),%ecx
    17b5:	8b 45 08             	mov    0x8(%ebp),%eax
    17b8:	83 c0 1e             	add    $0x1e,%eax
    17bb:	0f b6 00             	movzbl (%eax),%eax
    17be:	0f b6 c0             	movzbl %al,%eax
    17c1:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    17c8:	8b 45 08             	mov    0x8(%ebp),%eax
    17cb:	83 c0 01             	add    $0x1,%eax
    17ce:	31 ca                	xor    %ecx,%edx
    17d0:	88 10                	mov    %dl,(%eax)
    k[2] ^= rj_sbox(k[31]);
    17d2:	8b 45 08             	mov    0x8(%ebp),%eax
    17d5:	83 c0 02             	add    $0x2,%eax
    17d8:	0f b6 08             	movzbl (%eax),%ecx
    17db:	8b 45 08             	mov    0x8(%ebp),%eax
    17de:	83 c0 1f             	add    $0x1f,%eax
    17e1:	0f b6 00             	movzbl (%eax),%eax
    17e4:	0f b6 c0             	movzbl %al,%eax
    17e7:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    17ee:	8b 45 08             	mov    0x8(%ebp),%eax
    17f1:	83 c0 02             	add    $0x2,%eax
    17f4:	31 ca                	xor    %ecx,%edx
    17f6:	88 10                	mov    %dl,(%eax)
    k[3] ^= rj_sbox(k[28]);
    17f8:	8b 45 08             	mov    0x8(%ebp),%eax
    17fb:	83 c0 03             	add    $0x3,%eax
    17fe:	0f b6 08             	movzbl (%eax),%ecx
    1801:	8b 45 08             	mov    0x8(%ebp),%eax
    1804:	83 c0 1c             	add    $0x1c,%eax
    1807:	0f b6 00             	movzbl (%eax),%eax
    180a:	0f b6 c0             	movzbl %al,%eax
    180d:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    1814:	8b 45 08             	mov    0x8(%ebp),%eax
    1817:	83 c0 03             	add    $0x3,%eax
    181a:	31 ca                	xor    %ecx,%edx
    181c:	88 10                	mov    %dl,(%eax)

    for (i = 4; i < 16; i += 4) {
    181e:	bb 04 00 00 00       	mov    $0x4,%ebx
    1823:	e9 a9 00 00 00       	jmp    18d1 <aes_expandEncKey+0x156>
        k[i] ^= k[i - 4];
    1828:	0f b6 d3             	movzbl %bl,%edx
    182b:	8b 45 08             	mov    0x8(%ebp),%eax
    182e:	01 d0                	add    %edx,%eax
    1830:	0f b6 08             	movzbl (%eax),%ecx
    1833:	0f b6 c3             	movzbl %bl,%eax
    1836:	8d 50 fc             	lea    -0x4(%eax),%edx
    1839:	8b 45 08             	mov    0x8(%ebp),%eax
    183c:	01 d0                	add    %edx,%eax
    183e:	0f b6 10             	movzbl (%eax),%edx
    1841:	0f b6 f3             	movzbl %bl,%esi
    1844:	8b 45 08             	mov    0x8(%ebp),%eax
    1847:	01 f0                	add    %esi,%eax
    1849:	31 ca                	xor    %ecx,%edx
    184b:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
    184d:	0f b6 c3             	movzbl %bl,%eax
    1850:	8d 50 01             	lea    0x1(%eax),%edx
    1853:	8b 45 08             	mov    0x8(%ebp),%eax
    1856:	01 d0                	add    %edx,%eax
    1858:	0f b6 08             	movzbl (%eax),%ecx
    185b:	0f b6 c3             	movzbl %bl,%eax
    185e:	8d 50 fd             	lea    -0x3(%eax),%edx
    1861:	8b 45 08             	mov    0x8(%ebp),%eax
    1864:	01 d0                	add    %edx,%eax
    1866:	0f b6 10             	movzbl (%eax),%edx
    1869:	0f b6 c3             	movzbl %bl,%eax
    186c:	8d 70 01             	lea    0x1(%eax),%esi
    186f:	8b 45 08             	mov    0x8(%ebp),%eax
    1872:	01 f0                	add    %esi,%eax
    1874:	31 ca                	xor    %ecx,%edx
    1876:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
    1878:	0f b6 c3             	movzbl %bl,%eax
    187b:	8d 50 02             	lea    0x2(%eax),%edx
    187e:	8b 45 08             	mov    0x8(%ebp),%eax
    1881:	01 d0                	add    %edx,%eax
    1883:	0f b6 08             	movzbl (%eax),%ecx
    1886:	0f b6 c3             	movzbl %bl,%eax
    1889:	8d 50 fe             	lea    -0x2(%eax),%edx
    188c:	8b 45 08             	mov    0x8(%ebp),%eax
    188f:	01 d0                	add    %edx,%eax
    1891:	0f b6 10             	movzbl (%eax),%edx
    1894:	0f b6 c3             	movzbl %bl,%eax
    1897:	8d 70 02             	lea    0x2(%eax),%esi
    189a:	8b 45 08             	mov    0x8(%ebp),%eax
    189d:	01 f0                	add    %esi,%eax
    189f:	31 ca                	xor    %ecx,%edx
    18a1:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
    18a3:	0f b6 c3             	movzbl %bl,%eax
    18a6:	8d 50 03             	lea    0x3(%eax),%edx
    18a9:	8b 45 08             	mov    0x8(%ebp),%eax
    18ac:	01 d0                	add    %edx,%eax
    18ae:	0f b6 08             	movzbl (%eax),%ecx
    18b1:	0f b6 c3             	movzbl %bl,%eax
    18b4:	8d 50 ff             	lea    -0x1(%eax),%edx
    18b7:	8b 45 08             	mov    0x8(%ebp),%eax
    18ba:	01 d0                	add    %edx,%eax
    18bc:	0f b6 10             	movzbl (%eax),%edx
    18bf:	0f b6 c3             	movzbl %bl,%eax
    18c2:	8d 70 03             	lea    0x3(%eax),%esi
    18c5:	8b 45 08             	mov    0x8(%ebp),%eax
    18c8:	01 f0                	add    %esi,%eax
    18ca:	31 ca                	xor    %ecx,%edx
    18cc:	88 10                	mov    %dl,(%eax)
    for (i = 4; i < 16; i += 4) {
    18ce:	83 c3 04             	add    $0x4,%ebx
    18d1:	80 fb 0f             	cmp    $0xf,%bl
    18d4:	0f 86 4e ff ff ff    	jbe    1828 <aes_expandEncKey+0xad>
    }

    k[16] ^= rj_sbox(k[12]);
    18da:	8b 45 08             	mov    0x8(%ebp),%eax
    18dd:	83 c0 10             	add    $0x10,%eax
    18e0:	0f b6 08             	movzbl (%eax),%ecx
    18e3:	8b 45 08             	mov    0x8(%ebp),%eax
    18e6:	83 c0 0c             	add    $0xc,%eax
    18e9:	0f b6 00             	movzbl (%eax),%eax
    18ec:	0f b6 c0             	movzbl %al,%eax
    18ef:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    18f6:	8b 45 08             	mov    0x8(%ebp),%eax
    18f9:	83 c0 10             	add    $0x10,%eax
    18fc:	31 ca                	xor    %ecx,%edx
    18fe:	88 10                	mov    %dl,(%eax)
    k[17] ^= rj_sbox(k[13]);
    1900:	8b 45 08             	mov    0x8(%ebp),%eax
    1903:	83 c0 11             	add    $0x11,%eax
    1906:	0f b6 08             	movzbl (%eax),%ecx
    1909:	8b 45 08             	mov    0x8(%ebp),%eax
    190c:	83 c0 0d             	add    $0xd,%eax
    190f:	0f b6 00             	movzbl (%eax),%eax
    1912:	0f b6 c0             	movzbl %al,%eax
    1915:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    191c:	8b 45 08             	mov    0x8(%ebp),%eax
    191f:	83 c0 11             	add    $0x11,%eax
    1922:	31 ca                	xor    %ecx,%edx
    1924:	88 10                	mov    %dl,(%eax)
    k[18] ^= rj_sbox(k[14]);
    1926:	8b 45 08             	mov    0x8(%ebp),%eax
    1929:	83 c0 12             	add    $0x12,%eax
    192c:	0f b6 08             	movzbl (%eax),%ecx
    192f:	8b 45 08             	mov    0x8(%ebp),%eax
    1932:	83 c0 0e             	add    $0xe,%eax
    1935:	0f b6 00             	movzbl (%eax),%eax
    1938:	0f b6 c0             	movzbl %al,%eax
    193b:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    1942:	8b 45 08             	mov    0x8(%ebp),%eax
    1945:	83 c0 12             	add    $0x12,%eax
    1948:	31 ca                	xor    %ecx,%edx
    194a:	88 10                	mov    %dl,(%eax)
    k[19] ^= rj_sbox(k[15]);
    194c:	8b 45 08             	mov    0x8(%ebp),%eax
    194f:	83 c0 13             	add    $0x13,%eax
    1952:	0f b6 08             	movzbl (%eax),%ecx
    1955:	8b 45 08             	mov    0x8(%ebp),%eax
    1958:	83 c0 0f             	add    $0xf,%eax
    195b:	0f b6 00             	movzbl (%eax),%eax
    195e:	0f b6 c0             	movzbl %al,%eax
    1961:	0f b6 90 40 2c 00 00 	movzbl 0x2c40(%eax),%edx
    1968:	8b 45 08             	mov    0x8(%ebp),%eax
    196b:	83 c0 13             	add    $0x13,%eax
    196e:	31 ca                	xor    %ecx,%edx
    1970:	88 10                	mov    %dl,(%eax)

    for (i = 20; i < 32; i += 4) {
    1972:	bb 14 00 00 00       	mov    $0x14,%ebx
    1977:	e9 a9 00 00 00       	jmp    1a25 <aes_expandEncKey+0x2aa>
        k[i] ^= k[i - 4];
    197c:	0f b6 d3             	movzbl %bl,%edx
    197f:	8b 45 08             	mov    0x8(%ebp),%eax
    1982:	01 d0                	add    %edx,%eax
    1984:	0f b6 08             	movzbl (%eax),%ecx
    1987:	0f b6 c3             	movzbl %bl,%eax
    198a:	8d 50 fc             	lea    -0x4(%eax),%edx
    198d:	8b 45 08             	mov    0x8(%ebp),%eax
    1990:	01 d0                	add    %edx,%eax
    1992:	0f b6 10             	movzbl (%eax),%edx
    1995:	0f b6 f3             	movzbl %bl,%esi
    1998:	8b 45 08             	mov    0x8(%ebp),%eax
    199b:	01 f0                	add    %esi,%eax
    199d:	31 ca                	xor    %ecx,%edx
    199f:	88 10                	mov    %dl,(%eax)
        k[i + 1] ^= k[i - 3];
    19a1:	0f b6 c3             	movzbl %bl,%eax
    19a4:	8d 50 01             	lea    0x1(%eax),%edx
    19a7:	8b 45 08             	mov    0x8(%ebp),%eax
    19aa:	01 d0                	add    %edx,%eax
    19ac:	0f b6 08             	movzbl (%eax),%ecx
    19af:	0f b6 c3             	movzbl %bl,%eax
    19b2:	8d 50 fd             	lea    -0x3(%eax),%edx
    19b5:	8b 45 08             	mov    0x8(%ebp),%eax
    19b8:	01 d0                	add    %edx,%eax
    19ba:	0f b6 10             	movzbl (%eax),%edx
    19bd:	0f b6 c3             	movzbl %bl,%eax
    19c0:	8d 70 01             	lea    0x1(%eax),%esi
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	01 f0                	add    %esi,%eax
    19c8:	31 ca                	xor    %ecx,%edx
    19ca:	88 10                	mov    %dl,(%eax)
        k[i + 2] ^= k[i - 2];
    19cc:	0f b6 c3             	movzbl %bl,%eax
    19cf:	8d 50 02             	lea    0x2(%eax),%edx
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	01 d0                	add    %edx,%eax
    19d7:	0f b6 08             	movzbl (%eax),%ecx
    19da:	0f b6 c3             	movzbl %bl,%eax
    19dd:	8d 50 fe             	lea    -0x2(%eax),%edx
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
    19e3:	01 d0                	add    %edx,%eax
    19e5:	0f b6 10             	movzbl (%eax),%edx
    19e8:	0f b6 c3             	movzbl %bl,%eax
    19eb:	8d 70 02             	lea    0x2(%eax),%esi
    19ee:	8b 45 08             	mov    0x8(%ebp),%eax
    19f1:	01 f0                	add    %esi,%eax
    19f3:	31 ca                	xor    %ecx,%edx
    19f5:	88 10                	mov    %dl,(%eax)
        k[i + 3] ^= k[i - 1];
    19f7:	0f b6 c3             	movzbl %bl,%eax
    19fa:	8d 50 03             	lea    0x3(%eax),%edx
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	01 d0                	add    %edx,%eax
    1a02:	0f b6 08             	movzbl (%eax),%ecx
    1a05:	0f b6 c3             	movzbl %bl,%eax
    1a08:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	01 d0                	add    %edx,%eax
    1a10:	0f b6 10             	movzbl (%eax),%edx
    1a13:	0f b6 c3             	movzbl %bl,%eax
    1a16:	8d 70 03             	lea    0x3(%eax),%esi
    1a19:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1c:	01 f0                	add    %esi,%eax
    1a1e:	31 ca                	xor    %ecx,%edx
    1a20:	88 10                	mov    %dl,(%eax)
    for (i = 20; i < 32; i += 4) {
    1a22:	83 c3 04             	add    $0x4,%ebx
    1a25:	80 fb 1f             	cmp    $0x1f,%bl
    1a28:	0f 86 4e ff ff ff    	jbe    197c <aes_expandEncKey+0x201>
    }
}
    1a2e:	90                   	nop
    1a2f:	90                   	nop
    1a30:	83 c4 04             	add    $0x4,%esp
    1a33:	5b                   	pop    %ebx
    1a34:	5e                   	pop    %esi
    1a35:	5d                   	pop    %ebp
    1a36:	c3                   	ret    

00001a37 <ctr_inc_ctr>:

static void ctr_inc_ctr(uchar* val) {
    1a37:	55                   	push   %ebp
    1a38:	89 e5                	mov    %esp,%ebp
    if (val != (void*) 0x0) {
    1a3a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1a3e:	74 4d                	je     1a8d <ctr_inc_ctr+0x56>
        if (++val[3] == 0) {
    1a40:	8b 45 08             	mov    0x8(%ebp),%eax
    1a43:	83 c0 03             	add    $0x3,%eax
    1a46:	0f b6 10             	movzbl (%eax),%edx
    1a49:	83 c2 01             	add    $0x1,%edx
    1a4c:	88 10                	mov    %dl,(%eax)
    1a4e:	0f b6 00             	movzbl (%eax),%eax
    1a51:	84 c0                	test   %al,%al
    1a53:	75 38                	jne    1a8d <ctr_inc_ctr+0x56>
            if (++val[2] == 0) {
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	83 c0 02             	add    $0x2,%eax
    1a5b:	0f b6 10             	movzbl (%eax),%edx
    1a5e:	83 c2 01             	add    $0x1,%edx
    1a61:	88 10                	mov    %dl,(%eax)
    1a63:	0f b6 00             	movzbl (%eax),%eax
    1a66:	84 c0                	test   %al,%al
    1a68:	75 23                	jne    1a8d <ctr_inc_ctr+0x56>
                if (++val[1] == 0) {
    1a6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6d:	83 c0 01             	add    $0x1,%eax
    1a70:	0f b6 10             	movzbl (%eax),%edx
    1a73:	83 c2 01             	add    $0x1,%edx
    1a76:	88 10                	mov    %dl,(%eax)
    1a78:	0f b6 00             	movzbl (%eax),%eax
    1a7b:	84 c0                	test   %al,%al
    1a7d:	75 0e                	jne    1a8d <ctr_inc_ctr+0x56>
                    val[0]++;
    1a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a82:	0f b6 00             	movzbl (%eax),%eax
    1a85:	8d 50 01             	lea    0x1(%eax),%edx
    1a88:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8b:	88 10                	mov    %dl,(%eax)
                }
            }
        }
    }
}
    1a8d:	90                   	nop
    1a8e:	5d                   	pop    %ebp
    1a8f:	c3                   	ret    

00001a90 <ctr_clock_keystream>:

static void ctr_clock_keystream(aes256_context* ctx, uchar* ks) {
    1a90:	55                   	push   %ebp
    1a91:	89 e5                	mov    %esp,%ebp
    1a93:	83 ec 18             	sub    $0x18,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1a96:	8b 45 08             	mov    0x8(%ebp),%eax
    1a99:	83 c0 40             	add    $0x40,%eax
    1a9c:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if ((ctx != (void*) 0x0) && (ks != (void*) 0x0)) {
    1a9f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1aa3:	74 56                	je     1afb <ctr_clock_keystream+0x6b>
    1aa5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1aa9:	74 50                	je     1afb <ctr_clock_keystream+0x6b>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1aab:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
    1aaf:	eb 21                	jmp    1ad2 <ctr_clock_keystream+0x42>
            ks[i] = p[i];
    1ab1:	0f b6 55 f7          	movzbl -0x9(%ebp),%edx
    1ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ab8:	01 d0                	add    %edx,%eax
    1aba:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
    1abe:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ac1:	01 ca                	add    %ecx,%edx
    1ac3:	0f b6 00             	movzbl (%eax),%eax
    1ac6:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1ac8:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
    1acc:	83 c0 01             	add    $0x1,%eax
    1acf:	88 45 f7             	mov    %al,-0x9(%ebp)
    1ad2:	80 7d f7 0f          	cmpb   $0xf,-0x9(%ebp)
    1ad6:	76 d9                	jbe    1ab1 <ctr_clock_keystream+0x21>
        }

        aes256_encrypt_ecb(ctx, ks);
    1ad8:	83 ec 08             	sub    $0x8,%esp
    1adb:	ff 75 0c             	push   0xc(%ebp)
    1ade:	ff 75 08             	push   0x8(%ebp)
    1ae1:	e8 16 01 00 00       	call   1bfc <aes256_encrypt_ecb>
    1ae6:	83 c4 10             	add    $0x10,%esp
        ctr_inc_ctr(&ctx->blk.ctr[0]);
    1ae9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aec:	83 c0 4c             	add    $0x4c,%eax
    1aef:	83 ec 0c             	sub    $0xc,%esp
    1af2:	50                   	push   %eax
    1af3:	e8 3f ff ff ff       	call   1a37 <ctr_inc_ctr>
    1af8:	83 c4 10             	add    $0x10,%esp
    }
}
    1afb:	90                   	nop
    1afc:	c9                   	leave  
    1afd:	c3                   	ret    

00001afe <aes256_encrypt>:

void aes256_encrypt(uchar* key, void* buf, uint len) {
    1afe:	55                   	push   %ebp
    1aff:	89 e5                	mov    %esp,%ebp
    1b01:	83 ec 78             	sub    $0x78,%esp
    uchar* bytes = (uchar*) buf;
    1b04:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    aes256_context ctx;
    rfc3686_blk ctr = {
    1b0a:	c7 45 94 00 1c c5 b7 	movl   $0xb7c51c00,-0x6c(%ebp)
    1b11:	c7 45 98 51 a5 1d 70 	movl   $0x701da551,-0x68(%ebp)
    1b18:	c7 45 9c a1 c1 11 48 	movl   $0x4811c1a1,-0x64(%ebp)
    1b1f:	c7 45 a0 00 00 00 01 	movl   $0x1000000,-0x60(%ebp)
        {0x00, 0x1C, 0xC5, 0xB7},                         /* nonce   */
        {0x51, 0xA5, 0x1D, 0x70, 0xA1, 0xC1, 0x11, 0x48}, /* IV      */
        {0x00, 0x00, 0x00, 0x01}                          /* counter */
    };

    aes256_init(&ctx, key);
    1b26:	83 ec 08             	sub    $0x8,%esp
    1b29:	ff 75 08             	push   0x8(%ebp)
    1b2c:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1b2f:	50                   	push   %eax
    1b30:	e8 2e 00 00 00       	call   1b63 <aes256_init>
    1b35:	83 c4 10             	add    $0x10,%esp
    aes256_setCtrBlk(&ctx, &ctr);
    1b38:	83 ec 08             	sub    $0x8,%esp
    1b3b:	8d 45 94             	lea    -0x6c(%ebp),%eax
    1b3e:	50                   	push   %eax
    1b3f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1b42:	50                   	push   %eax
    1b43:	e8 8d 01 00 00       	call   1cd5 <aes256_setCtrBlk>
    1b48:	83 c4 10             	add    $0x10,%esp
    aes256_encrypt_ctr(&ctx, bytes, len);
    1b4b:	83 ec 04             	sub    $0x4,%esp
    1b4e:	ff 75 10             	push   0x10(%ebp)
    1b51:	ff 75 f4             	push   -0xc(%ebp)
    1b54:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1b57:	50                   	push   %eax
    1b58:	e8 c9 01 00 00       	call   1d26 <aes256_encrypt_ctr>
    1b5d:	83 c4 10             	add    $0x10,%esp
}
    1b60:	90                   	nop
    1b61:	c9                   	leave  
    1b62:	c3                   	ret    

00001b63 <aes256_init>:

void aes256_init(aes256_context* ctx, uchar* key) {
    1b63:	55                   	push   %ebp
    1b64:	89 e5                	mov    %esp,%ebp
    1b66:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1b67:	bb 00 00 00 00       	mov    $0x0,%ebx
    1b6c:	eb 1a                	jmp    1b88 <aes256_init+0x25>
        ctx->enckey[i] = key[i];
    1b6e:	0f b6 d3             	movzbl %bl,%edx
    1b71:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b74:	01 c2                	add    %eax,%edx
    1b76:	0f b6 c3             	movzbl %bl,%eax
    1b79:	0f b6 0a             	movzbl (%edx),%ecx
    1b7c:	8b 55 08             	mov    0x8(%ebp),%edx
    1b7f:	88 4c 02 20          	mov    %cl,0x20(%edx,%eax,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1b83:	89 d8                	mov    %ebx,%eax
    1b85:	8d 58 01             	lea    0x1(%eax),%ebx
    1b88:	80 fb 1f             	cmp    $0x1f,%bl
    1b8b:	76 e1                	jbe    1b6e <aes256_init+0xb>
    }
}
    1b8d:	90                   	nop
    1b8e:	90                   	nop
    1b8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1b92:	c9                   	leave  
    1b93:	c3                   	ret    

00001b94 <aes256_done>:

void aes256_done(aes256_context* ctx) {
    1b94:	55                   	push   %ebp
    1b95:	89 e5                	mov    %esp,%ebp
    1b97:	53                   	push   %ebx
    register uchar i;

    for (i = 0; i < sizeof(ctx->key); i++) {
    1b98:	bb 00 00 00 00       	mov    $0x0,%ebx
    1b9d:	eb 51                	jmp    1bf0 <aes256_done+0x5c>
        ctx->key[i] = ctx->enckey[i] = 0;
    1b9f:	0f b6 c3             	movzbl %bl,%eax
    1ba2:	8b 55 08             	mov    0x8(%ebp),%edx
    1ba5:	c6 44 02 20 00       	movb   $0x0,0x20(%edx,%eax,1)
    1baa:	0f b6 d3             	movzbl %bl,%edx
    1bad:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bb0:	0f b6 4c 01 20       	movzbl 0x20(%ecx,%eax,1),%ecx
    1bb5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb8:	88 0c 10             	mov    %cl,(%eax,%edx,1)
        ctx->blk.nonce[i % sizeof(ctx->blk.nonce)] = 0;
    1bbb:	0f b6 c3             	movzbl %bl,%eax
    1bbe:	83 e0 03             	and    $0x3,%eax
    1bc1:	89 c2                	mov    %eax,%edx
    1bc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc6:	c6 44 10 40 00       	movb   $0x0,0x40(%eax,%edx,1)
        ctx->blk.iv[i % sizeof(ctx->blk.iv)] = 0;
    1bcb:	0f b6 c3             	movzbl %bl,%eax
    1bce:	83 e0 07             	and    $0x7,%eax
    1bd1:	89 c2                	mov    %eax,%edx
    1bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd6:	c6 44 10 44 00       	movb   $0x0,0x44(%eax,%edx,1)
        ctx->blk.ctr[i % sizeof(ctx->blk.ctr)] = 0;
    1bdb:	0f b6 c3             	movzbl %bl,%eax
    1bde:	83 e0 03             	and    $0x3,%eax
    1be1:	89 c2                	mov    %eax,%edx
    1be3:	8b 45 08             	mov    0x8(%ebp),%eax
    1be6:	c6 44 10 4c 00       	movb   $0x0,0x4c(%eax,%edx,1)
    for (i = 0; i < sizeof(ctx->key); i++) {
    1beb:	89 d8                	mov    %ebx,%eax
    1bed:	8d 58 01             	lea    0x1(%eax),%ebx
    1bf0:	80 fb 1f             	cmp    $0x1f,%bl
    1bf3:	76 aa                	jbe    1b9f <aes256_done+0xb>
    }
}
    1bf5:	90                   	nop
    1bf6:	90                   	nop
    1bf7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1bfa:	c9                   	leave  
    1bfb:	c3                   	ret    

00001bfc <aes256_encrypt_ecb>:

void aes256_encrypt_ecb(aes256_context* ctx, uchar* buf) {
    1bfc:	55                   	push   %ebp
    1bfd:	89 e5                	mov    %esp,%ebp
    1bff:	83 ec 10             	sub    $0x10,%esp
    uchar i, rcon = 1;
    1c02:	c6 45 fe 01          	movb   $0x1,-0x2(%ebp)

    aes_addRoundKey_cpy(buf, ctx->enckey, ctx->key);
    1c06:	8b 45 08             	mov    0x8(%ebp),%eax
    1c09:	8b 55 08             	mov    0x8(%ebp),%edx
    1c0c:	83 c2 20             	add    $0x20,%edx
    1c0f:	50                   	push   %eax
    1c10:	52                   	push   %edx
    1c11:	ff 75 0c             	push   0xc(%ebp)
    1c14:	e8 bb f8 ff ff       	call   14d4 <aes_addRoundKey_cpy>
    1c19:	83 c4 0c             	add    $0xc,%esp
    for (i = 1; i < 14; ++i) {
    1c1c:	c6 45 ff 01          	movb   $0x1,-0x1(%ebp)
    1c20:	eb 74                	jmp    1c96 <aes256_encrypt_ecb+0x9a>
        aes_subBytes(buf);
    1c22:	ff 75 0c             	push   0xc(%ebp)
    1c25:	e8 31 f8 ff ff       	call   145b <aes_subBytes>
    1c2a:	83 c4 04             	add    $0x4,%esp
        aes_shiftRows(buf);
    1c2d:	ff 75 0c             	push   0xc(%ebp)
    1c30:	e8 11 f9 ff ff       	call   1546 <aes_shiftRows>
    1c35:	83 c4 04             	add    $0x4,%esp
        aes_mixColumns(buf);
    1c38:	ff 75 0c             	push   0xc(%ebp)
    1c3b:	e8 d5 f9 ff ff       	call   1615 <aes_mixColumns>
    1c40:	83 c4 04             	add    $0x4,%esp
        if ((i & 1) == 1) {
    1c43:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1c47:	83 e0 01             	and    $0x1,%eax
    1c4a:	85 c0                	test   %eax,%eax
    1c4c:	74 14                	je     1c62 <aes256_encrypt_ecb+0x66>
            aes_addRoundKey(buf, &ctx->key[16]);
    1c4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c51:	83 c0 10             	add    $0x10,%eax
    1c54:	50                   	push   %eax
    1c55:	ff 75 0c             	push   0xc(%ebp)
    1c58:	e8 39 f8 ff ff       	call   1496 <aes_addRoundKey>
    1c5d:	83 c4 08             	add    $0x8,%esp
    1c60:	eb 30                	jmp    1c92 <aes256_encrypt_ecb+0x96>
        } else {
            aes_expandEncKey(ctx->key, rcon);
    1c62:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1c66:	8b 45 08             	mov    0x8(%ebp),%eax
    1c69:	52                   	push   %edx
    1c6a:	50                   	push   %eax
    1c6b:	e8 0b fb ff ff       	call   177b <aes_expandEncKey>
    1c70:	83 c4 08             	add    $0x8,%esp
            rcon = rj_xtime(rcon);
    1c73:	0f b6 45 fe          	movzbl -0x2(%ebp),%eax
    1c77:	50                   	push   %eax
    1c78:	e8 ae f7 ff ff       	call   142b <rj_xtime>
    1c7d:	83 c4 04             	add    $0x4,%esp
    1c80:	88 45 fe             	mov    %al,-0x2(%ebp)
            aes_addRoundKey(buf, ctx->key);
    1c83:	8b 45 08             	mov    0x8(%ebp),%eax
    1c86:	50                   	push   %eax
    1c87:	ff 75 0c             	push   0xc(%ebp)
    1c8a:	e8 07 f8 ff ff       	call   1496 <aes_addRoundKey>
    1c8f:	83 c4 08             	add    $0x8,%esp
    for (i = 1; i < 14; ++i) {
    1c92:	80 45 ff 01          	addb   $0x1,-0x1(%ebp)
    1c96:	80 7d ff 0d          	cmpb   $0xd,-0x1(%ebp)
    1c9a:	76 86                	jbe    1c22 <aes256_encrypt_ecb+0x26>
        }
    }
    aes_subBytes(buf);
    1c9c:	ff 75 0c             	push   0xc(%ebp)
    1c9f:	e8 b7 f7 ff ff       	call   145b <aes_subBytes>
    1ca4:	83 c4 04             	add    $0x4,%esp
    aes_shiftRows(buf);
    1ca7:	ff 75 0c             	push   0xc(%ebp)
    1caa:	e8 97 f8 ff ff       	call   1546 <aes_shiftRows>
    1caf:	83 c4 04             	add    $0x4,%esp
    aes_expandEncKey(ctx->key, rcon);
    1cb2:	0f b6 55 fe          	movzbl -0x2(%ebp),%edx
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	52                   	push   %edx
    1cba:	50                   	push   %eax
    1cbb:	e8 bb fa ff ff       	call   177b <aes_expandEncKey>
    1cc0:	83 c4 08             	add    $0x8,%esp
    aes_addRoundKey(buf, ctx->key);
    1cc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc6:	50                   	push   %eax
    1cc7:	ff 75 0c             	push   0xc(%ebp)
    1cca:	e8 c7 f7 ff ff       	call   1496 <aes_addRoundKey>
    1ccf:	83 c4 08             	add    $0x8,%esp
}
    1cd2:	90                   	nop
    1cd3:	c9                   	leave  
    1cd4:	c3                   	ret    

00001cd5 <aes256_setCtrBlk>:

void aes256_setCtrBlk(aes256_context* ctx, rfc3686_blk* blk) {
    1cd5:	55                   	push   %ebp
    1cd6:	89 e5                	mov    %esp,%ebp
    1cd8:	83 ec 10             	sub    $0x10,%esp
    uchar i;
    uchar* p = (uchar*) &ctx->blk;
    1cdb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cde:	83 c0 40             	add    $0x40,%eax
    1ce1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    uchar* v = (uchar*) blk;
    1ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ce7:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (blk != (void*) 0x0)) {
    1cea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1cee:	74 33                	je     1d23 <aes256_setCtrBlk+0x4e>
    1cf0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1cf4:	74 2d                	je     1d23 <aes256_setCtrBlk+0x4e>
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1cf6:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
    1cfa:	eb 21                	jmp    1d1d <aes256_setCtrBlk+0x48>
            p[i] = v[i];
    1cfc:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1d00:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d03:	01 d0                	add    %edx,%eax
    1d05:	0f b6 4d ff          	movzbl -0x1(%ebp),%ecx
    1d09:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1d0c:	01 ca                	add    %ecx,%edx
    1d0e:	0f b6 00             	movzbl (%eax),%eax
    1d11:	88 02                	mov    %al,(%edx)
        for (i = 0; i < sizeof(ctx->blk); i++) {
    1d13:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
    1d17:	83 c0 01             	add    $0x1,%eax
    1d1a:	88 45 ff             	mov    %al,-0x1(%ebp)
    1d1d:	80 7d ff 0f          	cmpb   $0xf,-0x1(%ebp)
    1d21:	76 d9                	jbe    1cfc <aes256_setCtrBlk+0x27>
        }
    }
}
    1d23:	90                   	nop
    1d24:	c9                   	leave  
    1d25:	c3                   	ret    

00001d26 <aes256_encrypt_ctr>:

void aes256_encrypt_ctr(aes256_context* ctx, uchar* buf, uint sz) {
    1d26:	55                   	push   %ebp
    1d27:	89 e5                	mov    %esp,%ebp
    1d29:	53                   	push   %ebx
    1d2a:	83 ec 24             	sub    $0x24,%esp
    uchar key[sizeof(ctx->blk)];
    uint i;
    uchar j = sizeof(key);
    1d2d:	c6 45 f3 10          	movb   $0x10,-0xd(%ebp)

    for (i = 0; i < sz; i++) {
    1d31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d38:	eb 49                	jmp    1d83 <aes256_encrypt_ctr+0x5d>
        if (j == sizeof(key)) {
    1d3a:	80 7d f3 10          	cmpb   $0x10,-0xd(%ebp)
    1d3e:	75 16                	jne    1d56 <aes256_encrypt_ctr+0x30>
            j = 0;
    1d40:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
            ctr_clock_keystream(ctx, key);
    1d44:	83 ec 08             	sub    $0x8,%esp
    1d47:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1d4a:	50                   	push   %eax
    1d4b:	ff 75 08             	push   0x8(%ebp)
    1d4e:	e8 3d fd ff ff       	call   1a90 <ctr_clock_keystream>
    1d53:	83 c4 10             	add    $0x10,%esp
        }
        buf[i] ^= key[j++];
    1d56:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    1d5a:	8d 50 01             	lea    0x1(%eax),%edx
    1d5d:	88 55 f3             	mov    %dl,-0xd(%ebp)
    1d60:	0f b6 c0             	movzbl %al,%eax
    1d63:	0f b6 4c 05 e3       	movzbl -0x1d(%ebp,%eax,1),%ecx
    1d68:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d6e:	01 d0                	add    %edx,%eax
    1d70:	0f b6 10             	movzbl (%eax),%edx
    1d73:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d79:	01 d8                	add    %ebx,%eax
    1d7b:	31 ca                	xor    %ecx,%edx
    1d7d:	88 10                	mov    %dl,(%eax)
    for (i = 0; i < sz; i++) {
    1d7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d86:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d89:	72 af                	jb     1d3a <aes256_encrypt_ctr+0x14>
    }
}
    1d8b:	90                   	nop
    1d8c:	90                   	nop
    1d8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1d90:	c9                   	leave  
    1d91:	c3                   	ret    

00001d92 <_shb>:
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

FN_ uchar _shb(uint x, uint n) { return ((x >> (n & 31)) & 0xff); }
    1d92:	55                   	push   %ebp
    1d93:	89 e5                	mov    %esp,%ebp
    1d95:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d98:	83 e0 1f             	and    $0x1f,%eax
    1d9b:	8b 55 08             	mov    0x8(%ebp),%edx
    1d9e:	89 c1                	mov    %eax,%ecx
    1da0:	d3 ea                	shr    %cl,%edx
    1da2:	89 d0                	mov    %edx,%eax
    1da4:	5d                   	pop    %ebp
    1da5:	c3                   	ret    

00001da6 <_shw>:

FN_ uint _shw(uint x, uint n) { return ((x << (n & 31)) & 0xffffffff); }
    1da6:	55                   	push   %ebp
    1da7:	89 e5                	mov    %esp,%ebp
    1da9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dac:	83 e0 1f             	and    $0x1f,%eax
    1daf:	8b 55 08             	mov    0x8(%ebp),%edx
    1db2:	89 c1                	mov    %eax,%ecx
    1db4:	d3 e2                	shl    %cl,%edx
    1db6:	89 d0                	mov    %edx,%eax
    1db8:	5d                   	pop    %ebp
    1db9:	c3                   	ret    

00001dba <_r>:

FN_ uint _r(uint x, uchar n) { return ((x >> n) | _shw(x, 32 - n)); }
    1dba:	55                   	push   %ebp
    1dbb:	89 e5                	mov    %esp,%ebp
    1dbd:	53                   	push   %ebx
    1dbe:	83 ec 04             	sub    $0x4,%esp
    1dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dc4:	88 45 f8             	mov    %al,-0x8(%ebp)
    1dc7:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
    1dcb:	8b 55 08             	mov    0x8(%ebp),%edx
    1dce:	89 d3                	mov    %edx,%ebx
    1dd0:	89 c1                	mov    %eax,%ecx
    1dd2:	d3 eb                	shr    %cl,%ebx
    1dd4:	0f b6 55 f8          	movzbl -0x8(%ebp),%edx
    1dd8:	b8 20 00 00 00       	mov    $0x20,%eax
    1ddd:	29 d0                	sub    %edx,%eax
    1ddf:	50                   	push   %eax
    1de0:	ff 75 08             	push   0x8(%ebp)
    1de3:	e8 be ff ff ff       	call   1da6 <_shw>
    1de8:	83 c4 08             	add    $0x8,%esp
    1deb:	09 d8                	or     %ebx,%eax
    1ded:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1df0:	c9                   	leave  
    1df1:	c3                   	ret    

00001df2 <_Ch>:

FN_ uint _Ch(uint x, uint y, uint z) { return ((x & y) ^ ((~x) & z)); }
    1df2:	55                   	push   %ebp
    1df3:	89 e5                	mov    %esp,%ebp
    1df5:	8b 45 08             	mov    0x8(%ebp),%eax
    1df8:	23 45 0c             	and    0xc(%ebp),%eax
    1dfb:	89 c2                	mov    %eax,%edx
    1dfd:	8b 45 08             	mov    0x8(%ebp),%eax
    1e00:	f7 d0                	not    %eax
    1e02:	23 45 10             	and    0x10(%ebp),%eax
    1e05:	31 d0                	xor    %edx,%eax
    1e07:	5d                   	pop    %ebp
    1e08:	c3                   	ret    

00001e09 <_Ma>:

FN_ uint _Ma(uint x, uint y, uint z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    1e09:	55                   	push   %ebp
    1e0a:	89 e5                	mov    %esp,%ebp
    1e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e0f:	33 45 10             	xor    0x10(%ebp),%eax
    1e12:	23 45 08             	and    0x8(%ebp),%eax
    1e15:	89 c2                	mov    %eax,%edx
    1e17:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e1a:	23 45 10             	and    0x10(%ebp),%eax
    1e1d:	31 d0                	xor    %edx,%eax
    1e1f:	5d                   	pop    %ebp
    1e20:	c3                   	ret    

00001e21 <_S0>:

FN_ uint _S0(uint x) { return (_r(x, 2) ^ _r(x, 13) ^ _r(x, 22)); }
    1e21:	55                   	push   %ebp
    1e22:	89 e5                	mov    %esp,%ebp
    1e24:	53                   	push   %ebx
    1e25:	6a 02                	push   $0x2
    1e27:	ff 75 08             	push   0x8(%ebp)
    1e2a:	e8 8b ff ff ff       	call   1dba <_r>
    1e2f:	83 c4 08             	add    $0x8,%esp
    1e32:	89 c3                	mov    %eax,%ebx
    1e34:	6a 0d                	push   $0xd
    1e36:	ff 75 08             	push   0x8(%ebp)
    1e39:	e8 7c ff ff ff       	call   1dba <_r>
    1e3e:	83 c4 08             	add    $0x8,%esp
    1e41:	31 c3                	xor    %eax,%ebx
    1e43:	6a 16                	push   $0x16
    1e45:	ff 75 08             	push   0x8(%ebp)
    1e48:	e8 6d ff ff ff       	call   1dba <_r>
    1e4d:	83 c4 08             	add    $0x8,%esp
    1e50:	31 d8                	xor    %ebx,%eax
    1e52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1e55:	c9                   	leave  
    1e56:	c3                   	ret    

00001e57 <_S1>:

FN_ uint _S1(uint x) { return (_r(x, 6) ^ _r(x, 11) ^ _r(x, 25)); }
    1e57:	55                   	push   %ebp
    1e58:	89 e5                	mov    %esp,%ebp
    1e5a:	53                   	push   %ebx
    1e5b:	6a 06                	push   $0x6
    1e5d:	ff 75 08             	push   0x8(%ebp)
    1e60:	e8 55 ff ff ff       	call   1dba <_r>
    1e65:	83 c4 08             	add    $0x8,%esp
    1e68:	89 c3                	mov    %eax,%ebx
    1e6a:	6a 0b                	push   $0xb
    1e6c:	ff 75 08             	push   0x8(%ebp)
    1e6f:	e8 46 ff ff ff       	call   1dba <_r>
    1e74:	83 c4 08             	add    $0x8,%esp
    1e77:	31 c3                	xor    %eax,%ebx
    1e79:	6a 19                	push   $0x19
    1e7b:	ff 75 08             	push   0x8(%ebp)
    1e7e:	e8 37 ff ff ff       	call   1dba <_r>
    1e83:	83 c4 08             	add    $0x8,%esp
    1e86:	31 d8                	xor    %ebx,%eax
    1e88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1e8b:	c9                   	leave  
    1e8c:	c3                   	ret    

00001e8d <_G0>:

FN_ uint _G0(uint x) { return (_r(x, 7) ^ _r(x, 18) ^ (x >> 3)); }
    1e8d:	55                   	push   %ebp
    1e8e:	89 e5                	mov    %esp,%ebp
    1e90:	53                   	push   %ebx
    1e91:	6a 07                	push   $0x7
    1e93:	ff 75 08             	push   0x8(%ebp)
    1e96:	e8 1f ff ff ff       	call   1dba <_r>
    1e9b:	83 c4 08             	add    $0x8,%esp
    1e9e:	89 c3                	mov    %eax,%ebx
    1ea0:	6a 12                	push   $0x12
    1ea2:	ff 75 08             	push   0x8(%ebp)
    1ea5:	e8 10 ff ff ff       	call   1dba <_r>
    1eaa:	83 c4 08             	add    $0x8,%esp
    1ead:	89 da                	mov    %ebx,%edx
    1eaf:	31 c2                	xor    %eax,%edx
    1eb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb4:	c1 e8 03             	shr    $0x3,%eax
    1eb7:	31 d0                	xor    %edx,%eax
    1eb9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ebc:	c9                   	leave  
    1ebd:	c3                   	ret    

00001ebe <_G1>:

FN_ uint _G1(uint x) { return (_r(x, 17) ^ _r(x, 19) ^ (x >> 10)); }
    1ebe:	55                   	push   %ebp
    1ebf:	89 e5                	mov    %esp,%ebp
    1ec1:	53                   	push   %ebx
    1ec2:	6a 11                	push   $0x11
    1ec4:	ff 75 08             	push   0x8(%ebp)
    1ec7:	e8 ee fe ff ff       	call   1dba <_r>
    1ecc:	83 c4 08             	add    $0x8,%esp
    1ecf:	89 c3                	mov    %eax,%ebx
    1ed1:	6a 13                	push   $0x13
    1ed3:	ff 75 08             	push   0x8(%ebp)
    1ed6:	e8 df fe ff ff       	call   1dba <_r>
    1edb:	83 c4 08             	add    $0x8,%esp
    1ede:	89 da                	mov    %ebx,%edx
    1ee0:	31 c2                	xor    %eax,%edx
    1ee2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee5:	c1 e8 0a             	shr    $0xa,%eax
    1ee8:	31 d0                	xor    %edx,%eax
    1eea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1eed:	c9                   	leave  
    1eee:	c3                   	ret    

00001eef <_word>:

FN_ uint _word(uchar* c) {
    1eef:	55                   	push   %ebp
    1ef0:	89 e5                	mov    %esp,%ebp
    1ef2:	53                   	push   %ebx
    return (_shw(c[0], 24) | _shw(c[1], 16) | _shw(c[2], 8) | (c[3]));
    1ef3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef6:	0f b6 00             	movzbl (%eax),%eax
    1ef9:	0f b6 c0             	movzbl %al,%eax
    1efc:	6a 18                	push   $0x18
    1efe:	50                   	push   %eax
    1eff:	e8 a2 fe ff ff       	call   1da6 <_shw>
    1f04:	83 c4 08             	add    $0x8,%esp
    1f07:	89 c3                	mov    %eax,%ebx
    1f09:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0c:	83 c0 01             	add    $0x1,%eax
    1f0f:	0f b6 00             	movzbl (%eax),%eax
    1f12:	0f b6 c0             	movzbl %al,%eax
    1f15:	6a 10                	push   $0x10
    1f17:	50                   	push   %eax
    1f18:	e8 89 fe ff ff       	call   1da6 <_shw>
    1f1d:	83 c4 08             	add    $0x8,%esp
    1f20:	09 c3                	or     %eax,%ebx
    1f22:	8b 45 08             	mov    0x8(%ebp),%eax
    1f25:	83 c0 02             	add    $0x2,%eax
    1f28:	0f b6 00             	movzbl (%eax),%eax
    1f2b:	0f b6 c0             	movzbl %al,%eax
    1f2e:	6a 08                	push   $0x8
    1f30:	50                   	push   %eax
    1f31:	e8 70 fe ff ff       	call   1da6 <_shw>
    1f36:	83 c4 08             	add    $0x8,%esp
    1f39:	89 da                	mov    %ebx,%edx
    1f3b:	09 c2                	or     %eax,%edx
    1f3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f40:	83 c0 03             	add    $0x3,%eax
    1f43:	0f b6 00             	movzbl (%eax),%eax
    1f46:	0f b6 c0             	movzbl %al,%eax
    1f49:	09 d0                	or     %edx,%eax
}
    1f4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f4e:	c9                   	leave  
    1f4f:	c3                   	ret    

00001f50 <_addbits>:

static void _addbits(sha256_context* ctx, uint n) {
    1f50:	55                   	push   %ebp
    1f51:	89 e5                	mov    %esp,%ebp
    if (ctx->bits[0] > (0xffffffff - n)) {
    1f53:	8b 45 08             	mov    0x8(%ebp),%eax
    1f56:	8b 40 60             	mov    0x60(%eax),%eax
    1f59:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f5c:	f7 d2                	not    %edx
    1f5e:	39 d0                	cmp    %edx,%eax
    1f60:	76 0f                	jbe    1f71 <_addbits+0x21>
        ctx->bits[1] = (ctx->bits[1] + 1) & 0xFFFFFFFF;
    1f62:	8b 45 08             	mov    0x8(%ebp),%eax
    1f65:	8b 40 64             	mov    0x64(%eax),%eax
    1f68:	8d 50 01             	lea    0x1(%eax),%edx
    1f6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6e:	89 50 64             	mov    %edx,0x64(%eax)
    }
    ctx->bits[0] = (ctx->bits[0] + n) & 0xFFFFFFFF;
    1f71:	8b 45 08             	mov    0x8(%ebp),%eax
    1f74:	8b 50 60             	mov    0x60(%eax),%edx
    1f77:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f7a:	01 c2                	add    %eax,%edx
    1f7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7f:	89 50 60             	mov    %edx,0x60(%eax)
}
    1f82:	90                   	nop
    1f83:	5d                   	pop    %ebp
    1f84:	c3                   	ret    

00001f85 <_hash>:

static void _hash(sha256_context* ctx) {
    1f85:	55                   	push   %ebp
    1f86:	89 e5                	mov    %esp,%ebp
    1f88:	57                   	push   %edi
    1f89:	56                   	push   %esi
    1f8a:	53                   	push   %ebx
    1f8b:	83 ec 28             	sub    $0x28,%esp
    register uint a, b, c, d, e, f, g, h;
    uint t[2];

    a = ctx->hash[0];
    1f8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f91:	8b 70 40             	mov    0x40(%eax),%esi
    b = ctx->hash[1];
    1f94:	8b 45 08             	mov    0x8(%ebp),%eax
    1f97:	8b 40 44             	mov    0x44(%eax),%eax
    1f9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    c = ctx->hash[2];
    1f9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa0:	8b 40 48             	mov    0x48(%eax),%eax
    1fa3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    d = ctx->hash[3];
    1fa6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa9:	8b 40 4c             	mov    0x4c(%eax),%eax
    1fac:	89 45 d0             	mov    %eax,-0x30(%ebp)
    e = ctx->hash[4];
    1faf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb2:	8b 78 50             	mov    0x50(%eax),%edi
    f = ctx->hash[5];
    1fb5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb8:	8b 40 54             	mov    0x54(%eax),%eax
    1fbb:	89 45 d8             	mov    %eax,-0x28(%ebp)
    g = ctx->hash[6];
    1fbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc1:	8b 40 58             	mov    0x58(%eax),%eax
    1fc4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    h = ctx->hash[7];
    1fc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fca:	8b 40 5c             	mov    0x5c(%eax),%eax
    1fcd:	89 45 cc             	mov    %eax,-0x34(%ebp)

    for (uint i = 0; i < 64; i++) {
    1fd0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1fd7:	e9 27 01 00 00       	jmp    2103 <_hash+0x17e>
        if (i < 16) {
    1fdc:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
    1fe0:	77 2d                	ja     200f <_hash+0x8a>
            ctx->W[i] = _word(&ctx->buf[_shw(i, 2)]);
    1fe2:	6a 02                	push   $0x2
    1fe4:	ff 75 f0             	push   -0x10(%ebp)
    1fe7:	e8 ba fd ff ff       	call   1da6 <_shw>
    1fec:	83 c4 08             	add    $0x8,%esp
    1fef:	89 c2                	mov    %eax,%edx
    1ff1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff4:	01 d0                	add    %edx,%eax
    1ff6:	50                   	push   %eax
    1ff7:	e8 f3 fe ff ff       	call   1eef <_word>
    1ffc:	83 c4 04             	add    $0x4,%esp
    1fff:	89 c1                	mov    %eax,%ecx
    2001:	8b 55 08             	mov    0x8(%ebp),%edx
    2004:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2007:	83 c0 1c             	add    $0x1c,%eax
    200a:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    200d:	eb 64                	jmp    2073 <_hash+0xee>
        } else {
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    200f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2012:	83 e8 02             	sub    $0x2,%eax
    2015:	8b 55 08             	mov    0x8(%ebp),%edx
    2018:	83 c0 1c             	add    $0x1c,%eax
    201b:	8b 04 82             	mov    (%edx,%eax,4),%eax
    201e:	50                   	push   %eax
    201f:	e8 9a fe ff ff       	call   1ebe <_G1>
    2024:	83 c4 04             	add    $0x4,%esp
    2027:	89 c1                	mov    %eax,%ecx
    2029:	8b 45 f0             	mov    -0x10(%ebp),%eax
    202c:	83 e8 07             	sub    $0x7,%eax
    202f:	8b 55 08             	mov    0x8(%ebp),%edx
    2032:	83 c0 1c             	add    $0x1c,%eax
    2035:	8b 04 82             	mov    (%edx,%eax,4),%eax
    2038:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    203b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    203e:	83 e8 0f             	sub    $0xf,%eax
    2041:	8b 55 08             	mov    0x8(%ebp),%edx
    2044:	83 c0 1c             	add    $0x1c,%eax
    2047:	8b 04 82             	mov    (%edx,%eax,4),%eax
    204a:	50                   	push   %eax
    204b:	e8 3d fe ff ff       	call   1e8d <_G0>
    2050:	83 c4 04             	add    $0x4,%esp
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    2053:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
                        _G0(ctx->W[i - 15]) + ctx->W[i - 16];
    2056:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2059:	83 e8 10             	sub    $0x10,%eax
    205c:	8b 55 08             	mov    0x8(%ebp),%edx
    205f:	83 c0 1c             	add    $0x1c,%eax
    2062:	8b 04 82             	mov    (%edx,%eax,4),%eax
    2065:	01 c1                	add    %eax,%ecx
            ctx->W[i] = _G1(ctx->W[i - 2]) + ctx->W[i - 7] +
    2067:	8b 55 08             	mov    0x8(%ebp),%edx
    206a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    206d:	83 c0 1c             	add    $0x1c,%eax
    2070:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
        }

        t[0] = h + _S1(e) + _Ch(e, f, g) + K[i] + ctx->W[i];
    2073:	57                   	push   %edi
    2074:	e8 de fd ff ff       	call   1e57 <_S1>
    2079:	83 c4 04             	add    $0x4,%esp
    207c:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    207f:	01 c3                	add    %eax,%ebx
    2081:	ff 75 d4             	push   -0x2c(%ebp)
    2084:	ff 75 d8             	push   -0x28(%ebp)
    2087:	57                   	push   %edi
    2088:	e8 65 fd ff ff       	call   1df2 <_Ch>
    208d:	83 c4 0c             	add    $0xc,%esp
    2090:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    2093:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2096:	8b 04 85 40 2d 00 00 	mov    0x2d40(,%eax,4),%eax
    209d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    20a0:	8b 55 08             	mov    0x8(%ebp),%edx
    20a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20a6:	83 c0 1c             	add    $0x1c,%eax
    20a9:	8b 04 82             	mov    (%edx,%eax,4),%eax
    20ac:	01 c8                	add    %ecx,%eax
    20ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
        t[1] = _S0(a) + _Ma(a, b, c);
    20b1:	56                   	push   %esi
    20b2:	e8 6a fd ff ff       	call   1e21 <_S0>
    20b7:	83 c4 04             	add    $0x4,%esp
    20ba:	89 c3                	mov    %eax,%ebx
    20bc:	ff 75 dc             	push   -0x24(%ebp)
    20bf:	ff 75 e0             	push   -0x20(%ebp)
    20c2:	56                   	push   %esi
    20c3:	e8 41 fd ff ff       	call   1e09 <_Ma>
    20c8:	83 c4 0c             	add    $0xc,%esp
    20cb:	01 d8                	add    %ebx,%eax
    20cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
        h = g;
    20d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    20d3:	89 45 cc             	mov    %eax,-0x34(%ebp)
        g = f;
    20d6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    20d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        f = e;
    20dc:	89 7d d8             	mov    %edi,-0x28(%ebp)
        e = d + t[0];
    20df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20e2:	8b 7d d0             	mov    -0x30(%ebp),%edi
    20e5:	01 c7                	add    %eax,%edi
        d = c;
    20e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    20ea:	89 45 d0             	mov    %eax,-0x30(%ebp)
        c = b;
    20ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
        b = a;
    20f3:	89 75 e0             	mov    %esi,-0x20(%ebp)
        a = t[0] + t[1];
    20f6:	8b 55 e8             	mov    -0x18(%ebp),%edx
    20f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20fc:	8d 34 02             	lea    (%edx,%eax,1),%esi
    for (uint i = 0; i < 64; i++) {
    20ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2103:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    2107:	0f 86 cf fe ff ff    	jbe    1fdc <_hash+0x57>
    }

    ctx->hash[0] += a;
    210d:	8b 45 08             	mov    0x8(%ebp),%eax
    2110:	8b 40 40             	mov    0x40(%eax),%eax
    2113:	8d 14 06             	lea    (%esi,%eax,1),%edx
    2116:	8b 45 08             	mov    0x8(%ebp),%eax
    2119:	89 50 40             	mov    %edx,0x40(%eax)
    ctx->hash[1] += b;
    211c:	8b 45 08             	mov    0x8(%ebp),%eax
    211f:	8b 40 44             	mov    0x44(%eax),%eax
    2122:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2125:	01 c2                	add    %eax,%edx
    2127:	8b 45 08             	mov    0x8(%ebp),%eax
    212a:	89 50 44             	mov    %edx,0x44(%eax)
    ctx->hash[2] += c;
    212d:	8b 45 08             	mov    0x8(%ebp),%eax
    2130:	8b 40 48             	mov    0x48(%eax),%eax
    2133:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2136:	01 c2                	add    %eax,%edx
    2138:	8b 45 08             	mov    0x8(%ebp),%eax
    213b:	89 50 48             	mov    %edx,0x48(%eax)
    ctx->hash[3] += d;
    213e:	8b 45 08             	mov    0x8(%ebp),%eax
    2141:	8b 40 4c             	mov    0x4c(%eax),%eax
    2144:	8b 55 d0             	mov    -0x30(%ebp),%edx
    2147:	01 c2                	add    %eax,%edx
    2149:	8b 45 08             	mov    0x8(%ebp),%eax
    214c:	89 50 4c             	mov    %edx,0x4c(%eax)
    ctx->hash[4] += e;
    214f:	8b 45 08             	mov    0x8(%ebp),%eax
    2152:	8b 40 50             	mov    0x50(%eax),%eax
    2155:	8d 14 07             	lea    (%edi,%eax,1),%edx
    2158:	8b 45 08             	mov    0x8(%ebp),%eax
    215b:	89 50 50             	mov    %edx,0x50(%eax)
    ctx->hash[5] += f;
    215e:	8b 45 08             	mov    0x8(%ebp),%eax
    2161:	8b 40 54             	mov    0x54(%eax),%eax
    2164:	8b 55 d8             	mov    -0x28(%ebp),%edx
    2167:	01 c2                	add    %eax,%edx
    2169:	8b 45 08             	mov    0x8(%ebp),%eax
    216c:	89 50 54             	mov    %edx,0x54(%eax)
    ctx->hash[6] += g;
    216f:	8b 45 08             	mov    0x8(%ebp),%eax
    2172:	8b 40 58             	mov    0x58(%eax),%eax
    2175:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    2178:	01 c2                	add    %eax,%edx
    217a:	8b 45 08             	mov    0x8(%ebp),%eax
    217d:	89 50 58             	mov    %edx,0x58(%eax)
    ctx->hash[7] += h;
    2180:	8b 45 08             	mov    0x8(%ebp),%eax
    2183:	8b 40 5c             	mov    0x5c(%eax),%eax
    2186:	8b 55 cc             	mov    -0x34(%ebp),%edx
    2189:	01 c2                	add    %eax,%edx
    218b:	8b 45 08             	mov    0x8(%ebp),%eax
    218e:	89 50 5c             	mov    %edx,0x5c(%eax)
}
    2191:	90                   	nop
    2192:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2195:	5b                   	pop    %ebx
    2196:	5e                   	pop    %esi
    2197:	5f                   	pop    %edi
    2198:	5d                   	pop    %ebp
    2199:	c3                   	ret    

0000219a <sha256>:

void sha256(const void* data, uint len, uchar* hash) {
    219a:	55                   	push   %ebp
    219b:	89 e5                	mov    %esp,%ebp
    219d:	81 ec 78 01 00 00    	sub    $0x178,%esp
    sha256_context ctx;
    sha256_init(&ctx);
    21a3:	83 ec 0c             	sub    $0xc,%esp
    21a6:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    21ac:	50                   	push   %eax
    21ad:	e8 33 00 00 00       	call   21e5 <sha256_init>
    21b2:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&ctx, data, len);
    21b5:	83 ec 04             	sub    $0x4,%esp
    21b8:	ff 75 0c             	push   0xc(%ebp)
    21bb:	ff 75 08             	push   0x8(%ebp)
    21be:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    21c4:	50                   	push   %eax
    21c5:	e8 99 00 00 00       	call   2263 <sha256_hash>
    21ca:	83 c4 10             	add    $0x10,%esp
    sha256_done(&ctx, hash);
    21cd:	83 ec 08             	sub    $0x8,%esp
    21d0:	ff 75 10             	push   0x10(%ebp)
    21d3:	8d 85 88 fe ff ff    	lea    -0x178(%ebp),%eax
    21d9:	50                   	push   %eax
    21da:	e8 14 01 00 00       	call   22f3 <sha256_done>
    21df:	83 c4 10             	add    $0x10,%esp
}
    21e2:	90                   	nop
    21e3:	c9                   	leave  
    21e4:	c3                   	ret    

000021e5 <sha256_init>:

void sha256_init(sha256_context* ctx) {
    21e5:	55                   	push   %ebp
    21e6:	89 e5                	mov    %esp,%ebp
    if (ctx != (void*) 0x0) {
    21e8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    21ec:	74 72                	je     2260 <sha256_init+0x7b>
        ctx->bits[0] = ctx->bits[1] = ctx->len = 0;
    21ee:	8b 45 08             	mov    0x8(%ebp),%eax
    21f1:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
    21f8:	8b 45 08             	mov    0x8(%ebp),%eax
    21fb:	8b 50 68             	mov    0x68(%eax),%edx
    21fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2201:	89 50 64             	mov    %edx,0x64(%eax)
    2204:	8b 45 08             	mov    0x8(%ebp),%eax
    2207:	8b 50 64             	mov    0x64(%eax),%edx
    220a:	8b 45 08             	mov    0x8(%ebp),%eax
    220d:	89 50 60             	mov    %edx,0x60(%eax)
        ctx->hash[0] = 0x6a09e667;
    2210:	8b 45 08             	mov    0x8(%ebp),%eax
    2213:	c7 40 40 67 e6 09 6a 	movl   $0x6a09e667,0x40(%eax)
        ctx->hash[1] = 0xbb67ae85;
    221a:	8b 45 08             	mov    0x8(%ebp),%eax
    221d:	c7 40 44 85 ae 67 bb 	movl   $0xbb67ae85,0x44(%eax)
        ctx->hash[2] = 0x3c6ef372;
    2224:	8b 45 08             	mov    0x8(%ebp),%eax
    2227:	c7 40 48 72 f3 6e 3c 	movl   $0x3c6ef372,0x48(%eax)
        ctx->hash[3] = 0xa54ff53a;
    222e:	8b 45 08             	mov    0x8(%ebp),%eax
    2231:	c7 40 4c 3a f5 4f a5 	movl   $0xa54ff53a,0x4c(%eax)
        ctx->hash[4] = 0x510e527f;
    2238:	8b 45 08             	mov    0x8(%ebp),%eax
    223b:	c7 40 50 7f 52 0e 51 	movl   $0x510e527f,0x50(%eax)
        ctx->hash[5] = 0x9b05688c;
    2242:	8b 45 08             	mov    0x8(%ebp),%eax
    2245:	c7 40 54 8c 68 05 9b 	movl   $0x9b05688c,0x54(%eax)
        ctx->hash[6] = 0x1f83d9ab;
    224c:	8b 45 08             	mov    0x8(%ebp),%eax
    224f:	c7 40 58 ab d9 83 1f 	movl   $0x1f83d9ab,0x58(%eax)
        ctx->hash[7] = 0x5be0cd19;
    2256:	8b 45 08             	mov    0x8(%ebp),%eax
    2259:	c7 40 5c 19 cd e0 5b 	movl   $0x5be0cd19,0x5c(%eax)
    }
}
    2260:	90                   	nop
    2261:	5d                   	pop    %ebp
    2262:	c3                   	ret    

00002263 <sha256_hash>:

void sha256_hash(sha256_context* ctx, const void* data, uint len) {
    2263:	55                   	push   %ebp
    2264:	89 e5                	mov    %esp,%ebp
    2266:	53                   	push   %ebx
    2267:	83 ec 10             	sub    $0x10,%esp
    const uchar* bytes = (const uchar*) data;
    226a:	8b 45 0c             	mov    0xc(%ebp),%eax
    226d:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    2270:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2274:	74 77                	je     22ed <sha256_hash+0x8a>
    2276:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    227a:	74 71                	je     22ed <sha256_hash+0x8a>
        (ctx->len < sizeof(ctx->buf))) {
    227c:	8b 45 08             	mov    0x8(%ebp),%eax
    227f:	8b 40 68             	mov    0x68(%eax),%eax
    if ((ctx != (void*) 0x0) && (bytes != (void*) 0x0) &&
    2282:	83 f8 3f             	cmp    $0x3f,%eax
    2285:	77 66                	ja     22ed <sha256_hash+0x8a>
        for (uint i = 0; i < len; i++) {
    2287:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    228e:	eb 55                	jmp    22e5 <sha256_hash+0x82>
            ctx->buf[ctx->len++] = bytes[i];
    2290:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2293:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2296:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    2299:	8b 45 08             	mov    0x8(%ebp),%eax
    229c:	8b 40 68             	mov    0x68(%eax),%eax
    229f:	8d 48 01             	lea    0x1(%eax),%ecx
    22a2:	8b 55 08             	mov    0x8(%ebp),%edx
    22a5:	89 4a 68             	mov    %ecx,0x68(%edx)
    22a8:	0f b6 0b             	movzbl (%ebx),%ecx
    22ab:	8b 55 08             	mov    0x8(%ebp),%edx
    22ae:	88 0c 02             	mov    %cl,(%edx,%eax,1)
            if (ctx->len == sizeof(ctx->buf)) {
    22b1:	8b 45 08             	mov    0x8(%ebp),%eax
    22b4:	8b 40 68             	mov    0x68(%eax),%eax
    22b7:	83 f8 40             	cmp    $0x40,%eax
    22ba:	75 25                	jne    22e1 <sha256_hash+0x7e>
                _hash(ctx);
    22bc:	ff 75 08             	push   0x8(%ebp)
    22bf:	e8 c1 fc ff ff       	call   1f85 <_hash>
    22c4:	83 c4 04             	add    $0x4,%esp
                _addbits(ctx, sizeof(ctx->buf) * 8);
    22c7:	68 00 02 00 00       	push   $0x200
    22cc:	ff 75 08             	push   0x8(%ebp)
    22cf:	e8 7c fc ff ff       	call   1f50 <_addbits>
    22d4:	83 c4 08             	add    $0x8,%esp
                ctx->len = 0;
    22d7:	8b 45 08             	mov    0x8(%ebp),%eax
    22da:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
        for (uint i = 0; i < len; i++) {
    22e1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    22e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22e8:	3b 45 10             	cmp    0x10(%ebp),%eax
    22eb:	72 a3                	jb     2290 <sha256_hash+0x2d>
            }
        }
    }
}
    22ed:	90                   	nop
    22ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    22f1:	c9                   	leave  
    22f2:	c3                   	ret    

000022f3 <sha256_done>:

void sha256_done(sha256_context* ctx, uchar* hash) {
    22f3:	55                   	push   %ebp
    22f4:	89 e5                	mov    %esp,%ebp
    22f6:	57                   	push   %edi
    22f7:	56                   	push   %esi
    22f8:	53                   	push   %ebx
    register uint i, j;

    if (ctx != (void*) 0x0) {
    22f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    22fd:	0f 84 27 02 00 00    	je     252a <sha256_done+0x237>
        j = ctx->len % sizeof(ctx->buf);
    2303:	8b 45 08             	mov    0x8(%ebp),%eax
    2306:	8b 40 68             	mov    0x68(%eax),%eax
    2309:	83 e0 3f             	and    $0x3f,%eax
    230c:	89 c3                	mov    %eax,%ebx
        ctx->buf[j] = 0x80;
    230e:	8b 45 08             	mov    0x8(%ebp),%eax
    2311:	c6 04 18 80          	movb   $0x80,(%eax,%ebx,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    2315:	8d 73 01             	lea    0x1(%ebx),%esi
    2318:	eb 0a                	jmp    2324 <sha256_done+0x31>
            ctx->buf[i] = 0x00;
    231a:	8b 45 08             	mov    0x8(%ebp),%eax
    231d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        for (i = j + 1; i < sizeof(ctx->buf); i++) {
    2321:	83 c6 01             	add    $0x1,%esi
    2324:	83 fe 3f             	cmp    $0x3f,%esi
    2327:	76 f1                	jbe    231a <sha256_done+0x27>
        }

        if (ctx->len > 55) {
    2329:	8b 45 08             	mov    0x8(%ebp),%eax
    232c:	8b 40 68             	mov    0x68(%eax),%eax
    232f:	83 f8 37             	cmp    $0x37,%eax
    2332:	76 21                	jbe    2355 <sha256_done+0x62>
            _hash(ctx);
    2334:	ff 75 08             	push   0x8(%ebp)
    2337:	e8 49 fc ff ff       	call   1f85 <_hash>
    233c:	83 c4 04             	add    $0x4,%esp
            for (j = 0; j < sizeof(ctx->buf); j++) {
    233f:	bb 00 00 00 00       	mov    $0x0,%ebx
    2344:	eb 0a                	jmp    2350 <sha256_done+0x5d>
                ctx->buf[j] = 0x00;
    2346:	8b 45 08             	mov    0x8(%ebp),%eax
    2349:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            for (j = 0; j < sizeof(ctx->buf); j++) {
    234d:	83 c3 01             	add    $0x1,%ebx
    2350:	83 fb 3f             	cmp    $0x3f,%ebx
    2353:	76 f1                	jbe    2346 <sha256_done+0x53>
            }
        }

        _addbits(ctx, ctx->len * 8);
    2355:	8b 45 08             	mov    0x8(%ebp),%eax
    2358:	8b 40 68             	mov    0x68(%eax),%eax
    235b:	c1 e0 03             	shl    $0x3,%eax
    235e:	50                   	push   %eax
    235f:	ff 75 08             	push   0x8(%ebp)
    2362:	e8 e9 fb ff ff       	call   1f50 <_addbits>
    2367:	83 c4 08             	add    $0x8,%esp
        ctx->buf[63] = _shb(ctx->bits[0], 0);
    236a:	8b 45 08             	mov    0x8(%ebp),%eax
    236d:	8b 40 60             	mov    0x60(%eax),%eax
    2370:	6a 00                	push   $0x0
    2372:	50                   	push   %eax
    2373:	e8 1a fa ff ff       	call   1d92 <_shb>
    2378:	83 c4 08             	add    $0x8,%esp
    237b:	8b 55 08             	mov    0x8(%ebp),%edx
    237e:	88 42 3f             	mov    %al,0x3f(%edx)
        ctx->buf[62] = _shb(ctx->bits[0], 8);
    2381:	8b 45 08             	mov    0x8(%ebp),%eax
    2384:	8b 40 60             	mov    0x60(%eax),%eax
    2387:	6a 08                	push   $0x8
    2389:	50                   	push   %eax
    238a:	e8 03 fa ff ff       	call   1d92 <_shb>
    238f:	83 c4 08             	add    $0x8,%esp
    2392:	8b 55 08             	mov    0x8(%ebp),%edx
    2395:	88 42 3e             	mov    %al,0x3e(%edx)
        ctx->buf[61] = _shb(ctx->bits[0], 16);
    2398:	8b 45 08             	mov    0x8(%ebp),%eax
    239b:	8b 40 60             	mov    0x60(%eax),%eax
    239e:	6a 10                	push   $0x10
    23a0:	50                   	push   %eax
    23a1:	e8 ec f9 ff ff       	call   1d92 <_shb>
    23a6:	83 c4 08             	add    $0x8,%esp
    23a9:	8b 55 08             	mov    0x8(%ebp),%edx
    23ac:	88 42 3d             	mov    %al,0x3d(%edx)
        ctx->buf[60] = _shb(ctx->bits[0], 24);
    23af:	8b 45 08             	mov    0x8(%ebp),%eax
    23b2:	8b 40 60             	mov    0x60(%eax),%eax
    23b5:	6a 18                	push   $0x18
    23b7:	50                   	push   %eax
    23b8:	e8 d5 f9 ff ff       	call   1d92 <_shb>
    23bd:	83 c4 08             	add    $0x8,%esp
    23c0:	8b 55 08             	mov    0x8(%ebp),%edx
    23c3:	88 42 3c             	mov    %al,0x3c(%edx)
        ctx->buf[59] = _shb(ctx->bits[1], 0);
    23c6:	8b 45 08             	mov    0x8(%ebp),%eax
    23c9:	8b 40 64             	mov    0x64(%eax),%eax
    23cc:	6a 00                	push   $0x0
    23ce:	50                   	push   %eax
    23cf:	e8 be f9 ff ff       	call   1d92 <_shb>
    23d4:	83 c4 08             	add    $0x8,%esp
    23d7:	8b 55 08             	mov    0x8(%ebp),%edx
    23da:	88 42 3b             	mov    %al,0x3b(%edx)
        ctx->buf[58] = _shb(ctx->bits[1], 8);
    23dd:	8b 45 08             	mov    0x8(%ebp),%eax
    23e0:	8b 40 64             	mov    0x64(%eax),%eax
    23e3:	6a 08                	push   $0x8
    23e5:	50                   	push   %eax
    23e6:	e8 a7 f9 ff ff       	call   1d92 <_shb>
    23eb:	83 c4 08             	add    $0x8,%esp
    23ee:	8b 55 08             	mov    0x8(%ebp),%edx
    23f1:	88 42 3a             	mov    %al,0x3a(%edx)
        ctx->buf[57] = _shb(ctx->bits[1], 16);
    23f4:	8b 45 08             	mov    0x8(%ebp),%eax
    23f7:	8b 40 64             	mov    0x64(%eax),%eax
    23fa:	6a 10                	push   $0x10
    23fc:	50                   	push   %eax
    23fd:	e8 90 f9 ff ff       	call   1d92 <_shb>
    2402:	83 c4 08             	add    $0x8,%esp
    2405:	8b 55 08             	mov    0x8(%ebp),%edx
    2408:	88 42 39             	mov    %al,0x39(%edx)
        ctx->buf[56] = _shb(ctx->bits[1], 24);
    240b:	8b 45 08             	mov    0x8(%ebp),%eax
    240e:	8b 40 64             	mov    0x64(%eax),%eax
    2411:	6a 18                	push   $0x18
    2413:	50                   	push   %eax
    2414:	e8 79 f9 ff ff       	call   1d92 <_shb>
    2419:	83 c4 08             	add    $0x8,%esp
    241c:	8b 55 08             	mov    0x8(%ebp),%edx
    241f:	88 42 38             	mov    %al,0x38(%edx)
        _hash(ctx);
    2422:	ff 75 08             	push   0x8(%ebp)
    2425:	e8 5b fb ff ff       	call   1f85 <_hash>
    242a:	83 c4 04             	add    $0x4,%esp

        if (hash != (void*) 0x0) {
    242d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2431:	0f 84 f3 00 00 00    	je     252a <sha256_done+0x237>
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    2437:	be 00 00 00 00       	mov    $0x0,%esi
    243c:	bb 18 00 00 00       	mov    $0x18,%ebx
    2441:	e9 db 00 00 00       	jmp    2521 <sha256_done+0x22e>
                hash[i + 0] = _shb(ctx->hash[0], j);
    2446:	8b 45 08             	mov    0x8(%ebp),%eax
    2449:	8b 40 40             	mov    0x40(%eax),%eax
    244c:	8b 55 0c             	mov    0xc(%ebp),%edx
    244f:	8d 3c 16             	lea    (%esi,%edx,1),%edi
    2452:	53                   	push   %ebx
    2453:	50                   	push   %eax
    2454:	e8 39 f9 ff ff       	call   1d92 <_shb>
    2459:	83 c4 08             	add    $0x8,%esp
    245c:	88 07                	mov    %al,(%edi)
                hash[i + 4] = _shb(ctx->hash[1], j);
    245e:	8b 45 08             	mov    0x8(%ebp),%eax
    2461:	8b 40 44             	mov    0x44(%eax),%eax
    2464:	8d 4e 04             	lea    0x4(%esi),%ecx
    2467:	8b 55 0c             	mov    0xc(%ebp),%edx
    246a:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    246d:	53                   	push   %ebx
    246e:	50                   	push   %eax
    246f:	e8 1e f9 ff ff       	call   1d92 <_shb>
    2474:	83 c4 08             	add    $0x8,%esp
    2477:	88 07                	mov    %al,(%edi)
                hash[i + 8] = _shb(ctx->hash[2], j);
    2479:	8b 45 08             	mov    0x8(%ebp),%eax
    247c:	8b 40 48             	mov    0x48(%eax),%eax
    247f:	8d 4e 08             	lea    0x8(%esi),%ecx
    2482:	8b 55 0c             	mov    0xc(%ebp),%edx
    2485:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    2488:	53                   	push   %ebx
    2489:	50                   	push   %eax
    248a:	e8 03 f9 ff ff       	call   1d92 <_shb>
    248f:	83 c4 08             	add    $0x8,%esp
    2492:	88 07                	mov    %al,(%edi)
                hash[i + 12] = _shb(ctx->hash[3], j);
    2494:	8b 45 08             	mov    0x8(%ebp),%eax
    2497:	8b 40 4c             	mov    0x4c(%eax),%eax
    249a:	8d 4e 0c             	lea    0xc(%esi),%ecx
    249d:	8b 55 0c             	mov    0xc(%ebp),%edx
    24a0:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    24a3:	53                   	push   %ebx
    24a4:	50                   	push   %eax
    24a5:	e8 e8 f8 ff ff       	call   1d92 <_shb>
    24aa:	83 c4 08             	add    $0x8,%esp
    24ad:	88 07                	mov    %al,(%edi)
                hash[i + 16] = _shb(ctx->hash[4], j);
    24af:	8b 45 08             	mov    0x8(%ebp),%eax
    24b2:	8b 40 50             	mov    0x50(%eax),%eax
    24b5:	8d 4e 10             	lea    0x10(%esi),%ecx
    24b8:	8b 55 0c             	mov    0xc(%ebp),%edx
    24bb:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    24be:	53                   	push   %ebx
    24bf:	50                   	push   %eax
    24c0:	e8 cd f8 ff ff       	call   1d92 <_shb>
    24c5:	83 c4 08             	add    $0x8,%esp
    24c8:	88 07                	mov    %al,(%edi)
                hash[i + 20] = _shb(ctx->hash[5], j);
    24ca:	8b 45 08             	mov    0x8(%ebp),%eax
    24cd:	8b 40 54             	mov    0x54(%eax),%eax
    24d0:	8d 4e 14             	lea    0x14(%esi),%ecx
    24d3:	8b 55 0c             	mov    0xc(%ebp),%edx
    24d6:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    24d9:	53                   	push   %ebx
    24da:	50                   	push   %eax
    24db:	e8 b2 f8 ff ff       	call   1d92 <_shb>
    24e0:	83 c4 08             	add    $0x8,%esp
    24e3:	88 07                	mov    %al,(%edi)
                hash[i + 24] = _shb(ctx->hash[6], j);
    24e5:	8b 45 08             	mov    0x8(%ebp),%eax
    24e8:	8b 40 58             	mov    0x58(%eax),%eax
    24eb:	8d 4e 18             	lea    0x18(%esi),%ecx
    24ee:	8b 55 0c             	mov    0xc(%ebp),%edx
    24f1:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    24f4:	53                   	push   %ebx
    24f5:	50                   	push   %eax
    24f6:	e8 97 f8 ff ff       	call   1d92 <_shb>
    24fb:	83 c4 08             	add    $0x8,%esp
    24fe:	88 07                	mov    %al,(%edi)
                hash[i + 28] = _shb(ctx->hash[7], j);
    2500:	8b 45 08             	mov    0x8(%ebp),%eax
    2503:	8b 40 5c             	mov    0x5c(%eax),%eax
    2506:	8d 4e 1c             	lea    0x1c(%esi),%ecx
    2509:	8b 55 0c             	mov    0xc(%ebp),%edx
    250c:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
    250f:	53                   	push   %ebx
    2510:	50                   	push   %eax
    2511:	e8 7c f8 ff ff       	call   1d92 <_shb>
    2516:	83 c4 08             	add    $0x8,%esp
    2519:	88 07                	mov    %al,(%edi)
            for (i = 0, j = 24; i < 4; i++, j -= 8) {
    251b:	83 c6 01             	add    $0x1,%esi
    251e:	83 eb 08             	sub    $0x8,%ebx
    2521:	83 fe 03             	cmp    $0x3,%esi
    2524:	0f 86 1c ff ff ff    	jbe    2446 <sha256_done+0x153>
            }
        }
    }
}
    252a:	90                   	nop
    252b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    252e:	5b                   	pop    %ebx
    252f:	5e                   	pop    %esi
    2530:	5f                   	pop    %edi
    2531:	5d                   	pop    %ebp
    2532:	c3                   	ret    

00002533 <read_info>:
char passwords[MAX_LOGINS][MAX_INPUT_SIZE];
const char* SECRETS = "secrets";

char* shargv[] = {"sh", 0};

void read_info() {
    2533:	55                   	push   %ebp
    2534:	89 e5                	mov    %esp,%ebp
    2536:	83 ec 78             	sub    $0x78,%esp
    char buf[MAX_INPUT_SIZE];
    int n;
    fd = open(SECRETS, O_CREATE | O_RDWR);
    2539:	a1 68 38 00 00       	mov    0x3868,%eax
    253e:	83 ec 08             	sub    $0x8,%esp
    2541:	68 04 02 00 00       	push   $0x204
    2546:	50                   	push   %eax
    2547:	e8 7d e7 ff ff       	call   cc9 <open>
    254c:	83 c4 10             	add    $0x10,%esp
    254f:	a3 00 39 00 00       	mov    %eax,0x3900

    int i = 0;
    2554:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    255b:	eb 6f                	jmp    25cc <read_info+0x99>
        if (i % 2 == 0) {  // Username on even lines
    255d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2560:	83 e0 01             	and    $0x1,%eax
    2563:	85 c0                	test   %eax,%eax
    2565:	75 27                	jne    258e <read_info+0x5b>
            strcpy(usernames[i / 2], buf);
    2567:	8b 45 f4             	mov    -0xc(%ebp),%eax
    256a:	89 c2                	mov    %eax,%edx
    256c:	c1 ea 1f             	shr    $0x1f,%edx
    256f:	01 d0                	add    %edx,%eax
    2571:	d1 f8                	sar    %eax
    2573:	6b c0 64             	imul   $0x64,%eax,%eax
    2576:	8d 90 20 39 00 00    	lea    0x3920(%eax),%edx
    257c:	83 ec 08             	sub    $0x8,%esp
    257f:	8d 45 8c             	lea    -0x74(%ebp),%eax
    2582:	50                   	push   %eax
    2583:	52                   	push   %edx
    2584:	e8 ee e7 ff ff       	call   d77 <strcpy>
    2589:	83 c4 10             	add    $0x10,%esp
    258c:	eb 27                	jmp    25b5 <read_info+0x82>
        } else {  // Passwords on odd lines
            memmove(passwords[i / 2], buf, MAX_INPUT_SIZE);
    258e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2591:	89 c2                	mov    %eax,%edx
    2593:	c1 ea 1f             	shr    $0x1f,%edx
    2596:	01 d0                	add    %edx,%eax
    2598:	d1 f8                	sar    %eax
    259a:	6b c0 64             	imul   $0x64,%eax,%eax
    259d:	8d 90 60 38 64 00    	lea    0x643860(%eax),%edx
    25a3:	83 ec 04             	sub    $0x4,%esp
    25a6:	6a 64                	push   $0x64
    25a8:	8d 45 8c             	lea    -0x74(%ebp),%eax
    25ab:	50                   	push   %eax
    25ac:	52                   	push   %edx
    25ad:	e8 b1 e9 ff ff       	call   f63 <memmove>
    25b2:	83 c4 10             	add    $0x10,%esp
        }
        // Clear buffer
        memset(buf, 0, MAX_INPUT_SIZE);
    25b5:	83 ec 04             	sub    $0x4,%esp
    25b8:	6a 64                	push   $0x64
    25ba:	6a 00                	push   $0x0
    25bc:	8d 45 8c             	lea    -0x74(%ebp),%eax
    25bf:	50                   	push   %eax
    25c0:	e8 48 e8 ff ff       	call   e0d <memset>
    25c5:	83 c4 10             	add    $0x10,%esp
        i++;
    25c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    25cc:	a1 00 39 00 00       	mov    0x3900,%eax
    25d1:	83 ec 04             	sub    $0x4,%esp
    25d4:	6a 64                	push   $0x64
    25d6:	8d 55 8c             	lea    -0x74(%ebp),%edx
    25d9:	52                   	push   %edx
    25da:	50                   	push   %eax
    25db:	e8 c1 e6 ff ff       	call   ca1 <read>
    25e0:	83 c4 10             	add    $0x10,%esp
    25e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    25e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    25ea:	0f 8f 6d ff ff ff    	jg     255d <read_info+0x2a>
    }

    num_users = i / 2;
    25f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25f3:	89 c2                	mov    %eax,%edx
    25f5:	c1 ea 1f             	shr    $0x1f,%edx
    25f8:	01 d0                	add    %edx,%eax
    25fa:	d1 f8                	sar    %eax
    25fc:	a3 04 39 00 00       	mov    %eax,0x3904

    if (n < 0) {
    2601:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2605:	79 17                	jns    261e <read_info+0xeb>
        printf(1, "cat: read error\n");
    2607:	83 ec 08             	sub    $0x8,%esp
    260a:	68 4b 2e 00 00       	push   $0x2e4b
    260f:	6a 01                	push   $0x1
    2611:	e8 83 ec ff ff       	call   1299 <printf>
    2616:	83 c4 10             	add    $0x10,%esp
        exit();
    2619:	e8 6b e6 ff ff       	call   c89 <exit>
    }
}
    261e:	90                   	nop
    261f:	c9                   	leave  
    2620:	c3                   	ret    

00002621 <writeback>:

void writeback() {
    2621:	55                   	push   %ebp
    2622:	89 e5                	mov    %esp,%ebp
    2624:	83 ec 18             	sub    $0x18,%esp
    fd = open(SECRETS, O_CREATE | O_RDWR);
    2627:	a1 68 38 00 00       	mov    0x3868,%eax
    262c:	83 ec 08             	sub    $0x8,%esp
    262f:	68 04 02 00 00       	push   $0x204
    2634:	50                   	push   %eax
    2635:	e8 8f e6 ff ff       	call   cc9 <open>
    263a:	83 c4 10             	add    $0x10,%esp
    263d:	a3 00 39 00 00       	mov    %eax,0x3900
    for (int i = 0; i < num_users; i++) {
    2642:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2649:	eb 44                	jmp    268f <writeback+0x6e>
        write(fd, usernames[i], MAX_INPUT_SIZE);
    264b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    264e:	6b c0 64             	imul   $0x64,%eax,%eax
    2651:	8d 90 20 39 00 00    	lea    0x3920(%eax),%edx
    2657:	a1 00 39 00 00       	mov    0x3900,%eax
    265c:	83 ec 04             	sub    $0x4,%esp
    265f:	6a 64                	push   $0x64
    2661:	52                   	push   %edx
    2662:	50                   	push   %eax
    2663:	e8 41 e6 ff ff       	call   ca9 <write>
    2668:	83 c4 10             	add    $0x10,%esp
        write(fd, passwords[i], MAX_INPUT_SIZE);
    266b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    266e:	6b c0 64             	imul   $0x64,%eax,%eax
    2671:	8d 90 60 38 64 00    	lea    0x643860(%eax),%edx
    2677:	a1 00 39 00 00       	mov    0x3900,%eax
    267c:	83 ec 04             	sub    $0x4,%esp
    267f:	6a 64                	push   $0x64
    2681:	52                   	push   %edx
    2682:	50                   	push   %eax
    2683:	e8 21 e6 ff ff       	call   ca9 <write>
    2688:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_users; i++) {
    268b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    268f:	a1 04 39 00 00       	mov    0x3904,%eax
    2694:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    2697:	7c b2                	jl     264b <writeback+0x2a>
    }
    close(fd);
    2699:	a1 00 39 00 00       	mov    0x3900,%eax
    269e:	83 ec 0c             	sub    $0xc,%esp
    26a1:	50                   	push   %eax
    26a2:	e8 0a e6 ff ff       	call   cb1 <close>
    26a7:	83 c4 10             	add    $0x10,%esp
}
    26aa:	90                   	nop
    26ab:	c9                   	leave  
    26ac:	c3                   	ret    

000026ad <init_hook>:
 * Hook into user/src/login/login_init.c in order to intialize any files or
 * data structures necessary for the login system
 * 
 * Called once per boot of xv6
 */
void init_hook() {
    26ad:	55                   	push   %ebp
    26ae:	89 e5                	mov    %esp,%ebp
    26b0:	81 ec 48 02 00 00    	sub    $0x248,%esp
    strcpy(usernames[0], "root");
    26b6:	83 ec 08             	sub    $0x8,%esp
    26b9:	68 5c 2e 00 00       	push   $0x2e5c
    26be:	68 20 39 00 00       	push   $0x3920
    26c3:	e8 af e6 ff ff       	call   d77 <strcpy>
    26c8:	83 c4 10             	add    $0x10,%esp
    const char* root_passwd = "admin";
    26cb:	c7 45 f4 61 2e 00 00 	movl   $0x2e61,-0xc(%ebp)
    sha256_context context;
    uchar hash[MAX_INPUT_SIZE];
    // salt the password
    char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
    strcpy(salted_password, root_passwd);
    26d2:	83 ec 08             	sub    $0x8,%esp
    26d5:	ff 75 f4             	push   -0xc(%ebp)
    26d8:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    26de:	50                   	push   %eax
    26df:	e8 93 e6 ff ff       	call   d77 <strcpy>
    26e4:	83 c4 10             	add    $0x10,%esp
    salted_password[MAX_PASSWD_LEN] = 'c';
    26e7:	c6 85 1f fe ff ff 63 	movb   $0x63,-0x1e1(%ebp)

    sha256_init(&context);
    26ee:	83 ec 0c             	sub    $0xc,%esp
    26f1:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    26f7:	50                   	push   %eax
    26f8:	e8 e8 fa ff ff       	call   21e5 <sha256_init>
    26fd:	83 c4 10             	add    $0x10,%esp
    sha256_hash(&context, salted_password, strlen(salted_password));
    2700:	83 ec 0c             	sub    $0xc,%esp
    2703:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    2709:	50                   	push   %eax
    270a:	e8 d7 e6 ff ff       	call   de6 <strlen>
    270f:	83 c4 10             	add    $0x10,%esp
    2712:	83 ec 04             	sub    $0x4,%esp
    2715:	50                   	push   %eax
    2716:	8d 85 bb fd ff ff    	lea    -0x245(%ebp),%eax
    271c:	50                   	push   %eax
    271d:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    2723:	50                   	push   %eax
    2724:	e8 3a fb ff ff       	call   2263 <sha256_hash>
    2729:	83 c4 10             	add    $0x10,%esp
    sha256_done(&context, hash);
    272c:	83 ec 08             	sub    $0x8,%esp
    272f:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    2735:	50                   	push   %eax
    2736:	8d 85 84 fe ff ff    	lea    -0x17c(%ebp),%eax
    273c:	50                   	push   %eax
    273d:	e8 b1 fb ff ff       	call   22f3 <sha256_done>
    2742:	83 c4 10             	add    $0x10,%esp
    memset(passwords[0], 0, MAX_INPUT_SIZE);
    2745:	83 ec 04             	sub    $0x4,%esp
    2748:	6a 64                	push   $0x64
    274a:	6a 00                	push   $0x0
    274c:	68 60 38 64 00       	push   $0x643860
    2751:	e8 b7 e6 ff ff       	call   e0d <memset>
    2756:	83 c4 10             	add    $0x10,%esp
    memmove(passwords[0], hash, HASH_SIZE);
    2759:	83 ec 04             	sub    $0x4,%esp
    275c:	6a 20                	push   $0x20
    275e:	8d 85 20 fe ff ff    	lea    -0x1e0(%ebp),%eax
    2764:	50                   	push   %eax
    2765:	68 60 38 64 00       	push   $0x643860
    276a:	e8 f4 e7 ff ff       	call   f63 <memmove>
    276f:	83 c4 10             	add    $0x10,%esp

    read_info();
    2772:	e8 bc fd ff ff       	call   2533 <read_info>
    fd = open(SECRETS, O_RDWR);
    2777:	a1 68 38 00 00       	mov    0x3868,%eax
    277c:	83 ec 08             	sub    $0x8,%esp
    277f:	6a 04                	push   $0x4
    2781:	50                   	push   %eax
    2782:	e8 42 e5 ff ff       	call   cc9 <open>
    2787:	83 c4 10             	add    $0x10,%esp
    278a:	a3 00 39 00 00       	mov    %eax,0x3900
    write(fd, usernames[0], MAX_INPUT_SIZE);
    278f:	a1 00 39 00 00       	mov    0x3900,%eax
    2794:	83 ec 04             	sub    $0x4,%esp
    2797:	6a 64                	push   $0x64
    2799:	68 20 39 00 00       	push   $0x3920
    279e:	50                   	push   %eax
    279f:	e8 05 e5 ff ff       	call   ca9 <write>
    27a4:	83 c4 10             	add    $0x10,%esp
    write(fd, passwords[0], MAX_INPUT_SIZE);
    27a7:	a1 00 39 00 00       	mov    0x3900,%eax
    27ac:	83 ec 04             	sub    $0x4,%esp
    27af:	6a 64                	push   $0x64
    27b1:	68 60 38 64 00       	push   $0x643860
    27b6:	50                   	push   %eax
    27b7:	e8 ed e4 ff ff       	call   ca9 <write>
    27bc:	83 c4 10             	add    $0x10,%esp
    close(fd);
    27bf:	a1 00 39 00 00       	mov    0x3900,%eax
    27c4:	83 ec 0c             	sub    $0xc,%esp
    27c7:	50                   	push   %eax
    27c8:	e8 e4 e4 ff ff       	call   cb1 <close>
    27cd:	83 c4 10             	add    $0x10,%esp
}
    27d0:	90                   	nop
    27d1:	c9                   	leave  
    27d2:	c3                   	ret    

000027d3 <does_user_exist>:
 * Check if user exists in system 
 * 
 * @param username A null-terminated string representing the username
 * @return 0 on success if user exists, -1 for failure otherwise
 */
int does_user_exist(char* username) {
    27d3:	55                   	push   %ebp
    27d4:	89 e5                	mov    %esp,%ebp
    27d6:	83 ec 18             	sub    $0x18,%esp
    read_info();
    27d9:	e8 55 fd ff ff       	call   2533 <read_info>

    for (int i = 0; i < num_users; i++) {
    27de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    27e5:	eb 29                	jmp    2810 <does_user_exist+0x3d>
        //printf(1, "Username: %s\n", usernames[i]);
        if (strcmp(username, usernames[i]) == 0) {
    27e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27ea:	6b c0 64             	imul   $0x64,%eax,%eax
    27ed:	05 20 39 00 00       	add    $0x3920,%eax
    27f2:	83 ec 08             	sub    $0x8,%esp
    27f5:	50                   	push   %eax
    27f6:	ff 75 08             	push   0x8(%ebp)
    27f9:	e8 a9 e5 ff ff       	call   da7 <strcmp>
    27fe:	83 c4 10             	add    $0x10,%esp
    2801:	85 c0                	test   %eax,%eax
    2803:	75 07                	jne    280c <does_user_exist+0x39>
            return 0;
    2805:	b8 00 00 00 00       	mov    $0x0,%eax
    280a:	eb 13                	jmp    281f <does_user_exist+0x4c>
    for (int i = 0; i < num_users; i++) {
    280c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2810:	a1 04 39 00 00       	mov    0x3904,%eax
    2815:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    2818:	7c cd                	jl     27e7 <does_user_exist+0x14>
        }
    }
    return -1;
    281a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    281f:	c9                   	leave  
    2820:	c3                   	ret    

00002821 <create_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return 0 on success, -1 for failure
 */
int create_user(char* username, char* password) {
    2821:	55                   	push   %ebp
    2822:	89 e5                	mov    %esp,%ebp
    2824:	81 ec 08 02 00 00    	sub    $0x208,%esp
    read_info();
    282a:	e8 04 fd ff ff       	call   2533 <read_info>

    int open = -1;
    282f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    // printf(1, "Iterating through %d users\n", num_users);
    for (int i = 0; i < MAX_LOGINS; i++) {
    2836:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    283d:	eb 46                	jmp    2885 <create_user+0x64>
        if (strcmp(username, usernames[i]) == 0) {
    283f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2842:	6b c0 64             	imul   $0x64,%eax,%eax
    2845:	05 20 39 00 00       	add    $0x3920,%eax
    284a:	83 ec 08             	sub    $0x8,%esp
    284d:	50                   	push   %eax
    284e:	ff 75 08             	push   0x8(%ebp)
    2851:	e8 51 e5 ff ff       	call   da7 <strcmp>
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	85 c0                	test   %eax,%eax
    285b:	75 0a                	jne    2867 <create_user+0x46>
            // printf(1, "Already found a user with username %s!\n", username);
            return -1;
    285d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2862:	e9 18 01 00 00       	jmp    297f <create_user+0x15e>
        }

        if (usernames[i][0] == 0) {
    2867:	8b 45 f0             	mov    -0x10(%ebp),%eax
    286a:	6b c0 64             	imul   $0x64,%eax,%eax
    286d:	05 20 39 00 00       	add    $0x3920,%eax
    2872:	0f b6 00             	movzbl (%eax),%eax
    2875:	84 c0                	test   %al,%al
    2877:	75 08                	jne    2881 <create_user+0x60>
            open = i;
    2879:	8b 45 f0             	mov    -0x10(%ebp),%eax
    287c:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
    287f:	eb 0d                	jmp    288e <create_user+0x6d>
    for (int i = 0; i < MAX_LOGINS; i++) {
    2881:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2885:	81 7d f0 fd ff 00 00 	cmpl   $0xfffd,-0x10(%ebp)
    288c:	7e b1                	jle    283f <create_user+0x1e>
        }
    }

    // Case for open position
    // Could have also just inserted at num_users
    if (open != -1) {  
    288e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    2892:	0f 84 e2 00 00 00    	je     297a <create_user+0x159>
        sha256_context context;
        uchar hash[HASH_SIZE];

        char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
        strcpy(salted_password, password);
    2898:	83 ec 08             	sub    $0x8,%esp
    289b:	ff 75 0c             	push   0xc(%ebp)
    289e:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    28a4:	50                   	push   %eax
    28a5:	e8 cd e4 ff ff       	call   d77 <strcpy>
    28aa:	83 c4 10             	add    $0x10,%esp
        salted_password[MAX_PASSWD_LEN] = 'c';
    28ad:	c6 85 7f fe ff ff 63 	movb   $0x63,-0x181(%ebp)

        sha256_init(&context);
    28b4:	83 ec 0c             	sub    $0xc,%esp
    28b7:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    28bd:	50                   	push   %eax
    28be:	e8 22 f9 ff ff       	call   21e5 <sha256_init>
    28c3:	83 c4 10             	add    $0x10,%esp
        sha256_hash(&context, salted_password, strlen(salted_password));
    28c6:	83 ec 0c             	sub    $0xc,%esp
    28c9:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    28cf:	50                   	push   %eax
    28d0:	e8 11 e5 ff ff       	call   de6 <strlen>
    28d5:	83 c4 10             	add    $0x10,%esp
    28d8:	83 ec 04             	sub    $0x4,%esp
    28db:	50                   	push   %eax
    28dc:	8d 85 1b fe ff ff    	lea    -0x1e5(%ebp),%eax
    28e2:	50                   	push   %eax
    28e3:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    28e9:	50                   	push   %eax
    28ea:	e8 74 f9 ff ff       	call   2263 <sha256_hash>
    28ef:	83 c4 10             	add    $0x10,%esp
        sha256_done(&context, hash);
    28f2:	83 ec 08             	sub    $0x8,%esp
    28f5:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    28fb:	50                   	push   %eax
    28fc:	8d 85 80 fe ff ff    	lea    -0x180(%ebp),%eax
    2902:	50                   	push   %eax
    2903:	e8 eb f9 ff ff       	call   22f3 <sha256_done>
    2908:	83 c4 10             	add    $0x10,%esp

        strcpy(usernames[open], username);
    290b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    290e:	6b c0 64             	imul   $0x64,%eax,%eax
    2911:	05 20 39 00 00       	add    $0x3920,%eax
    2916:	83 ec 08             	sub    $0x8,%esp
    2919:	ff 75 08             	push   0x8(%ebp)
    291c:	50                   	push   %eax
    291d:	e8 55 e4 ff ff       	call   d77 <strcpy>
    2922:	83 c4 10             	add    $0x10,%esp
        memset(passwords[open], 0, MAX_INPUT_SIZE);
    2925:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2928:	6b c0 64             	imul   $0x64,%eax,%eax
    292b:	05 60 38 64 00       	add    $0x643860,%eax
    2930:	83 ec 04             	sub    $0x4,%esp
    2933:	6a 64                	push   $0x64
    2935:	6a 00                	push   $0x0
    2937:	50                   	push   %eax
    2938:	e8 d0 e4 ff ff       	call   e0d <memset>
    293d:	83 c4 10             	add    $0x10,%esp
        memmove(passwords[open], hash, HASH_SIZE);
    2940:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2943:	6b c0 64             	imul   $0x64,%eax,%eax
    2946:	8d 90 60 38 64 00    	lea    0x643860(%eax),%edx
    294c:	83 ec 04             	sub    $0x4,%esp
    294f:	6a 20                	push   $0x20
    2951:	8d 85 fb fd ff ff    	lea    -0x205(%ebp),%eax
    2957:	50                   	push   %eax
    2958:	52                   	push   %edx
    2959:	e8 05 e6 ff ff       	call   f63 <memmove>
    295e:	83 c4 10             	add    $0x10,%esp

        num_users++;
    2961:	a1 04 39 00 00       	mov    0x3904,%eax
    2966:	83 c0 01             	add    $0x1,%eax
    2969:	a3 04 39 00 00       	mov    %eax,0x3904
        writeback();
    296e:	e8 ae fc ff ff       	call   2621 <writeback>
        return 0;
    2973:	b8 00 00 00 00       	mov    $0x0,%eax
    2978:	eb 05                	jmp    297f <create_user+0x15e>
    }

    return -1;
    297a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    297f:	c9                   	leave  
    2980:	c3                   	ret    

00002981 <login_user>:
 * 
 * @param username A null-terminated string representing the username
 * @param password A null-terminated string representing the password
 * @return no return on success, -1 for failure
 */
int login_user(char* username, char* password) {
    2981:	55                   	push   %ebp
    2982:	89 e5                	mov    %esp,%ebp
    2984:	81 ec 18 02 00 00    	sub    $0x218,%esp
    read_info();
    298a:	e8 a4 fb ff ff       	call   2533 <read_info>

    for (int i = 0; i < MAX_LOGINS; i++) {
    298f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2996:	e9 7b 01 00 00       	jmp    2b16 <login_user+0x195>
        
        if (strcmp(username, usernames[i]) == 0) {
    299b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    299e:	6b c0 64             	imul   $0x64,%eax,%eax
    29a1:	05 20 39 00 00       	add    $0x3920,%eax
    29a6:	83 ec 08             	sub    $0x8,%esp
    29a9:	50                   	push   %eax
    29aa:	ff 75 08             	push   0x8(%ebp)
    29ad:	e8 f5 e3 ff ff       	call   da7 <strcmp>
    29b2:	83 c4 10             	add    $0x10,%esp
    29b5:	85 c0                	test   %eax,%eax
    29b7:	0f 85 55 01 00 00    	jne    2b12 <login_user+0x191>
            sha256_context context;
            uchar hash[HASH_SIZE];
            char salted_password[MAX_PASSWD_LEN + 1]; // +1 for the added character
            strcpy(salted_password, password);
    29bd:	83 ec 08             	sub    $0x8,%esp
    29c0:	ff 75 0c             	push   0xc(%ebp)
    29c3:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    29c9:	50                   	push   %eax
    29ca:	e8 a8 e3 ff ff       	call   d77 <strcpy>
    29cf:	83 c4 10             	add    $0x10,%esp
            salted_password[MAX_PASSWD_LEN] = 'c';
    29d2:	c6 85 77 fe ff ff 63 	movb   $0x63,-0x189(%ebp)
            
            sha256_init(&context);
    29d9:	83 ec 0c             	sub    $0xc,%esp
    29dc:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    29e2:	50                   	push   %eax
    29e3:	e8 fd f7 ff ff       	call   21e5 <sha256_init>
    29e8:	83 c4 10             	add    $0x10,%esp
            sha256_hash(&context, salted_password, strlen(salted_password));
    29eb:	83 ec 0c             	sub    $0xc,%esp
    29ee:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    29f4:	50                   	push   %eax
    29f5:	e8 ec e3 ff ff       	call   de6 <strlen>
    29fa:	83 c4 10             	add    $0x10,%esp
    29fd:	83 ec 04             	sub    $0x4,%esp
    2a00:	50                   	push   %eax
    2a01:	8d 85 13 fe ff ff    	lea    -0x1ed(%ebp),%eax
    2a07:	50                   	push   %eax
    2a08:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    2a0e:	50                   	push   %eax
    2a0f:	e8 4f f8 ff ff       	call   2263 <sha256_hash>
    2a14:	83 c4 10             	add    $0x10,%esp
            sha256_done(&context, hash);
    2a17:	83 ec 08             	sub    $0x8,%esp
    2a1a:	8d 85 f3 fd ff ff    	lea    -0x20d(%ebp),%eax
    2a20:	50                   	push   %eax
    2a21:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
    2a27:	50                   	push   %eax
    2a28:	e8 c6 f8 ff ff       	call   22f3 <sha256_done>
    2a2d:	83 c4 10             	add    $0x10,%esp

            for (int j = 0; j < 32; j++) {
    2a30:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2a37:	eb 34                	jmp    2a6d <login_user+0xec>
                if ((char) hash[j] != (char) passwords[i][j]) {
    2a39:	8d 95 f3 fd ff ff    	lea    -0x20d(%ebp),%edx
    2a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a42:	01 d0                	add    %edx,%eax
    2a44:	0f b6 00             	movzbl (%eax),%eax
    2a47:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2a4a:	6b ca 64             	imul   $0x64,%edx,%ecx
    2a4d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    2a50:	01 ca                	add    %ecx,%edx
    2a52:	81 c2 60 38 64 00    	add    $0x643860,%edx
    2a58:	0f b6 12             	movzbl (%edx),%edx
    2a5b:	38 d0                	cmp    %dl,%al
    2a5d:	74 0a                	je     2a69 <login_user+0xe8>
                    return -1;
    2a5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2a64:	e9 bf 00 00 00       	jmp    2b28 <login_user+0x1a7>
            for (int j = 0; j < 32; j++) {
    2a69:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2a6d:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    2a71:	7e c6                	jle    2a39 <login_user+0xb8>
                }
            }

            int pid, wpid;
            printf(1, "init: starting sh\n");
    2a73:	83 ec 08             	sub    $0x8,%esp
    2a76:	68 67 2e 00 00       	push   $0x2e67
    2a7b:	6a 01                	push   $0x1
    2a7d:	e8 17 e8 ff ff       	call   1299 <printf>
    2a82:	83 c4 10             	add    $0x10,%esp
            pid = fork();
    2a85:	e8 f7 e1 ff ff       	call   c81 <fork>
    2a8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (pid < 0) {
    2a8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2a91:	79 17                	jns    2aaa <login_user+0x129>
                printf(1, "init: fork failed\n");
    2a93:	83 ec 08             	sub    $0x8,%esp
    2a96:	68 7a 2e 00 00       	push   $0x2e7a
    2a9b:	6a 01                	push   $0x1
    2a9d:	e8 f7 e7 ff ff       	call   1299 <printf>
    2aa2:	83 c4 10             	add    $0x10,%esp
                exit();
    2aa5:	e8 df e1 ff ff       	call   c89 <exit>
            }
            if (pid == 0) {
    2aaa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2aae:	75 4c                	jne    2afc <login_user+0x17b>
                setuid(i);
    2ab0:	83 ec 0c             	sub    $0xc,%esp
    2ab3:	ff 75 f4             	push   -0xc(%ebp)
    2ab6:	e8 6e e2 ff ff       	call   d29 <setuid>
    2abb:	83 c4 10             	add    $0x10,%esp
                //printf(1, "UID SET: %d\n", i);
                exec("sh", shargv);
    2abe:	83 ec 08             	sub    $0x8,%esp
    2ac1:	68 6c 38 00 00       	push   $0x386c
    2ac6:	68 48 2e 00 00       	push   $0x2e48
    2acb:	e8 f1 e1 ff ff       	call   cc1 <exec>
    2ad0:	83 c4 10             	add    $0x10,%esp
                printf(1, "init: exec sh failed\n");
    2ad3:	83 ec 08             	sub    $0x8,%esp
    2ad6:	68 8d 2e 00 00       	push   $0x2e8d
    2adb:	6a 01                	push   $0x1
    2add:	e8 b7 e7 ff ff       	call   1299 <printf>
    2ae2:	83 c4 10             	add    $0x10,%esp
                exit();
    2ae5:	e8 9f e1 ff ff       	call   c89 <exit>
            }

            while ((wpid = wait()) >= 0 && wpid != pid)
                printf(1, "zombie!\n");
    2aea:	83 ec 08             	sub    $0x8,%esp
    2aed:	68 a3 2e 00 00       	push   $0x2ea3
    2af2:	6a 01                	push   $0x1
    2af4:	e8 a0 e7 ff ff       	call   1299 <printf>
    2af9:	83 c4 10             	add    $0x10,%esp
            while ((wpid = wait()) >= 0 && wpid != pid)
    2afc:	e8 90 e1 ff ff       	call   c91 <wait>
    2b01:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2b04:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2b08:	78 08                	js     2b12 <login_user+0x191>
    2b0a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2b0d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2b10:	75 d8                	jne    2aea <login_user+0x169>
    for (int i = 0; i < MAX_LOGINS; i++) {
    2b12:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2b16:	81 7d f4 fd ff 00 00 	cmpl   $0xfffd,-0xc(%ebp)
    2b1d:	0f 8e 78 fe ff ff    	jle    299b <login_user+0x1a>
        }
    }

    return -1;
    2b23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2b28:	c9                   	leave  
    2b29:	c3                   	ret    
