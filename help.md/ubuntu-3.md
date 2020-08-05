# ubuntu-3

## sed

sed是一种流编辑器，它是文本处理中非常中的工具，能够完美的配合正则表达式使用，功能不同凡响。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有 改变，除非你使用重定向存储输出。Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等

命令格式

```bash
sed [options] 'command' file(s)
sed [options] -f scriptfile file(s)
```

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

```bash
grep -A 1 SCC URFILE
sed -n '/SCC/{n;p}' URFILE
awk '/SCC/{getline; print}' URFILE
```

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

## Zsh和Bash的不同

[Zsh和Bash究竟有何不同][]
[Zsh和Bash，究竟有何不同 坑很深][]

[Zsh和Bash究竟有何不同]: https://blog.csdn.net/lixinze779/article/details/81012318
[Zsh和Bash，究竟有何不同 坑很深]: https://www.xshell.net/shell/bash_zsh.html

```bash
chsh -s /bin/bash
chsh -s /bin/zsh
```

开始之前：理解`Zsh`的仿真模式（emulation mode）

一种流行的说法是，`Zsh`是与`Bash`兼容的。这种说法既对，也不对，因为`Zsh`本身作为一种脚本语言，是与`Bash`不兼容的。
符合`Bash`规范的脚本无法保证被`Zsh`解释器正确执行。
但是，`Zsh`实现中包含了一个屌炸天的仿真模式（emulation mode），支持对两种主流的Bourne衍生版shell（`bash`、`ksh`）和`C shell`的仿真（`csh`的支持并不完整）。
在`Bash`的仿真模式下，可以使用与`Bash`相同的语法和命令集合，从而达到近乎完全兼容的目的。
为了激活对`Bash`的仿真，需要显式执行：

```bash
$ emulate bash
```

等效于：

```bash
$ emulate sh
```

`Zsh`是不会根据文件开头的`shebang`（如`#!/bin/sh`和`#!/bin/bash`）自动采取兼容模式来解释脚本的，
因此，要让`Zsh`解释执行一个其他`Shell`的脚本，你仍然必须手动`emulate sh`或者`emulate ksh`，告诉`Zsh`对何种Shell进行仿真。

那么，`Zsh`究竟在何时能够自动仿真某种Shell呢？

对于如今的绝大部分`GNU/Linux`（Debian系除外）和`Mac OS X`用户来说，系统默认的`/bin/sh`指向的是`bash`：

```bash
$ file /bin/sh
/bin/sh: symbolic link to `bash'
```

不妨试试用`zsh`来取代`bash`作为系统的`/bin/sh`：

`# ln -sf /bin/zsh /bin/sh `

所有的`Bash`脚本仍然能够正确执行，因为`Zsh`在作为`/bin/sh`存在时，能够自动采取其相应的兼容模式（`emulate sh`）来执行命令。
也许正是因为这个理由，Grml直接选择了`Zsh`作为它的`/bin/sh`，对现有的Bash脚本能做到近乎完美的兼容。

### shebang

无关主题：关于`/bin/sh`和`shebang`的可移植性

说到`/bin/sh`，就不得不提一下，在`Zsh`的语境下，`sh`指的是大多数`GNU/Linux`发行版上`/bin/sh`默认指向的`bash`，
或者至少是一个`Bash`的子集（若并非全部`GNU Bash`的最新特性都被实现的话），而非指`POSIX shell`。
因此，`Zsh`中的`emulate sh`可以被用来对`Bash`脚本进行仿真。

众所周知，`Debian`的默认`/bin/sh`是 `dash`（`Debian Almquist shell`），这是一个纯粹`POSIX shell`兼容的实现，基本上你要的`bash`和`ksh`里的那些高级特性它都没有。

“如果你在一个`#!/bin/sh`脚本中用到了非`POSIX shell`的东西，说明你的脚本写得是错的，不关我们发行版的事情。”Debian开发者们在把默认的`/bin/sh`换成`dash`，导致一些脚本出错时这样宣称道。

