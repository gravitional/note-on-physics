# awk

[w3c AWk][]

[w3c AWk]: https://www.w3cschool.cn/awk/hs671k8f.html

部分 AWK 的典型应用场景

AWK 可以做非常多的工作。 下面只是其中的一小部分：

+ 文本处理，
+ 生成格式化的文本报告，
+ 进行算术运算，
+ 字符串操作，以及其它更多。

## AWK 工作流程

### 工作流程

AWK 执行的流程非常简单：读( Read )、执行（ Execute )与重复( Repeat )。

+ 读（Read）: AWK 从输入流（文件、管道或者标准输入）中读入一行然后将其存入内存中。
+ 执行(Execute): 对于每一行输入，所有的 `AWK` 命令按顺执行。 默认情况下，AWK 命令是针对于每一行输入，但是我们可以将其限制在指定的模式中。
+ 重复（Repeate）:一直重复上述两个过程直到文件结束。

### 程序的结构

我们已经见过 AWK 程序的工作流程。 现在让我们一起来学习 AWK 程序的结构。

+ 开始块（BEGIN block）`BEGIN {awk-commands}`
+ 主体块（Body Block）`/pattern/ {awk-commands}`
+ 结束块（END Block）`END {awk-commands}`

开始块和结束块需要大写，它们是可选的。

默认情况下，对于输入的每一行，`AWK` 都会很执行命令。但是，我们可以将其限定在指定的模式中。 注意，在主体块部分没有关键字存在。

### 例子

先创建一个名为 `marks.txt` 的文件。其中包括序列号、学生名字、课程名称与所得分数。

```bash
1)    Amit     Physics    80
2)    Rahul    Maths      90
3)    Shyam    Biology    87
4)    Kedar    English    85
5)    Hari     History    89
```

接下来，我们将使用 AWK 脚本来显示输出文件中的内容，同时输出表头信息。

```bash
awk 'BEGIN{printf "Sr No\tName\tSub\tMarks\n"} {print}' marks.txt
```

程序启动时，AWK 在开始块中输出表头信息。在主体块中，AWK 每读入一行就将读入的内容输出至标准输出流中，一直到整个文件被全部读入为止。

## awk 基本示例

***
默认情况下，如果某行与模式串匹配，AWK 会将整行输出：

```bash
awk '/a/ {print $0}' test.txt
```

上面的示例中，我们搜索模式串 `a`，每次成功匹配后都会执行主体块中的命令。
如果没有主体块--默认的动作是输出记录（行）。因此上面的效果也可以使用下面简略方式实现,它们会得到相同的结果：

```bash
awk '/a/' marks.txt
```

***
不过，我们可以让 AWK 只输出特定的域（列）的内容。 例如，下面的这个例子中当模式串匹配成功后只会输出第三列与第四列的内容:
注意，列的顺序可以任意，比如下面的`$4 "\t" $3`

`awk '/a/ {print $4 "\t" $3}' test.txt`

***
计数匹配次数并输出

`awk '/a/{++cnt} END {print "Count = ", cnt}' test.txt`

***
输出字符数多于 `18` 的行

这个例子中我们只输出那些字符数超过 `18` 的记录：

`awk 'length($0) > 18' marks.txt`
`awk 'length($0) > 18 {print}' marks.txt`
`awk 'length($0) > 18 {print $2}' marks.txt`

AWK 提供了内置的 `length` 函数。该函数返回字符串的长度。
变量 `$0` 表示整行，缺失的主体块会执行默认动作，例如，打印输出。
因此，如果一行中字符数超过 `18`， 则比较的结果为真，该行则被输出。

## AWK 内置变量

`AWK` 提供了一些内置变量。 它们在你写 `AWK` 脚本的时候起着很重要的作用。

### 标准 AWK 变量

`ARGC`

`ARGC` 表示在命令行提供的参数的个数。

`awk 'BEGIN {print "Arguments =", ARGC}' One Two Three Four`

执行上面的命令可以得到如下的结果：

`Arguments = 5`

程序哪儿出毛病了吗？为什么只输入四个参数而 AWK 却显示输入的参数个数的五呢？ 看完下面这个例子，你就会明白的。

***
  ARGV

这个变量表示存储命令行输入参数的数组。数组的有效索引是从 `0` 到 `ARGC-1`。

```bash
awk 'BEGIN { for (i = 0; i < ARGC - 1; ++i)
      { printf "ARGV[%d] = %s\n", i, ARGV[i] }
                    }' one two three four
```

***
`CONVFMT`

此变量表示数据转换为字符串的格式，其默认值为 `%.6g`。

`awk 'BEGIN { print "Conversion Format =", CONVFMT }'`

***
`ENVIRON`

此变量是与环境变量相关的关联数组变量。

`awk 'BEGIN { print ENVIRON["USER"] }'`

可以使用 GNU/Linux 系统中的 `env` 命令查询其它环境变量的名字。

***
`FILENAME`

此变量表示当前文件名称。

`awk 'END {print FILENAME}' test.txt`

值得注意的是在开始块中`FILENAME`是未定义的。

***
`FS`

此变量表示输入的数据域之间的分隔符，其默认值是空格。 你可以使用 `-F` 命令行选项改变它的默认值。

`awk 'BEGIN {print "FS = " FS}' | cat -vte`

***
`NF`

此变量表示当前输入记录中域的数量(相当于列的数量)。例如，下面这个例子只输出超过两个域的行：

`echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NF > 2'`

***
`NR`

此变量表示当前记录的数量。（译注：该变量类似一个计数器，统计记录的数量）。下面例子会输出读入的前三行（`NR<3`）。

`echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NR < 3'`

***
`FNR`

该变量与 `NR` 类似，不过它是相对于当前文件而言的。此变量在处理多个文件输入时有重要的作用。
每当从新的文件中读入时 `FNR` 都会被重新设置为 `0`。

***
`OFMT`

此变量表示数值输出的格式，它的默认值为 `%.6g`。

`awk 'BEGIN {print "OFMT = " OFMT}'`

***
`OFS`

此变量表示输出域之间的分割符，其默认为空格。

`awk 'BEGIN {print "OFS = " OFS}' | cat -vte`

***
`ORS`

`cat -vte` 等于 `cat -A`，打印所有字符，包括通常不显示的。

此变量表示输出记录（行）之间的分割符，其默认值是换行符。

`awk 'BEGIN {print "ORS = " ORS}' | cat -vte`

***
`RLENGTH`

此变量表示 `match` 函数匹配的字符串长度。AWK 的 `match` 函数用于在输入的字符串中搜索指定字符串。

`awk 'BEGIN { if (match("One Two Three", "re")) { print RLENGTH } }'`

`RS`

此变量表示输入记录的分割符，其默认值为换行符。

`awk 'BEGIN {print "RS = " RS}' | cat -vte`

***
`RSTART`

此变量表示由 `match` 函数匹配的字符串的第一个字符的位置。

`awk 'BEGIN { if (match("One Two Three", "Thre")) { print RSTART } }'`

***
`SUBSEP`

此变量表示数组下标的分割行符，其默认值为` \034 `。

`awk 'BEGIN { print "SUBSEP = " SUBSEP }' | cat -vte`

***
`$0`

此变量表示整个输入记录。

`awk '{print $0}' marks.txt`

***
`$n`

此变量表示当前输入记录的第 `n` 个域，这些域之间由 `FS` 分割。

`awk '{print $3 "\t" $4}' marks.txt`

### GNU AWK 特定的变量

下面将介绍 `GNU` `AWK `专有的变量：

`ARGIND`

