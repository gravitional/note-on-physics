# mathematica.md

## 快捷键

`Ctrl+Shift+B`，选中配对的括号

## 将定义与不同的符号相关联

在 Wolfram 语言中，`f[args]=rhs` 或 `f[args]:=rhs` 会将对象 `f` 和你的定义相关联. 也就是说，当输入 `?f` 时，就会显示该定义. 一般我们把符号 `f` 作为标头的表达式称为 `f` 的下值 (`downvalue`).

Wolfram 语言也支持上值 (upvalue)，上值可以把不直接作为标头的符号与定义相关联.

比如，在定义 `Exp[g[x_]]:=rhs` 中，一种可能是把定义与符号 `Exp` 相关联，认为它是 `Exp` 的下值. 但是从组织或效率的角度来看未必是最好的方式.

较好的方式是将 `Exp[g[x_]]:=rhs` 与 `g` 关联起来，即对应为 `g` 的上值.

```mathematica
f[args]:=rhs    定义 f 的下值
f[g[args],\[Ellipsis]]^:=rhs    定义 g 的上值
```

## plot 采样奇技淫巧

默认特性

+ 在函数值变化较快的位置，使用更多的采样点：
+ 自动选择绘图范围：
+ 排除非实数的函数范围：
+ 函数中存在断点时断开曲线：

其他特性还有

+ 使用 `Exclusions->None` 绘制连续的曲线：
+ 用 `PlotPoints` 和 `MaxRecursion` 控制自适应采样：
+ 用 `PlotRange` 来突出显示感兴趣的区域：
+ 可以用区域来指定自变量的取值范围： `D = ImplicitRegion[x <= -1 \[Or] x >= 1, {x}];`
+ 用 `MeshRegion` 来指定自变量的取值范围：
`D =MeshRegion[{{-2}, {-1}, {-1/2}, {1/2}, {1}, {2}}, Line[{{1, 2}, {3, 4}, {5, 6}}]];`
+ 用 `ScalingFunctions` 来缩放坐标轴：

example

```mathematica
Plot[Tan[x^3 - x + 1] + 1/(x + 3 Exp[x]), {x, -2, 2},
Exclusions -> {Cos[x^3 - x + 1] == 0, x + 3 Exp[x] == 0}]
```

## $Assumptions 假设

`$Assumptions` 的初始设置为 `True`.

+ 设置全局假定：`$Assumptions = a > 0`
+ 局部添加假定：`Assuming[b < 0, Refine[Sqrt[a^2 b^2]]]`
+ 局部改变假定：`Block[{$Assumptions = a < 0 && b < 0}, Refine[Sqrt[a^2 b^2]]]`
+ 取消全局假定：`$Assumptions = True`

## options

`Options[f]`

`OptionsPattern`(选项模式)
`OptionValue`(选项值)

定义具有可选变量的函数
`tutorial/SettingUpFunctionsWithOptionalArguments`

`f[x_,k_:kdef]:=value`
第二个位置为可选变量，默认值为 `kdef` 的函数

## Assumptions(假设)

典型的缺省设置为`Assumptions:>$Assumptions`.

假设可以是方程、不等式或定义域指定，或者是这些内容的列表或逻辑组合.

## 积分

tutorial/DefiniteIntegrals

即使能求出函数的不定积分，如果只管将积分上下限处的值相减，还是往往会导致错误. 原因在于积分区域中可能有奇点.

这里是 $1/x^2$ 的不定积分：

```mathematica
In[10]:= Integrate[1/x^2, x]
Out[10]= -(1/x)
```

实际上，$x=0$ 是双重极点，此定积分是发散的：

这里是一个更妙的例子，其中包括分支线：

$$
In[13]:= Integrate[1/(1 + a Sin[x]), x]
Out[13]= (2 ArcTan[(a + Tan[x/2])/Sqrt[1 - a^2]])/Sqrt[1 - a^2]
$$

端点处的极限值相减得$0$：

$$
In[14]:= \lim[Out[13], x \to 2 \pi] - \lim[Out[13], x \to 0] \\
Out[14]= 0
$$

然而该定积分的正确结果依赖于$a$. 假定保证了函数的收敛：

$$
In[15]:= \int[1/(1 + a \sin[x]), \{x, 0, 2 \pi\}, Assumptions \to -1 < a < 1] \\
Out[15]= (2 \pi)/\sqrt{1 - a^2}
$$

$$
\text{Integrate}[\text{function}(x),\{x,-1,1\},\text{PrincipalValue}\to \text{True}]
$$

定积分的柯西主值

这是 $1/x$ 的不定积分：

