# -*- coding: utf-8 -*-
#!/usr/bin/env python3

# 使用 axodraw 画图的常用指令
# 虚线 \DashLine(10,25)(80,25){2}
# 光子线 \Photon(10,20)(80,20){5}{7} 最后两个是 振幅 和 number of wiggles
# 或者用这个指令 \Line[arrow,dash,double](10,10)(80,10)
# 文字 \Text(x, y)(旋转)[对齐]{{文字}}
# 顶点  \Vertex(40,10){1.5} 位置，半径

import os
import math
from collections import Iterable

fpath = r'/home/tom/note/axodraw2'
tex_name = r"nonlocal_vertex.tex"
file = os.path.join(fpath, tex_name)

fig_size = [100, 200]
background = False

# 覆盖之前的文件，重新开始输入
with open(file, 'w', encoding='utf-8') as f:  # 'w' 表示覆盖模式
    f.write(r''' %automatica generated by python script
    \documentclass[a4paper]{article}
        \usepackage{axodraw2}
        \usepackage{pstricks}
        \usepackage{color}
        \begin{document}
        ''')

#  定义图像的尺寸
with open(file, 'a', encoding='utf-8') as f:
    f.write(fr'''
    \begin{{center}}
    \begin{{axopicture}}({str(fig_size[0])},{str(fig_size[1])}) 
    ''')

# 画背景的格子
if background:
    with open(file, 'a', encoding='utf-8') as f:
        f.write(r'''
            % ++++++++++++++++++++格子
            \AxoGrid(0, 0)(10, 10)(52, 52){LightGray}{0.5}
            % ++++++++++++++++++++
            ''')

# 文字转动的角度
tex_ang = '0'
# 子图1的位置
# 图像的左右边界
fig_x1 = [10, 90]
# 图像的下上边界
fig_y1 = [130, 170]

# 用来产生坐标列表的函数，把数字转换成字符串


def tostr(li):
    if isinstance([], Iterable):
        return list(map(str, li))
    else:
        print('illegal input')


# 点的坐标和文字坐标，每个x给出一个横纵坐标

# 文字和线偏离的角度
epsilon = 10

# 子图1 +++++++++++++++++++++++++++++++
# 第一个点
x1 = tostr([fig_x1[0], fig_y1[0]])
t1 = tostr([fig_x1[0], fig_y1[0]+epsilon])
# 第二个点
x2 = tostr([(fig_x1[0]+fig_x1[1])/2, fig_y1[0]])
t2 = tostr([(fig_x1[0]+fig_x1[1])/2, fig_y1[0]+epsilon])
# 第三个点
x3 = tostr([(0*fig_x1[0]+fig_x1[1]), fig_y1[0]])
t3 = tostr([(0*fig_x1[0]+fig_x1[1]), fig_y1[0]+epsilon])
# 第四个点
x4 = tostr([(fig_x1[0]+fig_x1[1])/2, (0*fig_y1[0]+fig_y1[1])/1])
t4 = tostr([(fig_x1[0]+fig_x1[1])/2+epsilon, (0*fig_y1[0]+fig_y1[1])/1])

# 定义箭头样式
arr_line1 = r'arrow,arrowpos=0.5,arrowlength=6,arrowwidth=3,arrowinset=0.1'
arr_line2 = r'arrow,arrowpos=0.5,arrowlength=6,arrowwidth=3,arrowinset=0.1,dash'

# 查看计算出的值是否合理
try:
    print('value calculated')
    print(fig_x1, fig_y1)
    print("the x part is", x1, "\n", "the y part is", x2)
except ZeroDivisionError as e:
    print('custom except:', e)
finally:
    print('custom finally...')

# 开始画图，在文本中，用{}表示变量，用{{}}转义括号

with open(file, 'a', encoding='utf-8') as f:  # 'a' 表示追加模式
    f.write(fr'''
        % (起点)，(终点)
        % 水平的费米子线1
        \Line[{arr_line1}]({x1[0]},{x1[1]})({x2[0]},{x2[1]})
        % 水平的费米子线2
        \Line[{arr_line1}]({x2[0]},{x2[1]})({x3[0]},{x3[1]})
        % 垂直的介子线
        \Line[{arr_line2}]({x4[0]},{x4[1]})({x2[0]},{x2[1]})
        % 文字部分
        \Text({t1[0]}, {t1[1]})({tex_ang}){{$\Sigma^{{+}}$}}
        \Text({t3[0]}, {t3[1]})({tex_ang}){{$\bar{{\Xi^0}}$}}
        \Text({t4[0]}, {t4[1]})({tex_ang}){{$K^{{-}}$}}
        ''')

# 图像的下上边界
fig_y1 = [70, 110]

# 子图2 +++++++++++++++++++++++++++++++
# 第一个点
x1 = tostr([fig_x1[0], fig_y1[0]])
t1 = tostr([fig_x1[0], fig_y1[0]+epsilon])
# 第二个点
x2 = tostr([(fig_x1[0]+fig_x1[1])/2, fig_y1[0]])
t2 = tostr([(fig_x1[0]+fig_x1[1])/2, fig_y1[0]+epsilon])
# 第三个点
x3 = tostr([(0*fig_x1[0]+fig_x1[1]), fig_y1[0]])
t3 = tostr([(0*fig_x1[0]+fig_x1[1]), fig_y1[0]+epsilon])
# 第四个点
x4 = tostr([(fig_x1[0]+0*fig_x1[1])/1, (0*fig_y1[0]+fig_y1[1])/1])
t4 = tostr([(fig_x1[0]+0*fig_x1[1])/1+epsilon, (0*fig_y1[0]+fig_y1[1])/1])
# 第五个点
x5 = tostr([(0*fig_x1[0]+fig_x1[1])/1, (0*fig_y1[0]+1*fig_y1[1])/1])
t5 = tostr([(0*fig_x1[0]+fig_x1[1])/1-epsilon, (0*fig_y1[0]+1*fig_y1[1])/1])
# 光子线的振幅和数目
wig_amp = 3
wig_num = 7

