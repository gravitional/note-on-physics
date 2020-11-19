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
