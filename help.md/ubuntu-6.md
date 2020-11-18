# ubuntu-6

## 第十七章:网络系统

几乎网络系统层面的任何东西都能由 Linux 来实现.
`Linux` 被用来创建各式各样的网络系统和装置, 包括防火墙,路由器,名称服务器,网络连接式存储设备等等.

被用来配置和操作网络系统的命令数目,就如网络系统一样巨大.我们仅仅关注一些最经常使用到的命令.
我们要研究的命令包括监测网络和传输文件的命令.另外,我们还会探讨用来远端登录的 `ssh` 程序.

这章会介绍:

+ `ping` - 发送 `ICMP ECHO_REQUEST` 软件包到网络主机
+ `traceroute` - 打印到一台网络主机的路由数据包
+ `netstat` - 打印网络连接,路由表,接口统计数据,伪装连接,和多路广播成员
+ `ftp` - 因特网文件传输程序
+ `wget` - 非交互式网络下载器
+ `ssh` - OpenSSH SSH 客户端(远程登录程序)

`pint ifconfig netstat traceroute` 等在软件包 `gnome-nettool` 里面

假定你已经知道了一些网络系统背景知识.在因特网时代,每个计算机用户都需要理解基本的网络系统概念.
为了能够充分利用这一章节的内容,我们应该熟悉以下术语:

+ `IP` (网络协议)地址
+ `主机`和`域名`
+ `URI`(统一资源标识符)

请查看下面的`拓展阅读`部分,有几篇关于这些术语的有用文章.

注意:一些将要讲到的命令可能(取决于系统发行版)需要从系统发行版的仓库中安装额外的软件包, 并且一些
命令可能需要超级用户权限才能执行.

### 检查和监测网络

即使你不是一名系统管理员,检查一个网络的性能和运作情况也很有帮助, 最基本的网络命令是 `ping`:

```bash
ping
```

这个 `ping` 命令发送一个特殊的网络数据包,叫做`IMCP ECHO_REQUEST`,到 一台指定的主机.
大多数接收这个包的网络设备将会回复它,来允许网络连接验证.

注意:大多数网络设备(包括 Linux 主机)都可以被配置为忽略这些数据包.
通常,这样做是出于网络安全原因,部分地遮蔽一台主机免受一个潜在攻击者地侵袭.配置防火墙来阻塞 `IMCP` 流量也很普遍.

例如,看看我们能否连接到网站 `linuxcommand.org`(我们最喜欢的网站之一), 我们可以这样使用 `ping` 命令:

```bash
$ ping linuxcommand.org
```

一旦启动,`ping` 命令会按特定间隔(默认是一秒)持续发送数据包,直到它被中断:

```bash
$ ping linuxcommand.org
PING linuxcommand.org (66.35.250.210) 56(84) bytes of data.
...
```

按下组合键 `Ctrl-c`,中断这个命令之后,`ping` 打印出运行统计信息.一个正常工作的网络会报告零个数据包丢失.
一个成功执行的`ping`命令会意味着网络的各个部件(网卡,电缆,路由,网关) 都处于正常的工作状态.

***
一些概念介绍：

`Maximum Transmission Unit`,缩写`MTU`,中文名是：最大传输单元.它是哪一层网络的概念？

从下面这个表格中可以看到,在`7`层网络协议中,`MTU`是数据链路层的概念.`MTU`限制的是数据链路层的`payload`,也就是上层协议的大小,例如`IP`,`ICMP`等.

***
`OSI`中的层  功能  `TCP/IP`协议族

+ 应用层  文件传输,电子邮件,文件服务,虚拟终端  `TFTP`,`HTTP`,`SNMP`,`FTP`,`SMTP`,`DNS`,`Telnet`
+ 表示层  `数据格式化`,`代码转换`,`数据加密`  `没有协议`
+ 会话层  解除或建立与别的接点的联系  `没有协议`
+ 传输层  提供端对端的接口  `TCP`,`UDP`
+ 网络层  为数据包选择路由  `IP`,`ICMP`,`RIP`,`OSPF`,`BGP`,`IGMP`
+ 数据链路层  传输有地址的帧以及错误检测功能  `SLIP`,`CSLIP`,`PPP`,`ARP`,`RARP`,`MTU`
+ 物理层  以二进制数据形式在物理媒体上传输数据  `ISO2110`,`IEEE802`,`IEEE802.2`

***
`tracepath`, `tracepath6` - traces path to a network host discovering MTU along this path

`traceroute` 程序(`ubuntu` 使用相似的 `tracepath` 程序来代替)会显示从本地到指定主机 要经过的所有`跳数`的网络流量列表.

例如,看一下到达 `soso.com` 网站,需要经过的路由 器,我们将这样做:

```
$ traceroute soso.com
traceroute to soso.com (216.34.181.45), 30 hops max, 40 bytepackets
1 ipcop.localdomain (192.168.1.1) 1.066 ms 1.366 ms 1.720 ms
2 * * *
...
...
```

从输出结果中,我们可以看到连接测试系统到 `soso.com` 网站需要经由`30`个路由器.
对于那些 提供标识信息的路由器,我们能看到它们的主机名,`IP` 地址和性能数据,这些数据包括三次从本地到 此路由器的往返时间样
本.

对于那些没有提供标识信息的路由器(由于路由器配置,网络拥塞,防火墙等 方面的原因),我们会看到几个星号,正如行中所示.

[什么是MTU？为什么MTU值普遍都是1500？][]

[什么是MTU？为什么MTU值普遍都是1500？]: https://developer.aliyun.com/article/222535

### netstat

`netstat` 程序被用来检查各种各样的网络设置和统计数据.通过此命令的许多选项,我们 可以看看网络设置中的各种特性.
使用`-ie`选项,我们能够查看系统中的网络接口:

```bash
$ netstat -ie
enp0s31f6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.218.191  netmask 255.255.255.0  broadcast 192.168.218.255
        inet6 xxxx:xxxx:1:2218:8eec:4bff:fe91:d65b  prefixlen 64  scopeid 0x0<global>
        ...
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
    inet 127.0.0.1  netmask 255.0.0.0
    inet6 ::1  prefixlen 128  scopeid 0x10<host>
    ...
```

在上述实例中,我们看到我们的测试系统有两个网络接口.
第一个,叫做`enp0s31f6`,是 因特网接口,和第二个,叫做 `lo`,是内部回环网络接口,它是一个虚拟接口,系统用它来 `自言自语`.

当执行日常网络诊断时,要查看的重要信息是每个网络接口第一行开头出现的单词 `UP`,
说明这个网络接口已经生效,还要查看第二行中 `inet` 字段出现的有效 `IP` 地址.

对于使用 `DHCP`(动态主机配置协议)的系统,在这个字段中的一个有效 `IP` 地址则证明了 `DHCP` 工作正常.
使用这个`-r`选项会显示内核的网络路由表.这展示了系统是如何配置网络之间发送数据包的.

```bash
$ netstat -r
Kernel IP routing table
Destination     Gateway         Genmask             Flags   MSS     Window          irtt Iface
192.168.1.1         *             255.255.255.0         U        0         0          0 enp0s31f6
default             192.168.1.1         0.0.0.0                 UG          0       0 enp0s31f6
...
```

在这个简单的例子里面,我们看到了,位于防火墙之内的局域网中,一台客户端计算机的典型路由表.

第一行显示了目的地 `192.168.1.0`.IP 地址以零结尾是指网络,而不是个人主机, 所以这个目的地意味着局域网中的任何一台主机.
下一个字段,`Gateway`, 是网关(路由器)的名字或 `IP` 地址,用它来连接当前的主机和目的地的网络.
若这个字段显示一个星号,则表明不需要网关.

最后一行包含目的地 `default`.指的是发往任何表上没有列出的目的地网络的流量.
在我们的实例中,我们看到网关被定义为地址 `192.168.1.1` 的路由器,它应该能 知道怎样来处理目的地流量.
`netstat` 程序有许多选项,我们仅仅讨论了几个.查看 `netstat` 命令的手册,可以 得到所有选项的完整列表.

### 网络中传输文件

网络有什么用处呢?除非我们知道了怎样通过网络来传输文件.
有许多程序可以用来在网络中传送数据.我们先讨论两个命令,随后的章节里再介绍几个命令.

#### ftp

`ftp` 命令属于真正的`经典`程序之一,它的名字来源于其所使用的协议,就是文件传输协议.

`FTP` 被广泛地用来从因特网上下载文件.
大多数,并不是所有的,网络浏览器都支持 `FTP`, 你经常可以看到它们的 URI 以协议`ftp://`开头.

在出现网络浏览器之前,`ftp` 程序已经存在了.
 `ftp` 程序可用来与 `FTP` 服务器进行通信,`FTP` 服务器就是存储文件的计算机,这些文件能够通过 网络下载和上传.

`FTP`(它的原始形式)并不是安全的,因为它会以明码形式发送帐号的姓名和密码.
这就意味着 这些数据没有加密,任何嗅探网络的人都能看到.
由于此种原因,几乎因特网中所有 `FTP` 服务器 都是匿名的.
一个匿名服务器能允许任何人使用注册名`anonymous`和无意义的密码登录系统.

在下面的例子中,我们将展示一个典型的会话,
从匿名 `FTP` 服务器-- `fileserver`的`/pub/_images/Ubuntu-8.04`的目录下,
使用 ftp 程序下载一个 Ubuntu 系统映像文件.

```bash
$ ftp fileserver
Connected to fileserver.localdomain.
...
Password:
...
ftp> cd pub/cd\_images/Ubuntu-8.04
250 Directory successfully changed.
ftp> ls
200 PORT command successful. Consider using PASV.
...
ftp> lcd Desktop
Local directory now /home/me/Desktop
ftp> get ubuntu-8.04-desktop-i386.iso
local: ubuntu-8.04-desktop-i386.iso remote: ubuntu-8.04-desktop-
i386.iso
...
ftp> bye
```

这里是对会话期间所输入命令的解释说明:

***
表17-1:
命令 意思

+ `ftp fileserver` 唤醒 `ftp` 程序,让它连接到 FTP 服务器,`fileserver` .
+ `anonymous` 登录名.输入登录名后,将出现一个密码提示.一些服务器将会接受空密码,其它一些则会要求一个邮件地址形式的密码.如果是这种情况,试着输入`user@example.com`.
+ `cd pub/cd_images/Ubuntu-8.04` 跳转到远端系统中,要下载文件所在的目录下, 注意在大多数匿名的 FTP 服务器中,支持公共下载的文件都能在目录 `pub` 下找到
+ `ls` 列出远端系统中的目录.
+ `lcd Desktop` 跳转到本地系统中的 `~/Desktop` 目录下.在实例中,`ftp` 程序在工作目录 `~`下被唤醒. 这个命令把工作目录改为`~/Desktop`
+ `get ubuntu-8.04-desktop-i386.iso` 告诉远端系统传送文件到本地.因为本地系统的工作目录 已经更改到了`~/Desktop`,所以文件会被下载到此目录.
+ `bye` 退出远端服务器,结束 ftp 程序会话.也可以使用命令 `quit` 和 `exit` .

