# tikz

用来替换`pdf` 粘贴过程额外`h..i`的正则表达式

```bash
\bh([\. ]+?)i\b # vscode 里面的正则，元字符 . 需要转义成 \.
<$1>
```

## tikz 示例教程

[TiKZ入门教程 ][]

[TiKZ入门教程 ]: https://www.latexstudio.net/archives/9774.html

安装`texlive`

我们先从一个最简单的例子开始：画一条直线。 代码如下：

```latex
\documentclass[tikz,border=10pt]{standalone} % 生成自动裁剪过的pdf
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
        \draw (0,0) -- (1,1);
    \end{tikzpicture}
\end{document}
```

这样,我们得到了一个`pdf`文件,我们用`pdf2svg`工具将其转换为`svg`格式的矢量图。
带`\`的都是LaTeX的宏命令,这段代码的核心就一句话 `\draw (0,0) -- (1,1)`;
这句话的意思就是从`(0,0)`到`(1,1)`画一条线段。我们还可以画的稍微复杂一点：

```latex
\documentclass[tikz,convert=pdf2svg]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
        \draw [color=blue!50,->](0,0) node[left]{$A$}-- node [color=red!70,pos=0.25,above,sloped]{Hello}(3,3) node[right]{$B$};
    \end{tikzpicture}
\end{document}
```

输出：可以看到,`\draw`后面的方括号中跟的是对线的一些设置,`color=blue!50`表示的是用`50%`的蓝色,因为LaTeX中,`%`用作了注释,所以这里用`!`替代,

`->`表示的是线形是一个箭头,我们注意到,在起点坐标,`-–`,终点坐标后面,我们分别加入了一个`node`元素,起点后面的`node`表示的是加入一个标示,它在坐标点`(0,0)`的左边,`--`后面的`node`采用`70%`的红色,位置在线段的上方`0.25`的位置,随线段倾斜,花括号中是`node`的文字,为`Hello`,终点坐标同理。

`node`经常用于加入一些标注,这一点我们在后面将会看到。

### 一些复杂的形状

在TikZ中,除了画线段之外,还支持各种复杂的形状,下面一个例子给出了一些常见的形状：

```latex
\documentclass[tikz,convert=pdf2svg]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
        \draw (0,0) circle (10pt);     %画一个圆心在原点,半径为10pt的圆；
        \draw (0,0) .. controls (1,1) and (2,1) .. (2,0);       %画一个起点为(0,0),终点为(2,0),控制点为(1,1),(2,1)的贝塞尔曲线；
        \draw (0,0) ellipse (20pt and 10pt);       %画一个中心在原点,长轴、短轴分别为20pt和10pt的椭圆；
        \draw (0,0) rectangle (0.5,0.5);       %画一个从(0,0)到(0.5,0.5)的矩形
        \filldraw[fill=green!20!white, draw=green!50!black](0,0) -- (3mm,0mm) arc (0:30:3mm) -- cycle;
        %画一个扇形,并填充,扇形的边色和填充色的透明度不同。
    \end{tikzpicture}
\end{document}
```

### 属性预定义

在刚才的例子中我们看到,随着我们对样式需求的多样化,属性越来越长,而且多个实体之间往往具有相同的属性,这样一来,我们希望能预定义一个属性集合,到时候直接赋给相应的实体,`TikZ`本身就是个宏,因此它为我们提供了强大的属性定义功能,来看这段代码：

```latex
\documentclass[tikz,convert=pdf2svg]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
    [
    L1Node/.style={circle,   draw=blue!50, fill=blue!20, very thick, minimum size=10mm},
    L2Node/.style={rectangle,draw=green!50,fill=green!20,very thick, minimum size=10mm}
    ]
       \node[L1Node] (n1) at (0, 0){$\int x dx$};
       \node[L2Node] (n2) at (2, 0){$n!$};
    \end{tikzpicture}
\end{document}
```

输出：在这段代码中,我们在最开始定义了两个名为`L1Node`和`L2Node`的属性,在生成`node`结点的时候直接填到属性的位置即可。

### 循环

TikZ相比于Viso的一个优势就在于其循环功能,Viso里面要循环画十个圆就得复制十次,还要调节各自的位置,如果遇到需要调整位置又得重来,TikZ这种命令行的方式能直接画出来,如果需要调整位置,更改参数即可,我们在上一个例子上生成十个结点：

```latex
\documentclass[tikz,convert=pdf2svg]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
    [
    L1Node/.style={circle,   draw=blue!50, fill=blue!20, very thick, minimum size=10mm},
    L2Node/.style={rectangle,draw=green!50,fill=green!20,very thick, minimum size=10mm}
    ]
       \foreach \x in {1,...,5}
        \node[L1Node] (w1_\x) at (2*\x, 0){$\int_\Omega x_\x$};
    \end{tikzpicture}