此变量表示当前文件中正在处理的 `ARGV` 数组的索引值。

`awk '{ print "ARGIND   = ", ARGIND; print "Filename = ", ARGV[ARGIND] }' junk1 junk2 junk3`

***
`BINMODE`

此变量用于在非 POSIX 系统上指定 AWK 对所有文件的 `I/O` 都使用二进制模式。
数值`1`，`2` 或者 `3` 分别指定输入文件、输出文件或所有文件。
字符串值 `r` 或 `w` 分别指定输入文件或者输出文件使用二进制 `I/O`模式。 字符串值 `rw` 或 `wr` 指定所有文件使用二进制 I/O模式。

`ERRNO`

此变量用于存储当 `getline` 重定向失败或者 `close` 函数调用失败时的失败信息。

`awk 'BEGIN { ret = getline < "junk.txt"; if (ret == -1) print "Error:", ERRNO }'`

***
`FIELDWIDTHS`

该变量表示一个分割域之间的空格的宽度。当此变量被设置后， `GAWK` 将输入的域之间的宽度处理为固定宽度，而不是使用 `FS` 的值作为域间的分割符。

***
`IGNORECASE`

当此变量被设置后，`GAWK`将变得大小写不敏感。下面是一个简单的例子：

`awk 'BEGIN{IGNORECASE=1} /amit/' marks.txt`

***
`LINT`

此变量提供了在 `GAWK` 程序中动态控制 `--lint` 选项的一种途径。
当这个变量被设置后， `GAWK` 会输出 `lint` 警告信息。如果给此变量赋予字符值 `fatal`，`lint` 的所有警告信息将会变了致命错误信息(fatal errors)输出，这和 `--lint=fatal` 效果一样。

`awk 'BEGIN {LINT=1; a}'`

***
`PROCINFO`

这是一个关联数组变量，它保存了进程相关的信息。比如， 真正的和有效的 `UID` 值，进程 `ID` 值等等。

`awk 'BEGIN { print PROCINFO["pid"] }'`

***
`TEXTDOMAIN`

此变量表示　`AWK` 程序当前文本域。 它主要用寻找程序中的字符串的本地翻译，用于程序的国际化。

`awk 'BEGIN { print TEXTDOMAIN }'`

执行上面的命令可以得到如下的结果：

`messages`

（译注：输出 `message` 是由于 `TEXTDOMAIN` 的默认值为 `messages`） 上面所有的输出都是英文字符是因为本地语言环境配置为 `en_IN`

## AWK 操作符

与其它编程语言一样，AWK 也提供了大量的操作符。这一章节中，我们将结合例子介绍　AWK 操作符的使用方法：　

### 算术运算符　　
　
***
加法运算符　

加法运算由符号 `+` 表示，它求得两个或者多个数字的和。下面是一个使用示例：

`awk 'BEGIN { a = 50; b = 20; print "(a + b) = ", (a + b) }'`

***
减法运算符　　

减法运算由符号`-` 表示，它求得两个或者多个数值的差。示例如下：

`awk 'BEGIN { a = 50; b = 20; print "(a - b) = ", (a - b) }'`

***
乘法运算符　　

乘法运算由星号( `*` )表示，它求得两个或者多个数值的乘积。示例如下：

`awk 'BEGIN { a = 50; b = 20; print "(a * b) = ", (a * b) }'`

***
除法运算符　　

除法运算由斜线(` /` ) 表示，它求得两个或者两个以上数值的商。示例如下：

`awk 'BEGIN { a = 50; b = 20; print "(a / b) = ", (a / b) }'`

***
模运算符　　

模运算由百分（`％`）表示，它表示两个或者多个数进行模除运算得到其余数。下面是示例：

`awk 'BEGIN { a = 50; b = 20; print "(a % b) = ", (a % b) }'`

***
递增运算符与递减运算符　　
　
前置递增运算由 `++` 表示。它将操作数加 `1`。这个运算符将操作值增加 `1`，然后再返回增加后的值。

`awk 'BEGIN { a = 10; b = ++a; printf "a = %d, b = %d\n", a, b }'`

***
前置递减运算符　　

前置递减运算由 `--` 表示。它的语义是将操作数减 `1`。这个运算符先将操作数的值减 `1`， 再将被减小后的值返回。

`awk 'BEGIN { a = 10; b = --a; printf "a = %d, b = %d\n", a, b }'`

***
后置递增运算符 　　

后置递增运算由 `++` 表示。它同样将操作数的值加`1`。与前置递增运算符不同，它先将操作数的值返回，再将操作数的值加 `1`。

`awk 'BEGIN { a = 10; b = a++; printf "a = %d, b = %d\n", a, b }'`

***
后置递减运算符　　

后置递增运算符由 `--` 表示。它同样将操作数的值减`1`。该操作符先将操作数的值返回，然后将操作数减`1`。

`awk 'BEGIN { a = 10; b = a--; printf "a = %d, b = %d\n", a, b }'`

### 赋值操作符　　

AWK 支持下面这些赋值操作：　

***
简单赋值　　

简单赋值操作由 `=` 表示。示例如下：　　

`awk 'BEGIN { name = "Jerry"; print "My name is", name }'`

***
加法赋值　　

加法赋值运算符为 `+=`。下面为示例： 　　

`awk 'BEGIN { cnt=10; cnt += 10; print "Counter =", cnt }'`

***
减法赋值　　

减法赋值运算符为 `-=`。下面为示例： 　　

`awk 'BEGIN { cnt=100; cnt -= 10; print "Counter =", cnt }'`

***
乘法赋值　　

乘法赋值运算符为 `*=`。下面为示例： 　　

`awk 'BEGIN { cnt=10; cnt *= 10; print "Counter =", cnt }'`

***　　
除法赋值　　

除法赋值运算符为 `/=`。下面为示例：　　

`awk 'BEGIN { cnt=100; cnt /= 5; print "Counter =", cnt }'`

***　
模运算赋值　　

模运算赋值运算符为 `%=`。下面为示例： 　　

`awk 'BEGIN { cnt=100; cnt %= 8; print "Counter =", cnt }'`

***
指数赋值　　

指数赋值运算符为 `^=`。下面为示例： 　　

`awk 'BEGIN { cnt=2; cnt ^= 4; print "Counter =", cnt }'`
　
### 关系运算符 　　

AWK 支持如下关系运算符：

***　　
等于　　

等于运算符为 `==`。如果两个操作数相等则返回真，否则返回假。示例如下：　　

`awk 'BEGIN { a = 10; b = 10; if (a == b) print "a == b" }'`

***
不等于

不等于运算符为 `!=`。如果两个操作数相等则返回假，否则返回真。示例如下：　　

`awk 'BEGIN { a = 10; b = 20; if (a != b) print "a != b" }'`

***
小于 　　

小于运算符为 `<`。如果左操作数小于右操作数据则返回真，否则返回假。示例如下： 　　

`awk 'BEGIN { a = 10; b = 20; if (a < b) print "a < b" }'`

***
小于或等于 　　

小于等于运算符为 `<=`。如果左操作数小于或等于右操作数据则返回真，否则返回假。示例如下： 　　

`awk 'BEGIN { a = 10; b = 10; if (a <= b) print "a <= b" }'`

***
大于　　

大于运算符为 `>`。如果左操作数大于右操作数则返回真，否则返回假。示例如下： 　

`awk 'BEGIN { a = 10; b = 20; if (b > a ) print "b > a" }'`

***
大于或等于　　

大于等于运算符为` >=`。如果左操作数大于或等于右操作数则返回真，否则返回假。示例如下：　　

