# ubuntu-6

## 第十五章:软件包管理

如果我们花些时间在 Linux 社区里,我们会得知很多针对, 类如在众多 Linux 发行版中哪个是最好的(等问题的)看法. 
这些集中在像这些事情上的讨论,比方说最漂亮的桌面背景(一些人不使用 Ubuntu, 只是因为 Ubuntu默认主题颜色是棕色的!)和其它的琐碎东西,经常变得非常无聊.

Linux 发行版本质量最重要的决定因素是软件包管理系统和其支持社区的持久性.
随着我们 花更多的时间在Linux 上,我们会发现它的软件园地是非常动态的.软件不断变化.
大多数一线 Linux 发行版每隔六个月发布一个新版本,并且许多独立的程序每天都会更新.

为了能和这些 如暴风雪一般多的软件保持联系,我们需要一些好工具来进行软件包管理.
软件包管理是指系统中一种安装和维护软件的方法.今天,通过从 Linux 发行版中安装的软件包, 已能满足许多人所有需要的软件.
这不同于早期的 Linux,人们需要下载和编辑源码来安装软件.编辑源码没有任何问题,事实上,拥有对源码的访问权限是 Linux 的伟大奇迹.

它赋予我们( 其它每个人)才干来检测和提高系统性能.只是若有一个预先编译好的软件包处理起来要相对 容易快速些.

这章中,我们将查看一些用于包管理的命令行工具.
虽然所有主流 Linux 发行版都 提供了强大且精致的图形管理程序来维护系统,但是学习命令行程序也非常重要.
因为它们 可以完成许多让图形化管理程序处理起来困难(或者不可能)的任务.

### 打包系统

不同的 Linux 发行版使用不同的打包系统,
一般而言,大多数发行版分别属于两大包管理技术阵营: `Debian的``.deb`,和`Red Hat`的`.rpm`.
也有一些重要的例外,比方说 `Gentoo`, `Slackware`,和 `Foresight`,但大多数会使用这两个基本系统中的一个.
***
表15-1: 主要的包管理系统家族
包管理系统 发行版 (部分列表)

+ Debian Style (.deb) Debian, Ubuntu, Xandros, Linspire
+ Red Hat Style (.rpm) Fedora, CentOS, Red Hat Enterprise Linux, OpenSUSE, Mandriva, PCLinuxOS

### 软件包管理系统是怎样工作的

在专有软件产业中找到的软件发布方法通常需要买一张安装媒介,比方说`安装盘`,然后运行 `安装向导`,来在系统中安装新的应用程序.
Linux 不是这样.Linux 系统中几乎所有的软件都可以在互联网上找到.

其中大多数软件由发行商以 包文件的形式提供,剩下的则以源码形式存在,可以手动安装.
在后面章节里,我们将会谈谈怎样 通过编译源码来安装软件.

#### 包文件

在包管理系统中软件的基本单元是包文件.
包文件是一个构成软件包的文件压缩集合.一个软件包可能由大量程序以及支持这些程序的数据文件组成.
除了安装文件之外,软件包文件也包括 关于这个包的元数据,如软件包及其内容的文本说明.
另外,许多软件包还包括预安装和安装后脚本, 这些脚本用来在软件安装之前和之后执行配置任务.

软件包文件是由软件包维护者创建的,他通常是(但不总是)一名软件发行商的雇员.
软件维护者 从上游提供商(程序作者)那里得到软件源码,然后编辑源码,创建软件包元数据以及所需要的 安装脚本.
通常,软件包维护者要把所做的修改应用到最初的源码当中,来提高此软件与 Linux 发行版其它部分的融合性.

资源库虽然某些软件项目选择执行他们自己的打包和发布策略,但是现在大多数软件包是由发行商和感兴趣 的第三方创
建的.
系统发行版的用户可以在一个中心资源库中得到这些软件包,这个资源库可能 包含了成千上万个软件包,每一个软件包都是专门为这个系统发行版建立和维护的.

因软件开发生命周期不同阶段的需要,一个系统发行版可能维护着几个不同的资源库.
例如,通常会 有一个`测试`资源库,其中包含刚刚建立的软件包,它们想要勇敢的用户来使用, 在这些软件包正式发布之前,让用户查
找错误.
系统发行版经常会有一个`开发`资源库, 这个资源库中保存着注定要包含到下一个主要版本中的半成品软件包.

一个系统发行版可能也会拥有相关第三方的资源库.

这些资源库需要支持一些因法律原因, 比如说专利或者是DRM 反规避问题,而不能被包含到发行版中的软件.
可能最著名的案例就是 那个加密的 DVD 支持,在美国这是不合法的.

第三方资源库在这些软件专利和反规避法案不 生效的国家中起作用.这些资源库通常完全地独立于
它们所支持的资源库,要想使用它们, 你必须了解它们,手动地把它们包含到软件包管理系统的配置文件中.

### 依赖性

程序很少是`孤立的`,而是依赖于其它软件组件来完成它们的工作.
常见活动,以 输入/输出为例,就是由共享程序例程来处理的.这些程序例程存储在共享库中,共享库不只 为一个程序提供基本服务.

如果一个软件包需要共享资源,比如说共享库,据说就有一个依赖. 
现代的软件包管理系统都提供了一些依赖项解析方法,以此来确保当安装软件包时,也安装了 其所有的依赖程序.

### 上层和底层软件包工具

软件包管理系统通常由两种工具类型组成:底层工具用来处理这些任务,比方说安装和删除软件包文件, 和上层工具,完成元数据搜索和依赖解析.

在这一章中,我们将看一下由 Debian 风格的系统 (比如说 `Ubuntu`,还有许多其它系统)提供的工具,还有那些由 `Red Hat` 产品使用的工具.
虽然所有基于 `Red Hat` 风格的发行版都依赖于相同的底层程序(`rpm`), 但是它们却使用不同的上层工具.我们将研究上层程序 `yum` 供我们讨论,

Fedora, `Red Hat` 企业版,和 `CentOs` 都是使用 `yum`.其它基于 `Red Hat` 风格的发行版提供了带有可比较特性的上层工具.
***
表15-2: 包管理工具
发行版 底层工具 上层工具

+ `Debian-Style` : `dpkg apt-get`, `aptitude`
+ `Fedora`, `Red Hat Enterprise Linux`,` CentOS` : `rpm yum`

### 常见软件包管理任务

通过命令行软件包管理工具可以完成许多操作.我们将会看一下最常用的工具.
注意底层工具也 支持软件包文件的创建,这个话题超出了本书叙述的范围.
在以下的讨论中,`package_name` 这个术语是指软件包实际名称,而不是指`package_file`,它是包含在软件包中的文件名.

