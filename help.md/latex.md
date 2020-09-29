# latex.md

## 帮助文档

查看latex 的帮助文档,可以直接用 `texdoc pkg`

`texdoc` - find & view documentation in TeX Live

SYNOPSIS

`texdoc [OPTION]... NAME...`
`texdoc ACTION`

DESCRIPTION

对于给定的名字（可以多个）,试图寻找合适的TeX文档. 或者,执行某些动作并退出. 

Actions:

`-h`, `--help` 打印帮助信息. 
`-V`, `--version`打印版本号
`-f`, `--files` 打印使用的配置文件
`--just-view file` 展示文件,给出绝对路径（不搜索）

OPTIONS

+ `-w`, `--view` 使用查看模式,打开文档阅读器（默认）
+ `-m`, `--mixed` 使用混合模式（查看或者列表） 
+ `-l`, `--list` 使用列表模式：列出搜索结果. 
+ `-s`, `--showall` 展示所有模式,包括"坏"的结果
+ `-i`, `--interact` 使用交互菜单（默认）
+ `-I`, `--nointeract`使用plain列表,不需要交互
+ `-M`, `--machine` 机器可读的结果

## latex 编译模式

[如何加速 LaTeX 编译][]

[如何加速 LaTeX 编译]: https://zhuanlan.zhihu.com/p/55043560

不同的编译模式也有细微的影响. 
经过测试,使用批处理模式（`batchmode`）速度要优于默认的模式（不加参数）和其他一些模式（比如 `nonstopmode` 和 `scrollmode`）,这是因为批处理模式在编译和执行阶段是静默的,不输出任何信息,因此要快上一些. 

## 清理辅助文件

删除本层目录下除了源文件的`latex`辅助文件,只保留 `*.tex`,`*.pdf`,`*.bib`

```
temp_a=$(find . -mindepth 1 -maxdepth 1 -type f   \( -not -name  "*.pdf" \)  \( -not -name  "*.tex" \) \( -not -name  "*.bib" \) -print0); if [[ ${temp_a} != '' ]]; then  echo -n ${temp_a} |  xargs --null rm; fi
```

## 浮动体 图形

[liam.page][]

由两个 graphics packages:

`graphics` : The `standard` graphics package.
`graphicx` :The `extended` or `enhanced`  graphics package

这两个包的区别在于可选参数给出的形式不同. 参数名称和必选参数是相同的. 

插图和表格通常需要占据大块空间,所以在文字处理软件中我们经常需要调整他们的位置. `figure` 和 `table` 环境可以自动完成这样的任务；这种自动调整位置的环境称作浮动体(`float`). 我们以 `figure` 为例. 

```latex
\begin{figure}[htbp]
\centering
\includegraphics{a.jpg}
\caption{有图有真相}
\label{fig:myphoto}
\end{figure}
```

`htbp` 选项用来指定插图的理想位置,这几个字母分别代表 `here`, `top`, `bottom`, `float page`,也就是就这里、页顶、页尾、浮动页（专门放浮动体的单独页面或分栏）. `\centering` 用来使插图居中；`\caption` 命令设置插图标题,`LaTeX` 会自动给浮动体的标题加上编号. 注意 `\label` 应该放在标题命令之后. 

如果你想了解 `LaTeX` 的浮动体策略算法细节,你可以参考我博客中关于[浮动体的系列文章][]

如果你困惑于"为什么图表会乱跑"或者"怎样让图表不乱跑",请看[我的回答][]. 

[liam.page]: https://liam.page/2014/09/08/latex-introduction/

[浮动体的系列文章]: https://liam.page/series/#LaTeX-%E4%B8%AD%E7%9A%84%E6%B5%AE%E5%8A%A8%E4%BD%93

[我的回答]: https://www.zhihu.com/question/25082703/answer/30038248

### 表格字号大小

[latex设置表格字体大小][]

[latex设置表格字体大小] :https://blog.csdn.net/zzmgood/article/details/36419493

```bash
\begin{table}[h]
\small %此处写字体大小控制命令
\begin{tabular}
...
\end{tabular}
\end{table}
```

***
Latex 设置字体大小命令由小到大依次为：

+ `\tiny`
+ `\scriptsize`
+ `\footnotesize`
+ `\small`
+ `\normalsize`
+ `\large`
+ `\Large`
+ `\LARGE`
+ `\huge`
+ `\Huge`

***
Latex下 字体大小命令 比较

|size| 10pt (default)| 11pt   |12pt |
|---|---|---|---|
| `\tiny` | `5pt`  | `6pt` | `6pt` |
| `\scriptsize` | `7pt`  | `8pt` | `8pt` |
| `\footnotesize` | `8pt`  | `9pt` | `10pt` |
| `\small` | `9pt`  | `10pt` | `11pt` |
| `\normalsize` | `10pt`  | `11pt` | `12pt` |
| `\large` | `12pt`  | `12pt` | `14pt` |
| `\Large` | `14pt`  | `14pt` | `17pt` |
| `\LARGE` | `17pt`  | `17pt` | `20pt` |
| `\huge` | `20pt`  | `20pt` | `25pt` |
| `\Huge` | `25pt`  | `25pt` | `25pt` |

## 设置子页面宽度resizebox

[一行代码解决LaTex表格过宽或过窄问题][]

[一行代码解决LaTex表格过宽或过窄问题]: https://blog.csdn.net/Rained_99/article/details/79389189#commentBox

若表格过宽,则

```bash
\begin{table}[htbp]
\center
\caption{ Example}
\resizebox{\textwidth}{12mm}{ %12可随机设置,调整到适合自己的大小为止
\begin{tabular}{lll}
\...
\end{tabular}
}%注意这里还有一个半括号
\end{table}
```

若表格过窄,则

```bash
\begin{table}[htbp]
\center
\caption{ Example}
\setlength{\tabcolsep}{7mm}{%7可随机设置,调整到适合自己的大小为止
\begin{tabular}{lll}
...
\end{tabular}
}%注意这里还有一个半括号
\end{table}
```

### 参考

22.3.4 \resizebox