$$
\int \frac{1}{x} \, dx
\log (x)
$$

$-1$和$+2$处的极限值相减产生一个包含$i\,\pi$的奇怪结果：

Riemann 意义下的定积分是发散的：
Out[38]= `Integrate::idiv: 1/x 的积分在 {-1,2} 上不收敛`.
$$
\int_{-1}^2 \frac{1}{x} \, dx
$$

而柯西主值意义下该积分是有限的：
$$
\text{Integrate}\left[\frac{1}{x},\{x,-1,2\},\text{PrincipalValue}\to \text{True}\right] \\
\log (2)
$$

即使定积分收敛，积分路径上奇点的存在也会导致结果随参数变化而不连续.
有时能使用包含如`Sign`函数的单个公式归纳结果.

此处 `If` 给出积分收敛的条件：
$$
\int_0^{\infty } \frac{\sin (a x)}{x} \, dx \\
\text{ConditionalExpression}\left[\frac{\pi  a}{2 \sqrt{a^2}},\Im(a)\leq 0\right]
$$

结果关于 $a$ 是不连续的. 不连续的原因是 $x=\infty$ 是 $sin(x)$ 的本性奇点

## 底层的输入输出规则

tutorial/LowLevelInputAndOutputRules

`MakeBoxes[expr,form]` 按指定格式构造代表 expr 的框符
`MakeExpression[boxes,form]` 构造与 boxes 对应的表达式

## Needs and Get

属性和关系

```mathematica
Once[Get[package]] 类似于 Needs[package]：
Once[Get["EquationTrekker`"]]
```

## 图形结构

tutorial/TheStructureOfGraphics

给定一个图形基元列表后, Wolfram 语言提供了两种方式去修改最终的图形. 首先, 可以在图形基元列表中插入一些图形指令, 例如 RGBColor, 以修改随后列表中的图形基元. 用这种方式, 用户可以指定如何修改一个给定的图形基元列表.  

通过插入图形指令, 可以指定图形基元的显示方式. 然而, 用户往往经常会希望通过全局修改来改变整个图形的显示. 使用图形选项可以达到这一目的.

通过增加图形选项 Frame 用户可以修改图形的整体外观.

`FullGraphics[g]` 将图形选项指定的对象转化为明确的图形基元列表

对 Axes 等图形选项, Wolfram 语言的前端会自动画出用户需要的坐标轴等对象. 这些对象由选项值表示, 而非被确定的图形基元列表表示. 然而, 用户会需要要找到代表这些对象的图形基元列表. 函数 FullGraphics 给出不使用任何选项的情况下, 生成图形的完整的图形基元列表.

```mathematica
Short[InputForm[FullGraphics[ListPlot[Table[EulerPhi[n], {n, 10}]]]],6]
```

## Grid 玄学用法

设置指定项的背景：

```mathematica
Grid[Table[x, {4}, {7}],
 Background -> {None, None, {{1, 1} -> Pink, {3, 4} -> Red}}]
```

设置网格区域的背景：

```mathematica
Grid[Table[x, {4}, {7}],
 Background -> {None, None, {{1, 1} -> Pink, {3, 4} -> Red}}]
