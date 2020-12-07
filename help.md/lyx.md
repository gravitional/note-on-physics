# lyx

使用 LyX 须知：

1. lyx 具有极好的文档--使用它。点击帮助--介绍按钮,将会得到一个简明的介绍。
然后通过 帮助--教程 学习使用 lyx。
1. lyx 是一个"文档处理系统 "。在设计上,它跟通常的文字处理系统不同--它可以让写作变得更容易。但是区别也不是天翻地覆的,不要怕。文档会告诉你怎么使用。
1. lyx的输出比较好看。使用菜单里的 文档--查看[PDF(pdflatex)]或者点击工具栏按钮,亲自试试看。
1. 没错,lyx可以模仿LaTex几乎所有的功能。并且能够导入LaTeX文件。
latex老司机可以瞄一眼下面的教程就行了。然后阅读 "LyX for LaTeX Users"一章。
(对于别的读者:不用担心,你不必礼教LaTeX 才能使用LyX。)
1. lyx有许多特性,为非英语使用者提供便利。另外,键盘组合,工具栏和许多其他特性都是高度可定制的。见 Help->Cuttomization
1. lyx 主页是http://www.lyx.org/. Get information about LyX, subscribe to the LyX mailing list(s), take the LyX Graphical Tour, and more
1. Linux 用户请注意：请检查 latex 发行版 texlive 的语言包是否安装,否则会得到latex 错误。例如在linux发行版(K,X)Ubuntu and Debian上,the package name for the German language is "texlive-lang-german。
安装完语言包后,必须使用LyX menu Tools->Reconfigure 来更新。

## Introduction to LyX

### The Philosophy of LyX

LyX 是文档准备系统,适合用来打公式,交叉引用,参考文献,索引。

lyx 背后的理念是：指定你在做什么,而不是怎么做。
Instead of "What You See Is What You Get," the LyX model is "What You See Is What You Mean" or "WYSIWYM."

+ `Emphasized Style` is used for general emphasis, generic arguments, book titles, names of sections of other manuals, 
and notes from the authors.
+ `Typewriter` is used for program and file names, LyX code and functions.
+ `Sans Serif` is used for menu, button, or dialog box names, and the names of keyboard keys.
+ `Noun Style` is used for people's names.
+ `Bold` is used for LaTeX code

## Getting started with LyX

## Writing Documents

### 脚注

脚注可以复制粘贴,可以把普通文字变成脚注--通过点击工具栏上的按钮。
也可以把脚注变成普通文字,通过 backspace 或者 delete

### 数学

### 杂项

LyX is heavily configurable, 从窗口外观到输出结果样式都是多种方式定制的。

Much configuration is done through `Tools->Preferences`. 
For more information on this, check out `Help->Customization`.
The LyX menus feature keybindings. 

This means that you can do `File->Open` by pressing `Alt+F` followed by `O` or by using the binding which is shown next to it in the menu (`Ctrl+O` by default). 

Keybindings are also configurable. 
For information on this, check out `Help->Customization`.

### SVG Converter

安装软件 inkscape

In the Section Converters

依次填写以下转换规则

***
From: SVG
To: EPS
Converter: `inkscape $$i --export-eps=$$o`
Important: Press add

***
From: SVG
To: PDF (ps2pdf)
Converter: `inkscape --export-area-drawing $$i --export-pdf=$$o`
Important: Press add
        
***
(Optionally) 
From: SVG
To: PNG
Converter: `inkscape $$i --export-png=$$o`
Important: Press add 

***
Press Save 

You need to  maybe `reconfigure`  and restart LyX. 

## 快捷键

+ `ctrl+M` 插入数学
+ `ctrl+shift+M` 插入display数学
+ `c+R` 查看pdf

### 字体

`Edit`--`Text Style`  or `Alt-E-S-C`

Family: The "overall look" of the font. The possible options are,

+ Roman This is the Roman font family. Normally a serif font. It's also the default family. (key binding `Alt+C R`)
+ Sans Serif This is the Sans Serif font family. (key binding `Alt+C S`)
+ Typewriter This is the Typewriter font family. (key binding `Ctrl+Shift+P`)

***
Series: This corresponds to the print weight. Options are:

+ Medium This is the Medium font series. It's also the default series.
+ Bold This is the Bold font series. (key binding `Ctrl+Alt+B`)

