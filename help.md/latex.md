# latex.md

## 浮动体

[liam.page][]

插图和表格通常需要占据大块空间，所以在文字处理软件中我们经常需要调整他们的位置。`figure` 和 `table` 环境可以自动完成这样的任务；这种自动调整位置的环境称作浮动体(`float`)。我们以 `figure` 为例。

```latex
\begin{figure}[htbp]
\centering
\includegraphics{a.jpg}
\caption{有图有真相}
\label{fig:myphoto}
\end{figure}
```

`htbp` 选项用来指定插图的理想位置，这几个字母分别代表 `here`, `top`, `bottom`, `float page`，也就是就这里、页顶、页尾、浮动页（专门放浮动体的单独页面或分栏）。`\centering` 用来使插图居中；`\caption` 命令设置插图标题，`LaTeX` 会自动给浮动体的标题加上编号。注意 `\label` 应该放在标题命令之后。

如果你想了解 `LaTeX` 的浮动体策略算法细节，你可以参考我博客中关于[浮动体的系列文章][]

如果你困惑于"为什么图表会乱跑"或者"怎样让图表不乱跑"，请看[我的回答][]。

[liam.page]: https://liam.page/2014/09/08/latex-introduction/

[浮动体的系列文章]: https://liam.page/series/#LaTeX-%E4%B8%AD%E7%9A%84%E6%B5%AE%E5%8A%A8%E4%BD%93

[我的回答]: https://www.zhihu.com/question/25082703/answer/30038248

## pdftex/xetex --help

```bash
Usage: xetex [OPTION]... [TEXNAME[.tex]] [COMMANDS]
   or: xetex [OPTION]... \FIRST-LINE
   or: xetex [OPTION]... &FMT ARGS
```

Run XeTeX on `TEXNAME`, usually creating `TEXNAME.pdf`.
Any remaining `COMMANDS` are processed as `XeTeX input`, after `TEXNAME` is read.

If the first line of `TEXNAME` is `%&FMT`, and `FMT` is an existing `.fmt` file, use it. Else use `NAME.fmt`, where `NAME` is the program invocation name, most commonly `xetex`.

(**note:** `.FMT` : `Format File Tex`)

Alternatively, if the first non-option argument begins with a `backslash`, interpret all non-option arguments as a line of `XeTeX input`.

Alternatively, if the first non-option argument begins with a `&`, the next word is taken as the `FMT` to read, overriding all else.
Any remaining arguments are processed as above.

If no arguments or options are specified, prompt for input.

| options | effect |
| ----- | ----- |
| `[-no]-file-line-error`  |   disable/enable file:line:error style messages |
| `-fmt=FMTNAME`           |   use FMTNAME instead of program name or a %& line |
| `-halt-on-error`         |   stop processing at the first error |
| ------------------------ | ------------------------ |
| `-interaction=STRING`    |   set interaction mode (STRING=batchmode/nonstopmode/scrollmode/errorstopmode) |
| ------------------------ | ------------------------ |
| `-output-comment=STRING` |   use STRING for XDV file comment instead of date |
| `-output-directory=DIR`  |   use existing DIR as the directory to write files in |
| `-output-driver=CMD`     |   use CMD as the XDV-to-PDF driver instead of xdvipdfmx |
| `-no-pdf`                |   generate XDV (extended DVI) output rather than PDF |
| ------------------------ | ------------------------ |
| `[-no]-parse-first-line` |   disable/enable parsing of first line of input file |
| ------------------------ | ------------------------ |
| `[-no]-shell-escape`     |   disable/enable \write18{SHELL COMMAND} |
| `-shell-restricted`      |   enable restricted \write18 |
| ------------------------ | ------------------------ |
| `-help`                  |   display this help and exit |
| `-version`               |   output version information and exit |

```bash
pdflatex -halt-on-error file.tex 1 > /dev/null
[[ $? -eq 1 ]] && echo "msg in case of erros" && exit
```

Email bug reports to <xetex@tug.org>.

## latex with powershell

Invoke-Expression $("lualatex" + " " + "-halt-on-error " + "-output-directory=temp -shell-escape -interaction=nonstopmode " + "test.tikz.tex" ) > ./null

## 简单的规则

