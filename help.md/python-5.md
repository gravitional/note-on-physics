# python-5.md

ref: [这是小白的Python新手教程][]

[这是小白的Python新手教程]: https://www.liaoxuefeng.com/wiki/1016959663602400

## 正则表达式

字符串是编程时涉及到的最多的一种数据结构，对字符串进行操作的需求几乎无处不在。比如判断一个字符串是否是合法的`Email`地址，虽然可以编程提取`@`前后的子串，再分别判断是否是单词和域名，但这样做不但麻烦，而且代码难以复用。

正则表达式是一种用来匹配字符串的强有力的武器。它的设计思想是用一种描述性的语言来给字符串定义一个规则，凡是符合规则的字符串，我们就认为它“匹配”了，否则，该字符串就是不合法的。

所以我们判断一个字符串是否是合法的`Email`的方法是：

+ 创建一个匹配`Email`的正则表达式；
+ 用该正则表达式去匹配用户的输入来判断是否合法。

因为正则表达式也是用字符串表示的，所以，我们要首先了解如何用字符来描述字符。

在正则表达式中，如果直接给出字符，就是精确匹配。用`\d`可以匹配一个数字，`\w`可以匹配一个字母或数字，所以：

+ `'00\d'`可以匹配`'007'`，但无法匹配`'00A'`；
+ `'\d\d\d'`可以匹配`'010'`；
+ `'\w\w\d'`可以匹配`'py3'`；

`.`可以匹配任意字符，所以：

`'py.'`可以匹配`'pyc'`、`'pyo'`、`'py!'`等等。

要匹配变长的字符，在正则表达式中，用`*`表示任意个字符（包括`0`个），用`+`表示至少一个字符，用`?`表示`0`个或`1`个字符，用`{n}`表示`n`个字符，用`{n,m}`表示`n-m`个字符：

来看一个复杂的例子：`\d{3}\s+\d{3,8`}。
我们来从左到右解读一下：

+ `\d{3}`表示匹配3个数字，例如`'010'`；
+ `\s`可以匹配一个空格（也包括`Tab`等空白符），所以`\s+`表示至少有一个空格，例如 `匹配`'  '`，`'    '`等；
+ `\d{3,8}`表示`3-8`个数字，例如`'1234567'`。

综合起来，上面的正则表达式可以匹配以任意个空格隔开的带区号的电话号码。

如果要匹配`'010-12345'`这样的号码呢？由于`'-'`是特殊字符，在正则表达式中，要用`'\'`转义，所以，上面的正则是`\d{3}\-\d{3,8}`。

但是，仍然无法匹配`'010 - 12345'`，因为带有空格。所以我们需要更复杂的匹配方式。

### 进阶

要做更精确地匹配，可以用`[]`表示范围，比如：

+ `[0-9a-zA-Z\_]`可以匹配一个数字、字母或者下划线；
+ `[0-9a-zA-Z\_]+`可以匹配至少由一个数字、字母或者下划线组成的字符串，比如`'a100'`，`'0_Z'`，`'Py3000'`等等；
+ `[a-zA-Z\_][0-9a-zA-Z\_]*`可以匹配由字母或下划线开头，后接任意个由一个数字、字母或者下划线组成的字符串，也就是Python合法的变量；
+ `[a-zA-Z\_][0-9a-zA-Z\_]{0, 19}`更精确地限制了变量的长度是1-20个字符（前面1个字符+后面最多19个字符）。

+ `A|B`可以匹配`A`或`B`，所以`(P|p)ython`可以匹配`'Python'`或者`'python'`。
+ `^`表示行的开头，`^\d`表示必须以数字开头。
+ `$`表示行的结束，`\d$`表示必须以数字结束。

你可能注意到了，`py`也可以匹配`'python'`，但是加上`^py$`就变成了整行匹配，就只能匹配`'py'`了。

### re模块