#### 查找资源库中的软件包

使用上层工具来搜索资源库元数据,可以根据软件包的名字和说明来定位它.
***
表15-3: 软件包查找工具
风格 命令

+ Debian : `apt-get update`; `apt-cache search search_string`
+ Red Hat : `yum search search_string`

例如:搜索一个 `yum` 资源库来查找 `emacs` 文本编辑器,使用以下命令:

```bash
yum search emacs
```

#### 从资源库中安装一个软件包

上层工具允许从一个资源库中下载一个软件包,并经过完全依赖解析来安装它.
***
表15-4: 软件包安装命令
风格 命令

+ `Debian` : `apt-get update`; `apt-get install package_name`
+ `Red Hat` : `yum install package_name`

例如:从一个 `apt` 资源库来安装 `emacs` 文本编辑器:

```bash
apt-get update; apt-get install emacs
```

#### 通过软件包文件来安装软件

如果从某处而不是从资源库中下载了一个软件包文件,可以使用底层工具来直接(没有经过依赖解析)安装它.
***
表15-5: 底层软件包安装命令
风格 命令

+ `Debian`: `dpkg --install package_file`
+ `Red Hat`: `rpm -i package_file`

例如:如果已经从一个并非资源库的网站下载了软件包文件 `emacs-22.1-7.fc7-i386.rpm`, 则可以通过这种方法来安装它:

```bash
rpm -i emacs-22.1-7.fc7-i386.rpm
```

注意:因为这项技术使用底层的 `rpm` 程序来执行安装任务,所以没有运行依赖解析. 如果 `rpm` 程序发现缺少了一个依赖,则会报错并退出.

#### 卸载软件

可以使用上层或者底层工具来卸载软件.下面是可用的上层工具.
***
表15-6: 软件包删除命令
风格 命令

+ `Debian`: `apt-get remove package_name`
+ `Red Hat`: `yum erase package_name`

例如:从 `Debian` 风格的系统中卸载 `emacs` 软件包:

```bash
apt-get remove emacs
```

#### 经过资源库来更新软件包

最常见的软件包管理任务是保持系统中的软件包都是最新的.上层工具仅需一步就能完成 这个至关重要的任务.
***
表15-7: 软件包更新命令
风格 命令

+ `Debian`: `apt-get update; apt-get upgrade`
+ `Red Hat`: `yum update`

例如:更新安装在 Debian 风格系统中的软件包:

```bash
apt-get update; apt-get upgrade
```

#### 经过软件包文件来升级软件

如果已经从一个非资源库网站下载了一个软件包的最新版本,可以安装这个版本,用它来 替代先前的版本:
***
表15-8: 底层软件包升级命令
风格 命令

+ `Debian`: `dpkg --install package_file`
+ `Red Hat`: `rpm -U package_file`

例如:`把 Red Hat` 系统中所安装的 `emacs` 的版本更新到软件包文件 `emacs-22.1-7.fc7-i386.rpmz` 所包含的 `emacs` 版本.

```bash
rpm -U emacs-22.1-7.fc7-i386.rpm
```

注意:`rpm` 程序安装一个软件包和升级一个软件包所用的选项是不同的,而 `dpkg` 程序所用的选项是相同的.

#### 列出所安装的软件包

下表中的命令可以用来显示安装到系统中的所有软件包列表:
***
表15-9: 列出所安装的软件包命令
风格 命令

+ `Debian`: `dpkg --list`
+ `Red Hat` : `rpm -qa`

#### 确定是否安装了一个软件包

这些底端工具可以用来显示是否安装了一个指定的软件包:
***
表15-10: 软件包状态命令
风格 命令

+ `Debian`: `dpkg --status package_name`
+ `Red Hat`: `rpm -q package_name`

例如:确定是否` Debian` 风格的系统中安装了这个 `emacs` 软件包:

```bash
dpkg --status emacs
```

#### 显示所安装软件包的信息

如果知道了所安装软件包的名字,使用以下命令可以显示这个软件包的说明信息:
***
表15-11: 查看软件包信息命令
风格 命令

+ `Debian`: `apt-cache show package_name`
+ `Red Hat`: `yum info package_name`

例如:查看 Debian 风格的系统中 `emacs` 软件包的说明信息:

```bash
apt-cache show emacs
```

#### 查找安装了某个文件的软件包

确定哪个软件包对所安装的某个特殊文件负责,使用下表中的命令:
***
表15-12: 包文件识别命令
风格 命令

+ `Debian`: `dpkg --search file_name`
+ `Red Hat`: `rpm -qf file_name`

例如:在 `Red Hat` 系统中,查看哪个软件包安装了`/usr/bin/vim` 这个文件

```bash
rpm -qf /usr/bin/vim
```

总结归纳

在随后的章节里面,我们将探讨许多不同的程序,这些程序涵盖了广泛的应用程序领域.

虽然 大多数程序一般是默认安装的,但是若所需程序没有安装在系统中,那么我们可能需要安装额外的软件包.
通过我们新学到的(和了解的)软件包管理知识,我们应该没有问题来安装和管理所需的程序.

### Linux 软件安装谣言

从其它平台迁移过来的用户有时会成为谣言的受害者,说是在 Linux 系统中,安装软件有些 困难,并且不同系统发行版所使用的各种各样的打包方案是一个障碍.

唉,它是一个障碍, 但只是针对于那些希望把他们的秘密软件只以二进制版本发行的专有软件供应商.Linux 软件生态系统是基于开放源代码理念.
如果一个程序开发人员发布了一款产品的 源码,那么与系统发行版相关联的开发人员可能就会把这款产品打包,并把它包含在 他们的资源库中.
这种方法保证了这款产品能很好地与系统发行版整合在一起,同时为用户 `一站式采购`软件提供了方便,从而用户不必去搜索每个产品的网站.

设备驱动差不多也以同样的方式来处理,但它们不是系统发行版资源库中单独的项目, 它们本身是 Linux 系统内核的一部分.
一般来说,在 Linux 当中没有一个类似于`驱动盘`的东西. 要不内核支持一个设备,要不不支持,反正 Linux 内核支持很多设备,事实上,多于 Windows 所支持的设备数目.

当然,如果你需要的特定设备不被支持,这里也没有安慰.当那种情况 发生时,你需要查找一下原因.
缺少驱动程序支持通常是由以下三种情况之一导致:

1. 设备太新. 因为许多硬件供应商没有积极地支持 Linux 的发展,那么编写内核 驱动代码的任务就由一些
Linux 社区来承担,而这需要花费时间.
2. 设备太奇异. 不是所有的发行版都包含每个可能的设备驱动.每个发行版会建立 它们自己的内核,因为
内核是可以配置的(这使得从手表到主机的每台设备上运行 Linux 成为可能), 这样它们可能会忽略某
个特殊设备.通过定位和下载驱动程序的源码,可能需要你自己(是的,由你) 来编译和安装驱动.这
个过程不是很难,而是参与.我们将在随后的章节里来讨论编译软件.
3. 硬件供应商隐藏信息. 他们既不发布应用于 Linux 系统的驱动程序代码, 也不发布技术文档来让某人创
建它.这意味着硬件供应商试图保密此设备的程序接口.因为我们 不想在计算机中使用保密的设备,所
以我建议删除这令人厌恶的软件, 把它和其它无用的项目都仍到垃圾桶里.

拓展阅读

花些时间来了解你所用发行版中的软件包管理系统.每个发行版都提供了关于自带软件包管理工具的文档.
另外,这里有一些更普遍的资源:

Debian GNU/Linux FAQ 关于软件包管理一章对软件包管理进行了概述:
http://www.debian.org/doc/FAQ/ch-pkgtools.en.html

RPM 工程的主页:
http://www.rpm.org

杜克大学 YUM 工程的主页:
http://linux.duke.edu/projects/yum/

了解一点儿背景知识,Wikipedia 上有一篇关于 metadata 的文章:
http://en.wikipedia.org/wiki/Metadata

## 第十六章:存储媒介

在前面章节中,我们已经从文件级别看了操作数据.在这章里,我们将从设备级别来考虑数据. 
Linux 有着令人惊奇的能力来处理存储设备,
不管是物理设备,比如说硬盘,还是网络设备,或者是 虚拟存储设备,像RAID(独立磁盘冗余阵列)和 LVM(逻辑卷管理器).

然而,这不是一本关于系统管理的书籍,我们不会试图深入地覆盖整个主题.
我们将努力做的就是 介绍一些概念和用来管理存储设备的重要命令.
我们将会使用 `USB` 闪存,`CD-RW` 光盘(因为系统配备了 `CD-ROM` 烧写器)和一张软盘(若系统这样配备),来做这章的练习题.

我们将看看以下命令:

+ `mount` – 挂载一个文件系统
+ `umount` – 卸载一个文件系统
+ `fsck` – 检查和修复一个文件系统
+ `fdisk` – 分区表控制器
+ `mkfs` – 创建文件系统
+ `fdformat` – 格式化一张软盘
+ `dd` — 把面向块的数据直接写入设备
+ `genisoimage` (`mkisofs`) – 创建一个 `ISO 9660` 的映像文件
+ `wodim` (`cdrecord`) – 把数据写入光存储媒介
+ `md5sum` – 计算 `MD5` 检验码

### 挂载和卸载存储设备

Linux 桌面系统的最新进展已经使存储设备管理对于桌面用户来说极其容易.
大多数情况下,我们 只要把设备连接到系统中,它就能工作.在过去(比如说,2004年),这个工作必须手动完成.

在非桌面系统中(例如,服务器中),这仍然是一个主要地手动过程,因为服务器经常有极端的存储需求 和复杂的配置要求.
管理存储设备的第一步是把设备连接到文件系统树中.这个过程叫做挂载,允许设备参与到操作系统中. 

