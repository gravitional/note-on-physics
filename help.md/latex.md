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

如果你困惑于「为什么图表会乱跑」或者「怎样让图表不乱跑」，请看[我的回答][]。

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

>根据 `&`（假设`n`个）一行被分为`n+1`列。从左向右将列两个分为一组，第一组紧靠页左侧，最后一组紧靠页左侧，其余组均匀散布在整个行中。当公式比较短时，中间可能会有几段空白。
需要注意的是：
>每一组内部也是有对齐结构的！它们在所在位置上向中间对齐的，即第一列向右对齐，第二列向左对齐。
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

##  反向搜索设置 SumatraPDF
```
"C:\Users\Thomas\AppData\Local\Programs\Microsoft VS Code\Code.exe"  "C:\Users\Thomas\AppData\Local\Programs\Microsoft VS Code\resources\app\out\cli.js" -r -g "%f:%l"
```
[使用VSCode编写LaTeX][]

[使用VSCode编写LaTeX]: https://blog.csdn.net/fenzang/article/details/99805315