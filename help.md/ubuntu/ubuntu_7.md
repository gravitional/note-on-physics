# ubuntu_7

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

`gzip` 程序被用来压缩一个或多个文件.当执行 `gzip` 命令时,原始文件的压缩版会替代原始文件.
相对应的 `gunzip` 程序用来把压缩文件复原.这里有个例子:

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

这里,我们用压缩文件来替代文件 `foo.txt`,压缩文件名为 `foo.txt.gz`. 下一步,我们测试了压缩文件 的完整性,使用了`-t` 和 `-v` 选项.

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

`bzip2` 程序,由 Julian Seward 开发,与 `gzip` 程序相似,但使用了不同的压缩算法, 舍弃了压缩速度,从而实现了更高的压缩级别. 在大多数情况下,它的工作模式等同于 `gzip` . 
由 `bzip2` 压缩的文件,用扩展名 `.bz2`来表示:

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

`zip` 程序既是压缩工具,也是一个打包工具. 它读取和写入 `.zip` 文件, `Windows` 用户比较熟悉这种文件格式.
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

### 7z解压缩

支持的格式

`LZMA2`, `XZ`, `ZIP`, `Zip64`, `CAB`, `RAR` (如果安装了 non-free `p7zip-rar`包),
`ARJ`,  `GZIP`, `BZIP2`, `TAR`, `CPIO`, `RPM`, `ISO`

用法: `7z <command> [<switches>...] <archive_name> [<file_names>...] [<@listfiles...>]`

解压缩,输入密码,并保持目录结构:

`7z x -p1234 filename`

压缩单个文件

`7z a -t7z archive_name filename`

压缩txt中的文件

`7z a -t7z configrc.win.7z @tom.rc_list.win`
`7z a -t7z configrc.linux.7z @tom.rc_list.linux`

`<Commands>`

+ `a` : 添加文件到归档中
+ `b` : Benchmark
+ `d` : 从归档中删除
+ `e` : 从归档中提取（不使用目录名）
+ `h` : 计算文件的 hash 值
+ `i` : 展示支持的格式
+ `l` : 列出归档的内容
+ `rn` : 重命名归档中的文件
+ `t` : 检查归档的完整性
+ `u` : 把文件更新到归档
+ `x` : 提取文件，使用全路径(也就是保持文件结构)

`<Switches>`

+ `--` : Stop switches parsing
+ `-o{Directory}` : 设置输出目录
+ `-p{Password}` : 设置密码
+ `-r[-|0]` : 递归子目录
+ `-y` : 所有 queries 回答 yes
+ `-t{Type}`设置归档的 type

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

## linux 内核编码风格

[Linux 内核代码风格](https://www.kernel.org/doc/html/latest/translations/zh_CN/process/coding-style.html)
[Linux 内核编码风格](https://zhuanlan.zhihu.com/p/330280764)

### 括号

左括号紧跟在语句的最后，与语句在相同的一行。而右括号要另起一行，作为该行的第一个字符。
如果接下来的部分是相同语句的一部分，那么右括号就不单独占一行。

```c
if ... {
              if ... {
              ...
              } else {
              ...
                     } 
       }
return ... ;

do {
...
} while ( ...);
```

函数采用以下的书写方式：

```c
static inline int rt_policy(int policy)
{
              ...
}
```

最后不需要一定使用括号的语句可以忽略它：

```c
if (a==b)
              return 0;
return 1;
```

### 每行代码的长度

要尽可能地保证代码长度不超过80个字符，如果代码行超过`80`应该折到下一行。
将参数分行输入，在开头简单地加入两个标准tab：

```c
static int wait_noreap_copyout ( a, b, c, ...
              d,e,f )
{
       
}
```

### 命名规范

名称中不允许使用混合的大小写字符。
局部变量如果能够清楚地表明它的用途，那么选取`idx`甚至是i这样的名称都是可行的。
而像`theLoopIndex`这样冗长反复的名字不在接受之列。——匈牙利命名法（在变量名称中加入变量的类别）危害极大。

### 函数

根据经验函数的代码长度不应该超过两屏，局部变量不应该超过十个。

+ 一个函数应该功能单一并且实现精准。
+ 将一个函数分解成一些更短小的函数的组合不会带来危害。——如果你担心函数调用导致的开销，可以使用inline关键字。

### 注释

一般情况下，注释的目的是描述你的代码要做什么和为什么要做，而不是具体通过什么方式实现的。怎么实现应该由代码本身展现。
注释不应该包含谁写了那个函数，修改日期和其他那些琐碎而无实际意义的内容。这些信息应该集中在文件最开头地方。
重要信息常常以`XXX:`开头，而`bug`通常以`FIXME`开头.
