# ubuntu-3

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

"如果你在一个`#!/bin/sh`脚本中用到了非`POSIX shell`的东西，说明你的脚本写得是错的，不关我们发行版的事情。"Debian开发者们在把默认的`/bin/sh`换成`dash`，导致一些脚本出错时这样宣称道。

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

在`Zsh`中，你不需要通过双引号来告诉解释器"`$text`是一个字符串"。解释器不会把它转换成一个由`空格`或者`\n`分隔的参数列表或者别的什么。
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
我们知道在传统的`shell`中，分号本身并不是一条命令，空字符串也不是一条命令，因此，`then`后面紧接着的分号就会带来一条语法错误。（有些时候对某个"语言特性"的所谓解释只是为了掩饰设计者在一开始犯的错误，所以就此打住）

在`Zsh`中，上述两种写法都合法。因为它允许只包含一个分号的空命令。

```zsh
$ ;
```

当然，因为分号只是一个语句分隔符，所以没有也是可以的。这种写法在`Zsh`中合法：（`then`的语句块为空）

```zsh
if [ 1 ]; then fi
```

## Linux技巧

[应该知道的Linux技巧][]

[应该知道的Linux技巧]: https://coolshell.cn/articles/8883.html

### 基础

+ 学习 `Bash` 。你可以`man bash`来看看`bash`的东西，并不复杂也并不长。你用别的shell也行，但是bash是很强大的并且也是系统默认的。（学习zsh或tsch只会让你在很多情况下受到限制）
+ 学习 `vim` 。在Linux下，基本没有什么可与之竞争的编译辑器（就算你是一个Emacs或Eclipse的重度用户）。你可以看看《简明vim攻略》和 《Vim的冒险游戏》以及《给程序员的Vim速查卡》还有《把Vim变成一个编程的IDE》等等。
+ 了解 `ssh`。明白不需要口令的用户认证（通过`ssh-agent`, `ssh-add`），学会用`ssh`翻墙，用`scp`而不是`ftp`传文件，等等。你知道吗？`scp` 远端的时候，你可以按`tab`键来查看远端的目录和文件（当然，需要无口令的用户认证），这都是bash的功劳。
+ 熟悉`bash`的作业管理，如：`&`, `Ctrl-Z`, `Ctrl-C`, `jobs`, `fg`, `bg`, `kill`, 等等。当然，你也要知道`Ctrl+\`（SIGQUIT）和`Ctrl+C` （SIGINT）的区别。
+ 简单的文件管理 ： `ls` 和 `ls -l` (你最好知道 `ls -l` 的每一列的意思), 
`less`, `head`, `tail` 和 `tail -f`, `ln` 和 `ln -s` (你知道明白`hard link`和`soft link`的不同和优缺点), 
`chown`, `chmod`, `du` (如果你想看看磁盘的大小 `du -sk *`), `df`, `mount`,`find`
+ 基础的网络管理： `ip` 或 `ifconfig`, `dig`,`netstat`, `ping`, `traceroute`, 等
+ 理解正则表达式，还有`grep`/`egrep`的各种选项。比如： `-o`, `-A`, 和 `-B` 这些选项是很值得了解的。
+ 学习使用 `apt-get` 和 `yum` 来查找和安装软件（前者的经典分发包是Ubuntu，后者的经典分发包是Redhat），我还建议你试着从源码编译安装软件。

### 日常

+ 在 `bash` 里，使用 `Ctrl-R` 而不是上下光标键来查找历史命令。
+ 在 `bash` 里，使用 `Ctrl-W` 来删除最后一个单词，使用 `Ctrl-U` 来删除一行。请`man bash`后查找`Readline Key Bindings`一节来看看`bash`的默认热键，比如：`Alt-.` 把上一次命令的最后一个参数打出来，而`Alt-*` 则列出你可以输入的命令。
+ 回到上一次的工作目录： `cd –`  （回到`home`是` cd ~`）
+ 使用 `xargs`。这是一个很强大的命令。你可以使用`-L`来限定有多少个命令，也可以用`-P`来指定并行的进程数。
如果你不知道你的命令会变成什么样，你可以使用`xargs echo`来看看会是什么样。当然， `-I{}` 也很好用。示例：

```bash
find . -name \*.py | xargs grep some_function
cat hosts | xargs -I{} ssh root@{} hostname
```

+ `pstree -p` 可以帮你显示进程树。
+ 使用 `pgrep` 和 `pkill` 来找到或是`kill`某个名字的进程。 (`-f` 选项很有用).
+ 了解可以发给进程的信号。例如：要挂起一个进程，使用 `kill -STOP [pid]`. 使用 `man 7 signal` 来查看各种信号，使用`kill -l` 来查看数字和信号的对应表
+ 使用 `nohup` 或  `disown` 如果你要让某个进程运行在后台。
+ 使用`netstat -lntp`来看看有侦听在网络某端口的进程。当然，也可以使用`lsof`。
+ 在`bash`的脚本中，你可以使用`set -x`来debug输出。使用 `set -e` 来当有错误发生的时候`abort`执行。考虑使用 `set -o pipefail` 来限制错误。还可以使用`trap`来截获信号（如截获`ctrl+c`）。
+ 在bash 脚本中，`subshells` (写在圆括号里的) 是一个很方便的方式来组合一些命令。一个常用的例子是临时地到另一个目录中，例如：

```bash
# do something in current dir
(cd /some/other/dir; other-command)
# continue in original dir
```

+ 在 bash 中有很多**变量展开**。如：检查一个变量是否存在: `${name:?error message}`。
比如脚本参数的表达式： `input_file=${1:?usage: $0 input_file}`。
计算表达式： `i=$(( (i + 1) % 5 ))`。
一个序列： `{1..10}`。 
截断一个字符串： `${var%suffix}` 和 `${var#prefix}`。 
示例：`if var=foo.pdf; then echo ${var%.pdf}.txt;fi;`

+ 通过 `<(some command)` 可以把某命令当成一个文件。
示例：比较一个本地文件和远程文件` /etc/hosts`： `diff /etc/hosts <(ssh somehost cat /etc/hosts)`
+ 了解什么叫 "here documents" ，就是诸如 `cat <<EOF` 这样的东西。
+ 在 bash中，使用重定向到标准输出和标准错误。如： `some-command >logfile 2>&1`。
另外，要确认某命令没有把某个打开了的文件句柄重定向给标准输入，最佳实践是加上 `</dev/null`，把`/dev/null`重定向到标准输入。
+ 使用 `man ascii` 来查看 `ASCII` 表。
+ 在远端的 ssh 会话里，使用 `screen` 或 `dtach` 来保存你的会话。
+ 若要`debug Web`，试试`curl` 和 `curl -I` 或是 `wget` 。(我觉得debug Web的利器是`firebug`，`curl`和`wget`是用来抓网页的.)
+ 把 `HTML` 转成文本：`lynx -dump -stdin`
+ 如果你要处理`XML`，使用 `xmlstarlet`
+ 对于 `Amazon S3`， `s3cmd` 是一个很方便的命令（还有点不成熟）
+ 在`ssh`中，知道怎么来使用`ssh`隧道。通过 `-L` or `-D` (还有`-R`) ，翻墙神器。
+ 你还可以对你的 `ssh` 做点优化。比如，`.ssh/config` 包含着一些配置：避免链接被丢弃，链接新的`host`时不需要确认，转发认证，以前使用压缩（如果你要使用scp传文件）：

```bash
TCPKeepAlive=yes
ServerAliveInterval=15
ServerAliveCountMax=6
StrictHostKeyChecking=no
Compression=yes
ForwardAgent=yes
```

+ 如果你输入了一行命令，但你改变注意了，又不想删除它，因为你要在历史命令中找到它，但你也不想执行它。
那么，你可以按下 `Alt-#` ，于是这个命令关就被加了一个`#`字符，于是就被注释掉了。

### 数据处理

+ 了解 `sort` 和 `uniq` 命令 (包括 `uniq` 的 `-u` 和 `-d` 选项).
+ 了解用 `cut`, `paste`, 和 `join` 命令来操作文本文件。很多人忘了在`cut`前使用`join`。
+ 如果你知道怎么用`sort`/`uniq`来做集合交集、并集、差集能很大地促进你的工作效率。
假设有两个文本文件`a`和`b`已经被 `uniq`了，那么，用`sort`/`uniq`会是最快的方式，无论这两个文件有多大（`sort`不会被内存所限，你甚至可以使用`-T`选项，如果你的`/tmp`目录很小）

```bash
cat a b | sort | uniq > c   # c is a union b 并集
cat a b | sort | uniq -d > c   # c is a intersect b 交集
cat a b b | sort | uniq -u > c   # c is set difference a - b 差集
```

+ 了解和字符集相关的命令行工具，包括排序和性能。
很多的Linux安装程序都会设置`LANG `或是其它和字符集相关的环境变量。
这些东西可能会让一些命令（如：`sort`）的执行性能慢N多倍（注：就算是你用`UTF-8`编码文本文件，你也可以很安全地使用`ASCII`来对其排序）。
如果你想`Disable`那个`i18n` 并使用传统的基于`byte`的排序方法，那就设置`export LC_ALL=C` （实际上，你可以把其放在 `.bashrc`）。
如果这设置这个变量，你的`sort`命令很有可能会是错的。
+ 了解 `awk` 和 `sed` ，并用他们来做一些简单的数据修改操作。例如：求第`3`列的数字之和： `awk '{ x += $3 } END { print x }'`。这可能会比Python快`3`倍，并比Python的代码少`3`倍。
+ 使用 `shuf` 来打乱一个文件中的行或是选择文件中一个随机的行。
+ 了解`sort`命令的选项。了解`key`是什么（`-t`和`-k`）。具体说来，你可以使用`-k1,1`来对第一列排序，`-k1`来对全行排序。
+ `sort -s` 会很有用。
例如：如果你想对两列排序，先对第二列，再对第一列，那么你可以这样： `sort -k1,1 | sort -s -k2,2`
+ 我们知道，在`bash`命令行下，`Tab`键是用来做目录文件自动完成的事的。
但是如果你想输入一个`Tab`字符（比如：你想在`sort -t`选项后输入`<tab>`字符），你可以先按`Ctrl-V`，然后再按`Tab`键，就可以输入`<tab>`字符了。当然，你也可以使用`\t`。
+ 如果你想查看二进制文件，你可以使用`hd`命令（在CentOS下是`hexdump`命令），如果你想编译二进制文件，你可以使用`bvi`命令（http://bvi.sourceforge.net/ 墙）
+ 另外，对于二进制文件，你可以使用`strings`（配合`grep`等）来查看二进制中的文本。
+ 对于文本文件转码，你可以试一下` iconv`。或是试试更强的 `uconv` 命令（这个命令支持更高级的Unicode编码）
+ 如果你要分隔一个大文件，你可以使用`split`命令（split by size）和`csplit`命令（split by a pattern）。

### 系统调试

+ 如果你想知道磁盘、CPU、或网络状态，你可以使用 `iostat`, `netstat`, `top` (或更好的 `htop`), 还有 `dstat` 命令。你可以很快地知道你的系统发生了什么事。关于这方面的命令，还有`iftop`, `iotop`等（参看《28个Unix/Linux的命令行神器》）
+ 要了解内存的状态，你可以使用`free`和`vmstat`命令。具体来说，你需要注意 `"cached"` 的值，这个值是`Linux`内核占用的内存。还有`free`的值。
+ Java 系统监控有一个小的技巧是，你可以使用`kill -3 <pid>` 发一个`SIGQUIT`的信号给`JVM`，可以把堆栈信息（包括垃圾回收的信息）`dump`到`stderr/logs`。
+ 使用 `mtr `会比使用 `traceroute` 要更容易定位一个网络问题。
+ 如果你要找到哪个`socket`或进程在使用网络带宽，你可以使用 `iftop` 或 `nethogs`。
+ `Apache`的一个叫 `ab` 的工具是一个很有用的，用`quick-and-dirty`的方式来测试网站服务器的性能负载的工作。如果你需要更为复杂的测试，你可以试试 `siege`。
+ 如果你要抓网络包的话，试试 `wireshark` 或 `tshark。`
+ 了解 `strace` 和 `ltrace`。这两个命令可以让你查看进程的系统调用，这有助于你分析进程的hang在哪了，怎么crash和failed的。你还可以用其来做性能`profile`，使用 `-c` 选项，你可以使用`-p`选项来`attach`上任意一个进程。
+ 了解用`ldd`命令来检查相关的动态链接库。注意：`ldd`的安全问题
+ 使用`gdb`来调试一个正在运行的进程或分析`core dump`文件。参看我写的《GDB中应该知道的几个调试方法》
+ 学会到 `/proc` 目录中查看信息。这是一个Linux内核运行时记录的整个操作系统的运行统计和信息，比如： `/proc/cpuinfo`, `/proc/xxx/cwd`, `/proc/xxx/exe`, `/proc/xxx/fd/`, `/proc/xxx/smaps`.
+ 如果你调试某个东西为什么出错时，`sar`命令会有用。它可以让你看看 CPU, 内存, 网络, 等的统计信息。
+ 使用 `dmesg` 来查看一些硬件或驱动程序的信息或问题。

## transmission 屏蔽Ipv4

`cd ~/.config/transmission/blocklists`

创建空文件，文件名任意,写入
`Ipv4:0.0.0.0-255.255.255.255`

然后
`cd ~/.config/transmission`
`vim settings.json`

设置`ip`屏蔽生效
`"blocklist-enabled": true,`

## 28个Unix/Linux的命令行神器

[28个Unix/Linux的命令行神器][]

[28个Unix/Linux的命令行神器]: https://coolshell.cn/articles/7829.html

dstat & sar

iostat, vmstat, ifstat 三合一的工具，用来查看系统性能（我在《性能调优攻略》中提到过那三个xxstat工具）。

官方网站：http://dag.wieers.com/rpm/packages/dstat/

你可以这样使用：

alias dstat='dstat -cdlmnpsy'

dstat screenshot
slurm

查看网络流量的一个工具

官方网站：  Simple Linux Utility for Resource Management

slurm screenshot

vim & emacs

真正程序员的代码编辑器。

vim screenshot

screen, dtach, tmux, byobu

你是不是经常需要 SSH 或者 telent 远程登录到 Linux 服务器？你是不是经常为一些长时间运行的任务而头疼，比如系统备份、ftp 传输等等。通常情况下我们都是为每一个这样的任务开一个远程终端窗口，因为他们执行的时间太长了。必须等待它执行完毕，在此期间可不能关掉窗口或者断开连接，否则这个任务就会被杀掉，一切半途而废了。

Screen是一个可以在多个进程之间多路复用一个物理终端的窗口管理器。Screen中有会话的概念，用户可以在一个screen会话中创建多个screen窗口，在每一个screen窗口中就像操作一个真实的telnet/SSH连接窗口那样。请参看IBM DeveloperWorks的这篇文章《使用 screen 管理你的远程会话》

gnu screen screenshot

dtach 是用来模拟screen的detach的功能的小工具，其可以让你随意地attach到各种会话上 。下图为dtach+dvtm的样子。

tmux是一个优秀的终端复用软件，类似GNU Screen，但来自于OpenBSD，采用BSD授权。使用它最直观的好处就是，通过一个终端登录远程主机并运行tmux后，在其中可以开启多个控制台而无需再“浪费”多余的终端来连接这台远程主机；当然其功能远不止于此。与screen相比的优点：可以横向和纵向分割窗口，且窗格可以自由移动和调整大小。可在多个缓冲区进行复制和粘贴，支持跨窗口搜索；非正常断线后不需重新detach；……  有人说——与tmux相比，screen简直弱爆了。

byobu是Ubuntu开发的，在Screen的基础上进行包装，使其更加易用的一个工具。最新的Byobu，已经是基于Tmux作为后端了。可通过“byobu-tmux”这个命令行前端来接受各种与tmux一模一样的参数来控制它。Byobu的细节做的非常好，效果图如下：

multitail

MultiTail是个用来实现同时监控多个文档、类似tail命令的功能的软件。他和tail的区别就是他会在控制台中打开多个窗口，这样使同时监控多个日志文档成为可能。他还可以看log文件的统计，合并log文件，过滤log文件，分屏，……。

官网：http://www.vanheusden.com/multitail/

multitail screenshot

tpp

终端下的PPT，要是在某某大会上用这个演示PPT，就太TMD的Geek了。

官网：http://www.ngolde.de/tpp.html

tpp screenshot

xargs & parallel

Executes tasks from input (even multithread).

xargs 是一个比较古老的命令，有简单的并行功能，这个不说了。对于GNU parallel ( online manpage )来说，它不仅能够处理本机上多执行绪，还能分散至远端电脑协助处理。而使用GNU parallel前，要先确定本机有安装GNU parallel / ssh / rsync，远端电脑也要安装ssh。

xargs screenshot

duplicity & rsyncrypto

Duplicity是使用rsync算法加密的高效率备份软件，Duplicity支持目录加密生产和格式上传到远程或本地文件服务器。

rsyncrypto 就是 rsync + encryption。对于rsync的算法可参看酷壳的rsync核心算法。

Encrypting backup tools.

duplicity screenshot

nethack & slash’em

NetHack（Wiki），20年历史的古老电脑游戏。没有声音，没有漂亮的界面，不过这个游戏真的很有意思。网上有个家伙说：如果你一生只做一件事情，那么玩NetHack。这句话很惹眼，但也让人觉得这个游戏很复杂不容易上手。其实，这个游戏很虽然很复杂，却容易上手。虽然玩通关很难，但上手很容易。NetHack上有许多复杂的规则，”the DevTeam thinks of everything”（开发团队想到了所有的事情)。各种各样的怪物，各种各样的武器….，有许多spoilers文件来说明其规则。除了每次开始随机生成的地图，每次玩游戏，你也都会碰到奇怪的事情: 因为喝了一种药水，变成了机器人;因为踢坏了商店的门被要求高价赔偿;你的狗为你偷来了商店的东西….. 这有点象人生，你不能完全了解这个世界，但你仍然可以选择自己的面对方式。

