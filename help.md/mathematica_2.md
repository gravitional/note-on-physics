# mathemtatica-2

## 常用概念

***
`前端令牌`--`guide/FrontEndTokens` :
Wolfram语言允许通过发送适当的前端令牌，从内核以脚本的方式执行任何前端命令。如`保存`,`打开`文件等等。 
除了所有标准菜单命令，还包括默认前端菜单配置无法直接访问的`tokens`。

***
`模块` tutorial/HowModulesWork
Wolfram 语言中模块的基本工作方式非常简单. 
任何模块每一次使用时，就产生一个新符号去代表它的每一个局部变量. 
新符号的名字被唯一地给定，它不能跟任何其它名字冲突. 命名的方法是在给定的局部变量后加 `$`，并给出唯一的序号. 
从全局变量 `$ModuleNumber` 的值可以找到序列号. 该变量计算 `Module` 的任何形式所使用的总次数. 
`Module` 中产生形如 `x$nnn` 的符号去代表每个局部变量.

***
`模式` tutorial/PatternsAndTransformationRules
`常用表达式的模式`  tutorial/PatternsForSomeCommonTypesOfExpression
`模式与匹配 引言`: tutorial/OptionalAndDefaultArguments

表达式 `F[a,b,c...]`

`_ Blank[]`, 有且只有一个的表达式序列

`__ BlankSequence[]`, 一个或多个表达式序列

`f[x_, x_]` 表示函数中两个相同的自变量，`f[x_,y_]`表示函数中任意两个变量，可以相同，也可以不同。

```mathematica
s : _ | __ // FullForm
Pattern[s,Alternatives[Blank[],BlankSequence[]]]
```

头部也可以是表达式，
所以`_`也就是`Blank[]`可以指带`f[a,b,c...][x,y,z...]`

```mathematica
MatchQ[f[a,b,c][x,y,z],x_]
True
```

***
`对模式施加限制` tutorial/PuttingConstraintsOnPatterns
`限制模式` tutorial/PuttingConstraintsOnPatterns

Wolfram 语言中提供了对模式进行限制的一般方法. 这可以通过在模式后面加 `/;condition` 来实现，此运算符 /; 可读作"斜杠分号"、"每当"或"只要"，其作用是当所指定的 condition 值为 True 时模式才能使用.

***
`重复模式` tutorial/Introduction-Patterns
`expr..` 重复一次或多次的模式或表达式
`expr...` 重复零次或多次的模式或表达式

`规则与模式`: 
guide/RulesAndPatterns
guide/Patterns

Wolfram 语言符号编程范式的核心，是任意符号模式转换规则的概念. Wolfram 语言的模式语言方便的描述了一系列各种类型的表达式，让程序变得易读、简洁且高效.

***
`各种替换`

+ `Replace`
+ `ReplaceAll`
+ `ReplaceRepeated`
+ `ReplacePart`
+ `Dispatch`: 可以加速替换.

`mma`中的表达式都可以表示成树. 不同的函数具体的操作流程不同。

`ReplaceAll`大概是：在树的根部，也就是从整个表达式开始，然后第一层，第一个，尝试每个规则，如果可以替换就替换，否则深入到下一层，然后第二个，等等。
对于某个子表达式，`ReplaceAll`使用可用的第一个规则，然后跳过这个子集, 不再尝试更多的规则. `ReplaceAll` 仅对一个表达式应用特定规则一次.
也就是`ReplaceAll`替换它可以替换的最大子表达式，然后停止.
如果替换规则没有嵌套，应该可以保证完全替换. 否则应该使用`ReplaceRepeated`. 

`ReplaceRepeated`重复应用`ReplaceAll`， 直到表达式不再变化为止。

`Replace` with level spec `All` 将会尝试替换每个子表达式 exactly 一次.

`ReplacePart`: 替换某些位置上的子表达式.

***
`Condition`:条件替换
`PatternTest`: 模式检测

```mathematica
f[x_] := Condition[ppp[x], x > 0]
```

当`x > 0`为真的时候，才进行函数的定义.

判断是否为数值对象:

```mathematica
NumericQ[Sin[Sqrt[2]]]
```

***
`无序模式`

```mathematica
MatchQ[{2, 1}, {OrderlessPatternSequence[1, 2]}]
```

***
带有`默认参数`的匹配: tutorial/OptionalAndDefaultArguments

有些函数，比如`Plus`，具有`Flat`性质，在模式匹配中可以匹配任意多的数目的参数，因为`Plus[1,2,3]=Plus[1,Plus[2,3]]`。但是它不能匹配单个`a`。

这时候可以使用`x_+y_.`这样的写法，对应的函数是`x+Optional[y_]`，就可以匹配到`a+0`了，由于`Plus`具有全局默认参数,`0`。

使用`x_.`可以匹配那些在数学上相等，但是在结构上不相等的式子。`x_.`会自动选取外层函数的全局默认值。

```mathematica
{g[a^2], g[a + b]} /. g[x_^n_] -> p[x, n]
{p[a, 2], g[a + b]}
```

有时候需要分配一个没有默认值的可选参数，可以使用`2 | PatternSequence[]`，如

```mathematica
{g[1], g[1, 1], g[1, 2]} /. g[x_, 2 | PatternSequence[]] :> p[x]
{p[1], g[1, 1], p[1]}
```

***
`字符串处理`: `字符串模式` tutorial/WorkingWithStringPatterns

LetterQ

比较字符串时忽略大小写，这个功能在`StringMatchQ`的选项中：
`StringMatchQ["acggtATTCaagc", __ ~~ "aT" ~~ __, IgnoreCase -> True]`

在字符串匹配中，`x_`只匹配单个字符，`characters`,`StringExpression[pattern...]`可以用来表示模式序列，有各种各样对应正则表达式功能的函数。

比如

+ `StartOfString`   字符串开头
+ `EndOfString`   字符串结尾
+ `StartOfLine`   行的开始
+ `EndOfLine`   行的结束
+ `WordBoundary`   boundary between word characters and others 
+ `Except[WordBoundary]`   anywhere except a word boundary 

***

`字符串模式`: tutorial/StringPatterns
`文本标准化` guide/TextNormalization
`StringDelete`
`StringReplace`:替换字符串
`字符串运算`: guide/StringOperations
`正则表达式`:RegularExpression

***
字符串导出导入

常用函数

+ `Import`
+ `Export`
+ `ImportString`
+ `ExportString`

选项 默认值 含义

`"TextDelimiters"` string or list of strings 给非数字（一般是字符串）分界
`"FieldSeparators"`  `{" ","\t"}`给columns分界的字符串
`"LineSeparators"`  `{"\r\n","\n","\r"}`  给rows分界的字符串
`"Numeric"`  `True` 如果可能的话，是否把数据导入成数字

例子

```mathematica
ExportString[{1, "text", 2, 3},
 "Table",
 "TextDelimiters" -> {"<", ">"},
 "LineSeparators" -> "\n",
 "FieldSeparators" -> " "
 ]
 ```

`wolframscripts` 结合`shell` 使用时，传递参数最好用字符串，不会改变结构。
在mma 脚本内部，使用 `ToString` and `ToExpression` 进行转化，为了保险，可以增加`InputForm`选项。

***
命令行输出的时候，可以用

```
ExportString[RandomReal[10, {4, 3}], "Table"]
```

还有`"List"`格式

***
`变量局部化`

`Block` 居域化变量，但不创建新变量; `Module` 创建新变量。

```mathematica
x = 7;
Block[{x}, Print[x]]
Module[{x}, Print[x]]
```

`Block`和`Moudle`的区别可以查看`tutorial/BlocksComparedWithModules`，
`Module`是`lexical scoping`，而`Block`是`dynamic scoping`, `Module`把程序文本中出现的变量替换成局部变量，而`Block`则把计算过程中出现的变量替换成局部变量。
也就是`Block`是在执行历史中进行替换。`Block`在交互计算的时候，更常用，因为这时候更关注计算历史。

***
`表达式的层次`: `Level` `Map` `Scan` 等的区别: 

