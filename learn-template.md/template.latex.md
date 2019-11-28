## 简单的规则

1. 空格：Latex 中空格不起作用。
1. 换行：用控制命令“\\\”,或“ \newline”.
1. 分段：用控制命令“\par” 或空出一行。
1. 特殊控制字符: #，$, %, &, - ,{, }, ^, ~

##  换页

用控制命令“\newpage”或“\clearpage”

>\newpage：  The \newpage command ends the current page.
>\clearpage：The \clearpage command ends the current page and causes all figures and tables that have so far appeared in the input to be printed.



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

## newdef 定义

```latex
\begin{newdef}[aa]
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{newdef}
```

## newprop 命题

```latex
\begin{newprop}[aa]
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{newprop}
```

## example 例子

```latex
\begin{example}[aa]
%%some comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
%%%%%+++++++++++++++++++++++---------------------

%%%%%+++++++++++++++++++++++
\end{aligned}\end{equation}
\end{example}
```

## newthem 定理

```latex
\begin{newthem}[aa]
%%comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}
 
\end{aligned}\end{equation}
\end{newthem}
```

## newlemma 引理

```latex
\begin{newlemma}[aa]
%%some comment
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{newlemma}
```

## newcorol  推论

```latex
\begin{newcorol}[aa]
%%some comment
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{newcorol}
```


## note 附注

```latex
\begin{note}
%%some comment
\begin{enumerate}
%%%%%+++++++++++++++++++++++---------------------
\item aaa
%%%%%+++++++++++++++++++++++---------------------
\item bbb
\end{enumerate}
\end{note}
```

## newproof 证明

```latex
\begin{newproof}
%%comment
\begin{equation}\begin{aligned}
%%\label{eq.6.1.2}

\end{aligned}\end{equation}
\end{newproof}
```


## 矩阵排列

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


## 颜色声明

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