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
f[g[args],...]^:=rhs    定义 g 的上值
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

## 上值

`^:=` 定义上值（`upvalue`），它的方式和使用一个标签的相同：

```mathematica
In[1]:= g /: f[g[x_]] := f1[x]

In[2]:= f[h[x_]] ^:= f2[x]

In[3]:= {UpValues[g], UpValues[h]}

Out[3]= {{HoldPattern[f[g[x_]]] :> f1[x]}, {HoldPattern[f[h[x_]]] :> f2[x]}}
```

一个标签仅定义一个上值（upvalue），`^:=` 执行所有符号的定义：

```mathematica
In[1]:= g /: f1[g[x_], h[y_]] := gh[x y]

In[2]:= f2[g[x_], h[y_]] ^:= gh[x y]

In[3]:= {UpValues[g], UpValues[h]}

Out[3]= {{HoldPattern[f1[g[x_], h[y_]]] :> gh[x y],
  HoldPattern[f2[g[x_], h[y_]]] :> gh[x y]}, {HoldPattern[f2[g[x_], h[y_]]] :>
    gh[x y]}}
```

进行定义时，计算立即赋值的右边：

```mathematica
In[1]:= rand[int] ^= Random[Integer];

In[2]:= {rand[int], rand[int]}

Out[2]= {0, 0}
```

每次使用定义时，每次计算延迟定义的右边：

```mathematica
In[3]:= rand[real] ^:= Random[Real]

In[4]:= {rand[real], rand[real]}

Out[4]= {0.409393, 0.730688}
```

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

总之，默认变量用`x_:v`，可选变量用`p|PatternSequence[]`

有时需要定义具有默认值的函数. 即省略某些变量时，其值就用设定的默认值代替. 模式 `x_:v` 就表示省略时值为 `v` 表示的变量.

一些 Wolfram 语言常用函数的变量具有系统设定的默认值，此时不能明确给出 `x_:v` 中的默认值，而是可用 `x_.` 来使用其系统设定的默认值.

有时不对一个可选变量分配默认值是方便的；这样的变量可以使用 `PatternSequence[]` 来指定.

`p|PatternSequence[]` 不具有默认值的可选模式 `p`

## 内嵌单元

在文本中插入公式的话，用插入-排版-内嵌单元 选项

## Flatten

如果 $m_{ij}$ 为矩阵，
Flatten[{{ $m_{11}$, $m_{12}$}, {$m_{21}$, $m_{22}$ }},{{1,3},{2,4}}]
实际上建立了由块 $m_{ij}$ 组成的单个矩阵.

也就是说 Flatten 实际上是 矩阵索引 重新划分函数。
对于一个矩阵，有n个索引（指标）。
总的元素个数是 $a_1* a_2* a_3* a_4 \cdots$
可以重新组合这些指标，例如把$a_1, a_2$ 并入一个指标中，
指标的取值范围变成$1\to a_1*a_2$

类似的，矩阵的各种指标可以随意交换，
$a_1* a_2* a_3* a_4 \to a_3* a_2* a_1* a_4 \cdots$
这就是广义转置的过程，
广义转置再加上重新划分，
这就是Flatten的作用。

## 笔记本操作

设定目录时候，可以用`NotebookDirectory[]` 输出目标路径，然后采用字符串模式匹配的方法，获取根目录，这样得到的目录可以不依赖文件的子目录位置，例如

```mathematica
git`root`dir=StringCases[NotebookDirectory[],
StartOfString~~((WordCharacter|":"|"\\")..)~~"octet.formfactor"][[1]]

Out[136]= "C:\\octet.formfactor"
```

## 通过内核或前端操作笔记本

### 通过内核操作笔记本

tutorial/ManipulatingNotebooksFromTheKernel

在 Wolfram 语言笔记本中进行简单运算时，用标准 Wolfram 语言前端交互功能是非常方便的. 但要进行复杂和系统的运算时，最好要使用内核

