# sed

[sed教程][]

[sed教程]: https://www.cnblogs.com/along21/p/10366886.html

[sed命令][]

[sed命令]: https://man.linuxde.net/sed

`sed` 是一种流编辑器，它一次处理一行内容。
处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（patternspace ），接着用 `sed` 命令处理缓冲区中的内容，
处理完成后，把缓冲区的内容送往屏幕。

然后读入下行，执行下一个循环。如果没有使诸如 `D` 的特殊命令，那么会在两个循环之间清空模式空间，但不会清空保留空间。
这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出或`-i`。

功能：主要用来自动编辑一个或多个文件, 简化对文件的反复操作

## 命令格式

+ `sed [options] '[地址定界] command' file(s)`
+ `sed [options] -f scriptfile file(s)`

## 常用选项

`-h`或`--help`：显示帮助；
`-V`或`--version`：显示版本信息

`-e <script>`或`--expression=<script>`：以`script`来处理输入的文本文件；多点编辑，对每行处理时，可以有多个Script
`-f<src_script>`或`--file=<src_script>`：以选项中指定的`script`文件来处理输入的文本文件；
`-n`或`--quiet`或`--silent`：不输出模式空间内容到屏幕，即不自动打印，只打印匹配到的行
`-r`: 支持扩展的正则表达式
`-i`：直接将处理的结果写入文件
`-i.bak`：在将处理的结果写入文件之前备份一份

## 地址定界

+ 不给地址：对全文进行处理

单地址：

+ `#`: 指定的行`#`
+ ` /pattern/` ：被此处模式所能够匹配到的每一行    

地址范围：

+ `#1,#2` `#1`到`#2`行
+ `#1,+#2` `#1`到`#1+#2`行
+ `/pat1/,/pat2/` 模式`pat1`到模式`pat2`
+ `#,/pat1/` 行`#`到模式`pat1`

步进

+ `sed -n '1~2p'  只打印奇数行`（`1~2` 从第1行，一次加2行）
+ `sed -n '2~2p'  只打印偶数行`

## 编辑命令command

+ `d`：删除模式空间匹配的行，并立即启用下一轮循环
+ `p`：打印当前模式空间内容，追加到默认输出之后
+ `a`：在指定行后面追加文本，用`\n`进行多行追加
+ `i`：在指定行前面插入文本，用`\n`进行多行追加
+ `c`：替换指定行为单行或多行文本，用`\n`进行多行追加
+ `w`：保存模式匹配的行至指定文件
+ `r`：读取指定文件的文本至模式空间中匹配到的行后
+ `=`：为模式空间中的行打印行号
+ `!`：模式空间中匹配行取反处理
+ `s///`：查找替换，支持使用其它分隔符，如：`s@@@`，`s###`；加`g`表示行内全局替换(替换全部匹配)；
         
在替换时，可以加以下命令，实现大小写转换

+ `\l`：把下个字符转换成小写。
+ `\L`：把`replacement`字母转换成小写，直到`\U`或`\E`出现。
+ `\u`：把下个字符转换成大写。
+ `\U`：把`replacement`字母转换成大写，直到`\L`或`\E`出现。
+ `\E`：停止以`\L`或`\U`开始的大小写转换

## 常用选项options演示

+ `cat demo`

```bash
aaa
bbbb
AABBCCDD
```

+ `sed "/aaa/p" demo`  : 匹配到的行会打印一遍，不匹配的行也会打印
+ `sed -n "/aaa/p" demo`  : `-n`不显示没匹配的行
+ `sed -e "s/a/A/" -e "s/b/B/" demo`  : `-e`多点编辑

```bash
#-f使用脚本处理
cat sedscript.txt
s/A/a/g
sed -f sedscript.txt demo  
```

```bash
#-i直接对文件进行处理
sed -i.bak "s/a/A/g" demo  
cat demo
cat demo.bak
```

### 地址界定演示

+ `sed -n "p" demo`  ：不指定行，打印全文
+ `sed "2s/b/B/g" demo`  ：替换第2行的`b->B`
+ `sed -n "/aaa/p" demo` ：只打印匹配的行
+ `sed -n "1,2p" demo ` : 打印1-2行
+ `sed -n "/aaa/,/DD/p" demo` : 打印`/aaa/`和`/DD/`之间的行
+ `sed -n "2,/DD/p" demo` : 打印第`2`行和`/DD/`之间的行
+ `sed "1~2s/[aA]/E/g" demo` : 将奇数行的`a`或`A`全部替换为`E`

### 编辑命令command演示

`cat demo`

```bash
aaa
bbbb
AABBCCDD
```

