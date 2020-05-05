# mathemtatica-2

## Wolfram 语言脚本

in total, 

windows: 建立后缀名为`.wl`的文件，然后按正常的方法去写mma笔记本，
运行的时候用`wolframscript.exe`
用`-print all` 指定输出所有没被`;` 抑制输出的表达式。
用`para1 para2 ...` 传递参数。

参数用下面的变量调用

+ `$CommandLine` -- 一系列字符串给出使用的完整的命令行.
+ `$ScriptCommandLine` -- 为正在运行的脚本准备的一系列命令行参数. 这些参数出现在 `-option` 给出的选项之后.
+ `$ScriptInputString` -- 一个通过标准输入给出脚本输入的字符串. 在脚本的每次迭代中，选项 `-linewise` 用一行标准输入载入该变量.

```powershell
wolframscript.exe -print all -file .\test.wl para1 para2
```

*****
unix: 通过加上`#!/usr/bin/env wolframscript -print all`，
运行的时候，不用输入`wolframscript`，
传递参数的方法不变

```bash
./test.wl para1 para2
```

### 脚本文件

Wolfram 语言脚本是一个包含 Wolfram 语言命令的文件，用户通常可以在一个 Wolfram 语言会话中按顺序计算这些命令. 
如果这些命令需要多次重复，编写一个脚本就是非常有用的. 把这些命令收集在一起确保它们按照特定的顺序计算，并且没有忽略任何命令. 如果你运行复杂的、很长的计算，这么做是很重要的.

当您交互式地使用 Wolfram 语言时，包含在脚本文件中的命令可以利用 `Get` 计算. 
这个函数也可以通过编程在代码或者其它 `.wl` 文件中使用.

*****
从一个脚本文件读取命令.

+ `Get["file"]` 读入一个文件，并且运行其中的命令
+ `<<file` Get 的简写形式

对脚本文件的结构没有任何要求. 在该文件中给出的任何 Wolfram 语言命令序列都会按照顺序读入并计算. 
如果你的代码比一个普通命令列表更复杂，你可能可以考虑编写一个更为结构化的程序包，如"建立 Wolfram 语言程序包"中所述.

当我们不需要用一个交互式的会话时，即你的脚本封装了需要执行的简单计算时，Wolfram 语言脚本就更有用了.
例如，你的计算涉及大量计算任务，如线性代数、最优化、数值积分或微分方程的解，并且当你不使用排版功能、动态交互或笔记本的时候.

脚本可以存储在一般的 `.wl` 程序包文件或专门的 `.wls` 脚本文件. 
两种文件的概念是一样的：Wolfram 语言表达式系列，起始处带有可选的 "shebang" 行一般用于类 Unix 操作系统（参见 Unix 脚本可执行文件）. 

文件类型中的唯一不同是它们双击的行为. 
双击程序包文件会在笔记本程序包编辑器中打开文件；
双击脚本文件会执行文件，如果操作系统支持的话. 
脚本文件可以在笔记本界面上编辑，但是必须使用 文件--打开 进行开启.

### 在 Local 内核中运行脚本

当从命令行调用 Wolfram 语言内核时，可以使用脚本文件， 对于内核可执行文件，一般使用以下位置.

运行 Windows 上的脚本文件.

```mathematica
"%ProgramFiles%\Wolfram Research\Mathematica\12.0\wolfram" -script file.wl
```

```mathematica
D:\mathematica\wolfram -script file.wl
```

在 Mac 上运行脚本文件.

```mathematica
/Applications/Mathematica.app/Contents/MacOS/wolfram -script file.wl
```

在 Linux 上运行脚本.

```mathematica
wolfram -script file.wl
```

`-script` 命令行选项指定 Wolfram 语言内核在一个特殊的脚本上运行，或者以批处理模式运行. 
在这种模式下，内核读入指定的文件，并且按顺序计算命令. 通过把输出函数的 `PageWidth` 选项设为 `Infinity` ，内核关闭默认的换行功能，并且不显示 `In[]` 和 `Out[]` 标签. 
当在该模式下运行时，标准的输入和输出通道 `stdin`、`stdout` 和 `stderr` 不会被重定向，数值按 `InputForm` 进行格式化.

运行带有 `-script` 选项的 wolfram 等价于利用 `Get` 命令读入文件，唯一的不同之处是：**在计算文件中最后一个命令之后，内核停止运行**. 
这种行为可能会影响 `Wolfram Symbolic Transfer Protocol (WSTP)` 链接或者通过运行脚本创建的外部进程.

### 使用 WolframScript 运行脚本

脚本可以使用如下的 WolframScript 诠释器进行运行. `-file` 标志是可选的.

使用 WolframScript 运行脚本.

```mathematica
wolframscript -file file.wl
```

wolframscript 已经加入环境变量

