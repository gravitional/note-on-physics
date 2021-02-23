# manjaro

## 系统安装

这里我假设你的电脑引导方式是 `UEFI`, 如果你的`ssd`是`NVMe`协议`M.2`的，
需要在进入安装界面之前先进去`BIOS`里面修改从硬盘的启动形式，把`RAID`改成`AHCI`，保存退出，否则进入安装界面你不会看到你的`NVMe`硬盘，做好这件事其他就都和普通ssd一样了。
还需要注意的一点是，修改成`AHCI`模式之后，重新进入`Windows`时会有问题，这个时候不要慌，等电脑自动重启第三次的时候，进入安全模式启动`Windows`，
进去之后重启系统，再次进入`Windows`就不需要安全模式了

插上U盘，在电脑`logo`出现之前狂按`F12`手动选择从`U`盘启动
如果你的电脑有`NVIDIA`和Intel双显卡的话，开机界面将`drive`改成`nonfree`，这样系统会自动帮你安装适配的`NVIDIA`驱动（简直太方便了）
如果这一步你没有改，进去之后手动安装`NVIDIA`驱动千万不要自己随便安装，这样很可能会导致下次启动进入`X-Window`界面失败，具体怎么安装可以参考`Manjaro WiKi`的解决方案

为保安装一步成功请在启动安装程序之前先联网, 
一般来讲，你只要在Windows下给Manjaro预留出磁盘空间，如果你有多个硬盘记得在安装窗口的最上面选对硬盘，
安装时候的分区方案直接选择取代一个分区，点击你之前分好的硬盘空间，接着下一步即可

如果你需要手动分区：
如果你的硬盘是`ssd+hdd`，并且打算把系统装在`hdd`下的话，建议直接用`windows`的`efi`分区，`hdd`中划分一个区出来挂载`/`区，
或者在`ssd`中分一个`150`MB（当然大点也行）的区出来挂载`/boot/efi`, 安装完毕重启即可.

### 换源

启动`terminal`，输入：

```bash
sudo pacman-mirrors -i -c China -m rank
```

在弹出的框中选一个最快的源，一个就好，选多了会降低速度.
6.9更新，不建议使用`archlinuxcn`的源，因为并不一定兼容,而且已经有人遇到了问题. 如果真的需要用（比如想安装`mysql`简单点），执行：

```bash
sudo nano /etc/pacman.conf
```

在末尾输入：

```bash
[archlinuxcn]
Server = http://mirrors.163.com/archlinux-cn/$arch
```

保存退出（`Ctrl+X,y`）接着更新系统

```bash
sudo pacman -Syyu
```

系统更新完毕, 如果上一步添加了`archlinuxcn` 的源：

```bash
sudo pacman -S archlinuxcn-keyring
```

### 安装软件

`Manjaro` 背靠`Arch`软件仓库，

```bash
sudo pacman -S yay
```

`yay`是一个用Go语言写的一个`AUR`助手，有些时候官方仓库没有你想要的软件，就需要通过`yay`来安装,有了`yay`，以后就不用`sudo pacman`了

***
安装拼音输入法, 安装`fcitx5`（输入法框架）

```bash
yay -S fcitx5-im
```

配置`fcitx5`的环境变量：

```bash
nano ~/.pam_environment
```

内容为：

```pam
GTK_IM_MODULE DEFAULT=fcitx
QT_IM_MODULE  DEFAULT=fcitx
XMODIFIERS    DEFAULT=\@im=fcitx
SDL_IM_MODULE DEFAULT=fcitx
```

安装中文维基百科词库：

```bash
yay -S fcitx5-pinyin-zhwiki
```

配置主题：

```bash
yay -S fcitx5-material-color
```

