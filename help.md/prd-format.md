# aps-format

## 格式

### Preprint, reprint, and twocolumn options

三种格式：

+ reprint： 接近出版效果
+ Preprint：
+ twocolumn：

REVTEX 4.2 设计成切换单双栏，只需在设置中更改选项。

preprint 做三件事：增加字号到12 pt， 增加行距，改变格式到单栏。

Manuscripts 提交到 APS 时，应该是  letter size paper。

## FRONT MATTER 前置段落

front matter (title, authors,affiliations, abstract, etc）

### 标题

使用 `\title` macro.
使用 double backslash `\\` 换行

### 作者，机构，合作组

Authors, affiliations, and collaborations

REVTEX 4.2 会自动处理好作者和机构的 grouping 问题。
如果使用 superscript style，numbering affiliations
Please follow these guidelines:

+ 对于每个作者名，使用 \author macro，rt 会自动加上所有逗号和 "and"
+ 使用 `\surname` 详细制定 作者的 family name，如果 family name 有多个名字，或者不是 last name
+ 用 `\email` macro 指定 电子邮件地址，不要用 `\thanks`。其中只能出现电子邮件地址本身。
+ 用 `\homepage` 指定主页，同理不要用  `\thanks`， 其中只能出现 URL
+ 用 `\altaffiliation` 指定 机构，同理不要用  `\thanks`
+ 上面放不下的，用 `\thanks`
+ 对于每一个机构，用一个单独的 `\affiliation`
+ Superscripts linking 作者和机构，将会通过 `superscriptaddress` 选项自动完成，而不是手工
+ 合作组请用 `\collaboration` 指定，而不是`\author`

#### 摘要- Abstract

摘要需要通过 `abstract` 环境指定，
`abstract` 必须出现在 `\maketitle` 命令之前
rt4.2 现在支持 结构性摘要，用法如下：

```latex
\begin{abstract}
\begin{description}
\item[Background] This part would describe the
context needed to understand what the paper
is about.
\item[Purpose] This part would state the purpose
of the present paper.
\item[Method] This part describe the methods
used in the paper.
\item[Results] This part would summarize the
results.
\item[Conclusions] This part would state the
conclusions of the paper.
\end{description}
\end{abstract}
```

### 参考文献和脚标

REFERENCES AND FOOTNOTES

建议使用 BibTEX 准备 bibliographies。
如果用BibTEX的话，需要把 `.bbl`  文件 included directly into main `.tex` file
在 rt4.2 中，BibTEX styles 被修改成，显示 杂志-文章名

不管用不用BibTEX，应该满足以下条件

1. 使用 `\cite` and `\bibitem` command 创建和引用 参考文献，
2. rt4.2 提供一种新的语法，组合多个引用到一个条目中，或者在参考文献前或后放入额外文字。
Footnotes 用 `\footnote` macro 指定，rt4.2 将把脚注放在 bibliography 中。
需要运行 BibTEX 让 footnotes出现
3. 不要用自定义的 `\footnotemark` 或者 `\footnotetex`
4. 参考文献风格应该满足 Physical Review Style Guide，若使用 BibTEX automatically ensures this
5. E-print identifiers 应该通过使用`\eprint` macro 引入，如果有eprint field，BibTEX 会自动处理好。

Please see the **REVTEX 4.2 Author's Guide** for new features in  REVTEX4.2's APS BibTEX styles,
including support for citing data sets, journals that use DOIs in place of page numbers,
and journals that use year and issue instead of volume to uniquely identify articles

## 正文部分

BODY OF THE PAPER

### 分节和交叉引用

用 `\section`, `\subsection`, `\subsubsection` 来给文章分节，
交叉引用必须用 `\label` and `\ref` commands
不要手动引用，
不要用`\part`, `\chapter`, and `\subparagraph`

### 附录

appendix

附录应该通过 `\appendix` 指定，其后的 `\section` commands 创建 附录。

如果只有一个附录，也可以用 `\appendix*`

### 致谢

Acknowledgments

致谢应该用 acknowledgments **环境**

### 计数器

Counters

不要自创计数器，也不要更改标准的计数器，
实在想用，可以用 `\tag` command (requires the amsmath class option)
`\tag` 可能会跟 hyperref package 冲突。

### 字体

Fonts

不要用老掉牙的 `\rm`, `\it`, etc. 用 LATEX2e 中引入的吧。
字体和数学字体的控制命令如下

粗体 Greek letters 或者其他粗体数学符号，可以用 LATEX2e 中的 `bm.sty` 实现。
loaded via `\usepackage{bm}`
这个包引入了 `\bm` macro, 一些粗体字母可能需要 using the `amsfonts` class option

不要用 `\newfont` 创建新字体。不要自己选择 font family, shape, and series
the standard LATEX2e font selection macros list above should be used instead

最后，不要用`\symbol` macro

|   |   |
| -----  |  ----- |
| `\textit` | Italics. Replaces `\it` |
| `\textbf` | Bold face. Replaces `\bf` |
| `\textrm` | Roman. Replaces `\rm` |
| `\textsl` | Slanted. Replaces `\sl` |
| `\textsc` | Small caps. Replaces `\sc` |
| `\textsf` | Sans serif. Replaces `\sf` |
| `\texttt` | Typewriter. Replaces `\tt` |
| `\textmd` | Medium series |
| `\textnormal` | Normal |
| `\textup` | Upright |
| `\mathbf` | Bold face |
| `\mathcal` | Replaces `\cal` |
| `\mathit` | Italics |
| `\mathnormal` | Replaces `\mit` |
| `\mathsf` | Sans serif |
| `\mathtt` | Typewriter |
| `\mathfrak` | Fraktur: Requires amsfonts or amssymb class option |
| `\mathbb` | Bold blackboard: Requires amsfonts or amssymb class option |
| `\bm` | Bold Greek and other math symbols: Requires `\usepackage{bm}` and may require the amsfonts class option |

### 环境

Environments

标准的列表环境都允许， `itemize`, `enumerate`, and `description`
`\item` macro 有没有参数都行。
自定义的 列表环境（通过用 `\labelstyle`, `\labelitemi`, `\labelenumi`, `\itemsep`, etc.）也行，不过可能会被忽略。

Generalized lists (`\begin{list}`) and trivial lists (`\begin{trivlist}`) are not allowed

### 其他环境

一般定义新环境是不行的，但是`\newtheorem` 是可以的。

The tabbing environment and the macros `\=`, `\>`, `\'`, and `\'` are allowed but may be ignored in production.

Conversion programs used in production should recognize the escapes `\a=`, `\a'`, and `\a'` for using the corresponding accents within a tabbing environment though.

The `verbatim` environment is allowed.

### 盒子

Boxes

大多数盒子命令是不行的。包括：

These include `\raisebox`, `\parbox`, `\minipage`, `\rulebox`, `\framebox`, `\mbox`, `\fbox`, `\savebox`, `\newsavebox`, `\sbox`, `\usebox`, and the environment `\begin{lrbox}`.

Rules produced with `\rule` are not allowed.

#### Margin Notes

不要用 `\marginpar`，也不要修改 `\marginparwidth`, `\marginparsep`, and `\marginparpush`.

## 图片

FIGURES

### 插入图片

Figure inclusions

LATEX2e 中两个主要的用来插入图片的包 `graphics` and `graphicx`。

Both offer a macro called `\includegraphics`;
they mainly differ in how arguments for controlling figure placement
(e.g., scaling and rotation) are passed to the `\includegraphics`.

图片应该被放置在 figure 环境中，以便于加长 caption 和放置到合适的位置上。

如果需要在文中引用图片，应该使用 `\label`, 比如把 `\label` 加入到 `\caption` 的参数里。
跨页面的图形应该用 \figure* 环境。

不要直接使用 picture 环境
(one can include an Encapsulated PostScript figure that was produced using the picture environment of course）

### 图片放置

Figure placement

图片紧接着，被第一次引用的位置放置即可。

没有必要在末尾再次附上所有图形。

REVTEX 4.2 有一个选项 floatfix class option，
可以对“stuck” floats 进行紧急排列，否则的话它们一般会被推迟到末尾。
(and can lead to the fatal "Too many unprocessed floats" message)

## 表格

使用 LATEX2e 标准表格排版环境即可，also the longtable package。

Hint：

使用 the longtable package 以使得表格跨页。
使用 macro \squeezetable 减小表格字体size。

The proper markup is

```latex
\begingroup
\squeezetable
\begin{table}
...
\end{table}
\endgroup
```

尝试浮动体的 placement option H  
which will enable LATEX to break a float across pages

Long tables are more attractively set with longtable however.

```latex
\begin{table}[H]
\begin{ruledtabular}
\begin{tabular}
...
\end{tabular}
\end{ruledtabular}
\end{table}
```

### Doubled rules and table formatting

REVTEX 4.2 提供了 ruledtabular environment，它会在表格四周自动放置 scotch rules (double lines) 。

And formats all enclosed tabular environments to the full width of the tables  and improves intercolumn spacing.

你可以尽量多用它。

### 宽表格

Wide tables

当使用双栏排版时，表格可以单栏或者跨栏。
使用 table or longtable environments 的 "*" 号版本，来实现跨栏。

特别宽的表格可以用 landscape orientation (rotated 90 degrees)。
者可以用 turnpage environment 实现。
这将使旋转过的表格在单独一页上呈现。

一些 dvi previewers 可能无法正常显示，但是 dvips and pdflatex 正常工作。

### 表格放置

Table placement

表格无需单独在文末列出。
也可以使用  class option floatfix 避免表格堆积。

### 表格沿小数点对齐

Aligning columns on a decimal point

The standard LATEX2e macro package `dcolumn` should be used to accomplish this

### 表格附注

Tablenotes

表格中的脚注一般用 `\footnote` macro 即可.
However, if more than one reference to the same footnote is needed, authors may use
`\footnotetext` and `\footnotemark`。

会在表格下方产生注解（labeled by lower-case roman letters），而不是在 reference 或者页面底部。

## 自定义宏

AUTHOR-DEFINED MACROS

为了减少敲键盘次数，作者也可以自定义 macros 。
但是不要调用上下文依赖的 commands 比如 \if .

LATEX2e 提供了三种声明新命令的宏：

`\providecommand`, `\newcommand`, and `\renewcommand`

以及带星号的版本（'*'-ed versions）

不要用TEX 的底层命令，如 `\def`, `\edef`, and `\gdef`

## 总结

尽量少用底层命令，越简单越好。
以避免杂志编辑过程中无法转换成 XML。

使用 REVTEX 4.2 or LATEX2e 中合适的宏。

## others

### PACS codes

PACS codes are obsolete. The showpacs option does
nothing, but is present so that older documents may still
be processed under REVT E X 4.2

### 关键词

Keywords

`\keywords` macro 用来显示关键词，如

```latex
\keywords{nuclear form; yrast level}
```

会显示在 `abstract` 下面，

"keywords" 是否显示，可以通过 `\documentclass` line 中的 选项控制

`showkeys` and `noshowkeys`

### 多行公式

表格的对齐，是按奇偶列对齐的，
比如135左对齐
246 右对齐