网上有许多文章所这是最好的电脑游戏或最好的电脑游戏之一。也许是因为它开放的源代码让人赞赏，古老的历史让人宽容，复杂的规则让人敬畏。虽然它不是当前流行的游戏，但它比任何一个当前流行的游戏都更有可能再经受20年的考验。

Slash’EM 也是一个基于NetHack的经典游戏。

nethack screenshot

lftp

利用lftp命令行ftp工具进行网站数据的增量备份，镜像，就像使用rsync一样。

lftp screenshot

ack

ack是一个perl脚本，是grep的一个可选替换品。其可以对匹配字符有高亮显示。是为程序员专门设计的，默认递归搜索，省提供多种文件类型供选。

ack screenshot

calcurse & remind + wyrd

calcurse是一个命令行下的日历和日程软件。remind + wyrd也很类似。关于日历，我不得不提一个Linux的Cycle日历，也是一个神器，呵呵。

calcurse screenshot

newsbeuter & rsstail

newsbeuter 和 rsstail 是命令行下RSS的阅读工具。

newsbeuter screenshot

powertop

做个环保的程序员，看看自己的电脑里哪些程序费电。PowerTOP 是一个让 Intel 平台的笔记本电脑节省电源的 Linux 工具。此工具由 Intel 公司发布。它可以帮助用户找出那些耗电量大的程序，通过修复或者关闭那些应用程序或进程，从而为用户节省电源。