+ `Notebooks[]`   所有打开的笔记本集合
+ `Notebooks["name"]`   所有打开的有指定名的笔记本集合
+ `InputNotebook[]`   用于输入的笔记本
+ `EvaluationNotebook[]`   对这个函数正进行计算的笔记本
+ `ButtonNotebook[]`   可能包含启动这个计算的按钮的笔记本

在 Wolfram 语言中，笔记本前端中能交互进行的任何工作也可以从内核向前端发送适当的指令进行.

+ `Options[obj]` 给出对应于笔记本对象 obj 的笔记本的所有选项集合
+ `Options[obj,option]` 给出一个选项的设置
+ `AbsoluteOptions[obj,option]` 即使当实际设置是 Automatic 时给出绝对选项值
+ `CurrentValue[obj,option]=rhs` 给出并且设置 option 的值
+ `SetOptions[obj,option->value]` 设置选项的值

这里改变屏幕上当前所选笔记本的尺寸：

```mathematica
SetOptions[InputNotebook[], WindowSize -> {250, 100}]
```

另一方面，可以使用 CurrentValue 直接获得 WindowSize 的选项值：

```mathematica
CurrentValue[InputNotebook[], WindowSize]
```

这里对 CurrentValue 使用简单的赋值来改变选项：

```mathematica
CurrentValue[InputNotebook[], WindowSize] = {400, 300}
```

*****

还可以通过内核移动笔记本

在任何打开的笔记本中，前端总是保持当前的选择，这个选择由一个单元中的文本区域组成，或者是由这个单元组成. 通常这个选择在屏幕上是由一个高亮度形式表明. 这个选择也可以在文本的两个字符之间，或者在两个单元之间，这时它在屏幕上由两个竖直或水平的插入杠来表明.

*****

查找笔记本的内容.

将当前选择移到前一个词 cell 出现的位置：

```mathematica
NotebookFind[nb,"cell",Previous]
```

*****
为整个笔记本和当前选择寻找和设置选项.

+ `Options[obj,option]`  找出完整笔记本的一个选项值
+ `Options[NotebookSelection[obj],option]`  找出当前选择的值
+ `SetOptions[obj,option->value]` 设置完整的笔记本的一个选项值
+ `SetOptions[NotebookSelection[obj],option->value]`  设置当前选择的值

*****

整个笔记本的操作:

+ `CreateWindow[]`  产生一个新笔记本
+ `CreateWindow[options]`  产生一个具有指定选项的笔记本
+ `NotebookOpen["name"]`  打开一个已有的笔记本
+ `NotebookOpen["name",options]`  打开一个具有指定选项的笔记本
+ `SetSelectedNotebook[obj]`  选择一个指定的笔记本
+ `NotebookPrint[obj]`  打印一个笔记本
+ `NotebookPrint[obj,"file"]`  将一个笔记本的 PostScript 版本输出到一个文件
+ `NotebookPrint[obj,"!command"]`  将一个笔记本的 PostScript 版本送到一个外部命令
+ `NotebookSave[obj]`  将笔记本的当前版本存入一个文件
+ `NotebookSave[obj,"file"]`  将笔记本存为一个给定文件名的文件
+ `NotebookClose[obj]`  关闭一个笔记本

调用 `CreateWindow[]` 时，屏幕上出现一个空笔记本.

执行 `SetSelectedNotebook` 和 `NotebookOpen` 等指令时，就是让 Wolfram 语言改变所看到的窗口. 在`NotebookOpen` 和 `CreateWindow` 中使用选项设置 `Visible->False` 可以处理笔记本，但不将它显示在屏幕上.

### 通过内核操作前端

+ `$FrontEnd`  当前使用的前端
+ `Options[$FrontEnd,option]`  前端全局选项的设置
+ `AbsoluteOptions[$FrontEnd,option]`  选项的绝对设置
+ `SetOptions[$FrontEnd,option->value]`  在前端重设选项
+ `CurrentValue[$FrontEnd, option]`  返回选项值，当用于赋值的左边时，允许设置选项.

在前端操作全局选项. 

### 前端令牌

通过前端令牌，用户可以执行通常情况下使用菜单才能实现的内核命令. 
前端令牌对于编写操作笔记本的程序特别方便.

