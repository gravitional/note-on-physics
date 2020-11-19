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

建议使用 `BibTEX` 准备 bibliographies。
如果用 `BibTEX` 的话，需要把 `.bbl`  文件 included directly into main `.tex` file
在 rt4.2 中，`BibTEX` styles 被修改成，显示 杂志-文章名

不管用不用`BibTEX`，应该满足以下条件

1. 使用 `\cite` and `\bibitem` command 创建和引用 参考文献，
2. rt4.2 提供一种新的语法，组合多个引用到一个条目中，或者在参考文献前或后放入额外文字。
Footnotes 用 `\footnote` macro 指定，rt4.2 将把脚注放在 `bibliography` 中。
需要运行 BibTEX 让 footnotes 出现
3. 不要用自定义的 `\footnotemark` 或者 `\footnotetex`
4. 参考文献风格应该满足 Physical Review Style Guide，若使用 BibTEX automatically ensures this
5. E-print identifiers 应该通过使用`\eprint` macro 引入，如果有eprint field，BibTEX 会自动处理好。

Please see the **REVTEX 4.2 Author's Guide** for new features in  REVTEX4.2's APS BibTEX styles,
including support for citing data sets, journals that use DOIs in place of page numbers,
and journals that use year and issue instead of volume to uniquely identify articles

### bibtex 用法

bibtex 一般附在 Latex 发行版中，用于辅助制作 bibliographies

bibtex 需要你先准备一个 a database or collection of bibliography entries --- `.bib`

还有一个参考文献格式文件---`.bst` (bibtex style file)
它控制如何把 bib 转换成 latex 标准的 `\bibitem` 格式，可以修改成适应不同的杂志。

在文章 class 种设置合适的选择，会自动从 revtex4.2 中选择合适的 bst 文件，
5种基本的格式被包括在 revtex4.2 中：

+ `apsrev4-2.bst` (APS journals using a numeric citation style, i.e., all but RMP), 
+ `apsrmp4-2.bst` (author/year style citations
for RMP),
+ `aipauth4-2.bst` (AIP journal using an au-
thor/year citation style),
+ `aipnum4-2.bst` (AIP journals using a numeric citation style) 
+ `aapmrev4-2.bst` for AAPM journals. 

通过使用 latex2e 标准的 `\bibliographystyle` macro 指定另外的 `.bst` 可以覆盖这个选择。
但是命令必须出现在 preamble,  在 `\begin{document}` 行之前，这跟标准的latex2e 语法不同。

bibtex 的 `bib` 文件中将包含如下格式的 entries:

```bib
@Book{GSW,
author=''M. Greene, J. Schwarz,
E. Witten'',
title=''Superstring theory:
Introduction'',
publisher=''Cambridge University
Press'',
address=''London'',
year=''1985''
}
```

有各种各样的 entry 格式：

+ articles,
+ technical reports,
+ e-prints,
+ theses,
+ books,
+ proceedings,
+ articles that appear in books or proceedings

revtex4.2 提供的格式还允许 `URL` 和 `e-print` 标识符。
除了"author" field，还有"collaboration" field

在草稿中创建 参考文献时，请使用 `\bibliography{<bib files>}` macro

`<bib files>` 是一串用逗号分隔开的 bibtex bibliography database files
即`.bib`文件列表。
`\bibliography` macro 应该被放在参考文献要出现的地方，
一般是正文的后面。

latex 第一遍时，\cite macro 中引用的 key 会被写入 `.aux` 中，
然后运行  bibtex，就会产生 latex 需要的 `\bibitem` 条目，保存在以 `.bbl` 结尾的文件中。

接下来不断运行 `latex2e`，`latex2e` 会重复 call 这个 `bbl` 文件，直到参考文献都顺利显示。

使用 revtex style 文件产生的 `\bibitem` 看起来有些复杂。
这是因为 style 增加了 `\bibinfo`, `\bibnamefont`, `\eprint`, and `\url`
macros，用于指定额外的格式化和 tagging 。

`\bibinfo` macro 基本上啥也不干，只是用来标记从`bib` 文件得到的信息。

The `\eprint `and `\url` macros 用来创建合适的 `hyperlinks`，并适应最终的格式如`PDF`

更多使用帮助，请参考
Sections 4.3.1 and C.11.3 of the LATEX User's Guide & Reference Manual[2], Section 13.2 of [4], 
or the online BibTEX manual btxdoc.tex from `http://www.ctan.org/tex-archive/biblio/bibtex/distribs/doc/`.

### arXiv.org support

revtex4.2 支持引用 arXiv.org 的 e-prints。比如以下 `.bib` entry

```bib
@Unpublished{Ginsparg:1988ui,
author = "Ginsparg, Paul H.",
title = "{Applied Conformal Field Theory}",
year = "1988",
eprint = "hep-th/9108028",
archivePrefix = "arXiv",
SLACcitation = "%%CITATION=HEP-TH/9108028;%%"
}
```

将会包含arXiv.org e-print identifier as arXiv:hep-th/9108028 and
hyperlink it (if using hyperref)

arXiv 的新版标识符with `primary classifications`  will produce appropriate output
For example,

```bib
@Unpublished{Ginsparg:2014,
author = "Ginsparg, Paul",
title = "{Kenneth G. Wilson: Renormalized After-Dinner Anecdotes}",
year = "2014",
eprint = "1407.1855",
archivePrefix = "arXiv",
primaryClass = "physics.hist-ph",
}
```

will generate `arXiv:1407.1855 [physics.hist-ph]` and hyperlink it.

### noeprint option

在 revtex4.2 bibtex style 中，
the `noeprint` option 现在只 suppress
journal references 中的 arXiv identifiers，而保留 e-print references 中的 arXiv identifiers。

### Citing data sets with a DOI