回想一下第三章,类 Unix 的操作系统,像 `Linux`,维护单一文件系统树,设备连接到各个结点上. 
这与其它操作系统形成对照,比如说 `MS-DOS` 和 `Windows` 系统中,每个设备(例如 `C:\`,`D:\`,等) 保持着单独的文件系统树.

有一个叫做`/etc/fstab` 的文件可以列出系统启动时要挂载的设备(典型地,硬盘分区).
下面是 来自于 Fedora7系统的`/etc/fstab` 文件实例:

```bash
LABEL=/12   /   ext3    defaults    1 1
LABEL=/home  /home   ext3    defaults    1 2
LABEL=/boot  /boot   ext3    defaults    1 2
...
```

在这个实例中所列出的大多数文件系统是虚拟的,并不适用于我们的讨论.就我们的目的而言, 前三个是我们感兴趣的:

```bash
LABEL=/12   /   ext3    defaults    1 1
LABEL=/home  /home   ext3    defaults    1 2
LABEL=/boot  /boot   ext3    defaults    1 2
```

这些是硬盘分区.每行由六个字段组成,如下所示:
***
表16-1: `/etc/fstab` 字段
字段 内容 说明

1. `设备名`: 
传统上,这个字段包含与物理设备相关联的设备文件的实际名字,比如说`/dev/hda1`(第一个IDE 通道上第一个主设备分区).
然而今天的计算机,有很多热插拔设备(像 USB 驱动设备),许多 现代的 Linux 发行版用一个文本标签和设备相关联.
当这个设备连接到系统中时, 这个标签(当储存媒介格式化时,这个标签会被添加到存储媒介中)会被操作系统读取. 
那样的话,不管赋给实际物理设备哪个设备文件,这个设备仍然能被系统正确地识别.
2. `挂载点`: 设备所连接到的文件系统树的目录.
3. `文件系统类型` : Linux 允许挂载许多文件系统类型.大多数本地的Linux 文件系统是 `ext3`,但是也支持很多其它的,比方说 `FAT16` (msdos),`FAT32` (vfat),`NTFS`(ntfs),`CD-ROM`(iso9660),等等.
4. `选项`:  文件系统可以通过各种各样的选项来挂载.例如,挂载只读的文件系统, 或者挂载阻止执行任何程序的文件系统(一个有用的安全特性,避免删除媒介.)
5. `频率`: 一位数字,指定是否和在什么时间用 `dump` 命令来备份一个文件系统.
6. `次序`: 一位数字,指定 `fsck` 命令按照什么次序来检查文件系统.

### 查看挂载的文件系统列表

这个 `mount` 命令被用来挂载文件系统.执行这个不带参数的命令,将会显示 一系列当前挂载的文件系统:

```bash
$ mount
/dev/sda2 on / type ext3 (rw)
...
```

这个列表的格式是:`设备 on 挂载点 type 文件系统类型(可选的)`.

例如,第一行所示设备`/dev/sda2` 作为根文件系统被挂载,文件系统类型是 `ext3`,并且可读可写(这个`rw`选项).

在这个列表的底部有两个有趣的条目.
倒数第二行显示了在读卡器中的一张`2G` 的 SD 内存卡,挂载到了`/media/disk` 上.
最后一行 是一个网络设备,挂载到了`/misc/musicbox` 上.

第一次实验,我们将使用一张 `CD-ROM`.首先,在插入 `CD-ROM` 之前,我们将看一下系统:

```bash
$ mount

/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)
proc on /proc type proc (rw)
```

这个列表来自于 `CentOS 5`系统,使用 `LVM`(逻辑卷管理器)来创建它的根文件系统.
正如许多现在的 Linux 发行版一样,这个 系统试图自动挂载插入的 `CD-ROM`.当我们插入光盘后,我们看看下面的输出:

```bash
$ mount
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)
proc on /proc type proc (rw)
...
/dev/hdc on /media/live-1.0.10-8 type iso9660 (ro,noexec,nosuid,
nodev,uid=500)
```

当我们插入光盘后,除了额外的一行之外,我们看到和原来一样的列表.

在列表的末尾,我们 看到 CD-ROM 已经挂载到了`/media/live-1.0.10-8`上,它的文件类型是 `iso9660(CD-ROM)`.
就我们的实验目的而言,我们对这个设备的名字感兴趣.当你自己进行这个实验时,这个 设备名字是最有可能不同的.

警告:在随后的实例中,至关重要的是你要密切注意用在你系统中的实际设备名,并且 不要使用此文本中使用的名字!
还要注意音频 CD 和 CD-ROM 不一样.音频 CD 不包含文件系统,这样在通常意义上,它就不能被挂载了.

现在我们拥有 CD-ROM 光盘的设备名字,让我们卸载这张光盘,并把它重新挂载到文件系统树 的另一个位置.
我们需要超级用户身份(使用系统相应的命令)来进行操作,并且用 `umount`(注意这个命令的拼写)来卸载光盘:

```bash
$ su -
Password:
[root@linuxbox ~]# umount /dev/hdc
```

下一步是创建一个新的光盘挂载点.简单地说,一个挂载点就是文件系统树中的一个目录.它没有什么特殊的.
它甚至不必是一个空目录,即使你把设备挂载到了一个非空目录上,你也不能看到 这个目录中原来的内容,直到你卸载这个设备.
就我们的目的而言,我们将创建一个新目录:

```bash
[root@linuxbox ~]# mkdir /mnt/cdrom
```

最后,我们把这个 CD-ROM 挂载到一个新的挂载点上.这个`-t` 选项用来指定文件系统类型:

```bash
[root@linuxbox ~]# mount -t iso9660 /dev/hdc /mnt/cdrom
```

之后,我们可以通过这个新挂载点来查看 CD-ROM 的内容:

```bash
[root@linuxbox ~]# cd /mnt/cdrom
[root@linuxbox cdrom]# ls
```

注意当我们试图卸载这个 CD-ROM 时,发生了什么事情.

```bash
[root@linuxbox cdrom]# umount /dev/hdc
umount: /mnt/cdrom: device is busy
```

这是怎么回事呢?原因是我们不能卸载一个设备,如果某个用户或进程正在使用这个设备的话.
在这种 情况下,我们把工作目录更改到了 CD-ROM 的挂载点,这个挂载点导致设备忙碌.

我们可以很容易地修复这个问题 通过把工作目录改到其它目录而不是这个挂载点.

```bash
[root@linuxbox cdrom]# cd
[root@linuxbox ~]# umount /dev/hdc
```

现在这个设备成功卸载了.

#### 为什么卸载重要

如果你看一下 `free` 命令的输出结果,这个命令用来显示关于内存使用情况的统计信息,你会看到一个统计值叫做`buffers`.
计算机系统旨在尽可能快地运行.系统运行速度的 一个阻碍是缓慢的设备.
打印机是一个很好的例子.即使最快速的打印机相比于计算机标准也 极其地缓慢.
一台计算机确实会运行地非常慢,如果它要停下来等待一台打印机打印完一页. 
在早期的个人电脑时代(多任务之前),这真是个问题.

如果你正在编辑电子表格 或者是文本文档,每次你要打印文件时,计算机都会停下来而且变得不能使用. 
计算机能以打印机可接受的最快速度把数据发送给打印机,但由于打印机不能快速地打印, 这个发送速度会非常慢.
这个问题被解决了,由于打印机缓存的出现,一个包含一些 RAM 内存 的设备,位于计算机和打印机之间.

通过打印机缓存,计算机把要打印的结果发送到这个缓存区, 数据会迅速地存储到这个 RAM 中,这样计算机就能回去工作,而不用等待.
与此同时,打印机缓存将会 以打印机可接受的速度把缓存中的数据缓慢地输出给打印机.
缓存被广泛地应用于计算机中,使其运行地更快.别让偶尔地需要读取或写入慢设备阻碍了系统的运行速度.

在实际与慢设备交互之前,操作系统会尽可能多的读取或写入数据到内存中的 存储设备里.
以 Linux 操作系统为例,你会注意到系统看似填充了多于它所需要的内存.
 这不意味着 Linux 正在使用所有的内存,它意味着 Linux 正在利用所有可用的内存,来作为缓存区.

这个缓存区允许非常快速地写入存储设备,因为写入物理设备的操作被延迟到后面进行.
同时, 这些注定要传送到设备中的数据正在内存中堆积起来.时不时地,操作系统会把这些数据 写入物理设备.

卸载一个设备需要把所有剩余的数据写入这个设备,所以设备可以被安全地移除.
如果 没有卸载设备,就移除了它,就有可能没有把注定要发送到设备中的数据输送完毕.
在某些情况下, 这些数据可能包含重要的目录更新信息,这将导致文件系统损坏,这是发生在计算机中的最坏的事情之一.

### 确定设备名称

有时很难来确定设备名称.在以前,这并不是很难.一台设备总是在某个固定的位置,也不会 挪动它.类 Unix的系统喜欢设备那样安排.
之前在开发 Unix 系统的时候,`更改一个磁盘驱动器`要用一辆 叉车从机房中移除一台如洗衣机大小的设备.

最近几年,典型的桌面硬件配置已经变得相当动态,并且 Linux 已经发展地比其祖先更加灵活.
在以上事例中,我们利用现代 Linux 桌面系统的功能来`自动地`挂载 设备,然后再确定设备名称
.
但是如果我们正在管理一台服务器或者是其它一些(这种自动挂载功能)不会 发生的环境,我们又如何能查清设备名呢?
首先,让我们看一下系统怎样来命名设备.如果我们列出目录`/dev`(所有设备的住所)的内容,我们 会看到许许多多的设备:

```bash
$ ls /dev
```

这个列表的内容揭示了一些设备命名的模式.这里有几个:
***
表16-2: Linux 存储设备名称
模式 设备

+ `/dev/fd*` 软盘驱动器
+ `/dev/hd*`老系统中的`IDE(PATA)`磁盘.
典型的主板包含两个 IDE 连接器或者是通道,每个连接器 带有一根缆线,每根缆线上有两个硬盘驱动器连接点.
缆线上的第一个驱动器叫做主设备, 第二个叫做从设备.设备名称这样安排,`/dev/hdb` 是指第一通道上的主设备名;
`/dev/hdb`是第一通道上的从设备名;`/dev/hdc`是第二通道上的主设备名,等等.末尾的数字表示 硬盘驱动器上的分区.
例如,`/dev/hda1`是指系统中第一硬盘驱动器上的第一个分区,而 `/dev/hda` 则是指整个硬盘驱动器.
+ `/dev/lp*` 打印机
+ `/dev/sd*` `SCSI` 磁盘.在最近的 Linux 系统中,内核把所有类似于磁盘的设备
(包括`PATA/SATA` 硬盘, 闪存,和 `USB` 存储设备,比如说可移动的音乐播放器和数码相机)看作 `SCSI` 磁盘. 
剩下的命名系统类似于上述所描述的旧的`/dev/hd*`命名方案.
+ `/dev/sr*` 光盘(CD/DVD 读取器和烧写器)

另外,我们经常看到符号链接比如说`/dev/cdrom`,`/dev/dvd` 和`/dev/floppy`,它们指向实际的设备文件,提供这些链接是为了方便使用.

如果你工作的系统不能自动挂载可移动的设备,你可以使用下面的技巧来决定当可移动设备连接后,它是怎样被命名的.

首先,启动一个实时查看文件`/var/log/messages` (你可能需要超级用户权限):

```bash
sudo tail -f /var/log/messages
# or in ubuantu
sudo tail -f /var/log/kern.log
```

这个文件的最后几行会被显示,然后停止.下一步,插入这个可移动的设备.

在 这个例子里,我们将使用一个16MB 闪存.瞬间,内核就会发现这个设备, 并且探测它:

```bash
Jul 23 10:07:59 linuxbox kernel:
...
sd 3:0:0:0: [sdb] 31263 512-byte
sd 3:0:0:0: [sdb] Write Protect is
...
Jul 23 10:07:59 linuxbox kernel: sdb: sdb1
Jul 23 10:07:59 linuxbox kernel: sd 3:0:0:0: [sdb] Attached SCSI
removable disk
```

显示再次停止之后,输入 `Ctrl-c`,重新得到提示符.

输出结果的有趣部分是一再提及`[sdb]`, 这正好符和我们期望的 `SCSI` 磁盘设备名称.
知道这一点后,有两行输出变得颇具启发性:

```bash
Jul 23 10:07:59 linuxbox kernel: sdb: sdb1
Jul 23 10:07:59 linuxbox kernel: sd 3:0:0:0: [sdb] Attached SCSI
removable disk
```

这告诉我们这个设备名称是`/dev/sdb` 指整个设备,`/dev/sdb1`是这个设备的第一分区.
正如我们所看到的,使用 Linux 系统充满了有趣的监测工作.

小贴士:使用这个 `tail -f /var/log/messages` 技巧是一个很不错的方法,可以实时观察系统的一举一动.

既然知道了设备名称,我们就可以挂载这个闪存驱动器了:

```bash
$ sudo mkdir
$ sudo mount
$ df
```

这个设备名称会保持不变只要设备与计算机保持连接并且计算机不会重新启动.

### 创建新的文件系统

假若我们想要用 Linux 本地文件系统来重新格式化这个闪存驱动器,而不是它现用的 `FAT32`系统.这涉及到两个步骤:

1. (可选的)创建一个新的分区布局,若已存在的分区不是我们喜欢的.
2. 在这个闪存上创建一个新的空的文件系统.

注意!在下面的练习中,我们将要格式化一个闪存驱动器.拿一个不包含有用数据的驱动器 作为实验品,因为它将会被擦除!
再次,请确定你指定了正确的系统设备名称.未能注意此警告可能导致你格式化(即擦除)错误的驱动器!

### 用 fdisk 命令操作分区

这个 `fdisk` 程序允许我们直接在底层与类似磁盘的设备(比如说硬盘驱动器和闪存驱动器)进行交互. 

使用这个工具可以在设备上编辑,删除,和创建分区.以我们的闪存驱动器为例, 
首先我们必须卸载它(如果需要的话),然后调用 `fdisk` 程序,如下所示:

```bash
$ sudo umount /dev/sdb1
$ sudo fdisk /dev/sdb
```

注意我们必须指定设备名称,必须是整个设备,而不是分区号.这个程序启动后,我们 将看到以下提示:

```bash
Command (m for help):
输入`m`会显示程序菜单:
Command action
a toggle a bootable flag
....
```

我们想要做的第一件事情是检查已存在的分区布局.输入`p`会打印出这个设备的分区表:

```bash
Disk /dev/sdb: 16 MB, 16006656 bytes
1 heads, 31 sectors/track, 1008 cylinders
Units = cylinders of 31 * 512 = 15872 bytes

