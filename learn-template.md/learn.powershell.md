# learn.powershell.md

*For myself and for you*

[收集和分享 Windows PowerShell 相关教程,技术和最新动态][]  
版权归原作者所有

[收集和分享 Windows PowerShell 相关教程,技术和最新动态]: https://www.pstips.net/

## introduction

与大多数 Shell（它们接受和返回文本）不同，Windows PowerShell 是在 .NET Framework 公共语言运行时 (CLR) 和.NET Framework 的基础上生成的，它将接受和返回 .NET Framework 对像。 环境中的这一基本更改为 Windows 的管理和配置带来了全新的工具和方法。

Windows PowerShell 引入了 cmdlet（读作“command-let”）的概念，它是内置于 Shell 的简单的单一函数命令行工具。 可以分别使用每个 cmdlet，但只有组合使用这些简单的工具来执行复杂的任务时，你才会意识到它们的强大功能。 Windows PowerShell 包括一百多个基本核心 cmdlet，你可以编写自己的 cmdlet 并与其他用户共享。

与许多 Shell 类似，Windows PowerShell 允许你访问计算机上的文件系统。 此外，Windows PowerShell 提供程序使你能够像访问文件系统一样方便地访问其他数据存储（例如注册表和数字签名证书存储）。

[micro-doc][micro-doc]

[micro-doc]: https://docs.microsoft.com/zh-cn/powershell/scripting/getting-started/getting-started-with-windows-powershell?view=powershell-6

PowerShell 是一个脚本引擎 dll，嵌入到多个主机中。 启动的最常见主机是交互式命令行 PowerShell.exe 和交互式脚本环境 PowerShell_ISE.exe。

## section 认识Powershell

### Powershell管道和重定向

#### 管道

即把上一条命令的输出作为下一条命令的输入。

例如通过`ls`获取当前目录的所有文件信息，  
然后通过`·`Sort -Descending`·`对文件信息按照`Name`降序排列，  
最后将排序好的文件的`Name`和`Mode`格式化成`Table`输出。

`ls | sort -Descending Name | Format-Table Name,Mode`

#### 重定向

把命令的输出保存到文件中，`>`为覆盖，`>>`追加。

```powershell
PS C:\PStest> "Powershell Routing" >test.txt
PS C:\PStest> Get-Content .\test.txt
Powershell Routing
PS C:\PStest> "Powershell Routing" >>test.txt
PS C:\PStest> "Powershell Routing" >>test.txt
PS C:\PStest> "Powershell Routing" >>test.txt
PS C:\PStest> "Powershell Routing" >>test.txt
PS C:\PStest> "Powershell Routing" >>test.txt
PS C:PStest\> Get-Content .\test.txt
Powershell Routing
Powershell Routing
Powershell Routing
Powershell Routing
Powershell Routing
Powershell Routing
PS C:\PStest>
```

## section Powershell交互式

### Powershell 进行数学运算

我们可以把`powershell`当成一个计算器。  
像键入命令行那样输入数学表达式，回车，`powershell`会自动计算并把结果输出。  
常用的加减乘除模 `+,-,*,/,%` 运算和小括号表达式都支持。

`PowerShell`也能自动识别计算机容量单位, 包括`KB，MB，GB，TB，PB`

### Powershell 执行外部命令

Powershell 能够像CMD一样很好的执行外部命令。

#### 通过`netstat`查看网络端口状态

#### 通过`IPConfig`查看自己的网络配置

#### `route print`查看路由信息

#### 启动CMD控制台

启动`CMD`控制台键入`cmd`或者`cmd.exe`,退出`cmd`可以通过命令`exit`。

#### 查找可用的`Cmd`控制台命令

`Cmd.exe` 通过 `/c` 来接收命令参数，在`Cmd`中`help`可以查看可用的命令，  
所以可以通过`Cmd /c help` 查找可用的Cmd控制台命令

#### 启动外部程序

为什么可以通过`notpad`打开记事本，不能通过`wordpad`打开写字板？

因为`notepad.exe`位于`C:Windows\system32` 这个目录，  
而这个目录已经默认被包含在`Powershell`的环境变量`$env:Path`中。

而`wordpad.exe` 所在的`“%ProgramFiles%\Windows NT\Accessories\wordpad.exe“`目录却没有包含，  
可以先进入这个目录，再运行`wordpad`，或者将`wordpad`所在的目录加入到环境变量中，  `$env:Path=$env:Path+”%ProgramFiles%\Windows NT\Accessories”`。

默认键入一个字符串，`powershell`会将它原样输出，  
如果该字符串是一个命令或者启动程序，在字符串前加`‘&’`可以执行命令，或者启动程序。

```powershell
PS C:\PS> "ls"
ls
PS C:\PS> &"ls"

```

### Powershell 命令集 cmdlets

`cmdlets`是`Powershell`的内部命令，`cmdlet`的类型名为`System.Management.Automation.CmdletInfo`，包含下列属性和方法：

下面是全部的`Cmdlets`命令

每个命令有一个动词和名词组成，命令的作用一目了然。

[Powershell 命令集][]

[Powershell 命令集]: https://www.pstips.net/powershell-cmdlets.html

### Powershell 别名

`cmdlet`的名称由一个动词和一个名词组成，其功能对用户来讲一目了然。  
但是对于一个经常使用`powershell`命令的人每天敲那么多命令也很麻烦啊。  
能不能把命令缩短一点呢？于是“**别名**”就应运而生了。`Powershell`内部也实现了很多常用命令的别名。  
例如`Get-ChildItem`，列出当前的子文件或目录。它有两个别名：`ls` 和 `dir`，这两个别名来源于`unix` 的`shell`和`windows`的`cmd`。

因此别名有两个作用：

1. 继承：继承unix-shell和windows-cmd。
2. 方便：方便用户使用。

#### 处理别名

查询别名所指的真实`cmdlet`命令。

```powershell
PS C:\PS> Get-Alias -name ls
```

#### 查看可用的别名

查看可用的别名，可以通过” `ls alias:`” 或者 ”`Get-Alias`“
如何查看所有以`Remove`打头的`cmdlet`的命令的别名呢？

```powershell
PS C:\PS> dir alias: | where {$_.Definition.Startswith("Remove")}
```

说明：`dir alias:`获取的是别名的数组，通过`where`对数组元素进行遍历，`$_`代表当前元素，`alias`的`Definition`为`String`类型，因为`powershell`支持`.net`，`.net`中的`string`类有一个方法`Startswith`。通过`where`过滤集合在`powershell`中使用非常广泛。

有的`cmdlet`命令可能有2-3个别名，我们可以通过下面的命令查看所有别名和指向`cmdlet`的别名的个数。

```powersehll
PS C:\PS> ls alias: | Group-Object definition | sort -Descending Count
```

#### 创建自己的别名

给记事本创建一个别名，并查看该别名；

```powershell
PS C:\PS> Set-Alias -Name Edit -Value notepad
PS C:\PS> Edit
PS C:\PS> $alias:Edit
notepad
```

#### 删除自己的别名

别名不用删除，自定义的别名在`powershell`退出时会自动清除。但是请放心，`powershell`内置别名（诸如`ls,dir,fl`等）不会清除。如果你非得手工删除别名。请使用

```powershell
PS C:\PS> del alias:Edit
```

