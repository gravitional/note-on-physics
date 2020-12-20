# ubuntu-1

***
`ls *.tex` and `"ls *.tex"`
前一种 bash 认为 `*.tex` 是参数,后一种 bash 认为 `"ls *.tex"` 是一个整体命令的名字.

bash 物理行上单个语句不用分号,两个语句并列时,采用分号.

***
如果用显式字符串作 `cd` 的参数,应该用绝对路径避免`~`的解析问题.如

```bash
cd  /home/tom/Downloads
```

***
`whoami`会输出用户的名称

***
bash -c `command` arg1 arg2 ...

这种调用形式,会读取 `-c`后面的`command_string`并执行命令,然后退出
如果在`command_string`之后有参数,则第一个参数分配给`$0`,其余所有参数分配给`位置参数`.
`$0`的赋值设置`shell`的名称,该名称用于`warning`和`error`消息.如

```bash
bash -c 'ls;echo;uptime'
```

## 常用功能

命令可以是下面四种形式之一:

1. 是一个可执行程序,就像我们所看到的位于目录`/usr/bin` 中的文件一样.
属于这一类的程序,可以编译成二进制文件,诸如用 `C` 和 `C++`语言写成的程序, 也可以是由脚本语言写成的程序,比如说 `shell`,`perl`,`python`,`ruby`,等等.
2. 是一个内建于 `shell` 自身的命令.bash 支持若干命令,内部叫做 shell 内部命令 `(builtins`).例如,`cd` 命
令,就是一个 `shell` 内部命令.
3. 是一个 `shell` 函数.这些是小规模的 `shell` 脚本,它们混合到环境变量中. 在后续的章节里,我们将讨论配
置环境变量以及书写 shell 函数.但是现在, 仅仅意识到它们的存在就可以了.
4. 是一个命令别名.我们可以定义自己的命令,建立在其它命令之上

### 常用命令

+ `type` – 说明怎样解释一个命令名
+ `which` – 显示会执行哪个可执行程序
+ `man` – 许多希望被命令行使用的可执行程序,提供了一个正式的文档,叫做手册或手册页(man page).一个特殊的叫做`man` 的分页程序,可用来浏览他们
+ `apropos` - 显示适当的命令,基于某个关键字的匹配项.虽然很粗糙但有时很有用.
+ `info` – 项目提供了一个命令程序手册页的替代物,称为`info`.
+ `whatis` – 程序显示匹配特定关键字的手册页的名字和一行命令说明
+ `alias` – 创建命令别名
+ `type` 命令是 `shell` 内部命令,它会显示命令的类别
+ `which`这个命令只对可执行程序有效,不包括内部命令和命令别名,别名是真正的可执行程序的替代物
+ `bash` 有一个内建的帮助工具,可供每一个 `shell` 内部命令使用.输入`help`,接着是 `shell` 内部命令名.例如: `help cd`
+ 许多可执行程序支持一个` --help` 选项,这个选项是显示命令所支持的语法和选项说明.例如:
+ `less ` 浏览文件内容
+ `basename file suffix` 用来去掉文件后缀名
+ `/bin/kill -L` : 查看linux `kill` 的数字对应的短语
`echo`输出的时候,可以考虑改变颜色增加辨认度,
+ `ldd`查看依赖信息
+ `sha256sum`: 计算并检查 SHA256 message digest (消息摘要)

```bash
echo  -e "\033[1;47m\033[1;32m Testing output... "
```

***
简单命令

+ `date` 日期
+ `cal` 日历
+ `df` 磁盘剩余空间
+ `free` 空闲内存
+ ` file`  确定文件类型
+ `which` locate a command
+ `type` type is a shell builtin
+ `cd -` 更改工作目录到先前的工作目录
+ `cd ~user_name` 切换到用户家目录
+ `cp -u *.html destination` 更新文件到destination
+ `ln file link` 创建硬链接
+ `ln -s item link` 创建符号链接, `item`可以是一个文件或目录,`gnome`中,按住`ctrl+shift`拖动会创建链接.
+ `df -h`,让你以 `MB` 或 `G` 为单位查看磁盘的空间.

***
查看系统版本信息

