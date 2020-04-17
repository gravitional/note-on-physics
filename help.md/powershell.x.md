# conclusion.powershell.md

## 别名 获取动词/名词

当然，如果想查找特定动词/名词的命令也是可以的。比方说，如果我想查找所有以`Get`开头的命令，可以使用下面的命令。

```powershell
Get-Command -Verb Get
```

相应的，如果我想获取所有名词是`Help`的命令，可以使用下面的命令。

```powershell
Get-Command -Noun Help
```

### 查找 Get-Command 的别名

```powershell
Get-Command -CommandType Alias | where {$_.DisplayName -like -join("*", "Get-Command", "*") }
```

+ select -> Select-Object
+ gcm -> Get-Command

## 命令行历史

我们通常会在`Console`界面中运行多次命令或者命令行，
在`PowerShell`中我们可以使用管理历史记录的命令来管理那些之前使用过的命令行，目前在`PowerShell`中有如下四个管理历史相关的命令。

| Cmdlet (Alias) ||       Description |
| -------------------|  ---------------------- |
| `Get-History` (h)   |   Gets the command history. |
| `Invoke-History` (r) |  Runs a command in the command history. |
| `Add-History`      |   Adds a command to the command history. |
| `Clear-History` (clh) | Deletes commands from the command history. |

如上面的`Description`介绍所描述的那样, 我们如下使用了`Get-History`命令得到如下从我们打开`PowerShell Console`界面开始记录的第一条命令。

 ```powershell
 C:\Users\Administrator> Get-History
 ```

当然，`PowerShell`并不会无止境的记录历史命令，你可以通过使用如下保留自变量来查看系统默认可以记录多少历史命令：

```powershell
PS C:\Users\Administrator> $MaximumHistoryCount
```

你也可以直接给这个变量赋一个阿拉伯数字设置你想设置的上限值，比如我设置为`5`：

```powershell
PS C:\Users\Administrator> $MaximumHistoryCount = 5
PS C:\Users\Administrator> $MaximumHistoryCount
```

当你在用`Get-History`命令查看记录了多少命令的时候你会发现，它只自动截取了最近的`5`行命令

我们可以使用`Invoke-History`或者别名`r` 来调用历史命令：

```powershell
PS C:\Users\Administrator> `Invoke-History -id 51`
```

好了，大致是这样，非常简单的几个命令，对了你还可以用`Add-History`添加命令或用`Clear-History`来清除之前的命令行。

[itanders-command-history][]

[itanders-command-history]: https://blog.csdn.net/itanders/article/details/51344419

## 输出到控制台

Module : Microsoft.PowerShell.Utility

Write-Output
Sends the specified objects to the next command in the pipeline.
If the command is the last command in the pipeline, the objects are displayed in the console.

Syntax：

```powershell
Write-Output
     [-InputObject] <PSObject[]>
     [-NoEnumerate]
     [<CommonParameters>]
```

example: Pass output to another cmdlet

```powershell
Write-Output "test output" | Get-Member
```

## Powershell IF-ELSEIF-ELSE 条件

`Where-Object` 进行条件判断很方便，如果在判断后执行很多代码可以使用`IF-ELSEIF-ELSE`语句。语句模板：

