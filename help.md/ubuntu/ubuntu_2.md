# ubuntu-2.md

## Ubuntu 镜像使用帮助

清华大学的源

域名选择

```bash
https://mirrors.tuna.tsinghua.edu.cn 自动选择
https://mirrors6.tuna.tsinghua.edu.cn 只解析 IPv6
https://mirrors4.tuna.tsinghua.edu.cn 只解析 IPv4
```

Ubuntu 的软件源配置文件是 `/etc/apt/sources.list`.将系统自带的该文件做个备份,将该文件替换为下面内容,即可使用 `TUNA` 的软件源镜像.

```bash
# 默认注释了源码镜像以提高 apt update 速度,如有需要可自行取消注释
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源,不建议启用
# deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
```

## dpkg-buildpackage

`dget` -- Download Debian source and binary packages

SYNOPSIS

```
dget [options] URL ...
dget [options] [--all] package[=version] ...
```

DESCRIPTION

dget downloads Debian packages.

In the first form, dget fetches the requested `URLs`.  If this is a `.dsc` or `.changes` file,
then dget acts as a source-package aware form of wget: it also fetches any files referenced in the `.dsc/.changes` file.
The downloaded source is then checked with `dscverify` and, if successful, unpacked by `dpkg-source`.

6.1. 完整的(重)构建

为保证完整的软件包(重)构建能顺利进行,你必须保证系统中已经安装

    build-essential 软件包；

    列于 Build-Depends 域的软件包(参看 第 4.1 节 `control`)；

    列于 Build-Depends-indep 域的软件包(参看 第 4.1 节 `control`).

然后在源代码目录中执行以下命令:

$ dpkg-buildpackage -us -uc

这样会自动完成所有从源代码包构建二进制包的工作,包括:

    清理源代码树(debian/rules clean)

    构建源代码包(dpkg-source -b)

    构建程序(debian/rules build)

    构建二进制包(fakeroot debian/rules binary)

    制作 .dsc 文件

    用 dpkg-genchanges 命令制作 .changes 文件.

如果构建结果令人满意,那就用 debsign 命令以你的私有 GPG 密钥签署 .dsc 文件和 .changes 文件.你需要输入密码两次. [63]

对于非本土 Debian 软件包,比如 gentoo, 构建软件包之后,你将会在上一级目录(~/gentoo) 中看到下列文件:

    gentoo_0.9.12.orig.tar.gz

    这是原始的源代码 tarball,最初由 dh_make -f ../gentoo-0.9.12.tar.gz 命令创建,它的内容与上游 tarball 相同,仅被重命名以符合 Debian 的标准.

    gentoo_0.9.12-1.dsc

    这是一个从 control 文件生成的源代码概要,可被 dpkg-source(1) 程序解包.

    gentoo_0.9.12-1.debian.tar.gz

    这个压缩的 Tar 归档包含你的 debian 目录内容.其他所有对于源代码的修改都由 quilt 补丁存储于 debian/patches 中.

    如果其他人想要重新构建你的软件包,他们可以使用以上三个文件很容易地完成.只需复制三个文件,再运行 dpkg-source -x gentoo_0.9.12-1.dsc. [64]

    gentoo_0.9.12-1_i386.deb

    这是你的二进制包,可以使用 dpkg 程序安装或卸载它,就像其他软件包一样.

    gentoo_0.9.12-1_i386.changes

    这个文件描述了当前修订版本软件包中的全部变更,它被 Debian FTP 仓库维护程序用于安装二进制和源代码包.它是部分从 changelog 和 .dsc 文件生成的.

    随着你不断完善这个软件包,程序的行为会发生变化,也会有更多新特性添加进来.下载你软件包的人可以查看这个文件来快速找到有哪些变化,Debian 仓库维护程序还会把它的内容发表至 debian-devel-changes@lists.debian.org 邮件列表.

在上传到 Debian FTP 仓库中前,gentoo_0.9.12-1.dsc 文件和 gentoo_0.9.12-1_i386.changes 文件必须用 debsign 命令签署,其中使用你自己存放在 ~/.gnupg/ 目录中的 GPG 私钥. 用你的公钥,可以令 GPG 签名证明这些文件真的是你的.

debsign 命令可以用来以指定 ID 的 GPG 密钥进行签署 （这方便了赞助(sponsor)软件包）, 只要照着下边在 ~/.devscripts 中的内容:

DEBSIGN_KEYID=Your_GPG_keyID

.dsc 和 .changes 文件中很长的数字串是其中提及文件的 SHA1/SHA256 校验和.下载你软件包的人可以使用 sha1sum(1) 或 sha256sum(1) 来进行核对.如果校验和不符,则说明文件已被损坏或偷换

### Hostname

[What Is a Hostname? ][]

[What Is a Hostname? ]: https://www.lifewire.com/what-is-a-hostname-2625906

域名（英语:`Domain Name`）,又称网域,是由一串用点分隔的名字组成的`Internet`上某一台计算机或计算机组的名称,
用于在数据传输时对计算机的定位标识（有时也指地理位置）

由于`IP`地址具有不方便记忆并且不能显示地址组织的名称和性质等缺点,人们设计出了域名,
并通过网域名称系统（`DNS`,`Domain Name System`）来将域名和`IP`地址相互映射,使人更方便地访问互联网,
而不用去记住能够被机器直接读取的`IP`地址数串

A `hostname` is a label assigned to a `device` (a host) on a `network`.

It distinguishes one device from another on a specific network or over the internet.
The hostname for a computer on a home network may be something like `new laptop`, `Guest-Desktop`, or `FamilyPC`.

Hostnames are also used by `DNS` servers so you can access a website by a common, easy-to-remember name. This way, you don't have to remember a string of numbers (an `IP address`) to open a website.

A computer's hostname may instead be referred to as a computer name, sitename, or nodename.
You may also see hostname `spelled` as host name.

### Examples of a Hostname

Each of the following is an example of a Fully Qualified Domain Name with its hostname written off to the side:

+ `www.google.com: www`
+ `images.google.com: images`
+ `products.office.com: products`
+ `www.microsoft.com: www`

The hostname (like `products`) is the text that *precedes* the `domain` name (for example, office), which is the text that comes before the *top-level domain* (`.com`).

### How to Find a Hostname in Windows

Executing `hostname` from the Command Prompt is the easiest way to show the hostname of a computer.

## 用 Linux 命令显示硬件信息 