`awk 'BEGIN { a = 10; b = 10; if (a >= b) print "a >= b" }'`

### 逻辑运算符　

`AWK` 包括如下逻辑运算符：　

***　
逻辑与　　

逻辑与运算符为 `&&`。下面是逻辑与运算符的语法：

`expr1 && expr2`

如果 `expr1` 与 `epxr2` 均为真，则最终结果为真；否则为假。请注意，只有当 `expr1` 为真时才会计算 `expr2` 的值，若 `expr1` 为假则直接返回真，而不再计算 `expr2` 的值。下面的例子判断给定的字符串是否是八进制形式：

`awk 'BEGIN {num = 5; if (num >= 0 && num <= 7) printf "%d is in octal format\n", num }'`

***
逻辑或　　

逻辑或运算符为 `||`。该运算符语法如下： 　

`expr1 || expr2`

如果 `expr1` 与 `epxr2` 至少其中一个为真，则最终结果为真；二者均为假时则为假。请注意，只有当 `expr1` 为假时才会计算 expr2 的值，若 `expr1` 为真则不会再计算 `expr2` 的值。示例如下：

`awk 'BEGIN {ch = "\n"; if (ch == " " || ch == "\t" || ch == "\n") print "Current character is whitespace." }'`

***
逻辑非

逻辑非运算为感叹号(`!`)。此运算符语法如下：

`! expr1`

逻辑非将 `expr1` 的真值取反。如果 `expr1` 为真，则返回 `0`。否则返回 `1`。下面的示例判断字符串是否为空：

`awk 'BEGIN { name = ""; if (! length(name)) print "name is empty string." }'`

***
三元运算符

我们可以使用三元运算符来实现条件表达式。下面为其语法：

`condition_expression ? statement1 : statement2`

当条件表达式（ condition expression）为真时，`statement1` 执行，否则 `statement2` 执行。下面的示例将返回最大数值：

`awk 'BEGIN { a = 10; b = 20; (a > b) ? max = a : max = b; print "Max =", max}'`


### 一元运算符

AWK 支持如下几种一元运算符：

***
一元加运算

一元加运算符表示为 `+`。它将操作数乘以 `+1`。

`awk 'BEGIN { a = -10; a = +a; print "a =", a }'`

***
一元减运算符

一元减运算符为 `- `。它表示将操作数乘以 `-1`。

`awk 'BEGIN { a = -10; a = -a; print "a =", a }'`

***
指数运算符

幂运算符`^`

`^` 运算符对操作数执行幂运算。下面的示例求 10 的二次幂。

`awk 'BEGIN { a = 10; a = a ^ 2; print "a =", a }'`

幂运算符 `**`

** 运算符对操作数执行幂运算。下面的示例求 10 的二次幂。

`awk 'BEGIN { a = 10; a = a ** 2; print "a =", a }'`

***
字符串连接操作符

空格 (`space`) 操作符可以完成两个字符串的连接操作。示例如下：

`awk 'BEGIN { str1="Hello, "; str2="World"; str3 = str1 str2; print str3 }'`

***
数组成员操作符

数组成员操作符为 `in`。该操作符用于访问数组元素 。下面的示例用于此操作符输出数组中所有元素。

`awk 'BEGIN { arr[0] = 1; arr[1] = 2; arr[2] = 3; for (i in arr) printf "arr[%d] = %d\n", i, arr[i] }'`

### 正则表达式操作符

下面将介绍两种正则表达式操作符:

***
匹配运算符为 `~`。它用于搜索包含匹配模式字符串的域。下面的示例中将输出包括 `9` 的行：

`awk '$0 ~ 9' test.txt`

***
不匹配操作符为 `!~`。 此操作符用于搜索不匹配指定字符串的域。如下示例输出不包含 `9` 的行：

`awk '$0 !~ 9' marks.txt`

## AWK 数组

AWK 有关联数组这种数据结构，而这种数据结构最好的一个特点就是它的索引值不需要是连续的整数值。我们既可以使用数字也可以使用字符串作为数组的索引。除此之外，关联数组也不需要提前声明其大小，因为它在运行时可以自动的增大或减小。这一章节中将会讲解 AWK 数组的使用方法。

如下为数组使用的语法格式：

array_name[index]=value

其中 array_name 是数组的名称，index 是数组索引，value 为数组中元素所赋予的值。
创建数组

为了进一步了解数组，我们先来看一下如何创建数组以及如何访问数组元素：

[jerry]$ awk 'BEGIN {
fruits["mango"]="yellow";
fruits["orange"]="orange"
print fruits["orange"] "\n" fruits["mango"]
}'

执行上面的命令可以得到如下的结果：

orange
yellow

在上面的例子中，我们定义了一个水果(fruits)数组，该数组的索引为水果名称，值为水果的颜色。可以使用如下格式访问数组元素：

array_name[index] 

删除数组元素

插入元素时我们使用赋值操作符。删除数组元素时，我们则使用 delete 语句。如下所示：

delete array_name[index]

下面的例子中，数组中的 orange 元素被删除（删除命令没有输出）：

[jerry]$ awk 'BEGIN {
fruits["mango"]="yellow";
fruits["orange"]="orange";
delete fruits["orange"];
print fruits["orange"]
}'

多维数组

AWK 本身不支持多维数组，不过我们可以很容易地使用一维数组模拟实现多维数组。

如下示例为一个 3x3 的三维数组：

100 200 300
400 500 600
700 800 900

上面的示例中，array[0][0] 存储 100，array[0][1] 存储 200 ，依次类推。为了在 array[0][0] 处存储100, 我们可以使用如下语法：

array["0,0"] = 100

尽管在示例中，我们使用了 0,0 作为索引，但是这并不是两个索引值。事实上，它是一个字符串索引 0,0。

下面是模拟二维数组的例子：

[jerry]$ awk 'BEGIN {
array["0,0"] = 100;
array["0,1"] = 200;
array["0,2"] = 300;
array["1,0"] = 400;
array["1,1"] = 500;
array["1,2"] = 600;
# print array elements
print "array[0,0] = " array["0,0"];
print "array[0,1] = " array["0,1"];
print "array[0,2] = " array["0,2"];
print "array[1,0] = " array["1,0"];
print "array[1,1] = " array["1,1"];
print "array[1,2] = " array["1,2"];
}'

执行上面的命令可以得到如下结果：

array[0,0] = 100
array[0,1] = 200
array[0,2] = 300
array[1,0] = 400
array[1,1] = 500
array[1,2] = 600

在数组上可以执行很多操作，比如，使用 asort 完成数组元素的排序，或者使用 asorti 实现数组索引的排序等等。我们会在后面的章节中介绍可以对数组进行操作的函数。 

## AWK 输出重定向

到目前为止我们输出的数据都是输出到标准输出流中。不过我们也可以将数据输出重定向到文件中。
重定向操作往往出现在 `print` 或者 `printf` 语句中。 `AWK` 中的重定向方法与 `shell` 重定向十分相似，除了 `AWK` 重定向只用于 `AWK` 程序中外。

### 重定向操作符

重定向操作符的使用方法如下：

`print DATA > output-file`

上面重定向操作将输出数据重定向到 `output-file` 中。如果 `output-file` 文件不存在，则先创建该文件。使用这种重定向方式时，数据输出前会将 `output-file` 文件中原有的数据删除。下面的示例将 `Hello,World!!!` 消息重定向输出到文件中。

先创建文件并在文件中输入一些数据。

```bash
echo "Old data" > /tmp/message.txt 
cat /tmp/message.txt
```