WolframScript 会找到最佳的本地内核运行脚本.
如果没有找到任何本地内核，它会连接至云端并在那里运行脚本.
程序接受任何标志以便控制使用本地还是云端的进行计算.
它还设置 **脚本参数**，其允许脚本基于启动的形式或收到的输入来改变行为.
使用 WolframScript 的另一个好处是，输入和输出是完全缓存的，允许应用各种变换.
在 `WolframScript` 页面(`ref/program/wolframscript`)有对这些额外选项以及范例的详细说明.

在 Windows 和 Linux 上， `WolframScript` 一般与 Wolfram 系统一起安装.
在 `Mac` 上，有必要安装与 Wolfram 系统一起绑定的 "Extras" 安装器以便获取 `WolframScript`.
默认情况下，这些安装器会把 wolframscript 放在 `PATH` 中.

### Unix 脚本可执行文件

类 `Unix` 的操作系统--以及 Windows 中的 `Unix` 环境，例如 `cygwin` 和 `MinGW` 允许编写可执行的脚本文件，和普通的可执行程序那样运行. 
这可以通过在文件开头放上一个"解释器"行实现.
对于包含 Wolfram 语言命令的脚本也一样.

"解释器"行包括两个字符 `#!`，它必须是文件中的首两个字符，然后是执行文件的绝对路径以及其他参数.
为了达到跨平台和机器的最大的兼容性，建议通过如下所示的帮助器 `/usr/bin/env` 启动WolframScript.
`env` 程序会正确找到 `PATH` 中的 `wolframscript` 并启动之.

*****
一个脚本文件的范例.

```mathematica
#!/usr/bin/env wolframscript

(* generate high-precision samples of a mixed distribution *)
Print /@ RandomVariate[MixtureDistribution[
    {1,2},
    {NormalDistribution[1,2/10],
     NormalDistribution[3,1/10]}],
    10,  WorkingPrecision -> 50]
```

如果要把脚本编译成可执行文件，你需要设置可执行权限. 
之后，就可以通过在一个 shell 提示输入脚本名称，运行脚本.
*****
使脚本可执行，并且运行它.

```mathematica
chmod a+x script.wls
./script.wls
```

解释器行可能另外包含解释器的其他参数. 可能的参数在 WolframScript 页(`ref/program/wolframscript`)被指定.

*****
使用额外参数的解释器行.

```mathematica
#!/usr/bin/env wolframscript -linewise -format XML
```

Wolfram 语言脚本无需含有 `.wl` 或 `.wls` 扩展名.
一个可执行脚本等价于在一个 Unix 操作系统中的任何其它程序的一个全功能程序，所以它可用于其它脚本中，在管道中，根据任务控制的方运行等等. 
每个 Wolfram 语言脚本启动自己的 `WolframKernel` 拷贝，并且不共享变量或者定义. 
注意：同步运行 Wolfram 语言脚本可能受同时运行的内核数上的许可证限制所影响.

在一个交互式的 Wolfram 语言会话中，可以显式地读入可执行脚本文件并且对其进行计算. 
如果第一行以 `#!` 字符开始的话，`Get` 命令会正常忽略脚本的第一行.

可以避免使用 `env` 程序，但是到 `wolframscript` 的路径必须是绝对路径. 
启动脚本的操作系统机制没有使用 `PATH` 或其他方法找到文件. 而且，到诠释器的路径不能包含空格.

### Windows 上的脚本

独立的脚本也可以用在 `Windows` 上. 
不像 `Unix` 类的操作系统，这些脚本必须含有扩展名 `.wls` 以便被识别为 `Wolfram` 语言脚本. 
它们可以通过双击从 Windows 浏览器中启动，以及在命令提示符中敲入名称启动. 
Unix 诠释器行，如果出现的话，会被机制忽略.

*****
从命令提示符中启动脚本，等价于双击.

```mathematica
> file.wls
```

在命令提示符中，其他参数加在文件名后传递. 
WolframScript 本身看不见这些参数，但是会以参数形式传递给脚本，下一章节会详细描述.

*****
从命令提示符中启动带有两个额外参数的脚本.

```mathematica
> file.wls arg1 arg2
```

### 脚本参数

当运行一个 Wolfram 语言脚本时，你可能常常想要通过指定命令行参数，修改脚本行为. 
Wolfram 语言代码可以通过 `$ScriptCommandLine` 访问传递给 Wolfram 语言脚本的参数. 
另外，标准输入的内容可被用为变量 `$ScriptInputString` 中的字符串.

*****
变量，给出关于脚本如何运行的信息.

+ `$ScriptCommandLine`    启用脚本的命令行
+ `$ScriptInputString`    给予脚本的标准输入的内容

*****
利用一个命令行参数的脚本文件 `file.wls` 的一个范例.