[22.3.4 \resizebox](http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html#index-_005ctabcolsep)

Synopses:

```latex
\resizebox{horizontal length}{vertical length}{material}
\resizebox*{horizontal length}{vertical length}{material}
```

给定一个大小（例如`3`厘米）,请转换`material`使其达到该大小. 
 如果水平长度或垂直长度是一个感叹号`!` 就进行等比缩放. 

此示例使图形的宽度为半英寸,并按相同的比例垂直缩放图形,以防止图形变形. 

```bash
\ resizebox {0.5in} {!} {\ includegraphics {lion}}
```

未加星标形式 `\resizebox` 取垂直长度为`box`的高度,而带星标形式 `\resizebox*` 取其`height+depth`.  
例如,使用 `\resizebox*{!}{0.25in}{\parbox{1in}{使此框同时具有高度和深度. }}`
使文本的高度+深度达到四分之一英寸. 

您可以使用 `\depth`,`\height`,`\totalheight`和 `\width`来引用框的原始大小.  
因此,使用 `\resizebox{2in}{\height}{Two inch}`将文本设置为两英寸宽,但保留原始高度. 

***
8.23 tabular

[8.23 tabular](http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html#index-_005ctabcolsep)

`\tabcolsep`

长度是列之间间隔的一半.  默认值为`6pt`.  用 `\setlength`更改它. 

## LaTeX对齐

[LaTeX 对齐问题][]

[LaTeX 对齐问题]: https://blog.csdn.net/lvchaoshun/article/details/50518271

[latex23 doc](http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html#index-_005ccentering)

对齐的语法是

`{\centering ... }`

or

```latex
\begin{group}
  \centering ...
\end{group}
```

它使材料在其范围内（scope）居中.  它最常在诸如图形之类的环境中或在`parbox`中使用. 
常用来使插图居中：

```latex
\begin{figure}
  \centering
  \includegraphics[width=0.6\textwidth]{ctan_lion.png}
  \caption{CTAN Lion}  \label{fig:CTANLion}
\end{figure}
```

`\centering `的作用范围到`\end{figure}`为止.

与`center`环境不同,`\centering`命令不会在文本上方和下方添加垂直空间.  
这就是上面示例中的优势——没有多余的空间. 

### 一行文本对齐

+ `\leftline{左对齐}`
+ `\centerline{居中}`
+ `\rightline{右对齐}`

### 多行文本或段落对齐

左对齐

```latex
\begin{flushleft}
...
\end{flushleft}
```

居中

```latex
\begin{center}
...
\end{center}
```

右对齐

```latex
\begin{flushright}
...
\end{flushright}
```

### LaTeX公式对齐

默认情况下公式是居中对齐的,但若希望改成左对齐可以

```latex
\documentclass[a4paper,fleqn]{article}
```

这对整篇文章都有效. 

对某一行公式进行左对齐

```latex
\begin{flalign}
  your equation (1)  
\end{flalign}
```

对某一个公式左对齐

```latex
some text here\\
yourequationhere
\\
and more text here.
```

对某几行公式

```latex
\begin{flalign}  
\begin{split}  
your equation (1)  
your equation (2)  
\end{split}&  
\end{flalign}
```

[amsdoc](http://mirrors.ustc.edu.cn/CTAN/macros/latex/required/amsmath/amsldoc.pdf)

ams 数学环境包括：

```latex
equation     equation*    align          align*
gather          gather*         alignat      alignat* 
multline      multline*     flalign        flalign*
split
```

`split`环境是一种特殊的从属形式,仅在其他方程环境内部使用.  但是它不能在`multline`中使用. 
`split`仅支持一个对齐（`＆`）列； 如果需要更多,应使用`aligned`或`alignedat`. 
`split`结构的宽度是full line width

```latex
\begin{equation}\label{xx}
\begin{split}a& =b+c-d\\
& \quad +e-f\\
& =g+h\\
& =i
\end{split}
\end{equation}
```

### 其它方法

左对齐、居中对齐、右对齐的环境分别为`flushleft`、`center`和`flushright`. 
也可以使用命令`\raggedright`、`\centering`和`\raggedleft`使以后的文本按指定方式对齐.

加载amsmath宏包后,使用选项`fleqn`（就是声明加载宏包时使用`\usepackage[fleqn]{amsmath}`）
可以使本该居中对齐的行间公式改为左对齐.

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

1. 空格：`Latex` 中空格不起作用. 
1. 换行：用控制命令``\\``,或``\newline``.
1. 分段：用控制命令``\par`` 或空出一行. 
1. 换页：用控制命令``\newpage``或``\clearpage``
1. 特殊控制字符: `#`,`$`, `%`, `&`, `-` ,`{}`, `^`, `~`

## 子方程

```latex
\begin{subequations}
```

创建 子方程 环境

## 二元运算符

`+` 号后面 加 `{}` , 变成二元运算符,强制排版,用在多行公式换行中

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

根据 `&`（假设`n`个）一行被分为`n+1`列. 从左向右将列两个分为一组,第一组紧靠页左侧,最后一组紧靠页左侧,其余组均匀散布在整个行中. 当公式比较短时,中间可能会有几段空白. 
需要注意的是：
每一组内部也是有对齐结构的!它们在所在位置上向中间对齐的,即第一列向右对齐,第二列向左对齐. 
所谓紧靠页左/右是在进行了组内对齐调整之后,最长的一块紧靠上去. 也就是说对于长度不一两行,较短的那一行是靠不上去的. 
如果总共有奇数个列,及最后一组只有一个列,则它右对齐到页右侧,即所有行的最后一列的右侧都靠在页右侧. 

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

## 符号

[RaySir][]

[RaySir]: https://www.zhihu.com/people/a739643d07dc71b56c03cec1e1942358

连字符（Hyphens）、连接号（En-dashes）、破折号（Em-dashes）、减号（Minus signs）

连字符为`-`、连接号为`--`、破折号为`---`、减号为`$-$`. 

u+2014*2

+ `hyphen`,用于连接复合词,比如 pesudo-vector,TeX 里面用`-`
+ `en dash`,大致相当于中文的连接号,可连接人名、时间、地点等,如 Newton–Leibniz formula、10–20,TeX 里面用`--`
+ `em dash`,大致相当于中文的破折号,TeX 里面用`---` (即三个 hyphen)

### 数学符号

```bash
\DeclareMathOperator{\tr}{Tr}
\DeclareMathOperator{\re}{Re}
\DeclareMathOperator{\im}{Im}
\newcommand*{\dif}{\mathop{}\!\mathrm{d}}
```

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

链接有颜色,显示为`OpenBSD官方网站`,链接到`http://www.openbsd.org`

```latex
\href{http://www.openbsd.org}{OpenBSD官方网站}
```

只显示`URL`

```latex
\url{http://www.openbsd.org}
```

显示URL,但是不做链接和跳转：

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

`BibTeX` 涉及到两种特有的辅助的文件格式： `bst` 和 `bib` . 

`bst` 是 (B)ibliography (ST)yle 的缩写. 顾名思义,和 `sty` 文件是 `style` 的缩写一样,`bst` 文件控制着参考文献列表的格式. 
在这里说的"格式",主要指参考文献列表中的编号、排序规则、对人名的处理（是否缩写）、月份的处理（是否缩写）、期刊名称的缩写等. 

`bib` 是 `BibTeX` 定义的"参考文献数据库". 
通常,我们会按照 `BibTeX` 规定的格式,向 bib 文件写入多条文献信息. 
在实际使用时,我们就可以根据 bib 文件中定义的文献标记（label）,
从数据库中调取文献信息,继而排版成参考文献列表. 
值得注意的是,bib 是一个数据库,其中的内容并不一定等于 LaTeX 排版参考文献列表时的内容. 也就是说,如果 bib 数据库中有 10 条文献信息,并不一定说 LaTeX 排版出来的 PDF 文件中,参考文献列表里也一定有 10 条. 
实际排版出来的参考文献列表中有多少条文献,实际是哪几条,具体由文中使用的 `\cite` 命令（以及 `\nocite` 命令）指定. 如果没有使用 `\cite` 命令调取文献信息,那么即使在 `bib` 文件中定义了文献信息,也不会展现在参考文献列表中. 
很多人对此误解甚深,于是经常有人问道"为什么我在 bib 文件里写的文献,不出现在参考文献中"之类的问题. 

### BibTeX 的工作流程

介绍中提到,BibTeX 是一个参考文献格式化工具. 
这个定义,给 BibTeX 的用处做了良好的界定：BibTeX 不是用来排版参考文献的,更不是个排版工具,它只是根据需要,按照（ `bst` 文件规定的）某种格式,将（ `bib` 文件中包含的）参考文献信息,格式化 为 LaTeX 能够使用的列表信息. 

清楚了 `BibTeX` 需要做的事情（用软件工程的话说,就是清楚了 `BibTeX` 的 `API` ）,我们就可以理清 `BibTeX` 的工作流程. 

### 知道需要哪些参考文献信息

既然 `BibTeX` 会根据需要 格式化数据,那么首先要解决的问题就是：`BibTeX` 如何了解此处的"需求".  对 `BibTeX` 稍有了解的读者可能知道,运行 `BibTeX` 的命令行命令是：

`bibtex foo.aux` # 其中后缀名 `.aux` 可以省略

实际上,BibTeX 正是通过读取 `aux` 文件中的 `\citation{}` 标记,来确定用户需要哪些参考文献的.  举个例子,假设用户用 LaTeX 编译了以下代码：

```latex
\documentclass{article}
\begin{document}
bar\cite{baz}
\end{document}
```

如果该文件名为 `foo.tex`,那么就会生成 `foo.aux`. 其内容大约是：

```latex
\relax
\citation{baz}
```

在这里,`\relax` 表示休息一会儿,什么也不做；`\citation` 则是由 `tex` 文件中的 `\cite` 命令写入 `aux` 文件的标记. 
它说明了：用户需要标记为 `baz` 的参考文献信息. 
当 BibTeX 读入 `aux` 文件的时候,它就会记录下所有 `\citation` 命令中的内容（即文献标记——`label`）,这样就知道了用户需要哪些参考文献信息. 

### 了解文献列表格式以及读取文献数据库

当 BibTeX 清楚了用户需要哪些文献信息,接下来自然应该搞清楚用户想要什么样的格式. 
而知道了格式之后,就可以从数据库中抽取所需的文献信息,按照格式准备数据. 
为了讲清楚这个步骤,我们对上述 LaTeX 代码做些许的修改. 

```latex
\documentclass{article}
\begin{document}
\bibliographystyle{unsrt}
bar\cite{baz}
\bibliography{foobar}
\end{document}
```

同样,我们将它保存为 foo.tex,经由 LaTeX 编译之后得到一个 `foo.aux` 文件,其内容如下：

```latex
\relax
\bibstyle{unsrt}
\citation{baz}
\bibdata{foobar}
```

简单的对比,不难发现：

`foo.tex` 中新增的 `\bibliographystyle{unsrt}` 与 `aux` 文件中的 `\bibstyle{unsrt}` 相对应. 

`foo.tex` 中新增的 `\bibliography{foobar}` 与 aux 文件中的 `\bibdata{foobar}` 相对应. 

根据命令的名字,我们很容易猜测各个命令的作用. 

tex 文件中的 `\bibliographystyle` 指定了用户期待的参考文献列表格式文件,并将其写入 `aux` 文件备用,通过 `\bibstyle` 标记. 
与此同时,`\bibliography` 命令则用 `\bibdata` 在 `aux` 文件中记录了参考文献数据库的名字（不含扩展名）. 
`在这里,unsrt` 是 `unsort` 的缩写,它对应着 `unsrt.bst` 文件,是大多数 TeX发行版自带的标准格式文件之一；
`foobar` 则对应着 `foobar.bib` 文件,该文件是用户自己编写或生成的参考文献数据库. 

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

我们会发现, `BibTeX` 生成了两个文件：`foo.bbl` 和 `foo.blg`. 
其中 `foo.bbl` 的内容如下：

```latex
\begin{thebibliography}{1}

\bibitem{baz}
The King.
\newblock {\em Dummy Book}.
\newblock Egypt, 321.

\end{thebibliography}
```

显然,这就是一个标准的 `LaTeX` 环境. 对 `LaTeX` 参考文献排版稍有了解的读者可能知道 `thebibliography` 环境正是 `LaTeX` 中手工编排参考文献时使用的环境. 
因此,`foo.bbl` 就是 `BibTeX` 格式化输出的结果,`LaTeX` 只需要将该文件的内容读入,就能在相应的位置输出格式化之后的参考文献列表了. 
接下来,我们看看 `foo.blg` 的内容. `blg` 实际是 `BibTeX Log` 的缩写,亦即这是一个日志文件. 

```bibtex
This is BibTeX, Version 0.99d (TeX Live 2015)
Capacity: max_strings=35307, hash_size=35307, hash_prime=30011
The top-level auxiliary file: foo.aux
The style file: unsrt.bst
Database file #1: foobar.bib
You've used 1 entry,
...
```

我们看到,BibTeX 打出的日志文件中,记录了读入 `aux/bst/bib` 文件的情况. 
特别地,记录了所需的参考文献条目（entry）的数量（此处为 1）. 
日志中值得注意的地方是在提到 bib 文件时,使用了 `#1` 的标记. 既然存在 `#1`,那么合理推测也可以存在`#2`. 
也就是说,BibTeX 可能支持两个或更多的 `bib` 数据库共同工作. 
具体如何实现,请读者自己阅读相关资料（手册或 Google 检索）后实验. 
紧接着,我们再执行一次 `LaTeX` ：

```bash
latex foo.tex
```

首先,来看看 `aux` 文件会发生什么变化：

```latex
\relax
\bibstyle{unsrt}
\citation{baz}
\bibdata{foobar}
\bibcite{baz}{1}
```

相比上一次的 `foo.aux`,在读入 BibTeX 之后,LaTeX 向 `aux` 文件写入了更多的信息. 
这里 `\bibcite{baz}{1}` 将 `baz` 这一参考文献标记（label）与参考文献编号（数字 `1`）绑定起来了. 
接下来,我们看看 dvi 文件的内容：`foo.pdf`不难发现,由于读入了 `foo.bbl` 文件,参考文献列表已经正确展现出来了. 
然而,正文中依然有一个问号.  实际上,LaTeX 需要 `aux` 文件中的 `\bibcite` 命令,将参考文献标记与参考文献编号关联起来,从而在 tex文件中的 `\cite` 命令位置填上正确的参考文献编号. 
我们注意到,在我们第二次执行 `LaTeX` 命令编译之前,`foo.aux` 文件中是没有这些信息的,直到编译完成,这些信息才被正确写入. 因此,第二次执行 `LaTeX` 命令时,`LaTeX` 还不能填入正确的文献编号,于是就写入了一个问号作为占位符. 
 解决这个问题的办法也很简单——此时 `aux` 文件中已经有了需要的信息,再编译一遍就好了. 

```latex
latex foo.tex
```

如果没有意外,此时的 `foo.dvi` 文件应该看起来一切正常了. 

### 小结

`BibTeX` 是一个参考文献格式化工具,它会根据需要,按照（bst 文件规定的）某种式,将（bib 文件中包含的）参考文献信息,格式化 为 LaTeX 能够使用的列表信息. 

+ 正确使用 BibTeX 处理参考文献,需要先用 `(Xe/PDF)LaTeX` 编译 `tex` 文件,生成 `aux` 辅助文件. 
+ 执行 `BibTeX` 将读入 `aux` 文件,搞清楚用户需要哪些文献. 
+ 紧接着,BibTeX 根据 `aux` 文件中的内容,找到正确的 `bst` 和 `bib` 文件,并将参考文献信息格式化为 `LaTeX` 的 `thebibliography` 环境,作为 `bbl` 文件输出. 
+ 第二次执行 `(Xe/PDF)LaTeX` 将会读入新生成的 `bbl` 文件,同时更新 `aux` 文件. 此时,参考文献列表将会正常展示,但是正文中的引用标记显示为问号. 
+ 第三次执行 `(Xe/PDF)LaTeX` 将会读入 `bbl 文件和更新过后的 `aux` 文件. 此时,参考文献相关内容都正常显示. 

因此,总的来说,想要正确使用 `BibTeX` 协同 `LaTeX` 处理参考文献,需要编译四次：

```bash
(xe/pdf)latex foo.tex   # 表示使用 latex, pdflatex 或 xelatex 编译,下同
bibtex foo.aux
(xe/pdf)latex foo.tex
(xe/pdf)latex foo.tex
```

### 常见问题

***
我希望将一条文献展示在参考文献列表中,但不想在正文中用 `\cite` 命令引用,怎么办？

首先,确保这条文献已经写入了 `bib` 文件. 
其次,可以在 `\bibliography` 命令之前,用 `\nocite{label}`提示 `BibTeX` 调取这条文献. 
我有很多条文献,都存在这样的情况. 每条文献逐一 `\nocite` 太繁琐了,有没有懒人适用的办法？
有的. `\nocite{*}`. 

***
每次都要编译四次,我感觉懒癌又要发作了,有没有办法治疗？

有的. 可以尝试 `LaTeXmk`, `TeXify` 之类的自动化工具. 

***
我对默认提供的 `bst` 文件的格式效果不满意,哪里能找到更多的 `bst` ？

现代 TeX 发行版都提供了多种 `bst` 可供选择,每个 `bst` 文件的格式、适用范围、使用条件都不一样,需要仔细甄别. 
具体可以去安装目录下搜索试试. 

***
有没有遵循国家标准的 `bst`？

有的

***
我找到的 bst,效果都不满意,怎么办？

你可以在命令行执行 `latex makebst`,制作一个符合自己要求的 `bst` 文件. 
你需要回答大约 100 个关于参考文献列表效果的问题. 

***
`bib` 文件怎么生成？

你可以手写,或者用 `JabRef` 之类的文献工具生成. 具体请自行 Google 检索,篇幅所限就不展开了. 

***
我听说还有一个名为 `biblatex` 的工具,能介绍一下吗？

`biblatex` 与 `BibTeX` 是不同的工具,超出了本文的范围. 

### 其他的参考文献包

#### cite

[cite – Improved citation handling in LaTeX](https://www.ctan.org/pkg/cite)

`cite`支持压缩,排序的数字引用列表,还处理各种标点符号和其他表示形式的问题,包括对断点的全面管理.  
该软件包与`hyperref`和`backref`兼容. 

支持给出多种`cite`格式:
`[?,Einstein,4–6,6–9]`
`[5a–5c] or [T1–T4])`
`‘information;12`

`cite` and `natbib` 不能同时使用. 

#### natbib

[natbib – Flexible bibliography support ](https://www.ctan.org/tex-archive/macros/latex/contrib/natbib/)

natbib软件包是LATEX的扩展,允许作者年份(author–year)的引用形式,也支持数字引用. 
可以方便的切换. 

首先导入包,`\usepackage[sectionbib,square]{natbib}`
natbib 提供了三种新的格式,

+ plainnat.bst
+ abbrvnat.bst
+ unsrtnat.bst

通过在正文中调用以下命令使用这些格式：

`bibliographystyle{plainnat}`

natbib 特别定义了 `citet` (cite textual) and `citep`(cite parenthetical).
以及 `\citet*` and `\citep*` 可以打印出作者全名. 
这些命令都可以接受一到两个参数,在引用前后输出额外文字. 
可以同时引用多个参考文献. 

```latex
\citet{jon90,jam91} --> Jones et al.  (1990); James et al.  (1991)
\citep{jon90,jam91} --> (Jones et al., 1990; James et al.  1991)
\citep{jon90,jon91} --> (Jones et al., 1990, 1991)
\citep{jon90a,jon90b} --> (Jones et al., 1990a,b)
```

These examples are for author–year citation mode.  
In numerical mode,the results are different.

```latex
\citet{jon90} --> Jones et al.  [21]
\citet[chap.~2]{jon90} --> Jones et al.  [21, chap. 2]
\citep{jon90} --> [21]
\citep[chap.~2]{jon90} --> [21, chap. 2]
\citep[see][]{jon90} --> [see 21]
\citep[see][chap.~2]{jon90} --> [see 21, chap. 2]
\citep{jon90a,jon90b} --> [21, 32]
```

***
调用`\usepackage[options]{natbib}`的选项

+ `round` （默认）圆括号；
+ `square` 用于方括号；
+ `curly` 花括号;
+ `angle` 用于尖括号;
+ `semicolon` （默认）使用分号分隔多个引用；
+ `colon` 与`semicolon`相同,这是一个较早的术语错误；
+ `comma` 使用逗号作为分隔符；
+ `authoryear` （默认）作者年份（ author–year）引文；
+ `numbers` 数字引用；
+ `super` 用于上标数字引用,类似`Nature`中的. 
+ `sort` 将多个引文按其在参考文献列表中出现的顺序排序；
+ `sort&compress` 类似`sort`,但如果可能的话,还会压缩多个数字引用（如`3-6,15`）；
+ `compress` 压缩而不排序,因此压缩仅在给定的引用按照数字升序时生效；
+ `longnamesfirst` 使任何参考文献的第一个引用都等同于已加星标的变体（完整作者列表）,而随后的引用均是普通引用（缩写列表）；
+ `sectionbib` 重新定义`\ thebibliography`来引用`\ section *`而不是`\ chapter *`;仅对带有`\ chapter`命令的类有效； 与`chapterbib`软件包一起使用；
+ `nonamebreak` 将所有作者的名字放在同一行中,导致`hbox`过多,但有助于解决一些`hyperref`问题；
+ `merge` 允许在`citation key`前面加上`*`前缀,并将此类引文的引用与先前引文的引用合并；
+ `elide` 合并参考文献后,去掉重复的共同要素,例如作者或年份；
+ `mcite`识别（并忽略）合并语法

### input与include

[Latex导入文件/input和/include方式][]

[Latex导入文件/input和/include方式]: https://blog.csdn.net/OOFFrankDura/article/details/89644373

`\input`命令可以改为`include`,
区别在于,`input`可以放在导言区和正文区,包含的内容不另起一页；
而`include`只能放在正文区,包含的内容另起一页. 

另外`CJK`中还有`CJKinput`和`CJKinclude`命令. 

## texdoc

`man` page 指出这些命令行选项等价于使用the command forms as `\scrollmode`,官方文档是`TeXBook`,或者输入

```powershell
texdoc texbytopic
```

自由选择(see chapter 32).

## latex 编译调试

### 报错示例-1

```latex
./chapter-6.tex:58: Undefined control sequence.
l.58             \partial_\mu - i \eofphi
                                           A_\mu(x)
Output written on temp/main.xdv (21 pages, 329924 bytes).
SyncTeX written on temp/main.synctex.gz.

Transcript written on temp/main.log.
```

### 简短版latexmk

```powershell
$mk_message=(latexmk -f -xelatex); Write-Output ("*" * 90);$mk_message | Where-Object {$_ -like "*tex:*"}
```

### 详细版latexmk

```powershell
if ($null -eq $args[0]) {
    # the default tex compiler, used to compile the '*.tex' files
    $tex_compiler = "-xelatex";
}
else {
    $tex_compiler = $args[0]
};

$mk_message = (latexmk -f "$tex_compiler");
#detect the line number of the error message
$line_start = ($mk_message | Where-Object { $_ -match '[ ./\w]+tex:\d+:[ \w]+' });
$line_end = ($mk_message | Where-Object { $_ -match '^Transcript[ \w]*' });
$length = ($line_start.count - 1)
## show the erroe message
Write-Output ("`n" * 2 + "the error message start" + "`n" * 2 );
for ($i = 0; $i -le $length; $i++) {
    Write-Output ("*" * 90);
    $mk_message[$mk_message.IndexOf($line_start[$i])..($mk_message.IndexOf($line_end[$i]))] | Select-Object -First 10
}
```

在命令行下运行的时候,选择不同的引擎,关键字为

`-pdf` : `-pdflatex`
`-xelatex`
`-lualatex`

### 报错示例-2

ref-2: [LaTeX 如何进行 debug][]

[LaTeX 如何进行 debug]: https://www.zhihu.com/question/28698141/answer/41774879

我们故意构建一段错误的代码看看. 

```latex
\documentclass{minimal}
\begin{document}
\usepackage{amsmath}
\end{document}
```

编译运行之后,会提示错误

```latex
./test.tex:3: LaTeX Error: Can be used only in preamble.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.3 \usepackage
               {amsmath}
No pages of output.
```

`LaTeX` 的错误提示分成四个部分,以这个报错为例. 

以叹号开头的行说明出错原因,示例中提示:

`LaTeX Error: Can be used only in preamble`

中间段落是`LATEX`给出的提示建议. 

以字母`l`开头的那一行给出出错的具体位置. 
可以看到代码在 `\usepackage` 之后截断分为两行,这说明问题出在截断处. 
这里是第三行的 `\usepackage` 出错了. 以问号开头的行,表示 `LaTeX` 正在等待用户输入. 这里可以输入 `x` 停止编译,直接按回车忽略该错误,甚至输入 `s` 直接忽略后续一切错误. 

这里表示"第三行的 `\usepackage` 只能放在导言区,不能放在正文部分",
于是你只需要根据提示调整一下 `\usepackage` 的位置就好了. 

实际使用中遇到的错误多种多样,一些错误的分析和修复可能不这么简单. 
刘海洋 的《LaTeX 入门》中有名为「从错误中救赎」的章节,
专门讲解 `LaTeX` 的排错,对 `LaTeX` 的不同报错进行了详细地叙述. 

### 清理latex 辅助文件powershell

```powershell
remove-item -Path ('.\*.aux','.\*.lof','.\*.log','.\*.lot','.\*.fls','.\*.out','.\*.toc','.\*.fmt','.\*.fot','.\*.cb','.\*.cb2','.\*.ptc','.\*.xdv','.\*.fdb_latexmk','.\*.synctex.gz','.\*.ps1','.\*.bib','.\*.bbl','.\*.blg')
```

```powershell
remove-item -Path ($tepath+'*.aux',$tepath+'*.lof',$tepath+'*.log',$tepath+'*.lot',$tepath+'*.fls',$tepath+'*.out',$tepath+'*.toc',$tepath+'*.fmt',$tepath+'*.fot',$tepath+'*.cb',$tepath+'*.cb2',$tepath+'*.ptc',$tepath+'*.xdv',$tepath+'*.fdb_latexmk',$tepath+'*.synctex.gz',$tepath+'*.ps1')
```

## 定理类环境 of elegant-note

### definition 定义

```latex
\begin{definition}{name}{}%%\ref{def:label}
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{definition}
```

### theorem 定理

```latex
\begin{theorem}{name}{}%%\ref{thm:label}
%%comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{theorem}
```

### lemma 引理

```latex
\begin{lemma}{name}{}%%\ref{lem:label}
%%some comment
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{lemma}
```

### corollary  推论

```latex
\begin{corollary}{name}{}%%\ref{cor:label}
%%some comment
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{corollary}
```

### proposition 命题

```latex
\begin{proposition}{name}{}%%\ref{pro:label}
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{proposition}
```

## 其他环境 of elegant-note

这几个都是同一类环境,区别在于

1. 示例环境（`example`）、练习（`exercise`）与例题（`problem`）章节自动编号
2. 注意（note）,练习（exercise）环境有提醒引导符；
3. 结论（conclusion）等环境都是普通段落环境,引导词加粗. 

## example 例子

```latex
\begin{example} %%some comment

\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------

%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
\end{example}
```

## note 附注

```latex
\begin{note} %%some comment

\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{note}
```

## conclusion 结论

```latex
\begin{conclusion} %%comment
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{conclusion}
```

## 数学math

### 无序号公式

```latex
\begin{equation*}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------

%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation*}
```

### 有序号公式

```latex
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------

%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
```

### 分段函数 cases

```latex
\begin{equation}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------
y=
%%%%%+++++++++++++++++++++++
\begin{cases}
-x,\quad x\leq 0 \\
%%%%%+++++++++++++++++++++++
x,\quad x>0
\end{cases}
\end{equation}
```

```latex
f(n) = \begin{cases} n/2 &\mbox{if } n \equiv 0 \\
(3n +1)/2 & \mbox{if } n \equiv 1 \end{cases} \pmod{2}.
```

### 矩阵模板

```latex
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------
\begin{pmatrix}

\end{pmatrix}
%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
```

### 分隔符

```latex
%%%%%+++++++++++++++++++++++---------------------
```

### 表格

```latex
\begin{table}[htbp]
\centering
\begin{tabular}{|l|l|l|}

\end{tabular}
\caption{input anything you need}
\end{table}
```

### 常用颜色声明

```latex
{\color{main}text}
```

main, second, third

***
xcolor 使用

需求：`xcolor`默认颜色只有`19`种,使用时可以在`option`中加入另外3张颜色表来极大扩充颜色库. 

宏包：`\usepackage{xcolor}`
选项：`dvipsnames, svgnames, x11names`
使用：`\usepackage[dvipsnames, svgnames, x11names]{xcolor}`
注意：`xcolor`宏包一般要放在最前面!否则那3张颜色表容易加不进来. 

使用：

```latex
{\color{red}{红色}}是19个基本颜色中的一个,下面秀几个高级货：
这里是{\color{NavyBlue}{海军蓝}},这个是{\color{Peach}{桃子色}}
这个是{\color{SpringGreen}{春天绿}},最后一个{\color{SeaGreen3}{海绿3}}
```

[LaTeX：xcolor颜色介绍][]

[LaTeX：xcolor颜色介绍]: https://www.jianshu.com/p/5aee7c366369

### 颜色包的使用

```latex
\usepackage{color,xcolor}
% predefined color---black, blue, brown, cyan, darkgray, gray, green, lightgray, lime, magenta, olive, orange, pink, purple, red, teal, violet, white, yellow.
\definecolor{light-gray}{gray}{0.95}    % 1.灰度
\definecolor{orange}{rgb}{1,0.5,0}      % 2.rgb
\definecolor{orange}{RGB}{255,127,0}    % 3.RGB
\definecolor{orange}{HTML}{FF7F00}      % 4.HTML
\definecolor{orange}{cmyk}{0,0.5,1,0}   % 5.cmyk
```

### 简单枚举

```latex
$(\lambda)=(\lambda_1,\lambda_2,\cdots \lambda_m)$
```

### 杨图 diagrams 模板

```latex
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------
\ydiagram{4}&\quad&\ydiagram{3,1}&\quad&\ydiagram{2,2}\\
[4]&\quad&[3,1]&\quad&[2,2]
%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
```

## 杨表 tableaux  模板

```latex
\ytableausetup{mathmode, boxsize=1.5em}
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------
\begin{ytableau}
a & d & f \\
b & e & g \\
c
\end{ytableau}%%&\quad&
%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
```

## 标题中使用数学模式

```latex
\section{The classes \texorpdfstring{$\mathcal{L}(\gamma)$}{Lg}}
```

```latex
 \texorpdfstring{math objec}{Lg}
```

## 上下标

我们会发现, 在行内公式中, 所有的符号和上下标都以行内的大小为准, 尽量不去突出一行的高度, 而在行间公式中, 各种巨算符可以尽情舒展, 变成了平常我们见到的样子.
如果想在行内公式中也使用行间公式款的上下标的话, 可以在对应的命令前面加上`\displaystyle`, 即显示模式, 就可以变成我们想要的样子了, 但是这种方法会产生一些不良行距. 
而另一种方法是比较推荐使用的: `\limits`, 顾名思义, 这个命令可以把上下标变成我们常见的"极限"形式的上下标, 也就是显示在算符的上下, 而不是右边. 而与它对应的命令是`\nolimits`, 也就是把上下标显示在算符的右侧而不是上下. 下面通过一个例子来比较这几种的显示效果

```latex
\documentclass{article}
\usepackage[UTF8]{ctex}
\begin{document}
\noindent 无穷级数$ \sum_{n=1}^{\infty}a_{i} $收敛\\
无穷级数$ \displaystyle\sum_{n=1}^{\infty}a_{i} $收敛\\
无穷级数$ \sum\limits_{n=1}^{\infty}a_{i} $收敛\\
无穷级数$ \displaystyle\sum\nolimits_{n=1}^{\infty}a_{i} $收敛
\end{document}
```

```latex
$\limsup\limits_{x\rightarrow0}$ vs $\lim\sup\limits_{x\rightarrow0}$
```

So you will want to use \limsup.

[氢化脱苄苯甲醇-上下标][]

[氢化脱苄苯甲醇-上下标]: https://www.jianshu.com/p/229cbbac9446

## Math accents

reference: [Math accents][]

[Math accents]: http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html#Math-accents

`LaTeX` provides a variety of commands for producing accented letters in math.
These are different from `accents` in `normal text` (see `Accents`).

| command | description |
| ----- | ----- |
| `\acute` |      Math acute accent |
| `\bar` |        Math bar-over accent |
| `\breve` |      Math breve accent |
| `\check` |      Math hacek (check) accent |
| `\ddot` |       Math dieresis accent |
| `\dot` |        Math dot accent |
| `\grave` |      Math grave accent |
| `\hat` |        Math hat (circumflex) accent |
| `\mathring` |   Math ring accent |
| `\tilde` |      Math tilde accent |
| `\vec` |        Math vector symbol |
| `\widehat` |    Math wide hat accent |
| `\widetilde` |  Math wide tilde accent |

## 简单的规则

1. 空格：Latex 中空格不起作用. 
1. 换行：用控制命令`\\\`,或`\newline`.
1. 分段：用控制命令`\par` 或空出一行. 
1. 特殊控制字符: #,$, %, &, - ,{, }, ^, ~

## 换页

用控制命令``\newpage``或``\clearpage``

+ `\newpage`：  The `\newpage` command ends the current page.
+ `\clearpage`：The `\clearpage` command ends the current page and causes all figures and tables that have so far appeared in the input to be printed.

## 连字符

连字符（`Hyphens`）、连接号（`En-dashes`）、破折号（`Em-dashes`）及减号（`Minus signs`）

+ 连字符 `-` 通常用来连接复合词,比如 `daughter-in-law`. 
+ 连接号 `--` 通常用来表示范围,比如 `see pages 5--7`. 如果真的希望连续输入两个连字符,使用 `{-}{-}`. 
+ 破折号 `---` 是一个正规的标点符号,用来表示转折或者承上启下. 要注意的是,破折号与其前后的单词之间不应该存在空格,例如 `A specter is haunting Europe---the specter of Communism.`
+ 排版中的减号应该比连字符要长,因此用来表示减号或者负号时,请严格使用数学模式 $-5$ 而不要使用文字模式 `-5`

## 计数器 Counters

Everything `LaTeX` numbers for you has a `counter` associated with it.
The name of the `counter` is often the same as the name of the `environment` or `command` associated with the number, except that the `counter`’s name has no backslash `\`. Thus, associated with the `\chapter` command is the `chapter` counter that keeps track of the `chapter` number.

Below is a list of the counters used in `LaTeX`’s standard document classes to control numbering.

| | | | |
| ----- | ----- | ----- | ----- |
| part             | paragraph        | figure           | enumi |
| chapter          | subparagraph     | table            | enumii |
| section          | page             | footnote         | enumiii |
| subsection       | equation         | mpfootnote       | enumiv |
| subsubsection |  |  |  |

The `mpfootnote` counter is used by the `\footnote` command inside of a `minipage` (see minipage).
The counters `enumi` through `enumiv` are used in the `enumerate` environment, for up to four levels of nesting (see `enumerate`).

Counters can have any **integer** value but they are typically **positive**.

New counters are created with `\newcounter`.

+ `\alph` `\Alph` `\arabic` `\roman` `\Roman` `\fnsymbol`: Print value of a counter.
+ `\usecounter`: Use a specified counter in a list environment.
+ `\value`: Use the value of a counter in an expression.
+ `\setcounter`: Set the value of a counter.
+ `\addtocounter`: Add a quantity to a counter.
+ `\refstepcounter`: Add to a counter.
+ `\stepcounter`: Add to a counter, resetting subsidiary counters.
+ `\day` & `\month` & `\year`: Numeric date values.

## 列表环境

### enumerate

Synopsis:

```latex
\begin{enumerate}
  \item[optional label of first item] text of first item
  \item[optional label of second item] text of second item
  ...
\end{enumerate}
```

Environment to produce a numbered list of items. The format of the label numbering depends on the nesting level of this environment; see below.
The default top-level numbering is ‘`1.`’, ‘`2.`’, etc. Each enumerate list environment must have at least one item; having none causes the `LaTeX` error  `Something's wrong--perhaps a missing \item`.

This example gives the first two finishers in the 1908 Olympic marathon. As a top-level list the labels would come out as ‘`1.`’ and ‘`2.`’.

\begin{enumerate}
 \item Johnny Hayes (USA)
 \item Charles Hefferon (RSA)
\end{enumerate}

Start list items with the `\item` command (see `\item`). If you give `\item` an optional argument by following it with square brackets, as in `\item[Interstitial label]`, then the next item will continue the interrupted sequence (see `\item`).
That is, you will get labels like ‘`1.`’, then ‘`Interstitial label`’, then ‘`2.`’. Following the `\item` is optional text, which may contain multiple paragraphs.

Enumerations may be nested within other enumerate environments, or within any `paragraph-making` environment such as `itemize` (see `itemize`), up to four levels deep. This gives `LaTeX`’s default for the format at each nesting level, where `1` is the top level, the outermost level.

+ arabic number followed by a period: ‘`1.`’, ‘`2.`’, ...
+ lowercase letter inside parentheses: ‘`(a)`’, ‘`(b)`’ ...
+ lowercase roman numeral followed by a period: ‘`i.`’, ‘`ii.`’, ...
+ uppercase letter followed by a period: ‘`A.`’, ‘`B.`’, ...

The enumerate environment uses the counters `\enumi` through `\enumiv` (see `Counters`).

For other major LaTeX labeled list environments, see description and itemize. For information about list layout parameters, including the default values, and for information about customizing list layout, see list. The package enumitem is useful for customizing lists.

To change the format of the label use `\renewcommand` (see `\newcommand` & `\renewcommand`) on the commands `\labelenumi` through `\labelenumiv`. For instance, this first level list will be labelled with uppercase letters, in boldface, and without a trailing period.

```latex
\renewcommand{\labelenumi}{\textbf{\Alph{enumi}}}
\begin{enumerate}
  \item Shows as boldface A
  \item Shows as boldface B
\end{enumerate}
```

For a list of counter-labeling commands see `\alph \Alph \arabic \roman \Roman \fnsymbol`.

### itemize

Synopsis:

```latex
\begin{itemize}
  \item[optional label of first item] text of first item
  \item[optional label of second item] text of second item
\end{itemize}
```

Produce a list that is unordered, sometimes called a bullet list. The environment must have at least one `\item`; having none causes the `LaTeX` error ‘`Something's wrong--perhaps a missing \item`’.

This gives a two-item list.

```latex
\begin{itemize}
 \item Pencil and watercolor sketch by Cassandra
 \item Rice portrait
\end{itemize}
```

As a top-level list each label would come out as a bullet, $\textbullet$. The format of the labeling depends on the nesting level; see below.

Start list items with the `\item` command (see `\item`). If you give `\item` an optional argument by following it with square brackets, as in `\item[Optional label]`, then by default it will appear in bold and be flush right, so it could extend into the left margin.
For labels that are flush left see the description environment. Following the `\item` is optional text, which may contain multiple paragraphs.

Itemized lists can be nested within one another, up to four levels deep. They can also be nested within other paragraph-making environments, such as `enumerate` (see `enumerate`).
The itemize environment uses the commands `\labelitemi` through `\labelitemiv` to produce the default label (this also uses the convention of lowercase roman numerals at the end of the command names that signify the nesting level). These are the default marks at each level.

+ $\textbullet$ (bullet, from \textbullet)
+ $\textdash$ (bold en-dash, from `\normalfont\bfseries\textendash`)
+ $\textasteriskcentered$ (asterisk, from `\textasteriskcentered`)
+ $\textperiodcentered$ (centered dot, rendered here as a period, from `\textperiodcentered`)

Change the labels with `\renewcommand`. For instance, this makes the first level use diamonds.

```latex
\renewcommand{\labelitemi}{$\diamond$}
```

The distance between the left margin of the enclosing environment and the left margin of the itemize list is determined by the parameters `\leftmargini` through `\leftmarginvi`. (Note the convention of using lowercase roman numerals a the end of the command name to denote the nesting level.)
The defaults are: 2.5em in level 1 (2em in two-column mode), 2.2em in level 2, 1.87em in level 3, and 1.7em in level 4, with smaller values for more deeply nested levels.

For other major `LaTeX` labeled list environments, see description and enumerate. For information about list layout parameters, including the default values, and for information about customizing list layout, see list. The package enu`mitem is useful for customizing lists.

This example greatly reduces the margin space for outermost itemized lists.

```latex
\setlength{\leftmargini}{1.25em} % default 2.5em
```

Especially for lists with short items, it may be desirable to elide space between items. Here is an example defining an `itemize*` environment with no extra spacing between items, or between paragraphs within a single item (`\parskip` is not list-specific, see `\parindent` & `\parskip`):

```latex
\newenvironment{itemize*}%
  {\begin{itemize}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}}%
    \setlength{\parskip}{0pt}}%
  {\end{itemize}}
