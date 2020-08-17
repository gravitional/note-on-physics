# ubuntu-6

## 第十七章:网络系统

当谈及到网络系统层面,几乎任何东西都能由 Linux 来实现.

`Linux` 被用来创建各式各样的网络系统和装置, 包括防火墙,路由器,名称服务器,网络连接式存储设备等等.

被用来配置和操作网络系统的命令数目,就如网络系统一样巨大.我们仅仅会关注一些最经常 使用到的命令.
我们要研究的命令包括那些被用来监测网络和传输文件的命令.另外,我们 还会探讨用来远端登录的 ssh 程序.
这章会介绍:

+ `ping` - 发送 ICMP ECHO_REQUEST 软件包到网络主机
+ `traceroute` - 打印到一台网络主机的路由数据包
+ `netstat` - 打印网络连接,路由表,接口统计数据,伪装连接,和多路广播成员
+ `ftp` - 因特网文件传输程序
+ `wget` - 非交互式网络下载器
+ `ssh` - OpenSSH SSH 客户端(远程登录程序)

`pint ifconfig netstat traceroute` 等在软件包 `gnome-nettool` 里面

我们假定你已经知道了一点网络系统背景知识.
在这个因特网时代,每个计算机用户需要理解基本的网络 系统概念.为了能够充分利用这一章节的内容,我们应该熟悉以下术语:

IP (网络协议)地址
主机和域名
URI(统一资源标识符)

请查看下面的`拓展阅读`部分,有几篇关于这些术语的有用文章.

注意:一些将要讲到的命令可能(取决于系统发行版)需要从系统发行版的仓库中安装额外的软件包, 并且一些
命令可能需要超级用户权限才能执行.

### 检查和监测网络

即使你不是一名系统管理员,检查一个网络的性能和运作情况也是经常有帮助的.

```bash
ping
```

最基本的网络命令是 `ping`.
这个 `ping` 命令发送一个特殊的网络数据包,叫做`IMCP ECHO_REQUEST`,到 一台指定的主机.
大多数接收这个包的网络设备将会回复它,来允许网络连接验证.

注意:大多数网络设备(包括 Linux 主机)都可以被配置为忽略这些数据包.
通常,这样做是出于网络安全原因,部分地遮蔽一台主机免受一个潜在攻击者地侵袭.配置防火墙来阻塞 `IMCP` 流量也很普遍.

例如,看看我们能否连接到网站 linuxcommand.org(我们最喜欢的网站之一), 我们可以这样使用 `ping` 命令:

```bash
$ ping linuxcommand.org
```

一旦启动,ping 命令会持续在特定的时间间隔内(默认是一秒)发送数据包,直到它被中断:
$ ping linuxcommand.org
PING linuxcommand.org (66.35.250.210) 56(84) bytes of data.
64 bytes from vhost.sourceforge.net (66.35.250.210): icmp\_seq=1
ttl=43 time=107 ms
...
按下组合键 `Ctrl-c`,中断这个命令之后,`ping` 打印出运行统计信息.一个正常工作的网络会报告零个数据包丢失.
一个成功执行的`ping`命令会意味着网络的各个部件(网卡,电缆,路由,网关) 都处于正常的工作状态.

`tracepath`, `tracepath6` - traces path to a network host discovering MTU along this path

[什么是MTU？为什么MTU值普遍都是1500？][]

[什么是MTU？为什么MTU值普遍都是1500？]: https://developer.aliyun.com/article/222535

`Maximum Transmission Unit`,缩写`MTU`,中文名是：最大传输单元.这是哪一层网络的概念？

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

```bash
traceroute
```

这个 `traceroute` 程序(`ubuntu` 使用相似的 `tracepath` 程序来代替)会显示从本地到指定主机 要经过的所有`跳数`的网络流量列表.
例如,看一下到达 `soso.com` 网站,需要经过的路由 器,我们将这样做:

```
$ traceroute soso.com
```

命令输出看起来像这样:
traceroute to soso.com (216.34.181.45), 30 hops max, 40 bytepackets
1 ipcop.localdomain (192.168.1.1) 1.066 ms 1.366 ms 1.720 ms
2 * * *
...
...

从输出结果中,我们可以看到连接测试系统到 `soso.com` 网站需要经由16个路由器.
对于那些 提供标识信息的路由器,我们能看到它们的主机名,`IP` 地址和性能数据,这些数据包括三次从本地到 此路由器的往返时间样
本.
对于那些没有提供标识信息的路由器(由于路由器配置,网络拥塞,防火墙等 方面的原因),我们会看到几个星号,正如行中所示.

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
最显著的区别就是源或者目标路径名要以远端主机的名字,后跟一个**冒号**字符开头.

例如,如果我们想要 从远端系统`remote-sys`的家目录下复制文档`document.txt`,到我们本地系统的当前工作目录下, 可以这样操作:

```bash
$ scp remote-sys:document.txt .
me@remote-sys's password:
...
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

### Linux 配置SSH免密登录`ssh-keygen`

[Linux 配置SSH免密登录`ssh-keygen`][]

[Linux 配置SSH免密登录`ssh-keygen`]: https://www.jb51.net/article/163093.htm

为了在不同平台/网络主机之间的通信安全, 很多时候我们都要通过ssh进行认证. ssh认证方式主要有2种:

+ 基于口令的安全认证: 每次登录的时候都要输入用户名和密码, 由于要在网络上传输密码, 可能存在中间人攻击的风险;
+ 基于密钥的安全认证: 配置完成后就可以实现免密登录, 这种方式更加安全 -- 不需要在网络上传递口令, 只需要传输一次公钥. 
常见的`git`的`ssh`方式就是通过公钥进行认证的.

#### 配置SSH免密登录

说明: 这里演示所用的服务器操作系统是`Cent OS 7`. 我们的目标是:
`A`服务器(`172.16.22.131`) 能免密登录`B`服务器 (`172.16.22.132`).

注意: `ssh`连接是单向的, `A`能免密登录`B`, 并不能同时实现`B`能免密登录`A`.

#### 安装必需的软件

在操作之前, 先确保所需要的软件已经正常安装.

这里我们需要安装`ssh-keygen`和`ssh-copy-id`, 

#### ssh-keygen创建公钥-私钥对

(1) 在指定目录下生成rsa密钥, 并指定注释为`xxx`, 实现示例:

```bash
$ ssh-keygen -t rsa -f ~/.ssh/id_rsa -C "xxxxx"
#        ~密钥类型 ~密钥文件路径及名称 ~ 备注信息
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): # 输入密码, 若不输入则直接回车
Enter same passphrase again: # 再次确认密码, 若不输入则直接回车
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub....
```

注意: 密钥的文件名称必须是`id_xxx`, 这里的`xxx`就是`-t`参数指定的密钥类型. 
比如密钥类型是`rsa`, 那么密钥文件名就必须是`id_rsa`.

#### ssh-keygen常用参数说明:

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
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2JpLMqgeg9jB9ZztOCw0WMS8hdVpFxthqG1vOQTOji/cp0+8RUZl3P6NtzqfHbs0iTcY0ypIJGgx4eXyipfLvilV2bSxRINCVV73VnydVYl5gLHsrgOx+372Wovlanq7Mxq06qAONjuRD0c64xqdJFKb1OvS/nyKaOr9D8yq/FxfwKqK7TzJM0cVBAG7+YR8lc9tJTCypmNXNngiSlipzjBcnfT+5VtcFSENfuJd60dmZDzrQTxGFSS2J34CuczTQSsItmYF3DyhqmrXL+cJ2vjZWVZRU6IY7BpqJFWwfYY9m8KaL0PZ+JJuaU7ESVBXf6HJcQhYPp2bTUyff+vdV shoufeng
# 可以看到最后有一个注释内容shoufeng
```

#### `ssh-copy-id`把A的公钥发送给B

默认用法是: `ssh-copy-id root@172.16.22.132`, 

`ssh-copy-id`命令连接远程服务器时的默认端口是`22,` 当然可以指定`文件`、远程主机的`IP`、`用户`和`端口`:

```bash
# 指定要拷贝的本地文件、远程主机的IP+用户名+端口号:
$ ssh-copy-id -i ~/.ssh/id_rsa.pub -p 22 root@172.16.22.132
...
root@172.16.22.132's password: # 输入密码后, 将拷贝公钥
...
```
 
#### 在A服务器上免密登录B服务器

```bash
$ ssh root@172.16.22.132
Last login: Fri Jun 14 08:46:04 2019 from 192.168.34.16 # 登录成功
```

#### 扩展说明

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

## ssh 使用

[Linux (一) SSH 使用][]

[Linux (一) SSH 使用]: https://www.jianshu.com/p/e6d308e9162f

### 安装

如果你的服务器上没有`ssh`服务的话,可以使用以下命令（一般来说购买的阿里云、腾讯云自动就装好了这个）

```bash
yum install openssh-server   (安装过程种我们可以发现openssh-clients 客户端也已经装好了)
service sshd start                 启动ssh服务
chkconfig sshd on  
```

### 连接服务器

确认安装好`ssh`并启动后,我们在windows、mac上或者其他linux服务器上通过以下命令便可以连接到这台主机

```bash
ssh root@192.168.0.105   
```

`root` 表示你连接改服务器的用户名

`192.168.0.105` 是服务器`ip`.这个`ip`不能使用内网`ip`,如果是本地虚拟机的话,可以将连接方式改为“桥接”的方式.
然后用`ifconfig`查看本机公网`ip`

### ssh 的 config 文件

先展示一下`SSH config` 语法关键字,如下五个：

+ `Host` 别名
+ `HostName` 主机名
+ `Port` 端口
+ `User` 用户名
+ `IdentityFile` 密钥文件的路径

这个config的路径在服务的位置是 `~/.ssh/config` 如果没有找到这个文件,就在`>~/.ssh/config`