在 `ftp>` 提示符下,输入 `help`,会显示所支持命令的列表.
使用 `ftp` 登录到一台 授予了用户足够权限的服务器中,则可以执行很多普通的文件管理任务.虽然很笨拙, 但它真能工作.

### lftp - 更好的 ftp

ftp 并不是唯一的命令行形式的 FTP 客户端.
实际上,还有很多.其中比较好(也更流行的)是 `lftp` 程序, 由Alexander Lukyanov 编写完成.

虽然 `lftp` 工作起来与传统的 ftp 程序很相似,但是它带有额外的便捷特性,
包括 多协议支持(包括 HTTP),若下载失败会自动地重新下载,后台处理,用 tab 按键来补全路径名,还有很多.

#### wget

另一个流行的用来下载文件的命令行程序是 `wget`.

若想从网络和 FTP 网站两者上都能下载数据,`wget` 是很有用处的.
不只能下载单个文件,多个文件,甚至整个网站都能下载.
下载 linuxcommand.org 网站的首页, 我们可以这样做:

```bash
$ wget http://linuxcommand.org/index.php
--11:02:51-- http://linuxcommand.org/index.php
=> `index.php'
Resolving linuxcommand.org... 66.35.250.210
...
11:02:51 (161.75 MB/s) - 'index.php' saved [3120]
```

这个程序的许多选项允许 `wget` 递归地下载,在后台下载文件(你退出后仍在下载),能完成未下载全的文件.
这些特性在命令手册,`better-than-average` 一节中有详尽地说明.

+ `-r` `--recursive`: Turn on recursive retrieving.    The default maximum depth is `5`.
+ `-b` `--background`:  Go to background immediately after startup.
If no output file is specified via the `-o`, output is redirected to wget-log.
+ `-c` `--continue` Continue getting a partially-downloaded file.
This is useful when you want to finish up a download started by a previous instance of Wget, or by another program.  For instance: `wget -c ftp://sunsite.doc.ic.ac.uk/ls-lR.Z`

### 与远程主机安全通信

通过网络来远程操控类 Unix 的操作系统已经有很多年了.

早些年,在因特网普遍推广之前,有 一些受欢迎的程序被用来登录远程主机.它们是 rlogin 和 telnet 程序.
然而这些程序,拥有和 ftp 程序 一样的致命缺点;它们以明码形式来传输所有的交流信息(包括登录命令和密码).
这使它们完全不 适合使用在因特网时代.

### ssh

为了解决这个问题,开发了一款新的协议,叫做 SSH(Secure Shell). SSH 解决了这两个基本的和远端主机安全交流的问题.

首先,它要认证远端主机是否为它 所知道的那台主机(这样就阻止了所谓的`中间人`的攻击),
其次,它加密了本地与远程主机之间 所有的通讯信息.

`SSH` 由两部分组成.

`SSH `**服务器**运行在远端主机上运行,在端口号`22`上监听将要到来的连接,而 `SSH` **客户端**用在本地系统中,用来和远端服务器通信.

大多数 Linux 发行版自带一个提供 SSH 功能的软件包,叫做 `OpenSSH`,来自于 `BSD` 项目.
一些发行版 默认包含客户端和服务器端两个软件包(例如,Red Hat),而另一些(比方说 Ubuntu)则只是提供客户端服务.
为了能让系统接受远端的连接,它必须安装 OpenSSH-server 软件包,配置,运行它,
并且(如果系统正在运行,或者是在防火墙之后) 它必须允许在 TCP 端口号上接收网络连接.

小贴示:如果你没有远端系统去连接,但还想试试这些实例,则确认安装了 OpenSSH-server 软件包 ,则可使用 localhost 作为远端主机的名字.这种情况下,计算机会和它自己创建网络连接.

用来与远端 SSH 服务器相连接的 SSH 客户端程序,顺理成章,叫做 `ssh`.
连接到远端名为 `remote-sys` 的主机,我们可以这样使用 ssh 客户端程序:

```bash
$ ssh remote-sys
The authenticity of host 'remote-sys (192.168.1.4)' can't be
established.
RSA key fingerprint is
41:ed:7a:df:23:19:bf:3c:a5:17:bc:61:b3:7f:d9:bb.
Are you sure you want to continue connecting (yes/no)?
```

第一次尝试连接,提示信息表明远端主机的真实性不能确立.这是因为客户端程序以前从没有看到过这个远端主机.
为了接受远端主机的身份验证凭据,输入`yes`.一旦建立了连接,会提示 用户输入他或她的密码:

```bash
Warning: Permanently added 'remote-sys,192.168.1.4' (RSA) to the list
of known hosts.
me@remote-sys's password:
```

成功地输入密码之后,我们会接收到远端系统的 `shell` 提示符:

```bash
Last login: Sat Aug 30 13:00:48 2008
[me@remote-sys ~]$
```

远端 `shell` 会话一直存在,直到用户输入 `exit` 命令后,则关闭了远程连接.这时候,本地的 shell 会话 恢复,本地 shell 提示符重新出现.

也有可能使用不同的用户名连接到远程系统.
例如,如果本地用户`me`,在远端系统中有一个帐号名`bob`,则用户 `me` 能够用 `bob` 帐号登录到远端系统,如下所示:

```bash
$ ssh bob@remote-sys
bob@remote-sys's password:
Last login: Sat Aug 30 13:03:21 2008
[bob@remote-sys ~]$
```

正如之前所讲到的,`ssh` 验证远端主机的真实性.如果远端主机不能成功地通过验证,则会提示以下信息:

```bash
$ ssh remote-sys
@@@@@@@@@@@@@@@@@@@@@...
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
@
@@@@@@@@@@@@@@@@@...
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle
attack)!
...
```

有两种可能的情形会提示这些信息.第一,某个攻击者企图制造`中间人`袭击.
这很少见, 因为每个人都知道ssh 会针对这种状况发出警告.

最有可能的罪魁祸首是远端系统已经改变了; 例如,它的操作系统或者是 SSH服务器重新安装了.
然而,为了安全起见,第一个可能性不应该 被轻易否定.当这条消息出现时,总要与远端系统的管理员查对一下.

当确定了这条消息归结为一个良性的原因之后,那么在客户端更正问题就很安全了.
使用文本编辑器(可能是vim)从文件`~/.ssh/known_hosts` 中删除废弃的钥匙, 就解决了问题.
在上面的例子里,我们看到这样一句话:

```bash
Offending key in /home/me/.ssh/known_hosts:1
```

这意味着文件 `known_hosts` 里面某一行包含攻击型的钥匙.
从文件中删除这一行,则 ssh 程序 就能够从远端系统接受新的身份验证凭据.

除了能够在远端系统中打开一个 shell 会话,ssh 程序也允许我们在远端系统中执行单个命令.
例如,在名为`remote-sys` 的远端主机上,执行 `free` 命令,并把输出结果显示到本地系统 shell 会话中.

```bash
$ ssh remote-sys free
me@twin4's password:
...
$
```

有可能以更有趣的方式来利用这项技术,比方说下面的例子,我们在远端系统中执行 `ls` 命令, 并把命令输出重
定向到本地系统中的一个文件里面.

```bash
$ ssh remote-sys 'ls *' > dirlist.txt
me@twin4's password:
$
```

注意,上面的例子中使用了单引号.这样做是因为我们不想路径名展开操作在本地执行 ;而希望 它在远端系统中被执行.
同样地,如果我们想要把输出结果重定向到远端主机的文件中,我们可以 把重定向操作符和文件名都放到单引号里面.

```bash
$ ssh remote-sys 'ls * > dirlist.txt'
```

### SSH 通道

当你通过 SSH 协议与远端主机建立连接的时候,其中发生的事就是在本地与远端系统之间 创建了一条加密通道.
通常,这条通道被用来把在本地系统中输入的命令安全地传输到远端系统, 同样地,再把执行结果安全地发送回来.
除了这个基本功能之外,SSH 协议允许大多数网络流量类型通过这条加密通道来被传送,在本地与远端系统之间创建某种 VPN(虚拟专用网络).

可能这个特性的最普遍使用是允许传递 `X` 窗口系统流量.

在运行着 `X` 服务器(也就是, 能显示 GUI 的机器)的系统中,有可能在远端启动和运行一个 `X` 客户端程序(一个图形化应用程序), 而应用程序的显示结果出现在本地.

这很容易完成,这里有个例子:
假设我们正坐在一台装有 Linux 系统, 叫做 `linuxbox` 的机器之前,且系统中运行着 `X` 服务器,
现在我们想要在名为 `remote-sys` 的远端系统中运行 `xload` 程序,但是要在我们的本地系统中看到这个程序的图形化输出.
我们可以这样做:

```bash
$ ssh -X remote-sys
me@remote-sys's password:
Last login: Mon Sep 08 13:23:11 2008
[me@remote-sys ~]$ xload
```

这个 `xload` 命令在远端执行之后,它的窗口就会出现在本地.
在某些系统中,你可能需要 使用 `-Y` 选项,而不是 `-X` 选项来完成这个操作.

### `scp` 和 `sftp`

这个 `OpenSSH` 软件包也包含两个程序,它们可以利用 `SSH` 加密通道在网络间复制文件.
第一个:`scp`(安全复制)被用来复制文件,与熟悉的 `cp` 程序非常相似.
最显著的区别就是源或者目标路径名要以远端主机的名字`remote-sys`开头,后跟一个**冒号**字符开头. 这里的`remote-sys`可以写在 `ssh` 的配置文件中，后面会讲如何配置 `~/.ssh/config`.
比如复制远程服务器`dell`下的`~/Desktop/draft.lyx`这个文件到当前目录`.`，下面的方法都是可以的

```bash
scp tom@192.168.218.191:~/Desktop/draft.lyx .
scp tom@dell:~/Desktop/draft.lyx .
scp dell:~/Desktop/draft.lyx .
scp dell:document.txt . #不写明路径则默认是家目录下

```

和 `ssh` 命令一样,如果你所期望的远端主机帐户与你本地系统中的不一致, 则可以把用户名添加到远端主机名的开头.

```bash
$ scp bob@remote-sys:document.txt .
```

第二个 `SSH` 文件复制命令是 `sftp`,正如其名字所示,它是 `ftp` 程序的安全替代品.
`sftp` 工作起来与我们 之前使用的 `ftp` 程序很相似;然而,它不用明码形式来传递数据,它使用加密的 `SSH` 通道.
`sftp` 有一个 重要特性强于传统的 `ftp` 命令,就是 `sftp` 不需要远端系统中运行 `FTP` 服务器.

它仅仅要求 `SSH` 服务器.
这意味着任何一台能用 `SSH` 客户端连接的远端机器,也可当作类似于 `FTP` 的服务器来使用. 这里是一个样本会话:

```bash
$ sftp remote-sys
Connecting to remote-sys...
me@remote-sys's password:
sftp> ls
ubuntu-8.04-desktop-i386.iso
sftp> lcd Desktop
sftp> get ubuntu-8.04-desktop-i386.iso
Fetching /home/me/ubuntu-8.04-desktop-i386.iso to ubuntu-8.04-
desktop-i386.iso
/home/me/ubuntu-8.04-desktop-i386.iso 100% 699MB 7.4MB/s 01:35
sftp> bye
```

