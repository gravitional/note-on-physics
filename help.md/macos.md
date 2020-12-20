# macos

## homebrew

`Homebrew` 是一款 Mac OS 平台下的软件包管理工具，拥有安装, 卸载, 更新, 查看, 搜索等很多实用的功能。

`Homebrew` 的两个术语：

`Formulae` ：软件包，包括了这个软件的依赖, 源码位置及编译方法等；
`Casks`：已经编译好的应用包，如图形界面程序等。
`Homebrw`相关的几个文件夹用途：

`bin` ：用于存放所安装程序的启动链接（相当于快捷方式）
`etc` ：`brew` 安装程序的配置文件默认存放路径
`Library`：`Homebrew` 系统自身文件夹
`Cellar` ：通过 `brew` 安装的程序将以 `[程序名/版本号]` 存放于本目录下
常用的 `brew` 命令：

查看`brew`版本：`brew -v`
更新`brew`版本：`brew update`
本地软件库列表：`brew list`
查看软件库版本：`brew list --versions`
查找软件包：`brew search xxx` （xxx为要查找软件的关键词）
安装软件包：`brew install xxx` （xxx为软件包名称）
卸载软件包：`brew uninstall xxx`
安装软件：`brew cask install xxx`（xxx为软件名称）
卸载软件：`brew cask uninstall xxx`
查找软件安装位置：`which xxx` （xxx为软件名称）
`Homebrew` 提供了两种安装软件的方式，`brew install` 和 `brew cask install`，下面对两种方式进行一些解释说明。

### brew install

`brew` 是下载源码解压，然后 `./configure && make install` ，同时会包含相关依存库，并自动配置好各种环境变量。
对于对程序员只需通过简单的指令，就能快速安装和升级本地的各种开发环境，非常快捷方便。

### brew cask install

`brew cask` 是针对已经编译好了的应用包（`.dmg/.pkg`）下载解压，然后放在统一的目录中（`Caskroom`），省掉了自己下载, 解压, 安装等步骤。
这个对一般用户来说会比较方便，包含很多在 `AppStore` 里没有的常用软件。

简单来说，

`brew install` 用来安装一些不带界面的命令行工具和第三方库。
`brew cask install` 用来安装一些带界面的应用软件。