有了准备知识，我们就可以在Python中使用正则表达式了。Python提供`re`模块，包含所有正则表达式的功能。由于Python的字符串本身也用`\`转义，所以要特别注意：

```python
s = 'ABC\\-001' # Python的字符串
# 对应的正则表达式字符串变成：
# 'ABC\-001'
```

因此我们强烈建议使用Python的`r`前缀，就不用考虑转义的问题了：

```python
s = r'ABC\-001' # Python的字符串
# 对应的正则表达式字符串不变：
# 'ABC\-001'
```

先看看如何判断正则表达式是否匹配：

```python
>>> import re
>>> re.match(r'^\d{3}\-\d{3,8}$', '010-12345')
<_sre.SRE_Match object; span=(0, 9), match='010-12345'>
>>> re.match(r'^\d{3}\-\d{3,8}$', '010 12345')
>>>
```

`match()`方法判断是否匹配，如果匹配成功，返回一个`Match`对象，否则返回`None`。
常见的判断方法就是：

```python
test = '用户输入的字符串'
if re.match(r'正则表达式', test):
    print('ok')
else:
    print('failed')
```

### 切分字符串

用正则表达式切分字符串比用固定的字符更灵活，请看正常的切分代码：

```python
>>> 'a b   c'.split(' ')
['a', 'b', '', '', 'c']
```

嗯，无法识别连续的空格，用正则表达式试试：

```python
>>> re.split(r'\s+', 'a b   c')
['a', 'b', 'c']
```

无论多少个空格都可以正常分割。加入,试试：

```python
>>> re.split(r'[\s\,]+', 'a,b, c  d')
['a', 'b', 'c', 'd']
```

再加入;试试：

```python
>>> re.split(r'[\s\,\;]+', 'a,b;; c  d')
['a', 'b', 'c', 'd']
```

如果用户输入了一组标签，下次记得用正则表达式来把不规范的输入转化成正确的数组。
分组

除了简单地判断是否匹配之外，正则表达式还有提取子串的强大功能。用()表示的就是要提取的分组（Group）。比如：

`^(\d{3})-(\d{3,8})$`分别定义了两个组，可以直接从匹配的字符串中提取出区号和本地号码：

```python
>>> m = re.match(r'^(\d{3})-(\d{3,8})$', '010-12345')
>>> m
<_sre.SRE_Match object; span=(0, 9), match='010-12345'>
>>> m.group(0)
'010-12345'
>>> m.group(1)
'010'
>>> m.group(2)
'12345'
```

如果正则表达式中定义了组，就可以在`Match`对象上用`group()`方法提取出子串来。

注意到`group(0)`永远是原始字符串，`group(1)`、`group(2)`……表示第1、2、……个子串。

提取子串非常有用。来看一个更凶残的例子：

```python
>>> t = '19:05:30'
>>> m = re.match(r'^(0[0-9]|1[0-9]|2[0-3]|[0-9])\:(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|[0-9])\:(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|[0-9])$', t)
>>> m.groups()
('19', '05', '30')
```

这个正则表达式可以直接识别合法的时间。但是有些时候，用正则表达式也无法做到完全验证，比如识别日期：

'^(0[1-9]|1[0-2]|[0-9])-(0[1-9]|1[0-9]|2[0-9]|3[0-1]|[0-9])$'

对于`'2-30'`，`'4-31'`这样的非法日期，用正则还是识别不了，或者说写出来非常困难，这时就需要程序配合识别了。
贪婪匹配

最后需要特别指出的是，正则匹配默认是贪婪匹配，也就是匹配尽可能多的字符。举例如下，匹配出数字后面的0：

```python
>>> re.match(r'^(\d+)(0*)$', '102300').groups()
('102300', '')
```

由于`\d+`采用贪婪匹配，直接把后面的`0`全部匹配了，结果`0*`只能匹配空字符串了。

必须让`\d+`采用非贪婪匹配（也就是尽可能少匹配），才能把后面的`0`匹配出来，加个`?`就可以让`\d+`采用非贪婪匹配：

```python
>>> re.match(r'^(\d+?)(0*)$', '102300').groups()
('1023', '00')
```

### 编译

当我们在Python中使用正则表达式时，`re`模块内部会干两件事情：

+ 编译正则表达式，如果正则表达式的字符串本身不合法，会报错；
+ 用编译后的正则表达式去匹配字符串。

如果一个正则表达式要重复使用几千次，出于效率的考虑，我们可以预编译该正则表达式，接下来重复使用时就不需要编译这个步骤了，直接匹配：

```python
>>> import re
# 编译:
>>> re_telephone = re.compile(r'^(\d{3})-(\d{3,8})$')
# 使用：
>>> re_telephone.match('010-12345').groups()
('010', '12345')
>>> re_telephone.match('010-8086').groups()
('010', '8086')
```

编译后生成`Regular Expression`对象，由于该对象自己包含了正则表达式，所以调用对应的方法时不用给出正则字符串。

### 小结-正则表达式

正则表达式非常强大，要在短短的一节里讲完是不可能的。要讲清楚正则的所有内容，可以写一本厚厚的书了。如果你经常遇到正则表达式的问题，你可能需要一本正则表达式的参考书。

### 练习

请尝试写一个验证Email地址的正则表达式。版本一应该可以验证出类似的Email：

+ `someone@gmail.com`
+ `bill.gates@microsoft.com`

```python
re.match(r'^[\w\.]+?@[\w]+\.com$','bill.gates@microsoft.com')
```

```python
# -*- coding: utf-8 -*-
import re

