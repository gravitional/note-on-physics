# powershell_x

## 通用语法和参考文档

[PowerShell 术语表](https://docs.microsoft.com/zh-cn/powershell/scripting/learn/glossary?view=powershell-7.1)
[命令行语法关键字](https://docs.microsoft.com/zh-cn/windows-server/administration/windows-commands/command-line-syntax-key)
[Windows 10 and Windows Server 2016 PowerShell Module Reference](https://docs.microsoft.com/en-us/powershell/module/?view=win10-ps)

命令行语法关键字
表示法  说明

+ 不含方括号或大括号的文本  必须按如下所示键入项.
+ `<尖括号中的文字>`  必须为其提供值的占位符.
+ `[方括号中的文字]`  可选项.
+ `{大括号中的文字}`  所需项的集合. 您必须选择一个.
+ 竖线 `(|)`  互斥项的分隔符. 您必须选择一个.
+ 省略 `(…)`  可以重复并多次使用的项.

使用`update-help -UICulture en-us`更新帮助文档, 一般英文文档比较多

经常使用的参考文档：[Microsoft.PowerShell.Management](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/?view=powershell-7)
本节包含与`PowerShell Microsoft.PowerShell.Management`模块一起安装的`cmdlet`的帮助主题. 管理模块包含`cmdlet`,可帮助您在PowerShell中管理`Windows`.

***
查看pwsh 版本

```powershell
$PSVersionTable.PSVersion
```

### 语法表 sytax diagrams

```powershell
<command-name> -<Required Parameter Name> <Required Parameter Value> # 命令名,必选键值对 
[-<Optional Parameter Name> <Optional Parameter Value>] # 可选的键值对
[-<Optional Switch Parameters>] # 可选的开关
[-<Optional Parameter Name>] <Required Parameter Value> # 可匿名的键值对
```

***
命令说明中,每一段都代表一种可能的语法格式.

命令采用 `-参数 值`的形式,每个参数前面必须有一个`-`.
`pwsh`是基于`Microsoft .NET`框架的,所以参数值是用它们的`.NET`类型表示的.

***
参数集合(Parameter Set),语法表中的每一段是一种可能的命令使用形式.如果参数不能放在一起使用,它们会出现在不同的参数集合中(不同的段落中).有些参数可能出现在多个 Parameter Sets 中.

通过使用的参数名称,你隐式地指明了你想使用的参数集合.

在每一个参数集合中,参数按照位置顺序出现.如果你省略了参数名称（键值）,pwsh将会按照位置和类型对命令参数赋值.

***
语法表中的符号

+ 连字符`-`(hyphen)-表明接着的是一个参数的名字.如：

```powershell
New-Alias -Name
```

+ 尖括号`<>`: 表示一个占位符,需要把其中的数据类型换成具体的用户输入.

+ 中括号`[]`: 表示一个可选项.表示参数键值都可以省略,或者参数值可以省略.如：

```powershell
New-Alias [-Description <string>]
New-Alias [-Name] <string>
```

如果在一个`.NET`类型后面接上一个`[]`,表示这个参数可以接受多个同类型的值,用一个逗号分隔列表

```powershell
New-Alias [-Name] <string> # 接收一个值
Get-Process [-Name] <string[]> # 接受多个值
Get-Process -Name Explorer, Winlogon, Services
```

在语法示例中,`[]`也用于命名和强制转换为`.NET Framework`类型.这种时候,`[]`的意思不是一个元素可以省略.

+ 大括号`{}`:表明一个`枚举`,列出一个参数所有可能的选项,其中的值用`|`分隔,`|`是`exclusive OR`的意思,表示只能有一个.如：

```powershell
New-Alias -Option {None | ReadOnly | Constant | Private | AllScope}
```

### 运算符

[关于运算符](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.1)
[关于算术运算符](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.1)

任何编程语言或者脚本语言中的小括号`()`,主要作用都是用来改变默认操作符的运算顺序的,`PowerShell`也不例外. 比如：

```powershell
PS> 1-3/3
0
PS> (1-3)/3
-0.666666666666667
```

1. `.\` : 执行一个脚本或命令
2. `&` : 将字符串直接解释成命令并执行
3. `[]` : 类型转换
4. `.` : 调用`.NET`对象的成员,或`global`执行脚本(当前作用域中执行)
5. `::` : 调用`.NET`**类**中的**静态成员**
6. `..` : 创建一个范围闭区间
7. `-f` : 格式化数据
8. `$` : 将字符串内部的变量转换为实际的值
9. `@()` : 将一系列值转换为一个数组
10. `,` : 数组分隔,或创建单元素数组
11. `#` : 添加注释,单行

note：

`.\`运算符用于执行一个脚本或命令.
如果执行的是`Powershell`脚本,那么脚本会在自己的作用域中执行,
也就是说在当前环境下无法访问被执行的脚本中的变量.

`&`默认键入一个字符串,`powershell`会将它原样输出,如果该字符串是一个`命令`或者`外部程序`,在字符串前加‘`&`’可以执行命令,或者启动程序.

如果你之前将`Powershell`命令存储在了一个字符串中,或者一个变量中.
此时,`&`将字符串直接解释成命令并执行

事实上,`&`可以直接执行一个`CommandInfo`对象,绕过自身的内部`get-command`, 如
`&(Get-Command tasklist)`

### 详细解释

***
`&`运算符将它后面的命令设置为后台运行,当运行的命令需要阻塞当前终端的时候很有用.

***
`[]`运算符用于转换变量的类型,比如说下面的代码,就将`pi`变量转换为了`Float`类型.

```powershell
[Float]$pi = 3.14
$pi -is [Float]
```

***
`.`运算符用于调用`.NET`对象的成员,它也可以用于执行脚本.
当它用于执行脚本的时候,脚本会在当前作用域中执行,所以脚本结束之后,我们可以访问脚本中的元素.

***
`::`运算符用于调用**类**中的**静态成员**,
例如下面调用`.NET`平台中`DateTime`类的`Now`属性.

```powershell
PS D:\Desktop> [DateTime]::Now
out:
2017年5月18日 22:45:42
```

***
`..`运算符用于创建一个范围闭区间,例如下面这样.

```powershell
PS D:\Desktop> 1..3
out:
1
2
3
PS D:\Desktop> 3..1
```

***
`-f`运算符用于格式化数据,例如下面这样.格式化方法和`C#`中的完全相同,所以如果不熟悉的话直接看在`C#`中如何格式化数据就行了.

```powershell
PS D:\Desktop> 'My name is {0}, I am {1} years old' -f 'yitian',24
My name is yitian, I am 24 years old
```

***
`$`运算符可以将字符串内部的变量转换为实际的值,例如下面这样.需要注意使用内插操作符的时候,外部字符串需要使用双引号,否则`Powershell`会直接输出字符串内容.

```powershell
PS D:\Desktop> $name='yitian'
PS D:\Desktop> $age=24
PS D:\Desktop> "My name is $name, I am $age years old."
out:
My name is yitian, I am 24 years old.
```

***
`@()`运算符用于将一系列值转换为一个数组.
假如在脚本中有一个函数可能返回`0、1或多个值`,就可以使用这个操作符,将一系列值合并为一个数组,方便后续处理.

***
`,`逗号运算符如果放置在单个值前面,就会创建一个包含这个值的单元素数组.

## 概念解释

### providers

PowerShell providers 是一些特定的`.NET`程序,用来提供对特性`data stores` 的访问,方便查看和管理.
数据出现在一个`driver`里,你可以像是访问硬盘中的文件那样访问它们.
你也可以使用自定义的 `cmdlet`

有时`provider`也会给`built-in cmdlets`提供动态参数.只有`cmdlets`作用在这些`provider`上面时,参数才是可用的.

*****
复制并整理文件的脚本

```powershell
$originpath=Get-Location;

$tepath='C:\Users\Thomas\Desktop\paper.ff\'

if(-not ( Test-Path $tepath )){ mkdir $tepath } else {}
copy-item .\* -Destination $tepath -Force

cd $tepath

remove-item -Path ('.\temp\','.\*.aux','.\*.lof','.\*.log','.\*.lot','.\*.fls','.\*.out','.\*.toc','.\*.fmt','.\*.fot','.\*.cb','.\*.cb2','.\*.ptc','.\*.xdv','.\*.fdb_latexmk','.\*.synctex.gz','.\*.swp','.\*.ps1','.\*.bib','.\*.bbl','.\*.blg')

7z a ..\paper.7z $tepath

cd $originpath

```

### 执行策略限制

`Powershell`一般初始化情况下都会禁止脚本执行.脚本能否执行取决于`Powershell`的执行策略.

```powershell
PS E:> .\MyScript.ps1
无法加载文件 E:MyScript.ps1,因为在此系统中禁止执行脚本...
```

只有管理员才有权限更改这个策略.非管理员会报错.

查看脚本执行策略,可以通过：

```powershell
PS E:> Get-ExecutionPolicy
```

更改脚本执行策略,可以通过

```powershell
PS E:> Get-ExecutionPolicy
Restricted
PS E:> Set-ExecutionPolicy UnRestricted
```

脚本执行策略类型为：`Microsoft.PowerShell.ExecutionPolicy`
查看所有支持的执行策略：

```powershell
PS E:>  [System.Enum]::GetNames([Microsoft.PowerShell.ExecutionPolicy])
Unrestricted
RemoteSigned
AllSigned
Restricted
Default
Bypass
Undefined
```

+ `Unrestricted` :权限最高,可以不受限制执行任何脚本.
+ `Default` :为`Powershell`默认的策略：`Restricted`,不允许任何脚本执行.
+ `AllSigned` ：所有脚本都必须经过签名才能在运行.
+ `RemoteSigned` ：本地脚本无限制,但是对来自网络的脚本必须经过签名.

关于`Powershell`脚本的签名在后续会谈到.

## 命令行常用设置

### 查找别名

当然,如果想查找特定动词/名词的命令也是可以的.比方说,如果我想查找所有以`Get`开头的命令,可以使用下面的命令.

```powershell
Get-Command -Verb Get
```

相应的,如果我想获取所有名词是`Help`的命令,可以使用下面的命令. 也可以用来查找二进制程序，如`unzip.exe`

```powershell
Get-Command -Noun Help
```

```powershell
Get-Command -CommandType Alias | where {$_.DisplayName -like -join("*", "Get-Command", "*") }
```

+ select -> Select-Object
+ where-> Where-Object
+ gcm -> Get-Command

### 命令行历史

我们通常会在`Console`界面中运行多次命令或者命令行,
在`PowerShell`中我们可以使用管理历史记录的命令来管理那些之前使用过的命令行,目前在`PowerShell`中有如下四个管理历史相关的命令.

| Cmdlet (Alias) ||       Description |
| -------------------|  ---------------------- |
| `Get-History` (`h`)   |   Gets the command history. |
| `Invoke-History` (`r)` |  Runs a command in the command history. |
| `Add-History`      |   Adds a command to the command history. |
| `Clear-History` (`clh`) | Deletes commands from the command history. |

如上面的`Description`介绍所描述的那样, 我们如下使用了`Get-History`命令得到如下从我们打开`PowerShell Console`界面开始记录的第一条命令.

 ```powershell
 C:\Users\Administrator> Get-History
 ```

当然,`PowerShell`并不会无止境的记录历史命令,你可以通过使用如下保留自变量来查看系统默认可以记录多少历史命令：

```powershell
PS C:\Users\Administrator> $MaximumHistoryCount
```

你也可以直接给这个变量赋一个阿拉伯数字设置你想设置的上限值,比如我设置为`5`：

```powershell
PS C:\Users\Administrator> $MaximumHistoryCount = 5
PS C:\Users\Administrator> $MaximumHistoryCount
```

当你在用`Get-History`命令查看记录了多少命令的时候你会发现,它只自动截取了最近的`5`行命令

我们可以使用`Invoke-History`或者别名`r` 来调用历史命令：

```powershell
PS C:\Users\Administrator> `Invoke-History -id 51`
```

好了,大致是这样,非常简单的几个命令,对了你还可以用`Add-History`添加命令或用`Clear-History`来清除之前的命令行.

[itanders-command-history][]

[itanders-command-history]: https://blog.csdn.net/itanders/article/details/51344419

### 输出到控制台

Module : Microsoft.PowerShell.Utility

`Write-Output`
将指定的对象发送到管道中的下一个命令.
如果该命令是管道中的最后一个命令,则对象将显示在控制台中.

Syntax：

```powershell
Write-Output
     [-InputObject] <PSObject[]>
     [-NoEnumerate]
     [<CommonParameters>]
```

示例：将输出传递到另一个cmdlet

```powershell
Write-Output "test output" | Get-Member
```

## 文件管理

### 硬盘驱动器

`Get-PSDrive` 查看所有虚拟驱动器
`get-psprovider` 查看所有的 `provider`

可以使用 

### 子项目管理

***
获取文件管理相关命令

```powershell
Get-Command -noun Item
```

***
复制文件

```powershell
Copy-Item
```

***
批量重命名文件

查看原始文件：

```powershell
dir *.pdf
```

重命名：

```powershell
dir *.pdf | foreach { Rename-Item $_ -NewName ($_.BaseName+"_123.pdf")  }
```

带正则的语句

"Mr. Miller, Mrs. Meyer and Mr. Werner"-replace "(Mr.|Mrs.)\s*(Miller|Meyer)", "Our client `$2"

*****

替换例子

```powershell
dir *.nb | foreach { Rename-Item $_ -NewName ($_.Name -replace "rencon2", "rencon3" )  }
```

### 变量存在性检测

验证一个变量是否存在,仍然可以像验证文件系统那样,
使用`cmdlet Test-Path`.为什么？因为变量存在变量驱动器中.

```powershell
PS C:\test> Test-Path variable:value1
```

***
检查除指定类型外是否还有文件

```powershell
Test-Path -Path "C:\CAD\Commercial Buildings\*" -Exclude *.dwg
```

This command checks whether there are any files in the Commercial Buildings directory other than `.dwg` files.

`-Filter`

```powershell
Test-Path (Get-location) -Filter *.bib
```

### 磁盘管理

[PowerShell格式化磁盘](https://www.sysgeek.cn/windows-10-format-hard-drive-powershell/)
[如何在Windows 10中更专业地格式化U盘](https://www.sysgeek.cn/format-usb-drives-windows-10/)

***
使用`diskpart`命令格式化U盘

格式化 U 盘或磁盘的另一种方式便是使用 `diskpart` 命令行工具。
`diskpart` 命令可集成于 `Windows PE` 中方便管理员操作，也可以写到 MDT 的部署脚本当中进行使用；
使用 `diskpart` 格式化的 U 盘还可以直接将 Windows Vista 至 Windows 10 的 ISO 解压上去用于 U 盘启动引导系统，免去了用其它工具制作 Windows 10 安装 U 盘的麻烦。

1. 使用 `Windows+X` 快捷键打开`命令提示符（管理员）`工具：
1. 执行 `diskpart` 命令进行交互环境：
1. 执行 `list disk` 命令查看当前 PC 连接的磁盘：
1. 使用 `select` 命令选中你的 U 盘，在我们的演示环境中 U 盘是磁盘 1，所以使用 `select disk 1` 命令将它选中：
1. 执行 `clean` 命令清空 `U` 盘：
1. 使用如下命令创建一个新的主分区并标记为活动分区：

```diskpart
create partition primary
active
```

之所以标记为活动分区，是为了方便将 `Windows` 系统 `ISO` 映像放上去当启用 `U` 盘来用。

1. 使用如下命令对 U 盘进行快速格式化：

```diskpart
format fs=ntfs label="卷标" quick
```

1. 如果你要将 `U` 盘格式化为 `FAT` 或 `exFAT` 格式，只需替换 `fs=` 后面的 `ntfs` 即可，最后的 `quick` 表示执行快速格式化。
2. 格式化完成之后，使用 `assign` 命令自动为 U 盘分配一个盘符即可使用了。

***
使用PowerShell命令格式化磁盘

[Windows Storage Management-specific cmdlets](https://docs.microsoft.com/en-us/powershell/module/storage/?view=win10-ps)

普通磁盘和动态磁盘

[Basic and Dynamic Disks](https://docs.microsoft.com/en-us/windows/win32/fileio/basic-and-dynamic-disks)

+ 使用 `Windows+X` 快捷键打开`命令提示符（管理员）`工具：
+ 执行 `Get-Disk` Cmdlet 可以查看到连接到当前 Windows 10 PC 的所有物理磁盘和 `U` 盘。
+ 执行如入命令清理驱动器：

```powershell
Get-Disk 4 | Clear-Disk -RemoveData
```

执行上述命令时，请确保要清理和格式化的磁盘编号填写正确，否则清除了错误的驱动器会导致数据丢失。

+ 执行如下命令以使用 NTFS 文件系统来创建新分区，并为磁盘分配名称：

```powershell
New-Partition -DiskNumber 4 -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel Udisk
```

上述命令中，要格式化的驱动器磁盘号 `-DiskNumber` 为` 4`，要分配的磁盘名称也就是磁盘卷标 `-NewFileSystemLabel` 为 `Udisk`，请按你自己的情况更改。

+ 执行如下 PowerShell 命令为格式化好的磁盘分配一个驱动器号：

```powershell
Get-Partition -DiskNumber 4 | Set-Partition -NewDriveLetter G
```

## 流程控制

### if 条件判断

`Where-Object` 进行条件判断很方便,如果在判断执行代码段,可以使用`IF-ELSEIF-ELSE`语句.语句模板：

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

条件判断必须放在圆括号中,执行的代码必须紧跟在后面的花括号中.

```powershell
$n=8
if($n -gt 15) {"$n  大于 15 " }
if($n -gt 5) {"$n  大于 5 " }
8  大于 5
if($n -lt 0 ){"-1" } elseif($n -eq 0){"0"} else {"1"}
1
```

### for 循环

`for`循环可以看做是`while`循环的另一种形式,常用于固定次数的循环.

```powershell
for ($i = 0; $i -ne 3; $i++) {
    Write-Output $i
}
```

`foreach`循环用于遍历一个集合中的所有元素.
[关于 ForEach](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.1)

```powershell
$array = @(1, 2, 3, 4)
foreach ($i in $array) {
    Write-Output $i
}
```

值得一提的是,`foreach-object`语句用在管道上时,还有以下一种用法.

```powershell
<command> | foreach {<beginning command_block>}{<middle command_block>}{<ending command_block>}
```

使用这种方法时,`for-each`后面可以跟三个语句块,第一个语句块是开始语句块,
在循环前执行一次,常用来初始化一些数据；
第三个是结束语句块,在循环结束之后执行一次,常用于统计一些循环数据；
第二个就是正常的循环语句块,会循环多次.

## 脚本

### 传递参数

***
返回所有的参数

传递给一个函数或者一个脚本的参数都保存在`$args`变量中.

默认情况下,传递给一个`Powershell`脚本的参数类型为数组,例如：

```powershell
PS E:> .MyScript.ps1 My Website      Is        www.mossfly.com
Hello,My Website Is www.mossfly.com
```

上面的文本中包含多个连续的空格,可是当脚本把参数输出时却不存在连续的空格了.那是因为脚本会把文本根据白空格截断并转换成数组.
如果不想文本被当成数组那就把它放在引号中.

```powershell
PS E:> ./MyScript.ps1 "My Website      Is        www.mossfly.com"
Hello,My Website      Is        www.mossfly.com
```

***
逐个访问参数

因为`$args`是一个数组,自然可以通过索引访问数组的每一个元素.
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

***
在脚本中使用参数名

通过`Powershell`传递参数固然方便,但是如果用户不知道参数的传递顺序,也是很郁闷的.
所以最好的方式给参数指定名称,输入以下的脚本：

```powershell
param($Directory,$FileName)

"Directory= $Directory"
"FileName=$FileName"
```

其中`param`给参数指定名称.

执行脚本：

```powershell
PS E:> .\MyScript.ps1 -Directory $env:windir -FileName config.xml
Directory= C:windows
FileName=config.xml
PS E:> .\MyScript.ps1 -FileName config.xml -Directory $env:windir
Directory= C:windows
FileName=config.xml
```

## 筛选对象

### 查找字符串

`Select-String `: 查找字符串和文件中的文本.

### 筛选管道中的对象

通过管道可以过滤某些对象和对象的属性,这个功能很实用,因为很多时候我们并不是对所有的结果感兴趣,可能只会对某些结果感兴趣.

+ `Select-Object`：`select`,选取前几个对象如`-First 3`，或者对象的属性. 可以用它先查看对象都有什么属性, 
+ `Where-Object`:  `where`,根据对象的属性，从对象集合中挑选特定的几个。例如，选择在某个日期之后创建的文件, 具有特定ID的事件, 或者使用特定版本Windows的计算机。
+ `ForEach-Object`：`foreach`,对输入对象集合中的每个项目执行操作。输入对象可以通过管道进入`cmdlet`，也可以通过使用`InputObject`参数指定。
+ `Get-Uinque`：`gu`,从排序过的列表中返回不重复的对象.

比如过滤正在运行的服务,可以通过每个服务的属性`Status`进行过滤. 
首先我们看看服务的属性,可以通过`Format-List *`,也可以通过`Get-memeber`.

```powershell
Get-service | Select-Object -First 1 | Format-List * #Format-List 输出对象的属性，每行一个
```

找出`Status`为`Running`的程序, 这里是 `where-object` 的脚本块用法

```powershell
get-service | Where-Object {$_.Status -eq "Running"}
```

### 比较操作符

***
`-Contains` 包含

指示如果对象的`property`值中的任何项与指定值完全匹配，则此`cmdlet`将获取对象。例如:

```powershell
Get-Process | where ProcessName -Contains "Svchost"
```

***
`-GE` 大于

```powershell
Get-Process | Where-Object -Property Handles -GE -Value 1000
Get-Process | where Handles -GE 1000
```

第一条命令使用`comparison`语句格式。没有使用别名，并且所有参数前带上了参数名称。
第二个命令是更常用的格式，使用`where`代替了`Where-Object ` cmdlet，并且省略了所有可选参数名称。

***
`-Like` 通配符

如果`property`值与包含通配符的值匹配，则此cmdlet将获取对象。

For example:

```powershell
Get-Process | where ProcessName -Like "*host"
```

```powershell
Get-Process | where ProcessName -Like "*.pdf"
```

***
`-match` 正则表达式

用`Get-ChildItem`显示当前当前文件的时候,会显示所有文件.有时候我们可能仅仅需要搜索或者过滤部分文件.

首先,如果是比较简单的需求,可以使用`?*`通配符来搞定,`?`用于匹配任意单个字符,`*`用于匹配任意多个字符.
比方说,我想要列出所有`.md`格式的文件,就可以使用下面的命令.

```powershell
Get-ChildItem *.md
```

有时候可能需要使用正则表达式来查找文件,考虑使用 `Get-ChildItem`+`Where-Object`,比如查找所有`.md`格式的文件,
`Where-Object`里面的`$_`是形式变量,代表每次迭代的文件. 如果了解过`C#`的`LINQ`,或者`Java 8`的流类库,应该对这种形式会比较熟悉.

```powershell
Get-ChildItem | Where-Object {$_ -match '\w*.md$'}
```

想查找大于`5kb`的所有`.md`格式文件,

```powershell
 Get-ChildItem | Where-Object {$_ -match '\w*.md$' -and $_.Length/1kb -gt 5}
```

这里又用到了`Powershell`的一个方便的特性,文件大小单位,`KB GB MB TB`等单位都支持.
当然其实并不仅仅可以查询文件大小属性,基本上所有文件信息都可以用来查询.

最后,`Get-ChildItem` 不仅可以列出当前文件夹下的所有内容,还可以递归查询所有子文件夹.
比如我要查找一下文件夹下所有可执行文件,就可以使用下面的命令.

```powershell
Get-ChildItem -Recurse *.exe
```

如果添加`-Depth`参数的话,还可以指定递归深度.

### 拷贝特定文件类型

找出所有`jpg`和`png`

```powershell
Get-ChildItem -Recurse | Where-Object {$_ -match '\w*.jpg$' -or $_ -match '\w*.png$'}
```

找出当前文件夹下所有图片并复制到指定路径

```powershell
Get-ChildItem -Path . -Recurse | Where-Object {$_ -match '\w*.jpg$'} | ForEach-Object {Copy-Item $_.FullName -Destination (-Join("C:\Users\Tom\Desktop\test\",$_.Name)) }
```

找出当前文件夹下所有图片并复制到指定路径,并以父文件夹命名. 若要重命名项目而不复制它，请使用`Rename-Item` cmdlet。

```powershell
Get-ChildItem -Path . -Recurse | Where-Object {$_ -match '\w*.jpg$'} | 
ForEach-Object {Copy-Item $_.FullName -Destination (-Join("C:\Users\Tom\Desktop\test\",$_.Directory.Name)) }
```

`$a[0].Directory.Name` 会给出父文件夹的名字.

## 常用片段

### pwsh 锁屏

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

[更改计算机状态](https://docs.microsoft.com/zh-cn/powershell/scripting/samples/changing-computer-state?view=powershell-7.1)

使用标准可用工具直接锁定计算机的唯一方法是调用 `user32.dll` 中的 `LockWorkstation()` 函数：

```powershell
rundll32.exe user32.dll,LockWorkStation
```

你还可以使用具 `shutdown.exe` 工具及其 `logoff` 选项：

```powershell
shutdown.exe -l
```

另一种方法是使用 `WMI` . `Win32_OperatingSystem` 类具有 `Shutdown` 方法. 调用具有 0 标志的方法将启动注销：

```powershell
Get-CimInstance -Classname Win32_OperatingSystem | Invoke-CimMethod -MethodName Shutdown
```

***
关闭或重启计算机

关闭和重启计算机通常是相同类型的任务. 关闭计算机的工具通常也可以重启计算机,反之亦然.
从 PowerShell 重启计算机有两个直接的选项.你可以从 `tsshutdn.exe /?` 或 `shutdown.exe /?` 获取详细的使用信息.

也可以直接从 `PowerShell` 执行关闭和重启操作.

要关闭计算机,请使用 

```powershell
Stop-Computer
```

要重启操作系统,请使用 

```powershell
Restart-Computer
```

要强制立即重新启动计算机,请使用 `-Force` 参数.

```powershell
Restart-Computer -Force
```

### Hash 哈希值

[Win10自带PowerShell命令校验Hash值](https://www.windows10.pro/windows-powershell-get-filehash-algorithm-md5-sha1-format-list/)

校验文件`Hash`值的命令格式如下：

```powershell
Get-FileHash 文件路径 -Algorithm hash-type| Format-List
```

如果需要校验的文件路径比较复杂,例如路径中包含空格、括号等特殊符号,则需要在路径前后加上英文双引号.

pwsh 命令可以校验的`Hash`值类型包括：SHA1、SHA256、SHA384、SHA512、MACTripleDES、MD5、RIPEMD160,暂不支持校验`CRC32`值.
如果想要校验它的`SHA1`值,则运行如下命令：

```powershell
Get-FileHash C:\Windows\notepad.exe -Algorithm SHA1| Format-List
```

如果想要校验`SHA256`值,则不需要带`-Algorithm`参数即可,命令如下：

```powershell
Get-FileHash C:\Windows\notepad.exe | Format-List
```

### Start-Sleep

*****
暂停Windows PowerShell 10秒：

```powershell
Start-Sleep –s 10
```

*****
暂停脚本10秒（10,000毫秒）

```powershell
Start-Sleep –m 10000
```

*****
语法

+ `tart-Sleep [-seconds] <int> [<CommonParameters>]`
+ `Start-Sleep -milliseconds <int> [<CommonParameters>]`

*****
详细描述

`Start-Sleep` cmdlet使shell, 脚本, 或运行空间的活动挂起指定的时间. 
你可以在脚本使用此命令来等待一个操作的结束, 或者在循环中等待一段指定时间后继续迭代.

*****
参数

`-seconds <int>`

指定睡眠源需要睡眠的秒数. 你可以忽略此参数名称(`-Seconds`), 你也可以使用此参数缩写"-s". 

```powershell
-milliseconds <int>
```

指定睡眠源需要睡眠的毫秒数. 此参数缩写"-m".

*****
`<公共参数>`

此命令支持公共参数:` -Verbose`, `-Debug`, `-ErrorAction`, `-ErrorVariable`, and `-OutVariable`. 

更多信息, 输入, `get-help about_commonparameters`.

*****
输入类型

`Int32`

如果需要为该命令提供多个参数, 请使用逗号进行分隔. 例如, `<parameter-name> <value1>, <value2>`.

*****
你可以使用`Start-Sleep`内建别名`sleep`. 需要更多信息, 查看`About_Alias`.

### 监视文件夹

```powershell
$i=0
while ($i -le 1000)
{
    Clear-Host
    Write-Host "`n`n ++++++++++++ `n`n"
    dir data*
    Start-Sleep -Seconds 10 
    $i++
}
```

### 查看所有中文字体

```powershell
fc-list :lang=zh-cn
```

### eval

***
将命令行作为整体执行

在`Powershell`中,`&`操作符不但可以执行一条单独的命令,还可以执行`命令行`. 最方便的方式就是将你的命令行放在一个语句块中,作为整体.
在之前的文章中说过,调用操作符只能执行一条命令,但是借助语句块(`{}`)的这把利器,可以让调用操作符执行,多条`Powershell`命令,例如：

```powershell
& {$files=ls;Write-Host "文件数：" $files.Count }
文件数： 29
```

***
执行表达式

另外还有一条Powershell cmdlet,`Invoke-Expression`,这条命令的逻辑就是将一条字符串传递给调用操作符.例如：

```powershell
Invoke-Expression 'Get-Process | Where-Object { $_.Name -like "e*"}'
```

***
打开所有pdf

```powershell
& 'C:\Program Files\SumatraPDF\SumatraPDF.exe'  (Get-ChildItem | where Name -Like "*.pdf")
```

## 操作符

来看看`Powershell`中支持的操作符.

[about_Comparison_Operators](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.1)

### 数学运算符

首先,基本的数学运算符都是支持的.

```powershell
 $i=5
 $sum=3+4*($i-3)/2
 $sum
```

前置后置自增自减运算符也是支持的.

```powershell
 $i=0
 $i--
 $i++
 ++$i
 --$i
```

### 比较运算符

+ `-gt` `-ge` 
+ `-lt` `-le` `
+ `-eq` `-ne`

有大于（`-gt`）,大于等于（`-ge`）,小于（`-lt`）,
小于等于（`-le`）,等于（`-eq`）,不等于（`-ne`）几个.

### 字符串匹配运算符

`-like`和`-notlike`用于`?*`这样的通配符.

```powershell
 'hello' -like '?ello'
True
 'hello' -notlike '?ello'
False
 'hello' -like '*o'
True
```

`-match`和`-notmatch`用于正则表达式.

```powershell
 'aabcc' -match 'a*b?c+'
True
 'aab' -match 'a*b?c+'
False
```

### 包含和替换运算符

`-contains`查找序列中是否包含某个元素. 

```powershell
 'hello','zhang3' -contains 'zhang3'
True
```

`-replace`用于替换字符串中某个部分,当然正则表达式也是支持的.

```powershell
 'hello zhang3' -replace 'zhang3','yitian'
hello yitian
```

### 分隔和连接运算符

`-split`和`-join`用于将一个字符串分为几个子部分,或者将几个子部分组合为一个字符串.

```powershell
 'A B C DE' -split ' '
```

```powershell
-join ("a", "b", "c")
 'A','B','C' -join ','
```

上面这些运算符都是大小写不敏感的,如果需要大小写敏感的功能,可以在运算符前面添加`c`前缀.

```powershell
 'yitian' -match 'Yitian'
True
 'yitian' -cmatch 'Yitian'
False
```

### 逻辑运算符

逻辑运算符有与（`-and`）、或（`-or`）、非（`-not`或`!`）以及异或（`xor`）几个,
并且支持短路运算.
如果需要使用真值和假值字面量,可以使用`$true`和`$false`.

### 类型运算符

`Powershell`和`.NET`平台绑定,所以它是一门强类型的脚本.
因此我们可以在脚本中判断数据的类型,只要使用`-is`或`-isnot`运算符即可,
类型需要写到方括号中.这里的类型可以是所有合适的`.NET`类型.

```powershell
 3.14 -is [Double]
True
 3.14 -isnot [Float]
True
```

### 重定向运算符

首先是`>`和`>>`运算符,用于将标准输出流重定向到文件,前者会覆盖已有文件,
后者则是追加到已有文件末尾.

## 类与对象

使用`Get-Member -Static`来查看对象的静态属性和对象的类型.  使用`[类型名称]`，如`[System.Enum]`来指定某个类对象，可以调用静态方法.

### 一切皆对象

与大多数 `Shell`（它们接受和返回文本）不同,`Windows PowerShell` 是在 `.NET Framework` 公共语言运行时 (`CLR`) 和`.NET Framework` 的基础上生成的,
它将接受和返回 `.NET Framework` 对象. 每一个`Powershell`命令都会返回一个对象.包括 `comlet` `变量`,`函数`,`字符串`等等,都是对象.

属性可以描述一个对象,对象的属性可以被`Powershell`自动转换成文本,并且输出到控制台. 因此可以通过这种方法查看任何对象,例如`$host`:

```powershell
$ host
out:
Name    : ConsoleHost
Version : 2.0
```

但将对象的属性转换成文本并不安全,最安全的方式是将对象保存在变量中. 如果想将对象输出为文本,可以在控制台输入变量名.

```powershell
$FileList=dir
$FileList
```

### get-command

可以先查看存在哪些已经定义过的`命令`,`函数` etc. 别名是`gcm`，也可以用来查看二进制程序的位置, 如`gcm unzip`.

比如,`Powershell`已经提供了许多用户能够使用的预定义函数, 这些函数可以通过`Function:PSDrive` **虚拟驱动器**查看.

```powershell
ls function:
```

其他的类似命令还有：

+ `Get-Command` 获取所有可用命令
+ `ls alias:` 获取所有别名
+ `ls function:` 获取所有已命名函数
+ `ls variable:` 查看所有已定义的变量
+ `env:windir` 驱动器变量

查看某一具体命令的信息,如 `ls` ：

```powershell
PS C:> Get-command ls
```

***
删除函数

```powershell
del Function:Get-Command
```

### 变量的作用域

+ `$global` 全局变量,在所有的作用域中有效,如果你在脚本或者函数中设置了全局变量,即使脚本和函数都运行结束,这个变量也任然有效.
+ `$script` 脚本变量,只会在脚本内部有效,包括脚本中的函数,一旦脚本运行结束,这个变量就会被回收.
+ `$private` 私有变量,只会在当前作用域有效,不能贯穿到其他作用域.
+ `$local` 默认变量,可以省略修饰符,在当前作用域有效,其它作用域只对它有只读权限.

打开`Powershell`控制台后,`Powershell`会自动生成一个新的**全局作用域**.
如果增加了函数和脚本,或者特殊的定义,才会生成其它作用域.

如果在当前控制台,只存在一个作用域,通过修饰符访问,其实访问的是同一个变量.

### 查看对象的所有成员

知道了都存在哪些对象之后,可以查看它们的具体成员.

对象的成员包括**属性**和**方法**,可以使用`Get-Member`返回它们的详细信息,

***
对象的属性

如果只显示属性可以使用参数 `memberType` 为“`Property`”

```powershell
$host | Get-Member -memberType property
```

***
对象的方法

方法定义了一个对象可以做什么事情.
当你把一个对象输出在控制台时,它的属性可能会被转换成可视的文本, 但是它的方法却不可见.
列出一个对象的所有方法可是使用`Get-Member`命令,给“`MemeberType`”参数传入“`Method`”:

```powershell
$Host | Get-Member -MemberType Method
```

***
筛选方法

`Get_` 和 `Set_` 方法

所有名称以”`get_`”打头的方法都是为了给对应的属性返回一个值.
例如”`get_someInfo()`”方法的作用就是返回属性`someInfo`的值,因此可以直接通过属性调用.
类似的像”`set_someinfo`”一样,该方法只是为了给属性`someinfo`赋值,可以直接通过属性赋值调用.

剔除包含下划线的方法可以使用操作符 `-notlike` 和 通配符 `*`

```powershell
$Host.UI.RawUI | Get-Member -me method | where {$_.Name -notlike '*_*'}
```

***
查看方法的详情

从列表中筛选出一个方法,再通过`Get-Member`得到更多的信息.

```powershell
$info=$Host.UI |  Get-Member WriteDebugLine
$info
$info.Definition
```

### 总结

`对象`=`属性`+`方法`

一个对象的属性用来存储数据,反过来这些数据又可以存储其它对象.
每一个类型都可以包含一些静态的方法,可以通过方括号和类型名称得到**类型对象本身**,如

```powershell
[System.Security.AccessControl.FileSystemRights]
```

### 对象的原型--类

上面查看的都是已经存在的`objetc`, 对象一般是由`class`生成的

#### 继承

面向对象程序设计中最重要的一个概念是继承. 继承允许我们依据另一个类来定义一个类,这使得创建和维护一个应用程序变得更容易.
这样做,也达到了重用代码功能和提高执行效率的效果.

当创建一个类时,您不需要重新编写新的数据成员和成员函数,只需指定新建的类继承了一个已有的类的成员即可.
这个已有的类称为`basetype`, 新建的类称为`派生类`. `继承`代表了`is a` 关系.例如,

    Mammal is a animal, dog is a mammal, so dog is a animal, etc.

#### 类型的简称

由类型下的某个具体对象（实例）,查看类型的名称:

```powershell
(10).gettype().name
("aaa").gettype().name
("aaa","sdafsa").gettype().name
```

#### 类型的完整名称

`Powershell` 将信息存储在`对象`中,每个对象都会有一个具体的`type`, 任何`.NET`对象都可以通过`GetType()`方法返回它的类型,
该类型中有一个`FullName`属性,可以查看类型的`完整名称`.

```powershell
$Host.Version.GetType().FullName
System.Version
$Host.Version.Build
-1
```

```powershell
($Host.Version.GetType()).GetType().name
```

`($Host.Version.GetType())`的类型为`System.RuntimeType`

#### 类型的静态方法

每一个类型都可以包含一些`静态方法`,可以通过方括号和类型名称得到`类型对象本身`, 然后通过`Get-Memeber`命令查看该类型支持的所有静态方法.

```powershell
[System.DateTime] | Get-Member -static -memberType Method
```

注：
`C++`中,若类的方法前加了`static`关键字,则该方法称为`静态方法`,反之为`实例方法`.
静态方法为类所有,可以通过`对象`来使用,也可以通过`类`来使用.
但一般提倡通过`类`来使用,因为静态方法只要定义了`类`,不必建立类的`实例`就可使用.
静态方法只能调用`静态变量`.

#### 查看类的具体属性

```powershell
$Host.UI |  Get-Member WriteDebugLine
```

#### 查看基类

```powershell
[Microsoft.PowerShell.ExecutionPolicy].BaseType
```

### 创建新对象

通过 `New-Object` 创建某一类型的新对象.  查看`String`类的构造函数

```powershell
[String].GetConstructors() | foreach {$_.tostring()}
```

`| foreach {$_.tostring()}` 是为了格式化输出结果

```powershell
New-Object String('s',10)
out:
**********
```

为什么可以用这个方法? 原因是`String`类中包含一个`Void .ctor(Char, Int32)`构造函数, `.ctor` 是`构造函数(constructor)`的缩写.

#### 类型转换

通过类型转换可以替代 `New-Object`

```powershell
[System.Version]'2012.12.20.4444'

Major  Minor  Build  Revision
-----  -----  -----  --------
2012   12     20     4444
```

#### 枚举某个属性

脚本执行策略类为：`Microsoft.PowerShell.ExecutionPolicy`, 查看所有支持的执行策略：

```powershell
[System.Enum]::GetNames([Microsoft.PowerShell.ExecutionPolicy])
```

使用`[System.Enum]`类的`GetNames()`方法,查看`[Microsoft.PowerShell.ExecutionPolicy]`类的值域

#### 枚举类型

`Enum 类`:

+ 命名空间: `System`
+ 程序集: `System.Runtime.dll, mscorlib.dll, netstandard.dll`
+ 说明: 为枚举提供基类.
+ `GetNames(Type)`方法: 检索指定枚举中常数名称的数组.

[class Enum](https://docs.microsoft.com/zh-cn/dotnet/api/system.enum?redirectedfrom=MSDN&view=netframework-4.8#definition)

枚举类型是一组命名常量定义的值类型, 底层是整数类型。要定义枚举类型，请使用`enum`关键字并指定枚举成员的名称：

```C#
enum Season
{
    Spring,
    Summer,
    Autumn,
    Winter
}
```

默认情况下，与枚举成员的相关的常数是`int`类型；它们从零开始，并按照定义文本顺序增加一。
您可以显式指定任何其他整数类型作为枚举类型的基础类型。您还可以显式指定关联的常数值，例如：

```C#
enum ErrorCode : ushort
{
    None = 0,
    Unknown = 1,
    ConnectionLost = 100,
    OutlierReading = 200
}
```

### .net 对象

`.NET`中的类型定义在不同的程序集中,首先得知道当前程序已经加载了那些程序集.
`AppDomain`类的静态成员`CurrentDomain`,有一个`GetAssemblies()`方法.

```powershell
[AppDomain]::CurrentDomain.GetAssemblies()
```

***
搜索指定类型

查询每个程序集中的方法可使用 `GetExportedTypes()` 方法. 因为许多程序集中包含了大量的方法,在搜索时最好指定关键字.

```powershell
[AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { -not $_.IsDynamic } | ForEach-Object {$_.GetExportedTypes() } | Where-Object { $_ -like '*environment*' } | ForEach-Object { $_.FullName }

System.EnvironmentVariableTarget
System.Environment
...
```

## 日常应用

输出分页: `Get-Help Get-Help | Out-Host -Paging`
