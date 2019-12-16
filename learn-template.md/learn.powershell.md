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

## Powershell管道和重定向

### 管道

即把上一条命令的输出作为下一条命令的输入。

例如通过`ls`获取当前目录的所有文件信息，  
然后通过`·`Sort -Descending`·`对文件信息按照`Name`降序排列，  
最后将排序好的文件的`Name`和`Mode`格式化成`Table`输出。

`ls | sort -Descending Name | Format-Table Name,Mode`

### 重定向

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

## Powershell 进行数学运算

我们可以把`powershell`当成一个计算器。  
像键入命令行那样输入数学表达式，回车，`powershell`会自动计算并把结果输出。  
常用的加减乘除模 `+,-,*,/,%` 运算和小括号表达式都支持。

`PowerShell`也能自动识别计算机容量单位, 包括`KB，MB，GB，TB，PB`

## Powershell 执行外部命令

Powershell 能够像CMD一样很好的执行外部命令。

### 通过`netstat`查看网络端口状态

### 通过`IPConfig`查看自己的网络配置

### `route print`查看路由信息

### 启动CMD控制台

启动`CMD`控制台键入`cmd`或者`cmd.exe`,退出`cmd`可以通过命令`exit`。

### 查找可用的`Cmd`控制台命令

`Cmd.exe` 通过 `/c` 来接收命令参数，在`Cmd`中`help`可以查看可用的命令，  
所以可以通过`Cmd /c help` 查找可用的Cmd控制台命令

### 启动外部程序

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

## Powershell 命令集 cmdlets

`cmdlets`是`Powershell`的内部命令，`cmdlet`的类型名为`System.Management.Automation.CmdletInfo`，包含下列属性和方法：

下面是全部的`Cmdlets`命令

每个命令有一个动词和名词组成，命令的作用一目了然。

[Powershell 命令集][]

[Powershell 命令集]: https://www.pstips.net/powershell-cmdlets.html

## Powershell 别名

`cmdlet`的名称由一个动词和一个名词组成，其功能对用户来讲一目了然。  
但是对于一个经常使用`powershell`命令的人每天敲那么多命令也很麻烦啊。  
能不能把命令缩短一点呢？于是“**别名**”就应运而生了。`Powershell`内部也实现了很多常用命令的别名。  
例如`Get-ChildItem`，列出当前的子文件或目录。它有两个别名：`ls` 和 `dir`，这两个别名来源于`unix` 的`shell`和`windows`的`cmd`。

因此别名有两个作用：

1. 继承：继承unix-shell和windows-cmd。
2. 方便：方便用户使用。

### 处理别名

查询别名所指的真实`cmdlet`命令。

```powershell
PS C:\PS> Get-Alias -name ls
```

### 查看可用的别名

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

### 创建自己的别名

给记事本创建一个别名，并查看该别名；

```powershell
PS C:\PS> Set-Alias -Name Edit -Value notepad
PS C:\PS> Edit
PS C:\PS> $alias:Edit
notepad
```

### 删除自己的别名

别名不用删除，自定义的别名在`powershell`退出时会自动清除。但是请放心，`powershell`内置别名（诸如`ls,dir,fl`等）不会清除。如果你非得手工删除别名。请使用

```powershell
PS C:\PS> del alias:Edit
```

### 保存自己的别名

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

## Powershell 通过函数扩展别名

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

## Powershell 执行文件和脚本

像运行可执行文件一样，`Powershell`运行文件和脚本，  
也必须使用绝对路径或者相对路径，或者要运行的文件必须定义在可受信任的环境变量中。

### 关于脚本

脚本和批处理都属于伪可执行文件，它们只是包含了若干命令行解释器能够解释和执行的命令行代码。

### 执行批处理文件

批处理是扩展名为”`.bat`”的文本文件，它可以包含任何`cmd`控制台能够处理的命令。  
当批处理文件被打开，`Cmd`控制台会逐行执行每条命令。那`Powershell`能够直接执行批处理吗？  
将下列命令保存为`ping.bat`

```powershell
@echo off
echo batch File Test
pause
Dir %windir%/system
```
`
然后执行`
屏幕会打印`命令帮助，说明调用的` 而不是`。
改为：

PS C:\PS> ./ping

这时运行的是批处理。

通过`进入`控制台输入发现执行的不是命令，而是直接运行`ping.bat` ，  
也就是说可以通过`.bat` 覆盖`cmd`命令。  
这种机制很危险，如果有人侵入电脑，并将系统内部命令篡改成自己批处理，那就太悲剧了。  
这种命令与脚本的混淆不会发生在`powershell`中，因为`powershell`有更安全的机制。