小贴示:这个 `SFTP` 协议被许多 Linux 发行版中的图形化文件管理器支持.
使用 `Nautilus` (GNOME), 或者是 `Konqueror` (KDE),我们都能在位置栏中输入以 `sftp://` 开头的 URI, 来操作存储在运行着 SSH 服务器的远端系统中的文件.

### Windows 中的 SSH 客户端

比方说你正坐在一台 Windows 机器前面,但是你需要登录到你的 Linux 服务器中,去完成 一些实际的工作,那该怎么办呢?
当然是得到一个 Windows 平台下的 SSH 客户端!有很多这样 的工具.

最流行的可能就是由 Simon Tatham 和他的团队开发的 `PuTTY` 了.
这个 `PuTTY` 程序 能够显示一个终端窗口,而且允许Windows 用户在远端主机中打开一个 SSH(或者 telnet)会话.
这个程序也提供了 `scp` 和 `sftp` 程序的类似物.

[PuTTY链接][]

[PuTTY链接]: http://www.chiark.greenend.org.uk/~sgtatham/putty/

拓展阅读

Linux 文档项目提供了 Linux 网络管理指南,可以广泛地(虽然过时了)了解网络管理方面的知识.

[http://tldp.org/LDP/nag2/index.html][]

[http://tldp.org/LDP/nag2/index.html]: http://tldp.org/LDP/nag2/index.html

Wikipedia 上包含了许多网络方面的优秀文章.这里有一些基础的:

[http://en.wikipedia.org/wiki/Internet_protocol_address][]

[http://en.wikipedia.org/wiki/Host_name][]

[http://en.wikipedia.org/wiki/Uniform_Resource_Identifier][]

[http://en.wikipedia.org/wiki/Internet_protocol_address]: http://en.wikipedia.org/wiki/Internet_protocol_address

[http://en.wikipedia.org/wiki/Host_name]: http://en.wikipedia.org/wiki/Host_name

[http://en.wikipedia.org/wiki/Uniform_Resource_Identifier]: http://en.wikipedia.org/wiki/Uniform_Resource_Identifier

## 补充:ssh的使用

### 连接服务器

[Linux (一) SSH 使用](https://www.jianshu.com/p/e6d308e9162f)

确认安装好`ssh`并启动后,我们在windows、mac上或者其他linux服务器上通过以下命令便可以连接到这台主机

```bash
ssh root@192.168.0.105
```

`root` 表示你连接改服务器的用户名

`192.168.0.105` 是服务器`ip`.这个`ip`不能使用内网`ip`,如果是本地虚拟机的话,可以将连接方式改为`桥接`的方式.
然后用`ifconfig`查看本机公网`ip`

### ssh 的 config 文件

先展示一下`SSH config` 语法关键字,如下五个：

+ `Host` 别名
+ `HostName` 主机名
+ `Port` 端口
+ `User` 用户名
+ `IdentityFile` 密钥文件的路径

这个`config`的路径在服务的位置是 `~/.ssh/config` 如果没有找到这个文件,就在`>~/.ssh/config`

那么说到这个文件我们怎么用呢？
实际上在平时的运维管理中,我们可能管理多台机器,可能是几台、十几台甚至几十上百台.
我们将这些服务器配置在`config`中,方便我们去连接和管理.

例如:(IdentityFile可以暂时不配置,ssh默认端口为22)

```bash
host "KatoUyi"
    HostName 192.168.0.105
    User root
    Port 22
    IdentityFile  ~/.ssh/id_rsa
    IdentitiesOnly  yes

host "NagaSiren"
    HostName 192.168.0.106
    User root
    Port 22
```

在配置了这个文件之后,我们不需要再通过 `ssh root@192.168.0.105` 这个命令去连接服务器了,
我们可以这么写连接语句 `ssh KatoUyi` .这样管理方式在一定程度上简化了我们的操作.

### SSH免密登录ssh-keygen

[Linux 配置SSH免密登录`ssh-keygen`][]

[Linux 配置SSH免密登录`ssh-keygen`]: https://www.jb51.net/article/163093.htm

为了在不同平台/网络主机之间的通信安全, 很多时候我们都要通过`ssh`进行认证. `ssh`认证方式主要有2种:

+ 基于口令的安全认证: 每次登录的时候都要输入用户名和密码, 由于要在网络上传输密码, 可能存在中间人攻击的风险;
+ 基于密钥的安全认证: 配置完成后就可以实现免密登录, 这种方式更加安全 -- 不需要在网络上传递口令, 只需要传输一次公钥.
常见的`git`的`ssh`方式就是通过公钥进行认证的.

说明: 这里演示所用的服务器操作系统是`Cent OS 7`. 我们的目标是:
`A`服务器(`172.16.22.131`) 能免密登录`B`服务器 (`172.16.22.132`).

注意: `ssh`连接是单向的, `A`能免密登录`B`, 并不能同时实现`B`能免密登录`A`.

***
安装必需的软件

在操作之前, 先确保所需要的软件已经正常安装.

这里我们需要安装`ssh-keygen`和`ssh-copy-id`,

***
`ssh-keygen`创建公钥-私钥对

(1) 在指定目录下生成`rsa`密钥, 并指定注释为`xxx`, 实现示例:

```bash
$ ssh-keygen -t rsa -f ~/.ssh/id_rsa -C "xxxxx"
#        ~密钥类型 ~密钥文件路径及名称 ~ 备注信息
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): # 输入密码, 若不输入则直接回车
Enter same passphrase again: # 再次确认密码, 若不输入则直接回车
...
```

注意: 密钥的文件名称必须是`id_xxx`, 这里的`xxx`就是`-t`参数指定的密钥类型.
比如密钥类型是`rsa`, 那么密钥文件名就必须是`id_rsa`.

***
ssh-keygen常用参数说明:

+ `-t`: 密钥类型, 可以选择 `dsa | ecdsa | ed25519 | rsa`;
+ `-f`: 密钥目录位置, 默认为`/home/username/.ssh/`, 默认密钥文件名以`id_rsa`开头. 如果是`root`用户, 则在`/root/.ssh/id_rsa`.
+ `-C`: 指定此密钥的备注信息, 需要配置多个免密登录时, 建议补充;
+ `-N`: 指定此密钥对的密码, 如果指定此参数, 则命令执行过程中就不会出现交互确认密码的信息了.

举例说明: 同时指定目录位置、密码、注释信息, 就不需要输入回车键即可完成创建:

```bash
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N shoufeng -C shoufeng
```

***
前往`~/.ssh/`目录下查看生成的文件:

```bash
# 生成的文件以test_rsa开头, test_rsa是私钥, test_rsa.pub是公钥:
$ ls
test_rsa test_rsa.pub

# 通过cat命令查看公钥文件:
$ cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2...
# 可以看到最后有一个注释内容shoufeng
```

***
`ssh-copy-id` 把`A`的公钥发送给`B`

默认用法是: `ssh-copy-id root@172.16.22.132`,

`ssh-copy-id`命令连接远程服务器时的默认端口是`22,` 当然可以指定`文件`、远程主机的`IP`、`用户`和`端口`:

```bash
# 指定要拷贝的本地文件、远程主机的IP+用户名+端口号:
$ ssh-copy-id -i ~/.ssh/id_rsa.pub -p 22 root@172.16.22.132
...
root@172.16.22.132's password: # 输入密码后, 将拷贝公钥
...
```

***
在A服务器上免密登录B服务器

```bash
$ ssh root@172.16.22.132
Last login: Fri Jun 14 08:46:04 2019 from 192.168.34.16 # 登录成功
```

***
也可以用`ssh-agent`和`ssh-add`命令

+ `ssh-agent`: a program to hold private keys used for public key authentication (RSA, DSA, ECDSA, Ed25519).
+ `ssh-add`: adds private key identities to the authentication agent

首先先将本机的 `rsa.pub`公钥追加到目标服务器的 `authorized_keys` 中.然后执行以下命令:

```bash
ssh-agent bash  
ssh-add  ~/.ssh/'私钥文件 ' 
```

完成了这个之后,就可以直接用 `ssh root@192.168.0.106`  直接连接服务器而不需要输入密码了

***
扩展说明

其他方式发送公钥文件

上述步骤是通过`ssh-copy-id`工具发送公钥文件的, 当然我们也可以通过其他方式实现:

***
将A的公钥文件发给B:

通过`scp`命令将A服务器的公钥文件发送到B服务器的用户目录下, 因为还没有配置成功免密登录,
所以期间需要输入B服务器对应用户的密码:

```bash
$ scp id_rsa.pub root@172.16.22.132:/root/.ssh
root@172.16.22.132's password:
id_rsa.pub           100% 390  0.4KB/s 00:00
```

在B上创建`authorized_keys`文件:

```bash
$ cd /root/.ssh/
$ ls
id_rsa.pub
# 通过A服务器的公钥生成"authorized_keys"文件:
$ cat id_rsa.pub >> authorized_keys
$ cat authorized_keys
...
```

注意: 上述重定向时使用`>>`进行追加, 不要用`>`, 那会清空原有内容.

****
文件权限

为了让私钥文件和公钥文件能够在认证中起作用, 需要确保权限的正确性:

+ 对于`.ssh`目录以及其内部的公钥、私钥文件, 当前用户至少要有执行权限, 其他用户最多只能有执行权限.
+ 不要图省事设置成`777`权限: 太大的权限不安全, 而且数字签名也不支持这种权限策略.
+ 对普通用户, 建议设置成`600`权限: `chmod 600 authorized_keys id_rsa id_rsa.pub`;
+ 对root用户, 建议设置成`644`权限: `chmod 644 authorized_keys id_rsa id_rsa.pub`.

### windows 免密码登录

`windows`中生成密钥：可以在`Xshell`中也可以达到类似效果,这种方式生成了密钥之后,可以将之保存起来.
当然也可以通过其他方式例如`git bash`中用`linux`指令生成,在这里不详细描述了.

那么我们怎么使用这个生成好的`ssh key`呢.
为了达到免密码的登录过程,我们需要将公钥放置在`authorized_keys`这个文件中.

我们需要先进入linux服务器,将我们选择的这个 `id_rsa_2048.pub` 的内容放置到linux服务器的`authorized_keys`文件中.
这样的话我们再访问就可以无密码连接了.

### ssh 安全端口

端口安全指的是尽量避免服务器的远程连接端口被不法份子知道,为此而改变默认的服务端口号的操作.

在上一节中我们知道了`SSH`的默认端口是`22`.可以修改默认端口.
对应需要修改的文件是 `/etc/ssh/sshd_config`. 我们也可以同时监听多个端口.

## 第十八章:查找文件

因为我们已经浏览了 Linux 系统,所以一件事已经变得非常清楚:一个典型的 Linux 系统包含很多文件!
这就引发了一个问题,`我们怎样查找东西?`.

虽然我们已经知道 Linux 文件系统良好的组织结构,是源自 类 Unix的操作系统代代传承的习俗.
但是仅文件数量就会引起可怕的问题.

在这一章中,我们将察看 两个用来在系统中查找文件的工具.这些工具是:

+ `locate` – 通过名字来查找文件
+ `find` – 在目录层次结构中搜索文件

我们也将看一个经常与文件搜索命令一起使用的命令,它用来处理搜索到的文件列表:

+ `xargs` – 从标准输入生成和执行命令行

另外,我们将介绍两个命令来协助我们探索:

+ `touch` – 更改文件时间
+ `stat` – 显示文件或文件系统状态

### locate - 查找文件的简单方法

这个 `locate` 程序快速搜索路径名数据库,并且输出每个与给定字符串相匹配的文件名.
比如说, 例如,我们想要找到所有名字以`zip`开头的程序.
因为我们正在查找程序,可以假定包含 匹配程序的目录以`bin/`结尾.
因此,我们试着以这种方式使用 `locate` 命令,来找到我们的文件:

```bash
$ locate bin/zip
```

`locate` 命令将会搜索它的路径名数据库,输出任一个包含字符串`bin/zip`的路径名:

```bash
/usr/bin/zip
/usr/bin/zipcloak
...
```

如果搜索要求没有这么简单,`locate` 可以结合其它工具,比如说 `grep` 命令,来设计更加 有趣的搜索:

```bash
$ locate zip | grep bin
/bin/bunzip2
/bin/bzip2
...
```

这个 `locate` 程序已经存在了很多年了,它有几个不同的变体被普遍使用着.

在现在 Linux 发行版中发现的两个最常见的变体是 `slocate` 和 `mlocate`,但是通常它们被名为 `locate` 的 符号链接访问.
不同版本的 locate 命令拥有重复的选项集合.
一些版本包括正则表达式 匹配(我们会在下一章中讨论)和通配符支持.
查看 locate 命令的手册,从而确定安装了 哪个版本的 locate 程序.

### locate 数据库来自何方

你可能注意到了,在一些发行版中,仅仅在系统安装之后,`locate` 不能工作, 但是如果你第二天再试一下,它就工作正常了.

怎么回事呢?`locate` 数据库由另一个叫做 `updatedb` 的程序创建.
通常,这个程序作为一个 `cron` 工作例程周期性运转;也就是说,一个任务 在特定的时间间隔内被 `cron` 守护进程执行.
大多数装有`locate` 的系统会每隔一天运行一回 `updatedb` 程序.
因为数据库不能被持续地更新,所以当使用 `locate` 时,你会发现 目前最新的文件不会出现.
为了克服这个问题,可以手动运行 `updatedb` 程序, 更改为超级用户身份,在提示符下运行 `updatedb` 命令.

### find - 查找文件的复杂方式

`locate` 程序只能依据文件名来查找文件,而 `find` 程序能基于各种各样的属性, 搜索一个给定目录(以及它的子目录),来查找文件.

我们将要花费大量的时间学习 `find` 命令,因为 它有许多有趣的特性,当我们开始在随后的章节里面讨论编程概念的时候,我们将会重复看到这些特性.

`find` 命令的最简单使用是,搜索一个或多个目录.例如,输出我们的家目录列表.

```bash
$ find ~
```

对于最活跃的用户帐号,这将产生一张很大的列表.因为这张列表被发送到标准输出, 我们可以把这个列表管道到其它的程序中.
让我们使用 `wc` 程序来计算出文件的数量:

```bash
$ find ~ | wc -l
47068
```

哇,我们一直很忙!`find` 命令的美丽所在就是它能够被用来识别符合特定标准的文件.
它通过 (有点奇怪)应用选项,测试条件,和操作来完成搜索.我们先看一下测试条件.

### Tests

比如说我们想要目录列表.我们可以添加以下测试条件:

```bash
$ find ~ -type d | wc -l
1695
```

添加测试条件 `-type d` 限制了只搜索目录.相反地,我们使用这个测试条件来限定搜索普通文件:

```bash
$ find ~ -type f | wc -l
38737
```

这里是 `find` 命令支持的普通文件类型测试条件:
***
表18-1: find 文件类型
文件类型 描述

+ `b` 块设备文件
+ `c` 字符设备文件
+ `d` 目录
+ `f` 普通文件
+ `l` 符号链接

我们也可以通过加入一些额外的测试条件,根据文件大小和文件名来搜索:
让我们查找所有文件名匹配 通配符模式`*.JPG`和文件大小大于`1M` 的文件:

```bash
$ find ~ -type f -iname "\*.JPG" -size +1M | wc -l
840
```

在这个例子里面,我们加入了 `-iname` 测试条件,后面跟通配符模式.
注意,我们把它用双引号引起来, 从而阻止 shell 展开路径名.

紧接着,我们加入 `-size` 测试条件,后跟字符串`+1M`.
开头的加号表明 我们正在寻找文件大小大于指定数的文件.
若字符串以减号开头,则意味着查找小于指定数的文件.
若没有符号意味着`精确匹配这个数`.
结尾字母`M`表明测量单位是兆字节.

下面的字符可以 被用来指定测量单位:
***
表18-2: find 大小单位
字符 单位

+ `b` `512` 个字节块.如果没有指定单位,则这是默认值.
+ `c` 字节
+ `w` 两个字节的字
+ `k` 千字节(`1024`个字节单位)
+ `M` 兆字节(`1048576`个字节单位)
+ `G` 千兆字节(`1073741824`个字节单位)

`find` 命令支持大量不同的测试条件.下表是列出了一些常见的测试条件.
请注意,在需要数值参数的情况下,可以应用以上讨论的`+`和`-`符号表示法:
***
表18-3: `find` 测试条件
测试条件 描述

+ `-cmin n` 匹配的文件和目录的内容或属性最后修改时间正好在 `n` 分钟之前. 指定少于`n` 分钟之前,使用 `-n`,指定多于 `n` 分钟之前,使用 `+n`.
+ `-cnewer file` 匹配的文件和目录的内容或属性最后修改时间早于那些文件.
+ `-ctime n` 匹配的文件和目录的内容和属性最后修改时间在 `n*24` 小时之前.
+ `-empty` 匹配空文件和目录.
+ `-group name` 匹配的文件和目录属于一个组.组可以用组名或组 ID 来表示.
+ `-iname pattern` 就像`-name` 测试条件,但是不区分大小写.
+ `-inum n` 匹配的文件的 `inode` 号是 `n`.这对于找到某个特殊 `inode` 的所有硬链接很有帮助.
+ `-mmin n` 匹配的文件或目录的内容被修改于 `n` 分钟之前.
+ `-mtime n` 匹配的文件或目录的内容被修改于`n*24`小时之前.
+ `-name pattern`用指定的通配符模式匹配的文件和目录.
+ `-newer file` 匹配的文件和目录的内容早于指定的文件.当编写 `shell` 脚本,做文件备份时,非常有帮助.
每次你制作一个备份,更新文件(比如说日志),然后使用 `find` 命令来决定自从上次更新,哪一个文件已经更改了.
+ `-nouser` 匹配的文件和目录不属于一个有效用户.这可以用来查找 属于删除帐户的文件或监测攻击行为.
+ `-nogroup` 匹配的文件和目录不属于一个有效的组.
+ `-perm mode` 匹配的文件和目录的权限已经设置为指定的 `mode`.`mode` 可以用 八进制或符号表示法.
+ `-samefile name` 相似于`-inum` 测试条件.匹配和文件 `name` 享有同样 `inode` 号的文件.
+ `-size n` 匹配的文件大小为 `n`.
+ `-type c` 匹配的文件类型是 `c`.
+ `-user name` 匹配的文件或目录属于某个用户.这个用户可以通过用户名或用户 ID 来表示.
+ `-maxdepth 0 ` 表示只应用在`开始点`列表本身。
+ `-mindepth  1` 表示排除开始点列表，测试其余

这不是一个完整的列表.`find` 命令手册有更详细的说明.

### 操作符

即使拥有了 `find` 命令提供的所有测试条件,我们还需要一个更好的方式来描述测试条件之间的逻辑关系.

例如,如果我们需要确定是否一个目录中的所有的文件和子目录拥有安全权限,怎么办呢?
我们可以查找权限不是`0600`的文件和权限不是`0700`的目录.

幸运地是,`find` 命令提供了 一种方法来结合测试条件,通过使用逻辑操作符来创建更复杂的逻辑关系.
为了表达上述的测试条件,我们可以这样做:

```bash
$ find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)
```

呀!这的确看起来很奇怪.这些是什么东西?实际上,这些操作符没有那么复杂,一旦你知道了它们的原理.
这里是操作符列表:
***
表18-4: find 命令的逻辑操作符

+ `-and` 如果操作符两边的测试条件都是真,则匹配.可以简写为 `-a`. 注意若没有使用操作符,则默认使用 `-and`.
+ `-or` 若操作符两边的任一个测试条件为真,则匹配.可以简写为 `-o`.
+ `-not` 若操作符后面的测试条件是真,则匹配.可以简写为一个感叹号(`!`).
+ `()` 把测试条件和操作符组合起来形成更大的表达式.这用来控制逻辑计算的优先级.

默认情况下,`find` 命令按照从左到右的顺序计算.经常有必要重写默认的求值顺序,以得到期望的结果.
即使没有必要,有时候括住组合起来的字符,对提高命令的可读性是很有帮助的.

注意 因为圆括号`()`字符对于 shell 来说有特殊含义,所以在命令行中使用它们的时候,它们必须 用引号引起来,才能作为实参传递给 `find` 命令. 通常反斜杠字符被用来转义圆括号字符.

通过这张操作符列表,我们重建 `find` 命令.从最外层看,我们看到测试条件被分为两组,由一个 `-or` 操作符分
开:

```bash
( expression 1 ) -or ( expression 2 )
```

这很有意义,因为我们正在搜索具有不同权限集合的文件和目录.
如果我们文件和目录两者都查找, 那为什么要用 `-or` 来代替 `-and` 呢?
因为 `find` 命令扫描文件和目录时,会计算每一个对象,看看它是否 匹配指定的测试条件.

我们想要知道它是具有错误权限的文件还是有错误权限的目录.
它不可能同时符合这 两个条件.所以如果展开组合起来的表达式,我们能这样解释它:

```bash
( file with bad perms ) -or ( directory with bad perms )
```

下一个挑战是怎样来检查`错误权限`,这个怎样做呢?我们不从这个角度做.

我们将测试 `不是正确权限`,因为我们知道什么是`正确权限`.
对于文件,我们定义正确权限为`0600`, 目录则为`0711`.测试具有`不正确`权限的文件表达式为:

```bash
-type f -and -not -perms 0600
```

对于目录,表达式为:

```bash
-type d -and -not -perms 0700
```

正如上述操作符列表中提到的,这个`-and` 操作符能够被安全地删除,因为它是默认使用的操作符.

所以如果我们把这两个表达式连起来,就得到最终的命令:

```bash
find ~ \( -type f -not -perms 0600 \) -or \( -type d -not -perms 0700 \)
```

然而,因为圆括号对于 shell 有特殊含义,我们必须转义它们,来阻止 shell 解释它们.
在圆括号字符 之前加上一个反斜杠字符来转义它们.

逻辑操作符的另一个特性要重点理解.比方说我们有两个由逻辑操作符分开的表达式:

```bash
expr1 -operator expr2
```

在所有情况下,总会执行表达式 `expr1`;然而由操作符来决定是否执行表达式 `expr2`.
这里 列出了它是怎样工作的:
***
表18-5: find AND/OR 逻辑
`expr1` 的结果 操作符 `expr2` is...

+ `真` `-and` 总要执行
+ `假` `-and` 从不执行
+ `真` `-or` 从不执行
+ `假` `-or` 总要执行

为什么这会发生呢?这样做是为了提高性能.
以 `-and` 为例,我们知道表达式 `expr1 -and expr2` 不能为真,如果表达式 `expr1` 的结果为假,所以没有必要执行 `expr2`.

为什么这个很重要? 它很重要是因为我们能依靠这种行为来控制怎样来执行操作.我们会很快看到...

### 预定义的操作

从 `find` 命令得到的结果列表很有用处,但是我们真正想要做的事情是操作列表中的某些条目.
幸运地是,`find` 命令允许基于搜索结果来执行操作.有许多预定义的操作和几种方式来 应用用户定义的操作.

首先,让我们看一下几个预定义的操作:
***
表18-6: 几个预定义的 `find` 命令操作

+ `-delete` 删除当前匹配的文件.
+ `-ls` 对匹配的文件执行等同的 `ls -dils` 命令.并将结果发送到标准输出.
+ `-print` 把匹配文件的全路径名输送到标准输出.如果没有指定其它操作,这是 默认操作.
+ `-quit` 一旦找到一个匹配,退出.

和测试条件一样,还有更多的操作.

查看 `find` 命令手册得到更多细节.在第一个例子里, 我们这样做:

```bash
find ~
```

这个命令输出了我们家目录中包含的每个文件和子目录.
它会输出一个列表,因为会默认使用`-print` 操作 ,如果没有指定其它操作的话.
因此我们的命令也可以这样表述:

```bash
find ~ -print
```

我们可以使用 `find` 命令来删除符合一定条件的文件.
例如,来删除扩展名为`.BAK`(这通常用来指定备份文件) 的文件,我们可以使用这个命令:

```bash
find ~ -type f -name '*.BAK' -delete
```

在这个例子里面,用户家目录(和它的子目录)下搜索每个以`.BAK` 结尾的文件名.
当找到后,就删除它们.警告:当使用` -delete` 操作时,不用说,你应该格外小心.
首先测试一下命令, 用 `-print` 操作代替` -delete`,来确认搜索结果.

在我们继续之前,让我们看一下逻辑运算符是怎样影响操作的.考虑以下命令:

```bash
find ~ -type f -name '*.BAK' -print
```

正如我们所见到的,这个命令会查找每个文件名以`.BAK` (`-name '*.BAK' `) 结尾的普通文件 (`-type f`), 并把每个匹配文件的相对路径名输出到标准输出 (`-print`).

然而,此命令按这个方式执行的原因,是 由每个测试和操作之间的逻辑关系决定的.
记住,在每个测试和操作之间会默认应用 `-and` 逻辑运算符. 我们也可以这样表达这个命令,使逻辑关系更容易看出:

```bash
find ~ -type f -and -name '*.BAK' -and -print
```

当命令被充分表达之后,让我们看看逻辑运算符是如何影响其执行的:

`-print` 只有 `-type f and -name '*.BAK'`为真的时候
`-name *.BAK` 只有` -type f `为真的时候
`-type f `总是被执行,因为它是与 `-and` 关系中的第一个测试/行为.

因为测试和行为之间的逻辑关系决定了哪一个会被执行,我们知道测试和行为的顺序很重要.
例如, 如果我们重新安排测试和行为之间的顺序,让 `-print` 行为是第一个,那么这个命令执行起来会截然不同:

```bash
find ~ -print -and -type f -and -name '*.BAK'
```

这个版本的命令会打印出每个文件(`-print` 行为总是为真),然后测试文件类型和指定的文件扩展名.

### 用户定义的行为

除了预定义的行为之外,我们也可以唤醒随意的命令.
传统方式是通过 `-exec` 行为.这个 行为像这样工作:`-exec command {} ;`

这里的 `command` 就是指一个命令的名字,`{}`是当前路径名的符号表示,分号是要求的界定符 表明命令结束.
这里是一个使用 `-exec` 行为的例子,其作用如之前讨论的 `-delete` 行为:

```bash
-exec rm '{}' ';'
```

重述一遍,因为花括号`{}`和分号`;`对于 `shell` 有特殊含义,所以它们必须被引起来或被转义.

也有可能交互式地执行一个用户定义的行为.
通过使用 `-ok` 行为来代替 `-exec`,在执行每个指定的命令之前, 会提示用户:

```bash
find ~ -type f -name 'foo*' -ok ls -l '{}' ';'
< ls ... /home/me/bin/foo > ? y
...
```

在这个例子里面,我们搜索以字符串`foo`开头的文件名,并且对每个匹配的文件执行 `ls -l` 命令.
使用 `-ok `行为,会在 `ls` 命令执行之前提示用户.

### 提高效率

当 `-exec` 行为被使用的时候,若每次找到一个匹配的文件,它会启动一个新的指定命令的实例.
我们可能更愿意把所有的搜索结果结合起来,再运行一个命令的实例.例如,而不是像这样执行命令:

```bash
ls -l file1
ls -l file2
```

我们更喜欢这样执行命令:

```bash
ls -l file1 file2
```

这样就导致命令只被执行一次而不是多次.有两种方法可以这样做.
传统方式是使用外部命令 `xargs`,另一种方法是,使用 `find` 命令自己的一个新功能.
我们先讨论第二种方法.

通过把末尾的分号改为加号,就激活了 `find` 命令的一个功能,把搜索结果结合为一个参数列表, 然后执行一次
所期望的命令.

```bash
find ~ -type f -name 'foo*' -exec ls -l '{}' +
-rwxr-xr-x 1 me
```

虽然我们得到一样的结果,但是系统只需要执行一次 `ls` 命令.

### find 补充

find 有一些称为`Global option`（全局选项）的选项，对于出现在前面的Test，它们仍然会产生影响。
如果你把它放在别的位置，`find`会报出警告。它应该被放在`star points...`后面，也就是文件列表的后面。

`...`表示一个参数可以有多个

诸如 `-maxdepth levels`,`-mindepth levels`都是全局参数。

`-maxdepth 0 ` 表示只应用在`开始点`列表本身
`-mindepth  1` 表示排除开始点列表，测试其余

因为经常遇到文件名中包含空格，所以有一个常用操作

```bash
find ./ -mindepth 1 -maxdepth 1 -type f -iname '*.jpg' -print0 | xargs --null ls -l
```

通过指定分隔符为`null`(ASCII`0`)，来构建参数列表

### xargs

这个 `xargs` 命令会执行一个有趣的函数.它从标准输入接受输入,并把输入转换为一个特定命令的 参数列表.
对于我们的例子,我们可以这样使用它:

```bash
find ~ -type f -name 'foo\*' -print | xargs ls -l
-rwxr-xr-x 1 me
```

这里我们看到 `find` 命令的输出被管道到 `xargs` 命令,反过来,`xargs` 会为 `ls` 命令构建 参数列表,然后执行 `ls` 命令.

注意:当被放置到命令行中的参数个数相当大时,参数个数是有限制的.
有可能创建的命令 太长以至于 shell 不能接受.
当命令行超过系统支持的最大长度时,`xargs` 会执行带有最大 参数个数的指定命令,然后重复这个过程直到耗尽标准输入.
执行带有 `–show–limits` 选项 的 `xargs` 命令,来查看命令行的最大值.

[Shell中去掉文件中的换行符简单方法][]

[]: https://blog.csdn.net/Jerry_1126/article/details/85009615

```bash
cat FileName | xargs echo -n   # 连文件末尾换行符也去掉
# 或者
cat FileName | xargs           # 会保留文件末尾的换行符
```

#### 处理古怪的文件名

[Shell 截取文件名和后缀][]

[Shell 截取文件名和后缀]: https://segmentfault.com/a/1190000023219453

类 Unix 的系统允许在文件名中嵌入空格(甚至换行符).

这就给一些程序,如为其它 程序构建参数列表的`xargs` 程序,造成了问题.
一个嵌入的空格会被看作是一个界定符,生成的 命令会把每个空格分离的单词解释为单独的参数.
为了解决这个问题,`find` 命令和 `xarg` 程序 允许可选择的使用一个 `null` 字符作为参数分隔符.

一个 `null` 字符被定义在 `ASCII` 码中,由数字 `0`来表示(相反的,例如,`空格字符`在 `ASCII` 码中由数字`32`表示).
`find` 命令提供的 `-print0` 行为, 则会产生由 `null` 字符分离的输出,并且 `xargs` 命令有一个 `--null` 选项,这个选项会接受由 `null` 字符 分离的输入.这里有一个例子:

```bash
find ~ -iname '*.jpg' -print0 | xargs --null ls -l
```

使用这项技术,我们可以保证所有文件,甚至那些文件名中包含空格的文件,都能被正确地处理.
例如在latex 编译脚本里，可以这么用

```
find . -iname '*.tex' -printf '%f\0' | xargs --null echo
```

其中 `-printf '%f\0'` 指定输出格式为 不带路径的文件名，然后用ASCII`null`分隔。

所有可以用的格式指定为

\a     Alarm bell.

              \b     Backspace.

              \c     Stop printing from this format immediately and flush the output.

              \f     Form feed.

              \n     Newline.

              \r     Carriage return.

              \t     Horizontal tab.

              \v     Vertical tab.

              \0     ASCII NUL.

              \\     A literal backslash (`\').

              \NNN   The character whose ASCII code is NNN (octal).

              A `\' character followed by any other character is treated as an ordinary character, so they both are printed.

              %%     A literal percent sign.

              %a     File's last access time in the format returned by the C `ctime' function.

              %Ak    File's last access time in the format specified by k, which is either `@' or a directive for the C `strftime' function.  The possible values for  k
                     are listed below; some of them might not be available on all systems, due to differences in `strftime' between systems.

%c     File's last status change time in the format returned by the C `ctime' function.

              %Ck    File's last status change time in the format specified by k, which is the same as for %A.

              %d     File's depth in the directory tree; 0 means the file is a starting-point.

              %D     The device number on which the file exists (the st_dev field of struct stat), in decimal.

              %f     File's name with any leading directories removed (only the last element).

              %F     Type of the filesystem the file is on; this value can be used for -fstype.

              %g     File's group name, or numeric group ID if the group has no name.

              %G     File's numeric group ID.

              %h     Leading directories of file's name (all but the last element).  If the file name contains no slashes (since it is in the current directory) the  %h
                     specifier expands to `.'.

              %H     Starting-point under which file was found.

              %i     File's inode number (in decimal).

              %k     The  amount of disk space used for this file in 1K blocks.  Since disk space is allocated in multiples of the filesystem block size this is usually
                     greater than %s/1024, but it can also be smaller if the file is a sparse file.

              %l     Object of symbolic link (empty string if file is not a symbolic link).

%m     File's permission bits (in octal).  This option uses the `traditional' numbers which most Unix implementations use, but if your  particular  imple‐
                     mentation  uses an unusual ordering of octal permissions bits, you will see a difference between the actual value of the file's mode and the output
                     of %m.   Normally you will want to have a leading zero on this number, and to do this, you should use the # flag (as in, for example, `%#m').

              %M     File's permissions (in symbolic form, as for ls).  This directive is supported in findutils 4.2.5 and later.

              %n     Number of hard links to file.

              %p     File's name.

              %P     File's name with the name of the starting-point under which it was found removed.

              %s     File's size in bytes.

              %S     File's sparseness.  This is calculated as (BLOCKSIZE*st_blocks / st_size).  The exact value you will get for an ordinary file of a  certain  length
                     is  system-dependent.  However, normally sparse files will have values less than 1.0, and files which use indirect blocks may have a value which is
                     greater than 1.0.   The value used for BLOCKSIZE is system-dependent, but is usually 512 bytes.   If the file size is zero, the  value  printed  is
                     undefined.  On systems which lack support for st_blocks, a file's sparseness is assumed to be 1.0.

              %t     File's last modification time in the format returned by the C `ctime' function.

              %Tk    File's last modification time in the format specified by k, which is the same as for %A.

              %u     File's user name, or numeric user ID if the user has no name.

              %U     File's numeric user ID.
%y     File's type (like in ls -l), U=unknown type (shouldn't happen)

              %Y     File's type (like %y), plus follow symlinks: L=loop, N=nonexistent

              %Z     (SELinux only) file's security context.

如果要使用通配符，需要用括号包住，或者进行转义(escape)，否则shell 会将路径名展开，find 会接受到错误的参数列表。

比如`find . -name *.c  -print`会被shell 展开为类似于：`find . -name frcode.c locate.c word_io.c -print`
这将会使`find`报错.
 Instead of doing things this way, you should enclose the pattern in quotes or escape the wildcard:

+ `$ find . -name '*.c' -print`
+ `$ find . -name \*.c -print`

`escape`:逃脱，逃离，避开，即避免`shell`对提供的字符串进行各种处理。

***
例子：抽取所有子文件，即把子目录的所有文件复制到当前目录下

`find ./  -type f -print0 | xargs -0 cp -t . --backup=t `

### 返回操练场

到实际使用 `find` 命令的时候了.我们将会创建一个操练场,来实践一些我们所学到的知识.

首先,让我们创建一个包含许多子目录和文件的操练场:

```bash
$ mkdir -p playground/dir-{00{1..9},0{10..99},100}
$ touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}
```

惊叹于命令行的强大功能!只用这两行,我们就创建了一个包含一百个子目录,每个子目录中 包含了`26`个空文件的操练场.
试试用 `GUI` 来创建它!

我们用来创造这个奇迹的方法中包含一个熟悉的命令(`mkdir`),一个奇异的 `shell` 扩展(大括号) 和一个新命令,`touch`.
通过结合 `mkdir` 命令和`-p` 选项(导致 `mkdir` 命令创建指定路径的父目录),以及 大括号展开,我们能够创建一百个目录.

这个 `touch` 命令通常被用来设置或更新文件的访问,更改,和修改时间.
然而,如果一个文件名参数是一个 不存在的文件,则会创建一个空文件.

在我们的操练场中,我们创建了一百个名为 `file-A` 的文件实例.让我们找到它们:

```bash
$ find playground -type f -name 'file-A'
```

注意不同于 `ls` 命令,`find` 命令的输出结果是无序的.其顺序由存储设备的布局决定.
为了确定实际上 我们拥有一百个此文件的实例,我们可以用这种方式来确认:

```bash
$ find playground -type f -name 'file-A' | wc -l
```

下一步,让我们看一下基于文件的修改时间来查找文件.
当创建备份文件或者以年代顺序来 组织文件的时候,这会很有帮助.为此,首先我们将创建一个参考文件,我们将与其比较修改时间:

```bash
$ touch playground/timestamp
```

这个创建了一个空文件,名为 `timestamp`,并且把它的修改时间设置为当前时间.
我们能够验证 它通过使用另一个方便的命令,`stat`,是一款加大马力的 `ls` 命令版本.
这个 stat 命令会展示系统对 某个文件及其属性所知道的所有信息:

```bash
$ stat playground/timestamp
File: 'playground/timestamp'
Size: 0 Blocks: 0 IO Block: 4096 regular empty file
...
```

下一步,让我们使用 find 命令来更新一些操练场中的文件:

```bash
$ find playground -type f -name 'file-B' -exec touch '{}' ';'
```

这会更新操练场中所有名为 `file-B` 的文件.
接下来我们会使用 find 命令来识别已更新的文件, 通过把所有文件与参考文件 `timestamp` 做比较:

```bash
$ find playground -type f -newer playground/timestamp
```

搜索结果包含所有一百个文件 `file-B` 的实例.
因为我们在更新了文件 `timestamp` 之后, `touch` 了操练场中名为 `file-B` 的所有文件,
所以现在它们"新于"`timestamp` 文件,因此能被用 `-newer` 测试条件识别出来.

最后,让我们回到之前那个错误权限的例子中,把它应用于操练场里:

```bash
$ find playground \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)
```

这个命令列出了操练场中所有一百个目录和二百六十个文件(还有 `timestamp` 和操练场本身,共 `2702` 个) ,
因为没有一个符合我们`正确权限`的定义.

通过对运算符和行为知识的了解,我们可以给这个命令添加行为,对实战场中的文件和目录应用新的权限.

```bash
$ find playground \( -type f -not -perm 0600 -exec chmod 0600 '{}' ';' \) -or \( -type d -not -perm 0711 -exec chmod 0700 '{}' ';' \)
```

在日常的基础上,我们可能发现运行两个命令会比较容易一些,一个操作目录,另一个操作文件,
而不是这一个长长的复合命令,但是很高兴知道,我们能这样执行命令.

这里最重要的一点是要 理解怎样把操作符和行为结合起来使用,来执行有用的任务.

### 选项

最后,我们有这些选项.这些选项被用来控制 `find` 命令的搜索范围.
当构建 `find` 表达式的时候, 它们可能被其它的测试条件和行为包含:
***
表 18-7: find 命令选项
选项 描述

+ `-depth` 指导 `find` 程序先处理目录中的文件,再处理目录自身.当指定`-delete` 行为时,会自动 应用这个选项.
+ `-maxdepth levels` 当执行测试条件和行为的时候,设置 `find` 程序陷入目录树的最大级别数
+ `-mindepth levels` 在应用测试条件和行为之前,设置 `find`程序陷入目录数的最小级别数.
+ `-mount 指导 find` 程序不要搜索挂载到其它文件系统上的目录.
+ `-noleaf 指导 find` 程序不要基于搜索类 Unix 的文件系统做出的假设,来优化它的搜索.

拓展阅读

程序 locate,`updatedb`,find 和 xargs 都是 GNU 项目 findutils 软件包的一部分.
这个 GUN 项目提供了大量的在线文档,这些文档相当出色,如果你在高安全性的 环境中使用这些程序,你应该读读这些文档.
[http://www.gnu.org/software/findutils/][]

[http://www.gnu.org/software/findutils/]: http://www.gnu.org/software/findutils/

## 第十九章:归档和备份

计算机系统管理员的一个主要任务就是保护系统的数据安全,其中一种方法是通过定时备份系统文件,来保护数据.
即使你不是一名系统管理员,像做做拷贝或者在各个位置和设备之间移动大量的文件,通常也是很有帮助的.

在这一章中,我们将会看看几个经常用来管理文件集合的程序.它们就是文件压缩程序:

+ `gzip` – 压缩或者展开文件
+ `bzip2` – 块排序文件压缩器

归档程序:

+ `tar` – 磁带打包工具
+ `zip` – 打包和压缩文件

还有文件同步程序:

+ `rsync` – 同步远端文件和目录

### 压缩文件

纵观计算领域的发展历史,人们努力想把最多的数据存放到到最小的可用空间中,不管是内存,存储设备 还是网络带宽.
诸如便携式音乐播放器, 高清电视,或宽带网络之类的存在都应归功于高效的数据压缩技术.

数据压缩就是一个删除冗余数据的过程.

比方说我们有一张`100*100`像素的 纯黑的图片文件,假定每个像素占`24`位,或者`3`个字节,那么这张图像将会占用 `30,000` 个字节的存储空间:

```bash
100 * 100 * 3 = 30,000
```

一张单色图像包含的数据全是多余的.我们只要简单地描述这个事实,我们有3万个黑色的像素数据块.
所以,我们不存储包含`3万`个`0` (通常在图像文件中,黑色由`0`来表示)的数据块,
相反,我们把这些数据压缩为数字`30,000`, 后跟一个`0`.
这种数据压缩方案被称为游程编码,是一种最基本的压缩技术.

压缩算法(数学技巧被用来执行压缩任务)分为两大类,无损压缩和有损压缩.

无损压缩保留了原始文件的所有数据.还原出的文件与原文件一模一样.

而另一方面,有损压缩,执行压缩操作时会删除数据,允许更大的压缩.
有损文件被还原后, 与原文件不相匹配，而是一个近似值.
有损压缩的例子有 `JPEG`(图像)文件和 `MP3`(音频)文件.

在我们的讨论中,我们将看看完全无损压缩,因为计算机中的大多数数据是不能容忍丢失任何数据的.

### gzip

`gzip` 程序被用来压缩一个或多个文件.
当执行 `gzip` 命令时,原始文件的压缩版会替代原始文件.相对应的 `gunzip` 程序用来把压缩文件复原.
这里有个例子:

```bash
$ ls -l /etc > foo.txt
$ gzip foo.txt
$ gunzip foo.txt.gz
```

在这个例子里,我们创建了一个名为 `foo.txt` 的文本文件,其内容是一个目录的列表.

接下来,我们运行 `gzip` 命令,它会把原始文件替换为一个叫做 `foo.txt.gz` 的压缩文件.

在 `foo.*` 文件列表中,我们看到原始文件已经被压缩文件替代了,这个压缩文件大约是原始文件的十五分之一.
我们也能看到压缩文件与原始文件有着相同的权限和时间戳.

接下来,我们运行 `gunzip` 程序来解压缩文件.
随后,我们见到压缩文件已经被原始文件替代了, 同样地保留了相同的权限和时间戳.

`gzip` 命令有许多选项.这里列出了一些:
表19-1: gzip 选项
***
选项 说明

+ `-c` 把输出写入到标准输出,并且保留原始文件.也能用 `--stdout` 和 `--to-stdout` 选项来指定.
+ `-d` 解压缩.正如 `gunzip` 命令一样.也可以用`--decompress` 或者`--uncompress` 选项来指定.
+ `-f` 强制压缩,即使原始文件的压缩文件已经存在了,也要执行.也可以用`--force`选项来指定.
+ `-h` 显示用法信息.也可用`--help` 选项来指定.
+ `-l` 列出每个被压缩文件的压缩数据.也可用`--list` 选项.
+ `-r` 若命令的一个或多个参数是目录,则递归地压缩目录中的文件.也可用`--recursive` 选项来指定.
+ `-t` 测试压缩文件的完整性.也可用`--test`选项来指定.
+ `-v` 显示压缩过程中的信息.也可用`--verbose` 选项来指定.
+ `-number` 设置压缩指数.`number` 是一个在`1`(最快,最小压缩)到`9`(最慢,最大压缩)之间的整数.
数值`1`和`9`也可以用`--fast`和`--best` 选项来表示.默认值是整数6.

返回到我们之前的例子中:

```bash
$ gzip foo.txt
$ gzip -tv foo.txt.gz
foo.txt.gz: OK
$ gzip -d foo.txt.gz
```

这里,我们用压缩文件来替代文件 `foo.txt`,压缩文件名为 `foo.txt.gz`.
下一步,我们测试了压缩文件 的完整性,使用了`-t` 和 `-v` 选项.

```bash
$ ls -l /etc | gzip > foo.txt.gz
```

这个命令创建了一个目录列表的压缩文件.
`gunzip` 程序,会解压缩 `gzip` 文件,假定那些文件名的扩展名是`.gz`,所以没有必要指定它, 只要指定的名字与现有的未压缩文件不冲突就可以:

```bash
$ gunzip foo.txt
```

如果我们的目标只是为了浏览一下压缩文本文件的内容,我们可以这样做:

```bash
$ gunzip -c foo.txt | less
```

另外,对应于 `gzip` 还有一个程序,叫做 `zcat`,它等同于带有`-c` 选项的 `gunzip` 命令.
它可以被用来如 `cat` 命令作用于 `gzip` 压缩文件:

```bash
$ zcat foo.txt.gz | less
```

小贴士: 还有一个 `zless` 程序.它与上面的管道线有相同的功能.

### bzip2

`bzip2` 程序,由 Julian Seward 开发,与 `gzip` 程序相似,但使用了不同的压缩算法, 舍弃了压缩速度,从而实现了更高的压缩级别. 在大多数情况下,它的工作模式等同于 `gzip` . 由 `bzip2` 压缩的文件,用扩展名 `.bz2`来表示:

```bash
$ ls -l /etc > foo.txt
$ ls -l foo.txt
$ bzip2 foo.txt
$ ls -l foo.txt.bz2
$ bunzip2 foo.txt.bz2
```

正如我们所看到的, `bzip2` 程序用起来和 `gzip` 程序一样.

我们之前讨论的 `gzip` 程序的所有选项(除了`-r`) ,`bzip2` 程序同样也支持.
注意,然而,压缩级别选项(`-number`)对于 `bzip2` 程序来说,含义有稍许不同.

伴随着 `bzip2` 程序,有 `bunzip2` 和 `bzcat` 程序用来解压缩文件.
还有 `bzip2recover` 程序,可以用来尝试恢复受损的 `.bz2` 文件.

#### 不要强迫性压缩

偶尔会有人试图用高效的压缩算法,来压缩一个已经被压缩过的文件:

```bash
$ gzip picture.jpg
```

不要这样， 你可能只是在浪费时间和空间.
如果你再次压缩已经压缩过的文件,实际上你会得到一个更大的文件.
这是因为所有的压缩技术都会涉及一些开销,文件中会被添加描述此次压缩过程的信息.
如果你试图压缩一个已经不包含多余信息的文件,那么再次压缩不会节省空间,以抵消额外的开销.

### 归档文件

一个常见的,与文件压缩结合一块使用的文件管理任务是归档.
归档就是收集许多文件,并把它们 捆绑成一个大文件的过程.

归档经常作为系统备份的一部分来使用.
当把旧数据从一个系统移到某种类型的长期存储设备中时,也会用到归档程序.

### tar

在类 `Unix` 的软件世界中,这个 `tar` 程序是用来归档文件的经典工具.
它是 `tape archive` 的简称,揭示了它的起源是一款制作磁带备份的工具.
虽然仍被用来完成传统任务, 它也同样适用于其它类型的存储设备.

我们经常看到扩展名为 `.tar` 或者 `.tgz` 的文件,它们各自表示`普通` 的 `tar` 包和被 `gzip` 程序压缩过的 `tar` 包.
一个 `tar` 包可以由一组独立的文件,一个或者多个目录,或者 两者混合体组成. 命令语法如下:

```bash
tar mode[options] pathname...
```

这里的 `mode` 是指以下操作模式之一(这里只展示了一部分,查看 `tar` 的手册来得到完整列表):
***
表19-2: `tar` 模式
模式 说明

+ `c` 为文件和/或目录列表创建归档文件.
+ `x` 抽取归档文件.
+ `r` 追加具体的路径到归档文件的末尾.
+ `t` 列出归档文件的内容.

`tar` 命令使用了稍微有点奇怪的方式来表达它的选项,所以我们需要一些例子来展示它是怎样工作的.
首先,让我们重新创建之前我们用过的操练场:

```bash
$ mkdir -p playground/dir-{00{1..9},0{10..99},100}
$ touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}
```

下一步,让我们创建整个操练场的 `tar` 包:

```bash
$ tar cf playground.tar playground
```

这个命令创建了一个名为 `playground.tar` 的 tar 包,其包含整个 `playground` 目录层次结果.
我们 可以看到模式 `c` 和选项 `f`,其被用来指定这个 `tar` 包的名字,模式和选项可以写在一起,而且不需要开头的短横线.

注意,必须首先指定模式,然后才是其它的选项.

要想列出归档文件的内容,我们可以这样做:

```bash
$ tar tf playground.tar
```

为了得到更详细的列表信息,我们可以添加选项 `v`:

```bash
$ tar tvf playground.tar
```

现在,抽取 `tar` 包 `playground` 到一个新位置.
我们先创建一个名为 `foo` 的新目录,更改目录, 然后抽取 `tar` 包中的文件:

```bash
$ mkdir foo
$ cd foo
$ tar xf ../playground.tar
$ ls playground
```

如果我们检查 `~/foo/playground` 目录中的内容,会看到这个已经成功创建了原始文件的精确副本.
然而有个警告:除非你是超级用户,否则从归档文件中抽取的文件和目录的所有权在执行复原操作的用户手里,而不属于原始所有者.

***
`tar` 命令另一个有趣的行为是它处理归档文件路径名的方式.

默认情况下,路径名是相对的,而不是绝对路径.
当创建归档文件的时候,`tar` 命令会简单地删除路径名开头的斜杠.
为了说明问题,我们将重新创建我们的归档文件,这次指定一个绝对路径:

```bash
$ cd
$ tar cf playground2.tar ~/playground
```

记住,当按下回车键后,`~/playground` 会展开成 `/home/me/playground`,所以我们会得到一个绝对路径.
接下来和之前一样，我们抽取归档文件,观察发生了什么:

```bash
$ cd foo
$ tar xf ../playground2.tar
$ ls
home playground
$ ls home
me
$ ls home/me
playground
```

我们看到，当抽取第二个归档文件时,它重新创建了 `home/me/playground` 目录。
并且是相对于当前的工作目录`~/foo`,而不是相对于 `root`。
这看起来似乎是一种奇怪的工作方式,但事实上这种方式很有用,因为这样就允许我们抽取文件到任意位置,
而不是强制地把抽取的文件放置到原始目录下.

加上 `verbose`(`v`)选项,重做 这个练习,将会展现更加详细的信息.

***
让我们展示一个`tar`命令的实际应用.

假定我们想要复制家目录及其内容到另一个系统中, 并且有一个大容量的 `USB` 硬盘,可以作为传输工具.

在现代 `Linux` 系统中, 这个硬盘会被`自动地`挂载到 `/media` 目录下.
我们也假定硬盘中有一个名为 `BigDisk` 的逻辑卷. 为了制作 `tar` 包,我们可以这样做:

```bash
$ sudo tar cf /media/BigDisk/home.tar /home
```

`tar` 包制作完成之后,我们卸载硬盘,然后把它连接到第二个计算机上.
再一次,此硬盘被挂载到`/media/BigDisk` 目录下.为了抽取归档文件,我们这样做:

```bash
$ cd /
$ sudo tar xf /media/BigDisk/home.tar
```

值得注意的一点是,因为归档文件中的所有路径名都是相对的,
所以首先我们必须更改目录到根目录下, 这样抽取的文件路径是相对于根目录的.

当抽取一个归档文件时,可以限制从归档文件中抽取的内容. 例如抽取单个文件, 可以这样实现:

```bash
tar xf archive.tar pathname
```

通过给命令添加末尾的路径名,`tar` 命令就只会恢复指定的文件.可以指定多个路径名.
注意:路径名必须是精准的相对路径名,和存储在归档文件中的完全一样.

当指定路径名的时候, 通常不支持通配符.
然而,`GNU` 版本的 `tar` 命令(在 Linux 发行版中最常出现)可以通过 `--wildcards` 选项来支持通配符.
这个例子使用了之前的 `playground.tar` 文件:

```bash
$ cd foo
$ tar xf ../playground2.tar --wildcards 'home/me/playground/dir-*/file-A'
```

这个命令将只会抽取路径名匹配 `dir-*`的文件。

`tar` 命令经常结合 `find` 命令一起来制作归档文件.
我们可以使用 `find`来产生一个文件集合,然后把它们加入到归档文件中.

```bash
$ find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'
```

这里我们使用 `find` 命令来匹配 `playground` 目录中所有名为 `file-A` 的文件,
然后使用 `-exec` 行为,来唤醒带有追加模式(`r`)的 `tar` 命令,把匹配的文件添加到归档文件 `playground.tar` 中.

使用 `tar` 和 `find` 命令,来创建逐渐增加的目录树，或者整个系统的备份,是个不错的方法.
通过 `find` 命令匹配新于某个时间戳的文件,我们就能够创建一个归档文件,
令其只包含新于上一个 `tar` 包的文件(假定这个时间戳文件恰好在每个归档文件创建之后被更新了).

`tar` 命令也可以利用标准输出和输入.这里是一个完整的例子:

```bash
$ cd
$ find playground -name 'file-A' | tar cf - --files-from=- | gzip > playground.tgz
```

在这个例子里面,我们使用 `find` 程序产生了一个匹配文件列表,然后把它们管道到 `tar` 命令中.

如果指定了文件名`-`,则其被看作是标准输入或标准输出.
在上面的例子中`tar cf -`中的是标准输出,`--files-from=-`中的是标准输入.
(顺便说一下,使用`-`来表示 标准输入/输出的惯例,也被大量的其它程序使用).

这个 `--file-from` 选项(也可以用 `-T` 来指定) 导致 `tar` 命令从一个文件而不是命令行来读入它的路径名列表.

最后,这个由 `tar` 命令产生的归档 文件被管道到 `gzip` 命令中,然后创建了压缩归档文件 `playground.tgz`.
`.tgz` 扩展名是被`gzip` 压缩过的 `tar` 文件的常规扩展名.有时候也会使用 `.tar.gz`这个扩展名.

### 顺便压缩

在这里我们手动调用了`gzip`来制作归档文件的压缩版本.
实际上现在 GUN 版本的 `tar` 命令 ,可以直接在归档的同时进行压缩,`gzip`压缩对应选项`z`，`bzip2` 压缩对应选项`j`.
之前的例子可以简化为:

```bash
# 创建一个由 gzip 压缩的归档文件,可以这样做:
$ find playground -name 'file-A' | tar czf playground.tgz -T -
# 创建一个由 bzip2 压缩的归档文件,可以这样做:
$ find playground -name 'file-A' | tar cjf playground.tbz -T -
```

***
另一个 `tar` 命令与标准输入和输出的有趣使用,涉及到在系统之间经过 网络传输文件.

假定我们有两台机器,每台都运行着类 Unix,且装备着 `tar` 和 `ssh` 工具的操作系统.
在这种情景下,我们可以把一个目录从远端系统(名为 `remote-sys`)传输到我们的本地系统中:

```bash
$ mkdir remote-stuff
$ cd remote-stuff
$ ssh remote-sys 'tar cf - Documents' | tar xf -
me@remote-sys' s password:
$ ls Documents
```

这里我们能够从远端系统 `remote-sys` 中复制目录 `Documents` 到本地系统名为 `remote-stuff` 目录中.

我们怎样做的呢?首先,通过使用 `ssh` 命令在远端系统中启动 `tar` 程序.
你可记得 `ssh` 允许我们在远程联网的计算机上执行程序,并将远端系统中产生的输出结果被发送到本地系统中查看.
然后在本地系统中,我们执行 `tar xf -` 命令, 抽取标准输出中的文件.

### zip

`zip` 程序既是压缩工具,也是一个打包工具. 
它读取和写入 `.zip` 文件, `Windows` 用户比较熟悉这种文件格式.
然而,在 Linux 中 `gzip` 是主要的压缩程序, `bzip2`则排第二.

在 `zip` 命令的基本用法为：

```bash
zip options zipfile file...
```

例如,制作一个 `playground` 的 `zip` 版本的文件包,这样做:

```bash
$ zip -r playground.zip playground
```

我们需要包含 `-r` 选项,不然只有 `playground` 目录(没有任何它的内容)被存储.
虽然程序会自动添加 `.zip` 扩展名,但为了清晰起见,我们还是手动加上.

在创建 `zip` 版本的文件包时,`zip` 命令通常会显示一系列的信息:

```bash
adding: playground/dir-020/file-Z (stored 0%)
adding: playground/dir-020/file-Y (stored 0%)
```

这些信息显示了添加到文件包中每个文件的状态.

`zip` 命令会选用两种存储方法之一,来添加文件到文件包中:
一种是`store`,没有经过压缩的文件,正如这里所示,
另一种是`deflate`, 执行压缩操作.
在存储方法之后显示的数值表明了压缩量.

因为我们的 `playground` 目录只包含空文件,没有对它的内容执行压缩操作.

***
使用 `unzip` 程序,来直接抽取一个 `zip` 文件的内容.

```bash
$ cd foo
$ unzip ../playground.zip
```

对于 `zip` 命令(与 `tar` 命令相反)要注意一点,就是如果指定了的文件包已经存在,那么它会被更新而不是被替代.
这意味着会保留此文件包,但是会添加新文件,同时替换匹配的文件.

可以列出 文件或者有选择地从一个 `zip` 文件包中抽取文件,只要给 `unzip` 命令指定文件名:

```bash
$ unzip -l playground.zip playground/dir-087/file-Z
$ cd foo
$ unzip ./playground.zip playground/dir-087/file-Z
```

使用 `-l` 选项,导致 `unzip` 命令只是列出文件包中的内容而没有抽取文件.

如果没有指定文件, `unzip` 程序将会列出文件包中的所有文件.
添加这个 `-v` 选项会增加列表的冗余信息.注意当抽取的文件与已经存在的文件冲突时,会在替代此文件之前提醒用户.

像 `tar` 命令一样,`zip` 命令能够利用标准输入和输出,虽然它的实施不大有用.
通过`-@`选项,有可能把一系列的文件名管道到 `zip` 命令.

```bash
$ cd
$ find playground -name "file-A" | zip -@ file-A.zip
```

这里我们使用 `find` 命令产生一系列与`file-A`相匹配的文件列表,并且把此列表管道到 `zip` 命令,然后创建包含所选文件的文件包 `file-A.zip`.

`zip` 命令也支持把它的输出写入到标准输出,但是它的使用是有限的,因为很少的程序能利用输出.
不幸地是,`unzip` 程序不接受标准输入.这就阻止了 `zip` 和 `unzip` 一块使用,像 `tar` 命令那样, 来复制网络上的文件.

然而`zip` 命令可以接受标准输入,所以它可以被用来压缩其它程序的输出:

```bash
$ ls -l /etc/ | zip ls-etc.zip -
adding: - (deflated 80%)
```

在这个例子里,我们把 `ls` 命令的输出管道到 `zip` 命令.
像 `tar` 命令,`zip` 命令把末尾的`横杠`解释为 `使用标准输入作为输入文件`

通过指定`-p`选项,`unzip` 程序允许把它的结果发送到标准输出:

```bash
$ unzip -p ls-etc.zip | less
```

我们讨论了一些 `zip`/`unzip` 可以完成的基本操作.
它们两个都有许多选项,其增加了 命令的灵活性,虽然一些选项只针对于特定的平台.

`zip` 和 `unzip` 命令的说明手册都相当不错, 并且包含了有用的实例.
然而,这些程序的主要用途是为了和 `Windows` 系统交换文件,
而不是在 `Linux` 系统中执行压缩和打包操作,`tar` 和 `gzip` 程序在Linux 系统中更受欢迎.

### 同步文件和目录

维护系统备份的常见策略是保持一个或多个目录与另一个本地系统(通常是某种可移动的存储设备) ,
或者远端系统中的目录(或多个目录)同步.

例如我们有一个在开发中的网站, 需要经常将它的本地备份与远端网络服务器保持同步.
在类 Unix 系统的世界里,能完成此任务且备受人们喜爱的工具是 `rsync`.

这个程序能同步本地与远端的目录,通过使用 `rsync` 远端更新协议,此协议允许 `rsync` 快速地检测两个目录的差异,执行最小量的复制来达到目录间的同步.
比起其它种类的复制程序, 这就使得`rsync` 命令非常快速和高效.

唤醒`rsync`：

```bash
$ rsync options 源 目标
```

这里 `源` 和 `目标` 是下列选项之一:

+ 一个本地文件或目录一个远端文件或目录,以 `[user@]host:path` 的形式存在
+ 一个远端 `rsync` 服务器,由 `rsync://[user@]host[:port]/path` 指定

注意 `源` 和 `目标` 两者之一必须是本地文件,`rsync` 不支持远端到远端的复制.

让我们试着对一些本地文件使用 `rsync` 命令.首先,清空我们的 `foo` 目录:

```bash
$ rm -rf foo/*
```

下一步,我们同步 `playground` 目录和它在 `foo` 目录中对应的副本

```bash
$ rsync -av playground foo
```

我们使用了`-a` 选项(`递归`和`保护文件属性`)和 `-v` 选项(冗余输出), 以把`playground` 目录的内容同步到 `foo` 目录.
当这个命令执行的时候, 我们将会看到一系列的文件和目录被复制.
在最后,我们将看到一条像这样的总结信息:

```bash
sent 135759 bytes received 57870 bytes 387258.00 bytes/sec
total size is 3230 speedup is 0.02
...
```

它说明了复制的数量.

如果再次运行这个命令,我们将会看到不同的结果:

```bash
$ rsync -av playgound foo
building file list ... done
sent 22635 bytes received 20 bytes
total size is 3230 speedup is 0.14
45310.00 bytes/sec
```

注意到这一次的输出没有文件列表.
这是因为 `rsync` 程序检测到目录`~/playground` 和 `~/foo/playground` 之间不存在差异,因此它不需要复制任何数据.
如果我们在 `playground` 目录中修改一个文件,然后 再次运行 `rsync` 命令:

```bash
$ touch playground/dir-099/file-Z
$ rsync -av playground foo
building file list ... done
playground/dir-099/file-Z
```

我们看到 `rsync` 命令检测到更改,并且只复制了更新的文件.

考虑之前`tar` 命令中的例子，我们再次把此硬盘连接到系统,
它被挂载到`/media/BigDisk` 目录下,我们可以执行一个有用的系统备份了.

首先在外部硬盘上创建一个目录,名为`/backup`,然后使用 `rsync` 程序从我们的系统中复制最重要的数据到外部硬盘上:

```bash
$ mkdir /media/BigDisk/backup
$ sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup
```

在这个例子里,我们把`/etc`,`/home`,和`/usr/local` 目录从我们的系统中复制到外部硬盘的`/media/BigDisk/backup`目录上.

我们使用了`--delete` 这个选项,来删除可能在备份设备中已经存在但却不再存在于源设备中的文件, 
(这与我们第一次创建备份无关,但是会在随后的复制操作中发挥作用).

挂载外部驱动器,运行 `rsync` 命令,不断重复这个过程,是一个不错的系统(虽然不理想)备份方式.
当然,别名会对这个操作更有帮助些.我们创建一个别名,并把它添加到`.bashrc` 文件中, 来提供这个特性:

```bash
alias backup='sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup'
```

现在我们只需要连接外部驱动器,然后运行 `backup` 命令来完成工作.

### 在网络间使用 `rsync` 命令

`rsync` 程序的真正好处之一,是它可以被用来在网络间复制文件.毕竟,`rsync` 中的`r`象征着`remote`.

远程复制可以通过两种方法完成.

***
第一个方法要求另一个系统已经安装了 `rsync` 程序,还安装了远程 `shell` 程序,比如 `ssh`.
比方说我们本地网络中的某系统有大量可用的硬盘空间,我们用这个远程系统代替外部驱动器,来执行文件备份操作.

假定远程系统中有一个名为`/backup` 的目录, 其用来存放我们传送的文件,我们这样做:

```bash
$ sudo rsync -av --delete --rsh=ssh /etc /home /usr/local remote-sys:/backup
```

我们对命令做了两处修改,来方便网络间文件复制.

+ 首先,我们添加了`--rsh=ssh` 选项,其指示 `rsync` 使用 `ssh`程序作为它的远程 `shell`.
这样我们就能使用 `ssh` 加密通道,来把数据安全地传送到远程主机中.
+ 其次,在目标路径名前面指定了远端主机的名字(此例中远端主机名为 `remote-sys`),.

***
第二种方式是通过使用 `rsync` 服务器.
`rsync` 可以被配置为一个 守护进程,监听即将到来的同步请求.
这样做通常是为了方便一个远程系统的镜像.

例如,Red Hat 软件中心为它的Fedora 发行版,维护着一个巨大的开发中软件包的仓库.
对于软件测试人员, 在发行周期的测试阶段,镜像这些软件集合是非常有帮助的.
因为仓库中的这些文件会频繁地 (通常每天不止一次)改动,定期同步本地镜像更加合理, 而不是大量地拷贝软件仓库.

这些软件库之一被维护在 `Georgia Tech`.
我们可以使用本地`rsync` 程序和`Georgia Tech`的 `rsync` 服务器来镜像它.

```bash
$ mkdir fedora-devel
$ rsync -av -delete rsync://rsync.gtlib.gatech.edu/fedora-linux-core/development/i386/os fedora-devel
```

在这个例子里,我们使用了远端 `rsync` 服务器的 `URI`.
`URI`由协议(`rsync://`),远端主机名(`rsync.gtlib.gatech.edu`),和软件仓库的路径名组成.

拓展阅读

在这里讨论的所有命令的手册文档都相当清楚明白,并且包含了有用的例子.
另外, GNU 版本的 `tar` 命令有一个不错的在线文档.

可以在下面链接处找到:[http://www.gnu.org/software/tar/manual/index.html][]

[http://www.gnu.org/software/tar/manual/index.html]: http://www.gnu.org/software/tar/manual/index.html
