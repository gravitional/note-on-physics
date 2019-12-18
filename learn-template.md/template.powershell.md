# template.powershell.md

## powershell concepts

与大多数 `Shell`（它们接受和返回文本）不同，`Windows PowerShell` 是在 `.NET Framework` 公共语言运行时 (`CLR`) 和`.NET Framework` 的基础上生成的，它将接受和返回 `.NET Framework` 对像。

一切皆对象

Get-Command 获取所有可用命令
ls alias: 获取所有别名
ls function: 获取所有已命名函数
ls variable: 查看所有已定义的变量
env:windir 驱动器变量

### Get-Command

## pwsh特殊运算符

`&`运算符将它后面的命令设置为后台运行，当运行的命令需要阻塞当前终端的时候很有用。

`.\`运算符用于执行一个脚本或命令。
如果执行的是`Powershell`脚本，那么脚本会在自己的作用域中执行，
也就是说在当前环境下无法访问被执行的脚本中的变量。

`[]`运算符用于转换变量的类型，比如说下面的代码，就将`pi`变量转换为了`Float`类型。

```powershell
[Float]$pi = 3.14
$pi -is [Float]
```

`.`运算符用于调用`.NET`对象的成员，它也可以用于执行脚本。
当它用于执行脚本的时候，脚本会在当前作用域中执行。
所以脚本结束之后，我们可以访问脚本中的元素。

`::`运算符用于调用**类**中的**静态成员**，例如下面就会调用`.NET`平台中`DateTime`类的`Now`属性。

```powershell
PS D:\Desktop> [DateTime]::Now

2017年5月18日 22:45:42
```

`..`运算符用于创建一个范围闭区间，例如下面这样。

```powershell
PS D:\Desktop> 1..3
1
2
3
PS D:\Desktop> 3..1
3
2
1
```

`-f`运算符用于格式化数据，例如下面这样。
格式化方法和`C#`中的完全相同，所以如果不熟悉的话直接看在`C#`中如何格式化数据就行了。

```powershell
PS D:\Desktop> 'My name is {0}， I am {1} years old' -f 'yitian',24
My name is yitian， I am 24 years old
```

`$`运算符可以将字符串内部的变量转换为实际的值，例如下面这样。
需要注意使用内插操作符的时候，外部字符串需要使用双引号，否则`Powershell`会直接输出字符串内容。

```powershell
PS D:\Desktop> $name='yitian'
PS D:\Desktop> $age=24
PS D:\Desktop> "My name is $name, I am $age years old."
My name is yitian, I am 24 years old.
```

`@()`运算符用于将一系列值转换为一个数组。
假如在脚本中有一个函数可能返回`0、1或多个值`，就可以使用这个操作符，
将一系列值合并为一个数组，方便后续处理。

`,`逗号运算符如果放置在单个值前面，就会创建一个包含这个值的单元素数组。

## Powershell another parts

### Powershell 任意键退出

`Powershell`控制台退出,推荐3种方法：

+ 直接鼠标关闭窗口
+ 输入命令`exit` 退出
+ `Stop-Process -Id $pid` 退出

但是有时需要向用户提示并退出，推荐`2`种方法：

#### 使用read-host和exit命令

```powershell
"Any key to exit"  ;
 Read-Host | Out-Null ;
Exit
```

缺点：只有输入回车后才能退出控制台。

#### 使用C#中的readkey方法

```powershell
"Any key to exit." ;
[Console]::Readkey() |　Out-Null ;
Exit ;
```

这些命令都可以写在同一行，使用分号隔开。

除了`Ctrl`，`Alt`， `Shift` 等键，其它基本都可以识别并退出控制台.

### 短斜杠

在`Powershell`中短斜杠是个特殊字符，如果一个函数名中包含了特殊字符就应当把它放在花括号中。

### Powershell缩短文件路径

将很长的文件路径缩短，并且在`powershell`和`windows`中能够识别。下面有一个函数：

