# JSON 教程

``JSON``: ``JavaScript` Object Notation`(`JavaScript` 对象表示法)

``JSON`` 是存储和交换文本信息的语法。类似 `XML` 。

``JSON`` 比 `XML` 更小、更快，更易解析。

## 什么是 JSON

+ `JSON` 指的是 `JavaScript` 对象表示法（`JavaScript Object Notation`）
+ `JSON` 是轻量级的文本数据交换格式
+ `JSON` 独立于语言：`JSON` 使用 `Javascript`语法来描述数据对象，但是 `JSON` 仍然独立于语言和平台`JSON` 解析器和 `JSON` 库支持许多不同的编程语言。 目前非常多的动态（`PHP，JSP，.NET`）编程语言支持`JSON`。
+ `JSON` 具有自我描述性，更易理解

## JSON - 转换为  JavaScript 对象

`JSON` 文本格式在语法上与创建 `JavaScript` 对象的代码相同。

由于这种相似性，无需解析器，`JavaScript` 程序能够使用内建的 `eval() `函数，用 `JSON` 数据来生成原生的 `JavaScript` 对象

## 与 XML 相同之处

+ `JSON` 是纯文本
+ `JSON` 具有"自我描述性"（人类可读）
+ `JSON` 具有层级结构（值中存在值）
+ `JSON` 可通过 `JavaScript` 进行解析
+ `JSON` 数据可使用 `AJAX` 进行传输

## 与 XML 不同之处

+ 没有结束标签
+ 更短
+ 读写的速度更快
+ 能够使用内建的 `JavaScript eval()` 方法进行解析
+ 使用数组
+ 不使用保留字

## 为什么使用JSON

对于 `AJAX` `应用程序来说，JSON` 比 `XML` 更快更易使用：

使用 `XML`

+ 读取 `XML` 文档
+ 使用 `XML DOM` 来循环遍历文档
+ 读取值并存储在变量中

使用 `JSON`

+ 读取 `JSON` 字符串
+ 用 `eval()` 处理 `JSON` 字符串

## JSON 语法

`JSON` 语法是 `JavaScript` 语法的子集。

### JSON 语法规则

`JSON` 语法是 `JavaScript` 对象表示语法的子集。

+ 数据在名称/值对中
+ 数据由逗号分隔
+ 大括号保存对象
+ 中括号保存数组

### JSON 名称/值对

`JSON` 数据的书写格式是：名称/值对。

名称/值对包括字段名称（在双引号中），后面写一个冒号，然后是值：

```json
"name" : "菜鸟教程"
```

这很容易理解，等价于这条 `JavaScript` 语句：

```json
name = "菜鸟教程"
```

### JSON 值

`JSON` 值可以是：

+ 数字（整数或浮点数）
+ 字符串（在双引号中）
+ 逻辑值（ `true` 或 `false` ）
+ 数组（在中括号中）
+ 对象（在大括号中）
+ `null`

### JSON 数字

`JSON` 数字可以是整型或者浮点型：
`{ "age":30 }`

### JSON 对象

对象在大括号（`{}`）中书写：

JSON对象可以包含多个名称/值对

```json
{ "name":"菜鸟教程" , "url":"www.runoob.com" }
```

这一点也容易理解，与这条 `JavaScript` 语句等价：

```json
name = "菜鸟教程"
url = "www.runoob.com"
```

### JSON 数组

JSON 数组在中括号中书写：

数组可包含多个对象：

```json
{
"sites": [
{ "name":"菜鸟教程" , "url":"www.runoob.com" }, 
{ "name":"google" , "url":"www.google.com" }, 
{ "name":"微博" , "url":"www.weibo.com" }
]
}
```

在上面的例子中，对象 "`sites`" 是包含三个对象的数组。每个对象代表一条关于某个网站（ `name` `、url` ）的记录。

### JSON 布尔值

`JSjsonON` 布尔值可以是 `true` 或者 `false`：

```json
{ "flag":true }
```

### JSON null

`JSON` 可以设置 `null` 值：

```json
{ "runoob":null }
```


`JSON` 使用 `JavaScript` 语法

因为 `JSON` 使用 `JavaScript` 语法，所以无需额外的软件就能处理 `JavaScript` 中的 `JSON`。

通过 `JavaScript`，您可以创建一个对象数组，并像这样进行赋值：
实例

```json
var sites = [
    { "name":"runoob" , "url":"www.runoob.com" },
    { "name":"google" , "url":"www.google.com" },
    { "name":"微博" , "url":"www.weibo.com" }
];
```

可以像这样访问 JavaScript 对象数组中的第一项（索引从 0 开始）：
sites[0].name;

返回的内容是：
runoob

可以像这样修改数据：
sites[0].name="菜鸟教程";