[brew install 和 brew cask install 的区别](https://zhuanlan.zhihu.com/p/138059447)

## mac 自带的中文字体

查找 `字体册`, `font Book.app`应用.

`macos` 的字体存放在`/System/Library/Fonts`目录下，`macos` 预装的中文字体为，

```bash
Apple LiGothic Medium
Apple LiSung Light
Apple SD Gothic Neo Regular
AppleGothic Regular
AppleMyungjo Regula
Baoli SC Regular
BiauKai Regular
GB18030 Bitmap Regular
Hannotate SC Regular
HanziPen SC Regular
Hei Regular
Heiti TC Light
Hiragino Sans CNS W3
Hiragino Sans GB W3
Kai Regular
Kaiti SC Regular
Lantinghei SC Extralight
Libian SC Regular
LiHei Pro Medium
LingWai SC Medium
LiSong Pro Light
Nanum Gothic Regular
PCMyungjo Regular
PingFang SC Regular
SimSong Regular
Songti SC Regular
STFangsong Regular
STHeiti Light
STKaiti Regular
STSong Regular
Wawati SC Regular
Weibei SC Bold
Xingkai SC Light
Yuanti SC Regular
Yuppy SC Regular
```

## mounty for NTFS

[Mounty for NTFS](https://mounty.app/)

一个微型工具，用于以读写模式在macOS下重新 mount write-protected `NTFS` 。

 相当于指令

```bash
$ sudo umount /Volumes/UNTITLED
$ sudo mount -t ntfs -o rw,auto,nobrowse /dev/disk3s1 ~/ntfs-volume
```

## diskutil

[MacOS 磁盘管理工具 diskutil 介绍](https://www.jianshu.com/p/6a1f365617ad)

电脑上的操作系统, 应用程序和应用数据一般都需要保存在永久存储器中（通常就是硬盘），这样电脑断电后应用数据等就不会丢失。
为了更有效地组织磁盘上的数据信息，通常将磁盘预先划分成一个或多个磁盘分区，创建对应的文件系统，以方便计算机对各分区分别进行管理。
MacOS 系统自带一个图形化的磁盘管理工具（Disk Utility），同时还有一个命令行版本的 diskutil。
通过该命令的使用，可以很快捷地对本地磁盘进行擦除数据, 调整分区大小, 格式化等操作。

`diskutil` 命令的格式为：`diskutil <verb> <options>`

### verb

不带任何选项的 `diskutil` 命令会列出该命令支持的 `verb` 及其对应的介绍：

```bash
 diskutil
Disk Utility Tool
Utility to manage local disks and volumes
```

列出的 `verb` 主要分为以下几类：

+ 获取磁盘和分区信息：如 `list`, `info`, `activity` 等
+ 挂（卸）载磁盘或卷：如 `mount`, `eject`, `mountDisk` 等
+ 验证, 修复磁盘分区或文件系统：如 `verifyVolume`, `repairDisk` 等
+ 分区操作：如 `splitPartitions`, `mergePartitions` 等
+ 其他：如 `appleRAID`, `apfs` 等

如不清楚某个 `verb` 的具体命令格式，可以直接使用 `diskutil` 命令加上该 `verb` 并且不带任何其他选项，命令行即输出该 `verb` 的使用介绍。
如 `eraseDisk` 的使用介绍：

```bash
$   diskutil eraseDisk
Usage:  diskutil eraseDisk format name [APM[Format]|MBR[Format]|GPT[Format]]
        MountPoint|DiskIdentifier|DeviceNode
```

完全擦除现有的整个磁盘。 清除磁盘上的所有内容， 需要磁盘的所有权。
`Format`是你擦除之后，重新格式化要得到的格式（`HFS+`等）。例如:

```bash
diskutil eraseDisk JHFS+ UntitledUFS disk3
```

### 获取磁盘分区信息

#### list

可以使用 `list` 选项简要列出 MacOS 系统的磁盘及分区信息，包括分区类型（TYPE）, 分区名（NAME）, 容量大小（SIZE）和标志符（IDENTIFIER）等。
如此时系统挂载了 `dmg` 映像文件，其信息也会显示在列表中（下表中的 disk3 ）。

```bash
$   diskutil list
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *121.3 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                 Apple_APFS Container disk1         121.1 GB   disk0s2
   ...
```

其中的 `/dev/disk0` 为内置磁盘，`/dev/disk2` 为外置磁盘（U 盘，已在 Windows 系统下格式化为 `FAT32` 格式），`/dev/disk3` 为 `DMG` 映像文件。
而 `/dev/disk1` 其实就是 `disk0s2` 作为 `APFS` 文件系统容器的具体信息。

#### info

`info` 选项可以列出指定磁盘或分区的详细信息。如查看 `disk2` （即 8 G 优盘）的信息：

```bash
 diskutil info disk2
   Device Identifier:        disk2
   Device Node:              /dev/disk2
   Whole:                    Yes
   Part of Whole:            disk2
   Device / Media Name:      DataTraveler 2.0
   ...
```

输出的信息包括设备标志符（Device Identifier）, 设备节点（Device Node）, 设备名（Device / Media Name）, 容量大小（Disk Size）, 块大小（Block Size）等。

也可以查看某个分区的详细信息：

```bash
 diskutil info disk1s1
   Device Identifier:        disk1s1
   Device Node:              /dev/disk1s1
   Whole:                    No
   Part of Whole:            disk1
   ...
```

### 擦除磁盘或分区

`eraseDisk` 选项用于擦除整个磁盘并重新格式化。该命令的格式为：

```bash
diskutil eraseDisk <format> <name> [APM|MBR|GPT] MountPoint|DiskIdentifier|DeviceNode
```

`format` 用于指定擦除数据后需要重新建立的文件系统类型。可以为 `%noformat%` 来跳过初始化文件系统的操作。其他支持的类型可以通过 `listFilesystems` 选项查看。

```bash
$   diskutil listFilesystems
Formattable file systems
...
```

可以使用 `diskutil eraseDisk ExFAT StarkyDisk disk2` 命令将优盘数据擦除并格式化为 `ExFAT` 格式。

```bash
$   diskutil eraseDisk ExFAT StarkyDisk disk2
Started erase on disk2
Unmounting disk
...
```

此时的优盘分区表变为 `GPT` 类型，且多了一个 `EFI` 分区。

也可以在擦除磁盘时指定分区表类型：

```bash
$   sudo diskutil eraseDisk ExFAT StarkyDisk MBR disk2
Password:
Started erase on disk2
```

此时的优盘分区表变为 MBR 类型：

其他擦除命令如 `eraseVolume` （完全擦除整个磁盘或某个磁盘分区，创建新的文件系统）, `zeroDisk` （向整个磁盘或某个分区全部写入`'0'`）
使用 `zeroDisk` 命令擦除磁盘（该过程会花费很长的时间，我试了）后，该磁盘上的全部信息被抹除，同时也不再包含分区和文件系统信息.
则再次插入此优盘会提示你`初始化`或`格式化`该磁盘。

### 创建磁盘分区

可以通过 `partionDisk` 选项完成对磁盘的分区操作。该命令的格式为：

```bash
diskutil partitionDisk MountPoint|DiskIdentifier|DeviceNode
        [numberOfPartitions] [APM|MBR|GPT]
        [part1Format part1Name part1Size part2Format part2Name part2Size
         part3Format part3Name part3Size ...]
```

命令选项中的 `Size` 用来指定分区的大小（以扇区数计量），合法的值包括带有指定后缀的浮点数。
其中的后缀有 `B(ytes)`, `S(512-byte-blocks)`, `K(ilobytes)`, `M(egabytes)`, `G(igabytes)`, `T(erabytes),` `P(etabytes)`，
也可以是 `%` 来表示对整个磁盘的占比。
最后一个分区会自动扩展到占用整个磁盘的剩余空间，如果想为最后一个分区指定固定的大小，可在其后再创建一个类型为`free space`的分区。

```bash
$   sudo diskutil partitionDisk disk2 3 MBR MS-DOS F01 3G JHFS+ F02 3G "Free Space" F03 0
Started partitioning on disk2
Unmounting disk
...
```

上面的命令在优盘（`disk2`）上创建了 3 个分区，第一个（F01）格式为 `FAT32`，大小是 `3 Gb`。第二个（F02）格式为 `JHFS+`，大小为 `3 Gb`。
最后一个是`自由空间`，大小为剩余的容量。所以实际上只是分了两个区，整体的分区表类型为 `MBR` 。

### 分割/合并磁盘分区

`splitPartition` 选项可以用来将已存在的某个分区再分割成数个更小的分区，注意原分区上的所有数据都会丢失。
该选项的第一个参数为需要分割的分区的`挂载点`/`标志符`/`设备节点`，其余参数和使用 `partitionDisk` 时相同。

```bash
$   sudo diskutil list | grep disk2
/dev/disk2 (external, physical):
   0:      GUID_partition_scheme                        *7.8 GB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS starky                  7.5 GB     disk2s2
$   sudo diskutil splitPartition disk2s2 2 MS-DOS F01 3g JHFS+ F02 3g
Started partitioning on disk2s2 starky
Splitting
```

上面的命令将优盘的第二个分区（`disk2s2`）又分割成了两个更小的分区，分别是 `FAT32` 格式的 `F01`（`disk2s2`），和 `JHFS+` 格式的 F02（`disk2s3`）。
虽然命令中指定了 F02 的大小是 `3G`，因为是最后一个分区，所以自动扩展到占用剩余的磁盘空间。最后它的实际大小是 `4.5G`。

`mergePartitions` 选项用来将多个已存在的分区合并为一个大的分区。该选项的格式为：

```bash
diskutil mergePartitions [force] format name DiskIdentifier|DeviceNode DiskIdentifier|DeviceNode
```

第一个分区参数为起始分区，第二个分区参数为结束分区。这两个分区之间的所有分区都将被合并。
如果 `force` 选项没有被指定，且合并前的第一个分区是可调整大小的文件系统（如 `JHFS+`），则第一个分区上的数据会保留到合并后的分区。

```bash
$   sudo diskutil list | grep disk2
/dev/disk2 (external, physical):
   0:      GUID_partition_scheme                        *7.8 GB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS F01                     2.9 GB     disk2s2
   3:       Microsoft Basic Data F02                     4.5 GB     disk2s4
$   sudo diskutil mergePartitions JHFS+ Starky disk2s2 disk2s4
Merging partitions into a new partition
...
```

### 调整分区大小（无损）

`resizeVolume` 选项可以无损调整（增加或缩减）分区大小。

将 `disk2s2` 分区缩减为 `4g` 大小，腾出的空间作为`free space`：

```bash
$   diskutil list | grep disk2
/dev/disk2 (external, physical):
   0:      GUID_partition_scheme                        *7.8 GB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS F01                     7.5 GB     disk2s2
$   sudo diskutil resizeVolume disk2s2 4g
Resizing to 4000000000 bytes
```

将 `disk2s2` 分区扩展，并尽可能占用所有可用的自由空间。

```bash
$   sudo diskutil resizeVolume disk2s2 R
Resizing to full size (fit to fill)
...
/dev/disk2 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *7.8 GB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS F01                     7.5 GB     disk2s2

```