```powershell
If（条件满足）{
如果条件满足就执行代码
}
elseif
{
如果条件满足
}
else
{还不满足}
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

## 验证变量是否存在

验证一个变量是否存在，仍然可以像验证文件系统那样，
使用`cmdlet Test-Path`。为什么？因为变量存在变量驱动器中。

```powershell
PS C:\test> Test-Path variable:value1
```

### example --验证文件

 Check whether there are any files besides a specified type

```powershell
Test-Path -Path "C:\CAD\Commercial Buildings\*" -Exclude *.dwg
```

This command checks whether there are any files in the Commercial Buildings directory other than `.dwg` files.

`-Filter`

```powershell
Test-Path (Get-location) -Filter *.bib
```

## Powershell 给脚本传递参数

怎样将参数传递给脚本，这是本篇讨论的内容。

### $args返回所有的参数

传递给一个函数或者一个脚本的参数都保存在`$args`变量中。

默认情况下，传递给一个`Powershell`脚本的参数类型为数组，例如：

```powershell
PS E:> .MyScript.ps1 My Website      Is        www.mossfly.com
Hello,My Website Is www.mossfly.com
```

上面的文本中包含多个连续的空格，可是当脚本把参数输出时却不存在连续的空格了。那是因为脚本会把文本根据白空格截断并转换成数组。
如果不想文本被当成数组那就把它放在引号中。

```powershell
PS E:> ./MyScript.ps1 "My Website      Is        www.mossfly.com"
Hello,My Website      Is        www.mossfly.com
```

### 在$args中逐个访问参数

因为`$args`是一个数组，自然可以通过索引访问数组的每一个元素。
可以将`MyScript.sp1`的内容改为：

```powershell
For($i=0;$i -lt $args.Count; $i++)
{
    Write-Host "parameter $i : $($args[$i])"
}
```

然后在控制台测试：

```powershell
PS E:> .\MyScript.ps1 www moss fly com
parameter 0 : www
...
```

### 在脚本中使用参数名

通过`Powershell`传递参数固然方便，但是如果用户不知道参数的传递顺序，也是很郁闷的.
所以最好的方式给参数指定名称，输入以下的脚本：

```powershell
param($Directory,$FileName)

