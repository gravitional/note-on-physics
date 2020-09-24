# ubuntu-2.md

## Ubuntu 镜像使用帮助

清华大学的源

域名选择

```bash
https://mirrors.tuna.tsinghua.edu.cn 自动选择
https://mirrors6.tuna.tsinghua.edu.cn 只解析 IPv6
https://mirrors4.tuna.tsinghua.edu.cn 只解析 IPv4
```

Ubuntu 的软件源配置文件是 `/etc/apt/sources.list`。将系统自带的该文件做个备份，将该文件替换为下面内容，即可使用 `TUNA` 的软件源镜像。

```bash
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors6.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
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

为保证完整的软件包(重)构建能顺利进行，你必须保证系统中已经安装

    build-essential 软件包；

    列于 Build-Depends 域的软件包(参看 第 4.1 节 “control”)；

    列于 Build-Depends-indep 域的软件包(参看 第 4.1 节 “control”)。

然后在源代码目录中执行以下命令:

$ dpkg-buildpackage -us -uc

这样会自动完成所有从源代码包构建二进制包的工作，包括:

    清理源代码树(debian/rules clean)

    构建源代码包(dpkg-source -b)

    构建程序(debian/rules build)

    构建二进制包(fakeroot debian/rules binary)

    制作 .dsc 文件

    用 dpkg-genchanges 命令制作 .changes 文件。

如果构建结果令人满意，那就用 debsign 命令以你的私有 GPG 密钥签署 .dsc 文件和 .changes 文件。你需要输入密码两次。 [63]

对于非本土 Debian 软件包，比如 gentoo， 构建软件包之后，你将会在上一级目录(~/gentoo) 中看到下列文件:

    gentoo_0.9.12.orig.tar.gz

    这是原始的源代码 tarball，最初由 dh_make -f ../gentoo-0.9.12.tar.gz 命令创建，它的内容与上游 tarball 相同，仅被重命名以符合 Debian 的标准。

    gentoo_0.9.12-1.dsc

    这是一个从 control 文件生成的源代码概要，可被 dpkg-source(1) 程序解包。

    gentoo_0.9.12-1.debian.tar.gz

    这个压缩的 Tar 归档包含你的 debian 目录内容。其他所有对于源代码的修改都由 quilt 补丁存储于 debian/patches 中。

    如果其他人想要重新构建你的软件包，他们可以使用以上三个文件很容易地完成。只需复制三个文件，再运行 dpkg-source -x gentoo_0.9.12-1.dsc。 [64]

    gentoo_0.9.12-1_i386.deb

    这是你的二进制包，可以使用 dpkg 程序安装或卸载它，就像其他软件包一样。

    gentoo_0.9.12-1_i386.changes

    这个文件描述了当前修订版本软件包中的全部变更，它被 Debian FTP 仓库维护程序用于安装二进制和源代码包。它是部分从 changelog 和 .dsc 文件生成的。

    随着你不断完善这个软件包，程序的行为会发生变化，也会有更多新特性添加进来。下载你软件包的人可以查看这个文件来快速找到有哪些变化，Debian 仓库维护程序还会把它的内容发表至 debian-devel-changes@lists.debian.org 邮件列表。

在上传到 Debian FTP 仓库中前，gentoo_0.9.12-1.dsc 文件和 gentoo_0.9.12-1_i386.changes 文件必须用 debsign 命令签署，其中使用你自己存放在 ~/.gnupg/ 目录中的 GPG 私钥。 用你的公钥，可以令 GPG 签名证明这些文件真的是你的。

debsign 命令可以用来以指定 ID 的 GPG 密钥进行签署 （这方便了赞助(sponsor)软件包）， 只要照着下边在 ~/.devscripts 中的内容:

DEBSIGN_KEYID=Your_GPG_keyID

.dsc 和 .changes 文件中很长的数字串是其中提及文件的 SHA1/SHA256 校验和。下载你软件包的人可以使用 sha1sum(1) 或 sha256sum(1) 来进行核对。如果校验和不符，则说明文件已被损坏或偷换

### Hostname

[What Is a Hostname? ][]

[What Is a Hostname? ]: https://www.lifewire.com/what-is-a-hostname-2625906

域名（英语:`Domain Name`），又称网域，是由一串用点分隔的名字组成的`Internet`上某一台计算机或计算机组的名称，
用于在数据传输时对计算机的定位标识（有时也指地理位置）

由于`IP`地址具有不方便记忆并且不能显示地址组织的名称和性质等缺点，人们设计出了域名，
并通过网域名称系统（`DNS`，`Domain Name System`）来将域名和`IP`地址相互映射，使人更方便地访问互联网，
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

## linux查看设备信息和驱动安装信息

[linux查看设备信息和驱动安装信息]

[linux查看设备信息和驱动安装信息]: https://blog.csdn.net/m1223853767/article/details/79615011

`lspci`是列出所有的硬件信息，包括已经安装了驱动还是没有安装驱动的硬件设备，因为根据`pci`规范，只要改设备在`pci`总线上挂着，就可以读到其`Vendor ID`和`Device ID`等一系列信息，就能知道这个设备是什么设备。

如果要确认有没有安装驱动，就需要通过`lsmod`命令来看，当然`lsmod`命令只能显示编译`linux`内核时选中为“`M`”的驱动程序，最靠谱的还是`dmesg`来查看该设备的驱动有没有安装，`dmesg`信息太多，需要grep来过滤一下。

工作中的时候总结的一些经验

1. 确定需要安装驱动的硬件型号，可以在`/etc/sysconfig/hwconf`中找到，里面列出了所有硬件的型号和生产商等信息，其中`vendorId`指的是硬件的生产商编号，`deviceId`是指该设备的编号，一般生产商和设备编号都是四位的（ `debian`系的没有`sysconfig`都在`/etc/init.d/`里面）
2. `lspci`命令可以查看当前系统中所有PCI的设备的信息，`lspci -n|grep 02:00` 可以查看`02:00`设备对应的生产商和设备编号信息，这些信息也可以在`hwconf`中找到
3. 找到了设备编号可以到`http://pci-ids.ucw.cz/iii/`查找与该设备相关的信息，可以找到设备的名字
4. 通过设备名字和型号查找设备驱动
5. 编译模块/驱动
6. `lsmod`命令可以列出当前系统中所有已经加载了的模块/驱动
7. `modinfo`命令可以单看指定的模块/驱动的信息，其中`alias`指的是这个模块/驱动所支持的硬件的型号
8. 使用`modprobe`或者`insmod`命令可以加载驱动，使用`rmmod`可以删除一个模块/驱动

在LINUX环境开发驱动程序，首先要探测到新硬件，接下来就是开发驱动程序。

常用命令整理如下:

+ 用硬件检测程序`kuduz`探测新硬件:`service kudzu start ( or restart)`
+ 查看CPU信息:`cat /proc/cpuinfo`
+ 查看板卡信息:`cat /proc/pci`
+ 查看PCI信息:`lspci` (相比`cat /proc/pci`更直观）
+ 查看内存信息:`cat /proc/meminfo`
+ 查看USB设备:`cat /proc/bus/usb/devices`
+ 查看键盘和鼠标:`cat /proc/bus/input/devices`
+ 查看系统硬盘信息和使用情况:`fdisk & disk - l & df`
+ 查看各设备的中断请求(IRQ):`cat /proc/interrupts`
+ 查看系统体系结构:`uname -a`
+ `dmidecode` 查看硬件信息，包括bios、cpu、内存等信息
+ `dmesg | less` 查看硬件信息

[Linux下/proc目录简介][]

[Linux下/proc目录简介]: https://blog.csdn.net/zdwzzu2006/article/details/7747977

Linux 内核提供了一种通过 `/proc` 文件系统，在运行时访问内核内部数据结构、改变内核设置的机制。proc文件系统是一个伪文件系统，它只存在内存当中，而不占用外存空间。它以文件系统的方式为访问系统内核数据的操作提供接口。

用户和应用程序可以通过proc得到系统的信息，并可以改变内核的某些参数。
由于系统的信息，如进程，是动态改变的，所以用户或应用程序读取proc文件时，proc文件系统是动态从系统内核读出所需信息并提交的。
下面列出的这些文件或子文件夹，并不是都是在你的系统中存在，这取决于你的内核配置和装载的模块。
另外，在`/proc`下还有三个很重要的目录:`net`，`scsi`和`sys`。 `Sys`目录是可写的，可以通过它来访问或修改内核的参数，而`net`和`scsi`则依赖于内核配置。例如，如果系统不支持`scsi`，则`scsi`目录不存在。

除了以上介绍的这些，还有的是一些以数字命名的目录，它们是进程目录。
系统中当前运行的每一个进程都有对应的一个目录在`/proc`下，以进程的 `PID`号为目录名，它们是读取进程信息的接口。
而`self`目录则是读取进程本身的信息接口，是一个`link`。

## Linux各目录含义

### FHS标准

其实，linux系统的目录都遵循一个标准，即由Linux基金会发布的 文件系统层次结构标准 (`Filesystem Hierarchy Standard`, FHS)。
这个标准里面定义了linux系统该有哪些目录，各个目录应该存放什么，起什么作用等等。具体说明如下:

目录  含义

+ `/bin`  binary，即用来存放二进制可执行文件，并且比较特殊的是`/bin`里存放的是所有一般用户都能使用的可执行文件，如:`cat`, `chmod`, `chown`, `mv`, `mkdir`, `cd` 等常用指令
+ `/boot`  存放开机时用到的引导文件
+ `/dev`  device（并不是`develop`哦），任何设备都以文件的形式存放在这个目录中
+ `/etc`  `Editable Text Configuration`（早期含义为`etcetera`，但是有争议），存放系统配置文件，如各种服务的启动配置，账号密码等
+ `/home`  用户的主目录，每当新建一个用户系统都会在这个目录下创建以该用户名为名称的目录作为该用户的主目录。并且在命令行中~代表当前用户的主目录，~yousiku表示yousiku这个用户的主目录
+ `/lib`  library，存放着系统开机时所需的函数库以及/bin和/sbin目录下的命令会调用的函数库
+ `/lib64`  存放相对于/lib中支持64位格式的函数库
+ `/media`  可移除的媒体设备，如光盘，DVD等
+ `/mnt`  `mount`，临时挂载的设备文件
+ `/opt`  `optional`，可选的软件包，即第三方软件。我们可以将除了系统自带软件之外的其他软件安装到这个目录下
+ `/proc`  `process`，该目录是一个虚拟文件系统，即该目录的内容存放于内存中而不是硬盘中，存放着系统内核以及进程的运行状态信息
+ `/root`  超级管理员root的主目录
+ `/run`  最近一次开机后所产生的各项信息，如当前的用户和正在运行中的守护进程等
+ `/sbin`  存放一些只有root账户才有权限执行的可执行文件，如init, ip, mount等命令
+ `/srv`  service，存放一些服务启动后所需的数据
+ `/sys`  system，与/proc类似也是一个虚拟文件系统，存放系统核心与硬件相关的信息
+ `/tmp`  temporary，存放临时文件，可以被所有用户访问，系统重启时会清空该目录
+ `/usr`  Unix Software Resource（并不是指user哦），存放着所有用户的绝大多数工具和应用程序（下文详细介绍）
+ `/var`  variable，存放动态文件，如系统日志，程序缓存等（下文详细介绍）

### /usr目录

`Unix Software Resource` 意为 `Unix`系统软件资源，系统自带的软件都装在这个目录下（好比Windows系统的"C:\Windows"），用户安装的第三方软件也在这个目录下（好比Windows系统的"C:\Program Files"），不同的是，在Windows系统上安装软件通常将该软件的所有文件放置在同一个目录下，但是在Linux系统安装软件会将该软件的不同文件分别放置在/usr目录下的不同子目录下，而不应该自行创建该软件自己的独立目录。进入到`/usr`目录，一般有以下子目录:

```python
[root@localhost /]# cd usr/
[root@localhost usr]# ls
bin  etc  games  include  lib  lib64  libexec  local  sbin  share  src  tmp
```

目录  含义

+ `/usr/bin`  即`/bin`，用链接文件到方式将`/bin`链接至此
+ `/usr/etc`  应用程序的配置文件
+ `/usr/games`  与游戏相关的数据
+ `/usr/include`  `c/c++`程序的头文件
+ `/usr/lib`  即`/lib`，用链接文件到方式将`/lib`链接至此
+ `/usr/lib64`  即`/lib64`，用链接文件到方式将`/lib64`链接至此
+ `/usr/libexec`  不常用的执行文件或脚本
+ `/usr/local`  应用程序的安装目录，每个应用程序目录下还会有对应的`bin`, `etc`, `lib`等目录
+ `/usr/sbin`  即`/sbin`，用链接文件到方式将`/sbin`链接至此
+ `/usr/share`  共享文件，通常是一些文字说明文件，如软件文档等
+ `/usr/src`  `source`，应用程序源代码
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

终端下输入`ibus-setup`--`Input Method`--`Chinese - intelligent pinyin`，
点击右侧的 `preference`--`user data`--`import`
把制作好的词库导入进去即可。

测试:
`亥姆霍兹方程`
`重整化群`

[iBus拼音输入法导入搜狗词库][]

[iBus拼音输入法导入搜狗词库]: https://blog.csdn.net/betabin/article/details/7798668

## 查看文件、文件夹和磁盘空间的大小

[Ubuntu下查看文件、文件夹和磁盘空间的大小][]

[Ubuntu下查看文件、文件夹和磁盘空间的大小]: https://blog.csdn.net/BigData_Mining/java/article/details/88998472

在实际使用`ubuntu`时候，经常要碰到需要查看文件以及文件夹大小的情况。
有时候，自己创建压缩文件，可以使用 `ls -hl`查看文件大小。参数`-h` 表示`Human-Readable`，使用`GB`,`MB`等易读的格式方式显示。对于文件夹的大小，`ll -h` 显示只有`4k`。

***
那么如何来查看文件夹的大小呢？

使用`du`命令查看文件或文件夹的磁盘使用空间,`–max-depth` 用于指定深入目录的层数。

如要查看当前目录已经使用总大小及当前目录下一级文件或文件夹各自使用的总空间大小，
输入`du -h --max-depth=1`即可。

如要查看当前目录已使用总大小可输入:`du -h --max-depth=0`

***

```bash
du [OPTION]... [FILE]...
du [OPTION]... --files0-from=F
```

+ `-s,` `--summarize`: display only a total for each argument
+ ` -h`, `--human-readable`: print sizes in human readable format (e.g., 1K 234M 2G)
+ `-d,` `--max-depth=N`: print the total for a directory (or file, with `--all`) only if it is N or fewer levels below the command line argument;  `--max-depth=0` is the same as `--summarize`
+ `--si`   like `-h`, but use powers of `1000` not `1024`
+ `-a,` `--all` :write counts for all files, not just directories

### 查看磁盘空间大小命令

`df`命令是linux系统以磁盘分区为单位查看文件系统，可以加上参数查看磁盘剩余空间信息，命令格式:

`df - report file system disk space usage`

***
SYNOPSIS

`df [OPTION]... [FILE]...`

+ `-a`, `--all` include pseudo, duplicate, inaccessible file systems
+ `-l`, `--local` limit listing to local file systems
+ `-h`, `--human-readable` print sizes in powers of 1024 (e.g., 1023M)
+ `-T`, `--print-type` print file system type

### 删除日志文件

```bash
sudo /dev/null > /var/log/**.log
```

下面这个推荐使用,删除30天之前的旧文件

```bash
sudo find /var/log/ -type f -mtime +30 -exec rm -f {} \;
```

***
`find` - search for files in a directory hierarchy

`find [-H] [-L] [-P] [-D debugopts] [-Olevel] [starting-point...] [expression]`

***
`expression`

The part of the command line after the list of starting points is the `expression`.  This is a kind of query specification describing how we match files  and  what we do with the files that were matched.
An expression is composed of a sequence of things: Test, Actions,...

`-exec command ;`
              Execute  command;  true if 0 status is returned.  All following arguments to find are taken to be arguments to the command until an argument consisting of
              `;' is encountered.  The string `{}' is replaced by the current file name being processed everywhere it occurs in the arguments to the command,  not  just
              in  arguments where it is alone, as in some versions of find.  Both of these constructions might need to be escaped (with a `\') or quoted to protect them
              from expansion by the shell.  See the EXAMPLES section for examples of the use of the -exec option.  The specified command is run once  for  each  matched
              file.   The  command  is executed in the starting directory.   There are unavoidable security problems surrounding use of the -exec action; you should use
              the -execdir option instead.

       -exec command {} +
              This variant of the -exec action runs the specified command on the selected files, but the command line is built by appending each selected file  name  at
              the  end;  the  total number of invocations of the command will be much less than the number of matched files.  The command line is built in much the same
              way that xargs builds its command lines.  Only one instance of `{}' is allowed within the command, and (when find is being invoked from a shell) it should
              be  quoted (for example, '{}') to protect it from interpretation by shells.  The command is executed in the starting directory.  If any invocation returns
              a non-zero value as exit status, then find returns a non-zero exit status.  If find encounters an error, this can sometimes cause an  immediate  exit,  so
              some pending commands may not be run at all.  This variant of -exec always returns true.

`-mtime n`
File's  data  was  last  modified  `n*24` hours ago.
See the comments for -atime to understand how rounding affects the interpretation of file modificationtimes

`-type c`
File is of type c:

+ `b`  block (buffered) special
+ `c`  character (unbuffered) special
+ `d`  directory
+ `p`  named pipe (FIFO)
+ `f`  regular file

### shell 换行

把换行符注释掉，如果同时想插入注释，可以用`$()`或者两个`backtick`包裹注释

```bash
emcc -o ./dist/test.html `# 目标文件` \
--shell-file ./tmp.html `# 模板文件` \
--source-map-base dist `# source map 根路径` \
-O3 `# 优化级别` \
```

## shell空白字符

[对C标准中空白字符的理解][]
[Shell中去掉文件中的换行符简单方法][]

[对C标准中空白字符的理解]: https://blog.csdn.net/boyinnju/article/details/6877087

[Shell中去掉文件中的换行符简单方法]: https://blog.csdn.net/Jerry_1126/java/article/details/85009615

### 空白字符

`C`标准库里`<ctype.h>`中声明了一个函数:

`int isspace(int c);`

该函数判断字符`c`是否为一个空白字符。

`C`标准中空白字符有六个:
空格（`' '`）、换页（`'\f'`）、换行（`'\n'`）、回车（`'\r'`）、水平制表符（`'\t'`）、垂直制表符（`'\v'`）

***
空格: ASCII码为`0x20`，而不是`0x00`。`0x00`代表空（`NULL`）

`0X00-0XFF` `16`进制一共`256`个，刚好是一个`bit`的范围。

***
回车（'\r'）效果是输出回到本行行首，结果可能会将这一行之前的输出覆盖掉，例如执行:

```bash
puts("hello world!\rxxx");
#在终端输出的是:
xxxlo world!
```

如果将上面的字符串写入文件中，例如执行:

```bash
char *s = "hello world!\rxxx";
FILE *str = fopen("t.txt","r");
fwrite(s, 16, 1, str);
```

用文本编辑器打开`t.txt`。显示的效果将由打开的编辑器所决定。
vi将`\r`用`^M`代替，而记事本就没有显示该字符。

***
换行（'\n'）
顾名思义，换行就是转到下一行输出。例如:

```bash
puts("hello\nworld!");
#在终端中将输出
hello
world!
```

但需要注意的是，终端输出要达到换行效果用“`\n`”就可以，但要在文本文件输出中达到换行效果在各个系统中有所区别。
在`*nix`系统中，每行的结尾是"`\n`"，windows中则是"`\n\r`",mac则是"`\r`"。

***
水平制表符（'\t'）

相信大家对'\t'还是比较熟悉的。一般来说，其在终端和文件中的输出显示相当于按下键盘`TAB`键效果。
一般系统中，显示水平制表符将占8列。同时水平制表符开始占据的初始位置是第`8*n`列（第一列的下标为0）。例如:

```bash
puts("0123456\txx");
puts("0123456t\txx");
```

***
垂直制表符（'\v'）

垂直制表符不常用。它的作用是让`'\v'`后面的字符从下一行开始输出，且开始的列数为“`\v`”前一个字符所在列后面一列。例如:

```bash
puts("01\v2345");
```

***
换页（'\f'）

换页符的在终端的中的效果相当于`*nix`中`clear`命令。
终端在输出`'\f'`之后内容之前，会将整个终端屏幕清空空，然后在输出内容。给人的该觉是在`clear`命令后的输出字符串。

最后我想说明一点，`\t \r, \v \f`也是控制字符，它们会控制字符的输出方式。
它们在终端输出时会有上面的表现，但如果写入文本文件，一般文本编辑器（vi或记事本）对`\t \r, \v \f`的显示是没有控制效果的。

### 删除换行符

文件中每行都以`\n`结尾，如果要去掉换行符，使用`sed`命令

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

## eval

[Shell 中eval的用法][]

[Shell 中eval的用法]: https://blog.csdn.net/luliuliu1234/article/details/80994391

```bash
eval command-line
```

其中`command-line`是在终端上键入的一条普通命令行。
然而当在它前面放上`eval`时，其结果是`shell`在执行命令行之前扫描它两次。如:

```bash
$ pipe="|"
$ eval ls $pipe wc -l
1
2
3
```

shell第1次扫描命令行时，它替换出`pipe`的值`|`，接着`eval`使它再次扫描命令行，这时shell把`|`作为管道符号了。

如果变量中包含任何需要`shell`直接在命令行中看到的字符，就可以使用eval。
命令行结束符（`;  |  &`），I/o重定向符（`< >`）和引号就属于对shell具有特殊意义的符号，必须直接出现在命令行中。

`eval echo \$$#`取得最后一个参数, 如:

```bash
$ cat last    #此处last是一个脚本文件，内容是下一行显示
$  eval echo \$$#
$ ./last one two three four

four
```

第一遍扫描后，shell把反斜杠去掉了。当shell再次扫描该行时，它替换了`$4`的值，并执行echo命令

***
以下示意如何用`eval`命令创建指向变量的“指针”:

```bash
x=100
ptrx=x
eval echo \$$ptrx  #指向 ptrx，用这里的方法可以理解上面的例子
eval $ptrx=50 #将 50 存到 ptrx 指向的变量中。
echo $x
```

```bash
# ptrx 指向x
echo $ptrx
x
# \$ 转义之后，再跟 x 连成一个字符串
echo \$$ptrx
$x
# eval 执行两次扫描，所以相当于 echo $x
eval echo \$$ptrx
```

### chmod

chmod - change file mode bits

SYNOPSIS

`chmod [OPTION]... MODE[,MODE]... FILE...`
`chmod [OPTION]... OCTAL-MODE FILE...`
`chmod [OPTION]... --reference=RFILE FILE...`

DESCRIPTION

chmod 后面可以接符号表示新的权限，也可以接一个octal number --表示新的mode bits。

符号mode的格式一般是`[ugoa...][[-+=][perms...]...]`，`perms`一般是`0`，或者`rwxXst`中的多个字符，
或者`ugo`中的一个字符。多种符号mode可以给出，用逗号隔开。

`ugoa`表示控制特定用户访问权限:

+ u:the user who owns it
+ g:other users in the file's group
+ o:other users not in the file's group
+ a:all  users
如果没有给出，默认就是 a，but bits that are set in the umask are not affected.

operator `+`添加权限，`-`删除权限，`=`设置为`xxx`，except that a directory's unmentioned set user and group ID bits are not affected.

`rwxXst`表示mode bits，read (r), write (w), execute (or  search  for directories)  (x)，
execute/search  only if the file is a directory or already has execute permission for some user (X),
set user or group ID on execution (s), restricted deletion flag or sticky bit (t)

或者指定`ugo`中的一个，
the permissions granted to the user who owns the file (u),
 the permissions granted to other users who are members of the file's group (g),
 and the permissions granted to users that are in neither of the two preceding categories (o).

***
数字模式

数字mode 是1到4个 octal digits（0-7），derived by adding up the bits with values 4, 2, and 1.

省略的数字被认为是前置的`0`。

第一位数字选择用户组
the set user ID (4) and
set group  ID(2)  and
restricted deletion or sticky (1) attributes.

第二位数字选择权限
read (4), write (2), and execute (1);

第三位数字设定组中其他用户的权限

第四位数字设定不在组中用户的权限

## Mathematica

### linux mathematica 单个前端

定义一个别名，用`singleLaunch`选项

`alias mma='mathematica -singleLaunch'`

`-singleLaunch [file]`

Allows only one copy of the front end to exist per DISPLAY setting and directs the first instance of the front end to open file.

### 卸载 Mathematica

Linux

如要卸载 Mathematica，需删除下列目录。请备份这些目录下任何需要保存的文件:

+ `/usr/local/Wolfram/Mathematica/`
+ `/usr/share/Mathematica/`
+ `~/.Mathematica/`
+ `~/.Wolfram/`
+ `~/.cache/Wolfram/`

命令行下运行wolframscript脚本出错，是因为

`~/.config/Wolfram/WolframScript/WolframScript.conf `中的wolfram环境变量影响了 `wolframscript` 的运行，清除失效的路径就可以了

## formfactor 脚本

### 复制结果的脚本

```bash
#!/usr/bin/env python3
import os,shutil,time,gfm
# 复制到论文中的都是 ci==1.50 的结果
user_name='tom'
# 配置计算结果目录，论文目录，论文压缩文件目录
originpath=os.getcwd()
result_path=os.path.join(originpath,'expression-results/')
paper_path=os.path.join('/home',user_name,'private','paper-2.prd/')
desk_path=os.path.join('/home',user_name,'Desktop','paper.ff/')
# 复制计算结果到论文目录
shutil.copy(os.path.join(result_path,'fig.baryons.ge.charge.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig4.pdf'))
shutil.copy(os.path.join(result_path,'fig.baryons.ge.neutral.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig5.pdf'))
shutil.copy(os.path.join(result_path,'fig.baryons.gm.charge.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig2.pdf'))
shutil.copy(os.path.join(result_path,'fig.baryons.gm.neutral.L-0.90.ci-1.50.pdf'),os.path.join(paper_path,'fig3.pdf'))
# cd 到论文目录，重新编译论文
os.chdir(paper_path)
# 清除之前的编译结果，重新编译
os.system('latexmk -C')
os.system('./build.sh')
# 如果桌面有压缩文件目录，就删除，shutil.copytree需要目标不存在
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

Linux是一个多用户多任务的操作系统，可以在Linux中为不同的用户设置不同的运行环境，具体做法是设置不同用户的环境变量。

### Linux环境变量分类

***
按照生命周期来分，Linux环境变量可以分为两类:

1. 永久的:需要用户修改相关的配置文件，变量永久生效。
2. 临时的:用户利用`export`命令，在当前终端下声明环境变量，关闭Shell终端失效。

***
按照作用域来分，Linux环境变量可以分为:

1. 系统环境变量:系统环境变量对该系统中所有用户都有效。
2. 用户环境变量:顾名思义，这种类型的环境变量只对特定的用户有效。

### Linux设置环境变量的方法

1. 在`/etc/profile`文件中添加变量 对所有用户生效（永久的）

用`vim`在文件`/etc/profile`文件中增加变量，该变量将会对`Linux`下所有用户有效，并且是“永久的”。
例如:编辑`/etc/profile`文件，添加`CLASSPATH`变量

```bash
vim /etc/profile
export CLASSPATH=./JAVA_HOME/lib;$JAVA_HOME/jre/lib
```

要想马上生效，运行`source /etc/profile`，不然只能在下次重进此用户时生效。

2. 在用户目录下的`~/.bashrc`文件中增加变量 [对单一用户生效（永久的）]

用`vim ~/.bashrc`文件中增加变量，改变量仅会对当前用户有效，并且是“永久的”。

```bash
vim ~/.bashrc
export CLASSPATH=./JAVA_HOME/lib;$JAVA_HOME/jre/lib
```

1. 直接运行`export`命令定义变量 [只对当前shell（BASH）有效（临时的）]

在shell的命令行下直接使用`export 变量名=变量值`

定义变量，该变量只在当前的shell（BASH）或其子shell（BASH）下是有效的，
shell关闭了，变量也就失效了，再打开新shell时就没有这个变量，需要使用的话还需要重新定义。

### Linux环境变量使用

Linux中常见的环境变量有:

***
PATH:指定命令的搜索路径

PATH声明用法:

```bash
export PATH=$PAHT:<PATH 1>:<PATH 2>:<PATH 3>:--------:< PATH n >
```

你可以自己加上指定的路径，中间用冒号隔开。环境变量更改后，在用户下次登陆时生效。

可以利用`echo $PATH`查看当前当前系统PATH路径。

    HOME:指定用户的主工作目录（即用户登陆到Linux系统中时，默认的目录）。
    HISTSIZE:指保存历史命令记录的条数。
    LOGNAME:指当前用户的登录名。
    HOSTNAME:指主机的名称，许多应用程序如果要用到主机名的话，通常是从这个环境变量中来取得的
    SHELL:指当前用户用的是哪种Shell。
    LANG/LANGUGE:和语言相关的环境变量，使用多种语言的用户可以修改此环境变量。
    MAIL:指当前用户的邮件存放目录。

注意:上述变量的名字并不固定，如HOSTNAME在某些Linux系统中可能设置成HOST

2. Linux也提供了修改和查看环境变量的命令，下面通过几个实例来说明:

+ `echo`  显示某个环境变量值 `echo $PATH`
+ `export`  设置一个新的环境变量 `export HELLO="hello"` (可以无引号)
+ `env`  显示所有环境变量
+ `set`  显示本地定义的`shell`变量
+ `unset`  清除环境变量 `unset HELLO`
+ `readonly`  设置只读环境变量 `readonly HELLO`

3. C程序调用环境变量函数

+ `getenv()` 返回一个环境变量。
+ `setenv()` 设置一个环境变量。
+ `unsetenv()` 清除一个环境变量。

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

`grub2-mkconfig`是根据`/etc/default/grub`文件来创建配置文件的。
该文件中定义的是`grub`的全局宏，修改内置的宏可以快速生成`grub`配置文件。实际上在`/etc/grub.d/`目录下还有一些`grub`配置脚本，这些shell脚本读取一些脚本配置文件(如`/etc/default/grub`)，根据指定的逻辑生成`grub`配置文件。
若有兴趣，不放读一读`/etc/grub.d/10_linux`文件，它指导了创建`grub.cfg`的细节，例如如何生成启动菜单。

```bash
[root@xuexi ~]# ls /etc/grub.d/
00_header  00_tuned  01_users  10_linux  20_linux_xen  20_ppc_terminfo  30_os-prober  40_custom  41_custom  README
```

在`/etc/default/grub`中，使用`key=vaule`的格式，`key`全部为大小字母，如果`vaule`部分包含了空格或其他特殊字符，则需要使用引号包围。

例如，下面是一个`/etc/default/grub`文件的示例:

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

虽然可用的宏较多，但可能用的上的就几个:
`GRUB_DEFAULT`、`GRUB_TIMEOUT`、`GRUB_CMDLINE_LINUX`和`GRUB_CMDLINE_LINUX_DEFAULT`。

以下列出了部分key。

***
`GRUB_DEFAULT`

默认的菜单项，默认值为`0`。其值可为数值`N`，表示从`0`开始计算的第`N`项是默认菜单，也可以指定对应的`title`表示该项为默认的菜单项。
使用数值比较好，因为使用的`title`可能包含了容易改变的设备名。例如有如下菜单项

```grub
menuentry 'Example GNU/Linux distribution' --class gnu-linux --id example-gnu-linux {
    ...
}
```

如果想将此菜单设为默认菜单，则可设置`GRUB_DEFAULT=example-gnu-linux`。

如果`GRUB_DEFAULT`的值设置为`saved`，则表示默认的菜单项是`GRUB_SAVEDEFAULT`或`grub-set-default`所指定的菜单项。

## ibus下定制自己的libpinyin

[ibus下定制自己的libpinyin][]

[ibus下定制自己的libpinyin]: https://blog.csdn.net/godbreak/article/details/9031887

智能拼音输入法从`ibus-pinyin`更名为`ibus-libpinyin`

`libpinyin`添加了词库导入功能，并刚刚修复相关`bug`，所以要先更新`libpinyin`到最新版。
在`libpinyin`的配置界面（可以从`语言选项`---`输入源`找到，实在找不到，`/usr/share/ibus-libpinyin/setup/main2.py`），可以找到**用户数据导入选项**。

这个要求文件:

1. 文件采用本地编码格式
2. 格式为每行`字符 拼音 位置(可选)`，且字符数和拼音数要对应，例如`你好 ni'hao 5`。

去搜狗词库下搜狗细胞词库文件，然后下个**深蓝词库转换器**（`exe`），`wine`中打开转换器，选择从搜狗细胞词库转换到手机`QQ`格式，转换结束后不要选择文件保存本地，编码格式不大对，在输出框里面全选复制粘贴到你的文本编辑器，保存为`.txt`后缀。
然后在`libpinyin`配置界面导入即可。导入完成后，`kill ibus-engine-libpinyin`进程，再切回拼音输入法。

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

`Ubuntu 18.04 Server` 安装好后，Netplan 的默认描述文件是:`/etc/netplan/50-cloud-init.yaml`.

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
IP地址为`130.39.37.100`，
网络地址为`130.39.0.0`,
子网地址为`130.39.37.0`,
子网掩码为`255.255.255.0`，
网络地址部分和子网标识部分对应`1`，host部分对应`0`。
使用CIDR表示为:`130.39.37.100/24`即`IP地址/ 掩码长度`。

`ipv4`是`8bit.8bit.8bit.8bit`的形式，二进制到十六进制是`4`位到`1`位，`8bit`相当于两个`16`进制数字。
所以`ipv4`是四段地址:`0x0x.0x0x.0x0x.0x0x`，每段两个`16`进制数字。
`24`表示掩码开头有`24`个`1`，对应地址中的`3`段，也就是公网地址是`3`段。

`awk`执行按位**与**操作。

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

AB在同一局域网，C位于外网。

三个表:

+ `ARP`表:主机维护，存放`IP`地址和`MAC`地址对应关系。
+ `MAC`地址表:交换机维护，存放`MAC`地址和交换机端口对应关系。
+ 路由表:路由器维护，存放`IP`地址和路由器端口对应关系。

首先`AB`通信，
例如`A`要给`B`发送一个数据包，目前`A`知道`B`的`IP`地址，根据掩码规则判定`B`和自己在同一个局域网，同一个广播域。

接下来`A`通过广播方式获取`B`的`MAC`地址，添加到自己的`ARP`表中。
然后把要发送的包封装，然后发送给交换机，交换机收到数据包后解封装得到`B`的`MAC`地址，
根据`MAC`地址表转发到`B`所连接的交换机端口，完成发送。

如果`A`要和`C`通信，发送一个包给`C`的话，也只知道`C`的`IP`地址，然后`A`根据掩码规则发现`C`和自己不是同一个局域网的，
广播不到`C`，所以`A`只能把数据包发给网关，由网关发出去给到`C`。

`A`同样通过广播方式获取网关的`MAC`地址，然后把`C`的`IP`地址和网关的`MAC`地址封装到数据包后发给交换机，
交换机解封装后对比`MAC`地址表，发现是发给网关的包，就转发到网关即路由器所在的交换机端口。
路由器收到包之后再解封装，得到`C`的`IP`地址，然后根据自己的路由表转发到相应的端口。完成通信。

所以如果计算机上不设置子网掩码，从第一步就不能完成，下面就更不能继续了。
如果同一个广播域里有机器设置不同的子网掩码，依然能够通信，只不过有的内网包需要到网关绕一圈。

外网包的话只要网关设置对了就没问题。

## xelatex 脚本

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

# 默认文件名是 main，否则使用文件夹中的tex文件名
tex_usual="main"
echo "tex_usual $nameis $tex_usual"
eval  $delimiter

# 当前tex文件列表，去掉后缀

tex_list=$(ls -x *.tex)
echo "tex_list $nameis $tex_list"

tex_here=${tex_list//".tex"/}
echo "tex_here $nameis $tex_here"
eval  $delimiter

# 判断当前tex文件列表中是否包含 main.tex
# 若有 main.tex，使用之，若没有，则使用 列表中的tex
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

# 把下面这行加入到 ~/.latexmkrc，指定 pdf 查看程序
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

默认情况下，`echo`关闭了对转义字符的解释，添加 `-e `参数可打开`echo`对转义字符的解释功能。`-E`关闭转义字符，是默认值。

```bash
echo -e "hello\n wrold" #换行输出 hello world
echo -E "hello\n wrold" #输出 hello\n world， 默认情况
```

## texlive

`tlmgr [option]... action [option]... [operand]...`

安装好 texlive 后

如果使用`tlmgr option` 报错
`cannot setup TLPDB in /home/USER/texmf at /usr/bin/tlmgr line 5308.`

原因如下:

this error is generated when `tlmgr` was not initialized. In most cases, launching the following command (as a normal user) solves the problem :

`$ tlmgr init-usertree`

This command will create few folders inside your home directory. See the man page for explanation :

>Before using `tlmgr` in user mode, you have to set up the user tree with the `init-usertree` action.
>This creates `usertree/web2c` and `usertree/tlpkg/tlpobj`, and a minimal `usertree/tlpkg/texlive.tlpdb`.
> At that point, you can tell `tlmgr` to do the (supported) actions by adding the `--usermode` command line option.

***
下面这些是`tlmgr`的常用命令:

+ `tlmgr option repository ctan`
+ `tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet`

如果要使用清华的`mirror`:

`tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet`

Tell "tlmgr" to use a nearby CTAN mirror for future updates; useful if you installed TeX Live from the DVD image and want to have continuing updates.
The two commands are equivalent; "ctan" is just an alias for the given url.  Caveat: "mirror.ctan.org" resolves to many different hosts, and they are not perfectly synchronized; we recommend updating only daily (at most), and not more often.

+ `tlmgr update --list` Report what would be updated without actually updating anything.
+ `tlmgr update --all` Make your local TeX installation correspond to what is in the package repository (typically useful when updating from CTAN).
+ `tlmgr info" what` Display detailed information about a package what, such as the installation status and description, of searches for what in all packages.

### Actions

***
`install [option]... pkg...`

Install each `pkg` given on the command line, if it is not already installed.
(It does not touch existing packages; see the "update" action for how to get the latest version of a package.)

By default this also installs all packages on which the given pkgs are dependent.  Options:

--dry-run

Nothing is actually installed; instead, the actions to be performed are written to the terminal.

--file

Instead of fetching a package from the installation repository, use the package files given on the command line.  These files must be standard TeX Live package files (with contained tlpobj file).

--force

If updates to "tlmgr" itself (or other parts of the basic infrastructure) are present, "tlmgr" will bail out and not perform the installation unless this option is given.  Not recommended.

 --no-depends

Do not install dependencies.  (By default, installing a package ensures that all dependencies of this package are fulfilled.)

--no-depends-at-all

Normally, when you install a package which ships binary files the respective binary package will also be installed.
That is, for a package "foo", the package "foo.i386-linux" will also be installed on an "i386-linux" system.  This option suppresses this behavior, and also implies "--no-depends".
Don't use it unless you are sure of what you are doing.

--reinstall

Reinstall a package (including dependencies for collections) even if it already seems to be installed (i.e, is present in the TLPDB).
This is useful to recover from accidental removal of files in the hierarchy.

***
`conf [texmf|tlmgr|updmap [--conffile file] [--delete] [key [value]]]`
`conf auxtrees [--conffile file] [show|add|delete] [value]`

With only "conf", show general configuration information for TeX Live, including active configuration files, path settings, and more.  This is like running "texconfig conf", but works on all supported platforms.

With one of "conf texmf", "conf tlmgr", or "conf updmap", shows all key/value pairs (i.e., all settings) as saved in "ROOT/texmf.cnf", the user-specific "tlmgr" configuration file (see below), or the first found (via "kpsewhich") "updmap.cfg" file, respectively.

The "PATH" value shown by "conf" is as used by "tlmgr".  The directory in which the "tlmgr" executable is found is automatically prepended to the PATH value inherited from the environment.

Here is a practical example of changing configuration values. If the execution of (some or all) system commands via "\write18" was left enabled during installation, you can disable it afterwards:

`tlmgr conf texmf shell_escape 0`

The subcommand "auxtrees" allows adding and removing arbitrary additional texmf trees, completely under user control.  "auxtrees show" shows the list of additional trees, "auxtrees add" tree adds a tree to the list, and "auxtrees remove" tree removes a tree from the list (if present).

The trees should not contain an "ls-R" file (or files might not be found if the "ls-R" becomes stale). This works by manipulating the Kpathsea variable "TEXMFAUXTREES", in "ROOT/texmf.cnf". Example:

tlmgr conf auxtrees add /quick/test/tree
tlmgr conf auxtrees remove /quick/test/tree

In all cases the configuration file can be explicitly specified via the option "--conffile" file, if desired.

Warning: The general facility for changing configuration values is here, but tinkering with settings in this way is strongly discouraged.  Again, no error checking on either keys or values is done, so any sort of breakage is possible.

### texlive安装与卸载

***
[Linux环境下LaTex的安装与卸载][]
[Ubuntu Texlive 2019 安装与环境配置][]
[TexLive 2019 安装指南][]

[Linux环境下LaTex的安装与卸载]: https://blog.csdn.net/l2563898960/article/details/86774599

[Ubuntu Texlive 2019 安装与环境配置]: https://blog.csdn.net/williamyi96/java/article/details/90732304

[TexLive 2019 安装指南]: https://zhuanlan.zhihu.com/p/64530166

***
准备工作:下载，清除

注意:安装 lyx, apt 会默认安装 tex2017版本，覆盖掉新版的texlive2020

注意:如果重新安装，请务必完全删除之前的失败安装，默认情况下，这将在这两个目录中:

```bash
rm -rf /usr/local/texlive/2020
rm -rf ~/.texlive2020
```

或者参考下面的命令

```bash
rm -rf /usr/local/texlive/2020
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

因为下载好的是一个`iso`镜像文件，所以下载好之后，还需要挂载到`/mnt`目录下

```bash
sudo mount -o ro,loop,noauto texlive2020-20200406.iso /mnt
```

+ `ro` :     Mount the filesystem read-only.
+ `loop` : loop 文件
+ `auto` :   Can be mounted with the -a option.
+ `noauto` : Can only be mounted explicitly (i.e., the  -a  option  will  not cause the filesystem to be mounted).

***
接着运行`install-tl`脚本进行安装。

```bash
cd /tex_iso_directory
sudo ./install-tl --profile installation.profile
[... messages omitted ...]
Enter command: i
[... when done, see below for post-install ...]
```

若要更改安装目录或其他选项，请阅读提示和说明。

安装程序的接口:文本，GUI，批处理
安装程序支持:文本，图形，和批处理接口。（Linux系统下没有图像安装，在Windows下支持图形安装）

`install-tl -gui text #`使用简单文本模式。也是输入`install-tl`默认选项。

`install-tl --profile=profile #`进行一个批处理安装，需要一个 `profile` （配置文件），为了创建一个`profile`，最简单的方式是使用`tlpkg/texlive.profile`文件，这是安装器在安装成功后生成的文件。

***
卸载镜像文件

```bash
sudo umount /mnt
```

***
字体配置

```bash
sudo cp /usr/local/texlive/2020/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/20-texlive.conf
sudo fc-cache -fsv
```

***
环境变量

安装完之后有提示:

Add /usr/local/texlive/2020/texmf-dist/doc/man to MANPATH.
Add /usr/local/texlive/2020/texmf-dist/doc/info to INFOPATH.
Most importantly, add /usr/local/texlive/2020/bin/x86_64-linux
to your PATH for current and future sessions.

`~/.bashrc` 和 `~/.profile` 中均添加如下语句:

```bash
export MANPATH=${MANPATH}:/usr/local/texlive/2020/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/usr/local/texlive/2020/texmf-dist/doc/info
export PATH=${PATH}:/usr/local/texlive/2020/bin/x86_64-linux
```

或者在命令行下面运行:
配置普通用户的环境变量

因为你一般是在普通用户下使用 `TeX Live`，所以还需要切换到普通用户下，配置一下环境变量。运行以下命令。
在当前终端中，输入 `Ctrl + D`，退出 root 身份。
在当前终端下，输入以下命令:

```bash
echo "export MANPATH=${MANPATH}:/usr/local/texlive/2020/texmf-dist/doc/man" >> ~/.bashrc
echo "export INFOPATH=${INFOPATH}:/usr/local/texlive/2020/texmf-dist/doc/info" >> ~/.bashrc
echo "export PATH=${PATH}:/usr/local/texlive/2020/bin/x86_64-linux" >> ~/.bashrc
source ~/.bashrc # 令 bashrc 生效
```

如果使用的是`zsh`，要把相应的` ~/.bashrc` 改成 `~/.zshrc`

```bash
echo "export MANPATH=${MANPATH}:/usr/local/texlive/2020/texmf-dist/doc/man" >> ~/.zshrc
echo "export INFOPATH=${INFOPATH}:/usr/local/texlive/2020/texmf-dist/doc/info" >> ~/.zshrc
echo "export PATH=${PATH}:/usr/local/texlive/2020/bin/x86_64-linux" >> ~/.zshrc
source ~/.zshrc # 令 zshrc 生效
```

***
验证安装是否成功

```bash
tex -v
```

## loop 设备

loop 设备 (循环设备)

[loop 设备 (循环设备)][]

[loop 设备 (循环设备)]: https://blog.csdn.net/neiloid/article/details/8150629?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param

### loop 设备介绍

在类 UNIX 系统里，loop 设备是一种伪设备(pseudo-device)，或者也可以说是仿真设备。它能使我们像块设备一样访问一个文件。

在使用之前，一个 loop 设备必须要和一个文件进行连接。这种结合方式给用户提供了一个替代块特殊文件的接口。因此，如果这个文件包含有一个完整的文件系统，那么这个文件就可以像一个磁盘设备一样被 mount 起来。

上面说的文件格式，我们经常见到的是 CD 或 DVD 的 ISO 光盘镜像文件或者是软盘(硬盘)的 *.img 镜像文件。通过这种 loop mount (回环mount)的方式，这些镜像文件就可以被 mount 到当前文件系统的一个目录下。

至此，顺便可以再理解一下 loop 之含义:对于第一层文件系统，它直接安装在我们计算机的物理设备之上；而对于这种被 mount 起来的镜像文件(它也包含有文件系统)，它是建立在第一层文件系统之上，这样看来，它就像是在第一层文件系统之上再绕了一圈的文件系统，所以称为 loop。

在 Linux 里，loop 设备的设备名形如:

```bash
ls /dev/loop*
/dev/loop0  /dev/loop2  /dev/loop4  /dev/loop6
/dev/loop1  /dev/loop3  /dev/loop5  /dev/loop7
... ...
```

例如，要在一个目录下 mount 一个包含有磁盘镜像的文件，需要分 2 步走:

```bash
losetup /dev/loop0 disk.img           #使磁盘镜像文件与循环设备连结起来
mount /dev/loop0 /home/groad/disk_test   #将循环设备 mount 到目录 disk_test 下
```

经过上面的两个命令后，镜像文件就如同一个文件系统挂载在 `disk_test` 目录下，当然我们也可以往镜像里面添加文件。

其实上面的两个步骤可以写成一个步骤:

```bash
mount -t minix -o loop ./disk.img ./disk_test
```

## latex

### jabref

[JabRef中文手册][]

[JabRef中文手册]: https://blog.csdn.net/zd0303/article/details/7676807

题录时间戳

本功能可以在`选项->偏好设置->通用设置`中关闭或配置。

JabRef能自动的产生一个包含题录加入数据库的日期的域。

Formatting

The formatting of the time stamp is determined by a string containing designator words that indicate the position of the various parts of the date.

These are some of the available designator letters (examples are given in parentheses for Wednesday 14th of September 2005 at 5.45 PM):

    yy: year (05)

    yyyy: year (2005)

    MM: month (09)

    dd: day in month (14)

    HH: hour in day (17)

    mm: minute in hour (45)

These designators can be combined along with punctuation and whitespace. A couple of examples:

    yyyy.MM.dd gives 2005.09.14

    yy.MM.dd gives 05.09.14

    yyyy.MM.dd HH:mm gives 2005.09.14 17:45

### lyx 默认pdf查看

在`tools-preferences-File Handling-File Formats`

在 `Format` 一栏中选中`PDF(XeTex)`  或者其他想要更改的格式，然后在 `Viewer`中更改程序，或者自定义程序位置。

### 手动编译lyx

***
如果是后安装的`texlive`, `lyx` 需要运行 `tools-reconfigure` 进行配置

***
[compiling-lyx-2-2-on-debian][]

[compiling-lyx-2-2-on-debian]: https://unix.stackexchange.com/questions/321039/compiling-lyx-2-2-on-debian

编译的时候报错，`cannot compile a simple Qt executable. Check you have the right $QTDIR`.

`QTDIR` shouldn't really be necessary, but try setting it to `/usr/share/qt5`.

解决方法:

You could build the Debian source package instead:

```bash
sudo apt-get install devscripts dpkg-dev build-essential
sudo apt-get build-dep lyx
dget http://httpredir.debian.org/debian/pool/main/l/lyx/lyx_2.3.2-1.dsc
cd lyx-2.2.0
dpkg-buildpackage -us -uc
```

The first two commands install the packages necessary to build `lyx`;
then `dget` downloads and extracts the source package,
and `dpkg-buildpackage` builds it and produces a series of `.deb` packages
you can install manually using `dpkg` as usual.

***
代码解释

`build-dep `causes `apt-get` to install/remove packages in an attempt to satisfy the build dependencies for a source package.

By default the dependencies are satisfied to build the package natively

这样的话需要在 source.list 中添加软件源代码的源，即以 deb src 开头的行。

`gpg`

Your issue is you have not imported our public key into your keyring. You skipped a step.

***
`tar --one-top-level -xJvf  lyx`

`-J, --xz`

Filter the archive through xz(1).

`--one-top-level[=DIR]`

Extract all files into DIR, or, if used without argument, into a subdirectory named by the base name of the archive (minus standard  compression  suffixes recognizable by --auto-compress).

***
`dpkg-buildpackage -us -uc`

-us, --unsigned-source
Do not sign the source package (long option since dpkg 1.18.8).

uc, --unsigned-changes
Do not sign the .buildinfo and .changes files (long option since dpkg 1.18.8).

***
Compiling and installing LyX

Quick compilation guide

These four steps will compile, test and install LyX:

1. Linux users beware: You need `qt4/5` and `qt4/5-devel` packages of the same version to compile LyX.
In general, it is also recommended to have `pkg-config`installed (the name might vary depending on your distribution).

1. `./configure` configures LyX according to your system.
You may have to set `--with-qt-dir=<path-to-your-qt-installation>` (for example, "`--with-qt-dir=/usr/share/qt4/`") if the environment variable `QTDIR` is not set and `pkg-config` is not available.
You will need `--enable-qt5` switch for choosing qt5 over qt4.
See Note below if `./configure` script is not present.

`./configure --enable-qt5`

1. `make`   compiles the program.
1. `src/lyx`    runs the program so you can check it out.
1. `make install` will install it. You can use "`make install-strip`" instead if you want a smaller binary.

### lyx 文档类错误

`~/.lyx/textclass.lst` 中的条目格式有问题，如

`"IEEEtran-CompSoc"` 变成了 `"b'IEEEtran-CompSoc'"`

python中字节字符串不能格式化。
获取到的网页有时候是字节字符串，需要转化后再解析。

bytes 转 string 方式:

```python
>>>b=b'\xe4\xba\xba\xe7\x94\x9f\xe8\x8b\xa6\xe7\x9f\xad\xef\xbc\x8c\xe6\x88\x91\xe8\xa6\x81\xe7\x94\xa8python'
>>>string=str(b,'utf-8')
>>>string
## 或者
>>>b=b'\xe4\xba\xba\xe7\x94\x9f\xe8\x8b\xa6\xe7\x9f\xad\xef\xbc\x8c\xe6\x88\x91\xe8\xa6\x81\xe7\x94\xa8python'
>>>string=b.decode()
'人生苦短，我要用python'
```

[python基础之string与bytes的转换]

[python基础之string与bytes的转换]: https://blog.csdn.net/Panda996/java/article/details/84780377

### latexmk 选项

一般来说， `latexmk` 的通用`cmd`命令形式为:

`latexmk [options] [file]`

所有的选项可以用单个`-`连字符，也可以用双连字符`--`引入，e.g., "latexmk -help" or "latexmk --help".

***
注意:

除了文档里列出的选项， `latexmk`认识几乎所有the options recognized by the latex, pdflatex programs (and their relatives),
在当前的 TexLive and MikTeX 发行版中。

这些程序的一些选项还会引起 latexmk 的特殊 action or behavior，在本文档中有解释。否则，它们被直接传递给latex or pdflatex。
run `latexmk -showextraoptions`给出选项列表，这些选项被直接传递给latex or pdflatex。

***
注意:

"Further processing" 意味着需要运行其他程序，或者再次运行`latex`(etc)，如果没有 `errors` 的话。
如果你不想让`latex`在遇到错误的时候停下，应该使用 latexmk's option `-interaction=nonstopmode`

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

### tex的TDS

latex 组织文件的规范叫做 TDS-compliant

a standard `TeX Directory Structure` (TDS): a directory hierarchy for macros, fonts, and the other implementation-independent TeX system files.

#### TDS 特征

The common properties throughout the TDS tree.

+ Subdirectory searching
+ Rooting the tree
+ Local additions
+ Duplicate filenames

***
子目录搜索

Technical Working Group (TWG) 要求，一个综合的TDS 需要支持 implicit subdirectory searching。

更精确地说，具体实现要满足，在寻找输入文件（TeX，Metafont and their companion utilities ）的时候，能够指定具体路径，也能够递归地遍历所有的子文件夹。

***
tree的根目录

我们把TDS的根目录称为`texmf`(TeX and Metafont)，意思是，这个目录包含了一个完整TeX 系统附属的文件(including Metafont, MetaPost, BibTeX, etc.)，而不是只有单独的 TeX 自己。

***
Local additions

TDS 不能精确地指出，哪些包是"local addition"。

One common case of local additions is dynamically generated files, e.g., PK fonts by the mktexpk script (which originated in Dvips as MakeTeXPK). A site may store the generated files directly in any of:

+ their standard location in the main TDS tree (if it can be made globally writable);
+ an alternative location in the main TDS tree (for example, under texmf/fonts/tmp);
+ a second complete TDS tree (as outlined above);
+ any other convenient directory (perhaps under /var, for example /var/spool/fonts).

***
重复文件名

TDS tree 中的文件可能有相同的文件名。默认并不进一步区分，但TDS要求满足以下例外:

Names of TeX input files must be unique within each first-level subdirectory of `texmf/tex` and `texmf/tex/generic`, but not within all of `texmf/tex`; 比如, different TeX formats may have files by the same name.

所以具体实现必须提供**格式依赖**的路径指定方式。

#### TDS顶层目录

texmf root 下面包含了 TeX system 的主要成员
The top-level directories specified by the TDS are:

+ `tex` for TeX files (Section Macros).
+ `fonts` for font-related files (Section Fonts).
+ `metafont` for Metafont files which are not fonts (Section Non-font Metafont files).
+ `metapost` for MetaPost files (Section MetaPost).
+ `bibtex` for BibTeX files (Section BibTeX).
+ `scripts` for platform-independent executables (Section Scripts).
+ `doc` for user documentation (Section Documentation).
+ `source` for sources. This includes both traditional program sources (for example, Web2C sources go in texmf/source/web2c) and, e.g., LaTeX dtx sources (which go in texmf/source/latex). The TDS leaves unspecified any structure under source.
+ `implementation` for implementations (examples: `emtex`, `vtex`, `web2c`), to be used for whatever purpose deemed suitable by the implementor or TeX administrator.
That is, files that cannot be shared between implementations, such as pool files (tex.pool) and memory dump files (plain.fmt) go here, in addition to implementation-wide configuration files.
+ `program` for program-specific input and configuration files for any TeX-related programs (examples: `mft`, `dvips`). In fact, the `tex`, `metafont`, `metapost`, and `bibtex` items above may all be seen as instances of this case.

### 安装latex包

[Ubuntu/Mint下LaTeX宏包安装及更新][]

[Ubuntu/Mint下LaTeX宏包安装及更新]: https://blog.csdn.net/codeforces_sphinx/article/details/7315044

一般使用texlive的包管理工具，否则需要手动安装:

1. Get the package from [CTAN](http://www.ctan.org/CTAN) or wherever.
2. 如果其中有一个文件是`.ins` 结尾的，打开终端，执行命令`latex foiltex.ins`，就获得了安装需要的包。大多数 latex 包没有打包，所以可以跳过这一步。
3. 现在你需要决定，这个包要安装给所有用户使用，还是only for you。
4. 在*nix 系统上（OSX），给所有用户使用，安装到`local` TeX tree, 给自己使用，安装到`user`TeX tree。

查看`texmf.cnf`文件，它通常在`$TEXMF/web2c`文件夹，但是可以用`kpsewhich texmf.cnf`定位。

`local` Tree 的位置在 `TEXMFLOCAL` variable 中定义，通常像是`/usr/local/share/texmf`。
`user`  Tree 的位置在`TEXMFHOME`中定义，通常像是`$HOME/texmf` or `$HOME/.texliveXXXX`

如果这些变量没有定义，你需要手工指定。修改`local` Tree 可能需要 root 权限。建议修改 user tree, 因为在升级的时候，不会被覆盖。这样在备份系统的时候，可以一起备份。

现在，你需要告诉 Latex 有新文件。这取决于 LaTex 发行版。

1. 对于 TeXLive，运行`texhash`,可能需要 root 权限
2. 对于MikTeX，运行 `Settings (Admin)` and press the button marked `Refresh FNDB`

5. 最后，你需要告诉 LyX 有新的包可以使用。在LyX 中，运行 `Tools->Reconfigure` and then restart LyX

现在，新的文档 class 可以选择了，`Document->Settings->Document Class`。

### latex包安装方式2

首先要找到默认宏包所在目录，一般是:

```bash
/usr/share/texmf/tex/latex
/usr/share/texmf-texlive/tex/latex
```

1. 如果是安装一个新的宏包，就直接把宏包的压缩文件扔进第一个目录下，直接解压就行，注意解压后的文件里可能有安装说明，照着安装说明做就是了。
如果是更新一个宏包，一般都可以在第二个目录下找到，把原先的宏包重命名成`*-backup`，再解压新下载的宏包压缩文件，同时如果有安装说明的话，也照着做。
2. 之后要对宏包重新标记下，终端下执行

```bash
# texhash
```

3. `Log off` / `Log in`后，就完成了～

### latex pdf 裁剪

`texlive` 自带了一个叫做 `pdfcrop` 的 `perl` 脚本

使用方法如下：

`pdfcrop --margins 3 --clip input.pdf output.pdf; `
or

```bash
pdfcrop --clip --bbox '120 480 570 830' input.pdf output.pdf;
```

四个数字的含义是，以左下角为原点，给出`left bottom right top`的数值，单位是`point`

`1 point`=`0.3527 mm`=`1/72 inch`.
A4纸张(mm) `210` * `297`=`595.4 point`*`842.1 point`.

## X窗口系统

X窗口系统（使GUI工作的底层引擎）内建了一种机制，支持快速拷贝和粘贴技巧。

按下鼠标左键，沿着文本拖动鼠标（或者双击一个单词）高亮了一些文本，
那么这些高亮的文本就被拷贝到了一个由X管理的缓冲区里面。然后按下鼠标中键，这些文本就被粘贴到光标所在的位置。

>`ctrl-c` and `ctrl-v`，这两个控制代码对于Shell 有不同的含义，它们在早于Microsoft Windows许多年之前就赋予了不同的意义。

可以把聚焦策略设置为"跟随鼠标"，这样鼠标移动到的窗口，就可以接受输入

### 幕后控制台

即使仿真终端没有运行，后台仍然有几个终端会话运行。他们叫做虚拟终端或者虚拟控制台。

在大多数Linux发行版中，可以通过按下 `Ctrl+Alt+F1` 到 `Ctrl+Alt+F6` 访问。

切换可以直接按`Alt+F1..F6`。返回图形桌面，按下`Alt+F7`

### 将标准输出重定向到剪贴板

[将标准输出重定向到剪贴板][]

[将标准输出重定向到剪贴板]: https://blog.csdn.net/tcliuwenwen/article/details/103752486

作为一名优秀的程序员，终端和复制粘贴必将是必不可少的，手动将输出复制粘贴不应该是一名优秀程序员的作风。
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

如果是`Gnome3`系用户，可以按`ctrl + shift + alt + r`，屏幕右下角有红点出现，则开始录屏，
要结束的话再按一次`ctrl + shift + alt + r`，录好的视频在`~/video`下

***
修改默认30秒的问题, 改成1小时

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 3600
```

## linux查看当前登录用户

[linux查看当前登录用户][]

[linux查看当前登录用户]: https://blog.csdn.net/wanchaopeng/article/details/88425067

### w

`w`:显示目前登入系统的用户信息

+ `-f`: 开启或关闭显示用户从何处登入系统。
+ `-h`: 不显示各栏位的标题信息列。
+ `-s`: 使用简洁格式列表，不显示用户登入时间，终端机阶段作业和程序所耗费的CPU时间。
+ `-u`: 忽略执行程序的名称，以及该程序耗费CPU时间的信息。
+ `-V`: 显示版本信息。

输出的结果的含义:

+ `USER` 登录的用户名
+ `TTY` 登录终端
+ `FROM` 从哪个IP地址登录
+ `LOGIN`@ 登录时间
+ `IDLE` 用户闲置时间
+ `JCPU` 指的是和该终端连接的所有进程占用的时间，这个时间里并不包括过去的后台作业时间，但却包括当前正在运行的后台作业所占用的时间
+ `PCPU` 当前进程所占用的时间
+ `WHAT` 当前正在运行的命令

### who

显示当前已登录的用户信息,输出的结果有:用户名，登录终端，登录的时间

### last

列出目前与过去登入系统的用户相关信息。

+ `-R`: 省略 hostname 的栏位
+ `-n`:指定输出记录的条数。
+ `-f file`:指定用文件`file`作为查询用的`log`文件。
+ `-t time`:显示到指定的时间。
+ `-h `:显示帮助。
+ `-i` or`--ip`:以`数字`and `点`的形式显示`ip`地址。
+ `-x`:显示系统关闭、用户登录和退出的历史。

命令的输出包含:用户名，登录终端，登录IP，登录时间，退出时间（在线时间）

### lastlog

`lastlog` 命令检查某特定用户上次登录的时间

+ `-b`, `--before DAYS`: 仅打印早于 DAYS 的最近登录记录
+ `-h`, `--help`: 显示此帮助信息并推出
+ `-R`, `--root CHROOT_DIR` directory to chroot into
+ `-t`, `--time DAYS` : 仅打印比 DAYS 新近的登录记录
+ `-u`, `--user LOGIN` : 打印 LOGIN 用户的最近登录记录

注意:`lastlog`命令默认读取的是`/var/log/wtmp`这个文件的数据，一定注意这个文件不能用`vi`来查看。

命令输出包括:用户名，登录终端，登录IP，最后一次登录时间

## linux 版向日葵

### 安装

下载linux版本，然后安装

安装命令：
Ubuntu/Deepin系统：`sudo dpkg -i 文件名.deb`

*卸载命令（2步）：

```bash
sudo dpkg -l | grep sunlogin
sudo dpkg -r sunloginclient
```

PS：安装包因版本不同，名字可能会有所出入，建议直接复制当前下载安装包名字进行安装。
如果您的系统高于16.04版本，遇到`lib`依赖问题的话，可按照如下操作：

安装报错：

```bash
尝试sudo /安装路径/sunloginclient启动程序
```

启动报错：

```bash
使用ldd /安装路径/sunloginclient 查看依赖缺失问题
```

发现`libncurses.so.5/libform.so.5/libtinfo.so.5`缺失,由于版本较高，
依赖包版本也可能是更高版本，因此需要创建软链接。

具体如下：

查找现有`lib`包

可以使用`find / -name libncurses*`查找
找到后使用`ln -s /usr/lib/源依赖包位置 /usr/lib/指向依赖包位置`

创建成功后，卸载`sunloginclient`，再次安装`deb`包。

安装成功。直接调用`sudo /usr/local/sunlogin/bin/sunloginclient`即可运行

### 登录

1. 通过命令行开启向日葵：`sudo /usr/local/sunlogin/bin/sunloginclient`启动（路径为向日葵默认安装路径）
2. 登录向日葵：开启程序后的初始状态为未绑定，可见界面左上角的提示`Sunlogin （F12）`为进入菜单选项

## Powerline 状态条

Powerline 是一个极棒的 Vim 编辑器的状态行插件，这个插件是使用 Python 开发的，主要用于显示状态行和提示信息，适用于很多软件，比如 `bash`、`zsh`、`tmux` 等等。

[使用Powerline为VIM和Bash注入强劲动力][]

[使用Powerline为VIM和Bash注入强劲动力]: https://linux.cn/article-8118-1.html

首次安装`pip`，即python包管理器，在 Debian、Ubuntu 和 Linux Mint 中安装 `pip`

```bash
apt-get install python-pip
```

然后你可以通过 pip 命令安装 `Powerline`。

```bash
pip3 install git+git://github.com/powerline/powerline
```

### 在 Linux 中安装 Powerline 的字体

`Powerline` 使用特殊的符号来为开发者显示特殊的箭头效果和符号内容。因此你的系统中必须要有符号字体或者补丁过的字体。

通过下面的 `wget` 命令下载最新的系统字体及字体配置文件。

```bash
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
```

然后你将下载的字体放到字体目录下 `/usr/share/fonts` 或者 `/usr/local/share/fonts`，或者你可以通过 `xset q` 命令找到一个有效的字体目录。

```bash
mv PowerlineSymbols.otf /usr/share/fonts/
```

接下来你需要通过如下命令更新你系统的字体缓存。

```bash
fc-cache -vf /usr/share/fonts/
```

其次安装字体配置文件。

```bash
mv 10-powerline-symbols.conf /etc/fonts/conf.d/
```

### 打开 Bash Shell 中的 Powerline

如果希望在 `bash shell` 中默认打开 `Powerline`，可以在 `~/.bashrc` 中添加如下内容。

首先通过如下命令获取 powerline 的安装位置。

```bash
pip3 show powerline-status
...
Location: XXXXX
...
```

一旦找到 `powerline` 的具体位置后，根据你系统的情况替换到下列行中的 `XXXXX` 对应的位置。

```bash
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source XXXXX/powerline/bindings/bash/powerline.sh
```

然后退出后重新登录，现在 `powerline` 的状态行应该如下显示了。

### 在 Vim 中打开 Powerline

首先通过如下命令获取 `powerline` 的安装位置。

```bash
pip3 show powerline-status
```

在 `~/.vimrc` 中添加如下内容打开该插件（译注：注意同样需要根据你的系统情况修改路径）。

```bash
set rtp+=/home/tom/.local/lib/python3.6/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256
```

然后你打开 `vim` 后会看到一个新的状态行

## CMake

[CMake is an open-source][]
[Ubuntu16.04下安装Cmake][]

[Ubuntu16.04下安装Cmake]: https://blog.csdn.net/l1216766050/article/details/77513045

[CMake is an open-source]: https://cmake.org/

CMake is an open-source, cross-platform family of tools designed to build, test and package software. 

CMake用于使用简单平台和独立于编译器的配置文件来控制软件编译过程，并生成可在您选择的编译器环境中使用的本机makefile和工作区。 CMake工具套件是由Kitware创建的，旨在满足ITK和VTK等开源项目对强大，跨平台构建环境的需求。
