# java-1.md

[java教程-廖雪峰][]

[java教程-廖雪峰]: https://www.liaoxuefeng.com/wiki/1252599548343744/1255876875896416

## java快速入门

本章的主要内容是快速掌握Java程序的基础知识，了解并使用变量和各种数据类型，介绍基本的程序流程控制语句。

### Java简介

Java最早是由SUN公司（已被Oracle收购）的詹姆斯·高斯林（高司令，人称Java之父）在上个世纪90年代初开发的一种编程语言，最初被命名为Oak，目标是针对小型家电设备的嵌入式应用，结果市场没啥反响。谁料到互联网的崛起，让Oak重新焕发了生机，于是SUN公司改造了Oak，在1995年以Java的名称正式发布，原因是Oak已经被人注册了，因此SUN注册了Java这个商标。随着互联网的高速发展，Java逐渐成为最重要的网络编程语言。

Java介于编译型语言和解释型语言之间。编译型语言如C、C++，代码是直接编译成机器码执行，但是不同的平台（x86、ARM等）CPU的指令集不同，因此，需要编译出每一种平台的对应机器码。解释型语言如Python、Ruby没有这个问题，可以由解释器直接加载源码然后运行，代价是运行效率太低。而Java是将代码编译成一种“字节码”，它类似于抽象的CPU指令，然后，针对不同平台编写虚拟机，不同平台的虚拟机负责加载字节码并执行，这样就实现了“一次编写，到处运行”的效果。当然，这是针对Java开发者而言。对于虚拟机，需要为每个平台分别开发。为了保证不同平台、不同公司开发的虚拟机都能正确执行Java字节码，SUN公司制定了一系列的Java虚拟机规范。从实践的角度看，JVM的兼容性做得非常好，低版本的Java字节码完全可以正常运行在高版本的JVM上。

随着Java的发展，SUN给Java又分出了三个不同版本：

+ Java SE：Standard Edition
+ Java EE：Enterprise Edition
+ Java ME：Micro Edition

这三者之间有啥关系呢？

<pre style="font-size: 12px; line-height: 12px; border: medium none; white-space: pre; background-color: transparent;"><code class="language-ascii" style="font-family: &quot;Courier New&quot;, Consolas, monospace;">┌───────────────────────────┐
│Java EE                    │
│    ┌────────────────────┐ │
│    │Java SE             │ │
│    │    ┌─────────────┐ │ │
│    │    │   Java ME   │ │ │
│    │    └─────────────┘ │ │
│    └────────────────────┘ │
└───────────────────────────┘
</code></pre>

简单来说，Java SE就是标准版，包含标准的JVM和标准库，而Java EE是企业版，它只是在Java SE的基础上加上了大量的API和库，以便方便开发Web应用、数据库、消息服务等，Java EE的应用使用的虚拟机和Java SE完全相同。

Java ME就和Java SE不同，它是一个针对嵌入式设备的“瘦身版”，Java SE的标准库无法在Java ME上使用，Java ME的虚拟机也是“瘦身版”。

毫无疑问，Java SE是整个Java平台的核心，而Java EE是进一步学习Web应用所必须的。我们熟悉的Spring等框架都是Java EE开源生态系统的一部分。不幸的是，Java ME从来没有真正流行起来，反而是Android开发成为了移动平台的标准之一，因此，没有特殊需求，不建议学习Java ME。

因此我们推荐的Java学习路线图如下：

+ 首先要学习Java SE，掌握Java语言本身、Java核心开发技术以及Java标准库的使用；
+ 如果继续学习Java EE，那么Spring框架、数据库开发、分布式架构就是需要学习的；
+ 如果要学习大数据开发，那么Hadoop、Spark、Flink这些大数据平台就是需要学习的，它们都基于Java或Scala开发；
+ 如果想要学习移动开发，那么就深入Android平台，掌握Android App开发。

无论怎么选择，Java SE的核心技术是基础，这个教程的目的就是让你完全精通Java SE！

#### Java版本

从1995年发布1.0版本开始，到目前为止，最新的Java版本是Java 13

#### 名词解释

初学者学Java，经常听到JDK、JRE这些名词，它们到底是啥？

    JDK：Java Development Kit
    JRE：Java Runtime Environment

简单地说，JRE就是运行Java字节码的虚拟机。但是，如果只有Java源码，要编译成Java字节码，就需要JDK，因为JDK除了包含JRE，还提供了编译器、调试器等开发工具。

