# python.x

[python标准库文档][]

[python标准库文档]: https://docs.python.org/3/library/index.html

## 如何阅读python文档

1.2. 标注

句法和词法解析的描述采用经过改进的 `BNF` 语法标注。这包含以下定义样式:

```python
name      ::=  lc_letter (lc_letter | "_")*
lc_letter ::=  "a"..."z"
```

第一行表示 `name` 是一个 `lc_letter` 之后跟零个或多个 `lc_letter` 和下划线。
而一个 `lc_letter` 则是任意单个 `'a'` 至 `'z'` 字符。(实际上在本文档中始终采用此规则来定义词法和语法规则的名称。)

每条`规则`的开头是一个名称 (即该规则所定义的名称) 加上 `::=`。竖线 (`|`) 被用来分隔可选项；它是此标注中最灵活的操作符。
星号 (`*`) 表示前一项的零次或多次重复；
类似地，加号 (`+`) 表示一次或多次重复，而由方括号括起的内容 (`[ ]`) 表示出现零次或一次 (或者说，这部分内容是可选的)。
`*` 和 `+` 操作符的绑定是最紧密的；圆括号用于分组。
固定字符串包含在引号内。空格的作用仅限于分隔形符。
每条规则通常为一行；有许多个可选项的规则可能会以竖线为界分为多行。

在词法定义中 (如上述示例)，还额外使用了两个约定: 

+ 由三个点号`...`分隔的两个字符字面值表示在指定 (闭) 区间范围内的任意单个 `ASCII` 字符。
+ 由尖括号 (`<...>`) 括起来的内容是对于所定义符号的非正式描述；即可以在必要时用来说明 '控制字符' 的意图。

虽然所用的标注方式几乎相同，但是词法定义和句法定义是存在很大区别的: 
词法定义作用于输入源中单独的字符，而句法定义则作用于由词法分析所生成的`形符`(`tokens`)流。
在下一章节 ("词法分析") 中使用的 `BNF` 全部都是词法定义；在之后的章节中使用的则是句法定义。

## Python运行外部程序

[Python运行外部程序的几种方法][]

[Python运行外部程序的几种方法]: https://blog.csdn.net/xiligey1/article/details/80267983 

### subprocess --- 子进程管理

示例

```python
>>> subprocess.run(["ls", "-l"])  # doesn't capture output
CompletedProcess(args=['ls', '-l'], returncode=0)

>>> subprocess.run("exit 1", shell=True, check=True)
Traceback (most recent call last):
  ...
subprocess.CalledProcessError: Command 'exit 1' returned non-zero exit status 1

>>> subprocess.run(["ls", "-l", "/dev/null"], capture_output=True)
CompletedProcess(args=['ls', '-l', '/dev/null'], returncode=0,
stdout=b'crw-rw-rw- 1 root root 1, 3 Jan 23 16:23 /dev/null\n', stderr=b'')
```

### os.system运行外部程序

使用os.system函数运行其他程序或脚本

```python
import os
os.system('notepad python.txt')
```

***
使用`ShellExecute`函数运行其他程序

`ShellExecute(hwnd,op,file,params,dir,bShow)`

+ `hwnd`: 父窗口的句柄，若没有则为`0`
+ `op`: 要进行的操作，为`open`，`print` or `空`
+ `file`: 要运行的程序或脚本
+ `params`:  要向程序传递的参数，如果打开的是文件则为`空`
+ `dir`: 程序初始化的`目录`
+ `bShow`: 是否显示窗口

```python
ShellExecute(0, 'open', 'notepad.exe', 'python.txt', '', 1)
ShellExecute(0,'open','http://www.baidu.com','','',1)
ShellExecute(0,'open','F:\\Love\\Lady Antebellum - Need You Now.ape','','',1)
ShellExecute(0,'open','D:\Python\Code\Crawler\HanhanBlog.py','','',1)
```

***
使用`CreateProcess`函数

```python
import win32process
from win32process import CreateProcess
CreateProcess('c:\\windows\\notepad.exe', '', None, None, 0,
        win32process.CREATE_NO_WINDOW, None, None,
        win32process.STARTUPINFO())
```

***
用subprocess.call()

[python调用外部程序][]

[python调用外部程序]: https://blog.csdn.net/u011722133/article/details/80430439

`status = subprocess.call("mycmd"   " myarg", shell=True)`

比如

```python
#!/usr/bin/env python3
import os
import subprocess
# use os.system
os.system("ls  -lah /home/tom/Downloads")
print('\nuse another\n')
# use subprocess.call
subprocess.call("ls  -lah /home/tom/Downloads",shell=True)
```

## Python获取帮助

[Python获取帮助的3种方式][]

[Python获取帮助的3种方式]: https://blog.csdn.net/DQ_DM/article/details/45672623

***
help()

`help`函数是Python的一个内置函数。
函数原型：`help([object])`。
可以帮助我们了解该对象的更多信息。
If no argument is given, the interactive help system starts on the interpreter console.

***
`dir`函数是Python的一个内置函数。
函数原型：`dir([object])`
可以帮助我们获取该对象的大部分相关属性。
Without arguments, return the list of names in the current local scope. 

***
在Python中有一个奇妙的特性，文档字符串，又称为DocStrings。
用它可以为我们的模块、类、函数等添加说明性的文字，使程序易读易懂，
更重要的是可以通过Python自带的标准方法将这些描述性文字信息输出。

上面提到的自带的标准方法就是`__doc__`。前后各两个下划线。
注：当不是函数、方法、模块等调用`doc`时，而是具体对象调用时，会显示此对象从属的类型的构造函数的文档字符串。

### 操作文件和目录

Python内置的`os`模块也可以直接调用操作系统提供的接口函数。

```python
>>> import os
>>> os.name # 操作系统类型
'posix'
# 给出详细的系统信息
>>> os.uname()
('Linux', 'OP7050', '4.15.0-112-generic', '#113-Ubuntu SMP Thu Jul 9 23:41:39 UTC 2020', 'x86_64')
# 给出环境变量
>>> os.environ
environ({'VERSIONER_PYTHON_PREFER_32_BIT': 'no', 'TERM_PROGRAM_VERSION': '326', 'LOGNAME': 'michael', 'USER': 'michael', 'PATH': '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/mysql/bin', ...})
# 要获取某个环境变量的值
>>> os.environ.get('PATH')
```

***
操作文件和目录的函数一部分放在`os`模块中，一部分放在`os.path`模块中

