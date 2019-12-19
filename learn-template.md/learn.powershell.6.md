learn.powershell.6.md

For myself and for you

[收集和分享 Windows PowerShell 相关教程,技术和最新动态][]
版权归原作者所有

[收集和分享 Windows PowerShell 相关教程,技术和最新动态]: https://www.pstips.net/

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