二者关系如下：

<pre style="font-size: 12px; line-height: 12px; border: medium none; white-space: pre; background-color: transparent;"><code class="language-ascii" style="font-family: &quot;Courier New&quot;, Consolas, monospace;">  ┌─    ┌──────────────────────────────────┐
  │     │     Compiler, debugger, etc.     │
  │     └──────────────────────────────────┘
 JDK ┌─ ┌──────────────────────────────────┐
  │  │  │                                  │
  │ JRE │      JVM + Runtime Library       │
  │  │  │                                  │
  └─ └─ └──────────────────────────────────┘
        ┌───────┐┌───────┐┌───────┐┌───────┐
        │Windows││ Linux ││ macOS ││others │
        └───────┘└───────┘└───────┘└───────┘
</code></pre>

要学习Java开发，当然需要安装JDK了。

那JSR、JCP……又是啥？

+ JSR规范：Java Specification Request
+ JCP组织：Java Community Process

为了保证Java语言的规范性，SUN公司搞了一个JSR规范，凡是想给Java平台加一个功能，比如说访问数据库的功能，大家要先创建一个JSR规范，定义好接口，这样，各个数据库厂商都按照规范写出Java驱动程序，开发者就不用担心自己写的数据库代码在MySQL上能跑，却不能跑在PostgreSQL上。

所以JSR是一系列的规范，从JVM的内存模型到Web程序接口，全部都标准化了。而负责审核JSR的组织就是JCP。

一个JSR规范发布时，为了让大家有个参考，还要同时发布一个“参考实现”，以及一个“兼容性测试套件”：

+ RI：Reference Implementation
+ TCK：Technology Compatibility Kit

比如有人提议要搞一个基于Java开发的消息服务器，这个提议很好啊，但是光有提议还不行，得贴出真正能跑的代码，这就是RI。如果有其他人也想开发这样一个消息服务器，如何保证这些消息服务器对开发者来说接口、功能都是相同的？所以还得提供TCK。

通常来说，RI只是一个“能跑”的正确的代码，它不追求速度，所以，如果真正要选择一个Java的消息服务器，一般是没人用RI的，大家都会选择一个有竞争力的商用或开源产品。

参考：Java消息服务JMS的JSR：`https://jcp.org/en/jsr/detail?id=914`

### 安装JDK

因为Java程序必须运行在JVM之上，所以，我们第一件事情就是安装JDK。
搜索JDK 13，确保从[Oracle的官网][]下载最新的稳定版JDK：

[Oracle的官网]: https://www.oracle.com/java/technologies/javase-downloads.html

找到`Java SE 13.x`的下载链接，下载安装即可。
设置环境变量

安装完JDK后，需要设置一个`JAVA_HOME`的环境变量，它指向JDK的安装目录。
在Windows下，它是安装目录，类似：

```java
C:\Program Files\Java\jdk-13
```

在Mac下，它在`~/.bash_profile`里，它是：

export JAVA_HOME=`/usr/libexec/java_home -v 13`

然后，把`JAVA_HOME`的`bin`目录附加到系统环境变量PATH上。在Windows下，它长这样：

```java
Path=%JAVA_HOME%\bin;<现有的其他路径>
```

在Mac下，它在`~/.bash_profile`里，长这样：

```java
export PATH=$JAVA_HOME/bin:$PATH
```

把`JAVA_HOME`的`bin`目录添加到`PATH`中是为了在任意文件夹下都可以运行`java`。
打开命令提示符窗口，输入命令`java -version`

如果你看到的版本号不是`13`，而是`12`、`1.8`之类，说明系统存在多个JDK，且默认JDK不是JDK 13，需要把JDK 13提到PATH前面。

细心的童鞋还可以在JAVA_HOME的bin目录下找到很多可执行文件：

+ `java`：这个可执行程序其实就是JVM，运行Java程序，就是启动JVM，然后让JVM执行指定的编译后的代码；
+ `javac`：这是Java的编译器，它用于把Java源码文件（以.java后缀结尾）编译为Java字节码文件（以.class后缀结尾）；
+ `jar`：用于把一组.class文件打包成一个.jar文件，便于发布；
+ `javadoc`：用于从Java源码中自动提取注释并生成文档；
+ `jdb`：Java调试器，用于开发阶段的运行调试。