```mathematica
#!/usr/bin/env wolframscript

(* generate "num" samples of a mixed distribution *) 
num  = ToExpression[$ScriptCommandLine[[2]]];
Print /@ RandomVariate[
  MixtureDistribution[ 
    {1, 2},
    {NormalDistribution[1, 0.2],
     NormalDistribution[3, 0.1]}
  ], num,  WorkingPrecision -> 50]
```

*****
运行脚本，并且指定在 Unix 环境下的样本数.

```mathematica
./file.wls 10
```

*****
运行脚本，并且指定 Windows 中的样本数.

```mathematica
> file.wls 10
```

当在脚本中访问时，`$ScriptCommandLine` 是以脚本名称为第一个元素的一个列表，列表的其余元素为命令行变量.  
`$ScriptCommandLine` 遵循标准的 `argv[]` 习惯. 
注意这完全隐藏了到解释器的路径或 `#!` 行传递的任何参数.

因为类 Unix 操作系统执行脚本的方式，`$ScriptCommandLine` 仅仅当 Wolfram 语言内核经过 `wolframscript` 调用时才设置为非空列表. 

如果该脚本应该以批处理模式和标准 `Unix` 脚本模式运行，`$ScriptCommandLine` 可以用于决定当前执行模式. 
那么，`$ScriptCommandLine` 和 `$CommandLine` 都应该用于访问命令行参数.

### 标准输入、标准输出

[什么是标准输入、标准输出(stdin、stdout)][]

[什么是标准输入、标准输出(stdin、stdout)]: https://blog.csdn.net/sinat_17700695/article/details/91491472

*****
要弄清什么是标准输入输出。首先需要弄懂什么是IO。

`IO` 的 `I` 是 `Input` 的意思，`O` 是 `output` 的意思。
意味着输入和输出。

更确切的含义是：

+ `I`：从外部设备输入到内存
+ `O`：从内存输出到外部设备

而标准输入和标准输出是干什么的？它们是用于 `IO` 的。
那么它们属于 `IO` 的哪个部分？
内存？还是外部设备？

答案显然是外部设备(逻辑上的外部设备，为什么？接着看)。

*****
更具体的含义？

在 linux 操作系统中，外部设备用什么表示？是用文件。
linux 中一切设备皆是文件！
因此标准输入和输出更具体的含义是文件。

它们是哪两个文件？
它们是 `/dev/stdin` 这个文件和 `/dev/stdout` 这个文件。
也就是说所谓的标准输入和标准输出其实就是两个 linux 下的文件。

*****
linux 的文件类型有：

1. 普通文件
1. 字符设备文件
1. 块设备文件
1. 目录文件
1. 链接文件
1. 管道文件
1. 套接字文件

思考一下？它们是什么文件？它们在 `/dev` 目录下，它们是设备文件吗？

那么所谓的从标准输入读是什么意思？
逻辑上来看：
就是打开 `/dev/stdin` 这个文件，然后把这个文件里的内容读进来。
输出到标准输出是什么意思？
逻辑上来看：
就是打开 `/dev/stdout` 这个文件，然后把内容输出到这个文件里去。

为什么是从逻辑上来看？因为它们不是设备文件,所以它们不代表一个设备。
linux里一切皆是文件，设备是文件，但是文件不一定是设备！

*****
那它们是什么文件？他们是`链接文件`。(可以用` ls -l /dev` 来查看 `l` 开头的就是链接文件。)

什么是链接文件？**文件内容是另一个文件的地址的文件称为链接文件**。

因此，打开、读或者写 `/dev/stdin` 和` /dev/stdout` 实际上是打开、读或者写这两个文件中存放的地址对应的设备文件。

### WolframScript

ref/program/wolframscript
*****
名称
wolframscript -- Wolfram 语言命令行脚本解释器

### 概要

+ `wolframscript -code code [-cloud [cloudbase] | -local [kernelpath]] arg1 ...`
+ `wolframscript -file file|url [-cloud [cloudbase] | -local [kernelpath]] [Subscript[arg, 1] ...]`
+ `wolframscript -api url|uuid|file [-cloud [cloudbase] | -local [kernelpath]] [-args key=value ...]`
+ `wolframscript -function code [-cloud [cloudbase] | -local [-kernelpath]] [-signature type ...] [-args values ...]`

### 说明

`Wolframscript` 在本地或云端运行 `Wolfram` 语言代码、函数和已部署的 API， 接受
标准输入
命令行参数
文件
URL 
等形式的输入. 

### 范例

#### 命令行代码

在本地 Wolfram Engine 上执行 Wolfram 语言代码 `2+2`：

```mathematica
wolframscript -code 2+2
4
```

在 Wolfram 云中执行 Wolfram 语言代码 `2+2`，需要时提示输入许可验证：

