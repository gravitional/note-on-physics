# ubuntu-2.md

## tex的TDS

latex 组织文件的规范叫做 TDS-compliant

a standard `TeX Directory Structure` (TDS): a directory hierarchy for macros, fonts, and the other implementation-independent TeX system files.

### TDS 特征

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

TDS tree 中的文件可能有相同的文件名。默认并不进一步区分，但TDS要求满足以下例外：

Names of TeX input files must be unique within each first-level subdirectory of `texmf/tex` and `texmf/tex/generic`, but not within all of `texmf/tex`; 比如, different TeX formats may have files by the same name. 

所以具体实现必须提供**格式依赖**的路径指定方式。

### 顶层目录

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

## 安装latex包

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

### 安装方式2

首先要找到默认宏包所在目录，一般是：

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

## lyx

### lyx error

`~/.lyx/textclass.lst` 中的条目格式有问题，如

`"IEEEtran-CompSoc"` 变成了 `"b'IEEEtran-CompSoc'"`

python中字节字符串不能格式化。
获取到的网页有时候是字节字符串，需要转化后再解析。

bytes 转 string 方式：

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

然后在源代码目录中执行以下命令：

$ dpkg-buildpackage -us -uc

这样会自动完成所有从源代码包构建二进制包的工作，包括：

    清理源代码树(debian/rules clean)

    构建源代码包(dpkg-source -b)

    构建程序(debian/rules build)

    构建二进制包(fakeroot debian/rules binary)

    制作 .dsc 文件

    用 dpkg-genchanges 命令制作 .changes 文件。

如果构建结果令人满意，那就用 debsign 命令以你的私有 GPG 密钥签署 .dsc 文件和 .changes 文件。你需要输入密码两次。 [63]

对于非本土 Debian 软件包，比如 gentoo， 构建软件包之后，你将会在上一级目录(~/gentoo) 中看到下列文件：

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

debsign 命令可以用来以指定 ID 的 GPG 密钥进行签署 （这方便了赞助(sponsor)软件包）， 只要照着下边在 ~/.devscripts 中的内容：

DEBSIGN_KEYID=Your_GPG_keyID

.dsc 和 .changes 文件中很长的数字串是其中提及文件的 SHA1/SHA256 校验和。下载你软件包的人可以使用 sha1sum(1) 或 sha256sum(1) 来进行核对。如果校验和不符，则说明文件已被损坏或偷换

### Hostname

[What Is a Hostname? ][]

[What Is a Hostname? ]: https://www.lifewire.com/what-is-a-hostname-2625906

域名（英语：`Domain Name`），又称网域，是由一串用点分隔的名字组成的`Internet`上某一台计算机或计算机组的名称，
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

常用命令整理如下：

