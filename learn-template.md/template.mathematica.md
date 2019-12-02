## MapThread level 的区别

```mathematica
In[2]:= MapThread[f, {{{a, b}, {c, d}}, {{u, v}, {s, t}}}]
Out[2]= {f[{a, b}, {u, v}], f[{c, d}, {s, t}]}
```

```mathematica
>In[3]:= MapThread[f, {{{a, b}, {c, d}}, {{u, v}, {s, t}}}, 2]
Out[3]= {{f[a, u], f[b, v]}, {f[c, s], f[d, t]}}
```

## Grid temple

```mathematica
Grid[(*start grid *)
 Prepend[(*start prepend names horizontal*)
  MapThread[Prepend,(*start prepend names vertical *)
   {(*add names column*)
    datalist,(*add the data to display*)
    name`vertical (*end prepend names vertical *)
    }
   ],
  {"", name`horizontal}(*end prepend names horizontal*)
  ]
 , Frame -> {All, All}
 , Spacings -> {2, 2}
 , Background -> {None, {{None, None}}}
 ](*end grid *)
```

## Grid 背景颜色玄学用法

设置指定项的背景：

```mathematica
Grid[Table[x, {4}, {7}], 
 Background -> {None, None, {{1, 1} -> Pink, {3, 4} -> Red}}]
```

设置网格区域的背景：

```mathematica
Grid[Table[x, {4}, {7}], 
 Background -> {None, None, {{1, 1} -> Pink, {3, 4} -> Red}}]
```

## 不显示行号

```mathematica
SetOptions[EvaluationNotebook[], ShowCellLabel -> False];
```







