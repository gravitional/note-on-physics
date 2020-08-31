# -*- coding: utf-8 -*-
#!/usr/bin/env python3

import os
import math
from collections import Iterable

fpath = r'/home/tom/note/axodraw2'
tex_name = r"lagrangian_hamilton.tex"
file = os.path.join(fpath, tex_name)

# 追加内容的函数


def wnline(str):
    with open(file, 'a', encoding='utf-8') as f:
        f.write(str+'\n')
    return 0


fig_size = [300, 300]
background = False

# 覆盖之前的文件，重新开始输入
with open(file, 'w', encoding='utf-8') as f:
    f.write(
        '\\documentclass[a4paper]{article}\n\\usepackage{axodraw2}\n\\usepackage{pstricks}\n\\usepackage{color}\n\n\\begin{document}\n')


#  定义图像的尺寸
with open(file, 'a', encoding='utf-8') as f:
    f.write('\\begin{center}\n\\begin{axopicture}(' +
            str(fig_size[0])+','+str(fig_size[1])+')\n')

# 画背景的格子
if background:
    with open(file, 'a', encoding='utf-8') as f:
        f.write(
            '% ++++++++++++++++++++格子\n\\AxoGrid(0, 0)(10, 10)(52, 52){LightGray}{0.5}\n% ++++++++++++++++++++\n')

tex_ang = '0'
# 图像的左右边界
fig_x1 = [20, 260]
# 图像的下上边界
fig_y1 = [20, 260]

# 用来产生坐标列表的函数


def tostr(li):
    if isinstance([], Iterable):
        return list(map(str, li))
    else:
        print('illegal input')


# 点的坐标和文字坐标
epsilon = 5

t1 = tostr([(1*fig_x1[0]+1*fig_x1[1])/2, (3*fig_y1[0]+0*fig_y1[1])/3])
x1 = tostr([(1*fig_x1[0]+1*fig_x1[1])/2, (3*fig_y1[0]+0*fig_y1[1])/3+epsilon])

t6 = tostr([(1*fig_x1[0]+1*fig_x1[1])/2, (0*fig_y1[0]+3*fig_y1[1])/3])
x6 = tostr([(1*fig_x1[0]+1*fig_x1[1])/2, (0*fig_y1[0]+3*fig_y1[1])/3-epsilon])


t2 = tostr([(2*fig_x1[0]+0*fig_x1[1])/2, (2*fig_y1[0]+1*fig_y1[1])/3])
t3 = tostr([(0*fig_x1[0]+2*fig_x1[1])/2, (2*fig_y1[0]+1*fig_y1[1])/3])
x2 = tostr([(2*fig_x1[0]+0*fig_x1[1])/2+epsilon, (2*fig_y1[0]+1*fig_y1[1])/3])
x3 = tostr([(0*fig_x1[0]+2*fig_x1[1])/2-epsilon, (2*fig_y1[0]+1*fig_y1[1])/3])

t4 = tostr([(2*fig_x1[0]+0*fig_x1[1])/2, (1*fig_y1[0]+2*fig_y1[1])/3])
t5 = tostr([(0*fig_x1[0]+2*fig_x1[1])/2, (1*fig_y1[0]+2*fig_y1[1])/3])
x4 = tostr([(2*fig_x1[0]+0*fig_x1[1])/2+epsilon, (1*fig_y1[0]+2*fig_y1[1])/3])
x5 = tostr([(0*fig_x1[0]+2*fig_x1[1])/2-epsilon, (1*fig_y1[0]+2*fig_y1[1])/3])

# 定义箭头样式
arr_line = r'arrow,arrowpos=0.34,arrowlength=6,arrowwidth=3,arrowinset=0.1'

try:
    print('value calculated')
    print(fig_x1, fig_y1)
    print("the x part is", x1, "\n", "the y part is", x2)
except ZeroDivisionError as e:
    print('custom except:', e)
finally:
    print('custom finally...')

# 开始画图
with open(file, 'a', encoding='utf-8') as f:
    f.write('\n\
        % (起点)，(终点)\n\
        \\Line['+arr_line+']('+x1[0]+','+x1[1]+')('+x2[0]+','+x2[1]+')\n\
        \\Line['+arr_line+']('+x1[0]+','+x1[1]+')('+x3[0]+','+x3[1]+')\n\
        % 第二层\n\
        \\Line['+arr_line+']('+x2[0]+','+x2[1]+')('+x4[0]+','+x4[1]+')\n\
        \\Line['+arr_line+']('+x3[0]+','+x3[1]+')('+x4[0]+','+x4[1]+')\n\
        \\Line['+arr_line+']('+x2[0]+','+x2[1]+')('+x5[0]+','+x5[1]+')\n\
        \\Line['+arr_line+']('+x3[0]+','+x3[1]+')('+x5[0]+','+x5[1] + ')\n\
        % 第三层\n\
        \\Line['+arr_line+']('+x2[0]+','+x2[1]+')('+x6[0]+','+x6[1] + ')\n\
        \\Line['+arr_line+']('+x5[0]+','+x5[1]+')('+x6[0]+','+x6[1] + ')\n\
        % \Text(x, y)(旋转)[对齐]{文字}\n\
        \\Text('+t1[0]+', '+t1[1]+')('+tex_ang + '){$t$}\n\
        \\Text('+t2[0]+', '+t2[1]+')('+tex_ang + '){$q$}\n\
        \\Text('+t3[0]+', '+t3[1]+')('+tex_ang + '){$\dot{q}$}\n\
        \\Text('+t4[0]+', '+t4[1]+')('+tex_ang + '){$L$}\n\
        \\Text('+t5[0]+', '+t5[1]+')('+tex_ang + '){$p$}\n\
        \\Text('+t6[0]+', '+t6[1]+')('+tex_ang + '){$H$}\n\
        ')

# 写入文件结尾
with open(file, 'a', encoding='utf-8') as f:
    f.write(
        '\\end{axopicture}\n\\end{center}\n\\end{document}\n')

# 运行latex编译程序

sh_com = 'texbase=$(basename '+tex_name+' ".tex") \n\
    xelatex ${texbase}; axohelp ${texbase}; xelatex ${texbase} \n\
    if [ -f "${texbase}.pdf" ] ;   then \n\
        evince "${texbase}.pdf" &  \n\
    fi\n '
print(sh_com)
os.system(sh_com)


# pdfcrop
sh_com = 'texbase=$(basename '+tex_name+' ".tex") \n\
if [ -f "${texbase}.pdf" ]; then \n\
    pdfcrop --margins 3 --clip --bbox \'160 430 415 680\' "${texbase}.pdf" "${texbase}_cropped.pdf" \n\
    ##  left top right bottom \n\
fi \n\
if [ -f "${texbase}_cropped.pdf" ]; then \n\
    evince "${texbase}_cropped.pdf" & \n\
fi\n'

os.system(sh_com)


# texbase="lagrangian_hamilton"
# if [ -f "${texbase}.pdf" ]; then 
#     pdfcrop --margins 3 --clip --bbox '160 430 415 680' "${texbase}.pdf" "${texbase}_cropped.pdf" 
#     ##  left bottom right top
# fi