再用 AWK 重定向操作符重定向数据到文件 `message.txt `中。

```bash
awk 'BEGIN { print "Hello, World !!!" > "/tmp/message.txt" }'
cat /tmp/message.txt
```

### 追加重定向

追加重定向操作符的语法如下：

`print DATA >> output-file`

用这种重定向方式将数据追加到 `output-file` 文件的末尾。如果文件不存在则先创建该文件。示例如下：

创建文件并输入一些数据：

```bash
echo "Old data" > /tmp/message.txt 
cat /tmp/message.txt
```

再使用 AWK 追加操作符追加内容到文件中：

```bash
awk 'BEGIN { print "Hello, World !!!" > "/tmp/message.txt" }'
cat /tmp/message.txt
```

### 管道

除了使用文件在程序之间传递数据之外，AWK 还提供使用管道将一个程序的输出传递给另一个程序。这种重定向方式会打开一个管道，将对象的值通过管道传递给管道另一端的进程，然后管道另一端的进程执行命令。下面是管道的使用方法：

`print items | command`

下面的例子中我们使用 `tr` 命令将小写字母转换成大写。

`awk 'BEGIN { print "hello, world !!!" | "tr [a-z] [A-Z]" }'`

### 双向通信通道

`AWK` 允许使用 `|&` 与一个外部进程通信，并且可以双向通信。下面的例子中，我们仍然使用 `tr` 命令将字母转换为大写字母。

```bash
awk 'BEGIN {
    cmd = "tr [a-z] [A-Z]"
    print "hello, world !!!" |& cmd
    close(cmd, "to")
    cmd |& getline out
    print out;
    close(cmd);
}'
```

脚本的内容看上去很神秘吗？让我们一步一步揭开它神秘的面纱。

+ 第一条语句 `cmd = "tr [a-z] [A-Z]"` 在`AWK `中建立了一个双向的通信通道。
+ 第二条语句 `print` 为 `tr` 命令提供输入。`&|` 表示双向通信。
+ 第三条语句 `close(cmd, "to") `执行后关闭 `to `进程。
+ 第四条语句 `cmd |& getline out` 使用 `getline` 函数将输出存储到 `out` 变量中。
+ 接下来的输出语句打印输出的内容，最后 `close` 函数关闭 `cmd`。

## another

[awk命令][]

[awk命令]: https://man.linuxde.net/awk

`awk`是一种编程语言，用于在`linux/unix`下对文本和数据进行处理。数据可以来自标准输入(stdin)、一个或多个文件，或其它命令的输出。
它支持用户自定义函数和动态正则表达式等先进功能，是`linux/unix`下的一个强大编程工具。
它在命令行中使用，但更多是作为脚本来使用。

`awk`有很多内建的功能，比如数组、函数等，这是它和`C`语言的相同之处，灵活性是`awk`最大的优势。

## awk命令格式和选项

我们可以直接通过命令行的方式为 `AWK` 程序提供 `AWK` 命令，也可以使用包括 `AWK` 命令的脚本文件。

***
语法形式

```bash
awk [options] 'script' var=value file(s)
awk [options] -f scriptfile var=value file(s)
```

***
常用命令选项

+ `-F fs`   fs指定输入分隔符，`fs`可以是字符串或正则表达式，如`-F:`
+ `-v var=value`   赋值一个用户定义变量，将外部变量传递给`awk`
+ `-f scripfile`  从脚本文件中读取`awk`命令
+ `-m[fr] val`   对`val`值设置内在限制，`-mf`选项限制分配给`val`的最大块数目；`-mr`选项限制记录的最大数目。这两个功能是Bell实验室版awk的扩展功能，在标准awk中不适用。
+ `--dump-variables[=file] 选项`: 将全局变量及相应值按序输出到指定文件中，默认的输出文件名是 `awkvars.out`。

***
`--lint[=fatal]` 选项

这个选项用于检查程序的可移植情况以及代码中的可疑部分。如果提供了参数 `fatal`，AWK 会将所有的警告信息当作错误信息处理。下面这个简单的示例说明了 `lint` 选项的用法：

`awk --lint '' /bin/ls`

***
`--posix` 选项

这个选项会打开严格 `POSIX` 兼容性审查。 如此，所有共同的以及 GAWK 特定的扩展将被设置为无效。

***
`--profile[=file]` 选项

这个选项会将程序文件以一种很优美的方式输出（译注：用于格式化 awk 脚本文件）。默认输出文件是 `awkprof.out`。示例如下：

```bash
awk --profile 'BEGIN{printf"---|Header|--\n"} {print} END{printf"---|Footer|---\n"}' marks.txt > /dev/null
cat awkprof.out
```

***
`--traditional` 选项

此选项用于禁止 GAWK 相关的扩展

### awk模式和操作

awk脚本是由模式和操作组成的。

***
模式

模式可以是以下任意一个：

+ /正则表达式/：使用通配符的扩展集。
+ 关系表达式：使用运算符进行操作，可以是字符串或数字的比较测试。
+ 模式匹配表达式：用运算符`~`（匹配）和`~!`（不匹配）。
+ `BEGIN`语句块、`pattern`语句块、`END`语句块：参见awk的工作原理

***
操作

操作由一个或多个命令、函数、表达式组成，之间由换行符或分号隔开，并位于大括号内，主要部分是：

+ 变量或数组赋值
+ 输出命令
+ 内置函数
+ 控制流语句

### awk脚本基本结构

```bash
awk 'BEGIN{ print "start" } pattern{ commands } END{ print "end" }' file
```

一个`awk`脚本通常由：`BEGIN`语句块、能够使用模式匹配的通用语句块、`END`语句块3部分组成，这三个部分是可选的。
任意一个部分都可以不出现在脚本中，脚本通常在单引号或双引号中，例如：

```bash
awk 'BEGIN{ i=0 } { i++ } END{ print i }' filename
awk "BEGIN{ i=0 } { i++ } END{ print i }" filename
```

### awk的工作原理

```bash
awk 'BEGIN{ commands } pattern{ commands } END{ commands }'
```

+ 第一步：执行`BEGIN{ commands }`语句块中的语句；
+ 第二步：从文件或标准输入(stdin)读取一行，然后执行`pattern{ commands }`语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，直到文件全部被读取完毕。
+ 第三步：当读至输入流末尾时，执行`END{ commands }`语句块。

`BEGIN`语句块在`awk`开始从输入流中读取行之前被执行，
这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在`BEGIN`语句块中。

`END`语句块在`awk`从输入流中读取完所有的行之后即被执行，
比如打印所有行的分析结果这类信息汇总都是在`END`语句块中完成，它也是一个可选语句块。

`pattern`语句块中的通用命令是最重要的部分，它也是可选的。如果没有提供`pattern`语句块，则默认执行`{ print }`，即打印每一个读取到的行，`awk`读取的每一行都会执行该语句块。

示例

```bash
echo -e "A line 1\nA line 2" | awk 'BEGIN{ print "Start" } { print } END{ print "End" }'
```

当使用不带参数的`print`时，它就打印当前行，当`print`的参数是以逗号进行分隔时，打印时则以空格作为定界符。
在`awk`的`print`语句块中双引号是被当作拼接符使用，例如：

```bash
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1,var2,var3; }'
v1 v2 v3
```

双引号拼接使用：

```bash
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1"="var2"="var3; }'
v1=v2=v3
```

`{ }`类似一个循环体，会对文件中的每一行进行迭代，
通常变量初始化语句（如：`i=0`）以及打印文件头部的语句放入`BEGIN`语句块中，将打印的结果等语句放在`END`语句块中。