它们都可以使用标准的层次指定, `Scan` 和 `Map`效果一样，但是`Scan`不会返回结果（不会建立一个新的表达式）. 
`Scan` 可以用过程化的控制：`Return`, `Throw`, `Catch`

可以使用 `Shallow`函数来浏览表达式的结构，

```mathematica
Shallow[First[fig`origin[["merge", "normal", "gm_charge"]]] // 
  InputForm,
 {8, 10}
 ]
```

`Level` 也可以对子表达式应用函数`f`，但将整个序列作为`f`的参数，例如:

```mathematica
Level[a + f[x, y^n], 3, ft]
Level[a + f[x, y^n], {3}, ft]

out:ft[a, x, y, n, y^n, f[x, y^n]]
out: ft[y, n]
```

***
过程控制函数

`Sow`, `Reap`, `Catch`,  `Throw`

***
`插入元素`: `Insert[expr,elem,{i,j,...}]`: 把元素插入到 `expr` 的 `{i,j,...}` 位置.

***
求数列公式有个函数`FindSequenceFunction`

***
`Messages`:  tutorial/Messages 

消息系统可以用来输出错误和警告：`tutorial/Messages`
常用函数有：`Message`, `Messages`, `Information`

`$MessageList` : 当前输入行计算产生的消息列表。

`Check[expr,failexpr]`:  如果计算成功，返回`expr`，如果计算期间产生消息（一般是因为错误），就返回`failexpr`

***
`全局信息` tutorial/GlobalSystemInformation

可以使用一些特殊的全局变量，来查看运行环境，如：

```mathematica
$Notebooks   记录是否正在使用笔记本前端
$BatchInput   是否以批处理方式给出输入
$BatchOutput   是否应以批处理方式给出输出，从而不带标签等.
$CommandLine   用于调用Wolfram语言内核的原始命令行
$ParentLink   WSTP LinkObject，指定调用内核的程序（如果直接调用内核，则为Null）
$ProcessID   操作系统分配给Wolfram语言内核进程的ID
$ParentProcessID   调用Wolfram语言内核的进程的ID
$Username   运行Wolfram语言内核的用户的登录名
Environment["var"]   操作系统定义的变量的值
```

***
`张量` tutorial/SymmetrizedArrays

mma 可以处理张量对称性，使用以下函数

例如：

```mathematica
SymmetrizedArray[{{1, 2} -> a, {2, 3} -> b}, {3, 3},  Antisymmetric[{1, 2}]]
Symmetric[{1, 2, 3}]
Antisymmetric[{1, 2}]
Symmetrize[{{a, b}, {c, d}}, Antisymmetric[{1, 2}]]
```

`TensorSymmetry` : 给出张量在 `slots` 的置换下的对称性.
`Symmetric[All]`表示对所有指标对称，`Symmetric[{}]`表示没有对称性。

***
张量运算

内积:`Dot`

对于两个一般的张量 $T[i_1,i_2,\cdots ,i_n]$ and $U[j_1,j_2,\cdots,j_m]$，应用`Dot[T,U]`将得到张量
$$
\sum_k T[i_1,i_2,\cdots ,i_{n-1},k] * U[k,j_2,\cdots,j_m].
$$

当然，这要求$T$的最后一个指标$i_n$和$U$的第一个指标$j_1$相等，`Dot`运算始终可以理解为缩并这两个指标。
结果是一个$m+n-2$阶张量。

张量缩并:`TensorContract`

```mathematica
TensorContract[T, {{2, 3},{1,4}}]
```

分别缩并张量`T`的`2,3`，`1,4`指标.

***
`多项式`相关 tutorial/FindingTheStructureOfAPolynomial

找到某一个变量的最高次幂:

```mathematica
Exponent[1 + x^2 + a x^3, x]
```

提取多项式的系数:

```mathematica
CoefficientList[1 + 6 x - x^4, x]
```

给出一个多项式中的单项式:

```mathematica
MonomialList[(x + 1)^5, x, Modulus -> 2]
```

还可以为结果指定顺序，可以指定的顺序有：

"Lexicographic", "DegreeLexicographic", "DegreeReverseLexicographic", "NegativeLexicographic", "NegativeDegreeLexicographic", "NegativeDegreeReverseLexicographic", or an explicit weight matrix

***
`李群生成元`

参考[stackexchange](https://mathematica.stackexchange.com/questions/159014/calculate-representations-of-sun-generators||calculate-representations-of-sun-generators)，计算`SU(3)`群的生成元在`d`维的表示.

实际上，结构常数的思想不是先规定好它们的取值，再找到合适的基。 
这个过程是反过来的：通常先规定基满足一些良好的性质，再根据这些基计算结构常数。
一般是要求这些矩阵是稀疏矩阵，并且对于某种内积正交。

在 Mathematica 中，可以通过 `SparseArray` 设置稀疏矩阵。 
下面的代码构造了`SU(3)`生成元的3–维基，它们对于 `Frobenius` 内积是正交的。 当然，该方法可以推广到任意维度。

```bash
n=3; 
a=1/Sqrt[2] Flatten[Table[
SparseArray[{{i,j}->I,{j,i}->I},{n,n}],{i,1,n},{j,i+1,n}],1]; 
b=1/Sqrt[2] Flatten[Table[
SparseArray[{{i,j}->-1,{j,i}->1},{n,n}],{i,1,n},{j,i+1,n}],1]; 
c=DiagonalMatrix@*SparseArray/@Orthogonalize[Table[SparseArray[{{i}->I,{i+1}->-I},{n}],{i,1,n-1}]]; 
basis=Join[a,b,c]; 
MatrixForm/@basis
```

***
`插图`: `Inset[obj,pos,opos,size]`

把一个图像插入到外层图像的特定位置，并指定插图的大小

***
`package` 包 : tutorial/SettingUpWolframLanguagePackages

mma 中写包的大概结构：

```mathematica
BeginPackage["Package`"]    设置 Package` 为当前上下文，并且把 System` 放进 $ContextPath
f::usage="text", ...    介绍打算要导出的对象（不包括其他对象）,函数在这里使用后，它的上下文会是Package`，可以被外部使用
Begin["`Private`"]    设置当前上下文为  Package`Private`
f[args]=value, ...     给出包中定义的主要内容
End[]   恢复到之前的上下文（此处为 Package`）
EndPackage[]    结束包，把Package`放到上下文搜索路径中
```

此外：

`$Packages` :提供与当前 `Wolfram` 系统会话中已加载的所有软件包相对应的上下文列表。
`` Needs ["context`"] ``:如果指定的上下文尚未在 `$Packages` 中，则加载适当的文件。它会自动调用`Get[]`

mma 的环境变量一共有两部分，分别叫做`$ContextPath` and `$Context`，
前者类似 Linux 的 `$PATH`，后者是当前的上下文，搜索名称的时候，**先搜索`$ContextPath`, 再搜索`$Context`**。

***
`BeginPackage[]` and `Begin[]` 都要配合相应的`EndPackage[]` and `End[]` 使用，它们的效果不同：