#### 保存自己的别名

可以使用Export-Alias将别名导出到文件，需要时再通过`Import-Alias`导入。但是导入时可能会有异常，提示别名已经存在无法导入：

```powershell
PS C:\PS> Import-Alias alias.ps1
Import-Alias : Alias not allowed because an alias with the name 'ac' already exists.
At line:1 char:13
+ Import-Alias <<<<  alias.ps1
    + CategoryInfo          : ResourceExists: (ac:String) [Import-Alias], SessionStateException
    + FullyQualifiedErrorId : AliasAlreadyExists,Microsoft.PowerShell.Commands.ImportAliasCommand
```

这时可以使用`Force`强制导入。

```powershell
PS C:\PS> Export-Alias alias.ps1
PS C:\PS> Import-Alias -Force alias.ps1
```

### Powershell 通过函数扩展别名

在`Powershell`中设置别名的确方便快捷，但是在设置别名的过程中并设置参数的相关信息。  
尽管别名会自动识别参数，但是如何把经常使用的参数默认设定在别名里面呢？  
例如`Test-Connection -Count 2 -ComputerName`，让 “`-Count 2`” 固化在别名中。

这时简单的别名无法完成上述需求，可以通过函数来完成它，  
并且一旦把函数拉过来，定义别名会变得更加灵活。

```powershell
PS C:\PS> function test-conn { Test-Connection  -Count 2 -ComputerName $args}
PS C:\PS> Set-Alias tc test-conn
PS C:\PS> tc localhost

Source        Destination     IPV4Address      IPV6Address                              Bytes    Time(ms)
------        -----------     -----------      -----------                              -----    --------
test-me-01   localhost       127.0.0.1        ::1                                      32       0
test-me-01   localhost       127.0.0.1        ::1                                      32       0
```

有了函数牵线，别名可以完成更高级更强大的功能，其中`$args`为参数的占位符。

### Powershell 执行文件和脚本

像运行可执行文件一样，`Powershell`运行文件和脚本，  
也必须使用绝对路径或者相对路径，或者要运行的文件必须定义在可受信任的环境变量中。

#### 关于脚本

脚本和批处理都属于伪可执行文件，它们只是包含了若干命令行解释器能够解释和执行的命令行代码。

#### 执行批处理文件

批处理是扩展名为”`.bat`”的文本文件，它可以包含任何`cmd`控制台能够处理的命令。  
当批处理文件被打开，`Cmd`控制台会逐行执行每条命令。那`Powershell`能够直接执行批处理吗？  
将下列命令保存为`ping.bat`

```powershell
@echo off
echo batch File Test
pause
Dir %windir%/system
```

然后执行`ping`
屏幕会打印`ping`命令帮助，说明调用的`ping` 而不是`ping.bat`。
改为：

```powershell
PS C:\PS> ./ping
```

这时运行的是批处理。

通过`进入`控制台输入发现执行的不是命令，而是直接运行`ping.bat` ，  
也就是说可以通过`.bat` 覆盖`cmd`命令。  
这种机制很危险，如果有人侵入电脑，并将系统内部命令篡改成自己批处理，那就太悲剧了。  
这种命令与脚本的混淆不会发生在`powershell`中，因为`powershell`有更安全的机制。

#### 执行powershell脚本

`Powershell` 拥有自己的脚本，扩展名为“`.ps1`”

```powershell
PS C:\PS> echo "dir;Get-PSProvider;help dir" >test.ps1
PS C:\PS> Get-Content ./test.ps1
dir;Get-PSProvider;help dir
PS C:\PS> ./test.ps1
```

初次执行脚本时，可能会碰到一个异常：

```powershell
File ” C:\PS\test.ps1″ cannot be loaded because the
execution of scripts is disabled on this system. Please see
“get-help about_signing” for more details.
At line:1 char:10
+ .test.ps1 <<<<
```

这是`powershell`的默认安全设置禁用了执行脚本，要启用这个功能需要拥有管理员的权限。

#### Powershell调用入口的优先级

别名：控制台首先会寻找输入是否为一个别名，如果是，执行别名所指的命令。因此我们可以通过别名覆盖任意`powershell`命令，因为别名的优先级最高。

函数：如果没有找到别名，会继续寻找函数，函数类似别名，只不过它包含了更多的`powershell`命令。  
因此可以自定义函数扩充 `cmdlet` 把常用的参数给固化进去。

命令：如果没有找到函数，控制台会继续寻找命令，即 `cmdlet` ，`powershell`的内部命令。

脚本：没有找到命令，继续寻找扩展名为“`.ps1`”的`Powershell`脚本。

文件：没有找到脚本，会继续寻找文件，如果没有可用的文件，控制台会抛出异常。

```powershell
The term ‘now’ is not recognized as the name of a cmdlet, function, script file, or operable program. Chec
g of the name, or if a path was included, verify that the path is correct and try again.
At line:1 char:4
+ now <<<<
+ CategoryInfo : ObjectNotFound: (now:String) [], CommandNotFoundException
+ FullyQualifiedErrorId : CommandNotFoundException
```

## section Powershell变量

### Powershell 定义变量

变量可以临时保存数据，因此可以把数据保存在变量中，以便进一步操作。

```powershell
#定义变量
$a=10
$b=4
#计算变量
$result=$a*$b
$msg="保存文本"

#输出变量
$result
$msg

40
保存文本
```

`powershell` 不需要显示地去声明，可以自动创建变量，只须记住变量的前缀为`$`.
创建好了变量后，可以通过变量名输出变量，也可以把变量名存在字符串中。  
但是有个例外---单引号中的字符串不会识别和处理变量名。

#### 选择变量名

在`powershell`中变量名均是以美元符”`$`”开始，剩余字符可以是数字、字母、下划线的任意字符，  
并且`powershell`变量名大小写不敏感（`$a`和`$A` 是同一个变量)。
某些特殊的字符在`powershell`中有特殊的用途，一般不推荐使用这些字符作为变量名。  
当然你硬要使用，请把整个变量名后缀用花括号括起来。

```powershell
PS C:\test> ${"I"like $}="mossfly"
PS C:\test> ${"I"like $}
mossfly
```

#### 赋值和返回值

赋值操作符为`“=”`，几乎可以把任何数据赋值给一个变量，甚至一条`cmdlet`命令，  
为什么，因为`Powershell`支持对象，对象可以包罗万象。

```powershell
PS C:\test> $item=Get-ChildItem .
PS C:\test> $item

    Directory: C:\test

PS C:\test> $result=3000*(1/12+0.0075)
PS C:\test> $result
272.5
```

#### 给多个变量同时赋值

赋值操作符不仅能给一个变量赋值，还可以同时给多个变量赋相同的值。

```powershell
PS C:\test> $a=$b=$c=123
PS C:\test> $a
123
PS C:\test> $b
123
PS C:\test> $c
123
```

#### 交换变量的值

要交换两个变量的值，传统的程序语言至少需要三步，并且还需定义一个中间临时变量。

在powershell中，交换两个变量的值，这个功能变得非常简单。

```powershell
PS C:\test> $value1=10
PS C:\test> $value2=20
PS C:\test> $value1,$value2=$value2,$value1
PS C:\test> $value1
20
PS C:\test> $value2
10
```

#### 查看正在使用的变量