Device Boot   Start         End           Blocks            Id     System
/dev/sdb1          2             1008          15608+        b        w95 FAT32
```

在此例中,我们看到一个 `16MB` 的设备只有一个分区`(1)`,此分区占用了可用的`1008`个柱面中的1006个, 并被标识为 `Windows 95 FAT32`分区.

有些程序会使用这个标志符来限制一些可以对磁盘所做的操作, 但大多数情况下更改这个标志符没有危害.
然而,为了叙述方便,我们将会更改它, 以此来表明是个 `Linux` 分区.在更改之前,首先我们必须找到被用来识别一个 `Linux` 分区的 `ID` 号码. 

在上面列表中,我们看到 `ID` 号码`b`被用来指定这个已存在的分区.
要查看可用的分区类型列表, 参考之前的程序菜单.我们会看到以下选项:

`l list known partition types`

如果我们在提示符下输入`l`,就会显示一个很长的可能类型列表.
在它们之中会看到`b`为已存在分区 类型的 `ID` 号,而`83`是针对 Linux 系统的 `ID` 号.
回到之前的菜单,看到这个选项来更改分区 `ID` 号:

`t change a partition's system id`

我们先输入`t`,再输入新的 `ID` 号:

```bash
Command (m for help): t
Selected partition 1
Hex code (type L to list codes): 83
Changed system type of partition 1 to 83 (Linux)
```

这就完成了我们需要做得所有修改.
到目前为止,还没有实际接触这个设备(所有修改都存储在内存中, 而不是在此物理设备中),所以我们将会把修改过的分区表写入此设备,再退出.
为此,我们输入 在提示符下输入`w`:

```bash
Command (m for help): w
The partition table has been altered!
Calling ioctl() to re-read partition table.
WARNING: If you have created or modified any DOS 6.x
partitions, please see the fdisk manual page for additional
information.
Syncing disks.
$
```

