# general

## 简单的规则

1. 空格：Latex 中空格不起作用。
1. 换行：用控制命令“\\\”,或“ \newline”.
1. 分段：用控制命令“\par” 或空出一行。
1. 特殊控制字符: #，$, %, &, - ,{, }, ^, ~

##  换页

用控制命令“\newpage”或“\clearpage”

>\newpage：  The \newpage command ends the current page.
>\clearpage：The \clearpage command ends the current page and causes all figures and tables that have so far appeared in the input to be printed.



# 定理类环境 of elegant-note 

## definition 定义

```latex
\begin{definition}{name}{}%%\ref{def:label}
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{definition}
```

## theorem 定理

```latex
\begin{theorem}{name}{}%%\ref{thm:label}
%%comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
 
\end{aligned}\end{equation}
\end{theorem}
```

## lemma 引理

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

## corollary  推论

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

## proposition 命题

```latex
\begin{proposition}{name}{}%%\ref{pro:label}
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{proposition}
```

# 其他环境 of elegant-note 

>这几个都是同一类环境，区别在于
>1. 示例环境（example）、练习（exercise）与例题（problem）章节自动编号；
>2. 注意（note），练习（exercise）环境有提醒引导符；
>3. 结论（conclusion）等环境都是普通段落环境，引导词加粗。

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
\begin{conclusion}
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{conclusion}
```

# 数学 math

## 无序号公式

```latex
\begin{equation*}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------

%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation*}
```

## 有序号公式

```latex
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------

%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
```

## cases 分段函数

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

## 矩阵模板

```latex
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------
\begin{pmatrix}

\end{pmatrix}
%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
```

## 分隔符

```latex
%%%%%+++++++++++++++++++++++---------------------
```

## 表格

```latex
\begin{table}[htbp]
\centering
\begin{tabular}{|l|l|l|}

\end{tabular}
\caption{input anything you need} 
\end{table}
```


## 常用颜色声明

```latex
{\color{seco}text}
```


## 颜色包的使用

```latex
\usepackage{color,xcolor}
% predefined color---black, blue, brown, cyan, darkgray, gray, green, lightgray, lime, magenta, olive, orange, pink, purple, red, teal, violet, white, yellow.
\definecolor{light-gray}{gray}{0.95}    % 1.灰度
\definecolor{orange}{rgb}{1,0.5,0}      % 2.rgb
\definecolor{orange}{RGB}{255,127,0}    % 3.RGB
\definecolor{orange}{HTML}{FF7F00}      % 4.HTML
\definecolor{orange}{cmyk}{0,0.5,1,0}   % 5.cmyk
```

## 枚举环境

```latex
$(\lambda)=(\lambda_1,\lambda_2,\cdots \lambda_m)$
```


## 杨图 diagrams 模板

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
\ytableausetup{mathmode, boxsize=2em}
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

