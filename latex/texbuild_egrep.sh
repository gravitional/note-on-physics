#!/bin/bash

# 设置格式化相关的部分
nameis="name is :"
# 定义一个打印的函数,并且加上颜色输出
function echo2() {
    delimiter1="+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    delimiter2="-------------------------------------------------------"
    echo -e "$delimiter1\n\033[1;44m\033[1;37m$*\033[0;0m\n$delimiter2"
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
result=$(echo $tex_here | egrep -i "main")
# 如果命令行中指定了文件名，那么使用命令行中的文件名, 并且去掉 .tex 后缀
if [[ $* != "" ]]; then
    tex_here=$(basename -s '.tex' $*)
    echo2 "because cml argument given, using <$tex_here> as input"
elif [[ ${result} != "" ]]; then
    tex_here=${tex_usual}
    echo2 "because there is a tex file named 'main', so we just compile the, $tex_here"
    # 如果不存在命名为 *main*.tex 的文件，就编译发现的 tex
elif [[ $tex_here != "" ]]; then
    echo2 "because there isn't a tex file named 'main', so we just compile the, $tex_here"
fi

## 如果 *.tex 文件不存在，就打印提醒
if test -e "$tex_here" -o -e "$tex_here.tex"; then
    # 开始循环，对每一个tex文件编译，并寻找错误
    # 可增加输出文件夹选项 -auxdir=temp -outdir=temp
    # 还有 -shell-escape 选项
    # 把下面这行加入到 ~/.latexmkrc，指定 pdf 查看程序
    # $pdf_previewer = 'evince %O %S';
    # -silent 选项可以抑制输出
    for var in $tex_here; do
        # 打印正在处理的tex 文件名字
        echo2 "the tex processed is $var"
        # 用latexmk 逐个编译 *.tex
        latexmk -silent -xelatex -pv -view=pdf -bibtex -cd -recorder -file-line-error -interaction=nonstopmode -synctex=1 $var
        ## 输出错误记录
        echo2 'echo message'
        ## 之前用 tail 减少输出数量
        ## egrep -m 100 -Ii -n --color -B 0 -A 8 "\[[[:digit:]]+\]" "$var.log" | tail -n 50
        # 输出错误，[11]这种类型的, 忽略二进制文件
        egrep -m 10 -Ii -n --color -B 0 -A 8 "\[[[:digit:]]+\]" "$var.log"
        # 输出各种形式的错误
        echo2 'echo errors : ! LaTeX Error:'
        egrep -i -m 15 -n --color -B 1 -A 6 -e "! LaTeX Error:" "$var.log"
        echo2 'echo errors : \? x'
        egrep -i -m 15 -n --color -B 1 -A 6 -e "\? x" "$var.log"
        echo2 'echo errors : xx.tex: 123 '
        egrep -i -m 15 -n --color -B 0 -A 6 -e "\.tex:[[:digit:]]+:" "$var.log"
        # echo2 'echo errors : ! Package tikz Error:'
        # egrep -i -m 15 -n --color -B 0 -A 6 -e "! Package tikz Error:" "$var.log"
        # 给出错误的具体位置 l.123
        echo2 'the error line postion'
        egrep -i -m 15 -n --color -B 1 -A 1 "l\.[[:digit:]]+" "$var.log"
    done
else
    echo2 "error: there are no .tex files found"
fi