```powershell
function Get-ShortPath($Path)
{
    $code = @'
    [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError=true)]
    public static extern uint GetShortPathName(string longPath,
    StringBuilder shortPath,uint bufferSize);
'@
    $API = Add-Type -MemberDefinition $code -Name Path -UsingNamespace System.Text -PassThru
    $shortBuffer = New-Object Text.StringBuilder ($Path.Length * 2)
    $rv = $API::GetShortPathName( $Path, $shortBuffer, $shortBuffer.Capacity )
    if ($rv -ne 0)
    {
        $shortBuffer.ToString()
    }
    else
    {
        Write-Warning "Path '$path' not found."
    }
}
#测试

PS C:mossfly> md "Powershell 缩短文件路径缩短文件路径缩短文件路径缩短文件路径缩短文件路径"

    目录: C:mossfly

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         2012/3/30     23:10      Powershell 缩短文件路径缩短文件路径缩短文件路径缩短文件路径缩短文件路径

PS C:mossfly> Get-ShortPath "Powershell 缩短文件路径缩短文件路径缩短文件路径缩短文件路径缩短
文件路径" POWERS~1
PS C:mossfly> Test-Path POWERS~1
True
PS C:mossfly> cd POWERS~1
PS C:mossflyPowershell 缩短文件路径缩短文件路径缩短文件路径缩短文件路径缩短文件路径>
```

### Powershell获取星期和月份

```powershell
PS C:> [Enum]::GetNames([DayOfWeek])

PS C:> [Globalization.DatetimeFormatInfo]::CurrentInfo.MonthNames
```

### Powershell 朗读文本

通过`.net`对象`System.Speech.Synthesis.SpeechSynthesizer`
可以朗读文本，可以调节朗读的语速和音量，还可以将文本转换成音频。

```powershell
# 添加 System.speech.dll 引用
Add-Type -AssemblyName System.speech
# 创建 SpeechSynthesizer 对象
$syn=New-Object System.Speech.Synthesis.SpeechSynthesizer
$syn.Speak("飞苔博客")
 
#设置朗读的语速
$syn.Rate=-5
$syn.Speak("飞苔博客")
 
#设置朗读的音量
$syn.Volume=80
$syn.Speak("飞苔博客")
 
#将文本转换成音频
$syn.SetOutputToWaveFile("e:a.wav")
$syn.Speak("飞苔博客")
```


## 在变量中存储结果

不要将结果在控制台输出可以防止对象转换成文本。
控制台是一个不安全的地方，任何对象输出后都会自动转换成文本，最安全的方式是将对象保存在变量中。
如果想将对象输出为文本，可以在控制台输入变量名。

```powershell
PS C:Powershell> $FileList=dir
PS C:Powershell> $FileList
```
### 查看变量类型

(10).gettype().name

### 作用域

+ `$global` 全局变量，在所有的作用域中有效，如果你在脚本或者函数中设置了全局变量，即使脚本和函数都运行结束，这个变量也任然有效。

+ `$script` 脚本变量，只会在脚本内部有效，包括脚本中的函数，一旦脚本运行结束，这个变量就会被回收。

+ `$private` 私有变量，只会在当前作用域有效，不能贯穿到其他作用域。

+ `$local` 默认变量，可以省略修饰符，在当前作用域有效，其它作用域只对它有只读权限。

打开`Powershell`控制台后，`Powershell`会自动生成一个新的**全局作用域**。
如果增加了函数和脚本，或者特殊的定义，才会生成其它作用域。
在当前控制台，只存在一个作用域，通过修饰符访问，其实访问的是同一个变量：

## 查看类and属性

### 发现命令

如果你想查看关于 `LS` 命令的信息，请把它传递给 `Get-Command` 。

```powershell
PS C:> Get-command LS
```

### 查看已命名的函数

`Powershell`已经提供了许多用户能够使用的预定义函数，
这些函数可以通过`Function:PSDrive`虚拟驱动器查看。

```powershell
ls function:
```

### 类型的完整名称

`Powershell` 将信息存储在对象中，每个对象都会有一个具体的类型，
任何`.NET`对象都可以通过`GetType()`方法返回它的类型，
该类型中有一个`FullName`属性，可以查看类型的完整名称

```powershell
PS C:Powershell> $Host.Version.GetType().FullName
System.Version
PS C:Powershell> $Host.Version.Build
-1
```

### 类型的静态方法