```

## MapThread level 的区别

```mathematica
In[2]:= MapThread[f, {{{a, b}, {c, d}}, {{u, v}, {s, t}}}]
Out[2]= {f[{a, b}, {u, v}], f[{c, d}, {s, t}]}
```

```mathematica
>In[3]:= MapThread[f, {{{a, b}, {c, d}}, {{u, v}, {s, t}}}, 2]
Out[3]= {{f[a, u], f[b, v]}, {f[c, s], f[d, t]}}
```

## 目录和目录操作

guide/DirectoriesAndDirectoryOperations

## Wolfram 语言脚本

tutorial/WolframLanguageScripts

## 建立 Wolfram 语言程序包

tutorial/SettingUpWolframLanguagePackages

## 离散数学

guide/DiscreteMathematics

## 上设置延迟

ref/UpSetDelayed

把 rhs 赋为 lhs 的延迟值，并将这种赋值和在 lhs 中层 1 出现的符号相关联.

## 上值 下值

tutorial/AssociatingDefinitionsWithDifferentSymbols

## 表达式的计算

tutorial/EvaluationOfExpressionsOverview

## 计算 非标准变量计算

tutorial/Evaluation

## 算符

tutorial/Operators

## 重画和组合图形

tutorial/RedrawingAndCombiningPlots

Wolfram 语言的所有图形都是表达式，起操控方式与其它表达式相同. 这些操控不要求使用 Show.

## 常用表达式的模式

tutorial/PatternsForSomeCommonTypesOfExpression

## 基本几何区域

guide/GeometricSpecialRegions

## 不显示out in

SetOptions[EvaluationNotebook[], ShowCellLabel -> False];

## 值集的操作

tutorial/ManipulatingValueLists

## Optional (:)(默认选值)

Optional[s_h]  表示可以忽略的函数，但如果是当前函数，必须有头部 h. 这种情况下没有任何更简单的句法形式.

可选变量与默认变量

## tutorial/OptionalAndDefaultArguments

## FLat 属性

## tutorial/PartsOfExpressions

表达式

## Through

function list apply on variables

## ref/Default

Default(默认)

_. 匹配可有可无

## tutorial/Attributes

属性

## Operate

操作

## guide/AlphabeticalListing

函数列表（按字母顺序排列）

## tutorial/SparseArrays-LinearAlgebra

稀疏数组：线性代数

## tutorial/SolvingLinearSystems

求解线性系统

## 字符串模式

tutorial/StringPatterns

## 函数的上值和下值

tutorial/AssociatingDefinitionsWithDifferentSymbols

## 文本标准化

guide/TextNormalization

### StringDelete

## Sequence[]

参数序列

## StringReplace(替换字符串)

## 字符串运算

guide/StringOperations

## 常用记号和表示惯例

tutorial/SomeGeneralNotationsAndConventions

## RegularExpression(正则表达式)

## 通过名称操作符号和内容

tutorial/ManipulatingSymbolsAndContextsByName

## JoinAcross(交叉连接)

ref/JoinAcross

tutorial/LevelsInExpressions

tutorial/Introduction-Patterns

## 模式与匹配 引言

tutorial/OptionalAndDefaultArguments

## 可选变量与默认变量

ref/$SummaryBoxDataSizeLimit

## SummaryBoxDataSizeLimit

## 摘要框

## 张量对称性

tutorial/TensorSymmetries

## 下标索引

ref/Indexed

## 构造变量的具有索引的集合

v = ToExpression["x" <> ToString[#]] & /@ Range[5]

ToString

## 曲线拟合

tutorial/CurveFitting

ref/MapThread

## MapThread & Thread difference

## 在计算过程中收集表达式/Sow Reap

tutorial/CollectingExpressionsDuringEvaluation

## 数值运算

tutorial/NumericalCalculations

## 绘图工具

tutorial/InteractiveGraphicsPalette

## DeleteCases

当应用于 Association 上时，DeleteCases 根据它们的值删除元素.

## #name

`#name` 是 #["name"] 的简短形式：

In[1]:= #x &[<|"x" -> a, "y" -> b|>]

Out[1]= a

## NestList(嵌套列表)

ref/NestList

## 颜色

guide/Colors

结合新的可编程的符号颜色和精心选择的美学颜色参数，Wolfram 语言在图形和其它形式的显示方面，采用更灵活、更引人注目的方案来设置色彩和透明度.

## 输出的样式和字体

tutorial/StylesAndFontsInOutput

## 格式化输出

tutorial/FormattedOutput#218124152

我们首先了解一下与显示大量表达式相关的框符生成器，然后再介绍几种超出了简单数学排版的方式，这些方式能用于生成漂亮的格式化输出.

## 自定义图表和图形

howto/CustomizePlotsAndGraphics

## 图形和声音

tutorial/GraphicsAndSoundOverview

## ref/Operate

算子运算，即泛函

## restore the output format changed by FeynCalc

SetOptions[EvaluationNotebook[],  CommonDefaultFormatTypes -> {"Output" -> StandardForm}]

## guide/RulesAndPatterns

## 规则与模式

Wolfram 语言符号编程范式的核心，是任意符号模式转换规则的概念. Wolfram 语言的模式语言方便的描述了一系列各种类型的表达式，让程序变得易读、简洁且高效.

## 限制模式

tutorial/PuttingConstraintsOnPatterns

Wolfram 语言中提供了对模式进行限制的一般方法. 这可以通过在模式后面加 /;condition 来实现，此运算符 /; 可读作"斜杠分号"、"每当"或"只要"，其作用是当所指定的 condition 值为 True 时模式才能使用.

## LetterQ

## /.{}

ReplaceAll  查看 expr 的每个部分，尝试所有的规则，然后继续 expr 的下一部分. 使用应用到一个特定部分的第一个规则；在这个部分或它的任何子集没有尝试更多的规则.

ReplaceAll 仅对一个表达式应用特定规则一次.

## ctrl+space跳出子表达式

## Sum  (求和)

ref/Sum

## guide/Patterns

模式