如果我们已经决定保持设备不变,可在提示符下输入`q`,这将退出程序而没有写更改.
我们 可以安全地忽略这些不祥的警告信息.

### 用mkfs命令创建一个新的文件系统

完成了分区编辑工作(它或许是轻量级的),是时候在我们的闪存驱动器上创建一个新的文件系统了. 

为此,我们会使用 `mkfs`(make file system 的简写),它能创建各种格式的文件系统. 
在此设备上创建一个 `ext3`文件系统,我们使用`-t` 选项来指定这个`ext3`系统类型,随后是我们要格式化的设备分区名称:

创建`ext4`格式的文件系统，可以使用`mkfs.ext4 `

```bash
$ sudo mkfs -t ext3 /dev/sdb1
mke2fs 1.40.2 (12-Jul-2007)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
...
```

当 `ext3` 被选为文件系统类型时,这个程序会显示许多信息.
若把这个设备重新格式化为它最初的`FAT32`文件系统,指定`vfat`作为文件系统类型:

```bash
$ sudo mkfs -t vfat /dev/sdb1
```

任何时候添加额外的存储设备到系统中时,都可以使用这个分区和格式化的过程.

虽然我们只以一个小小的闪存驱动器为例,同样的操作可以被应用到内部硬盘和其它可移动的存储设备上像 USB 硬盘驱动器.

### 测试和修复文件系统

在之前讨论文件`/etc/fstab` 时,我们会在每行的末尾看到一些神秘的数字.
每次系统启动时, 在挂载系统之前,都会按照惯例检查文件系统的完整性.

这个任务由 fsck 程序(是`file system check`的简写)完成.每个 `fstab` 项中的最后一个数字指定了设备的检查顺序.
在上面的实例中,我们看到首先检查根文件系统,然后是 `home` 和 `boot` 文件系统. 若最后一个数字 是零则相应设备不会被检查.

除了检查文件系统的完整性之外,`fsck` 还能修复受损的文件系统,其成功度依赖于损坏的数量. 
在类 Unix 的文件系统中,文件恢复的部分被放置于 `lost+found` 目录里面,位于每个文件系统的根目录下面.

检查我们的闪存驱动器(首先应该卸载),我们能执行下面的操作:

```bash
$ sudo fsck /dev/sdb1
fsck 1.40.8 (13-Mar-2008)
e2fsck 1.40.8 (13-Mar-2008)
/dev/sdb1: clean, 11/3904 files, 1661/15608 blocks
```

以我的经验,文件系统损坏情况相当罕见,除非硬件存在问题,如磁盘驱动器故障. 
在大多数系统中,系统启动阶段若探测到文件系统已经损坏了,则会导致系统停止下来, 在系统继续执行之前,会指导你运行 `fsck` 程序.

#### 什么是 fsck?

在 Unix 文化中,`fsck`这个单词往往会被用来代替一个流行的词,`fsck`和这个词共享了三个字母.
尤其适用于,当你不得不使用 `fsck` 命令时,你可能会说出这个词汇.

### 格式化软盘

对于那些还在使用配备了软盘驱动器的计算机的用户,我们也能管理这些设备.

准备一 张可用的空白软盘要分两个步骤.首先,对这张软盘执行低级格式化,然后创建一个文件系统. 
为了完成格式化,我们使用 `fdformat` 程序,同时指定软盘设备名称(通常为`/dev/fd0`):

```bash
$ sudo fdformat /dev/fd0
Double-sided, 80 tracks, 18 sec/track. Total capacity 1440 kB.
Formatting ... done
Verifying ... done
```

接下来,通过 `mkfs` 命令,给这个软盘创建一个 `FAT` 文件系统:

```bash
$ sudo mkfs -t msdos /dev/fd0
```

注意我们使用这个`msdos`文件系统类型来得到旧(小的)风格的文件分配表.
当一个软磁盘被准备好之后,则可能像其它设备一样挂载它.

### 直接把数据移入/出设备

虽然我们通常认为计算机中的数据以文件形式来组织数据,但也可以按`原始的`形式来考虑数据. 

如果我们能看到磁盘驱动器上的数据,我们会发现它由大量的`数据块`组成,而操作系统把这些数据块看作目录和文件.
然而,如果把磁盘驱动器简单地看成一个数据块大集合,我们就能执行有用的任务,如克隆设备.

`dd` 程序能执行此任务.它可以把数据块从一个地方复制到另一个地方.它使用独特的语法(由于历史原因):

```bash
dd if=input_file of=output_file [bs=block_size [count=blocks]]
```

比方说我们有两个相同容量的 USB 闪存驱动器,并且要精确地把第一个驱动器(中的内容) 复制给第二个.
如果连接两个设备到计算机上,它们各自被分配到设备`/dev/sdb` 和 `/dev/sdc `上,
这样我们就能通过下面的命令把第一个驱动器中的所有数据复制到第二个驱动器中.

```bash
dd if=/dev/sdb of=/dev/sdc
```

或者,如果只有第一个驱动器被连接到计算机上,我们可以把它的内容复制到一个普通文件中供以后恢复或复制数据:

```bash
dd if=/dev/sdb of=flash_drive.img
```

警告!这个 `dd` 命令非常强大.
虽然它的名字来自于`数据定义`,有时候也把它叫做`清除磁盘` 因为用户经常会误输入 `if` 或 `of` 的规范.
在按下回车键之前,要再三检查输入与输出规范!

### 创建 CD-ROM 映像

写入一个可记录的 CD-ROM(一个 CD-R 或者是 CD-RW)由两步组成:
首先,构建一个 iso 映像文件, 这就是一个 CD-ROM 的文件系统映像,
第二步,把这个映像文件写入到 CD-ROM 媒介中.

#### 创建一个 CD-ROM 的映像拷贝

如果想要制作一张现有 CD-ROM 的 iso 映像,我们可以使用 dd 命令来读取 CD-ROM 中的所有数据块, 并把它们复制到本地文件中.

比如说我们有一张 Ubuntu CD,用它来制作一个 iso 文件,以后我们可以用它来制作更多的拷贝.
插入这张 CD 之后,确定 它的设备名称(假定是`/dev/cdrom`),然后像这样来制作 iso 文件:

```bash
dd if=/dev/cdrom of=ubuntu.iso
```

这项技术也适用于 DVD 光盘,但是不能用于音频 CD,因为它们不使用文件系统来存储数据.
对于音频 CD,看一下 `cdrdao` 命令.

#### 从文件集合中创建一个映像

创建一个包含目录内容的 iso 映像文件,我们使用 `genisoimage` 程序.