BibTEX styles in REVTEX 4.2 增加了对 data sets 的支持，
使用了新的 BibTEX type @dataset：

```bib
@dataset{haigh:2016,
author = "Haigh, J. A. and Lambert, N. J. and
Sharma, S. and Blanter, Y. and
Bauer, G. E. W. and Ramsay, A. J.",
year = "2018",
title = "{Data from Figures in‘‘Selection rules
for cavity-enhanced Brillouin light scattering
from magnetostatic modes" [Data set]}",
doi = "10.5281/zenodo.1284434",
note = "{Zenodo}"
}
```

This results in the formatted reference: “J. A. Haigh,
N. J. Lambert, S. Sharma, Y. Blanter, G. E. W. Bauer,
and A. J. Ramsay, Data from Figures in “Selection rules
for cavity-enhanced Brillouin light scattering from mag-
netostatic modes” [Data set], 10.5281/zenodo.1284434
(2018), Zenodo.”

这主要用于有 DOI 分配的 data sets。

### Journal references with only DOIs

一些杂志转而使用 only a volume and DOI to identify an article，
不再分配page numbers or article identifiers. 

对于`Phys. Rev. journals` 使用的 `apsrev.bst` BibTEX style file，
如果bib 文件中 entry 的 pages field 缺失，但存在 DOI，
DOI将会will be explicitly displayed and linked in the formatted reference

### Journals that use the year and issue for unique citations

年份-期号

The `apsrev.bst` style used for `Phys. Rev. journals` now includes support for four journals that use the year in place of a volume and require an explicit issue to uniquely cite a paper:

+ J. High Energy Phys.
+ J. Cosmol. Astropart. Phys.
+ J. Instrum.
+ J. Stat. Mech.: Theory Exp.

The BibTEX entry 必须精确的匹配上述缩写之一，
或者使用相应的 macro:  `jhep`, `jcap`,`jinst`, or `jstat`,  
来触发相应的格式化，比如

```bib
@Article{Cotogno2017,
author="Cotogno, Sabrina and van Daal, Tom
and Mulders, Piet J.",
title="Positivity bounds on gluon {TMDs}
for hadrons of spin $\le$ 1",,
journal=jhep,
year="2017",
month="Nov",
day="28",
volume="2017",
number="11",
pages="185",
doi="10.1007/JHEP11(2017)185",
url="https://doi.org/10.1007/JHEP11(2017)185"
}
```

将会被格式化为
"S. Cotogno, T. van Daal, and P. J. Mulders, Positivity bounds on gluon TMDs for hadrons of spin ≤ 1, J. High Energy Phys. 2017 (11), 185."

### Multiple references in a single bibliography entry 

REVTEX 4.2 允许在单个 bibliography entry 中包含多个 reference，若使用BibTEX 的话。

这可以通过使用在 `\cite` 命令中使用带星号(*) 的参数实现。
并需要一个兼容的 `natbib` 版本和 REVTEX 4.2 自带的 bst 文件。
为了把多个ref 包括进一个 `\bibitem`，在 `\cite` command 中的第二、三等等
citation keys 前面加上asterisk(*)，例如：

`\cite{bethe, *feynman, *bohr}` 
会组合 `\bibitems` with keys `bethe`, `feynman`, and `bohr`，
使它们成为参考文献列表中的单个条目，用 semicolons 分隔。

### Prepending and/or appending text to a citation

The expanded syntax for the `\cite` command argument 
也可以用来指定 citation 前置的或后置的文本，例如：

```pdf
[19] A similar expression was derived in A. V. Andreev, Phys. Rev.Lett. 99, 247204 (2007) in the context of carbon nanotube p-n junctions. The only difference is that no integration over ky is present there.
```

可以用以下 `\cite` command 创建：

```latex
\cite{*[{A similar expression was derived in }] [{ in the context of carbon nanotube p-n junctions. The only difference is that no integration over ky is present there.}] andreev2007}
```

请注意其中用来封闭文字的 curly braces 以及 外面的 square brackets，
还有 brackets 后面的括号。

### natbib 简介

`natbib` 宏包重定义了 LATEX 命令 `\cite` ，可以采用作者年份格式或者数字
格式引用文献，
适用于 `plain` 等标准的参考文献格式, 也与 `harvard` `，apalike` ， `chicago` `，astron` `，authordate` 以及 `natbib` 等兼容。

与上述宏包相比， `natbib`  宏包不仅支持众多的作者年份格式，也支持标
准的数字格式引用。

事实上，它还可以在作者年份的文献格式下产生数字格式引用，而且很容易在两种引用模式间切换。为此，它也提供了替代标准 LATEX 文献格式的专用格式（.bst）。

natbib 宏包可以定义引用格式（如括号以及不同引用条目间标点的类型等），甚至可以关联文献格式名以自动激活不同引用格式，也可以通过当前的配置文件 `natbib.cfg` 为 `.bst` 文件定义引用格式。

natbib 宏包与 `babel` ， `index` ，`citeref` ， `showkeys` ， `chapterbib` ， `hyperref` ， `koma` 等宏包以及 `amsbook` ， `amsart` 等文档类兼容，
也能实现 `cite` 宏包的排 序与压缩功能，还能实现 Thorsten Ohl 写的 `mcite` 宏包的多个引用的合并功能。
然而， `natbib` 宏包本身与 `cite` 或 `mcite` 宏包不兼容。

应该注意的是实现文献列表中增加引用页码功能的 `citeref` 宏包必须在
`natbib` 宏包之后调用。
（调用 `hyperref` 宏包时设定 `pagebackref` 选项也有此
功能，而且提供了超链接。）

此外，natbib 宏包为大多常见的参考文献格式提供了统一而灵活的接口。

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
be processed under REVTEX 4.2

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