```

## 超链接

使用宏包 `hyperref` 来制作

### email链接

```latex
\href{mailto:michaelbibby@gmail.com}{给我电邮}}
```

### URL链接

链接有颜色,显示为`OpenBSD官方网站`,链接到`http://www.openbsd.org`

```latex
\href{http://www.openbsd.org}{OpenBSD官方网站}
```

只显示`URL`

```latex
\url{http://www.openbsd.org}
```

显示URL,但是不做链接和跳转：

```latex
\nolinkurl{http://www.openbsd.org}
```

[LaTeX技巧159：如何在文中使用链接][]

[LaTeX技巧159：如何在文中使用链接]: https://www.latexstudio.net/archives/7741.html

## 特殊符号与数学字体

ref: [LaTeX —— 特殊符号与数学字体][]

[LaTeX —— 特殊符号与数学字体]: https://blog.csdn.net/lanchunhui/article/details/54633576

### 特殊符号

+ $\ell$ 用于和大小的$l$和数字$1$相区分
+ $\Re$
+ $\nabla$ 微分算子

### 数学字体

+ `mathbb`：blackboard bold,黑板粗体
+ `mathcal`：calligraphy（美术字）
+ `mathrm`：math roman
+ `mathbf`：math boldface

`\usepackage{bbm}`