Wolfram 核心语言的一个独特的优势是其强大、简洁明了、高可读性的符号模式语言. 方便直接的应用于单个函数和系统的大规模程序中，Wolfram 语言的模式语言用正则表达式等概念来描述任意符号结构的模式.

## tutorial/PatternsForSomeCommonTypesOfExpression

常用表达式的模式

利用在"引言"中描述的对象，你可以设置许多不同类型表达式的模式. 需要注意的是，在所有情况下，模式必须用 Wolfram 语言内部格式（像 FullForm 显示的一样）来表示表达式的结构.

## 重复模式

`expr..` 重复一次或多次的模式或表达式
`expr...` 重复零次或多次的模式或表达式

## tutorial/Introduction-Patterns

引言

Wolfram 语言中用大量的模式来代表各类表达式. 例如，模式 `f[x_]` 表示形如 `f[anything]` 的一族表达式.

模式的主要功能在于 Wolfram 语言中的许多操作不仅可以对单个表达式实现，也可以对代表某类表达式的模式进行操作.

## guide/SymbolicTensors

符号张量

张量是线性计算的基本工具，它把向量和矩阵推广到更高的阶数. Mathematica 9 引入强大的方法来以代数方法操作任意阶数的对称张量. 它同时处理以分量数组给出的张量和特定张量域的成员给出的符号张量.

## guide/FunctionCompositionAndOperatorForms

函数组合和操作符表单
Wolfram语言的符号结构使得可以以符号式合并和操作的"操作符"的创建变得轻松形成操作的"管道"并且应用到参数. 某些内置函数也直接支持一个"令行禁止"的条件表单，它们在其中可以直接作为符号操作符给出.

## tutorial/Contexts

上下文
总是给变量或者定义选用尽可能清楚的名称是一个好思想. 但这样做有时会导致变量名很长.
在 Wolfram 语言中，可以用上下文来组织符合名. 在引入与其它符号不冲突的变量名的 Wolfram 语言程序包中上下文特别有用. 在编写或者调用 Wolfram 语言程序包时，就需要了解上下文.
其基本的思想是任何符号的全名为两部分：上下文和短名. 全名被写为 ``context`short``，其中 ` 是倒引号或重音符字符（ ASCII 二进制代码 96），在 Wolfram 语言中称为上下文标记.

## TimeConstrained(时间约束)

ref/TimeConstrained

TimeConstrained[expr,t,failexpr]
如果没有达到时间限制，返回 failexpr.

## 特殊函数

tutorial/SpecialFunctions

Wolfram 系统包括了标准手册中所有的数学物理中常见的特殊函数. 下面将依次讨论各类函数.

## 有理函数

guide/RationalFunctions

Wolfram 语言可以有效地处理单变量和多变量的有理函数，通过内置函数直接执行标准的代数变换.

## 以任一个变量为主组合表达式

FactorTerms[expr,x]

Collect[expr,x]

对于含有一个变量的表达式，可以选择用项的和或者乘积等来表示. 而对于含有多个变量的表达式，则有更多的可供选择的形式，例如，以任一个变量为主组合表达式.

## 以不同形式表示表达式

tutorial/PuttingExpressionsIntoDifferentForms

## Assumptions

Simplify 中的选项Assumptions可以使用诸如 Assumptions -> {m > 0, \[Mu] > 0, Di > 0}] 的规则列表

## 列表

tutorial/ListsOverview

"函数作用于表达式的部分项" 和 "结构的操作" 将介绍如何用 Map 和 Thread 使一个函数分别地作用于列表的每个元素.

tutorial/CollectingObjectsTogether

## 生成列表

生成长度为`n`、元素为 `f[i]` 的列表
ref/Array

## Apply (@@)(应用)

ref/Apply

Apply[f,expr]
或 f@@expr  用 f 替换 expr 的头部.

## Join(连接)

`Join[list1,list2]`
把列表或其它享有相同头部的表达式连接在一起.

## Replace 指定层数

`Replace[f[f[f[f[x]]]], f[x_] :> g[x], {0, 2}]`，后面可以选`All`，全部替换

Repeated [ expr_, {5} ]   or Repeated [ expr, {min,max} ]

可以具体制定重复的次数，精确的！

## 读写 Wolfram 系统的文件

tutorial/ReadingAndWritingWolframSystemFiles

## Timing

Timing

Timing[f = Fourier[RandomReal[1, 2^16]];]

## Part (部分)

ref/Part

## 倒引号`

数字标记/记号

## Array

$$\text{Array}\left[f,\left\{n_1,n_2,\text{Null}\right\},\left(
\begin{array}{cc}
 a_1 & b_1 \\
 a_2 & b_2 \\
\end{array}
\right)\right]$$

