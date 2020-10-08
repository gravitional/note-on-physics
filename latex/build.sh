#!/bin/bash

# 设置格式化相关的部分
nameis="name is :"
# 定义一个打印的函数
function echo2()
{
	delimiter1="+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		delimiter2="-------------------------------------------------------"
		echo -e "${delimiter1}\n $* \n${delimiter2}"
}
# 打印当前目录
echo2 "current directory is " $(pwd)
# 默认文件名是 main，否则使用文件夹中的tex文件名
tex_usual="main"
echo2 "tex_usual" $nameis $tex_usual

# 当前tex文件列表， 去掉后缀的.tex
tex_here=$(basename -s '.tex' $(ls *.tex) | xargs echo)
echo2 "tex_here $nameis $tex_here"
# 判断当前tex文件列表中是否包含 main.tex
# 若有 main.tex，使用之，若没有，则使用 列表中的tex
result=$(echo $tex_here | grep -iP "main" )
if [[ $* != "" ]];then
tex_here=$*
echo2 "because cml argument given, using <$tex_here> as input"
elif [[ ${result} != "" ]]
then
tex_here=${tex_usual}
echo2 "because there is a tex file named 'main', so we just compile the, $tex_here"
else
echo2 "because there isn't a tex file named 'main', so we just compile the, $tex_here"
fi
# 开始循环，对每一个tex文件编译，并寻找错误
# 可增加输出文件夹选项 -auxdir=temp -outdir=temp
# 还有 -shell-escape 选项
# 把下面这行加入到 ~/.latexmkrc，指定 pdf 查看程序
# $pdf_previewer = 'evince %O %S';
# -silent 选项可以抑制输出
for var in ${tex_here}
do
# 打印正在处理的tex 文件名字
echo2 "the tex processed is ${var}"
# 用latexmk 逐个编译 *.tex
latexmk -silent -xelatex -pv -view=pdf -bibtex -cd -recorder -file-line-error -interaction=nonstopmode -synctex=1  $var
## 输出错误记录
echo2 'echo message'
## 之前用 tail 减少输出数量
## grep -m 100 -i -n --color -P -B 0 -A 8 "\[\d+\]" "$var.log" | tail -n 50
# 输出警告
grep -m 10 -Pi -n --color -B 0 -A 8 "\[\d+\]" "${var}.log"
# 输出各种形式的错误
echo2 'echo errors 1'
grep -Pi -m 15 -n --color -B 1 -A 6 -e "! LaTeX Error:" "${var}.log"
echo2 'echo errors 2'
grep -Pi -m 15 -n --color -B 1 -A 6 -e "\? x"       "${var}.log"
echo2 'echo errors 3'
grep -Pi -m 15 -n --color -B 0 -A 6 -e "\.tex:\d+:" "${var}.log"
# 给出错误的具体位置 l.123
echo2 'the error line postion'
grep -Pi -m 15 -n --color -B 1 -A 1 "l\.\d+" "${var}.log"
done