那么说到这个文件我们怎么用呢？
实际上在平时的运维管理中,我们可能管理多台机器,可能是几台、十几台甚至几十上百台.
我们将这些服务器配置在config中,方便我们去连接和管理.

例如:(IdentityFile可以暂时不配置,ssh默认端口为22)

```bash
host "KatoUyi"
    HostName 192.168.0.105
    User root
    Port 22
    IdentityFile  ~/.ssh.id_rsa
    IdentitiesOnly  yes

host "NagaSiren"
    HostName 192.168.0.106
    User root
    Port 22
```

在配置了这个文件之后,我们不需要再通过 `ssh root@192.168.0.105` 这个命令去连接服务器了,
我们可以这么写连接语句 `ssh KatoUyi` .这样管理方式在一定程度上简化了我们的操作.

### ssh key (SSH安全免密码登录)

我们需要先了解一些基础
ssh key使用对称加密的方式生成公钥和私钥
私钥存放在本地 `~/.ssh` 目录下
公钥可以对外开放,放在服务器的 `~/.ssh/authorized_keys`

在上一节的操作当中,我们发现每次使用`ssh`连接服务器的时候,都要输入一次密码.
密码长了复杂了会很麻烦.我们可以使用`ssh key`去解决这个麻烦.

```bash
ssh-keygen -t rsa   # linux中生成密钥的指令
```

`windows`中生成密钥：可以在`Xshell`中也可以达到类似效果,这种方式生成了密钥之后,可以将之保存起来.
当然也可以通过其他方式例如`git bash`中用`linux`指令生成,在这里不详细描述了.

那么我们怎么使用这个生成好的`ssh key`呢.
在`Xshell`中,我们之前连接服务器,在用户认证窗口使用的是`password`密码的方式去连接,现在我们切换成`Public Key`的方式

实际上,在这个时候连接还少了很重要的一步,会出现"所选的用户密钥未在远程主机上注册.请再试一次"的错误提示.
为了达到免密码的登录过程,我们需要将公钥放置在`authorized_keys`这个文件中.

我们需要先进入linux服务器,将我们选择的这个 `id_rsa_2048.pub` 的内容放置到linux服务器的`authorized_keys`文件中.
这样的话我们再访问就可以无密码连接了.

***
在linux连接别的linux的服务器的时候怎么做到免密呢？

首先先将本机的 `rsa.pub`公钥追加到目标服务器的 `authorized_keys` 中.
然后执行以下命令

```bash
ssh-agent bash   # ssh-agent is a program to hold private keys used for public key authentication (RSA, DSA, ECDSA, Ed25519).
ssh-add  ~/.ssh/'私钥文件 ' # ssh-add adds private key identities to the authentication agent
```

完成了这个之后,就可以直接用 `ssh root@192.168.0.106`  直接连接服务器而不需要输入密码了

### ssh 安全端口

端口安全指的是尽量避免服务器的远程连接端口被不法份子知道,为此而改变默认的服务端口号的操作.

在上一节中我们知道了`SSH`的默认端口是`22`.可以修改默认端口.
对应需要修改的文件是 `/etc/ssh/sshd_config`. 我们也可以同时监听多个端口.

## 第十八章:查找文件

因为我们已经浏览了 Linux 系统,所以一件事已经变得非常清楚:一个典型的 Linux 系统包含很多文件! 
这就引发了一个问题,“我们怎样查找东西?”。

虽然我们已经知道 Linux 文件系统良好的组织结构,是源自 类 Unix的操作系统代代传承的习俗。
但是仅文件数量就会引起可怕的问题。

在这一章中,我们将察看 两个用来在系统中查找文件的工具。这些工具是:

+ `locate` – 通过名字来查找文件
+ `find` – 在目录层次结构中搜索文件

我们也将看一个经常与文件搜索命令一起使用的命令,它用来处理搜索到的文件列表:

+ `xargs` – 从标准输入生成和执行命令行

另外,我们将介绍两个命令来协助我们探索:

+ `touch` – 更改文件时间
+ `stat` – 显示文件或文件系统状态

### locate - 查找文件的简单方法

这个 `locate` 程序快速搜索路径名数据库,并且输出每个与给定字符串相匹配的文件名。比如说, 例如,我们想
要找到所有名字以“zip”开头的程序。因为我们正在查找程序,可以假定包含 匹配程序的目录以”bin/”结
尾。因此,我们试着以这种方式使用 locate 命令,来找到我们的文件:

[me@linuxbox ~]$ locate bin/zip