### awk内置变量

内置变量，也就是预定义变量

说明：`[A][N][P][G]`表示第一个支持变量的工具，`[A]=awk`、`[N]=nawk`、`[P]=POSIXawk`、`[G]=gawk`

`$n`: 当前记录的第`n`个字段，比如`n`为`1`表示第一个字段，`n`为`2`表示第二个字段。
`$0`: 这个变量包含执行过程中当前行的文本内容。
`ARGC`: (`[N]` ) 命令行参数的数目。
`ARGIND`: (`[G]` ) 命令行中当前文件的位置（从0开始算）。
`ARGV`: (`[N]` ) 包含命令行参数的数组。
`CONVFMT`: (`[G]` ) 数字转换格式（默认值为%.6g）。
`ENVIRON`: (`[P]` ) 环境变量关联数组。
`ERRNO`: (`[N]` ) 最后一个系统错误的描述。
`FIELDWIDTHS`: (`[G]` ) 字段宽度列表（用空格键分隔）。
`FILENAME`: (`[A]` ) 当前输入文件的名。
`FNR`: (`[P]` ) 同NR，但相对于当前文件。
`FS`: (`[A]` ) 字段分隔符（默认是任何空格）。
`IGNORECASE`: (`[G]` ) 如果为真，则进行忽略大小写的匹配。
`NF`: (`[A]` ) 表示字段数，在执行过程中对应于当前的字段数。
`NR`: (`[A]` ) 表示记录数，在执行过程中对应于当前的行号。
`OFMT`: (`[A]` ) 数字的输出格式（默认值是%.6g）。
`OFS`: (`[A]` ) 输出字段分隔符（默认值是一个空格）。
`ORS`: (`[A]` ) 输出记录分隔符（默认值是一个换行符）。
`RS`: (`[A]` ) 记录分隔符（默认是一个换行符）。
`RSTART`: (`[N]` ) 由match函数所匹配的字符串的第一个位置。
`RLENGTH`: (`[N]` ) 由match函数所匹配的字符串的长度。
`SUBSEP`: (`[N]` ) 数组下标分隔符（默认值是34）。

### 内建变量示例

***
简单查询

```bash
echo -e "line1 f2 f3\nline2 f4 f5\nline3 f6 f7" | awk '{print "行数:"NR, "字段总数:"NF, "字段0="$0, "字段1="$1, "字段2="$2, "字段3="$3}'
```

使用`print $NF`可以打印出一行中的最后一个字段，使用`$(NF-1)`则是打印倒数第二个字段，其他以此类推：

```bash
echo -e "line1 f2 f3\n line2 f4 f5" | awk '{print $NF}'
echo -e "line1 f2 f3\n line2 f4 f5" | awk '{print $(NF-1)}'
```

打印每一行的第二和第三个字段：

```bash
awk '{ print $2,$3 }' filename
```

统计文件中的行数：

```bash
awk 'END{ print NR }' filename
```

以上命令只使用了`END`语句块，在读入每一行的时，`awk`会将`NR`更新为对应的行号，
当到达最后一行`NR`的值就是最后一行的行号，所以`END`语句块中的`NR`就是文件的行数。

一个每一行中第一个字段值累加的例子：

```bash
seq 5 | awk 'BEGIN{ sum=0; print "总和：" } { print $1"+"; sum+=$1 } END{ print "等于"; print sum }'
```

`seq` - print a sequence of numbers

### 将外部变量值传递给awk

借助`-v`选项，可以将外部值（并非来自`stdin`）传递给`awk`：

```bash
VAR=10000
echo | awk -v VARIABLE=$VAR '{ print VARIABLE }'
```

另一种传递外部变量方法：

```bash
var1="aaa"
var2="bbb"
echo | awk '{ print v1,v2 }' v1=$var1 v2=$var2
```

当输入来自于文件时使用：

`awk '{ print v1,v2 }' v1=$var1 v2=$var2 filename`

以上方法中，变量之间用空格分隔作为`awk`的命令行参数跟随在`BEGIN`、`{}`和`END`语句块之后。

## awk运算与判断

作为一种程序设计语言所应具有的特点之一，`awk`支持多种运算，这些运算与C语言提供的基本相同。
`awk`还提供了一系列内置的运算函数（如`log`、`sqr`、`cos`、`sin`等）和一些用于对字符串进行操作（运算）的函数（如`length`、`substr`等等）。

这些函数的引用大大的提高了`awk`的运算功能。作为对条件转移指令的一部分，关系判断是每种程序设计语言都具备的功能，`awk`也不例外，`awk`中允许进行多种测试，作为样式匹配，还提供了模式匹配表达式`~`（匹配）和`~!`（不匹配）。
作为对测试的一种扩充，`awk`也支持用逻辑运算符。

***
算术运算符

+ `+ -`  加，减
+ `* / &`  乘，除与求余
+ `+ - !`  一元加，减和逻辑非
+ `^ ***`  求幂
+ `++ --`  增加或减少，作为前缀或后缀

例：

```bash
awk 'BEGIN{a="b";print a++,++a;}'
```

注意：所有用作算术运算符进行操作，操作数自动转为数值，所有非数值都变为0

### 赋值运算符

`= += -= *= /= %= ^= **=  赋值语句`

例：

`a+=5; 等价于：a=a+5; 其它同类`

### 逻辑运算符

+ `||`  逻辑或
+ `&& ` 逻辑与

例：

```bash
awk 'BEGIN{a=1;b=2;print (a>5 && b<=2),(a>5 || b<=2);}'
```

### 正则运算符

`~ ~!`  匹配正则表达式和不匹配正则表达式

例：

```bash
awk 'BEGIN{a="100testa";if(a ~ /^100*/){print "ok";}}'
ok
```

### 关系运算符

`< <= > >= != ==`  关系运算符

例：

```bash
awk 'BEGIN{a=11;if(a >= 9){print "ok";}}'
ok
```

注意：`>`,` < `可以作为字符串比较，也可以用作数值比较，关键看操作数（operand）。
如果是字符串就会转换为字符串比较，两个都为数字才转为数值比较。字符串比较：按照`ASCII`码顺序比较。

### 其它运算符

+ `$`  字段引用
+ `空格`  字符串连接符
+ `?:`  C条件表达式
+ `in`  **数组中**是否存在某**键值**

例：

```bash
awk 'BEGIN{a="b";print a=="b"?"ok":"err";}'
awk 'BEGIN{a="b";arr[0]="b";arr[1]="c";print (a in arr);}'
awk 'BEGIN{a="b";arr[0]="b";arr["b"]="c";print (a in arr);}'
```

### 运算级优先级表

级别越高越优先
级别越高越优先

## awk高级输入输出

### 读取下一条记录

`awk`中`next`语句使用：在循环逐行匹配，如果遇到`next`，就会跳过当前行，直接忽略下面语句。而进行下一行匹配。
`next`语句一般用于多行合并：

```bash
cat text.txt
a
b
c
d
e
awk 'NR%2==1{next}{print NR,$0;}' text.txt
```

当记录行号除以`2`余`1`，就跳过当前行。下面的`print NR,$0`也不会执行。
下一行开始，程序有开始判断`NR%2`值。这个时候记录行号是：`2` ，就会执行下面语句块：`printNR,$0`

***
例子

将包含有`web`的行与下面的行合并：

```bash
cat text.txt
web01[192.168.2.100]
httpd            ok
tomcat               ok
sendmail               ok
web02[192.168.2.101]
httpd            ok
postfix               ok
web03[192.168.2.102]
mysqld            ok
httpd               ok
```

