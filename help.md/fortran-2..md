# Fortran-2

[Fortran语言的入门与心得][]

[Fortran语言的入门与心得]: https://blog.csdn.net/xiaoxiaoxingzi/article/details/105315397

## 第一个例子

### Hello world

```fortran
program main
  implicit none
  print *, 'Hello World'
end program main
```

## 一些小心得

+ `Fortran`不区分大小写
+ `Fortran`每行的末尾不必要写分号
+ 不像C语言，`fortran`不使用大括号`{ }`
+ `Fortran`有5种基本数据类型，`integer`，`real`, `character`,   `logical`,  `complex`，其他语言一般没有复数类型，这是`fortran`与其他语言不同的地方。
+ `DOUBLE  PRECISION`语句在`FORTRAN90`标准中完全可以用`REAL(8)`代替，目前很少使用。
+ `Fortran`两种格式之间的一些遗留问题
+ 使用系统默认的隐含约定（`I-N`规则）：FORTRAN中约定，在没有强制规定变量类型的情况下，如果变量名的首字母为`I`、`J`、`K`、`L`、`M`、`N`这`6`个字母中的一个时，即认为该变量为整型变量，而已其他字母开头的变量则默认为实型变量。
+ 这就是所谓的（I-N规则）。

（I-N规则）的使用有利有弊。

### 变量名

`real(kind=8) a` 这种格式只使用于Fortran90，Fortran77中要使用real*8或real(8)

常数parameter的声明方法--Fortran90里，`PARAMETER`可以作为一个形容词，和变量的声明同时写在一起，例如：

```fortran
real, parameter ::  pi=3.141592653
```

FORTRAN中乘方要使用`**`运算符，使用乘方运算符`**`时，一定要写成两个连续的星号。
一般来说，乘方运算要比等价的单个乘法运算花费更多的时间。

算术表达式中的类型转换：

FORTRAN语言允许不同类型的算术运算量之间进行算术运算，同类型的算术运算量之间的运算结果保持原类型不变。

需要特别注意的是：FORTRAN语言中规定两个整数相除的商也是整数。例如，`2/5`的结果为`0`。

参加运算的两个算术运算量为不同类型时，编译系统会自动将它们转换成同一类型之后才进行运算。

### do循环

Fortran 95使用`end do`来结束循环。

循环的流程控制：

循环中的`cycle`命令相当于c++里的continue命令，用于结束一次循环
循环中的exit命令好比c里面的break，用于结束循环

    不使用do循环，单纯用GOTO语句也能设计循环程序，但不推荐使用GOTO语句
    fortran有等价声明：即用equivalence(a,b),这样使得a,b使用同一块内存，这样可以节省内存，有时可精简代码。
    fortran77中只能用单引号。（还有疑问，因为fixed format能用双引号）
    关系运算符

         ==    /=     >      >=     <     <=         !Fortran90用法

      .EQ.   .NE.   .GT.    .GE.    .LT.   .LE.      !Fortran77用法(左右各有一个点)

    逻辑运算符

5种逻辑运算符，新旧FORTRAN标准中的逻辑运算符没有任何区别，每个运算符的左右都有一个点“.”，书写时不能漏写。

.AND.     .OR.     .NOT.      .EQV.        .NEQV.                 !语法

逻辑与   逻辑或   逻辑非   逻辑等价   逻辑不等价               ！意义

    PAUSE,CONTINUE，STOP

       pause 暂停程序执行，按enter可继续执行

       continue 貌似没什么用处，可用作封装程序的标志

       STOP 命令用来结束程序，要谨慎使用

    Fortran的特色：隐含式循环
    a,b都为数组，则可以这样用a=sin(b),(内部函数都可以这样用)
    数组专用：

where命令形式上类似于if,但只用于设置数组 where.....elsewhere...elsewhere...endwhere (没有then)

         FORALL是Fortran95添加的功能,只能用于数组操作

         forall可以嵌套使用，还可以在forall中使用where，但where中不能使用forall

    Fortran中传递参数的原理与c++不同，Fortran中是传址调用，就是传递时用参数和子程序接受时用的参数使用一个地址，尽管命名可以不同。
    调用自定义函数前需要做声明，调用子程序则不需要。
    Module中有函数时必须在contains命令之后
    全局变量（COMMON,有的书上叫无名公用区、有名公用区）

全局变量用来定义一块共享的内存空间；

    全局变量不能声明成常量

全局变量不能直接使用data命令赋初值，要在block data模块中使用data来设置初值。

COMMON语句是说明语句，因此它应该出现在相应程序单元中的所有可执行语句之前。

取用全局变量时，是根据它们的相对位置关系来作对应，而不是根据变量名称来对应。由于全局变量是使用“地址对应”的方法在程序中共享数据，所以在程序设计时常常会有麻烦出现：比如要调用后面的变量就要从第一个开始，这种麻烦在全局变量多的情况下更为惊人。因此，可以把全局变量进行归类，放在彼此独立的COMMON区间中。l

common  /group1/ a

common  /group2/ b

24  传递参数与使用全局变量都可以在不同程序之间共享数据，那什么时候该使用参数，还有什么时候该使用全局变量呢？

    简单地说，当需要共享的变量不多，而且只有少数几个程序需要使用这些数据时，那就使用参数，

需要共享大笔数据，或是有很多不同程序都需要使用这些数据时，就使用全局变量。

25  INCLUDE命令

1    INCLUDE命令可以写在任何地方，它只是单纯地用来插入一个文件的内容。

2   有时候也会应用在声明全局变量，先把声明全局变量的程序代码编写在某个文件中，需要使用全局变量的函数再去INCLUDE这个文件，这样可以减少程序代码。

26 如何换行
————————————————
版权声明：本文为CSDN博主「xiaoxiaoxingzi」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/xiaoxiaoxingzi/article/details/105315397