+ `sed "2d" demo`  : 删除第`2`行
+ `sed -n "2p" demo`  : 打印第`2`行
+ `sed "2a123" demo`  : 在第`2`行后加`123`
+ `sed "1i123" demo`  : 在第`1`行前加`123`
+ `sed "3c123\n456" demo`  : 替换第`3`行内容
+ `sed -n "3w./demo3" demo`  : 保存第`3`行的内容到`demo3`文件中

```bash
# 新建一个demo3
echo 12345678 > demo3
cat -A demo3
```

+ `sed "1r./demo3" demo`  : 读取`demo3`的内容到第`1`行后
+ `sed -n "=" demo`  : 只打印匹配行的行号
+ `sed -n '2!p' demo`  : 打印除了第`2`行的内容
+ `sed 's@[a-z]@\u&@g' demo`  : 将全文的小写字母替换为大写字母

### sed高级编辑命令

***
格式

+ `h`：把模式空间中的内容覆盖至保持空间中
+ `H`：把模式空间中的内容追加至保持空间中
+ `g`：从保持空间取出数据覆盖至模式空间
+ `G`：从保持空间取出内容追加至模式空间
+ `x`：把模式空间中的内容与保持空间中的内容进行互换
+ `n`：读取匹配到的行的下一行覆盖至模式空间，即把唱针往前移动一行,移动之前会默认打印现在的内容,用`-n`抑制.
+ `N`：读取匹配到的行的下一行追加至模式空间
+ `d`：删除模式空间中的行
+ `D`：删除当前模式空间开端至`\n`的内容（不再定向到标准输出,也就是第一行），放弃之后的命令，但是对剩余模式空间重新执行`sed`
+ `!` 表示后面的命令对所有没有被选定的行发生作用。

### 案例

***
打印99乘法表

```bash
seq 9 | sed 'H;g' | awk -v RS='' '{
    for(i=1;i<=NF;i++)
    {# 如果不到这一行
        printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")
    }
    }'
```

RS: Records Separator，记录分隔符
NR: Number of Records，记录的序号

***
倒序输出文本

```bash
cat num.txt
One
Two
Three
sed '1!G;h;$!d' num.txt
Three
Two
One
```

## 总结模式空间与保持空间关系

模式空间`g`,`G`;`n`,`N`
保持空间`h`,`H`

保持空间是模式空间一个临时存放数据的缓冲区，协助模式空间进行数据处理

### 演示

`n`: 用下一个输入覆盖当前模式空间，相当于启动下一个循环，会先打印覆盖之前模式空间的内容
`N`: 用下一个输入追加当前模式空间，不会打印当前模式空间的内容

***
显示偶数行
`seq 9 |sed -n 'n;p'`

***
显示奇数行
`seq 9 |sed 'n;d'`

***
倒序显示
`seq 9 |sed  '1!G;h;$!d'`

***
显示最后一行
`seq 9| sed 'N;D'`

***
每行之间加空行
`seq 9 | sed 'G'`

***
把每行内容替换成空行
`seq 9 | sed "g"`
 
 ***
确保每一行下面都有一个空行
`seq 9 | sed '/^$/d;G'`

## 命令

+ `h` 拷贝模板块的内容到内存中的缓冲区。
+ `H` 追加模板块的内容到内存中的缓冲区。
+ `g` 获得内存缓冲区的内容，并替代当前模板块中的文本。
+ `G` 获得内存缓冲区的内容，并追加到当前模板块文本的后面。
+ `l` 列表不能打印字符的清单。
+ `n` 读取下一个输入行，用下一个命令处理新的行而不是用第一个命令。
+ `N` 追加下一个输入行到模板块后面并在二者间嵌入一个新行，改变当前行号码。
+ `P` (大写) 打印模板块的第一行。
+ `q` 退出`Sed`。
+ `b lable` 分支到脚本中带有标记的地方，如果分支不存在则分支到脚本的末尾。
+ `r file` 从`file`中读行。
+ `t label` `if`分支，从最后一行开始，条件一旦满足或者`T`，`t`命令，将导致分支到带有标号的命令处，或者到脚本的末尾。
+ `T label` 错误分支，从最后一行开始，一旦发生错误或者`T`，`t`命令，将导致分支到带有标号的命令处，或者到脚本的末尾。
+ `w file` 写并追加模板块到`file`末尾。
+ `W file` 写并追加模板块的第一行到`file`末尾。

+ `=` 打印当前行号码。
+ `#` 把注释扩展到下一个换行符以前。

### 替换标记

+ `g` 表示行内全面替换。
+ `p` 表示打印行。
+ `w` 表示把行写入一个文件。
+ `x` 表示互换模板块中的文本和缓冲区中的文本。
+ `y` 表示把一个字符翻译为另外的字符（但是不用于正则表达式）
+ `\1` 子串匹配标记
+ `&` 已匹配字符串标记