```bash
awk '/^web/{T=$0;next;}{print T":\t"$0;}' test.txt
```

### 简单地读取一条记录

`awk` `getline`用法：输出重定向需用到`getline`函数。

`getline`从标准输入、管道或者当前正在处理的文件之外的其他输入文件获得输入。
它负责从输入获得下一行的内容，并给`NF`,`NR`和`FNR`等内建变量赋值。
如果得到一条记录，`getline`函数返回`1`，如果到达文件的末尾就返回`0`，如果出现错误，例如打开文件失败，就返回`-1`。

`getline`语法：`getline var`，变量`var`包含了特定行的内容。

awk `getline`从整体上来说，用法说明：

当其左右无重定向符`|`或`<`时：`getline`作用于当前文件，读入当前文件的第一行给其后跟的变量`var`或`$0`（无变量时候），
应该注意到，由于`awk`在处理`getline`之前已经读入了一行，所以`getline`得到的返回结果是隔行的。

当其左右有重定向符`|`或`<`时：`getline`则作用于定向输入文件，
由于该文件是刚打开，并没有被`awk`读入一行，只是`getline`读入，那么`getline`返回的是该文件的第一行，而不是隔行。

示例：

执行`linux`的`date`命令，并通过管道输出给`getline`，然后再把输出赋值给自定义变量`out`，并打印它：

```bash
awk 'BEGIN{ "date" | getline out; print out }' test
```

执行`shell`的`date`命令，并通过管道输出给`getline`，然后`getline`从管道中读取并将输入赋值给`out`，`split`函数把变量`out`转化成数组`mon`，然后打印数组`mon`的第二个元素：

```bash
awk 'BEGIN{ "date" | getline out; split(out,mon); print mon[2] }' test
```

命令`ls`的输出传递给`geline`作为输入，循环使`getline`从`ls`的输出中读取一行，并把它打印到屏幕。
这里没有输入文件，因为`BEGIN`块在打开输入文件前执行，所以可以忽略输入文件。

```bash
awk 'BEGIN{ while( "ls" | getline) print }'
```

### 关闭文件

`awk`中允许在程序中关闭一个**输入或输出**文件，方法是使用`awk`的`close`语句。

`close("filename")`

`filename`可以是`getline`打开的文件，也可以是`stdin`，包含文件名的变量，或者`getline`使用的确切命令。
或一个输出文件，可以是`stdout`，包含文件名的变量或使用管道的确切命令。

### 输出到一个文件

`awk`中允许用如下方式将结果输出到一个文件：

`echo | awk '{printf("hello word!n") > "datafile"}'`
或
`echo | awk '{printf("hello word!n") >> "datafile"}'`

## 设置字段定界符

默认的字段定界符是空格，可以使用`-F "定界符"` 明确指定一个定界符：

`awk -F: '{ print $NF }' /etc/passwd`
或
`awk 'BEGIN{ FS=":" } { print $NF }' /etc/passwd`

在`BEGIN`语句块中则可以用`OFS=“定界符”`设置输出字段的定界符。

## 流程控制语句

`linux awk`的`while`、`do-while`和`for`语句允许使用`break`,`continue`语句来控制流程走向，也允许使用`exit`这样的语句来退出。

`break`中断当前正在执行的循环并跳到循环外执行下一条语句。`if `是流程选择用法。
`awk`中，流程控制语句，语法结构，与c语言类似。有了这些语句，其实很多`shell`程序都可以交给`awk`，而且性能是非常快的。
下面是各个语句用法。

### 条件判断语句

```bash
if(表达式)
  {语句1}
else
  {语句2}
```

格式中`语句1`可以是多个语句，为了方便判断和阅读，最好将多个语句用`{}`括起来。`awk`分枝结构允许嵌套，其格式为：

```bash
if(表达式)
  {语句1}
else if(表达式)
  {语句2}
else
  {语句3}
```

示例：

```bash
awk 'BEGIN{
test=100;
if(test>90){
  print "very good";
  }
  else if(test>60){
    print "good";
  }
  else{
    print "no pass";
  }
}'
```

每条命令语句后面可以用`;`分号结尾。

### 循环语句

`while`语句

```bash
while(表达式)
  {语句}
```

示例：

```bash
awk 'BEGIN{
test=100;
total=0;
while(i<=test){
  total+=i;
  i++;
}
print total;
}'
```

***
`for`循环

`for`循环有两种格式：

格式1：

```bash
for(变量 in 数组)
  {语句}
```

示例：

```bash
awk 'BEGIN{
for(k in ENVIRON){
  print k"="ENVIRON[k];
}
}'
```

注：`ENVIRON`是`awk`常量，是字典型数组。

格式2：

```bash
for(变量;条件;表达式)
  {语句}
```

示例：

```bash
awk 'BEGIN{
total=0;
for(i=0;i<=100;i++){
  total+=i;
}
print total;
}'
```

***
`do`循环

```bash
do
{语句} while(条件)
```

例子：

```bash
awk 'BEGIN{
total=0;
i=0;
do {total+=i;i++;} while(i<=100)
  print total;
}'
```

### 其他语句

+ `break` 当 `break` 语句用于 `while` 或 `for` 语句时，导致退出程序循环。
+ `continue` 当 `continue` 语句用于 `while` 或 `for` 语句时，使程序循环移动到下一个迭代。
+ `next` 能能够导致读入下一个输入行，并返回到脚本的顶部。这可以避免对当前输入行执行其他的操作过程。
+ `exit` 语句使主输入循环退出并将控制转移到`END`,如果`END`存在的话。如果没有定义`END`规则，或在`END`中应用`exit`语句，则终止脚本的执行。

## 数组应用

数组是`awk`的灵魂，处理文本中最不能少的就是它的数组处理。
`awk`的数组索引（下标）可以是**数字**或者**字符串**，所以`awk`的数组叫做关联数组(associative arrays)。
`awk` 中的数组不必提前声明，也不必声明大小。数组元素用`0`或**空字符串**来初始化，这根据上下文而定。

### 数组的定义

数字做数组索引（下标）：

```bash
Array[1]="sun"
Array[2]="kai"
```

字符串做数组索引（下标）：

```bash
Array["first"]="www"
Array["last"]="name"
Array["birth"]="1987"
```

使用中`print Array[1]`会打印出`sun`；使用`print Array[2]`会打印出`kai`；使用`print["birth"]`会得到`1987`。

读取数组的值

```bash
{ for(item in array) {print array[item]}; }       #输出的顺序是随机的
{ for(i=1;i<=len;i++) {print array[i]}; }         #Len是数组的长度
```

### 数组相关函数

得到数组长度：

```bash
awk 'BEGIN{info="it is a test";lens=split(info,tA," ");print length(tA),"length is:"lens;}'
```

`length`返回字符串以及数组长度，`split`进行分割字符串为数组，也会返回分割得到数组长度。

```bash
awk 'BEGIN{info="it is a test";split(info,tA," ");print asort(tA);for (k in tA){print k,tA[k];}}'
```

`asort`对数组进行排序，返回数组长度。

输出数组内容（无序，有序输出）：

```bash
awk 'BEGIN{info="it is a test";split(info,tA," ");for(k in tA){print k,tA[k];}}'
```

`for…in`输出，因为数组是关联数组，默认是无序的。所以通过`for…in`得到是无序的数组。如果需要得到有序数组，需要通过下标获得。

```bash
awk 'BEGIN{info="it is a test";tlen=split(info,tA," ");for(k=1;k<=tlen;k++){print k,tA[k];}}'
```

注意：数组下标是从`1`开始，与`C`数组不一样。