+ `\mathbbm`: 黑板粗体字母

花体`\mathcal`：`L,F,D,N`

+ $\mathcal{L}$ 常用来表示损失函数
+ $\mathcal{D}$ 表示样本集
+ $\mathcal{N}$ 常用来表示高斯分布；

### 其他数学字体

+ `\mathsf`
+ `\mathtt`
+ `\mathit`

以下分别是`4`种字体形式：

1-4 行分别是：`默认`,`\mathsf`, `\mathtt`, `\mathit`. 

```latex
\[
    \begin{split}
        &{f(x,y) = 3(x+y)y / (2xy-7)}\\
        &\mathsf{f(x,y) = 3(x+y)y / (2xy-7)}\\
        &\mathtt{f(x,y) = 3(x+y)y / (2xy-7)}\\
        &\mathit{f(x,y) = 3(x+y)y / (2xy-7)}
    \end{split}
\]
```

### 小写字母的数字花体

ref-2: [LaTeX小写花体字母][]
ref-3: [查找任意符号的LaTeX指令][]

拥有小写字母的数字花体字体当然也是存在的——比如`MathTime Pro 2`的`\mathcal`就支持小写,
需要付钱.  把一些正文字体借用于数学公式中是可能
把一些正文字体借用于数学公式中是可能的. 不过不推荐. 
如果是为了区分不同的变量,可以考虑用`black letter`风格的`\mathfrak`. 