"Directory= $Directory"
"FileName=$FileName"
```

其中`param`给参数指定名称。

执行脚本：

```powershell
PS E:> .\MyScript.ps1 -Directory $env:windir -FileName config.xml
Directory= C:windows
FileName=config.xml
PS E:> .\MyScript.ps1 -FileName config.xml -Directory $env:windir
Directory= C:windows
FileName=config.xml
```

## 字符串转命令

### 将命令行作为整体执行

在`Powershell`中,调用操作符不但可以执行一条单独的命令，还可以执行”命令行”.
最方便的方式就是讲你的命令行放在一个语句块中，作为整体。
在之前的文章中说过，调用操作符只能执行一条命令，但是借助语句块(`{}`)的这把利器，可以让调用操作符执行，多条`Powershell`命令，例如：

```powershell
PS E:> & {$files=ls;Write-Host "文件数：" $files.Count }
文件数： 29
```

#### 执行表达式

另外还有一条`Powershell`命令集，`Invoke-Expression`，这条命令的逻辑就是将一条字符串传递给调用操作符。例如：

```powershell
PS E:> Invoke-Expression 'Get-Process | Where-Object { $_.Name -like "e*"}'
```

#### example --打开所有pdf

&'C:\Program Files\SumatraPDF\SumatraPDF.exe'  (Get-ChildItem | where Name -Like "*.pdf")

## 筛选管道中的对象

通过管道可以过滤某些对象和对象的属性，这个功能很实用，因为很多时候我们并不是对所有的结果感兴趣，可能只会对某些结果感兴趣。

如果要过滤对象可以使用`Where-Object`；
如果要过滤对象的属性，可以使用`Select-Object`；
如果要自定义个性化的过滤效果可以使用`ForEach-Object`。
最后如果想过滤重复的结果，可以使用`Get-Uinque`。

但是可能只关心那些正在运行的服务，这时你就可以通过每个服务的属性`Status`进行过滤。
但是前提条件是你得事先知道待处理的对象拥有哪些属性。
你可以通过`Format-List *`，也可以通过`Get-memeber`。

```powershell
PS C:Powershell> Get-service | Select-Object -First 1 | Format-List *
```

```powershell
PS C:Powershell> get-service | Where-Object {$_.Status -eq "Running"}
```

### 包含 -Contains

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

### 模式 -Like

Indicates that this cmdlet gets objects if the property value matches a value that includes wildcard characters.

For example:

```powershell
Get-Process | where ProcessName -Like "*host"
```

```powershell
Get-Process | where ProcessName -Like "*.pdf"
```

## 查看已存在的对象

### 一切皆对象

与大多数 `Shell`（它们接受和返回文本）不同，`Windows PowerShell` 是在 `.NET Framework` 公共语言运行时 (`CLR`) 和`.NET Framework` 的基础上生成的，它将接受和返回 `.NET Framework` 对象。

每一个`Powershell`命令都会返回一个对象。包括 `comlet` `变量`，`函数`，`字符串`等等，都是对象。

属性可以描述一个对象，对象的属性可以被`Powershell`自动转换成文本，并且输出到控制台。
因此可以通过这种方法查看任何对象，例如`$host`:

```powershell
PS C:Powershell> $host
out:
Name             : ConsoleHost
Version          : 2.0
```

但将对象的属性转换成文本并不安全，最安全的方式是将对象保存在变量中。
如果想将对象输出为文本，可以在控制台输入变量名。

```powershell
PS C:Powershell> $FileList=dir
PS C:Powershell> $FileList
```

### 发现命令 get-command

可以先查看存在哪些已经定义过的`命令`，`函数` etc.

比如，`Powershell`已经提供了许多用户能够使用的预定义函数，
这些函数可以通过`Function:PSDrive` **虚拟驱动器**查看。

```powershell
ls function:
```

其他的类似命令还有：

+ `Get-Command` 获取所有可用命令
+ `ls alias:` 获取所有别名
+ `ls function:` 获取所有已命名函数
+ `ls variable:` 查看所有已定义的变量
+ `env:windir` 驱动器变量

查看某一具体命令的信息，如 `LS` ：

```powershell
PS C:> Get-command LS
```

### 删除函数

```powershell
del Function:Get-Command
```

### 变量的作用域

+ `$global` 全局变量，在所有的作用域中有效，如果你在脚本或者函数中设置了全局变量，即使脚本和函数都运行结束，这个变量也任然有效。

+ `$script` 脚本变量，只会在脚本内部有效，包括脚本中的函数，一旦脚本运行结束，这个变量就会被回收。

+ `$private` 私有变量，只会在当前作用域有效，不能贯穿到其他作用域。

+ `$local` 默认变量，可以省略修饰符，在当前作用域有效，其它作用域只对它有只读权限。

打开`Powershell`控制台后，`Powershell`会自动生成一个新的**全局作用域**。
如果增加了函数和脚本，或者特殊的定义，才会生成其它作用域。

如果在当前控制台，只存在一个作用域，通过修饰符访问，其实访问的是同一个变量。

### 查看对象的所有成员

知道了都存在哪些对象之后，可以查看它们的具体成员。

对象的成员包括**属性**和**方法**，可以使用`Get-Member`返回它们的详细信息，

### 对象的属性

如果只显示属性可以使用参数 `memberType` 为“`Property`”

```powershell
PS C:Powershell> $host | Get-Member -memberType property
```

### 对象的方法

方法定义了一个对象可以做什么事情。
当你把一个对象输出在控制台时，它的属性可能会被转换成可视的文本, 但是它的方法却不可见。
列出一个对象的所有方法可是使用`Get-Member`命令，给“`MemeberType`”参数传入“`Method`”:

```powershell
PS C:Powershell> $Host | Get-Member -MemberType Method
```

### 筛选命令的方法

`Get_` 和 `Set_` 方法

所有名称以”`get_`”打头的方法都是为了给对应的属性返回一个值。
例如”`get_someInfo()`”方法的作用就是返回属性`someInfo`的值，因此可以直接通过属性调用。
类似的像”`set_someinfo`”一样，该方法只是为了给属性`someinfo`赋值，可以直接通过属性赋值调用。

剔除包含下划线的方法可以使用操作符 `-notlike` 和 通配符 `*`

```powershell
PS C:Powershell> $Host.UI.RawUI | Get-Member -me method | where {$_.Name -notlike '*_*'}
```

### 查看方法的详情

从列表中筛选出一个方法，再通过`Get-Member`得到更多的信息。

```powershell
PS C:Powershell> $info=$Host.UI |  Get-Member WriteDebugLine
PS C:Powershell> $info
PS C:Powershell> $info.Definition
```

### conclusion on object

对象=属性+方法

一个对象的属性用来存储数据，反过来这些数据又可以存储其它对象。

每一个类型都可以包含一些静态的方法，可以通过方括号和类型名称得到**类型对象本身**，如

```powershell
[System.Security.AccessControl.FileSystemRights]
```

## 查看对象的原型--类

上面查看的都是已经存在的**对象**，对象一般是由**类**生成的

### 继承

面向对象程序设计中最重要的一个概念是继承。
继承允许我们依据另一个类来定义一个类，这使得创建和维护一个应用程序变得更容易。
这样做，也达到了重用代码功能和提高执行效率的效果。

当创建一个类时，您不需要重新编写新的数据成员和成员函数，只需指定新建的类继承了一个已有的类的成员即可。
这个已有的类称为**基类**，新建的类称为**派生类**。

**继承**代表了 **is a** 关系。
例如，
Mammal is a animal, dog is a mammal, so dog is a animal, etc.

### 类型的简称

由类型下的某个具体对象（实例），查看类型的名称:

```powershell
(10).gettype().name
("aaa").gettype().name
("aaa","sdafsa").gettype().name
```

### 类型的完整名称

`Powershell` 将信息存储在**对象**中，每个对象都会有一个具体的**类型**，
任何`.NET`对象都可以通过`GetType()`方法返回它的类型，
该类型中有一个`FullName`属性，可以查看类型的**完整名称**

```powershell
PS C:Powershell> $Host.Version.GetType().FullName
System.Version
PS C:Powershell> $Host.Version.Build
-1
```

```powershell
($Host.Version.GetType()).GetType().name
```

`($Host.Version.GetType())`的类型为`System.RuntimeType`

### 类型的静态方法

每一个类型都可以包含一些**静态方法**，可以通过方括号和类型名称得到**类型对象本身**，
然后通过`Get-Memeber`命令查看该类型支持的所有静态方法。

```powershell
PS C:Powershell> [System.DateTime] | Get-Member -static -memberType *Method
```

注：
`C++`中，若类的方法前加了`static`关键字，则该方法称为**静态方法**，反之为**实例方法**。
静态方法为类所有，可以通过**对象**来使用，也可以通过**类**来使用。
但一般提倡通过**类**来使用，因为静态方法只要定义了**类**，不必建立类的**实例**就可使用。
静态方法只能调用**静态变量**。

### 查看类的具体属性

```powershell
PS C:Powershell> $Host.UI |  Get-Member WriteDebugLine
```

查看基类

```powershell
[Microsoft.PowerShell.ExecutionPolicy].BaseType
```

### 通过 New-Object 创建某一类型的新对象

查看`String`类的构造函数

```powershell
PS C:Powershell> [String].GetConstructors() | foreach {$_.tostring()}
```

`| foreach {$_.tostring()}` 是为了格式化输出结果

```powershell
PS C:Powershell> New-Object String(‘s’,10)
out:
**********
```

为什么支持上面的**方法**，原因是`String`类中包含一个`Void .ctor(Char, Int32)`构造函数

`.ctor` 是“构造函数”的缩写---`constructor`

### 类型转换

通过类型转换可以替代 New-Object

```powershell
PS C:Powershell> [System.Version]'2012.12.20.4444'