+ 用硬件检测程序`kuduz`探测新硬件：`service kudzu start ( or restart)`
+ 查看CPU信息：`cat /proc/cpuinfo`
+ 查看板卡信息：`cat /proc/pci`
+ 查看PCI信息：`lspci` (相比`cat /proc/pci`更直观）
+ 查看内存信息：`cat /proc/meminfo`
+ 查看USB设备：`cat /proc/bus/usb/devices`
+ 查看键盘和鼠标:`cat /proc/bus/input/devices`
+ 查看系统硬盘信息和使用情况：`fdisk & disk - l & df`
+ 查看各设备的中断请求(IRQ):`cat /proc/interrupts`
+ 查看系统体系结构：`uname -a`
+ `dmidecode` 查看硬件信息，包括bios、cpu、内存等信息
+ `dmesg | less` 查看硬件信息

[Linux下/proc目录简介][]

[Linux下/proc目录简介]: https://blog.csdn.net/zdwzzu2006/article/details/7747977

Linux 内核提供了一种通过 `/proc` 文件系统，在运行时访问内核内部数据结构、改变内核设置的机制。proc文件系统是一个伪文件系统，它只存在内存当中，而不占用外存空间。它以文件系统的方式为访问系统内核数据的操作提供接口。

用户和应用程序可以通过proc得到系统的信息，并可以改变内核的某些参数。
由于系统的信息，如进程，是动态改变的，所以用户或应用程序读取proc文件时，proc文件系统是动态从系统内核读出所需信息并提交的。
下面列出的这些文件或子文件夹，并不是都是在你的系统中存在，这取决于你的内核配置和装载的模块。
另外，在`/proc`下还有三个很重要的目录：`net`，`scsi`和`sys`。 `Sys`目录是可写的，可以通过它来访问或修改内核的参数，而`net`和`scsi`则依赖于内核配置。例如，如果系统不支持`scsi`，则`scsi`目录不存在。

除了以上介绍的这些，还有的是一些以数字命名的目录，它们是进程目录。
系统中当前运行的每一个进程都有对应的一个目录在`/proc`下，以进程的 `PID`号为目录名，它们是读取进程信息的接口。
而`self`目录则是读取进程本身的信息接口，是一个`link`。

## Linux各目录含义

### FHS标准

其实，linux系统的目录都遵循一个标准，即由Linux基金会发布的 文件系统层次结构标准 (`Filesystem Hierarchy Standard`, FHS)。
这个标准里面定义了linux系统该有哪些目录，各个目录应该存放什么，起什么作用等等。具体说明如下：

目录  含义

+ `/bin`  binary，即用来存放二进制可执行文件，并且比较特殊的是`/bin`里存放的是所有一般用户都能使用的可执行文件，如：`cat`, `chmod`, `chown`, `mv`, `mkdir`, `cd` 等常用指令
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

`Unix Software Resource` 意为 `Unix`系统软件资源，系统自带的软件都装在这个目录下（好比Windows系统的"C:\Windows"），用户安装的第三方软件也在这个目录下（好比Windows系统的"C:\Program Files"），不同的是，在Windows系统上安装软件通常将该软件的所有文件放置在同一个目录下，但是在Linux系统安装软件会将该软件的不同文件分别放置在/usr目录下的不同子目录下，而不应该自行创建该软件自己的独立目录。进入到`/usr`目录，一般有以下子目录：

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

## 输入法

重启输入法

`ibus restart`: Restart ibus-daemon.

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

如要查看当前目录已使用总大小可输入：`du -h --max-depth=0`

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

`df`命令是linux系统以磁盘分区为单位查看文件系统，可以加上参数查看磁盘剩余空间信息，命令格式：

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

## sed

sed是一种流编辑器，它是文本处理中非常中的工具，能够完美的配合正则表达式使用，功能不同凡响。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有 改变，除非你使用重定向存储输出。Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等

命令格式

sed [options] 'command' file(s)
sed [options] -f scriptfile file(s)

### 选项

-e<script>或--expression=<script>：以选项中的指定的script来处理输入的文本文件；
-f<script文件>或--file=<script文件>：以选项中指定的script文件来处理输入的文本文件；
-h或--help：显示帮助；
-n或--quiet或——silent：仅显示script处理后的结果；
-V或--version：显示版本信息。

### 命令

+ `a\` 在当前行下面插入文本。
+ `i\` 在当前行上面插入文本。
+ `c\` 把选定的行改为新的文本。
+ `d` 删除，删除选择的行。
+ `D` 删除模板块的第一行。
+ `s` 替换指定字符
+ `h` 拷贝模板块的内容到内存中的缓冲区。
+ `H` 追加模板块的内容到内存中的缓冲区。
+ `g` 获得内存缓冲区的内容，并替代当前模板块中的文本。
+ `G` 获得内存缓冲区的内容，并追加到当前模板块文本的后面。
+ `l` 列表不能打印字符的清单。
+ `n` 读取下一个输入行，用下一个命令处理新的行而不是用第一个命令。
+ `N` 追加下一个输入行到模板块后面并在二者间嵌入一个新行，改变当前行号码。
+ `p` 打印模板块的行。
+ `P` (大写) 打印模板块的第一行。
+ `q` 退出Sed。
+ `b lable` 分支到脚本中带有标记的地方，如果分支不存在则分支到脚本的末尾。
+ `r file` 从file中读行。
+ `t label` if分支，从最后一行开始，条件一旦满足或者T，t命令，将导致分支到带有标号的命令处，或者到脚本的末尾。
+ `T label` 错误分支，从最后一行开始，一旦发生错误或者T，t命令，将导致分支到带有标号的命令处，或者到脚本的末尾。
+ `w file` 写并追加模板块到file末尾。
+ `W file` 写并追加模板块的第一行到file末尾。
+ `!` 表示后面的命令对所有没有被选定的行发生作用。
+ `=` 打印当前行号码。
+ `#` 把注释扩展到下一个换行符以前。

### 替换标记

+ `g` 表示行内全面替换。
+ `p` 表示打印行。
+ `w` 表示把行写入一个文件。
+ `x` 表示互换模板块中的文本和缓冲区中的文本。
+ `y` 表示把一个字符翻译为另外的字符（但是不用于正则表达式）
+ `\1` 子串匹配标记
+ `&` 已匹配字符串标记

### 元字符集

+ `^` 匹配行开始，如：`/^sed/`匹配所有以`sed`开头的行。
+ `$` 匹配行结束，如：`/sed$/`匹配所有以`sed`结尾的行。
+ `.` 匹配一个非换行符的任意字符，如：`/s.d/`匹配`s`后接一个任意字符，最后是`d`。
+ `*` 匹配`0`个或多个字符，如：`/*sed/`匹配所有模板是一个或多个空格后紧跟`sed`的行。
+ `[]` 匹配一个指定范围内的字符，如`/[ss]ed/`匹配sed和Sed。
+ `[^]` 匹配一个不在指定范围内的字符，如：`/[^A-RT-Z]ed/`匹配不包含`A-R`和`T-Z`的一个字母开头，紧跟`ed`的行。
+ `\(..\)` 匹配子串，保存匹配的字符，如`s/\(love\)able/\1rs`，loveable被替换成lovers。
+ `&` 保存搜索字符用来替换其他字符，如`s/love/**&**/`，love这成`**love**`。
+ `\<` 匹配单词的开始，如:`/\<love/`匹配包含以love开头的单词的行。
+ `\>` 匹配单词的结束，如`/love\>/`匹配包含以love结尾的单词的行。
+ `x\{m\}` 重复字符`x`，`m`次，如：`/0\{5\}/`匹配包含5个0的行。
+ `x\{m,\}` 重复字符`x`，至少`m`次，如：`/0\{5,\}/`匹配至少有5个0的行。
+ `x\{m,n\}` 重复字符`x`，至少`m`次，不多于n次，如：`/0\{5,10\}/`匹配5~10个0的行。

### 用法实例

### ip地址

先观察原始信息，利用`ip monitor address dev enp0s31f6` 监视 IP变化

ip monitor address dev enp0s31f6

```bash
dev_name="enp0s31f6" #设备名称
dev_addr=$(ip monitor address dev $dev_name)  #监视ip变化
echo $dev_addr |\ 
grep -Po "${dev_name}[ ]+inet[ ]+[ \w\d\./]+brd" | `#用grep 提取出address一行`\
sed "s/${dev_name} \{1,\}inet//g" | sed "s/brd//g"
```

```bash
dev_name="enp0s31f6" #设备名称
ip monitor address dev $dev_name | while read line
do
echo $line |\ 
grep -Po "${dev_name}[ ]+inet[ ]+[ \w\d\./]+brd" | `#用grep 提取出address一行`\
sed "s/${dev_name} \{1,\}inet//g" | sed "s/brd//g"
done
```

#### 替换操作：s命令

替换文本中的字符串：

```bash
sed 's/book/books/' file
```

`-n`选项和`p`命令一起使用表示只打印那些发生替换的行：

```bash
sed -n 's/test/TEST/p' file
```

直接编辑文件选项`-i`，会匹配`file`文件中每一行的第一个`book`替换为`book`s：

```bash
sed -i 's/book/books/g' file
```

#### 全面替换标记g

使用后缀 `/g` 标记会替换每一行中的所有匹配：

```bash
sed 's/book/books/g' file
```

 当需要从第N处匹配开始替换时，可以使用 /Ng：

echo sksksksksksk | sed 's/sk/SK/2g'
skSKSKSKSKSK

echo sksksksksksk | sed 's/sk/SK/3g'
skskSKSKSKSK

echo sksksksksksk | sed 's/sk/SK/4g'
skskskSKSKSK

#### 定界符

以上命令中字符 / 在sed中作为定界符使用，也可以使用任意的定界符：

sed 's:test:TEXT:g'
sed 's|test|TEXT|g'

定界符出现在样式内部时，需要进行转义：

sed 's/\/bin/\/usr\/local\/bin/g'

#### 删除操作：d命令

删除空白行：

sed '/^$/d' file

删除文件的第2行：

sed '2d' file

删除文件的第2行到末尾所有行：

sed '2,$d' file

删除文件最后一行：

sed '$d' file

删除文件中所有开头是test的行：

sed '/^test/'d file

#### 已匹配字符串标记&

正则表达式 \w\+ 匹配每一个单词，使用 [&] 替换它，& 对应于之前所匹配到的单词：

echo this is a test line | sed 's/\w\+/[&]/g'
[this] [is] [a] [test] [line]

所有以192.168.0.1开头的行都会被替换成它自已加localhost：

sed 's/^192.168.0.1/&localhost/' file
192.168.0.1localhost

#### 子串匹配标记\1

匹配给定样式的其中一部分：

echo this is digit 7 in a number | sed 's/digit \([0-9]\)/\1/'
this is 7 in a number

命令中 digit 7，被替换成了 7。样式匹配到的子串是 7，\(..\) 用于匹配子串，对于匹配到的第一个子串就标记为 \1，依此类推匹配到的第二个结果就是 \2，例如：

echo aaa BBB | sed 's/\([a-z]\+\) \([A-Z]\+\)/\2 \1/'
BBB aaa

love被标记为1，所有loveable会被替换成lovers，并打印出来：

sed -n 's/\(love\)able/\1rs/p' file

#### 组合多个表达式

sed '表达式' | sed '表达式'

等价于：

sed '表达式; 表达式'

#### 引用

sed表达式可以使用单引号来引用，但是如果表达式内部包含变量字符串，就需要使用双引号。

test=hello
echo hello WORLD | sed "s/$test/HELLO"
HELLO WORLD

#### 选定行的范围：,（逗号）

所有在模板test和check所确定的范围内的行都被打印：

sed -n '/test/,/check/p' file

打印从第5行开始到第一个包含以test开始的行之间的所有行：

sed -n '5,/^test/p' file

对于模板test和west之间的行，每行的末尾用字符串aaa bbb替换：

sed '/test/,/west/s/$/aaa bbb/' file

#### 多点编辑：e命令

-e选项允许在同一行里执行多条命令：

sed -e '1,5d' -e 's/test/check/' file

上面sed表达式的第一条命令删除1至5行，第二条命令用check替换test。命令的执行顺序对结果有影响。如果两个命令都是替换命令，那么第一个替换命令将影响第二个替换命令的结果。

和 -e 等价的命令是 --expression：

sed --expression='s/test/check/' --expression='/love/d' file

#### 从文件读入：r命令

file里的内容被读进来，显示在与test匹配的行后面，如果匹配多行，则file的内容将显示在所有匹配行的下面：

sed '/test/r file' filename

#### 写入文件：w命令  

在example中所有包含test的行都被写入file里：

sed -n '/test/w file' example

#### 追加（行下）：a\命令

将 this is a test line 追加到 以test 开头的行后面：

sed '/^test/a\this is a test line' file

在 test.conf 文件第2行之后插入 this is a test line：

sed -i '2a\this is a test line' test.conf

#### 插入（行上）：i\命令

将 this is a test line 追加到以test开头的行前面：

sed '/^test/i\this is a test line' file

在test.conf文件第5行之前插入this is a test line：

sed -i '5i\this is a test line' test.conf

#### 下一个：n命令

如果test被匹配，则移动到匹配行的下一行，替换这一行的aa，变为bb，并打印该行，然后继续：

sed '/test/{ n; s/aa/bb/; }' file

#### 变形：y命令

把1~10行内所有abcde转变为大写，注意，正则表达式元字符不能使用这个命令：

sed '1,10y/abcde/ABCDE/' file

#### 退出：q命令

打印完第10行后，退出sed

sed '10q' file

#### 保持和获取：h命令和G命令

在sed处理文件的时候，每一行都被保存在一个叫模式空间的临时缓冲区中，除非行被删除或者输出被取消，否则所有被处理的行都将 打印在屏幕上。接着模式空间被清空，并存入新的一行等待处理。

sed -e '/test/h' -e '$G' file

在这个例子里，匹配test的行被找到后，将存入模式空间，h命令将其复制并存入一个称为保持缓存区的特殊缓冲区内。第二条语句的意思是，当到达最后一行后，G命令取出保持缓冲区的行，然后把它放回模式空间中，且追加到现在已经存在于模式空间中的行的末尾。在这个例子中就是追加到最后一行。简单来说，任何包含test的行都被复制并追加到该文件的末尾。

#### 保持和互换：h命令和x命令

互换模式空间和保持缓冲区的内容。也就是把包含test与check的行互换：

sed -e '/test/h' -e '/check/x' file

#### 脚本scriptfile

sed脚本是一个sed的命令清单，启动Sed时以-f选项引导脚本文件名。Sed对于脚本中输入的命令非常挑剔，在命令的末尾不能有任何空白或文本，如果在一行中有多个命令，要用分号分隔。以#开头的行为注释行，且不能跨行。

sed [options] -f scriptfile file(s)

#### 打印奇数行或偶数行

方法1：

sed -n 'p;n' test.txt  #奇数行
sed -n 'n;p' test.txt  #偶数行

方法2：

sed -n '1~2p' test.txt  #奇数行
sed -n '2~2p' test.txt  #偶数行

#### 打印匹配字符串的下一行

grep -A 1 SCC URFILE
sed -n '/SCC/{n;p}' URFILE
awk '/SCC/{getline; print}' URFILE

## shell空白字符

[对C标准中空白字符的理解][]
[Shell中去掉文件中的换行符简单方法][]

[对C标准中空白字符的理解]: https://blog.csdn.net/boyinnju/article/details/6877087

[Shell中去掉文件中的换行符简单方法]: https://blog.csdn.net/Jerry_1126/java/article/details/85009615

### 空白字符

`C`标准库里`<ctype.h>`中声明了一个函数:

`int isspace(int c);`

该函数判断字符`c`是否为一个空白字符。

`C`标准中空白字符有六个：
空格（`' '`）、换页（`'\f'`）、换行（`'\n'`）、回车（`'\r'`）、水平制表符（`'\t'`）、垂直制表符（`'\v'`）

***
空格: ASCII码为`0x20`，而不是`0x00`。`0x00`代表空（`NULL`）

`0X00-0XFF` `16`进制一共`256`个，刚好是一个`bit`的范围。

***
回车（'\r'）效果是输出回到本行行首，结果可能会将这一行之前的输出覆盖掉，例如执行：

```bash
puts("hello world!\rxxx");
#在终端输出的是：
xxxlo world!
```

如果将上面的字符串写入文件中，例如执行：

```bash
char *s = "hello world!\rxxx";
FILE *str = fopen("t.txt","r");
fwrite(s, 16, 1, str);
```

用文本编辑器打开`t.txt`。显示的效果将由打开的编辑器所决定。
vi将`\r`用`^M`代替，而记事本就没有显示该字符。

***
换行（'\n'）
顾名思义，换行就是转到下一行输出。例如：

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
一般系统中，显示水平制表符将占8列。同时水平制表符开始占据的初始位置是第`8*n`列（第一列的下标为0）。例如：

```bash
puts("0123456\txx");
puts("0123456t\txx");
```

***
垂直制表符（'\v'）

垂直制表符不常用。它的作用是让`'\v'`后面的字符从下一行开始输出，且开始的列数为“`\v`”前一个字符所在列后面一列。例如：

```bash
puts("01\v2345");
```

***
换页（'\f'）

换页符的在终端的中的效果相当于`*nix`中`clear`命令。
终端在输出`'\f'`之后内容之前，会将整个终端屏幕清空空，然后在输出内容。给人的该觉是在`clear`命令后的输出字符串。

最后我想说明一点，`\t \r, \v \f`也是控制字符，它们会控制字符的输出方式。
它们在终端输出时会有上面的表现，但如果写入文本文件，一般文本编辑器（vi或记事本）对`\t \r, \v \f`的显示是没有控制效果的。

### 去掉文件中的换行符号

文件中每行都以`\n`结尾，如果要去掉换行符，使用`sed`命令

```bash
[root@host ~]# sed -i 's/\n//g' FileName
```

或者使用`tr`命令: tr - translate or delete characters

```bash
[root@host ~]# cat fileName | tr '\n' ''
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
然而当在它前面放上`eval`时，其结果是`shell`在执行命令行之前扫描它两次。如：

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

`eval echo \$$#`取得最后一个参数, 如：

```bash
$ cat last    #此处last是一个脚本文件，内容是下一行显示
$  eval echo \$$#
$ ./last one two three four

four
```

第一遍扫描后，shell把反斜杠去掉了。当shell再次扫描该行时，它替换了`$4`的值，并执行echo命令

***
以下示意如何用`eval`命令创建指向变量的“指针”：

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

`ugoa`表示控制特定用户访问权限：

+ u：the user who owns it 
+ g：other users in the file's group
+ o：other users not in the file's group
+ a：all  users
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

如要卸载 Mathematica，需删除下列目录。请备份这些目录下任何需要保存的文件：

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
#!/bin/bash

# 复制到论文中的都是 ci==1.50 的结果
user_name=$(whoami)
# 配置计算结果目录，论文目录，论文压缩文件目录
originpath=$(pwd)
paperpath="/home/${user_name}/private/paper-2.prd/"
deskpath="/home/${user_name}/Desktop/paper.ff/"
# 复制计算结果到论文目录
cp "fig.baryons.ge.charge.L-0.90.ci-1.50.pdf"  ${paperpath}"fig4.pdf"
cp "fig.baryons.ge.neutral.L-0.90.ci-1.50.pdf" ${paperpath}"fig5.pdf"
cp "fig.baryons.gm.charge.L-0.90.ci-1.50.pdf" ${paperpath}"fig2.pdf"
cp "fig.baryons.gm.neutral.L-0.90.ci-1.50.pdf" ${paperpath}"fig3.pdf"
# cd 到论文目录，重新编译论文
cd $paperpath
./build.sh
# 如果桌面还没有压缩文件目录，就创建一个
if [ ! -d $deskpath ];then
      mkdir -p $deskpath
fi
# 把论文目录的东西复制到桌面目录中
cp  ./* $deskpath 
# 进入桌面目录，删除tex编译过程中的额外文件
# if [ -f *.${rmtype} ]; then rm *.${rmtype}; fi
cd $deskpath 
echo -e '\n delete auxilary files \n'
for rmtype in aux lof log lot fls out toc fmt fot cb cb2 ptc xdv \
fdb_latexmk synctex.gz  swp ps1 sh bib bbl blg
do
rm *.${rmtype}
done
# 产生论文压缩文件
7z a ../paper.7z $deskpath
# 回到原来的文件夹
cd $originpath 
```

## 环境变量

[Linux环境变量总结][]

[Linux环境变量总结]: https://www.jianshu.com/p/ac2bc0ad3d74

Linux是一个多用户多任务的操作系统，可以在Linux中为不同的用户设置不同的运行环境，具体做法是设置不同用户的环境变量。

### Linux环境变量分类

***
按照生命周期来分，Linux环境变量可以分为两类：

1. 永久的：需要用户修改相关的配置文件，变量永久生效。
2. 临时的：用户利用`export`命令，在当前终端下声明环境变量，关闭Shell终端失效。

***
按照作用域来分，Linux环境变量可以分为：

1. 系统环境变量：系统环境变量对该系统中所有用户都有效。
2. 用户环境变量：顾名思义，这种类型的环境变量只对特定的用户有效。

### Linux设置环境变量的方法

1. 在`/etc/profile`文件中添加变量 对所有用户生效（永久的）

用`vim`在文件`/etc/profile`文件中增加变量，该变量将会对`Linux`下所有用户有效，并且是“永久的”。
例如：编辑`/etc/profile`文件，添加`CLASSPATH`变量

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

Linux中常见的环境变量有：

***
PATH：指定命令的搜索路径

PATH声明用法：

```bash
export PATH=$PAHT:<PATH 1>:<PATH 2>:<PATH 3>:--------:< PATH n >
```

你可以自己加上指定的路径，中间用冒号隔开。环境变量更改后，在用户下次登陆时生效。

可以利用`echo $PATH`查看当前当前系统PATH路径。

    HOME：指定用户的主工作目录（即用户登陆到Linux系统中时，默认的目录）。
    HISTSIZE：指保存历史命令记录的条数。
    LOGNAME：指当前用户的登录名。
    HOSTNAME：指主机的名称，许多应用程序如果要用到主机名的话，通常是从这个环境变量中来取得的
    SHELL：指当前用户用的是哪种Shell。
    LANG/LANGUGE：和语言相关的环境变量，使用多种语言的用户可以修改此环境变量。
    MAIL：指当前用户的邮件存放目录。

注意：上述变量的名字并不固定，如HOSTNAME在某些Linux系统中可能设置成HOST

2. Linux也提供了修改和查看环境变量的命令，下面通过几个实例来说明：

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

例如，下面是一个`/etc/default/grub`文件的示例：

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

虽然可用的宏较多，但可能用的上的就几个：
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
