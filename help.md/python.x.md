# python.x

## Python运行外部程序

[Python运行外部程序的几种方法][]

[Python运行外部程序的几种方法]: https://blog.csdn.net/xiligey1/article/details/80267983 

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

1. `shutil.copy('来源文件','目标地址')` #返回值是复制之后的路径
2. `shutil.copy2()` #`shutil.copy()`差不多，复制后的结果保留了原来的所有信息（包括状态信息）
3. `shutil.copyfile(来源文件,目标文件)`  # 将一个文件的内容拷贝的另外一个文件当中,返回值是复制之后的路径
4. `shutil.copyfileobj(open(来源文件,'r'),open('目标文件','w'))` #将一个文件的内容拷贝的另外一个文件当中
5. `shutil.copytree(来源目录,目标目录)` #复制整个文件目录 (无论文件夹是否为空，均可复制，而且会复制文件夹中的所有内容)
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