```mathematica
wolframscript -cloud -code 2+2
4
```

在本地执行 Wolfram 语言代码，对shell的输入进行转义：

```mathematica
wolframscript -code 'StringReverse["hello"]'
olleh
```

执行代码并把结果放入文件中：

```mathematica
wolframscript -code 'Graphics3D[Sphere[ ]]' -format PNG > file.png
```

#### 文件代码

从文件中执行 Wolfram 语言代码，返回产生的最终结果：

```mathematica
$ wolframscript -file test.wl
12345
```

从本地文件中获取代码，但是在云端运行代码：

```mathematica
$ wolframscript -cloud -file test.wl
12345
```

#### 脚本文件

设置为在本地执行 Wolfram 语言代码的文件：

```mathematica
#!/usr/bin/env wolframscript
Print[2+2]
$ ./file.wls
4
```

在 Wolfram 云中执行 Wolfram 语言代码的文件：

```mathematica
#!/usr/bin/env wolframscript -cloud
Print[2+2]
$ ./file.wls
4
```

使用命令行参数的文件：

```mathematica
#!/usr/bin/env wolframscript
Print[ToExpression[$ScriptCommandLine[[2]]]^2]
$ ./file.wls 5
25
```

一个能给出函数的文件，其参数从命令行中来：

```mathematica
#!/usr/bin/env wolframscript -function -signature City City
GeoDistance[#1, #2]&
$ ./file.wls "New York" London
Quantity[3453.7070027090986, Miles]
```

#### 交互操作

```mathematica
在交互 `REPL` 中运行 Wolfram 语言：

$ wolframscript
Wolfram Language 12.0.0 for Microsoft Windows (64-bit)
Copyright 1988-2019 Wolfram Research, Inc.

In[1]:= 2+2

Out[1]= 4

In[2]:= 
```

#### API

#### 运行云端 API

```mathematica
$ wolframscript -api https://wolfr.am/bNvKWq2U -args x=1 y=2
3
```

从云中获取 API 代码，但在本地运行 API：

```mathematica
$ wolframscript -api https://wolfr.am/bNvKWq2U -local -args x=1 y=2
3
```

#### 更多范例

登录不同的云账户：

```mathematica
$ wolframscript -authenticate
Enter WolframID: example-user@wolfram.com
Password:

Success. Saving connection data.
```

提供证书而不使用提示：

```mathematica
$ wolframscript -username example-user@wolfram.com -password XXXXXX
Success. Saving connection data.
```

断开云端，清除连接信息：

```mathematica
$ wolframscript -disconnect
```

颠倒输入文件中每行字符串的顺序，并把结果写入另一个文件中：

```mathematica
$ wolframscript -code 'StringReverse[$ScriptInputString]' -linewise < file1 > file2 
```

使用超时限制计算：

```mathematica
$ wolframscript -code 'Do[Print[i];Pause[1], {i,10}]' -timeout 3
1
2
3
$TimedOut
```

输出使用特殊字符：

```mathematica
$ wolframscript -code 'Alphabet["Greek"]' -charset UTF8
```

使用脚本的选项 `-print` 和 `-format` 产生一幅图像：

```mathematica
#!/usr/bin/env wolframscript -print -format PNG
ListLinePlot[RandomFunction[WienerProcess[],{0,10,0.01},10]]
```

```powershell
$ ./file.wls > plot.png
```

使用 `-print All` 选项，打印执行脚本时产生的每个结果：

```mathematica
#!/usr/bin/env wolframscript -print All
"Using -print All print will each result"
a = 2+2; (* This line won't print because the ; suppresses output *)
a
$ ./file.wls
Using -print All will each result
4
```

创建一个由 `PermissionsKey` 保护的 `API` ，并把密钥传给 `WolframScript` ，以便访问：

```mathematica
In[1]:= CloudDeploy[APIFunction[{"n"->Integer},#n^2&],Permissions->{PermissionsKey["thekey"]->"Execute"}]
Out[1]= CloudObject[https://www.wolframcloud.com/objects/83aa0bc2-8e0c-4ef6-b314-48e0bf283196]
$ wolframscript -api 83aa0bc2-8e0c-4ef6-b314-48e0bf283196 -args n=5 -permissionskey thekey
25
```

检查 WolframScript 的版本：

```mathematica
$ wolframscript -version
WolframScript 1.2.0 for MacOSX-x86-64
```

配置使用特别的 `WolframEngine` ：

```mathematica
$ wolframscript -config WOLFRAMSCRIPT_KERNELPATH=/Applications/Mathematica.app/MacOS/WolframKernel
Configured:WOLFRAMSCRIPT_KERNELPATH=/Applications/Mathematica.app/MacOS/WolframKernel
```

### 选项

#### 代码选项

