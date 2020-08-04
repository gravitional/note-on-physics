# ubuntu

***
`ls *.tex` and `"ls *.tex"`
前一种 bash 认为 `*.tex` 是参数，后一种 bash 认为 `"ls *.tex"` 是一个整体命令的名字。

bash 物理行上单个语句不用分号，两个语句并列时，采用分号。

***
如果用显式字符串作 `cd` 的参数，应该用绝对路径避免`~`的解析问题。如

```bash
cd  /home/tom/Downloads
```

***
[root@test01 ~]# whoami 

## 常用命令

命令可以是下面四种形式之一:

1. 是一个可执行程序,就像我们所看到的位于目录`/usr/bin` 中的文件一样.
属于这一类的程序,可以编译成二进制文件,诸如用 `C` 和 `C++`语言写成的程序, 也可以是由脚本语言写成的程序,比如说 `shell`,`perl`,`python`,`ruby`,等等。
2. 是一个内建于 `shell` 自身的命令。bash 支持若干命令,内部叫做 shell 内部命令 `(builtins`)。例如,`cd` 命
令,就是一个 `shell` 内部命令。
3. 是一个 `shell` 函数。这些是小规模的 `shell` 脚本,它们混合到环境变量中。 在后续的章节里,我们将讨论配
置环境变量以及书写 shell 函数。但是现在, 仅仅意识到它们的存在就可以了。
4. 是一个命令别名。我们可以定义自己的命令,建立在其它命令之上

### 命令信息

+ `type` – 说明怎样解释一个命令名
+ `which` – 显示会执行哪个可执行程序
+ `man` – 显示命令手册页
+ `apropos` – 显示一系列适合的命令
+ `info` – 显示命令 info
+ `whatis` – 显示一个命令的简洁描述
+ `alias` – 创建命令别名

+ `type` 命令是 shell 内部命令,它会显示命令的类别
+ `which`这个命令只对可执行程序有效,不包括内部命令和命令别名,别名是真正的可执行程序的替代物
+ `bash` 有一个内建的帮助工具,可供每一个 `shell` 内部命令使用。输入`help`,接着是 `shell` 内部命令名。例如: `help cd`
+ 许多可执行程序支持一个` --help` 选项,这个选项是显示命令所支持的语法和选项说明。例如:
+ 许多希望被命令行使用的可执行程序,提供了一个正式的文档,叫做手册或手册页(man page)。一个特殊的叫做`man` 的分页程序,可用来浏览他们。它是这样使用的: `man program`
+ apropos - 显示适当的命令,基于某个关键字的匹配项。虽然很粗糙但有时很有用。 +
+ `whatis` 程序显示匹配特定关键字的手册页的名字和一行命令说明:
+ GNU 项目提供了一个命令程序手册页的替代物,称为`info`。

### shell 模式切换

1. 查看系统支持的shell模式及位置

`echo &SHELL`
`cat /etc/shells`

2. 切换shell为/bin/sh

`# chsh -s /bin/sh`

### ls 只列出子目录

`ls -d */`

`-d`选项指定只列出目录，`glob`模式当前目录下`*/`表示所有的子目录

### 别名(alias)

[Linux shell 脚本中使用 alias 定义的别名][]

[Linux shell 脚本中使用 alias 定义的别名]: https://www.cnblogs.com/chenjo/p/11145021.html

可以把多个命令放在同一行上,命令之间 用”;”分开

```bash
command1; command2; command3...
```

我们会用到下面的例子:

```bash
[me@linuxbox ~]$ cd /usr; ls; cd -
bin games
kerberos lib64
local
```

正如我们看到的,我们在一行上联合了三个命令。
首先更改目录到`/usr`,然后列出目录 内容,最后回到原始目录(用命令`cd -`),结束在开始的地方。
现在,通过 `alia` 命令 把这一串命令转变为一个命令。

为了查清此事,可以使用 type 命令:

```bash
[me@linuxbox ~]$ type test
test is a shell builtin
```

哦!”test”名字已经被使用了。试一下”foo”:

```bash
[me@linuxbox ~]$ type foo
bash: type: foo: not found
```

创建命令别名:

```bash
[me@linuxbox ~]$ alias foo='cd /usr; ls; cd -'
```

注意命令结构:

```bash
alias name='string'
```

在命令”alias”之后,输入“name”,紧接着(没有空格)是一个等号,等号之后是 一串用引号引起的字符串,字符串的内容要赋值给 `name`。

删除别名,使用 unalias 命令,像这样:

```bash
[me@linuxbox ~]$ unalias foo
[me@linuxbox ~]$ type foo
bash: type: foo: not found
```

如果想要永久保存定义的`alias`，可以将其写入到 `/etc/profile` 或者 `~/.bash_rc` 中去，
两个的区别是影响的范围不一样而已

### ls

+ `-m` fill width with a comma separated list of entries
+ `-x` list entries by lines instead of by columns
+ `-b, --escape` print C-style escapes for nongraphic characters
+ `-q, --hide-control-chars` print ? instead of nongraphic characters
+ `--format=WORD` across `-x`, commas `-m`, horizontal `-x`, long `-l`, single-column `-1`, verbose `-l`, vertical `-C`

### 复制移动

复制移动的时候，可以加上 `-i` 参数，防止覆盖

`cp [OPTION]... SOURCE... DIRECTORY`

`...` 表示可以重复

`cp -i  ... ... `

`cp -irf  ... ... `

短命令可以堆叠， `-i -r -f`=`-irf`=`--interactive --force --recursive`

### 7z解压缩

支持的格式

LZMA2, XZ, ZIP, Zip64, CAB, RAR (if the non-free p7zip-rar package is installed), 
ARJ,  GZIP, BZIP2, TAR, CPIO, RPM, ISO

usage: `7z <command> [<switches>...] <archive_name> [<file_names>...] [<@listfiles...>]`

解压缩，输入密码，并保持目录结构：

`7z x -p1234 filename`

压缩单个文件

`7z a -t7z archive_name filename`

压缩txt中的文件

`7z a -t7z configrc.win.7z @tom.rc_list.win`
`7z a -t7z configrc.linux.7z @tom.rc_list.linux`

`<Commands>`

+ `a` : Add files to archive
+ `b` : Benchmark
+ `d` : Delete files from archive
+ `e` : Extract files from archive (without using directory names)
+ `h` : Calculate hash values for files
+ `i` : Show information about supported formats
+ `l` : List contents of archive
+ `rn` : Rename files in archive
+ `t` : Test integrity of archive
+ `u` : Update files to archive
+ `x` : eXtract files with full paths

`<Switches>`

+ `--` : Stop switches parsing
+ `-o{Directory}` : set Output directory
+ `-p{Password}` : set Password
+ `-r[-|0]` : Recurse subdirectories
+ `-y` : assume Yes on all queries
+ `-t{Type}` Set type of archive

### 查看所有可用的字体

```bash
fc-list :lang=zh
```

fc-list: list available fonts

### 安装字体

[Ubuntu系统字体命令和字体的安装][]

[Ubuntu系统字体命令和字体的安装]: https://www.jianshu.com/p/e7f12b8c8602

字体有`.ttf格`式（truetype font）和`.otf`格式（opentype font）字体

如果系统中没有中文字体，需要先行安装中文字体，在`Ubuntu`和`Cent OS`中的安装步骤如下：

+ 从网络上下载字体或者直接从其他计算机（windows）上拷贝
+ 建立`/usr/share/fonts/myfonts` 目录
+ `cd /usr/share/fonts/`

如果fonts/目录不存在，则创建

```bash
mkdir fonts
mkdir myfonts
```

把下载好的字体拷贝到/usr/share/fonts/myfonts目录下：

```bash
sudo cp ~/myfonts/* /usr/share/fonts/myfonts/
# ~/myfonts/ 是保存字体的目录
```

+ 修改字体文件的权限，使root用户以外的用户也可以使用

```bash
cd /usr/share/fonts/
sudo chmod -R  755 myfonts/
```

(5) 建立字体缓存

```bash
mkfontscale && mkfontdir && fc-cache -fv
```

```bash
mkfontscale
# 如果提示 mkfontscale: command not found
# 在Ubuntu下运行如下命令
# sudo apt-get install ttf-mscorefonts-installer
# 在cent os下运行如下命令
# yum install mkfontscale
mkfontdir
fc-cache -fv
# fc-cache - build font information cache files
# 如果提示 fc-cache: command not found
# 在Ubuntu下运行如下命令
# sudo apt-get install fontconfig
# 在cent os下运行如下命令
# yum install fontconfig
```

至此字体就安装成功了，如果需要安装其他字体，只需将字体拷贝到字体目录下，重新运行以上的命令即可。

### apt 与 apt-get

[Linux中apt与apt-get命令的区别与解释][]

[Linux中apt与apt-get命令的区别与解释]: https://www.sysgeek.cn/apt-vs-apt-get/

如果你已阅读过我们的 apt-get 命令指南，可能已经遇到过许多类似的命令，如apt-cache、apt-config 等。如你所见，这些命令都比较低级又包含众多功能，普通的 Linux 用户也许永远都不会使用到。换种说法来说，就是最常用的 Linux 包管理命令都被分散在了 apt-get、apt-cache 和 apt-config 这三条命令当中。

