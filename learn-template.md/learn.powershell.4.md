# learn.powershell.4.md

For myself and for you

[收集和分享 Windows PowerShell 相关教程,技术和最新动态][]
版权归原作者所有

[收集和分享 Windows PowerShell 相关教程,技术和最新动态]: https://www.pstips.net/

## 命令发现和脚本块

### Powershell 发现命令

从用户的角度来看，在`Powershell`控制台上输入一条命令，然后直接回车执行，是一件简单的事情，
事实上`Powershell`在后台做了很多事情，
其中第一步，就是查看用户输入的命令是否可用,这个步骤也被称作自动化发现命令。
使用`Get-Command`命令可以查看当前作用域支持的所有命令。
如果你想查看关于 `LS` 命令的信息，请把它传递给 `Get-Command` 。

```powershell
PS C:> Get-command LS

CommandType Name Definition
----------- ---- ----------
Alias       ls   Get-ChildItem
```

如果你想查看更加详细的信息可以使用：

```powershell
PS C:> Get-Command ls | fl *
HelpUri             : http://go.microsoft.com/fwlink/?LinkID=113308
ResolvedCommandName : Get-ChildItem
```

如果你想查看命令`IPConfig`的命令信息，可以使用：

```powershell
PS C:> get-command ipconfig

CommandType Name         Definition
----------- ----         ----------
Application ipconfig.exe C:windowsSYSTEM32ipconfig.exe
```

事实上，`Get-Command` 返回的是一个对象`CommandInfo`，`ApplicationInfo`，`FunctionInfo`，或者`CmdletInfo`；

```powershell
PS C:> $info = Get-Command ping
PS C:> $info.GetType().fullname
System.Management.Automation.ApplicationInfo
PS C:> $info = Get-Command ls
PS C:> $info.GetType().fullname
System.Management.Automation.AliasInfo
PS C:> $info = Get-Command Get-Command
PS C:> $info.GetType().fullname
System.Management.Automation.CmdletInfo
PS C:> $info=Get-Command more | select -First 1
PS C:> $info.GetType().fullname
System.Management.Automation.FunctionInfo
```

如果一条命令可能指向两个实体，`get-command`也会返回，例如`more`。

```powershell
PS C:> Get-Command more

CommandType Name     Definition
----------- ----     ----------
Function    more     param([string[]]$paths)...
Application more.com C:windowsSYSTEM32more.com
```

这两条命令，前者是`Powershell`的自定义函数，后者是扩展的`Application`命令。

细心的读者可能会提问，这两个会不会发生冲突。当然不会，默认会调用第一个，
是不是仅仅因为它排在第一个，不是，而是在`Powershell`中有一个机制，就是函数永远处在最高的优先级。
不信，看看下面的例子，
通过函数可以重写`ipconfig`，一旦删除该函数，原始的`ipconfig`才会重新登上历史的舞台：

```powershell
PS C:> function Get-Command () {}
PS C:> Get-Command
PS C:> del Function:Get-Command
PS C:> ipconfnig
PS C:> ipconfig.exe

Windows IP 配置

无线局域网适配器 无线网络连接 3:

   媒体状态  . . . . . . . . . . . . : 媒体已断开
   连接特定的 DNS 后缀 . . . . . . . :
...
```

### Powershell 调用操作符

调用操作符“`&`”虽然简短，但是给我们执行`Powershell`命令提供了很大的方便。
如果你之前将`Powershell`命令存储在了一个字符串中，或者一个变量中。
此时，调用操作符就可以将字符串直接解释成命令并执行，
如果在`Powershell`控制台中，你只须要输入即可。
具体，如下：

```powershell
#将命令存储在变量中:
$command = "Dir"
# 如果直接输出变量，字符串原样输出。
$command

#Dir

#如果使用调用操作符"&"
& $command

    目录: E:

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----          2012/5/9      0:42            Blog
...
```

#### 调用操作符只能接受单个命令

但是调用操作符不能接受全部的`Powershell`脚本或命令，只能接受单个的一条命令，例如使用：

```powershell
$command = "Dir $env:windir"
& $command

无法将“Dir C:windows”项识别为 cmdlet、函数、脚本文件或可运行程序的名称...
```