推荐两个查找任意符号的LaTeX指令的方法

+ 查阅 [The Comprehensive LaTeX Symbol List][] ,这份资料很好,囊括众多宏包中的符号,就是查起来比较麻烦
+ 使用 [Detexify][] ,用鼠标直接画出你想要的符号即可查出该符号的`LaTeX`指令,灰常给力.

[LaTeX小写花体字母]: https://www.zhihu.com/question/26941177/answer/34623570

[查找任意符号的LaTeX指令]: https://www.zhihu.com/question/26941177/answer/34626024

[The Comprehensive LaTeX Symbol List]: http://mirrors.ustc.edu.cn/CTAN/info/symbols/comprehensive/symbols-a4.pdf

[Detexify]: http://detexify.kirelabs.org/classify.html

## 数学符号

| `latex` | appearance | 描述 |
| ----- | ----- |----- |
| `\oint` | $\oint$ | 环路积分 |
| `\approx` | $\approx$ | Almost equal to (relation) 双线约等于 |
| `\sim` | $\sim$ | 相似 单线约为 |
| `\ldots` | $\ldots$ | lying dots 省略号 |
| `\cdots` | $\cdots$ | centerd dots 省略号 |
| `\infty` | $\infty$ | infinity 无穷 |
| `\gg` | $\gg$ |greater greater 远远大于 |
| `\ll` | $\ll$ | less less 远远小于 |
| `\propto` | $\propto$ | 正比于 |
| `\in` | $\in$ | 属于 |
| `\notin` | $\notin$ | 不属于|
| `\ast` | $\ast$ | Asterisk operator, convolution, six-pointed (binary) 六角星|
| `\cong` | $\cong$ | Congruent (relation).  全等|
| `\dagger` | $\dagger$ | Dagger relation (binary). 厄米共轭  |
| `\ast` | $\ast$ | asterisk. 复共轭  |
| `\equiv` | $\equiv$ | Equivalence (relation).  恒等于 |
| `\subset` | $\subset$ | Subset (occasionally, is implied by) (relation) 子集|
| `\varphi` | $\varphi$ | Variant on the lowercase Greek letter 变型希腊字母 |
| `\zeta` | $\zeta$ | Lowercase Greek letter  |
| `\Zeta` | $\Zeta$ | Lowercase Greek letter  |
| `\xi` | $\xi$ | Lowercase Greek letter  |
| `\upsilon` | $\upsilon$ | Lowercase Greek letter  |
| `\mathsection` | $\mathsection$ | Section sign in math mode  |
| `\langle` | $\langle$ | Section sign in math mode 尖括号 |
| `\left| a \right|` | $\left\| a \right\|$ | absolute value 绝对值 |
| `\leftrightarrow` | $\leftrightarrow$ | 双向箭头 |
| `\widehat{}` | $\widehat{M}$ | 宽帽子 |
|`\sqrt[4]{8}`|$\sqrt[4]{8}$ | 四次根号`8` |

