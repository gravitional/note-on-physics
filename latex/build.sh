#!/bin/bash

# 设置格式化相关的部分
delimiter="echo -e \\\n+++++++++++++"
nameis="name is :"
eval  $delimiter

# 默认文件名是 main，否则使用文件夹中的tex文件名
tex_usual="main"
echo "tex_usual $nameis $tex_usual"
eval  $delimiter

# 当前tex文件列表，去掉后缀

tex_list=$(ls -x *.tex)
echo "tex_list $nameis $tex_list"

tex_here=${tex_list//".tex"/}
echo "tex_here $nameis $tex_here"
eval  $delimiter

# 判断当前tex文件列表中是否包含 main.tex
# 若有 main.tex，使用之，若没有，则使用 列表中的tex
if [[ $tex_usual=~$tex_here ]]
then
    tex_file=$tex_usual
else
    tex_file=${$tex_here%%" *"}
fi

echo "tex_file $nameis $tex_file"
eval  $delimiter

# 可增加输出文件夹选项 -auxdir=temp -outdir=temp
# 还有 -shell-escape 选项

# 把下面这行加入到 ~/.latexmkrc，指定 pdf 查看程序
# $pdf_previewer = 'evince %O %S';

latexmk -xelatex  -silent -pv  -view=pdf -bibtex -cd -recorder -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 -view=pdf ${tex_file}

## 输出错误记录
eval  $delimiter
echo 'error message'
eval  $delimiter
## 用 tail 减少输出数量
## grep -m 100 -i -n --color -P -B 0 -A 8 "\[\d+\]" ./$tex_file".log" | tail -n 50
grep -m 10 -i -n --color -P -B 0 -A 8 "\[\d+\]" ./$tex_file".log" 