当然，我们应该继续假装与`POSIX shell`标准保持兼容是一件重要的事情，即使现在大家都已经用上了更高级的shell。

因为有非`GNU`的`Unix`，和`Debian GNU/Linux`这类发行版的存在，你不能够假设系统的`/bin/sh`总是`GNU Bash`，
也不应该把`#!/bin/sh`用作一个`Bash`脚本的`shebang`（--除非你愿意放弃你手头`Shell`的高级特性，写只与`POSIX shell`兼容的脚本）。

如果想要这个脚本能够被方便地移植的话，应指定其依赖的具体Shell解释器：`#!/usr/bin/env bash `
这样系统才能够总是使用正确的`Shell`来运行脚本。
（当然，显式地调用`bash`命令来执行脚本，`shebang`怎样写就无所谓了）

### echo命令 / 字符串转义

`Zsh`比之于`Bash`，可能最容易被注意到的一点不同是，`Zsh`中的`echo`和`printf`是内置的命令。

```zsh
$ which echo
echo: shell built-in command

$ which printf
printf: shell built-in command
```

`Bash`中的`echo`和`printf`同样是内置命令：

```bash
$ type echo
echo is a shell builtin

$ type printf
echo is a shell builtin
```

因为`which`本身并不是Bash中的内置命令, `which`在`Zsh`中是一个内置命令。

`Zsh`内置的`echo`命令，与我们以前在`GNU Bash`中常见的`echo`命令，使用方式是不兼容的。

首先，请看Bash：

```bash
$ echo \\
\
$ echo \\\\
\\
```