`apt` 命令的引入就是为了解决命令过于分散的问题，它包括了 apt-get 命令出现以来使用最广泛的功能选项，以及 apt-cache 和 apt-config 命令中很少用到的功能。

在使用 apt 命令时，用户不必再由 apt-get 转到 apt-cache 或 apt-config，而且 apt 更加结构化，并为用户提供了管理软件包所需的必要选项。

> 简单来说就是：`apt = apt-get`,`apt-cache` 和 `apt-config` 中最常用命令选项的集合。

### apt-get

`--install-suggests`

Consider suggested packages as a dependency for installing. Configuration Item: APT::Install-Suggests.

### 修复应用

```bash
apt-get -f install pkg
```

***
安装应用 deb pkg

```bash
dpkg -i pkg
```

`-i`== `--install`

### 查看应用安装信息

```bash
dpkg -l pkg
dpkg -L pkg
```

`install, remove, purge (apt-get(8))`

`apt list `(work-in-progress) 半成品

list is somewhat similar to `dpkg-query --list` in that it can display a list of packages satisfying certain criteria. 

It supports glob(7) patterns for matching package names as well as options to list installed (`--installed`), upgradeable (`--upgradeable`) or all available (`--all-versions`) versions.

### grep 过滤输出

`-n` 行号
`-v`,`--invert-match` 匹配不符合
`--color` 染色
`-P` perl 拓展
`-B` before 前输出
`-A` after 后输出
`-o` only 仅输出匹配字符
`-i` `--ignore-case` 忽略大小写
`-m NUM`, `--max-count=NUM` 输出的最大行

Stop  reading  a  file after `NUM` matching lines.  

If the input is standard input from a regular file, and `NUM` matching lines are output, 
grep ensures that the standard input is positioned to just after the last matching line before exiting, regardless of the presence of trailing(后面的) context lines.  
This  enables a  calling process to resume a search.  When grep stops after `NUM` matching lines, it outputs any trailing context lines.  

When the `-c` or `--count` option is also used, grep does not output a count greater than `NUM`.  
When the `-v` or `--invert-match` option is also used, grep stops after outputting `NUM` non-matching lines.

example:

```bash
grep -n --color -P -B 1 -A 6 "(?:tex:\d+:|warning:)" ./temp $tex_file".log"
```

### 图片格式转换

pkg: `pdftoppm`

pdftoppm  -png -rx 300 -ry 300  input.pdf outputname

pdftoppm input.pdf outputname -png -f {page} -singlefile

This will output each page in the PDF using the format outputname-01.png, with 01 being the index of the page.
Converting a single page of the PDF

Change {page} to the page number. It's indexed at 1, so -f 1 would be the first page.

查看图片用 eye of gnome `eog`

### 文档格式转换

用 `pandoc`

`pandoc [options] [input-file]...`

`-f --from -t --to`

`--latex-engine=pdflatex|lualatex|xelatex`

```bash
pandoc -f markdown --latex-engine=xelatex -o name
```

### 查看文档

文档尾巴

```bash
tail -n [+]num
```

`+num`  从第 num 行开始，

文档开头

```bash
head -n [-]num
```

`-num` 不输出最后num行

### 创建链接

`ln` — 创建链接

`ln` 命令即可创建硬链接,也可以创建符号链接。

可以用其中一种方法来使用它:

+ `ln file link` 创建硬链接
+ `ln -s item link` 创建符号链接,”item” 可以是一个文件或是一个目录。

#### 硬链接

硬链接和符号链接比起来,硬链接是最初 `Unix` 创建链接的方式,而符号链接更加现代。 在默认情况下,每个文
件有一个硬链接,这个硬链接给文件起名字。
当我们创建一个 硬链接以后,就为文件创建了一个额外的目录条目。硬链接有两个重要局限性:

1. 一个硬链接不能关联它所在文件系统之外的文件。这是说一个链接不能关联 与链接本身不在同一个磁盘分区
上的文件。
2. 一个硬链接不能关联一个目录。

一个硬链接和文件本身没有什么区别。不像符号链接,当你列出一个包含硬链接的目录 内容时,你会看到没有特
殊的链接指示说明。当一个硬链接被删除时,这个链接 被删除,但是文件本身的内容仍然存在(这是说,它所占
的磁盘空间不会被重新分配), 直到所有关联这个文件的链接都删除掉。知道硬链接很重要,因为你可能有时
会遇到它们,但现在实际中更喜欢使用符号链接,下一步我们会讨论符号链接。

#### 符号链接

创建符号链接是为了克服硬链接的局限性。
符号链接生效,是通过创建一个特殊类型的文件,这个文件包含一个关联文件或目录的文本指针。
在这一方面, 它们和 Windows 的快捷方式差不多,当然,符号链接早于Windows 的快捷方式 很多年;-)

一个符号链接指向一个文件,而且这个符号链接本身与其它的符号链接几乎没有区别。
例如,如果你往一个符号链接里面写入东西,那么相关联的文件也被写入。

然而, 当你删除一个符号链接时,只有这个链接被删除,而不是文件自身。
如果先于符号链接删除文件,这个链接仍然存在,但是不指向任何东西。
在这种情况下,这个链接被称为坏链接。
在许多实现中,`ls` 命令会以不同的颜色展示坏链接,比如说红色,来显示它们的存在。

***
创建硬链接

现在,我们试着创建链接。首先是硬链接。我们创建一些关联我们 数据文件的链接:

```bash
[me@linuxbox playground]$ ln fun fun-hard
[me@linuxbox playground]$ ln fun dir1/fun-hard
[me@linuxbox playground]$ ln fun dir2/fun-hard
```

ls 命令有一种方法,来展示(文件索引节点)的信息。在命令中加上”`-i`”选项:

***
创建符号链接

建立符号链接的目的是为了克服硬链接的两个缺点:硬链接不能跨越物理设备, 硬链接不能关联目录,只能是文
件。符号链接是文件的特殊类型,它包含一个指向 目标文件或目录的文本指针。

符号链接的建立过程相似于创建硬链接:

```bash
[me@linuxbox playground]$ ln -s fun fun-sym
[me@linuxbox playground]$ ln -s ../fun dir1/fun-sym
[me@linuxbox playground]$ ln -s ../fun dir2/fun-sym
```

第一个实例相当直接,在 ln 命令中,简单地加上”-s”选项就可以创建一个符号链接, 而不是一个硬链接。

`fun-sym` 的列表说明了它是一个符号链接,通过在第一字段中的首字符”l” 可知,并且它还指向”../fun”,也是正确的。

当建立符号链接时,你即可以使用绝对路径名:

```bash
ln -s /home/me/playground/fun dir1/fun-sym
```

也可用相对路径名,正如前面例题所展示的。使用相对路径名更令人满意, 因为它允许一个包含符号链接的目录重命名或移动,而不会破坏链接。

## bash 快捷键

[Bash 快捷键大全 ][]
[vim ,vi总是卡死，终于找到原因了。][]

[Bash 快捷键大全 ]: https://linux.cn/article-5660-1.html

[vim ,vi总是卡死，终于找到原因了。]: https://www.cnblogs.com/cocoliu/p/6369749.html

