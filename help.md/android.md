# Android.md

## flash rooms

[使用fastboot命令刷机流程详解](https://blog.csdn.net/s13383754499/article/details/82755012)

### Fastboot是什么

*****
卡刷

在系统进行定制时，编译系统会编译出一份`ZIP`的压缩包，里面是一些系统分区镜像，提供给客户进行手动升级、恢复系统。
需要提前将压缩包内置`SDcard`，在`Recovery`模式进行。进入`Recovery`方法：将手机完全关机后，按住音量键下(上)+电源键，进入`BootLoader`界面。
用音量加减来控制光标，电源键来进行确认(有的机器只能用音量下键进行选择，上键是确认键)。说明：有的机器可能没有预装`Recovery`。

*****
线刷

在安卓手机中`Fastboot`是一种比`Recovery`更底层的刷机模式。使用USB数据线连接手机的一种刷机模式。这就是所谓的线刷，与`Recovery`模式相比`Fastboot`需要掌握一些烧机命令，对于某些系统卡刷来说，线刷更可靠，安全。

### Android系统分区介绍

+ `hboot` -- 系统开机引导类似电脑·，这块刷错手机就会变成砖
+ `radio` -- 通讯模块、基带、`WIFI`、`Bluetooth`等衔接硬件的驱动软件
+ `recovery` -- 系统故障时负责恢复
+ `boot` -- Linux嵌入式系统内核
+ `system` -- 系统文件、应用
+ `cache` -- 系统运行时产生的缓存
+ `userdata` -- 用户使用`APP`产生的缓存数据
 
### Fastboot环境搭建

`Android SDK`工具`platform-tools`

进入这个目录下就可以使用`adb`、`fastboot`命令了，也可以先配置环境变量就不用每次这么麻烦。
可以把这个目录单独拷贝出来，携带方便一点，SDK太大了。
其实很多刷机工具、刷机脚本都是围绕此工具进行刷机的，使用的也就是`adb`、`fastboot`命令，只不过别人将各种情况判断写成程序而已。

### Fastboot刷机命令

#### 常用命令

| | |
|---|---|---|
| `adb start-server` |  ensure that there is a server running |
| `adb kill-server`   | kill the server if it is running|
| `adb reboot bootloader` | 将手机重启到`Fastboot`模式|
| `adb reboot [bootloader|recovery]` | reboots the device, optionally into the bootloader or recovery program|
| `adb root`  | restarts the adbd daemon with root permissions |
| `fastboot  flashing  unlock`  | 设备解锁，开始刷机|
| `adb pull 文件路径 保存路径` | 复制普通手机文件到电脑  |
| `adb push 文件路径 保存路径` | 复制文件到手机中 |
| `fastboot  flash  boot  boot.img` | 刷入 `boot` 分区, 如果修改了`kernel` 代码，则应该刷入此分区以生效|
| `fastboot  flash  recovery  recovery.img` | 刷入 `recovery` 分区|
| `fastboot  flash  country  country.img` | 刷入 `country` 分区。这个分区是开发组自己划分的，别的 Android 设备上不一定有|
| `fastboot  flash  system  system.img` | 刷入 `system` 分区。如果修改的代码会影响 `out/system/` 路径下生成的文件，则应该刷入此分区以生效 |
|`fastboot flash recovery twrp-x.x.x-x-polaris.img`|将闪存恢复到设备上|
|`fastboot boot twrp-x.x.x-x-polaris.img`| 当显示`OKEY`说明安装成功|
|`fastboot oem reboot-recovery`|接着输入以下命令进入`TWEP`|

#### 写入分区步骤以及命令

+ `adb devices`-- 查看手机是否连接上
+ `adb reboot bootloader`-- 将手机重启到Fastboot模式
+ `fastboot devices`-- 查看Fastboot模式下连接的手机

#### 几种分区写入如下

例如：`system.img`--刷入的分区电脑上具体的路径 

```bash
fastboot flash system system.img
fastboot flash boot boot.img
fastboot flash radio radio.img
...
```

`fastboot reboot`-- Fastboot模式下重启手机

#### 擦除分区

擦除会将该分区恢复到使用前状态

`fastboot erase system`
`fastboot erase boot`
...

#### 准备工作

首先需要准备好刷机包，可以是自己编译的，也可以是从别处拷贝的，但一定要确保刷机包适用于你的 Android 设备。

然后解压刷机包，解压后我们可以得到 `boot.img`、`recovery.img`、`system.img`、bootloader 文件，正是这些文件构成了 Android 设备的系统。

让设备进入 `fastboot` 环境。有 2 种方法：

执行命令 `adb  reboot  fastboot`
或者同时按住 `增加音量` 和 `电源` 键开机。

#### 命令执行流程

在设备进入到 `fastboot` 环境后，根据需求执行下面的命令进行刷机：

+ `fastboot  flashing  unlock`    # 设备解锁，开始刷机
+ `fastboot  flash  boot  boot.img`    # 刷入 `boot` 分区, 如果修改了 `kernel` 代码，则应该刷入此分区以生效
+ `fastboot  flash  recovery  recovery.img`    # 刷入 `recovery` 分区
+ `fastboot  flash  country  country.img`    # 刷入 `country` 分区。这个分区是开发组自己划分的，别的 Android 设备上不一定有
+ `fastboot  flash  system  system.img`    # 刷入 `system` 分区。如果修改的代码会影响 `out/system/` 路径下生成的文件，则应该刷入此分区以生效 
+ `fastboot  flash  bootloader  bootloader`    # 刷入 bootloader
+ `fastboot  erase  frp`    # 擦除 `frp` 分区，`frp` 即 `Factory Reset Protection`，用于防止用户信息在手机丢失后外泄
+ `fastboot  format  data`    # 格式化 `data` 分区
+ `fastboot  flashing lock`    # 设备上锁，刷机完毕
+ `fastboot  continue`    # 自动重启设备

### adb help 输出

Android Debug Bridge version 1.0.32

adb help                     - show this help message
adb version                  - show version num

scripting:

`adb wait-for-device`  block until device is online
`adb start-server`   ensure that there is a server running
`adb kill-server`    kill the server if it is running
`adb get-state`      prints: offline | bootloader | device
`adb get-serialno`   prints: <serial-number>
`adb get-devpath`    prints: <device-path>
`adb status-window`  continuously print device status for a specified device
`adb remount`  remounts the `/system` and `/vendor` (if present) partitions on the device read-write
`adb reboot [bootloader|recovery]` - reboots the device, optionally into the bootloader or recovery program
`adb reboot-bootloader`      reboots the device into the bootloader
`adb root`    restarts the adbd daemon with root permissions
`adb usb`     restarts the adbd daemon listening onUSB
`adb tcpip <port>`   restarts the adbd daemon listening on TCP on the specified port networking:

*****
`adb ppp <tty> [parameters]` 

Run `PPP` over `USB`. Note: you should not automatically start a `PPP` connection. 
`<tty>` refers to the `tty` for `PPP` stream. Eg. `dev:/dev/omap_csmi_tty1`
`[parameters]` - Eg. defaultroute debug dump local notty usepeerdns

*****
`adb sync notes:` 

adb sync `[ <directory> ]` `<localdir>` can be interpreted in several ways:

If `<directory>` is not specified, `/system`, `/vendor` (if present), and `/data` partitions will be updated.

If it is `"system"`, `"vendor"` or `"data"`, only the corresponding partition is updated.

*****
environmental variables:

`ADB_TRACE`   - Print debug information. 
A comma separated list of the following values 1 or all, adb, sockets, packets, rwx, usb, sync, sysdeps, transport, jdwp

`ANDROID_SERIAL`   - The serial number to connect to. -s takes priority over this if given.

`ANDROID_LOG_TAGS`  - When used with the logcat option, only these debug tags are printed.

### 网络 adb

[ADB网络调试和常见命令](https://www.jianshu.com/p/2d256f338634)

安卓的adb调试模式有两种：1、使用usb线；2、使用网络。

#### 设置网络adb监听的端口

*****
最简单的方法

先是使用usb线连接电脑跟安卓设备，执行`adb`命令，该条命令是设置网络`adb`监听的端口，`5555`是默认，也可以设置其他的，在安卓设备重启后会失效，不需要`root`权限

```bash
adb tcpip 5555 
```

*****
重启后依然有效方法

在root权限下执行

```bash
adb shell su -c setprop service.adb.tcp.port 5555
```

*****
修改系统配置文件的方法

在`Android`的`/system/build.prop`文件最后添加`service.adb.tcp.port=5555`，
重启后有效，需要root权限

*****
输入命令连接到设备

```bash
adb connect 10.0.0.102
```

#### 进行跨网络调试

`adb`网络连接是基于`TCP`协议，不在一个局域网，只要知道Android设备终端IP，也能进行网络调试；
需要知道公网`IP`，设置一下端口映射就可以通过`ADB`连接

#### ADB调试常用命令

`adb`命令是`adb`程序自带的一些命令，`adb shell` 是调用android 系统的命令

| ----- | ----- |
| ----- | ----- |
| 查看连接的adb设备 | `adb devices` |
| 连接多个设备对其中一个进行操作 | adb -s 10.0.0.131:5555 shell |
| 获取root权限 | adb root |
| 查看所有进程详情 | adb shell procrank |
| 关闭进程(PID)，需要root权限 | adb shell kill 620 |

*****
进程详情

+ `VSS- Virtual Set Size` 虚拟耗用内存（包含共享库占用的内存）
+ `RSS- Resident Set Size` 实际使用物理内存（包含共享库占用的内存）
+ `Proportional Set Size` 实际使用的物理内存（比例分配共享库占用的内存）
+ `USS- Unique Set Size` 进程独自占用的物理内存（不包含共享库占用的内存）

*****
日志相关的命令

1. 查看进程pid为620的日志信息: `adb logcat | grep 620`
2. 过滤出有字符串同步数据的日志进行显示: `adb logcat | grep "同步数据"`
3. 查看`Tag`为`MainActivity`的日志信息: `adb logcat -s MainActivity`
4. 查看Tag为MainActivity的，日志等级不低于V的日志信息: `adb logcat MainActivity:V *:S` 

优先级是下面的字符，顺序是从低到高：

+ `V` — 明细 verbose(最低优先级)
+ `D` — 调试 debug
+ `I` — 信息 info
+ `W` — 警告 warn
+ `E` — 错误 error
+ `F` — 严重错误 fatal
+ `S` — 无记载 silent

将日志输出到文件，一般在日志命令后面加 `>> 文件路径`就行了，但是`1`，`2`的命令不行

```bash
adb logcat MainActivity:V *:S  >> ~/Desktop/AtestLog.txt
```

#### 其他命令

| end | sytax |
| ----- | ----- |
| 查看所有安装包 | `adb shell pm list packages` |
| 安装应用 | `adb install test.apk` |
| 保留数据和缓存文件，重新安装，升级 | `adb install -r test.apk` |
| 卸载应用 | `adb uninstall test.apk` |
| 卸载app但保留数据和缓存文件 | `adb uninstall -k cnblogs.apk` |
| 复制普通手机文件到电脑 | `adb pull 文件路径 保存路径`  |
| 复制文件到手机中 | `adb push 文件路径 保存路径` |

`adb pull /mnt/sdcard/ACrashTest/log/test.txt Desktop/`

操作手机`/system`目录文件，`adb remount` 将 `/system` 部分置于可写入的模式，默认情况下 `/system` 部分是只读模式的。这个命令只适用于已被 root 的设备

```bash
adb remount
```

查看存储空间

```bash
adb shell
//查看存储空间
df
//查看目录下的文件大小
du -sh *
```

重启机器

```bash
adb reboot
```

### sideload

[使用adb sideload线刷ROM的方法](https://www.cnblogs.com/godfeer/p/12029476.html)
[使用adb sideload线刷ROM的方法]: 

本教程详细介绍 手机刷三方ROM 之前需要安装的 `TWRP` 这个神器工具
楼主的手机是小米，所以此教程以小米手机为例。其他手机原理类似

#### 第一步，解锁引导程序

访问小米的官方解锁网站并申请解锁权限。等待直到获得批准，这可能需要几天的时间。

强烈建议在进行解锁之前，在设备上安装最新的官方MIUI开发软件包。

#### 第二步，安装TWRP fastboot

下载自定义`recovery`-你可以下载`TWRP`。
只需下载名为的最新恢复文件`twrp-x.x.x-x-polaris.img`。
通过USB将设备连接到PC。

*****
`adb`和`fastboot`命令使用示例

在计算机上，打开命令提示符或终端窗口，然后键入：`adb reboot bootloader`

您也可以通过组合键启动进入快速启动模式：
关闭设备电源，按住`Volume Down`+ `Power`。按住两个按钮，直到屏幕上出现“ FASTBOOT”字样，然后松开。

设备进入快速启动模式后，请通过键入以下内容验证您的PC能够找到它：`fastboot devices`

*****
将闪存恢复到设备上：
`fastboot flash recovery twrp-x.x.x-x-polaris.img`

在某些设备上，可能需要以下命令
`fastboot boot twrp-x.x.x-x-polaris.img`

当显示`OKEY`说明安装成功

接着输入以下命令进入`TWEP`：
`fastboot oem reboot-recovery`

然后
`高级`-`ADB Sideload`--滑动开始Sideload--连接USB数据线到电脑 

*****
然后 使用`ADB`执行
`adb sideload G:\fastboot\e-0.7-o-2019111430687-dev-polaris.zip`

`sideload`后面是你的要刷入的ROM文件,会出现正在输入的进度

当出现`Total`，即刷入成功。然后拔掉数据线，操作手机按提示重启即可进入 。
只要ROM没问题 一般情况都可以正常进入系统。