+ `-c|-code code` -- 给出要执行的 Wolfram 语言代码.
+ `-f|-file file` -- 给出含有要执行的 Wolfram 语言代码的文件.
+ `-api url|uuid|file` -- 在指定的 URL 使用 API，或来自于有指定 UUID 的云端或本地对象，也可以来自于指定的本地文件. 使用参数 key=value .......
+ `-fun|-function code [-s|-signature type ...] [-args|-- value ...]` --  使用参数为字符串 `value` ...... 的函数，将其解释为类型 `type` ....... 如果没有给出标记 (signature)，则假设所有参数都是字符串. 标记类型可以是 `$InterpreterTypes` 的任意一种.

#### 执行选项

+ `-o|-cloud [cloudbase]` -- 在云端执行代码，使用指定的云基 (cloud base). 缺省情况下，cloudbase 为 https://wolframcloud.com.
+ `-l|-local [kernelpath]` -- 在本地执行代码，使用到 Wolfram Engine 核的指定路径. 缺省情况下，kernelpath 使用本地系统中 Wolfram 语言的最新版本.
+ `-format type` -- 指定输出的格式. 可以使用任意可被 Export 接受的格式.
+ `-charset encoding` -- 对输出使用 encoding. 如果想输出原始字节，编码可设为 None，或  $CharacterEncodings 中的任意一项，除了 "Unicode". 默认情况下，从终端的语言设置中推断. 
+ `-linewise` -- 执行从标准输入读入的每行代码.
+ `-print [all]` -- 当运行脚本时，将执行脚本最后一行的结果打印出来，在指定 all 时，打印所有行的结果.
+ `-timeout seconds [value]` -- 指定执行可以使用的秒数. 如果超出指定时间，返回 value 的值.
+ `-v|-verbose` --  在执行中打印额外信息.

#### 实用选项

`-h|-help` -- 打印帮助信息.
`-version` -- 打印 WolframScript 版本.
`-auth|-authenticate [wolframid [password]] [-cloud cloudbase]` -- 执行云端许可验证，指定特定的 Wolfram ID 和密码，没有给出的情况下提示输入. 对不同的云可以指定不同的验证.
`-username [wolframid]` -- 指定在云端认证使用的 Wolfram ID.
`-password [password]` -- 指定在云端认证使用的密码.
`-permissionskey key` -- 使用权限密钥访问云资源.
`-config|-configure [key=value ...]` -- 通过指定特定配置变量的值对 WolframScript 进行配置.
`-disconnect [-cloud cloudbase]` -- 从云端断开，并移除验证信息.

### 详细信息

#### Wolfram 语言脚本

在 `#!wolframscript` 脚本中可以使用所有标准选项.
当设置为 `#!wolframscript -function` ...... 时，可以在命令行脚本中给出函数的每个参数.
当设置为 `#!wolframscript -api` ...... 时，可以按 `-key value` ...... 形式在命令行脚本中给出 API 的参数.
可以用 `Exit[code]`指定在执行脚本时退出的代码.
没有设置 `-print` 时，不传送任何输出到 `stdout`，除非使用 `Print[expr]` 命令明确指出.
当有选项 `-print` 时，把脚本最后一行的结果传送到 `stdout`.
当有选项 `-print all` 时，脚本中每一行命令的结果产生后都被传送到 `stdout`.
`-linewise` 选项可用来多次运行脚本，每次取一行 `stdin` 作为输入.

#### 命令行输入

在 Wolfram 语言代码中，可以用 `$ScriptInputString` 获取按标准输入形式给出的脚本输入.
可以用 `$ScriptCommandLine` 获取命令行中给出的参数.

#### 输出格式

`TotalWidth` 的缺省设置为 `Infinity`.

#### API 参数

如果 API 支持多个参数，如 `x-url`、`x-format` 和 `_timeout`，可将它们用在 `wolframscript -api` 命令中.

#### 代码位置

在 `wolframscript -api uuid` 中，如果 `LocalObject["uuid"]` 存在，就用 `LocalObject["uuid"]`，否则使用 `CloudObject["uuid"]`.

### 文件

*****
缺省配置文件：

+ `%APPDATA%\Wolfram\WolframScript\WolframScript.conf` Windows 
+ `~/Library/Application\ Support/Wolfram/WolframScript/WolframScript.conf` Macintosh
+ `~/.config/Wolfram/WolframScript/WolframScript.conf` Unix

*****
缺省认证文件夹：