Major  Minor  Build  Revision
-----  -----  -----  --------
2012   12     20     4444
```

### 查看属性的值域

脚本执行策略 类 为：`Microsoft.PowerShell.ExecutionPolicy`

查看所有支持的执行策略：

```powershell
PS E:> [System.Enum]::GetNames([Microsoft.PowerShell.ExecutionPolicy])
```

使用`[System.Enum]`类的`GetNames()`方法，查看`[Microsoft.PowerShell.ExecutionPolicy]`类的值域

### 枚举类型

`Enum 类`:

+ 命名空间: `System`
+ 程序集: `System.Runtime.dll, mscorlib.dll, netstandard.dll`
+ 说明: 为枚举提供基类。
+ `GetNames(Type)`方法: 检索指定枚举中常数名称的数组。

reference : [class Enum][]

[class Enum]: https://docs.microsoft.com/zh-cn/dotnet/api/system.enum?redirectedfrom=MSDN&view=netframework-4.8#definition

An enumeration type (or enum type) is a value type defined by a set of named constants of the underlying integral numeric type.
To define an enumeration type, use the enum keyword and specify the names of enum members:

```C#
enum Season
{
    Spring,
    Summer,
    Autumn,
    Winter
}
```

By default, the associated constant values of enum members are of type int;
they start with zero and increase by one following the definition text order.
You can explicitly specify any other integral numeric type as an underlying type of an enumeration type.
You also can explicitly specify the associated constant values, as the following example shows:

```C#
enum ErrorCode : ushort
{
    None = 0,
    Unknown = 1,
    ConnectionLost = 100,
    OutlierReading = 200
}
```

## .net对象使用

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

## if else

```powershell
If（条件满足）{
如果条件满足就执行代码
}
Else
{
如果条件不满足
}
```

## pwsh特殊运算符

任何编程语言或者脚本语言中的小括号`()`，主要作用都是用来改变默认操作符的运算顺序的，
`PowerShell`也不例外。
比如：

```powershell
PS> 1-3/3
0
PS> (1-3)/3
-0.666666666666667
```

1. `.\` : 执行一个脚本或命令
2. `&` : 将字符串直接解释成命令并执行
3. `[]` : 类型转换
4. `.` : 调用`.NET`对象的成员，或`global`执行脚本(当前作用域中执行)
5. `::` : 调用`.NET`**类**中的**静态成员**
6. `..` : 创建一个范围闭区间
7. `-f` : 格式化数据
8. `$` : 将字符串内部的变量转换为实际的值
9. `@()` : 将一系列值转换为一个数组
10. `,` : 数组分隔，或创建单元素数组
11. `#` : 添加注释，单行

