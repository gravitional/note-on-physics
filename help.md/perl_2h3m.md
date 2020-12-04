# perl

[Learn Perl in about 2 hours 30 minutes ](https://qntm.org/perl_en)

Practical Extraction and Report Language

Perl是一种动态的,动态类型的,高级脚本（解释）语言,类似于PHP和Python。
Perl的语法在很大程度上归功于古老的Shell脚本,并且因过度使用混乱的符号而闻名,大多数都无法Google 到。
Perl的shell脚本继承使其非常适合编写 glue 代码：将其他脚本和程序链接在一起的脚本。
Perl非常适合处理文本数据并生成更多文本数据。
Perl广泛,流行,高度可移植并且得到了良好的支持。
Perl的设计理念是 '条条大道通罗马'（TMTOWTDI）（与Python相比,'应该有一种,或者只有一种更好的方法'）。

Perl令人恐惧,但它也具有一些很棒的补偿功能。在这方面,它就像过去创造的所有其他编程语言一样。

本文档旨在提供信息,而不是福音。它针对像我这样的人：

+ 不喜欢[http://perl.org/](http://perl.org/)上的Perl官方文档,因为它技术性很强,并且对不常见的边缘情况讲的太多
+ 通过`公理和示例`快速学习新的编程语言
+ 希望 Larry Wall 能讲到重点
+ 已经知道编程大概是什么
+ 除了完成工作所必需的之外,不太关心Perl

本文档旨在尽可能短,但不要更短。

初步说明

关于本文档中几乎每条陈述,都要附上：`严格来说,这不是正确的；情况实际上要复杂得多`。
在整个文档中,我使用示例打印语句输出数据,但未明确附加换行符。这样做是为了防止我发疯,并更加关注每种情况下要打印的实际字符串,这总是更加重要。
在许多示例中,如果代码在现实中运行,则会导致大量的单词挤在一行中。尝试忽略这一点。

## hello world

Perl 脚本的后缀名为`.pl`,`helloworld.pl`的全文是：

```perl
use strict;
use warnings;

print "Hello world";
```

Perl脚本由解释器`perl`或`perl.exe`解释：

```perl
perl helloworld.pl [arg0 [arg1 [arg2 ...]]]
```

一些即时笔记。 Perl的语法是高度自由的。
避免它们的方法是在每个Perl脚本或模块的最顶部加上 `use strict; use warnings;` 。
`use foo;`这种形式称为`pragmas`。 它们是给perl.exe的信号,在程序开始运行之前执行初始语法验证时生效。 当解释器在运行时遇到它们时,这些行不起作用。
分号`;`是语句终止符。 符号`＃`开始注释。 注释一直持续到该行的末尾。 Perl没有块注释语法。

## 变量

Perl变量分为三种类型： `scalar`, `arrays` and `hashes`。
每种类型都有自己的标志：分别为`$`,`@`和`％`。
变量使用`my`声明,并一直保留到`scope`中,直到块封闭或文件结束。

### scalar variable

标量变量可以包含：

+ `undef` （对应于Python中的`None`,PHP中的`null`）
+ 一个数字（`Perl`不区分整数和浮点数）
+ 一个字符串
+ 对任何其他变量的引用。

```perl
my $undef = undef;
print $undef; # prints the empty string "" and raises a warning

# implicit undef:
my $undef2;
print $undef2; # prints "" and raises exactly the same warning

my $num = 4040.5;
print $num; # "4040.5"

my $string = "world";
print $string; # "world"
```

使用`.`做字符串连接（与`PHP`相同）：

```perl
print "Hello ".$string; # "Hello world"
```

### booleans

`Perl`没有布尔数据类型。如果且仅当它是以下之一时,`if`语句中的标量求值为布尔值 `false`：

+ `undef`
+ `number 0`
+ `string ""`
+ `string "0"`

Perl文档反复声明函数在某些情况下返回`true`或` false`值。
实际上,当一个函数声称返回` true`时,通常返回`1`,而当一个函数声称返回`false`时,通常返回空字符串`""`。

### Weak typing

无法确定标量包含`数字`还是`字符串`。更确切地说,永远不需要这样做。
标量的行为像数字还是字符串取决于使用它的运算符。当用作字符串时,标量的行为类似于字符串。当用作数字时,标量的行为将类似于数字（如果不可能,则发出警告）：

```perl
my $str1 = "4G";
my $str2 = "4H";

print $str1 .  $str2; # "4G4H"
print $str1 +  $str2; # "8" with two warnings
print $str1 eq $str2; # "" (empty string, i.e. false)
print $str1 == $str2; # "1" with two warnings

# The classic error
print "yes" == "no"; # "1" with two warnings; both values evaluate to 0 when used as numbers
```

须知是使用正确的运算符。将标量作为数字比较,与作为字符比较,有各自的运算符：

```perl
# Numerical operators:  <,  >, <=, >=, ==, !=, <=>, +, *
# String operators:    lt, gt, le, ge, eq, ne, cmp, ., x
```

### array 变量

数组变量是由从`0`开始的整数索引的标量的列表。在Python中,这称为`list`,在PHP中,其称为`array`。使用带括号的标量列表声明数组：

```perl
my @array = (
    "print",
    "these",
    "strings",
    "out",
    "for",
    "me", # trailing comma is okay
);
```

您必须使用`$`符号来访问数组中的值,因为要检索的值不是数组,而是标量：

```perl
print $array[0]; # "print"
print $array[1]; # "these"
print $array[2]; # "strings"
print $array[3]; # "out"
print $array[4]; # "for"
print $array[5]; # "me"
print $array[6]; # returns undef, prints "" and raises a warning
```

您可以使用负数索引从尾部开始打印：

```perl
print $array[-1]; # "me"
print $array[-2]; # "for"
print $array[-3]; # "out"
print $array[-4]; # "strings"
print $array[-5]; # "these"
print $array[-6]; # "print"
print $array[-7]; # returns undef, prints "" and raises a warning
```

标量`$var`和包含标量`$var [0]`的数组`@var`之间没有冲突。但是,可能会使读者感到困惑,因此请避免这种情况。

获取数组的长度：

```perl
print "This array has ".(scalar @array)."elements"; # "This array has 6 elements"
print "The last populated index is ".$#array;       # "The last populated index is 5"
```

调用`Perl`脚本的参数存储在内置数组变量`@ARGV`中。

变量可以插入到字符串中：

```perl
print "Hello $string"; # "Hello world"
print "@array";        # "print these strings out for me"
```

注意,有时候你会需要将某人的电子邮件地址放入字符串` jeff@gmail.com`中。
这将导致`Perl`查找名为`@gmail`的数组变量以插值到字符串中,但找不到它,从而导致运行时错误。
可以通过两种方式来防止插值：通过反斜杠`\`对符号进行转义,或使用单引号而不是双引号。

```perl
print "Hello \$string"; # "Hello $string"
print 'Hello $string';  # "Hello $string"
print "\@array";        # "@array"
print '@array';         # "@array"
```

### Hash变量

哈希变量是由字符串索引的标量的列表。在Python中,这被称为`dictionary`,而在PHP中,其被称为`array`。

```perl
my %scientists = (
    "Newton"   => "Isaac",
    "Einstein" => "Albert",
    "Darwin"   => "Charles",
);
```

请注意,此声明与数组声明有多相似。实际上,双箭头符号`=>`被称为`fat comma`,因为它只是逗号分隔符的同义词。
使用具有偶数个元素的列表声明`hash`,其中偶数个元素(`0,2,...`)全部被当成字符串。

同样,你必须使用`$`符号从哈希中访问值,因为要检索出的值不是哈希,而是标量：

```perl
print $scientists{"Newton"};   # "Isaac"
print $scientists{"Einstein"}; # "Albert"
print $scientists{"Darwin"};   # "Charles"
print $scientists{"Dyson"};    # returns undef, prints "" and raises a warning
```

请注意此处使用的括号。同样,标量`$var`和包含标量条目`$var {foo`}`的哈希`％var`之间没有冲突。

你可以将哈希直接转换为具有两倍条目的数组,元素在键和值之间进行交替（逆过程也很容易）：

`my @scientists = %scientists;`

但是与数组不同,哈希键没有基础顺序。它们将返回更有效率的顺序。因此,请注意在结果数组中顺序的重新排列,它们之保持成对：

```perl
print "@scientists"; # something like "Einstein Albert Darwin Charles Newton Isaac"
```

回顾一下,您必须使用方括号从数组中检索值,但必须使用花括号从哈希中检索值。
方括号实际上是数字运算符,而花括号实际上是字符串运算符。提供的索引是数字或字符串这一事实绝对没有意义：

```perl
my $data = "orange";
my @data = ("purple");
my %data = ( "0" => "blue");

print $data;      # "orange"
print $data[0];   # "purple"
print $data["0"]; # "purple"
print $data{0};   # "blue"
print $data{"0"}; # "blue"
```

### lists

Perl中的`列表`不同于`数组`或`哈希`。你刚刚看到了几个`lists`：

```perl
(
    "print",
    "these",
    "strings",
    "out",
    "for",
    "me",
)
```

```perl
(
    "Newton"   => "Isaac",
    "Einstein" => "Albert",
    "Darwin"   => "Charles",
)
```

列表不是变量。列表是一个临时(ephemeral)`vale`,可以分配给数组或哈希变量。这就是为什么声明数组和哈希变量的语法相同的原因。
在许多情况下,术语`list`和`array`可以互换使用,但是在很多情况下,列表和数组的行为不同,令人感到混乱。

`请记住,`=>`只是伪装的`,`然后看这个例子：

```perl
("one", 1, "three", 3, "five", 5)
("one" => 1, "three" => 3, "five" => 5)
```

`=>`提示了列表之一是数组声明,而另一个是哈希声明。
但是就它们自己而言,它们都不是任何东西的声明。它们只是`lists`, identical lists：

```perl
()
```

这里甚至没有提示。
该列表可用于声明一个空数组或一个空哈希,并且`perl`解释器显然无法区分。
一旦了解了Perl这个奇怪的方面,你就理解了为什么：列表值不能嵌套。尝试一下：

```perl
my @array = (
    "apples",
    "bananas",
    (
        "inner",
        "list",
        "several",
        "entries",
    ),
    "cherries",
);
```

`Perl`无法知道`("inner", "list", "several", "entries")`应该是内部数组还是内部哈希。因此,Perl假定两者都不是,并将列表展平为单个长列表：

```perl
print $array[0]; # "apples"
print $array[1]; # "bananas"
print $array[2]; # "inner"
print $array[3]; # "list"
print $array[4]; # "several"
print $array[5]; # "entries"
print $array[6]; # "cherries"
```

是否使用`fat comma`都是同样的情况：

```perl
my %hash = (
    "beer" => "good",
    "bananas" => (
        "green"  => "wait",
        "yellow" => "eat",
    ),
);

# The above raises a warning because the hash was declared using a 7-element list

print $hash{"beer"};    # "good"
print $hash{"bananas"}; # "green"
print $hash{"wait"};    # "yellow";
print $hash{"eat"};     # undef, so prints "" and raises a warning
```

当然,这确实使连接多个数组起变得容易：

```perl
my @bones   = ("humerus", ("jaw", "skull"), "tibia");
my @fingers = ("thumb", "index", "middle", "ring", "little");
my @parts   = (@bones, @fingers, ("foot", "toes"), "eyeball", "knuckle");
print @parts;
```

不久之后会涉及更多。

## Context

`Perl` 最独特的功能是其代码是上下文敏感的。 `Perl`中的每个表达式都是在标量上下文或列表上下文中求值的,具体取决于期望产生标量还是列表。
如果不了解表达式的上下文,就无法确定表达式的计算结果。

```perl
array-> 长度
list -> 末尾元素
reverser
scalar
```

标量分配`my $scalar =`在标量上下文中评估其表达式。在这里,表达式为`"Mendeleev"`：

```perl
my $scalar = "Mendeleev";
```

数组或哈希分配（例如,` my @array =`或`my %hash = `）在列表上下文中求值。
在此,表达式为`("Alpha", "Beta", "Gamma", "Pie")`或`("Alpha" => "Beta", "Gamma" => "Pie"),`,两者等效：

```perl
my @array = ("Alpha", "Beta", "Gamma", "Pie");
my %hash = ("Alpha" => "Beta", "Gamma" => "Pie");
```

在列表上下文中求值的标量表达式将自动转换为单元素列表：

```perl
my @array = "Mendeleev"; # same as 'my @array = ("Mendeleev");'

```

在标量上下文中求值的`array`表达式返回`array`的长度：

```perl
my @array = ("Alpha", "Beta", "Gamma", "Pie");
my $scalar = @array;
print $scalar; # "4"
```

在标量上下文中求值的`list`表达式（`list`与数组不同,还记得吗？）不返回`list`的长度,而是返回`list`中的末位标量：

```perl
my $scalar = ("Alpha", "Beta", "Gamma", "Pie");
print $scalar; # "Pie"
```

`print` 内置函数在列表上下文中评估其所有参数。
实际上, `print` 接受无限数量的参数列表,并且一个接一个地打印,这意味着可以将其直接用于打印数组：

```perl
my @array = ("Alpha", "Beta", "Goo");
my $scalar = "-X-";
print @array;              # "AlphaBetaGoo";
print $scalar, @array, 98; # "-X-AlphaBetaGoo98";
```

警告。许多`Perl`表达式和内置函数根据它们的上下文表现出完全不同的行为。
最突出的例子是 function ` reverse`。在列表上下文中,`reverse`将其参数视为列表,然后反转该列表。
在标量上下文中,`reverse`将整个列表连接在一起,然后将其作为单个单词反向。

```perl
print reverse "hello world"; # "hello world"

my $string = reverse "hello world";
print $string; # "dlrow olleh"
```

您可以使用`scalar`内置函数强制任何表达式在标量上下文中计算：

```perl
print scalar reverse "hello world"; # "dlrow olleh"
```

还记得我们之前如何使用`scalar`来获取数组的长度吗？

## 引用和嵌套数据结构

类似`list`不能包含`list`作为元素,`array`和`hash`不能包含其他数组和`hash`作为元素。它们只能包含标量。观看当我们尝试时会发生什么：

```perl
my @outer = ("Sun", "Mercury", "Venus", undef, "Mars");
my @inner = ("Earth", "Moon");

$outer[3] = @inner;

print $outer[3]; # "2"
```

`$outer [3]`是一个`scalar`,因此它需要一个`scalar`值。当您尝试为其分配一个数组值（`@inner`）时,`@inner`在`scalar`上下文中求值。这与分配`saclar @inner`相同,后者是array `@inner`的长度,即`2`。

但是,`scalar`变量可以包含对任何变量的引用,包括`array`变量或哈希变量。这就是在`Perl`中创建更复杂的数据结构的方式。

引用使用反斜杠`\`创建。

```perl
my $colour    = "Indigo";
my $scalarRef = \$colour;
```

任何时候使用变量名时,都可以用引用代替,引用变量外加上一层`braces`。

```perl
print $colour;         # "Indigo"
print $scalarRef;      # e.g. "SCALAR(0x182c180)"
print ${ $scalarRef }; # "Indigo"
```

只要结果没有歧义,您也可以省略花括号：

```perl
print $$scalarRef; # "Indigo"
```

如果您的引用是对数组或哈希变量的引用,则可以使用花括号或使用更流行的箭头运算符`->`从其中获取数据。

```perl
my @colours = ("Red", "Orange", "Yellow", "Green", "Blue");
my $arrayRef = \@colours;

print $colours[0];       # direct array access
print ${ $arrayRef }[0]; # use the reference to get to the array
print $arrayRef->[0];    # exactly the same thing

my %atomicWeights = ("Hydrogen" => 1.008, "Helium" => 4.003, "Manganese" => 54.94);
my $hashRef = \%atomicWeights;

print $atomicWeights{"Helium"}; # direct hash access
print ${ $hashRef }{"Helium"};  # use a reference to get to the hash
print $hashRef->{"Helium"};     # exactly the same thing - this is very common
```

### 声明数据结构

这里有四个示例,但实际上最后一个是最有用的。

```perl
my %owner1 = (
    "name" => "Santa Claus",
    "DOB"  => "1882-12-25",
);

my $owner1Ref = \%owner1;

my %owner2 = (
    "name" => "Mickey Mouse",
    "DOB"  => "1928-11-18",
);

my $owner2Ref = \%owner2;

my @owners = ( $owner1Ref, $owner2Ref );

my $ownersRef = \@owners;

my %account = (
    "number" => "12345678",
    "opened" => "2000-01-01",
    "owners" => $ownersRef,
);
```

这显然是不必要的麻烦,因为您可以将其缩短为：

```perl
my %owner1 = (
    "name" => "Santa Claus",
    "DOB"  => "1882-12-25",
);

my %owner2 = (
    "name" => "Mickey Mouse",
    "DOB"  => "1928-11-18",
);

my @owners = ( \%owner1, \%owner2 );

my %account = (
    "number" => "12345678",
    "opened" => "2000-01-01",
    "owners" => \@owners,
);
```

也可以使用不同的符号声明匿名数组和哈希。使用方括号声明匿名`array`,使用圆括号声明匿名`array`。
在每种情况下返回的值都是对所讨论的匿名数据结构的引用。请仔细观察,其结果是与上面的`%account`完全相同：

```perl
# Braces denote an anonymous hash
my $owner1Ref = {
    "name" => "Santa Claus",
    "DOB"  => "1882-12-25",
};

my $owner2Ref = {
    "name" => "Mickey Mouse",
    "DOB"  => "1928-11-18",
};

# Square brackets denote an anonymous array
my $ownersRef = [ $owner1Ref, $owner2Ref ];

my %account = (
    "number" => "12345678",
    "opened" => "2000-01-01",
    "owners" => $ownersRef,
);
```

或者,简而言之（这是 in-line 声明复杂数据结构时,实际中应该使用的形式）：

```perl
my %account = (
    "number" => "31415926",
    "opened" => "3000-01-01",
    "owners" => [
        {
            "name" => "Philip Fry",
            "DOB"  => "1974-08-06",
        },
        {
            "name" => "Hubert Farnsworth",
            "DOB"  => "2841-04-09",
        },
    ],
);
```

### 从数据结构中获取信息

现在,让我们假设您还有`%account`,但是其他所有内容（如果有其他内容）都超出了范围。
您可以通过在每种情况下相反的步骤来打印信息。同样,这里有四个示例,其中最后一个是最有用的：

```perl
my $ownersRef = $account{"owners"};
my @owners    = @{ $ownersRef };
my $owner1Ref = $owners[0];
my %owner1    = %{ $owner1Ref };
my $owner2Ref = $owners[1];
my %owner2    = %{ $owner2Ref };
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $owner1{"name"}, " (born ", $owner1{"DOB"}, ")\n";
print "\t", $owner2{"name"}, " (born ", $owner2{"DOB"}, ")\n";
```

或者,简而言之：

```perl
my @owners = @{ $account{"owners"} };
my %owner1 = %{ $owners[0] };
my %owner2 = %{ $owners[1] };
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $owner1{"name"}, " (born ", $owner1{"DOB"}, ")\n";
print "\t", $owner2{"name"}, " (born ", $owner2{"DOB"}, ")\n";
```

或使用引用和`->`运算符：

```perl
my $ownersRef = $account{"owners"};
my $owner1Ref = $ownersRef->[0];
my $owner2Ref = $ownersRef->[1];
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $owner1Ref->{"name"}, " (born ", $owner1Ref->{"DOB"}, ")\n";
print "\t", $owner2Ref->{"name"}, " (born ", $owner2Ref->{"DOB"}, ")\n";
```

或者跳过所有中间取值

```perl
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $account{"owners"}->[0]->{"name"}, " (born ", $account{"owners"}->[0]->{"DOB"}, ")\n";
print "\t", $account{"owners"}->[1]->{"name"}, " (born ", $account{"owners"}->[1]->{"DOB"}, ")\n";
```

### 如何使用数组引用让自己快乐

该数组包含五个元素：

```perl
my @array1 = (1, 2, 3, 4, 5);
print @array1; # "12345"
```

但是,此数组具有`单个`元素（它是对匿名的五元素数组的引用）：

```perl
my @array2 = [1, 2, 3, 4, 5];
print @array2; # e.g. "ARRAY(0x182c180)"
```

此`scalar`是对一个匿名的五元素数组的引用：

```perl
my $array3Ref = [1, 2, 3, 4, 5];
print $array3Ref;      # e.g. "ARRAY(0x22710c0)"
print @{ $array3Ref }; # "12345"
print @$array3Ref;     # "12345"
```

### Conditionals

### if ... elsif ... else ...

除了`elsif`的拼写,这里没有其他惊喜：

```perl
my $word = "antidisestablishmentarianism";
my $strlen = length $word;

if($strlen >= 15) {
	print "'", $word, "' is a very long word";
} elsif(10 <= $strlen && $strlen < 15) {
	print "'", $word, "' is a medium-length word";
} else {
	print "'", $word, "' is a short word";
}
```

Perl提供了一个较短的`statement if condition`语法,强烈建议在短语句中使用：

```perl
print "'", $word, "' is actually enormous" if $strlen >= 20;
```

### unless ... else ...

我的$温度= 20;

my $temperature = 20;

```perl
unless($temperature > 30) {
	print $temperature, " degrees Celsius is not very hot";
} else {
	print $temperature, " degrees Celsius is actually pretty hot";
}
```

最好避免使用`unless`,因为它们会造成混乱。可以通过否定条件（或通过保留条件并交换这些块）来将`"unless [... else]"`微不足道地重构为``if [... else]``块。
幸运的是,没有`elsunless`关键字。

相比之下,强烈建议您这样做,因为它很容易阅读：

```perl
print "Oh no it's too cold" unless $temperature > 15;
```

### Ternary 三元运算符

三元运算符`?:`允许将简单的`if`语句嵌入到一条语句中。一个标准用法是单数/复数形式：

```perl
my $gain = 48;
print "You gained ", $gain, " ", ($gain == 1 ? "experience point" : "experience points"), "!";
```

旁白:在两种情况下,最好将单数和复数完整地拼写。不要做下面这种奇怪的事情,因为任何人搜索代码库来替换单词` tooth`或`teeth`时,都找不到此行：

```perl
my $lost = 1;
print "You lost ", $lost, " t", ($lost == 1 ? "oo" : "ee"), "th!";
```

三元运算符可以嵌套：

```perl
my $eggs = 5;
print "You have ", $eggs == 0 ? "no eggs" :
                   $eggs == 1 ? "an egg"  :
                   "some eggs";
```

`if`语句在标量上下文中计算其条件。
例如,当且仅当`@array`具有`1`个或多个元素时,`if(@array)`返回`true`。
这些元素是什么无关紧要-对于我们关心的所有元素,它们可能包含`undef`或其他`false`。

### 循环

有不止一种方法可以做到这一点。
Perl有一个常规的`while`循环：

```perl
my $i = 0;
while($i < scalar @array) {
	print $i, ": ", $array[$i];
	$i++;
}
```

Perl还提供了`until`关键字：

```perl
my $i = 0;
until($i >= scalar @array) {
	print $i, ": ", $array[$i];
	$i++;
}
```

这些`do`循环与上面的`几乎`等效（如果`@array`为空,则会发出警告）：

```perl
my $i = 0;
do {
	print $i, ": ", $array[$i];
	$i++;
} while ($i < scalar @array);
```

and

```perl
my $i = 0;
do {
	print $i, ": ", $array[$i];
	$i++;
} until ($i >= scalar @array);
```

也可以使用基本的`C`风格的循环。注意我们如何在`for`语句中放入`my`,仅在循环范围内声明`$i`：

```perl
for(my $i = 0; $i < scalar @array; $i++) {
	print $i, ": ", $array[$i];
}
# $i has ceased to exist here, which is much tidier.
```

这种`for`循环被认为是老式的,应尽可能避免。list 上的原生迭代要好得多。
注意：与PHP不同,`for`和`foreach`关键字是同义词。只需选用最容易理解的即可：

```perl
foreach my $string ( @array ) {
	print $string;
}
```

如果确实需要索引,则`range operator ..`将创建一个匿名整数列表：

```perl
foreach my $i ( 0 .. $#array ) {
	print $i, ": ", $array[$i];
}
```

您不能遍历哈希。但是,您可以遍历其键。使用`keys`内置函数检索包含哈希的所有键的`array`。然后对`array`使用`foreach`方法：

```perl
foreach my $key (keys %scientists) {
	print $key, ": ", $scientists{$key};
}
```

由于哈希没有基础顺序,因此可以按任何顺序返回键。使用内置的`sort`函数可以按字母顺序对键数组进行排序：

```perl
foreach my $key (sort keys %scientists) {
	print $key, ": ", $scientists{$key};
}
```

如果您不提供显式的迭代器,则Perl使用默认的迭代器`$ _`。 `$_`是第一个也是最友好的内置变量：

```perl
foreach ( @array ) {
	print $_;
}
```

如果使用默认的迭代器,而您只希望在循环中放入一条语句,则可以使用超短循环语法：

```perl
print $_ foreach @array;
```

### Loop control

`next`和`last`可以用来控制循环的进度。在大多数编程语言中,它们分别称为`continue`和`break`。
我们还可以选择为任何循环提供`label`。按照惯例,标签全部以大写书写。
在标记了循环之后,`next and last`可以定位到该标记。本示例查找低于`100`的素数：

```perl
CANDIDATE: for my $candidate ( 2 .. 100 ) {
	for my $divisor ( 2 .. sqrt $candidate ) {
		next CANDIDATE if $candidate % $divisor == 0;
	}
	print $candidate." is prime\n";
}
```

## Array functions

in-place array modification

我们将使用`@stack`演示这些：

```perl
my @stack = ("Fred", "Eileen", "Denise", "Charlie");
print @stack; # "FredEileenDeniseCharlie"
```

`pop`提取并返回数组的最后一个元素。这可以认为是堆栈的顶部：

```perl
print pop @stack; # "Charlie"
print @stack;     # "FredEileenDenise"
```

`push`将多余的元素追加到数组的末尾：

```perl
push @stack, "Bob", "Alice";
print @stack; # "FredEileenDeniseBobAlice"
```

`shift`提取并返回数组的第一个元素：

```perl
print shift @stack; # "Fred"
print @stack;       # "EileenDeniseBobAlice"
```

`unshift`在数组的开头插入新元素：

```perl
unshift @stack, "Hank", "Grace";
print @stack; # "HankGraceEileenDeniseBobAlice"
```

`pop`,`push`,`shift` 和 `unshift` 都是`splice`的特例。` splice`删除并返回一个数组切片,将其替换为另一个数组切片：

```perl
print splice(@stack, 1, 4, "<<<", ">>>"); # "GraceEileenDeniseBob"
print @stack;                             # "Hank<<<>>>Alice"
```

### 从旧数组创建新数组

Perl提供了以下功能,这些功能可作用于数组以创建其他数组。

`join`函数将许多字符串合并为一个：

```perl
my @elements = ("Antimony", "Arsenic", "Aluminum", "Selenium");
print @elements;             # "AntimonyArsenicAluminumSelenium"
print "@elements";           # "Antimony Arsenic Aluminum Selenium"
print join(", ", @elements); # "Antimony, Arsenic, Aluminum, Selenium"
```

在`list`上下文中,`reverse`函数以相反的顺序返回列表。在标量上下文中,``reverse``将整个列表连接在一起,然后将其作为单个单词反向。

```perl
print reverse("Hello", "World");        # "WorldHello"
print reverse("HelloWorld");            # "HelloWorld"
print scalar reverse("HelloWorld");     # "dlroWolleH"
print scalar reverse("Hello", "World"); # "dlroWolleH"
```

`map`函数将一个数组作为输入,并对该数组中的每个标量`$_`应用一个运算。然后,它根据结果构造一个新的数组。大括号内的单个表达式提供了要执行的操作：

```perl
my @capitals = ("Baton Rouge", "Indianapolis", "Columbus", "Montgomery", "Helena", "Denver", "Boise");

print join ", ", map { uc $_ } @capitals;
# "BATON ROUGE, INDIANAPOLIS, COLUMBUS, MONTGOMERY, HELENA, DENVER, BOISE"
```

`grep`函数将一个数组作为输入,并返回一个经过过滤的数组作为输出, 语法类似于`map`。
它将计算第二个参数中的每个标量`$_`。如果返回布尔值`true`,则将标量放入输出数组,否则不放入。

```perl
print join ", ", grep { length $_ == 6 } @capitals;
# "Helena, Denver"
```

显然,结果数组的长度就是成功匹配的次数,这意味着您可以使用`grep`快速检查数组是否包含元素：

```perl
print scalar grep { $_ eq "Columbus" } @capitals; # "1"
```

`grep` 和 `map` 可以结合起来形成 `list comprehensions`,这是许多其他编程语言所不具备的非常强大的功能。

默认情况下,`sort`函数返回输入数组,并按词汇（字母顺序）顺序排序：

```perl
my @elevations = (19, 1, 2, 100, 3, 98, 100, 1056);
print join ", ", sort @elevations;
# "1, 100, 100, 1056, 19, 2, 3, 98"
```

但是,类似于`grep`和`map`,您可以提供一些自己的代码。
排序总是通过在两个元素之间使用一系列比较完成的，你的块接收`$a`和`$b`作为输入,如果`$a`小于`$b`,则返回`-1`；如果它们相等,则返回`0`；如果`$a`大于`$b`,则返回`1`。

`cmp`运算符就可以实现此操作：

```perl
print join ", ", sort { $a cmp $b } @elevations;
# "1, 100, 100, 1056, 19, 2, 3, 98"
```

"spaceship operator" `<=>`对数字的作用相同：

```perl
print join ", ", sort { $a <=> $b } @elevations;
# "1, 2, 3, 19, 98, 100, 100, 1056"
```

`$a`和`$b`始终是标量,但是它们可以引用很难比较的相当复杂的对象。如果需要更多空间进行比较,则可以创建一个单独的子例程并提供其名称,而不是：

```perl
sub comparator {
	# lots of code...
	# return -1, 0 or 1
}

print join ", ", sort comparator @elevations;
```

对于`grep`或`map`操作,您无法执行此操作。

注意,永远不会显式地提供`$a`和`$b`给`subroutine`和`block`。像`$_`一样,`$a`和`$b`实际上是全局变量,每次比较时，给它们填充一对值。

## Built-in 函数

到目前为止，您至少已经看到了十二种内置函数： `print`, `sort`, `map`, `grep`, `keys`, `scalar` 等。内置功能是Perl的最大优势之一。他们

+ 很多
+ 非常有用
+ 文档很多
+ 语法差异很大，因此请查看文档
+ 有时接受正则表达式作为参数
+ 有时接受整个代码块作为参数
+ 有时参数之间不需要逗号
+ 有时会使用任意数量的逗号分隔的参数，有时不会
+ 如果提供的参数太少，有时会填写自己的参数
+ 一般情况下，除非模棱两可的情况，否则通常不需要在参数周围加上方括号

关于内置功能的最佳建议是`know that they exist`。浏览文档以备将来参考。如果您正在执行的任务看起来像是已经完成了很多次的低级通用任务，那么很有可能已经完成了。