+ 查看当前目录的绝对路径：`os.path.abspath('.')`
+ 合并路径：`os.path.join('/Users/michael', 'testdir')`
+ 拆分路径：`os.path.split()`
+ 创建一个目录：`os.mkdir('/Users/michael/testdir')`
+ 删掉一个目录：`os.rmdir('/Users/michael/testdir')`
+ 获得文件扩展名：`os.path.splitext()`

`os.mkdir(path[, mode])`: 以数字mode的mode创建一个名为`path`的文件夹.默认的 `mode` 是 `0777 `

这些合并、拆分路径的函数**并不要求目录和文件要真实存在**，它们只对字符串进行操作。

文件操作使用下面的函数。假定当前目录下有一个`test.txt`文件：

+ 对文件重命名：`os.rename('test.txt', 'test.py')`
+ 删掉文件：`os.remove('test.py')`

但是复制文件的函数居然在`os`模块中不存在！原因是复制文件并非由操作系统提供的系统调用。
幸运的是`shutil`模块提供了`copyfile()`的函数，你还可以在`shutil`模块中找到很多实用函数，它们可以看做是`os`模块的补充。

***
利用Python的特性来过滤文件。比如我们要列出当前目录下的所有**目录**，只需要一行代码：

```python
>>> [x for x in os.listdir('.') if os.path.isdir(x)]
['.lein', '.local', '.m2', '.npm', '.ssh', '.Trash', '.vim', 'Applications', 'Desktop', ...]
```

要列出所有的`.py`文件，也只需一行代码：

```python
>>> [x for x in os.listdir('.') if os.path.isfile(x) and os.path.splitext(x)[1]=='.py']
['apis.py', 'config.py', 'models.py', 'pymonitor.py', 'test_db.py', 'urls.py', 'wsgiapp.py']
```

### shutil模块

安装
`pip install shutil`

***
复制文件

1. `shutil.copy('来源文件','目标地址')` : 返回值是复制之后的路径
2. `shutil.copy2()` ,`shutil.copy()` :差不多，复制后的结果保留了原来的所有信息（包括状态信息）
3. `shutil.copyfile(来源文件,目标文件)`  : 将一个文件的内容拷贝的另外一个文件当中,返回值是复制之后的路径
4. `shutil.copyfileobj(open(来源文件,'r'),open('目标文件','w'))` :将一个文件的内容拷贝的另外一个文件当中
5. `shutil.copytree(来源目录,目标目录)` : 复制整个文件目录 (无论文件夹是否为空，均可复制，而且会复制文件夹中的所有内容)
6. `copymode()`,`copystat()` 不常用

***
删除文件

1. `shutil.rmtree(目录路径)` #移除整个目录，无论是否空(删除的是文件夹，如果删除文件`os.unlink(path)`)
2. `shutil.move(来源地址,目标地址)`#移动文件

***
案列分享

有时候在进行大量文件复制的过程中，会出现同样名字被覆盖的问题，看到很多案列感觉麻烦，懒人有懒人的办法

```python
#!/usr/bin/env python3
import os,shutil,time
# 判断文件名已经存在

print(
os.path.split(os.path.abspath('.'))
)

file_path=os.path.join('/home','tom','note','python')
filename='os.txt'

if os.path.exists(os.path.join('.','')):
#把原来的文件名进行改掉   
#主要是如果循环多，重复的名字多，所以用时间戳进行代替，不会弄重复  
    os.rename(
    os.path.join(file_path,filename),
    os.path.join(file_path,str(time.time())+filename)
    )
```

[python操作文件，强大的shutil模块][]

[python操作文件，强大的shutil模块]: https://www.jianshu.com/p/e62b05f08179

### 序列化

在程序运行的过程中，所有的变量都是在内存中，比如，定义一个`dict`:`d = dict(name='Bob', age=20, score=88)`

我们把变量从内存中变成可存储或传输的过程称之为序列化，在Python中叫`pickling`，在其他语言中也被称之为`serialization`，`marshalling`，`flattening`等等，都是一个意思。

序列化之后，就可以把序列化后的内容写入磁盘，或者通过网络传输到别的机器上。
反过来，把变量内容从序列化的对象重新读到内存里称之为反序列化，即`unpickling`。
Python提供了`pickle`模块来实现序列化。

首先，我们尝试把一个对象序列化并写入文件：

```python
>>> import pickle
>>> d = dict(name='Bob', age=20, score=88)
>>> pickle.dumps(d)
b'...'
```

`pickle.dumps()`方法把任意对象序列化成一个`bytes`，然后，就可以把这个`bytes`写入文件。
或者用另一个方法`pickle.dump()`直接把对象序列化后写入一个`file-like Object`：

```python
>>> f = open('dump.txt', 'wb')
>>> pickle.dump(d, f)
>>> f.close()
```

看看写入的`dump.txt`文件，一堆乱七八糟的内容，这些都是Python保存的对象内部信息。

当我们要把对象从磁盘读到内存时，可以先把内容读到一个`bytes`，然后用`pickle.loads()`方法反序列化出对象，也可以直接用`pickle.load()`方法从一个`file-like Object`中直接反序列化出对象。
我们打开另一个Python命令行来反序列化刚才保存的对象：

```python
>>> f = open('dump.txt', 'rb')
>>> d = pickle.load(f)
>>> f.close()
>>> d
{'age': 20, 'score': 88, 'name': 'Bob'}
```

变量的内容又回来了！

Pickle的问题和所有其他编程语言特有的序列化问题一样，就是它只能用于Python，并且可能不同版本的Python彼此都不兼容，因此，只能用Pickle保存那些不重要的数据，不能成功地反序列化也没关系。

### 文件读写

读写文件是最常见的IO操作。Python内置了读写文件的函数，用法和C是兼容的。

读写文件前，我们先必须了解一下，在磁盘上读写文件的功能都是由操作系统提供的，现代操作系统不允许普通的程序直接操作磁盘，所以，读写文件就是请求操作系统打开一个文件对象（通常称为文件描述符），然后，通过操作系统提供的接口从这个文件对象中读取数据（读文件），或者把数据写入这个文件对象（写文件）。

#### 读文件

读文件使用Python内置的`open()`函数，传入文件名和标示符：

+ 打开文件（读取）：`f = open('/Users/thomas/desktop/test.py', 'r')`
+ 打开文件（写入）`f = open('/Users/michael/test.txt', 'w')`
+ 关闭文件：`f.close()`
+ 读取内容：`f.read()`
+ 每次最多读取`size`个字节的内容：`read(size)`方法
+ 每次读取一行内容： `readline()`
+ 一次读取所有内容并按行返回`list`：`readlines()`
+ 要读取二进制文件，比如图片、视频等等，用'`rb`'模式：` f = open('/Users/michael/test.jpg', 'rb')`
+ 给`open()`函数传入编码参数（一般是uft-8）：`f = open('/Users/michael/gbk.txt', 'r', encoding='gbk')`
+ 忽略未识别字符`f = open('/Users/michael/gbk.txt', 'r', encoding='gbk', errors='ignore')`