### 自定义数学符号

\mathrm v.s. \text

[is-there-a-preference-of-when-to-use-text-and-mathrm][]

[is-there-a-preference-of-when-to-use-text-and-mathrm]: https://tex.stackexchange.com/questions/19502/is-there-a-preference-of-when-to-use-text-and-mathrm

*Caution: the following discussion assumes that the package amsmath has been loaded.*
In general `\mathrm` should be used for "symbols" and `\text` for, yes, text . :)

However, it's best to use operators for clusters of Roman letters that represent functions: the commands `\lcm` and `\gcd` are predefined; for "ord" there's not a predefined command, but it suffices to put in the preamble

```latex
\DeclareMathOperator{\ord}{ord}
```

In this case `\text{divides}` and `\mathrm{divides}` might give the same result, but they are conceptually different (and can actually be printed in different ways, depending on the math fonts used).
Spaces in the argument of `\mathrm` are ignored, for example. Moreover, `\text` honors the font of the surrounding environment: it will print in italics in the statement of a theorem.

Particular attention should be paid to units such as "`m/s`"; it's best not to do them "by hand", but employ a package like `siunitx` that takes care of all the subtleties, while being very flexible.

#### 求迹 Trace etc

```latex
\usepackage{amsmath}
\DeclareMathOperator{\Tr}{Tr}
```

