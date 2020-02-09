# python-2.md

ref: [这是小白的Python新手教程][]

[这是小白的Python新手教程]: https://www.liaoxuefeng.com/wiki/1016959663602400

## 函数式编程

函数是Python内建支持的一种封装，我们通过把大段代码拆成函数，通过一层一层的函数调用，就可以把复杂任务分解成简单的任务，这种分解可以称之为面向过程的程序设计。函数就是面向过程的程序设计的基本单元。

而函数式编程（请注意多了一个“式”字）——Functional Programming，
虽然也可以归结到面向过程的程序设计，但其思想更接近数学计算。

我们首先要搞明白计算机（Computer）和计算（Compute）的概念。

在计算机的层次上，CPU执行的是加减乘除的指令代码，以及各种条件判断和跳转指令，所以，汇编语言是最贴近计算机的语言。

而计算则指数学意义上的计算，越是抽象的计算，离计算机硬件越远。

对应到编程语言，就是越低级的语言，越贴近计算机，抽象程度低，执行效率高，比如C语言；越高级的语言，越贴近计算，抽象程度高，执行效率低，比如Lisp语言。

函数式编程就是一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的，这种纯函数我们称之为没有副作用。而允许使用变量的程序设计语言，由于函数内部的变量状态不确定，同样的输入，可能得到不同的输出，因此，这种函数是有副作用的。

函数式编程的一个特点就是，允许把函数本身作为参数传入另一个函数，还允许返回一个函数！

Python对函数式编程提供部分支持。
由于Python允许使用变量，因此，Python不是纯函数式编程语言。

### 高阶函数

高阶函数英文叫`Higher-order function`。
什么是高阶函数？我们以实际代码为例子，一步一步深入概念。

#### 变量可以指向函数

以Python内置的求绝对值的函数`abs()`为例，调用该函数用以下代码：

```python
>>> abs(-10)
10
```

但是，如果只写`abs`呢？

```python
>>> abs
<built-in function abs>
```

可见，`abs(-10)`是函数调用，而`abs`是函数本身。

要获得函数调用结果，我们可以把结果赋值给变量：

```python
>>> x = abs(-10)
>>> x
10
```

但是，如果把函数本身赋值给变量呢？

```python
>>> f = abs
>>> f
<built-in function abs>
```

结论：函数本身也可以赋值给变量，即：变量可以指向函数。

如果一个变量指向了一个函数，那么，可否通过该变量来调用这个函数？用代码验证一下：

```python
>>> f = abs
>>> f(-10)
10
```

成功！说明变量f现在已经指向了`abs`函数本身。
直接调用`abs()`函数和调用变量`f()`完全相同。

#### 函数名也是变量

那么函数名是什么呢？函数名其实就是指向函数的变量！
对于`abs()`这个函数，完全可以把函数名`abs`看成变量，
它指向一个可以计算绝对值的函数！

如果把`abs`指向其他对象，会有什么情况发生？

```python
>>> abs = 10
>>> abs(-10)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'int' object is not callable
```

把`abs`指向`10`后，就无法通过`abs(-10)`调用该函数了！
因为`abs`这个变量已经不指向求绝对值函数而是指向一个整数`10`！

当然实际代码绝对不能这么写，这里是为了说明函数名也是变量。
要恢复`abs`函数，请重启Python交互环境。

注：由于`abs`函数实际上是定义在`import builtins`模块中的，
所以要让修改`abs`变量的指向在其它模块也生效，要用`import builtins; builtins.abs = 10`。

#### 传入函数

既然变量可以指向函数，函数的参数能接收变量，
那么一个函数就可以接收另一个函数作为参数，这种函数就称之为高阶函数。

一个最简单的高阶函数：

```python
def add(x, y, f):
    return f(x) + f(y)
```

当我们调用`add(-5, 6, abs)`时，
参数`x`，`y`和f分别接收`-5`，`6`和`abs`，
根据函数定义，我们可以推导计算过程为：

```python
x = -5
y = 6
f = abs
f(x) + f(y) ==> abs(-5) + abs(6) ==> 11
return 11
```

用代码验证一下：