每一个类型都可以包含一些静态的方法，可以通过方括号和类型名称得到**类型对象本身**，
然后通过`Get-Memeber`命令查看该类型支持的所有静态方法。

```powershell
PS C:Powershell> [System.DateTime] | Get-Member -static -memberType *Method
```

### 创建某一类型

```powershell
PS C:Powershell> [System.Version]'2012.12.20.4444'

Major  Minor  Build  Revision
-----  -----  -----  --------
2012   12     20     4444
```

### 通过 New-Object 创建新对象

查看`String`类的构造函数
```powershell
PS C:Powershell> [String].GetConstructors() | foreach {$_.tostring()}
```


### 查看某一对象的属性

```powershell
PS C:Powershell> $Host.UI |  Get-Member WriteDebugLine
```

可以使用`Get-Member`得到一个对象所有的属性：

```powershell
PS C:Powershell> $obj=(dir)[0]
PS C:Powershell> $obj | Get-Member -MemberType Property
```

### 查看某个类所有的名称

脚本执行策略类型为：`Microsoft.PowerShell.ExecutionPolicy`
查看所有支持的执行策略：

```powershell
PS E:> [System.Enum]::GetNames([Microsoft.PowerShell.ExecutionPolicy])
```

### 删除函数

```powershell
del Function:Get-Command
```



## PowerShell转义通配符

当你使用`–like`操纵符，它支持`3`个通配符，
”`*`“代表任意个数的字符，”`?`“代表一个字符，“`[a-z]`”代表一个字符列表。
然而`PowerShell`中转义字符“`”（反引号）很少有人知道，它可以转义通配符。

所以，当你想验证“`*`”是否在某个字符串中，你可能会写成这样，实际上这样恰恰错了。

```powershell
'*abc' -like '*abc'
```

之所以错，是因为下面的字符串也会被匹配返回`true`：

```powershell
'xyzabc' -like '*abc'
```

因此如果要验证 “`*`”，一定得保证它不是通配符，此时就需要转义字符：

```powershell
PS> '*abc' -like '`*abc'
True
```

```powershell
PS> 'xyzabc' -like '`*abc'
False
```

当你想匹配反引号时，同样也需要转义字符

```powershell
# 错误:
PS> "xyzabc" -like "`*abc"
True

# 正确:
PS> "xyzabc" -like "``*abc"
False

PS> "*abc" -like "``*abc"
True
```

## .net

`.NET`中的类型定义在不同的程序集中，首先得知道当前程序已经加载了那些程序集。

`AppDomain`类的静态成员`CurrentDomain`，有一个`GetAssemblies()`方法。

```powershell
PS C:Powershell> [AppDomain]::CurrentDomain.GetAssemblies()
```

### 搜索指定类型

查询每个程序集中的方法可使用 `GetExportedTypes()` 方法。
因为许多程序集中包含了大量的方法，在搜索时最好指定关键字。

```powershell
PS C:Powershell> [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { -not $_.IsDynamic } | ForEach-Object {$_.GetExportedTypes() } | Where-Object { $_ -like '*environment*' } | ForEach-Object { $_.FullName }

System.EnvironmentVariableTarget
System.Environment
...
```

## 筛选管道结果中的对象

如果你只对管道结果的特定对象感兴趣，可以使用`Where-Object`对每个结果进行严格筛选，
一旦满足你的标准才会保留，不满足标准的就会自动丢弃。

```powershell
PS C:Powershell> get-service | Where-Object {$_.Status -eq "Running"}
```

### -Contains

Indicates that this cmdlet gets objects if any item in the property value of the object is an exact match for the specified value.

For example: 

```powershell
Get-Process | where ProcessName -Contains "Svchost"
```

**note**
The first command uses the comparison statement format.
In this command, no aliases are used and all parameters include the parameter name.

The second command is the more natural use of the comparison command format.
The where alias is substituted for the Where-Object cmdlet name and all optional parameter names are omitted.

```PowerShell
Get-Process | Where-Object -Property Handles -GE -Value 1000
Get-Process | where Handles -GE 1000
```

### -Like

Indicates that this cmdlet gets objects if the property value matches a value that includes wildcard characters.

For example: 

```powershell
Get-Process | where ProcessName -Like "*host"
```