### 定义配对的数学符号

绝对值

`\vert` `|`

Single line vertical bar (ordinary).

Similar: double-line vertical bar `\Vert`.
For such that, as in the definition of a set, use `\mid` because it is a relation.

For absolute value you can use the `mathtools` package and in your preamble put `\DeclarePairedDelimiter\abs{\lvert}{\rvert}`.

This gives you three command variants for single-line vertical bars that are correctly horizontally spaced:

在正文中,使用带星号的版本,`\abs*{\frac{22}{7}}`,竖线的高度会匹配参数的高度
而`\abs{\frac{22}{7}}`会保留默认高度. 
`\abs[size command]{\frac{22}{7}}`会给出指定的高度,比如`\Bigg`

### 微分符号

[在LaTeX中使用微分算子的正确姿势][]

[在LaTeX中使用微分算子的正确姿势 ]: https://www.latexstudio.net/archives/10115.html

\newcommand*{\dif}{\mathop{}\!\mathrm{d}}

```latex
\begin{displaymath}
\mathop{\sum \sum}_{i,j=1}^{N} a_i a_j
{\sum \sum}_{i,j=1}^{N} a_i a_j
\end{displaymath}
```

`\mathop` is considered to be a single variable sized math symbol for purposes of placing limits below (subscripts) and above (superscripts)  in display math style

数学符号的标准,首先是定义在 ISO 31-11 当中；而后这个标准被 ISO 80000-2:2009 取代. 
因此,此篇讨论的内容,都是基于 ISO 80000-2:2009 的.  在 ISO 80000-2:2009 中,微分算子被描述为

+ 直立的拉丁字母 `d`；
+ 一个右边没有间距的操作符. 

对于直立的拉丁字母 `d`,我们可以使用 `\mathrm{d}` 达成效果. 
而若要微分算子的左边有间距,而右边没有,这个问题就值得思考了.  最简单的办法,是将微分算子做如下实现

```latex
\newcommand*{\dif}{\,\mathrm{d}}
```

看起来,这样是没有问题的. 但是,在某些情况下,就会出现尴尬的问题. 比如

```latex
关于 $x$ 的微分 $\dif x$ 是指的思考的问题. 
```

因为在 `\dif` 的定义中,`\mathrm{d}` 之前有不可省略的铅空 `\,`. 
于是,这份代码中 `\dif x` 与前后正文之间的距离就不一致了. 为了解决这个问题,更有经验的人可能会选择这样定义

```bash
\newcommand*{\dif}{\mathop{\mathrm{d}}\!}
```

这份代码,试图利用 `\mathop`,只在必要的时候于左边插入空白,修复了上面的问题. 
不过,这样一来也带来了一些副作用——在 `\mathop` 的作用下,`\mathrm{d}` 的基线发生了改变,不再与正常的数学变量保持在同一个基线上. 这也是不好的.  
最终解决问题,应该对微分算子有这样的定义

```latex
\newcommand*{\dif}{\mathop{}\!\mathrm{d}}
```

在这个定义中,拉丁字母 d 本身的特点得到了保留（比如基线是正常的）. 
此外,在 \mathrm{d} 的左边,插入了一个空白的 `\mathop{}`；其左边的空白保留,而右边与 `\mathrm{d}` 之间的距离,则由 `\!` 抑制. 这样就达成了我们的目标.  

数学公式环境中,本来就没有距离,所以`\mathrm{d}`什么都没有,就代表右侧没有距离,
左边的`\!`是用来把`\mathrm{d}`往左移动的,就是离左边稍微近一点,因为插入了一个空白的数学符号. 

测试如下：

```latex
$\int\,\mathrm{d} x$\\
关于 $x$ 的微分 $\,\mathrm{d} x$ 是指的思考的问题. \\
$\int \mathop{\mathrm{d}}\! x $\\
关于 $x$ 的微分 $\mathop{\mathrm{d}}\! x$ 是指的思考的问题. \\
$\int \mathop{}\!\mathrm{d} x $\\
关于 $x$ 的微分 $\mathop{}\!\mathrm{d} x$ 是指的思考的问题. \\
$\int \mathop{}\mathrm{d} x $\\
关于 $x$ 的微分 $\mathop{}\mathrm{d} x$ 是指的思考的问题. \\
```

### 上下划线和大括号

[LaTeX教学3.2.2 数学结构-上下划线和大括号][]

[LaTeX教学3.2.2 数学结构-上下划线和大括号]: https://www.jianshu.com/p/0217f22ebb3e

有的时候我们会需要在公式的上面或者下面打一条线, 这时候我们需要用到两个命令：

`\overline`和`\underline`

这是两个带一个必要参数的命令 , 分别用来在公式上作上划线和下划线. 比如：

除了横线和箭头, 数学公式还可以使用`\overbrace`和`\underbrace`来带上花括号, 如

同时我们还可以用上下标在花括号上做标注, 如

```latex
\[
 ( \overbrace{a_{0},a_{1},\dots,a_{n}}^{n+1} )=
 ( \underbrace{0,0,\dots 0}_{n},1 )
\]
```

### 下划线,中划线

[LaTeX文字的加粗、斜体、下划线、删除线等][]

[LaTeX文字的加粗、斜体、下划线、删除线等]: https://www.jianshu.com/p/a1838fa53882

+ 加粗 `\textbf{文字}`
+ 斜体 `\emph{文字}`
+ 下划线 `\underline{文字}`
+ 删除线 
删除线需要调用package：
`\usepackage{ulem}`
而后是：
+ `\sout{文字}` %删除线
+ `\uwave{文字}` %波浪线
+ `\xout{文字}` %斜删除线
+ `\uuline{文字}`  %双下划线

### 多重下标

[如何排版公式的多行下标][]

[如何排版公式的多行下标]: https://jingyan.baidu.com/article/59703552e0fae18fc1074043.html

第一种方法

我们可以使用命令`\substack`,可以排版多重上标或下标,两行之间用`\\`分隔,居中显示. 