判断键值存在以及删除键值：

```bash
#错误的判断方法：
awk 'BEGIN{tB["a"]="a1";tB["b"]="b1";if(tB["c"]!="1"){print "no found";};for(k in tB){print k,tB[k];}}'
no found
a a1
b b1
c
```

以上出现奇怪问题，`tB["c"]`没有定义，但是循环时候，发现已经存在该键值，它的值为空。
这里需要注意，`awk`数组是关联数组，只要通过数组引用它的`key`，就会自动创建改序列。

```bash
#正确判断方法：
awk 'BEGIN{tB["a"]="a1";tB["b"]="b1";if( "c" in tB){print "ok";};for(k in tB){print k,tB[k];}}'
a a1
b b1
```

`if(key in array)`通过这种方法判断数组中是否包含`key`键值。

```bash
#删除键值：
[chengmo@localhost ~]$ awk 'BEGIN{tB["a"]="a1";tB["b"]="b1";delete tB["a"];for(k in tB){print k,tB[k];}}'
b b1
```

`delete array[key]`可以删除，对应数组`key`的，序列值。

### 二维、多维数组使用

`awk`的多维数组在本质上是一维数组，更确切一点，`awk`在存储上并不支持多维数组。`awk`提供了逻辑上模拟二维数组的访问方式。
例如，`array[2,4]=1`这样的访问是允许的。`awk`使用一个特殊的字符串`SUBSEP`作为分割字段，在上面的例子中，关联数组array存储的键值实际上是`2SUBSEP4`。

类似一维数组的成员测试，多维数组可以使用`if ( (i,j) in array)`这样的语法，但是下标必须放置在圆括号中。

```bash
awk 'BEGIN{
for(i=1;i<=4;i++){
  for(j=1;j<=4;j++){
    tarr[i,j]=i*j;
  }
}
if ((4,5) in tarr)
{print tarr[4,5]}
else
{print "does not exist"}

if ((4,4) in tarr)
{print tarr[4,4]}
else
{print "does not exist"}
}'

类似一维数组的循环访问，多维数组使用`for ( item in array )`这样的语法遍历数组。

```bash
awk 'BEGIN{
for(i=1;i<=4;i++){
  for(j=1;j<=4;j++){
    tarr[i,j]=i*j;
  }
}
for(m in tarr){
  print m,tarr[m];
}
}'
```

与一维数组不同的是，多维数组必须使用`split()`函数来访问单独的下标分量。

```bash
awk 'BEGIN{
for(i=1;i<=9;i++){
  for(j=1;j<=9;j++){
    tarr[i,j]=i*j; print i,"*",j,"=",tarr[i,j];
  }
}
}'
```

可以通过`array[k,k2]`引用获得数组内容。

另一种方法：

```bash
awk 'BEGIN{
for(i=1;i<=9;i++){
  for(j=1;j<=9;j++){
    tarr[i,j]=i*j;
  }
}
for(m in tarr){
  split(m,tarr2,SUBSEP); print tarr2[1],"*",tarr2[2],"=",tarr[m];
}
}'
```

## 内置函数

`awk`内置函数，主要分以下`3`种类似：算数函数、字符串函数、其它一般函数、时间函数。

### 算术函数

+ `atan2(y, x)`  返回 y/x 的反正切。
+ `cos(x)`  返回 `x` 的余弦；`x` 是弧度。
+ `sin(x)`  返回 `x` 的正弦；`x` 是弧度。
+ `exp(x)`  返回 `x` 幂函数。
+ `log(x)`  返回 `x` 的自然对数。
+ `sqrt(x)`  返回 `x` 平方根。
+ `int(x)`  返回 `x` 的截断至整数的值。
+ `rand( )`  返回任意数字 `n`，其中 `0 <= n < 1`。
+ `srand( [expr])`  将 `rand` 函数的种子值设置为 `Expr` 参数的值，或如果省略 `Expr` 参数则使用某天的时间。返回先前的种子值。

举例说明：

```bash
awk 'BEGIN{OFMT="%.3f";fs=sin(1);fe=exp(10);fl=log(10);fi=int(3.1415);print fs,fe,fl,fi;}'
0.841 22026.466 2.303 3
```

`OFMT` 设置输出数据格式是保留`3`位小数。

获得随机数：

```bash
awk 'BEGIN{srand();fr=int(100*rand());print fr;}'
awk 'BEGIN{srand();fr=int(100*rand());print fr;}'
awk 'BEGIN{srand();fr=int(100*rand());print fr;}'
```

### 字符串函数

+ `gsub(Ere, Repl, [In] )`  和`sub`函数类似，只不过进行所有可能的替换。
+ `sub(Ere, Repl, [In] )`  匹配`In`中由 `Ere` 指定的字符串（扩展正则表达式），并用 `Repl`参数替换，只替换第一个具体值。`sub`函数返回替换的数量。用`&`来进行匹配结果的引用。如果未指定 `In` 参数，缺省值是整个记录（`$0` 记录变量）。
+ `index(str1,str2)`  返回`str2`在`str1`中的位置，从 1 开始编号。如果 `str2`参数不在`str1`中出现，则返回`0`（零）。
+ `length [(str)]`  返回 `str` 参数指定的字符串的长度（字符形式）。如果未给出 `str`，则返回整个记录的长度（`$0`的长度）。
+ `blength [(str)]`  返回 `str` 参数指定的字符串的长度（以**字节**为单位）。如果未给出 `str` 参数，则返回整个记录的长度（`$0`的长度）。
+ `substr(str,M,[N])`  返回`str`中长度为`N`的字符子串。子串从 `M`指定的位置开始。 `str` 中的第一个字符编号为 `1`。如果未指定 `N` 参数，则默认取到 `str` 的末尾。
+ `match(str,Ere)`  返回 `str`中`Ere`的位置（字符形式），从`1` 开始编号。如果 Ere 参数不出现，则返回 `0`。`RSTART` 特殊变量记录返回值。`RLENGTH` 特殊变量记录匹配字符串的长度，或如果未找到任何匹配，则值为 `-1`。
+ `split(str,A,[Ere])`  将 `str` 分割为数组 `A[1]`, `A[2]`, `. . .`, `A[n]`，并返回`n`（数组的长度）。分隔符为`Ere`指定的扩展正则表达式。如果没有给出 `Ere` 参数，则为当前字段分隔符（`FS` 特殊变量）。
除非上下文指明特定的元素为数字值，否则 `A` 中的元素为字符串。
+ `tolower(str)`  返回 `str` 的小写形式，大写和小写的映射由当前语言环境的 `LC_CTYPE` 范畴定义。
+ `toupper(str)`  返回 `str` 的大写形式，大写和小写的映射由当前语言环境的`LC_CTYPE` 范畴定义。
+ `sprintf(Format, Expr, Expr, . . . )`  根据 `Format` 参数指定的 `printf` 格式字输出 `Expr` 参数指定的表达式，并返回最后生成的字符串。

注：`Ere`都可以是正则表达式。

***
`gsub`,`sub`

```bash
awk 'BEGIN{info="this is a test2010test!";gsub(/[0-9]+/,"AAA",info);print info}'
```

在`info`中查找`/[0-9]+/ `,并用`"AAA"`替换，并将替换后的值，赋给`info`。
如果未给出`info`参数，则默认为`$0`。

***
查找字符串`index`

```bash
awk 'BEGIN{info="this is a test2010test!";print index(info,"test")?"ok":"no found";}'
## or
awk 'BEGIN{info="this is a test2010test!";
if(index(info,"test"))
{print "Ok";}
else{print "not found";}
}'
## or
awk 'BEGIN{info="this is a test2010test!";
if("test" in info)
{print "Ok";}
else{print "not found";}
}'
```

***
正则表达式匹配查找`match`

```bash
awk 'BEGIN{info="this is a test2010test!";print match(info,/[0-9]+/)?"ok":"no found";}'
```

***
截取字符串`substr`

```bash
awk 'BEGIN{info="this is a test2010test!";print substr(info,4,10);}'

