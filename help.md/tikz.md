# texdoc tikz

用来替换`pdf` 粘贴过程额外`h..i`的正则表达式

```bash
\bh([\. ]+?)i\b # vscode 里面的正则，元字符 . 需要转义成 \.
<$1>
```

## Tutorial Karl

### 路径命令

p32, `tikz`中，`path`就是一连串的坐标，在路径的开头可以选择:

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

自定义格式, \tikzset,p35

```latex
help lines/.style={color=blue!50,very thin} %在环境内部任意地方定义格式, 后面可以调用
\tikzset{help lines/.style=very thin} %在文档开头，定义全局格式
\tikzset{Karl's grid/.style={help lines,color=blue!50}} %格式可以嵌套
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4); % 使用 grid 绘制 参考格子
```

### 颜色线型等

绘制选项, p36

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

### 放大部分区域

剪切出图形的某一部分,clip

```latex
\draw[clip] (0.5,0.5) circle (.6cm);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
...
```

### 画抛物线

抛物线,parabola, p38

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

### 渐变色

渐变色,shade,p39 

```latex
\shadedraw[left color=gray,right color=green, draw=green!50!black](0,0) -- (3mm,0mm)
```

### 相对坐标

定义命令，相对坐标指定, p40

```latex
(30:1cm |- 0,0) % 垂直线与水平线的交点，|- 左边的坐标对应铅垂线，右边的对应水平线。
\def\rectanglepath{-- ++(1cm,0cm) -- ++(0cm,1cm) -- ++(-1cm,0cm) -- cycle} %% 连续的相对指定，后一个坐标相对于前一个，使用 \def 在任意地方定义一个命令替换。
\def\rectanglepath{-- +(1cm,0cm) -- +(1cm,1cm) -- +(0cm,1cm) -- cycle} %% 基于相同root的相对坐标，后面几个坐标相对于同一个最初坐标
```

### 路径交点

路径的交点, 使用`name path`在后面引用.

可以使用`(1,{tan(30)})`这种坐标形式, `tikz`的数学引擎可以处理`tan(30)`，但是外面需要包围一层`{}`，否则会与坐标的语法冲突。一般情况中，遇到含有`()`的坐标，也需要用`{}`包裹起来。

```latex
% 在导言区 \tikz 后面添加 \usetikzlibrary{intersections}
\path [name path=upward line] (1,0) -- (1,1); % 给第一条路径命名, \path 只计算路径，不进行实际描绘.
\path [name path=sloped line] (0,0) -- (30:1.5cm);  % 第二条路径，画得稍微长一点，保证有交点
\draw [name intersections={of=upward line and sloped line, by=x}] [very thick,orange] (1,0) -- (x);
```

***
添加箭头, 通过`->`选项，可以指定在路径末端加上箭头。

```latex
\usetikzlibrary {arrows.meta}
\begin{tikzpicture}[>=Stealth]
\draw [->] (0,0) arc [start angle=180, end angle=30, radius=10pt];
\draw [<<-,very thick] (1,0) -- (1.5cm,10pt) -- (2cm,0pt) -- (2.5cm,10pt);
\end{tikzpicture}
```

### 作用域

p42, scope,
可以给选项设置作用范围, 如果想让整个环境都生效，可以把选项传递给`\tikz`命令或者`{tikzpicture}`环境。
如果希望定义一个局部环境，可以使用`{scope}`环境. 例如:

```latex
\begin{tikzpicture}[ultra thick]
\draw (0,0) -- (0,1);
\begin{scope}[thin] % 在这里给出选项
\draw (1,0) -- (1,1);
\draw (2,0) -- (2,1);
\end{scope}
\draw (3,0) -- (3,1);
\end{tikzpicture}
```

`\clip`的生效范围也受`\scope`的控制，只在`scope`范围内有效。
类似于`\draw`的选项，其实不是`\draw`的选项，而是提供给`path`的选项，可以在路径命令序列的任何地方提供。大部分`graphic`选项是对整个路径生效的，所以选项的位置不重要。
例如，下面三种用法是等价的。如果同时给出`thick` and `thin`，后一个覆盖前一个的效果。

```latex
\begin{tikzpicture}
\draw[thin] (0,0) --(1,0);
\draw (0,1) [thin] --(1,1);
\draw (0,2) --(1,2) [thin];
\end{tikzpicture}
```