note：

`.\`运算符用于执行一个脚本或命令。
如果执行的是`Powershell`脚本，那么脚本会在自己的作用域中执行，
也就是说在当前环境下无法访问被执行的脚本中的变量。

`&`

默认键入一个字符串，`powershell`会将它原样输出，如果该字符串是一个`命令`或者`外部程序`，在字符串前加‘`&`’可以执行命令，或者启动程序。

如果你之前将`Powershell`命令存储在了一个字符串中，或者一个变量中。
此时，`&`将字符串直接解释成命令并执行

事实上，`&`可以直接执行一个`CommandInfo`对象，绕过自身的内部`get-command`, 如
`&(Get-Command tasklist)`

### 详细解释

`&`

`&`运算符将它后面的命令设置为后台运行，当运行的命令需要阻塞当前终端的时候很有用。

`[]`

运算符用于转换变量的类型，比如说下面的代码，就将`pi`变量转换为了`Float`类型。

```powershell
[Float]$pi = 3.14
$pi -is [Float]
```

`.`

运算符用于调用`.NET`对象的成员，它也可以用于执行脚本。
当它用于执行脚本的时候，脚本会在当前作用域中执行,
所以脚本结束之后，我们可以访问脚本中的元素。

`::`

运算符用于调用**类**中的**静态成员**，
例如下面调用`.NET`平台中`DateTime`类的`Now`属性。

```powershell
PS D:\Desktop> [DateTime]::Now
out:
2017年5月18日 22:45:42
```

`..`

运算符用于创建一个范围闭区间，例如下面这样。

```powershell
PS D:\Desktop> 1..3
out:
1
2
3
PS D:\Desktop> 3..1
```

`-f`

`-f`运算符用于格式化数据，例如下面这样。
格式化方法和`C#`中的完全相同，所以如果不熟悉的话直接看在`C#`中如何格式化数据就行了。

```powershell
PS D:\Desktop> 'My name is {0}， I am {1} years old' -f 'yitian',24
My name is yitian， I am 24 years old
```

`$`

`$`运算符可以将字符串内部的变量转换为实际的值，例如下面这样。
需要注意使用内插操作符的时候，外部字符串需要使用双引号，否则`Powershell`会直接输出字符串内容。

```powershell
PS D:\Desktop> $name='yitian'
PS D:\Desktop> $age=24
PS D:\Desktop> "My name is $name, I am $age years old."
out:
My name is yitian, I am 24 years old.
```

`@()`

`@()`运算符用于将一系列值转换为一个数组。
假如在脚本中有一个函数可能返回`0、1或多个值`，就可以使用这个操作符，
将一系列值合并为一个数组，方便后续处理。