为什么会这样呢？
追根溯源，`Powershell`中的调用符，首先会使用`get-command`去发现命令是否可用，
而`get-command`的确只支持单独的一条命令，不支持命令串或者脚本串。

#### 调用操作符执行`CommandInfo`对象

调用操作符初始化时会将指定的文本传递给`get-command`，然后由`get-command`去检索命令，
事实上，调用操作符甚至可以直接执行一个`CommandInfo`对象，绕过自身的内部`get-command`，例如：

```powershell
PS E:> $command=Get-Command tasklist
PS E:> $command

CommandType     Name
-----------     ----
Application     tasklist.exe

PS E:> & $command

映像名称                       PID 会话名              会话#       内存使用
========================= ======== ================ =========== ============
System Idle Process              0 Services                   0         24 K
System                           4 Services                   0        560 K
```

#### 通过命令名称唯一标识一条命令

可能存在别名，命令，函数的的名称，
那Powershell会不会纠结到底执行哪个呢？当然不会，因为它们之间是有一个优先级的。
从高到底，依次为：

1. Alias（1）
1. Function（2）
1. Filter（2）
1. Cmdlet（3）
1. Application（4）
1. ExternalScript（5）
1. Script （-）

下面举个例子：

```powershell
PS E:> function Ping(){"我是Ping函数"}
PS E:> Set-Alias -Name Ping -Value echo

CommandType Name     Definition
----------- ----     ----------
Alias       Ping     echo
Function    Ping     param()...
Application PING.EXE C:windowsSYSTEM32PING.EXE

PS E:> ping "测试我的Ping,估计执行的别名echo"
测试我的Ping,估计执行的别名echo

PS E:> del Alias:Ping
PS E:> ping ; #别名已经被删除，估计执行的是函数PING
我是Ping函数

PS E:> del Function:Ping
PS E:> ping baidu.com ; #函数已经被删除，估计执行的是函数ping 程序

正在 Ping baidu.com [220.181.111.85] 具有 32 字节的数据:
...
```

那怎样突破优先级的限制执行指定的命令呢？
方法都是大同小异，通过特定信息过滤到指定的`CommandInfo`对象，然后直接使用我们本篇的调用操作符。
例如当存在如下的命令`Ping`命令

```powershell
CommandType     Name
-----------     ----
Alias           Ping
Function        Ping
Application     PING.EXE
```

我想调用第三个，可以使用：

```powershell
PS E:> $command=Get-Command -Name ping | where {$_.CommandType -eq "Application" }
PS E:> & $command

用法: ping [-t] [-a] [-n count] [-l size] [-f] [-i TTL] [-v TOS]
...
#或者& (Get-Command -Name ping)[2]
```

### Powershell 语句块

脚本块是一种特殊的命令模式。
一个脚本块可以包含许多的 `Powershell`命令和语句。
它通常使用大括号定义。最小最短的脚本块，可能就是一对大括号，中间什么也没有。
可以使用之前的调用操作符“`&`”执行脚本块：

```powershell
PS E:> & {"当前时间:" + (get-date) }
当前时间:08/08/2012 22:30:24
```

#### 将命令行作为整体执行

可能你已经意识到，在`Powershell`中,调用操作符不但可以执行一条单独的命令，还可以执行”命令行”.
最方便的方式就是讲你的命令行放在一个语句块中，作为整体。
在之前的文章中说过，调用操作符只能执行一条命令，
但是借助语句块的这把利器，可以让调用操作符执行，多条Powershell命令，例如：

```powershell
PS E:> & {$files=ls;Write-Host "文件数：" $files.Count }
文件数： 29
```

#### 执行表达式

另外还有一条`Powershell`命令集，Invoke-Expression，
这条命令的逻辑就是将一条字符串传递给调用操作符。例如：

```powershell
PS E:> Invoke-Expression 'Get-Process | Where-Object { $_.Name -like "e*"}'

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    332      29    12280      24264   154     1.40   3236 egui
...
```

这里有一点需要注意，在传递给`invoke-expressio`n的字符串使用了单引号，单引号可以防止变量被替换。
如果上面的命令使用了双引号，会先去解释`$_.name`，但是当前作用域中，`$_.Name` 为`null`，所以结果不是期望的。