大部分图形选项应用于整个路径，而所有的变形选项,`transformation` 只作用于跟在其后的路径片段。

### 路径变形

page 43. 路径变形选项。
图像的最后位置是由`TikZ`, `TeX`, `PDF`共同决定的。`tikz` 提供了一些选项可以在自己的坐标系统内变换图像的位置. 并且运行在路径中途修改变换方式。例如:

```latex
\begin{tikzpicture}[even odd rule,rounded corners=2pt,x=10pt,y=10pt]
\filldraw[fill=yellow!80!black] (0,0)  rectangle (1,1) [xshift=5pt,yshift=5pt]  (0,0)  rectangle (1,1) [rotate=30]   (-1,-1) rectangle (2,2);
\end{tikzpicture}
```

这类选项有：

`x=<value>`, `y=<value>`, `z=<value>`. 例如：

```latex
\draw[x=2cm,color=red] (0,0.1) -- +(1,0);
\draw[x={(2cm,0.5cm)},color=red] (0,0) -- (1,0); %含有逗号的坐标需要放在括号里
```

+ `xshift=<dimension>`,`yshift=<dimension>`:用来平移
+ `shift={<coordinate>}`: 平移到指定的点，如`shift={(1,0)}, shift={+(1,0)},`
必须加上`{}`，以避免`TeX`把坐标解析成两个选项。例如:

```latex
\draw[shift={(1,1)},blue] (0,0) -- (1,1) -- (1,0);
\draw[shift={(30:1cm)},red] (0,0) -- (1,1) -- (1,0);
```

+ `rotate=<degree>`: 旋转特定角度。以及`rotate around`:绕指定的点旋转。
+ `scale=<factor>`: 放大或者缩小指定的倍数。以及`xscale`, `yscale`。`xscale=-1`表示翻转。
+ `xslant=<factor>`, `yslant=<factor>`：倾斜
+ `cm`: 指定任意的变换矩阵。

详细可以参考 page 373: 25 Transformations

### 循环

`latex`本身有循环的命令，`pstricks`具有`\multido`命令。`tikz`也引入了自己的循环命令`\foreach`，它定义在`\pgffor`中，`\tikz`会自动`\include`这个命令。
语法是`\foreach \x in {1,2,3} {$x =\x $,}`. 循环区域用列表指定， 要循环的指令也放在一个`{}`中。如果不用`{}`包裹，就把下一个`;`之前的命令当作循环指令。例如下面的语句绘制一个坐标系：

```latex
\begin{tikzpicture}[scale=3]
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw[->] (-1.5,0) -- (1.5,0);
\draw[->] (0,-1.5) -- (0,1.5);
\foreach \x in {-1cm,-0.5cm,1cm}
\draw (\x,-1pt) -- (\x,1pt);
\foreach \y in {-1cm,-0.5cm,0.5cm,1cm}
\draw (-1pt,\y) -- (1pt,\y);
\end{tikzpicture}
```

也可以结合平移使用:

```latex
\foreach \x in {-1,-0.5,1} \draw[xshift=\x cm] (0pt,-1pt) -- (0pt,1pt);
```

`\foreach`也可以使用`c`式的范围指定：`{a,...,b}`，必须使用无量纲的实数。 `{1,3,...,11}`则可以指定步长。两种语法可以混合，例如:

```latex
\tikz \foreach \x in {1,3,...,11} \draw (\x,0) circle (0.4cm);
```

循环可以嵌套：

```latex
\begin{tikzpicture}
\foreach \x in {1,2,...,5,7,8,...,12}
\foreach \y in {1,...,5}
{
  \draw (\x,\y) +(-.5,-.5) rectangle ++(.5,.5);
  \draw (\x,\y) node{\x,\y};
}
\end{tikzpicture}
```

为了方便，还有一种`key/value`型的循环语法：`foreach \key/\value in {1/a,2/b,3/c}`，`key/value`用`/`分隔开。在每一次循环中，`\key`和`\value`的值将一一对应。
如果循环域中，某一项只给出了`key`，会默认`value`等于`key`.

### 添加文字

添加文字可以使用`\node`命令，也可以用来添加任意形状。通常的用法是`\node[选项]{文字}`. `\node`会放在当前位置，也就是`\node`命令前面的那个坐标上。
当所有路径`draw/fill/shade/clipped/whatever`完成之后，才绘制`\node`，所以`\node`的图层在最上面。

