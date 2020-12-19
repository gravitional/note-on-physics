# macos

## homebrew

`Homebrew` 是一款 Mac OS 平台下的软件包管理工具，拥有安装、卸载、更新、查看、搜索等很多实用的功能。

`Homebrew` 的两个术语：

`Formulae` ：软件包，包括了这个软件的依赖、源码位置及编译方法等；
`Casks`：已经编译好的应用包，如图形界面程序等。
`Homebrw`相关的几个文件夹用途：

`bin` ：用于存放所安装程序的启动链接（相当于快捷方式）
`etc` ：`brew` 安装程序的配置文件默认存放路径
`Library`：`Homebrew` 系统自身文件夹
`Cellar` ：通过 `brew` 安装的程序将以 `[程序名/版本号]` 存放于本目录下
常用的 `brew` 命令：

查看`brew`版本：`brew -v`
更新`brew`版本：`brew update`
本地软件库列表：`brew list`
查看软件库版本：`brew list --versions`
查找软件包：`brew search xxx` （xxx为要查找软件的关键词）
安装软件包：`brew install xxx` （xxx为软件包名称）
卸载软件包：`brew uninstall xxx`
安装软件：`brew cask install xxx`（xxx为软件名称）
卸载软件：`brew cask uninstall xxx`
查找软件安装位置：`which xxx` （xxx为软件名称）
`Homebrew` 提供了两种安装软件的方式，`brew install` 和 `brew cask install`，下面对两种方式进行一些解释说明。

### brew install

`brew` 是下载源码解压，然后 `./configure && make install` ，同时会包含相关依存库，并自动配置好各种环境变量。
对于对程序员只需通过简单的指令，就能快速安装和升级本地的各种开发环境，非常快捷方便。

### brew cask install

`brew cask` 是针对已经编译好了的应用包（`.dmg/.pkg`）下载解压，然后放在统一的目录中（`Caskroom`），省掉了自己下载、解压、安装等步骤。
这个对一般用户来说会比较方便，包含很多在 `AppStore` 里没有的常用软件。

简单来说，

`brew install` 用来安装一些不带界面的命令行工具和第三方库。
`brew cask install` 用来安装一些带界面的应用软件。

[brew install 和 brew cask install 的区别](https://zhuanlan.zhihu.com/p/138059447)

## mac 自带的中文字体

查找 `字体册`, `font Book.app`应用.

`macos` 的字体存放在`/System/Library/Fonts`目录下，`macos` 预装的中文字体为，

```bash
Apple LiGothic Medium
Apple LiSung Light
Apple SD Gothic Neo Regular
AppleGothic Regular
AppleMyungjo Regula
Baoli SC Regular
BiauKai Regular
GB18030 Bitmap Regular
Hannotate SC Regular
HanziPen SC Regular
Hei Regular
Heiti TC Light
Hiragino Sans CNS W3
Hiragino Sans GB W3
Kai Regular
Kaiti SC Regular
Lantinghei SC Extralight
Libian SC Regular
LiHei Pro Medium
LingWai SC Medium
LiSong Pro Light
Nanum Gothic Regular
PCMyungjo Regular
PingFang SC Regular
SimSong Regular
Songti SC Regular
STFangsong Regular
STHeiti Light
STKaiti Regular
STSong Regular
Wawati SC Regular
Weibei SC Bold
Xingkai SC Light
Yuanti SC Regular
Yuppy SC Regular
```

#