`Powershell`将变量的相关信息的记录存放在名为`variable:`的驱动中。  
如果要查看所有定义的变量，可以直接遍历`variable:`

```powershell
PS C:\test> ls variable:
```

#### 查找变量

因为有虚拟驱动`variable:`的存在，可以像查找文件那样使用通配符查找变量。  
例如要查询以`value`打头的变量名。

```powershell
PS C:\test> ls variable:value*
```

#### 验证变量是否存在

验证一个变量是否存在，仍然可以像验证文件系统那样，  
使用`cmdlet Test-Path`。为什么？因为变量存在变量驱动器中。

```powershell
PS C:\test> Test-Path variable:value1
```

#### 删除变量

因为变量会在`powershell`退出或关闭时，自动清除。  
一般没必要删除，但是你非得删除，也可以像删除文件那样删除它。

```powershell
PS C:\test> Test-Path variable:value1
True
PS C:\test> del variable:value1
PS C:\test> Test-Path variable:value1
False
```

#### 使用专用的变量命令

为了管理变量，`powershell`提供了五个专门管理变量的命令  
`Clear-Variable`，`Get-Variable`，`New-Variable`，`Remove-Variable`，`Set-Variable`。  
因为虚拟驱动器`variable:`的存在，`clear，remove，set`打头的命令可以被代替。  
但是`Get-Variable，New-Variable`,却非常有用。  
`new-variable`可以在定义变量时，指定变量的一些其它属性，比如访问权限。  
同样`Get-Variable`也可以获取这些附加信息。

#### 变量写保护

可以使用`New-Variable` 的`option`选项 在创建变量时，给变量加上只读属性，  
这样就不能给变量重新赋值了。

```powershell
PS C:\test> New-Variable num -Value 100 -Force -Option readonly
PS C:\test> $num=101
Cannot overwrite variable num because it is read-only or constant.
```

但是可以通过删除变量，再重新创建变量更新变量内容。

```powershell
PS C:\test> del Variable:num -Force
PS C:\test> $num=101
PS C:\test> $num
101
```

有没有权限更高的变量，有，那就是：选项`Constant`，常量一旦声明，不可修改

```powershell
PS C:\test> new-variable num -Value "strong" -Option constant

PS C:\test> $num="why? can not delete it."
Cannot overwrite variable num because it is read-only or constant.
```

#### 变量描述

在 `New-Variable`可以通过 `-description` 添加变量描述，  
但是变量描述默认不会显示，可以通过`Format-List` 查看。

```powershell
PS C:\test> new-variable name -Value "me" -Description "This is my name"
PS C:\test> ls Variable:name | fl *
```

### Powershell自动化变量

`Powershell` 自动化变量 是那些一旦打开`Powershell`就会自动加载的变量。
这些变量一般存放的内容包括

+ 用户信息：例如用户的根目录`$home`
+ 配置信息:例如`powershell`控制台的大小，颜色，背景等。
+ 运行时信息：例如一个函数由谁调用，一个脚本运行的目录等。

```powershell
PS> $HOME
C:\Users\test
PS> $currentProcessID=$pid
PS> $currentProcessID
5356
PS> Get-Process -Id $pid
```

`powershell`中的某些自动化变量只能读，不能写。例如:`$Pid`。  
可以通过`Get-Help about_Automatic_variables`查看`Automatic_variables`的帮助。

[detail on automatic][]

[detail on automatic]: https://www.pstips.net/powershell-automatic-variables.html

### Powershell环境变量

传统的控制台一般没有象`Powershell`这么高级的变量系统。  
它们都是依赖于机器本身的环境变量，进行操作。  
环境变量对于`powershell`显得很重要，因为它涵盖了许多操作系统的细节信息。  
此外，`powershell`中的变量只存在于`powershell`内部的会话中，一旦`powershell`关闭，这些变量就会自生自灭。  
但是如果环境变量被更新了，它会继续保存在操作系统中，即使其它程序也可以调用它。

#### 读取特殊的环境变量

通过环境变量读取`Windows`操作系统的安装路径，和默认应用程序的安装路径。

```powershell
PS> $env:windir
C:\Windows
PS> $env:ProgramFiles
C:\Program Files
```

通过`$env:`，这就提示`powershell`忽略基本的`variable:`驱动器，而是去环境变量`env:`驱动器中寻找变量。
为了和其它变量保持一致，`powershell`环境变量也可以象其它变量那样使用。  
比如你可以把它插入到文本中。

```powershell
PS> "My computer name $env:COMPUTERNAME"
My computer name MYHome-test-01
```

#### 查找环境变量

`Powershell`把所有环境变量的记录保存在`env:` 虚拟驱动中，因此可以列出所有环境变量 。  
一旦查出环境变量的名字就可以使用`$env:name` 访问了。

```powershell
PS> ls env:
```

#### 创建新的环境变量

创建新环境变量的方法和创建其它变量一样，只需要指定`env:`虚拟驱动器即可

```powershell
PS> $env:TestVar1="This is my environment variable"
PS> $env:TestVar2="Hollow, environment variable"
PS> ls env:Test*
```

#### 删除和更新环境变量

在`powershell`删除和更新环境变量和常规变量一样。例如要删除环境变量中的 `windir`，

```powershell
PS> del env:windir
PS> $env:windir
```

可以更新环境变量$env:OS 为linux redhat。

```powershell
PS> $env:OS
Windows_NT
PS>  $env:OS="Redhat Linux"
PS> $env:OS
Redhat Linux
```

这样直接操作环境变量，会不会不安全？  
事实上很安全，因为`$env：`中的环境变量只是机器环境变量的一个副本，  
即使你更改了它，下一次重新打开时，又会恢复如初。（.NET方法更新环境变量除外）

我们可以将受信任的文件夹列表追加到环境变量的末尾，  
这样就可以直接通过相对路径执行这些文件下的文件或者脚本，甚至省略扩展名都可以。

```powershell
PS> md .myscript

    Directory:

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----        2011/11/29     18:20            myscript

PS> cd .myscript
PSmyscript> "write-host 'Hollow , Powershell'" > hollow.ps1
PSmyscript> .hollow.ps1
Hollow , Powershell
PSmyscript> cd ..
PS> $env:Path+=";C:PowerShell\myscript"
PS> hollow.ps1
Hollow , Powershell
PS> hollow
Hollow , Powershell
```

#### 环境变量更新生效

上述对于环境变量的操作只会影响当前`powershell`会话，并没有更新在机器上。  
`.NET`方法`[environment]::SetEnvironmentvariable`操作可以立刻生效。
下面的例子对当前用户设置环境变量，经测试，重新打开powershell仍然存在

```powershell
PS> [environment]::SetEnvironmentvariable("Path", ";c:\powershellscript", "User")
PS> [environment]::GetEnvironmentvariable("Path", "User")
;c:\powershellscript
```

### Powershell驱动器变量

`Powershell`中所有不是我们自己的定义的变量都属于驱动器变量（比如环境变量），  
它的前缀只是提供给我们一个可以访问信息的虚拟驱动器。  
例如`env:windir`，像`env：`驱动器上的一个”`文件`”，我们通过`$`访问它，就会返回”`文件`”的内容。

#### 直接访问文件路径

通过驱动器直接访问文件路径，也支持物理驱动器，必须把文件路径放在封闭的大括号中，  
因为正常的文件路径包含两个特殊字符“`:`”和“`/`”，有可能会被`powershell`解释器误解。