+ 可以使用类似于`anchor=north`指定`\node`的哪一个锚点放在前面给定的坐标上。也可以使用`below=1pt`直接指定`\node`的相对偏移。
+ 如果担心图形上的其他元素干扰了`node`的辨识度，可以给`node`加上`[fill=white]`选项，绘制一个白色的背景。
+ 如果把`\node`放在`--`后面，默认会将`\node`的位置放在这条线段的中点。可以使用`pos=`选项控制具体的位置，也可以使用`near start`, `near end`等等指定大概位置。
+ 还可以使用`[above, sloped]`选项，使曲线上方的`\node`贴合曲线斜率。例如：

```latex
\begin{tikzpicture}
\draw (0,0) .. controls (6,1) and (9,1) .. 
node[near start,sloped,above] {near start} node {midway} 
node[very near end,sloped,below] {very near end} (12,0);
\end{tikzpicture}
```

如果`\node`中的文本量比较大，需要控制换行，可以使用类似`text width=6cm`的选项控制`\node`宽度。完整的例子为:

```latex
\begin{tikzpicture}
  [scale=3,line cap=round,
    % 定义一些对象的格式
    axes/.style=,
    important line/.style={very thick},
    information text/.style={rounded corners,fill=red!10,inner sep=1ex}]
  % 定义一些对象的颜色
  \colorlet{anglecolor}{green!50!black}
  \colorlet{sincolor}{red}
  \colorlet{tancolor}{orange!80!black}
  \colorlet{coscolor}{blue}
  % 开始画图
  \draw[help lines,step=0.5cm] (-1.4,-1.4) grid (1.4,1.4);
  \draw (0,0) circle [radius=1cm];
  \begin{scope}[axes]
    \draw[->] (-1.5,0) -- (1.5,0) node[right] {$x$} coordinate(x axis);
    \draw[->] (0,-1.5) -- (0,1.5) node[above] {$y$} coordinate(y axis);
    \foreach \x/\xtext in {-1, -.5/-\frac{1}{2}, 1}
    \draw[xshift=\x cm] (0pt,1pt) -- (0pt,-1pt) node[below,fill=white] {$\xtext$};
    \foreach \y/\ytext in {-1, -.5/-\frac{1}{2}, .5/\frac{1}{2}, 1}
    \draw[yshift=\y cm] (1pt,0pt) -- (-1pt,0pt) node[left,fill=white] {$\ytext$};
  \end{scope}
  \filldraw[fill=green!20,draw=anglecolor] (0,0) -- (3mm,0pt)
  arc [start angle=0, end angle=30, radius=3mm];
  \draw (15:2mm) node[anglecolor] {$\alpha$};
  \draw[important line,sincolor]
  (30:1cm) -- node[left=1pt,fill=white] {$\sin \alpha$} (30:1cm |- x axis);
  \draw[important line,coscolor]
  (30:1cm |- x axis) -- node[below=2pt,fill=white] {$\cos \alpha$} (0,0);
  \path [name path=upward line] (1,0) -- (1,1);
  \path [name path=sloped line] (0,0) -- (30:1.5cm);
  \draw [name intersections={of=upward line and sloped line, by=t}]
  [very thick,orange] (1,0) -- node [right=1pt,fill=white]
  {$\displaystyle \tan \alpha \color{black}=
      \frac{{\color{red}\sin \alpha}}{\color{blue}\cos \alpha}$} (t);
  \draw (0,0) -- (t);
  \draw[xshift=1.85cm]
  node[right,text width=6cm,information text]
  {
    The {\color{anglecolor} angle $\alpha$} is $30^\circ$ in the
    example ($\pi/6$ in radians). The {\color{sincolor}sine of
        $\alpha$}, which is the height of the red line, is
    \[
      {\color{sincolor} \sin \alpha} = 1/2.
    \]
    By the Theorem of Pythagoras ...
  };
\end{tikzpicture}
```

### pic: 图形复用

`pic`是`picture`的简称。通过预先定义的图片名字，可以在指定的地方复用图形。例如:

```latex
\usetikzlibrary {angles,quotes}
\begin{tikzpicture}[scale=3]
\coordinate (A) at (1,0);
\coordinate (B) at (0,0);
\coordinate (C) at (30:1cm);
\draw (A) -- (B) -- (C)
pic [draw=green!50!black, fill=green!20, angle radius=9mm,"$\alpha$"] {angle = A--B--C};
\end{tikzpicture}
```

