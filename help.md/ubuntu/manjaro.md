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

`yay`是一个用Go语言写的一个`AUR`助手，有些时候官方仓库没有你想要的软件，就需要通过`yay`来安装

有了`yay`，以后就不用`sudo pacman`了

安装拼音输入法, 安装fcitx5（输入法框架）

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

安装fcitx5-rime（输入法引擎）

yay -S fcitx5-rime

安装rime-cloverpinyin（输入方案）

yay -S rime-cloverpinyin

创建并写入rime-cloverpinyin的输入方案：

nano ~/.local/share/fcitx5/rime/default.custom.yaml

内容为：

patch:
  "menu/page_size": 5
  schema_list:
    - schema: clover

关于这个输入方案有什么问题，可以去github看对应的wiki
fkxxyz/rime-cloverpinyin​
github.com图标

安装中文维基百科词库：

yay -S fcitx5-pinyin-zhwiki-rime

关于词库的配置可以看我这篇文章：
https://zhuanlan.zhihu.com/p/287774005​
zhuanlan.zhihu.com图标

（可选）配置主题：

yay -S fcitx5-material-color

关于这个的配置建议去项目地址查看：
Fcitx5-Material-Color​
github.com

还有可以试试我参与制做的两个主题：
Nord​
github.com


Gruvbox​
github.com
Nord-Light皮肤效果

完成之后就可以注销，重新登录之后打开fcitx5-configtool编辑一下相应配置：

切换到rime输入法之后，右击输入法托盘图标，点击重新部署，就可以看到四叶草输入法了

5.2 配置ohmyzsh（神器，用过的都说好

首先说一下这个过程不需要使用pacman/yay安装软件，因此可以和安装软件并发进行

首先修改默认shell为zsh

chsh -s /usr/bin/zsh

安装ohmyzsh

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

如果每次执行都失败提示被拒绝连接就先改一下hosts文件

sudo nano /etc/hosts

把这段话复制到下面

# GitHub Start
151.101.64.133 raw.githubusercontent.com
# GitHub End

5.2.1安装zsh-syntax-highlighting：提供命令高亮

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

5.2.2安装autosuggestions：记住你之前使用过的命令

git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

5.2.3 安装incr：（需要注意的是这个插件会拖慢zsh的速度，新手入门可以试试）

再也不用先ls在粘贴文件名了，看下效果：

git clone git://github.com/makeitjoe/incr.zsh $ZSH_CUSTOM/plugins/incr

5.2.4 启用所有插件

nano ~/.zshrc

将plugins=(git)改为:

plugins=(git zsh-syntax-highlighting zsh-autosuggestions incr sudo extract)

这个sudo是ohmyzsh自带的插件，功能是在你输入的命令的开头添加sudo ，方法是双击Esc

extract也是自带插件，不用再去记不同文件的解压命令，方法是extract +你要解压的文件名

保存退出之后，手动修改konsole的默认bash为zsh：（右键Konsole -> 编辑当前方案）

打开konsole执行：

source ~/.zshrc

配置完毕，这时候输入zsh感受一下ohmyzsh以及这些插件的强大吧

还有很多有意思的插件，可以自行安装

alias 可以帮助你简化很多命令，具体设置看你习惯

一个究极自定义的zsh主题：
romkatv/powerlevel10k​
github.com图标

如果想在这个主题中使用Icon请将终端字体改为打了Nerd补丁的Font，下面这个链接是一些nerd fonts的下载地址，个人推荐JetBrainsMono Nerd Font
Releases · ryanoasis/nerd-fonts​
github.com

解压下载完的字体压缩包，假设目录名是JetBrainsMono

mkdir -p ~/.local/share/fonts
cp -vr JetBrainsMono/ ~/.local/share/fonts
fc-cache -vf

再开一个konsole，手动把字体改成JetBrainsMono Nerd Font即可
这是我配置完的效果

关于显示CPU利用率、磁盘使用率和内存剩余率，请手动编辑~/.p10k.zsh取消图中所示行的注释：

5.3安装Vimplus（现代化的vim插件管理工具，开箱即用，不使用vim的可以略过

git clone https://github.com/chxuan/vimplus.git ~/.vimplus
cd ~/.vimplus
./install.sh

vimplus​
github.com

下图为安装效果：

同样想显示icon，需要将终端字体改为打了nerd补丁的字体

vim并不难，开个终端执行vimtutor命令，进去练30分钟就能掌握80%的有用操作

如果想上手Emacs，个人建议使用Doom Emacs：
Doom Emacs​
github.com

5.4 安装腾讯系软件

5.4.1 安装Tim

yay -S deepin-wine-tim

安装过程中出现选择输入n就好

切换deepin-wine环境

sh /opt/deepinwine/apps/Deepin-Tim/run.sh -d

有问题直接去
作者GitHub项目地址 ​
github.com

开issue反馈就好了

如果这个版本的卡或者有其他问题，建议安装：

yay -S deepin.com.qq.office

如果这个也没办法装，则使用linuxqq

yay -S linuxqq

5.4.2 安装微信

deepin-wine版：

yay -S deepin-wine-wechat

切换到deepin-wine环境：

/opt/apps/com.qq.weixin.deepin/files/run.sh -d

关于字体发虚问题：

在切换到deepin-wine环境后，在terminal输入下面的指令：