`,`

`,`逗号运算符如果放置在单个值前面，就会创建一个包含这个值的单元素数组。

## 过滤文件

用`Get-ChildItem`显示当前当前文件的时候，会显示所有文件。
有时候我们可能仅仅需要搜索或者过滤部分文件。

首先，如果是比较简单的需求，可以使用`?*`通配符来搞定，
`?`用于匹配任意单个字符，`*`用于匹配任意多个字符。
比方说，我想要列出所有`.md`格式的文件，就可以使用下面的命令。

```powershell
Get-ChildItem *.md
```

有时候可能需要使用正则表达式来查找文件，
`Get-ChildItem`+`Where-Object`

下面同样是查找所有`.md`格式的文件，不过这次使用了`Where-Object`和正则表达式，
其中`Where-Object`里面的`$_`是形式变量，代表每次迭代的文件。
如果了解过`C#`的`LINQ`，或者`Java 8`的流类库，应该对这种形式会比较熟悉。

```powershell
Get-ChildItem | Where-Object {$_ -match '\w*.md$'}
```

想查找大于`5kb`的所有`.md`格式文件，那么就可以这么写。
这里又用到了`Powershell`的一个方便的特性，文件大小单位，`KB GB MB TB`等单位都支持。
当然其实并不仅仅可以查询文件大小属性，基本上所有文件信息都可以用来查询。

```powershell
 Get-ChildItem | Where-Object {$_ -match '\w*.md$' -and $_.Length/1kb -gt 5}
```

最后，`Get-ChildItem` 不仅可以列出当前文件夹下的所有内容，还可以递归查询所有子文件夹。
比如我要查找一下文件夹下所有可执行文件，
就可以使用下面的命令。如果添加`-Depth`参数的话，还可以指定递归深度。

```powershell
Get-ChildItem -Recurse *.exe
```

### 拷贝指定文件类型例子

找出所有jpg和png

```powershell
Get-ChildItem -Recurse | Where-Object {$_ -match '\w*.jpg$' -or $_ -match '\w*.png$'}
```

找出当前文件夹下所有图片并复制到指定路径

```powershell
Get-ChildItem -Path . -Recurse | Where-Object {$_ -match '\w*.jpg$'} | ForEach-Object {Copy-Item $_.FullName -Destination (-Join("C:\Users\Tom\Desktop\test\",$_.Name)) }
```

找出当前文件夹下所有图片并复制到指定路径,并以父文件夹命名

`Copy-Item` cmdlet can copy and rename items in the same command.
To rename an item, enter the new name in the value of the `Destination` parameter.
To rename an item and not copy it, use the `Rename-Item` cmdlet.

```powershell
Get-ChildItem -Path . -Recurse | Where-Object {$_ -match '\w*.jpg$'} | ForEach-Object {Copy-Item $_.FullName -Destination (-Join("C:\Users\Tom\Desktop\test\",$_.Directory.Name)) }
```

$a[0].Directory.Name

## 操作符

来看看`Powershell`中支持的操作符。

### 数学运算符

首先，基本的数学运算符都是支持的。

```powershell
 $i=5
 $sum=3+4*($i-3)/2
 $sum
```

前置后置自增自减运算符也是支持的。

```powershell
 $i=0
 $i--
 $i++
 ++$i
 --$i
```

### 比较运算符

有大于（`-gt`），大于等于（`-ge`），小于（`-lt`），
小于等于（`-le`），等于（`-eq`），不等于（`-ne`）几个。

### 字符串匹配运算符

`-like`和`-notlike`用于`?*`这样的通配符。

```powershell
 'hello' -like '?ello'
True
 'hello' -notlike '?ello'
False
 'hello' -like '*o'
True
```

`-match`和`-notmatch`用于正则表达式。

```powershell
 'aabcc' -match 'a*b?c+'
True
 'aab' -match 'a*b?c+'
False
```

### 包含和替换运算符

`-contains`查找序列中是否包含某个元素。

```powershell
 'hello','zhang3' -contains 'zhang3'
True
```

`-replace`用于替换字符串中某个部分，当然正则表达式也是支持的。

