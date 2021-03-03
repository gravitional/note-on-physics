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

## 日常

命令可以是下面四种形式之一:

1. 是一个可执行程序,就像我们所看到的位于目录`/usr/bin` 中的文件一样.
属于这一类的程序,可以编译成二进制文件,诸如用 `C` 和 `C++`语言写成的程序, 也可以是由脚本语言写成的程序,比如说 `shell`,`perl`,`python`,`ruby`,等等.
2. 是一个内建于 `shell` 自身的命令.bash 支持若干命令,内部叫做 shell 内部命令 `(builtins`).例如,`cd` 命
令,就是一个 `shell` 内部命令.
3. 是一个 `shell` 函数.这些是小规模的 `shell` 脚本,它们混合到环境变量中. 在后续的章节里,我们将讨论配
置环境变量以及书写 shell 函数.但是现在, 仅仅意识到它们的存在就可以了.
4. 是一个命令别名.我们可以定义自己的命令,建立在其它命令之上

***
[oh_my_zsh](https://ohmyz.sh/#install)

查看或设置主题

```zsh
_omz::theme list agnoster
_omz::theme set agnoster
```

更新 `omz`

```
_omz::update
```

***
powerline

[Powerline is a statusline plugin](https://github.com/powerline/powerline)
[Installation on Linux](https://powerline.readthedocs.io/en/latest/installation/linux.html)

get the latest release version

```powershell
pip install --user powerline-status
```

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
+ `sha256sum`: 计算并检查 `SHA256` message digest (消息摘要)
+ `xdg-open`: 可以设置别名为`open`, 使用默认的程序打开文件或者`url`.

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

[/etc/environment 与 /etc/profile区别](https://blog.csdn.net/lijingshan34/article/details/86568596)

`/etc/environment`是设置整个系统的环境，而`/etc/profile`是设置所有用户的环境，前者与登录用户无关，后者与登录用户有关。

跟环境变量相关的参数：

`/etc/profile` ->`/etc/enviroment` -->`$HOME/.profile` -->`$HOME/.env`

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

`$HOME`:用户目录

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

### 文件管理 cp rm mv

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

### 获取绝对路径 realpath

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

### tar and 7z 压缩

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
+ `unzip file[.zip] [file(s) ...]  [-x xfile(s) ...] [-d exdir]`  文件名中可以使用通配符,但要`quote`起来

查看压缩文件内容,以下命令都可以

+ `tar -tf  xxx.tar.gz`
+ `tar -tzf  xxx.tar.gz`
+ `gunzip -c foo.txt | less`
+ `zcat foo.txt.gz | less`
+ `unzip -l file[.zip] [file(s) ...]`

支持的解压过滤器如下

+ `-a, --auto-compress`  使用存档后缀来确定压缩程序。
+ `-I, --use-compress-program=COMMAND`: 通过COMMAND过滤数据。 它必须接受`-d`选项以进行解压缩。 该参数可以包含命令行选项。
+ `-j, --bzip2`: 通过`bzip2(1)`过滤存档。
+ `-J, --xz`: 通过`xz(1)`过滤存档。
+ `--lzip` :通过`lzip(1)`过滤存档。
+ `--lzma` :通过`lzma(1)`过滤存档。
+ `--lzop`:通过lzop(1)过滤存档。
+ `--no-auto-compress`: 不要使用存档后缀来确定压缩程序。
+ `-z, --gzip, --gunzip, --ungzip`: 通过`gzip(1)`过滤存档。
+ `-Z, --compress, --uncompress`通过`compress(1)`过滤存档。
+ `--zstd`: 通过`zstd(1)`过滤存档。

***
7z解压缩

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

### 查看和安装字体

`fc-list`: list available fonts

```
fc-list [ -vVh ]  [ pattern  [ element... ]   ]
```

```bash
fc-list :lang=zh
```

`:lang=zh` 代表匹配模式

***
安装字体

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

如果你已阅读过我们的 `apt-get` 命令指南,可能已经遇到过许多类似的命令,如`apt-cache`,`apt-config` 等.如你所见,这些命令都比较低级又包含众多功能,普通的 Linux 用户也许永远都不会使用到.换种说法来说,就是最常用的 Linux 包管理命令都被分散在了 `apt-get`,`apt-cache` 和 `apt-config` 这三条命令当中.

`apt` 命令的引入就是为了解决命令过于分散的问题,它包括了 `apt-get` 命令出现以来使用最广泛的功能选项,以及 `apt-cache` 和 `apt-config` 命令中很少用到的功能.
在使用 apt 命令时,用户不必再由 `apt-get` 转到 `apt-cache` 或 `apt-config`,而且 apt 更加结构化,并为用户提供了管理软件包所需的必要选项.

> 简单来说就是:`apt = apt-get`,`apt-cache` 和 `apt-config` 中最常用命令选项的集合.

***
`apt`

`install, remove, purge (apt-get(8))`
`apt list`(半成品)
`apt list`类似于`dpkg-query --list`，它可以显示满足某些条件的软件包列表。

它支持用`glob(7)`匹配软件包名称，以及列出已安装（`--installed`），可升级（`--upgradeable`）或所有可用（`--all-versions`）版本的选项。

另外也可以用`whereis`

`whereis` - 找到命令的二进制文件，源文件和 man 文件

***
`apt-get --install-suggests`

将建议的软件包视为安装的依赖项. 配置项:`APT::Install-Suggests`.

```bash
apt-get -f install pkg
```

### dpkg 应用管理

+ `ldd /bin/ls` : `ldd`查看依赖信息
+ `dpkg -i pkg`: 安装`pkg.deb`
+ `dpkg -r pkg`: 删除已安装的程序包
+ `dpkg -P pkg`: 彻底清除已安装的程序包
+ `dpkg -l, --list package-name-pattern...`: 列出与给定模式匹配的软件包。
+ `dpkg -s, --status package-name...`: 报告指定软件包的状态。
+ `dpkg -L, --listfiles package-name...`: 从软件包名称列出安装到系统的文件。
+ `dpkg -S, --search filename-search-pattern...` 从已安装的软件包中搜索文件名。
+ `dpkg -p, --print-avail package-name...` 显示有关软件包名称的详细信息，存放在`/var/lib/dpkg/available`,基于`APT`的前端的用户使用`apt-cache`

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

### 挂载命令 mount

[linux挂载命令mount及U盘,移动硬盘的挂载](https://www.cnblogs.com/sunshine-cat/p/7922193.html)
[gpt格式的移动硬盘在Linux系统下挂载方法](https://blog.csdn.net/zhang_can/article/details/79714012)

+ `mount -l -t type` : `-l` 选项可以显示`label`
+ `findmnt [options] device|mountpoint`: 可以更清晰的显示文件系统
+ `umount [-dflnrv] {directory|device}` : 卸载文件系统,应该通过给出文件目录来使用,`-l, --lazy`Lazy  unmount

***
`fdisk` 查看磁盘列表

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

mount 命令的标准格式:

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

### 格式化 exfat

[将 USB 盘格式化为 exFAT](https://linux.cn/article-12294-1.html)

从 `Linux kernel 5.4` 开始，Linux 内核本身中启用了 `exFAT` 文件系统支持。检查正在运行的 `Linux` 内核版本。`uname -r`
如果是内核 `5.4` 或更高版本，那么应该没问题。

不然，你必须启用 exFAT 支持。在基于 `Ubuntu` 的发行版中，你可以安装以下软件包：

```bash
sudo apt install exfat-fuse exfat-utils
```

***
方法 1：使用 `GNOME 磁盘工具`将磁盘格式化为 `exFAT`

使用`GNOME 磁盘` 格式化驱动器是一项简单的工作。它预装在许多 Linux 发行版中。
插入外部 `USB` 盘。在菜单中查找 `Disk`，然后打开`GNOME 磁盘` 应用。第一步，选择要格式化的驱动器，要使用 `exFAT`，请选择 `其它`，然后单击`下一步`。

***
方法 2：在 `Linux` 命令行中将磁盘格式化为 `exFAT`.

插入外部硬盘，然后在终端中输入以下命令：

```bash
sudo fdisk -l
```

通过列出的磁盘大小信息找出`USB`的标记，`/dev/sdb1`.
识别出 USB 盘后，请使用以下命令将它格式化为 `exfat`。将` /dev/sdXn` 替换为你的磁盘 `ID`。`LABEL` 是你要为磁盘命名的名称，例如 `Data`,`MyUSB` 等。

```bash
sudo mkfs.exfat -n LABEL /dev/sdXn
```

可选地，运行 `fsck` 检查，以确保格式化正确。

```bash
sudo fsck.exfat /dev/sdXn
```

就是这样。享受 `exFAT` 盘吧。

### 查看文档首行末行

文档尾巴, `tail -n, --lines=[+]NUM`, 从第`num`行开始. 
文档开头, `head -n, --lines=[-]NUM`, 减去最后`num`行.

### 查看使用的桌面环境

[如何找出你所使用的桌面环境 ](https://linux.cn/article-12124-1.html)

***
检查你使用的是哪个桌面环境

你可以在 Linux 中使用 `echo` 命令在终端中显示 `XDG_CURRENT_DESKTOP` 变量的值.

```bash
echo $XDG_CURRENT_DESKTOP
echo $XDG_SESSION_TYPE
```

***
如何获取桌面环境版本

与获取桌面环境的名称不同.获取其版本号的方法并不直接,因为它没有标准的命令或环境变量可以提供此信息.
在 Linux 中获取桌面环境信息的一种方法是使用 `Screenfetch` 之类的工具.
此命令行工具以 ascii 格式显示 Linux 发行版的 logo 以及一些基本的系统信息.桌面环境版本就是其中之一.
安装:`sudo apt install screenfetch`.

对于其他 Linux 发行版,请使用系统的软件包管理器来安装此程序.
安装后,只需在终端中输入 `screenfetch` 即可,它应该显示桌面环境版本以及其他系统信息.

### 查看linux 系统信息

ref: [3 Ways to Check Linux Kernel Version in Command Line](https://itsfoss.com/find-which-kernel-version-is-running-in-ubuntu/)

***
uname

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

***
使用 /proc/version file

在Linux中,您还可以在文件`/proc/version`中找到内核信息. 只需查看此文件的内容即可:

`cat /proc/version`

在命令行中检查Linux内核版本, 您会看到类似于uname的输出.

`Linux version 5.4.0-48-generic (buildd@lcy01-amd64-010) (gcc version 9.3.0 (Ubuntu 9.3.0-10ubuntu2)) #52-Ubuntu SMP Thu Sep 10 10:58:49 UTC 2020`

您可以在此处看到内核版本`5.4.0-48-generic`.

***
使用dmesg

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

### curl wget

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

### 查看磁盘空间

`df`命令是linux系统以磁盘分区为单位查看文件系统,可以加上参数查看磁盘剩余空间信息,命令格式:

`df - report file system disk space usage`

***
SYNOPSIS

`df [OPTION]... [FILE]...`

+ `-a`, `--all` include pseudo, duplicate, inaccessible file systems
+ `-l`, `--local` limit listing to local file systems
+ `-h`, `--human-readable` print sizes in powers of 1024 (e.g., 1023M)
+ `-T`, `--print-type` print file system type

### find

删除日志文件

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

`starting points`列表之后的部分是`表达式`。 这是一种查询规范，描述了我们如何匹配文件以及如何处理匹配的文件。
表达式由一系列事物组成:`Test`, `Actions`,...

***
`-exec command ;`

执行命令； 如果返回`0`状态，则为`true`。 之后传递给`find`的参数都将作为命令的参数，直到遇到`;`为止。
字符` {}`被替换为当前文件名命令参数中出现的任何地方的当前文件名，而不仅仅是在单独存在的参数中。
这两种构造都可能需要转义（以`\`表示）或加引号以保护它们，避免 shell 展开。
有关使用`-exec`选项的示例，请参见示例部分。对每个匹配的文件运行一次指定的命令。 
该命令在起始目录中执行。 与`-exec`有关的操作具有不可避免的安全问题； 你应该使用`-execdir`选项代替。

***
`-exec command {} +`

在选定的文件上运行指定的命令, `-exec` action的变体. 但是通过在命令结尾附加上每个选中的文件名; 
该命令的调用总数将远远少于匹配文件的数目。 命令行的构建方式与`xargs`几乎相同.
命令中仅允许使用一个`{}`实例，并且当从`shell`调用`find`时,应该用引号保护起来, 例如`'{}'`，以防止其被`shell`解释。 
该命令在起始目录中执行。 如果有任何调用返回一个非零值作为退出状态，则`find`返回一个非零退出状态。 
如果`find`遇到错误，有时可能会导致立即退出，因此一些待处理的命令可能根本不会运行。This variant of `-exec` always returns `true`.

***
`-mtime n`
文件数据的最后修改时间为 `n*24` 小时。请参阅`-atime`的注释，以了解舍入如何影响文件修改时间的解释

`-type c`
File is of type c:

+ `b`  block (buffered) special
+ `c`  character (unbuffered) special
+ `d`  directory
+ `p`  named pipe (FIFO)
+ `f`  regular file

### 查看文件大小

[Ubuntu下查看文件、文件夹和磁盘空间的大小](https://blog.csdn.net/BigData_Mining/java/article/details/88998472)

在实际使用`ubuntu`时候,经常要碰到需要查看文件以及文件夹大小的情况.
有时候,自己创建压缩文件,可以使用 `ls -hl`查看文件大小.参数`-h` 表示`Human-Readable`,使用`GB`,`MB`等易读的格式方式显示.对于文件夹的大小,`ll -h` 显示只有`4k`.

***
那么如何来查看文件夹的大小呢？

使用`du`命令查看文件或文件夹的磁盘使用空间,`–max-depth` 用于指定深入目录的层数.

如要查看当前目录已经使用总大小及当前目录下一级文件或文件夹各自使用的总空间大小,
输入`du -h --max-depth=1`即可.

如要查看当前目录已使用总大小可输入:`du -h --max-depth=0`

***

```bash
du [OPTION]... [FILE]...
du [OPTION]... --files0-from=F
```

+ `-s,` `--summarize`: 对每个参数仅显示总计
+ ` -h`, `--human-readable`: 以人类可读的格式显示大小（例如`1K` `234M` `2G`）
+ `-d,` `--max-depth=N`: 指定目录递归的层数； `--max-depth = 0`与`--summaryize`相同
+ `--si`   like `-h`, 但是使用`1000`的幂而不是`1024`的幂
+ `-a,` `--all` :给出所有文件的统计，而不仅仅是目录

### 创建链接

`ln` — 创建链接

`ln` 命令即可创建硬链接,也可以创建符号链接.

可以用其中一种方法来使用它:

+ `ln file link` 创建硬链接
+ `ln -s item link` 创建符号链接,`item` 可以是一个文件或是一个目录.

#### 硬链接

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

#### 符号链接

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

***
截取文件名和后缀

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

***
更复杂的情况

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

***
使用参数扩展

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

***
inode是什么

理解`inode`,要从文件储存说起.
文件储存在硬盘上,硬盘的最小存储单位叫做`扇区`(Sector).每个扇区储存`512`Byte(相当于`0.5KB`).
操作系统读取硬盘的时候,不会一个个扇区地读取,这样效率太低,而是一次性连续读取多个扇区,即一次性读取一个"块"(`block`).
这种由多个扇区组成的`块`,是文件存取的最小单位.`块`的大小,最常见的是`4KB`,即连续八个 `sector`组成一个 `block`.

文件数据都储存在`块`中,那么很显然,我们还必须找到一个地方储存文件的元信息,比如文件的创建者、文件的创建日期、文件的大小等等.
这种储存文件元信息的区域就叫做`inode`,中文译名为`索引节点`, `index node`.

***
inode的内容

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

***
inode的大小

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

***
inode号码

每个`inode`都有一个号码,操作系统用`inode`号码来识别不同的文件.

这里值得重复一遍,`Unix/Linux`系统内部不使用文件名,而使用`inode`号码来识别文件.对于系统来说,文件名只是`inode`号码便于识别的别称或者绰号.
表面上,用户通过文件名,打开文件.实际上,系统内部这个过程分成三步:首先,系统找到这个文件名对应的`inode`号码；其次,通过`inode`号码,获取`inode`信息；
最后,根据`inode`信息,找到文件数据所在的`block`,读出数据.

使用`ls -i`命令,可以看到文件名对应的`inode`号码:

```bash
ls -i example.txt
```

***
目录文件

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

***
硬链接

一般情况下,文件名和`inode`号码是"一一对应"关系,每个`inode`号码对应一个文件名.但是,Unix/Linux系统允许,多个文件名指向同一个`inode`号码.
这意味着,可以用不同的文件名访问同样的内容；对文件内容进行修改,会影响到所有文件名；但是,删除一个文件名,不影响另一个文件名的访问.这种情况就被称为"硬链接"(`hard link`).

`ln`命令可以创建硬链接:

```bash
ln 源文件 目标文件
```

运行上面这条命令以后,源文件与目标文件的inode号码相同,都指向同一个`inode`.`inode`信息中有一项叫做"链接数",记录指向该`inode`的文件名总数,这时就会增加1.反过来,删除一个文件名,就会使得`inode`节点中的"链接数"减1.当这个值减到0,表明没有文件名指向这个`inode`,系统就会回收这个`inode`号码,以及其所对应`block`区域.

这里顺便说一下目录文件的"链接数".创建目录时,默认会生成两个目录项:"."和"..".前者的`inode`号码就是当前目录的`inode`号码,等同于当前目录的"硬链接"；后者的`inode`号码就是当前目录的父目录的`inode`号码,等同于父目录的"硬链接".所以,任何一个目录的"硬链接"总数,总是等于`2`加上它的子目录总数(含隐藏目录),这里的`2`是父目录对其的"硬链接"和当前目录下的".硬链接".

***
软链接

除了硬链接以外,还有一种特殊情况.文件`A`和文件`B`的`inode`号码虽然不一样,但是文件`A`的内容是文件`B`的路径.
读取文件`A`时,系统会自动将访问者导向文件`B`.因此,无论打开哪一个文件,最终读取的都是文件`B`.这时,文件`A`就称为文件`B`的"软链接"(soft link)或者"符号链接(symbolic link).

这意味着,文件`A`依赖于文件`B`而存在,如果删除了文件`B`,打开文件`A`就会报错:"No such file or directory".
这是软链接与硬链接最大的不同:文件`A`指向文件`B`的文件名,而不是文件`B`的`inode`号码,文件`B`的`inode`"链接数"不会因此发生变化.

`ln -s`命令可以创建软链接.

```bash
ln -s 源文文件或目录 目标文件或目录
```

***
inode的特殊作用

由于inode号码与文件名分离,这种机制导致了一些`Unix/Linux`系统特有的现象.

+ 有时,文件名包含特殊字符,无法正常删除.这时,直接删除`inode`节点,就能起到删除文件的作用.
+ 移动文件或重命名文件,只是改变文件名,不影响`inode`号码.
+ 打开一个文件以后,系统就以`inode`号码来识别这个文件,不再考虑文件名.因此,通常来说,系统无法从`inode`号码得知文件名.

第`3`点使得软件更新变得简单,可以在不关闭软件的情况下进行更新,不需要重启.
因为系统通过`inode`号码,识别运行中的文件,不通过文件名.更新的时候,新版文件以同样的文件名,生成一个新的`inode`,不会影响到运行中的文件.
等到下一次运行这个软件的时候,文件名就自动指向新版文件,旧版文件的`inode`则被回收.

### shebang 脚本开头

[Shebang](https://bash.cyberciti.biz/guide/Shebang)

大多数`Linux shell`和`perl`/`python`脚本以以下行开头：

```bash
#!/bin/bash
#!/usr/bin/perl
#!/usr/bin/python
#!/usr/bin/python3
#!/usr/bin/env bash
```

这称为`shebang`或`bang`行。

`shebang`(意思为这一切)其实就是`Bash`解释器的绝对路径。几乎所有的`bash`脚本通常都以`#!/bin/bash`开头（假设`Bash`已安装在`/bin`中）.
这样可以确保即使在另一个`shell`下执行脚本，也可以使用`Bash`来解释该脚本。
`Shebang`是由Dennis Ritchie在第7版和8版`Unix`之间在`Bell`实验室推出的。 然后，它也被添加到Berkeley的`BSD`中。

`/usr/bin/env`在修改后的环境中运行`bash`之类的程序。 它使您的`bash`脚本具有可移植性。 
`#!/usr/bin/env bash`的优点是，它将使用运行用户的`$PATH`变量中最先出现的`bash`可执行文件。

## bash 快捷键

[Bash 快捷键大全 ](https://linux.cn/article-5660-1.html)
[vim ,vi总是卡死,终于找到原因了.](https://www.cnblogs.com/cocoliu/p/6369749.html)

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