这里调用了`angles` and `quotes`库。前者预定义了`angle`图形，后者可以简化参数输入为`"标记"`，而不需要输入`label text="标记"`。
`{angle = A--B--C}`表示`angle`是`BA`和`BC`的夹角。 `\coordinate`用于声明一个坐标点，可以在后文引用。

## tikz 设计原则

page 124, `TikZ` 遵循以下基本设计原则：

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

131 Using Scopes to Structure a Picture. 如果`scope`不生效的话，可以尝试在导言区添加

```latex
\usetikzlibrary {scopes}
```

命令 `\path` 用于创建一个路径 (`path`),此命令可以带有图形选项 (graphic options),这些选项只对本路径有效。使用简写形式的 scope 可以在路径内部插入一个 `scope`:

```latex
\tikz \draw (0,0) -- (1,1)
{[rounded corners, red] -- (2,0) -- (3,1)}
-- (3,0) -- (2,1);
```

上面例子中,选项 `rounded corners` 的作用范围受到花括号的限制,并且颜色选项 red 没有起到作用,这是因为 `\draw` 的默认颜色是 `draw=black`,颜色 `black` 把 `red` 覆盖了。
还要注意开启 scope 的符号组合`{[...]`要放在坐标点之后、`--`之前。

除了`\tikzpicture`环境，可以使用简洁的`\tikz{path1;path2}`命令，例如：

```latex
\tikz[baseline]{
  \draw (0,0)--(2,0);\draw (0.5,0) to [out=90,in=90,looseness=1.5] (1.5,0);
\draw (0.5,0) to [out=-90,in=-90,looseness=1.5] (1.5,0);
}
```

## 坐标计算

page 148

### 指定坐标点

page 136, Specifying Coordinates
page 148,TikZ Library calc, 可以计算坐标值。

坐标总是放在圆括号内，一般的语法是 `([<options>]<coordinate specification>)`。有两种指定坐标的方法：

明确指定坐标系统和参数，使用`xxx cs:`这种语法

```latex
\draw (canvas cs:x=0cm,y=2mm)
-- (canvas polar cs:radius=2cm,angle=30);
```

或者可以隐式地指定，`tikz` 会根据格式自动判断坐标系统。例如 `(0,0)` 对应笛卡尔坐标,`(30:2)` 对应极坐标 (其中 `30` 代表角度)。

+ 基本使用:`(1cm,2pt)`
+ 极坐标:`(30:1cm)`
+ `PGF-xy` 坐标系统, 单位按照`cm` :  `(2,1)`
+ `PDF-xyz` 坐标系统:`(1,1,1)`
+ 也可以使用利用之前定义的形状作为锚点,如:`(first node.south)`
+ 连续相对坐标:`++(1cm,0pt)`,`(1,0), ++(1,0), ++(0,1)`给出`(1,0), (2,0),(2,1)`
+ 同源相对坐标:`+(1,0) +(1,0) +(0,1)` 给出 `(1,0), (2,0), (1,1)`.

对图像进行全局伸缩，可以指定`xyz`单位矢量的长度，也可以通过画布变换

page 137: Coordinate system xyz
page 43: Transformations

### 指定路径

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

所有这些命令只能在`{tikzpicture}`环境中使用。 `TikZ` 允许您使用不同的颜色进行填充和描边。

### node 指定

p224 基本语法：

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

page 785,72 Shape Library：可以指定`node`的形状，有预定义的各种形状。
page 563, Part V Libraries： 从这里开始是各种库，有预定义的各种命令。

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

p224, Nodes and Their Shapes

比如

```tikz
\begin{tikzpicture}
\draw (0,0) node[minimum size=2cm,draw] {square};
\draw (0,-2) node[minimum size=2cm,draw,circle] {circle};
\end{tikzpicture}
```

p785: 72 Shape Library, 形状库

p229: 17.2.3 Common Options: Separations, Margins, Padding and Border Rotation: 给出了node 一些几何参数的选项

p730: 63 Pattern Library : node 可以使用 pattern 填充，某种图形模式。

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
`pgf`先确定沿路径`2cm`的位置。 然后将坐标系平移到此处并旋转它，使`x`轴正向与路径相切。 然后创建一个保护用的`scope`，在内部执行上述代码--最后路径上出现一个叉叉。

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
page 841 75.4 Loops

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