powertop screenshot

htop & iotop

htop 和 iotop  用来查看进程，内存和IO负载。

htop screenshot
ttyrec & ipbt

ttyrec 是一个 tty 控制台录制程序，其所录制的数据文件可以使用与之配套的 ttyplay 播放。不管是你在 tty 中的各种操作，还是在 tty 中耳熟能详的软件，都可进行录制。

ipbt 是一个用来回放 ttyrec 所录制的控制台输入过程的工具。

与此类似的还有Shelr 和 termrec 

ipbt screenshot

rsync

通过SSH进行文件同步的经典工具（核心算法）

rsync screenshot

mtr

MTR – traceroute 2.0，其是把 traceroute 和 ping 集成在一块的一个小工具 用于诊断网络。

mtr screenshot

socat & netpipes

socat是一个多功能的网络工具，名字来由是” Socket CAT”，可以看作是netcat的N倍加强版。

netpipes 和socat一样，主要是用来在命令行来进行socket操作的命令，这样你就可以在Shell脚本下行进socket网络通讯了。

socat screenshot

iftop & iptraf

iftop和iptraf可以用来查看当前网络链接的一些流量情况。

iftop screenshot

siege & tsung

Siege是一个压力测试和评测工具，设计用于WEB开发这评估应用在压力下的承受能力：可以根据配置对一个WEB站点进行多用户的并发访问，记录每个用户所有请求过程的相应时间，并在一定数量的并发访问下重复进行。