#### 管道中的foreach-object语句块

管道中的`foreach-object`本身后面也会带语句块，针对数组中的每一个元素分别传递给语句块处理。
 例如：

```powershell
 Get-Process | ForEach-Object { $_.name }
```

#### 条件和循环中的语句块

在条件语句中，如果条件满足，做一件事，条件不满足做另外一件事，
这一件事或者另外一件事本身应当是一个整体，尽管本身可能包含了许多命令和语句。
所以会把它们放在一个语句块中。

在循环语句中，如果条件满足循环做一件事，这一件事本身，也是一个整体。
这里就不举例了。

#### 函数本身是一个已命名的语句块

为什么把函数和语句块归结在一起呢？请看下面的例子。

```powershell
#定义一个函数
Function SayHello([string]$people="everyone")
{
   write-host "Hello, $people ”
}

#通过函数调用
SayHello "Mosser"
Hello, Mosser

#通过语句块调用

$scriptblocks

param([string]$people="everyone")
write-host "Hello, $people ”

& $scriptblocks
Hello, everyone
```

#### 构建语句块

既然函数只是被命令的语句块，那是不是也可以通过语句块就能实现函数的特性呢？
接下来就验证一下吧。

#### 传递参数给语句块

在函数中可以传递参数：

```powershell
Function SayHello([string]$people="everyone")
{
   write-host "Hello, $people ”
}
```

能否在语句块中也传递参数？

```powershell
& { param($people="everyone") write-host "Hello, $people ” } "Mosser"
Hello, Mosser
```

定义和传递参数一次性完成，有点匿名函数的味道。

`Begin, Process, End` 管道语句块

之前讲过定义函数也可以按照`Begin, Process, End`的结构，这样尤其可以实时处理管道数据。
那能不能也直接通过语句块定义呢？

```powershell
get-process | select -last 5 | & {
begin {
"开始准备环境"
}
process
{
 $_.Name
}
end {
"开始清理环境"
}
}
#输出结果为：
开始准备环境
wlcommsvc
WLIDSVC
WLIDSVCM
WmiPrvSE
XDict
开始清理环境
```

#### 验证变量

函数中的所有变量都是内置的，属于函数定义域。除非你指定给一个全局变量赋值。首先通过函数实现：

```powershell
function Test
{
$value1 = 10
$global:value2 = 20
}
Test
$value1
$value2

20
```

那语句块也支持吗？例如：

```powershell
& { $value1 = 10; $global:value2 = 20 }
$value1
$value2

20
```

通过语句块可以实现函数的3个特性，再一次印证了函数确实是命名的语句块。

### Powershell 执行上下文

`Powershell` 提供了一个非常特别的自动化变量，`$ExecutionContext` 。
这个变量可能会很少碰到，但是理解它的机制，有助于我们理解`Powershell`执行命令和脚本的内部机制。
这个对象主要包含两个属性：`InvokeCommand` 和 `SessionState`.

```powershell
PS E:> $ExecutionContext

Host           : System.Management.Automation.Internal.Host.InternalHost
Events         : System.Management.Automation.PSLocalEventManager
InvokeProvider : System.Management.Automation.ProviderIntrinsics
SessionState   : System.Management.Automation.SessionState
InvokeCommand  : System.Management.Automation.CommandInvocationIntrinsics
```

#### InvokeCommand

到目前为止,我们在`Powershell`控制台中遇到三个比较特殊的字符，
字符串标识`""`，调用操作符 `&`，和脚本块标识`{}`。

|特殊字符 |定义 |内部方法|
|---------|---------|---------|
|`“` |处理字符串中的变量 |`ExpandString()`|
|`&` |执行命令集 |`InvokeScript()`|
|`{}`| 创建一个新的代码块 |`NewScriptBlock()`|

#### 处理变量

每当你在`Powershell`的字符串中放置一个变量，
`Powershell`解释器会自动处理该变量，并将变量替换成变量本身的值或者内容

```powershell
$site = '飞苔博客'
# 双引号中的变量会被自动解析成变量的值:
$text = "我的个人网站 $site"
$text
```

输出:

```powershell
我的个人网站 飞苔博客
```