[ubuntu：查看ubuntu系统的版本信息](https://blog.csdn.net/whbing1471/article/details/52074390)

```bash
cat /proc/version
uname -a
sb_release -a
```

*** 
查看主要存储设备的使用情况

```bash
df -h | sort -hr --key=2
```

### 环境变量

如果你把文本放在双引号中, `shell` 使用的特殊字符, 除了`\`(反斜杠),`$` ,和 `` ` ``(倒引号)之外, 则失去它们的特殊含义,被当作普通字符来看待。

这意味着

+ 单词分割, (`空格`)
+ 路径名展开, （`*``?`）
+ 波浪线展开,(`~`)
+ 和花括号展开(`{}`)

都被禁止,然而

+ 参数展开(`$USER`)
+ 算术展开(`$(())`)
+ 命令替换`$()`

仍被执行，所以在`.zshrc` or `.bashrc` 中设置环境变量的时候, 如果需要用到`~`，那么就不用加`"` or `'`,(不要加任何引号)

```bash
export PATH=/usr/local/opt/coreutils/libexec/gnubin:~/bin:$PATH
```

### shell 模式切换

1. 查看系统支持的shell模式及位置

`echo &SHELL`
`cat /etc/shells`

2. 切换shell为/bin/sh

`# chsh -s /bin/sh`

### 录制屏幕

如果是`Gnome3`系用户,可以按`ctrl + shift + alt + r`,屏幕右下角有红点出现,则开始录屏,
要结束的话再按一次`ctrl + shift + alt + r`,录好的视频在`~/video`下

### ls 选项

`ls -d */`

+ `-d`= 选项指定只列出目录,`glob`模式当前目录下`*/`表示所有的子目录
+ `-S` 按文件大小排序,大的优先
+ `--sort=WORD` =  按`WORD`排序,而不是`name`: none (-U), size (-S), time (-t), version (-v), extension (-X)
+ `--time=WORD`= 和 `-l`一起使用,使用`WORD`代替默认的修改时间:atime or access or use (-u); ctime or status (-c); also use specified time as sort key if  `--sort=time` (newest first)
+ `-X` = 按拓展名的字母顺序排列
+ `-m`用逗号分隔的条目列表填充宽度
+ `-x` 按行而不是按列输出条目
+ `-b, --escape` 打印非图形字符的`C`样式转义符
+ `-q, --hide-control-chars` 打印`?`而不是非图形字符
+ `--format=WORD` 横跨`-x`,逗号`-m`,水平`-x`,长`-l`,单列`-1`,verbose`-l`,垂直`-C`

### 别名(alias)

[Linux shell 脚本中使用 alias 定义的别名][]

[Linux shell 脚本中使用 alias 定义的别名]: https://www.cnblogs.com/chenjo/p/11145021.html

可以把多个命令放在同一行上,命令之间 用`;`分开

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

正如我们看到的,我们在一行上联合了三个命令.
首先更改目录到`/usr`,然后列出目录 内容,最后回到原始目录(用命令`cd -`),结束在开始的地方.
现在,通过 `alia` 命令 把这一串命令转变为一个命令.

为了查清此事,可以使用 type 命令:

```bash
[me@linuxbox ~]$ type test
test is a shell builtin
```

哦!`test`名字已经被使用了.试一下`foo`:

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

在命令`alias`之后,输入`name`,紧接着(没有空格)是一个等号,等号之后是 一串用引号引起的字符串,字符串的内容要赋值给 `name`.

删除别名,使用 unalias 命令,像这样:

```bash
[me@linuxbox ~]$ unalias foo
[me@linuxbox ~]$ type foo
bash: type: foo: not found
```

如果想要永久保存定义的`alias`,可以将其写入到 `/etc/profile` 或者 `~/.bash_rc` 中去,
两个的区别是影响的范围不一样而已

***
zsh 别名

+ `grep`='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

### 复制移动删除 cp rm mv

复制移动的时候,可以加上 `-i` 参数,防止覆盖

`cp [OPTION]... SOURCE... DIRECTORY`

`...` 表示可以重复

`cp -i  ... ... `

`cp -irf  ... ... `

短命令可以堆叠, `-i -r -f`=`-irf`=`--interactive --force --recursive`

要删除名称以`-`开头的文件,例如` -foo`,请使用以下命令之一:

+ `rm -- -foo`
+ `rm ./-foo`

删除本层目录下除了源文件的`latex`辅助文件

```
temp_a=$(find . -mindepth 1 -maxdepth 1 -type f   \( -not -name  "*.pdf" \)  \( -not -name  "*.tex" \) \( -not -name  "*.bib" \) -print0); if [[ ${temp_a} != '' ]]; then  echo -n ${temp_a} |  xargs --null rm; fi
```

可以多用花括号展开,指定多个文件名,例如:

```bash
ls ~/draft/draft.2008{03,04,05}.nb
/home/tom/draft/draft.200803.nb  /home/tom/draft/draft.200804.nb  /home/tom/draft/draft.200805.nb
```

### 重命名 rename

重命名除了使用`mv`,也可以使用`rename`,以下是简单的说明:

***
rename - renames multiple files

SYNOPSIS

```bash
rename [ -h|-m|-V ] [ -v ] [ -n ] [ -f ] [ -e|-E perlexpr]*|perlexpr [ files ]
```

DESCRIPTION

`rename`根据指定为第一个参数的规则重命名提供的文件名.
`perlexpr`参数是一个`Perl`表达式,它修改`Perl`中的`$ _`字符串.
如果给定的文件名未被表达式修改,则不会重命名.
如果命令行中未提供文件名,则将通过标准输入读取文件名.

`perlepxr`三种模式,分别是:

+ 匹配; `m`
+ 替换; `s`
+ 转化; `tr` or `y` ： 相当于一个映射表格，进行批量替换

例如,要重命名所有匹配`* .bak`的文件,以去除扩展名,可以用

```bash
rename 's/\e.bak$//' *.bak
```

要将大写名称转换为小写,可以使用

```bash
rename 'y/A-Z/a-z/' *
```

把文件名中的 中划线 改称 下划线

```bash
rename -n 'y/-/_/' */* # 先使用 -n 查看将被改名的文件，但不执行操作
rename -v 'y/-/_/' */* # 去掉 -n 选项，执行操作
```

***
后向引用

+ `` $`  `` : 匹配部分的前一部分字符串
+ `$&`: 匹配的字符串
+ `$'`: 还没有匹配的剩余字符串
+ `$1`: 反向引用的第一个字符串

***
参数

` -v, --verbose`
Verbose: 打印出重命名成功的文件.

`-0, --null`
当从`STDIN`读取时，使用`\0`作为分隔符。

`--path, --fullpath`
Rename full path: 重命名任何路径元素, 默认行为

`-d, --filename, --nopath, --nofullpath`

不重命名文件夹，只重命名文件部分。

`-n, --nono`
No action: 打印出要重命名的文件，但不执行操作

`-e  Expression`:
作用到文件名上的代码。可以重复使用`-e expr1 -e expr2 ...`来构建代码，(like `perl -e`). 如果没有`-e`，第一个参数被当成`code`

`-E Statement`:
类似于`-e`，但需要`;`结束

### 获取绝对路径

`realpath` - `print the resolved path`(打印已解析的路径)

SYNOPSIS
`realpath [OPTION]... FILE...`

DESCRIPTION
打印解析的绝对文件名； 除最后一个组件外的所有组件都必须存在

`-e`, `--canonicalize-existing`: 路径的所有组成部分必须存在
`-m`,`--canonicalize-missing`:路径组件不需要存在,也不必是目录
`-L`, `--logical`:解析符号链接前的`..`组件
`-P`, `--physical`:解析遇到的符号链接(默认)
`-q`, `--quiet`:禁止显示大多数错误消息
`--relative-to=DIR`:打印相对于`DIR`的解析路径
`--relative-base=DIR`:只打印`DIR`后面的绝对路径路径
`-s`, `--strip, --no-symlinks`:不扩展符号链接
`-z`,` --zero`:用NUL而不是换行符结束每个输出行

canonical order: 在排序中,指一种标准的顺序,比如字母顺序.

### tar压缩

***
创建压缩文件

+ `tar -cvf a.tar /etc`
+ `gzip foo.txt`
+ `gzip -fvr foo.txt `: force,verbose,recursive
+ `zip -r foo.zip a b c ...`

同时用`gunzip`压缩

+ `tar -czvf a.tar.gz /etc`

***
解压缩`xxx.tar.gz`

+ `tar -xzvf  xxx.tar.gz`
+ `gzip foo.txt`
+ `gzip -tv foo.txt.gz` : test,检验压缩文件完整性
+ `unzip file[.zip] [file(s) ...]  [-x xfile(s) ...] [-d exdir]`  文件名中可以使用通配符,但要quote起来

查看压缩文件内容,以下命令都可以

+ `tar -tf  xxx.tar.gz`
+ `tar -tzf  xxx.tar.gz`
+ `gunzip -c foo.txt | less`
+ `zcat foo.txt.gz | less`
+ `unzip -l file[.zip] [file(s) ...]`

### 7z解压缩

支持的格式

LZMA2, XZ, ZIP, Zip64, CAB, RAR (if the non-free p7zip-rar package is installed),
ARJ,  GZIP, BZIP2, TAR, CPIO, RPM, ISO

usage: `7z <command> [<switches>...] <archive_name> [<file_names>...] [<@listfiles...>]`

解压缩,输入密码,并保持目录结构:

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

### 查看字体

fc-list: list available fonts

```
fc-list [ -vVh ]  [ pattern  [ element... ]   ]
```

```bash
fc-list :lang=zh
```

`:lang=zh` 代表匹配模式

### 安装字体

[Ubuntu系统字体命令和字体的安装][]

[Ubuntu系统字体命令和字体的安装]: https://www.jianshu.com/p/e7f12b8c8602

字体有`.ttf格`式(truetype font)和`.otf`格式(opentype font)字体

如果系统中没有中文字体,需要先行安装中文字体,在`Ubuntu`和`Cent OS`中的安装步骤如下:

+ 从网络上下载字体或者直接从其他计算机(windows)上拷贝
+ 建立`/usr/share/fonts/myfonts` 目录
+ `cd /usr/share/fonts/`

在`/etc/fonts/conf.d`目录下,有字体配置文件的符号链接

如果`fonts/`目录不存在,则创建

```bash
mkdir fonts
mkdir myfonts
```

把下载好的字体拷贝到`/usr/share/fonts/myfonts`目录下:

```bash
sudo cp ~/myfonts/* /usr/share/fonts/myfonts/
# ~/myfonts/ 是保存字体的目录
```

+ 修改字体文件的权限,使root用户以外的用户也可以使用

```bash
cd /usr/share/fonts/
sudo chmod -R  755 myfonts/
```

(5) 建立字体缓存

```bash
sudo mkfontscale && mkfontdir && fc-cache -fv
```

```bash
sudo mkfontscale
# 如果提示 mkfontscale: command not found
# 在Ubuntu下运行如下命令
# sudo apt-get install ttf-mscorefonts-installer
# 在cent os下运行如下命令
# yum install mkfontscale
sudo mkfontdir
sudo fc-cache -fv
# fc-cache - build font information cache files
# 如果提示 fc-cache: command not found
# 在Ubuntu下运行如下命令
# sudo apt-get install fontconfig
# 在cent os下运行如下命令
# yum install fontconfig
```

至此字体就安装成功了,如果需要安装其他字体,只需将字体拷贝到字体目录下,重新运行以上的命令即可.

### apt 与 apt-get

[Linux中apt与apt-get命令的区别与解释][]

[Linux中apt与apt-get命令的区别与解释]: https://www.sysgeek.cn/apt-vs-apt-get/

如果你已阅读过我们的 apt-get 命令指南,可能已经遇到过许多类似的命令,如apt-cache,apt-config 等.如你所见,这些命令都比较低级又包含众多功能,普通的 Linux 用户也许永远都不会使用到.换种说法来说,就是最常用的 Linux 包管理命令都被分散在了 apt-get,apt-cache 和 apt-config 这三条命令当中.

`apt` 命令的引入就是为了解决命令过于分散的问题,它包括了 apt-get 命令出现以来使用最广泛的功能选项,以及 apt-cache 和 apt-config 命令中很少用到的功能.

在使用 apt 命令时,用户不必再由 apt-get 转到 apt-cache 或 apt-config,而且 apt 更加结构化,并为用户提供了管理软件包所需的必要选项.

> 简单来说就是:`apt = apt-get`,`apt-cache` 和 `apt-config` 中最常用命令选项的集合.

### apt-get

`--install-suggests`

将建议的软件包视为安装的依赖项. 配置项:`APT::Install-Suggests`.

### dpkg 安装应用

```bash
apt-get -f install pkg
```

***
安装应用 deb pkg

```bash
dpkg -i pkg
```

`-i`== `--install`

`-r` = `remove`

`ldd /bin/ls` == `ldd`查看依赖信息

### 查看应用安装信息

```bash
dpkg -l pkg
dpkg -L pkg
```

`install, remove, purge (apt-get(8))`

`apt list `(work-in-progress) 半成品

list is somewhat similar to `dpkg-query --list` in that it can display a list of packages satisfying certain criteria.

It supports glob(7) patterns for matching package names as well as options to list installed (`--installed`), upgradeable (`--upgradeable`) or all available (`--all-versions`) versions.

另外也可以用`whereis`

`whereis` - locate the binary, source, and manual page files for a command

### grep 过滤输出

+ `-n` 行号
+ `-v`,`--invert-match` 匹配不符合
+ `--color` 染色
+ `-P` perl 拓展
+ `-B` before 前输出
+ `-A` after 后输出
+ `-o` only 仅输出匹配字符
+ `-i` `--ignore-case` 忽略大小写
+ `-m NUM`, `--max-count=NUM` 输出的最大行

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

`-e PATTERNS`, `--regexp=PATTERNS`: 使用`PATTERNS`作为模式.
此选项可以多次使用或与`-f`(`--file`)选项结合使用,搜索给定的所有模式. 此选项可用于保护以`-`开头的模式.

`f FILE`, `--file=FILE`:从`FILE`中获取模式,每行一个.
如果此选项多次使用或与`-e`(`--regexp`)选项结合使用,则搜索给定的所有模式. 空文件包含零个模式,因此不匹配.

### 图片格式转换

pkg: `pdftoppm`

pdftoppm  -png -rx 300 -ry 300  input.pdf outputname

pdftoppm input.pdf outputname -png -f {page} -singlefile

This will output each page in the PDF using the format outputname-01.png, with 01 being the index of the page.
Converting a single page of the PDF

Change {page} to the page number. It's indexed at 1, so -f 1 would be the first page.

查看图片用 eye of gnome `eog`

### ubuntu 自带截图

ubuntu自带截图程序叫做`gnome-serceenshot`

[Ubuntu设置截图到剪贴板,像QQ一样截图][]

[Ubuntu设置截图到剪贴板,像QQ一样截图]: https://www.jianshu.com/p/7f453c144f9c

定义一个快捷键,保存到桌面文件

```bash
gnome-screenshot -a --file=(~"/Desktop/$(date +%s).png")
```

`date +%s`给出 UTC 时间

在 Ubuntu(18.04,16.04)或 Debian(Jessie 和更新版本)中安装 `GPaste`

对于 Debian,GPaste 可用于 Jessie 和更新版本,而对于 Ubuntu,GPaste 在 16.04 及更新版本的仓库中(因此可在 Ubuntu 18.04 Bionic Beaver 中使用).

你可以使用以下命令在 Debian 或 Ubuntu 中安装 GPaste(守护程序和 Gnome Shell 扩展):

```bash
sudo apt install gnome-shell-extensions-gpaste gpaste
```

安装完成后,按下 `Alt + F2` 并输入 `r` 重新启动 Gnome Shell,然后按回车键.
现在应该启用了 GPaste Gnome Shell 扩展,其图标应显示在顶部 Gnome Shell 面板上.
如果没有,请使用 Gnome Tweaks(Gnome Tweak Tool)启用扩展.

Debian 和 Ubuntu 的 GPaste 3.28.0 中有一个错误,如果启用了图像支持选项会导致它崩溃,所以现在不要启用此功能.
这在 GPaste 3.28.2 中被标记为已修复,但 Debian 和 Ubuntu 仓库中尚未提供此包.

### 文档格式转换

用 `pandoc`

`pandoc [options] [input-file]...`

`-f --from -t --to`

`--latex-engine=pdflatex|lualatex|xelatex`

把markdown转换成`pdf`

```bash
pandoc -f markdown --latex-engine=xelatex -o output.pdf input.md
```

### ubunut 安装 typora

[typora for linux][]

[typora for linux]: https://www.typora.io/#linux

```bash
# or run:
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
# install typora
sudo apt-get install typora
```

### 查看挂载的文件系统

+ `mount -l -t type` : `-l` 选项可以显示`label`
+ `findmnt [options] device|mountpoint`: 可以更清晰的显示文件系统
+ `umount [-dflnrv] {directory|device}` : 卸载文件系统,应该通过给出文件目录来使用,`-l, --lazy`Lazy  unmount

### 查看文档首行末行

文档尾巴

```bash
tail -n [+]num
```

`+num`  从第 num 行开始,

文档开头

```bash
head -n [-]num
```

`-num` 不输出最后num行

### 查看使用的桌面环境

[如何找出你所使用的桌面环境 ][]

[如何找出你所使用的桌面环境 ]: https://linux.cn/article-12124-1.html

#### 检查你使用的是哪个桌面环境

你可以在 Linux 中使用 `echo` 命令在终端中显示 `XDG_CURRENT_DESKTOP` 变量的值.

```bash
echo $XDG_CURRENT_DESKTOP
```

#### 如何获取桌面环境版本

与获取桌面环境的名称不同.获取其版本号的方法并不直接,因为它没有标准的命令或环境变量可以提供此信息.
在 Linux 中获取桌面环境信息的一种方法是使用 `Screenfetch` 之类的工具.
此命令行工具以 ascii 格式显示 Linux 发行版的 logo 以及一些基本的系统信息.桌面环境版本就是其中之一.
安装:`sudo apt install screenfetch`.

对于其他 Linux 发行版,请使用系统的软件包管理器来安装此程序.
安装后,只需在终端中输入 `screenfetch` 即可,它应该显示桌面环境版本以及其他系统信息.

### 查看linux 系统信息

ref: [3 Ways to Check Linux Kernel Version in Command Line](https://itsfoss.com/find-which-kernel-version-is-running-in-ubuntu/)

#### uname

`inxi -S`: 命令行 系统信息脚本 for console and IRC
`uname` -打印系统信息
`uname -r`命令的输出为:`5.4.0-48-generic`

这意味着您正在运行Linux内核`5.4.0-48`,或更笼统地说,您正在运行Linux内核版本`5.4`.

但是其他数字在这里意味着什么？

+ `5` – 内核版本
+ `4` – 重大修订
+ `0` – 次要修订
+ `48`– Bug fix
+ `generic`–特定于发行版的字符串.对于Ubuntu,这表示我使用的是`desktop`版本.
对于Ubuntu服务器版本,它将是`server`

使用`-a`选项可以输出更多信息
`uname -a`

命令的输出应如下所示:
`Linux OP7050 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux`

让我解释一下输出及其含义:

+ `Linux` –内核名称. 如果在BSD或macOS上运行相同的命令,结果将有所不同.
+ `OP7050` –主机名.
+ `5.4.0-48-generic` –内核版本(如我们在上面看到的).
+ `52-Ubuntu SMP Thu Sep 10 10:58:49 UTC 2020` –这意味着Ubuntu已编译`5.4.0-48-generic` `52`次. 最后一次编译的时间戳也在那里.
+ `x86_64` –机器架构.
+ `x86_64` –处理器架构.
+ `x86_64` –操作系统体系结构(您可以在64位处理器上运行32位OS).
+ `GNU / Linux` –操作系统(它不会显示发行版名称).

让我们看看其他一些命令来查找您的Linux内核版本.

#### 使用 /proc/version file

在Linux中,您还可以在文件`/proc/version`中找到内核信息. 只需查看此文件的内容即可:

`cat /proc/version`

在命令行中检查Linux内核版本, 您会看到类似于uname的输出.

`Linux version 5.4.0-48-generic (buildd@lcy01-amd64-010) (gcc version 9.3.0 (Ubuntu 9.3.0-10ubuntu2)) #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC 2020`

您可以在此处看到内核版本`5.4.0-48-generic`.

#### 使用dmesg

[Linux dmesg命令](https://www.runoob.com/linux/linux-comm-dmesg.html)

dmesg是用于编写内核消息的强大命令.这对于获取系统信息也非常有用.`dmesg`命令用于显示开机信息.
kernel会将开机信息存储在`ring buffer`中.您若是开机时来不及查看信息,可利用dmesg来查看.开机信息亦保存在`/var/log`目录中,名称为`dmesg`的文件里.

由于`dmesg`提供了很多信息,使用`grep`挑选.

```bash
dmesg | grep Linux
```

输出将包含几行,但是您应该能够在其中轻松识别Linux内核版本.

```bash
[    0.000000] Linux version 5.4.0-48-generic (buildd@lcy01-amd64-010) (gcc version 9.3.0 (Ubuntu 9.3.0-10ubuntu2)) #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC 2020 (Ubuntu 5.4.0-48.52-generic 5.4.60)
...
[   12.936690] Intel(R) Wireless WiFi driver for Linux
```

### curl

curl -fsSL https://www.preining.info/rsa.asc | tlmgr key add -

`-f, --fail`
（HTTP）服务器错误时静默失败（没有输出）。 这样做主要是为了更好地使脚本等更好地处理失败的尝试。
在正常情况下，当HTTP服务器无法交付文档时，它将返回HTML文档，说明（通常还会描述原因及更多）。 该`flag`将阻止`curl`输出该错误并返回`error 22`。

此方法不是`fail-safe`的，并且有时会漏入不成功的响应代码，尤其是在涉及验证时（response codes 401 and 407）。

`-s, --silent`

静音或安静模式。 不显示进度表或错误消息。 使`Curl`静音。 仍会输出您要求的数据，甚至到终端/标准输出，除非您将其重定向。
除此选项外，还可以使用`-S`，`--show-error`禁用进度表，但仍显示错误消息。
另请参见`-v`, `--verbose` and `--stderr`.       

`-S, --show-error`
与`-s`, `--silent`一起使用时，如果`curl`失败，它将使`curl`显示一条错误消息。

`-L, --location`

（HTTP）如果服务器报告请求的页面已移动到其他位置（由`Location:  header`  and  a `3XX`响应代码），此选项将使`curl`在新位置上重做请求。
如果与`-i`，`--include`或`-l`,`--head`一起使用，将显示所有请求页面的`headers`。使用身份验证时，curl仅将其凭据发送到初始主机.
如果重定向将curl转移到其他主机，它无法截获`user+password`。
另请参阅`--location-trusted`查看如何修改这项设置。
您可以使用`--max-redirs`选项来限制要遵循的重定向数量。

当curl跟随重定向并且请求不是简单的`GET`（例如`POST`或`PUT`）时，it will do the following request with a GET:
如果`HTTP`响应是`301`、`302`或`303`。如果响应代码是任何其他`3xx`代码，curl will resend the following request using the same unmodified method.

您可以通过使用专用的选项`--post301,` `--post302` and `--post303`, 来告诉curl 对于`30x`response, 不要将 `non-GET` request method 更改为`GET`.

### Gnu 隐私卫士

[Gnu 隐私卫士 (GnuPG) 袖珍 HOWTO (中文版)](https://www.gnupg.org/howtos/zh/index.html)

#### 引进钥匙

当你收到一把别人的公钥(或好几把公钥)时,为了能使用它们,你得把它们加进你的钥匙数据库.加进数据库的命令如下:

```bash
gpg --import [Filename]
```

如果文件名(`filename`)省略了,数据将从标准输入( `stdin`)读入.

#### 取消钥匙

因为好些原因,你可以想要取消一把已经存在的钥匙,
例如:密钥被盗了或被不该得到它的人得到,用户身份识别改变了,钥匙不够长了,等等.对上述各种情况,取消钥匙的命令是:

```bash
gpg --gen-revoke
```

该命令将产生一份取消钥匙证书.
要这么做,一定要先有密钥！ 否则任何人都能取消你的钥匙.
这种方法有一个缺点: 如果我不知道通行句就用不了密钥.但用不了密钥,我就不能取消我的钥匙.
为解决这个问题,在你产生钥匙对的时候就产生一份取消钥匙证书是一种明智的做法.
如果你这样做的话,一定要把证书保存好！ 你可以把它放在磁盘上,纸张上,等等.
一定要保证证书不落入坏人之手！！！ 否则别人就可以发出该证书取消你的钥匙,使你的钥匙作废.

#### 钥匙管理

随系统而来,有一个文件,起到某种数据库的作用.
所有有关钥匙和钥匙附带信息的数据都存在这个文件里(只有一样例外:主人的信任值.更多的信息见 钥匙签名).用

```bash
gpg --list-keys
```

可以显示所有现有的钥匙. 要想同时显示签名,用

```bash
gpg --list-sigs
```

(更多的信息见 钥匙签名). 要想见到钥匙的指纹,敲入:

```bash
gpg --fingerprint
```

用户需要见到`指纹`来确认某人说的身份是真的. 这个命令将会产生一列相对较小的数字.

### 查看ip地址

使用`ip`命令

```bash
ip addr show
ip link show #查看 MAC 地址
```

### 安装额外解码器

如果你刚刚安装了 Ubuntu 或其他 Ubuntu 特色版本 如 Kubuntu,Lubuntu 等,你会注意到系统无法播放某些音频或视频文件.

对于视频文件,你可以在 Ubuntu 上安装 `VLC`.`VLC` 是 Linux 上的最佳视频播放器之一,它几乎可以播放任何视频文件格式.但你仍然会遇到无法播放音频和 `flash` 的麻烦.

好消息是 Ubuntu 提供了一个软件包来安装所有基本的媒体编解码器:`ubuntu-restricted-extras`.

ubuntu-restricted-extras 是一个包含各种基本软件,如 `Flash` 插件,`unrar` ,`gstreamer`,`mp4`,`Ubuntu` 中的 `Chromium` 浏览器的编解码器等的软件包.

由于这些软件不是开源软件,并且其中一些涉及软件专利,因此 Ubuntu 默认情况下不会安装它们.你必须使用 `multiverse` 仓库,它是 Ubuntu 专门为用户提供非开源软件而创建的仓库.

由于 `ubuntu-restrcited-extras` 软件包在 `multiverse` 仓库中,因此你应验证系统上已启用 `multiverse` 仓库:

```bash
sudo add-apt-repository multiverse
```

然后你可以使用以下命令安装:

```bash
sudo apt install ubuntu-restricted-extras
```

[What are Ubuntu Repositories](https://itsfoss.com/ubuntu-repositories/)
[一条命令在 Ubuntu 中安装所有基本的媒体编解码器 ](https://linux.cn/article-11906-1.html)

## 创建链接

`ln` — 创建链接

`ln` 命令即可创建硬链接,也可以创建符号链接.

可以用其中一种方法来使用它:

+ `ln file link` 创建硬链接
+ `ln -s item link` 创建符号链接,`item` 可以是一个文件或是一个目录.

### 硬链接

硬链接和符号链接比起来,硬链接是最初 `Unix` 创建链接的方式,而符号链接更加现代. 在默认情况下,每个文
件有一个硬链接,这个硬链接给文件起名字.
当我们创建一个 硬链接以后,就为文件创建了一个额外的目录条目.硬链接有两个重要局限性:

1. 一个硬链接不能关联它所在文件系统之外的文件.这是说一个链接不能关联 与链接本身不在同一个磁盘分区
上的文件.
2. 一个硬链接不能关联一个目录.

一个硬链接和文件本身没有什么区别.不像符号链接,当你列出一个包含硬链接的目录 内容时,你会看到没有特
殊的链接指示说明.当一个硬链接被删除时,这个链接 被删除,但是文件本身的内容仍然存在(这是说,它所占
的磁盘空间不会被重新分配), 直到所有关联这个文件的链接都删除掉.知道硬链接很重要,因为你可能有时
会遇到它们,但现在实际中更喜欢使用符号链接,下一步我们会讨论符号链接.

### 符号链接

创建符号链接是为了克服硬链接的局限性.
符号链接生效,是通过创建一个特殊类型的文件,这个文件包含一个关联文件或目录的文本指针.
在这一方面, 它们和 Windows 的快捷方式差不多,当然,符号链接早于Windows 的快捷方式 很多年;-)

一个符号链接指向一个文件,而且这个符号链接本身与其它的符号链接几乎没有区别.
例如,如果你往一个符号链接里面写入东西,那么相关联的文件也被写入.

然而, 当你删除一个符号链接时,只有这个链接被删除,而不是文件自身.
如果先于符号链接删除文件,这个链接仍然存在,但是不指向任何东西.
在这种情况下,这个链接被称为坏链接.
在许多实现中,`ls` 命令会以不同的颜色展示坏链接,比如说红色,来显示它们的存在.

***
创建硬链接

现在,我们试着创建链接.首先是硬链接.我们创建一些关联我们 数据文件的链接:

```bash
[me@linuxbox playground]$ ln fun fun-hard
[me@linuxbox playground]$ ln fun dir1/fun-hard
[me@linuxbox playground]$ ln fun dir2/fun-hard
```

`ls` 命令有一种方法,来展示(文件索引节点)的信息.在命令中加上``-i``选项:

***
创建符号链接

建立符号链接的目的是为了克服硬链接的两个缺点:硬链接不能跨越物理设备, 硬链接不能关联目录,只能是文
件.符号链接是文件的特殊类型,它包含一个指向 目标文件或目录的文本指针.

符号链接的建立过程相似于创建硬链接:

```bash
[me@linuxbox playground]$ ln -s fun fun-sym
[me@linuxbox playground]$ ln -s ../fun dir1/fun-sym
[me@linuxbox playground]$ ln -s ../fun dir2/fun-sym
```

第一个实例相当直接,在 ln 命令中,简单地加上`-s`选项就可以创建一个符号链接, 而不是一个硬链接.

`fun-sym` 的列表说明了它是一个符号链接,通过在第一字段中的首字符`l` 可知,并且它还指向`../fun`,也是正确的.

当建立符号链接时,你即可以使用绝对路径名:

```bash
ln -s /home/me/playground/fun dir1/fun-sym
```

也可用相对路径名,正如前面例题所展示的.使用相对路径名更令人满意, 因为它允许一个包含符号链接的目录重命名或移动,而不会破坏链接.

### basename

#### 截取文件名和后缀

编写Shell脚本的过程中,经常会和文件名和文件路径打交道.
如果用户输入了一个文件的全名(可能包含绝对路径和文件后缀),如何得到文件的路径名,文件名,文件后缀这些信息呢.
Shell脚本拥有强大的字符串处理能力,如果把文件名当做字符串,我们不难使用`cut`或`sed`这样的工具得到我们想要的结果.

```bash
$fullfile=/the/path/foo.txt
$fullname=$(basename $fullfile)
$dir=$(dirname $fullfile)
$filename=$(echo $fullname | cut -d . -f1)
$extension=$(echo $fullname | cut -d . -f2)
$ echo $dir , $fullname , $filename , $extension
/the/path , foo.txt , foo , txt
```

这里使用`basename`命令可以直接得到包含后缀的文件名,而`dirname`命令可以得到路径名,
然后就能简单的用`cut`截取文件名和后缀名.

#### 更复杂的情况

如果对付简单应用场景,到这里已经可以打完收工了,但是有时候文件可能不止有一个后缀,比如`*.tar.gz`,怎样得到最后一个后缀呢？
再`cut`一回？当然可以,但是如果文件名是`mylib.1.0.1a.zip`这样的呢？呃......正则表达式肯定可以.

```bash
$ fullname=mylib.1.0.1a.zip
$ filename=$(echo $fullname | sed 's/\.[^.]*$//')
$ extension=$(echo $fullname | sed 's/^.*\.//')
$ echo $filename, $extension
mylib.1.0.1a, zip
```

这里面的逻辑是这样的:

文件名:把以`.`字符开头以后一直到行尾都是非`.`字符的子串替换为空.
后缀名:把从行首开始以`.`字符结尾的子串替换为空.

光用语言把这两个正则表达式描述出来脑细胞也要死不少.有没有像上面`cut`版本一样简单容易理解的方法呢？
由于`.`分隔符的个数不确定,正常使用`cut`来分割最后一个`.`字符是不太可能的.
但是我们可使用`rev`命令将字符串反转一下,区分后缀和文件名的`.`字符位置就确定了.
截取了想要的部分之后,再次反转就得到了我们想要的内容.

```bash
$ fullname=mylib.1.0.1a.zip
$ filename=$(rev <<< $fullname | cut -d . -f2- | rev)
$ extension=$(rev <<< $fullname | cut -d . -f1 | rev)
$ echo $filename, $extension
mylib.1.0.1a, zip
```

#### 使用参数扩展

其实不借助复杂的正则表达式,甚至不调用`basename`, `dirname`, `cut`, `sed`命令,`shel`l脚本一样可以做到所有的操作.
看下面的实现:

```bash
$ fullfile=/the/path/mylib.1.0.1a.zip
$ fullname="${fullfile##*/}"
$ dir="${fullfile%/*}"
$ extension="${fullname##*.}"
$ filename="${fullname%.*}"
$ echo $dir , $fullname , $filename , $extension
/the/path , mylib.1.0.1a.zip , mylib.1.0.1a , zip
```

真是不能再简洁了,大括号之内变量名配合几个神奇的字符,就是Shell的参数扩展(Parameter Extension)功能.

+ `${fullfile##*/}`:从前面开始删除`fullfile`中最大匹配(longest matching pattern) `*/` 的字符串
+ `${fullfile%/*}`:从后面开始删除`fullfile`中最小匹配(shortest matching pattern) `/*` 的字符串
+ `${fullname##*.}`:从前面开始删除`fullname`中最大匹配(longest matching pattern) `*.` 的字符串
+ `${fullname%.*}`:从后面开始删除`fullname`中最小匹配(shortest matching pattern) `.*` 的字符串

参数扩展有多种形式,在shell编程中可以用作参数的拼接,字符串的替换,参数列表截取,变量初值等操作,
这里不再详述,请参考后面的功能列表和官方文档

***
使用`basename`命令输出所有`*.tex`的名字

```bash
basename -s '.tex' $(ls *.tex) | xargs echo
```

### inode

[Linux的inode的理解](https://www.cnblogs.com/itech/archive/2012/05/15/2502284.html)

#### inode是什么

理解`inode`,要从文件储存说起.
文件储存在硬盘上,硬盘的最小存储单位叫做`扇区`(Sector).每个扇区储存`512`Byte(相当于`0.5KB`).
操作系统读取硬盘的时候,不会一个个扇区地读取,这样效率太低,而是一次性连续读取多个扇区,即一次性读取一个"块"(`block`).
这种由多个扇区组成的`块`,是文件存取的最小单位.`块`的大小,最常见的是`4KB`,即连续八个 `sector`组成一个 `block`.

文件数据都储存在`块`中,那么很显然,我们还必须找到一个地方储存文件的元信息,比如文件的创建者、文件的创建日期、文件的大小等等.
这种储存文件元信息的区域就叫做`inode`,中文译名为`索引节点`, `index node`.

#### inode的内容

`inode`包含文件的元信息,具体来说有以下内容:

+ 文件的字节数
+ 文件拥有者的User ID
+ 文件的Group ID
+ 文件的读、写、执行权限
+ 文件的时间戳,共有三个:`ctime` 指 `inode` 上一次变动的时间, `mtime` 指文件内容上一次变动的时间, `atime` 指文件上一次打开的时间.
+ 链接数,即有多少文件名指向这个 `inode`
+ 文件数据`block`的位置

可以用`stat`命令,查看某个文件的`inode`信息:

```bash
stat example.txt
```

总之,除了文件名以外的所有文件信息,都存在`inode`之中.至于为什么没有文件名,下文会有详细解释.

#### inode的大小

`inode`也会消耗硬盘空间,所以硬盘格式化的时候,操作系统自动将硬盘分成两个区域.一个是数据区,存放文件数据；另一个是`inode`区(`inode table`),存放`inode`所包含的信息.
每个`inode`节点的大小,一般是`128`字节或`256`字节.
`inode`节点的总数,在格式化时就给定,一般是每1KB或每2KB就设置一个`inode`.
假定在一块1GB的硬盘中,每个`inode`节点的大小为128字节,每`1KB`就设置一个`inode`,那么`inode table`的大小就会达到`128MB`,占整块硬盘的`12.8%`.

查看每个硬盘分区的`inode`总数和已经使用的数量,可以使用`df`命令.

```bash
df -i
```

查看每个`inode`节点的大小,可以用如下命令:

```bash
sudo dumpe2fs -h /dev/hda | grep "Inode size"
```

由于每个文件都必须有一个`inode`,因此有可能发生`inode`已经用光,但是硬盘还未存满的情况.这时,就无法在硬盘上创建新文件.

#### inode号码

每个`inode`都有一个号码,操作系统用`inode`号码来识别不同的文件.

这里值得重复一遍,`Unix/Linux`系统内部不使用文件名,而使用`inode`号码来识别文件.对于系统来说,文件名只是`inode`号码便于识别的别称或者绰号.
表面上,用户通过文件名,打开文件.实际上,系统内部这个过程分成三步:首先,系统找到这个文件名对应的`inode`号码；其次,通过`inode`号码,获取`inode`信息；
最后,根据`inode`信息,找到文件数据所在的`block`,读出数据.

使用`ls -i`命令,可以看到文件名对应的`inode`号码:

```bash
ls -i example.txt
```

#### 目录文件

`Unix/Linux`系统中,目录(directory)也是一种文件.打开目录,实际上就是打开目录文件.

目录文件的结构非常简单,就是一系列目录项(`dirent`)的列表.每个目录项,由两部分组成: 所包含文件的文件名,以及该文件名对应的 `inode` 号码.

`ls`命令只列出目录文件中的所有文件名:

```bash
ls /etc
```

ls -i命令列出整个目录文件,即文件名和`inode`号码:

```bash
ls -i /etc
```

如果要查看文件的详细信息,就必须根据`inode`号码,访问`inode`节点,读取信息.`ls -l`命令列出文件的详细信息.

```bash
ls -l /etc
```

#### 硬链接

一般情况下,文件名和`inode`号码是"一一对应"关系,每个`inode`号码对应一个文件名.但是,Unix/Linux系统允许,多个文件名指向同一个`inode`号码.
这意味着,可以用不同的文件名访问同样的内容；对文件内容进行修改,会影响到所有文件名；但是,删除一个文件名,不影响另一个文件名的访问.这种情况就被称为"硬链接"(`hard link`).

`ln`命令可以创建硬链接:

```bash
ln 源文件 目标文件
```

运行上面这条命令以后,源文件与目标文件的inode号码相同,都指向同一个`inode`.`inode`信息中有一项叫做"链接数",记录指向该`inode`的文件名总数,这时就会增加1.反过来,删除一个文件名,就会使得`inode`节点中的"链接数"减1.当这个值减到0,表明没有文件名指向这个`inode`,系统就会回收这个`inode`号码,以及其所对应`block`区域.

这里顺便说一下目录文件的"链接数".创建目录时,默认会生成两个目录项:"."和"..".前者的`inode`号码就是当前目录的`inode`号码,等同于当前目录的"硬链接"；后者的`inode`号码就是当前目录的父目录的`inode`号码,等同于父目录的"硬链接".所以,任何一个目录的"硬链接"总数,总是等于`2`加上它的子目录总数(含隐藏目录),这里的`2`是父目录对其的"硬链接"和当前目录下的".硬链接".

#### 软链接

除了硬链接以外,还有一种特殊情况.文件`A`和文件`B`的`inode`号码虽然不一样,但是文件`A`的内容是文件`B`的路径.
读取文件`A`时,系统会自动将访问者导向文件`B`.因此,无论打开哪一个文件,最终读取的都是文件`B`.这时,文件`A`就称为文件`B`的"软链接"(soft link)或者"符号链接(symbolic link).

这意味着,文件`A`依赖于文件`B`而存在,如果删除了文件`B`,打开文件`A`就会报错:"No such file or directory".
这是软链接与硬链接最大的不同:文件`A`指向文件`B`的文件名,而不是文件`B`的`inode`号码,文件`B`的`inode`"链接数"不会因此发生变化.

`ln -s`命令可以创建软链接.

```bash
ln -s 源文文件或目录 目标文件或目录
```

### inode的特殊作用

由于inode号码与文件名分离,这种机制导致了一些`Unix/Linux`系统特有的现象.

+ 有时,文件名包含特殊字符,无法正常删除.这时,直接删除`inode`节点,就能起到删除文件的作用.
+ 移动文件或重命名文件,只是改变文件名,不影响`inode`号码.
+ 打开一个文件以后,系统就以`inode`号码来识别这个文件,不再考虑文件名.因此,通常来说,系统无法从`inode`号码得知文件名.

第`3`点使得软件更新变得简单,可以在不关闭软件的情况下进行更新,不需要重启.
因为系统通过`inode`号码,识别运行中的文件,不通过文件名.更新的时候,新版文件以同样的文件名,生成一个新的`inode`,不会影响到运行中的文件.
等到下一次运行这个软件的时候,文件名就自动指向新版文件,旧版文件的`inode`则被回收.

## bash 快捷键

[Bash 快捷键大全 ][]
[vim ,vi总是卡死,终于找到原因了.][]

[Bash 快捷键大全 ]: https://linux.cn/article-5660-1.html

[vim ,vi总是卡死,终于找到原因了.]: https://www.cnblogs.com/cocoliu/p/6369749.html

`Alt+tab`:切换程序
`` Alt+` ``:切换程序的不同窗口

在`vim`下,有时候不小心按下了`CTRL-S`,会冻结终端的输入,表现为按什么键都没有反应,这时候按下`CTRL-Q`即可恢复.

`CTRL-S`: `Suspend(XOFF)`,挂起.这个是冻结终端的`stdin`.要恢复可以按`CTRL-Q`.

### 常用的

| 快捷键   | 快捷键说明|
| --------------- | ----------- |
| `CTRL-/` | 撤消操作,Undo.    |
| `ALT-B`  | 光标往回跳一个词,词以非字母为界(跳动到当前光标所在词的开头).   |
| `ALT-F`  | 光标往前跳一个词(移动到光标所在词的末尾).     |
| `ALT-D`  | 删除光标所在位置到光标所在词的结尾位置的所有内容      |
| `ALT-BASKSPACE` | 删除光标所在位置到词开头的所有内容.    |
| `ALT-数值`      | 这个数值可以是正或者是负,这个键单独没有作用,必须后面再接其他内容,如果后面是字符,则表示重复次数.如:`[ALT-9,k]`则光标位置会插入`9`个`k`字符(负值在这种情况下无效)；如果后面接的是命令,则数字会影响后面命令的执行结果,如:`[ALT-9,CTRL-D]`则向`CTRL-D`默认方向相反(负数)的方向执行`9`次操作. |
| `ALT-<`  | 移动到历史记录中的第一行命令.   |
| `ALT->`  | 移动到历史的最后一行,即当前正在输入的行(没有输入的情况下为空). |
| `ALT-P`  | 从当前行开始向前搜索,有必要则向"上"移动,移动时,使用非增量搜索查找用户提供的字符串.      |
| `ALT-N`  | 从当前行开始向后搜索,如果有必要向"下"移动,移动时,使用非增量搜索查找用户提供的字符串.    |
| `ALT-?`  | 列出能够补全标志点前的条目.     |
| `ALT-C`  | 将光标所在位置的字母转为大写     |
| `ALT-U`  | 将光标所在位置到词尾的所有字母转为大写.       |
| `ALT-L`  | 将光标位置到词尾的所有字母转为小写.    |
| `ALT-R`  | 取消所有变更,并将当前行恢复到在历史记录中的原始状态  |
| `ALT-T`  | 当光标两侧都存在词的时候,交换光标两侧词的位置.如:`abc <ALT-T>bcd -> bcd abc|`     |
| `ALT-.`  | 使用前一次命令的最后一个词(命令本身也是一个词,参见后一篇的Bang命令中的词指示符概念).      |
| `CTRL-A` | 将光标移到行首(在命令行下)     |
| `CTRL-C` | 中断,终结一个前台作业.         |
| `CTRL-E` | 将光标移动到行尾(在命令行下)   |
| `CTRL-K` | 在控制台或 xterm 窗口输入文本时,`CTRL-K`会删除从光标所在处到行尾的所有字符.        |
| `CTRL-U` | 擦除从光标位置开始到行首的所有字符内容.       |
| `CTRL-W` | `CTRL-W` 会删除从在光标处往回的第一个空白符之间的内容 |
| `CTRL-Y` | 将之前已经清除的文本粘贴回来(主要针对`CTRL-U`或`CTRL-W`).     |
| `CTRL-N` | 每按一次,是更接近的一条命令.   |
| `CTRL-P` | 此快捷键召回的顺序是由近及远的召回,    |
| `ALT-*`  | 把能够补全[`ALT-?`]命令能生成的所有文本条目插入到标志点前.      |
| `CTRL-Q` | `Resume (XON)`.恢复/解冻,这个命令是恢复终端的stdin用的,可参见`CTRL-S`.    |
| `CTRL-R` | 回溯搜索(Backwards search)history缓冲区内的文本(在命令行下).注意:按下之后,提示符会变成`(reverse-i-search)'':`输入的搜索内容出现在单引号内,同时冒号后面出现最近最匹配的历史命令.         |
| `CTRL-S` | `Suspend(XOFF)`,挂起.这个是冻结终端的`stdin`.要恢复可以按`CTRL-Q`.        |
| `CTRL-T` | 交换光标位置与光标的前一个位置的字符内容(在命令行下)|
| `CTRL-\` | 退出.和`CTRL-C`差不多,也可能dump一个"core"文件到你的工作目录下(这个文件可能对你没用).    |
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
| `CTRL-A` | 将光标移到行首(在命令行下)          |
| `CTRL-B` | 退格 (非破坏性的),这个只是将光标位置往回移动一个位置.    |
| `CTRL-C` | 中断,终结一个前台作业. |
| `CTRL-D` | "EOF" (文件结尾:end of file).它用于表示标准输入(`stdin`)的结束.  |
| `CTRL-E` | 将光标移动到行尾(在命令行下)        |
| `CTRL-F` | 将光标向前移动一个字符(在命令行下)         |
| `CTRL-G` | `BEL`.在一些老式打印机终端上,这会引发一个响铃.在xterm终端上可能是哔的一声.     |
| `CTRL-H` | 擦除(Rubout)(破坏性的退格).在光标往回移动的时候,同时擦除光标前的一个字符.       |
| `CTRL-I` | 水平制表符.      |
| `CTRL-J` | 新行(`换行[line feed]`并到行首).在脚本中,也可能表示为八进制形式(`'\012'`)或十六进制形式(`'\x0a'`).   |
| `CTRL-K` | 垂直制表符(Vertical tab).在控制台或 xterm 窗口输入文本时,`CTRL-K`会删除从光标所在处到行尾的所有字符. |
| `CTRL-L` | 跳纸,换页(Formfeed),清屏.清空终端屏幕.在终端上,这个命令的作用和`clear`命令一样.但当这个命令发送到打印机时,`Ctrl-L`会直接跳到纸张(Paper sheet)的末尾.      |
| `CTRL-M` | 回车(Carriage return).  |
| `CTRL-N` | 擦除从history缓冲区召回的一行文本(在命令行下).如果当前输入是历史记录中选择的时候,这个是从这个历史记录开始,每按一次,是更接近的一条命令. |
| `CTRL-O` | 产生一个新行(在命令行下).          |
| `CTRL-P` | 从history缓冲区召回上一次的命令(在命令行下).此快捷键召回的顺序是由近及远的召回,即按一次,召回的是前一次的命令,再按一次,是召回上一次之前的命令,这和`CTRL-N`都是以当前的输入为起点,但是两个命令操作刚好相反,`CTRL-N`是从起点开始由远及近(如果起点是历史命令的话).        |
| `CTRL-Q` | `Resume (XON)`.恢复/解冻,这个命令是恢复终端的stdin用的,可参见`CTRL-S`.         |
| `CTRL-R` | 回溯搜索(Backwards search)history缓冲区内的文本(在命令行下).注意:按下之后,提示符会变成`(reverse-i-search)'':`输入的搜索内容出现在单引号内,同时冒号后面出现最近最匹配的历史命令. |
| `CTRL-S` | `Suspend(XOFF)`,挂起.这个是冻结终端的`stdin`.要恢复可以按`CTRL-Q`.|
| `CTRL-T` | 交换光标位置与光标的前一个位置的字符内容(在命令行下).比如:`echo $var;`,假设光标在`a`上,那么,按下`C-T`之后,`v`和`a`将会交换位置:`echo $avr;`.     |
| `CTRL-U` | 擦除从光标位置开始到行首的所有字符内容.在某些设置下,`CTRL-U`会不以光标位置为参考而删除整行的输入.    |
| `CTRL-V` | 在输入文本的时候,按下`C-V`之后,可以插入控制字符.比如:`echo -e '\x0a';`和`echo <CTRL-V><CTRL-J>;`这两种效果一样.这点功能在文本编辑器内非常有效. |
| `CTRL-W` | 当在控制台或一个xterm窗口敲入文本时, `CTRL-W` 会删除从在光标处往后(回)的第一个空白符之间的内容.在某些设置里, `CTRL-W` 删除光标往后(回)到第一个非文字和数字之间的字符.     |
| `CTRL-X` | 在某些文字处理程序中,这个控制字符将会剪切高亮的文本并且将它复制到剪贴板中.       |
| `CTRL-Y` | 将之前已经清除的文本粘贴回来(主要针对`CTRL-U`或`CTRL-W`).   |
| `CTRL-Z` | 暂停一个前台的作业；在某些文本处理程序中也作为替换操作；在MSDOS文件系统中作为EOF(End-of-file)字符.    |
| `CTRL-\` | 退出.和`CTRL-C`差不多,也可能dump一个"core"文件到你的工作目录下(这个文件可能对你没用).  |
| `CTRL-/` | 撤消操作,Undo.  |
| `CTRL-_` | 撤消操作.        |
| `CTRL-xx`       | 在行首和光标两个位置间进行切换,此处是两个`"x"`字符.      |
| `ALT-B`  | 光标往回跳一个词,词以非字母为界(跳动到当前光标所在词的开头). |
| `ALT-F`  | 光标往前跳一个词(移动到光标所在词的末尾).   |
| `ALT-D`  | 删除光标所在位置到光标所在词的结尾位置的所有内容(如果光标是在词开头,则删除整个词).      |
| `ALT-BASKSPACE` | 删除光标所在位置到词开头的所有内容.         |
| `ALT-C`  | 将光标所在位置的字母转为大写(如果光标在一个词的起始位置或之前,则词首字母大写).   |
| `ALT-U`  | 将光标所在位置到词尾的所有字母转为大写.     |
| `ALT-L`  | 将光标位置到词尾的所有字母转为小写.         |
| `ALT-R`  | 取消所有变更,并将当前行恢复到在历史记录中的原始状态(前提是当前命令是从历史记录中来的,如果是手动输入,则会清空行).        |
| `ALT-T`  | 当光标两侧都存在词的时候,交换光标两侧词的位置.如:`abc <ALT-T>bcd -> bcd abc|`   |
| `ALT-.`  | 使用前一次命令的最后一个词(命令本身也是一个词,参见后一篇的Bang命令中的词指示符概念).    |
| `ALT-_`  | 同`ALT-.`.       |
| `ALT-数值`      | 这个数值可以是正或者是负,这个键单独没有作用,必须后面再接其他内容,如果后面是字符,则表示重复次数.如:`[ALT-10,k]`则光标位置会插入`10`个`k`字符(负值在这种情况下无效)；如果后面接的是命令,则数字会影响后面命令的执行结果,如:`[ALT--10,CTRL-D]`则向`CTRL-D`默认方向相反(负数)的方向执行`10`次操作. |
| `ALT-<`  | 移动到历史记录中的第一行命令.        |
| `ALT->`  | 移动到历史的最后一行,即当前正在输入的行(没有输入的情况下为空).      |
| `ALT-P`  | 从当前行开始向前搜索,有必要则向"上"移动,移动时,使用非增量搜索查找用户提供的字符串.    |
| `ALT-N`  | 从当前行开始向后搜索,如果有必要向"下"移动,移动时,使用非增量搜索查找用户提供的字符串.  |
| `ALT-CTRL-Y`    | 在标志点上插入前一个命令的第一个参数(一般是前一行的第二个词).如果有参数`n`,则插入前一个命令的第`n`个词(前一行的词编号从`0`开始,见历史扩展).负的参数将插入冲前一个命令的结尾开始的第n个词.参数`n`通过`M-No.`的方式传递,如:`[ALT-0,ALT-CTRL-Y]`插入前一个命令的第`0`个词(命令本身).        |
| `ALT-Y`  | 轮询到删除环,并复制新的顶端文本.只能在`yank[CTRL-Y]`或者`yank-pop[M-Y]`之后使用这个命令.      |
| `ALT-?`  | 列出能够补全标志点前的条目.          |
| `ALT-*`  | 把能够补全[`ALT-?`]命令能生成的所有文本条目插入到标志点前.|
| `ALT-/`  | 试图对标志点前的文本进行文件名补全.`[CTRL-X,/]`把标志点前的文本当成文件名并列出可以补全的条目. |
| `ALT-~`  | 把标志点前的文本当成用户名并试图进行补全.`[CTRL-X,~]`列出可以作为用户名补全标志点前的条目.     |
| `ALT-$`  | 把标志点前的文本当成Shell变量并试图进行补全.`[CTRL-X,$]`列出可以作为变量补全标志点前的条目.    |
| `ALT-@`  | 把标志点前的文本当成主机名并试图进行补全.`[CTRL-X,@]`列出可以作为主机补全标志点前的条目.       |
| `ALT-!`  | 把标志点前的文本当成命令名并试图进行补全.进行命令名补全时会依次使用别名,保留字,Shell函数,shell内部命令,最后是可执行文件名.`[CTRL-X,!]`把标志点前的文本当成命令名并列出可补全的条目.          |
| `ALT-TAB`       | 把标志点前的文本与历史记录中的文本进行比较以寻找匹配的并试图进行补全.|
| `ALT-{`  | 进行文件名补全,把可以补全的条目列表放在大括号之间,让shell可以使用. |

***

在控制台或`xterm` 窗口输入文本时,``CTRL-D`` 删除在光标下的字符.从一个shell中退出 (类似于`exit`).如果没有字符存在,``CTRL-D`` 则会登出该会话.在一个xterm窗口中,则会产生关闭此窗口的效果.

`CTRL-K`
在脚本中,也可能表示为八进制形式(`'\013'`)或十六进制形式(`'\x0b'`).在脚本中,`CTRL-K`可能会有不一样的行为,下面的例子给出其不一样的行为:

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

## shell 变量

[Shell变量:Shell变量的定义,赋值和删除][]

[Shell变量:Shell变量的定义,赋值和删除]: http://c.biancheng.net/view/743.html

脚本语言在定义变量时通常不需要指明类型,直接赋值就可以,`Shell` 变量也遵循这个规则.

在 `Bash shell` 中,每一个变量的值都是**字符串**,无论你给变量赋值时有没有使用引号,值都会以字符串的形式存储.

这意味着,`Bash shell` 在默认情况下不会区分变量类型,即使你将整数和小数赋值给变量,它们也会被视为字符串,这一点和大部分的编程语言不同.

例如在C语言或者 C++ 中,变量分为整数,小数,字符串,布尔等多种类型.

当然,如果有必要,你也可以使用 `Shell declare` 关键字显式定义变量的类型,但在一般情况下没有这个需求,Shell 开发者在编写代码时自行注意值的类型即可.

### 定义变量

`Shell` 支持以下三种定义变量的方式:

```bash
variable=value
variable='value'
variable="value"
```

`variable` 是变量名,`value` 是赋给变量的值.如果 `value` 不包含任何空白符(例如空格,`Tab` 缩进等),那么可以不使用引号；
如果 `value` 包含了空白符,那么就必须使用引号包围起来.使用单引号和使用双引号也是有区别的,稍后我们会详细说明.

注意,赋值号`=`的周围不能有空格,这可能和你熟悉的大部分编程语言都不一样.

`Shell` 变量的命名规范和大部分编程语言都一样:

+ 变量名由数字,字母,下划线组成；
+ 必须以字母或者下划线开头；
+ 不能使用 `Shell` 里的关键字(通过 `help` 命令可以查看保留关键字).

变量定义举例:

```bash
url=http://c.biancheng.net/shell/
echo $url
name='C语言中文网'
echo $name
author="严长生"
echo $author
```

### 使用变量

使用一个定义过的变量,只要在变量名前面加美元符号`$`即可,如:

```bash
author="严长生"
echo $author
echo ${author}
```

变量名外面的花括号`{ }`是可选的,加不加都行,
加花括号是为了帮助解释器识别变量的边界,比如下面这种情况:

```bash
skill="Java"
echo "I am good at ${skill}Script"
```

如果不给 `skill` 变量加花括号,写成`echo "I am good at $skillScript"`,解释器就会把 `$skillScript` 当成一个变量(其值为空),代码执行结果就不是我们期望的样子了.

推荐给所有变量加上花括号`{ }`,这是个良好的编程习惯.

### 修改变量的值

已定义的变量,可以被重新赋值,如:

```bash
url="http://c.biancheng.net"
echo ${url}
url="http://c.biancheng.net/shell/"
echo ${url}
```

第二次对变量赋值时不能在变量名前加`$`,只有在使用变量时才能加`$`.

### 单引号和双引号的区别

定义变量时,变量的值可以由单引号`' '`包围,也可以由双引号`" "`包围,
它们的区别以下面的代码为例来说明:

``` bash
#!/bin/bash
url="http://c.biancheng.net"
website1='C语言中文网:${url}'
website2="C语言中文网:${url}"
echo $website1
echo $website2
运行结果:
C语言中文网:${url}
C语言中文网:http://c.biancheng.net
```

以单引号`' '`包围变量的值时,单引号里面是什么就输出什么,即使内容中有变量和命令(命令需要`反引`起来)也会把它们原样输出.
这种方式比较适合定义显示纯字符串的情况,即不希望解析变量,命令等的场景.

以双引号`" "`包围变量的值时,输出时会先解析里面的变量和命令,而不是把双引号中的变量名和命令原样输出.
这种方式比较适合字符串中附带有变量和命令并且想将其解析后再输出的变量定义.

我的建议:
如果变量的内容是数字,那么可以不加引号；
如果真的需要原样输出就加单引号；
其他没有特别要求的字符串等最好都加上双引号,定义变量时加双引号是最常见的使用场景.

### 将命令的结果赋值给变量

`Shell` 也支持将命令的执行结果赋值给变量,常见的有以下两种方式:

```bash
variable=`command`
variable=$(command)
```

第一种方式把命令用反引号` `(位于 `Esc` 键的下方)包围起来,反引号和单引号非常相似,容易产生混淆,所以不推荐使用这种方式；
第二种方式把命令用`$()`包围起来,区分更加明显,所以推荐使用这种方式.

例如,我在 `demo` 目录中创建了一个名为 `log.txt` 的文本文件,用来记录我的日常工作.
下面的代码中,使用 `cat` 命令将 `log.txt` 的内容读取出来,并赋值给一个变量,然后使用 `echo` 命令输出.

```bash
[mozhiyan@localhost ~]$ cd demo
[mozhiyan@localhost demo]$ log=$(cat log.txt)
[mozhiyan@localhost demo]$ echo $log
严长生正在编写Shell教程,教程地址:http://c.biancheng.net/shell/
[mozhiyan@localhost demo]$ log=`cat log.txt`
[mozhiyan@localhost demo]$ echo $log
严长生正在编写Shell教程,教程地址:http://c.biancheng.net/shell/
```

### 只读变量

使用 `readonly` 命令可以将变量定义为只读变量,只读变量的值不能被改变.

下面的例子尝试更改只读变量,结果报错:

```bash
#!/bin/bash
myUrl="http://c.biancheng.net/shell/"
readonly myUrl
myUrl="http://c.biancheng.net/shell/"

运行脚本,结果如下:
bash: myUrl: This variable is read only.
```

### 删除变量

使用 `unset` 命令可以删除变量.语法:

```bash
unset variable_name
```

变量被删除后不能再次使用；`unset` 命令不能删除只读变量.

举个例子:

```bash
#!/bin/sh
myUrl="http://c.biancheng.net/shell/"
unset myUrl
echo $myUrl
```

上面的脚本没有任何输出.

### 变量类型

运行`shell`时,会同时存在三种变量:

1. **局部变量** 局部变量在脚本或命令中定义,仅在当前shell实例中有效,其他shell启动的程序不能访问局部变量.
2. **环境变量** 所有的程序,包括shell启动的程序,都能访问环境变量,有些程序需要环境变量来保证其正常运行.必要的时候shell脚本也可以定义环境变量.
3. **shell变量** shell变量是由shell程序设置的特殊变量.shell变量中有一部分是环境变量,有一部分是局部变量,这些变量保证了shell的正常运行

## Shell 字符串

字符串是`shell`编程中最常用最有用的数据类型(除了数字和字符串,也没啥其它类型好用了),字符串可以用单引号,也可以用双引号,也可以不用引号.单双引号的区别跟PHP类似.

### 单引号

```bash
str='this is a string'
```

单引号字符串的限制:

+ 单引号里的任何字符都会原样输出,单引号字符串中的变量是无效的；
+ 单引号字串中不能出现单独一个的单引号(对单引号使用转义符后也不行),但可成对出现,作为字符串拼接使用.

### 双引号

```bash
your_name='runoob'
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str
out: Hello, I know you are "runoob"!
```

双引号的优点:

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

以下实例从字符串第 `2` 个字符开始截取 `4` 个字符:

```bash
string="runoob is a great site"
echo ${string:1:4} # 输出 unoo
```

注意:第一个字符的索引值为 `0`.

### 查找子字符串

查找字符 `i` 或 `o` 的位置(哪个字母先出现就计算哪个):

```bash
string="runoob is a great site"
echo $(expr index "$string" io)  # 输出 4
```

### Shell 数组

bash支持一维数组(不支持多维数组),并且没有限定数组的大小.

类似于 `C` 语言,数组元素的下标由 `0` 开始编号.
获取数组中的元素要利用下标,下标可以是整数或算术表达式,其值应大于或等于 `0`.
定义数组

在 `Shell` 中,用括号来表示数组,数组元素用"空格"符号分割开.定义数组的一般形式为:

```bash
数组名=(值1 值2 ... 值n)
```

例如:

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

还可以单独定义数组的各个分量:

```bash
array_name[0]=value0
array_name[1]=value1
array_name[n]=valuen
```

可以不使用连续的下标,而且下标的范围没有限制.

### 读取数组

读取数组元素值的一般格式是:

```bash
${数组名[下标]}
```

例如:

```bash
valuen=${array_name[n]}
```

使用 `@` 符号可以获取数组中的所有元素,例如:

```bash
echo ${array_name[@]}
```

### 获取数组的长度

获取数组长度的方法与获取字符串长度的方法相同,例如:

```bash
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```

### Shell 注释

以 `#` 开头的行就是注释,会被解释器忽略.

通过每一行加一个 `#` 号设置多行注释,像这样:

```bash
#--------------------------------------------
# 这是一个注释
# author:菜鸟教程
# site:www.runoob.com
# slogan:学的不仅是技术,更是梦想！
#--------------------------------------------
##### 用户配置区 开始 #####
#
#
# 这里可以添加脚本描述信息
#
#
##### 用户配置区 结束  #####
```

如果在开发过程中,遇到大段的代码需要临时注释起来,过一会儿又取消注释,怎么办呢？

每一行加个`#`符号太费力了,可以把这一段要注释的代码用一对花括号括起来,定义成一个函数,
没有地方调用这个函数,这块代码就不会执行,达到了和注释一样的效果.

### 多行注释

多行注释还可以使用以下格式:

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

传入脚本的参数,要用双引号保护起来`"args"`,防止变量的自动分字(word splitting)
也就是双层引号可以避免分字

与`mathematica`配合的时候,尽量把长参数放到mathematica 脚本中,把短参数放到调用的`shell`中,结构化成一个关联的形式.

### 实例

## Shell 数组

### 实例

### shell中的数组作为参数传递

[shell中的数组作为参数传递][]

[shell中的数组作为参数传递]: https://blog.csdn.net/brouse8079/article/details/6417836

`./test.sh  "${atest[@]}"` 简而言之,需要把数组参数用引号括起来.

其中 `$0` 为执行的文件名(包含文件路径)

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

`atest`为数组.此时若把这个数组的内容作为参数调用另一个shell脚本时,写法很关键.

第一种写法:`./test.sh ${atest[@]}`

执行结果:

```bash
a
...
a0
```

此时传递的参数为`a bb cc dd ee ff gg hh ii jj`.把数组的内容组成了一个字符串,已经破坏了原来数组的结构.

第二种写法:`./test.sh  "${atest[@]}"`

执行结果:

```bash
a
bb cc
dd ee ff
gg hh ii jj
a0
```

把数组用双引号括起来,此时传递到`test.sh`中的参数仍然为数组的原来结构.

## 各种命令

### source

[Ubuntu如何使用source命令执行文件][]

[Ubuntu如何使用source命令执行文件]: http://www.xitongzhijia.net/xtjc/20150714/52870.html

`Ubuntu source` 命令的作用就是将设置在文件中的配置信息马上生效,而不需要经过重启.

Ubuntu如何使用`source`命令执行文件

source命令用法:
`source filename` 或 `. filename`

在对编译系统核心时常常需要输入一长串的命令,如:

```bash
make mrproper
make menuconfig
make dep
make clean
make bzImage
......
```

如果把这些命令做成一个文件,让它自动顺序执行,对于需要多次反复编译系统核心的用户来说会很方便,
而用source命令就可以做到这一点,
它的作用就是把一个文件的内容当成shell来执行,先在linux的源代码目录下(如`/usr/src/linux-2.4.20`)建立一个文件,如`make_command`,在其中输入一下内容:

```bash
make mrproper &&
make menuconfig &&
make dep &&
make clean &&
...
```

文件建立好之后,每次编译核心的时候,只需要在`/usr/src/linux-2.4.20`下输入:`source make_command`即可

顺便补充一点,`&&`命令表示顺序执行由它连接的命令,但是只有它之前的命令成功执行完成了之后才可以继续执行它后面的命令.

另外执行source命令时如果提示command not found,是因为环境变量没配置好的原因,在终端运行如下命令即可修复:

`export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin`

### Ubuntu Dock

[如何移除或禁用 Ubuntu Dock][]

[]: https://zhuanlan.zhihu.com/p/48078003

方法 4:使用 `Dash to Panel` 扩展

Dash to Panel 是 Gnome Shell 的一个高度可配置面板,是 Ubuntu Dock 或 Dash to Dock 的一个很好的替代品(Ubuntu Dock 是从 Dash to Dock 分叉而来的).

安装和启动 Dash to Panel 扩展会禁用 Ubuntu Dock,因此你无需执行其它任何操作.

你可以从 extensions.gnome.org 来安装 [Dash to Panel][].

如果你改变主意并希望重新使用 Ubuntu Dock,那么你可以使用 Gnome Tweaks 应用程序禁用 Dash to Panel,或者通过单击以下网址旁边的 X 按钮完全移除 `Dash to Panel`: https://extensions.gnome.org/local/ .

[Dash to Panel]: https://extensions.gnome.org/extension/1160/dash-to-panel/

## 挂载命令mount

[linux挂载命令mount及U盘,移动硬盘的挂载][]
[gpt格式的移动硬盘在Linux系统下挂载方法][]

[linux挂载命令mount及U盘,移动硬盘的挂载]: https://www.cnblogs.com/sunshine-cat/p/7922193.html

[gpt格式的移动硬盘在Linux系统下挂载方法]: https://blog.csdn.net/zhang_can/article/details/79714012?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase

查看当前磁盘列表的设备

```bash
sudo fdisk -l
```

显示某个特定设备

```bash
sudo fdisk -l /dev/sdb
```

首先查看所有已经 mount 的设备:

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

可以知道sdb2(135M to 6001G)为基本数据分区,格式为`NTFS`

mount command 的标准格式:

```bash
mount -t type device dir
```

告诉 kernel attach the filesystem found on `device` (which is of type `type`) at the directory `dir`.  The option `-t type` is optional.

挂载到指定目录即可:

```bash
sudo mount -t ntfs /dev/sda1 /home/6T
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

在Linux中,在执行命令时,系统会按照`PATH`的设置,去每个`PATH`定义的路径下搜索执行文件,先搜索到的文件先执行.

当我们在执行一个指令癿时候,举例来说"ls"好了,系统会依照PATH的设定去每个PATH定义的目录下搜寻文件名为ls 的可执行文件, 如果在PATH定义的目录中含有多个文件名为ls 的可执行文件,那么先搜寻到癿同名指令先被执行！

***
如何改变PATH

1. 直接修改`$PATH`值:

生效方法:立即生效
有效期限:临时改变,只能在当前的终端窗口中有效,当前窗口关闭后就会恢复原有的`path`配置
用户局限:仅对当前用户

`echo $PATH //查看当前PATH的配置路径`

`export PATH=$PATH:/xxx/xxx //将需配置路径加入$PATH  等号两边一定不能有空格`

配置完后可以通过第一句命令查看配置结果.

### 通过修改.bashrc文件

有效期限:永久有效
用户局限:仅对当前用户

`.bashrc`文件在根目录下

```bash
vi .bashrc  //编辑.bashrc文件
//在最后一行添上:
export PATH=$PATH:/xxx/xxx  ///xxx/xxx位需要加入的环境变量地址 等号两边没空格
```

生效方法:(有以下两种)

+ 关闭当前终端窗口,重新打开一个新终端窗口就能生效
+ 输入`source .bashrc`命令,立即生效

### 通过修改profile文件:(profile文件在/etc目录下)

生效方法:系统重启
有效期限:永久有效
用户局限:对所有用户

```bash
vi /etc/profile //编辑profile文件
//在最后一行添上:
export PATH=$PATH:/xxx/xxx
```

### 通过修改environment文件

生效方法:系统重启
有效期限:永久有效
用户局限:对所有用户

environment文件在`/etc`目录下

```bash
vi /etc/profile //编辑profile文件
在PATH=/......中加入`:/xxx/xxx`
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

在使用`{  }`时,`{  }`与命令之间必须使用一个`空格`

***
`$( )`命令替换

`$( )` 与 \`\` (反引号) 都是用来做命令替换

***
`${ }` 变量替换,各种字符串功能

`${ }` 用来作变量替换,把括号里的变量代入值.

***
`$(( ))`整数运算

在 bash 中,`$(( ))` 的整数运算符号大致有这些:

+ `+ - * /` :分别为 "加,减,乘,除".
+ `%` :余数运算
+ `& | ^ !`:分别为 "`AND`,`OR`,`XOR`,`NOT`" 运算.

### &&运算符

`&&` 运算符:
***
格式
`command1  && command2`

`&&`左边的命令(命令`1`)返回真(即返回`0`,成功被执行)后,`&&`右边的命令(命令`2`)才能够被执行；
换句话说,`如果这个命令执行成功`&&`那么执行这个命令`.

语法格式如下:

```bash
command1 && command2 && command3 ...
```

命令之间使用 `&&` 连接,实现逻辑与的功能.
只有在 `&&` 左边的命令返回真(命令返回值 `$? == 0`),`&&` 右边的命令才会被执行.
只要有一个命令返回假(命令返回值 $? == 1),后面的命令就不会被执行.

示例1中,`cp`命令首先从`root`的家目录复制文件文件`anaconda-ks.cfg`到 `/data`目录下；
执行成功后,使用 `rm` 命令删除源文件；如果删除成功则输出提示信息"`SUCCESS`".

`cp anaconda-ks.cfg /data/ && rm -f anaconda-ks.cfg && echo "SUCCESS"`

### || 运算符

格式

```bash
command1 || command2
```

`||`则与`&&`相反.如果`||`左边的命令(command1)未执行成功,那么就执行`||`右边的命令(command2)；
或者换句话说,`如果这个命令执行失败了`||`那么就执行这个命令.

命令之间使用 `||` 连接,实现逻辑或的功能.

只有在 `||` 左边的命令返回`假`(命令返回值 `$? == 1`),`||` 右边的命令才会被执行.
这和 `c` 语言中的逻辑或语法功能相同,即实现短路逻辑或操作.

只要有一个命令返回真(命令返回值 `$? == 0`),后面的命令就不会被执行.

如果 dir目录不存在,将输出提示信息 fail .

```bash
ls dir &>/dev/null || echo "fail"
```

如果 dir 目录存在,将输出 success 提示信息；否则输出 fail 提示信息.

```bash
ls dir &>/dev/null && echo "fail" || echo "fail"
```

***
`&>` 的意思是重定向标准输出和错误到 同一个地方,如

```bash
[me@linuxbox ~]$ ls -l /bin/usr &> ls-output.txt
```

利用`/dev/null`处理不需要的输出,这个文件是系统设备,叫做位存储桶,它可以 接受输入,并且对输入不做任何处理.

***
下面是一个shell脚本中常用的`||`组合示例

```bash
echo $BASH | grep -q 'bash' || { exec bash "$0" "$@" || exit 1; }
```

系统调用`exec`是以新的进程去代替原来的进程,但进程的`PID`保持不变.

因此,可以这样认为,`exec`系统调用并没有创建新的进程,只是替换了原来进程上下文的内容.
原进程的代码段,数据段,堆栈段被新的进程所代替.

### () 运算符

如果希望把几个命令合在一起执行, `shell` 提供了两种方法.既可以在当前shell也可以在子shell中执行一组命令.

格式:

```bash
(command1;command2;command3....)        多个命令之间用`;`分隔
```

一条命令需要独占一个物理行,如果需要将多条命令放在同一行,命令之间使用命令分隔符`(;)`分隔.
执行的效果等同于多个独立的命令单独执行的效果.`()` 表示在子shell 中将多个命令作为一个整体执行.
需要注意的是,使用 `()` 括起来的命令执行后,不会切换当前的工作目录.

命令组合常和命令执行控制结合起来使用.比如如果目录`dir`不存在,则执行命令组合.

```bash
ls dir &>/dev/null || (cd /home/; ls -lh; echo "success")
ls dir &>/dev/null || { cd /home/; ls -lh; echo "success" }
```

### {} 运算符

如果使用`{}`来代替`()`,那么相应的命令将在当前shell中作为一个整体被执行,

它的一般形式为:

```bash
{空格command1;command2;command3…空格}
```

注意:在使用`{}`时,`{}`与命令之间必须使用一个`空格`

使用`{}`则在子`shell`中执行了打印操作

```bash
A=1; echo $A; { A=2 }; echo $A
A=1; echo $A; (A=2); echo $A
```

另外,`{}`可以用来做花括号展开,开头称为报头,结尾称为附言,中间包含由逗号分开的字符串列表或整数列表,不能包含空白.
还可以使用范围.可以嵌套

```bash
echo Front-{A,B,C}-Back
echo Number_{1..5}
echo {Z..A}
echo aa{A{1,2},B{3,4}}bb
```

### $(( )) 与 $( ) ${ }

***
`$( )` 与 `backtick`

在 bash shell 中,`$( )` 与 \`\` (反引号) 都是用来做命令替换用(`command substitution`)的.

用 `$( )` 的理由:

1. \`\` 很容易与`' '` ( 单引号)搞混乱,尤其对初学者来说.
2. 在多层次的复合替换中,\`\` 须要额外的跳脱( \` )处理,而 `$( )` 则比较直观.

`$( )` 的不足:

1. \`\` 基本上可用在全部的 `unix shell` 中使用,若写成 `shell script` ,其移植性比较高.
而 `$( )` 并不见的每一种 `shell` 都能使用,我只能跟你说,若你用 bash2 的话,肯定没问题…   ^_^

***
`${ }` 用来作变量替换,把括号里的变量代入值.

以上的理解在于, 你一定要分清楚 `unset` 与 `null` 及 `non-null` 这三种赋值状态.
一般而言, `:` 与 `null` 有关, 若不带 `:` 的话, null 不受影响, 若带 `:` 则连 null 也受影响.

还有哦,`${#var}` 可计算出变量值的长度:
`${#file}` 可得到 `27` ,因为 `/dir1/dir2/dir3/my.file.txt` 刚好是 `27` 个字节…

***
接下来,再为大家介稍一下 `bash` 的组数(`array`)处理方法.

一般而言,`A="a b c def"` 这样的变量只是将 `$A` 替换为一个单一的字符串,
但是改为 `A=(a b c def) `,则是将 `$A` 定义为组数…

bash 的组数替换方法可参考如下方法:

+ `${A[@]}` 或 `${A[*]}` 可得到 `a b c def` (全部组数)
+ `${A[0]}` 可得到 `a` (第一个组数),${A[1]} 则为第二个组数…
+ `${#A[@]}` 或 `${#A[*]}` 可得到 `4` (全部组数数量)
+ `${#A[0]}` 可得到 `1` (即第一个组数(`a`)的长度),`${#A[3]}` 可得到 `3` (第四个组数(def)的长度)
+ `A[3]=xyz` 则是将第四个组数重新定义为 `xyz` …

### (())算术比较

好了,最后为大家介绍 `$(( ))` 的用途吧:它是用来作整数运算的.
在 bash 中,`$(( ))` 的整数运算符号大致有这些:
括号`(())`和`==`等操作符周围都不需要空格,但是为了统一,也可以加上

+ `+ - * /` :分别为 "加,减,乘,除".
+ `%` :余数运算
+ `& | ^ !`:分别为 "`AND`,`OR`,`XOR`,`NOT`" 运算.

`XOR` `exclusive OR`:一样为`0`,不一样为`1`,相当于不考虑进位的加法.

按位操作运算符

+ `<<`: 左移
+ `>>`: 右移
+ `&`: 按位与
+ `|`: 按位或
+ `~`: 按位非
+ `^`: 按位异或

例:

```bash
$ a=5; b=7; c=2
$ echo $(( a+b*c ))
19
$ echo $(( (a+b)/c ))
6
$ echo $(( (a*b)%c))
1
```

在 `$(( ))` 中的变量名称,可于其前面加 `$` 符号来替换,也可以不用,如:`$(( $a + $b * $c))` 也可得到 `19` 的结果
此外,`$(( ))` 还可作不同进位(如二进制,八进位,十六进制)作运算,只是,输出结果皆为十进制:

```bash
echo $((16#2a)) 结果为 42 (16进位转十进制)
```

以一个实用的例子来看看吧:

假如当前的   `umask` 是 `022` ,那么新建文件的权限即为:

```bash
$ umask 022
$ echo "obase=8;$(( 8#666 & (8#777 ^ 8#$(umask)) ))" | bc
644
```

事实上,单纯用 `(( ))` 也可重定义变量值,或作 `testing`:

+ `a=5; ((a++))` 可将 `$a` 重定义为 `6`
+ `a=5; ((a–))` 则为 `a=4`
+ `a=5; b=7; ((a < b))` 会得到   `0` (`true`) 的返回值.

常见的用于 `(( ))` 的测试符号有如下这些:

+ `<`:小于
+ `>`:大于
+ `<=`:小于或等于
+ `>=`:大于或等于
+ `==`:等于
+ `!=`:不等于

### []文件系统属性测试

Shell 里面的中括号(包括单中括号与双中括号)可用于一些条件的测试:

+ 算术比较, 比如一个变量是否为`0`, `[ $var -eq 0 ]`.
+ 文件属性测试,比如一个文件是否存在,`[ -e $var ]`, 是否是目录,`[ -d $var ]`.
+ 字符串比较, 比如两个字符串是否相同, `[[ $var1 = $var2 ]]`.

`[]` 常常可以使用 `test` 命令来代替,后面有介绍.

***
对变量或值进行算术条件判断:

+ `[ $var -eq 0 ]`  # 当 `$var` 等于 `0` 时,返回真
+ `[ $var -ne 0 ]`  # 当 `$var` 不等于 `0` 时,返回真

需要注意的是 `[` 与 `]` 与操作数之间一定要有一个空格,否则会报错.比如下面这样就会报错:

`[$var -eq 0 ]`  或 `[ $var -ne 0]`

其他比较操作符:

+ `-gt` 大于
+ `-lt` 小于
+ `-ge` 大于或等于
+ `-le` 小于或等于

可以通过 `-a` (and) 或 `-o` (or) 结合多个条件进行测试:

`[ $var1 -ne 0 -a $var2 -gt 2 ]`  # 使用逻辑与 `-a`
`[ $var1 -ne 0 -o $var2 -gt 2 ]`  # 使用逻辑或 `-o`

***
使用不同的条件标志测试不同的文件系统属性.

+ `[ -f $file_var ]` 变量 `$file_var` 是一个正常的文件路径或文件名 (`file`),则返回真
+ `[ -x $var ]` 变量 `$var` 包含的文件可执行 (`execute`),则返回真
+ `[ -d $var ]` 变量 `$var` 包含的文件是目录 (`directory`),则返回真
+ `[ -e $var ]` 变量 `$var` 包含的文件存在 (`exist`),则返回真
+ `[ -c $var ]` 变量 `$var` 包含的文件是一个字符设备文件的路径 (`character`),则返回真
+ `[ -b $var ]` 变量 `$var` 包含的文件是一个块设备文件的路径 (`block`),则返回真
+ `[ -w $var ]` 变量 `$var` 包含的文件可写(`write`),则返回真
+ `[ -r $var ]` 变量 `$var` 包含的文件可读 (`read`),则返回真
+ `[ -L $var ]` 变量 `$var` 包含是一个符号链接 (`link`),则返回真

Shell 还提供了与`-a` 、或`-o`、非`!`三个逻辑操作符用于将测试条件连接起来，其优先级为： `!` 最高， `-a` 次之， `-o` 最低

例如
`-e filename` 如果 `filename` 存在,则为真

如果存在某文件,则删除

```bash
if [ -f trials ]; then rm ${result_path}trials; fi
```

如果没有文件夹,则创建

```bash
if [ ! -d $result_name ];then
      mkdir -p $result_name
fi
```

用双引号把变量包起来, 例如：

```bash
abc="hello xx"
if test "hello" != "$abc"; then
    echo "Your word is not 'hello'."
fi
```

变量 `abc` 的值为 "hello xx"，在字符串中间有个空格。如果不用引号保护起来，Bash 进行命令解释的时候，上面的 `test` 命令变成：

```bash
test "hello" != hello xx
```

这不是一个合法的 `test` 命令，所以脚本执行时就会报错.
其实不光是空格，包含在 `$IFS `中的其它字符，还有变量为空时，都会造成语法错误。
所以使用双引号包裹变量是一种保护机制，可以提高脚本的健壮性。

[Shell 中的中括号用法总结][]
[linux shell 中判断文件,目录是否存在][]

[Shell 中的中括号用法总结]: https://www.runoob.com/w3cnote/shell-summary-brackets.html

[linux shell 中判断文件,目录是否存在]: https://blog.csdn.net/yifeng4321/article/details/70232436

### [[ ]]字符串比较

在进行字符串比较时,最好使用双中括号 `[[ ]]`. 因为单中括号可能会导致一些错误,因此最好避开它们.

检查两个字符串是否相同:

```bash
[[ $str1 == $str2 ]]
```

当 `str1` 等于 `str2` 时,返回真.也就是说, `str1` 和 `str2` 包含的文本是一样的.
其中的双等于号也可以写成单等于号,也就是说,上面的字符串比较等效于 `[[ $str1 = $str2 ]]`.
注意 `=` 前后有一个`空格`,如果忘记加空格, 就变成了赋值语句,而非比较关系了.
字符串比较,`[[`,`]]`,`==`周围必须都有空格,中括号比较时,变量必须写成如`$a`的形式.

字符串的其他比较情况:

+ `[[ $str1 != $str2 ]]`   如果 `str1` 与 `str2` 不相同,则返回真
+ `[[ -z $str1 ]]`   如果 `str1` 是`null`字符串,则返回真
+ `[[ -n $str1 ]]`   如果 `str1` 是非`null`字符串,则返回真

使用逻辑运算符 `&&` 和 `||` 可以轻松地将多个条件组合起来, 比如:

```bash
str1="Not empty"
str2=""
if [[ -n $str1 ]] && [[ -z $str2 ]];
then
  echo str1 is nonempty and str2 is empty string.
fi
```

`test` 命令也可以从来执行条件检测,用 `test` 可以避免使用过多的括号,`[]` 中的测试条件同样可以通过 `test` 来完成.

```bash
if [ $var -eq 0 ]; then echo "True"; fi
```

等价于:

```bash
if test $var -eq 0; then echo "True"; fi
```

## 字符串和数字

commandline chapter 35

在这一章中,我们将查看几个用来操作字符串和数字的 shell 功能.
shell 提供了各种执行字符串操作的参数展开功能.
除了算术展开(在第七章中接触过),还有一个常见的命令行程序叫做 `bc`,能执行更高级别的数学运算.

### 字符串总结

parameter 前面可能出现的保留字,`!`, `#`
parameter 后面可能接的保留字,`:` `#` `%` `/`

+ 返回变量名的参数展开
+ `${!prefix*}` :这种展开会返回以 `prefix` 开头的已有变量名
+ `${#parameter}` :展开成由 parameter 所包含的字符串的长度.
+ 空变量的展开
+ `${parameter:-word}` :若 parameter 没有设置(例如,不存在)或者为空,展开结果是 word 的值
+ `${parameter:=word}` :若 parameter 没有设置或为空,展开结果是 word 的值.另外,word 的值会赋值给 parameter.
+ `${parameter:?word}`:若 parameter 没有设置或为空,这种展开导致脚本带有错误退出,并且 word 的内容会发送到标准错误.
+ `${parameter:+word}`:若 parameter 为空,结果为空.若 parameter 不为空, word 的值; parameter 的值不改变.
+ 字符串展开
+ `${parameter:offset}` :从 `parameter` 所包含的字符串中提取一部分字符,到结尾
+ `${parameter:offset:length}` :从 `parameter` 所包含的字符串中提取一部分字符,`length`制定长度
+ 字符串修剪
+ `${parameter#pattern}` :从 `paramter` 所包含的字符串中清除开头的`pattern`
+ `${parameter##pattern}` :## 模式清除最长的匹配结果.
+ `${parameter%pattern}` :清除 `parameter` 末尾所包含的`pattern`
+ `${parameter%%pattern}` :%% 模式清除最长的匹配结果.
+ 字符串查找和替换操作 `parameter`必须是一个变量 `pattern` 和 `string` 可以不加引号
+ `${parameter/pattern/string}` :如果找到了匹配通配符 pattern 的文本, 则用 `string` 的内容替换它.
+ `${parameter//pattern/string}` : `//` 形式下,所有的匹配项都会被替换掉
+ `${parameter/#pattern/string}` :` /# `要求匹配项出现在字符串的开头,
+ `${parameter/%pattern/string}` :`/%` 要求匹配项出现在字符串的末尾

### 参数展开

尽管参数展开在第七章中出现过,但我们并没有详尽地介绍它,因为大多数的参数展开会用在脚本中,而不是命
令行中. 我们已经使用了一些形式的参数展开;例如,shell 变量.shell 提供了更多方式.

### 基本参数展开

最简单的参数展开形式反映在平常使用的变量上.

在这个例子中,我们试图创建一个文件名,通过把字符串 ``_file`` 附加到变量 `a` 的值的后面.

```bash
[me@linuxbox ~]$ a="foo"
[me@linuxbox ~]$ echo "$a_file"
```

如果我们执行这个序列,没有任何输出结果,因为 `shell` 会试着展开一个称为 `a_file` 的变量,而不是 `a`.通过添加花括号可以解决这个问题:

```bash
[me@linuxbox ~]$ echo "${a}_file"
foo_file
```

我们已经知道通过把数字包裹在花括号中,可以访问大于`9`的位置参数.例如,访问第十一个位置参数,我们可以这样做: `${11}`

### 管理空变量的展开

`null`
`undefined`
`defined`

几种用来处理不存在和空变量的参数展开形式.
这些展开形式对于解决丢失的位置参数和给参数指定默认值的情况很方便.

```bash
${parameter:-word}
```

若 parameter 没有设置(例如,不存在)或者为空,展开结果是 `word` 的值.
若 parameter 不为空,则展开结果是 parameter 的值.

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

若 parameter 没有设置或为空,展开结果是 word 的值.另外,word 的值会赋值给 parameter.
若parameter 不为空,展开结果是 parameter 的值.

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

注意: 位置参数或其它的特殊参数不能以这种方式赋值.

```bash
${parameter:?word}
```

若 parameter 没有设置或为空,这种展开导致脚本带有错误退出,并且 word 的内容会发送到标准错误.
若parameter 不为空, 展开结果是 parameter 的值.

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

若 parameter 没有设置或为空,展开结果为空.
若 parameter 不为空, 展开结果是 word 的值会替换掉parameter 的值;然而,parameter 的值不会改变.

```bash
foo=
echo ${foo:+"substitute value if set"}
foo=bar
echo ${foo:+"substitute value if set"}
```

### 返回变量名的参数展开

`shell` 具有返回变量名的能力.这会用在一些相当独特的情况下.

```bash
${!prefix*}
${!prefix@}
```

这种展开会返回以 `prefix` 开头的已有变量名.根据 bash 文档,这两种展开形式的执行结果相同.
这里,我们列出了所有以 `BASH` 开头的环境变量名:

```bash
[me@linuxbox ~]$ echo ${!BASH*}
BASH BASH_ARGC BASH_ARGV BASH_COMMAND BASH_COMPLETION
...
```

### 字符串展开

有大量的展开形式可用于操作字符串.其中许多展开形式尤其适用于路径名的展开.

```bash
${#parameter}
```

展开成由 `parameter` 所包含的字符串的长度.

通常,`parameter` 是一个字符串;然而,如果 `parameter` 是 `@`或者是 `*` 的话, 则展开结果是位置参数的个数.

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

这些展开用来从 `parameter` 所包含的字符串中提取一部分字符.
提取的字符始于第 `offset` 个字符(从字符串开头算起)直到字符串的末尾,除非指定提取的长度.

```bash
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo ${foo:5}
string is long.
[me@linuxbox ~]$ echo ${foo:5:6}
string
```

若 `offset` 的值为负数,则认为 `offset` 值是从字符串的末尾开始算起,而不是从开头.
注意负数前面必须有一个空格, 为防止与 `${parameter:-word}` 展开形式混淆.`length`,若出现,则必须不能小于零.
如果 `parameter` 是 `@`,展开结果是 `length` 个位置参数,从第 offset 个位置参数开始.

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

这些展开会从 `paramter` 所包含的字符串中清除开头一部分文本,这些字符要匹配定义的 `patten` .
pattern 是通配符模式,就如那些用在路径名展开中的模式.
这两种形式的差异之处是该 `#` 形式清除最短的匹配结果, 而该`##` 模式清除最长的匹配结果.

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

这些展开和上面的 `#` 和 `##` 展开一样,除了它们清除的文本从 `parameter` 所包含字符串的末尾开始,而不是开头.

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

这种形式的展开对 `parameter` 的内容执行查找和替换操作.

如果找到了匹配通配符 `pattern` 的文本, 则用 `string` 的内容替换它.
在正常形式下,只有第一个匹配项会被替换掉.在 `//` 形式下,所有的匹配项都会被替换掉.
` /# `要求匹配项出现在字符串的开头,而 `/%` 要求匹配项出现在字符串的末尾.
`/string` 可能会省略掉,这样会导致删除匹配的文本.

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

知道参数展开是件很好的事情.

字符串操作展开可以用来替换其它常见命令比方说 `sed` 和 `cut`.通过减少使用外部程序,展开提高了脚本的效率.

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
大的提高.

### formfactor bash 脚本

```bash
curveopacity=1
markers="Bands"
markopacity=0.1
expr_marker=3
expr_opacity=1

wolframscript -print "all" -file ./f.figure.series-full.rencon3.strange.baryons-all.band.wl "full" 0.90 1.50 $curveopacity $markers $markopacity $expr_marker $expr_opacity
```

### 通配符/Wildcard/glob

[Shell中的通配符][]

[Shell中的通配符]: https://www.jianshu.com/p/25f3d0cd5fdc

`glob()`, glob: 一滴 一团

`glob()`函数根据`shell`使用的规则搜索所有与模式匹配的路径名 (请参阅`glob(7)`)
没有`tilde expansion`或`parameter substitution`； 如果需要这些,请使用`wordexp(3)`.

`globfree()`函数释放先前调用`glob()`时,动态分配的存储空间 .
`man 7 glob()` see glob(7)

在 `Shell` 中命令中,通常会使用通配符表达式来匹配一些文件,如以下命令可以查找当前目录下所有后缀为 `.xml` 的文件
`find . -name "*.xml" `

Shell 中可以使用的通配符如下:

| 通配符| 含义| 实例|
|--|--|--|
|`*`|  匹配 `0` 或多个字符   | `a*b`,`a`与`b`之间可以有任意长度的任意字符, 也可以一个也没有, 如 `aabcb`, `axyzb`, `a012b`, `ab`|
| `?`| 匹配任意单个字符   |`a?b`,`a`与`b`之间有且只有一个字符, 可以是任意字符,如 `aab`, `abb`, `acb`, `a0b`|
| `[list]`|  匹配 `list` 中的任意单个字符 | `a[xyz]b`,`a`与`b`之间必须也只能有一个字符, 但只能是 `x` 或 `y` 或 `z`, 如 `axb`, `ayb`, `azb`.|
|`[!list]`|  匹配除 `list` 中的任意单一字符 |  `a[!0-9]b`,`a`与`b`之间必须也只能有一个字符, 但不能是阿拉伯数字, 如 `axb,` `aab`, `a-b`.|
|`[c1-c2]`| 匹配 `c1-c2` 中的任意单一字符 | `a[0-9]b`,匹配`0`与`9`之间其中一个字符,如 `a0b`, `a1b`... `a9b`|
| `{s1,s2,...}` | 匹配 `s1` 或 `s2` (或更多)中的一个字符串 |`a{abc,xyz,123}b`,`a`与`b`之间只能是`abc`或`xyz`或`123`这三个字符串之一|
| `[[:class:]]`| 匹配任意一个属于指定字符类中的字符 | `*[[:lower:]123]`,以小写字母开头,或者以`1`,`2`,`3`结尾的文件 |

常用字符类

+ `[:alnum:]` : 匹配任意一个字母或数字
+ `[:alpha:]` :  匹配任意一个字母
+ `[:digit:]` : 匹配任意一个数字
+ `[:lower:]` : 匹配任意一个小写字母
+ `[:upper:]` : 匹配任意一个大写字母

### 转义字符

有的时候,我们匹配的内容里面会存在 `*`,`?`,`[`等通配符中的符号.
为了表示他们原来的意思,我们需要使用转义字符 `\`,如 `a\[ac\]c` 表示匹配 `a[a]c` 或 `a[c]c`.

`\ `本身用` \\` 表示.

### 字符切割

分字 word splitting

[Shell_Linux Shell 中实现字符串切割的几种方法][]
[refs1][]
[refs2][]

[Shell_Linux Shell 中实现字符串切割的几种方法]: https://blog.csdn.net/u010003835/article/details/80750003
[refs1]: https://blog.csdn.net/u010003835/article/details/80749220
[refs2]: https://blog.csdn.net/whuslei/article/details/7187639

***
shell 的 `for` 参数可以是一个连续的字符串,用`IFS`分割

```bash
#!/bin/bash
string="hello shell split test"  ; for var in ${string[@]}; do    echo -e "$var EOF" ;done
####
echo test2
string="hello shell split test"
for var in ${string}
do
   echo -e "$var EOF"
done
```

***
我们在shell 脚本编程中,经常需要用到字符串切割,即将字符串切割为一个数组,
类似 `java` 中的`split`函数,下面对几种常见的方式做一个总结.

+ 利用shell 中 变量 的字符串替换
+ 设置分隔符,通过 `IFS` 变量
+ 利用`tr` 指令实现字符替换  (！只能针对单个分隔符)

***
方法一:利用shell 中 变量的字符串替换

示例:

```bash
#!/bin/bash
string="hello,shell,split,test"
array=(${string//,/ })

for var in ${array[@]}
do
   echo -e "$var \n"
done
```

***
方法二: 设置分隔符,通过 `IFS `变量

原理:自定义IFS变量, 改变分隔符, 对字符串进行切分

IFS 介绍

`Shell` 脚本中有个变量叫 `IFS`(Internal Field Seprator) ,**内部域分隔符**.

`Shell` 的环境变量分为 `set`, `env` 两种,其中 `set` 变量可以通过 `export` 工具导入到 `env` 变量中.
其中,`set` 是显示设置 `shell` 变量,仅在本 `shell` 中有效；`env` 是显示设置用户环境变量 ,仅在当前会话中有效.
换句话说,`set` 变量里包含了 `env` 变量,但 `set` 变量不一定都是 `env` 变量.
这两种变量不同之处在于变量的作用域不同.显然,`env` 变量的作用域要大些,它可以在 `subshell` 中使用.

而 `IFS` 是一种 `set` 变量,当 `shell` 处理"命令替换"和"参数替换"时, `shell` 根据 `IFS` 的值,默认是 `space`, `tab`, `newline` 来拆解读入的变量,然后对特殊字符进行处理,最后重新组合赋值给该变量.

***
`IFS` 简单实例

查看变量 `IFS` 的值.

```bash
$ echo $IFS

$ echo "$IFS" | od -b
0000000 040 011 012 012
0000004
```

直接输出IFS是看不到的,把它转化为二进制就可以看到了,
`040`是空格,`011`是Tab,`012`是换行符`\n` .
最后一个 `012` 是 `echo`输出的(`echo` 默认会换行的).

示例

```bash
#!/bin/bash

string="hello,shell,split,test"

#对IFS变量 进行替换处理
OLD_IFS="$IFS"
IFS=","
array=($string)
IFS="$OLD_IFS"

for var in ${array[@]}
do
   echo -e $var\n
done
```

***
方法三: 利用`tr`指令实现字符替换

原理: 由于只是对单个字符进行的替换,则可以用  `echo args |   tr "oldSpilt" "newSpilt"`  的方式实现.

`tr` 指令讲解: `tr`命令可以对来自标准输入的字符进行替换,压缩和删除.

语法:`tr(选项)(参数)`

选项

+ `-c`或`--complerment`:取代所有不属于第一字符集的字符；
+ `-d`或`--delete`:删除所有属于第一字符集的字符；
+ `-s`或`--squeeze-repeats`:把连续重复的字符以单独一个字符表示；
+ `-t`或`--truncate-set1`:先删除第一字符集较第二字符集多出的字符.

参数

+ `字符集1`:指定要转换或删除的原字符集.当执行转换操作时,必须使用参数`字符集2`指定转换的目标字符集.
但执行删除操作时,不需要参数`字符集2`；
+ `字符集2`:指定要转换成的目标字符集.

示例:

```bash
#!/bin/bash

string="hello,shell,split,test"
array=(`echo $string | tr ',' ' '` )

for var in ${array[@]}
do
   echo -e $var
done
```
