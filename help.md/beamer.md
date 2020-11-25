# beamer

参考：
[使用 Beamer 制作学术讲稿 ][]
[beamer class][]

[使用 Beamer 制作学术讲稿 ]: https://www.latexstudio.net/archives/2825.html

[beamer class]: https://mirrors.ustc.edu.cn/CTAN/macros/latex/contrib/beamer/doc/beameruserguide.pdf

## lyx

使用 xelatex 进行编译，可以设置`Document Settings`--`Fonts`--`LaTeX font encoding: None fontenc`
在同一个页面，如果勾选`Use non-Tex fonts`，即可选择系统自带的字体，即可显示中文

对应 `latex`设置为

```latex
\setmainfont[Mapping=tex-text]{Times New Roman}
\setsansfont[Mapping=tex-text]{Noto Sans CJK SC}
\setmonofont{Noto Sans Mono CJK SC}
```

另外，`Document Settings`--`Language`中可设置语言，以及`xeTeX,utf-8`编码。

可以在`Insert`菜单栏中插入`beamer`特有的格式。

## 5 创造一个演示的参考Guidelines for Creating Presentations 

### 组织一个frameStructuring a Frame 

+ 使用块环境，例如 `block`, `theorem`, `proof`, `example` 等。
+ 优先使用`enumerations` and `itemize` 而不是纯文本环境。
+ 在定义几件事时使用`description`。
+ 请勿使用超过两个级别的`“subitemizing.”`。`beamer`支持三个级别，但您不应使用三层。通常，您甚至都不应该使用第二个。请改用优质的图形。
+ 不要创建无尽的逐项`itemize`或`enumerate`列表。
+ 不要逐段显示列表。
+ 强调是创建结构的重要组成部分。使用`\alert`突出显示重要的内容。适用对象可以是一个单词或整个句子。但是，不要过度使用突出显示，因为这会抵消效果。如 `\alert{prime number}`
+ 使用列，如下：

```latex
\begin{columns}[t]      
\column
{.22\textwidth}
%\pause
\column{.65\textwidth}
\end{columns}
 ```

+ 切勿使用脚注(footnotes.)。他们不必要地打乱了阅读流程。脚注中所说的如果重要，应放在普通文本中；或不重要，应将其省略（尤其是演示文稿中）。
+ 使用`quote`或`quotation`排版引文。

```latex
\begin{quotation/quote}<⟨action specification⟩>
⟨environment contents⟩
\end{quotation/quote}
```

+ 除较长的书目外，请勿使用选项`allowframebreaks`。
+ 请勿使用较长的参考书目。

## 创建覆盖 9 creating overlays  

### 递增指定 Incremental Specifications 

`+-` 会被替换成一个变量`beamerpauses`的值，它在每张`frame`上重置为`1`，每个`overlay specification` 使它增加`1`。这样可以方便的实现递增 uncover 效果。
另外，`alert` 表示强调

```latex
\begin{itemize}
\item<+-| alert@+> Apple
\item<+-| alert@+> Peach
\item<+-| alert@+> Plum
\item<+-| alert@+> Orange
\end{itemize}
```

例如第一个 `<+-| alert@+>` 被替换成 `<1-| alert@1>`
由于`itemize`支持设置默认 overlay specification，所以也可以这么写

```latex
\begin{itemize}[<+-| alert@+>]
\item Apple
\item Peach
\item Plum
\item Orange
\end{itemize}
```

## Structuring a Presentation: The Local Structure

### Highlighting

`\structure<⟨overlay specification⟩>{⟨text⟩}`

给定的文本被标记为结构的一部分，也就是说，它应该可以帮助观众看到演示文稿的结构。
如果存在`⟨overlay specification⟩`，则该命令仅对指定的幻灯片有效。

```latex
\begin{structureenv}<⟨overlay specification⟩>
⟨environment contents⟩
\end{structureenv}
```

`\structure` 命令的环境版本。

## 17 colors

### Default and Special-Purpose Color Themes 默认和特殊颜色主题

默认颜色主题中的主要颜色如下：

+ `normal text` is black on white.
+ `alerted text` is red.
+ `example text` is a dark green (green with 50% black).
+ `structure` is set to a light version of MidnightBlue (more precisely, 20% red, 20% green, and 70% blue)

`example`,`exampleblock`是环境

## beamer 加参考文献

[在 Beamer 中使用参考文献][]

[在 Beamer 中使用参考文献]: https://guyueshui.github.io/post/use-reference-in-beamer/

主要是要把参考文献生成部分的命令放在`frame`里面，其他的和平常的用法一样。
指定参考文献库，指定参考文献风格。

```latex
\usepackage{cite}
% Removes icon in bibliography
\setbeamertemplate{bibliography item}[text]
...
\begin{document}
...
%%% end of your presentation slides
\begin{frame}[allowframebreaks]{References}
    %\bibliographystyle{plain}
    \bibliographystyle{amsalpha}
    %\bibliography{mybeamer} also works
    \bibliography{./mybeamer.bib}
\end{frame}
\end{document}
```

bibtex 标准 style `plain`,`unsrt`,`alpha`,`abbrv`

用find 查找到的本机的安装的支持`nat`的`bst`:

+ /bst/shipunov/rusnat.bst
+ /bst/bib-fr/abbrvnat-fr.bst
+ /bst/bib-fr/plainnat-fr.bst
+ /bst/bib-fr/unsrtnat-fr.bst
+ /bst/ksfh_nat/ksfh_nat.bst
+ /bst/natbib/unsrtnat.bst
+ /bst/natbib/plainnat.bst
+ /bst/natbib/abbrvnat.bst
+ /bst/persian-bib/plainnat-fa.bst
+ /bst/nature/naturemag.bst
+ /bst/sort-by-letters/plainnat-letters.bst
+ /bst/sort-by-letters/frplainnat-letters.bst
+ /bst/phfnote/naturemagdoi.bst
+ /bst/beebe/humannat.bst
+ /bst/swebib/sweplnat.bst
+ /bst/upmethodology/upmplainnat.bst
+ /bst/dinat/dinat.bst
+ /bst/din1505/natdin.bst

## beamer中文

[数学字体](https://mirrors.bfsu.edu.cn/CTAN/info/Free_Math_Font_Survey/en/survey.html)
[xeCJK中文字体包](https://www.ctan.org/pkg/xecjk)
[如何使用 LaTeX/XeLaTeX 编辑中文？](https://zhuanlan.zhihu.com/p/27739925)
[全面总结如何在 LaTeX 中使用中文 (2020 最新版)](https://jdhao.github.io/2018/03/29/latex-chinese.zh/)

这里介绍 LaTeX 编辑中文的两种方式。注意，虽说是使用 LaTeX，实际使用的是 XeLaTeX 引擎。具体方法如下：

### 使用xeCJK宏包

***
[How to get Beamer Math to look like Article Math](https://tex.stackexchange.com/questions/34265/how-to-get-beamer-math-to-look-like-article-math)
如果你仅仅需要在文档中使用有限的一些中文字符，你可以使用 `xeCJK` 宏包，然后使用 `xelatex` 命令编译源文件。

***
[Beamer的中文自动换行问题](http://softlab.sdut.edu.cn/blog/subaochen/2018/11/)

在LyX中，标准的Beamer无法实现中文自动换行，观察其tex源文件可以发现，其导入的package为：
`\usepackage{fontspec}`
而在导言区使用
`\usepackage{xeCJK}`
就可以支持中文自动换行了。

***
beamer 有个选项，可以更改数学字体的显示方式，`\usefonttheme[onlymath]{serif}`可以使数学字体风格为`serif`

一个简单可运行的例子如下：

```latex
%!TEX program=xelatex
% 该文件使用 xelatex 命令可以编译通过
\documentclass[12pt, a4paper]{article}
\usepackage{fontspec}
\usepackage[slantfont, boldfont]{xeCJK}

% 设置英文字体
\setmainfont{Microsoft YaHei}
\setsansfont{Comic Sans MS}
\setmonofont{Courier New}

% 设置中文字体
\setCJKmainfont[Mapping=tex-text]{Noto Sans CJK SC}
\setCJKsansfont[Scale=0.7,Mapping=tex-text]{Source Han Sans SC}
\setCJKmonofont[Scale=0.7]{Noto Sans Mono CJK SC}


% 中文断行设置
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt

\title{测试}
\author{东}
\date{2016年6月6日}
\begin{document}
\maketitle
\begin{center}
满纸荒唐言\\
一把辛酸泪\\
都云作者痴\\
谁解其中味\\
\end{center}
\begin{verse}
\texttt{Stray birds of summer come to my window to sing and fly away}. \\
\textsf{And yellow leaves of autumn, which have no songs}, \\
\textrm{flutter and fall there with a sign}.\\
\hfill \emph{RabindranathTagore}
\end{verse}
\begin{verse}
\texttt{夏天的飞鸟}，\textsf{飞到我的窗前唱歌}，\textrm{又飞去了}。\\
秋天的黄叶，它们没有什么可唱，只叹息一声，飞落在那里。\\
\hfill \emph{罗宾德拉纳特·泰戈尔}
\end{verse}
\end{document}
```

对于中文来说，`\setCJKmainfont{}` 命令用来设置正文使用的中文字体，同时也是 `\textrm{}` 命令使用的字体。
`\setCJKmonofont{}` 用来设置 `\texttt{}` 命令中的中文使用的字体。`\setCJKsansfont{}` 用来设置 `\textsf{}` 命令中的中文使用的字体。

那么问题来了，如何找到可用的中文字体呢？如果你已经安装了 TeX Live，那么很容易找到中文字体。在系统的命令行，使用下面的命令：

```bash
fc-list :lang=zh
```

此种方式试用于有特定文档类型的情况，如 `beamer` 。

***
lyx 的设置

```latex
\batchmode
\makeatletter
\def\input@path{{/home/tom/note/chpt/}}
\makeatother
\documentclass[utf8,dvipsnames,svgnames,x11names,hyperref]{beamer}
\usepackage{amstext}
\usepackage{amssymb}
\usepackage{fontspec}
\setmainfont[Mapping=tex-text]{Noto Sans CJK SC}
\setsansfont[Scale=0.7,Mapping=tex-text]{Source Han Sans SC}
\setmonofont[Scale=0.7]{Noto Sans Mono CJK SC}
\usepackage{mathrsfs}

```

还可以同时用`Scale=0.7`调节大小

### 使用 ctexbeamer 文档类型：

```latex
%!TEX program=xelatex
\documentclass{ctexart}
\begin{document}
    你好！
\end{document}
```

此种方式比较简便，也更适合中文排版要求，建议选用。

## 添加当前位置

texdoc beamer : 101

```latex
\frame{\tableofcontents[currentsection]}
```