既然双引号的机制是`ExpandString()`方法,那么也可以自己调用该方法

```powershell
$site = '飞苔博客'
# 双引号中的变量会被自动解析成变量的值:
$text = '我的个人网站 $site'
$text
#通过ExpandString()自动处理字符串中的变量
$executioncontext.InvokeCommand.ExpandString($text)
```

输出:

```powershell
我的个人网站 $site
我的个人网站 飞苔博客
```

#### 创建脚本块

如果将`Powershell`代码放置在花括号中,这样既可以使用调用操作符`&`执行脚本,
也可以将脚本块赋值给一个函数,因为之前的文章中说过,**函数是一个命令的脚本块**.

```powershell
# 创建新的脚本块
$block = {
$write=Get-Process WindowsLiveWriter
"$($write.Name) 占用内存: $($write.WorkingSet/1mb) MB"
}
$block.GetType().Name
& $block

# 使用NewScriptBlock方法创建脚本块:
$blockStr='$write=Get-Process WindowsLiveWriter
"$($write.Name) 占用内存: $($write.WorkingSet/1mb) MB"'
$block = $executioncontext.InvokeCommand.NewScriptBlock($blockStr)
$block.GetType().Name
& $block
```

输出:

```powershell
ScriptBlock
WindowsLiveWriter 占用内存: 150.734375 MB
ScriptBlock
WindowsLiveWriter 占用内存: 150.734375 MB
```

#### 执行命令行

输入的命令行可以通过`InvokeScript()`脚本执行,也可以使用`&`执行,
也可以使用`Invoke-Expression`命令执行

```powershell
$cmd='3*3*3.14'
& { 3*3*3.14}
$executioncontext.InvokeCommand.InvokeScript($cmd)
Invoke-Expression $cmd
```

输出:

```powershell
28.26
28.26
28.26
```

#### SessionState

`SessionState`是一个用来表现`Powershell`环境的对象,
你同样可以通过自动化变量`$ExecutionContext`访问这些信息.

```powershell
PS E:> $executioncontext.SessionState | Format-List *

Drive                         : System.Management.Automation.DriveManagementIntrinsics
Provider                      : 
...
```

`PSVariable`,可以取出和更新`Powershell`中所有的变量.

```powershell
$value = "Test"
# Retrieve variable contents:
$executioncontext.SessionState.PSVariable.GetValue("value")
Test
# Modify variable contents:
$executioncontext.SessionState.PSVariable.Set("value", 100)
$value
100
```

输出:

```powershell
Powershell博客 飞苔博客
Powershell博客 网站http://www.mossfly.com
```

##### 管理驱动器

查看当前驱动器信息

```powershell
PS E:> $executioncontext.SessionState.Drive.Current

Name Used (GB) Free (GB) Provider   Root CurrentLocation
---- --------- --------- --------   ---- ---------------
E         1.67     78.33 FileSystem E:
```

查看所有驱动器信息

```powershell
PS E:> $executioncontext.SessionState.Drive.GetAll() | ft -

Name     Used (GB) Free (GB) Provider    Root
----     --------- --------- --------    ----
WSMan                        WSMan
Alias                        Alias
Env                          Environment
C            44.48     35.52 FileSystem  C:
```

如果你的只想关注特定的驱动器,可以使用下面的方法:

```powershell
PS E:> $executioncontext.SessionState.Drive.GetAllForProvider("FileSystem")

Name Used (GB) Free (GB) Provider   Root CurrentLocation
---- --------- --------- --------   ---- ---------------
C        44.48     35.52 FileSystem C:    Usersbaozhen
```

##### 路径操作

`SessionState`的`Path`包含几个特殊的方法,基本可以覆盖各种常用的路径操作了

|方法 |描述 |对应的命令|
|----- |------ |-----|
|`CurrentLocation` |当前路径 |`Get-Location`|
| `PopLocation()` |获取存储的路径 |`Pop-Location`|
|`PushCurrentLocation()`| 存储路径| |`Push-Location`|
|`SetLocation()` |定位路径 | `Set-Location`|
|`GetResolvedPSPathFromPSPath()` |相对路径转换成绝对路径 | `Resolve-Location`|

## 文件系统