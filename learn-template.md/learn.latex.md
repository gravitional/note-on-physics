## 简单的规则

1. 空格：Latex 中空格不起作用。
1. 换行：用控制命令“\\”,或“ \newline”.
1. 分段：用控制命令“\par” 或空出一行。
1. 换页：用控制命令“\newpage”或“\clearpage”
1. 特殊控制字符: #，$, %, &, - ,{, }, ^, ~

***

\\begin{subequations} 

创建 子方程 环境

***

\+ 号后面 加 {} , 变成二元运算符，强制排版，用在多行公式换行中

= 号也是同理

***

## spacing in math mode

/,  /: /; /quad /qquad

***

## Placeholders

Use Placeholders: if the completed commands have options which need to 
be filled out, "place holder" are put at this positions and they can be 
jumped to by using Ctrl+Right/Ctrl+

***

## shell-escape

What does --shell-escape do?

[tex.stackexchange.com](https://tex.stackexchange.com/questions/88740/what-does-shell-escape-do)

>Sometimes, it is useful to be able to run external commands from inside the tex file : it allows for example to externalize some typesetting, or to use external tools like bibtex. This is available via the \write18 tex primitive.

>The problem is that it allows for almost everything. A tex file is meant to be portable, and one shouldn't have to fear any security issue when compiling a third-party file. So by default, this primitive is disabled.

>If an user needs to use it, he needs to explicitely tell the compiler that he trusts the author of the file with shell interaction, and that's exactly the point of the optional --shell-escape argument.


## align环境如何对齐

多&情况下flalign和align环境是如何对齐的：
[对齐 CSDN](https://blog.csdn.net/yanxiangtianji/article/details/54767265)

>根据&（假设n个）一行被分为n+1列。从左向右将列两个分为一组，第一组紧靠页左侧，最后一组紧靠页左侧，其余组均匀散布在整个行中。当公式比较短时，中间可能会有几段空白。
需要注意的是：

>每一组内部也是有对齐结构的！它们在所在位置上向中间对齐的，即第一列向右对齐，第二列向左对齐。
所谓紧靠页左/右是在进行了组内对齐调整之后，最长的一块紧靠上去。也就是说对于长度不一两行，较短的那一行是靠不上去的。
如果总共有奇数个列，及最后一组只有一个列，则它右对齐到页右侧，即所有行的最后一列的右侧都靠在页右侧。