```python
# -*- coding: utf-8 -*-

def add(x, y, f):
    return f(x) + f(y)

print(add(-5, 6, abs))
```

编写高阶函数，就是让函数的参数能够接收别的函数。

#### 小结-高阶函数

把函数作为参数传入，这样的函数称为高阶函数，
函数式编程就是指这种高度抽象的编程范式。

### map/reduce

Python内建了`map()`和`reduce()`函数。

如果你读过Google的那篇大名鼎鼎的论文“[MapReduce: Simplified Data Processing on Large Clusters][]”，你就能大概明白`map/reduce`的概念。

[MapReduce: Simplified Data Processing on Large Clusters]: research.google.com/archive/mapreduce.html

#### map

我们先看map。`map()`函数接收两个参数，一个是函数，一个是`Iterable`，
map将传入的函数依次作用到序列的每个元素，并把结果作为新的`Iterator`返回。

举例说明，比如我们有一个函数`f(x)=x2`，
要把这个函数作用在一个`list [1, 2, 3, 4, 5, 6, 7, 8, 9]`上，
就可以用`map()`实现,
我们用Python代码实现：

```python
>>> def f(x):
...     return x * x
...
>>> r = map(f, [1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> list(r)
[1, 4, 9, 16, 25, 36, 49, 64, 81]
```

`map()`传入的第一个参数是`f`，即函数对象本身。由于结果`r`是一个`Iterator`，`Iterator`是惰性序列，因此通过`list()`函数让它把整个序列都计算出来并返回一个`list`。

你可能会想，不需要`map()`函数，写一个循环，也可以计算出结果：

```python
L = []
for n in [1, 2, 3, 4, 5, 6, 7, 8, 9]:
    L.append(f(n))
print(L)
```

的确可以，但是，从上面的循环代码，能一眼看明白“把f(x)作用在list的每一个元素并把结果生成一个新的list”吗？

所以，`map()`作为高阶函数，事实上它把运算规则抽象了，因此，我们不但可以计算简单的`f(x)=x2`，还可以计算任意复杂的函数，比如，把这个`list`所有数字转为字符串：

```python
>>> list(map(str, [1, 2, 3, 4, 5, 6, 7, 8, 9]))
['1', '2', '3', '4', '5', '6', '7', '8', '9']
```

只需要一行代码。

#### reduce

再看`reduce`的用法。`reduce`把一个函数作用在一个序列`[x1, x2, x3, ...]`上，这个函数必须接收两个参数，
`reduce`把结果继续和序列的下一个元素做累积计算，其效果就是：

```python
reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)
```

比方说对一个序列求和，就可以用`reduce`实现：

```python
>>> from functools import reduce
>>> def add(x, y):
...     return x + y
...
>>> reduce(add, [1, 3, 5, 7, 9])
25
```

当然求和运算可以直接用Python内建函数`sum()`，没必要动用`reduce`。
但是如果要把序列`[1, 3, 5, 7, 9]`变换成整数`13579`，`reduce`就可以派上用场：

```python
>>> from functools import reduce
>>> def fn(x, y):
...     return x * 10 + y
...
>>> reduce(fn, [1, 3, 5, 7, 9])
13579
```

这个例子本身没多大用处，但是，如果考虑到字符串`str`也是一个序列，对上面的例子稍加改动，配合`map()`，我们就可以写出把`str`转换为`int`的函数：

```python
>>> from functools import reduce
>>> def fn(x, y):
...     return x * 10 + y
...
>>> def char2num(s):
...     digits = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}
...     return digits[s]
...
>>> reduce(fn, map(char2num, '13579'))
13579
```

整理成一个`str2int`的函数就是：

```python
from functools import reduce

DIGITS = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}

def str2int(s):
    def fn(x, y):
        return x * 10 + y
    def char2num(s):
        return DIGITS[s]
    return reduce(fn, map(char2num, s))
```

还可以用`lambda`函数进一步简化成：

```python
from functools import reduce

DIGITS = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}

def char2num(s):
    return DIGITS[s]

def str2int(s):
    return reduce(lambda x, y: x * 10 + y, map(char2num, s))
```

也就是说，假设Python没有提供`int()`函数，你完全可以自己写一个把字符串转化为整数的函数，而且只需要几行代码！