在给定出射和入射角度之后，`/tikz/looseness=<number>`选项中的`<number>`调控`control points`与初始点以及与终点的距离。
还可以用 `/tikz/min distance=<distance>`, `/tikz/out min distance=<distance>` 控制最小距离，避免计算无解。

使用 `loop`选项来绘制圈图曲线，例如

```latex
\begin{tikzpicture}
  \begin{feynman}
  \draw  (0,0) edge [anti charged scalar,loop, looseness=30] (h3);
  \end{feynman}
\end{tikzpicture}
```

`loop`选项只接受一个参数，即初始点，终点位置和初始点相同，然后把`looseness`设置为`8`，`min distance`设置为`5mm`.
如果想精确控制圈图的形状，可以手动添加控制点，例如：

```latex
\draw (a3) to [controls=+(45:1.5) and +(135:1.5)] (a3); % 使用(角度:距离)的方式指定控制点的坐标.
```

### arc 弧线

159 The Arc Operation

`\path ... arc[<options>] ...;`

从当前点开始画弧线，可以用`x radius` and `y radius`指定半径，用`start angle`, `end angle`, and `delta angle`指定角度.

也有一个较简捷的句法来指定圆弧:
`arc(<start angle>:<end angle>:<radius>)`
或者
`arc(<start angle>:<end angle>:<x radius> and <y radius>)`

## Pics: 复用图形组件

p263, `pic`是`picture`的简称。通过预先定义的图片名字，可以在指定的地方复用图形。例如先定义一个海鸥的形状：

```latex
\tikzset{
seagull/.pic={
% Code for a "seagull". Do you see it?...
\draw (-3mm,0) to [bend left] (0,0) to [bend left] (3mm,0);
}
}
```

使用`\tikzset`定义的是全局的，整个文档都可以调用。然后调用它：

```latex
\tikz \fill [fill=blue!20]
(1,1)
-- (2,2) pic {seagull}
-- (3,2) pic {seagull}
-- (3,1) pic [rotate=30] {seagull}
-- (2,1) pic [red] {seagull};
```

### 定义新的Pic类型

如`pic`命令说明中所述，要定义新的`pic`类型，您需要

1. 定义一个路径前缀为`/tikz/pics`的`key`，
2. 将`/tikz/pics/code`设置为`pic`的`code`。
 
这可以使用`.style` handler 实现：

```latex
\tikzset{
  pics/seagull/.style ={
      % 当调用 seagull 的时候，下面的代码会设置 seagull 的 code key:
      code = { %
          \draw (...) ... ;
        }
    }
}
```

一些简单的情况下，可以直接使用`.pic` handler,

```latex
\tikzset{
    seagull/.pic = {
    \draw (...) ... ;
  }
}
```

此`handler`只能对带有`/tikz/`前缀的`key`一起使用，因此通常应将其用作`TikZ`命令或`\tikzset`命令的选项。 
它使用`<key>`的路径，并把其中的`/tikz/`替换为`/tikz/pics/`。最终得到一个`style`，能够执行`code = some code`。
大多数情况下，`.pic`handler足以设置`keys`。 但是，在某些情况下确实需要使用第一个版本:

+ 当您的图片类型需要设置`foreground`或`background`代码时。
+ 如果给`key`提供了复杂的参数

例如：

```latex
\tikzset{
    pics/my circle/.style = {
    background code = { \fill circle [radius=#1]; }
  }
}
\tikz [fill=blue!30]
```

这里给`my circle`使用了参数。

## 颜色

### 透明度

page 353: 23 Transparency

常用透明度选项：

```latex
/tikz/draw opacity=<value>
/tikz/fill opacity=<value>
```

`<value>`除了数字取值$[0,1]$之外，还可以下列预设：

```latex
/tikz/transparent
/tikz/ultra nearly transparent
/tikz/very nearly transparent
/tikz/nearly transparent
/tikz/semitransparent
/tikz/nearly opaque
/tikz/very nearly opaque
/tikz/ultra nearly opaque
/tikz/opaque
```

## key 管理

### key 简述

p975. `key` 就是`tikz`中的各种关键字，它们是通过包`pgfkeys`管理的。`\usepackage{pgfkeys}`。

`key`的例子：`/tikz/coordinate system/x`，或者只用写`/x`. 这种写法类似于`Unix`上的文件路径。可以使用绝对路径，也可以使用相对路径。`tikz`的`key`名称经常包含空格。
调用`key`使用`\pgfkeys`命令。`pgfkeys`接受`key=value`形式的参数。例如:

```latex
\pgfkeys{/my key=hallo, /your keys=something\strange, others=something else}
```

可以在`key`中存储一些`code`，通常用`handler`来管理`key`的内容。例如:

```latex
\pgfkeys{/my key/.code=The value is '#1'.}
\pgfkeys{/my key=hi!}
```

有许多`handler`可以用来定义`key`。例如，我们可以定义一个具有多个参数的`key`:

```latex
\pgfkeys{/my key/.code 2 args=The values are '#1' and '#2'.}
\pgfkeys{/my key={a1}{a2}}
```

常用`handler`有:

+ `.default`:提供默认值。
+ `/.value required`:必须指定参数.
+ `/.value forbidden`:不能指定参数。

`tikz`的所有`key`都以`/tikz`开头。然而不必每次都显式加上这个前缀，可以使用`/.cd`来声明默认目录。

```latex
\pgfkeys{/tikz/.cd,line width=1cm, linecap=round}
```

当`handle`一个`key`时，除了直接执行某些代码，也可以递归调用另一些`keys`, 这种`key`被称为`styles`。`styles`本质上就是`key`的列表。例如:

```latex
\pgfkeys{/a/.code=(a:#1)}
\pgfkeys{/b/.code=(b:#1)}
\pgfkeys{/my style/.style={/a=foo,/b=bar,/a=#1}}
\pgfkeys{/my style=wow}
```

`.styles`也可以带有参数`#1`，如同普通的`.code`.

### The Key Tree

p975, `key`的组织方式类似`Unix`. `/a/b.../x`中，前面的`/a/b.../`是`路径`，后面的`x`是`名称`.
`pgfkeys`包中有一些内部命令，如`\pgfkeyssetvalue`，`\pgfkeyslet`等等。但是通常用户不需要直接调用这些命令.

简要提一下`\def`, `\let`,`\edef`三个命令：[What is the difference between \let and \def](https://tex.stackexchange.com/questions/258/what-is-the-difference-between-let-and-def)
`\let`相当于直接赋值，右边的式子计算之后赋给左边. `\def`命令相当于mma中的`SetDelay`即`:=`，会在被调用时重新计算。
`\edef`是`expand def`的缩写，也就是赋值之前右边的式子会被展开。

### Key Handlers

p984, 常用的 `key handler`:

+ `<key>/.cd`: 设置默认路径为`key`.
+ `<key>/.is family`：当使用`key`时，当前路径被设置为`key`,效果同`<key>/.cd`.
+ `<key>/.default=<值>` :设置`key`的默认值。例如`\pgfkeys{/width/.default=1cm}`
+ `<key>/.value required`: 表明必须赋值。
+ `<key>/.value forbidden`: 表明禁止赋值。
+ `<key>/.code=<代码>`: 添加代码，可以有一个参数`#1`
+ `<key>/.code 2 args=<代码>`:表示有两个参数`{#1}{#2}`，如果第二个未给出，将会是空字符。如果传入`first`，第一个参数将是`f`，第二个将是`irst`，所以需要用`{}`包裹起来。
+ `<key>/.code n args={<m>}{<代码>}`:传入`m`个参数`{#1}{#2}{#3}...`，`m`为`0`~`9`，不能多也不能少，空格也可以作为参数。
+ `<key>/.code args={<参数模式>}{<代码>}`:可以指定任意的参数模式，比如`(#1/#2)`,调用对应的写成`(first/second)`, 空格将被去掉。
+ `<key>/.add code={<前缀代码>}{<后缀代码>}`：将代码添加到已经存在的`key`.
+ `<key>/.prefix code=<前缀代码>`: 类似`.add code`，但只添加前缀。
+ `<key>/.append code=<后缀代码>`: 类似`.add code`，但只添加后缀。

其中 `.code 2 args`和`.code args`的区别见下面的例子：

```latex
\pgfkeys{/page size/.code 2 args={\paperheight=#2\paperwidth=#1}}
\pgfkeys{/page size={30cm}{20cm}}
% 同样的定义，使用 .code args
\pgfkeys{/page size/.code args={#1 and #2}{\paperheight=#2\paperwidth=#1}}
\pgfkeys{/page size=30cm and 20cm}
```

### Defining Styles

`.style`是`key`的列表，它的`handler`和`key`基本相同，只需要作替换`.code`->`.style`