\end{document}
```

### node树

node结点不但可以用于添加标识,还可以来绘制树形图,下面看一个例子

```latex
\documentclass[tikz,convert=pdf2svg]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
        \node {root}
            child {node {a1}}
            child {node {a2}
                child {node {b1}}
                child {node {b2}}}
            child {node {a3}};
    \end{tikzpicture}
\end{document}
```

稍微加点样式：

```latex
\documentclass[tikz,convert=pdf2svg]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}
    [every node/.style={fill=blue!30,draw=blue!70,rounded corners},
     edge from parent/.style={blue,thick,draw}]
        \node {root}
            child {node {a1}}
            child {node {a2}
                child {node {b1}}
                child {node {b2}}}
            child {node {a3}};
    \end{tikzpicture}
\end{document}
```

### 绘制函数图像

TikZ提供了强大的函数绘制功能,下面的代码展示了如何绘制函数,当然,绘制数据图表并非TikZ擅长的事情,也并非其设计初衷,TikZ着眼于定性的图表,定量数据的演示还是用其他工具绘制较好。

```latex
\documentclass[tikz]{standalone}
\usepackage{tikz}
\begin{document}
    \begin{tikzpicture}[domain=0:4]
  \draw[very thin,color=gray] (-0.1,-1.1) grid (3.9,3.9);
  \draw[->] (-0.2,0) -- (4.2,0) node[right] {$x$};
  \draw[->] (0,-1.2) -- (0,4.2) node[above] {$f(x)$};
  \draw[color=red]    plot (\x,\x)             node[right] {$f(x) =x$};
  % \x r 表示弧度
  \draw[color=blue]   plot (\x,{sin(\x r)})    node[right] {$f(x) = \sin x$};
  \draw[color=orange] plot (\x,{0.05*exp(\x)}) node[right] {$f(x) = \frac{1}{20} \mathrm e^x$};
\end{tikzpicture}
\end{document}
```

TikZ提供了图的支持,通过类似于`dot`语言的方式来生成图关系

```latex
\documentclass[tikz]{standalone}
\usepackage{tikz}
\usetikzlibrary{graphs}
\begin{document}
\begin{tikzpicture}
    \graph {
        "$x_1$" -> "$x_2$"[red] -> "$x_3,x_4$";
        "$x_1$" ->[bend left] "$x_3,x_4$";
    };
\end{tikzpicture}
\begin{tikzpicture}
    \graph  {
     a -> {
        b -> c,
        d -> e
     } -> f
    };
