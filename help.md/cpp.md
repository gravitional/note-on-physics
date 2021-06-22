# cpp

[runoob-cpp](https://www.runoob.com/cplusplus/cpp-environment-setup.html).

## g++ 应用说明

程序 `g++` 是将 `gcc` 默认语言设为 `C++` 的一个特殊的版本，链接时它自动使用 `C++` 标准库而不用 `C` 标准库。通过遵循源码的命名规范并指定对应库的名字，用 `gcc` 来编译链接 `C++` 程序是可行的，如下例所示：

```bash
gcc main.cpp -lstdc++ -o main
gcc helloworld.cpp -lstdc++ -o helloworld
```

下面是一个保存在文件 `helloworld.cpp` 中一个简单的 `C++` 程序的代码：

```cpp
#include <iostream>
using namespace std;
int main()
{
    cout << "Hello, world!" << endl;
    return 0;
}
```

最简单的编译方式：

```bash
g++ helloworld.cpp
```

由于命令行中未指定可执行程序的文件名，编译器采用默认的 `a.out`。程序可以这样来运行：

```bash
$ ./a.out
Hello, world!
```

通常我们使用 `-o` 选项指定可执行程序的文件名，以下实例生成一个 `helloworld` 的可执行文件：

```bash
g++ helloworld.cpp -o helloworld
```

执行 `helloworld`:

```bash
$ ./helloworld
Hello, world!
```

如果是多个`C++`代码文件，如 `runoob1.cpp、runoob2.cpp`，编译命令如下：

```bash
g++ runoob1.cpp runoob2.cpp -o runoob
```

生成一个`runoob`可执行文件。

`g++`有些系统默认是使用`C++98`，我们可以指定使用`C++11`来编译`main.cpp`文件：

```bash
g++ -g -Wall -std=c++11 main.cpp
```

`g++`常用命令选项

| 选项           | 解释                                                                                       |
| -------------- | ------------------------------------------------------------------------------------------ |
| `-ansi`        | `只支持 ANSI 标准的 C 语法。这一选项将禁止 GNU C 的某些特色， 例如 asm 或 typeof 关键词。` |
| `-c`           | `只编译并生成目标文件。`                                                                   |
| `-DMACRO`      | `以字符串"1"定义 MACRO 宏。`                                                               |
| `-DMACRO=DEFN` | `以字符串"DEFN"定义 MACRO 宏。`                                                            |
| `-E`           | `只运行 C 预编译器。`                                                                      |
| `-g`           | `生成调试信息。GNU 调试器可利用该信息。`                                                   |
| `-IDIRECTORY`  | `指定额外的头文件搜索路径DIRECTORY。`                                                      |
| `-LDIRECTORY`  | `指定额外的函数库搜索路径DIRECTORY。`                                                      |
| `-lLIBRARY`    | `连接时搜索指定的函数库LIBRARY。`                                                          |
| `-m486`        | `针对 486 进行代码优化。`                                                                  |
| `-o`           | `FILE 生成指定的输出文件。用在生成可执行文件时。`                                          |
| `-O0`          | `不进行优化处理。`                                                                         |
| `-O`           | `或 -O1 优化生成代码。`                                                                    |
| `-O2`          | `进一步优化。`                                                                             |
| `-O3`          | `比 -O2 更进一步优化，包括 inline 函数。`                                                  |
| `-shared`      | `生成共享目标文件。通常用在建立共享库时。`                                                 |
| `-static`      | `禁止使用共享连接。`                                                                       |
| `-UMACRO`      | `取消对 MACRO 宏的定义。`                                                                  |
| `-w`           | `不生成任何警告信息`                                                                       |
| `-Wall`        | `生成所有警告信息`                                                                         |

## C++ 基本语法

`C++`程序可以定义为对象的集合，这些对象通过调用彼此的方法进行交互。
现在让我们简要地看一下什么是类、对象，方法、即时变量。

+ **对象** - 对象具有状态和行为。例如：一只狗的状态 - 颜色、名称、品种，行为 - 摇动、叫唤、吃。对象是类的实例。
+ **类** - 类可以定义为描述对象行为/状态的模板/蓝图。
+ **方法** - 从基本上说，一个方法表示一种行为。一个类可以包含多个方法。可以在方法中写入逻辑、操作数据以及执行所有的动作。
+ **即时变量** - 每个对象都有其独特的即时变量。对象的状态是由这些即时变量的值创建的。

### C++ 程序结构

让我们看一段简单的代码，可以输出单词 `Hello World`。

实例

```cpp
#include <iostream>
using namespace std;

// main() 是程序开始执行的地方

int main()
{
   cout << "Hello World"; // 输出 Hello World
   return 0;
}
```

接下来我们讲解一下上面这段程序：

+ C++ 语言定义了一些头文件，这些头文件包含了程序中必需的或有用的信息。上面这段程序中，包含了头文件`<iostream>`。
+ 下一行 `using namespace std`; 告诉编译器使用`std`命名空间。命名空间是 `C++` 中一个相对新的概念。
+ 下一行 `// main()` 是程序开始执行的地方 是一个单行注释。单行注释以 `//` 开头，在行末结束。
+ 下一行 `int main()` 是主函数，程序从这里开始执行。
+ 下一行 `cout << "Hello World"`; 会在屏幕上显示消息 "`Hello World`"。
+ 下一行 `return 0`; 终止 `main( )`函数，并向调用进程返回值 `0`。

### 编译 & 执行 C++ 程序

接下来让我们看看如何把源代码保存在一个文件中，以及如何编译并运行它。下面是简单的步骤：

+ 打开一个文本编辑器，添加上述代码。
+ 保存文件为 `hello.cpp`。
+ 打开命令提示符，进入到保存文件所在的目录。
+ 键入 '`g++ hello.cpp`'，输入回车，编译代码。如果代码中没有错误，命令提示符会跳到下一行，并生成 `a.out` 可执行文件。
+ 现在，键入 `a.out` 来运行程序。
+ 您可以看到屏幕上显示 '`Hello World`'。

```bash
$ g++ hello.cpp
"nothing"
$ ./a.out
Hello World
```

请确保您的路径中已包含 `g++` 编译器，并确保在包含源文件 `hello.cpp` 的目录中运行它。您也可以使用 `makefile` 来编译 `C/C++` 程序。

### C++ 中的分号 & 语句块

在 `C++` 中，分号是语句结束符。也就是说，每个语句必须以分号结束。它表明一个逻辑实体的结束。

例如，下面是三个不同的语句：

```cpp
x = y;
y = y+1;
add(x, y);
```

语句块是一组使用大括号括起来的按逻辑连接的语句。例如：

```cpp
{
   cout << "Hello World"; // 输出 Hello World
   return 0;
}
```

`C++` 不以行末作为结束符的标识，因此，您可以在一行上放置多个语句。例如：

```cpp
x = y;
y = y+1;
add(x, y);
```

等同于

```cpp
x = y; y = y+1; add(x, y);
```

### C++ 标识符

`C++` 标识符是用来标识变量、函数、类、模块，或任何其他用户自定义项目的名称。
一个标识符以字母 `A-Z` 或 `a-z` 或下划线 `_` 开始，后跟零个或多个字母、下划线和数字（`0-9`）。

`C++` 标识符内不允许出现标点字符，比如 `@`、`&` 和 `%`。`C++`是区分大小写的编程语言。
因此，在 `C++` 中，`Manpower` 和 `manpower` 是两个不同的标识符。

下面列出几个有效的标识符：

```cpp
mohd       zara    abc   move_name  a_123
myname50   _temp   j     a23b9      retVal
```

### C++ 关键字

下表列出了 `C++` 中的保留字。这些保留字不能作为常量名、变量名或其他标识符名称。

|              |           |                  |          |
| ------------ | --------- | ---------------- | -------- |
| asm          | else      | new              | this     |
| auto         | enum      | operator         | throw    |
| bool         | explicit  | private          | true     |
| break        | export    | protected        | try      |
| case         | extern    | public           | typedef  |
| catch        | false     | register         | typeid   |
| char         | float     | reinterpret_cast | typename |
| class        | for       | return           | union    |
| const        | friend    | short            | unsigned |
| const_cast   | goto      | signed           | using    |
| continue     | if        | sizeof           | virtual  |
| default      | inline    | static           | void     |
| delete       | int       | static_cast      | volatile |
| do           | long      | struct           | wchar_t  |
| double       | mutable   | switch           | while    |
| dynamic_cast | namespace | templat          |          |

完整关键字介绍可查阅：[C++ 的关键字（保留字）完整介绍][]

[C++ 的关键字（保留字）完整介绍]: https://www.runoob.com/w3cnote/cpp-keyword-intro.html

### 三字符组

**三字符组**就是用于表示**另一个字符**的**三个字符序列**，又称为**三字符序列**。三字符序列总是以两个问号开头。
三字符序列不太常见，但 `C++` 标准允许把某些字符指定为三字符序列。以前为了表示键盘上没有的字符，这是必不可少的一种方法。

三字符序列**可以出现在任何地方**，包括`字符串`、`字符序列`、`注释`和`预处理指令`。
下面列出了最常用的三字符序列：

| 三字符组 | 替换 |
| -------- | ---- |
| `??=`    | `#`  |
| `??/`    | `\`  |
| `??'`    | `^`  |
| `??(`    | `[`  |
| `??)`    | `]`  |
| `??!`    | `|`  |
| `??<`    | `{`  |
| `??>`    | `}`  |
| `??-`    | `~`  |

如果希望在源程序中有两个连续的问号，且不希望被预处理器替换，这种情况出现在字符常量、字符串字面值或者是程序注释中，
可选办法是用字符串的自动连接：`"...?""?..."`或者转义序列：`"...?\?..."`。

从`Microsoft Visual C++ 2010`版开始，**该编译器默认不再自动替换三字符组**。
如果需要使用三字符组替换（如为了兼容古老的软件代码），需要设置编译器命令行选项`/Zc:trigraphs`

`g++`**仍默认支持三字符组**，但会给出编译警告。

### C++ 中的空格

只包含空格的行，被称为空白行，可能带有注释, `C++`编译器会完全忽略它。

在 `C++` 中，空格用于描述`空白符`、`制表符`、`换行符`和`注释`。
空格分隔语句的各个部分，让编译器能识别语句中的某个元素（比如 `int`）在哪里结束，下一个元素在哪里开始。因此，在下面的语句中：

```cpp
int age;
```

在这里，`int` 和 `age` 之间必须至少有一个`空格字符`（通常是一个`空白符`），这样编译器才能够区分它们。另一方面，在下面的语句中：

```cpp
fruit = apples + oranges;   // 获取水果的总数
```

`fruit` 和 `=`，或者 `=` 和 `apples` 之间的空格字符不是必需的，但是为了增强可读性，您可以根据需要适当增加一些空格。

## C++ 注释

程序的注释是解释性语句，您可以在 `C++` 代码中包含注释，这将提高源代码的可读性。
所有的编程语言都允许某种形式的注释。

`C++` 支持单行注释和多行注释。注释中的所有字符会被 `C++` 编译器忽略。

`C++` 注释以 `/*` 开始，以 `*/` 终止。例如：

```cpp
/* 这是注释 */

/* C++ 注释也可以
 * 跨行
 */
```

注释也能以 `//` 开始，直到行末为止。例如：

实例

```cpp
#include <iostream>
using namespace std;

int main()
{
   cout << "Hello World"; // 输出 Hello World

   return 0;
}
```

当上面的代码被编译时，编译器会忽略 `//` 输出 `Hello World`，最后会产生以下结果：

```cpp
Hello World
```

在 `/*` 和 `*/` 注释内部，`//` 字符没有特殊的含义。在 `//` 注释内，`/*` 和 `*/` 字符也没有特殊的含义。因此，您可以在一种注释内嵌套另一种注释。例如：

```cpp
/* 用于输出 Hello World 的注释

cout << "Hello World"; // 输出 Hello World

*/
```

## C++ 数据类型

使用编程语言进行编程时，需要用到各种变量来存储各种信息。变量保留的是它所存储的值的内存位置。这意味着，当您创建一个变量时，就会在内存中保留一些空间。

您可能需要存储各种数据类型（比如`字符型`、`宽字符型`、`整型`、`浮点型`、`双浮点型`、`布尔型`等）的信息，操作系统会根据变量的数据类型，来分配内存和决定在保留内存中存储什么。

### 基本的内置类型

`C++` 为程序员提供了种类丰富的内置数据类型和用户自定义的数据类型。下表列出了七种基本的 `C++` 数据类型：

| 类型     | `关键字`  |
| -------- | --------- |
| 布尔型   | `bool`    |
| 字符型   | `char`    |
| 整型     | `int`     |
| 浮点型   | `float`   |
| 双浮点型 | `double`  |
| 无类型   | `void`    |
| 宽字符型 | `wchar_t` |

其实 `wchar_t` 是这样来的：

```cpp
typedef short int wchar_t;
```

所以 `wchar_t` 实际上的空间是和 `short int` 一样。

一些基本类型可以使用一个或多个类型修饰符进行修饰：

+ `signed`
+ `unsigned`
+ `short`
+ `long`

下表显示了各种变量类型在内存中存储值时需要占用的内存，以及该类型的变量所能存储的最大值和最小值。

注意：不同系统会有所差异。

| 类型                 | 位         | 范围                                                               |
| -------------------- | ---------- | ------------------------------------------------------------------ |
| `char`               | 1个字节    | `-128到127 或者 0到255`                                            |
| `unsigned char`      | 1 个字节   | `0到255`                                                           |
| `signed char`        | 1个字节    | `-128到127`                                                        |
| `int`                | 4个字节    | `-2147483648到2147483647`                                          |
| `unsigned  int`      | 4个字节    | `0到4294967295`                                                    |
| `signed int`         | 4个字节    | `-2147483648到2147483647`                                          |
| `short int`          | 2个字节    | `-32768到32767`                                                    |
| `unsigned short int` | 2个字节    | `0到65,535`                                                        |
| `signed short int`   | 2个字节    | `-32768到32767`                                                    |
| `long int`           | 8个字节    | `-9,223,372,036,854,775,808 到 9,223,372,036,854,775,807`          |
| `signed long int`    | 8个字节    | `-9,223,372,036,854,775,808 到 9,223,372,036,854,775,807`          |
| `unsigned long int`  | 8个字节    | `0到18,446,744,073,709,551,615`                                    |
| `float`              | 4个字节    | `精度型占4个字节（32位）内存空间，+/- 3.4e +/- 38 (~7 个数字)`     |
| `double`             | 8个字节    | `双精度型占8个字节（64位）内存空间，+/- 1.7e +/- 308 (~15 个数字)` |
| `long double`        | 16个字节   | `长双精度型16个字节（128位）内存空间，可提供18-19位有效数字。`     |
| `wchar_t`            | 2或4个字节 | `1个宽字符`                                                        |

从上表可得知，变量的大小会根据编译器和所使用的电脑而有所不同。
下面实例会输出您电脑上各种数据类型的大小。

```cpp
#include<iostream>

using namespace std;

int main()
{
    cout << "type: \t\t" << "************size**************"<< endl;
    cout << "bool: \t\t" << "所占字节数：" << sizeof(bool);
    cout << "\t最大值：" << (numeric_limits<bool>::max)();
    cout << "\t\t最小值：" << (numeric_limits<bool>::min)() << endl;
    cout << "char: \t\t" << "所占字节数：" << sizeof(char);
    cout << "\t最大值：" << (numeric_limits<char>::max)();
    cout << "\t\t最小值：" << (numeric_limits<char>::min)() << endl;
    cout << "signed char: \t" << "所占字节数：" << sizeof(signed char);
    cout << "\t最大值：" << (numeric_limits<signed char>::max)();
    cout << "\t\t最小值：" << (numeric_limits<signed char>::min)() << endl;
    cout << "unsigned char: \t" << "所占字节数：" << sizeof(unsigned char);
    cout << "\t最大值：" << (numeric_limits<unsigned char>::max)();
    cout << "\t\t最小值：" << (numeric_limits<unsigned char>::min)() << endl;
    cout << "wchar_t: \t" << "所占字节数：" << sizeof(wchar_t);
    cout << "\t最大值：" << (numeric_limits<wchar_t>::max)();
    cout << "\t\t最小值：" << (numeric_limits<wchar_t>::min)() << endl;
    cout << "short: \t\t" << "所占字节数：" << sizeof(short);
    cout << "\t最大值：" << (numeric_limits<short>::max)();
    cout << "\t\t最小值：" << (numeric_limits<short>::min)() << endl;
    cout << "int: \t\t" << "所占字节数：" << sizeof(int);
    cout << "\t最大值：" << (numeric_limits<int>::max)();
    cout << "\t最小值：" << (numeric_limits<int>::min)() << endl;
    cout << "unsigned: \t" << "所占字节数：" << sizeof(unsigned);
    cout << "\t最大值：" << (numeric_limits<unsigned>::max)();
    cout << "\t最小值：" << (numeric_limits<unsigned>::min)() << endl;
    cout << "long: \t\t" << "所占字节数：" << sizeof(long);
    cout << "\t最大值：" << (numeric_limits<long>::max)();
    cout << "\t最小值：" << (numeric_limits<long>::min)() << endl;
    cout << "unsigned long: \t" << "所占字节数：" << sizeof(unsigned long);
    cout << "\t最大值：" << (numeric_limits<unsigned long>::max)();
    cout << "\t最小值：" << (numeric_limits<unsigned long>::min)() << endl;
    cout << "double: \t" << "所占字节数：" << sizeof(double);
    cout << "\t最大值：" << (numeric_limits<double>::max)();
    cout << "\t最小值：" << (numeric_limits<double>::min)() << endl;
    cout << "long double: \t" << "所占字节数：" << sizeof(long double);
    cout << "\t最大值：" << (numeric_limits<long double>::max)();
    cout << "\t最小值：" << (numeric_limits<long double>::min)() << endl;
    cout << "float: \t\t" << "所占字节数：" << sizeof(float);
    cout << "\t最大值：" << (numeric_limits<float>::max)();
    cout << "\t最小值：" << (numeric_limits<float>::min)() << endl;
    cout << "size_t: \t" << "所占字节数：" << sizeof(size_t);
    cout << "\t最大值：" << (numeric_limits<size_t>::max)();
    cout << "\t最小值：" << (numeric_limits<size_t>::min)() << endl;
    cout << "string: \t" << "所占字节数：" << sizeof(string) << endl;
    // << "\t最大值：" << (numeric_limits<string>::max)() << "\t最小值：" << (numeric_limits<string>::min)() << endl;
    cout << "type: \t\t" << "************size**************"<< endl;
    return 0;
}
```

本实例使用了`endl`，这将在每一行后插入一个换行符，`<<` 运算符用于向屏幕传多个值。
我们也使用 `sizeof()` 函数来获取各种数据类型的大小。

当上面的代码被编译和执行时，它会产生以下的结果，结果会根据所使用的计算机而有所不同：

```cpp
type:         ************size**************
bool:         所占字节数：1    最大值：1        最小值：0
char:         所占字节数：1    最大值：        最小值：?
...
```

## 数据的编码表示

`10`进制转`R`进制：除`R`取余数，位数依次升高。
`10`进制小数转`R`进制：乘`R`取整数部分，小数部分再乘`R`取整数迭代，位数依次降低.
`R`进制转`10`进制：科学计数法，级数求和。

整数的几种编码:

+ 原码：以`0`表示`+`号，`1`表示`-`号，但是这样`0`的表示不唯一，且正负号需要单独的运算规则
+ 模数：以钟表为例，`12`就是模数。
+ 补数：一个数减去另一个数，等于第一个数加上第二个数的补数。例如：`8(-2)=8+10(mod 12)=6`
+ 反码：对于负整数：原码符号位不变（仍是`1`），其余各位取反；对于正整数，原码就是补码。反码是求补码的中间码。
+ 补码：补码=`反码的最低位+1`

整数使用补码的优点是：

+ `0`的表示唯一
+ 符号位可作为数值参与运算
+ 补码运算的结果仍为补码
+ 补码再求补即可得到原码

如果负数之和得正数，或正数之和得负数，说明运算结果`溢出`.

***
小数的两种表示方法：定点方案，与浮点方案。现在一般都用浮点数，也就是小数点位置可变。
$N=M\times 2^E$
`E`:`2`的幂次，称为数字`N`的阶码，反映了该浮点数表示的数据范围.
`M`:`N`的尾数，其位数反映了数据的精度。

字符在计算机中通过编码表示：西文常用`ASCII`码，`7`位二进制数表示一个字符，最多为`2^7=128`个。
汉字编码：中国国家标准：`GB 18030-2005 信息技术中文编码字符集`

布尔类型，默认转换，非零数据转换成`false`, 其他数值转换成`true`.

## 输入输出流

cout << 表达式 << 表达式 ...
cin >> 表达式 >> 表达式...

`I/O`流类库操纵符.

+ `dec` : 十进制表示
+ `hex` : 十六进制表示
+ `oct` : 八进制表示
+ `ws` : 提取空白符
+ `endl` : 插入换行符，并刷新流
+ `ends` : 插入空字符
+ `setprecision(int)` : 设置浮点数的小数位数（包括小数点）
+ `setw(int)` : 设置域宽

例如:

```c++
cout << setw(5) << setprecision(3) << 3.1415 ;
```

## 过程控制

### if switch

```c++
if  (表达式1)
{...}
else if (表达式2)
{...}
else if
```

注意`if`和`else`的匹配关系:

```c++
if  (表达式1)
{
   if () 语句1
}
else
```

`switch` 语句: 没有`break`不会默认跳出, 每个 `case `都应该包含`break`; `case`包含多个语句，无需`{}`，因为`case, break`就相当于括号。
表达式，判断值都是`int` or `char`类型。

```c++
switch (表达式){
case 判断值0: xxx; break;
case 判断值1: xxx; break;
...
default:
}
```

### while, do while, for

```c++
int i=1, sum=0;
while (i<=10) {
sum +=i;
i++;
}
```

`do while`会先执行一次循环体。而`while`先判断。

```c++
do {
   语句
}
while (判断)
```

`for`语句明确控制循环次数. `for( 初始语句;循环体;循环后语句)`

```c++
for (int k=1; k<=n; k++){
语句
}
```

`for`语句中的范围`for`形式, 用于遍历一个容器中的序列:

```c++
for (声明: 表达式)
   语句
```

+ `break`: 跳出最内层的循环体
+ `continue`: 提前结束本次循环，进入下一次。
+ `goto`: 跳转到任意地方。

## 自定义类型

给类型起一个别名

```c++
typedef 已有类型名 新类型名表 //c 语言继承的办法
// 或者
using 新类型名 = 已有类型名
using Area = double
```

### 枚举类型

`enum 枚举类型名 {变量值列表}`

```c++
enum Weekday {SUN,MON,TUE,WED,THU,FRI,SAT}
```

也可以定义限定类型的枚举类型. 将整数值赋值给枚举类型要进行强制类型转换。

### auto, decltype 类型

`auto `: 编译器通过初始值自动推断变量的类型。例如：`auto val=val1+ val2`. 
如果都是`int`，则`val` is `int`. 如果有一个`double`，则`val`是`doule`类型。

`decltype(cls) j =2`:表示`j`的初始值为`2`，但类型与`cls`一致。

### struct

`struct`把一组相互关联的数据整合在一起. 例如:

```c++
struct MyTimeStruct
{
   unsigned int year;
   unsigned int month;
   unsigned int day;
}
// 赋值和调用
myTime={2015,3,16}
myTime.day
```

## 函数

+ 内联函数
+ `constexpr`函数
+ 带默认参数值的函数
+ 函数重载: 编译时绑定--早绑定, 晚绑定
+ C++ 系统函数 

### 函数定义

函数定义的语法形式

```c++
类型标识符 函数名(形式参数表)
{
语句序列
return x // void 函数不需要写 return
}
```

形式参数的形式为: `type1 name1, ....`

### 函数调用

调用函数需要声明`函数原型`: 类型标识符 被调函数名 (含类型说明的形参表)， 调用使用`函数名(实参列表)`.
`调用堆栈`

随机函数：`rand()`, `srand()`.

函数的嵌套调用和递归调用。

### 参数传递

函数被调用时才分配形参的存储单元
实参可以是常量，变量或表达式
实参类型必须与形参相符
值传递是传递参数值，即单向传递
引用传递可以实现双向传递
常数引用作参数可以保障实参数据的安全

### 引用

引用(&)是标识符的别名。
定义引用时，必须同时对它进行初始化，指向一个已存在的对象。例如

```c++
int i,j;
int &ri = i; //定义 int 引用 ri，初始化为变量i的引用
j=10
ri=j; // 相当于 i=j
```

一旦引用被初始化后，就不能改为指向其他对象。 引用可以作为形参。

### 含有可变参数的函数

类模板: `initializer_list`

initializer_list<string> ls; //initializer_list 的元素类型是 string
initializer_list<int> ls; //initializer_list 的元素类型是 int

`initializer_list` 比较特殊的是，其对象中的元素永远是常量值，无法改变`initializer_list`对象中元素的值。
含有`initializer_list`形参的函数也可以同时拥有形参。

### 内联函数

编译器实现的，不走调用子函数开销。内联函数声明关键字`inline`.

编译时用函数体进行替换，节省了参数传递，控制转移等开销。

内联函数不能有循环语句和 switch 语句。
必须出现在第一次调用之前，不能使用异常接口声明。

`inline`只是建议，编译器不一定理会。

### constexpr 函数

`constexpr` 修饰的函数，在其所有参数都是`constexpr`时，一定返回`constexpr`.例如

```cpp
constexpr int get_size(){return 20;}
constexpr int foo = get_size(); \\正确: foo 是一个常量表达式
```

编译期间可计算函数。

### 函数的默认参数

```cpp
int add(int x=5,int y=6){
   return x+y;
}
int main(){
   add(10,20); //10+20
   add(10); // 10+6
   add(); //5+6
}

带有默认值的形参必须在形参列表的最右，即默认参数的右边不能有无默认值的参数；
调用时实参与形参的结合次序是从左到右。

```cpp
int add(int x,int y=6, int z=6); 
```

如果函数声明在前，则在声明中给定默认值；
如果函数定义在前，则在定义中给定默认值；

### 函数的重载

在编译的时候实现，利用静态的多态性实现。允许功能相似的函数在相同的作用域内以相同函数名声明，从而形成重载。
方便使用与记忆。

```cpp
int add (int x, int y);
float add(float add, float y);
```

```cpp
int add (int x, int y);
int add (int x, int y, int z);
```

### c++系统函数

使用系统函数要包含相应的头文件。如`cmath`.

## 面向对象

构造函数，析构函数

抽象，封装，继承，多态。

封装: 只通过外部接口调用，以特定的访问权限。
实现封装: 类声明中的`{}`

多态: 同一名称，不同的功能实现方式.
目的: 减少程序标识符的个数。

***
设计类就是设计类型。

```cpp
class 类名称
{
public:
公有成员(外部接口)
private:
私有成员
protected:
保护成员
}
```

紧跟在类名称后面声明私有成员，则关键字`private`可以省略。

### 对象定义的语法

```cpp
类名 对象名; // 例如
Clock myClock
```

类中的成员可以占直接互相访问，外部要访问使用`对象名.成员名`.

***
类中的函数可以在类外使用`类::函数名`定义函数体。比较简单的函数，可以声明为内联成员函数。内联函数体中不要有复杂结构(如循环语句和switch语句)

+ 直接把函数体放在类的声明中
+ 在类外使用`inline`关键字声明。
  
### 构造函数

类中的特殊函数，用于描述初始化算法。在对象被创建时使用特定的值构建对象，将对象初始化为一个特定的初始状态。

构造函数的形式：

+ 函数名与类名相同
+ 不能定义返回值类型，也不能有`return`语句。
+ 可以有形式参数，也可以没有形式参数
+ 可以是内联函数
+ 可以重载
+ 可以带默认参数值

构造函数在创建对象时，自动被调用。默认构造函数要么不需要实参，要么全部参数带有默认值。default constructor.

```cpp
Clock(); //这两个构造函数不能同时出现。
Clock(int newH...);
```

隐含生成的构造函数: 如果程序未定义构造函数，编译器将自动生成一个默认构造函数。

+ 参数表为空，不为数据成员设置初始值。
+ 如果类内定义了成员的初始值，则使用内类定义的初始值。
+ 如果没有定义类内的初始值，则以默认方式初始化。
+ 基本类型的数据默认初始化是不确定的。

可以使用`Clock()=default`强制编译器生成默认构造函数。

构造函数可以有多个重载形式。

### 委托构造函数

委托构造函数使用类的其他构造函数执行初始化过程。例如：

```cpp
Clock(int newH, int newM, int newS):
hour(newH),minute(newM),second(newS){}
Clock():Clock(0,0,0){} //默认构造函数可以调用带参数的构造函数。
```

### 复制构造函数

使用对象`A`给对象`B`初始化，需要用到复制构造函数。

```cpp
class 类名{
public: 类名(形参); //构造函数
类名(const 类名 &对象名);// 复制构造函数, const 是为了保证引用为常引用，单项引用，保持安全性
//...
};
类名::类(const 类名 &对象名)//复制构造函数的实现
{ 函数体 }
```

调用复制构造函数的情况：

+ 对象`A`初始化对象`B`
+ 函数的形参是类的对象，形实结合使用复制构造。
+ 如果函数的返回值是类的对象，函数执行完返回一个临时无名对象，传递给主调函数，也发生复制构造。

如果没有定义，则编译器产生隐含的复制构造函数。
将两个对象的数据成员一一对应。