```powershell
PS> ${c:/powershell/ping.bat}
@echo off
echo batch File Test
pause
Dir %windir%/system

PS> ${c:autoexec.bat}
REM Dummy file for NTVDM
```

上述的例子有一个限制，就是`${$env:HOMEDRIVE/Powershellping.bat}`不能识别，  
原因是`$`后花括号中的路径必须是具体的路径，而不能带返回值。
解决方法：

```powershell
PS> Invoke-Expression "`${$env:HOMEDRIVE/Powershell/ping.bat}"
@echo off
echo batch File Test
pause
Dir %windir%/system
```

因为反引号”`` ` ``”放在`$`前，会把`$`解析成普通字符，解释器会继续去解析第二个`$`，  
发现`env:HOMEDRIVE`，将其替换成`c`，  
到此 `Invoke-Expression`的参数就变成了`${C:/Powershell/ping.bat}`,  
继续执行这个表达式就可以了。
查看`Powershell`支持的驱动器，可以使用`Get-PSDrive`查看。

`PSDrive`中的大多都支持直接路径访问，例如可以通过函数路径，访问一个函数的具体实现。

```powershell
PS> function hellow(){ Write-Host "Hellow,Powershell" }
PS> $function:hellow
param()
Write-Host "Hellow,Powershell"
```

#### 特殊的变量：子表达式

由 `$+圆括号+表达式` 构成的变量属于`子表达式变量`，  
这样的变量会先计算表达式，然后把表达式的值返回。  
例如 变量`$(3+6)`，可以简写成`（3+6）`,甚至可以简写成`3+6`。  
子表达式变量也可以嵌套在文本中，例如”`result=$(3+6)`”。
在处理对象的属性时，会大量的用到表达式变量。例如：

```powershell
PS> $file=ls Powershell_Cmdlets.html
PS> $file.Length
735892
PS> "The size of Powershell_Cmdlets.html is $($file.Length)"
The size of Powershell_Cmdlets.html is 735892
```

其实上面的代码可以简化为：

```powershell
PS> "The size of Powershell_Cmdlets.html is $($(ls Powershell_Cmdlets.html).Length)"
The size of Powershell_Cmdlets.html is 735892
```

### Powershell变量的作用域

`Powershell`所有的变量都有一个作用域,决定变量是否可用。  
`Powershell`支持四个作用域：全局、当前、私有和脚本。  
有了这些作用域就可以限制变量的可见性了，尤其是在函数和脚本中。

如果我们对变量不做特别的声明，`Powershell`解释器会自动处理和限制变量的作用域。  
将下面的内容命令保存着至`test1.ps1`

```powershell
$windows = $env:windir
“Windows Folder: $windows”
```

然后在控制台给变量`$windows`赋值，并调用Test.ps1脚本。

```powershell
PS> $windows="Hellow"
PS> .\test.ps1
Windows Folder: C:\Windows
PS> $windows
Hellow
```

调用脚本时，会分配一个变量`$windows`，在脚本调用结束后，这个变量被回收，  
脚本中的变量不会影响脚本外的变量，因为它们在不同的作用域中。  
`powershell`会针对每个函数和脚本给它们分配不同的作用域。

#### 更改变量的可见性

你可以很容易的看到没有`Powershell`解释器自动限制可见性时会发生什么状况，同样是刚才的脚本，刚才的命令，只是在运行脚本时多加上一个点”`.`” 和一个`空格`：

```powershell
PS> $windows="Hellow"
PS> . .\test.ps1
Windows Folder: C:\Windows
PS> $windows
C:Windows
```

在运行脚本时使用一个`圆点`和`空格`，`Powershell`解释器就不会为脚本本身创建自己的变量作用域，  
它会**共享当前控制台的作用域**，这种**不太灵活但却简单**的方法，**使用时一定要格外小心**。

#### 加强变量可见性限制的优点：清空初始化环境

可以假设一个场景，如果你在当前控制台不小心定义了一个只读的常量，这个常量既不能更新也不能删除，很是麻烦。  
但是如果你在脚本中操作这个变量就不成问题，因为脚本有自己的作用域。  
例如，将下面文本保存为`test.ps1`，并调用没有任何问题：

```powershell
New-Variable a -value 1 -option Constant
"Value: $a"

PS> .\test.ps1
Value: 1
```

但是如果你通过圆点禁用作用域限制，调用`test.ps1`,就会有异常，因为一个常量不能被创建两次。

```powershell
PS> . .\test.ps1
Value: 1
PS> . .\test.ps1
New-Variable : A variable with name 'a' already exists.
```

所以这种变量的作用域限制可以把变量的冲突降到最小。

#### 设置单个变量的作用域

到目前为止，看到的变量作用域的改变都是全局的，能不能针对某个具体变量的作用域做一些个性化的设置。

`$global`

全局变量，在所有的作用域中有效，如果你在脚本或者函数中设置了全局变量，即使脚本和函数都运行结束，这个变量也任然有效。

`$script`

脚本变量，只会在脚本内部有效，包括脚本中的函数，一旦脚本运行结束，这个变量就会被回收。

`$private`

私有变量，只会在当前作用域有效，不能贯穿到其他作用域。

`$local`

默认变量，可以省略修饰符，在当前作用域有效，其它作用域只对它有只读权限。

打开`Powershell`控制台后，`Powershell`会自动生成一个新的**全局作用域**。  
如果增加了函数和脚本，或者特殊的定义，才会生成其它作用域。
在当前控制台，只存在一个作用域，通过修饰符访问，其实访问的是同一个变量：

```powershell
PS> $logo="www.pstips.net"
PS> $logo
www.pstips.net
PS> $private:logo
www.pstips.net
PS> $script:logo
www.pstips.net
PS> $private:logo
www.pstips.net
PS> $global:logo
www.pstips.net
```

当调用一个已定义的函数，`Powershell`会生成第二个作用域，  
它可以对**调用者的作用域**(即`$global`)中的变量执行读操作，但是不能执行写操作。

``` powershell
PS> function f(){ "var=$var";$var="function inner";$var }
PS> $var="I am in console."
PS> $var
I am in console.
PS> f
var=I am in console.
function inner
PS> $var
I am in console.
```

怎样把当前控制台中的变量保护起来，不让它在函数和脚本中被访问，`Private`修饰符就派上了用场。

```powershell
PS> function f(){ "var=$var";$var="function inner";$var }
PS> $private:var="i am a private variable in console,other scope can not access me."
PS> f
var=
function inner
PS> $private:var
i am a private variable in console,other scope can not access me.
```

对于`$private`限制的变量能不能在函数中通过`$global`修改呢？  
不但不能修改，还会删除当前的`$private`变量。**此处存疑**

```powershell
PS> Function f(){ "var=$var";$global:var=" Try to change variable in function"}
PS> $private:var="I am a private variable"
PS> $private:var
I am a private variable
PS> $var
I am a private variable
PS> f
var=
PS> $private:var
PS> $var
PS>
PS> $private:var -eq $null
True
```

#### 但是`$local`修饰的变量则可以通过`$global`在函数内部更改