locate 命令将会搜索它的路径名数据库,输出任一个包含字符串“bin/zip”的路径名:
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit
如果搜索要求没有这么简单,locate 可以结合其它工具,比如说 grep 命令,来设计更加 有趣的搜索:
[me@linuxbox ~]$ locate zip | grep bin
/bin/bunzip2
/bin/bzip2
/bin/bzip2recover
/bin/gunzip
/bin/gzip
/usr/bin/funzip
/usr/bin/gpg-zip
/usr/bin/preunzip
/usr/bin/prezip
/usr/bin/prezip-bin
/usr/bin/unzip
/usr/bin/unzipsfx
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit
这个 locate 程序已经存在了很多年了,它有几个不同的变体被普遍使用着。在现在 Linux 发行版中发现的两个
最常见的变体是 slocate 和 mlocate,但是通常它们被名为 locate 的 符号链接访问。不同版本的 locate 命令拥
有重复的选项集合。一些版本包括正则表达式 匹配(我们会在下一章中讨论)和通配符支持。查看 locate 命令
的手册,从而确定安装了 哪个版本的 locate 程序。
locate 数据库来自何方?
你可能注意到了,在一些发行版中,仅仅在系统安装之后,locate 不能工作, 但是如果你第二天再试一下,
它就工作正常了。怎么回事呢?locate 数据库由另一个叫做 updatedb 的程序创建。通常,这个程序作为一
个 cron 工作例程周期性运转;也就是说,一个任务 在特定的时间间隔内被 cron 守护进程执行。大多数装有
locate 的系统会每隔一天运行一回 updatedb 程序。因为数据库不能被持续地更新,所以当使用 locate 时,
你会发现 目前最新的文件不会出现。为了克服这个问题,可以手动运行 updatedb 程序, 更改为超级用户身
份,在提示符下运行 updatedb 命令。
find - 查找文件的复杂方式
locate 程序只能依据文件名来查找文件,而 find 程序能基于各种各样的属性, 搜索一个给定目录(以及它的子
目录),来查找文件。我们将要花费大量的时间学习 find 命令,因为 它有许多有趣的特性,当我们开始在随后
的章节里面讨论编程概念的时候,我们将会重复看到这些特性。
find 命令的最简单使用是,搜索一个或多个目录。例如,输出我们的家目录列表。
[me@linuxbox ~]$ find ~
对于最活跃的用户帐号,这将产生一张很大的列表。因为这张列表被发送到标准输出, 我们可以把这个列表管道
本文档使用 看云 构建
- 160 -第十八章:查找文件
到其它的程序中。让我们使用 wc 程序来计算出文件的数量:
[me@linuxbox ~]$ find ~ | wc -l
47068
哇,我们一直很忙!find 命令的美丽所在就是它能够被用来识别符合特定标准的文件。它通过 (有点奇怪)应用
选项,测试条件,和操作来完成搜索。我们先看一下测试条件。
Tests
比如说我们想要目录列表。我们可以添加以下测试条件:
[me@linuxbox ~]$ find ~ -type d | wc -l
1695
添加测试条件-type d 限制了只搜索目录。相反地,我们使用这个测试条件来限定搜索普通文件:
[me@linuxbox ~]$ find ~ -type f | wc -l
38737
这里是 find 命令支持的普通文件类型测试条件:
表18-1: find 文件类型
文件类型 描述
b 块设备文件
c 字符设备文件
d 目录
f 普通文件
l 符号链接
我们也可以通过加入一些额外的测试条件,根据文件大小和文件名来搜索:让我们查找所有文件名匹配 通配符模
式“*.JPG”和文件大小大于1M 的文件:
[me@linuxbox ~]$ find ~ -type f -name "\*.JPG" -size +1M | wc -l
840
在这个例子里面,我们加入了 -name 测试条件,后面跟通配符模式。注意,我们把它用双引号引起来, 从而阻
止 shell 展开路径名。紧接着,我们加入 -size 测试条件,后跟字符串“+1M”。开头的加号表明 我们正在寻找
文件大小大于指定数的文件。若字符串以减号开头,则意味着查找小于指定数的文件。 若没有符号意味着“精确
本文档使用 看云 构建
- 161 -第十八章:查找文件
匹配这个数”。结尾字母“M”表明测量单位是兆字节。下面的字符可以 被用来指定测量单位:
表18-2: find 大小单位
字符 单位
b 512 个字节块。如果没有指定单位,则
这是默认值。
c 字节
w 两个字节的字
k 千字节(1024个字节单位)
M 兆字节(1048576个字节单位)
G 千兆字节(1073741824个字节单位)
find 命令支持大量不同的测试条件。下表是列出了一些常见的测试条件。请注意,在需要数值参数的 情况下,可
以应用以上讨论的“+”和”-“符号表示法:
表18-3: find 测试条件
测试条件 描述
-cmin n 匹配的文件和目录的内容或属性最后修
改时间正好在 n 分钟之前。 指定少于
n 分钟之前,使用 -n,指定多于 n 分
钟之前,使用 +n。
-cnewer file 匹配的文件和目录的内容或属性最后修
改时间早于那些文件。
-ctime n 匹配的文件和目录的内容和属性最后修
改时间在 n*24小时之前。
-empty 匹配空文件和目录。
-group name 匹配的文件和目录属于一个组。组可以
用组名或组 ID 来表示。
-iname pattern 就像-name 测试条件,但是不区分大
小写。
-inum n 匹配的文件的 inode 号是 n。这对于找
到某个特殊 inode 的所有硬链接很有
帮助。
-mmin n 匹配的文件或目录的内容被修改于 n 分
钟之前。
-mtime n 匹配的文件或目录的内容被修改于
n*24小时之前。
-name pattern
本文档使用 看云 构建
用指定的通配符模式匹配的文件和目
- 162 -第十八章:查找文件
-name pattern 录。
-newer file 匹配的文件和目录的内容早于指定的文
件。当编写 shell 脚本,做文件备份
时,非常有帮助。 每次你制作一个备
份,更新文件(比如说日志),然后使
用 find 命令来决定自从上次更新,哪
一个文件已经更改了。
-nouser 匹配的文件和目录不属于一个有效用
户。这可以用来查找 属于删除帐户的文
件或监测攻击行为。
-nogroup 匹配的文件和目录不属于一个有效的
组。
-perm mode 匹配的文件和目录的权限已经设置为指
定的 mode。mode 可以用 八进制或
符号表示法。
-samefile name 相似于-inum 测试条件。匹配和文件
name 享有同样 inode 号的文件。
-size n 匹配的文件大小为 n。
-type c 匹配的文件类型是 c。
-user name 匹配的文件或目录属于某个用户。这个
用户可以通过用户名或用户 ID 来表
示。
这不是一个完整的列表。find 命令手册有更详细的说明。
操作符
即使拥有了 find 命令提供的所有测试条件,我们还需要一个更好的方式来描述测试条件之间的逻辑关系。例如,
如果我们需要确定是否一个目录中的所有的文件和子目录拥有安全权限,怎么办呢? 我们可以查找权限不是
0600的文件和权限不是0700的目录。幸运地是,find 命令提供了 一种方法来结合测试条件,通过使用逻辑操作
符来创建更复杂的逻辑关系。 为了表达上述的测试条件,我们可以这样做:
[me@linuxbox ~]$ find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm
0700 \)
呀!这的确看起来很奇怪。这些是什么东西?实际上,这些操作符没有那么复杂,一旦你知道了它们的原理。 这
里是操作符列表:
表18-4: find 命令的逻辑操作符
本文档使用 看云 构建
- 163 -第十八章:查找文件
-and 如果操作符两边的测试条件都是真,则
匹配。可以简写为 -a。 注意若没有使
用操作符,则默认使用 -and。
-or 若操作符两边的任一个测试条件为真,
则匹配。可以简写为 -o。
-not 若操作符后面的测试条件是真,则匹
配。可以简写为一个感叹号(!)。
() 把测试条件和操作符组合起来形成更大
的表达式。这用来控制逻辑计算的优先
级。 默认情况下,find 命令按照从左
到右的顺序计算。经常有必要重写默认
的求值顺序,以得到期望的结果。 即使
没有必要,有时候包括组合起来的字
符,对提高命令的可读性是很有帮助
的。注意 因为圆括号字符对于 shell 来
说有特殊含义,所以在命令行中使用它
们的时候,它们必须 用引号引起来,才
能作为实参传递给 find 命令。通常反
斜杠字符被用来转义圆括号字符。
通过这张操作符列表,我们重建 find 命令。从最外层看,我们看到测试条件被分为两组,由一个 -or 操作符分
开:
( expression 1 ) -or ( expression 2 )
这很有意义,因为我们正在搜索具有不同权限集合的文件和目录。如果我们文件和目录两者都查找, 那为什么要
用 -or 来代替 -and 呢?因为 find 命令扫描文件和目录时,会计算每一个对象,看看它是否 匹配指定的测试条
件。我们想要知道它是具有错误权限的文件还是有错误权限的目录。它不可能同时符合这 两个条件。所以如果展
开组合起来的表达式,我们能这样解释它:
( file with bad perms ) -or ( directory with bad perms )
下一个挑战是怎样来检查“错误权限”,这个怎样做呢?我们不从这个角度做。我们将测试 “不是正确权限”,
因为我们知道什么是“正确权限”。对于文件,我们定义正确权限为0600, 目录则为0711。测试具有“不正
确”权限的文件表达式为:
-type f -and -not -perms 0600
对于目录,表达式为:
本文档使用 看云 构建
- 164 -第十八章:查找文件
对于目录,表达式为:
-type d -and -not -perms 0700
正如上述操作符列表中提到的,这个-and 操作符能够被安全地删除,因为它是默认使用的操作符。 所以如果我
们把这两个表达式连起来,就得到最终的命令:
find ~ ( -type f -not -perms 0600 ) -or ( -type d -not -perms 0700 )
然而,因为圆括号对于 shell 有特殊含义,我们必须转义它们,来阻止 shell 解释它们。在圆括号字符 之前加上
一个反斜杠字符来转义它们。
逻辑操作符的另一个特性要重点理解。比方说我们有两个由逻辑操作符分开的表达式:
expr1 -operator expr2
在所有情况下,总会执行表达式 expr1;然而由操作符来决定是否执行表达式 expr2。这里 列出了它是怎样工作
的:
表18-5: find AND/OR 逻辑
expr1 的结果 操作符 expr2 is...
真 -and 总要执行
假 -and 从不执行
真 -or 从不执行
假 -or 总要执行
为什么这会发生呢?这样做是为了提高性能。以 -and 为例,我们知道表达式 expr1 -and expr2 不能为真,如
果表达式 expr1的结果为假,所以没有必要执行 expr2。同样地,如果我们有表达式 expr1 -or expr2,并且表
达式 expr1的结果为真,那么就没有必要执行 expr2,因为我们已经知道 表达式 expr1 -or expr2 为真。好,这
样会执行快一些。为什么这个很重要? 它很重要是因为我们能依靠这种行为来控制怎样来执行操作。我们会很快
看到...
预定义的操作
让我们做一些工作吧!从 find 命令得到的结果列表很有用处,但是我们真正想要做的事情是操作列表 中的某些
条目。幸运地是,find 命令允许基于搜索结果来执行操作。有许多预定义的操作和几种方式来 应用用户定义的操
作。首先,让我们看一下几个预定义的操作:
表18-6: 几个预定义的 find 命令操作
本文档使用 看云 构建
- 165 -第十八章:查找文件
-delete 删除当前匹配的文件。
-ls 对匹配的文件执行等同的 ls -dils 命
令。并将结果发送到标准输出。
-print 把匹配文件的全路径名输送到标准输
出。如果没有指定其它操作,这是 默认
操作。
-quit 一旦找到一个匹配,退出。
和测试条件一样,还有更多的操作。查看 find 命令手册得到更多细节。在第一个例子里, 我们这样做:
find ~
这个命令输出了我们家目录中包含的每个文件和子目录。它会输出一个列表,因为会默认使用-print 操作 ,如果
没有指定其它操作的话。因此我们的命令也可以这样表述:
find ~ -print
我们可以使用 find 命令来删除符合一定条件的文件。例如,来删除扩展名为“.BAK”(这通常用来指定备份文
件) 的文件,我们可以使用这个命令:
find ~ -type f -name '*.BAK' -delete
在这个例子里面,用户家目录(和它的子目录)下搜索每个以.BAK 结尾的文件名。当找到后,就删除它们。
警告:当使用 -delete 操作时,不用说,你应该格外小心。首先测试一下命令, 用 -print 操作代替 -delete,来
确认搜索结果。
在我们继续之前,让我们看一下逻辑运算符是怎样影响操作的。考虑以下命令:
find ~ -type f -name '*.BAK' -print
正如我们所见到的,这个命令会查找每个文件名以.BAK (-name ‘*.BAK’) 结尾的普通文件 (-type f), 并把每
个匹配文件的相对路径名输出到标准输出 (-print)。然而,此命令按这个方式执行的原因,是 由每个测试和操作
之间的逻辑关系决定的。记住,在每个测试和操作之间会默认应用 -and 逻辑运算符。 我们也可以这样表达这个
命令,使逻辑关系更容易看出:
find ~ -type f -and -name '*.BAK' -and -print
本文档使用 看云 构建
- 166 -第十八章:查找文件
当命令被充分表达之后,让我们看看逻辑运算符是如何影响其执行的:
测试/行为 只有...的时候,才被执行
-print 只有 -type f and -name '*.BAK'为真
的时候
-name ‘*.BAK’ 只有 -type f 为真的时候
-type f 总是被执行,因为它是与 -and 关系中
的第一个测试/行为。
因为测试和行为之间的逻辑关系决定了哪一个会被执行,我们知道测试和行为的顺序很重要。例如, 如果我们重
新安排测试和行为之间的顺序,让 -print 行为是第一个,那么这个命令执行起来会截然不同:
find ~ -print -and -type f -and -name '*.BAK'
这个版本的命令会打印出每个文件(-print 行为总是为真),然后测试文件类型和指定的文件扩展名。
用户定义的行为
除了预定义的行为之外,我们也可以唤醒随意的命令。传统方式是通过 -exec 行为。这个 行为像这样工作:
-exec command {} ;
这里的 command 就是指一个命令的名字,{}是当前路径名的符号表示,分号是要求的界定符 表明命令结束。这
里是一个使用 -exec 行为的例子,其作用如之前讨论的 -delete 行为:
-exec rm '{}' ';'
重述一遍,因为花括号和分号对于 shell 有特殊含义,所以它们必须被引起来或被转义。
也有可能交互式地执行一个用户定义的行为。通过使用 -ok 行为来代替 -exec,在执行每个指定的命令之前, 会
提示用户:
find ~ -type f -name 'foo*' -ok ls -l '{}' ';'
< ls ... /home/me/bin/foo > ? y
-rwxr-xr-x 1 me
me 224 2007-10-29 18:44 /home/me/bin/foo
< ls ... /home/me/foo.txt > ? y
-rw-r--r-- 1 me
me 0 2008-09-19 12:53 /home/me/foo.txt
在这个例子里面,我们搜索以字符串“foo”开头的文件名,并且对每个匹配的文件执行 ls -l 命令。 使用 -ok 行
为,会在 ls 命令执行之前提示用户。
本文档使用 看云 构建
- 167 -第十八章:查找文件
提高效率
当 -exec 行为被使用的时候,若每次找到一个匹配的文件,它会启动一个新的指定命令的实例。 我们可能更愿意
把所有的搜索结果结合起来,再运行一个命令的实例。例如,而不是像这样执行命令:
ls -l file1
ls -l file2
我们更喜欢这样执行命令:
ls -l file1 file2
这样就导致命令只被执行一次而不是多次。有两种方法可以这样做。传统方式是使用外部命令 xargs,另一种方
法是,使用 find 命令自己的一个新功能。我们先讨论第二种方法。
通过把末尾的分号改为加号,就激活了 find 命令的一个功能,把搜索结果结合为一个参数列表, 然后执行一次
所期望的命令。再看一下之前的例子,这个:
find ~ -type f -name 'foo*' -exec ls -l '{}' ';'
-rwxr-xr-x 1 me
me 224 2007-10-29 18:44 /home/me/bin/foo
-rw-r--r-- 1 me
me 0 2008-09-19 12:53 /home/me/foo.txt
会执行 ls 命令,每次找到一个匹配的文件。把命令改为:
find ~ -type f -name 'foo*' -exec ls -l '{}' +
-rwxr-xr-x 1 me
me 224 2007-10-29 18:44 /home/me/bin/foo
-rw-r--r-- 1 me
me 0 2008-09-19 12:53 /home/me/foo.txt
虽然我们得到一样的结果,但是系统只需要执行一次 ls 命令。
xargs
这个 xargs 命令会执行一个有趣的函数。它从标准输入接受输入,并把输入转换为一个特定命令的 参数列表。对
于我们的例子,我们可以这样使用它:
find ~ -type f -name 'foo\*' -print | xargs ls -l
-rwxr-xr-x 1 me
me 224 2007-10-29 18:44 /home/me/bin/foo
-rw-r--r-- 1 me
me 0 2008-09-19 12:53 /home/me/foo.txt
这里我们看到 find 命令的输出被管道到 xargs 命令,反过来,xargs 会为 ls 命令构建 参数列表,然后执行 ls 命
令。
本文档使用 看云 构建
- 168 -第十八章:查找文件
注意:当被放置到命令行中的参数个数相当大时,参数个数是有限制的。有可能创建的命令 太长以至于 shell 不
能接受。当命令行超过系统支持的最大长度时,xargs 会执行带有最大 参数个数的指定命令,然后重复这个过程
直到耗尽标准输入。执行带有 –show–limits 选项 的 xargs 命令,来查看命令行的最大值。
处理古怪的文件名
类 Unix 的系统允许在文件名中嵌入空格(甚至换行符)。这就给一些程序,如为其它 程序构建参数列表的
xargs 程序,造成了问题。一个嵌入的空格会被看作是一个界定符,生成的 命令会把每个空格分离的单词解
释为单独的参数。为了解决这个问题,find 命令和 xarg 程序 允许可选择的使用一个 null 字符作为参数分隔
符。一个 null 字符被定义在 ASCII 码中,由数字 零来表示(相反的,例如,空格字符在 ASCII 码中由数字
32表示)。find 命令提供的 -print0 行为, 则会产生由 null 字符分离的输出,并且 xargs 命令有一个 –null
选项,这个选项会接受由 null 字符 分离的输入。这里有一个例子:
find ~ -iname ‘*.jpg’ -print0 | xargs –null ls -l
使用这项技术,我们可以保证所有文件,甚至那些文件名中包含空格的文件,都能被正确地处理。
返回操练场
到实际使用 find 命令的时候了。我们将会创建一个操练场,来实践一些我们所学到的知识。
首先,让我们创建一个包含许多子目录和文件的操练场:
[me@linuxbox ~]$ mkdir -p playground/dir-{00{1..9},0{10..99},100}
[me@linuxbox ~]$ touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}
惊叹于命令行的强大功能!只用这两行,我们就创建了一个包含一百个子目录,每个子目录中 包含了26个空文件
的操练场。试试用 GUI 来创建它!
我们用来创造这个奇迹的方法中包含一个熟悉的命令(mkdir),一个奇异的 shell 扩展(大括号) 和一个新命
令,touch。通过结合 mkdir 命令和-p 选项(导致 mkdir 命令创建指定路径的父目录),以及 大括号展开,我
们能够创建一百个目录。
这个 touch 命令通常被用来设置或更新文件的访问,更改,和修改时间。然而,如果一个文件名参数是一个 不
存在的文件,则会创建一个空文件。
在我们的操练场中,我们创建了一百个名为 file-A 的文件实例。让我们找到它们:
[me@linuxbox ~]$ find playground -type f -name 'file-A'
注意不同于 ls 命令,find 命令的输出结果是无序的。其顺序由存储设备的布局决定。为了确定实际上 我们拥有
一百个此文件的实例,我们可以用这种方式来确认:
[me@linuxbox ~]$ find playground -type f -name 'file-A' | wc -l
本文档使用 看云 构建
- 169 -第十八章:查找文件
下一步,让我们看一下基于文件的修改时间来查找文件。当创建备份文件或者以年代顺序来 组织文件的时候,这
会很有帮助。为此,首先我们将创建一个参考文件,我们将与其比较修改时间:
[me@linuxbox ~]$ touch playground/timestamp
这个创建了一个空文件,名为 timestamp,并且把它的修改时间设置为当前时间。我们能够验证 它通过使用另
一个方便的命令,stat,是一款加大马力的 ls 命令版本。这个 stat 命令会展示系统对 某个文件及其属性所知道
的所有信息:
[me@linuxbox ~]$ stat playground/timestamp
File: 'playground/timestamp'
Size: 0 Blocks: 0 IO Block: 4096 regular empty file
Device: 803h/2051d Inode: 14265061 Links: 1
Access: (0644/-rw-r--r--) Uid: ( 1001/ me) Gid: ( 1001/ me)
Access: 2008-10-08 15:15:39.000000000 -0400
Modify: 2008-10-08 15:15:39.000000000 -0400
Change: 2008-10-08 15:15:39.000000000 -0400
如果我们再次 touch 这个文件,然后用 stat 命令检测它,我们会发现所有文件的时间已经更新了。
[me@linuxbox ~]$ touch playground/timestamp
[me@linuxbox ~]$ stat playground/timestamp
File: 'playground/timestamp'
Size: 0 Blocks: 0 IO Block: 4096 regular empty file
Device: 803h/2051d Inode: 14265061 Links: 1
Access: (0644/-rw-r--r--) Uid: ( 1001/ me) Gid: ( 1001/ me)
Access: 2008-10-08 15:23:33.000000000 -0400
Modify: 2008-10-08 15:23:33.000000000 -0400
Change: 2008-10-08 15:23:33.000000000 -0400
下一步,让我们使用 find 命令来更新一些操练场中的文件:
[me@linuxbox ~]$ find playground -type f -name 'file-B' -exec touch '{}' ';'
这会更新操练场中所有名为 file-B 的文件。接下来我们会使用 find 命令来识别已更新的文件, 通过把所有文件
与参考文件 timestamp 做比较:
[me@linuxbox ~]$ find playground -type f -newer playground/timestamp
搜索结果包含所有一百个文件 file-B 的实例。因为我们在更新了文件 timestamp 之后, touch 了操练场中名为
本文档使用 看云 构建
- 170 -第十八章:查找文件
file-B 的所有文件,所以现在它们“新于”timestamp 文件,因此能被用 -newer 测试条件识别出来。
最后,让我们回到之前那个错误权限的例子中,把它应用于操练场里:
[me@linuxbox ~]$ find playground \( -type f -not -perm 0600 \) -or \( -type d -
not -perm 0700 \)
这个命令列出了操练场中所有一百个目录和二百六十个文件(还有 timestamp 和操练场本身,共 2702 个) ,
因为没有一个符合我们“正确权限”的定义。通过对运算符和行为知识的了解,我们可以给这个命令 添加行为,
对实战场中的文件和目录应用新的权限。
[me@linuxbox ~]$ find playground \( -type f -not -perm 0600 -exec chmod 0600 '{
}' ';' \)
-or \( -type d -not -perm 0711 -exec chmod 0700 '{}' ';' \)
在日常的基础上,我们可能发现运行两个命令会比较容易一些,一个操作目录,另一个操作文件, 而不是这一个
长长的复合命令,但是很高兴知道,我们能这样执行命令。这里最重要的一点是要 理解怎样把操作符和行为结合
起来使用,来执行有用的任务。
选项
最后,我们有这些选项。这些选项被用来控制 find 命令的搜索范围。当构建 find 表达式的时候, 它们可能被其
它的测试条件和行为包含:
表 18-7: find 命令选项
选项 描述
-depth 指导 find 程序先处理目录中的文件,
再处理目录自身。当指定-delete 行为
时,会自动 应用这个选项。
-maxdepth levels 当执行测试条件和行为的时候,设置
find 程序陷入目录树的最大级别数
-mindepth levels 在应用测试条件和行为之前,设置 find
程序陷入目录数的最小级别数。
-mount 指导 find 程序不要搜索挂载到其它文
件系统上的目录。
-noleaf 指导 find 程序不要基于搜索类 Unix 的
文件系统做出的假设,来优化它的搜
索。
拓展阅读
本文档使用 看云 构建
- 171 -第十八章:查找文件
程序 locate,updatedb,find 和 xargs 都是 GNU 项目 findutils 软件包的一部分。 这个 GUN 项目提供了
大量的在线文档,这些文档相当出色,如果你在高安全性的 环境中使用这些程序,你应该读读这些文档。
http://www.gnu.org/software/findutils/