Python引入了`with`语句来自动帮我们调用`close()`方法：

```python
with open('/path/to/file', 'r') as f:
    print(f.read())
```

写文件和读文件是一样的，唯一区别是调用`open()`函数时，传入标识符`'w'`或者`'wb'`表示写文本文件或写二进制文件：

```python
>>> f = open('/Users/michael/test.txt', 'w')
>>> f.write('Hello, world!')
>>> f.close()
```

你可以反复调用`write()`来写入文件，但是务必要调用`f.close()`来关闭文件。当我们写文件时，操作系统往往不会立刻把数据写入磁盘，而是放到内存缓存起来，空闲的时候再慢慢写入。所以，还是用`with`语句来得保险：

```python
with open('/Users/michael/test.txt', 'w') as f:
    f.write('Hello, world!')
```

要写入特定编码的文本文件，请给`open()`函数传入`encoding`参数，将字符串自动转换成指定编码。

如果我们希望追加到文件末尾怎么办？可以传入`'a'`以追加（`append`）模式写入。

所有模式的定义及含义可以参考 [Python的官方文档][]。

[Python的官方文档]: https://docs.python.org/3/library/functions.html#open

## python 空语句

`pass`

## 条件判断和循环

***
判断样式

```python
age = 3
if age >= 18:
    print('adult')
elif age >= 6:
    print('teenager')
else:
    print('kid')
```

***
`for x in ...`循环就是把每个元素代入变量`x`，然后执行缩进块的语句。
Python提供一个`range()`函数，可以生成一个整数序列，再通过`list()`函数可以转换为`list`。

```python
>>> list(range(5))
[0, 1, 2, 3, 4]
```

```python
sum = 0
for x in range(101):
    sum = sum + x
print(sum)
```

***
第二种循环是`while`循环，只要条件满足，就不断循环，条件不满足时退出循环。
比如我们要计算`100`以内所有奇数之和，可以用`while`循环实现：

```python
sum = 0
n = 99
while n > 0:
    sum = sum + n
    n = n - 2
print(sum)
```

如果要提前结束循环，可以用`break`语句：
在循环过程中，也可以通过`continue`语句，跳过当前的这次循环，直接开始下一次循环。

## formfactor 脚本

### 复制结果的脚本

```python
#!/usr/bin/env python3
import os,shutil,time,gfm
# 复制到论文中的都是 ci==1.50 的结果
user_name='tom'
# 配置计算结果目录，论文目录，论文压缩文件目录
originpath=os.getcwd()
paper_path=os.path.join('/home',user_name,'private','paper-2.prd/')
desk_path=os.path.join('/home',user_name,'Desktop','paper.ff/')
# 复制计算结果到论文目录
shutil.copy('fig.baryons.ge.charge.L-0.90.ci-1.50.pdf', paper_path+'fig4.pdf') 
shutil.copy('fig.baryons.ge.neutral.L-0.90.ci-1.50.pdf', paper_path+'fig5.pdf') 
shutil.copy('fig.baryons.gm.charge.L-0.90.ci-1.50.pdf', paper_path+'fig2.pdf') 
shutil.copy('fig.baryons.gm.neutral.L-0.90.ci-1.50.pdf', paper_path+'fig3.pdf') 
# cd 到论文目录，重新编译论文
os.chdir(paper_path)
os.system('./build.sh')
# 如果桌面有压缩文件目录，就删除，shutil.copytree需要目标不存在
if  os.path.isdir(desk_path):
    shutil.rmtree(desk_path)
    # 把论文目录的东西复制到桌面目录中
    shutil.copytree('.',desk_path)
else:
    shutil.copytree('.',desk_path)

print("+++++++\nthe file copied from paper_path\n+++++++")
os.listdir(desk_path)

## 切换到桌面整理目录
os.chdir(desk_path )
print("+++++++\ndelete auxilary files\n +++++++")

rm_list=['*.aux','*.lof','*.log','*.lot','*.fls','*.out',
'*.toc', '*.fmt','*.fot','*.cb','*.cb2','*.ptc','*.xdv','*.fdb_latexmk',
'*.synctex.gz','*.swp','*.ps1','*.sh','*.bib','*.bbl','*.blg',
'*.py','*.pyc','__pycache__'
]

for aux in rm_list:
    gfm.rma('.',aux)

print("+++++++\nthe file left in",os.getcwd(),"\n+++++++")
os.listdir(desk_path)

# 产生论文压缩文件
os.system(('7z a ../paper.7z '+desk_path))
# 回到原来的文件夹
os.listdir(originpath)
```

## 模块

Python本身就内置了很多非常有用的模块，只要安装完毕，这些模块就可以立刻使用。

### 模块写法

我们以内建的`sys`模块为例，编写一个`hello`的模块：

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Michael Liao'

import sys

def test():
    args = sys.argv
    if len(args)==1:
        print('Hello, world!')
    elif len(args)==2:
        print('Hello, %s!' % args[1])
    else:
        print('Too many arguments!')

if __name__=='__main__':
    test()