+ `\%LOCALAPPDATA%\Wolfram\WolframScript\` Windows
+ `~/Library/Caches/Wolfram/WolframScript/` Macintosh
+ `~/.cache/Wolfram/WolframScript/` Unix

### WOLFRAM 语言变量

下列变量会在 WolframScript 开始执行时被设置.

+ `$CommandLine` -- 一系列字符串给出使用的完整的命令行.
+ `$ScriptCommandLine` -- 为正在运行的脚本准备的一系列命令行参数. 这些参数出现在 `-option` 给出的选项之后.
+ `$ScriptInputString` -- 一个通过标准输入给出脚本输入的字符串. 在脚本的每次迭代中，选项 `-linewise` 用一行标准输入载入该变量.

### 环境变量

+ `WOLFRAMSCRIPT_AUTHENTICATIONPATH` -- 存储验证信息的文件夹.
+ `WOLFRAMSCRIPT_CONFIGURATIONPATH` -- 存储永久配置信息的文件.
+ `WOLFRAMSCRIPT_CLOUDBASE` --  WolframScript 中使用的缺省云基 (cloud base) .
+ `WOLFRAMSCRIPT_KERNELPATH` -- 到缺省的本地可执行 Wolfram Engine 核的路径.

### 配置变量

+ `WOLFRAMSCRIPT_AUTHENTICATIONPATH` -- 同名的环境变量尚未被设置的情况下，到存储验证信息的文件的路径.
+ `WOLFRAMSCRIPT_CLOUDBASE` -- 同名的环境变量尚未被设置的情况下，WolframScript 中使用的缺省云基.
+ `WOLFRAMSCRIPT_KERNELPATH` -- 同名的环境变量尚未被设置的情况下，到缺省的本地可执行 Wolfram Engine 核的路径. 

## 流和文件

tutorial/FilesAndStreams

### 文件

*****
文件名使用惯例. 

+ `name.m`   Wolfram 语言源文件
+ `name.nb`   Wolfram 系统笔记本文件
+ `name.ma`   Wolfram 系统从第3版以前的笔记本文件
+ `name.mx`   输出所有 Wolfram 语言表达式
+ `name.exe`   WSTP 可执行程序
+ `name.tm`   WSTP 模版文件
+ `name.ml`   WSTP 流文件

Wolfram 系统所使用的绝大多数文件都与系统完全无关. 
然而，`.mx` 和 `.exe` 文件与系统有关. 
对于这些文件，按照惯例，对不同计算机系统版本的名称进行捆绑，
形式如 `name/$SystemID/name`. 

### 流

*****
流的类型. 

+ `InputStream["name",n]`  从一个文件或者管道的输入
+ `OutputStream["name",n]`  一个文件或管道的输出

*****
输出流的选项. 

| 选项名 | 默认值 | explanation |
| ----- | ----- | -----|
| `CharacterEncoding` | `Automatic` | 用于特殊字符的编码|
| `BinaryFormat` | `False` | 是否把文件以二进制格式处理|
| `FormatType` | `InputForm` | 表达式的默认格式|
| `PageWidth` | `78` | 每一行的字符数目|
| `TotalWidth` | `Infinity` | 单个表达式中的最大字符数目|

使用 `Options` 用户可以测试流的选项，并且使用 `SetOptions` 重设. 

## 流和底层的输入输出

tutorial/StreamsAndLowLevelInputAndOutput

文件和管道两者都是一般称为 `流` 的 Wolfram 语言对象的例子. 
Wolfram 系统中的流是一个输入或输出源. 许多运算都是在流上进行的. 

可以将 `>>` 和 `<<` 作为"高层" Wolfram 语言输入输出函数. 
它们的基础是直接在流上工作的**底层输入-输出基元**. 
用这些基元，可以更多地控制 Wolfram 语言的输入和输出.
在编写从文件或管道存取中间数据的 Wolfram 语言程序时，需要进行精确的输入和输出控制. 

把输出写入一个 Wolfram 语言流的底层步骤如下. 

+ 首先，调用 `OpenWrite` 或 `OpenAppend` 去打开这个流，这告诉Wolfram 语言需要向一个**文件**或**外部程序**写入输出以及输出的形式.
+ 打开一个流之后，调用 `Write` 或 `WriteString` 向这个流写入一个表达式或字符串序列. 
+ 完成后，用 `Close` 去关闭这个流. 

*****
Wolfram 语言中的流. 

+ `"name"`  用名称指定的文件
+ `"!name"`  用名称指定的命令
+ `InputStream["name",n]`  输入流
+ `OutputStream["name",n]`  输出流

打开一个文件或管道时，Wolfram 系统产生一个"流对象"去指出打开的流与该文件或管道相关. 
这个流对象一般包含该 `文件名` 或 管道中 `外部命令名` 和 一个**唯一的数**. 

在流对象中使用一个唯一数的原因是可能同时会有几个流与同一个文件或外部程序相联系. 
例如，可以在不同的地方使用同一个外部程序，每一次都与不同的流相关联. 

然而，打开一个流后，当仅有一个对象和这个流相关联时，
仍可以用一个简单的文件名或外部程序名取指代这个流. 

打开一个输出到文件 tmp 的流：

```mathematica
In[1]:= stmp = OpenWrite["tmp"]
Out[1]= OutputStream["tmp", 5321]
```

向该文件写入一个表达式序列：

```mathematica
In[2]:= Write[stmp, a, b, c]
```

由于仅有一个流与文件 `tmp` 相关联，所以能简单地用文件名去指代它：

```mathematica
In[3]:= Write["tmp", x]
```

关闭这个流：

```mathematica
In[4]:= Close[stmp]
Out[4]= "tmp"
```

这是向该文件写入的内容：

```mathematica
In[5]:= FilePrint["tmp"]
During evaluation of In[7]:=
abc
x
```

*****
底层输出函数. 

+ `OpenWrite["file"]`  打开一个输出到文件的流，清除该文件以前的内容
+ `OpenWrite[]`  打开一个输出到新的临时文件的流
+ `OpenAppend["file"]`  打开一个输出到文件的流，向已有内容追加数据
+ `OpenWrite["!command"]`  打开一个输出到外部命令的流
+ `Write[stream,exp1,exp2,...]`  将表达式序列写到一个流，用一个换行结束输出
+ `WriteString[stream,str1,str2,...]`  将字符串序列写到一个流，没有额外换行
+ `Close[stream]`  告诉 Wolfram 语言该流已经完成

调用 `Write[stream,expr]` 时，将一个表达式写入一个指定的流. 
其默认情形是用 Wolfram 语言输入形式写入该表达式. 
当调用 `Write` 写入一个表达式序列时，这些表达式就一个接一个地写入一个流中.
一般地，在相继表达式中无空格. 
然而，在写完了所有表达式之后，Write 总用一个换行结束输出. 

重新打开文件 `tmp` ：

```mathematica
In[6]:= stmp = OpenWrite["tmp"]
Out[6]= OutputStream["tmp", 5322]
```

向该文件写入一个表达式序列，然后关闭：

```mathematica
In[7]:= Write[stmp, a^2, 1 + b^2]; Write[stmp, c^3]; Close[stmp]
Out[7]= "tmp"
```

所有表达式用输入形式写入，同一 `Write` 给出的表达式放在同一行：

```mathematica
In[8]:= FilePrint["tmp"]
During evaluation of In[10]:=
a^21 + b^2
c^3
```

`Write` 提供了写出完整 Wolfram 语言表达式的途径. 有时需要写出较少结构化的数据. 
`WriteString` 用来写出任意字符串. 与 `Write` `不同，WriteString` 不换行，也不加任何字符. 

打开一个流：

```mathematica
In[9]:= stmp = OpenWrite["tmp"]
Out[9]= OutputStream["tmp", 5323]
```

向该流写入2个字符串：

```mathematica
In[10]:= WriteString[stmp, "Arbitrary output.\n", "More output."]
```

这里写入另一个字符串，然后关闭该流：

```mathematica
In[11]:= WriteString[stmp, " Second line.\n"]; Close[stmp]
Out[11]= "tmp"
```

这里是该文件的内容. 这些字符串与给定的完全一样. 只有在明确给出换行符的地方才换行：

```mathematica
In[12]:= FilePrint["tmp"]
During evaluation of In[14]:=
Arbitrary output.
More output. Second line.
```

*****
将输出写入一个流列表. 

+ `Write[{stream1,stream 2},expr1,...]`  将表达式写入一个流列表
+ `WriteString[{stream1,stream2},str1,...]`  将字符串写入流列表

函数 `Write` 和 `WriteString` 的重要特点之一是它们不仅可以向一个流，而且可以向一个流列表写入输出. 

在使用 Wolfram 语言时，定义由流列表组成的**通道**是方便的. 
简单地令 Wolfram 语言向通道写入时，就把同一对象写入了几个流之中. 

在标准交互式 Wolfram 语言进程中，有几个常用的输出通道. 
它们指定某些类型输出的去向. 
例如，`$Output` 指定标准输出的去向，而 `$Messages` 指定信息的去向. 函数 `Print` 调用 `Write` 在 `$Output` 通道工作. 
同理， `Message` 调用 `Write` 在 `$Messages` 通道工作. 
在 "主循环" 中列出了典型 Wolfram 语言进程所使用的通道. 

注意，通过 Wolfram Symbolic Transfer Protocol (WSTP) 运行 Wolfram 语言时使用不同的方式. 
所有输出一般写入一个 WSTP 连接中，但每个输出块以一个表明类型的"小包"出现. 

在大部分情况下，Wolfram 语言使用的文件名与外部命令名与计算机操作系统所使用的名称相对应. 
但在一些系统中，Wolfram 系统支持各种具有特殊名称的流. 

*****
一些计算机系统中的特殊流. 

+ `"stdout"`  标准输出
+ `"stderr"`  标准错误

特殊流 `"stdout"` 允许将输出送到操作系统提供的标准输出. 
但要注意仅能在 Wolfram 语言的简单文本界面中使用. 
当与 Wolfram 语言的交互更复杂时，这种流无法工作，试图使用这种流会带来很多麻烦. 

*****
输出流的一些选项. 

| 选项名 | 默认值 |exppantion|
| ----- | ----- | ----- |
| `FormatType` | `InputForm` | 默认输出格式 |
| `PageWidth` | `78` | 页按字符数的宽度 |
| `NumberMarks` | `$NumberMarks` | 近似数中是否包含记号`` ` `` 
| `CharacterEncoding` | `$CharacterEncoding` | 特殊字符使用的编码 |