```powershell
 'hello zhang3' -replace 'zhang3','yitian'
hello yitian
```

### 分隔和连接运算符

`-split`和`-join`用于将一个字符串分为几个子部分，或者将几个子部分组合为一个字符串。

```powershell
 'A B C DE' -split ' '
```

```powershell
-join ("a", "b", "c")
 'A','B','C' -join ','
```

上面这些运算符都是大小写不敏感的，如果需要大小写敏感的功能，可以在运算符前面添加`c`前缀。

```powershell
 'yitian' -match 'Yitian'
True
 'yitian' -cmatch 'Yitian'
False
```

### 逻辑运算符

逻辑运算符有与（`-and`）、或（`-or`）、非（`-not`或`!`）以及异或（`xor`）几个，
并且支持短路运算。
如果需要使用真值和假值字面量，可以使用`$true`和`$false`。

### 类型运算符

`Powershell`和`.NET`平台绑定，所以它是一门强类型的脚本。
因此我们可以在脚本中判断数据的类型，只要使用`-is`或`-isnot`运算符即可，
类型需要写到方括号中。这里的类型可以是所有合适的`.NET`类型。

```powershell
 3.14 -is [Double]
True
 3.14 -isnot [Float]
True
```

### 重定向运算符

首先是`>`和`>>`运算符，用于将标准输出流重定向到文件，前者会覆盖已有文件，
后者则是追加到已有文件末尾。

## 循环

### for循环

`for`循环可以看做是`while`循环的另一种形式，常用于固定次数的循环。

```powershell
for ($i = 0; $i -ne 3; $i++) {
    Write-Output $i
}
```

`foreach-object`循环

alias `foreach -> ForEach-Object`

`foreach-object`循环用于遍历一个集合中的所有元素。

```powershell
$array = @(1, 2, 3, 4)
foreach ($i in $array) {
    Write-Output $i
}
```

值得一提的是，`foreach-object`语句用在管道上时，还有以下一种用法。

```powershell
<command> | foreach {<beginning command_block>}{<middle command_block>}{<ending command_block>}
```

使用这种方法时，`for-each`后面可以跟三个语句块，第一个语句块是开始语句块，
在循环前执行一次，常用来初始化一些数据；
第三个是结束语句块，在循环结束之后执行一次，常用于统计一些循环数据；
第二个就是正常的循环语句块，会循环多次。

## pwsh 锁屏

```powershell
Function Lock-WorkStation {
$signature = @"
[DllImport("user32.dll", SetLastError = true)]
public static extern bool LockWorkStation();
"@

$LockWorkStation = Add-Type -memberDefinition $signature -name "Win32LockWorkStation" -namespace Win32Functions -passthru
$LockWorkStation::LockWorkStation() | Out-Null
}
```

## Hash 哈希值

[巧用Win10自带的PowerShell命令校验文件的Hash值（MD5、SHA1/256等）][]

[巧用Win10自带的PowerShell命令校验文件的Hash值（MD5、SHA1/256等）]:https://www.windows10.pro/windows-powershell-get-filehash-algorithm-md5-sha1-format-list/

在Win10开始按钮上点击右键，选择“Windows PowerShell(管理员)”打开“管理员: Windows PowerShell”窗口。

校验文件Hash值的命令格式如下：

```PowerShell
Get-FileHash 文件路径 -Algorithm 校验的Hash值类型| Format-List
```

PS: 如果需要校验的文件路径比较复杂，例如路径中包含空格、括号等特殊符号，则需要在路径前后加上英文双引号。

Windows PowerShell命令可以校验的Hash值类型包括：SHA1、SHA256、SHA384、SHA512、MACTripleDES、MD5、RIPEMD160，暂不支持校验CRC32值。
如果想要校验它的SHA1值，则运行如下命令：

```PowerShell
Get-FileHash C:\Windows\notepad.exe -Algorithm SHA1| Format-List
```

如果想要校验SHA256值，则不需要带-Algorithm参数即可，命令如下：

```PowerShell
Get-FileHash C:\Windows\notepad.exe | Format-List
```

## 文件管理

获取相关命令。

Get-Command -noun Item

复制文件

Copy-Item