Tsung 是一个压力测试工具，可以测试包括HTTP, WebDAV, PostgreSQL, MySQL, LDAP, and XMPP/Jabber等服务器。针对 HTTP 测试，Tsung 支持 HTTP 1.0/1.1 ，包含一个代理模式的会话记录、支持 GET、POST 和 PUT 以及 DELETE 方法，支持 Cookie 和基本的 WWW 认证，同时还支持 SSL。

参看：十个免费的Web压力测试工具

siege screenshot

ledger

ledger 一个命令行下记帐的小工具。

ledger screenshot

taskwarrior

TaskWarrior 是一个基于命令行的 TODO 列表管理工具。主要功能包括：标签、彩色表格输出、报表和图形、大量的命令、底层API、多用户文件锁等功能。

taskwarrior screenshot

下图是TaskWarrior 2.0的界面：

curl

cURL是一个利用URL语法在命令行下工作的文件传输工具，1997年首次发行。它支持文件上传和下载，所以是综合传输工具，但按传统，习惯称cURL为下载工具。cURL还包含了用于程序开发的libcurl。cURL支援的通訊協定有FTP、FTPS、HTTP、HTTPS、TFTP、SFTP、Gopher、SCP、Telnet、DICT、FILE、LDAP、LDAPS、IMAP、POP3、SMTP和RTSP。