`lambda`函数的用法在后面介绍。

#### 练习-map-reduce-1

利用`map()`函数，把用户输入的不规范的英文名字，变为首字母大写，
其他小写的规范名字。
输入：`['adam', 'LISA', 'barT']`，输出：`['Adam', 'Lisa', 'Bart']`：

```python
# -*- coding: utf-8 -*-
def normalize(name):
    return s=s[0].upper()+s[1:].lower()

 # 测试:
L1 = ['adam', 'LISA', 'barT']
L2 = list(map(normalize, L1))
print(L2)
```

#### 练习-map-reduce-2

Python提供的`sum()`函数可以接受一个list并求和，
请编写一个`prod()`函数，可以接受一个list并利用`reduce()`求积：

```python
# -*- coding: utf-8 -*-
from functools import reduce
def prod(L):
    def times(a,b):
        return a*b
    return reduce(times,L)

print('3 * 5 * 7 * 9 =', prod([3, 5, 7, 9]))
if prod([3, 5, 7, 9]) == 945:
    print('测试成功!')
else:
    print('测试失败!')
```

#### 练习-map-reduce-3

利用map和reduce编写一个`str2float`函数，把字符串`'123.456'`转换成浮点数`123.456`：

```python
# -*- coding: utf-8 -*-
from functools import reduce
import math

def str2float(s):
    dgdict= {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}
    dot=len(s)-s.index('.')-1
    new_s=s.replace('.','')
    def fn(x, y):
        return x * 10 + y
    def char2num(s2):
        return dgdict[s2]
    s_int=reduce(fn, map(char2num, new_s))
    return s_int/(math.pow(10,dot))


# 测试
print('str2float(\'123.456\') =', str2float('123.456'))
if abs(str2float('123.456') - 123.456) < 0.00001:
    print('测试成功!')
else:
    print('测试失败!')
```

### filter

Python内建的`filter()`函数用于过滤序列。

和`map()`类似，`filter()`也接收一个函数和一个序列。
和map()不同的是，`filter()`把传入的函数依次作用于每个元素，然后根据返回值是`True`还是`False`决定保留还是丢弃该元素。

`''` 空字符串被视为`False`

例如，在一个list中，删掉偶数，只保留奇数，可以这么写：

```python
def is_odd(n):
    return n % 2 == 1

list(filter(is_odd, [1, 2, 4, 5, 6, 9, 10, 15]))
# 结果: [1, 5, 9, 15]
```

把一个序列中的空字符串删掉，可以这么写：

```python
def not_empty(s):
    return s and s.strip()

list(filter(not_empty, ['A', '', 'B', None, 'C', '  ']))
# 结果: ['A', 'B', 'C']
```

可见用`filter()`这个高阶函数，关键在于正确实现一个“筛选”函数。

注意到`filter()`函数返回的是一个`Iterator`，也就是一个惰性序列，所以要强迫`filter()`完成计算结果，需要用`list()`函数获得所有结果并返回list。
用filter求素数

计算素数的一个方法是埃氏筛法，它的算法理解起来非常简单：

首先，列出从2开始的所有自然数，构造一个序列：
2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...

取序列的第一个数2，它一定是素数，然后用2把序列的2的倍数筛掉：
3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...

取新序列的第一个数3，它一定是素数，然后用3把序列的3的倍数筛掉：
5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...

不断筛下去，就可以得到所有的素数。

用Python来实现这个算法，可以先构造一个从3开始的奇数序列：

```python
def _odd_iter():
    n = 1
    while True:
        n = n + 2
        yield n
```

注意这是一个生成器，并且是一个无限序列。

然后定义一个筛选函数：

```python
def _not_divisible(n):
    return lambda x: x % n > 0
```

lambda 表达式 即匿名函数

最后，定义一个生成器，不断返回下一个素数：

```python
def primes():
    yield 2
    it = _odd_iter() # 初始序列
    while True:
        n = next(it) # 返回序列的第一个数
        yield n
        it = filter(_not_divisible(n), it) # 构造新序列
```

这个生成器先返回第一个素数`2`，然后，利用`filter()`不断产生筛选后的新的序列。