### 第一个Java程序

我们来编写第一个Java程序。

打开文本编辑器，输入以下代码：

```java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello, world!");
    }
}
```

在一个Java程序中，你总能找到一个类似：

```java
public class Hello {
    ...
}
```

的定义，这个定义被称为`class`（类），这里的类名是`Hello`，大小写敏感，`class`用来定义一个类，`public`表示这个类是公开的，`public`、`class`都是Java的关键字，必须小写，`Hello`是类的名字，按照习惯，首字母H要大写。而花括号{}中间则是类的定义。

注意到类的定义中，我们定义了一个名为main的方法：

```java
    public static void main(String[] args) {
        ...
    }
```

方法是可执行的代码块，一个方法除了方法名`main`，还有用()括起来的方法参数，这里的`main`方法有一个参数，参数类型是`String[]`，参数名是`args`，`public`、`static`用来修饰方法，这里表示它是一个公开的静态方法，`void`是方法的返回类型，而花括号`{}`中间的就是方法的代码。

方法的代码每一行用;结束，这里只有一行代码，就是：

```java
        System.out.println("Hello, world!");
```

它用来打印一个字符串到屏幕上。

`Java`规定，某个类定义的`public static void main(String[] args)`是`Java`程序的固定入口方法，因此，`Java`程序总是从`main`方法开始执行。

注意到`Java`源码的缩进不是必须的，但是用缩进后，格式好看，很容易看出代码块的开始和结束，缩进一般是4个空格或者一个`tab`。

最后，当我们把代码保存为文件时，文件名必须是`Hello.java`，而且文件名也要注意大小写，因为要和我们定义的类名`Hello`完全保持一致。

#### 如何运行Java程序

`Java`源码本质上是一个文本文件，我们需要先用`javac`把`Hello.java`编译成字节码文件`Hello.class`，然后，用`java`命令执行这个字节码文件：

<pre style="font-size: 12px; line-height: 12px; border: medium none; white-space: pre; background-color: transparent;"><code class="language-ascii" style="font-family: &quot;Courier New&quot;, Consolas, monospace;">┌──────────────────┐
│    Hello.java    │&lt;─── source code
└──────────────────┘
          │ compile
          ▼
┌──────────────────┐
│   Hello.class    │&lt;─── byte code
└──────────────────┘
          │ execute
          ▼
┌──────────────────┐
│    Run on JVM    │
└──────────────────┘
</code></pre>

因此，可执行文件`javac`是编译器，而可执行文件`java`就是虚拟机。

第一步，在保存Hello.java的目录下执行命令`javac Hello.java`：

```java
$ javac Hello.java
```

如果源代码无误，上述命令不会有任何输出，而当前目录下会产生一个`Hello.class`文件：

```java
$ ls
Hello.class Hello.java
```

第二步，执行`Hello.class`，使用命令`java Hello`：

```java
$ java Hello
Hello, world!
```

注意：给虚拟机传递的参数`Hello`是我们定义的类名，虚拟机自动查找对应的`class`文件并执行。

有一些童鞋可能知道，直接运行`java Hello.java`也是可以的：

```java
$ java Hello.java
Hello, world!
```

这是Java 11新增的一个功能，它可以直接运行一个单文件源码！

需要注意的是，在实际项目中，单个不依赖第三方库的Java源码是非常罕见的，所以，绝大多数情况下，我们无法直接运行一个Java源码文件，原因是它需要依赖其他的库。

#### 小结

+ 一个Java源码只能定义一个`public`类型的`class`，
并且`class`名称和文件名要完全一致；
+ 使用`javac`可以将`.java`源码编译成`.class`字节码；
+ 使用`java`可以运行一个已编译的`Java`程序，参数是类名。

### 使用IDE

### 使用IDE联系插件

### java程序基础

本节我们将介绍Java程序的基础知识，包括：

+ Java程序基本结构
+ 变量和数据类型
+ 整数运算
+ 浮点数运算
+ 布尔运算
+ 字符和字符串
+ 数组类型

#### Java程序基本结构

我们先剖析一个完整的Java程序，它的基本结构是什么：

```java
/**
 * 可以用来自动创建文档的注释
 */
public class Hello {
    public static void main(String[] args) {
        // 向屏幕输出文本:
        System.out.println("Hello, world!");
        /* 多行注释开始
        注释内容
        注释结束 */
    }
} // class定义结束
```