curl screenshot

rtorrent & aria2

rTorrent 是一个非常简洁、优秀、非常轻量的BT客户端. 它使用了 ncurses 库以 C++ 编写, 因此它完全基于文本并在终端中运行. 将 rTorrent 用在安装有 GNU Screen 和 Secure Shell 的低端系统上作为远程的 BT 客户端是非常理想的。

aria2 是 Linux 下一个不错的高速下载工具。由于它具有分段下载引擎，所以支持从多个地址或者从一个地址的多个连接来下载同一个文件。这样自然就大大加快了文件的下载速度。aria2 也具有断点续传功能，这使你随时能够恢复已经中断的文件下载。除了支持一般的 http(s) 和 ftp 协议外，aria2 还支持 BitTorrent 协议。这意味着，你也可以使用 aria2 来下载 torrent 文件。

 rtorrent screenshot
ttytter & earthquake

TTYtter 是一个Perl写的命令行上发Twitter的工具，可以进行所有其他平台客户端能进行的事情，当然，支持中文。脚本控、CLI控、终端控、Perl控的最愛。

Earthquake也是一个命令行上的Twitter客户端。

ttytter screenshot

vifm & ranger

Vifm 基于ncurses的文件管理器，DOS风格，用键盘操作。

vifm screenshot

Ranger用 Python 完成，默认为使用 Vim 风格的按键绑定，比如 hjkl（上下左右），dd（剪切），yy（复制）等等。功能很全，扩展/可配置性也非常不错。类似MacOS X下Finder（文件管理器）的多列文件管理方式。支持多标签页。实时预览文本文件和目录。

cowsay & sl

cowsay  不说了，如下所示，哈哈哈。还有xcowsay，你可以自己搜一搜。

cowsay screenshot

 sl是什么？ls？，呵呵，你会经常把ls 打成sl吗？如果是的话，这个东西可以让你娱乐一下，你会看到一辆火车呼啸而过~~，相当拉风。你可以使用sudo apt-get install sl 安装。

最后，再介绍一个命令中linuxlogo，你可以使用 sudo apt-get install linuxlogo来安装，然后，就可以使用linuxlogo -L
来看一下各种Linux的logo了

（全文完）


## ssh

常用格式：ssh [-l login_name] [-p port] [user@]hostname