```

第`1`行和第`2`行是标准注释，
第`1`行注释可以让这个`hello.py`文件直接在`Unix/Linux/Mac`上运行，第`2`行注释表示`.py`文件本身使用标准`UTF-8`编码；

第`4`行是一个字符串，表示模块的文档注释，**任何模块代码的第一个字符串都被视为模块的文档注释**；

第`6`行使用`__author__`变量把作者写进去，这样当你公开源代码后别人就可以瞻仰你的大名；

以上就是Python模块的标准文件模板，当然也可以全部删掉不写，但是，按标准办事肯定没错。

后面开始就是真正的代码部分。

你可能注意到了，使用`sys`模块的第一步，就是导入该模块：
`import sys`

导入`sys`模块后，我们就有了变量`sys`指向该模块，利用`sys`这个变量，就可以访问`sys`模块的所有功能。

`sys`模块有一个`argv`变量，用`list`存储了命令行的所有参数。`argv`至少有一个元素，因为第一个参数永远是该`.py`文件的名称，例如：

运行`python3 hello.py Michael`获得的`sys.argv`就是`['hello.py', 'Michael]`。

最后，注意到这两行代码：

```python
if __name__=='__main__':
    test()
```

当我们在命令行运行`hello`模块文件时，Python解释器把一个特殊变量`__name__`置为`__main__`，而如果在其他地方导入该`hello`模块时，`if`判断将失败，因此，这种`if`测试可以让一个模块通过命令行运行时执行一些额外的代码，最常见的就是运行测试。

我们可以用命令行运行`hello.py`看看效果：

```bash
$ python3 hello.py
Hello, world!
$ python hello.py Michael
Hello, Michael!
```

如果启动Python交互环境，再导入hello模块：

```python
$ python3
Python 3.4.3...
>>> import hello
```

导入时，没有打印`Hello, word!`，因为没有执行`test()`函数。

调用`hello.test()`时，才能打印出Hello, word!：

```python
>>> hello.test()
Hello, world!
```

### 导入自己的Python模块

[编写你自己的Python模块][]

[编写你自己的Python模块]: https://www.cnblogs.com/yuanrenxue/p/10675135.html
 
每一个 Python 程序同时也是一个模块。你只需要保证它以 `.py` 为扩展名即可。下面的案例会作出清晰的解释。

***
案例（保存为 `mymodule.py`）：

```python
def say_hi():
    print('Hi, this is mymodule speaking.')

__version__ = '0.1'
```

上方所呈现的就是一个简单的模块, 与我们一般所使用的 Python 的程序并没有什么特殊的区别。我们接下来将看到如何在其它 Python 程序中使用这一模块。

要记住该模块应该放置于与其它我们即将导入这一模块的程序相同的目录下，或者是放置在`sys.path`所列出的其中一个目录下。

另一个模块（保存为`mymodule_demo.py`）：

```python
import mymodule

mymodule.say_hi()
print('Version', mymodule.__version__)
```

输出：

```python
$ python mymodule_demo.py
Hi, this is mymodule speaking.
Version 0.1
```

***
下面是一个使用 `from...import` 语法的范本（保存为 `mymodule_demo2.py`）：

```python
from mymodule import say_hi, __version__

say_hi()
print('Version', __version__)
```

`mymodule_demo2.py` 所输出的内容与 `mymodule_demo.py` 所输出的内容是一样的。

在这里需要注意的是，如果导入到 `mymodule` 中的模块里已经存在了` __version__` 这一名称，那将产生冲突。
这可能是因为每个模块通常都会使用这一名称来声明它们各自的版本号。
因此最好使用 `import` 语句，尽管这会使你的程序变得稍微长一些。

你还可以使用：

```python
from mymodule import *
```

这将导入诸如 `say_hi` 等所有公共名称，但不会导入 `__version__` 名称，因为后者以双下划线开头。

警告：要记住你应该避免使用 `import`的这种形式，即 `from mymodule import `。

>Python 的一大指导原则是“明了胜过晦涩，你可以通过在 Python 中运行 `import this` 来了解更多内容。

### 作用域

在一个模块中，我们可能会定义很多函数和变量，但有的函数和变量我们希望给别人使用，有的函数和变量我们希望仅仅在模块内部使用。在Python中，是通过`_`前缀来实现的。

正常的函数和变量名是公开的（`public`），可以被直接引用，比如：`abc`，`x123`，`PI`等；

类似`__xxx__`这样的变量是特殊变量，可以被直接引用，但是有特殊用途，比如上面的`__author__`，`__name__`就是特殊变量，hello模块定义的文档注释也可以用特殊变量`__doc__`访问，我们自己的变量一般不要用这种变量名；

类似`_xxx`和`__xxx`这样的函数或变量就是非公开的（private），不应该被直接引用，比如`_abc`，`__abc`等；

之所以我们说，private函数和变量“不应该”被直接引用，而不是“不能”被直接引用，是因为Python并没有一种方法可以完全限制访问private函数或变量，但是，从编程习惯上不应该引用private函数或变量。

private函数或变量不应该被别人引用，那它们有什么用呢？请看例子：

```python
def _private_1(name):
    return 'Hello, %s' % name

def _private_2(name):
    return 'Hi, %s' % name

def greeting(name):
    if len(name) > 3:
        return _private_1(name)
    else:
        return _private_2(name)
```

我们在模块里公开`greeting()`函数，而把内部逻辑用private函数隐藏起来了，这样，调用`greeting()`函数不用关心内部的private函数细节，这也是一种非常有用的代码封装和抽象的方法，即：

外部不需要引用的函数全部定义成private，只有外部需要引用的函数才定义为public。

如果一个函数定义中包含`yield`关键字，那么这个函数就不再是一个普通函数，而是一个`generator`：

### 通配符删除文件

[Python 通配符删除文件][]

[Python 通配符删除文件]: https://blog.csdn.net/mathcompfrac/article/details/75331440

```python
# -*- coding: utf-8 -*-
"""
使用通配符，获取所有文件，或进行操作。
"""

__author__ = '飞鸽传说'

import glob,os

# 给出当前目录下的文件的generator
def files(curr_dir = '.', ext = '*.aux'): # 指定默认变量，目录和拓展名
    """给出当前目录下的文件"""
    for i in glob.glob(os.path.join(curr_dir, ext)):
        yield i

# 给出所有文件的generator
def all_files(rootdir, ext):
    """给出当前目录下以及子目录的文件"""
    for name in os.listdir(rootdir):
        if os.path.isdir(os.path.join(rootdir, name)):#判断是否为文件夹
            try:
                for sub_file in all_files(os.path.join(rootdir, name), ext):
                    # 递归地给出所有子文件夹中的文件
                    yield sub_file
            except:
                pass
    for cwd_file in files(rootdir, ext):
        yield cwd_file

# 删除文件的函数，默认不显示
def remove_files(rootdir, ext, show = False):
    """删除rootdir目录下的符合的文件"""
    for cwd_file in files(rootdir, ext):
        if show:
            print cwd_file
        os.remove(cwd_file)

# 删除所有文件的函数，默认不显示
def remove_all_files(rootdir, ext, show = False):
    """删除rootdir目录下以及子目录下符合的文件"""
    for rec_file in all_files(rootdir, ext):
        if show:
            print rec_file
        os.remove(rec_file)

# 如果在命令行运行，Python解释器把一个特殊变量__name__置为__main__
if __name__ == '__main__':
    #这一行删除预设的文件
    remove_all_files('.', '*.aux', show = True)
    # remove_all_files('.', '*.exe', show = True)
    remove_files('.', '*.aux', show = True)
    # for i in files('.','*.c'):
        # print i
```

## 函数

```python
def write_result(str):
  writeresult=file(r'D:\eclipse4.4.1 script\my_selenium\model\test_result.log','a+')
  str1=writeresult.write(str+'\n')
  writeresult.close()
  return str
```

函数参数类型，一共五种

装饰器

map reduce

## python库

### glob

[python标准库之glob介绍][]

[python标准库之glob介绍]: https://www.cnblogs.com/luminousjj/p/9359543.html

`glob` 文件名模式匹配，不用遍历整个目录判断每个文件是不是符合。

#### 通配符*

星号`*`匹配零个或多个字符

```python
import glob
for name in glob.glob('dir/*'):
    print (name)
```

列出子目录中的文件，必须在模式中包括子目录名：

```python
import glob

#用子目录查询文件
print ('Named explicitly:')
for name in glob.glob('dir/subdir/*'):
    print ('\t', name)
#用通配符* 代替子目录名
print ('Named with wildcard:')
for name in glob.glob('dir/*/*'):
    print ('\t', name)
```

#### 单个字符通配符?

用问号`?`匹配任何单个的字符。

```python
import glob

for name in glob.glob('dir/file?.txt'):
    print (name)
```

#### 字符范围

当需要匹配一个特定的字符，可以使用一个范围

```python
import glob
for name in glob.glob('dir/*[0-9].*'):
    print (name)
```

## python vscode 调试

`open launch.json` 打开调试文件

有两种标准配置，或者在`code`的集成终端中运行，或者在外部终端运行：

```json
{
    "name": "Python: Current File (Integrated Terminal)",
    "type": "python",
    "request": "launch",
    "program": "${file}",
    "console": "integratedTerminal"
},
{
    "name": "Python: Current File (External Terminal)",
    "type": "python",
    "request": "launch",
    "program": "${file}",
    "console": "externalTerminal"
}
```

还可以添加其他设置如`args`，但它不属于标准配置的一部分。比如，你总要 launch `startup.py` with the arguments `--port 1593`，可以添加如下配置：

```bash
 {
     "name": "Python: startup.py",
     "type": "python",
     "request": "launch",
     "program": "${workspaceFolder}/startup.py",
     "args" : ["--port", "1593"]
 },
```

+ `name` : `vscode` 下拉列表中的名字
+ `type`: type of debugger to use; leave this set to python for Python code.
+ `request` : Specifies the mode in which to start debugging:
`launch`: start the debugger on the file specified in program
`attach`: attach the debugger to an already running process. See Remote debugging for an example.
+ `program`: 程序的路径。`${file}`，当前激活的编辑器,可以是绝对路径，也可以是相对路径，如：`"program": "${workspaceFolder}/pokemongo_bot/event_handlers/__init__.py"`
+ `python`: 用来debug的python 解释器的全路径。如果不指定，使用`python.pythonPath`,等价于`${config:python.pythonPath}`，也可以使用环境变量。还可以向解释器传递参数，`"python": ["<path>", "<arg>",...]`.
+ `args` : 传递给 python 程序的参数。如`"args": ["--quiet", "--norepeat", "--port", "1593"]`
+ `stopOnEntry`： 当设置为`true`时，在地一行停下。默认忽略，在第一个间断点停下。
+ `console`:  指定程序如何输出结果，可以设置成`"internalConsole"`,`"externalTerminal"`,`"integratedTerminal" (default)`
+ `cwd` 指定当前工作目录，默认为`${workspaceFolder}` (打开`vscode`的目录)
+ `redirectOutput`: 是否重定向debug输出。选择`XXterminal`时，默认关闭。(不在VS code debug window中输出)
+ `justMyCode`: `true`或忽略，只调试用户写的代码。`false`也调试标准库函数。
+ `django`: When set to true, activates debugging features specific to the Django web framework.
+ `sudo`: 设置为`true`,且调试窗口选择为`externalTerminal`时，可以提升权限
+ `pyramid` : When set to true, ensures that a Pyramid app is launched with the necessary pserve command.
+ `env`: 设置可选的环境变量，为debugger 进程，除了系统变量之外。值必须为字符串。
+ `envFile`: Optional path to a file that contains environment variable definitions. See Configuring Python environments - environment variable definitions file.
+ `gevent`: If set to true, enables debugging of gevent monkey-patched code.

## python 格式化输出

[更漂亮的输出格式][]

[更漂亮的输出格式]: https://docs.python.org/zh-cn/3/tutorial/inputoutput.html#formatted-string-literals

要使用 格式化字符串字面值 ，请在字符串的开始引号或三引号之前加上一个 `f` 或 `F` 。
在此字符串中，在 `{` 和 `}` 字符之间可以引用变量或字面值的 Python 表达式。

```bash
>>> year = 2016
>>> event = 'Referendum'
>>> f'Results of the {year} {event}'
'Results of the 2016 Referendum'
```

## python 词法分析

[词法分析¶][]

[词法分析¶]: https://docs.python.org/zh-cn/3/reference/lexical_analysis.html

### 逻辑行

Python 程序由一个 `解析器` 读取。
输入到解析器的是一个由 `词法分析器` 所生成的 `形符` (`tokens`)流，本章将描述词法分析器是如何将一个文件拆分为一个个形符的。

一个 Python 程序可分为许多 `逻辑行`。

`逻辑行`的结束是以 `NEWLINE` 形符表示的。
语句不能跨越逻辑行的边界，除非其语法允许包含 `NEWLINE` (例如复合语句可由多行子语句组成)。
一个逻辑行可由一个或多个 `物理行` 按照明确或隐含的 行拼接 规则构成。

`物理行`是以一个`行终止序列`结束的字符序列。
在源文件和字符串中，可以使用任何标准平台上的`行终止序列` - Unix 所用的 ASCII 字符 `LF` (换行), Windows 所用的 ASCII 字符序列 `CR LF` (回车加换行), 或者旧 Macintosh 所用的 ASCII 字符 `CR` (回车)。
所有这些形式均可使用，无论具体平台。输入的结束也会被作为最后一个物理行的隐含终止标志。

当嵌入 Python 时，源码字符串传入 Python API 应使用标准 C 的传统换行符 (即 `\n`，表示 ASCII 字符 `LF` 作为行终止标志)。

### 注释

一条注释以不包含在字符串字面值内的井号 (`#`) 开头，并在物理行的末尾结束。 一条注释标志着逻辑行的结束，除非存在隐含的行拼接规则。 注释在语法分析中会被忽略。

编码声明

如果一条注释位于 Python 脚本的第一或第二行，并且匹配正则表达式 `coding[=:]\s*([-\w.]+)`，这条注释会被作为编码声明来处理；

上述表达式的第一组指定了源码文件的编码。编码声明必须独占一行。
如果它是在第二行，则第一行也必须是注释。推荐的编码声明形式如下

```python
# -*- coding: <encoding-name> -*-
```

这也是 GNU Emacs 认可的形式，以及

```vim
# vim:fileencoding=<encoding-name>
```

这是 Bram Moolenaar 的 `VIM` 认可的形式。

如果没有编码声明，则默认编码为 UTF-8。此外，如果文件的首字节为 UTF-8 字节顺序标志 (`b'\xef\xbb\xbf'`)，文件编码也声明为 `UTF-8` (这是 Microsoft 的 notepad 等软件支持的形式)。

编码声明指定的编码名称必须是 Python 所认可的编码。所有词法分析将使用此编码，包括语义字符串、注释和标识符。

### 行拼接

显式的行拼接

两个或更多个物理行可使用反斜杠字符 (`\`) 拼接为一个逻辑行，规则如下: 当一个物理行以一个不在字符串或注释内的反斜杠结尾时，它将与下一行拼接构成一个单独的逻辑行，反斜杠及其后的换行符会被删除。例如:

```python
if 1900 < year < 2100 and 1 <= month <= 12 \
   and 1 <= day <= 31 and 0 <= hour < 24 \
   and 0 <= minute < 60 and 0 <= second < 60:   # Looks like a valid date
        return 1
```

+ 以反斜杠结束的行不能带有注释。
+ 反斜杠不能用来拼接注释。
+ 反斜杠不能用来拼接`tokens`，字符串除外 (即`literal string`以外的`tokens`不能用反斜杠分隔到两个物理行)。
+ 不允许有`literal string`以外的反斜杠存在于物理行的其他位置(出现在用来拼接的`\`的前面)。

***
隐式的行拼接

圆括号、方括号或花括号以内的表达式允许分成多个物理行，无需使用反斜杠。总之，括号以内可以断行。
例如:

```python
month_names = ['Januari', 'Februari', 'Maart',      # These are the
               'April',   'Mei',      'Juni',       # Dutch names
               'Juli',    'Augustus', 'September',  # for the months
               'Oktober', 'November', 'December']   # of the year
```

隐式的行拼接可以带有注释。后续行的缩进不影响程序结构。后续行也允许为空白行。
隐式拼接的行之间不会有 `NEWLINE` 形符。
隐式拼接的行也可以出现于`三引号`字符串中 (见下)；此情况下这些行不允许带有注释。

### 空白行

一个只包含`空格符`，`制表符`，`进纸符`或者`注释`的逻辑行会被忽略 (即不生成 `NEWLINE` 形符)。
在交互模式输入语句时，对空白行的处理可能会因读取-求值-打印循环的具体实现方式而存在差异。
在标准交互模式解释器中，一个完全空白的逻辑行 (即连空格或注释都没有) 将会结束一条多行复合语句。

### 缩进

一个逻辑行开头处的空白 (空格符和制表符) 被用来计算该行的缩进等级，以决定语句段落的组织结构。

制表符会被 (从左至右) 替换为一至八个空格，这样缩进的空格总数为八的倍数 (这是为了与 Unix 所用的规则一致)。
首个非空白字符之前的空格总数将确定该行的缩进层次。
一个缩进不可使用反斜杠进行多行拼接；首个反斜杠之前的空格将确定缩进层次。

在一个源文件中如果混合使用制表符和空格符缩进，并使得确定缩进层次需要依赖于制表符对应的空格数量设置，则被视为不合规则；
此情况将会引发 `TabError`。

跨平台兼容性注释: 由于非 UNIX 平台上文本编辑器本身的特性，在一个源文件中混合使用制表符和空格符是不明智的。
另外也要注意不同平台还可能会显式地限制最大缩进层级。

行首有时可能会有一个进纸符；它在上述缩进层级计算中会被忽略。
处于行首空格内其他位置的进纸符的效果未定义 (例如它可能导致空格计数重置为零)。

多个连续行各自的缩进层级将会被放入一个堆栈用来生成 `INDENT` 和 `DEDENT` 形符，具体说明如下(省略)

以下示例显示了各种缩进错误:

```python
 def perm(l):                       # error: first line indented
for i in range(len(l)):             # error: not indented
    s = l[:i] + l[i+1:]
        p = perm(l[:i] + l[i+1:])   # error: unexpected indent
        for x in p:
                r.append(l[i:i+1] + x)
            return r                # error: inconsistent dedent
```

(实际上，前三个错误会被解析器发现；只有最后一个错误是由词法分析器发现的 --- `return r `的缩进无法匹配弹出栈的缩进层级。)

### 形符之间的空白

除非是在逻辑行的开头或字符串内，空格符、制表符和进纸符等空白符都同样可以用来分隔形符。
如果两个形符彼此相连会被解析为一个不同的形符，则需要使用空白来分隔 (例如 `ab` 是一个形符，而 `a b` 是两个形符)。

### 其他形符

除了 `NEWLINE`, `INDENT` 和 `DEDENT`，还存在以下类别的形符: `标识符`, `关键字`, `字面值`, `运算符` 以及 `分隔符`。

空白字符 (之前讨论过的行终止符除外) 不属于形符，而是用来分隔形符。
如果存在二义性，将从左至右读取尽可能长的合法字符串组成一个形符。

### 标识符和关键字

标识符 (或者叫做 `名称`) 由以下词法定义进行描述。

Python 中的标识符语法是基于 Unicode 标准附件 `UAX-31`，并加入了下文所定义的细化与修改；更多细节还可参见 PEP 3131 。

在 ASCII 范围内 (`U+0001..U+007F`)，可用于标识符的字符与 Python 2.x 一致: 大写和小写字母 `A` 至 `Z`，下划线 `_` 以及数字 `0` 至 `9`，但不可以数字打头。

Python 3.0 引入了 ASCII 范围以外的额外字符 (见 PEP 3131)。这些字符的分类使用包含于 `unicodedata` 模块中的 Unicode 字符数据库版本。

标识符的长度没有限制。对大小写敏感。

所有标识符在解析时会被转换为规范形式 NFKC；标识符的比较都是基于 NFKC。

Unicode 4.1 中所有可用的标识符字符列表可参见以下[非正式 HTML 文件][]

[非正式 HTML 文件]:  https://www.unicode.org/Public/13.0.0/ucd/DerivedCoreProperties.txt

### 关键字

以下标识符被作为语言的保留字或称 关键字，不可被用作普通标识符。关键字的拼写必须与这里列出的完全一致。

+ `False`   `await` `else`  `import`    `pass`
+ `None`    `break` `except`    `in`    `raise`
+ `True`    `class` `finally`   `is`    `return`
+ `and` `continue`  `for`   `lambda`    `try`
+ `as`  `def`   `from`  `nonlocal`  `while`
+ `assert`  `del`   `global`    `not`   `with`
+ `async`   `elif`  `if`    `or`    `yield`

### 保留的标识符类

某些标识符类 (除了关键字) 具有特殊的含义。这些标识符类的命名模式是以下划线字符打头和结尾:

+ `_*`

不会被 `from module import *` 导入。特殊标识符 `_` 在交互式解释器中被用来存放最近一次求值结果；
它保存在 `builtins` 模块中。当不处于交互模式时，`_` 无特殊含义也没有预定义。参见 `import` 语句。

注解: `_` 作为名称常用于连接国际化文本；请参看 gettext 模块文档了解有关此约定的详情。

+ `__*__`

系统定义的名称，在非正式场合下被叫做 "dunder" 名称。 这些名称是由解释器及其实现（包括标准库）定义的。 现有系统定义名称相关的讨论请参见 特殊方法名称 等章节。 未来的 Python 版本中还将定义更多此类名称。 任何情况下 任何 不遵循文档所显式指明的` __*__ `名称使用方式都可能导致无警告的错误。

+ `__*`

类的私有名称。这种名称在类定义中使用时，会以一种混合形式重写以避免在基类及派生类的 "私有" 属性之间出现名称冲突。
参见 标识符（名称）。

### 字面值(literal:原义的)

字面值用于表示一些内置类型的常量。

***
字符串和字节串字面值

自然语言描述: 两种字面值都可以用成对单引号 (`) 或双引号 (`) 来标示首尾。
它们也可以用成对的`连续三个单引号或双引号`来标示首尾 (这通常被称为 `三引号字符串`)。
反斜杠 (`\`) 字符被用来对特殊含义的字符进行转义，例如换行，反斜杠本身或是引号等字符。

`字节串`字面值总是带有前缀 `'b'` 或 `'B'`；它们生成 `bytes` 类型而非 `str` 类型的实例。
它们只能包含 `ASCII` 字符；字节对应数值在`128`及以上必须以转义形式来表示。

字符串和字节串字面值都可以带有前缀 `'r'` 或 `'R'`；
这种字符串被称为 原始字符串 其中的反斜杠会被当作其本身的字面字符来处理。
因此在原始字符串字面值中，`'\U'` 和 `'\u'` 转义形式不会被特殊对待。
由于 Python 2.x 的原始统一码字面值的特性与 Python 3.x 不一致，`'ur'` 语法已不再被支持。

包含 `'f'` 或 `'F'` 前缀的字符串字面值称为 格式化字符串字面值；参见 格式化字符串字面值。
`'f'` 可与 `'r'` 连用，但不能与 `'b'` 或 `'u'` 连用，因此存在原始格式化字符串，但不存在格式化字节串字面值。

在三引号字面值中，允许存在未经转义的换行和引号 (并原样保留)，要输入三引号本身，需要转义。

除非带有 `'r'` 或 `'R'` 前缀，字符串和字节串字面值中的转义序列会基于类似标准 `C` 中的转义规则来解读。
可用的转义序列如下:

2.4.2. 字符串字面值拼接

多个相邻的字符串或字节串字面值 (以空白符分隔)，所用的引号可以彼此不同，其含义等同于全部拼接为一体。因此， "hello" 'world' 等同于 "helloworld"。此特性可以减少反斜杠的使用，以方便地将很长的字符串分成多个物理行，甚至每部分字符串还可分别加注释，例如:

re.compile("[A-Za-z_]"       # letter or underscore
           "[A-Za-z0-9_]*"   # letter, digit or underscore
          )

注意此特性是在句法层面定义的，但是在编译时实现。在运行时拼接字符串表达式必须使用 '+' 运算符。还要注意字面值拼接时每个部分可以使用不同的引号风格 (甚至混合使用原始字符串和三引号字符串)，格式化字符串字面值也可与普通字符串字面值拼接。

### 格式化字符串字面值

3.6 新版功能.

格式化字符串字面值 或称 f-string 是带有 `'f'` 或 'F' 前缀的字符串字面值。这种字符串可包含替换字段，即以 {} 标示的表达式。而其他字符串字面值总是一个常量，格式化字符串字面值实际上是会在运行时被求值的表达式。

转义序列会像在普通字符串字面值中一样被解码 (除非字面值还被标示为原始字符串)。解码之后，字符串内容所用的语法如下:

f_string          ::=  (literal_char | "{{" | "}}" | replacement_field)*
replacement_field ::=  "{" f_expression ["="] ["!" conversion] [":" format_spec] "}"
f_expression      ::=  (conditional_expression | "*" or_expr)
                         ("," conditional_expression | "," "*" or_expr)* [","]
                       | yield_expression
conversion        ::=  "s" | "r" | "a"
format_spec       ::=  (literal_char | NULL | replacement_field)*
literal_char      ::=  <any code point except "{", "}" or NULL>

字符串在花括号以外的部分按其字面值处理，除了双重花括号 '{{' 或 '}}' 会被替换为相应的单个花括号。 单个左花括号 '{' 标示一个替换字段，它以一个 Python 打头。 要同时显示表达式文本及其求值后的结果值（这在调试时很有用），可以在表达式后加一个等于号 '='。 之后可能带有一个以叹号 '!' 标示的转换字段。 之后还可能带有一个以冒号 ':' 标示的格式说明符。 替换字段以一个右花括号 '}' 作为结束。

格式化字符串字面值中的表达式会被当作包含在圆括号中的普通 Python 表达式一样处理，但有少数例外。 空表达式不被允许，lambda 和赋值表达式 := 必须显式地加上圆括号。 替换表达式可以包含换行（例如在三重引号字符串中），但是不能包含注释。 每个表达式会在格式化字符串字面值所包含的位置按照从左至右的顺序被求值。

在 3.7 版更改: 在 Python 3.7 之前， await 表达式包含 async for 子句的推导式不允许在格式化字符串字面值表达式中使用，这是因为具体实现存在一个问题。

在提供了等于号 '=' 的时候，输出将包含表达式文本，'=' 以及求值结果。 左花括号 '{' 之后包含在表达式中及 '=' 后的空格将在输出时被保留。 默认情况下，'=' 会导致表达式的 repr() 被使用，除非专门指定了格式。 当指定了格式时默认会使用表达式的 str()，除非声明了转换字段 '!r'。

3.8 新版功能: 等于号 '=' 在 Python 3.8 中加入。

如果指定了转换符，表达式的求值结果会先转换再格式化。转换符 '!s' 即对结果调用 str()，'!r' 为调用 repr()，而 '!a' 为调用 ascii()。

在此之后结果会使用 format() 协议进行格式化。格式说明符会被传入表达式或转换结果的 __format__() 方法。如果省略格式说明符则会传入一个空字符串。然后格式化结果会包含在整个字符串最终的值当中。

顶层的格式说明符可以包含有嵌套的替换字段。这些嵌套字段也可以包含有自己的转换字段和 格式说明符，但不可再包含更深层嵌套的替换字段。这里的 格式说明符微型语言 与字符串 .format() 方法所使用的相同。

格式化字符串字面值可以拼接，但是一个替换字段不能拆分到多个字面值。

一些格式化字符串字面值的示例:
>>>

>>> name = "Fred"
>>> f"He said his name is {name!r}."
"He said his name is 'Fred'."
>>> f"He said his name is {repr(name)}."  # repr() is equivalent to !r
"He said his name is 'Fred'."
>>> width = 10
>>> precision = 4
>>> value = decimal.Decimal("12.34567")
>>> f"result: {value:{width}.{precision}}"  # nested fields
'result:      12.35'
>>> today = datetime(year=2017, month=1, day=27)
>>> f"{today:%B %d, %Y}"  # using date format specifier
'January 27, 2017'
>>> f"{today=:%B %d, %Y}" # using date format specifier and debugging
'today=January 27, 2017'
>>> number = 1024
>>> f"{number:#0x}"  # using integer format specifier
'0x400'
>>> foo = "bar"
>>> f"{ foo = }" # preserves whitespace
" foo = 'bar'"
>>> line = "The mill's closed"
>>> f"{line = }"
'line = "The mill\'s closed"'
>>> f"{line = :20}"
"line = The mill's closed   "
>>> f"{line = !r:20}"
'line = "The mill\'s closed" '

与正常字符串字面值采用相同语法导致的一个结果就是替换字段中的字符不能与外部的格式化字符串字面值所用的引号相冲突:

f"abc {a["x"]} def"    # error: outer string literal ended prematurely
f"abc {a['x']} def"    # workaround: use different quoting

格式表达式中不允许有反斜杠，这会引发错误:

f"newline: {ord('\n')}"  # raises SyntaxError

想包含需要用反斜杠转义的值，可以创建一个临时变量。
>>>

newline = ord('\n')

f"newline: {newline}"
'newline: 10'

格式化字符串字面值不可用作文档字符串，即便其中没有包含表达式。
>>>

>>> def foo():
...     f"Not a docstring"
...
>>> foo.__doc__ is None
True

另请参见 PEP 498 了解加入格式化字符串字面值的提议，以及使用了相关的格式字符串机制的 str.format()。

### 数字字面值

数字字面值有三种类型: 整型数、浮点数和虚数。没有专门的复数字面值 (复数可由一个实数加一个虚数合成)。

注意数字字面值并不包含正负号；`-1` 这样的负数实际上是由单目运算符 `'-'` 和字面值 `1` 合成的。

### 整型数字面值

整型数字面值由以下词法定义进行描述:

```python
integer      ::=  decinteger | bininteger | octinteger | hexinteger
decinteger   ::=  nonzerodigit (["_"] digit)* | "0"+ (["_"] "0")*
bininteger   ::=  "0" ("b" | "B") (["_"] bindigit)+
octinteger   ::=  "0" ("o" | "O") (["_"] octdigit)+
hexinteger   ::=  "0" ("x" | "X") (["_"] hexdigit)+
nonzerodigit ::=  "1"..."9"
digit        ::=  "0"..."9"
bindigit     ::=  "0" | "1"
octdigit     ::=  "0"..."7"
hexdigit     ::=  digit | "a"..."f" | "A"..."F"
```

整型数字面值的长度没有限制，能一直大到占满可用内存。

在确定数字大小时字面值中的下划线会被忽略。它们可用来将数码分组以提高可读性。一个下划线可放在数码之间，也可放在基数说明符例如 0x 之后。

注意非零的十进制数开头不允许有额外的零。这是为了避免与 Python 在版本 3.0 之前所使用的 C 风格八进制字面值相混淆。

一些整型数字面值的示例如下:

7     2147483647                        0o177    0b100110111
3     79228162514264337593543950336     0o377    0xdeadbeef
      100_000_000_000                   0b_1110_0101

在 3.6 版更改: 允许在字面值中使用下划线进行分组。

2.4.6. 浮点数字面值

浮点数字面值由以下词法定义进行描述:

floatnumber   ::=  pointfloat | exponentfloat
pointfloat    ::=  [digitpart] fraction | digitpart "."
exponentfloat ::=  (digitpart | pointfloat) exponent
digitpart     ::=  digit (["_"] digit)*
fraction      ::=  "." digitpart
exponent      ::=  ("e" | "E") ["+" | "-"] digitpart

注意整型数部分和指数部分在解析时总是以 10 为基数。例如，077e010 是合法的，且表示的数值与 77e10 相同。浮点数字面值允许的范围依赖于具体实现。对于整型数字面值，支持以下划线进行分组。

一些浮点数字面值的示例如下:

3.14    10.    .001    1e100    3.14e-10    0e0    3.14_15_93

在 3.6 版更改: 允许在字面值中使用下划线进行分组。

2.4.7. 虚数字面值

虚数字面值由以下词法定义进行描述:

imagnumber ::=  (floatnumber | digitpart) ("j" | "J")

一个虚数字面值将生成一个实部为 0.0 的复数。复数是以一对浮点数来表示的，它们的取值范围相同。要创建一个实部不为零的复数，就加上一个浮点数，例如 (3+4j)。一些虚数字面值的示例如下:

3.14j   10.j    10j     .001j   1e100j   3.14e-10j   3.14_15_93j

### 运算符

以下形符属于运算符:

```python
+       -       *       **      /       //      %      @
<<      >>      &       |       ^       ~       :=
<       >       <=      >=      ==      !=
```

### 分隔符

以下形符在语法中归类为分隔符:

```python
(       )       [       ]       {       }
,       :       .       ;       @       =       ->
+=      -=      *=      /=      //=     %=      @=
&=      |=      ^=      >>=     <<=     **=
```

句点也可出现于浮点数和虚数字面值中。连续三个句点有表示一个省略符的特殊含义。
以上列表的后半部分为增强赋值操作符，在词法中作为分隔符，但也起到运算作用。

以下可打印 ASCII 字符作为其他形符的组成部分时**具有**特殊含义，或是对词法分析器有重要意义:

```python
'       "       #       \
```

以下可打印 ASCII 字符**不在** Python 词法中使用。如果出现于字符串字面值和注释之外将无条件地引发错误:

```python
$       ?       `
```