```

从第 4个 字符开始，截取10个长度字符串

***
字符串分割`split`

awk 'BEGIN{info="this is a test";split(info,tA," ");print length(tA);for(k in tA){print k,tA[k];}}'

分割`info`，动态创建数组`tA`。`awk`中的`for …in`循环，是一个无序的循环。
并不是按照数组下标`1…n`循环 ，因此使用时候需要注意。

***
格式化字符串输出`sprintf`

格式化的字符串包括两部分内容（内容和格式）：
一部分是正常字符，这些字符将按原样输出;
另一部分是格式控制字符，以`"%"`开始，后跟一个或几个规定字符,用来确定输出内容格式。

格式  描述

+ `%d`  十进制有符号整数
+ `%u`  十进制无符号整数
+ `%f`  浮点数
+ `%s`  字符串
+ `%c`  单个字符
+ `%p`  指针的值
+ `%e`  指数形式的浮点数
+ `%x`  `%X` 无符号以十六进制表示的整数
+ `%o`  无符号以八进制表示的整数
+ `%g`  自动选择合适的表示法

```bash
awk 'BEGIN{n1=124.113;n2=-1.224;n3=1.2345; printf("%.2f,%.2u,%.2g,%X,%o\n",n1,n2,n3,n1,n1);}'
```

### 一般函数

格式  描述

+ `close(Expression)`  用同一个 `Expression`参数（值为字符串）来关闭文件或管道。它们由 `print`或`printf` 语句或`getline` 函数打开。
如果文件或管道成功关闭，则返回`0`；其它情况下返回非零值。
如果打算写一个文件，并稍后在同一个程序中读取文件，则`close`语句是必需的。
+ `system(command)`  执行 `Command` 参数指定的命令，并返回退出状态。等同于 `system` 子例程。
+ `Expression | getline [Variable]`  将 `Expression`的值当作命令执行，然后从管道传送的流中读取一个输入记录，并将该记录的值赋给`Variable`。如果当前不存在执行`Expression`得到的流，则创建一个。
创建的流等同于调用 `popen` 子例程，此时 `Command` 参数取 `Expression` 的值且 `Mode` 为`r`。
只要流保留打开且`Expression`不变，则`getline`函数继续读取下一个记录。如果未指定 `Variable` 参数，则使用 `$0` 和`NF`存储记录。
+ `getline [Variable] < Expression` 从`Expression`指定的文件读取下一个记录，并将 `Variable`设置为该记录的值。只要流保留打开且`Expression`的值不变，则`getline`函数继续往下读取记录。
如果未指定 `Variable` 参数，则使用 `$0` 和`NF`存储记录。
+ `getline [Variable]`  将 `Variable` 设置为下一个输入记录。如果未指定 `Variable` 参数，则使用`$0`,`NF`、`NR` 和 `FNR` 特殊变量。

### 打开外部文件（close用法）

```bash
awk 'BEGIN{while("cat /etc/passwd"|getline){print $0;};close("/etc/passwd");}'
```

逐行读取外部文件

```bash
awk 'BEGIN{while(getline < "/etc/passwd"){print $0;};close("/etc/passwd");}'
```

```bash
awk 'BEGIN{print "Enter your name:";getline name;print name;}'
```

调用外部应用程序

```bash
awk 'BEGIN{b=system("ls -al");print b;}'
```

### 时间函数

函数名  说明

+ `mktime( YYYY MM dd HH MM ss[ DST])` 生成时间格式
+ `strftime([format [, timestamp]])` 格式化时间输出，将时间戳转为时间字符串，具体格式见下表。
+ `systime()`  得到时间戳,返回从`1970年1月1日`开始到当前时间(不计闰年)的整秒数

建指定时间(mktime使用）

```bash
awk 'BEGIN{tstamp=mktime("2001 01 01 12 12 12");print strftime("%c",tstamp);}'
```

```bash
awk 'BEGIN{tstamp1=mktime("2001 01 01 12 12 12");tstamp2=mktime("2001 02 01 0 0 0");print tstamp2-tstamp1;}'
```

***
strftime日期和时间格式说明符

格式  描述

+ `%a`  星期几的缩写(Sun)
+ `%A`  星期几的完整写法(Sunday)
+ `%b`  月名的缩写(Oct)
+ `%B`  月名的完整写法(October)
+ `%c`  本地日期和时间
+ `%d`  十进制日期
+ `%D`  日期 `08/20/99`
+ `%e`  日期，如果只有一位会补上一个空格
+ `%H`  用十进制表示24小时格式的小时
+ `%I`  用十进制表示12小时格式的小时
+ `%j`  从`1`月`1`日起一年中的第几天
+ `%m`  十进制表示的月份
+ `%M`  十进制表示的分钟
+ `%p`  12小时表示法(AM/PM)
+ `%S`  十进制表示的秒
+ `%U`  十进制表示的一年中的第几个星期(星期天作为一个星期的开始)
+ `%w`  十进制表示的星期几(星期天是0)
+ `%W`  十进制表示的一年中的第几个星期(星期一作为一个星期的开始)
+ `%x`  重新设置本地日期(08/20/99)
+ `%X`  重新设置本地时间(12：00：00)
+ `%y`  两位数字表示的年(99)
+ `%Y`  当前月份
+ `%Z`  时区(PDT)
+ `%%`  百分号(%)

## 一些示例

### 分隔文件

下面这个例子，是按第`6`例分隔文件，相当的简单（其中的`NR!=1`表示不处理表头）。

`awk 'NR!=1{print > $6}' netstat.txt`

你也可以把指定的列输出到文件：

`awk 'NR!=1{print $4,$5 > $6}' netstat.txt`

再复杂一点：（注意其中的`if-else-if`语句，可见`awk`其实是个脚本解释器）

```bash
$ awk 'NR!=1{if($6 ~ /TIME|ESTABLISHED/) print > "1.txt";
else if($6 ~ /LISTEN/) print > "2.txt";
else print > "3.txt" }' netstat.txt
```

### 统计

下面的命令计算所有的`C`文件，`CPP`文件和`H`文件的文件大小总和。

```bash
$ ls -l  *.cpp *.c *.h | awk '{sum+=$5} END {print sum}'
```

***
注：如果你要指定多个分隔符，你可以这样来：

awk -F '[;:]'

***
如果我们需要表头的话，我们可以引入内建变量NR：

```bash
awk '$3==0 && $6=="LISTEN" || NR==1 ' netstat.txt
```

### 环境变量

即然说到了脚本，我们来看看怎么和环境变量交互：（使用`-v`参数和`ENVIRON`，使用`ENVIRON`的环境变量需要`export`）

```bash
$ x=5
$ y=10
$ export y
$ echo $x $y
5 10
$ awk -v val=$x '{print $1, $2, $3, $4+val, $5+ENVIRON["y"]}' OFS="\t" score.txt
```

### 几个花活

[AWK 简明教程][]

```bash
#从file文件中找出长度大于80的行
awk 'length>80' file
#按连接数查看客户端IP
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr
#打印99乘法表
seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")}'
```

[AWK 简明教程]: https://coolshell.cn/articles/9070.html