```powershell
PS> Function f(){ "var=$var";$global:var=" Try to change variable in function"}
PS> $var="I am a local variable."
PS> $var
I am a local variable.
PS> $private:var
I am a local variable.
PS> f
var=I am a local variable.
PS> $var
 Try to change variable in function
PS> $local:var
 Try to change variable in function
```

### Powershell变量的类型和强类型

变量可以自动存储任何`Powershell`能够识别的类型信息，  
可以通过`$variable`的`GetType().Name`查看和验证`Powershell`分配给变量的数据类型。

```powershell
PS> (10).gettype().name
Int32
PS> (9999999999999999).gettype().name
Int64
PS> (3.14).gettype().name
Double
PS> (3.14d).gettype().name
Decimal
PS> ("WWW.MOSSFLY.COM").gettype().name
String
PS> (Get-Date).gettype().name
DateTime
```

`Powershell`会给数据分配一个最佳的数据类型；  
如果一个整数超出了32位整数的上限(`[int32]::MaxValue`),它就会分配一个64位整数的数据类型；  
如果碰到小数，会分配一个`Double`类型；  
如果是文本，`Powershell`会分配一个`String`类型；  
如果是日期或者时间，会被存储为一个`Datetime`对象。

这种类型自适应也称作“弱类型”,虽然使用起来方便，但是也会有一些限制，甚至危险。  
如果`powershell`选择了一个错误的类型赋给变量，可能会引发一些奇怪的现象。  
例如有一个变量要存储的是即将拷贝文件的个数，可是在赋值时赋了一个字符串，`Powershell`不会去做过多的判断，它会更新这个变量的类型，并且存储新的数据。  
所以一般专业的程序员或者脚本开发者更喜欢使用“**强类型**”，哪怕在赋值时类型不兼容的报错，他们也乐意接受。

喜欢使用强类型的另一个原因是：每一个数据类型都有属于自己的函数。  
例如`DateTime`,和`XML`，尽管这两种类型都可以用纯文本表示，  
但是使用强类型`[DateTime]`和`[XML]`,对于数据操作起来更方便，这两个类型的方法可是很丰富噢！

#### 指定类型定义变量

定义变量时可以在变量前的中括号中加入数据类型。  
例如定义一个`Byte`类型的变量，因为`Byte`的定义域为`[0,255]`, 一旦尝试使用一个不在定义域中的值赋给该变量就会显示一条错误信息。

```powershell
PS> [byte]$b=101
PS> $b
101
PS> $b=255
PS> $b
255
PS> $b.gettype()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Byte                                     System.ValueType

PS> $b=256

Cannot convert value "256" to type "System.Byte". Error: "Value was either too large or too small for an unsigned byte.
"
```

#### 使用固定类型的优点

手动地定义类型的一个重要原因是每个特殊的数据类型都有自己的特殊命令和特殊方法。  
比如把一个日期字符串赋给一个变量，`Powershell`不会自动把这个字符串转换成日期对象赋给一个变量，因为`Powershell`毕竟是机器，没有人那么智能。  
当你在赋值时指定`DateTime`类型时，你会发现几乎所有的`.Net` 中`DateTime`类型的方法在这里都得到支持。

```powershell
PS> [DateTime]$date="2012-12-20 12:45:00"
PS> $date

2012年12月20日 12:45:00

PS> $date.DayOfWeek
Thursday
PS> $date.DayOfYear
355
PS> $date.AddDays(-10)

2012年12月10日 12:45:00
```

`Powershell`处理`Xml`文档也很方便。

例如有如下`LogoTest.xml`

```xml
<logotest>
  <extensions>
    <e>.exe</e>
    <e>.dll</e>
  </extensions>
  <files>
    <f></f>
  </files>
  <dirs></dirs>
</logotest>
```

查询`.exe` 和 `.dll`结点

```powershell
PS> [ XML ]$xml=(Get-Content .LogoTestConfig.xml)
PS> $xml.LogoTest.Extensions.E
.exe
.dll
```

`Powershell` 默认支持的`.NET`类型如下。

`[array]`,`[bool]`,`[byte]`,

`[char]`,`[datetime]`,`[decimal]`,

`[double]`,`[guid]`,`[hashtable]`,

`[int16]`,`[int32]`,`[int]`,`[int64]`,

`[long]`,`[nullable]`,`[psobject]`,`[regex]`,

`[sbyte]`.`[scriptblock]`,`[single]`,`[float]`,

`[string]`,`[switch]`,`[timespan]`,`[type]`,

`[uint16]`,`[uint32]`,`[uint64]`,

`[ XML ]`

### Powershell强类型数组

`Powershell`数组一般具有多态性，如果你不指定元素的具体类型，解释器会自动选择合适的类型存储每个元素。  
如果要统一限制所有元素的类型，可是使用**类型名和一对方括号**作为数组变量的类型。  
这样每当赋值时，会自动类型检查。如果目标数据类型不能转换成功，就会抛出一个异常。

```powershell
PS C:Powershell> [int[]] $nums=@()
PS C:Powershell> $nums+=2012
PS C:Powershell> $nums+=12.3
PS C:Powershell> $nums+="999"
PS C:Powershell> $nums+="can not convert"
Cannot convert value "can not convert" to type "System.Int32". Error: "Input string was not in a correct format."
```

### Powershell变量的幕后管理

在`Powershell`中创建一个变量，会在后台生成一个`PSVariable`对象，  
这个对象不仅包含变量的值，也包含变量的其它信息，例如”**只写保护**”这样的描述。
如果在`Powershell`中输出一个变量，只会输出这个变量的值。  
不能够显示它的其它信息，如果想查看一个变量的其它保留信息，就需要变量的基类`PSVariable`对象，  
这个可以通过`Get-Variable`命令得到，下面的例子演示如何查看一个变量的全部信息。

```powershell
PS> $a=get-date
PS> Get-Variable a
```

#### 修改变量的选项设置

`Powershell`处理一个变量的`PSVariable`对象，主要是为了能够更新变量的选项设置。  
既可以使用命令`Set-Variable`，也可以在获取`PSvariable`对象后直接更改。  
比如更改一个变量的描述：

```powershell
PS> $str="我是一个变量"
PS> $var=Get-Variable str
PS> $var

Name                           Value
----                           -----
str                            我是一个变量

PS> $var | fl *

Name        : str
Description :
...

PS> $var.Description="我知道你是一个变量"
PS> $var | fl *
Name        : str
Description : 我知道你是一个变量
...
```

如果你不想多加一个临时变量`$var`来存储`PSVariable`,可以使用`Powershell`子表达式

```powershell
PS> (Get-Variable str).Description="变量的描述已更改;"
PS> Get-Variable str | Format-Table Name,Description

Name                                                        Description
----                                                        -----------
str                                                         变量的描述已更改;
```

#### 激活变量的写保护

可以操作一个变量的选项设置 ，比如给一个变量加上写保护，需要将`Option`设置为“`ReadOnly`”

```powershell
PS> $var="mossfly"
PS> Set-Variable var -Option "ReadOnly"
PS> (Get-Variable var).Options
ReadOnly
PS> Set-Variable var -Option "None" -Force
PS> (Get-Variable var).Options
None
```

#### 变量的选项

变量的选项是一个枚举值，包含:

(枚举值: 通过预定义列出所有值的标识符来定义一个有序集合，这些值的次序和枚举类型说明中的标识符的次序是一致的。)