许多选项与输出流有关. 
第一次用 `OpenWrite` 或 `OpenAppend` 打开输出流时就可以定义这些选项. 

这里打开一个流，指定 `OutputForm` 是默认输出格式：

```mathematica
In[13]:= stmp = OpenWrite["tmp", FormatType -> OutputForm]
Out[13]= OutputStream["tmp", 5324]
```

将表达式写入这个流后关闭它：

```mathematica
In[14]:= Write[stmp, x^2 + y^2, " ", z^2]; Close[stmp]
Out[14]= "tmp"
```

这些表达式按 `OutputForm` 格式写入了这个流：

```mathematica
In[15]:= FilePrint["tmp"]
During evaluation of In[17]:=
 2    2  2
x  + y  z
```

注意，将一个欲写入流的表达式放在 `OutputForm` 或 `TeXForm` 等 Wolfram 语言格式指令内总可以覆盖对这个流所指定的输出格式. 

选项 `PageWidth` 指定 Wolfram 语言文本输出的页宽. 
所有输出都分成这种宽度的行. 
不需要分行时应设置`PageWidth->Infinity`. 
通常，设定与输出设备相符的 `PageWidth` . 
在许多系统中，运行一个程序去找到这个页宽值. 
用 `SetOptions` 可以给出设置 `PageWidth` 的默认规则，
例如，`PageWidth:><<"!devicewidth"`，这就可以自动运行外部程序找出选项值. 