由于`primes()`也是一个无限序列，所以调用时需要设置一个退出循环的条件：

```python
# 打印1000以内的素数:
for n in primes():
    if n < 1000:
        print(n)
    else:
        break
```

注意到`Iterator`是惰性计算的序列，所以我们可以用`Python`表示“全体自然数”，
“全体素数”这样的序列，而代码非常简洁。

练习-filter

回数是指从左向右读和从右向左读都是一样的数，例如12321，909。请利用filter()筛选出回数：

```python
# -*- coding: utf-8 -*-

def is_palindrome(n):
    n_rev=''
    for i in str(n):
         n_rev=i+n_rev
    return str(n) == n_rev

# 测试:
output = filter(is_palindrome, range(1, 1000))
print('1~1000:', list(output))
if list(filter(is_palindrome, range(1, 200))) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88, 99, 101, 111, 121, 131, 141, 151, 161, 171, 181, 191]:
    print('测试成功!')
else:
    print('测试失败!')
```

也可以用 字符 切片功能，把间距取为`-1`，会比较方便

```python
def is_palindrome(n):
    L=list(str(n))
    return L==L[::-1]
```

### sorted

排序算法

排序也是在程序中经常用到的算法。无论使用冒泡排序还是快速排序，排序的核心是比较两个元素的大小。如果是数字，我们可以直接比较，但如果是字符串或者两个dict呢？直接比较数学上的大小是没有意义的，因此，比较的过程必须通过函数抽象出来。

Python内置的`sorted()`函数就可以对list进行排序：

```python
>>> sorted([36, 5, -12, 9, -21])
[-21, -12, 5, 9, 36]
```

此外，`sorted()`函数也是一个高阶函数，
它还可以接收一个`key`函数来实现自定义的排序，例如按绝对值大小排序：

```python
>>> sorted([36, 5, -12, 9, -21], key=abs)
[5, 9, -12, -21, 36]
```

`key`指定的函数将作用于`list`的每一个元素上，
并根据`key`函数返回的结果进行排序。
对比原始的`list`和经过`key=abs`处理过的`list`：

```python
list = [36, 5, -12, 9, -21]
keys = [36, 5,  12, 9,  21]
```

然后`sorted()`函数按照`keys`进行排序，并按照对应关系返回list相应的元素：

我们再看一个字符串排序的例子：

```python
>>> sorted(['bob', 'about', 'Zoo', 'Credit'])
['Credit', 'Zoo', 'about', 'bob']
```

默认情况下，对字符串排序，是按照`ASCII`的大小比较的，由于`'Z'< 'a'`，结果，大写字母Z会排在小写字母a的前面。

现在，我们提出排序应该忽略大小写，按照字母序排序。要实现这个算法，不必对现有代码大加改动，只要我们能用一个key函数把字符串映射为忽略大小写排序即可。忽略大小写来比较两个字符串，实际上就是先把字符串都变成大写（或者都变成小写），再比较。

这样，我们给`sorted`传入`key`函数，即可实现忽略大小写的排序：

```python
>>> sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower)
['about', 'bob', 'Credit', 'Zoo']
```

要进行反向排序，不必改动`key`函数，可以传入第三个参数`reverse=True`：

```python
>>> sorted(
['bob', 'about', 'Zoo', 'Credit'], 
key=str.lower, 
reverse=True
)
['Zoo', 'Credit', 'bob', 'about']
```

从上述例子可以看出，高阶函数的抽象能力是非常强大的，而且，核心代码可以保持得非常简洁。

#### 小结-sorted

`sorted()`也是一个高阶函数。用`sorted()`排序的关键在于实现一个映射函数。

#### 练习-sorted

假设我们用一组`tuple`表示学生名字和成绩：

```python
L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]
```

请用`sorted()`对上述列表分别按名字排序：

```python
# -*- coding: utf-8 -*-
L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]

def by_name(t):
    return t[0]

L2 = sorted(L, key=by_name)
print(L2)
```

再按成绩从高到低排序：

```python
# -*- coding: utf-8 -*-

L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]

def by_score(t):
    return t[1]

L2 = sorted(L, key=by_score)
print(L2)
```