+ “`None`”:默认设置
+ “`ReadOnly`”：变量只读，但是可以通过-Force 选项更新。
+ “`Constant`”：常量一旦声明，在当前控制台不能更新。
+ “`Private`”:只在当前作用域可见，不能贯穿到其它作用域
+ “`AllScope`”：全局，可以贯穿于任何作用域

#### 变量的类型规范

每个变量的都有自己的类型，  
这个具体的类型存放在`PsVariable`对象的  
`Attributes[System.Management.Automation.PSVariableAttributeCollection]`属性，  
如果这个`Attributes`为空，可以给这个变量存放任何类型的数据，`Powershell`会自己选择合适的类型。  
一旦这个`Attributes`属性确定下来，就不能随意存放数据了。

例如给`$var`存放一个整数，属于弱类型，所以`Attributes`属性为空，这时还可以给它赋值一个字符串。  
但是如果给`$var`增加强类型，存放一个整数，再给它赋值一个其它类型，解释器会自动尝试转换，如果不能转换就会抛出异常。  
这时如果你非得更新`$var`变量的类型，可以使用`(Get-Variable var).Attributes.Clear()`,清空`Attributes`，这样强类型就又转换成弱类型了。

***
conclusion:

+ `$var.GetType().FullName`
+ `(Get-Variable var).Attributes`
+ `(Get-Variable var).Attributes.Clear()`

***

```powershell
PS> $var=123
PS> (Get-Variable var).Attributes
PS> $var.GetType().FullName
System.Int32
PS> $var="字符串"
PS>  (Get-Variable var).Attributes
PS>  $var.GetType().FullName
System.String
PS> [int]$var=123
PS> (Get-Variable var).Attributes

TypeId
------
System.Management.Automation.ArgumentTypeConverterAttribute

PS> $var.GetType().FullName
System.Int32
PS> $var="2012"
PS> $var
2012
PS> $var.GetType().FullName
System.Int32
PS> $var="2012世界末日"
Cannot convert value "2012世界末日" to type "System.Int32". Error: "Input string was not in a correct format."

PS> (Get-Variable var).Attributes.Clear()
PS> (Get-Variable var).Attributes
PS> $var="2012世界末日"
PS> $var.GetType().FullName
System.String
```

#### 验证和检查变量的内容

变量`PSVariable`对象的`Attributes`属性能够存储一些附件条件，例如限制变量的长度，  
这样在变量重新赋值时就会进行验证，下面演示如何限制一个字符串变量的长度为位于`2-5`之间。

```powershell
PS> $var="限制变量"
PS> $condition= New-Object System.Management.Automation.ValidateLengthAttribute -ArgumentList 2,5
PS> (Get-Variable var).Attributes.Add($condition)
PS> $var="限制"
PS> $var="射雕英雄传"
PS> $var="看射雕英雄传"
The variable cannot be validated because the value 看射雕英雄传 is not a valid value for the var variable.
```

常用的变量内容验证还有`5`种，分别为：

+ `ValidateNotNullAttribute`：限制变量不能为空
+ `ValidateNotNullOrEmptyAttribute`：限制变量不等为空，不能为空字符串，不能为空集合
+ `ValidatePatternAttribute`:限制变量要满足制定的正则表达式
+ `ValidateRangeAttribute`：限制变量的取值范围
+ `ValidateSetAttribute`：限制变量的取值集合

#### ValidateNotNullAttribute 例子

```powershell
PS> $a=123
PS> $con=New-Object System.Management.Automation.ValidateNotNullAttribute
PS> (Get-Variable a).Attributes.Add($con)
PS> $a=8964
PS> $a=$null
无法验证此变量，因为值  不是变量 a 的有效值。
```

#### ValidateNotNullOrEmptyAttribute 例子

注意`@()`为一个空数组。

```powershell
PS> $con=New-Object System.Management.Automation.ValidateNotNullOrEmptyAttribute
PS> (Get-Variable a).Attributes.clear()
PS> (Get-Variable a).Attributes.add($con)
PS> $a=$null
The variable cannot be validated because the value  is not a valid value for the a variable.
```

`ValidatePatternAttribute` 例子

验证`Email`格式

```powershell
PS> $email="test@mossfly.com"
PS> $con=New-Object System.Management.Automation.ValidatePatternAttribute "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b"
PS> (Get-Variable email).Attributes.Add($con)
PS> $email="abc@abc.com"
PS> $email="abc@mossfly.com"
PS> $email="author@gmail.com"
PS> $email="www@mossfly"
The variable cannot be validated because the value www@mossfly is not a valid value for the email variable.
```

## section Powershell数组和哈希表

## section Powershell管道

## section Powershell使用对象

## section Powershell条件判断

### Powershell 中的比较运算符

+ -eq ：等于
+ -ne ：不等于
+ -gt ：大于
+ -ge ：大于等于
+ -lt ：小于
+ -le ：小于等于
+ -contains ：包含
+ -notcontains :不包含

### 进行比较

可以将比较表达式直接输入进`Powershell`控制台，然后回车，会自动比较并把比较结果返回。

```powershell
PS C:Powershell> (3,4,5 ) -contains 2
False
PS C:Powershell> (3,4,5 ) -contains 5
True
PS C:Powershell> (3,4,5 ) -notcontains 6
True
PS C:Powershell> 2 -eq 10
False
PS C:Powershell> "A" -eq "a"
True
PS C:Powershell> "A" -ieq "a"
True
PS C:Powershell> "A" -ceq "a"
False
PS C:Powershell> 1gb -lt 1gb+1
True
PS C:Powershell> 1gb -lt 1gb-1
False
```

### 求反

求反运算符为`-not` 但是像高级语言一样”`！`“ 也支持求反。

```powershell
PS C:Powershell> $a= 2 -eq 3
PS C:Powershell> $a
False
PS C:Powershell> -not $a
True
PS C:Powershell> !($a)
True
```

### 布尔运算

+ `-and` ：和
+ `-or`  ：或
+ `-xor` ：异或
+ `-not` ：逆

```powershell
PS C:Powershell> $true -and $true
True
PS C:Powershell> $true -and $false
False
PS C:Powershell> $true -or $true
True
PS C:Powershell> $true -or $false
True
PS C:Powershell> $true -xor $false
True
PS C:Powershell> $true -xor $true
False
PS C:Powershell>  -not  $true
False
```

### 比较数组和集合

#### 过滤数组中的元素

```powershell
PS C:Powershell> 1,2,3,4,3,2,1 -eq 3
3
3
PS C:Powershell> 1,2,3,4,3,2,1 -ne 3
1
2
4
2
1
```

### 验证一个数组是否存在特定元素

```powershell
PS C:Powershell> $help=(man ls)
PS C:Powershell> 1,9,4,5 -contains 9
True
PS C:Powershell> 1,9,4,5 -contains 10
False
PS C:Powershell> 1,9,4,5 -notcontains 10
True
```

`-contains` 大小写不敏感，`-ccontains`大小写敏感。

```powershell
PS> "a","b","c" -ccontains "a"
True
PS> "a","b","c" -contains "a"
True
PS> "a","b","c" -ccontains "A"
False
```

### Powershell Where-Object 条件过滤

本篇会对条件判断进行实际应用。  
在管道中可以通过条件判断过滤管道结果，Where-Object会对集合逐个过滤，将符合条件的结果保留。