FrontEndToken 是一个内核命令，它确定其变量为前端令牌.
`FrontEndExecute` 是一个将其变量发送到前端来执行的内核命令. 
例如，下面命令创建一个新的笔记本.

```mathematica
FrontEndExecute[FrontEndToken["New"]]
```

### 在前端直接执行笔记本指令

在执行 `NotebookWrite[obj,data]` 等指令时，向笔记本中插入数据的实际操作是在前端进行的. 但为了估算原来的指令和构造送向前端的适当请求，还是要使用内核的. 不过，前端可以直接执行一定量的指令，而不需涉及内核. 
*****
区分指令的内核和前端版本. 

+ `NotebookWrite[obj,data]` 在内核执行的 `NotebookWrite` 版本指令
+ `FrontEnd`NotebookWrite[obj,data]` 在前端直接执行的 `NotebookWrite` 版本指令

Wolfram 语言区分在内核执行的指令和前端直接执行的指令的基本方式是使用上下文. 
内核指令通常在 ``System` `` 上下文中，而前端指令通常在 ``FrontEnd` `` 上下文中. 

`FrontEndExecute[expr]` 把 `expr` 发送到前端执行

把表达式发送到前端执行. 

在书写操纵笔记本的精细复杂的程序时，这些程序必须在内核执行但对于通过简单按钮所进行的运算，可以在前端直接执行所需要的所有指令，甚至不需要运行内核. 

### 单元结构

*****
对应于单元的表达式. 

+ `Cell[contents,"style"]`  有特殊风格的单元
+ `Cell[contents,"style1","style2`  有多个风格的单元
+ `Cell[contents,"style",options]`  有额外选项设置的单元

Wolfram 系统实际上用`样式定义单元`来定义样式. 这些单元可以放在另外的样式定义笔记本中，也可以包含在一个笔记本的选项中. 不论哪一种情形，都可以在标准笔记本前端中用 `编辑样式表` 菜单项访问它们.

### 单元选项

Wolfram 语言提供了大量的单元选项，这些选项都可以在前端中通过 选项设置 菜单项访问. 
它们可以在单个单元层上直接设置，也可以在高层设置而让单个单元去继承. 

*****
计算选项. 

| 选项 | 典型默认值 | explanation |
|----|----|----|
| Evaluator | "Local" | 用于计算的内核名 |
| Evaluatable | False | 单元内容是否被计算
| CellAutoOverwrite | False | 产生新输出时是否覆盖以前的输出 |
| GeneratedCell | False | 该单元是否从内核产生 |
| InitializationCell |  False | 打开笔记本时是否自动计算该单元 |

Wolfram 语言可以对笔记本中的每个单元指定不同的计算方式. 
但是常常是在笔记本层设置选项 Evaluator，这一般是用前端中的 内核配置选项 菜单项完成. 

### 文本和字体选项

### 表达式输入和输出选项

Wolfram 语言中常用特殊字符有许多别名.
`InputAliases` 可以给更多的特殊字符或其它类型的 Wolfram 语言输入定义别名. 形如 `"name"->expr` 的规则决定 `Esc name Esc` 应该在输入时立即被 expr 替换. 

`别名`用明确的 `Esc` 字符定界. 选项 `InputAutoReplacements` 指定一些类型的输入序列即使设有明显的定界符也应该被立即替代. 例如，在默认设置下，`->` 立即被 `->` 替换. 可以用形如 `"seq"->"rhs"` 的规则去指定输入中出现的 `seq` 立即用 `rhs` 替换. 

### 笔记本选项

*****
改变笔记本选项的方式. 

+ `\[FilledSmallSquare]` 用选项设置菜单交互式的改变选项.
+ `\[FilledSmallSquare]` 使用内核的 `SetOptions[obj,options]`.
+ `\[FilledSmallSquare]` 用 `CreateWindow[options]` 产生具有指定选项的新笔记本.

这里创建一个笔记本，并显示在具有细框的 `400x300` 窗口中：

```mathematica
CreateWindow[WindowFrame -> "ThinFrame", WindowSize -> {400, 300}]
```

### 前端的全局选项

在标准笔记本前端中，可以设置许多 Wolfram 系统全局选项. 
默认情况下，这些选项的值保存在一个"偏好文件"中，当重新运行 Wolfram 系统时就自动再次使用.
这些选项包含可以用偏好设置对话框生成的设置.

*****
前端全局选项的一些类型.

+ 风格定义  新笔记本使用的默认样式定义
+ 文件位置  搜索笔记本和系统文件的目录
+ 数据输出选项  如何用各种格式输出数据
+ 字符编码选项  如何对特殊字符编码
+ 语言选项  文本使用的语言
+ 信息选项  如何处理 Wolfram 系统产生的信息
+ 对话设置  对话框中的选择
+ 系统配置  对特定计算机系统的私有选项

可以用 `Options[$FrontEnd,name]` 从内核访问前端全局选项. 
但通常在前端使用"选项设置"去交互式地访问这些选项. 

## 框符的字符串表示

Wolfram 语言提供了一种简洁的方式来用字符串表示框符. 在将框符的设定作为普通文本进行导入和导出时，这种方式尤其方便.

*****
区分原始框符和其代表的表达式. 

+ `\(input\)` 原始框符
+ `\!\(input\)` 框符的意义

如果将一个 StandardForm 单元的内容复制到另一个如文本编辑器的程序中，
Wolfram 系统将在必要时生成一个`\!\(...\)`形式. 这样做是为了当讲这个格式的内容重新复制回 Wolfram 系统中时，该 StandardForm 单元的原始内容会自动再次生成. 
如果没有 `\!`，则仅得到对应于这些内容的原始框符.

在选项的默认设置下，贴入 Wolfram 系统笔记本中的 `\!\(...\)` 格式自动显示成二维格式.

*****
字符串中嵌入二维框件结构. 

+ `"\(input\)"` 一个原始字符串
+ `"\!\(input\)"` 含有框符的字符串

Wolfram 语言通常将出现在字符串内的 `\(...\)` 格式与其它的一系列字符一样对待. 
通过插入 `\!` 可以令 Wolfram 语言将这个格式视作它所代表的框符.
 通过这种方式可以在普通字符串内嵌入框符结构.

Wolfram 语言把这当成一个普通字符串：

```mathematica
In[13]:= "\( x \^ 2 \)"
Out[13]= \( x \^ 2 \)
```

`!\` 告诉 Wolfram 语言这个字符串含有框符：

```mathematica
In[14]:= "\!\( x \^ 2 \)"
Out[14]= x^2
```

## Wolfram 系统的结构

ref: tutorial/RunningTheWolframSystemOverview

Wolfram 系统是一个模块化的软件系统，其执行运算的内核与处理用户交互的前端是互相分离的.

*****
Wolfram 系统的基本部分.

+ Wolfram 语言内核 实际执行运算的部分
+ Wolfram 系统前端 处理与用户交互的部分

这样的设计比整体结构有许多优势. 例如，Wolfram 系统前端可运行在具有增强图形处理能力的本地计算机上，而 Wolfram 语言内核可运行在更快地远程计算机上. 
或运行多个内核只需一个前端.

最常见的 Wolfram 系统工作方式是使用交互式文档称为笔记本. 
笔记本把具有文字、图形、面板和其它资料的输入和输出放在一起. 
用户使用笔记本既可进行运算，也可作为表达或发布自己的结果的工具.

其它常见的 Wolfram 系统界面包括基于文本的界面和 Wolfram Symbolic Transfer Protocol (WSTP) 接口.

Wolfram 系统的常见界面种类.

+ 笔记本界面 交互式文档
+ 基于文本的界面 由键盘输入的文本
+ WSTP 接口 与其它程序通讯

Wolfram 系统的一个重要特点是它不仅能与人交互，还能和其它程序交互. 这个功能是通过 WSTP 来实现的. 
它是外部程序和 Wolfram 语言内核之间的标准双向通讯协议.
在众多可用的 WSTP 兼容的程序中，一些被用来作为 Wolfram 系统的前端. 这些前端常常提供自己特有的用户界面，并把 Wolfram 语言内核纯粹作为嵌入的计算引擎.

**您应该意识到笔记本是 Wolfram 系统 "前端" 的一部分. **

Wolfram 语言内核--实际执行计算的部分， 既可以和前端一样运行在本地计算机上，也可以通过网络运行在其它的计算机上. 

在大多数情况下，直到您用 Wolfram 语言进行计算时， 内核才开始启动.

### 使用文本界面

在某些情况，您不需要使用笔记本前端，而需要更直接的与 Wolfram 语言内核交互， 
为此，您可以使用基于文本的界面，您键入键盘的文本会直接进入内核.

值得注意的是，虽然文本界面可以使用 Wolfram 语言内核的大部分功能，但是不具备图形功能和与 Wolfram 语言前端动态交互的能力.

#### 启动 Wolfram 语言内核

windows: wolframscript.exe

#### Wolfram 系统会话

在每一个阶段，Wolfram 系统将给出提示 `In[n]:=` 告诉您，它准备接受输入. 
然后，您可以敲入输入，并以 `Enter` 或 `Return` 结束输入.

请注意您无需键入提示 `In[n]:=`，只需键入提示后的文本.

当您敲入输入，Wolfram 系统将处理并产生结果，输出结果时将其标记为`Out[n]=`.

#### 编辑输入

*****
编辑输入的默认键. 

+ `Ctrl+A`,`Home` 将光标移到输入的开始
+ `Ctrl+E`,`End` 将光标移到输入的结尾
+ `Ctrl+H`,`Backspace` 删除光标之前的字符
+ `Ctrl+D`,`Delete` 删除光标之后的字符
+ `Ctrl+G`,`Ctrl+C`,`Esc` 取消或者删除输入
+ `Ctrl+K` 删除从光标到输入末尾的内容
+ `Ctrl+D`,`Ctrl+Z` 终止内核
+ `Left`,`Right` 移动光标
+ `Up`,`Down` 调用前面的输入
+ `Enter` 计算输入或者增加另一行
+ `PageUp`,`PageDown` 跳到输入历史的第一项或者最后一项

当您的输入很长时，您也可以在几行内给出. Wolfram 系统将自动读取连续的行直至它收到一个完整的表达式. 因此，例如，当您在一行输入一个前括弧或者双引号时，Wolfram 系统将继续读取连续的输入行，直至它看到相应的后括弧或者双引号.

有时候，您可能想要删除输入，并且重新开始，而不是计算已经输入的内容. 若要取消、删除输入的内容，使用 `Ctrl+G`. 或者如果您想要删除光标位置后的输入，使用 `Ctrl+K`.

键盘快捷键列表在上面的表格中给出.

#### 启用原始的基于文本的界面

通常情况下，当 Wolfram 语言内核运行于基于文本的界面时，它会提供其他工具，例如命令行编辑器或命令行历史，这些在前面章节已讨论过. 
为了操作这些工具，内核使用特殊的底层指令控制你使用的字符终端或终端仿真器. 

在某些情况下，你可能想阻止内核这样做，
比如你的终端不支持某些命令行编辑器需要的底层指令，或比如你需要非交互式地运行内核作为更大型命令的一部分.

要在原始模式上运行 Wolfram 语言内核，使用 `-rawterm` 命令行开关. 
当在原始模式下，内核累积所有直接从键盘上收到的字节到输入缓存以便进一步解析和诠释.

```mathematica
$ wolfram -rawterm
Mathematica 12.0 for Linux x86 (64-bit)
Copyright 1988-2018 Wolfram Research, Inc.

In[1]:=
```

#### 终止内核

在基于文本的界面中退出 Wolfram 系统. 

在输入提示符下输入 `Quit[]` 退出 Wolfram 系统. 
您也可以敲入`Ctrl+D` 或 `Ctrl+Z` 退出 Wolfram 系统，
如果输入行为空，`Ctrl+D` 将终止 Wolfram 系统.

`Ctrl+D`, `Ctrl+Z` 或`Quit[]` 退出 Wolfram 系统

## Wolfram 系统会话

Wolfram 系统会话

reference: guide/WolframSystemSessions
reference: tutorial/RunningTheWolframSystemOverview
*****
mathematica 中的前端概念

Wolfram 系统的组件 
Kernel（内核）- 核心计算引擎 
Front end（前端）-笔记本界面系统 

### 执行计算

`shift+enter` 计算输入
`ctrl+shift+enter`  在当前位置计算选择表达式
`expr;`   计算表达式，但不输出结果
(= 在输入的开始部分) 使用自由格式语言输入

### 会话历史

`%n`  第n个输出表达式
`ctrl+l` 复制一个输入单元

### 消息 

`Off` 关掉一个消息或一群消息
`Quiet` "安静"的运行一次计算，不输出消息

### 会话信息

+ `Directory` 当前目录
+ `Names`  已知符号的名称
+ `Notebooks `
+ `MemoryInUse`
+ `SystemInformation`
+ `DateString`

### 定制会话

+`$Post` 后处理,是一个全局变量，如果设置，它的值应用到每个输出表达式.
`$Path` 默认路径,给出在试图找到一个外部文件时搜索的缺省目录列表.

## 使用文本界面

tutorial/UsingATextBasedInterface

## 计划任务

### NotebookEvaluate

*****

NotebookEvaluate[notebook] 

计算 `notebook`  中所有可计算单元.

`NotebookEvaluate` 返回指定笔记本中最后一次计算返回的值.

`NotebookEvaluate` 可以采用 `NotebookObject` 或者指定一个笔记本文件的文件名. 如果一个文件名指代的是一个当前打开的笔记本，那么计算进行到打开的笔记本中.
可以给定如下选项：

+ `InsertResults` `False` 是否在笔记本中插入结果
+ `EvaluationElements` `All` 计算哪些单元

缺省情况下，`NotebookEvaluate` 显示运算中产生的各种信息的方式与怎样调用 `Get` 类似. 
消息、输出及运算中产生的其他信息将会被放置在调用 `NotebookEvaluate` 的单元的输出中，而不是指定笔记本的输出. 笔记本中现有的输出单元不会被更新或删除.

`NotebookEvaluate[notebook,InsertResults->True]` 处理运算中产生的信息和输出的方式与处理shift-enter运算的方式一样.
消息、输出及运算中产生的其他信息将与输出一起放置在笔记本中，
会取代现有输出或其他相关单元.

当 `NotebookEvaluate[notebook, InsertResults->True]` 用于一个未打开的文件上时，Wolfram 系统将打开文件、完全计算它，保存并且关闭该文件.

`NotebookEvaluate[notebook, InsertResults->False]` 将使得笔记本完全不被修改.

笔记本的单元在对话子进程中计算.

在一个打开的笔记本上使用 `NotebookEvaluate` 将导致笔记本中出现子进程计算的可见部分. 

笔记本将继续在屏幕上更新，而它的单元正在被计算.

与 `Get` 不同，出现在一个可执行单元中的语法将不阻止 `NotebookEvaluate` 对其他输入进行计算.

`NotebookEvaluate[notebook, EvaluationElements->Automatic]` 只计算初始化单元. 
这与把笔记本保存为程序包文件等价，或者与自动产生的程序包等价，并且在所得的程序包文件上使用 `Get`.

当在一个程序包文件上运行时，`NotebookEvaluate` 等价于 `Get`. `InsertResults` 选项将被忽略.

### 对话

ref:tutorial/Dialogs

在标准交互式进程中，可以用 Wolfram 语言命令 Dialog 去建立一个**子进程**或者**对话.** 在进行计算的过程中，可以用对话与 Wolfram 语言相互作用. 像 "计算的跟踪" 中提到的一样，TraceDialog 在一个表达式计算的过程中的指定点自动调用 Dialog. 另外，在计算过程中要中断 Wolfram 语言时，一般用对话检查它的状态. 

*****
启动对话和从对话返回. 

+`Dialog[]` 启动 Wolfram 语言对话
+`Dialog[expr]` 启动对话，将 `expr` 作为 `%` 的当前值
+`Return[]` 从对话返回，取 `%` 的当前值作为返回值
+`Return[expr]` 从对话返回，取 `expr` 作为返回值

## mathematica脚本

## 文件

### 本地对象





## mathematica 的 层次结构

guide/LowLevelNotebookStructure

内核--前端

box--笔记本

字符串表示--框符

`\[name]`

## 模块化和事物的命名

tutorial/ModulesAndLocalVariables

跟变量命名 和 以及 变量局部化有关

## 使用样式表

tutorial/WorkingWithStylesheets

根据笔记本界面所提供的任意或全部可用选项，Wolfram 系统使用样式表控制笔记本的行为和外观. 

样式表是笔记本的各种特殊单元的集合，它被其他笔记本引用，或者作为笔记本选项的一部分应用. 在后一种情形中，我们称样式表作为私有或本地样式表在笔记本内部"嵌入".

*****
与样式表相关的函数.

+ `StyleDefinitions` 笔记本选项，指定具有样式定义的文件能够在笔记本中使用
+ `StyleData["style"]` 样式定义单元的内容的低层表示

样式表是包含 `StyleData` 单元的笔记本. 一个简单的样式表笔记本表达式可以像下面所展示的这个例子这么简单.

```mathematica
Notebook[{
  Cell[StyleData["Section"],
    FontColor->Gray],
  Cell[StyleData["Subsection"],
    FontFamily->"Helvetica"]
  }]
```

上例仅定义了两种样式： `Section` 和 `Subsection`. 两者的定义仅使用了一个选项. 
在没有更多信息的情况下，`Section` 和 `Subsection` 单元在工作笔记本中没有任何不同. 它们的大小相同（正常文本），并具有相同的边幅，一个将是灰色的，另一个将是黑色的，并且它们的字体也将不同.

### 继承

继承是一个与级联样式表相关的概念--从不同层次的引用所获得的格式设置. 
样式表中的第一个单元通常引用已有的样式表，如 Default.nb，点击它可以看到它引用的是 Core.nb. 

该累积效应堆栈的最终是工作文档的实际单元. 如果它应用了一个选项，如 `FontColor->Red`，该选项将覆盖整个继承堆栈的 `FontColor` 的其他设置.

+ `$FrontEnd`  笔记本界面中所有选项的默认设置
+ `Core.nb`  定义低层单元外观和行为的基础样式表
+ `Default.nb` 可供用户选择的样式表，对于新文档通常是 Default.nb
+ `个人样式表 （如果存在）`  编辑文档样式表的结果
+ `样式表中 "Notebook "的局部样式定义 `  应用于笔记本层次的选项的样式表的特殊样式定义
+ `样式表中的样式环境设置`  下节中讨论的环境
+ `笔记本层次的选项设置`  应用于笔记本层次的设置
+ `单元层次的选项设置`  应用于单元层次的设置

### 环境

`StyleData["style","environment"]` 表示在样式环境 "environment" 中样式定义单元的内容

`StyleData` 的第二个参数通常是设置所应用的环境名称.

样式环境提供了一种无需更换样式表即可切换文档设置的方法. 
典型的环境包括 `SlideShow` 和 `Printout`. 许多专门的行为依赖于文档的环境设置. 
例如，幻灯片放映能够工作是由于分页设置，而分页设置在其他情况下与正常工作环境无关.
相似地，打印操作也受这些相同的分页符的影响，但 `Printout` 环境将待打印页面中所有内容按比例缩放至一个更合适的尺寸. 字体也被设置为打印所需的较高分辨率.

显示屏和打印环境的设置可以不同，方法是使用两种不同的菜单：`格式--显示屏环境` 和 `文件--打印设置--打印环境`. 
在默认情况下，文档界面将显示屏环境设置为 `Working` ，将打印环境设置为 `Printout`. 
因此，一定要注意这不是一个"所见即所得"的配置. 