env WINEPREFIX="$HOME/.deepinwine/Deepin-TIM" /usr/bin/deepin-wine winecfg

在弹出的窗口中选择windows xp，将DPI调大（默认是96），我调成了120

微信的同样，只需要将命令改为：

env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" /usr/bin/deepin-wine winecfg

electron版：

yay -S electron-wechat

5.5 安装其他软件：

tldr(Too Long; Don't Read)：帮你更加高效地学习linux命令

pip install --user tldr

如果下载太慢：

mkdir -p ~/.config/pip
nano ~/.config/pip/pip.conf

写入如下内容

[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple

这样就永久地修改了用户级别的pip下载源

如果安装失败则用：

yay -S tldr

GNU/Linux基本命令的rust替代（更好用）：
https://zhuanlan.zhihu.com/p/347596983​
zhuanlan.zhihu.com图标

ranger：终端文件浏览器

yay -S ranger

wps:中文版，想要英文版把后面那个包去掉

yay -S wps-office wps-office-mui-zh-cn

如果你使用fcitx5的话，还需要修改/usr/bin/wps和/usr/bin/wpp，将下面这行代码加到文件开头：

export QT_IM_MODULE="fcitx5"

修改完的效果为：

ibreoffice：如果你安装时没有装的话（建议）

yay -S libreoffice

其下libreoffice-fresh相当于是beta版，libreoffice-still相当于是stable版

网易云音乐：

yay -S netease-cloud-music

这样得到的版本不能在搜索框输入中文，可以使用我在用的这个版本
ForMat网络安全联盟/netease-cloud-music_For_Arch​
gitee.com图标

高颜值、开发活跃的第三方客户端：
YesPlayMusic​
github.com

yay -S yesplaymusic

qq音乐：

yay -S qqmusic-bin

一个支持全平台听歌的软件：FeelUown

yay -S feeluown

根据装完之后的提示装对应平台的依赖

chrome

yay -S google-chrome

百度网盘：

yay -S baidunetdisk

或者命令行（CLI）的：

yay -S baidupcs-go

坚果云：

yay -S nutstore

为知笔记：全平台通用、有云端同步、支持md的笔记

yay -S wiznote

如果你更喜欢开源软件，这里还有个很好的选择：joplin

yay -S joplin

还有个选择：notion

yay -S notion-app

Typora：我认为最舒适的md编辑器

yay -S typora

flameshot：最强大的截图工具 当你的tim/微信截图不好用的时候，用这个

yay -S flameshot

timeshift：强大好用的备份、回滚系统工具

yay -S timeshift

设置快捷键启动的方式：

设置 -> 快捷键 -> 自定义快捷键 -> 编辑 -> 新建 -> 全局快捷键 -> 命令/URL

设置触发器：设置为你习惯的快捷键 -> 动作：命令/URL这填：/usr/bin/flameshot gui
设置快捷键
设置命令

XDM：Linux下最快的下载神器

yay -S xdman

建议直接去官网下载压缩包安装，比命令行快很多

calibre：电子书管理神器

yay -S calibre

系统托盘那开启夜间颜色控制，不需要安装redshift了
6.字体:

1.使用Windows/Mac OS字体
Fonts (简体中文) - ArchWiki​
wiki.archlinux.org

这里建议直接拷贝字体文件而非链接

2.渲染效果优化
https://zhuanlan.zhihu.com/p/343934880​
zhuanlan.zhihu.com图标
7.美化（饱暖思淫欲

安装latte-dock

yay -S latte-dock

添加一个新空面板，默认会出现在上面，然后删除下面这个面板

在新面板上添加必要的部件：应用程序面板，数字时钟，托盘图标

还可以加全局菜单，显示面板等等

启动latte-dock，下方就会出现一个dock栏，具体配置看自己爱好

移除那个时钟的方法：

右键 配置lattedock 然后右键 那个时钟 移除 就好了

进入设置-外观中选择你喜欢的主题什么的安装并且应用即可

设置-工作空间行为-桌面特效 中可以启用一些华丽的特效

设置-开机和关机 中更改登录屏幕等效果

在设置-工作空间行为-常规行为-点击行为 中改掉单击打开文件/文件夹的设置

修改~下的用户文件夹名称为英文：

先去手动修改文件夹名称，然后在 设置 -> 应用程序 -> 地点 这修改

添加开机动画：
参见这篇教程​
www.jianshu.com

修改grub主题：

去 Gnome-look 找自己喜欢的grub主题按照提示安装就好了

全部设置完之后就可以重启了
8.双系统时间同步

按照 Arch WiKi 的建议，这里修改Windows系统的注册表：

ctrl+X 按 A 以管理员方式打开PowerShell，输入

reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_QWORD /f

如果你的WIndows是32位的，把上述代码中的REG_QWORD改成REG_DWORD

同时禁用Windows的自动同步时间功能

最后附一张图：

图中渐变色怎么做到：先yay -S lolcat然后neofetch | lolcat

装好Manjaro必须要有的习惯：

1.必须要做timeshift，以防你哪天玩坏只能重装

2.每天要开机执行一遍sudo pacman -Syyu

虽说Manjaro相对Arch应该稳定一点，但终究是滚动发行版，还是有滚挂的风险

防止滚挂的最好办法就是 及时滚 长时间不更新必挂