为此,我们首先创建 一个目录,这个目录中包含了要包括到此映像中的所有文件,然后执行这个 `genisoimage` 命令 来创建映像文件.

例如,如果我们已经创建一个叫做`~/cd-rom-files` 的目录,
然后用文件 填充此目录,再通过下面的命令来创建一个叫做 `cd-rom.iso` 映像文件:

```bash
genisoimage -o cd-rom.iso -R -J ~/cd-rom-files
```

`-R`选项添加元数据为 Rock Ridge 扩展,这允许使用长文件名和 POSIX 风格的文件权限.
同样地,这个`-J`选项使 Joliet 扩展生效,这样 Windows 中就支持长文件名了.

#### 一个有着其它名字的程序...

如果你看一下关于创建和烧写光介质如 CD-ROMs 和 DVD 的在线文档,你会经常碰到两个程序 叫做 `mkisofs` 和 `cdrecord` .
这些程序是流行软件包`cdrtools`的一部分,`cdrtools`由 Jorg Schilling 编写成.

在2006年春天,Schilling 先生更改了部分 cdrtools 软件包的协议,Linux 社区许多人的看法是, 这创建了一个与 `GNU GPL` 不相兼容的协议.
结果,就 `fork` 了这个 `cdrtools` 项目, 目前新项目里面包含了 `cdrecord` 和 `mkisofs` 的替代程序,分别是 `wodim` 和 `genisoimage` .

### 写入 CD-ROM 镜像

有了一个映像文件之后,我们可以把它烧写到光盘中.下面讨论的大多数命令对可 记录的 CD-ROM 和 DVD 媒
介都适用.

#### 直接挂载一个 ISO 镜像

有一个诀窍,我们可以用它来挂载 `iso` 映像文件,虽然此文件仍然在我们的硬盘中,但我们当作它已经在光盘中了.

添加 `-o loop` 选项来挂载(同时带有必需的 `-t iso9660` 文件系统类型), 挂载这个映像文件就好像它是一台设备,把它连接到文件系统树上:

```bash
mkdir /mnt/iso_image
mount -t iso9660 -o loop image.iso /mnt/iso_image
```

上面的示例中,我们创建了一个挂载点叫做`/mnt/iso_image`,然后把此映像文件 `image.iso` 挂载到挂载点上.

映像文件被挂载之后,可以把它当作,就好像它是一张 真正的 CD-ROM 或者 DVD.当不再需要此映像文件后,记得卸载它.

#### 清除一张可重写入的 CD-ROM

可重写入的 CD-RW 媒介在被重使用之前需要擦除或清空.为此,我们可以用 `wodim` 命令,指定 设备名称和清空的类型.
`wodim` 程序提供了几种清空类型.最小(且最快)的是 `fast` 类型:

```bash
wodim dev=/dev/cdrw blank=fast
```

#### 写入镜像

写入一个映像文件,我们再次使用 `wodim` 命令,指定光盘设备名称和映像文件名:

```bash
wodim dev=/dev/cdrw image.iso
```

除了设备名称和映像文件之外,`wodim` 命令还支持非常多的选项.
常见的两个选项是,`-v` 可详细输出, 和`-dao` 以 `disk-at-once` 模式写入光盘.

如果你正在准备一张光盘为的是商业复制,那么应该使用这种模式.
`wodim` 命令的默认模式是 track-at-once,这对于录制音乐很有用.

拓展阅读

我们刚才谈到了很多方法,可以使用命令行管理存储介质.看看我们所讲过命令的手册页. 一些命令支持大量的选项和操作.
此外,寻找一些如何添加硬盘驱动器到 Linux 系统(有许多)的在线教程, 这些教程也要适用于光介质存储设备.

友情提示

通常验证一下我们已经下载的 iso 映像文件的完整性很有用处.
在大多数情况下,iso 映像文件的贡献者也会提供 一个 `checksum` 文件.
一个 `checksum` 是一个神奇的数学运算的计算结果,这个数学计算会产生一个能表示目标文件内容的数字.
如果目标文件的内容即使更改一个二进制位,`checksum` 的结果将会非常不一样. 

`生成checksum` 数字的最常见方法是使用 `md5sum` 程序.当你使用 `md5sum` 程序的时候, 它会产生一个独一无二的十六进制数字:

```bash
md5sum image.iso
34e354760f9bb7fbf85c96f6a3f94ece
image.iso
```

当你下载完映像文件之后,你应该对映像文件执行 `md5sum` 命令,然后把运行结果与发行商提供的 `md5sum` 数值作比较.

除了检查下载文件的完整性之外,我们也可以使用 `md5sum` 程序验证新写入的光学存储介质. 

为此,首先我们计算映像文件的 `checksum` 数值,然后计算此光学存储介质的 `checksum` 数值. 
这种验证光学介质的技巧是限定只对 光学存储介质中包含映像文件的部分计算 checksum 数值.
通过确定映像文件所包含的 2048 个字节块的数目(光学存储介质总是以 2048 个字节块的方式写入) 并从存储介质中读取那么多的字节块,我们就可以完成操作.

某些类型的存储介质,并不需要这样做.一个以 disk-at-once 模式写入的 CD-R,可以用下面的方式检验:

```bash
md5sum /dev/cdrom
34e354760f9bb7fbf85c96f6a3f94ece
/dev/cdrom
```

许多存储介质类型,如 DVD 需要精确地计算字节块的数目.

在下面的例子中,我们检验了映像文件 `dvd-image.iso `以及 DVD 光驱中磁盘 `/dev/dvd` 文件的完整性.
你能弄明白这是怎么回事吗?

```bash
md5sum dvd-image.iso
dd if=/dev/dvd bs=2048 count=$(( $(stat -c "%s" dvd-image.iso) / 2048 )) |  md5sum
```

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
然而这些程序,拥有和 `ftp` 程序 一样的致命缺点;它们以明码形式来传输所有的交流信息(包括登录命令和密码).
这使它们完全不 适合使用在因特网时代.

### ssh

为了解决这个问题,开发了一款新的协议,叫做 SSH(Secure Shell). SSH 解决了这两个基本的和远端主机安全交流的问题.

首先,它要认证远端主机是否为它 所知道的那台主机(这样就阻止了所谓的`中间人`的攻击),
其次,它加密了本地与远程主机之间 所有的通讯信息.

`SSH` 由两部分组成.

`SSH `**服务器**运行在远端主机上运行,在端口号`22`上监听将要到来的连接,而 `SSH` **客户端**用在本地系统中,用来和远端服务器通信.

