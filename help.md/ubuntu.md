# ubuntu

## 常用命令

### 复制移动

复制移动的时候，可以加上 `-i` 参数，防止覆盖

`cp -i  ... ... `

`cp -irf  ... ... `

短命令可以堆叠， `-i -r -f`=`-irf`=`--interactive --force --recursive`

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

> 简单来说就是：`apt = apt-get`、`apt-cache` 和 `apt-config` 中最常用命令选项的集合。

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

### grep 过滤输出

-n 行号
--color 染色
-P perl 拓展
-B before 前输出
-A after 后输出
-o only 仅输出匹配字符
-i --ignore-case 忽略大小写

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

文档开头

```bash
head -n [-]num
```

## bash 快捷键

[Bash 快捷键大全 ][]

[Bash 快捷键大全 ]: https://linux.cn/article-5660-1.html

### 常用的

| 快捷键| 快捷键说明 |
|---|---|
| `CTRL-/`  |撤消操作，Undo。|
| `ALT-B` | 光标往回跳一个词，词以非字母为界(跳动到当前光标所在词的开头)。|
| `ALT-F`  |光标往前跳一个词(移动到光标所在词的末尾)。|
| `ALT-D`  | 删除光标所在位置到光标所在词的结尾位置的所有内容|
| `ALT-BASKSPACE` | 删除光标所在位置到词开头的所有内容。|
| `ALT-数值`|  这个数值可以是正或者是负，这个键单独没有作用，必须后面再接其他内容，如果后面是字符，则表示重复次数。如：`[ALT-9,k]`则光标位置会插入`9`个`k`字符(负值在这种情况下无效)；如果后面接的是命令，则数字会影响后面命令的执行结果，如：`[ALT-9,CTRL-D]`则向`CTRL-D`默认方向相反(负数)的方向执行`9`次操作。|
| `ALT-<` | 移动到历史记录中的第一行命令。|
| `ALT->` | 移动到历史的最后一行，即当前正在输入的行(没有输入的情况下为空)。|
| `ALT-P`  |从当前行开始向前搜索，有必要则向"上"移动，移动时，使用非增量搜索查找用户提供的字符串。|
| `ALT-N` | 从当前行开始向后搜索，如果有必要向"下"移动，移动时，使用非增量搜索查找用户提供的字符串。|
| `ALT-?`  |列出能够补全标志点前的条目。|
| `ALT-C`  |将光标所在位置的字母转为大写|
| `ALT-U` | 将光标所在位置到词尾的所有字母转为大写。|
| `ALT-L`  |将光标位置到词尾的所有字母转为小写。|
| `ALT-R` | 取消所有变更，并将当前行恢复到在历史记录中的原始状态|
| `ALT-T` | 当光标两侧都存在词的时候，交换光标两侧词的位置。如：`abc <ALT-T>bcd -> bcd abc|`
| `ALT-.`  |使用前一次命令的最后一个词(命令本身也是一个词，参见后一篇的Bang命令中的词指示符概念)。|
| `CTRL-A` |  将光标移到行首（在命令行下）|
| `CTRL-C` |  中断，终结一个前台作业。|
| `CTRL-E` | 将光标移动到行尾（在命令行下）|
| `CTRL-K`   |在控制台或 xterm 窗口输入文本时，`CTRL-K`会删除从光标所在处到行尾的所有字符。|
| `CTRL-U`  |擦除从光标位置开始到行首的所有字符内容。|
| `CTRL-W`  |`CTRL-W` 会删除从在光标处往回的第一个空白符之间的内容|
| `CTRL-Y` | 将之前已经清除的文本粘贴回来（主要针对`CTRL-U`或`CTRL-W`）。|
| `CTRL-N`  |每按一次，是更接近的一条命令。
| `CTRL-P`  |此快捷键召回的顺序是由近及远的召回，|
| `ALT-*` | 把能够补全[`ALT-?`]命令能生成的所有文本条目插入到标志点前。|
| `CTRL-Q`  |`Resume (XON)`。恢复/解冻，这个命令是恢复终端的stdin用的，可参见`CTRL-S`。|
| `CTRL-R`  |回溯搜索(Backwards search)history缓冲区内的文本（在命令行下）。注意：按下之后，提示符会变成`(reverse-i-search)'':`输入的搜索内容出现在单引号内，同时冒号后面出现最近最匹配的历史命令。|
| `CTRL-S`  |`Suspend(XOFF)`，挂起。这个是冻结终端的`stdin`。要恢复可以按`CTRL-Q`。|
| `CTRL-T` | 交换光标位置与光标的前一个位置的字符内容（在命令行下）|
| `CTRL-\`  |退出。和`CTRL-C`差不多，也可能dump一个"core"文件到你的工作目录下(这个文件可能对你没用)。|

***

terminal 快捷键

| 快捷键| 快捷键说明 |
|---|---|
| `c+s+t`  | new tab|
| `c+s+n` | new window |
| `c+s+w`  |close tab|
| `c+s+q`  | close window |
| `c+page up` | switch to previous tab|
| `c+s+page up`|  switch to the left |

### 广泛的

| 快捷键| 快捷键说明 |
|---|---|
| `CTRL-A` |  将光标移到行首（在命令行下）|
| `CTRL-B` |  退格 (非破坏性的)，这个只是将光标位置往回移动一个位置。|
| `CTRL-C` |  中断，终结一个前台作业。|
| `CTRL-D` | "EOF" (文件结尾：end of file)。它用于表示标准输入（`stdin`）的结束。|
| `CTRL-E` | 将光标移动到行尾（在命令行下）|
| `CTRL-F` | 将光标向前移动一个字符（在命令行下）|
| `CTRL-G` | `BEL`。在一些老式打印机终端上，这会引发一个响铃。在xterm终端上可能是哔的一声。|
| `CTRL-H`  | 擦除(Rubout)(破坏性的退格)。在光标往回移动的时候，同时擦除光标前的一个字符。|
| `CTRL-I`  |水平制表符。|
| `CTRL-J`  |新行(`换行[line feed]`并到行首)。在脚本中，也可能表示为八进制形式(`'\012'`)或十六进制形式(`'\x0a'`)。|
| `CTRL-K`   |垂直制表符(Vertical tab)。在控制台或 xterm 窗口输入文本时，`CTRL-K`会删除从光标所在处到行尾的所有字符。|
| `CTRL-L` | 跳纸，换页(Formfeed)，清屏。清空终端屏幕。在终端上，这个命令的作用和`clear`命令一样。但当这个命令发送到打印机时，`Ctrl-L`会直接跳到纸张(Paper sheet)的末尾。|
| `CTRL-M`  |回车(Carriage return)。|
| `CTRL-N`  |擦除从history缓冲区召回的一行文本（在命令行下）。如果当前输入是历史记录中选择的时候，这个是从这个历史记录开始，每按一次，是更接近的一条命令。
| `CTRL-O`  |产生一个新行（在命令行下）。|
| `CTRL-P`  |从history缓冲区召回上一次的命令（在命令行下）。此快捷键召回的顺序是由近及远的召回，即按一次，召回的是前一次的命令，再按一次，是召回上一次之前的命令，这和`CTRL-N`都是以当前的输入为起点，但是两个命令操作刚好相反，`CTRL-N`是从起点开始由远及近（如果起点是历史命令的话）。|
| `CTRL-Q`  |`Resume (XON)`。恢复/解冻，这个命令是恢复终端的stdin用的，可参见`CTRL-S`。|
| `CTRL-R`  |回溯搜索(Backwards search)history缓冲区内的文本（在命令行下）。注意：按下之后，提示符会变成`(reverse-i-search)'':`输入的搜索内容出现在单引号内，同时冒号后面出现最近最匹配的历史命令。|
| `CTRL-S`  |`Suspend(XOFF)`，挂起。这个是冻结终端的`stdin`。要恢复可以按`CTRL-Q`。|
| `CTRL-T` | 交换光标位置与光标的前一个位置的字符内容（在命令行下）。比如：`echo $var;`，假设光标在`a`上，那么，按下`C-T`之后，`v`和`a`将会交换位置：`echo $avr;`。|
| `CTRL-U`  |擦除从光标位置开始到行首的所有字符内容。在某些设置下，`CTRL-U`会不以光标位置为参考而删除整行的输入。|
| `CTRL-V`  |在输入文本的时候，按下`C-V`之后，可以插入控制字符。比如：`echo -e '\x0a';`和`echo <CTRL-V><CTRL-J>;`这两种效果一样。这点功能在文本编辑器内非常有效。|
| `CTRL-W`  |当在控制台或一个xterm窗口敲入文本时, `CTRL-W` 会删除从在光标处往后（回）的第一个空白符之间的内容。在某些设置里, `CTRL-W` 删除光标往后（回）到第一个非文字和数字之间的字符。|
| `CTRL-X` | 在某些文字处理程序中，这个控制字符将会剪切高亮的文本并且将它复制到剪贴板中。|
| `CTRL-Y` | 将之前已经清除的文本粘贴回来（主要针对`CTRL-U`或`CTRL-W`）。|
| `CTRL-Z` | 暂停一个前台的作业；在某些文本处理程序中也作为替换操作；在MSDOS文件系统中作为EOF（End-of-file)字符。|
| `CTRL-\`  |退出。和`CTRL-C`差不多，也可能dump一个"core"文件到你的工作目录下(这个文件可能对你没用)。|
| `CTRL-/`  |撤消操作，Undo。|
| `CTRL-_`  |撤消操作。|
| `CTRL-xx`  |在行首和光标两个位置间进行切换，此处是两个`"x"`字符。|
| `ALT-B` | 光标往回跳一个词，词以非字母为界(跳动到当前光标所在词的开头)。|
| `ALT-F`  |光标往前跳一个词(移动到光标所在词的末尾)。|
| `ALT-D`  | 删除光标所在位置到光标所在词的结尾位置的所有内容(如果光标是在词开头，则删除整个词)。|
| `ALT-BASKSPACE` | 删除光标所在位置到词开头的所有内容。|
| `ALT-C`  |将光标所在位置的字母转为大写(如果光标在一个词的起始位置或之前，则词首字母大写)。|
| `ALT-U` | 将光标所在位置到词尾的所有字母转为大写。|
| `ALT-L`  |将光标位置到词尾的所有字母转为小写。|
| `ALT-R` | 取消所有变更，并将当前行恢复到在历史记录中的原始状态(前提是当前命令是从历史记录中来的，如果是手动输入，则会清空行)。|
| `ALT-T` | 当光标两侧都存在词的时候，交换光标两侧词的位置。如：`abc <ALT-T>bcd -> bcd abc|`
| `ALT-.`  |使用前一次命令的最后一个词(命令本身也是一个词，参见后一篇的Bang命令中的词指示符概念)。|
| `ALT-_` | 同`ALT-.`。|
| `ALT-数值`|  这个数值可以是正或者是负，这个键单独没有作用，必须后面再接其他内容，如果后面是字符，则表示重复次数。如：`[ALT-10,k]`则光标位置会插入`10`个`k`字符(负值在这种情况下无效)；如果后面接的是命令，则数字会影响后面命令的执行结果，如：`[ALT--10,CTRL-D]`则向`CTRL-D`默认方向相反(负数)的方向执行`10`次操作。|
| `ALT-<` | 移动到历史记录中的第一行命令。|
| `ALT->` | 移动到历史的最后一行，即当前正在输入的行(没有输入的情况下为空)。|
| `ALT-P`  |从当前行开始向前搜索，有必要则向"上"移动，移动时，使用非增量搜索查找用户提供的字符串。|
| `ALT-N` | 从当前行开始向后搜索，如果有必要向"下"移动，移动时，使用非增量搜索查找用户提供的字符串。|
| `ALT-CTRL-Y` | 在标志点上插入前一个命令的第一个参数(一般是前一行的第二个词)。如果有参数`n`，则插入前一个命令的第`n`个词(前一行的词编号从`0`开始，见历史扩展)。负的参数将插入冲前一个命令的结尾开始的第n个词。参数`n`通过`M-No.`的方式传递，如：`[ALT-0,ALT-CTRL-Y]`插入前一个命令的第`0`个词(命令本身)。
| `ALT-Y`  | 轮询到删除环，并复制新的顶端文本。只能在`yank[CTRL-Y]`或者`yank-pop[M-Y]`之后使用这个命令。|
| `ALT-?`  |列出能够补全标志点前的条目。|
| `ALT-*` | 把能够补全[`ALT-?`]命令能生成的所有文本条目插入到标志点前。|
| `ALT-/` | 试图对标志点前的文本进行文件名补全。`[CTRL-X,/]`把标志点前的文本当成文件名并列出可以补全的条目。|
| `ALT-~` | 把标志点前的文本当成用户名并试图进行补全。`[CTRL-X,~]`列出可以作为用户名补全标志点前的条目。|
|`ALT-$` | 把标志点前的文本当成Shell变量并试图进行补全。`[CTRL-X,$]`列出可以作为变量补全标志点前的条目。|
| `ALT-@`|  把标志点前的文本当成主机名并试图进行补全。`[CTRL-X,@]`列出可以作为主机补全标志点前的条目。|
| `ALT-!` | 把标志点前的文本当成命令名并试图进行补全。进行命令名补全时会依次使用别名、保留字、Shell函数、shell内部命令，最后是可执行文件名。`[CTRL-X,!]`把标志点前的文本当成命令名并列出可补全的条目。|
| `ALT-TAB` |把标志点前的文本与历史记录中的文本进行比较以寻找匹配的并试图进行补全。|
| `ALT-{` | 进行文件名补全，把可以补全的条目列表放在大括号之间，让shell可以使用。|

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

## 修改变量的值

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

## 网络

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

`Ubuntu 18.04 Server` 安装好后，Netplan 的默认描述文件是：`/etc/netplan/50-cloud-init.yaml`.

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

## source

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

`mount`的命令格式是（注意`mount`只能在root权限下运行）

`mount dervice dir`

`dervice` 是要挂载的设备，`dir` 是挂载点

***

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
/dev/sda1  *         2048 209719295 209717248   100G  7 HPFS/NTFS/exFAT
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

## lyx

如果是后安装的`texlive`, `lyx` 需要运行 `tools-reconfigure` 进行配置

## shell 中 && || () {} 用法

[shell 中 && || () {} 用法][]

[shell 中 && || () {} 用法]: https://www.jianshu.com/p/617c1ee1e46e

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