\end{tikzpicture}
\end{document}
```

[各种更样的示例](http://www.texample.net/tikz/examples/)

```latex
\coordinate [label=left:{$a$}](a) at (0,0);
\draw (a) circle (0.5);
\node[inner color=white, outer color=orange,inner sep=0.5cm] (b) at (5,2){$b$};
\draw (a)--(b);
\draw (a) .. controls (1,3) and (5,5) .. (b);
\draw (a) -| (b);
\draw (a)|- (b);
```

## tikz 教程

32
tikz中，路径就是一连串的坐标，在路径的开头可以选择

+ `\path` 什么也不做
+ `\draw` 画出路径
+ `\fill` 填充路径
+ `\filldraw` 等等

对路径的操作。用分号表示一条路径的结束。每一条路径会有初始点，当前点等等特殊坐标。
如`current subpath start`

路径构建命令和绘画命令相分离，与路径构建的选项，都在路径命令中指定；
与实际描绘相关的选项，都在`\draw`,`\fill`等命令的选项中指定。

曲线 33
`\draw (0,0) .. controls (1,1) and (2,1) .. (2,0);`

圆形
`(1,1) circle [radius=2pt]`
`ellipse [x radius=20pt, y radius=10pt]`

方形
`\draw (0,0) rectangle (0.5,0.5);`
`\draw[step=.5cm] (-1.4,-1.4) grid (1.4,1.4);`

自定义格式 35

```latex
help lines/.style={color=blue!50,very thin} %在环境内部任意地方定义格式
\tikzset{help lines/.style=very thin} %在文档开头，定义全局格式
\tikzset{Karl's grid/.style={help lines,color=blue!50}} %格式可以嵌套
```

绘制选项 36

```latex
%颜色
color=<color>
draw=<color>
%%线型
ultra thin
very thin
thin
semithick
thick
very thick
ultra thick
%% 虚线
dashed
loosely dashed
densely dashed
dotted
loosely dotted
densely dotted
dash pattern
```

剪切出图形的某一部分

```latex
\draw[clip] (0.5,0.5) circle (.6cm);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
...
```

抛物线 38

```latex
\tikz \draw (0,0) rectangle (1,1)(0,0) parabola (1,1);
\tikz \draw[x=1pt,y=1pt] (0,0) parabola bend (4,16) (6,12);
```

填充封闭区域，使用`cycle`进行封闭 39

```latex
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20!white, draw=green!50!black] (0,0) -- (3mm,0mm)
arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\end{tikzpicture}
```

过渡颜色 39

```latex
\shadedraw[left color=gray,right color=green, draw=green!50!black](0,0) -- (3mm,0mm)
```

定义命令，相对坐标指定

```latex
(30:1cm |- 0,0) % 垂直线与水平线的交点
\def\rectanglepath{-- ++(1cm,0cm) -- ++(0cm,1cm) -- ++(-1cm,0cm) -- cycle} %%连续相对坐标
\def\rectanglepath{-- +(1cm,0cm) -- +(1cm,1cm) -- +(0cm,1cm) -- cycle} %% 同源相对坐标
```

## tikz 设计原则

page 124

TikZ遵循以下基本设计原则：

1. 用于指定`points`的特殊语法。
2. 指定`path`的特殊语法。
3. Actions on paths。
4. 图形参数的`Key–value`语法。
5. `nodes`的特殊语法。
6. `trees`的特殊语法。
7. `graphs`的特殊语法。
8. 对图形的参数分组。
9. 坐标转换系统。

## scope 作用范围

131 Using Scopes to Structure a Picture

如果不生效的话，可以尝试在导言区添加

```latex
\usetikzlibrary {scopes}
```

命令 `\path` 用于创建一个路径 (path),此命令可以带有图形选项 (graphic options),这些选项只对本路径有效。使用简写形式的 scope 可以在路径内部插入一个 `scope`:

```latex
\tikz \draw (0,0) -- (1,1)
{[rounded corners, red] -- (2,0) -- (3,1)}
-- (3,0) -- (2,1);
```

上面例子中,选项 `rounded corners` 的作用范围受到花括号的限制,并且颜色选项 red 没有起到作用,这是因为 `\draw` 的默认颜色是 `draw=black`,颜色 `black` 把 `red` 覆盖了。
还要注意开启 scope 的符号组合`{[...]`要放在坐标点之后、`--`之前。

## 坐标计算

148

## tikz 图形对齐

[LaTeX中tikz画的图放在公式环境中如何和公式对齐](https://www.zhihu.com/question/381314763/answer/1096658439)

```latex
\documentclass{ctexart}
\usepackage{adjustbox}
\usepackage{tikz}

\makeatletter
\newcommand\valignWithTikz[1]{%
  text \tikzcircle{#1} text, $a^2 + \tikzcircle{#1} + b^2$ \par
}
\newcommand\tikzcircle[1]{%
  \tikz[#1] \draw (0, 0) circle (.5);
}

\newcommand\sep{\par\hspace*{10em}}
\makeatother

\begin{document}
\subsection*{默认效果}
绘图底部和文字基线对齐 \sep
  \valignWithTikz{}

\subsection*{使用 \texttt{baseline} 选项}
\verb|\tikz[baseline=(current bounding box.center)]| \sep
  \valignWithTikz{baseline=(current bounding box.center)}
调整纵向偏移,\verb|\tikz[baseline={([yshift=-.5ex]current bounding box.center)}]| \sep
  \valignWithTikz{baseline={([yshift=-.5ex]current bounding box.center)}}

\subsection*{使用 \texttt{\char`\\adjustbox} 命令的 \texttt{valign} 选项}
\renewcommand{\tikzcircle}[1]{%
  \adjustbox{valign=#1}{\tikz \draw (0, 0) circle (.5);}%
}
\verb|\adjustbox{valign=M}{\tikz ...}| \sep
  \valignWithTikz{M}
\verb|\adjustbox{valign=m}{\tikz ...}| \sep
  \valignWithTikz{m}
\end{document}
```

### 例子

```latex
\begin{equation}
\begin{aligned}
-i M^2 (p^2)=
\adjustbox{valign=M}{
\feynmandiagram [layered layout, horizontal=b to c] {
a -- [photon, momentum=\(p\)] b
-- [fermion, half left, momentum=\(k\)] c
-- [fermion, half left, momentum=\(k-p\)] b,
c -- [photon, momentum=\(p\)] d,

}};
\end{aligned}
\end{equation}
```

## 指定坐标点

136 Specifying Coordinates

148 坐标计算

坐标总是放在圆括号内，一般的语法是 `([hoptionsi]<coordinate specification>)`。有两种指定坐标的方法：

明确指定坐标系统和参数，使用`xxx cs:`这种语法

```latex
\draw (canvas cs:x=0cm,y=2mm)
-- (canvas polar cs:radius=2cm,angle=30);
```

或者可以隐式地指定，tikz 会根据格式自动判断坐标系统。例如 `(0,0)` 对应笛卡尔坐标,`(30:2)` 对应极坐标 (其中 `30` 代表角度)。

+ 基本使用:`(1cm,2pt)`
+ 极坐标:`(30:1cm)`
+ `PGF-xy` 坐标系统, unit in cm :  `(2,1)`
+ `PDF-xyz` 坐标系统:`(1,1,1)`
+ 也可以使用利用之前定义的形状作为锚点,如:`(first node.south)`
+ 连续相对坐标:`++(1cm,0pt)`,`(1,0) ++(1,0) ++(0,1)`给出`(1,0), (2,0),(2,1)`
+ 同源相对坐标:`+(1,0) +(1,0) +(0,1)` 给出 `(1,0), (2,0), (1,1)`.

## 指定路径

路径是一些直线和曲线的组合。
部分使用`metapost`的语法,例如,一条三角形路径

```latex
(5pt,0pt) -- (0pt,0pt) -- (0pt,5pt) -- cycle
```

p168 The Let Operation

### 对路径的action

路径只是一系列直线和曲线的组合,但你尚未指定如何处理它。
可以绘制一条路径,填充一条路径,为其着色,对其进行裁剪或进行这些操作的任意组合。

`draw`,`fill`,`shade`,`clip`

例如

```latex
\path[draw] (0,0) rectangle (2ex,1ex)
```

`\path[draw]`: `\draw`
`\path[fill]` :`\filldraw`
`\path[shade]`:`\shade` and `\shadedraw`
`\path[clip]`:
`\draw[clip]` or `\path[draw,clip]`: `\clip`

所有这些命令只能在`{tikzpicture}`环境中使用。
`TikZ` 允许您使用不同的颜色进行填充和描边。

### node 指定

p224

基本语法：

```latex
\path ... node <foreach statements>  [<options>] (<name>) at (<coordinate>) : <animation attribute>
={<options>} {<node contents>} ...;
```

各部分规范的顺序。 在`node`和`{<node contents>}`之间的所有内容都是可选的。如果有`<foreach>`语句,它必须首先出现,紧接在`node`之后。
除此之外,节点规范的所有其他元素（ `<options>` ,`name`,`coordinate` 和 `animation attribute` ）的顺序都是任意的,
实际上,这些元素中的任何一个都可能多次出现（尽管对于`name`和`coordinate`,这没有意义）。
例如

```latex
\vertex (a2) at (0,0){2};
```

***
`at` p158

```latex
\path ... circle[<options>] ...;
/tikz/at=<coordinate>
```

如果在`<options>`内部显式设置了此选项（或通过`every circle`样式间接设置），则`<coordinate>`将用作圆的中心而不是当前点。 在一个封闭范围内给某个值设置`at`无效。

### node位置的相对指定

240

```latex
/tikz/below=<specification>
/tikz/left=<specification>
/tikz/right=<specification>
/tikz/below left=<specification>
/tikz/below right=<specification>
/tikz/above left=<specification>
```

`/tikz/above left=<specification>`类似`above`,但是`<shifting parti>`的指定更加复杂。

1. 当`<shifting part>`形式为`<number or dimension> and <number or dimension>`的时候(注意中间有个`and`)，先向左移动，再向右移动（通常这令人满意，除非你使用了`x` and `y`选项，修改了`xy`--坐标系的单位矢量。）
2. 当`<shifting part>`形式为`<number or dimension> `时，也就是只给出一个参数，向对角线方向(135度方向)移动$\frac{1}{2}\sqrt{2}cm$。按照数学的说法，就是按照$l_{2}-norm$理解，相当于极坐标中的半径。而`<number or dimension> and <number or dimension>`是按照$l_{1}-norm$理解。

## 自定义

### 自定义 style

```latex
\begin{tikzpicture}[abcde/.style={
  double distance=10pt,
  postaction={
  decorate,
  decoration={
      markings,
      mark=at position .5 with {\arrow[blue,line width=1mm]{>}},
    }
  }
  }]

  \begin{feynman}
  ...
  \end{feynman}

  \draw [help lines] grid (3,2);
  \draw[abcde]  (a1) -- (b1);

\end{tikzpicture}
```

### 指定线型

173 Graphic Parameters: Line Width, Line Cap, and Line Join

`/tikz/dash pattern=<dash pattern>`
`/tikz/dashed` ： 指定虚线模式的简写
Shorthand for setting a dashed dash pattern.

### 指定 node 节点的形状

224 Nodes and Their Shapes

比如

```tikz
\begin{tikzpicture}
\draw (0,0) node[minimum size=2cm,draw] {square};
\draw (0,-2) node[minimum size=2cm,draw,circle] {circle};
\end{tikzpicture}
```

### 添加任意装饰

p191 Arrows 箭头

p196 指定箭头大小，形状

p212 Reference: Arrow Tips 与定义箭头形状参考

```tikz
\usetikzlibrary{arrows.meta}
```

p365 Decorated Paths 装饰路径

p646 Arbitrary Markings 添加任意装饰

Decoration markings

`marking`可以被认为是"小图片"，或更准确地说是放置的`some scope contents`，放置在路径的某个位置"上"。
假设`marking`为简单的十字。 可以用以下代码产生：

```latex
\draw (-2pt,-2pt) -- (2pt,2pt);
\draw (2pt,-2pt) -- (-2pt,2pt);
```

如果我们将此代码用作路径上`2cm`处的`marking`，则会发生以下情况：
`pgf`先确定沿路径2cm的位置。 然后将坐标系平移到此处并旋转它，使`x`轴正向与路径相切。 然后创建一个保护用的`scope`，在内部执行上述代码--最后路径上出现一个叉叉。

`marking`允许在路径上放置一个或多个装饰。除了后面讲的少数情况，`decoration`摧毁路径输入，也就是说，计算完成，作完装饰之后，路径就消失了。一般需要`postaction`来添加装饰。
`postaction` 表示完成路径绘制之后再进行操作。

```latex
\begin{tikzpicture}[decoration={
        markings,% 启用 markings
        mark=% mark 的形状
        at position 2cm
        with
          {
            \draw (-2pt,-2pt) -- (2pt,2pt);
            \draw (2pt,-2pt) -- (-2pt,2pt);
          }
      }
  ]
  \draw [help lines] grid (3,2);
  \draw [postaction={decorate}] (0,0) -- (3,1) arc (0:180:1.5 and 1); % postaction 表示画完路径之后再装饰，再摧毁路径。
\end{tikzpicture}
```

## 曲线绘画

### To 自由曲线

164 The To Path Operation
838 To Path Library

可以使用 `To`来绘制直线，也可以用来绘制曲线。

```latex
\path ... to[<options>] <nodes> <coordinate or cycle> ...;
```

例如`(a) to [out=135,in=45] (b)`

各种选项

```latex
/tikz/out=<angle>
/tikz/in=<angle>
...
```

使用 `loop`选项来绘制圈图曲线，例如

```latex
\begin{tikzpicture}
  \begin{feynman}
  \draw  (0,0) edge [anti charged scalar,loop, looseness=30] (h3);
  \end{feynman}
\end{tikzpicture}
```

`/tikz/looseness=<number>` 设置控制点与初始点和终点的距离，
还可以用 `/tikz/min distance=<distance>`, `/tikz/out min distance=<distance>` 控制最小距离，避免计算无解。

### arc 弧线

159 The Arc Operation

`\path ... arc[<options>] ...;`

从当前点开始画弧线，可以用`x radius` and `y radius`指定半径，用`start angle`, `end angle`, and `delta angle`指定角度.

也有一个较简捷的句法来指定圆弧:
`arc(<start angle>:<end angle>:<radius>)`
或者
`arc(<start angle>:<end angle>:<x radius> and <y radius>)`

## tikz-feynman

添加动量 key, 连线的 label

```tikz
(b2) --[half right, momentum'={\scriptsize \(k\)} ](b4),
(d) -- [boson, bend left, edge label=\(W^{+}\)] (c2)
```