大多数 Linux 发行版自带一个提供 SSH 功能的软件包,叫做 `OpenSSH`,来自于 `BSD` 项目.
一些发行版 默认包含客户端和服务器端两个软件包(例如,`Red Hat`),而另一些(比方说 `Ubuntu`)则只是提供客户端服务.
为了能让系统接受远端的连接,它必须安装 `OpenSSH-server` 软件包,配置运行它, 并且须允许它在 `TCP` 端口号上接收网络链接(如果系统运在防火墙之后) .

小贴示:如果你没有远端系统去连接,但还想试试这些实例,则确认安装了 `OpenSSH-server` 软件包 ,则可使用 `localhost` 作为远端主机的名字.这种情况下,计算机会和它自己创建网络连接.

用来与远端 `SSH` 服务器相连接的 `SSH` 客户端程序,顺理成章,叫做 `ssh`. 连接到远端名为 `remote-sys` 的主机,我们可以这样使用 `ssh` 客户端程序:

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

### scp 和  sftp

这个 `OpenSSH` 软件包也包含两个程序,它们可以利用 `SSH` 加密通道在网络间复制文件. 第一个:`scp`(安全复制)被用来复制文件,与熟悉的 `cp` 程序非常相似.
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

`sftp` 有一个 重要特性强于传统的 `ftp` 命令,就是 `sftp` 不需要远端系统中运行 `FTP` 服务器.它仅仅要求 `SSH` 服务器.
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

小贴示:这个 `SFTP` 协议被许多 `Linux` 发行版中的图形化文件管理器支持.
使用 `Nautilus` (GNOME), 或者是 `Konqueror` (KDE),我们都能在位置栏中输入以 `sftp://` 开头的 URI, 来操作存储在运行着 SSH 服务器的远端系统中的文件.

### Windows 中的 SSH 客户端

比方说你正坐在一台 Windows 机器前面,但是你需要登录到你的 Linux 服务器中,去完成 一些实际的工作,那该怎么办呢?
当然是得到一个 Windows 平台下的 SSH 客户端!有很多这样 的工具.

最流行的可能就是由 Simon Tatham 和他的团队开发的 `PuTTY` 了.
这个 `PuTTY` 程序 能够显示一个终端窗口,而且允许Windows 用户在远端主机中打开一个 SSH(或者 telnet)会话.
这个程序也提供了 `scp` 和 `sftp` 程序的类似物.

[PuTTY链接](http://www.chiark.greenend.org.uk/~sgtatham/putty/)

拓展阅读

Linux 文档项目提供了 Linux 网络管理指南,可以广泛地(虽然过时了)了解网络管理方面的知识.

[http://tldp.org/LDP/nag2/index.html](http://tldp.org/LDP/nag2/index.html)

`Wikipedia` 上包含了许多网络方面的优秀文章.这里有一些基础的:

[http://en.wikipedia.org/wiki/Internet_protocol_address](http://en.wikipedia.org/wiki/Internet_protocol_address)
[http://en.wikipedia.org/wiki/Host_name](http://en.wikipedia.org/wiki/Host_name)
[http://en.wikipedia.org/wiki/Uniform_Resource_Identifier](http://en.wikipedia.org/wiki/Uniform_Resource_Identifier)

### ssh ipv6

[Linux下通过IPv6使用SSH和SCP](http://beanocean.github.io/tech/2014/10/17/scp_ipv6/)

解决这个问题的主要思路有两个，第一个是在路由器上设置`NAT`，进行端口映射；
第二个便是利用`IPv6`登录。其中，`IPv6`的方式最方便（Linux默认是开启`IPv6`服务的），无须多余设置，只需要知道`IPv6`地址即可。
具体方法如下：（假设`IPv6`地址为`2101:da8:a000:12:bc26:9915:4b1d:64cc`）

***
`ssh`远程登录服务器

```bash
# 用法:
ssh [username]@[IPv6_Host] -p [port number]
# 例子:
ssh lg@2101:da8:a000:12:bc26:9915:4b1d:64cc -p 1234
```

***
`SCP`拷贝文件

```bash
# 用法;
scp [username]@[IPv6_Host]:[file_path] [target_path]
# 例子:
scp lg@\[2101:da8:a000:12:bc26:9915:4b1d:64cc\]:/home/lg/example.c ~/home/lg/src
```

这里需要注意的是，由于`IPv6`地址中的冒号和`host`中的冒号有冲突，需要用中括号加转义字符的方式把`IPv6`的地址括起来。

### 补充:ssh的使用

***
连接服务器

[Linux SSH 使用](https://www.jianshu.com/p/e6d308e9162f)

确认安装好`ssh`并启动后,我们在`windows`、`mac`上或者其他`linux`服务器上通过以下命令便可以连接到这台主机

```bash
ssh root@192.168.0.105
```

`root` 表示你连接改服务器的用户名

`192.168.0.105` 是服务器`ip`.这个`ip`不能使用内网`ip`,如果是本地虚拟机的话,可以将连接方式改为`桥接`的方式.
然后用`ifconfig`查看本机公网`ip`

***
`ssh` 的 `config` 文件

先展示一下`SSH config` 语法关键字,如下五个：

+ `Host` 别名
+ `HostName` 主机名
+ `Port` 端口
+ `User` 用户名
+ `IdentityFile` 密钥文件的路径

这个`config`的路径在服务的位置是 `~/.ssh/config` 如果没有找到这个文件,就在`>~/.ssh/config`

那么说到这个文件我们怎么用呢？
实际上在平时的运维管理中,我们可能管理多台机器,可能是几台,十几台甚至上百台.
我们将这些服务器配置在`config`中,方便我们去连接和管理.

例如:(`IdentityFile`可以暂时不配置,`ssh`默认端口为`22`)

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

***
SSH免密登录ssh-keygen

[Linux 配置SSH免密登录`ssh-keygen`](https://www.jb51.net/article/163093.htm)

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

1. 在指定目录下生成`rsa`密钥, 并指定注释为`xxx`, 实现示例:

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

`-i identity_file`

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
将`A`的公钥文件发给`B`:

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

***
windows 免密码登录

`windows`中生成密钥：可以在`Xshell`中也可以达到类似效果,这种方式生成了密钥之后,可以将之保存起来.
当然也可以通过其他方式例如`git bash`中用`linux`指令生成,在这里不详细描述了.

那么我们怎么使用这个生成好的`ssh key`呢.
为了达到免密码的登录过程,我们需要将公钥放置在`authorized_keys`这个文件中.

我们需要先进入linux服务器,将我们选择的这个 `id_rsa_2048.pub` 的内容放置到linux服务器的`authorized_keys`文件中.
这样的话我们再访问就可以无密码连接了.

***
ssh 安全端口

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