1. 空格：`Latex` 中空格不起作用。
1. 换行：用控制命令“`\\`”,或“`\newline`”.
1. 分段：用控制命令“`\par`” 或空出一行。
1. 换页：用控制命令“`\newpage`”或“`\clearpage`”
1. 特殊控制字符: `#`，`$`, `%`, `&`, `-` ,`{}`, `^`, `~`

## 子方程

```latex
\begin{subequations}
```

创建 子方程 环境

## 二元运算符

`+` 号后面 加 `{}` , 变成二元运算符，强制排版，用在多行公式换行中

`=` 号也是同理

## spacing in math mode

`/,`  `/:` `/;` `/quad` `/qquad`

## Placeholders

Use Placeholders: if the completed commands have options which need to be filled out, "place holder" are put at this positions and they can be jumped to by using `Ctrl+Right/Ctrl+Left`

## shell-escape

What does --shell-escape do?

[tex.stackexchange.com](https://tex.stackexchange.com/questions/88740/what-does-shell-escape-do)

>Sometimes, it is useful to be able to run external commands from inside the tex file : it allows for example to externalize some typesetting, or to use external tools like bibtex. This is available via the \write18 tex primitive.
>The problem is that it allows for almost everything. A tex file is meant to be portable, and one shouldn't have to fear any security issue when compiling a third-party file. So by default, this primitive is disabled.
>If an user needs to use it, he needs to explicitely tell the compiler that he trusts the author of the file with shell interaction, and that's exactly the point of the optional --shell-escape argument.

## align环境如何对齐

多&情况下flalign和align环境是如何对齐的：
[对齐@CSDN][]

根据 `&`（假设`n`个）一行被分为`n+1`列。从左向右将列两个分为一组，第一组紧靠页左侧，最后一组紧靠页左侧，其余组均匀散布在整个行中。当公式比较短时，中间可能会有几段空白。
需要注意的是：
每一组内部也是有对齐结构的！它们在所在位置上向中间对齐的，即第一列向右对齐，第二列向左对齐。
所谓紧靠页左/右是在进行了组内对齐调整之后，最长的一块紧靠上去。也就是说对于长度不一两行，较短的那一行是靠不上去的。
如果总共有奇数个列，及最后一组只有一个列，则它右对齐到页右侧，即所有行的最后一列的右侧都靠在页右侧。

[对齐@CSDN]: https://blog.csdn.net/yanxiangtianji/article/details/54767265

## Token not allowed

Hyperref - Token not allowed [duplicate]

The following code:

```latex
\subsection{The classes $\mathcal{L}(\gamma)$}
```

generates the errors:

```shell
Package hyperref Warning: Token not allowed in a PDF string (PDFDocEncoding):
(hyperref)      removing `math shift' on input line 1938.
```

>The PDF bookmarks are a different thing than the table of contents. The bookmarks are not typeset by TeX: they simply are strings of characters, so no math or general formatting instructions are allowed.
>The easiest method to avoid the warnings is to use \texorpdfstring:

```latex
\subsection{The classes \texorpdfstring{$\mathcal{L}(\gamma)$}{Lg}}
```

>where in the second argument you put the best approximation possible; after all the bookmarks are only a guide for consulting the document.

## 在文中使用链接

使用宏包 `hyperref` 来制作

```latex
\usepackage[dvipdfm, %
pdfstartview=FitH, %
bookmarks=true,
CJKbookmarks=true, %
bookmarksnumbered=true, %
bookmarksopen=true, %
colorlinks=true, %注释掉此项则交叉引用为彩色边框 %
%(将colorlinks和pdfborder同时注释掉) %
pdfborder=001, %注释掉此项则交叉引用为彩色边框 %
citecolor=magenta, % magenta , cyan %
linkcolor=blue,
%linktocpage
%nativepdf=true %
linktocpage=true, %
]{hyperref}
```

### email链接

```latex
\href{mailto:michaelbibby@gmail.com}{给我电邮}
```

### URL链接

链接有颜色,显示为“OpenBSD官方网站”，链接到`http://www.openbsd.org`

```latex
\href{http://www.openbsd.org}{OpenBSD官方网站}
```

只显示`URL`

```latex
\url{http://www.openbsd.org}
```

显示URL，但是不做链接和跳转：

```latex
\nolinkurl{http://www.openbsd.org}
```

[LaTeX技巧159：如何在文中使用链接][]

[LaTeX技巧159：如何在文中使用链接]: https://www.latexstudio.net/archives/7741.html

## 反向搜索设置 SumatraPDF

```code
"C:\Users\Thomas\AppData\Local\Programs\Microsoft VS Code\Code.exe"  "C:\Users\Thomas\AppData\Local\Programs\Microsoft VS Code\resources\app\out\cli.js" -r -g "%f:%l"
```

[使用VSCode编写LaTeX][]

[使用VSCode编写LaTeX]: https://blog.csdn.net/fenzang/article/details/99805315

## BibTeX生成参考文献列表 

[LaTeX技巧829:使用BibTeX生成参考文献列表][]

[LaTeX技巧829:使用BibTeX生成参考文献列表]: https://www.latexstudio.net/archives/5594

### bst 和 bib 格式简介

BibTeX 涉及到两种特有的辅助的文件格式： `bst` 和 `bib` 。

`bst` 是 (B)ibliography (ST)yle 的缩写。顾名思义，和 `sty` 文件是 `style` 的缩写一样，`bst` 文件控制着参考文献列表的格式。
在这里说的"格式"，主要指参考文献列表中的编号、排序规则、对人名的处理（是否缩写）、月份的处理（是否缩写）、期刊名称的缩写等。

bib 是 BibTeX 定义的"参考文献数据库"。
通常，我们会按照 BibTeX 规定的格式，向 bib 文件写入多条文献信息。
在实际使用时，我们就可以根据 bib 文件中定义的文献标记（label），
从数据库中调取文献信息，继而排版成参考文献列表。 
值得注意的是，bib 是一个数据库，其中的内容并不一定等于 LaTeX 排版参考文献列表时的内容。也就是说，如果 bib 数据库中有 10 条文献信息，并不一定说 LaTeX 排版出来的 PDF 文件中，参考文献列表里也一定有 10 条。
实际排版出来的参考文献列表中有多少条文献，实际是哪几条，具体由文中使用的 `\cite` 命令（以及 `\nocite` 命令）指定。如果没有使用 `\cite` 命令调取文献信息，那么即使在 `bib` 文件中定义了文献信息，也不会展现在参考文献列表中。
很多人对此误解甚深，于是经常有人问道"为什么我在 bib 文件里写的文献，不出现在参考文献中"之类的问题。

### BibTeX 的工作流程

介绍中提到，BibTeX 是一个参考文献格式化工具。
这个定义，给 BibTeX 的用处做了良好的界定：BibTeX 不是用来排版参考文献的，更不是个排版工具，它只是根据需要，按照（ `bst` 文件规定的）某种格式，将（ `bib` 文件中包含的）参考文献信息，格式化 为 LaTeX 能够使用的列表信息。

清楚了 `BibTeX` 需要做的事情（用软件工程的话说，就是清楚了 `BibTeX` 的 `API` ），我们就可以理清 `BibTeX` 的工作流程。

### 知道需要哪些参考文献信息

既然 `BibTeX` 会根据需要 格式化数据，那么首先要解决的问题就是：`BibTeX` 如何了解此处的"需求"。 对 `BibTeX` 稍有了解的读者可能知道，运行 `BibTeX` 的命令行命令是：

`bibtex foo.aux` # 其中后缀名 `.aux` 可以省略

实际上，BibTeX 正是通过读取 `aux` 文件中的 `\citation{}` 标记，来确定用户需要哪些参考文献的。 举个例子，假设用户用 LaTeX 编译了以下代码：

```latex
\documentclass{article}
\begin{document}
bar\cite{baz}
\end{document}
```

如果该文件名为 `foo.tex`，那么就会生成 `foo.aux`。其内容大约是：

```latex
\relax
\citation{baz}
```

在这里，`\relax` 表示休息一会儿，什么也不做；`\citation` 则是由 `tex` 文件中的 `\cite` 命令写入 `aux` 文件的标记。
它说明了：用户需要标记为 `baz` 的参考文献信息。 
当 BibTeX 读入 `aux` 文件的时候，它就会记录下所有 `\citation` 命令中的内容（即文献标记——`label`），这样就知道了用户需要哪些参考文献信息。

### 了解文献列表格式以及读取文献数据库

当 BibTeX 清楚了用户需要哪些文献信息，接下来自然应该搞清楚用户想要什么样的格式。
而知道了格式之后，就可以从数据库中抽取所需的文献信息，按照格式准备数据。
为了讲清楚这个步骤，我们对上述 LaTeX 代码做些许的修改。

```latex
\documentclass{article}
\begin{document}
\bibliographystyle{unsrt}
bar\cite{baz}
\bibliography{foobar}
\end{document}
```

同样，我们将它保存为 foo.tex，经由 LaTeX 编译之后得到一个 `foo.aux` 文件，其内容如下：

```latex
\relax
\bibstyle{unsrt}
\citation{baz}
\bibdata{foobar}
```

简单的对比，不难发现：

`foo.tex` 中新增的 `\bibliographystyle{unsrt}` 与 `aux` 文件中的 `\bibstyle{unsrt}` 相对应。

`foo.tex` 中新增的 `\bibliography{foobar}` 与 aux 文件中的 `\bibdata{foobar}` 相对应。

根据命令的名字，我们很容易猜测各个命令的作用。

tex 文件中的 `\bibliographystyle` 指定了用户期待的参考文献列表格式文件，并将其写入 `aux` 文件备用，通过 `\bibstyle` 标记。
与此同时，`\bibliography` 命令则用 `\bibdata` 在 `aux` 文件中记录了参考文献数据库的名字（不含扩展名）。
`在这里，unsrt` 是 `unsort` 的缩写，它对应着 `unsrt.bst` 文件，是大多数 TeX发行版自带的标准格式文件之一；
`foobar` 则对应着 `foobar.bib` 文件，该文件是用户自己编写或生成的参考文献数据库。

### 实际操作看看

我们假设上述 `foobar.bib` 文件有如下内容：

```bib
@BOOK{
    baz,
    title = {Dummy Book},
    publisher = {Egypt},
    year = {321},
    author = {The King}
}
```

我们在命令行执行以下操作：

```bash
latex foo.tex   # .tex 可以省略
bibtex foo.aux  # .aux 可以省略
```

我们会发现， `BibTeX` 生成了两个文件：`foo.bbl` 和 `foo.blg`。
其中 `foo.bbl` 的内容如下：

```latex
\begin{thebibliography}{1}

\bibitem{baz}
The King.
\newblock {\em Dummy Book}.
\newblock Egypt, 321.

\end{thebibliography}
```

显然，这就是一个标准的 `LaTeX` 环境。对 `LaTeX` 参考文献排版稍有了解的读者可能知道 `thebibliography` 环境正是 `LaTeX` 中手工编排参考文献时使用的环境。
因此，`foo.bbl` 就是 `BibTeX` 格式化输出的结果，`LaTeX` 只需要将该文件的内容读入，就能在相应的位置输出格式化之后的参考文献列表了。
接下来，我们看看 `foo.blg` 的内容。`blg` 实际是 `BibTeX Log` 的缩写，亦即这是一个日志文件。

```bibtex
This is BibTeX, Version 0.99d (TeX Live 2015)
Capacity: max_strings=35307, hash_size=35307, hash_prime=30011
The top-level auxiliary file: foo.aux
The style file: unsrt.bst
Database file #1: foobar.bib
You've used 1 entry,
...
```

我们看到，BibTeX 打出的日志文件中，记录了读入 `aux/bst/bib` 文件的情况。
特别地，记录了所需的参考文献条目（entry）的数量（此处为 1）。 
日志中值得注意的地方是在提到 bib 文件时，使用了 `#1` 的标记。既然存在 `#1`，那么合理推测也可以存在`#2`。
也就是说，BibTeX 可能支持两个或更多的 `bib` 数据库共同工作。
具体如何实现，请读者自己阅读相关资料（手册或 Google 检索）后实验。 
紧接着，我们再执行一次 `LaTeX` ：

```bash
latex foo.tex
```

首先，来看看 `aux` 文件会发生什么变化：

```latex
\relax
\bibstyle{unsrt}
\citation{baz}
\bibdata{foobar}
\bibcite{baz}{1}
```

相比上一次的 `foo.aux`，在读入 BibTeX 之后，LaTeX 向 `aux` 文件写入了更多的信息。
这里 `\bibcite{baz}{1}` 将 `baz` 这一参考文献标记（label）与参考文献编号（数字 `1`）绑定起来了。 
接下来，我们看看 dvi 文件的内容：`foo.pdf`不难发现，由于读入了 `foo.bbl` 文件，参考文献列表已经正确展现出来了。
然而，正文中依然有一个问号。 实际上，LaTeX 需要 `aux` 文件中的 `\bibcite` 命令，将参考文献标记与参考文献编号关联起来，从而在 tex文件中的 `\cite` 命令位置填上正确的参考文献编号。
我们注意到，在我们第二次执行 `LaTeX` 命令编译之前，`foo.aux` 文件中是没有这些信息的，直到编译完成，这些信息才被正确写入。因此，第二次执行 `LaTeX` 命令时，`LaTeX` 还不能填入正确的文献编号，于是就写入了一个问号作为占位符。
 解决这个问题的办法也很简单——此时 `aux` 文件中已经有了需要的信息，再编译一遍就好了。

```latex
latex foo.tex
```

如果没有意外，此时的 `foo.dvi` 文件应该看起来一切正常了。

### 小结

`BibTeX` 是一个参考文献格式化工具，它会根据需要，按照（bst 文件规定的）某种式，将（bib 文件中包含的）参考文献信息，格式化 为 LaTeX 能够使用的列表信息。

+ 正确使用 BibTeX 处理参考文献，需要先用 `(Xe/PDF)LaTeX` 编译 `tex` 文件，生成 `aux` 辅助文件。
+ 执行 `BibTeX` 将读入 `aux` 文件，搞清楚用户需要哪些文献。
+ 紧接着，BibTeX 根据 `aux` 文件中的内容，找到正确的 `bst` 和 `bib` 文件，并将参考文献信息格式化为 `LaTeX` 的 `thebibliography` 环境，作为 `bbl` 文件输出。
+ 第二次执行 `(Xe/PDF)LaTeX` 将会读入新生成的 `bbl` 文件，同时更新 `aux` 文件。此时，参考文献列表将会正常展示，但是正文中的引用标记显示为问号。
+ 第三次执行 `(Xe/PDF)LaTeX` 将会读入 `bbl 文件和更新过后的 `aux` 文件。此时，参考文献相关内容都正常显示。

因此，总的来说，想要正确使用 `BibTeX` 协同 `LaTeX` 处理参考文献，需要编译四次：

```bash
(xe/pdf)latex foo.tex   # 表示使用 latex, pdflatex 或 xelatex 编译，下同
bibtex foo.aux
(xe/pdf)latex foo.tex
(xe/pdf)latex foo.tex
```

### 常见问题

*****
我希望将一条文献展示在参考文献列表中，但不想在正文中用 `\cite` 命令引用，怎么办？

首先，确保这条文献已经写入了 `bib` 文件。其次，可以在 `\bibliography` 命令之前，用 `\nocite{label}`提示 `BibTeX` 调取这条文献。

我有很多条文献，都存在这样的情况。每条文献逐一 `\nocite` 太繁琐了，有没有懒人适用的办法？

有的。`\nocite{*}`。

*****
每次都要编译四次，我感觉懒癌又要发作了，有没有办法治疗？

有的。可以尝试 `LaTeXmk`, `TeXify` 之类的自动化工具。

*****
我对默认提供的 `bst` 文件的格式效果不满意，哪里能找到更多的 `bst` ？

现代 TeX 发行版都提供了多种 `bst` 可供选择，每个 `bst` 文件的格式、适用范围、使用条件都不一样，需要仔细甄别。具体可以去安装目录下搜索试试。

*****
有没有遵循国家标准的 `bst`？

有的

*****
我找到的 bst，效果都不满意，怎么办？

你可以在命令行执行 `latex makebst`，制作一个符合自己要求的 `bst` 文件。
你需要回答大约 100 个关于参考文献列表效果的问题。

*****
`bib` 文件怎么生成？

你可以手写，或者用 `JabRef` 之类的文献工具生成。具体请自行 Google 检索，篇幅所限就不展开了。

*****
我听说还有一个名为 `biblatex` 的工具，能介绍一下吗？

`biblatex` 与 `BibTeX` 是不同的工具，超出了本文的范围。