打开一个流，指定页宽为`20`个字符：

```mathematica
In[16]:= stmp = OpenWrite["tmp", PageWidth -> 20]
Out[16]= OutputStream["tmp", 5325]
```

写一个表达式后关闭该流：

```mathematica
In[17]:= Write[stmp, Expand[(1 + x)^5]]; Close[stmp]
Out[17]= "tmp"
```

表达式分为几行以便每行最多是`20`个字符：

```mathematica
In[18]:= FilePrint["tmp"]
During evaluation of In[20]:=
1 + 5*x + 10*x^2 + 
 10*x^3 + 5*x^4 + 
 x^5
```

`CharacterEncoding` 选项为一个字符串指定代码，该代码将在送到 `Write` 或 `WriteString` 给出的流中任意包含这个特殊字符的字符串中使用. 
在需要改动国际字符集、或者需要某一输出设备接收不能处理的字符时，
常常使用 `CharacterEncoding` . 

*****
操作流的选项. 

+ `Options[stream]`  找出对流设置的选项
+ `SetOptions[stream,Subscript[opt, 1]->Subscript[val, 1],...]`  对一个打开的流重写设置选项

打开一个具有默认设置的流：

```mathematica
In[19]:= stmp = OpenWrite["tmp"]
Out[19]= OutputStream["tmp", 5326]
```

改变打开流的 `FormatType` 选项：

```mathematica
In[20]:= SetOptions[stmp, FormatType -> TeXForm];
```

`Options` 显示了对打开的流所设置的选项：

```mathematica
In[21]:= Options[stmp]
Out[21]= {BinaryFormat -> False, FormatType -> TeXForm, PageWidth -> 78, 
 PageHeight -> 22, TotalWidth -> \[Infinity], TotalHeight -> \[Infinity], 
 CharacterEncoding :> Automatic, NumberMarks :> $NumberMarks, 
 Method -> {"File", BinaryFormat -> False}}
```

关闭这个流：

```mathematica
In[22]:= Close[stmp]
Out[22]= "tmp"
```

*****
操作标准输出通道的选项. 

+ `Options[$Output]`	找出通道 `$Output` 中所有流的选项
+ `SetOptions[$Output,opt1->val1,...]`	对通道 `$Output` 中的所有流设置选项

在进程中的每一处，Wolfram 语言保持一个当前打开的所有输入输出流以及它们选项的列表  `Streams[]` . 
有时需要直接查看这一列表，但除过间接使用 `OpenRead` 等情况下，Wolfram 语言不允许修改这个列表. 
