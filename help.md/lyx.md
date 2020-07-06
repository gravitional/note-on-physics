# lyx

使用 LyX 须知：

1. lyx 具有极好的文档--使用它。点击帮助--介绍按钮，将会得到一个简明的介绍。
然后通过 帮助--教程 学习使用 lyx。
1. lyx 是一个“文档处理系统 ”。在设计上，它跟通常的文字处理系统不同--它可以让写作变得更容易。但是区别也不是天翻地覆的，不要怕。文档会告诉你怎么使用。
1. lyx的输出比较好看。使用菜单里的 文档--查看[PDF(pdflatex)]或者点击工具栏按钮，亲自试试看。
1. 没错，lyx可以模仿LaTex几乎所有的功能。并且能够导入LaTeX文件。
latex老司机可以瞄一眼下面的教程就行了。然后阅读 “LyX for LaTeX Users”一章。
（对于别的读者:不用担心，你不必礼教LaTeX 才能使用LyX。）
1. lyx有许多特性，为非英语使用者提供便利。另外，键盘组合，工具栏和许多其他特性都是高度可定制的。见 Help->Cuttomization
1. lyx 主页是http://www.lyx.org/. Get information about LyX, subscribe to the LyX mailing list(s), take the LyX Graphical Tour, and more
1. Linux 用户请注意：请检查 latex 发行版 texlive 的语言包是否安装，否则会得到latex 错误。例如在linux发行版(K,X)Ubuntu and Debian上，the package name for the German language is “texlive-lang-german。
安装完语言包后，必须使用LyX menu Tools->Reconfigure 来更新。

## Introduction to LyX

### The Philosophy of LyX

LyX 是文档准备系统，适合用来打公式，交叉引用，参考文献，索引。

lyx 背后的理念是：指定你在做什么，而不是怎么做。
Instead of “What You See Is What You Get,” the LyX model is “What You See Is What You Mean” or “WYSIWYM.”

+ `Emphasized Style` is used for general emphasis, generic arguments, book titles, names of sections of other manuals, 
and notes from the authors.
+ `Typewriter` is used for program and file names, LyX code and functions.
+ `Sans Serif` is used for menu, button, or dialog box names, and the names of keyboard keys.
+ `Noun Style` is used for people's names.
+ `Bold` is used for LaTeX code

## Getting started with LyX

## Writing Documents

### footnote

脚注可以复制粘贴，可以把普通文字变成脚注--通过点击工具栏上的按钮。
也可以把脚注变成普通文字，通过 backspace 或者 delete

### Using Math

### Miscellaneous

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