## 控制大表达式的显示

tutorial/ControllingTheDisplayOfLargeExpressions

## 将求和换成列表

tev3 = tev2 /. Plus -> List;

## Reap(收获)

Reap[expr]
给出表达式 expr 的值，以及在计算中已经应用 Sow 的所有表达式. 使用 Sow[e] 或具有不同标记的 Sow[e,Subscript[tag, i]] "散布"的表达式在不同列表中给出.

## 产生 C 和 Fortran 表达式

tutorial/GeneratingCAndFortranExpressions

*****

一些我比较经常用的 mathematica 的功能

`xxx/xxx` 是mathematica帮助文档的地址链接

## 图形结构

基本思想是 Wolfram 语言用图形基元的集合表示所有图形.
图形基元包括代表图像基本元素的 `Point` (点), `Line` (线) 和 `Polygon` (多边形), 以及 `RGBColor` 和 `Thickness` 等指令.

`InputForm` 告诉 Wolfram 语言如何表示图形.
每个点被表示为一个 `Point` 图形基元的坐标形式.

在 Wolfram 语言中,  每个完整的图形块都用图形对象表示. 图形对象的种类很多, 分别对应于不同类型的图形. 每类图形对象都有确定的头部以表明它的类型.

+ `Graphics[list]` 生成二维图形
+ `Graphics3D[list]` 生成三维图形

Plot 和 ListPlot 等在 "图形和声音的结构" 中讨论的函数都是按照先建立 Wolfram 语言内部图形对象, 然后显示它们的顺序工作的.

在 Wolfram 语言中, 用户可以自行建立图形对象产生其它类型的图像. 由于在 Wolfram 语言中的图形对象是符号表达式, 所以能用所有的 Wolfram 语言标准函数对其进行操作.

### 修改图形的局部和全局方式

给定一个图形基元列表后, Wolfram 语言提供了两种方式去修改最终的图形. 首先, 可以在图形基元列表中插入一些图形指令, 例如 RGBColor, 以修改随后列表中的图形基元. 用这种方式, 用户可以指定如何修改一个给定的图形基元列表.

通过插入图形指令, 可以指定图形基元的显示方式. 然而, 用户往往经常会希望通过全局修改来改变整个图形的显示. 使用图形选项可以达到这一目的.

通过增加图形选项 Frame 用户可以修改图形的整体外观：

```mathematica
Show[%, Frame -> True]
```

### 确定图形块的完全形式

对 `Axes` 等图形选项, Wolfram 语言的前端会自动画出用户需要的坐标轴等对象. 这些对象由选项值表示, 而非被确定的图形基元列表表示. 然而, 用户会需要要找到代表这些对象的图形基元列表. 函数 `FullGraphics` 给出不使用任何选项的情况下, 生成图形的完整的图形基元列表.

## 模式

表达式 `F[a,b,c...]`

`_ Blank[]`, 有且只有一个的表达式序列

`__ BlankSequence[]`, 一个或多个表达式序列

```mathematica
s : _ | __ // FullForm
Pattern[s,Alternatives[Blank[],BlankSequence[]]]
```

头部也可以是表达式，
所以`_ Blank[]`可以指带`f[a,b,c...][x,y,z...]`

```mathematica
MatchQ[f[a,b,c][x,y,z],x_]
True
```

## := and =

^:=

UpSetDelayed

Delayed and 不带 Delayed 的最重要区别就是，
定义时计算，还是调用的时候计算。
也就是不带 Delayed容易受到全局变量的影响，
带Delayed更加接近函数式编程

## 调试不完全数组

如果一个数组，用Dimension 测试的结果是不完全数组，
如何找出是哪里的结构不完全呢。
可以把数组中的每一项都替换成$1$再显示，这样可以比较方便的看出来。

## transpose 参数确定方法

写下数组的维数，比如`{6，8，3}`
在下面标出 转置后想得到的数组维数目次序，
比如`{3，1，2}`,

则transpose参数设置即是`{3，1，2}`

## 可选变量与默认变量

有时需要定义具有默认值的函数. 即省略某些变量时，其值就用设定的默认值代替. 模式 `x_:v` 就表示省略时值为 `v` 表示的变量.

一些 Wolfram 语言常用函数的变量具有系统设定的默认值，此时不能明确给出 `x_:v` 中的默认值，而是可用 `x_.` 来使用其系统设定的默认值.

有时不对一个可选变量分配默认值是方便的；这样的变量可以使用 `PatternSequence[]` 来指定.

`p|PatternSequence[]` 不具有默认值的可选模式 `p`
