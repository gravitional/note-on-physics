# template.latex.md

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

这几个都是同一类环境，区别在于

1. 示例环境（`example`）、练习（`exercise`）与例题（`problem`）章节自动编号
2. 注意（note），练习（exercise）环境有提醒引导符；
3. 结论（conclusion）等环境都是普通段落环境，引导词加粗。

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
{\color{seco}text}
```

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

### 枚举环境

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
如果想在行内公式中也使用行间公式款的上下标的话, 可以在对应的命令前面加上`\displaystyle`, 即显示模式, 就可以变成我们想要的样子了, 但是这种方法会产生一些不良行距。
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

1. 空格：Latex 中空格不起作用。
1. 换行：用控制命令“\\\”,或“ \newline”.
1. 分段：用控制命令“\par” 或空出一行。
1. 特殊控制字符: #，$, %, &, - ,{, }, ^, ~

## 换页

用控制命令“`\newpage`”或“`\clearpage`”

+ `\newpage`：  The `\newpage` command ends the current page.
+ `\clearpage`：The `\clearpage` command ends the current page and causes all figures and tables that have so far appeared in the input to be printed.

## \mathrm v.s. \text

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

## 数学符号

| `latex` 写法 | 描述 |
| ----- | ----- |
| `\oint` |  环路积分 |
| `\ldots` | lying dots |
| `\cdots` | centerd dots |