[大佬制作的fcitx5主题](https://github.com/ayamir/fcitx5-nord)

安装

```bash
git clone https://github.com/tonyfettes/fcitx5-nord.git
mkdir -p ~/.local/share/fcitx5/themes/
cd fcitx5-nord
cp -r nord-Dark/ nord-Light/ ~/.local/share/fcitx5/themes/
```

然后编辑`~/.config/fcitx5/conf/classicui.conf`, 更改主题指定的行，

```bash
Theme=Nord-Dark
# or
Theme=Nord-Light
```

然后重启`fcitx5`, `fcitx5 -r`

完成之后就可以注销，重新登录之后打开`fcitx5-configtool`编辑一下相应配置：

### 配置ohmyzsh

首先说一下这个过程不需要使用`pacman/yay`安装软件，首先修改默认`shell`为`zsh`

```bash
chsh -s /usr/bin/zsh
#安装ohmyzsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

安装`zsh-syntax-highlighting`：提供命令高亮

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

安装autosuggestions：记住你之前使用过的命令

```bash
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

安装incr：（需要注意的是这个插件会拖慢zsh的速度，新手入门可以试试）

```bash
git clone git://github.com/makeitjoe/incr.zsh $ZSH_CUSTOM/plugins/incr
```

启用所有插件

```bash
nano ~/.zshrc
# 将 plugins=(git) 改为:
plugins=(git zsh-syntax-highlighting zsh-autosuggestions incr sudo extract)
```

这个`sudo`是`ohmyzsh`自带的插件，功能是在你输入的命令的开头添加`sudo `，方法是`双击Esc`
`extract`也是自带插件，不用再去记不同文件的解压命令，方法是`extract +你要解压的文件名`.
保存退出之后，手动修改`konsole`的默认`bash`为`zsh`：（右键`Konsole - 编辑当前方案`）,打开`konsole`执行`source ~/.zshrc`, 配置完毕.

### 安装Vimplus

（现代化的vim插件管理工具，开箱即用，不使用vim的可以略过

```bash
git clone https://github.com/chxuan/vimplus.git ~/.vimplus
cd ~/.vimplus
./install.sh
```

### 安装腾讯系软件

安装Tim

```bash
yay -S deepin-wine-tim
```

安装过程中出现选择输入`n`就好

切换`deepin-wine`环境

```bash
sh /opt/deepinwine/apps/Deepin-Tim/run.sh -d
```

有问题直接去 [countstarlight/deepin-wine-tim-arch ](https://github.com/countstarlight/deepin-wine-tim-arch/issues) 开issue反馈就好了, 
如果这个版本的卡或者有其他问题，建议安装：

```bash
yay -S deepin.com.qq.office
```

如果这个也没办法装，则使用`linuxqq`

```bash
yay -S linuxqq
```

***
安装微信

`deepin-wine`版：

```bash
yay -S deepin-wine-wechat
```

切换到`deepin-wine`环境：

```bash
/opt/apps/com.qq.weixin.deepin/files/run.sh -d
```

关于字体发虚问题：

在切换到`deepin-wine`环境后，在`terminal`输入下面的指令：

```bash
env WINEPREFIX="$HOME/.deepinwine/Deepin-TIM" /usr/bin/deepin-wine winecfg
```

在弹出的窗口中选择`windows xp`，将`DPI`调大（默认是`96`），我调成了`120`

微信的同样，只需要将命令改为：

```bash
env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" /usr/bin/deepin-wine winecfg
```

`electron`版：

```bash
yay -S electron-wechat
```

### 安装其他软件

`tldr`(Too Long; Don't Read)：帮你更加高效地学习`linux`命令

```bash
pip install --user tldr
```

如果下载太慢：

```bash
mkdir -p ~/.config/pip
nano ~/.config/pip/pip.conf
```

写入如下内容

```bash
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```

这样就永久地修改了用户级别的`pip`下载源

如果安装失败则用：

```bash
yay -S tldr
```

`ranger`：终端文件浏览器

```bash
yay -S ranger
```

`wps`:中文版，想要英文版把后面那个包去掉

```bash
yay -S wps-office wps-office-mui-zh-cn
```

如果你使用`fcitx5`的话，还需要修改`/usr/bin/wps`和`/usr/bin/wpp`，将下面这行代码加到文件开头：

```bash
export QT_IM_MODULE="fcitx5"
```

网易云音乐：

```bash
yay -S netease-cloud-music
```

这样得到的版本不能在搜索框输入中文，

高颜值、开发活跃的第三方客户端：

```bash
yay -S yesplaymusic
```

qq音乐：

```bash
yay -S qqmusic-bin
```

一个支持全平台听歌的软件：`FeelUown`

```bash
yay -S feeluown
```

根据装完之后的提示装对应平台的依赖

chrome

```bash
yay -S google-chrome
```

百度网盘：

```bash
yay -S baidunetdisk
```

或者命令行（CLI）的：

```bash
yay -S baidupcs-go
```

坚果云：

```bash
yay -S nutstore
```

为知笔记：全平台通用、有云端同步、支持md的笔记

```bash
yay -S wiznote
```

Typora：我认为最舒适的md编辑器

```bash
yay -S typora
```

***
`flameshot`：强大的截图工具

```bash
yay -S flameshot
```

设置快捷键启动的方式

`设置->快捷键->自定义快捷键 -> 编辑 -> 新建 -> 全局快捷键 -> 命令/URL`，转到`触发器`标签，设置习惯的快捷键.
转到`动作`标签,在`命令/URL`中填上`/usr/bin/flameshot gui`

***
`timeshift` ：强大好用的备份、回滚系统工具

```bash
yay -S timeshift
```

XDM：Linux下最快的下载神器

```bash
yay -S xdman
```

建议直接去[https://subhra74.github.io/xdm/](https://subhra74.github.io/xdm/)下载压缩包安装，比命令行快很多

***
`calibre`：电子书管理神器

```bash
yay -S calibre
```

系统托盘那开启夜间颜色控制，不需要安装redshift了

### 字体

使用Windows/Mac OS字体:
[Fonts (简体中文) - ArchWiki​](https://wiki.archlinux.org/index.php/Fonts_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#Microsoft_%E5%AD%97%E4%BD%93)

这里建议直接拷贝字体文件

[渲染效果优化](https://zhuanlan.zhihu.com/p/343934880)

### 美化

安装`latte-dock`

```bash
yay -S latte-dock
```

添加一个新空面板，默认会出现在桌面上方，可以删除下面自带的面板，在新面板上添加必要的部件：应用程序面板，数字时钟，托盘，还可以加全局菜单，显示面板等等

启动`latte-dock`，下方就会出现一个dock栏，具体配置看自己爱好.
除dock栏中时钟的方法: 右键`配置lattedock`,接着右键时钟,选择`移除`就好了

***
`设置-外观`中选择你喜欢的主题什么的安装并且应用即可
`设置-工作区行为-桌面特效` 中可以启用一些华丽的特效
`设置-开机和关机`中更改登录屏幕等效果
`设置-工作区行为-常规行为-点击行为`设置双击打开文件/文件夹的设置

***
修改`/home/user`下的用户文件夹名称为英文：
先去手动修改文件夹名称，然后在 `设置 -> 应用程序 -> 地点` 中修改

***
双系统时间同步

按照[ Arch WiKi ](https://wiki.archlinux.org/index.php/System_time_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))的建议，这里修改`Windows`系统的注册表：
`win+X` 以管理员方式打开PowerShell，输入

```bash
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_QWORD /f
```

如果你的`Windows`是`32`位的，把上述代码中的`REG_QWORD`改成`REG_DWORD`

同时禁用`Windows`的自动同步时间功能

***
查看系统信息

```bash
yay -S neofetch lolcat # lolcat 只是渐变色的工具
neofetch | lolcat
```

装好`Manjaro`必须要有的习惯：

1. 必须要做`timeshift`，以防你哪天玩坏只能重装
2. 每天要开机执行一遍`sudo pacman -Syyu`

虽说`Manjaro`相对`Arch`应该稳定一点，但终究是滚动发行版，还是有滚挂的风险, 防止滚挂的最好办法就是 及时滚 长时间不更新必挂