`Alt+tab`：切换程序
`` Alt+` ``：切换程序的不同窗口

在`vim`下，有时候不小心按下了`CTRL-S`，会冻结终端的输入，表现为按什么键都没有反应，这时候按下`CTRL-Q`即可恢复。

`CTRL-S`: `Suspend(XOFF)`，挂起。这个是冻结终端的`stdin`。要恢复可以按`CTRL-Q`。

### 常用的

| 快捷键   | 快捷键说明|
| --------------- | ----------- |
| `CTRL-/` | 撤消操作，Undo。    |
| `ALT-B`  | 光标往回跳一个词，词以非字母为界(跳动到当前光标所在词的开头)。   |
| `ALT-F`  | 光标往前跳一个词(移动到光标所在词的末尾)。     |
| `ALT-D`  | 删除光标所在位置到光标所在词的结尾位置的所有内容      |
| `ALT-BASKSPACE` | 删除光标所在位置到词开头的所有内容。    |
| `ALT-数值`      | 这个数值可以是正或者是负，这个键单独没有作用，必须后面再接其他内容，如果后面是字符，则表示重复次数。如：`[ALT-9,k]`则光标位置会插入`9`个`k`字符(负值在这种情况下无效)；如果后面接的是命令，则数字会影响后面命令的执行结果，如：`[ALT-9,CTRL-D]`则向`CTRL-D`默认方向相反(负数)的方向执行`9`次操作。 |
| `ALT-<`  | 移动到历史记录中的第一行命令。   |
| `ALT->`  | 移动到历史的最后一行，即当前正在输入的行(没有输入的情况下为空)。 |
| `ALT-P`  | 从当前行开始向前搜索，有必要则向"上"移动，移动时，使用非增量搜索查找用户提供的字符串。      |
| `ALT-N`  | 从当前行开始向后搜索，如果有必要向"下"移动，移动时，使用非增量搜索查找用户提供的字符串。    |
| `ALT-?`  | 列出能够补全标志点前的条目。     |
| `ALT-C`  | 将光标所在位置的字母转为大写     |
| `ALT-U`  | 将光标所在位置到词尾的所有字母转为大写。       |
| `ALT-L`  | 将光标位置到词尾的所有字母转为小写。    |
| `ALT-R`  | 取消所有变更，并将当前行恢复到在历史记录中的原始状态  |
| `ALT-T`  | 当光标两侧都存在词的时候，交换光标两侧词的位置。如：`abc <ALT-T>bcd -> bcd abc|`     |
| `ALT-.`  | 使用前一次命令的最后一个词(命令本身也是一个词，参见后一篇的Bang命令中的词指示符概念)。      |
| `CTRL-A` | 将光标移到行首（在命令行下）     |
| `CTRL-C` | 中断，终结一个前台作业。         |
| `CTRL-E` | 将光标移动到行尾（在命令行下）   |
| `CTRL-K` | 在控制台或 xterm 窗口输入文本时，`CTRL-K`会删除从光标所在处到行尾的所有字符。        |
| `CTRL-U` | 擦除从光标位置开始到行首的所有字符内容。       |
| `CTRL-W` | `CTRL-W` 会删除从在光标处往回的第一个空白符之间的内容 |
| `CTRL-Y` | 将之前已经清除的文本粘贴回来（主要针对`CTRL-U`或`CTRL-W`）。     |
| `CTRL-N` | 每按一次，是更接近的一条命令。   |
| `CTRL-P` | 此快捷键召回的顺序是由近及远的召回，    |
| `ALT-*`  | 把能够补全[`ALT-?`]命令能生成的所有文本条目插入到标志点前。      |
| `CTRL-Q` | `Resume (XON)`。恢复/解冻，这个命令是恢复终端的stdin用的，可参见`CTRL-S`。    |
| `CTRL-R` | 回溯搜索(Backwards search)history缓冲区内的文本（在命令行下）。注意：按下之后，提示符会变成`(reverse-i-search)'':`输入的搜索内容出现在单引号内，同时冒号后面出现最近最匹配的历史命令。         |
| `CTRL-S` | `Suspend(XOFF)`，挂起。这个是冻结终端的`stdin`。要恢复可以按`CTRL-Q`。        |
| `CTRL-T` | 交换光标位置与光标的前一个位置的字符内容（在命令行下）|
| `CTRL-\` | 退出。和`CTRL-C`差不多，也可能dump一个"core"文件到你的工作目录下(这个文件可能对你没用)。    |
***

terminal 快捷键

| 快捷键 | 快捷键说明      |
| ------------- | ---------------------- |
| `c+s+t`       | new tab  |
| `c+s+n`       | new window      |
| `c+s+w`       | close tab       |
| `c+s+q`       | close window    |
| `c+page up`   | switch to previous tab |
| `c+s+page up` | switch to the left     |

### 广泛的

| 快捷键  | 快捷键说明       |
| --------------- | ------ |
| `CTRL-A` | 将光标移到行首（在命令行下）          |
| `CTRL-B` | 退格 (非破坏性的)，这个只是将光标位置往回移动一个位置。    |
| `CTRL-C` | 中断，终结一个前台作业。 |
| `CTRL-D` | "EOF" (文件结尾：end of file)。它用于表示标准输入（`stdin`）的结束。  |
| `CTRL-E` | 将光标移动到行尾（在命令行下）        |
| `CTRL-F` | 将光标向前移动一个字符（在命令行下）         |
| `CTRL-G` | `BEL`。在一些老式打印机终端上，这会引发一个响铃。在xterm终端上可能是哔的一声。     |
| `CTRL-H` | 擦除(Rubout)(破坏性的退格)。在光标往回移动的时候，同时擦除光标前的一个字符。       |
| `CTRL-I` | 水平制表符。      |
| `CTRL-J` | 新行(`换行[line feed]`并到行首)。在脚本中，也可能表示为八进制形式(`'\012'`)或十六进制形式(`'\x0a'`)。   |
| `CTRL-K` | 垂直制表符(Vertical tab)。在控制台或 xterm 窗口输入文本时，`CTRL-K`会删除从光标所在处到行尾的所有字符。 |
| `CTRL-L` | 跳纸，换页(Formfeed)，清屏。清空终端屏幕。在终端上，这个命令的作用和`clear`命令一样。但当这个命令发送到打印机时，`Ctrl-L`会直接跳到纸张(Paper sheet)的末尾。      |
| `CTRL-M` | 回车(Carriage return)。  |
| `CTRL-N` | 擦除从history缓冲区召回的一行文本（在命令行下）。如果当前输入是历史记录中选择的时候，这个是从这个历史记录开始，每按一次，是更接近的一条命令。 |
| `CTRL-O` | 产生一个新行（在命令行下）。          |
| `CTRL-P` | 从history缓冲区召回上一次的命令（在命令行下）。此快捷键召回的顺序是由近及远的召回，即按一次，召回的是前一次的命令，再按一次，是召回上一次之前的命令，这和`CTRL-N`都是以当前的输入为起点，但是两个命令操作刚好相反，`CTRL-N`是从起点开始由远及近（如果起点是历史命令的话）。        |
| `CTRL-Q` | `Resume (XON)`。恢复/解冻，这个命令是恢复终端的stdin用的，可参见`CTRL-S`。         |
| `CTRL-R` | 回溯搜索(Backwards search)history缓冲区内的文本（在命令行下）。注意：按下之后，提示符会变成`(reverse-i-search)'':`输入的搜索内容出现在单引号内，同时冒号后面出现最近最匹配的历史命令。 |
| `CTRL-S` | `Suspend(XOFF)`，挂起。这个是冻结终端的`stdin`。要恢复可以按`CTRL-Q`。|
| `CTRL-T` | 交换光标位置与光标的前一个位置的字符内容（在命令行下）。比如：`echo $var;`，假设光标在`a`上，那么，按下`C-T`之后，`v`和`a`将会交换位置：`echo $avr;`。     |
| `CTRL-U` | 擦除从光标位置开始到行首的所有字符内容。在某些设置下，`CTRL-U`会不以光标位置为参考而删除整行的输入。    |
| `CTRL-V` | 在输入文本的时候，按下`C-V`之后，可以插入控制字符。比如：`echo -e '\x0a';`和`echo <CTRL-V><CTRL-J>;`这两种效果一样。这点功能在文本编辑器内非常有效。 |
| `CTRL-W` | 当在控制台或一个xterm窗口敲入文本时, `CTRL-W` 会删除从在光标处往后（回）的第一个空白符之间的内容。在某些设置里, `CTRL-W` 删除光标往后（回）到第一个非文字和数字之间的字符。     |
| `CTRL-X` | 在某些文字处理程序中，这个控制字符将会剪切高亮的文本并且将它复制到剪贴板中。       |
| `CTRL-Y` | 将之前已经清除的文本粘贴回来（主要针对`CTRL-U`或`CTRL-W`）。   |
| `CTRL-Z` | 暂停一个前台的作业；在某些文本处理程序中也作为替换操作；在MSDOS文件系统中作为EOF（End-of-file)字符。    |
| `CTRL-\` | 退出。和`CTRL-C`差不多，也可能dump一个"core"文件到你的工作目录下(这个文件可能对你没用)。  |
| `CTRL-/` | 撤消操作，Undo。  |
| `CTRL-_` | 撤消操作。        |
| `CTRL-xx`       | 在行首和光标两个位置间进行切换，此处是两个`"x"`字符。      |
| `ALT-B`  | 光标往回跳一个词，词以非字母为界(跳动到当前光标所在词的开头)。 |
| `ALT-F`  | 光标往前跳一个词(移动到光标所在词的末尾)。   |
| `ALT-D`  | 删除光标所在位置到光标所在词的结尾位置的所有内容(如果光标是在词开头，则删除整个词)。      |
| `ALT-BASKSPACE` | 删除光标所在位置到词开头的所有内容。         |
| `ALT-C`  | 将光标所在位置的字母转为大写(如果光标在一个词的起始位置或之前，则词首字母大写)。   |
| `ALT-U`  | 将光标所在位置到词尾的所有字母转为大写。     |
| `ALT-L`  | 将光标位置到词尾的所有字母转为小写。         |
| `ALT-R`  | 取消所有变更，并将当前行恢复到在历史记录中的原始状态(前提是当前命令是从历史记录中来的，如果是手动输入，则会清空行)。        |
| `ALT-T`  | 当光标两侧都存在词的时候，交换光标两侧词的位置。如：`abc <ALT-T>bcd -> bcd abc|`   |
| `ALT-.`  | 使用前一次命令的最后一个词(命令本身也是一个词，参见后一篇的Bang命令中的词指示符概念)。    |
| `ALT-_`  | 同`ALT-.`。       |
| `ALT-数值`      | 这个数值可以是正或者是负，这个键单独没有作用，必须后面再接其他内容，如果后面是字符，则表示重复次数。如：`[ALT-10,k]`则光标位置会插入`10`个`k`字符(负值在这种情况下无效)；如果后面接的是命令，则数字会影响后面命令的执行结果，如：`[ALT--10,CTRL-D]`则向`CTRL-D`默认方向相反(负数)的方向执行`10`次操作。 |
| `ALT-<`  | 移动到历史记录中的第一行命令。        |
| `ALT->`  | 移动到历史的最后一行，即当前正在输入的行(没有输入的情况下为空)。      |
| `ALT-P`  | 从当前行开始向前搜索，有必要则向"上"移动，移动时，使用非增量搜索查找用户提供的字符串。    |
| `ALT-N`  | 从当前行开始向后搜索，如果有必要向"下"移动，移动时，使用非增量搜索查找用户提供的字符串。  |
| `ALT-CTRL-Y`    | 在标志点上插入前一个命令的第一个参数(一般是前一行的第二个词)。如果有参数`n`，则插入前一个命令的第`n`个词(前一行的词编号从`0`开始，见历史扩展)。负的参数将插入冲前一个命令的结尾开始的第n个词。参数`n`通过`M-No.`的方式传递，如：`[ALT-0,ALT-CTRL-Y]`插入前一个命令的第`0`个词(命令本身)。        |
| `ALT-Y`  | 轮询到删除环，并复制新的顶端文本。只能在`yank[CTRL-Y]`或者`yank-pop[M-Y]`之后使用这个命令。      |
| `ALT-?`  | 列出能够补全标志点前的条目。          |
| `ALT-*`  | 把能够补全[`ALT-?`]命令能生成的所有文本条目插入到标志点前。|
| `ALT-/`  | 试图对标志点前的文本进行文件名补全。`[CTRL-X,/]`把标志点前的文本当成文件名并列出可以补全的条目。 |
| `ALT-~`  | 把标志点前的文本当成用户名并试图进行补全。`[CTRL-X,~]`列出可以作为用户名补全标志点前的条目。     |
| `ALT-$`  | 把标志点前的文本当成Shell变量并试图进行补全。`[CTRL-X,$]`列出可以作为变量补全标志点前的条目。    |
| `ALT-@`  | 把标志点前的文本当成主机名并试图进行补全。`[CTRL-X,@]`列出可以作为主机补全标志点前的条目。       |
| `ALT-!`  | 把标志点前的文本当成命令名并试图进行补全。进行命令名补全时会依次使用别名、保留字、Shell函数、shell内部命令，最后是可执行文件名。`[CTRL-X,!]`把标志点前的文本当成命令名并列出可补全的条目。          |
| `ALT-TAB`       | 把标志点前的文本与历史记录中的文本进行比较以寻找匹配的并试图进行补全。|
| `ALT-{`  | 进行文件名补全，把可以补全的条目列表放在大括号之间，让shell可以使用。 |

***

在控制台或`xterm` 窗口输入文本时，``CTRL-D`` 删除在光标下的字符。从一个shell中退出 (类似于`exit`)。如果没有字符存在，``CTRL-D`` 则会登出该会话。在一个xterm窗口中，则会产生关闭此窗口的效果。

`CTRL-K`
在脚本中，也可能表示为八进制形式(`'\013'`)或十六进制形式(`'\x0b'`)。在脚本中，`CTRL-K`可能会有不一样的行为，下面的例子给出其不一样的行为：

```bash
#!/bin/bash
## 一个`CTRL-K`垂直制表符的例子
var=$'\x0aBottom Line\x0bTop line\x0a'
## 直接输出
echo "$var"
## 使用col来过滤控制字符
echo "$var" | col
## 上面的显示将会不一样
exit 0
```

## glob()

glob： 一滴 一团

The `glob()` function searches for all the pathnames matching pattern according to the rules used by the shell (see glob(7)).  No tilde expansion or parameter substitution is done; if you want these, use wordexp(3).

The `globfree()` function frees the dynamically allocated storage from an earlier call to glob().

`man 7 glob()` see glob(7)

## shell 变量

[Shell变量：Shell变量的定义、赋值和删除][]

[Shell变量：Shell变量的定义、赋值和删除]: http://c.biancheng.net/view/743.html

脚本语言在定义变量时通常不需要指明类型，直接赋值就可以，`Shell` 变量也遵循这个规则。

在 `Bash shell` 中，每一个变量的值都是**字符串**，无论你给变量赋值时有没有使用引号，值都会以字符串的形式存储。

这意味着，`Bash shell` 在默认情况下不会区分变量类型，即使你将整数和小数赋值给变量，它们也会被视为字符串，这一点和大部分的编程语言不同。

例如在C语言或者 C++ 中，变量分为整数、小数、字符串、布尔等多种类型。

当然，如果有必要，你也可以使用 `Shell declare` 关键字显式定义变量的类型，但在一般情况下没有这个需求，Shell 开发者在编写代码时自行注意值的类型即可。

### 定义变量

`Shell` 支持以下三种定义变量的方式：

```bash
variable=value
variable='value'
variable="value"
```

`variable` 是变量名，`value` 是赋给变量的值。如果 `value` 不包含任何空白符（例如空格、`Tab` 缩进等），那么可以不使用引号；
如果 `value` 包含了空白符，那么就必须使用引号包围起来。使用单引号和使用双引号也是有区别的，稍后我们会详细说明。

注意，赋值号`=`的周围不能有空格，这可能和你熟悉的大部分编程语言都不一样。

`Shell` 变量的命名规范和大部分编程语言都一样：

+ 变量名由数字、字母、下划线组成；
+ 必须以字母或者下划线开头；
+ 不能使用 `Shell` 里的关键字（通过 `help` 命令可以查看保留关键字）。

变量定义举例：

```bash
url=http://c.biancheng.net/shell/
echo $url
name='C语言中文网'
echo $name
author="严长生"
echo $author
```

### 使用变量

使用一个定义过的变量，只要在变量名前面加美元符号`$`即可，如：

```bash
author="严长生"
echo $author
echo ${author}
```

变量名外面的花括号`{ }`是可选的，加不加都行，
加花括号是为了帮助解释器识别变量的边界，比如下面这种情况：

```bash
skill="Java"
echo "I am good at ${skill}Script"
```

如果不给 `skill` 变量加花括号，写成`echo "I am good at $skillScript"`，解释器就会把 `$skillScript` 当成一个变量（其值为空），代码执行结果就不是我们期望的样子了。

推荐给所有变量加上花括号`{ }`，这是个良好的编程习惯。

### 修改变量的值

已定义的变量，可以被重新赋值，如：

```bash
url="http://c.biancheng.net"
echo ${url}
url="http://c.biancheng.net/shell/"
echo ${url}
```

第二次对变量赋值时不能在变量名前加`$`，只有在使用变量时才能加`$`。

### 单引号和双引号的区别

定义变量时，变量的值可以由单引号`' '`包围，也可以由双引号`" "`包围，
它们的区别以下面的代码为例来说明：

``` bash
#!/bin/bash
url="http://c.biancheng.net"
website1='C语言中文网：${url}'
website2="C语言中文网：${url}"
echo $website1
echo $website2
运行结果：
C语言中文网：${url}
C语言中文网：http://c.biancheng.net
```

以单引号`' '`包围变量的值时，单引号里面是什么就输出什么，即使内容中有变量和命令（命令需要`反引`起来）也会把它们原样输出。
这种方式比较适合定义显示纯字符串的情况，即不希望解析变量、命令等的场景。

以双引号`" "`包围变量的值时，输出时会先解析里面的变量和命令，而不是把双引号中的变量名和命令原样输出。
这种方式比较适合字符串中附带有变量和命令并且想将其解析后再输出的变量定义。

我的建议：
如果变量的内容是数字，那么可以不加引号；
如果真的需要原样输出就加单引号；
其他没有特别要求的字符串等最好都加上双引号，定义变量时加双引号是最常见的使用场景。

### 将命令的结果赋值给变量

`Shell` 也支持将命令的执行结果赋值给变量，常见的有以下两种方式：

```bash
variable=`command`
variable=$(command)
```

第一种方式把命令用反引号` `（位于 `Esc` 键的下方）包围起来，反引号和单引号非常相似，容易产生混淆，所以不推荐使用这种方式；
第二种方式把命令用`$()`包围起来，区分更加明显，所以推荐使用这种方式。

例如，我在 `demo` 目录中创建了一个名为 `log.txt` 的文本文件，用来记录我的日常工作。
下面的代码中，使用 `cat` 命令将 `log.txt` 的内容读取出来，并赋值给一个变量，然后使用 `echo` 命令输出。

```bash
[mozhiyan@localhost ~]$ cd demo
[mozhiyan@localhost demo]$ log=$(cat log.txt)
[mozhiyan@localhost demo]$ echo $log
严长生正在编写Shell教程，教程地址：http://c.biancheng.net/shell/
[mozhiyan@localhost demo]$ log=`cat log.txt`
[mozhiyan@localhost demo]$ echo $log
严长生正在编写Shell教程，教程地址：http://c.biancheng.net/shell/
```

### 只读变量

使用 `readonly` 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：

```bash
#!/bin/bash
myUrl="http://c.biancheng.net/shell/"
readonly myUrl
myUrl="http://c.biancheng.net/shell/"

运行脚本，结果如下：
bash: myUrl: This variable is read only.
```

### 删除变量

使用 `unset` 命令可以删除变量。语法：

```bash
unset variable_name
```

变量被删除后不能再次使用；`unset` 命令不能删除只读变量。

举个例子：

```bash
#!/bin/sh
myUrl="http://c.biancheng.net/shell/"
unset myUrl
echo $myUrl
```

上面的脚本没有任何输出。

### 变量类型

运行`shell`时，会同时存在三种变量：

1. **局部变量** 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
2. **环境变量** 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
3. **shell变量** shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

## Shell 字符串

字符串是`shell`编程中最常用最有用的数据类型（除了数字和字符串，也没啥其它类型好用了），字符串可以用单引号，也可以用双引号，也可以不用引号。单双引号的区别跟PHP类似。

### 单引号

```bash
str='this is a string'
```

单引号字符串的限制：

+ 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
+ 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

### 双引号

```bash
your_name='runoob'
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str
out: Hello, I know you are "runoob"! 
```

双引号的优点：

+ 双引号里可以有变量
+ 双引号里可以出现转义字符

### 拼接字符串

```bash
your_name="runoob"
# 使用双引号拼接
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting  $greeting_1
out: hello, runoob ! hello, runoob !
# 使用单引号拼接
greeting_2='hello, '$your_name' !'
greeting_3='hello, ${your_name} !'
echo $greeting_2  $greeting_3
out: hello, runoob ! hello, ${your_name} !
```

### 获取字符串长度

```bash
string="abcd"
echo ${#string} #输出 4
```

### 提取子字符串

以下实例从字符串第 `2` 个字符开始截取 `4` 个字符：

```bash
string="runoob is a great site"
echo ${string:1:4} # 输出 unoo
```

注意：第一个字符的索引值为 `0`。

### 查找子字符串

查找字符 `i` 或 `o` 的位置(哪个字母先出现就计算哪个)：

```bash
string="runoob is a great site"
echo $(expr index "$string" io)  # 输出 4
```

### Shell 数组

bash支持一维数组（不支持多维数组），并且没有限定数组的大小。

类似于 `C` 语言，数组元素的下标由 `0` 开始编号。
获取数组中的元素要利用下标，下标可以是整数或算术表达式，其值应大于或等于 `0`。
定义数组

在 `Shell` 中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为：

```bash
数组名=(值1 值2 ... 值n)
```

例如：

```bash
array_name=(value0 value1 value2 value3)
```

或者

```bash
array_name=(
value0
value1
value2
value3
)
```

还可以单独定义数组的各个分量：

```bash
array_name[0]=value0
array_name[1]=value1
array_name[n]=valuen
```

可以不使用连续的下标，而且下标的范围没有限制。

### 读取数组

读取数组元素值的一般格式是：

```bash
${数组名[下标]}
```

例如：

```bash
valuen=${array_name[n]}
```

使用 `@` 符号可以获取数组中的所有元素，例如：

```bash
echo ${array_name[@]}
```

### 获取数组的长度

获取数组长度的方法与获取字符串长度的方法相同，例如：

```bash
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```

### Shell 注释

以 `#` 开头的行就是注释，会被解释器忽略。

通过每一行加一个 `#` 号设置多行注释，像这样：

```bash
#--------------------------------------------
# 这是一个注释
# author：菜鸟教程
# site：www.runoob.com
# slogan：学的不仅是技术，更是梦想！
#--------------------------------------------
##### 用户配置区 开始 #####
#
#
# 这里可以添加脚本描述信息
# 
#
##### 用户配置区 结束  #####
```

如果在开发过程中，遇到大段的代码需要临时注释起来，过一会儿又取消注释，怎么办呢？

每一行加个`#`符号太费力了，可以把这一段要注释的代码用一对花括号括起来，定义成一个函数，
没有地方调用这个函数，这块代码就不会执行，达到了和注释一样的效果。

### 多行注释

多行注释还可以使用以下格式：

```bash
:<<EOF
注释内容...
注释内容...
注释内容...
EOF

EOF 也可以使用其他符号:

:<<'
注释内容...
注释内容...
注释内容...
'

:<<!
注释内容...
注释内容...
注释内容...
!
```

## Shell 传递参数

### 实例

## Shell 数组

### 实例

### shell中的数组作为参数传递

[shell中的数组作为参数传递][]

[shell中的数组作为参数传递]: https://blog.csdn.net/brouse8079/article/details/6417836

`./test.sh  "${atest[@]}"` 简而言之，需要把数组参数用引号括起来

```bash
#!/bin/bash

echo $1
echo $2
...
echo ${10}
```

***
构造数组

```bash
atest=("a" "bb cc" "dd ee ff" "gg hh ii jj")
```

***
测试

`atest`为数组。此时若把这个数组的内容作为参数调用另一个shell脚本时，写法很关键。

第一种写法：`./test.sh ${atest[@]}`

执行结果：

```bash
a
...
a0
```

此时传递的参数为`a bb cc dd ee ff gg hh ii jj`。把数组的内容组成了一个字符串，已经破坏了原来数组的结构。

第二种写法：`./test.sh  "${atest[@]}"`

执行结果：

```bash
a
bb cc
dd ee ff
gg hh ii jj
a0
```

把数组用双引号括起来，此时传递到`test.sh`中的参数仍然为数组的原来结构。

## 各种命令

### source

[Ubuntu如何使用source命令执行文件][]

[Ubuntu如何使用source命令执行文件]: http://www.xitongzhijia.net/xtjc/20150714/52870.html

`Ubuntu source` 命令的作用就是将设置在文件中的配置信息马上生效，而不需要经过重启。

Ubuntu如何使用`source`命令执行文件

source命令用法：
`source filename` 或 `. filename`

在对编译系统核心时常常需要输入一长串的命令，如：

```bash
make mrproper
make menuconfig
make dep
make clean
make bzImage
......
```

如果把这些命令做成一个文件，让它自动顺序执行，对于需要多次反复编译系统核心的用户来说会很方便，
而用source命令就可以做到这一点，
它的作用就是把一个文件的内容当成shell来执行，先在linux的源代码目录下（如`/usr/src/linux-2.4.20`）建立一个文件，如`make_command`，在其中输入一下内容：

```bash
make mrproper &&
make menuconfig &&
make dep &&
make clean &&
...
```

文件建立好之后，每次编译核心的时候，只需要在`/usr/src/linux-2.4.20`下输入：`source make_command`即可

顺便补充一点，`&&`命令表示顺序执行由它连接的命令，但是只有它之前的命令成功执行完成了之后才可以继续执行它后面的命令。

另外执行source命令时如果提示command not found，是因为环境变量没配置好的原因，在终端运行如下命令即可修复：

`export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin`

### Ubuntu Dock

[如何移除或禁用 Ubuntu Dock][]

[]: https://zhuanlan.zhihu.com/p/48078003

方法 4：使用 `Dash to Panel` 扩展

Dash to Panel 是 Gnome Shell 的一个高度可配置面板，是 Ubuntu Dock 或 Dash to Dock 的一个很好的替代品（Ubuntu Dock 是从 Dash to Dock 分叉而来的）。

安装和启动 Dash to Panel 扩展会禁用 Ubuntu Dock，因此你无需执行其它任何操作。

你可以从 extensions.gnome.org 来安装 [Dash to Panel][]。

如果你改变主意并希望重新使用 Ubuntu Dock，那么你可以使用 Gnome Tweaks 应用程序禁用 Dash to Panel，或者通过单击以下网址旁边的 X 按钮完全移除 `Dash to Panel`: https://extensions.gnome.org/local/ 。

[Dash to Panel]: https://extensions.gnome.org/extension/1160/dash-to-panel/

## 挂载命令mount

[linux挂载命令mount及U盘、移动硬盘的挂载][]
[gpt格式的移动硬盘在Linux系统下挂载方法][]

[linux挂载命令mount及U盘、移动硬盘的挂载]: https://www.cnblogs.com/sunshine-cat/p/7922193.html

[gpt格式的移动硬盘在Linux系统下挂载方法]: https://blog.csdn.net/zhang_can/article/details/79714012?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase

查看当前磁盘列表的设备

```bash
sudo fdisk -l
```

首先查看所有已经 mount 的设备：

```bash
mount [-l] [-t type]
```

显示如下信息

```bash
root@kali:~# fdisk -l
...
Device     Boot     Start       End   Sectors   Size Id Type
/dev/sda1  *  2048 209719295 209717248   100G  7 HPFS/NTFS/exFAT
/dev/sda2       209719296 976773119 767053824 365.8G  f W95 Ext'd (LBA)
/dev/sda5       209721344 465575935 255854592   122G  7 HPFS/NTFS/exFAT
/dev/sda6       465577984 721432575 255854592   122G  7 HPFS/NTFS/exFAT
/dev/sda7       721434624 976773119 255338496 121.8G  7 HPFS/NTFS/exFAT
...
```

`parted /dev/sdb print`  显示 sdb 的分区表

可以知道sdb2(135M to 6001G)为基本数据分区，格式为`NTFS`

mount command 的标准格式：

```bash
mount -t type device dir
```

告诉 kernel attach the filesystem found on `device` (which is of type `type`) at the directory `dir`.  The option `-t type` is optional.

挂载到指定目录即可：

```bash
sudo mount -t ntfs /dev/sdb2 /home/6T
```

The option `-l` adds labels to this listing.

***
弹出设备

```bash
umount /dev/sda5
```

通过`df`可以查看设备挂载点

## 环境变量

[ubuntu 修改环境变量(PATH)][]

[ubuntu 修改环境变量(PATH)]: https://www.cnblogs.com/crave/p/11818594.html

在Linux中，在执行命令时，系统会按照`PATH`的设置，去每个`PATH`定义的路径下搜索执行文件，先搜索到的文件先执行。

当我们在执行一个指令癿时候，举例来说"ls"好了，系统会依照PATH的设定去每个PATH定义的目录下搜寻文件名为ls 的可执行文件， 如果在PATH定义的目录中含有多个文件名为ls 的可执行文件，那么先搜寻到癿同名指令先被执行！

***
如何改变PATH

1. 直接修改`$PATH`值：

生效方法：立即生效
有效期限：临时改变，只能在当前的终端窗口中有效，当前窗口关闭后就会恢复原有的`path`配置
用户局限：仅对当前用户

`echo $PATH //查看当前PATH的配置路径`

`export PATH=$PATH:/xxx/xxx //将需配置路径加入$PATH  等号两边一定不能有空格`

配置完后可以通过第一句命令查看配置结果。

### 通过修改.bashrc文件

有效期限：永久有效
用户局限：仅对当前用户

`.bashrc`文件在根目录下

```bash
vi .bashrc  //编辑.bashrc文件
//在最后一行添上：
export PATH=$PATH:/xxx/xxx  ///xxx/xxx位需要加入的环境变量地址 等号两边没空格
```

生效方法：（有以下两种）

+ 关闭当前终端窗口，重新打开一个新终端窗口就能生效
+ 输入`source .bashrc`命令，立即生效

### 通过修改profile文件：（profile文件在/etc目录下）

生效方法：系统重启
有效期限：永久有效
用户局限：对所有用户

```bash
vi /etc/profile //编辑profile文件
//在最后一行添上：
export PATH=$PATH:/xxx/xxx
```

### 通过修改environment文件

生效方法：系统重启
有效期限：永久有效
用户局限：对所有用户

environment文件在`/etc`目录下

```bash
vi /etc/profile //编辑profile文件
在PATH=/......中加入“:/xxx/xxx”
```

## && || () {} 用法

[shell 中 && || () {} 用法][]
[shell中$(( )) 与 $( ) 还有${ }的区别][]

[shell 中 && || () {} 用法]: https://www.jianshu.com/p/617c1ee1e46e

[shell中$(( )) 与 $( ) 还有${ }的区别]: https://www.cnblogs.com/xunbu7/p/6187017.html

### 括号总结

***
命令成组, 用 `()` 或者 `{  }`

```bash
> A=1; echo $A; { A=2 }; echo $A
1
2
> A=1; echo $A; (A=2); echo $A
1
1
```

在使用`{  }`时，`{  }`与命令之间必须使用一个`空格`

***
`$( )`命令替换

`$( )` 与 \`\` (反引号) 都是用来做命令替换

***
`${ }` 变量替换，各种字符串功能

`${ }` 用来作变量替换，把括号里的变量代入值。

***
`$(( ))`整数运算

在 bash 中，`$(( ))` 的整数运算符号大致有这些：

+ `+ - * /` ：分别为 "加、减、乘、除"。
+ `%` ：余数运算
+ `& | ^ !`：分别为 "`AND`,`OR`,`XOR`,`NOT`" 运算。

### &&运算符

`&&` 运算符:
***
格式
`command1  && command2`

`&&`左边的命令（命令`1`）返回真(即返回`0`，成功被执行）后，`&&`右边的命令（命令`2`）才能够被执行；
换句话说，“如果这个命令执行成功`&&`那么执行这个命令”。

语法格式如下：

```bash
command1 && command2 && command3 ...
```

命令之间使用 `&&` 连接，实现逻辑与的功能。
只有在 `&&` 左边的命令返回真（命令返回值 `$? == 0`），`&&` 右边的命令才会被执行。
只要有一个命令返回假（命令返回值 $? == 1），后面的命令就不会被执行。

示例1中，`cp`命令首先从`root`的家目录复制文件文件`anaconda-ks.cfg`到 `/data`目录下；
执行成功后，使用 `rm` 命令删除源文件；如果删除成功则输出提示信息"`SUCCESS`"。

`cp anaconda-ks.cfg /data/ && rm -f anaconda-ks.cfg && echo "SUCCESS"`

### || 运算符

格式

```bash
command1 || command2
```

`||`则与`&&`相反。如果`||`左边的命令（command1）未执行成功，那么就执行`||`右边的命令（command2）；
或者换句话说，“如果这个命令执行失败了`||`那么就执行这个命令。

命令之间使用 `||` 连接，实现逻辑或的功能。

只有在 `||` 左边的命令返回`假`（命令返回值 `$? == 1`），`||` 右边的命令才会被执行。
这和 `c` 语言中的逻辑或语法功能相同，即实现短路逻辑或操作。

只要有一个命令返回真（命令返回值 `$? == 0`），后面的命令就不会被执行。

如果 dir目录不存在，将输出提示信息 fail 。

```bash
ls dir &>/dev/null || echo "fail"
```

如果 dir 目录存在，将输出 success 提示信息；否则输出 fail 提示信息。

```bash
ls dir &>/dev/null && echo "fail" || echo "fail"
```

***
`&>` 的意思是重定向标准输出和错误到 同一个地方，如

```bash
[me@linuxbox ~]$ ls -l /bin/usr &> ls-output.txt
```

利用`/dev/null`处理不需要的输出，这个文件是系统设备,叫做位存储桶,它可以 接受输入,并且对输入不做任何处理。

***
下面是一个shell脚本中常用的`||`组合示例

```bash
echo $BASH | grep -q 'bash' || { exec bash "$0" "$@" || exit 1; }
```

系统调用`exec`是以新的进程去代替原来的进程，但进程的`PID`保持不变。

因此，可以这样认为，`exec`系统调用并没有创建新的进程，只是替换了原来进程上下文的内容。
原进程的代码段，数据段，堆栈段被新的进程所代替。

### () 运算符

如果希望把几个命令合在一起执行， `shell` 提供了两种方法。既可以在当前shell也可以在子shell中执行一组命令。

格式:

```bash
(command1;command2;command3....)        多个命令之间用;分隔
```

一条命令需要独占一个物理行，如果需要将多条命令放在同一行，命令之间使用命令分隔符`(;)`分隔。
执行的效果等同于多个独立的命令单独执行的效果。

`()` 表示在当前 shell 中将多个命令作为一个整体执行。

需要注意的是，使用 `()` 括起来的命令在执行前面都不会切换当前工作目录，
也就是说命令组合都是在当前工作目录下被执行的，尽管命令中有切换目录的命令。

命令组合常和命令执行控制结合起来使用。

如果目录`dir`不存在，则执行命令组合。

```bash
ls dir &>/dev/null || (cd /home/; ls -lh; echo "success")
```

### {} 运算符

如果使用`{}`来代替`()`，那么相应的命令将在当前shell中作为一个整体被执行，
只有在`{}`中所有命令的输出作为一个整体被重定向时，其中的命令才被放到子shell中执行，否则在当前shell执行。

它的一般形式为：

```bash
{ command1;command2;command3… }
```

注意：在使用`{}`时，`{}`与命令之间必须使用一个`空格`

使用`{}`则在子`shell`中执行了打印操作

```bash
A=1; echo $A; { A=2 }; echo $A
A=1; echo $A; (A=2); echo $A
```

### $(( )) 与 $( ) ${ }

***
`$( )` 与 `backtick`

在 bash shell 中，`$( )` 与 \`\` (反引号) 都是用来做命令替换用(`command substitution`)的。

用 `$( )` 的理由：

1. \`\` 很容易与`' '` ( 单引号)搞混乱，尤其对初学者来说。
2. 在多层次的复合替换中，\`\` 须要额外的跳脱( \` )处理，而 `$( )` 则比较直观。

`$( )` 的不足:

1. \`\` 基本上可用在全部的 `unix shell` 中使用，若写成 `shell script` ，其移植性比较高。
而 `$( )` 并不见的每一种 `shell` 都能使用，我只能跟你说，若你用 bash2 的话，肯定没问题…   ^_^

***
`${ }` 用来作变量替换，把括号里的变量代入值。

以上的理解在于, 你一定要分清楚 `unset` 与 `null` 及 `non-null` 这三种赋值状态.
一般而言, `:` 与 `null` 有关, 若不带 `:` 的话, null 不受影响, 若带 `:` 则连 null 也受影响.

还有哦，`${#var}` 可计算出变量值的长度：
`${#file}` 可得到 `27` ，因为 `/dir1/dir2/dir3/my.file.txt` 刚好是 `27` 个字节…

***
接下来，再为大家介稍一下 `bash` 的组数(`array`)处理方法。

一般而言，`A="a b c def"` 这样的变量只是将 `$A` 替换为一个单一的字符串，
但是改为 `A=(a b c def) `，则是将 `$A` 定义为组数…

bash 的组数替换方法可参考如下方法：

+ `${A[@]}` 或 `${A[*]}` 可得到 `a b c def` (全部组数)
+ `${A[0]}` 可得到 `a` (第一个组数)，${A[1]} 则为第二个组数…
+ `${#A[@]}` 或 `${#A[*]}` 可得到 `4` (全部组数数量)
+ `${#A[0]}` 可得到 `1` (即第一个组数(`a`)的长度)，`${#A[3]}` 可得到 `3` (第四个组数(def)的长度)
+ `A[3]=xyz` 则是将第四个组数重新定义为 `xyz` …

### (())算术比较

好了，最后为大家介绍 `$(( ))` 的用途吧：它是用来作整数运算的。

在 bash 中，`$(( ))` 的整数运算符号大致有这些：

+ `+ - * /` ：分别为 "加、减、乘、除"。
+ `%` ：余数运算
+ `& | ^ !`：分别为 "`AND`,`OR`,`XOR`,`NOT`" 运算。

`XOR` `exclusive OR`

例：

```bash
$ a=5; b=7; c=2
$ echo $(( a+b*c ))
19
$ echo $(( (a+b)/c ))
6
$ echo $(( (a*b)%c))
1
```

在 `$(( ))` 中的变量名称，可于其前面加 `$` 符号来替换，也可以不用，如：`$(( $a + $b * $c))` 也可得到 `19` 的结果

此外，`$(( ))` 还可作不同进位(如二进制、八进位、十六进制)作运算，只是，输出结果皆为十进制：

```bash
echo $((16#2a)) 结果为 42 (16进位转十进制)
```

以一个实用的例子来看看吧：

假如当前的   `umask` 是 `022` ，那么新建文件的权限即为：

```bash
$ umask 022
$ echo "obase=8;$(( 8#666 & (8#777 ^ 8#$(umask)) ))" | bc
644
```

事实上，单纯用 `(( ))` 也可重定义变量值，或作 `testing`：

+ `a=5; ((a++))` 可将 `$a` 重定义为 `6`
+ `a=5; ((a–))` 则为 `a=4`
+ `a=5; b=7; ((a < b))` 会得到   `0` (`true`) 的返回值。

常见的用于 `(( ))` 的测试符号有如下这些：

+ `<`：小于
+ `>`：大于
+ `<=`：小于或等于
+ `>=`：大于或等于
+ `==`：等于
+ `!=`：不等于

### []中括号-文件系统属性测试

Shell 里面的中括号（包括单中括号与双中括号）可用于一些条件的测试：

+ 算术比较, 比如一个变量是否为`0`, `[ $var -eq 0 ]`。
+ 文件属性测试，比如一个文件是否存在，`[ -e $var ]`, 是否是目录，`[ -d $var ]`。
+ 字符串比较, 比如两个字符串是否相同， `[[ $var1 = $var2 ]]`。

`[]` 常常可以使用 `test` 命令来代替，后面有介绍。

***
对变量或值进行算术条件判断：

+ `[ $var -eq 0 ]`  # 当 `$var` 等于 `0` 时，返回真
+ `[ $var -ne 0 ]`  # 当 `$var` 不等于 `0` 时，返回真

需要注意的是 `[` 与 `]` 与操作数之间一定要有一个空格，否则会报错。比如下面这样就会报错:

`[$var -eq 0 ]`  或 `[ $var -ne 0]`

其他比较操作符：

+ `-gt` 大于
+ `-lt` 小于
+ `-ge` 大于或等于
+ `-le` 小于或等于

可以通过 `-a` (and) 或 `-o` (or) 结合多个条件进行测试：

`[ $var1 -ne 0 -a $var2 -gt 2 ]`  # 使用逻辑与 `-a`
`[ $var1 -ne 0 -o $var2 -gt 2 ]`  # 使用逻辑或 `-o`

***
使用不同的条件标志测试不同的文件系统属性。

+ `[ -f $file_var ]` 变量 `$file_var` 是一个正常的文件路径或文件名 (`file`)，则返回真
+ `[ -x $var ]` 变量 `$var` 包含的文件可执行 (`execute`)，则返回真
+ `[ -d $var ]` 变量 `$var` 包含的文件是目录 (`directory`)，则返回真
+ `[ -e $var ]` 变量 `$var` 包含的文件存在 (`exist`)，则返回真
+ `[ -c $var ]` 变量 `$var` 包含的文件是一个字符设备文件的路径 (`character`)，则返回真
+ `[ -b $var ]` 变量 `$var` 包含的文件是一个块设备文件的路径 (`block`)，则返回真
+ `[ -w $var ]` 变量 `$var` 包含的文件可写(`write`)，则返回真
+ `[ -r $var ]` 变量 `$var` 包含的文件可读 (`read`)，则返回真
+ `[ -L $var ]` 变量 `$var` 包含是一个符号链接 (`link`)，则返回真

也可以是

`-e filename` 如果 `filename` 存在，则为真

常用例子，如果存在某文件，则删除

```bash
if [ -f trials ]; then rm ${result_path}trials; fi
```

如果没有文件夹，则创建

```bash
if [ ! -d $result_name ];then
      mkdir -p $result_name
fi
```

[Shell 中的中括号用法总结][]
[linux shell 中判断文件、目录是否存在][]

[Shell 中的中括号用法总结]: https://www.runoob.com/w3cnote/shell-summary-brackets.html

[linux shell 中判断文件、目录是否存在]: https://blog.csdn.net/yifeng4321/article/details/70232436

### [[ ]]字符串比较

在进行字符串比较时，最好使用双中括号 `[[ ]]`. 因为单中括号可能会导致一些错误，因此最好避开它们。

检查两个字符串是否相同：

```bash
[[ $str1 = $str2 ]]
```

当 `str1` 等于 `str2` 时，返回真。也就是说， `str1` 和 `str2` 包含的文本是一样的。
其中的单等于号也可以写成双等于号，也就是说，上面的字符串比较等效于 `[[ $str1 == $str2 ]]`。

注意 `=` 前后有一个`空格`，如果忘记加空格, 就变成了赋值语句，而非比较关系了。

字符串的其他比较情况：

+ `[[ $str1 != $str2 ]]`   如果 `str1` 与 `str2` 不相同，则返回真
+ `[[ -z $str1 ]]`   如果 `str1` 是`null`字符串，则返回真
+ `[[ -n $str1 ]]`   如果 `str1` 是非`null`字符串，则返回真

使用逻辑运算符 `&&` 和 `||` 可以轻松地将多个条件组合起来, 比如：
 
```bash
str1="Not empty"
str2=""
if [[ -n $str1 ]] && [[ -z $str2 ]];
then
  echo str1 is nonempty and str2 is empty string.
fi
```

`test` 命令也可以从来执行条件检测，用 `test` 可以避免使用过多的括号，`[]` 中的测试条件同样可以通过 `test` 来完成。

```bash
if [ $var -eq 0 ]; then echo "True"; fi
```

等价于:

```bash
if test $var -eq 0; then echo "True"; fi
```

## 字符串和数字

commandline chapter 35

在这一章中,我们将查看几个用来操作字符串和数字的 shell 功能。
shell 提供了各种执行字符串操作的参数展开功能。
除了算术展开(在第七章中接触过),还有一个常见的命令行程序叫做 `bc`,能执行更高级别的数学运算。

### 字符串总结

parameter 前面可能出现的保留字，`!`, `#`
parameter 后面可能接的保留字，`:` `#` `%` `/`

+ 返回变量名的参数展开
+ `${!prefix*}` ：这种展开会返回以 `prefix` 开头的已有变量名
+ `${#parameter}` ：展开成由 parameter 所包含的字符串的长度。
+ 空变量的展开
+ `${parameter:-word}` ：若 parameter 没有设置(例如,不存在)或者为空,展开结果是 word 的值
+ `${parameter:=word}` ：若 parameter 没有设置或为空,展开结果是 word 的值。另外,word 的值会赋值给 parameter。
+ `${parameter:?word}`：若 parameter 没有设置或为空,这种展开导致脚本带有错误退出,并且 word 的内容会发送到标准错误。
+ `${parameter:+word}`：若 parameter 为空,结果为空。若 parameter 不为空, word 的值; parameter 的值不改变。
+ 字符串展开
+ `${parameter:offset}` ：从 `parameter` 所包含的字符串中提取一部分字符，到结尾
+ `${parameter:offset:length}` ：从 `parameter` 所包含的字符串中提取一部分字符，`length`制定长度
+ 字符串修剪
+ `${parameter#pattern}` ：从 `paramter` 所包含的字符串中清除开头的`pattern`
+ `${parameter##pattern}` ：## 模式清除最长的匹配结果。
+ `${parameter%pattern}` ：清除 `parameter` 末尾所包含的`pattern`
+ `${parameter%%pattern}` ：%% 模式清除最长的匹配结果。
+ 字符串查找和替换操作 `parameter`必须是一个变量 `pattern` 和 `string` 可以不加引号
+ `${parameter/pattern/string}` ：如果找到了匹配通配符 pattern 的文本, 则用 `string` 的内容替换它。
+ `${parameter//pattern/string}` ： `//` 形式下,所有的匹配项都会被替换掉
+ `${parameter/#pattern/string}` ：` /# `要求匹配项出现在字符串的开头,
+ `${parameter/%pattern/string}` ：`/%` 要求匹配项出现在字符串的末尾

### 参数展开

尽管参数展开在第七章中出现过,但我们并没有详尽地介绍它,因为大多数的参数展开会用在脚本中,而不是命
令行中。 我们已经使用了一些形式的参数展开;例如,shell 变量。shell 提供了更多方式。

### 基本参数展开

最简单的参数展开形式反映在平常使用的变量上。

在这个例子中,我们试图创建一个文件名,通过把字符串 “`_file`” 附加到变量 `a` 的值的后面。

```bash
[me@linuxbox ~]$ a="foo"
[me@linuxbox ~]$ echo "$a_file"
```

如果我们执行这个序列,没有任何输出结果,因为 `shell` 会试着展开一个称为 `a_file` 的变量,而不是 `a`。通过添加花括号可以解决这个问题:

```bash
[me@linuxbox ~]$ echo "${a}_file"
foo_file
```

我们已经知道通过把数字包裹在花括号中,可以访问大于`9`的位置参数。例如,访问第十一个位置参数,我们可以这样做: `${11}`

### 管理空变量的展开

`null`
`undefined`
`defined`

几种用来处理不存在和空变量的参数展开形式。
这些展开形式对于解决丢失的位置参数和给参数指定默认值的情况很方便。

```bash
${parameter:-word}
```

若 parameter 没有设置(例如,不存在)或者为空,展开结果是 `word` 的值。
若 parameter 不为空,则展开结果是 parameter 的值。

```bash
foo=
echo ${foo:-"substitute value if unset"}
echo $foo
foo=bar
echo ${foo:-"substitute value if unset"}
echo $foo
```

```bash
${parameter:=word}
```

若 parameter 没有设置或为空,展开结果是 word 的值。另外,word 的值会赋值给 parameter。
若parameter 不为空,展开结果是 parameter 的值。

```bash
foo=
echo ${foo:="default value if unset"}
unset
echo $foo
unset
foo=bar
echo ${foo:="default value if unset"}
echo $foo
```

注意: 位置参数或其它的特殊参数不能以这种方式赋值。

```bash
${parameter:?word}
```

若 parameter 没有设置或为空,这种展开导致脚本带有错误退出,并且 word 的内容会发送到标准错误。
若parameter 不为空, 展开结果是 parameter 的值。

```bash
foo=
echo ${foo:?"parameter is empty"
echo $?
foo=bar
echo ${foo:?"parameter is empty"}
echo $?
```

```bash
${parameter:+word}
```

若 parameter 没有设置或为空,展开结果为空。
若 parameter 不为空, 展开结果是 word 的值会替换掉parameter 的值;然而,parameter 的值不会改变。

```bash
foo=
echo ${foo:+"substitute value if set"}
foo=bar
echo ${foo:+"substitute value if set"}
```

### 返回变量名的参数展开

`shell` 具有返回变量名的能力。这会用在一些相当独特的情况下。

```bash
${!prefix*}
${!prefix@}
```

这种展开会返回以 `prefix` 开头的已有变量名。根据 bash 文档,这两种展开形式的执行结果相同。
这里,我们列出了所有以 `BASH` 开头的环境变量名:

```bash
[me@linuxbox ~]$ echo ${!BASH*}
BASH BASH_ARGC BASH_ARGV BASH_COMMAND BASH_COMPLETION
...
```

### 字符串展开

有大量的展开形式可用于操作字符串。其中许多展开形式尤其适用于路径名的展开。

```bash
${#parameter}
```

展开成由 `parameter` 所包含的字符串的长度。

通常,`parameter` 是一个字符串;然而,如果 `parameter` 是 `@`或者是 `*` 的话, 则展开结果是位置参数的个数。

```bash
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo "'$foo' is ${#foo} characters long."
'This string is long.' is 20 characters long.
```

***

```bash
${parameter:offset}
${parameter:offset:length}
```

这些展开用来从 `parameter` 所包含的字符串中提取一部分字符。
提取的字符始于第 `offset` 个字符(从字符串开头算起)直到字符串的末尾,除非指定提取的长度。

```bash
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo ${foo:5}
string is long.
[me@linuxbox ~]$ echo ${foo:5:6}
string
```

若 `offset` 的值为负数,则认为 `offset` 值是从字符串的末尾开始算起,而不是从开头。
注意负数前面必须有一个空格, 为防止与 `${parameter:-word}` 展开形式混淆。`length`,若出现,则必须不能小于零。
如果 `parameter` 是 `@`,展开结果是 `length` 个位置参数,从第 offset 个位置参数开始。

```bash
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo ${foo: -5}
long.
[me@linuxbox ~]$ echo ${foo: -5:2}
lo
```

***

```bash
${parameter#pattern}
${parameter##pattern}
```

这些展开会从 `paramter` 所包含的字符串中清除开头一部分文本,这些字符要匹配定义的 `patten` 。
pattern 是通配符模式,就如那些用在路径名展开中的模式。
这两种形式的差异之处是该 `#` 形式清除最短的匹配结果, 而该`##` 模式清除最长的匹配结果。

```bash
[me@linuxbox ~]$ foo=file.txt.zip
[me@linuxbox ~]$ echo ${foo#*.}
txt.zip
[me@linuxbox ~]$ echo ${foo##*.}
zip
```

***

```bash
${parameter%pattern}
${parameter%%pattern}
```

这些展开和上面的 `#` 和 `##` 展开一样,除了它们清除的文本从 `parameter` 所包含字符串的末尾开始,而不是开头。

```bash
[me@linuxbox ~]$ foo=file.txt.zip
[me@linuxbox ~]$ echo ${foo%.*}
file.txt
[me@linuxbox ~]$ echo ${foo%%.*}
file
```

***

```bash
${parameter/pattern/string}
${parameter//pattern/string}
${parameter/#pattern/string}
${parameter/%pattern/string}
```

这种形式的展开对 `parameter` 的内容执行查找和替换操作。

如果找到了匹配通配符 `pattern` 的文本, 则用 `string` 的内容替换它。
在正常形式下,只有第一个匹配项会被替换掉。在 `//` 形式下,所有的匹配项都会被替换掉。
` /# `要求匹配项出现在字符串的开头,而 `/%` 要求匹配项出现在字符串的末尾。
`/string` 可能会省略掉,这样会导致删除匹配的文本。

```bash
[me@linuxbox~]$ foo=JPG.JPG
[me@linuxbox ~]$ echo ${foo/JPG/jpg}
jpg.JPG
[me@linuxbox~]$ echo ${foo//JPG/jpg}
jpg.jpg
[me@linuxbox~]$ echo ${foo/#JPG/jpg}
jpg.JPG
[me@linuxbox~]$ echo ${foo/%JPG/jpg}
JPG.jpg
```

知道参数展开是件很好的事情。

字符串操作展开可以用来替换其它常见命令比方说 `sed` 和 `cut`。通过减少使用外部程序,展开提高了脚本的效率。

举例说明,我们将修改在之前章节中讨论的 `longest-word` 程序,
用参数展开`${#j}` 取代命令 `$(echo $j | wc -c)` 及其`subshell` ,像这样:

`wc`- print newline, word, and byte counts for each file

```bash
#!/bin/bash
# longest-word3 : find longest string in a file
for i; do
   if [[ -r $i ]]; then
      max_word=
      max_len=
      for j in $(strings $i); do
  len=${#j}
  if (( len > max_len )); then
     max_len=$len
     max_word=$j
  fi
      done
      echo "$i: '$max_word' ($max_len characters)"
   fi
   shift
done
```

下一步,我们将使用 `time` 命令来比较这两个脚本版本的效率:

```bash
[me@linuxbox ~]$ time longest-word2 dirlist-usr-bin.txt
dirlist-usr-bin.txt: 'scrollkeeper-get-extended-content-list' (38 characters)
real 0m3.618s
user 0m1.544s
sys 0m1.768s
[me@linuxbox ~]$ time longest-word3 dirlist-usr-bin.txt
dirlist-usr-bin.txt: 'scrollkeeper-get-extended-content-list' (38 characters)
real 0m0.060s
user 0m0.056s
sys 0m0.008s
```

原来的脚本扫描整个文本文件需耗时`3.168`秒,而该新版本,使用参数展开,仅仅花费了`0.06`秒 —— 一个非常巨
大的提高。

### formfactor bash 脚本

```bash
curveopacity=1
markers="Bands"
markopacity=0.1
expr_marker=3
expr_opacity=1

wolframscript -print "all" -file ./f.figure.series-full.rencon3.strange.baryons-all.band.wl "full" 0.90 1.50 $curveopacity $markers $markopacity $expr_marker $expr_opacity
```