[用 Linux 命令显示硬件信息 ](https://linux.cn/article-11422-1.html)

最简单的方法是使用标准的 Linux GUI 程序之一:

+ `i-nex` 收集硬件信息，并且类似于 Windows 下流行的 `CPU-Z` 的显示。
+ `HardInfo` 显示硬件具体信息，甚至包括一组八个的流行的性能基准程序，你可以用它们评估你的系统性能。
+ `KInfoCenter` 和 `Lshw` 也能够显示硬件的详细信息，并且可以从许多软件仓库中获取。

### 硬件概述

`inxi` 命令能够列出包括 CPU、图形、音频、网络、驱动、分区、传感器等详细信息。
当论坛里的人尝试帮助其他人解决问题的时候，他们常常询问此命令的输出。

```bash
inxi -Fxz
```

`-F` 参数意味着你将得到完整的输出，`x` 增加细节信息，`z` 参数隐藏像 `MAC` 和 `IP` 等私人身份信息。

`hwinfo` 和 `lshw` 命令以不同的格式显示大量相同的信息：

`hwinfo --short` 或 `lshw -short`

这两条命令的长格式输出非常详细，但也有点难以阅读：

`hwinfo` 或`lshw`

### CPU 详细信息

通过命令你可以了解关于你的 CPU 的任何信息。使用 `lscpu` 命令或与它相近的 `lshw` 命令查看 `CPU` 的详细信息：

`lscpu`  或 `lshw -C cpu`

在这两个例子中，输出的最后几行都列出了所有 `CPU` 的功能。你可以查看你的处理器是否支持特定的功能。

使用这些命令的时候，你可以使用 `grep` 过滤信息。例如，只查看 CPU 品牌和型号:

```bash
lshw -C cpu | grep -i product
```

仅查看 `CPU` 的速度（兆赫兹）:

```bash
lscpu | grep -i mhz
```

或其 `BogoMips` 额定功率:

```bash
lscpu | grep -i bogo
```

`grep` 命令的 `-i`参数代表搜索结果忽略大小写。

### 内存

`Linux` 命令行使你能够收集关于你的计算机内存的所有可能的详细信息。
你甚至可以不拆开计算机机箱就能确定是否可以为计算机添加额外的内存条。

使用 `dmidecode` 命令列出每根内存条和其容量：

```bash
dmidecode -t memory | grep -i size
```

使用以下命令获取系统内存更多的信息，包括类型、容量、速度和电压：

```bash
lshw -short -C memory
```

你肯定想知道的一件事是你的计算机可以安装的最大内存：

```bash
dmidecode -t memory | grep -i max
```

现在检查一下计算机是否有空闲的插槽可以插入额外的内存条。你可以通过使用命令在不打开计算机机箱的情况下就做到：

```bash
lshw -short -C memory | grep -i empty
```

输出为空则意味着所有的插槽都在使用中。

### 显卡

确定你的计算机拥有多少显卡内存需要下面的命令。首先使用 `lspci` 列出所有设备信息然后过滤出你想要的显卡设备信息:

```bash
lspci | grep -i vga
```

视频控制器的设备号输出信息通常如下：

```bash
00:02.0 VGA compatible controller: Intel Corporation 82Q35 Express Integrated Graphics Controller (rev 02)
```

现在再加上视频设备号重新运行 `lspci` 命令：

```bash
lspci -v -s 00:02.0
```

输出信息中 `prefetchable` 那一行显示了系统中的显卡内存大小:

最后使用下面的命令展示当前内存使用量（兆字节）：

```bash
free -m
```

这条命令告诉你多少内存是空闲的，多少命令正在使用中以及交换内存的大小和是否正在使用。例如，输出信息如下：
`top` 命令为你提供内存使用更加详细的信息。
它显示了当前全部内存和 CPU 使用情况并按照进程 ID、用户 ID 及正在运行的命令细分。同时这条命令也是全屏输出:

```bash
top
```

使用`xrandr` 可以设置屏幕输出的大小，方向或反射。 它还可以设置屏幕尺寸.

Dell optiplex 7060 AMD Radeon R5 430
Intel HD 530

### 磁盘文件系统和设备

你可以轻松确定有关磁盘、分区、文件系统和其他设备信息。

显示每个磁盘设备的描述信息：

```bash
lshw -short -C disk
```

通过以下命令获取任何指定的 `SATA` 磁盘详细信息，例如其型号、序列号以及支持的模式和扇区数量等：

```bash
hdparm -i /dev/sda
```

当然，如果需要的话你应该将 `sda` 替换成 `sdb` 或者其他设备号。

列出所有磁盘及其分区和大小：

```bash
lsblk
```

使用以下命令获取更多有关扇区数量、大小、文件系统 ID 和 类型以及分区开始和结束扇区：

```bash
fdisk -l
```

要启动 Linux，你需要确定 `GRUB` 引导程序的可挂载分区。你可以使用 `blkid` 命令找到此信息。它列出了每个分区的唯一标识符（UUID）及其文件系统类型（例如 ext3 或 ext4）：

```bash
blkid
```

使用以下命令列出已挂载的文件系统和它们的挂载点，以及已用的空间和可用的空间（兆字节为单位）：

```bash
df -m
```

最后，你可以列出所有的 USB 和 PCI 总线以及其他设备的详细信息：

```bash
lsusb
```

或

```bash
lspci
```

### 网络

Linux 提供大量的网络相关命令，下面只是几个例子。

查看你的网卡硬件详细信息:

```bash
lshw -C network
```

`ifconfig` 是显示网络接口的传统命令：

```bash
ifconfig -a
```

但是现在很多人们使用：

```bash
ip link show
```

或

```bash
netstat -i
```

在阅读输出时，了解常见的网络缩写十分有用：

缩写    含义

+ `lo`    回环接口
+ `eth0` 或 `enp*`    以太网接口
+ `wlan0`    无线网接口
+ `ppp0`    点对点协议接口（由拨号调制解调器、PPTP VPN 连接或者 USB 调制解调器使用）
+ `vboxnet0` 或 `vmnet*`    虚拟机网络接口

表中的星号是通配符，代表不同系统的任意字符。

使用以下命令显示默认网关和路由表：

```bash
ip route | column -t
```

或

```bash
netstat -r
```

### 软件

让我们以显示最底层软件详细信息的两条命令来结束。
例如，如果你想知道是否安装了最新的固件该怎么办？这条命令显示了 `UEFI` 或 `BIOS` 的日期和版本:

```bash
dmidecode -t bios
```

内核版本是多少，以及它是 64 位的吗？网络主机名是什么？使用下面的命令查出结果：

```bash
uname -a
```

### 快速查询表

用途   命令

+ 显示所有硬件信息   `inxi -Fxz` 或 `hwinfo --short` 或 `lshw  -short`
+ `CPU` 信息   `lscpu` 或 `lshw -C cpu`
+ 显示 `CPU` 功能（例如 PAE、SSE2）  `lshw -C cpu | grep -i capabilities`
+ 报告 `CPU` 位数   `lshw -C cpu | grep -i width`
+ 显示当前内存大小和配置   `dmidecode -t memory | grep -i size` 或 `lshw -short -C memory`
+ 显示硬件支持的最大内存   `dmidecode -t memory | grep -i max`
+ 确定是否有空闲内存插槽   `lshw -short -C memory | grep -i empty`（输出为空表示没有可用插槽）
+ 确定显卡内存数量   `lspci | grep -i vga` 然后指定设备号再次使用；例如：`lspci -v -s 00:02.0` 
显卡内存数量就是  `prefetchable` 的值
+ 显示当前内存使用情况  `free -m` 或 `top`
+ 列出磁盘驱动器   `lshw -short -C disk`
+ 显示指定磁盘驱动器的详细信息   `hdparm -i /dev/sda`（需要的话替换掉 `sda` ）
+ 列出磁盘和分区信息   `lsblk`（简单） 或 `fdisk -l`（详细）
+ 列出分区 ID（UUID）   `blkid`
+ 列出已挂载文件系统挂载点以及已用和可用空间   d`f -m`
+ 列出 USB 设备   `lsusb`
+ 列出 PCI 设备   `lspci`
+ 显示网卡详细信息  ` lshw -C network`
+ 显示网络接口   `ifconfig -a` 或 `ip link show` 或 `netstat -i`
+ 显示路由表   `ip route | column -t` 或 `netstat -r`
+ 显示 UEFI/BIOS 信息   `dmidecode -t bios`
+ 显示内核版本网络主机名等   `uname -a`

[Linux下/proc目录简介][]

[Linux下/proc目录简介]: https://blog.csdn.net/zdwzzu2006/article/details/7747977

Linux 内核提供了一种通过 `/proc` 文件系统,在运行时访问内核内部数据结构、改变内核设置的机制.proc文件系统是一个伪文件系统,它只存在内存当中,而不占用外存空间.它以文件系统的方式为访问系统内核数据的操作提供接口.

用户和应用程序可以通过proc得到系统的信息,并可以改变内核的某些参数.
由于系统的信息,如进程,是动态改变的,所以用户或应用程序读取proc文件时,proc文件系统是动态从系统内核读出所需信息并提交的.
下面列出的这些文件或子文件夹,并不是都是在你的系统中存在,这取决于你的内核配置和装载的模块.
另外,在`/proc`下还有三个很重要的目录:`net`,`scsi`和`sys`. `Sys`目录是可写的,可以通过它来访问或修改内核的参数,而`net`和`scsi`则依赖于内核配置.例如,如果系统不支持`scsi`,则`scsi`目录不存在.

除了以上介绍的这些,还有的是一些以数字命名的目录,它们是进程目录.
系统中当前运行的每一个进程都有对应的一个目录在`/proc`下,以进程的 `PID`号为目录名,它们是读取进程信息的接口.
而`self`目录则是读取进程本身的信息接口,是一个`link`.

## Linux各目录含义

### FHS标准

其实,linux系统的目录都遵循一个标准,即由Linux基金会发布的 文件系统层次结构标准 (`Filesystem Hierarchy Standard`, FHS).
这个标准里面定义了linux系统该有哪些目录,各个目录应该存放什么,起什么作用等等.具体说明如下:

目录  含义

+ `/bin`  `binary`,即用来存放二进制可执行文件,并且比较特殊的是`/bin`里存放的是所有一般用户都能使用的可执行文件,如:`cat`, `chmod`, `chown`, `mv`, `mkdir`, `cd` 等常用指令
+ `/boot`  存放开机时用到的引导文件
+ `/dev`  device（并不是`develop`哦）,任何设备都以文件的形式存放在这个目录中
+ `/etc`  `Editable Text Configuration`（早期含义为`etcetera`,但是有争议）,存放系统配置文件,如各种服务的启动配置,账号密码等
+ `/home`  用户的主目录,每当新建一个用户系统都会在这个目录下创建以该用户名为名称的目录作为该用户的主目录.并且在命令行中~代表当前用户的主目录,~yousiku表示yousiku这个用户的主目录
+ `/lib`  library,存放着系统开机时所需的函数库以及/bin和/sbin目录下的命令会调用的函数库
+ `/lib64`  存放相对于/lib中支持64位格式的函数库
+ `/media`  可移除的媒体设备,如光盘,DVD等
+ `/mnt`  `mount`,临时挂载的设备文件
+ `/opt`  `optional`,可选的软件包,即第三方软件.我们可以将除了系统自带软件之外的其他软件安装到这个目录下
+ `/proc`  `process`,该目录是一个虚拟文件系统,即该目录的内容存放于内存中而不是硬盘中,存放着系统内核以及进程的运行状态信息
+ `/root`  超级管理员root的主目录
+ `/run`  最近一次开机后所产生的各项信息,如当前的用户和正在运行中的守护进程等
+ `/sbin`  存放一些只有root账户才有权限执行的可执行文件,如init, ip, mount等命令
+ `/srv`  service,存放一些服务启动后所需的数据
+ `/sys`  system,与/proc类似也是一个虚拟文件系统,存放系统核心与硬件相关的信息
+ `/tmp`  temporary,存放临时文件,可以被所有用户访问,系统重启时会清空该目录
+ `/usr`  Unix Software Resource（并不是指user哦）,存放着所有用户的绝大多数工具和应用程序（下文详细介绍）
+ `/var`  variable,存放动态文件,如系统日志,程序缓存等（下文详细介绍）

### /usr目录

`Unix Software Resource` 意为 `Unix`系统软件资源,系统自带的软件都装在这个目录下（好比Windows系统的"C:\Windows"）,用户安装的第三方软件也在这个目录下（好比Windows系统的"C:\Program Files"）,不同的是,在Windows系统上安装软件通常将该软件的所有文件放置在同一个目录下,但是在Linux系统安装软件会将该软件的不同文件分别放置在/usr目录下的不同子目录下,而不应该自行创建该软件自己的独立目录.进入到`/usr`目录,一般有以下子目录:

```python
[root@localhost /]# cd usr/
[root@localhost usr]# ls
bin  etc  games  include  lib  lib64  libexec  local  sbin  share  src  tmp
```

目录  含义

+ `/usr/bin`  即`/bin`,用链接文件到方式将`/bin`链接至此
+ `/usr/etc`  应用程序的配置文件
+ `/usr/games`  与游戏相关的数据
+ `/usr/include`  `c/c++`程序的头文件
+ `/usr/lib`  即`/lib`,用链接文件到方式将`/lib`链接至此
+ `/usr/lib64`  即`/lib64`,用链接文件到方式将`/lib64`链接至此
+ `/usr/libexec`  不常用的执行文件或脚本
+ `/usr/local`  应用程序的安装目录,每个应用程序目录下还会有对应的`bin`, `etc`, `lib`等目录
+ `/usr/sbin`  即`/sbin`,用链接文件到方式将`/sbin`链接至此
+ `/usr/share`  共享文件,通常是一些文字说明文件,如软件文档等
+ `/usr/src`  `source`,应用程序源代码
+ `/usr/tmp`  应用程序临时文件

[Linux各目录含义][]

[Linux各目录含义]: https://www.jianshu.com/p/142deb98ed5a

## 语言显示

### 输入法

重启输入法

`ibus restart`: Restart ibus-daemon.

### gedit默认编码设置为UTF-8编码

[ubuntu下gedit默认编码设置为UTF-8编码][]

[ubuntu下gedit默认编码设置为UTF-8编码]:  https://blog.csdn.net/miscclp/article/details/39154639

在终端下输入:

```bash
gsettings set org.gnome.gedit.preferences.encodings candidate-encodings "['UTF-8', 'GB18030', 'GB2312', 'GBK', 'BIG5', 'CURRENT', 'UTF-16']"
```

### 导入ibus词库

终端下输入`ibus-setup`--`Input Method`--`Chinese - intelligent pinyin`,
点击右侧的 `preference`--`user data`--`import`
把制作好的词库导入进去即可.

测试:
`亥姆霍兹方程`
`重整化群`

[iBus拼音输入法导入搜狗词库][]

[iBus拼音输入法导入搜狗词库]: https://blog.csdn.net/betabin/article/details/7798668

## shell 语法

### 空白字符

[对C标准中空白字符的理解](https://blog.csdn.net/boyinnju/article/details/6877087)
[Shell中去掉文件中的换行符简单方法](https://blog.csdn.net/Jerry_1126/java/article/details/85009615)

`C`标准库里`<ctype.h>`中声明了一个函数:

`int isspace(int c);`

该函数判断字符`c`是否为一个空白字符.

`C`标准中空白字符有六个:
空格（`' '`）、换页（`'\f'`）、换行（`'\n'`）、回车（`'\r'`）、水平制表符（`'\t'`）、垂直制表符（`'\v'`）

***
空格: ASCII码为`0x20`,而不是`0x00`.`0x00`代表空（`NULL`）

`0X00-0XFF` `16`进制一共`256`个,刚好是一个`bit`的范围.

***
回车（'\r'）效果是输出回到本行行首,结果可能会将这一行之前的输出覆盖掉,例如执行:

```bash
puts("hello world!\rxxx");
#在终端输出的是:
xxxlo world!
```

如果将上面的字符串写入文件中,例如执行:

```bash
char *s = "hello world!\rxxx";
FILE *str = fopen("t.txt","r");
fwrite(s, 16, 1, str);
```

用文本编辑器打开`t.txt`.显示的效果将由打开的编辑器所决定.
vi将`\r`用`^M`代替,而记事本就没有显示该字符.

***
换行（'\n'）
顾名思义,换行就是转到下一行输出.例如:

```bash
puts("hello\nworld!");
#在终端中将输出
hello
world!
```

但需要注意的是,终端输出要达到换行效果用``\n``就可以,但要在文本文件输出中达到换行效果在各个系统中有所区别.
在`*nix`系统中,每行的结尾是"`\n`",windows中则是"`\n\r`",mac则是"`\r`".

***
水平制表符（'\t'）

相信大家对'\t'还是比较熟悉的.一般来说,其在终端和文件中的输出显示相当于按下键盘`TAB`键效果.
一般系统中,显示水平制表符将占8列.同时水平制表符开始占据的初始位置是第`8*n`列（第一列的下标为0）.例如:

```bash
puts("0123456\txx");
puts("0123456t\txx");
```

***
垂直制表符（'\v'）

垂直制表符不常用.它的作用是让`'\v'`后面的字符从下一行开始输出,且开始的列数为``\v``前一个字符所在列后面一列.例如:

```bash
puts("01\v2345");
```

***
换页（'\f'）

换页符的在终端的中的效果相当于`*nix`中`clear`命令.
终端在输出`'\f'`之后内容之前,会将整个终端屏幕清空空,然后在输出内容.给人的该觉是在`clear`命令后的输出字符串.

最后我想说明一点,`\t \r, \v \f`也是控制字符,它们会控制字符的输出方式.
它们在终端输出时会有上面的表现,但如果写入文本文件,一般文本编辑器（vi或记事本）对`\t \r, \v \f`的显示是没有控制效果的.

### shell 换行

把换行符注释掉,如果同时想插入注释,可以用`$()`或者两个`backtick`包裹注释

```bash
emcc -o ./dist/test.html `# 目标文件` \
--shell-file ./tmp.html `# 模板文件` \
--source-map-base dist `# source map 根路径` \
-O3 `# 优化级别` \
```

### 删除换行符

文件中每行都以`\n`结尾,如果要去掉换行符,使用`sed`命令

```bash
[root@host ~]# sed -i 's/\n//g' FileName
```

或者使用`tr`命令: tr - translate or delete characters

```bash
[root@host ~]# cat fileName | tr  -d '\n'
```

有一种简单的方法:

`xargs` - build and execute command lines from standard input

 ```bash
cat FileName | xargs | echo -n   # 连文件末尾换行符也去掉
# 或者
cat FileName | xargs           # 会保留文件末尾的换行符
 ```

### eval

[Shell 中eval的用法][]

[Shell 中eval的用法]: https://blog.csdn.net/luliuliu1234/article/details/80994391

```bash
eval command-line
```

其中`command-line`是在终端上键入的一条普通命令行.
然而当在它前面放上`eval`时,其结果是`shell`在执行命令行之前扫描它两次.如:

```bash
$ pipe="|"
$ eval ls $pipe wc -l
1
2
3
```

shell第1次扫描命令行时,它替换出`pipe`的值`|`,接着`eval`使它再次扫描命令行,这时shell把`|`作为管道符号了.

如果变量中包含任何需要`shell`直接在命令行中看到的字符,就可以使用eval.
命令行结束符（`;  |  &`）,I/o重定向符（`< >`）和引号就属于对shell具有特殊意义的符号,必须直接出现在命令行中.

`eval echo \$$#`取得最后一个参数, 如:

```bash
$ cat last    #此处last是一个脚本文件,内容是下一行显示
$  eval echo \$$#
$ ./last one two three four

four
```

第一遍扫描后,shell把反斜杠去掉了.当shell再次扫描该行时,它替换了`$4`的值,并执行echo命令

***
以下示意如何用`eval`命令创建指向变量的`指针`:

```bash
x=100
ptrx=x
eval echo \$$ptrx  #指向 ptrx,用这里的方法可以理解上面的例子
eval $ptrx=50 #将 50 存到 ptrx 指向的变量中.
echo $x
```

```bash
# ptrx 指向x
echo $ptrx
x
# \$ 转义之后,再跟 x 连成一个字符串
echo \$$ptrx
$x
# eval 执行两次扫描,所以相当于 echo $x
eval echo \$$ptrx
```

### chmod

chmod - change file mode bits

SYNOPSIS

`chmod [OPTION]... MODE[,MODE]... FILE...`
`chmod [OPTION]... OCTAL-MODE FILE...`
`chmod [OPTION]... --reference=RFILE FILE...`

DESCRIPTION

chmod 后面可以接符号表示新的权限,也可以接一个octal number --表示新的mode bits.

符号mode的格式一般是`[ugoa...][[-+=][perms...]...]`,`perms`一般是`0`,或者`rwxXst`中的多个字符,
或者`ugo`中的一个字符.多种符号mode可以给出,用逗号隔开.

`ugoa`表示控制特定用户访问权限:

+ u:the user who owns it
+ g:other users in the file's group
+ o:other users not in the file's group
+ a:all  users
如果没有给出,默认就是 a,but bits that are set in the umask are not affected.

operator `+`添加权限,`-`删除权限,`=`设置为`xxx`,except that a directory's unmentioned set user and group ID bits are not affected.

`rwxXst`表示mode bits,read (r), write (w), execute (or  search  for directories)  (x),
execute/search  only if the file is a directory or already has execute permission for some user (X),
set user or group ID on execution (s), restricted deletion flag or sticky bit (t)

或者指定`ugo`中的一个,
the permissions granted to the user who owns the file (u),
 the permissions granted to other users who are members of the file's group (g),
 and the permissions granted to users that are in neither of the two preceding categories (o).

***
数字模式

数字mode 是1到4个 octal digits（0-7）,derived by adding up the bits with values 4, 2, and 1.

省略的数字被认为是前置的`0`.

第一位数字选择用户组
the set user ID (4) and
set group  ID(2)  and
restricted deletion or sticky (1) attributes.

第二位数字选择权限
read (4), write (2), and execute (1);

第三位数字设定组中其他用户的权限

第四位数字设定不在组中用户的权限

## formfactor 脚本

### 复制结果的脚本

```bash
#!/usr/bin/env python3
import os,shutil,time,gfm
# 复制到论文中的都是 ci==1.50 的结果
user_name='tom'
# 配置计算结果目录,论文目录,论文压缩文件目录
originpath=os.getcwd()
result_path=os.path.join(originpath,'expression-results/')
paper_path=os.path.join('/home',user_name,'private','paper-2.prd/')
desk_path=os.path.join('/home',user_name,'Desktop','paper.ff/')
# 复制计算结果到论文目录
shutil.copy(os.path.join(result_path,'fig.baryons.ge.charge.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig4.pdf'))
shutil.copy(os.path.join(result_path,'fig.baryons.ge.neutral.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig5.pdf'))
shutil.copy(os.path.join(result_path,'fig.baryons.gm.charge.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig2.pdf'))
shutil.copy(os.path.join(result_path,'fig.baryons.gm.neutral.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig3.pdf'))
# cd 到论文目录,重新编译论文
os.chdir(paper_path)
# 清除之前的编译结果,重新编译
os.system('latexmk -C')
os.system('./build.sh')
# 如果桌面有压缩文件目录,就删除,shutil.copytree需要目标不存在
src_list=['fig1.pdf','fig2.pdf','fig3.pdf','fig4.pdf','fig5.pdf','octetFF.tex','octetFF.pdf']
# 把论文目录的东西复制到桌面目录中
if  os.path.isdir(desk_path):
    for src in src_list:
        shutil.copy2(src,desk_path)
else:
    os.mkdir(desk_path)
    for src in src_list:
        shutil.copy2(src,desk_path)

## 切换到桌面整理目录
os.chdir(desk_path)

print("+++++++\nthe file left in",os.getcwd(),"\n+++++++")
os.listdir(desk_path)

# 产生论文压缩文件
os.system('rm ../paper.7z; 7z a ../paper.7z '+desk_path)
# 回到原来的文件夹
os.listdir(originpath)
```

## 环境变量

[Linux环境变量总结][]

[Linux环境变量总结]: https://www.jianshu.com/p/ac2bc0ad3d74

Linux是一个多用户多任务的操作系统,可以在Linux中为不同的用户设置不同的运行环境,具体做法是设置不同用户的环境变量.

### Linux环境变量分类

***
按照生命周期来分,Linux环境变量可以分为两类:

1. 永久的:需要用户修改相关的配置文件,变量永久生效.
2. 临时的:用户利用`export`命令,在当前终端下声明环境变量,关闭Shell终端失效.

***
按照作用域来分,Linux环境变量可以分为:

1. 系统环境变量:系统环境变量对该系统中所有用户都有效.
2. 用户环境变量:顾名思义,这种类型的环境变量只对特定的用户有效.

### Linux设置环境变量的方法

1. 在`/etc/profile`文件中添加变量 对所有用户生效（永久的）

用`vim`在文件`/etc/profile`文件中增加变量,该变量将会对`Linux`下所有用户有效,并且是`永久的`.
例如:编辑`/etc/profile`文件,添加`CLASSPATH`变量

```bash
vim /etc/profile
export CLASSPATH=./JAVA_HOME/lib;$JAVA_HOME/jre/lib
```

要想马上生效,运行`source /etc/profile`,不然只能在下次重进此用户时生效.

2. 在用户目录下的`~/.bashrc`文件中增加变量 [对单一用户生效（永久的）]

用`vim ~/.bashrc`文件中增加变量,改变量仅会对当前用户有效,并且是`永久的`.

```bash
vim ~/.bashrc
export CLASSPATH=./JAVA_HOME/lib;$JAVA_HOME/jre/lib
```

1. 直接运行`export`命令定义变量 [只对当前shell（BASH）有效（临时的）]

在shell的命令行下直接使用`export 变量名=变量值`

定义变量,该变量只在当前的shell（BASH）或其子shell（BASH）下是有效的,
shell关闭了,变量也就失效了,再打开新shell时就没有这个变量,需要使用的话还需要重新定义.

### Linux环境变量使用

Linux中常见的环境变量有:

***
PATH:指定命令的搜索路径

PATH声明用法:

```bash
export PATH=$PAHT:<PATH 1>:<PATH 2>:<PATH 3>:--------:< PATH n >
```

你可以自己加上指定的路径,中间用冒号隔开.环境变量更改后,在用户下次登陆时生效.

可以利用`echo $PATH`查看当前当前系统PATH路径.

    HOME:指定用户的主工作目录（即用户登陆到Linux系统中时,默认的目录）.
    HISTSIZE:指保存历史命令记录的条数.
    LOGNAME:指当前用户的登录名.
    HOSTNAME:指主机的名称,许多应用程序如果要用到主机名的话,通常是从这个环境变量中来取得的
    SHELL:指当前用户用的是哪种Shell.
    LANG/LANGUGE:和语言相关的环境变量,使用多种语言的用户可以修改此环境变量.
    MAIL:指当前用户的邮件存放目录.

注意:上述变量的名字并不固定,如HOSTNAME在某些Linux系统中可能设置成HOST

2. Linux也提供了修改和查看环境变量的命令,下面通过几个实例来说明:

+ `echo`  显示某个环境变量值 `echo $PATH`
+ `export`  设置一个新的环境变量 `export HELLO="hello"` (可以无引号)
+ `env`  显示所有环境变量
+ `set`  显示本地定义的`shell`变量
+ `unset`  清除环境变量 `unset HELLO`
+ `readonly`  设置只读环境变量 `readonly HELLO`

3. C程序调用环境变量函数

+ `getenv()` 返回一个环境变量.
+ `setenv()` 设置一个环境变量.
+ `unsetenv()` 清除一个环境变量.

## shell脚本中的符号

[shell脚本中一些特殊符号][]

[shell脚本中一些特殊符号]: https://www.cnblogs.com/xuxm2007/archive/2011/10/20/2218846.html

## 开机报错

[System program problem detected?][]

[System program problem detected?]: https://askubuntu.com/questions/1160113/system-program-problem-detected

### What causes this

See the crash report that is dumped on your disk.
The directory you want is `/var/crash/` and it will contain several files pointing you to the package it is about and what the crash is.

This directory is described as:

>`/var/crash` : System crash dumps (optional)
>This directory holds system crash dumps.
>As of the date of this release of the standard, system crash dumps were not supported under Linux but may be supported by other systems which may comply with the FHS.

Ubuntu releases use this (optional) directory to dump crashes and the package that does that is called `apport` (and `whoopsie`).
The link has a detailed description and also has a PDF that describes the crash report data format.

If you want really detailed reports on a crash install `GDB`: `The GNU Project Debugger` with `sudo apt-get install gdb`.

### How to get rid of it

Depends on what you call "get rid". The ideal fix would be to check what is inside the reports, and try and find a fix for it.
If the package it is about is unneeded or benign you could also purge it. Most times it is a core functionality though.

If you can not understand those crash reports most times you can google the error notice (there will always be one in there). Or drop a message in chat.
Generally crashes are off topic on AU as those are bugs and would need to be reported (through this service ;) ).

You can pick any of these to remove the crash report up to actually removing the package (would be rather ironic if the error comes from apport itself):

+ `sudo rm /var/crash/*` will delete old crashes and stop informing you about them until some package crashes again.
+ You can stop the service with `sudo systemctl` disable apport (and enable it again with `sudo systemctl enable apport`)
+ If you do not want to see crash reports you can disable it by doing sudo `vim /etc/default/apport`
and changing `enabled=1` to `enabled=0`. (or `sudo nano /etc/default/apport`).
Editing it in reverse will enable it again.
+ You can delete the service with `sudo apt purge apport` (and install it again with `sudo apt install apport`)
+ And there is also a desktop method (option "problem reporting":

[how to read and use crash reports?][] has some interesting answers.
It has an example crash report and a method to retrace crashes.

[how to read and use crash reports?]: https://askubuntu.com/questions/346953/how-to-read-and-use-crash-reports

## grub2

[grub2详解(翻译和整理官方手册)][]
[官方手册原文][]

[grub2详解(翻译和整理官方手册)]: https://www.cnblogs.com/f-ck-need-u/archive/2017/06/29/7094693.html#auto_id_37

[官方手册原文]: https://www.gnu.org/software/grub/manual/html_node/Simple-configuration.html#Simple-configuration

`grub2-mkconfig`是根据`/etc/default/grub`文件来创建配置文件的.
该文件中定义的是`grub`的全局宏,修改内置的宏可以快速生成`grub`配置文件.实际上在`/etc/grub.d/`目录下还有一些`grub`配置脚本,这些shell脚本读取一些脚本配置文件(如`/etc/default/grub`),根据指定的逻辑生成`grub`配置文件.
若有兴趣,不放读一读`/etc/grub.d/10_linux`文件,它指导了创建`grub.cfg`的细节,例如如何生成启动菜单.

```bash
[root@xuexi ~]# ls /etc/grub.d/
00_header  00_tuned  01_users  10_linux  20_linux_xen  20_ppc_terminfo  30_os-prober  40_custom  41_custom  README
```

在`/etc/default/grub`中,使用`key=vaule`的格式,`key`全部为大小字母,如果`vaule`部分包含了空格或其他特殊字符,则需要使用引号包围.

例如,下面是一个`/etc/default/grub`文件的示例:

```bash
[root@xuexi ~]# cat /etc/default/grub
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto biosdevname=0 net.ifnames=0 rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
```

虽然可用的宏较多,但可能用的上的就几个:
`GRUB_DEFAULT`、`GRUB_TIMEOUT`、`GRUB_CMDLINE_LINUX`和`GRUB_CMDLINE_LINUX_DEFAULT`.

以下列出了部分key.

***
`GRUB_DEFAULT`

默认的菜单项,默认值为`0`.其值可为数值`N`,表示从`0`开始计算的第`N`项是默认菜单,也可以指定对应的`title`表示该项为默认的菜单项.
使用数值比较好,因为使用的`title`可能包含了容易改变的设备名.例如有如下菜单项

```grub
menuentry 'Example GNU/Linux distribution' --class gnu-linux --id example-gnu-linux {
    ...
}
```

如果想将此菜单设为默认菜单,则可设置`GRUB_DEFAULT=example-gnu-linux`.

如果`GRUB_DEFAULT`的值设置为`saved`,则表示默认的菜单项是`GRUB_SAVEDEFAULT`或`grub-set-default`所指定的菜单项.

## ibus下定制自己的libpinyin

[ibus下定制自己的libpinyin][]

[ibus下定制自己的libpinyin]: https://blog.csdn.net/godbreak/article/details/9031887

智能拼音输入法从`ibus-pinyin`更名为`ibus-libpinyin`

`libpinyin`添加了词库导入功能,并刚刚修复相关`bug`,所以要先更新`libpinyin`到最新版.
在`libpinyin`的配置界面（可以从`语言选项`---`输入源`找到,实在找不到,`/usr/share/ibus-libpinyin/setup/main2.py`）,可以找到**用户数据导入选项**.

这个要求文件:

1. 文件采用本地编码格式
2. 格式为每行`字符 拼音 位置(可选)`,且字符数和拼音数要对应,例如`你好 ni'hao 5`.

去搜狗词库下搜狗细胞词库文件,然后下个**深蓝词库转换器**（`exe`）,`wine`中打开转换器,选择从搜狗细胞词库转换到手机`QQ`格式,转换结束后不要选择文件保存本地,编码格式不大对,在输出框里面全选复制粘贴到你的文本编辑器,保存为`.txt`后缀.
然后在`libpinyin`配置界面导入即可.导入完成后,`kill ibus-engine-libpinyin`进程,再切回拼音输入法.

## 网络配置

EXAMPLES

+ `ip addr` Shows addresses assigned to all network interfaces.
+ `ip neigh` Shows the current neighbour table in kernel.
+ `ip link set x up` Bring up interface x.
+ `ip link set x down` Bring down interface x.
+ `ip route` Show table routes.

EXAMPLES

+ `ip ro` Show all route entries in the kernel.
+ `ip route add default via 192.168.1.1 dev eth0` Adds a default route (for all addresses) via the local gateway 192.168.1.1 that can be reached on device eth0.
+ `ip route add 10.1.1.0/30 encap mpls 200/300 via 10.1.1.1 dev eth0` Adds an ipv4 route with mpls encapsulation attributes attached to it.
+ `ip -6 route add 2001:db8:1::/64 encap seg6 mode encap segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0` Adds an IPv6 route with SRv6 encapsulation and two segments attached.

***

`Ubuntu 18.04 Server` 安装好后,Netplan 的默认描述文件是:`/etc/netplan/50-cloud-init.yaml`.

[Ubuntu18.04的网络配置 netplan]

[Ubuntu18.04的网络配置 netplan]: https://blog.csdn.net/uaniheng/article/details/104233137?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase

### 配置netplan 固定ip

`vim /etc/netplan/50-cloud-init.yaml `

配置如下:

```bash
network:
    ethernets:
        enp3s0:
            addresses: [192.168.0.20/24]  //IP址
            gateway4: 192.168.0.1  // 网关
            nameservers:
             addresses: [114.114.114.114, 192.168.0.1] //DNS
            dhcp4: no
            optional: no
    version: 2
```

或者配置dhcp自动获取ip

`vim /etc/netplan/50-cloud-init.yaml `

配置如下:

```bash
network:
    ethernets:
        enp3s0:
            dhcp4: true
            optional: yes
    version: 2
```

应用:

`sudo netplan apply`

### ubuntu查看MAC地址

+ `ifconfig | awk '/eth/{print $1,$5}'`
+ `arp -a | awk '{print $4}`
+ `sudo lshw -C network`
+ `sudo lshw -c network | grep serial`

```bash
wlp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
      link/ether 10:5b:ad:df:4c:cd brd ff:ff:ff:ff:ff:ff
    inet 192.168.32.6/24 brd 192.168.32.255 scope global dynamic noprefixroute wlp2s0
       valid_lft 4185sec preferred_lft 4185sec
    inet6 fe80::310a:df04:1f02:d5ac/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

`link/ether 10:5b:ad:df:4c:cd brd ff:ff:ff:ff:ff:ff` This is the mac address

### 子网掩码

[为什么每台电脑都要设置子网掩码?][]

[为什么每台电脑都要设置子网掩码?]: https://www.zhihu.com/question/263438014/answer/278015413

[24 28 30 位的子网掩码是多少 ][]

[24 28 30 位的子网掩码是多少 ]: https://zhidao.baidu.com/question/517459209.html

例如:
IP地址为`130.39.37.100`,
网络地址为`130.39.0.0`,
子网地址为`130.39.37.0`,
子网掩码为`255.255.255.0`,
网络地址部分和子网标识部分对应`1`,host部分对应`0`.
使用CIDR表示为:`130.39.37.100/24`即`IP地址/ 掩码长度`.

`ipv4`是`8bit.8bit.8bit.8bit`的形式,二进制到十六进制是`4`位到`1`位,`8bit`相当于两个`16`进制数字.
所以`ipv4`是四段地址:`0x0x.0x0x.0x0x.0x0x`,每段两个`16`进制数字.
`24`表示掩码开头有`24`个`1`,对应地址中的`3`段,也就是公网地址是`3`段.

`awk`执行按位**与**操作.

```bash
awk 'BEGIN {
awk 'BEGIN {
    num1 = 10
    num2 = 6
    printf "(%d AND %d) = %d\n", num1, num2, and(num1, num2)
}'
```

设

```ip
A:10.1.1.10 /24
B:10.1.1.20 /24
C:50.1.1.80 /24
```

AB在同一局域网,C位于外网.

三个表:

+ `ARP`表:主机维护,存放`IP`地址和`MAC`地址对应关系.
+ `MAC`地址表:交换机维护,存放`MAC`地址和交换机端口对应关系.
+ 路由表:路由器维护,存放`IP`地址和路由器端口对应关系.

首先`AB`通信,
例如`A`要给`B`发送一个数据包,目前`A`知道`B`的`IP`地址,根据掩码规则判定`B`和自己在同一个局域网,同一个广播域.

接下来`A`通过广播方式获取`B`的`MAC`地址,添加到自己的`ARP`表中.
然后把要发送的包封装,然后发送给交换机,交换机收到数据包后解封装得到`B`的`MAC`地址,
根据`MAC`地址表转发到`B`所连接的交换机端口,完成发送.

如果`A`要和`C`通信,发送一个包给`C`的话,也只知道`C`的`IP`地址,然后`A`根据掩码规则发现`C`和自己不是同一个局域网的,
广播不到`C`,所以`A`只能把数据包发给网关,由网关发出去给到`C`.

`A`同样通过广播方式获取网关的`MAC`地址,然后把`C`的`IP`地址和网关的`MAC`地址封装到数据包后发给交换机,
交换机解封装后对比`MAC`地址表,发现是发给网关的包,就转发到网关即路由器所在的交换机端口.
路由器收到包之后再解封装,得到`C`的`IP`地址,然后根据自己的路由表转发到相应的端口.完成通信.

所以如果计算机上不设置子网掩码,从第一步就不能完成,下面就更不能继续了.
如果同一个广播域里有机器设置不同的子网掩码,依然能够通信,只不过有的内网包需要到网关绕一圈.

外网包的话只要网关设置对了就没问题.

## tex相关

### xelatex 脚本

[shell 参数换行 & shell 输出换行的方法][]

[shell 参数换行 & shell 输出换行的方法]: https://blog.csdn.net/donaldsy/article/details/99938408

首先测试一下括号的用法:

```bash
tex_list=1; echo $tex_list; tex_list=$( { ls -x *.tex } ); echo $tex_list;
tex_list=1; echo $tex_list; tex_list=$( ( ls -x *.tex ) ); echo $tex_list;
tex_list=$(ls -x *.tex; ls -x *.log); echo $tex_list;
tex_list=$( (ls -x *.tex; ls -x *.log) ); echo $tex_list;
```

```bash
#!/bin/bash

# 设置格式化相关的部分
delimiter="echo -e \\\n+++++++++++++"
nameis="name is :"
eval  $delimiter

# 默认文件名是 main,否则使用文件夹中的tex文件名
tex_usual="main"
echo "tex_usual $nameis $tex_usual"
eval  $delimiter

# 当前tex文件列表,去掉后缀

tex_list=$(ls -x *.tex)
echo "tex_list $nameis $tex_list"

tex_here=${tex_list//".tex"/}
echo "tex_here $nameis $tex_here"
eval  $delimiter

# 判断当前tex文件列表中是否包含 main.tex
# 若有 main.tex,使用之,若没有,则使用 列表中的tex
# tex_file=${${tex_here}%% *}

if [[ $tex_usual =~ $tex_here ]]
then
    tex_file=$tex_usual
else
    tex_file=${tex_here}
fi

echo "tex_file $nameis $tex_file"
eval  $delimiter

# 可增加输出文件夹选项 -auxdir=temp -outdir=temp
# 还有 -shell-escape 选项

# 把下面这行加入到 ~/.latexmkrc,指定 pdf 查看程序
# $pdf_previewer = 'evince %O %S';
# -silent 可以抑制输出

latexmk -xelatex  -silent -pv  -view=pdf -bibtex -cd -recorder -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 -view=pdf ${tex_file}

## 输出错误记录
eval  $delimiter
echo 'error message'
eval  $delimiter
## 用 tail 减少输出数量
## grep -m 100 -i -n --color -P -B 0 -A 8 "\[\d+\]" ./$tex_file".log" | tail -n 50
grep -m 10 -i -n --color -P -B 0 -A 8 "\[\d+\]" ./$tex_file".log"
```

***

默认情况下,`echo`关闭了对转义字符的解释,添加 `-e `参数可打开`echo`对转义字符的解释功能.`-E`关闭转义字符,是默认值.

```bash
echo -e "hello\n wrold" #换行输出 hello world
echo -E "hello\n wrold" #输出 hello\n world, 默认情况
```

### texlive安装与卸载

***
[Linux环境下LaTex的安装与卸载][]
[Ubuntu Texlive 2019 安装与环境配置][]
[TexLive 2019 安装指南][]

[TeX Live - Quick install](https://tug.org/texlive/quickinstall.html)

[Linux环境下LaTex的安装与卸载]: https://blog.csdn.net/l2563898960/article/details/86774599

[Ubuntu Texlive 2019 安装与环境配置]: https://blog.csdn.net/williamyi96/java/article/details/90732304

[TexLive 2019 安装指南]: https://zhuanlan.zhihu.com/p/64530166

***
准备工作:下载,清除

注意:安装 `lyx`, `apt` 会默认安装 `tex2017`版本,覆盖掉新版的`texlive2020`

注意:如果重新安装,请务必完全删除之前的失败安装,默认情况下,这将在这两个目录中:

```bash
rm -rf /usr/local/texlive/2020
rm -rf ~/.texlive2020
```

或者参考下面的命令

```bash
sudo rm -rf /usr/local/texlive/2020
rm -rf ~/.texlive2020
sudo rm -rf /usr/local/texlive
sudo rm -rf /usr/local/share/texmf
sudo rm -rf /var/lib/texmf
sudo rm -rf /etc/texmf
sudo apt-get purge texlive*
sudo apt-get remove tex-common --purge
```

***
进行安装

因为下载好的是一个`iso`镜像文件,所以下载好之后,还需要挂载到`/mnt`目录下

```bash
sudo mount -o ro,loop,noauto texlive2020-20200406.iso /mnt
```

+ `ro` :     Mount the filesystem read-only.
+ `loop` : loop 文件
+ `auto` :   Can be mounted with the -a option.
+ `noauto` : Can only be mounted explicitly (i.e., the  -a  option  will  not cause the filesystem to be mounted).

***
接着运行`install-tl`脚本进行安装.

若要更改安装目录或其他选项,请阅读提示和说明.
一般需要更改路径到自己有读写权限的文件夹下面,按`D`,然后按`1`,输入比如`~/texlive/2020`

更改目录到

+ `TEXDIR:         /home/tome/texlive/2020`
+ `main tree:      /home/tome/texlive/2020/texmf-dist`

+ `TEXMFLOCAL:     /home/tome/texlive/texmf-local`
+ `TEXMFSYSVAR:    /home/tome/texlive/2020/texmf-var`
+ `TEXMFSYSCONFIG: /home/tome/texlive/2020/texmf-config`
+ `TEXMFVAR:       ~/.texlive2020/texmf-var`
+ `TEXMFCONFIG:    ~/.texlive2020/texmf-config`
+ `TEXMFHOME:      ~/texmf`

```bash
cd /tex_iso_directory
sudo ./install-tl --profile installation.profile
[... messages omitted ...]
Enter command: i
[... when done, see below for post-install ...]
```

安装程序的接口:文本,GUI,批处理
安装程序支持:文本,图形,和批处理接口.（Linux系统下没有图像安装,在Windows下支持图形安装）

`install-tl -gui text #`使用简单文本模式.也是输入`install-tl`默认选项.

`install-tl --profile=profile #`进行一个批处理安装,需要一个 `profile` （配置文件）,为了创建一个`profile`,最简单的方式是使用`tlpkg/texlive.profile`文件,这是安装器在安装成功后生成的文件.

***
卸载镜像文件

```bash
sudo umount /mnt
```

***
字体配置

```bash
sudo cp /home/tom/texlive/2020/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/20-texlive.conf
sudo fc-cache -fsv
```

***
环境变量

安装完之后有提示:

```bash
Add /home/tom/texlive/2020/texmf-dist/doc/man to MANPATH.
Add /home/tom/texlive/2020/texmf-dist/doc/info to INFOPATH.
Most importantly, add /home/tom/texlive/2020/bin/x86_64-linux
to your PATH for current and future sessions.
```

我用的是`zsh`,如果用的是`bash`则修改`~/.bashrc`,其中的`/home/tom/texlive/2020`改称你安装时的路径
直接把下面的语句添加到`.zshrc`文件末尾.

```bash
export MANPATH=${MANPATH}:/home/tom/texlive/2020/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/home/tom/texlive/2020/texmf-dist/doc/info
export PATH=${PATH}:/home/tom/texlive/2020/bin/x86_64-linux
```

***
验证安装是否成功

```bash
tex -v
```

***
设置默认纸张尺寸

`tlmgr paper letter`

***
ubuntu 仓库的texlive

使用`apt`命令从`ubuntu`仓库安装的`texlive`可以使用`dpkg -L texlive-full`查询

安装在 `/usr/local/`目录下,
`texmf`(TDS的根目录)在`/usr/share/texmf` and `/usr/share/texlive/texmf-dist`

### texlive常用命令

用`texlive**.iso`手动安装的 texlive 是可以正常使用下面这些命令的,而用 `debian`源`apt`安装的,可能会出问题.

`tlmgr [option]... action [option]... [operand]...`

安装好 texlive 后

如果使用`tlmgr option` 报错
`cannot setup TLPDB in /home/USER/texmf at /usr/bin/tlmgr line 5308.`

原因如下:

未初始化`tlmgr`时会产生此错误. 在大多数情况下,以普通用户身份启动以下命令可以解决此问题：

`$ tlmgr init-usertree`

此命令将在您的家目录内创建几个文件夹. 请参见手册页以获取解释：

>在用户模式下使用`tlmgr`之前,您必须使用`init-usertree`操作设置用户树.
>这将创建`usertree / web2c`和`usertree / tlpkg / tlpobj`,以及最小的`usertree / tlpkg / texlive.tlpdb`.
>此时,您可以通过添加`--usermode`命令行选项来告诉`tlmgr`执行（支持的）动作.

***
下面这些是`tlmgr`的常用命令:

+ `tlmgr option repository ctan`
+ `tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet`
+ `tlmgr repository list`
+ `tlmgr update --self`
+ `tlmgr update  --all`

如果要使用清华的`mirror`:

`tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet`

[texlive home page](https://tug.org/texlive/) 

[texlive installation and updates](https://tug.org/texlive/pkginstall.html) texlive 安装和更新

[archive of tlnet ](https://www.texlive.info/tlnet-archive/) ：各个年份的 tex 更新，可以选择用来更新的 repository 的版本

[texlive.info](https://texlive.info/) 查看各种关于 texlive 的信息

告诉`tlmgr`使用附近的CTAN镜像进行将来的更新； 如果您从DVD映像安装了TeX Live,并且想要持续更新,则很有用.
这两个命令是等效的. `ctan`只是给定URL的别名. 
注意：`mirror.ctan.org`解析为许多不同的主机,它们并没有完全同步. 我们建议仅（最多）每天更新一次,而不要更频繁.

+ `tlmgr update --list` 报告将要更新的内容,而无需实际更新任何内容.
+ `tlmgr update --all` 使本地TeX安装与软件包存储库中的安装相对应（从CTAN更新时通常很有用）.
+ `tlmgr info pkg` 显示有关软件包内容的详细信息,例如搜索所有软件包中内容的安装状态和描述.

可能遇到的错误：

[tlmgr: unexpected return value from verify_checksum: -5](https://tex.stackexchange.com/questions/528634/tlmgr-unexpected-return-value-from-verify-checksum-5)

出现这个错误是由于某个`repository`的`signing key`过期了，
首先可以使用`tlmgr repository list`列出所有的库，使用`tlmgr key list`列出所有的`keys`

首先把`repository`更换到对应`debian`发行版的仓库，比如使用 `2019` 版本的 `repository` ，
`tlmgr option repository https://www.texlive.info/tlnet-archive/2019/12/31/tlnet/`

然后把[tug](https://www.tug.org/texlive/)的 `GPG` key 加入到 `tlmgr` 的key 列表中

```bash
curl -fsSL https://www.tug.org/texlive/files/texlive.asc | tlmgr key add -
```

这样就不会出现`erify_checksum: -5`错误了。

总结：

+ `tlmgr key list`列出所有的`key`
+ `tlmgr repository list`列出使用的仓库
+ `curl -fsSL https://www.preining.info/rsa.asc | tlmgr key add -`为`contrib`仓库添加新的gpg key
+ `tlmgr install  --verify-repo=none pkg` 免去验证

curl -fsSL https://www.preining.info/rsa.asc | tlmgr key add -

### tlmgr 命令

***
`install [option]... pkg...`

如果尚未安装,请安装命令行上给出的每个`pkg`.
（它不涉及现有软件包；有关如何获取软件包的最新版本,请参见`更新`操作.）

默认情况下,这还会安装给定pkg所依赖的所有软件包. 选项：

+ `--dry-run` : 实际没有安装任何东西. 而是将要执行的动作写入终端.
+ `--file`: 不从安装库中获取软件包,不如使用命令行上给出的软件包文件. 这些文件必须是标准的TeX Live软件包文件（包含tlpobj文件）.
+ `--force`:如果存在对`tlmgr`本身（或基本基础结构的其他部分）的更新,
则除非给出此选项,否则`tlmgr`将退出紧急状态并且不会执行安装. 不建议.
+ `--no-depends`:不要安装依赖项. （默认情况下,安装软件包可确保满足该软件包的所有依赖关系.）
+ `--no-depends-at-all`:通常,当您安装附带二进制文件的软件包时,还将安装相应的二进制软件包.
也就是说,对于软件包`foo`,软件包`foo.i386-linux`也将安装在`i386-linux`系统上. 
此选项抑制了这种行为,并且还暗示了`--no-depends`.
除非您确定自己在做什么,否则不要使用它.
+ `--reinstall`:即使似乎已经安装了软件包（即TLPDB中已存在）,也要重新安装软件包（包括集合的依赖项）.
这对于从意外删除层次结构中的文件中恢复非常有用.

***

+ `conf [texmf|tlmgr|updmap [--conffile file] [--delete] [key [value]]]`
+ `conf auxtrees [--conffile file] [show|add|delete] [value]`

仅使用`conf`,即可显示TeX Live的常规配置信息,包括活动配置文件,路径设置等. 
这就像运行`texconfig conf`一样,但是可以在所有支持的平台上运行.

使用`conf texmf`,`conf tlmgr`或`conf updmap`之一显示`ROOT / texmf.cnf`（用户特定的`tlmgr`配置）中保存的所有键/值对（即所有设置） 文件（请参见下文）或第一个（通过`kpsewhich`找到的）`updmap.cfg`文件.

`conf`显示的`PATH`值与`tlmgr`使用的值相同. 包含`tlmgr`可执行文件的目录会自动添加到从环境继承的PATH值之前.

这是更改配置值的实际示例. 如果在安装过程中启用了通过`\ write18`执行的（部分或全部）系统命令,则可以在以后将其禁用：

```bash
tlmgr conf texmf shell_escape 0
```

子命令`auxtrees`允许完全在用户控制下添加和删除任意其他texmf树.
`auxtrees show`显示其他树的列表,`auxtrees add`树将树添加到列表中,`auxtrees remove`树从列表中删除树（如果存在）.

树中不应包含`ls-R`文件（否则,如果`ls-R`过时,则可能找不到文件）. 
通过操作`ROOT / texmf.cnf`中的Kpathsea变量`TEXMFAUXTREES`来生效. 例：

```bash
tlmgr conf auxtrees add /quick/test/tree
tlmgr conf auxtrees remove /quick/test/tree
```

在所有情况下,如果需要,都可以通过选项`--conffile`文件显式指定配置文件.

警告：此处是用于更改配置值的一般工具,但是强烈建议不要以这种方式修改设置. 
同样,不对键或值进行错误检查,因此可能发生任何破损.

### jabref

[JabRef中文手册][]

[JabRef中文手册]: https://blog.csdn.net/zd0303/article/details/7676807

entry时间戳

本功能可以在`选项->偏好设置->通用设置`中关闭或配置.
`JabRef`能自动的产生一个包含题录加入数据库的日期的域.

格式：

时间戳记的格式由包含指示词的字符串确定,指示词表示日期各部分的位置.
以下是一些可用的指示字母（示例在括号中给出,为： 2005年9月14日（星期三）下午5.45）：

+ yy: year (05)
+ yyyy: year (2005)
+ MM: month (09)
+ dd: day in month (14)
+ HH: hour in day (17)
+ mm: minute in hour (45)

这些指示符可以与标点符号和空格一起使用. 几个例子：

+ `yyyy.MM.dd gives 2005.09.14`
+ `yy.MM.dd gives 05.09.14`
+ `yyyy.MM.dd HH:mm gives 2005.09.14 17:45`

### lyx 报错

使用命令行打开`lyx`就没有问题。

***
有时安装好了texlive,也安装好了lyx,却仍然报错,这个时候一般是因为路径(`$PATH`)没有配置好,
lyx没有检测到texlive的各种文件.参考 [LYX Manuals](https://wiki.lyx.org/uploads//LyX/Manuals/1.6.4//Manuals.pdf)

`LYX`的一些功能可以从`LYX`内部进行配置,而无需重新配置文件. 
首先,`LYX`能够检查您的系统,以查看可以使用哪些程序,`LATEX`文档类和`LATEX`软件包. 
它使用此知识为多个`Preferences`设置提供合理的默认值.
尽管在系统上安装`LYX`时已经完成了此配置,但是您可能需要在本地安装一些项目,
新的`LATEX`类,而`LYX`看不到这种变化.
要强制LYX重新检查系统,您应该使用`Tools,Reconfigure`. 然后,您应该重新启动LYX以确保考虑到更改.

添加`tex`文件的路径到`$PATH`中的时候,注意尽量把新的`tex`路径添加到`$PATH`前面,
以防止之前安装的残留掩盖新的路径.也就是,

```bash
if [[ $SHELL == "/bin/zsh" ]] ;then
echo "\n# add texlive paths" >> ~/.zshrc
echo "export MANPATH=your_texlive_path/texmf-dist/doc/man:${MANPATH}" >> ~/.zshrc
echo "export INFOPATH=your_texlive_path/texmf-dist/doc/info:${INFOPATH}" >> ~/.zshrc
echo "export PATH=your_texlive_path/bin/x86_64-linux:${PATH}" >> ~/.zshrc
fi
```

***
可能2

`~/.lyx/textclass.lst` 中的条目格式有问题,如

`"IEEEtran-CompSoc"` 变成了 `"b'IEEEtran-CompSoc'"`

python中字节字符串不能格式化.
获取到的网页有时候是字节字符串,需要转化后再解析.

bytes 转 string 方式:

```python
>>>b=b'\xe4\xba\xba\xe7\x94\x9f\xe8\x8b\xa6\xe7\x9f\xad\xef\xbc\x8c\xe6\x88\x91\xe8\xa6\x81\xe7\x94\xa8python'
>>>string=str(b,'utf-8')
>>>string
## 或者
>>>b=b'\xe4\xba\xba\xe7\x94\x9f\xe8\x8b\xa6\xe7\x9f\xad\xef\xbc\x8c\xe6\x88\x91\xe8\xa6\x81\xe7\x94\xa8python'
>>>string=b.decode()
'人生苦短,我要用python'
```

[python基础之string与bytes的转换]

[python基础之string与bytes的转换]: https://blog.csdn.net/Panda996/java/article/details/84780377

### lyx 默认pdf查看

在`tools-preferences-File Handling-File Formats`

在 `Format` 一栏中选中`PDF(XeTex)`  或者其他想要更改的格式,然后在 `Viewer`中更改程序,或者自定义程序位置.

### latexmk 选项

一般来说, `latexmk` 的通用`cmd`命令形式为:

`latexmk [options] [file]`

所有的选项可以用单个`-`连字符,也可以用双连字符`--`引入,e.g., "latexmk -help" or "latexmk --help".

***
注意:

除了文档里列出的选项, `latexmk`认识几乎所有the options recognized by the latex, pdflatex programs (and their relatives),
在当前的 TexLive and MikTeX 发行版中.

这些程序的一些选项还会引起 latexmk 的特殊 action or behavior,在本文档中有解释.否则,它们被直接传递给latex or pdflatex.
run `latexmk -showextraoptions`给出选项列表,这些选项被直接传递给latex or pdflatex.

***
注意:

"Further processing" 意味着需要运行其他程序,或者再次运行`latex`(etc),如果没有 `errors` 的话.
如果你不想让`latex`在遇到错误的时候停下,应该使用 latexmk's option `-interaction=nonstopmode`

`-xelatex`  使用`xelatex`编译
`-pv `   - preview document.  (Side effect turn off continuous preview)
` -pv-`   - turn off preview mode
`-pvc`   - preview document and continuously update.  (This also turns  on force mode, so errors do not cause latexmk to stop.)
(Side effect: turn off ordinary preview mode.)
`-pvc-`  - turn off -pvc

`-view=default` - viewer is default (dvi, ps, pdf)
`-view=ps`      - viewer is for ps
`-view=pdf`     - viewer is for pdf

`-bibtex`       - use bibtex when needed (default)
`-bibtex-`      - never use bibtex

`-cd`    - Change to directory of source file when processing it

`-recorder` - Use -recorder option for (pdf)latex (to give list of input and output files)
` -recorder-` - Do not use -recorder option for (pdf)latex

***
简单传递的命令

`-error-line=n` set the width of context lines on terminal error messages
`-half-error-line=n`      set the width of first lines of contexts in terminal error messages

`-file-line-error `       enable `file:line:error` style messages
`-halt-on-error`          stop processing at the first error
`-interaction=STRING`     set interaction mode (STRING=batchmode/nonstopmode/scrollmode/errorstopmode)
`-synctex=NUMBER`         generate `SyncTeX` data for previewers if nonzero

### 安装latex包

[Ubuntu/Mint下LaTeX宏包安装及更新][]

[Ubuntu/Mint下LaTeX宏包安装及更新]: https://blog.csdn.net/codeforces_sphinx/article/details/7315044

一般使用texlive的包管理工具,否则需要手动安装:

1. Get the package from [CTAN](http://www.ctan.org/CTAN) or wherever.
2. 如果其中有一个文件是`.ins` 结尾的,打开终端,执行命令`latex foiltex.ins`,就获得了安装需要的包.大多数 latex 包没有打包,所以可以跳过这一步.
3. 现在你需要决定,这个包要安装给所有用户使用,还是only for you.
4. 在*nix 系统上（OSX）,给所有用户使用,安装到`local` TeX tree, 给自己使用,安装到`user`TeX tree.

查看`texmf.cnf`文件,它通常在`$TEXMF/web2c`文件夹,但是可以用`kpsewhich texmf.cnf`定位.

`local` Tree 的位置在 `TEXMFLOCAL` variable 中定义,通常像是`/usr/local/share/texmf`.
`user`  Tree 的位置在`TEXMFHOME`中定义,通常像是`$HOME/texmf` or `$HOME/.texliveXXXX`

如果这些变量没有定义,你需要手工指定.修改`local` Tree 可能需要 root 权限.建议修改 user tree, 因为在升级的时候,不会被覆盖.这样在备份系统的时候,可以一起备份.

现在,你需要告诉 Latex 有新文件.这取决于 LaTex 发行版.

1. 对于 TeXLive,运行`texhash`,可能需要 root 权限
2. 对于MikTeX,运行 `Settings (Admin)` and press the button marked `Refresh FNDB`

5. 最后,你需要告诉 LyX 有新的包可以使用.在LyX 中,运行 `Tools->Reconfigure` and then restart LyX

现在,新的文档 class 可以选择了,`Document->Settings->Document Class`.

### latex包安装方式2

首先要找到默认宏包所在目录,一般是:

```bash
/usr/share/texmf/tex/latex
/usr/share/texmf-texlive/tex/latex
```

1. 如果是安装一个新的宏包,就直接把宏包的压缩文件扔进第一个目录下,直接解压就行,注意解压后的文件里可能有安装说明,照着安装说明做就是了.
如果是更新一个宏包,一般都可以在第二个目录下找到,把原先的宏包重命名成`*-backup`,再解压新下载的宏包压缩文件,同时如果有安装说明的话,也照着做.
2. 之后要对宏包重新标记下,终端下执行

```bash
# texhash
```

Log off/Log in 后,就完成了~

### latex pdf 裁剪

`texlive` 自带了一个叫做 `pdfcrop` 的 `perl` 脚本

使用方法如下：

`pdfcrop --margins 3 --clip input.pdf output.pdf; `
or

```bash
pdfcrop --clip --bbox '120 480 570 830' input.pdf output.pdf;
```

四个数字的含义是,以左下角为原点,给出`left bottom right top`的数值,单位是`point`

`1 point`=`0.3527 mm`=`1/72 inch`.
A4纸张(mm) `210` * `297`=`595.4 point`*`842.1 point`.

## loop 设备

loop 设备 (循环设备)

[loop 设备 (循环设备)][]

[loop 设备 (循环设备)]: https://blog.csdn.net/neiloid/article/details/8150629?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param

### loop 设备介绍

在类 UNIX 系统里,`loop` 设备是一种伪设备(pseudo-device),或者也可以说是仿真设备.它能使我们像块设备一样访问一个文件.

在使用之前,一个 `loop` 设备必须要和一个文件进行连接.这种结合方式给用户提供了一个替代块特殊文件的接口.因此,如果这个文件包含有一个完整的文件系统,那么这个文件就可以像一个磁盘设备一样被 `mount` 起来.

上面说的文件格式,我们经常见到的是 CD 或 DVD 的 ISO 光盘镜像文件或者是软盘(硬盘)的 *.img 镜像文件.通过这种 `loop mount` (回环`mount`)的方式,这些镜像文件就可以被 `mount` 到当前文件系统的一个目录下.

至此,顺便可以再理解一下 `loop` 的含义:对于第一层文件系统,它直接安装在我们计算机的物理设备之上；
而对于这种被 `mount` 起来的镜像文件(它也包含有文件系统),它是建立在第一层文件系统之上,
这样看来,它就像是在第一层文件系统之上再绕了一圈的文件系统,所以称为 `loop`.

在 Linux 里,`loop` 设备的设备名形如:

```bash
ls /dev/loop*
/dev/loop0  /dev/loop2  /dev/loop4  /dev/loop6
/dev/loop1  /dev/loop3  /dev/loop5  /dev/loop7
... ...
```

例如,要在一个目录下 mount 一个包含有磁盘镜像的文件,需要分 2 步走:

```bash
losetup /dev/loop0 disk.img           #使磁盘镜像文件与循环设备连结起来
mount /dev/loop0 /home/groad/disk_test   #将循环设备 mount 到目录 disk_test 下
```

经过上面的两个命令后,镜像文件就如同一个文件系统挂载在 `disk_test` 目录下,当然我们也可以往镜像里面添加文件.

其实上面的两个步骤可以写成一个步骤:

```bash
mount -t minix -o loop ./disk.img ./disk_test
```

## linux查看当前登录用户

[linux查看当前登录用户][]

[linux查看当前登录用户]: https://blog.csdn.net/wanchaopeng/article/details/88425067

### w命令

`w`:显示目前登入系统的用户信息

+ `-f`: 开启或关闭显示用户从何处登入系统.
+ `-h`: 不显示各栏位的标题信息列.
+ `-s`: 使用简洁格式列表,不显示用户登入时间,终端机阶段作业和程序所耗费的CPU时间.
+ `-u`: 忽略执行程序的名称,以及该程序耗费CPU时间的信息.
+ `-V`: 显示版本信息.

输出的结果的含义:

+ `USER` 登录的用户名
+ `TTY` 登录终端
+ `FROM` 从哪个IP地址登录
+ `LOGIN`@ 登录时间
+ `IDLE` 用户闲置时间
+ `JCPU` 指的是和该终端连接的所有进程占用的时间,这个时间里并不包括过去的后台作业时间,但却包括当前正在运行的后台作业所占用的时间
+ `PCPU` 当前进程所占用的时间
+ `WHAT` 当前正在运行的命令

### who

显示当前已登录的用户信息,输出的结果有:用户名,登录终端,登录的时间

### last

列出目前与过去登入系统的用户相关信息.

+ `-R`: 省略 hostname 的栏位
+ `-n`:指定输出记录的条数.
+ `-f file`:指定用文件`file`作为查询用的`log`文件.
+ `-t time`:显示到指定的时间.
+ `-h `:显示帮助.
+ `-i` or`--ip`:以`数字`and `点`的形式显示`ip`地址.
+ `-x`:显示系统关闭、用户登录和退出的历史.

命令的输出包含:用户名,登录终端,登录IP,登录时间,退出时间（在线时间）

### lastlog

`lastlog` 命令检查某特定用户上次登录的时间

+ `-b`, `--before DAYS`: 仅打印早于 DAYS 的最近登录记录
+ `-h`, `--help`: 显示此帮助信息并推出
+ `-R`, `--root CHROOT_DIR` directory to chroot into
+ `-t`, `--time DAYS` : 仅打印比 DAYS 新近的登录记录
+ `-u`, `--user LOGIN` : 打印 LOGIN 用户的最近登录记录

注意:`lastlog`命令默认读取的是`/var/log/wtmp`这个文件的数据,一定注意这个文件不能用`vi`来查看.

命令输出包括:用户名,登录终端,登录`IP`,最后一次登录时

## X窗口系统

X窗口系统（使GUI工作的底层引擎）内建了一种机制,支持快速拷贝和粘贴技巧.

按下鼠标左键,沿着文本拖动鼠标（或者双击一个单词）高亮了一些文本,
那么这些高亮的文本就被拷贝到了一个由X管理的缓冲区里面.然后按下鼠标中键,这些文本就被粘贴到光标所在的位置.

>`ctrl-c` and `ctrl-v`,这两个控制代码对于Shell 有不同的含义,它们在早于Microsoft Windows许多年之前就赋予了不同的意义.

可以把聚焦策略设置为"跟随鼠标",这样鼠标移动到的窗口,就可以接受输入

### 幕后控制台

即使仿真终端没有运行,后台仍然有几个终端会话运行.他们叫做虚拟终端或者虚拟控制台.

在大多数Linux发行版中,可以通过按下 `Ctrl+Alt+F1` 到 `Ctrl+Alt+F6` 访问.

切换可以直接按`Alt+F1..F6`.返回图形桌面,按下`Alt+F7`

### 将标准输出重定向到剪贴板

[将标准输出重定向到剪贴板][]

[将标准输出重定向到剪贴板]: https://blog.csdn.net/tcliuwenwen/article/details/103752486

作为一名优秀的程序员,终端和复制粘贴必将是必不可少的,手动将输出复制粘贴不应该是一名优秀程序员的作风.
那么如何将标准输出重定向到剪贴板方便我们粘贴呢？

安装`xsel`或者`xclip`

```bash
sudo apt install xsel
sudo apt install xclip
```

***
将输出通过管道重定向到剪贴板

```bash
ls | xsel -ib  # 使用xsel
ls | xclip -select clip  # 使用xclip
```

***
可以考虑使用别名来简短命令这里不再赘述

### 剪贴板管理程序

[10 款最佳剪贴板管理器][]

[10 款最佳剪贴板管理器]: https://www.linuxprobe.com/10-best-linux-clipboard.html

+ CopyQ
+ GPaste
+ Klipper
+ Clipman
+ Diodon

etc

### Linux 录屏软件

[Linux 录屏软件有哪些][]

[Linux 录屏软件有哪些]: https://www.zhihu.com/question/51920876

如果是`Gnome3`系用户,可以按`ctrl + shift + alt + r`,屏幕右下角有红点出现,则开始录屏,
要结束的话再按一次`ctrl + shift + alt + r`,录好的视频在`~/video`下

***
修改默认30秒的问题, 改成1小时

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 3600
```

### 美化

shell: [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
themes: [vimix-gtk-themes](https://github.com/vinceliuice/vimix-gtk-themes)
icon: [vimix-icon-theme/](https://github.com/vinceliuice/vimix-icon-theme/)

`sudo apt install gnome-shell-extensions`

extensions: `Blyr `,`Dash to panel`,`User themes`,`openweather`

#### Plymouth

[Ubuntu 16.04美化——Plymouth(splash screen/开机画面)主题安装](https://blog.csdn.net/mutilcam_prince/article/details/78299628)

[www.gnome-look.org](www.gnome-look.org)上有大量的`Ubuntu Plymouth`主题,也就是通常所说的开机画面主题,
但是几乎所有的主题在`16.04`之后变的不可用了,那是因为从`16.04`开始, `plymouth`主题存放路径已经变了,
而网络上的主题还是对应的老版路径,那就是`/lib/plymouth/themes/`,`16.04`之后已改为：`/usr/share/plymouth/themes/`.
这导致老版的主题不光用作者写的脚本安装不上,即便是自己手动复制到主题目录里,也不能正常使用.

本篇文章重点介绍一下老版`plymouth`主题如何安装到`16.04`上.

首先正常的话,`16.04`已经默认安装了一个`plymouth`主题,
如果不知道何种原因,你的`16.04`没有默认安装`plymouth`的默认主题,那么可以通过下面这个命令安装：

` sudo apt-get install plymouth-themes`

这条命令会自动创建`/usr/share/plymouth/themes/`并且附带几个简单默认的主题.

那么下面我们来开始安装自定义主题.以[`NSA Splash Screen`] (https://www.gnome-look.org/p/1173975/)为例.

***
下载主题,然后解压后得到一个目录.（本文以解压到`~/Downloads`为例）解压完成后，
重点是`images`目录、`nsa.plymouth`、`nsa.script`
那么我们可以得知,这个主题叫`nsa`
`Plymouth`的主题名称和主题文件名以及主题目录名,必须完全一致,不然会报错.
所以我们首先需要把这个`skd1993-nsa-plymouth-50df7fd`目录名改成`nsa`

***
查看并修改主题文件

`nsa`是个老版本的主题,这个是怎么看出来的呢,用文本编辑器打开`nsa.plymouth`：

[Plymouth Theme]
Name=nsa
Description=An NSA style cool bootsplash
ModuleName=script

[script]
ImageDir=/lib/plymouth/themes/nsa-plymouth
ScriptFile=/lib/plymouth/themes/nsa-plymouth/nsa.script

正如之前所说,`ImageDir`和`ScriptFile`对应的路径已经不存在了.因此我们需要对其进行修改.
对于我们这个主题来说,具体是这样的：

```bash
ImageDir=/usr/share/plymouth/themes/nsa
ScriptFile=/usr/share/plymouth/themes/nsa/nsa.script
```

保存退出.

***
安装主题

把主题文件夹复制到`plymouth`的`theme`目录

`sudo cp -r  ~/Downloads/nsa   /usr/share/plymouth/themes/`

然后安装这个主题.

`sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth       default.plymouth        /usr/share/plymouth/themes/nsa/nsa.plymouth  100`

更新一下`plymouth`,根据提示手动输入序号选择我们刚刚安装的主题.

`sudo update-alternatives --config default.plymouth`

最后更新一下`initramfs`

`sudo update-initramfs -u`

完成
重启即可看到效果.

***
如果在`sudo update-alternatives –config default.plymouth`这一步出现错误提示：

```bash
W: plymouth module "(/usr/lib/i386-linux-gnu/plymouth//.so)" missing, skipping that theme.
```

这是个内核级的错误,此时不要重启,不然可能卡在开机界面.绝大多数可能是某个步骤中的路径搞错了.
仔细检查所有步骤的路径,然后重来一遍.

本文中的三四步骤，可以通过一个shell脚本完成。
下面贴上脚本内容（仅限本主题，其他主题可以简单将文中的`nsa`更换为相应主题的名称，前提是修改完`nsa.script`）

```bash
#!/bin/bash
# 打印提示信息，选择颜色使其更醒目
echo  -e "\033[36m Copying new files...  \033[0m"
# 在/usr/share/plymouth/themes文件夹下，创建目录存放主题文件
sudo mkdir /usr/share/plymouth/themes/nsa
# 复制主题内容，其中使用了花括号展开，这里相当于直接给出
sudo cp --recursive {images,nsa.plymouth,nsa.script,README.md} /usr/share/plymouth/themes/nsa
# 安装主题，语法是：update-alternatives --install link name path priority ... 分别是2级链接，一级连接，实际路径
echo -e "\033[31m Installing the theme...  \033[0m"
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/nsa/nsa.plymouth  100
# 使用 update-alternatives 设置为默认主题，依照提示选择
echo -e "\033[32m Please Select your theme and set it default...  \033[0m"
sudo update-alternatives --config default.plymouth
# 更新
sudo update-initramfs -u
echo -e "\033[36m Installation Complete!  \033[0m"
```

将上述代码保存到主题目录下，文件名比如为`xxx.sh`

```bash
chmod +x xxx.sh
./xxx.sh
```

即可完成安装

#### 其他主题安装

有的主题也可能自带安装脚本，比如

[ubuntu-touch: A Plymouth startup and shutdown animated splash](http://gnome-look.org/content/show.php/colours%3A+Ubuntu+rainbow+plymouth+theme?content=163234)

1. 下载解压缩，进入`ubuntu-touch-splash`
1. `./install-ubuntu-touch [ENTER]`.将安装`plymouth-x11`软件包以提供测试主题的功能，而无需重新启动。
之后，将显示新主题的启动和关闭的10秒测试。

如果修改不小心导致启动屏幕黑屏，则恢复的最快方法是重新提取下载文件，然后重新安装它。
如果尚未对`ubuntu-touch-splash`文件夹中的文件进行任何更改，则可以使用以下方法重复测试：
`  ./test-plymouth [输入]`
 
在启动动画的持续时间非常非常短的情况下，可以通过在`ubuntu-touch-splash`文件夹中执行来获得改进的效果：
` ./assert-framebuffer`
如果您最终对该主题不满意，还原可以在主题目录下执行：

```bash
./update-plymouth [ENTER]
```

根据要求选择`ubuntu-logo`或者其他之前使用的主题。

## ubuntu 备份和恢复

### Ubuntu系统备份1

***
分区 id 记录

设备 挂载点 原始uuid 分区格式 新uuid new设备

`/boot/efi` 2EEE-149A `FAT (32-bit version)`
`none` 3278e9ef-8c04-4eaa-bfde-af2313f36545 `Swap`
`/`  7aba3e2f-f94d-454c-9ad6-9098d658401a `Ext4`

***
可以用ubuntu18.04自带软件`gnome-disks`查看自己系统分区情况：
在新电脑上，可以用`GParted`对硬盘进行分区

***
首先启动live CD，选择`try Ubuntu`；

开始对需要用live CD备份的分区进行挂载，所以挂载除了`swap`之外的分区，对比我们之前创建的表来看下面的挂载命令会更容易理解：

```bash
#获取最高权限
sudo su
#-- 在mnt下创建root目录和efi目录，分别用来挂载原系统的root分区和efi分区
mkdir /mnt/root   /mnt/efi  /mnt/home
#-- 将原系统根分区挂载到/mnt目录
mount /dev/sdb5   /mnt/root
#将原系统的boot/efi分区挂载到/mnt/efi目录
mount /dev/sda2   /mnt/efi
#-- 将原系统的home分区挂载到/mnt/home
mount /dev/sdb6   /mnt/home
```

***
插入U盘或硬盘开始备份：

```bash
#-- 将root、home和efi分区备份到硬盘中
mksquashfs /mnt/root /media/ubuntu/你的移动硬盘/备份的目录/root.sfs
mksquashfs /mnt/efi /media/ubuntu/你的移动硬盘/备份目录/efi.sfs
mksquashfs /mnt/home /media/ubuntu/你的移动硬盘/备份目录/home.sfs
sync
#-- 卸载刚刚挂载的分区和硬盘
umount /media/ubuntu/* /mnt/*
```

`root`、`home`和`efi`分区备份完成。

***
对新硬盘进行分区

在新电脑上启动live CD，选择试用，打开live CD中自带分区工具`GParted`，对新电脑进行分区，分区大小根据个人情况而定, 参照之前填的表：

```bash
efi分区
swap分区,如果不需要休眠，其实不用分这个，而且固态硬盘不分这个比较好
root分区（主分区或逻辑分区无所谓）
home分区（主分区或逻辑分区无所谓）
```

***
将备份文件恢复到各个分区

使用`live CD`自带软件`gnome-disks`查看新分区的信息，完善之前的表，我的情况如下:

插入存有备份文件的移动硬盘开始恢复备份：

```bash
sudo su
#-- 在mnt下创建root、home和efi目录，分别用来挂载新电脑的root、home和efi分区
mkdir /mnt/root /mnt/efi  /mnt/home
#-- 挂载新电脑的根分区到/mnt/root目录
mount /dev/sdc5 /mnt/root
#-- 挂载新电脑的efi分区到/mnt/efi
mount /dev/sdc1 /mnt/efi
#-- 挂载新电脑home分区到/mnt/home
mount /dev/sdc6 /mnt/home
#-- 新建/backup/root/、/backup/home和/backup/efi目录,使用loop模式将之前准备好的sfs文件挂载到对应的目录下
mkdir /backup
cd /backup
mkdir root efi home
mount -o loop /media/ubuntu/存放备份文件的路径/root.sfs /backup/root
mount -o loop /media/ubuntu/存放备份文件的路径/efi.sfs  /backup/efi
mount -o loop /media/ubuntu/存放备份文件的路径/home.sfs  /backup/home
#-- 开始恢复
cp -a /backup/root/* /mnt/root
cp -a /backup/efi/* /mnt/efi 
cp -a /backup/home/* /mnt/home 
# -- 同步数据并取消挂载
sync
umount /backup/*
umount /mnt/*
umount /media/ubuntu/*
```

***
启动引导修复

恢复完成之后，开始来修改引导文件,首先使用`/mnt`目录来挂载新电脑完整的文件系统，再次掏出我们之前填好的表：

```bash
sudo su
# -- 移除之前创建的临时文件夹 
rm -r /mnt/root /mnt/efi /mnt/home
# -- 首先挂载新电脑的根目录
mount /dev/sdc5 /mnt
#-- 挂载efi
mount /dev/sdc1 /mnt/boot/efi
# -- 挂载home
mount /dev/sdc6 /mnt/home
# 接下来挂载虚拟文件系统，为后面的修复做准备
mount --o bind /dev   /mnt/dev
mount --o bind /proc   /mnt/proc
mount --o bind /sys   /mnt/sys
# 将liveCD的根目录改为新电脑的根目录确保之后的操作安全。（这里也请大佬指点，是否只是安全？）
# chroot /mnt
```

接下来修改两个文件分别位于新电脑的`/etc/fstab`和`/boot/grub/grub.cfg`（不用手动修改），接下来我们再次掏出我们的表：

```bash
# -- 用nano编辑器打开/etc/fstab
nano /etc/fstab
```

按照提示，和`uuid`变化的对照表，修改`root`,`/boot/efi`,`/home`等的`uuid`

`/boot/grub/grub.cfg`这个文件是用`grub-mkconfig`自动生成的，所以不需要手动修改。

>It is automatically generated by grub-mkconfig using templates  from /etc/grub.d and settings from /etc/default/grub

然后一定要更新`grub`引导:

```bash
# -- grub安装到efi分区
grub-install /dev/sdc1
update-grub
sync #确保数据写入硬盘
#-- 退出chroot
exit
umount /mnt/*/media/ubuntu/* 
exit
reboot
```

系统重启，拔出你的`live CD`，不出意外电脑开机将会进入你备份恢复完成的新电脑。

### 问题排查

如果无法开机/开机时间过长，首先(使用 liveCD进入系统查看)确保`/etc/fstab`中的硬盘`uuid`没有写错。

使用下面命令查看问题

```bash
systemd-analyze
systemd-analyze blame
systemd-analyze critical-chain
## 以及
sudo cat /var/log/boot.log | less
```

如果之前有`swap`分区，还原的时候没有`swap`分区，修改`initramfs`配置：

```bash
sudo vim /etc/initramfs-tools/conf.d/resume
#在文件中添加一行
RESUME=none
sudo update-grub
sudo update-initramfs -u
```

以下命令在排除错误时可能用到

```bash
sudo blkid
sudo fdisk -l
sudo dmesg
```

[Ubuntu 18.04 如何添加或删除 SWAP 交换分区](https://www.sysgeek.cn/ubuntu-18-04-swap/)

[Linux系统制作Ubuntu18.04启动盘](https://blog.csdn.net/xiaoma_2018/article/details/85059930)

```bash
# 插入U盘，在Linux系统中打开终端，查看 U 盘信息：
sudo fdisk -l 
# 然后卸载掉 U 盘：
sudo umount /dev/sdb*
# U 盘格式化：
sudo mkfs.vfat /dev/sdb -I
#完成格式化后查看磁盘信息：
# 最后使用 dd 命令制作启动盘：
sudo dd if=ubuntu-18.04.1-desktop-amd64.iso of=/dev/sdb bs=10M
```

### Ubuntu系统备份2

[Ubuntu系统备份](https://zhuanlan.zhihu.com/p/51827233)

备份前可以先清理一下缓存

```bash
# 清理旧版本的软件缓存
sudo apt-get autoclean
# 清理所有软件缓存
sudo apt-get clean
# 删除系统不再使用的孤立软件
sudo apt-get autoremove
```

ubuntu 秉承一切皆文件的思想，系统备份就相当于把整个`/`（根目录）所有文件打包压缩保存

主要有两种方式备份还原：

+ `tar` 命令
+ `livecd` 模式

首先介绍下 `tar` 命令备份

```bash
# 备份前先切换到root用户，避免权限问题
sudo su
# 再切换到 /（根目录）
cd /
# 备份系统
tar -cvpzf /media/Disk/myDisk/ubuntu_backup@ $(date +%Y-%m+%d).tar.gz --exclude=/proc --exclude=/tmp --exclude=/home --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/run /
```

***

tar命令参数：

+ `-c`： 新建一个备份文档
+ `-v`： 显示详细信息
+ `-p`： 保存权限，并应用到所有文件
+ `-z`： 用 `gzip` 压缩备份文档，减小空间
+ `-f`： 指定压缩包名称（带路径），只能做最后一个参数
+ `–exclude`： 排除指定目录，不进行备份

注意，如果没有把`/home`或者`/boot`目录单独分一个区，一定不要加`–exclude=/home`或`–exclude=/boot`参数！

文件目录介绍

`/proc`：一个虚拟文件系统，系统运行的每一个进程都会自动在这个目录下面创建一个进程目录。既然是系统自动创建，也就没必要备份的必要了。
`/tmp`：一个临时文件夹，系统的一些临时文件会放在这里。
`/lost+found`：系统发生错误时（比如非法关机），可以在这里找回一些丢失文件。
`/media`：多媒体挂载点，像u盘、移动硬盘、windons分区等都会自动挂载到这个目录下。
`/mnt`：临时挂载点，你可以自己挂载一些文件系统到这里。
`/run`：系统从启动以来产生的一些信息文件。
`/home`：用户家目录，存放用户个人文件和应用程序。
`/boot`：和系统启动相关的文件，像grub相关文件都放在这里，这个目录很重要！

为了保险起见，也可以对`/home`和`/boot`备份，但是备份频率完全没必要和/分区一样高。
比如`/`分区每周备份一次，那`/home`和`/boot`完全可以一个月备份一次，因为这两个分区出问题的概率真的很小，而且变动也不会太频繁。

```bash
tar -cvpzf /media/Disk/my_Disk/ubuntu_home_backup@`date +%Y-%m-%d`.tar.gz /home
tar -cvpzf /media/Disk/myDisk/ubuntu_boot_backup@`date +%Y-%m-%d`.tar.gz /boot
```

***

打包过程中会遇到如下错误或警告信息

```bash
tar: Exiting with failure status due to previous errors 
```

这个问题其实不是真正的错误信息， 真正的错误信息混杂在标准输出(stout)中, 重新执行命令并把`v`参数去掉即可看到真正问题所在。

```bash
tar: Removing leading '/' from member names  
#或 
tar: Removing leading '/' from hard link targets 
```

这个问题其实不影响程序的执行，产生的原因是`tar`在压缩的过程中自动帮我们去掉了路径前的`/`，也就是tar压缩后的包是按照相对路径压缩的。
 当我们恢复时， 就需要通过 `-C` 参数手动指定解压到 `/` 目录， 如：

```bash
tar zxvpf ubuntu_20170120_11.tar.bz2 -C / 
```

可以使用`-P`参数来指定按照绝对路径打包：

```bash
tar -cvpzf /media/Disk/myDisk/ubuntu_backup@`date +%Y-%m+%d`.tar.gz --exclude=/proc --exclude=/tmp --exclude=/home --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/run -P /
```

另外，如果出现

```bash
tar: /dev/shm: file changed as we read it 
或 
tar: /run/udev/control: socket ignored 
```

这个 `socket ignored` 产生的原因是压缩的过程中文件正在使用，无需理会，不影响压缩。

```bash
tar: /run/user/1000/gvfs: Cannot stat: Permission denied 
```

这个问题不用理会，与虚拟文件系统有关，不影响压缩。

Ubuntu系统U盘（livecd）方式备份

启动过程中从U盘启动，采用试用Ubuntu系统的方式，进入`livecd`模式（试用ubuntu）

```bash
sudo su
fdisk -l
```

其中`boot`分区为`/dev/sda5`,`home`分区为`/dev/sda7`,主分区`/`为`/dev/sda8`。

分别进行挂载：

```bash
mount /dev/sda5 /boot
mount /dev/sda7 /home
mount /dev/sda8 /mnt
```

再对移动硬盘进行挂载：

```bash
mount /media/ubuntu/移动硬盘对应盘符 /data
```

进行备份：

```bash
mksquashfs /mnt /data/ubuntu_main.sfs(文件名任意)
mksquashfs /home /data/ubuntu_home.sfs(文件名任意)
mksquashfs /boot /data/ubuntu_boot.sfs(文件名任意)
sync(让系统保存一下数据)
```

卸载硬盘：

```bash
umount /data
umount /mnt
umount /home
umount /boot
```

到此备份成功。

### 系统还原

系统备份的意义就在于系统哪天发生意外时可以系统还原拯救回来

这里有两种还原方式，如果你系统出问题了，但是还可以进入终端，那就可以直接解压备份文件进行还原。
但是如果你连系统都不能登录了，就要使用`LiveCD`（U盘启动盘）进行还原了。

#### tar命令还原系统

```bash
# 备份前先切换到`root`用户，避免权限问题
sudo su
# 再切换到/（根目录）
cd /
# 还原
tar -xvpzf /media/Disk/myDisk/ubuntu_backup@2016-6-6.tar.gz -C /
```

注意先创建一个临时目录用于挂载你的`/`根目录分区，`sdaX`代表你的`/`根目录分区，
如果不知道就用`fdisk -l`查看一下，另外如果你的移动硬盘没有被自动挂载，你也需要手动创建一个临时目录进行挂载。

Note：
因为 tar还原是只会覆盖相同的文件，但是这种方法只是恢复备份时的文件，就是说如果某些文件丢失或损坏了，这样可以恢复修复这些文件，但不能删除自备份到恢复前这期间所生成的其它文件.
假如你备份系统时有`1234`这四个文件，如果三天后，由于某些原因变成了`1234'5`（`4`改变了），你恢复后，就会变成`12345`，其中`4'`恢复成备份时的文件，`5`保留。
所以大家要是想彻底还原成备份时候的样子最好彻底删除根目录下的所有文件，然后再还原，这样就可以还原成备份时的样子了。
删除整个文件系统，比如运行命令`rm -fr /*`，那么你还原系统后一定要把你之前没有备份的目录手动创建，不然重启系统是有问题的。

```bash
mkdir proc tmp lost+found media mnt run
```

***
进入 LiveCD 之后 还原系统

```bash
#切换到root用户
sudo su
#进入到 / 目录
cd /
mkdir /mnt/sys
mount /dev/sdaX /mnt/sys
tar -xvpzf /media/myDisk/ubuntu_boot_backup@2016-6-6.tar.gz -C /mnt/sys
```

执行恢复命令之前请再确认一下你所键入的命令是不是你想要的，执行恢复命令可能需要一段不短的时间。

恢复命令结束时，你的工作还没完成，别忘了重新创建那些在备份时被排除在外的目录：

```bash
mkdir proc
mkdir lost+found
mkdir mnt
mkdir sys
```

等等

当你重启电脑，你会发现一切东西恢复到你创建备份时的样子了！

#### livecd 还原 

还有一个稍微复杂点的`livecd`方式还原，如下：

先要对之前的启动文件和分区文件做一个备份，分别为`/etc/fstab`,`/etc/fstab.d`（可能没有）,`/boot/grub/grub.cfg`：

```bash
cp /etc/fstab /media/用户名/移动硬盘对应盘符/
cp /boot/grub/grub.cfg /media/用户名/移动硬盘对应盘符/
```

接下来进行恢复系统，同样利用系统`u`盘进入`livecd`模式。同样进入`root`模式，查看分区情况

假设分区情况如上：`/dev/sda1`为`boot`分区，`/dev/sda2`为主分区，`/dev/sda3`为`home`分区。对`home`分区和主分区进行格式化：

```bash
sudo su
mkfs.ext4 /dev/sda2 # root
mkfs.ext4 /dev/sda3 # home
```

然后分别进行挂载：

```bash
mount /dev/sda2 /mnt #挂载 root
# 新建home和boot文件:
mkdir /mnt/home 
mkdir /mnt/boot
#挂载其他两个盘：
mount /dev/sda1 /mnt/boot #挂载 boot
mount /dev/sda3 /mnt/home # 挂载 home
# 挂载数据盘：
mkdir /rescovery/mnt
mkdir /rescovery/home
mkdir /rescovery/boot
mount -o loop /media/ubuntu/移动硬盘盘符/ubuntu_main.sfs /rescovery/mnt  # 这里使用了 loop mount，循环挂载
mount -o loop /media/ubuntu/移动硬盘盘符/ubuntu_home.sfs /rescovery/home
mount -o loop /media/ubuntu/移动硬盘盘符/ubuntu_boot.sfs /rescovery/boot
```

```bash
cp -a /recovery/mnt/* /mnt
cp -a /recovery/home/* /mnt/home
cp -a /recovery/boot/* /mnt/boot
# 然后拷贝之前的fstab和grub.cfg文件到硬盘：
cp /media/ubuntu/移动硬盘盘符/fstab /mnt/etc/
cp /media/ubuntu/移动硬盘盘符/grub.cfg /mnt/boot/grub/
# 挂载虚拟文件系统，这是为了后面修复引导做准备。
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
# chroot进入已经还原的操作系统。
chroot /mnt
```

### 查看当前UUID

由于我们格式化了分区，所以`UUID`发生了变化，若不修改，系统将无法正常挂载分区，导致启动异常。
故需要修改本机系统的`UUID`设置,当前终端不要关闭，新建一个终端，输入`blkid`:

在`fstab`文件中更新上面两个新硬盘的`UUID`,在`chroot`过的端口输入：

```bash
nano /etc/fstab
# 更改两个UUID，ctrl+x退出，Y保存。进行grub的更新：
grub-install /dev/sda
update-grub
退出并卸载盘：
exit
umount /mnt/dev
umount /mnt/sys
umount /proc
sync
```

重启即可

### mount 简介

`-o --options opts`:使用指定的安装选项。 `opts`参数是用逗号分隔的列表。 例如：

```bash
mount LABEL=mydisk -o noatime,nodev,nosuid
```

复制文件：

Bind mount operation

Bind mount operation

在其他位置重新挂载文件结构的一部分。 语法是：

```bash
mount --bind olddir newdir
```

或使用以下`fstab`条目：

```bash
/olddir /newdir none bind
```

调用之后，可以在两个位置访问相同的内容。

重要的是要理解`bind`不会在`kernel VFS`中创建任何`second-class `或`special node`。 
`bind`只是`attach`文件系统的另一种操作。没有一个特定的地方去记录哪些文件系统是通过`bind`附加到系统上的。
`olddir` 和 `newdir` 是独立的，并且可以卸载`olddir`。

也可以将单个文件重新挂载（在单个文件上）。 也可以使用`bind`从常规目录创建`mountpoint`，例如：

```bash
mount --bind foo foo
```

## snap

[Ubuntu使用snap安装常用软件](https://www.jianshu.com/p/4049b97151a1)

什么是`snap`，`snap`是一种全新的软件包管理方式，它类似一个容器拥有一个应用程序所有的文件和库，各个应用程序之间完全独立。
所以使用`snap`包的好处就是它解决了应用程序之间的依赖问题，使应用程序之间更容易管理。但是由此带来的问题就是它占用更多的磁盘空间。

`Snap`的安装包扩展名是`.snap`，类似于一个容器，它包含一个应用程序需要用到的所有文件和库（`snap`包包含一个私有的`root`文件系统，里面包含了依赖的软件包）。
它们会被安装到单独的目录；各个应用程序之间相互隔离。使用`snap`有很多好处，首先它解决了软件包的依赖问题；其次，也使应用程序更容易管理。

现在支持`snap`的应用并不多，`snap`软件包一般安装在`/snap`目录下