#### 过滤管道结果

使用`Get-Process`返回所有的当前进程 ，但是你可能并不对所有的进程感兴趣，  
然后通过每个`Process`对象的属性进行过滤。首先得知道每个对象支持那些属性

```powershell
PS C:Powershell> Get-Process | select -First 1 | fl *
```

***
根据进程名过滤所有`记事本`进程。

```powershell
PS C:Powershell> Get-Process | Where-Object {$_.Name -eq "notepad"}

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    158       7     8800      37264   114    18.41   6204 notepad
```

***
根据进程名过滤所有`IE`进程。

```powershell
PS C:Powershell> Get-Process | Where-Object {$_.Name -eq "iexplore"}

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    710      23    12832      18160   175    10.51   4204 iexplore
    971      39    81000     107580   399    22.20   6764 iexplore
    336      13    28516      20096   187     0.34   6792 iexplore
    929      35    51020      46568   314    10.42   7192 iexplore
    835      26    49200      32360   308     7.82   7952 iexplore
```

***
根据`company`过滤所有产品发布者以”`Microsoft`”打头的进程：

```powershell
PS C:Powershell> Get-Process | Where-Object {$_.company -like '*Microsoft*' }| select Name,Description,Company
msseces                    Microsoft Security Clie... Microsoft Corporation
notepad                    记事本                     Microsoft Corporation
ONENOTEM                   Microsoft OneNote Quick... Microsoft Corporation
OUTLOOK                    Microsoft Outlook          Microsoft Corporation
powershell                 Windows PowerShell         Microsoft Corporation
prevhost                   Preview Handler Surroga... Microsoft Corporation
RDCMan                     RDCMan                     Microsoft Corporation
SearchProtocolHost         Microsoft Windows Searc... Microsoft Corporation
taskhost                   Windows 任务的主机进程     Microsoft Corporation
```

#### 使用别名

因为`Where-Object`的使用概率比较高，所以有一个很形象的别名`？`可以使用：

```powershell
PS C:Powershell> Get-Service | ? {$_.Name -like "B*"}

Status   Name               DisplayName
------   ----               -----------
Running  BDESVC             BitLocker Drive Encryption Service
Running  BFE                Base Filtering Engine
Running  BITS               Background Intelligent Transfer Ser...
Stopped  Browser            Computer Browser
Stopped  bthserv            Bluetooth Support Service
```

#### example

`Where-Object`

Selects objects from a collection based on their property values.

These commands get a list of all services that are currently stopped.  
The `$_` automatic variable represents each object that is passed to the `Where-Object` cmdlet.  
The first command uses the **script block** format, the second command uses the **comparison statement** format.

The commands are equivalent and can be used interchangeably.

```powershell
Get-Service | Where-Object {$_.Status -eq "Stopped"}
Get-Service | where Status -eq "Stopped"
```

***
`-Like`

Indicates that this cmdlet gets objects if the property value matches a value that **includes wildcard characters**.

For example: `Get-Process | where ProcessName -Like "*host"`
***

### Powershell IF-ELSEIF-ELSE 条件

`Where-Object` 进行条件判断很方便，如果在判断后执行很多代码可以使用`IF-ELSEIF-ELSE`语句。语句模板：

```powershell
If（条件满足）{
如果条件满足就执行代码
}
Else
{
如果条件不满足
}
```

条件判断必须放在圆括号中，执行的代码必须紧跟在后面的花括号中。

```powershell
PS C:Powershell> $n=8
PS C:Powershell> if($n -gt 15) {"$n  大于 15 " }
PS C:Powershell> if($n -gt 5) {"$n  大于 5 " }
8  大于 5
PS C:Powershell> if($n -lt 0 ){"-1" } elseif($n -eq 0){"0"} else {"1"}
1
```

### Powershell Switch 条件

如果语句中有多路分支，使用`IF-ELSEIF-ELSE`不友好，可以使用`Switch`，看起来比较清爽一点。
下面的例子将`If-ElseIF-Else`转换成`Switch`语句

```powershell
#使用 IF-ElseIF-Else
If( $value -eq 1 )
{
    "Beijing"
}
Elseif( $value -eq 2)
{
    "Shanghai"
}
Elseif( $value -eq 3 )
{
    "Tianjin"
}
Else
{
    "Chongqing"
}

#使用 Switch
switch($value)
{
    1 {"Beijing"}
    2 {"Shanghai"}
    3 {"Tianjin"}
    4 {"Chongqing"}
}
```

#### 测试取值范围

使用 `Switch`时缺省的比较运算符为 `-eq` 等于，你也可以自己定制比较条件，  
将条件放在花括号中, 必须保证条件表达式的返回值为布尔类型”`$True`”或”`$False`”

```powershell
$value=18
# 使用 Switch 测试取值范围
switch($value)
{
    {$_ -lt 10} {"小于10"}
    10  {"等于10"}
    {$_  -gt 10} {"大于10"}
}
#输出
#大于10
```

#### 没有匹配条件

在`IF-Else`语句中如果没有合适的条件匹配，可以在`Else`中进行处理，
同样在`Switch`语句中如果`case`中没有条件匹配，可以使用关键字`Default`进行处理。
同样是上面的例子，稍加修改：

```powershell
$value=-7
# 使用 Switch 测试取值范围
switch($value)
{
    {($_ -lt 10) -and ( $_ -gt 0) }  {"小于10"}
    10  {"等于10"}
    {$_  -gt 10} {"大于10"}
    Default {"没有匹配条件"}
}
#Output:
#没有匹配条件
```

#### 多个条件匹配

如果`case`中有多个条件匹配，那么每个匹配的条件都会进行处理，例如：

```powershell
$value=2
# 使用 Switch 测试取值范围
switch($value)
{
    {$_ -lt 5 }  { "小于5" }
    {$_ -gt 0 }   { "大于0" }
    {$_ -lt 100}{ "小于100"}
    Default {"没有匹配条件"}
}
 
#小于5
#大于0
#小于100
```

如果碰到匹配条件时只处理一次，可以使用`Break`关键字

```powershell
$value=99
# 使用 Switch 测试取值范围
switch($value)
{
    {$_ -lt 5 }   { "小于5"; break}
    {$_ -gt 0 }   { "大于0"; break}
    {$_ -lt 100}  { "小于100"; break}
    Default {"没有匹配条件"}
}
 
#大于0
```

#### 比较字符串

之前的条件比较的都是数字，接下来比较字符串，默认的条件判断为`-eq`，  
我们知道在`Powershell`中字符串的使用`-eq`比较大小写不敏感，所以才有下面的例子：
	
```powershell
$domain="www.mossfly.com"
switch($domain)
{
    "Www.moSSfly.com" {"Ok 1"}
    "www.MOSSFLY.com" {"Ok 2" }
    "WWW.mossfly.COM" {"Ok 3"}
}
Ok 1
Ok 2
Ok 3
```


大小写敏感

怎样在比较字符串时能够恢复为大小写敏感模式?  
`Switch`有一个`-case`选项，一旦指定了这个选项，比较运算符就会从`-eq` 切换到`-ceq`，即大小写敏感比较字符串:

```powershell
$domain="www.mossfly.com"
#大小写敏感
switch -case ($domain)
{
    "Www.moSSfly.com" {"Ok 1"}
    "www.MOSSFLY.com" {"Ok 2" }
    "www.mossfly.com" {"Ok 3"}
}
#Ok 3
```

#### 使用通配符

字符串非常特殊，需要使用通配符，幸运的是`Powershell`也支持，果然`Power`啊。  
但是在Switch语句后要指定 `-wildcard` 选项

	
```powershell
$domain="www.mossfly.com"
#使用通配符
switch -wildcard($domain)
{
    "*"     {"匹配'*'"}
    "*.com" {"匹配*.com" }
    "*.*.*" {"匹配*.*.*"}
}
匹配'*'
匹配*.com
匹配*.*.*
```

在字符串匹配中，比通配符功能更强大是正则表达式，`Powershell`的`Switch`语句也支持，真是太棒了。  
当然需要给`Switch`关键字指定选项`-regex`

```powershell
$mail="www@mossfly.com"
#使用通配符
switch -regex ($mail)
{
    "^www"     {"www打头"}
    "com$"     {"com结尾" }
    "d{1,3}.d{1,3}.d{1,3}.d{1,3}" {"IP地址"}
}

#www打头
#com结尾
```

#### 同时处理多个值

`Switch`支持对集合所有元素进行匹配,下面的例子使用`Powershell Switch`语句演示打印水仙花数：

```powershell
$value=100..999
switch($value)
{
{[Math]::Pow($_%10,3)+[Math]::Pow( [Math]::Truncate($_%100/10) ,3)+[Math]::Pow( [Math]::Truncate($_/100) , 3) -eq $_} {$_}
}

#153
#370
#371
#407
```

## section Powershell循环

### Powershell ForEach-Object 循环

`Powershell`管道就像流水线，对于数据的处理是一个环节接着一个环节，  
如果你想在某一环节对流进来的数据逐个细致化的处理，可是使用`ForEach-Object`，  
`$_`代表当前的数据。

#### 对管道对象逐个处理

如果使用`Get-WmiObject`获取系统中的服务，为了排版可能会也会使用`Format-Table`对结果进行表格排版。

```powershell
PS C:Powershell> Get-WmiObject Win32_Service | Format-Table status,DisplayName -AutoSize

status DisplayName
------ -----------
OK     Adobe Acrobat Update Service
OK     Application Experience
...
```

但是如果想对每个服务进行更定制化的处理可以使用`ForEach-Object`

```powershell
PS C:Powershell> Get-WmiObject Win32_Service | ForEach-Object {"Name:"+ $_.Disp
layName, ", Is ProcessId more than 100:" + ($_.ProcessId -gt 100)}
Name:Adobe Acrobat Update Service , Is ProcessId more than 100:True
Name:Application Experience , Is ProcessId more than 100:False
Name:Application Layer Gateway Service , Is ProcessId more than 100:False
```

#### 结合条件处理

`ForEach-Object`的处理可以包含任意`Powershell`脚本，当然也包括条件语句
	
```powershell
Get-WmiObject Win32_Service | ForEach-Object {
    if ($_.ProcessId -gt 3000)
    { "{0}({1})" -f $_.DisplayName,$_.ProcessID}
}

Windows Presentation Foundation Font Cache 3.0.0.0(5408)
Microsoft Network Inspection(5260)
BranchCache(4112)
Windows Modules Installer(7656)
```

#### 调用方法

在`ForEach-Object`中，`$_`代表当前对象，当然也允许通过`$_`,调用该对象支持的方法。  
下面的例子杀死所有IE浏览器进程：

```powershell
PS C:Powershell> Get-Process iexplore

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    883      29    14728      22432   181    34.26   4300 iexplore
    771      28    55552     129152   425     8.56   5732 iexplore
...

PS C:Powershell> Get-Process iexplore | ForEach-Object {$_.kill()}
PS C:Powershell> Get-Process iexplore
```

### Powershell Foreach 循环

`Foreach-object` 为`cmdlet`命令，使用在管道中，对管道结果逐个处理，  
`foreach`为遍历集合的关键字。

下面举两个例子：
	
```powershell
$array=7..10
foreach ($n in $array)
{
    $n*$n
}
 
#49
#64
#81
#100
 
foreach($file in dir c:\windows)
{
    if($file.Length -gt 1mb)
    {
        $File.Name
    }
}
 
#explorer.exe
#WindowsUpdate.log
```

这里只为了演示foreach，其实上面的第二个例子可以用`Foreach-Object`更简洁。

```powershell
PS C:\Powershell> dir C:\Windows | where {$_.length -gt 1mb} |foreach-object {$_.Name}
explorer.exe
WindowsUpdate.log
```

### Powershell Do While 循环

`Do`和`While`可能产生死循环，为了防止死循环的发生，你必须确切的指定循环终止的条件。  
指定了循环终止的条件后，一旦条件不满足就会退出循环。

#### 继续与终止循环的条件

`do-while()`会先执行再去判断，能保证循环至少执行一次。

```powershell
PS C:Powershell> do { $n=Read-Host } while( $n -ne 0)
10
100
99
2012
世界末日
为什么不退出
因为条件不满足
怎样才能满足
请输入一个0，试一试
0
PS C:Powershell>
```

#### 单独使用While

```powershell
$n=5
while($n -gt 0)
{
    $n
    $n=$n-1
}
5
4
3
2
1
```

#### 终止当前循环

使用`continue`关键字，可以终止当前循环，跳过`continue`后其它语句，重新下一次循环。

```powershell
$n=1
while($n -lt 6)
{
    if($n -eq 4)
    {
        $n=$n+1
        continue

    }
    else
    {
        $n
    }
    $n=$n+1
}
1
2
3
5
```

#### 跳出循环语句

跳出循环语句使用`break`关键字
	
```powershell
$n=1
while($n -lt 6)
{
    if($n -eq 4)
    {
        break
    }
    $n
    $n++
}
```

### Powershell For 循环

如果你知道循环的确切次数可以使用`For`循环，`For`循环属于计数型循环，  
一旦达到最大次数，循环就会自动终止。下面的例子通过循环求`1-100`的数列和。

```powershell
$sum=0
for($i=1;$i -le 100;$i++)
{
    $sum+=$i
}
$sum
```

#### For循环是特殊类型的While循环

在`For`循环开始的圆括号中，由分号隔开的语句为循环的控制条件，  
分别为：初始化，循环执行满足的条件，增量。

For循环的控制语句第一个和第三个可以为空：

```powershell
$sum=0
$i=1
for(;$i -le 100;)
{
    $sum+=$i
    $i++
}
$sum
```

#### For循环的特殊应用

上面的`For`循环示例停留在数字层面上，其实`While`循环能办到的事，`For`循环也可以，  
只是可能有时不方便而已。例如判断域名的例子：

```powershell
for($domain="";!($domain -like "www.*.*");$domain=Read-Host "Input domain")
{
    Write-Host -ForegroundColor "Green" "Please give a valid domain name."
}
Please give a valid domain name.
Input domain: www
Please give a valid domain name.
Input domain: mossfly.com
Please give a valid domain name.
```





## section Powershell函数

## section Powershell脚本

## section Powershell错误处理

## section Powershell命令发现和脚本块

## section Powershell文本和正则表达式

## section PowerShell处理XML

## section PowerShell文件系统

## section PowerShell注册表