def is_valid_email(addr):
    if re.match(r'^[\w\.]+?@[\w]+\.com$',str(addr)):
        return True
    else:
        return False

# 测试:
assert is_valid_email('someone@gmail.com')
assert is_valid_email('bill.gates@microsoft.com')
assert not is_valid_email('bob#example.com')
assert not is_valid_email('mr-bob@example.com')
print('ok')
```

版本二可以提取出带名字的Email地址：

+ `<Tom Paris> tom@voyager.org` => `Tom Paris`
+ `bob@example.com` => `bob`

```python
re.match(r'^(<([\w ]+)>)?\s*(\w+)@[\w]+\.(com|org)$', '<Tom Paris> tom@voyager.org').groups()
```

```python
re.match(r'^(<([\w ]+)>)?\s*(\w+)@[\w]+\.(com|org)$', 'bob@example.com').groups()
```

```python
# -*- coding: utf-8 -*-
import re

def name_of_email(addr):
    m=re.match(r'^(<([\w ]+)>)?\s*(\w+)@[\w]+\.(com|org)$', str(addr))
    if m[2]:
        return m[2]
    elif m[3]:
        return m[3]
    else:
        return 'no match names'

# 测试:
assert name_of_email('<Tom Paris> tom@voyager.org') == 'Tom Paris'
assert name_of_email('tom@voyager.org') == 'tom'
print('ok')
```

## 常用内建模块

Python之所以自称“batteries included”，就是因为内置了许多非常有用的模块，无需额外安装和配置，即可直接使用。

本章将介绍一些常用的内建模块。

### datetime

`datetime`是Python处理日期和时间的标准库。
获取当前日期和时间

我们先看如何获取当前日期和时间：

```python
>>> from datetime import datetime
>>> now = datetime.now() # 获取当前datetime
>>> print(now)
2015-05-18 16:28:07.198690
>>> print(type(now))
<class 'datetime.datetime'>
```

注意到`datetime`是模块，`datetime`模块还包含一个`datetime`类，
通过`from datetime import datetime`导入的才是`datetime`这个类。

如果仅导入`import datetime`，则必须引用全名`datetime.datetime`。

`datetime.now()`返回当前日期和时间，其类型是`datetime`。

#### 获取指定日期和时间

要指定某个日期和时间，我们直接用参数构造一个`datetime`：

```python
>>> from datetime import datetime
>>> dt = datetime(2015, 4, 19, 12, 20) # 用指定日期时间创建datetime
>>> print(dt)
2015-04-19 12:20:00
```

#### datetime转换为timestamp

在计算机中，时间实际上是用数字表示的。
我们把1970年1月1日 `00:00:00 UTC+00:00`时区的时刻称为`epoch time`，记为`0`（1970年以前的时间timestamp为负数），当前时间就是相对于`epoch time`的秒数，称为timestamp。

你可以认为：

```python
timestamp = 0 = 1970-1-1 00:00:00 UTC+0:00
```

对应的北京时间是：

```python
timestamp = 0 = 1970-1-1 08:00:00 UTC+8:00
```

可见`timestamp`的值与时区毫无关系，因为`timestamp`一旦确定，其`UTC`时间就确定了，转换到任意时区的时间也是完全确定的，这就是为什么计算机存储的当前时间是以`timestamp`表示的，因为全球各地的计算机在任意时刻的`timestamp`都是完全相同的（假定时间已校准）。

把一个`datetime`类型转换为`timestamp`只需要简单调用`timestamp`()方法：

```python
>>> from datetime import datetime
>>> dt = datetime(2015, 4, 19, 12, 20) # 用指定日期时间创建datetime
>>> dt.timestamp() # 把datetime转换为timestamp
1429417200.0
```

注意Python的`timestamp`是一个浮点数。如果有小数位，小数位表示毫秒数。

某些编程语言（如Java和JavaScript）的`timestamp`使用整数表示毫秒数，这种情况下只需要把`timestamp`除以1000就得到Python的浮点表示方法。

#### timestamp转换为datetime

要把`timestamp`转换为`datetime`，使用`datetime`提供的`fromtimestamp`()方法：

```python
>>> from datetime import datetime
>>> t = 1429417200.0
>>> print(datetime.fromtimestamp(t))
2015-04-19 12:20:00
```

注意到`timestamp`是一个浮点数，它没有时区的概念，
而`datetime`是有时区的。上述转换是在`timestamp`和本地时间做转换。

本地时间是指当前操作系统设定的时区。例如北京时区是东8区，则本地时间：

```python
2015-04-19 12:20:00
```

实际上就是UTC+8:00时区的时间：

```python
2015-04-19 12:20:00 UTC+8:00
```

而此刻的格林威治标准时间与北京时间差了8小时，也就是UTC+0:00时区的时间应该是：

```python
2015-04-19 04:20:00 UTC+0:00
```

`timestamp`也可以直接被转换到UTC标准时区的时间：

```python
>>> from datetime import datetime
>>> t = 1429417200.0
>>> print(datetime.fromtimestamp(t)) # 本地时间
2015-04-19 12:20:00
>>> print(datetime.utcfromtimestamp(t)) # UTC时间
2015-04-19 04:20:00
```

#### str转换为datetime

很多时候，用户输入的日期和时间是字符串，要处理日期和时间，
首先必须把`str`转换为`datetime`。
转换方法是通过`datetime.strptime()`实现，需要一个日期和时间的格式化字符串：
p should be parse

```python
>>> from datetime import datetime
>>> cday = datetime.strptime('2015-6-1 18:19:59', '%Y-%m-%d %H:%M:%S')
>>> print(cday)
2015-06-01 18:19:59
```

字符串`'%Y-%m-%d %H:%M:%S'`规定了日期和时间部分的格式。
[详细的说明请参考Python文档][].

[详细的说明请参考Python文档]: https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior

注意转换后的`datetime`是没有时区信息的。

#### datetime转换为str

如果已经有了`datetime`对象，要把它格式化为字符串显示给用户，就需要转换为str，转换方法是通过`strftime()`实现的，同样需要一个日期和时间的格式化字符串：

```python
>>> from datetime import datetime
>>> now = datetime.now()
>>> print(now.strftime('%a, %b %d %H:%M'))
Mon, May 05 16:28
```

#### datetime加减

对日期和时间进行加减实际上就是把`datetime`往后或往前计算，得到新的`datetime`。加减可以直接用+和-运算符，不过需要导入timedelta这个类：

```python
>>> from datetime import datetime, timedelta
>>> now = datetime.now()
>>> now
datetime.datetime(2015, 5, 18, 16, 57, 3, 540997)
>>> now + timedelta(hours=10)
datetime.datetime(2015, 5, 19, 2, 57, 3, 540997)
>>> now - timedelta(days=1)
datetime.datetime(2015, 5, 17, 16, 57, 3, 540997)
>>> now + timedelta(days=2, hours=12)
datetime.datetime(2015, 5, 21, 4, 57, 3, 540997)
```

可见，使用`timedelta`你可以很容易地算出前几天和后几天的时刻。

#### 本地时间转换为UTC时间

本地时间是指系统设定时区的时间，例如北京时间是`UTC+8:00`时区的时间，
而`UTC`时间指`UTC+0:00`时区的时间。

一个`datetime`类型有一个时区属性`tzinfo`，但是默认为`None`，
所以无法区分这个`datetime`到底是哪个时区，除非强行给`datetime`设置一个时区：

```python
>>> from datetime import datetime, timedelta, timezone
>>> tz_utc_8 = timezone(timedelta(hours=8)) # 创建时区UTC+8:00
>>> now = datetime.now()
>>> now
datetime.datetime(2015, 5, 18, 17, 2, 10, 871012)
>>> dt = now.replace(tzinfo=tz_utc_8) # 强制设置为UTC+8:00
>>> dt
datetime.datetime(2015, 5, 18, 17, 2, 10, 871012, tzinfo=datetime.timezone(datetime.timedelta(0, 28800)))
```

如果系统时区恰好是`UTC+8:00`，那么上述代码就是正确的，
否则，不能强制设置为`UTC+8:00`时区。

#### 时区转换

我们可以先通过`utcnow()`拿到当前的`UTC`时间，再转换为任意时区的时间：

```python
# 拿到UTC时间，并强制设置时区为UTC+0:00:
>>> utc_dt = datetime.utcnow().replace(tzinfo=timezone.utc)
>>> print(utc_dt)
2015-05-18 09:05:12.377316+00:00
# astimezone()将转换时区为北京时间:
>>> bj_dt = utc_dt.astimezone(timezone(timedelta(hours=8)))
>>> print(bj_dt)
2015-05-18 17:05:12.377316+08:00
# astimezone()将转换时区为东京时间:
>>> tokyo_dt = utc_dt.astimezone(timezone(timedelta(hours=9)))
>>> print(tokyo_dt)
2015-05-18 18:05:12.377316+09:00
# astimezone()将bj_dt转换时区为东京时间:
>>> tokyo_dt2 = bj_dt.astimezone(timezone(timedelta(hours=9)))
>>> print(tokyo_dt2)
2015-05-18 18:05:12.377316+09:00
```

时区转换的关键在于，拿到一个`datetime`时，要获知其正确的时区，
然后强制设置时区，作为基准时间。

利用带时区的`datetime`，通过`astimezone()`方法，可以转换到任意时区。

注：不是必须从`UTC+0:00`时区转换到其他时区，任何带时区的`datetime`都可以正确转换，例如上述`bj_dt`到`tokyo_dt`的转换。

#### 小结-datetime

`datetime`表示的时间需要时区信息才能确定一个特定的时间，否则只能视为本地时间。

如果要存储`datetime`，最佳方法是将其转换为`timestamp`再存储，因为`timestamp`的值与时区完全无关。

#### 练习-datetime

假设你获取了用户输入的日期和时间如`'2015-1-21 9:01:30'`，以及一个时区信息如`'UTC+5:00'`，均是`str`，请编写一个函数将其转换为`timestamp`：

```python
# -*- coding:utf-8 -*-

import re
from datetime import datetime, timezone, timedelta

def to_timestamp(dt_str, tz_str, timezone_local=8):
    # 本机时区为 UTC+8:00
    the_time = datetime.strptime(str(dt_str), '%Y-%m-%d %H:%M:%S')
    #解析输入的时间，时区是UTC+8
    time_delta_hour=int(
        re.match(r'^UTC((?:\+|\-)\d+):\d+',str(tz_str)).group(1)
        )-timezone_local
        # 正则表达式抽出 输入的时区，然后-8，得到与本地时区的差
    the_time_local = the_time - timedelta(hours=time_delta_hour)
    # 得到输入时间在本地时区的表示
    return the_time_local.timestamp()
    #返回timestamp表示

# 测试:
t1 = to_timestamp('2015-6-1 08:10:30', 'UTC+7:00')
assert t1 == 1433121030.0, t1

t2 = to_timestamp('2015-5-31 16:10:30', 'UTC-09:00')
assert t2 == 1433121030.0, t2

print('ok')
```

### collections
