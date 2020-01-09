# learn.bash.md

## ubuntu常用文件操作

+ `mkidr old` : 创建名为`old`的目录
+ `mv old new`: 将`old`目录命名为`new`
+ `rmdir old` : 目录删除分为删除空目录和非空目录，`rmdir`用于删除空目录
+ `rm -rf old` : 指令删除非空目录
+ `cp -r old /home` : 将`old`目录复制到`/home`路径下
+ `touch old` : 创建`old`文件，其他的过程都和目录的操作方法是一样的

[ubuntu创建目录][]

[ubuntu创建目录]: https://jingyan.baidu.com/article/fec7a1e5efb5331191b4e768.html

## 安装Windows 字体

或者，将所有的 `Windows` 字体复制到 /usr/share/fonts 目录下并使用一下命令安装字体：

```bash
mkdir /usr/share/fonts/WindowsFonts
cp /Windowsdrive/Windows/Fonts/* /usr/share/fonts/WindowsFonts
chmod 755 /usr/share/fonts/WindowsFonts/*
```

最后，使用命令行重新生成` fontconfig` 缓存：

```bash
fc-cache
```

### 应用到vscode

"editor.fontFamily": "Fira Code, Source Code Pro, Noto Sans CJK SC, monospace"

这个是用的谷歌的开源字体思源黑体。

`makrdown` 的话，还有个"`markdown.preview.fontFamily`"设置。

>但是也许是我的版本较高，版本`1.23.1`，我的里面设置是这样子的：
>`"editor.fontFamily": "Consolas, Dengxian"`,
>英文字体用了`Consolas`，如果不适用的字体就用`Dengxian`

我的设置

```json
"editor.fontFamily": "Fira Code Retina, Microsoft YaHei",
"editor.fontLigatures": true,
```


`makrdown` 的话，还有个`"markdown.preview.fontFamily"`设置。

[refer1][]
[refer2][]
[refer3][]

[refer1]: https://zhuanlan.zhihu.com/p/40434062
[refer2]: https://segmentfault.com/a/1190000004168301
[refer3]: https://www.v2ex.com/t/453862