例如：

```latex
\begin{equation}
\sum_{\substack{k_0,k_1,\dots>0\\   k_0+k_1+\dots=n}}   F(k_i)
\end{equation}
```

第二种方法

我们可以使用`subarray`环境来实现多行上下标,且可以自己选择对齐方式. 

```latex
\begin{gather}
  \sum_{\substack{0 \le i \le m\\
  0 < j < n}}P(i, j)\\
  \sum_{\begin{subarray}{l}
    i \in \Lambda \\
    0 \le i \le m \\
    0 < j < n
  \end{subarray}} P(i, j)
\end{gather}
```

## newcommand 新命令

[LaTeX2e unofficial reference manual (October 2018)][]

[LaTeX2e unofficial reference manual (October 2018)]: http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html

12.1 \newcommand & \renewcommand

语法,使用下面形式中的一个:

```latex
\newcommand{\cmd}{defn}
\newcommand{\cmd}[nargs]{defn}
\newcommand{\cmd}[nargs][optargdefault]{defn}
\newcommand*{\cmd}{defn}
\newcommand*{\cmd}[nargs]{defn}
\newcommand*{\cmd}[nargs][optargdefault]{defn}
```

or one of these.

```bash
\renewcommand{\cmd}[nargs]{defn}
\renewcommand{\cmd}[nargs]{defn}
\renewcommand{\cmd}[nargs][optargdefault]{defn}
\renewcommand*{\cmd}{defn}
\renewcommand*{\cmd}[nargs]{defn}
\renewcommand*{\cmd}[nargs][optargdefault]{defn}
```

定义或重定义一个命令. See also the discussion of \DeclareRobustCommand in Class and package commands.
这两个命令的`*`号形式要求参数中不包含多段文字. （用 `plain TeX` 术语说,不能为`\long` ）. 

参数说明:

+ `cmd`：必选,命令名称. 用`\`开头. 且不能以`\end`开头,对于`\newcommand`,命令不能定义过. 
对于`\renewcommand`,命令必须已经定义过. 
+ `nargs`:可选,一个从`0`到`9`的整数. 指定命令接受的参数个数,包括可选参数. 忽略这个参数相当于设定为`0`,
意味着命令不接受参数. 如果重定义命令,新命令可以和旧命令的参数数目可以不一样. 
+ `optargdefault`：可选. 如果这个参数存在,`\cmd`的第一个参数将是可选参数（可以是空字符串）. 如果这个参数不存在,`\cmd`不使用可选参数. 也就是说,如果用`\cmd[optval]{...}`调用,`#1`将会被设置成`optval`; 如果用`\cmd{...}`调用,`#1`将会被设置成`optargdefault`. 两种情况下,必选参数都从`#2`开始. 
忽略`[optargdefault]`与使用`[]`是不同的,前一种情况, `#1`被设置为`optargdefault`；后一种情况,`#1`被设置为空字符串. 
+ `defn`: 需要；每次遇到`\cmd`就用`defn`替换. 参数`#1`,`#2`被替换成你提供的值. `Tex`会忽略跟在`\cmd`后面的空白. 如果你想要一个空白,使用`\cmd{}`或者使用显式的控制序列`'\cmd\ '`. 
一个简单的定义新命令的例子：`\newcommand{\RS}{Robin Smith}`,文中的每个`\RS`会被`Robin Smith`替换. 
重定义命令是类似的`\renewcommand{\qedsymbol}{{\small QED}}`.
用`\newcommand`重定义命令,或者用`\renewcommand`定义新命令,都会报错. 

Here the first command definition has no arguments, and the second has one required argument.

```bash
\newcommand{\student}{Ms~O'Leary}
\newcommand{\defref}[1]{Definition~\ref{#1}}
```

使用第一个命令时,建议用`\student{}`(以便于和后面有空格区分开). 
第二个命令有一个变量,`\defref{def:basis}`将会展开成`Definition~\ref{def:basis}`,最终展开成类似于`Definition~3.14`. 

类似地,两个必选参数：`\newcommand{\nbym}[2]{$#1 \times #2$}`,调用时使用`\nbym{2}{k}`.

可选参数的例子：`\newcommand{\salutation}[1][Sir or Madam]{Dear #1:}`
`\salutation`给出`Dear Sir or Madam:`,`\salutation[John]`给出`Dear John:`.
`\salutation[]`给出 `Dear :`

这个例子给出一个可选参数和两个必选参数：

```bash
\newcommand{\lawyers}[3][company]{#2, #3, and~#1}
I employ \lawyers[Howe]{Dewey}{Cheatem}.
```

输出是`I employ Dewey, Cheatem, and Howe`.
`\lawyers{Dewey}{Cheatem}`将给出`I employ Dewey, Cheatem, and company`

`defn` 周围的大括号并不会定义一个组,也就是说,它并不会限制指令的生效范围. 
比如,使用`\newcommand{\shipname}[1]{\it #1}`, 

```latex
The \shipname{Monitor} met the \shipname{Merrimac}.
```

单词 `met the`也会变成斜体`italics`. 解决方法是在定义中额外加上一对大括号：

```latex
\newcommand{\shipname}[1]{{\it #1}}
```

## latex 注音符号

http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html#Accents

23.5 Accents

### \RequirePackage \usepackage 区别

[What's the difference between \RequirePackage and \usepackage?][]

[What's the difference between \RequirePackage and \usepackage?]: https://tex.stackexchange.com/questions/19919/whats-the-difference-between-requirepackage-and-usepackage

惯例是在包或者文档类中使用`\RequirePackage`,在文档中使用`\usepackage`

`\RequirePackage`可以用在`\documentclass ....`之前

you can write :

```latex
\RequirePackage{atbegshi}      
\documentclass ....
```

and not

```latex
\usepackage{atbegshi}      
\documentclass ...
```

## 保留字符 Reserved characters

[23.1 Reserved characters][]

[23.1 Reserved characters]: http://tug.ctan.org/tex-archive/info/latex2e-help-texinfo/latex2e.html#index-_005c_007e

LaTeX为特殊目的预留了以下字符.  例如,百分号％用于注释.  它们被称为保留字符或特殊字符. 

`# $ % & { } _ ~ ^ \ `

除了最后三个,都可以用转义实现

If you want a reserved character to be printed as itself, in the text body font, for all but the final three characters in that list simply put a backslash \ in front of the character. Thus, typing \$1.23 will produce $1.23 in your output.
最后三个要使用
`\~{}` ： 本来是用来给后面跟的字符加上波浪线的
`\^{}`：同理,本是用来加上音调符号的
`\textbackslash{}`：这个不知道有啥用,就是加个`backslash`

若要使用`typewriter font `,使用`verb!! `语法

```latex
\begin{center}
  \# \$ \% \& \{ \} \_ \~{} \^{} \textbackslash \\
  \verb!# $ % & { } _ ~ ^ \!
\end{center}
```

## 原文 verbatim

### verb 宏

概要：

```latex
\verb char文字文本char
\verb * char文字文本char
```

使用打字机（`\tt`）字体对输入的文字文本进行原样排版，包括特殊字符和空格。
此示例显示了`\verb`的两种不同调用。

```latex
This is \verb!literally! the biggest pumpkin ever.
And this is the best squash, \verb+literally!+
```

第一个`\verb`的文字文本带有感叹号`！`。第二个取而代之的是使用加号`+`，因为感叹号是文字文本的一部分。

包围文字文本的单字符定界符`char`必须相同。
`\verb`或`\verb*`与`char`之间，`char`与文字文本之间，或文本与第二个`char`之间不能有空格
（上面的空格是为了区分不同部分）。分隔符不能出现在后续文本中，文本中不能包含换行符。
`*`形式的不同之处仅在于，空格以可见的空格字符打印。

### verbatim 环境

概要：

```latex
\ begin {verbatim}
文字文本
\ end {verbatim}
```

创建一个段落，对内容原样输出。例如，在文字文本中，反斜杠`\`字符不会启动命令，它会产生一个打印的`\`，
并按字面意义使用回车符和空格。输出以类似等距打字机的字体（`\tt`）出现。
文字文本的唯一限制是它不能包含字符串`\end {verbatim}`。
您不能在宏的参数（例如`\section`的参数）中使用逐字记录环境。（但是cprotect软件包可以帮助您解决此问题。）

`verbatim`的一种常见用法是排版计算机代码。有一些软件包可以改善`verbatim`。
例如，一种改进是允许逐字包含外部文件或这些文件的一部分，比如`listings`, and `minted`.
一个为`verbatim`环境提供更多选项的软件包是`fancyvrb`。另一个是`verbatimbox`。
有关所有相关软件包的列表，请参见CTAN。
