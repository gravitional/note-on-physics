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

# 默认文件名是 main，否则使用文件夹中的tex文件名
tex_usual="main"
echo2 "tex_usual" $nameis $tex_usual

# 当前tex文件列表，排成一行显示
tex_list=$(ls -x *.tex)
echo2 "tex_list $nameis $tex_list"
# 去掉后缀的.tex
tex_here=${tex_list//.tex/}
echo2 "tex_here $nameis $tex_here"
# 判断当前tex文件列表中是否包含 main.tex
# 若有 main.tex，使用之，若没有，则使用 列表中的tex
if [[ $tex_usual =~ $tex_here ]]
then
    tex_here=${tex_usual}
fi
echo2 "tex_here updated, $nameis $tex_here"
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
grep -m 10 -i -n --color -P -B 0 -A 8 "\[\d+\]" "${var}.log"
# 输出errors
echo2 'echo errors'
grep -m 15 -i -n --color -P -B 0 -A 8 "${var}\.tex:\d+:" "${var}.log"
done

