# jupyter

[The Jupyter Notebook][]

[The Jupyter Notebook]: https://jupyter-notebook.readthedocs.io/en/latest/

## 运行笔记本

安装`Jupyter Notebook`会默认安装`IPython` kernel。 可以使用 Python 进行工作。

在计算机上安装`Jupyter Notebook`后，即可运行笔记本服务器。 
您可以通过运行以下命令从命令行（在`Mac / Linux`上使用`Terminal`，在Windows上使用`Command Prompt`）启动笔记本服务器。

```
jupyter notebook
```

终端中将打印有关笔记本服务器的一些信息，包括Web应用程序的`URL`（默认情况下为`http://localhost:8888`）

***
以下代码应在当前运行的笔记本服务器中打开给定的笔记本，并在必要时启动一个服务器。

```bash
jupyter notebook notebook.ipynb
```

***
使用自定义IP或端口启动笔记本电脑.

默认情况下，笔记本服务器从端口`8888`启动。如果端口`8888`不可用或正在使用中，则笔记本服务器搜索下一个可用端口。 
您也可以手动指定端口。 在此示例中，我们将服务器的端口设置为`9999`：

```bash
jupyter notebook --port 9999
```

***
在不打开Web浏览器的情况下启动笔记本服务器：

```bash
jupyter notebook --no-browser
```

***

获得有关笔记本服务器选项的帮助

```bash
jupyter notebook --help
```

## 快捷键

`Jupyter`笔记本电脑有两种不同的键盘输入模式。 
编辑模式允许您在单元格中键入代码或文本，并以绿色单元格边框指示。 
命令模式将键盘绑定到笔记本级别的命令，并由带有蓝色左边界的灰色单元格边框指示。

`enter`：进入编辑模式
`esc`: 进入命令模式

笔记本界面，菜单中有快捷键提示，在命令模式按下`h`打开，也可以自定义快捷键
常用如下，按小写字母就可以

+ `ctrl+S` 保存
+ `X`: 剪切
+ `C`: 拷贝
+ `V`: 粘贴到下面
+ `shift+V`: 粘贴到上面
+ `D,D`: 删除cell
+ `Z`: 撤回删除
+ `ctrl+shit+-`: 分割cells
+ `shift+L`: 切换行号显示
+ `A`：上方插入
+ `B`：下方插入
+ `Y`: code 格式
+ `M`: markdwon 格式
+ `R` : rawNBConvert 格式
+ `ctrl+enter`:运行单元
+ `shift+enter`:运行并选择下一行
+ `alt+enter`:运行并插入下一行
+ `shift+0`:切换滚动
+ `I,I`打断运行
+ `0,0`:重启内核