``BeginPackage["abc`"] `` 默认会同时设置 `$Context` and `$ContextPath`，让会话中只剩下`` abc` `` and `` System` ``两个上下文，
当然，它也有`` BeginPackage["context`",{"need1`","need2`",... ``这种语法。

而`` Begin["abc`"] `` 不会更改 `$ContextPath`，它只更改`$Context` 为 `` "abc`" ``。

此外，调用`` EndPackage[] `` (不需要参数) 结束包时，会将这个包，比如`` "abc`" ``添加到`$ContextPath`的前面。
而`` End[] `` 不会更改`$ContextPath`。

***
`函数`, `function`

默认值与可选值

指定类型用`x_ h`语法，or `Blank[h]`

+ `x_:v`   如果没有提供，默认值是`v`
+ `x_ h:v` 头部是`h`，默认值是`v`
+ `x_.`  一个表达式，带有内置的默认值, 内置默认值用`Default`设置, `Default[f,i]` 设定第`i`个默认值。
+ `p|PatternSequence[]`  可选模式`p`，不带默认值,`PatternSequence[]` 表示长度为零的模式。

一个位置参数的比较完整的形式是：`name:_head`

```mathematica
x : _Integer
```

一个默认参数的比较完整的形式是：`name:_head:default`

```mathematica
x:_h:v
```

***
`key-value 键值对`

`key-value`类型的参数，在 `mma` 中，通过选项--`Option`实现，, `OptionsPattern[]` 匹配

+ `OptionsPattern`匹配由`->`或`:>`指定的的任何替换规则序列，或规则的嵌套列表。
+ 在`OptionsPattern [{spec1,spec2，...}]`中，`speci`可以是 `Head fi`，或显式的规则`opti->vali`. 对于每个`Head fi`，使用`Options[fi]`获得规则列表。
+ `OptionsPattern[]`使用`nearest enclosing function`的默认选项。
+ 使用`OptionsPattern[{}]`表示不包含默认选项。
  
使用`OptionValue[f, {Frame, PlotPoints}]`获取选项的`value`

使用`FilterRules[rules,patt] `挑选规则列表，例如：

```mathematica
FilterRules[{a->1,b->2,c->3},{b,a}]
{a -> 1, b -> 2}
```

***
函数的属性

tutorial/Attributes

```mathematica
Attributes[f]   给出 f 的属性
Attributes[f]={attr1,attr2,...}  设置 f 的属性
Attributes[f]={}   令 f 没有属性
SetAttributes[f,attr]   为f 添加属性attr
ClearAttributes[f,attr]   从 f 中清除 attr 属性
```

***
`过程式编程`

guide/ProceduralProgramming
guide/FlowControl

普通的流程控制可以使用`Return[expr]`，复杂的可以使用`Throw`,`Catch`

由于`Return`一般在控制结构比如`If`中使用，`Return`会退出`If`，以及`If`外面那层函数，但对于嵌套函数的情形，只退出最内的一层函数。

语句组：
`CompoundExpression[exp1,exp2,...]`
例如:`Print[x]; Print[y]`，按顺序执行。

返回值可以由`Return[expr]`控制，但是需要有一个外层函数结构。

***
也可以使用`Throw`,`Catch`控制过程。
他们是成对使用的, `Throw[value,tag]`负责跳出过程，返回当前`value`, 对应的`Catch`可以接住`value`，
可以用`tag`指定`Throw` and `Catch`如何匹配。
如:

```mathematica
Module[{u},
 Catch[
  Throw[a, u],
  u]
 ]
```

***
`离散数学` guide/DiscreteMathematics

***
IO 文件操作

目录和目录操作 guide/DirectoriesAndDirectoryOperations

设定目录时候，可以用`NotebookDirectory[]` 输出目标路径，然后采用字符串模式匹配的方法，获取根目录，这样得到的目录可以不依赖文件的子目录位置，例如

```mathematica
git`root`dir=StringCases[NotebookDirectory[],
StartOfString~~((WordCharacter|":"|"\\")..)~~"octet.formfactor"][[1]]

Out[136]= "C:\\octet.formfactor"
```

+ `NotebookFileName[]` 笔记本路径详细
+ `NotebookDirectory[]`笔记本父目录
+ `DirectoryQ[]` 用来判断目录是否存在
+ `FileExistsQ[]` 判断文件是否存在 
+ `FileNameJoin[]` 路径连接
+ `FileNameSplit[]` 路径分割
+ `ExpandFileName[]` 展开为绝对路径
+ `FileNames[]` 列出指定目录下符合模式的文件

***
`流和文件`:  tutorial/FilesAndStreams

***
`图形结构` tutorial/TheStructureOfGraphics

给定一个图形基元列表后, Wolfram 语言提供了两种方式去修改最终的图形. 首先, 可以在图形基元列表中插入一些图形指令, 例如 `RGBColor`, 以修改随后列表中的图形基元. 用这种方式, 用户可以指定如何修改一个给定的图形基元列表.

通过插入图形指令, 可以指定图形基元的显示方式. 然而, 用户往往经常会希望通过全局修改来改变整个图形的显示. 使用图形选项可以达到这一目的.

通过增加图形选项 Frame 用户可以修改图形的整体外观.

`FullGraphics[g]` 将图形选项指定的对象转化为明确的图形基元列表

对 Axes 等图形选项, Wolfram 语言的前端会自动画出用户需要的坐标轴等对象. 这些对象由选项值表示, 而非被确定的图形基元列表表示. 然而, 用户会需要要找到代表这些对象的图形基元列表. 函数 FullGraphics 给出不使用任何选项的情况下, 生成图形的完整的图形基元列表.

```mathematica
Short[InputForm[FullGraphics[ListPlot[Table[EulerPhi[n], {n, 10}]]]],6]
```

***
`图例` Legended

`Legended` 是可以嵌套的

```mathematica
Legended[
 Legended[
  PieChart[{1, 2, 3, 4}],
  Placed[
   "aaaa",
   {{0.5, 0.5},
    {0, 0}}
   ]
  ],
 Placed[
  "aaaa",
  {{0.5, 0.51},
   {0, 0}}
  ]
 ]
```

***
盒子 Boxes

像Wolfram语言中的所有其他内容一样，笔记本最终是符号表达式。 `mma` 的高维结构是用 "Box" 来实现的。

参考：

guide/LowLevelNotebookStructure
tutorial/RepresentingTextualFormsByBoxes

***
`Box` 转换与自定义

`Box`有自己的语法，可以查看一个显示的表达式对应的`Box`表达式，也可以对后者再次排版。
也就是说笔记本中显示的二维格式,与 low-level 的 `Box` 之间，可以进行转换，基本的转换有：

+ `DisplayForm[expr]`:将`expr`中的 `low-level` 框符表示成显式的二维格式。
+ `ToBoxes[expr,form]`: 给出对应于特定`form`的`Box`。

`ToBoxes` 会计算`expr`，而`MakeBoxes`不计算`expr`

***
`Box` 自定义输出格式

一般很少需要修改这些规则。
主要原因是 `Wolfram` 语言已经为许多`operators`的输入和输出建立了内置规则，而该`operators`本身并未为其分配特定的含义。
也就是预置了很多可以用，但没有数学规则，只有排版规则的`operators`。

可以用来自定义输出的函数有：
`MakeBoxes`: 底层版本
`Format`: 上层版本

`mma` 在输出计算结果的时候，会使用`MakeBoxes`从表达式构建二维结构(`Box`).
`MakeBoxes`是Wolfram系统会话(`sessions`)中用于将表达式转换为`boxes`的`low-level`函数。
所以可以通过定义表达式的`MakeBoxes`上值来自定义输出。

另一方面，`MakeBoxes`也会使用通过`Format`添加的排版规则：

***
利用`MakeBoxes` 自定义输出格式:

```mathematica
gplus /: MakeBoxes[gplus[x_, y_, n_], StandardForm] :=  RowBox[{MakeBoxes[x, StandardForm], 
SubscriptBox["\[CirclePlus]", MakeBoxes[n, StandardForm]], 
MakeBoxes[y, StandardForm]}]
gplus[a, b, m + n]
```

***
利用`Format`自定义输出格式:

`Format[f[...]]:=rhs` 定义`f`的输出格式像是`rhs`.
`Format[expr,form]`:对特定`form`如`StandardForm`指定自定义格式。

```mathematica
Format[f[x_, y_, z__]] := f[x, ...]
```

`Format`的下值将被优先使用，然后才使用跟`MakeBoxes`相关的上值。
`MakeBoxes`可以理解成是`Format`的底层版本。
不过一个重要的区别是`MakeBoxes`不会计算它的参数，所以你可以只定义排版规则，而不必担心这些表达式将会被如何计算。

此外，`Format`会自动在计算结果上再次调用`Format`，而`MakeBoxes`不会。
所以你需要在需要排版的子表达式上,手动再次调用`MakeBoxes`。

当排版的时候，

`RawBoxes[boxes]`直接插入`boxes`到已有的`Box`结构中，不检查错误，由前端直接渲染。

***
辅助信息: `TagBox`

在不同排版格式之间转换的时候，参数信息可能会丢失。
此时可以使用`TagBox`,`TagBox`提供了一种在 Wolfram 语言`input`和`output`中存储隐藏信息的方法。
`TagBox[bbb,tag]`构建的`Box`和`bbb`一样，但可以包含额外信息`tag`。一般是函数的头部。

比如：

```mathematica
ToBoxes[InverseFunction[f], StandardForm]
out: TagBox[SuperscriptBox["f",   RowBox[{"(", RowBox[{"-", "1"}], ")"}]], InverseFunction,  Editable -> False]
```

此外，`InterpretationBox`提供了一种在Wolfram语言`output`中存储隐藏信息的方法。

`InterpretationBox[boxes,expr]`
是一个底层`box`构建，显示和`boxes`一样，但如果在输入中，被理解成`expr`

***
脚本中的原始字符格式

mathematica 的层次结构

```mathematica
guide/LowLevelNotebookStructure
tutorial/StringRepresentationOfBoxes
tutorial/RepresentingTextualFormsByBoxes
```

内核--前端,
`box`--笔记本,
字符串表示--框符
`\[name]`

最核心的概念是，一切皆是表达式，对于内核来说，它接受的全部是类 `LISP` 的表达式 语言。
就类似于纯字符界面的交互方式，只有 `LISP` 表达式，在这个层次上，考虑的是输入的编码问题。
往上，包括图形，二维化表示等等，这个层面上，出现 框符 的概念，
二维化框符的显示，带来了一批处理显示相关的表达式，它们是`mma`的排版层。
框符不仅有 `LISP` 表示，而且有字符串表示。

***
`框符的字符串表示` tutorial/StringRepresentationOfBoxes

区分原始框符和其代表的表达式. 

+ `\(input\)`  原始框符(即仅仅是一个二维化结构式)
+ `\!\(input\)`  框符的意义（二维化结构式的数学意义）

如果将一个 `StandardForm` 单元的内容复制到另一个如文本编辑器的程序中，
Wolfram 系统将在必要时生成一个 `\!\(...\)` 形式. 
这样做是为了当讲这个格式的内容重新复制回 Wolfram 系统中时，该 `StandardForm` 单元的原始内容会自动再次生成. 
如果没有 `\!`，则仅得到对应于这些内容的原始框符.

在选项的默认设置下，贴入 Wolfram 系统笔记本中的 `\!\(...\)` 格式自动显示成二维格式.

***
字符串中嵌入二维框件结构. 

+ `"\(input\)"`  一个原始字符串
+ `"\!\(input\)"`  含有框符的字符串

+ `\(box1,box2,...\)`  `RowBox[box1,box2,...]`
+ `box1\^box2`  SuperscriptBox[box1,box2]
+ `box1\_ box2`  SubscriptBox[box1,box2]
+ `box1\_box2\% box3`  SubsuperscriptBox[box1,box2,box3]
+ `box1\& box2`  OverscriptBox[box1,box2]
+ `box1\+box2`  UnderscriptBox[box1,box2]
+ `box1\+box2\% box3`  UnderoverscriptBox[box1,box2,box3]
+ `box1\/box2`  FractionBox[box1,box2]
+ `\@box`  SqrtBox[box]
+ `\@box1\%box2`  RadicalBox[box1,box2]
+ `` form\` box ``  FormBox[box,form]
+ `\*input`  构建来自 input 的框符

***
控制输入被解释的方式. 

+ `\!\(input\)`  解释当前形式中的输入
+ `` \!\(form\`input\) ``  使用指定形式解释输入

***
文本格式的框符表示

tutorial/RepresentingTextualFormsByBoxes

tutorial/FormattedOutput

Wolfram 语言中的所有文本和图形格式最终是用框符的嵌套集合来表示的. 
通常这些框符中的元素对应于要放在二维相对位置处的对象.

这里是对应于表达式 `a+b` 的框符：

```mathematica
In[1]:= ToBoxes[a+b]
Out[1]=  RowBox[{a,+,b}]
```

`DisplayForm` 表明这些框符是如何显示的：

```mathematica
In[2]:= DisplayForm[%]
Out[2]//DisplayForm=  a+b
```

`DisplayForm[boxes]` 表明 `boxes` 被显示的格式

***
一些基本的框符类型. 

+ `"text"`  原样的文本
+ `RowBox[{a,b,...}]`  一行框符或字符串 a,b,...
+ `GridBox[{{a1,b1,...},{a2,b2,...},...}]`   一个框符网 
+ `SubscriptBox[a,b]`  下标 
+ `SuperscriptBox[a,b]`  上标
+ `SubsuperscriptBox[a,b,c]`  上下标
+ `UnderscriptBox[a,b]`  底标
+ `OverscriptBox[a,b]`  顶标
+ `UnderoverscriptBox[a,b,c]`  顶底标
+ `FractionBox[a,b]`  分式 `a/b`
+ `SqrtBox[a]`  平方根 `Sqrt[a]`
+ `RadicalBox[a,b]`  `b` 次方根 `Power[a, (b)^-1]`

***
修改框符的外观. 

+ `StyleBox[boxes,options]`  按指定选项的设置显示 `boxes`
+ `StyleBox[boxes,"style"]`  按指定样式显示 `boxes`

***
控制框符的解释. 

+ `FormBox[boxes,form]`  用与指定格式有关的规则解释 `boxes`
+ `InterpretationBox[boxes,expr]`  将 `boxes` 当作表达式 `expr` 的表示形式
+ `TagBox[boxes,tag]`  用 `tag` 引导 `boxes` 的解释
+ `ErrorBox[boxes]`  指出错误并不再对 `boxes` 进行解释

***
`输入语法` tutorial/InputSyntax

各种输入表达式的特殊方式

`!command` 执行外部命令,只在命令行有效.

***
`算符优先级` tutorial/OperatorInputForms

可以具有内置定义的运算符

***
`无内置定义的算符`tutorial/OperatorsWithoutBuiltInMeanings

有几百个记号没有内部（`built-in`）定义，也就是没有和函数绑定。
可以用来构建自己的记号。如：

```mathematica
CirclePlus[x,y]
TildeTilde[x,y]
Therefore[x,y]
LeftRightArrow[x,y]
Del[x]
Square[x]
AngleBracket[x,y,...]
Subscript[x,y]
Superscript[x, y]
UnderBar[x]
SubPlus[x]
SubMinus[x]
SubStar[x]
SuperPlus[x]
SuperMinus[x]
SuperStar[x]
SuperDagger[x]
Overscript[x,y]
Underscript[x,y]
OverBar[x]
OverVector[x]
OverTilde[x]
OverHat[x]
OverDot[x]
UnderBar[x]
```

`Wolfram` 语言遵循一般约定，对于某个算符，和其有关的函数和这个算符的名字相同，例如：

函数是 `Congruent[x,y,...] `
符号的名字是：`\[Congruent]`

一般有对应关系如下：

+ `x \[name]  y` ->  `name[x, y]`
+ `\[name] x` -> `name[x]`
+ `\[Leftname] x,y,...` -> `\[Rightname]  name[x, y, ...]`

***
控制表达式计算流程: 各种 `Hold`

`Hold` 相关的分成两类，一类是函数 `Hold`，另一类是 属性 `Attribute`中的 `Hold`

函数类

`Hold`
属性： `HoldAll`
解封： `ReleaseHold`

使用 `UpValue`
展开`Sequence`
内部`Evaluate`有效
不移除`Unevaluated`
内部`Replace`有效

***
`HoldComplete`
属性： `HoldAllComplete`
解封： `ReleaseHold`

不使用 `UpValue`
不展开`Sequence`
内部`Evaluate`无效
不移除`Unevaluated`
内部`Replace`有效

***
`Evaluate`可以强行计算带有`HoldAll`，`HoldFirst`,`HoldRest`属性的参数，
`Unevaluated`保持表达式不计算，然后外层函数计算这个raw形式。

***
`HoldPattern[expr]`
用于模式匹配的时候，等价于`expr`，但是保持`expr`不计算
属性： `HoldAll`

还有一个更强的函数

`Verbatim`，不翻译模式比如`_`，只匹配字面值

`HoldForm`
输出形式的函数
属性： `HoldAll`
解封： `ReleaseHold`

***
`HoldXXX` 属性

+ `HoldFirst`：保持第一个参数不计算
+ `HoldRest`：保持第一个后面的参数不计算
+ `HoldAll`：保持所有参数不计算，但是展平 `Sequence`，使用`upvalue`
+ `HoldAllComplete`: 不得以任何方式修改或查看函数的所有参数。
不展开`Sequence`，不移除`Unevaluated`，不使用`UpValue`，内部`Evaluate`无效

***
快捷键

`Ctrl+Shift+B`，选中配对的括号

***
将定义与不同的符号相关联

在 Wolfram 语言中，`f[args]=rhs` 或 `f[args]:=rhs` 会将对象 `f` 和你的定义相关联. 也就是说，当输入 `?f` 时，就会显示该定义. 一般我们把符号 `f` 作为标头的表达式称为 `f` 的下值 (`downvalue`).

Wolfram 语言也支持上值 (upvalue)，上值可以把不直接作为标头的符号与定义相关联.

比如，在定义 `Exp[g[x_]]:=rhs` 中，一种可能是把定义与符号 `Exp` 相关联，认为它是 `Exp` 的下值. 但是从组织或效率的角度来看未必是最好的方式.

较好的方式是将 `Exp[g[x_]]:=rhs` 与 `g` 关联起来，即对应为 `g` 的上值.

```mathematica
f[args]:=rhs    定义 f 的下值
f[g[args],...]^:=rhs    定义 g 的上值
```

***
`plot` 采样奇技淫巧

默认特性

+ 在函数值变化较快的位置，使用更多的采样点：
+ 自动选择绘图范围：
+ 排除非实数的函数范围：
+ 函数中存在断点时断开曲线：
+ `plot`有`HoldAll`属性，一般是先代入具体的值，再计算`f(x)`，为了强迫先计算`f(x)`再代入具体的坐标，可以使用`Evaluate[f(x)]`

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

***
`$Assumptions` 假设

`$Assumptions` 的初始设置为 `True`.

+ 设置全局假定：`$Assumptions = a > 0`
+ 局部添加假定：`Assuming[b < 0, Refine[Sqrt[a^2 b^2]]]`
+ 局部改变假定：`Block[{$Assumptions = a < 0 && b < 0}, Refine[Sqrt[a^2 b^2]]]`
+ 取消全局假定：`$Assumptions = True`

***
`options`

`Options[f]`

`OptionsPattern`(选项模式)
`OptionValue`(选项值)

定义具有可选变量的函数
`tutorial/SettingUpFunctionsWithOptionalArguments`

`f[x_,k_:kdef]:=value`
第二个位置为可选变量，默认值为 `kdef` 的函数

默认值的模式，加上头部指定，以及函数的默认取值`_.`，一共有三种写法，以及简略写法：

+ `s:_`：模式记号为`s`.
+ `s:_h`:模式记号为`s`, 模式的头部为`h`.
+ `s : _ : v`: 模式记号为`s`，默认值为`v`.
+ `s : _.` : 模式记号为`s`,模式的默认值取函数此位置的全局默认值。
+ `s : _h : v`:模式记号为`s`，模式的头部为`h`,默认值为`v`.
+ 下面是对应的缩写
+ `s_`
+ `s_h`
+ `s_: v`
+ `s_.`
+ `s_h: v`

***
`Assumptions`(假设)

典型的缺省设置为`Assumptions:>$Assumptions`.

假设可以是方程、不等式或定义域指定，或者是这些内容的列表或逻辑组合.

***
积分

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

***
`底层的输入输出规则`:tutorial/LowLevelInputAndOutputRules

`MakeBoxes[expr,form]` 按指定格式构造代表 `expr` 的框符
`MakeExpression[boxes,form]` 构造与 `boxes` 对应的表达式

***
`Needs` and `Get`

属性和关系

```mathematica
Once[Get[package]] 类似于 Needs[package]：
Once[Get["EquationTrekker`"]]
```

***
`图形结构`: tutorial/TheStructureOfGraphics

基本思想是 Wolfram 语言用图形基元的集合表示所有图形.
图形基元包括代表图像基本元素的 `Point` (点), `Line` (线) 和 `Polygon` (多边形), 以及 `RGBColor` 和 `Thickness` 等指令.

在 Wolfram 语言中,  每个完整的图形块都用图形对象表示. 图形对象的种类很多, 分别对应于不同类型的图形. 每类图形对象都有确定的头部以表明它的类型.

+ `Graphics[list]` 生成二维图形
+ `Graphics3D[list]` 生成三维图形

***
`修改图形的局部和全局方式`

+ 图形指令  范例: `RGBColor`, `Thickness`
+ 图形选项  范例: `PlotRange`, `Ticks`, `AspectRatio`, `ViewPoint`

给定一个图形基元列表后, Wolfram 语言提供了两种方式去修改最终的图形. 首先, 可以在图形基元列表中插入一些图形指令, 例如 `RGBColor`, 以修改随后列表中的图形基元. 用这种方式, 用户可以指定如何修改一个给定的图形基元列表.

通过插入图形指令, 可以指定图形基元的显示方式.
`guide/GraphicsDirectives`
然而, 用户往往经常会希望通过全局修改来改变整个图形的显示. 使用图形选项可以达到这一目的.

通过增加图形选项 `Frame` 用户可以修改图形的整体外观.

`FullGraphics[g]` 将图形选项指定的对象转化为明确的图形基元列表

对 `Axes` 等图形选项, Wolfram 语言的前端会自动画出用户需要的坐标轴等对象. 这些对象由选项值表示, 而非被确定的图形基元列表表示. 然而, 用户会需要要找到代表这些对象的图形基元列表. 函数 `FullGraphics` 给出不使用任何选项的情况下, 生成图形的完整的图形基元列表.

```mathematica
Short[InputForm[FullGraphics[ListPlot[Table[EulerPhi[n], {n, 10}]]]],6]
```

***
`Grid` 玄学用法

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

使格子中的文本不换行, 指定`ItemSize->Full`.

***
`MapThread`,`level` 的区别

一般编程语言中的`Map/Reduce`在`mma`中相当于`Map`以及一系列函数，`Fold`以及一系列函数.

由于`mma`是`m[m,m,m,..]`的形式，其中`m=Head[Sequence]`，(可以无穷无尽地套娃)
所以除了函数作用到**一堆参数列表**上，还有反向操作，就是**一堆函数**作用到一个参数上，相应的函数为:

`Through[p[f,g][args]]`: `f,g`被组织在结构`p[]`中，`p`可以是列表，也可以是`Plus`，等等。

还有专门用来对头部作用的函数:`Operate`:`Operate[p,f[x,y]]`给出`p[f][x,y]`

```mathematica
In[2]:= MapThread[f, {{{a, b}, {c, d}}, {{u, v}, {s, t}}}]
Out[2]= {f[{a, b}, {u, v}], f[{c, d}, {s, t}]}
```

```mathematica
>In[3]:= MapThread[f, {{{a, b}, {c, d}}, {{u, v}, {s, t}}}, 2]
Out[3]= {{f[a, u], f[b, v]}, {f[c, s], f[d, t]}}
```

***
Thread

神器 `Thread`，线程

Thread可以理解成，自动对参数进行同样的处理，
如果是一元算符，则直接轮流作用一遍。
如果是多元算符，首先把参数列表对齐, 就是把参数中出现的单个元素扩充到和其他的一样长。

还有神奇的自动过滤选项,

`Thread[f[args],h,n] `
threads **f** over objects with head **h** that appear in the first **n** args.

***
`Thread` 和 `MapThread` 的区别

MapThread works like Thread, but takes the function and arguments separately:

```mathematica
In[1]:= MapThread[f,{{a,b,c},{x,y,z}}]
Out[1]= {f[a,x],f[b,y],f[c,z]}
```

***
`上设置延迟` ref/UpSetDelayed

把 `rhs` 赋为 `lhs` 的延迟值，并将这种赋值和在 lhs 中层 1 出现的符号相关联.

***
上值 下值 tutorial/AssociatingDefinitionsWithDifferentSymbols
值集的操作, 上值 下值: tutorial/ManipulatingValueLists
表达式的计算 tutorial/EvaluationOfExpressionsOverview
标准计算流程 tutorial/TheStandardEvaluationProcedure
计算 非标准计算 tutorial/Evaluation

***
算符 tutorial/Operators

***
`重画和组合图形` tutorial/RedrawingAndCombiningPlots

`Wolfram` 语言的所有图形都是表达式，其操控方式与其它表达式相同. 这些操控不要求使用 Show.

***
基本几何区域 guide/GeometricSpecialRegions

***
不显示out in cell label`

SetOptions[EvaluationNotebook[], ShowCellLabel -> False];

***
`Optional`:默认选值

`Optional[s_h]`  表示可以忽略的函数，但如果是当前函数，必须有头部 `h`. 这种情况下没有任何更简单的句法形式.

***
`可选变量与默认变量` tutorial/OptionalAndDefaultArguments

***
取表达式的一部分 tutorial/PartsOfExpressions

***
将多个函数应用到同一个变量 `Through`

***
属性 tutorial/Attributes
操作 Operate

***
函数列表（按字母顺序排列）guide/AlphabeticalListing

***
`稀疏数组`：线性代数 tutorial/SparseArrays-LinearAlgebra
`求解线性系统`: tutorial/SolvingLinearSystems

***
`函数的上值和下值` tutorial/AssociatingDefinitionsWithDifferentSymbols

***
`参数序列`: Sequence[]

***
`常用记号和表示惯例`: tutorial/SomeGeneralNotationsAndConventions
`通过名称操作符号和内容`: tutorial/ManipulatingSymbolsAndContextsByName

***
`交叉连接`JoinAcross

ref/JoinAcross
tutorial/LevelsInExpressions
tutorial/Introduction-Patterns

***
`可选变量与默认变量`:ref/$SummaryBoxDataSizeLimit

***
`摘要框`: SummaryBoxDataSizeLimit

***
`张量对称性`: tutorial/TensorSymmetries

***
`下标索引`: ref/Indexed

***
`构造变量的具有索引的集合`

v = ToExpression["x" <> ToString[#]] & /@ Range[5]

***
`曲线拟合` 
tutorial/CurveFitting
ref/MapThread

***
`在计算过程中收集表达式`: Sow Reap

tutorial/CollectingExpressionsDuringEvaluation

***
`数值运算`: tutorial/NumericalCalculations

***
`绘图工具`:tutorial/InteractiveGraphicsPalette

***
`DeleteCases`: 当应用于 `Association` 上时，`DeleteCases` 根据它们的值删除元素.

***
`#name`: `#name` 是 #["name"] 的简短形式：

```mathematica
In[1]:= #x &[<|"x" -> a, "y" -> b|>]
Out[1]= a
```

***
`NestList`: 嵌套列表, ref/NestList

***
颜色,  `guide/Colors`

结合新的可编程的符号颜色和精心选择的美学颜色参数，Wolfram 语言在图形和其它形式的显示方面，采用更灵活、更引人注目的方案来设置色彩和透明度.

***
`输出的样式和字体`: tutorial/StylesAndFontsInOutput

***
`格式化输出`: tutorial/FormattedOutput#218124152

我们首先了解一下与显示大量表达式相关的框符生成器，然后再介绍几种超出了简单数学排版的方式，这些方式能用于生成漂亮的格式化输出.

***
`自定义图表和图形`: howto/CustomizePlotsAndGraphics

***
`图形和声音`: tutorial/GraphicsAndSoundOverview

***
`算子运算，即泛函`:ref/Operate

***
恢复被 FeynCalc 更改默认输出格式: 

```mathematica
SetOptions[EvaluationNotebook[],  CommonDefaultFormatTypes -> {"Output" -> StandardForm}]
```

***
`ctrl+space`跳出子表达式

***
`求和`: Sum, ref/Sum

***
`符号张量`: guide/SymbolicTensors

张量是线性计算的基本工具，它把向量和矩阵推广到更高的阶数. 
Mathematica 9 引入强大的方法来以代数方法操作任意阶数的对称张量. 它同时处理以分量数组给出的张量和特定张量域的成员给出的符号张量.

***
`函数组合和操作符表单`: guide/FunctionCompositionAndOperatorForms

Wolfram语言的符号结构使得可以以符号式合并和操作的"操作符"的创建变得轻松形成操作的"管道"并且应用到参数. 某些内置函数也直接支持一个"令行禁止"的条件表单，它们在其中可以直接作为符号操作符给出.

***
`上下文`: tutorial/Contexts

总是给变量或者定义选用尽可能清楚的名称是一个好思想. 但这样做有时会导致变量名很长.
在 Wolfram 语言中，可以用上下文来组织符合名. 在引入与其它符号不冲突的变量名的 Wolfram 语言程序包中上下文特别有用. 在编写或者调用 Wolfram 语言程序包时，就需要了解上下文.
其基本的思想是任何符号的全名为两部分：上下文和短名. 全名被写为 ``context`short``，其中 ` 是倒引号或重音符字符（ ASCII 二进制代码 96），在 Wolfram 语言中称为上下文标记.

***
`计算用的时间约束`:TimeConstrained

ref/TimeConstrained

`TimeConstrained[expr,t,failexpr]`如果没有达到时间限制，返回 `failexpr`.

***
`特殊函数`: tutorial/SpecialFunctions

Wolfram 系统包括了标准手册中所有的数学物理中常见的特殊函数. 下面将依次讨论各类函数.

***
`有理函数`: guide/RationalFunctions

Wolfram 语言可以有效地处理单变量和多变量的有理函数，通过内置函数直接执行标准的代数变换.

***
以任一个变量为主组合表达式

```mathematica
FactorTerms[expr,x]
Collect[expr,x]
```

对于含有一个变量的表达式，可以选择用项的和或者乘积等来表示. 而对于含有多个变量的表达式，则有更多的可供选择的形式，例如，以任一个变量为主组合表达式.

***
`以不同形式表示表达式`:tutorial/PuttingExpressionsIntoDifferentForms

***
`假设 前提条件 变量约束`:Assumptions

`Simplify` 中的选项 `Assumptions` 可以使用诸如 `Assumptions -> {m > 0, \[Mu] > 0, Di > 0}]` 的规则列表

***
`列表`: 
tutorial/ListsOverview
tutorial/CollectingObjectsTogether

"函数作用于表达式的部分项" 和 "结构的操作" 将介绍如何用 Map 和 Thread 使一个函数分别地作用于列表的每个元素.

***
`生成列表`: 生成长度为`n`、元素为 `f[i]` 的列表, ref/Array

***
Apply (@@)(应用)

ref/Apply

Apply[f,expr]
或 f@@expr  用 f 替换 expr 的头部.

***
连接列表:

`Join[list1,list2]`
把列表或其它享有相同头部的表达式连接在一起.

***
`Replace` 指定层数

`Replace[f[f[f[f[x]]]], f[x_] :> g[x], {0, 2}]`，后面可以选`All`，全部替换

Repeated [ expr_, {5} ]   or Repeated [ expr, {min,max} ]

可以具体制定重复的次数，精确的！

***
`读写 Wolfram 系统的文件`: tutorial/ReadingAndWritingWolframSystemFiles

***
`Timing`: 表达式计算用的时间

Timing[f = Fourier[RandomReal[1, 2^16]];]

***
`Part` :  ref/Part

***
倒引号`` ` ``: 数字标记/记号

***
Array

$$\text{Array}\left[f,\left\{n_1,n_2,\text{Null}\right\},\left(
\begin{array}{cc}
a_1 & b_1 \\
a_2 & b_2 \\
\end{array}
\right)\right]$$

***
`控制大表达式的显示`:  tutorial/ControllingTheDisplayOfLargeExpressions

***
`将求和换成列表`: tev3 = tev2 /. Plus -> List;

***
`Reap`收割, 收获

`Reap[expr]`
给出表达式 expr 的值，以及在计算中已经应用 `Sow` 的所有表达式. 使用 `Sow[e]` 或具有不同标记的 `Sow[e,Subscript[tag, i]]` "散布"的表达式在不同列表中给出.

***
`产生 C 和 Fortran 表达式`: tutorial/GeneratingCAndFortranExpressions

***
图形结构

基本思想是 Wolfram 语言用图形基元的集合表示所有图形.
图形基元包括代表图像基本元素的 `Point` (点), `Line` (线) 和 `Polygon` (多边形), 以及 `RGBColor` 和 `Thickness` 等指令.

`InputForm` 告诉 Wolfram 语言如何表示图形.
每个点被表示为一个 `Point` 图形基元的坐标形式.

在 Wolfram 语言中,  每个完整的图形块都用图形对象表示. 图形对象的种类很多, 分别对应于不同类型的图形. 每类图形对象都有确定的头部以表明它的类型.

+ `Graphics[list]` 生成二维图形
+ `Graphics3D[list]` 生成三维图形

Plot 和 ListPlot 等在 "图形和声音的结构" 中讨论的函数都是按照先建立 Wolfram 语言内部图形对象, 然后显示它们的顺序工作的.

在 Wolfram 语言中, 用户可以自行建立图形对象产生其它类型的图像. 由于在 Wolfram 语言中的图形对象是符号表达式, 所以能用所有的 Wolfram 语言标准函数对其进行操作.

***
`修改图形的局部和全局方式`

给定一个图形基元列表后, Wolfram 语言提供了两种方式去修改最终的图形. 首先, 可以在图形基元列表中插入一些图形指令, 例如 RGBColor, 以修改随后列表中的图形基元. 用这种方式, 用户可以指定如何修改一个给定的图形基元列表.

通过插入图形指令, 可以指定图形基元的显示方式. 然而, 用户往往经常会希望通过全局修改来改变整个图形的显示. 使用图形选项可以达到这一目的.

通过增加图形选项 Frame 用户可以修改图形的整体外观：

```mathematica
Show[%, Frame -> True]
```

***
`确定图形块的完全形式`

对 `Axes` 等图形选项, Wolfram 语言的前端会自动画出用户需要的坐标轴等对象. 这些对象由选项值表示, 而非被确定的图形基元列表表示. 然而, 用户会需要要找到代表这些对象的图形基元列表. 函数 `FullGraphics` 给出不使用任何选项的情况下, 生成图形的完整的图形基元列表.

***
`UpSetDelayed` 
`:=`
`=`
`^:=`

`Delayed` and 不带 `Delayed` 的最重要区别就是，定义时计算，还是调用的时候计算。
也就是不带 `Delayed` 容易受到全局变量的影响，带 `Delayed` 更加接近函数式编程

`上值`:`UpValue`

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

***
`调试不完全数组`

如果一个数组，用Dimension 测试的结果是不完全数组，
如何找出是哪里的结构不完全呢。
可以把数组中的每一项都替换成$1$再显示，这样可以比较方便的看出来。

***
`transpose 参数确定方法`

写下数组的维数，比如`{6，8，3}`
在下面标出 转置后想得到的数组维数目次序，
比如`{3，1，2}`,

则transpose参数设置即是`{3，1，2}`

***
`可选变量与默认变量`

总之，默认变量用`x_:v`，可选变量用`p|PatternSequence[]`
有时需要定义具有默认值的函数. 即省略某些变量时，其值就用设定的默认值代替. 模式 `x_:v` 就表示省略时值为 `v` 表示的变量.
一些 Wolfram 语言常用函数的变量具有系统设定的默认值，此时不能明确给出 `x_:v` 中的默认值，而是可用 `x_.` 来使用其系统设定的默认值.
有时不对一个可选变量分配默认值是方便的；这样的变量可以使用 `PatternSequence[]` 来指定.

`p|PatternSequence[]` 不具有默认值的可选模式 `p`

***
`内嵌单元`: 在文本中插入公式的话，用插入-排版-内嵌单元 选项

***
`Flatten` : 如果 $m_{ij}$ 为矩阵，
Flatten[{{ $m_{11}$, $m_{12}$}, {$m_{21}$, $m_{22}$ }},{{1,3},{2,4}}]
实际上建立了由块 $m_{ij}$ 组成的单个矩阵.

本来的矩阵，实际上有`4`个指标`ijkl`
`{{1,3},{2,4}}` 的意思是，把第一个和第三个指标放在一起，把第二个和第四个指标放在一起。

也就是说 Flatten 实际上是 矩阵索引 重新划分函数。
对于一个矩阵，有`n`个索引（指标）(`a1,a2,...,an`)。
总的元素个数是 `a1* a2*...*an`
可以重新组合这些指标，例如把`a1, a2` 并入一个指标中，
指标的取值范围变成`1,2,...,a_1*a_2`

类似的，矩阵的各种指标可以随意交换，
`a1* a2* a3* a4` to `a3* a2* a1* a4`，这就是广义转置的过程。
广义转置再加上重新划分（指标的重新组合），这就是Flatten的作用。

类似的操作还有

***
`数组展平`

`ArrayFlatten[a,r]` is normally equivalent to `Flatten[a,{{1,r+1},{2,r+2},...,{r,2r}}]`
相当于`Flatten`的简化版

***
`把数组重塑成指定维数的数组`: `ArrayReshape[list,dims] `

```mathematica
In[1]:= ArrayReshape[{a,b,c,d,e,f},{2,3}]
Out[1]= {{a,b,c},{d,e,f}}
```

***
`多行排列`:`Multicolumn[list,cols]`

是一个对象，其格式为将列表的元素排列在具有指定列数的网格中

***
图例中的布局函数一定要加一个括号，如果使用匿名函数的话，例如：
`SwatchLegend[63, Range[5], LegendLayout -> (Multicolumn[***
, 1] &)]`

***
`通过内核操作笔记本` tutorial/ManipulatingNotebooksFromTheKernel

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

***
`通过内核移动笔记本`

在任何打开的笔记本中，前端总是保持当前的选择，这个选择由一个单元中的文本区域组成，或者是由这个单元组成. 
通常这个选择在屏幕上是由一个高亮度形式表明. 这个选择也可以在文本的两个字符之间，或者在两个单元之间，这时它在屏幕上由两个竖直或水平的插入杠来表明.

***
`查找笔记本的内容`

将当前选择移到前一个词 `cell` 出现的位置：

```mathematica
NotebookFind[nb,"cell",Previous]
```

***
为整个笔记本和当前选择寻找和设置选项.

+ `Options[obj,option]`  找出完整笔记本的一个选项值
+ `Options[NotebookSelection[obj],option]`  找出当前选择的值
+ `SetOptions[obj,option->value]` 设置完整的笔记本的一个选项值
+ `SetOptions[NotebookSelection[obj],option->value]`  设置当前选择的值

***
以整个笔记本为对象的操作:

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

***
通过内核操作前端

+ `$FrontEnd`  当前使用的前端
+ `Options[$FrontEnd,option]`  前端全局选项的设置
+ `AbsoluteOptions[$FrontEnd,option]`  选项的绝对设置
+ `SetOptions[$FrontEnd,option->value]`  在前端重设选项
+ `CurrentValue[$FrontEnd, option]`  返回选项值，当用于赋值的左边时，允许设置选项.

在前端操作全局选项.

***
`前端令牌`

通过前端令牌，用户可以执行通常情况下使用菜单才能实现的内核命令.
前端令牌对于编写操作笔记本的程序特别方便.

FrontEndToken 是一个内核命令，它确定其变量为前端令牌.
`FrontEndExecute` 是一个将其变量发送到前端来执行的内核命令.
例如，下面命令创建一个新的笔记本.

```mathematica
FrontEndExecute[FrontEndToken["New"]]
```

***
`在前端直接执行笔记本指令`

在执行 `NotebookWrite[obj,data]` 等指令时，向笔记本中插入数据的实际操作是在前端进行的. 但为了估算原来的指令和构造送向前端的适当请求，还是要使用内核的. 不过，前端可以直接执行一定量的指令，而不需涉及内核.
***
区分指令的内核和前端版本.

+ `NotebookWrite[obj,data]` 在内核执行的 `NotebookWrite` 版本指令
+ `FrontEnd`NotebookWrite[obj,data]` 在前端直接执行的 `NotebookWrite` 版本指令

Wolfram 语言区分在内核执行的指令和前端直接执行的指令的基本方式是使用上下文.
内核指令通常在 ``System` `` 上下文中，而前端指令通常在 ``FrontEnd` `` 上下文中.

`FrontEndExecute[expr]` 把 `expr` 发送到前端执行

把表达式发送到前端执行.

在书写操纵笔记本的精细复杂的程序时，这些程序必须在内核执行但对于通过简单按钮所进行的运算，可以在前端直接执行所需要的所有指令，甚至不需要运行内核.

***
`单元结构`:

对应于单元的表达式.

+ `Cell[contents,"style"]`  有特殊风格的单元
+ `Cell[contents,"style1","style2`  有多个风格的单元
+ `Cell[contents,"style",options]`  有额外选项设置的单元

Wolfram 系统实际上用`样式定义单元`来定义样式. 这些单元可以放在另外的样式定义笔记本中，也可以包含在一个笔记本的选项中. 不论哪一种情形，都可以在标准笔记本前端中用 `编辑样式表` 菜单项访问它们.

***
`单元选项`

Wolfram 语言提供了大量的单元选项，这些选项都可以在前端中通过 选项设置 菜单项访问.
它们可以在单个单元层上直接设置，也可以在高层设置而让单个单元去继承.

***
`计算选项`

| 选项 | 典型默认值 | explanation |
|----|----|----|
| Evaluator | "Local" | 用于计算的内核名 |
| Evaluatable | False | 单元内容是否被计算
| CellAutoOverwrite | False | 产生新输出时是否覆盖以前的输出 |
| GeneratedCell | False | 该单元是否从内核产生 |
| InitializationCell |  False | 打开笔记本时是否自动计算该单元 |

Wolfram 语言可以对笔记本中的每个单元指定不同的计算方式.
但是常常是在笔记本层设置选项 Evaluator，这一般是用前端中的 内核配置选项 菜单项完成.

***
`文本和字体选项`

***
`表达式输入和输出选项`

Wolfram 语言中常用特殊字符有许多别名.
`InputAliases` 可以给更多的特殊字符或其它类型的 Wolfram 语言输入定义别名. 形如 `"name"->expr` 的规则决定 `Esc name Esc` 应该在输入时立即被 expr 替换.

`别名`用明确的 `Esc` 字符定界. 选项 `InputAutoReplacements` 指定一些类型的输入序列即使设有明显的定界符也应该被立即替代. 例如，在默认设置下，`->` 立即被 `->` 替换. 可以用形如 `"seq"->"rhs"` 的规则去指定输入中出现的 `seq` 立即用 `rhs` 替换.

***
`笔记本选项`

改变笔记本选项的方式.

+ `\[FilledSmallSquare]` 用选项设置菜单交互式的改变选项.
+ `\[FilledSmallSquare]` 使用内核的 `SetOptions[obj,options]`.
+ `\[FilledSmallSquare]` 用 `CreateWindow[options]` 产生具有指定选项的新笔记本.

这里创建一个笔记本，并显示在具有细框的 `400x300` 窗口中：

```mathematica
CreateWindow[WindowFrame -> "ThinFrame", WindowSize -> {400, 300}]
```

***
`前端的全局选项`

在标准笔记本前端中，可以设置许多 Wolfram 系统全局选项.
默认情况下，这些选项的值保存在一个"偏好文件"中，当重新运行 Wolfram 系统时就自动再次使用.
这些选项包含可以用偏好设置对话框生成的设置.

***
`前端全局选项的一些类型`

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

***
`框符的字符串表示`

Wolfram 语言提供了一种简洁的方式来用字符串表示框符. 在将框符的设定作为普通文本进行导入和导出时，这种方式尤其方便.

***
`区分原始框符和其代表的表达式`

+ `\(input\)` 原始框符
+ `\!\(input\)` 框符的意义

如果将一个 StandardForm 单元的内容复制到另一个如文本编辑器的程序中，
Wolfram 系统将在必要时生成一个`\!\(...\)`形式. 这样做是为了当讲这个格式的内容重新复制回 Wolfram 系统中时，该 StandardForm 单元的原始内容会自动再次生成.
如果没有 `\!`，则仅得到对应于这些内容的原始框符.

在选项的默认设置下，贴入 Wolfram 系统笔记本中的 `\!\(...\)` 格式自动显示成二维格式.

***
`字符串中嵌入二维框件结构`

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

***
`模块化和事物的命名`: tutorial/ModulesAndLocalVariables

***
`Wolfram 系统的结构`: tutorial/RunningTheWolframSystemOverview

Wolfram 系统是一个模块化的软件系统，其执行运算的内核与处理用户交互的前端是互相分离的. Wolfram 系统的基本部分:

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

***
`使用命令行界面`

在某些情况，您不需要使用笔记本前端，而需要更直接的与 Wolfram 语言内核交互，
为此，您可以使用基于文本的界面，您键入键盘的文本会直接进入内核.
值得注意的是，虽然文本界面可以使用 Wolfram 语言内核的大部分功能，但是不具备图形功能和与 Wolfram 语言前端动态交互的能力.

启动 Wolfram 语言内核 in `windows`: `wolframscript.exe`

***
`Wolfram 系统会话`

在每一个阶段，Wolfram 系统将给出提示 `In[n]:=` 告诉您，它准备接受输入.
然后，您可以敲入输入，并以 `Enter` 或 `Return` 结束输入.

请注意您无需键入提示 `In[n]:=`，只需键入提示后的文本.

当您敲入输入，Wolfram 系统将处理并产生结果，输出结果时将其标记为`Out[n]=`.

***
`编辑输入的默认键`

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

***
`启用原始的基于文本的界面`

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

***
终止内核: `Quit[]`

在输入提示符下输入 `Quit[]` 退出 Wolfram 系统.
您也可以敲入`Ctrl+D` 或 `Ctrl+Z` 退出 Wolfram 系统，
如果输入行为空，`Ctrl+D` 将终止 Wolfram 系统.

`Ctrl+D`, `Ctrl+Z` 或`Quit[]` 退出 Wolfram 系统

***
`Wolfram 系统会话`

reference: guide/WolframSystemSessions
reference: tutorial/RunningTheWolframSystemOverview

***
mathematica 中的前端概念:

Wolfram 系统的组件
Kernel（内核）- 核心计算引擎
Front end（前端）-笔记本界面系统

***
`执行计算`

`shift+enter` 计算输入
`ctrl+shift+enter`  在当前位置计算选择表达式
`expr;`   计算表达式，但不输出结果
(= 在输入的开始部分) 使用自由格式语言输入

***
会话历史

`%n`  第n个输出表达式
`ctrl+l` 复制一个输入单元

***
消息

`Off` 关掉一个消息或一群消息
`Quiet` "安静"的运行一次计算，不输出消息

***
会话信息

+ `Directory` 当前目录
+ `Names`  已知符号的名称
+ `Notebooks `
+ `MemoryInUse`
+ `SystemInformation`
+ `DateString`

***
`定制会话`

`$Post` 后处理,是一个全局变量，如果设置，它的值应用到每个输出表达式.
`$Path` 默认路径,给出在试图找到一个外部文件时搜索的缺省目录列表.

***
使用文本界面 tutorial/UsingATextBasedInterface

***
`计划任务`

NotebookEvaluate: 计算 `notebook`  中所有可计算单元

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

***
`对话`: tutorial/Dialogs

在标准交互式进程中，可以用 `Wolfram` 语言命令 `Dialog` 去建立一个**子进程**或者**对话.** 在进行计算的过程中，可以用对话与 `Wolfram` 语言相互作用. 
像 "计算的跟踪" 中提到的一样, `TraceDialog` 在一个表达式计算的过程中的指定点自动调用 `Dialog`. 另外，在计算过程中要中断 `Wolfram` 语言时，一般用对话检查它的状态.

***
启动对话和从对话返回.

+`Dialog[]` 启动 `Wolfram` 语言对话
+`Dialog[expr]` 启动对话，将 `expr` 作为 `%` 的当前值
+`Return[]` 从对话返回，取 `%` 的当前值作为返回值
+`Return[expr]` 从对话返回，取 `expr` 作为返回值
