" 设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" 默认字体
set guifont=Courier\ New:h20


" 窗口大小 位置
set lines=32 columns=100
winpos 300 0


" 显示行号和相对行号 etc
set number
set relativenumber 

" highlight the search results
set hlsearch
 
" file type detection
filetype on

" 突出显示当前行
" set cursorline

" 突出显示当前列
" set cursorcolumn

" 显示括号匹配
set showmatch

" 设置缩进
" 设置Tab长度为4空格
set tabstop=4
" 设置自动缩进长度为4空格
set shiftwidth=4
" 继承前一行的缩进方式，适用于多行注释
set autoindent
set smartindent

" tab to space 
set expandtab

" 设置粘贴模式
set paste

" 显示空格和tab键
set listchars=tab:>-,trail:-

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler


" 代码补全
set completeopt=preview,menu

" 去掉输入错误的提示声音
set noeb

" 颜色方案
syntax on 
" set background=dark
" colorscheme solarized