我们知道，因为这里传递给`echo`的只是一个字符串（允许使用反斜杠`\`转义），所以不加引号与加上双引号是等价的。
`Bash`输出了我们预想中的结果：每两个连续的`\`转义成一个`\`字符输出，最终`2`个变`1`个，`4`个变`2`个。没有任何惊奇之处。

你能猜到`Zsh`的输出结果么？

```bash
$ echo \\
\
$ echo \\\\
\
```

我们还知道，要想避免一个字符串被反斜杠转义，可以把它放进单引号。
正如我们在Bash中所清楚看到的这样，所有的反斜杠都照原样输出：

```bash
$ echo '\\'
\\
$ echo '\\\\'
\\\\
```

再一次，你能猜到Zsh的输出结果么？

```bash
$ echo '\\'
\
$ echo '\\\\'
\\
```

这个解释是这样的：在前一种不加引号（或者加了双引号）的情形下，**传递给`echo`内部命令的字符串将首先被转义**，
`echo \\`中的`\\`被转义成`\`，`echo \\\\`中的`\\\\`被转义成`\\`。

然后，在`echo`这个内部命令输出到终端的时候，它还要把这个东西再转义一遍，一个单独的`\`没法转义，所以仍然是作为`\`输出；
连续的`\\`被转义成`\`，所以输出就是`\`。因此，`echo \\`和`echo \\\\`的输出相同，都是`\`。

为了让`Zsh`中`echo`的输出不被转义，需要显式地指明`-E`选项：

```bash
$ echo -E \\
\
$ echo -E \\\\
\\
```

于是，我们也就知道在后一种加单引号的情形下，如何得到与原字符串完全相同的输出了：

```bash
$ echo -E '\\'
\\
$ echo -E '\\\\'
\\\\
```

而`Bash`的`echo`默认就是不对输出进行转义的，若要得到转义的效果，需显式地指定`-e`选项。`Bash`和`Zsh`中`echo`命令用法的不兼容，在这里体现出来了。

### 变量的自动分字（word splitting）

在`Bash`中，你可以通过调用外部命令`echo`输出一个字符串：

```bash
echo $text
```

我们知道，`Bash`**会对传递给命令的字符串进行分字（根据空格或换行符）**，然后作为多个参数传给`echo`。
当然，作为分隔符的换行，在最终输出时就被抹掉了。

于是，更好的习惯是把变量名放在双引号中，把它作为一个字符串传递，这样就可以保留文本中的换行符，将其原样输出。

```bash
echo "$text"
```

在`Zsh`中，你不需要通过双引号来告诉解释器“`$text`是一个字符串”。解释器不会把它转换成一个由`空格`或者`\n`分隔的参数列表或者别的什么。
所以，没有`Bash`中的`trick`，直接`echo $text`就可以保留换行符。
但是，如前一节所说，我们需要一个多余的工作来保证输出的是未转义的原始文本，那就是`-E`选项：

```bash
echo -E $text
```

从这里我们看到，**`Zsh`中的变量在传递给命令时是不会被自动切分成`words`然后以多个参数的形式存在的**。它仍然保持为一个量。

这是它与传统的`Bourne`衍生shell（`ksh`、`bash`）的一个重要不兼容之处。这是`Zsh`的特性，而不是一个bug。

### 通配符展开（globbing）

通配符展开（`globbing`）也许是`Unix shell`中最为实用化的功能之一。
比起正则表达式，它的功能相当有限，不过它的确能满足大部分时候的需求：依据固定的前缀或后缀匹配文件。
需要更复杂模式的时候其实是很少见的，至少在文件的命名和查找上。

`Bash`和`Zsh`对通配符展开的处理方式有何不同呢？
举个例子，假如我们想要列举出当前目录下所有的`.markdown`文件，但实际上又不存在这样的文件。
在`Zsh`中：（注意到这里使用了内置的`echo`，因为我们暂时还不想用到外部的系统命令）

```zsh
$ echo *.markdown
zsh: no matches found: *.markdown
```

`Bash`中：

```bash
$ echo *.markdown
*.markdown
```

Zsh因为通配符展开失败而报错；而`Bash`在通配符展开失败时，会放弃把它作为通配符展开、直接把它当做字面量返回。

看起来，`Zsh`的处理方式更优雅，因为这样你就可以知道这个通配符确实无法展开；
而在Bash中，你很难知道究竟是不存在这样的文件，还是存在一个文件名为`'*.markdown'`的文件。

接下来就是不那么和谐的方面了。

在`Zsh`中，用`ls`查看当然还是报错：

```zsh
$ ls *.markdown
zsh: no matches found: *.markdown
```

Bash，这时候调用`ls`也会报错。
因为当前目录下没有`.markdown`后缀的文件，通配符展开失败后变成字面的`'*.markdown'`，这个文件自然也不可能存在，所以外部命令`ls`报错：

```bash
$ ls *.markdown
ls: cannot access *.markdown: No such file or directory
```

同样是错误，差别在哪里？对于`Zsh`，这是一个语言级别的错误；
对于`Bash`，这是一个外部命令执行的错误。这件差别很重要，因为它意味着后者可以被轻易地`catch`，而前者不能。

想象一个常见的命令式编程语言，`Java`或者`Python`。你可以用`try...catch`或类似的语言结构来捕获运行时的异常，比较优雅地处理无法预料的错误。

`Shell`当然没有通用的异常机制，但是，你可以通过检测某一段命令的返回值来模拟捕获运行时的错误。例如，在`Bash`里可以这样：

```bash
$ if ls *.markdown &>/dev/null; then :; else echo $?; fi
2
```

于是，在通配符展开失败的情形下，我们也能轻易地把外部命令的错误输出重定向到`/dev/null`，然后根据返回的错误码执行后续的操作。

不过在`Zsh`中，这个来自`Zsh`解释器自身的错误输出却无法被重定向：

```zsh
$ if ls *.markdown &>/dev/null; then :; else echo $?; fi
zsh: no matches found: *.markdown
1
```

大部分时候，我们并不想看到这些丑陋多余的错误输出，我们期望程序能完全捕获这些错误，然后完成它该完成的工作。
但这也许是一种正常的行为。
理由是，在程序语言里，`syntax error`一般是无法简单地由用户在运行阶段自行`catch`的，这个报错工作将直接由解释器来完成。除非，当然，除非我们用了邪恶的`eval`。

```zsh
$ if eval "ls *.markdown" &>/dev/null; then :; else echo $?; fi
1
```

`Eval is evil`. 但在`Zsh`中捕获这样的错误，似乎没有更好的办法了。
必须这么做的原因就是：`Zsh`中，通配符展开失败是一个语法错误。而在`Bash`中则不是。

基于上述理由，依赖于`Bash`中通配符匹配失败而直接把`*`当作字面量传递给命令的写法，在`Zsh`中是无法正常运行的。
例如，在`Bash`中你可以：（虽然在大部分情况下能用，但显然不加引号是不科学的）

```bash
$ find /usr/share/git -name *.el
```

因为`Zsh`不会在`glob`扩展失败后自动把`*`当成字面量，而是直接报错终止运行，
所以在`Zsh`中你必须给`*.el`加上引号，来避免这种扩展：

```bash
$ find /usr/share/git -name "*.el"
```

### 字符串比较

在`Bash`中判断两个字符串是否相等：

```bash
[ "$foo" = "$bar" ]
```

或与之等效的（现代编程语言中更常见的`==`比较运算符）：

```bash
[ "$foo" == "$bar" ]
```

**注意等号左右必须加空格，变量名一定要放在双引号中**。（写过`Shell`的都知道这些规则的重要性）

在条件判断的语法上，`Zsh`基本和`Bash`相同，没有什么改进。除了它的解释器想得太多，以至于不小心把`==`当做了一个别的东西：

```bash
$ [ foo == bar ]; echo $?
zsh: = not found
```

要想使用我们最喜欢的`==`，只有把它用引号给保护起来，不让解释器做多余的解析：

```bash
$ [ foo "==" bar ]; echo $?
1
```

所以，为了少打几个字符，还是老老实实用更省事的`=`吧。

### 数组

同样用一个简单的例子来说明。Bash：

```bash
array=(alpha bravo charlie delta) 
echo $array 
echo ${array[*]} 
echo ${#array[*]} 
for ((i=0; i < ${#array[*]}; i++)); 
do
    echo ${array[$i]} 
done
```

输出：

```bash
alpha
alpha bravo charlie delta
4
alpha
bravo
charlie
delta
```

很容易看到，`Bash`的数组下标是从`0`开始的。`$array`取得的实际上是数组的第一个元素的值，也就是`${array[0]}`（这些行为和`C`有点像）。

要想取得整个数组的值，必须使用`${array[*]}`或`${array[@]}`，因此，获取数组的长度可以使用`${#array[*]}`。
在`Bash`中，必须记得在访问数组元素时给整个数组名连同下标加上花括号，
比如，`${array[*]}`不能写成`$array[*]`，否则解释器会首先把`$array`当作一个变量来处理。

再来看这段`Zsh`：

```zsh
array=(alpha bravo charlie delta) 
echo $array 
echo $array[*] 
echo $#array 
for ((i=1; i <= $#array[*]; i++)); 
do  
echo $array[$i] 
done
```

输出：

```zsh
alpha bravo charlie delta
alpha bravo charlie delta
4
alpha
bravo
charlie
delta
```

在`Zsh`中，`$array`和`$array[*]`一样，可以用来取得整个数组的值。因此获取数组的长度可直接用`$#array`。

`Zsh`的默认数组下标是从`1`而不是`0`开始的，这点更像`C shell`。
（虽然一直无法理解一个名字叫`C`的`shell`为何会采用`1`作为数组下标开始这种奇葩设定）

最后，`Zsh`不需要借助花括号来访问数组元素，因此`Bash`中必需的花括号都被略去了。

### 关联数组

`Bash 4.0+`和`Zsh`中都提供了对类似`AWK`关联数组的支持。

```bash
declare -A array
array[mort]=foo
```

和普通的数组一样，在`Bash`中，必须显式地借助花括号来访问一个数组元素：

```bash
echo ${array[mort]}
```

而`Zsh`中则没有必要：

```bash
echo $array[mort]
```

说到这里，我们注意到`Zsh`有一个不同寻常的特性：**支持使用方括号进行更复杂的`globbing`**，
`array[mort]`这样的写法事实上会造成二义性：
究竟是取`array`这个关联数组以`mort`为`key`的元素值呢，还是以通配符展开的方式匹配当前目录下以`"array"`开头，以`"m"`、`"o"`、`"r"`或`"t"`任一字符结尾的文件名呢？

在`array[mort]=`作为命令开始的情况下，不存在歧义，这是一个对关联数组的赋值操作。
在前面带有`$`的情况下，`Zsh`会自动把`$array[mort]`识别成取关联数组的值，这也没有太大问题。
问题出在它存在于命令中间，却又不带`$`的情况，比如：

```bash
read -r -d ' ' array[mort] << 'EOF' hello world EOF
```

我们的本意是把这个`heredoc`赋值给`array[mort]`数组元素。在`Bash`中，这是完全合法的。
然而，在`Zsh`中，解释器会首先试图对`"array[mort]"`这个模式进行`glob`展开，如果当前目录下没有符合该模式的文件，当然就会报出一个语法错误：

```zsh
zsh: no matches found: array[mort]
```

这是一件很傻的事情，为了让这段脚本能够被`Zsh`解释器正确执行，我们需要把`array[mort]`放在引号中以防止被展开：

```zsh
read -r -d '' 'array[mort]' << 'EOF' hello world EOF
```

这是`Zsh`在扩展了一些强大功能的同时带来的不便之处（或者说破坏了现有脚本兼容性的安全隐患，又或者是让解释器混乱的`pitfalls`）。

顺便说一句，用`Rake`构建过项目的`Rails`程序员都知道，有些时候需要在命令行下通过方括号给`rake`传递参数值，如：

```zsh
$ rake seeder:seed[100]
```

`Zsh`这个对方括号展开的特性确实很不方便。如果不想每次都用单引号把参数括起来，可以完全禁止`Zsh`对某条命令后面的参数进行`glob`扩展：（`~/.zshrc`）

```zsh
alias rake="noglob rake"
```

嗯，对于`rake`命令来说，`glob`扩展基本是没有用的。你可以关掉它。

### 分号与空语句

虽然有点无聊，但还是想提一下：`Bash`不允许语句块中使用空语句，最小化的语句是一个`noop`命令（`:`）。而`Zsh`允许空语句。

刚开始写`Bash`的时候，总是记不得什么时候该加分号什么时候不该加。比如

```bash
if [ 1 ] then : fi
```

如果放在一行里写，应该是

```bash
if [ 1 ]; then :; fi
```

`then`后面是不能接分号的，如果写成

```bash
if [ 1 ]; then; :; fi
```

就会报错：

```bash
bash: syntax error near unexpected token `;'
```

解释是：`then`表示一个代码段的开始，`fi`表示结束，这中间的内容必须是若干行命令，或者以分号`;`结尾的放在同一行内的多条命令。
我们知道在传统的`shell`中，分号本身并不是一条命令，空字符串也不是一条命令，因此，`then`后面紧接着的分号就会带来一条语法错误。（有些时候对某个“语言特性”的所谓解释只是为了掩饰设计者在一开始犯的错误，所以就此打住）

在`Zsh`中，上述两种写法都合法。因为它允许只包含一个分号的空命令。

```zsh
$ ;
```

当然，因为分号只是一个语句分隔符，所以没有也是可以的。这种写法在`Zsh`中合法：（`then`的语句块为空）

```zsh
if [ 1 ]; then fi
```

