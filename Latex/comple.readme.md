# compile.readme.md

`powershell` 写的用来编译 `.tex` 的脚本，拙作望不吝赐教。

## 打开powershell

打开 `powershell` 有很多种方式：

+ 右键任务栏左边`Windows`徽标，选择`Windows Powershll(I)`
+ `Win+R` 输入`powershell`
+ 在`.tex` 文件的目录下，空白处按下`Shift+右键`，选择`在此处打开 window powershell 窗口`（推荐）

## 适当修改脚本

然后脚本唯一需要修改的地方是`PDF`预览程序的路径（当然不修改也无所谓，只是不会自动打开编译好的`PDF`）：

随便用一个文本编辑器打开 `compile.ps1`，然后把

```powershell
&'C:\Program Files\SumatraPDF\SumatraPDF.exe'  (Get-ChildItem | Where-Object Name -Like "*.pdf")
```

中的`'C:\Program Files\SumatraPDF\SumatraPDF.exe'` 修改成你电脑上 `PDF` 预览程序的路径，记得带上单引号。

完事儿。

## 使用

在前面打开的`powershell`窗口下，输入比如：

```powershell
.\compile.ps1 pdflatex
```

你可以把 `pdflatex` 替换成 `xelatex`, `lualatex` ...

脚本会自动把文件夹下所有的 `.tex` 文件编译，支持参考文献。

## 其他

功能比较简陋，大佬可以帮忙修改下，哈哈