### 元字符集

+ `^` 匹配行开始，如：`/^sed/`匹配所有以`sed`开头的行。
+ `$` 匹配行结束，如：`/sed$/`匹配所有以`sed`结尾的行。
+ `.` 匹配一个非换行符的任意字符，如：`/s.d/`匹配`s`后接一个任意字符，最后是`d`。
+ `*` 匹配`0`个或多个字符，如：`/*sed/`匹配所有模板是一个或多个空格后紧跟`sed`的行。
+ `[]` 匹配一个指定范围内的字符，如`/[ss]ed/`匹配sed和Sed。
+ `[^]` 匹配一个不在指定范围内的字符，如：`/[^A-RT-Z]ed/`匹配不包含`A-R`和`T-Z`的一个字母开头，紧跟`ed`的行。
+ `\(..\)` 匹配子串，保存匹配的字符，如`s/\(love\)able/\1rs`，loveable被替换成lovers。
+ `&` 保存搜索字符用来替换其他字符，如`s/love/**&**/`，love这成`**love**`。
+ `\<` 匹配单词的开始，如:`/\<love/`匹配包含以love开头的单词的行。
+ `\>` 匹配单词的结束，如`/love\>/`匹配包含以love结尾的单词的行。
+ `x\{m\}` 重复字符`x`，`m`次，如：`/0\{5\}/`匹配包含5个0的行。
+ `x\{m,\}` 重复字符`x`，至少`m`次，如：`/0\{5,\}/`匹配至少有5个0的行。
+ `x\{m,n\}` 重复字符`x`，至少`m`次，不多于n次，如：`/0\{5,10\}/`匹配5~10个0的行。

#### 替换操作：s命令

替换文本中的字符串：

```bash
sed 's/book/books/' file
```

`-n`选项和`p`命令一起使用表示只打印那些发生替换的行：

```bash
sed -n 's/test/TEST/p' file
```

直接编辑文件选项`-i`，会匹配`file`文件中每一行的第一个`book`替换为`book`s：

```bash
sed -i 's/book/books/g' file
```

#### 全面替换标记g

使用后缀 `/g` 标记会替换每一行中的所有匹配：

```bash
sed 's/book/books/g' file
```

 当需要从第N处匹配开始替换时，可以使用 /Ng：

echo sksksksksksk | sed 's/sk/SK/2g'
skSKSKSKSKSK

echo sksksksksksk | sed 's/sk/SK/3g'
skskSKSKSKSK

echo sksksksksksk | sed 's/sk/SK/4g'
skskskSKSKSK

#### 定界符

以上命令中字符 / 在sed中作为定界符使用，也可以使用任意的定界符：

sed 's:test:TEXT:g'
sed 's|test|TEXT|g'

定界符出现在样式内部时，需要进行转义：

sed 's/\/bin/\/usr\/local\/bin/g'

#### 删除操作：d命令

删除空白行：

sed '/^$/d' file

删除文件的第2行：

sed '2d' file

删除文件的第2行到末尾所有行：

sed '2,$d' file

删除文件最后一行：

sed '$d' file

删除文件中所有开头是test的行：

sed '/^test/'d file

#### 已匹配字符串标记&

正则表达式 \w\+ 匹配每一个单词，使用 [&] 替换它，& 对应于之前所匹配到的单词：

echo this is a test line | sed 's/\w\+/[&]/g'
[this] [is] [a] [test] [line]

所有以192.168.0.1开头的行都会被替换成它自已加localhost：

sed 's/^192.168.0.1/&localhost/' file
192.168.0.1localhost

#### 子串匹配标记\1

匹配给定样式的其中一部分：

echo this is digit 7 in a number | sed 's/digit \([0-9]\)/\1/'
this is 7 in a number

命令中 digit 7，被替换成了 7。样式匹配到的子串是 7，\(..\) 用于匹配子串，对于匹配到的第一个子串就标记为 \1，依此类推匹配到的第二个结果就是 \2，例如：

echo aaa BBB | sed 's/\([a-z]\+\) \([A-Z]\+\)/\2 \1/'
BBB aaa

love被标记为1，所有loveable会被替换成lovers，并打印出来：

sed -n 's/\(love\)able/\1rs/p' file

#### 组合多个表达式

`sed '表达式' | sed '表达式'`

等价于：

`sed '表达式; 表达式'`

#### 引用

sed表达式可以使用单引号来引用，但是如果表达式内部包含变量字符串，就需要使用双引号。

test=hello
echo hello WORLD | sed "s/$test/HELLO"
HELLO WORLD

#### 选定行的范围：,（逗号）