***
Shape: As the name implies. Options are:

+ Upright This is the Upright font shape. It's also the default shape.
+ Italic This is the Italic font shape.
+ Slanted This is the Slanted font shape (although it might not be visible in LyX, this is different from italic).
+ Small Caps This is the Small caps font shape.

### 插入latex code

`ctrl+L` or `Insert->Tex code`

## 插入各种特殊格式

`lyx note`: Insert--Note-Lyx Note

`Institute mark`: (Insert->Custom Insets->InstituteMark)

还可以插入 `Short Author`, `Short Date`,但要在相应的`Author` or `Date`环境中,`Insert`菜单中才有相应条目

## lyx pdf 预览问题

[Lyx, Error Converting to Loadable Format for PDFs](https://tex.stackexchange.com/questions/326244/lyx-error-converting-to-loadable-format-for-pdfs)
[How LyX handles figures](https://wiki.lyx.org/LyX/FiguresInLyX)

要在`LyX`屏幕上查看图像,需要与`XForms`或`Qt GUI`库兼容的格式,即`bmp`,`gif`,`jpeg`,`pbm`,`pgm`,`ppm`,`tif`,`xbm`或`mng`,`png`和`xpm`。

出现消息"Error converting to loadable format" 表示无法将图像转换为`PNG`或任何上面的格式。

一般来说需要增加已知`converters`的列表。

### 添加转换器

可以通过在命令行中运行LyX来获取有关转换过程的更多信息：

```bash
lyx -dbg graphics
```

如果图形输出有问题,可以从在上述命令生成的输出中找到原因。

要在LyX屏幕上查看图形,LyX必须从`EncapsulatedPostScript`转换到可加载的图形格式。在`tools-preference-Converters`部分可以看到配置的转换器机制。
添加新的转换器将导致类似下面一行

```latex
\converter "eps" "png" "my_ps2png $$i $$o" ""
```

被添加到您的`.lyx/preferences`文件中。该行使用外部程序 `my_ps2png` 定义了从`EncapsulatedPostScript`到`PNG`格式的转换器。
占位符`$$i`和`$$o`由LyX替换为输入文件和输出文件的名称。

如果LyX无法通过转换路径(可能有许多步骤),从`EncapsulatedPostScript`转换到上面列出的可加载格式中的一种,则默认为使用Shell脚本`convertDefault.sh`。
后者是`ImageMagick`的`convert` utility 的简单`wrapper`。显然,只有在安装了 `convert` 且`convert`可以处理从A格式到B格式的转换时,它才可以工作。

如果经过以上步骤,`LyX`仍然无法加载图形,它将在图片位置上输出消息"Error converting to loadable format"。如果出现此类消息,则需要增加(augment)已知转换器的列表。

添加`EPS-> PNG`转换器的示例(对于Mac OS X)。

+ 安装ImageMagick。安装后,通过在终端中键入`covert /path/test.eps /path/test.png`(对于Mac OS X),检查将`eps`转换为`png`的转换器是否正常工作。
+ 在`Lyx->Preferences->File Handling->Converters`中,将EPS添加到Lyx中的PNG转换器。
选择`EPS-> PDF`,然后将`格式`从`PDF`更改为`PNG`。在转换器行中,键入`convert $$i $$o`,然后按添加并保存。
+ 将`convert`命令所在的路径添加到`Lyx`。例如 `/opt/ImageMagick/bin` (for Mac OS X)。
转到`Lyx>Preferences>Paths>Path prefix`,添加`:/opt/ImageMagick/bin`到路径的末尾。保存路径并退出Lyx。
+ 再次运行Lyx,然后打开包含`eps`图形的文件,现在此文件应该在预览中显示`png`图形。

### Imagemagick 安全策略

[ImageMagick security policy 'PDF' blocking conversion](https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion)

linux 下 lyx `pdf` 无法预览,可能是由于`Imagemagick`的安全策略引起的。你需要更改`/etc/ImageMagick-7/policy.xml`中ImageMagick的策略。 
例如在ArchLinux中(2019年5月1日),以下行未注释：

```xml
<policy domain="coder" rights="none" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />
```

只需把上面这几行放进`<!--` and `-->`中注释掉,然后pdf转换应该就能工作了。