with open(file, 'a', encoding='utf-8') as f:
    f.write(fr'''
        % (起点)，(终点)
        % 水平的费米子线1
        \Line[{arr_line1}]({x1[0]},{x1[1]})({x2[0]},{x2[1]})
        % 水平的费米子线2
        \Line[{arr_line1}]({x2[0]},{x2[1]})({x3[0]},{x3[1]})
        % 倾斜的介子线
        \Line[{arr_line2}]({x4[0]},{x4[1]})({x2[0]},{x2[1]})
        %倾斜的光子线
        \Photon({x5[0]},{x5[1]})({x2[0]},{x2[1]}){{{wig_amp}}}{{{wig_num}}}
        % 文字部分
        \Text({t1[0]}, {t1[1]})({tex_ang}){{$\Sigma^{{+}}$}}
        \Text({t3[0]}, {t3[1]})({tex_ang}){{$\bar{{\Xi^0}}$}}
        \Text({t4[0]}, {t4[1]})({tex_ang}){{$K^{{-}}$}}
        \Text({t5[0]}, {t5[1]})({tex_ang}){{$\gamma$}}
        ''')

# 图像的下上边界
fig_y1 = [10, 50]
# 子图3 +++++++++++++++++++++++++++++++
# 第一个点
x1 = tostr([fig_x1[0], fig_y1[0]])
t1 = tostr([fig_x1[0], fig_y1[0]+epsilon])
# 第二个点
x2 = tostr([(fig_x1[0]+fig_x1[1])/2, fig_y1[0]])
t2 = tostr([(fig_x1[0]+fig_x1[1])/2, fig_y1[0]+epsilon])
# 第三个点
x3 = tostr([(0*fig_x1[0]+fig_x1[1]), fig_y1[0]])
t3 = tostr([(0*fig_x1[0]+fig_x1[1]), fig_y1[0]+epsilon])
# 第四个点
x4 = tostr([(fig_x1[0]+0*fig_x1[1])/1, (0*fig_y1[0]+fig_y1[1])/1])
t4 = tostr([(fig_x1[0]+0*fig_x1[1])/1+epsilon, (0*fig_y1[0]+fig_y1[1])/1])
# 第五个点
x5 = tostr([(0*fig_x1[0]+fig_x1[1])/1, (0*fig_y1[0]+1*fig_y1[1])/1])
t5 = tostr([(0*fig_x1[0]+fig_x1[1])/1-epsilon, (0*fig_y1[0]+1*fig_y1[1])/1])
# 第六个点
x6 = tostr([(fig_x1[0]+fig_x1[1])/2, (1*fig_y1[0]+0*fig_y1[1])/1])
t6 = tostr([(fig_x1[0]+fig_x1[1])/2-epsilon, (1*fig_y1[0]+0*fig_y1[1])/1])
# 光子线的振幅和数目
wig_amp = 3
wig_num = 7
# 光子顶点的半径
size_ver = 3

with open(file, 'a', encoding='utf-8') as f:
    f.write(fr'''
        % (起点)，(终点)
        % 水平的费米子线1
        \Line[{arr_line1}]({x1[0]},{x1[1]})({x2[0]},{x2[1]})
        % 水平的费米子线2
        \Line[{arr_line1}]({x2[0]},{x2[1]})({x3[0]},{x3[1]})
        % 倾斜的介子线
        \Line[{arr_line2}]({x4[0]},{x4[1]})({x2[0]},{x2[1]})
        %倾斜的光子线
        \Photon({x5[0]},{x5[1]})({x2[0]},{x2[1]}){{{wig_amp}}}{{{wig_num}}}
        % 额外相互作用的点
        \Vertex({x6[0]},{x6[1]}){{{size_ver}}}
        % 文字部分
        \Text({t1[0]}, {t1[1]})({tex_ang}){{$\Sigma^{{+}}$}}
        \Text({t3[0]}, {t3[1]})({tex_ang}){{$\bar{{\Xi^0}}$}}
        \Text({t4[0]}, {t4[1]})({tex_ang}){{$K^{{-}}$}}
        \Text({t5[0]}, {t5[1]})({tex_ang}){{$\gamma$}}
        ''')

# 写入文件结尾
with open(file, 'a', encoding='utf-8') as f:
    f.write(r'''
        \end{axopicture}
        \end{center}
        \end{document}
        ''')

# 运行latex编译程序
sh_com = 'texbase=$(basename '+tex_name+' ".tex") \n\
    xelatex ${texbase}; axohelp ${texbase}; xelatex ${texbase} \n\
    if [ -f "${texbase}.pdf" ] ;   then \n\
        evince "${texbase}.pdf" &  \n\
    fi\n '
print(sh_com)
os.system(sh_com)

# pdfcrop     参数是 left bottom right top, 单位是`point`, A4纸张(mm) =`595.4 point`*`842.1 point`
sh_com = 'texbase=$(basename '+tex_name+' ".tex") \n\
if [ -f "${texbase}.pdf" ]; then \n\
    pdfcrop --margins 3 --clip --bbox \'250 520 345 680\' "${texbase}.pdf" "${texbase}_cropped.pdf" \n\
fi \n\
if [ -f "${texbase}_cropped.pdf" ]; then \n\
    evince "${texbase}_cropped.pdf" & \n\
fi\n'
#
os.system(sh_com)