所有在模板test和check所确定的范围内的行都被打印：

sed -n '/test/,/check/p' file

打印从第5行开始到第一个包含以test开始的行之间的所有行：

sed -n '5,/^test/p' file

对于模板test和west之间的行，每行的末尾用字符串aaa bbb替换：

sed '/test/,/west/s/$/aaa bbb/' file

#### 多点编辑：e命令

`-e`选项允许在同一行里执行多条命令：

sed -e '1,5d' -e 's/test/check/' file

上面sed表达式的第一条命令删除1至5行，第二条命令用check替换test。命令的执行顺序对结果有影响。如果两个命令都是替换命令，那么第一个替换命令将影响第二个替换命令的结果。

和 -e 等价的命令是 --expression：

sed --expression='s/test/check/' --expression='/love/d' file

#### 从文件读入：r命令

file里的内容被读进来，显示在与test匹配的行后面，如果匹配多行，则file的内容将显示在所有匹配行的下面：

sed '/test/r file' filename

#### 写入文件：w命令

在example中所有包含test的行都被写入file里：

sed -n '/test/w file' example

#### 追加（行下）：a\命令

将 this is a test line 追加到 以test 开头的行后面：

sed '/^test/a\this is a test line' file

在 test.conf 文件第2行之后插入 this is a test line：

sed -i '2a\this is a test line' test.conf

#### 插入（行上）：i\命令

将 this is a test line 追加到以test开头的行前面：

sed '/^test/i\this is a test line' file

在test.conf文件第5行之前插入this is a test line：

sed -i '5i\this is a test line' test.conf

#### 下一个：n命令

如果test被匹配，则移动到匹配行的下一行，替换这一行的aa，变为bb，并打印该行，然后继续：

sed '/test/{ n; s/aa/bb/; }' file

#### 变形：y命令

把1~10行内所有abcde转变为大写，注意，正则表达式元字符不能使用这个命令：

sed '1,10y/abcde/ABCDE/' file

#### 退出：q命令

打印完第10行后，退出sed

sed '10q' file

#### 保持和获取：h命令和G命令

在sed处理文件的时候，每一行都被保存在一个叫模式空间的临时缓冲区中，除非行被删除或者输出被取消，否则所有被处理的行都将 打印在屏幕上。接着模式空间被清空，并存入新的一行等待处理。

sed -e '/test/h' -e '$G' file

在这个例子里，匹配test的行被找到后，将存入模式空间，h命令将其复制并存入一个称为保持缓存区的特殊缓冲区内。第二条语句的意思是，当到达最后一行后，G命令取出保持缓冲区的行，然后把它放回模式空间中，且追加到现在已经存在于模式空间中的行的末尾。在这个例子中就是追加到最后一行。简单来说，任何包含test的行都被复制并追加到该文件的末尾。

#### 保持和互换：h命令和x命令

互换模式空间和保持缓冲区的内容。也就是把包含test与check的行互换：

sed -e '/test/h' -e '/check/x' file

#### 脚本scriptfile

sed脚本是一个sed的命令清单，启动Sed时以-f选项引导脚本文件名。Sed对于脚本中输入的命令非常挑剔，在命令的末尾不能有任何空白或文本，如果在一行中有多个命令，要用分号分隔。以#开头的行为注释行，且不能跨行。

sed [options] -f scriptfile file(s)

#### 打印奇数行或偶数行

方法1：

sed -n 'p;n' test.txt  #奇数行
sed -n 'n;p' test.txt  #偶数行

方法2：

sed -n '1~2p' test.txt  #奇数行
sed -n '2~2p' test.txt  #偶数行

#### 打印匹配字符串的下一行

```bash
grep -A 1 SCC URFILE
sed -n '/SCC/{n;p}' URFILE
awk '/SCC/{getline; print}' URFILE
```

### 用法实例

### ip地址

先观察原始信息，利用`ip monitor address dev enp0s31f6` 监视 IP变化

ip monitor address dev enp0s31f6

```bash
dev_name="enp0s31f6" #设备名称
dev_addr=$(ip monitor address dev $dev_name)  #监视ip变化
echo $dev_addr |\
grep -Po "${dev_name}[ ]+inet[ ]+[ \w\d\./]+brd" | `#用grep 提取出address一行`\
sed "s/${dev_name} \{1,\}inet//g" | sed "s/brd//g"
```

```bash
dev_name="enp0s31f6" #设备名称
ip monitor address dev $dev_name | while read line
do
echo $line |\
grep -Po "${dev_name}[ ]+inet[ ]+[ \w\d\./]+brd" | `#用grep 提取出address一行`\
sed "s/${dev_name} \{1,\}inet//g" | sed "s/brd//g"
done
```
