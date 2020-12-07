# ubuntu_7

## Imagemagick 使用

[ImageMagick](https://imagemagick.org/)

使用`ImageMagick`创建,编辑,合成或转换位图图像。
它可以读取和写入各种格式(超过200种)的图像,包括PNG,JPEG,GIF,HEIC,TIFF,DPX,EXR,WebP,Postscript,PDF和SVG。 
`ImageMagick`可以调整图像大小,翻转,镜像,旋转,变形,剪切和变换图像,调整图像颜色,应用各种特殊效果或绘制文本,线条,多边形,椭圆和贝塞尔曲线。
`ImageMagick`是免费软件,可以即用型二进制分发形式提供,也可以作为源代码提供,您可以在开放应用程序和专有应用程序中使用,复制,修改和分发它们。 它是在派生的`Apache 2.0`许可下分发的。
`ImageMagick`利用多个计算线程来提高性能,并且可以读取,处理或写入兆,千兆或兆像素的图像大小。

`ImageMagick`有一个单文件版本--`magick`,在`Linux`上完整的便携式应用程序,无需安装。 只需下载并运行。 
`AppImage`需要`FUSE`和`libc`才能运行。 许多发行版都具有开箱即用的有效`FUSE`设置。 但是,如果对您不起作用,则必须手动安装和配置`FUSE`。

[FUSE](https://github.com/AppImage/AppImageKit/wiki/FUSE)

AppImage需要FUSE才能运行。 Filesystem in Userspace (FUSE)是一种允许非root用户安装文件系统的系统。在 Ubuntu 上安装`FUSE`:

```bash
sudo apt install fuse
sudo modprobe fuse
sudo groupadd fuse

user="$(whoami)"
sudo usermod -a -G fuse $user
```

下载便携版`magick`程序之后,运行以下命令,将绘制一个示例的进度图

```bash
magick -size 320x90 canvas:none -stroke snow4 -size 1x90 -tile gradient:white-snow4 \
  -draw 'roundrectangle 16, 5, 304, 85 20,40' +tile -fill snow \
  -draw 'roundrectangle 264, 5, 304, 85  20,40' -tile gradient:chartreuse-green \
  -draw 'roundrectangle 16,  5, 180, 85  20,40' -tile gradient:chartreuse1-chartreuse3 \
  -draw 'roundrectangle 140, 5, 180, 85  20,40' +tile -fill none \
  -draw 'roundrectangle 264, 5, 304, 85 20,40' -strokewidth 2 \
  -draw 'roundrectangle 16, 5, 304, 85 20,40' \( +clone -background snow4 \
  -shadow 80x3+3+3 \) +swap -background none -layers merge \( +size -pointsize 90 \
  -strokewidth 1 -fill red label:'50 %' -trim +repage \( +clone -background firebrick3 \
  -shadow 80x3+3+3 \) +swap -background none -layers merge \) -insert 0 -gravity center \
  -append -background white -gravity center -extent 320x200 cylinder_shaded.png
```

### 几何参数

Image Geometry

许多命令行选项采用几何参数来指定诸如所需的图像宽度和高度以及其他尺寸数量之类的内容。
因为用户想要图像的最终尺寸,大小和位置有如此多的变化(并且因为ImageMagick希望提供它们),所以geometry参数可以采用多种形式。我们将在本节中描述其中的许多内容。

采用某些几何参数形式的图像选项和设置包括以下内容。请记住,其中一些的 parse 方式略有不同。有关更多选项,请参见有关单个选项或设置的文档。

```magic
-adaptive-resize , -border , -borderwidth , -chop , -crop , -density , -extent , -extract , -frame , -geometry , -iconGeometry , -liquid-rescale , -page , 
-region , -repage , -resize , -sample , -scale , -shave , -splice , -thumbnail , -window 
```

geometry参数可以采用下表中列出的任何形式。这些将在表格后面的小节中详细介绍。
通常的形式是`size[offset]`,这意味着需要大小,而`offset`是可选的。有时也可能是`[size]offset`的形式。在任何情况下,几何参数中都不允许有空格。

格式和含义:
大小;  一般说明(实际行为可能因不同的选项和设置而异)

+ `scale%`;     高度和宽度均按指定的百分比缩放。
+ `scale-x%xscale-y%`   按指定百分比分别缩放的高度和宽度。 (只需要一个`％`符号。)
+ `width`       给定的宽度,自动选择的高度以保留宽高比。
+ `xheight`     给定的高度,自动选择的宽度以保留宽高比。
+ `widthxheight`        给定的高度和宽度的最大值,保留宽高比。
+ `widthxheight^`      给定的宽度和高度的最小值,保留宽高比。
+ `widthxheight!`       着重给出宽度和高度,忽略原始宽高比。
+ `widthxheight>`      缩小尺寸大于相应的`width`或`height`参数的图像。
+ `widthxheight<`   放大尺寸小于相应的`width`或`height`参数的图像。
+ `area@`       调整图像大小以具有以像素为单位的指定区域。长宽比被保留。
+ `x:y` 在此,`x`和`y`表示纵横比(例如`3:2=1.5`)。
+ `{size}{offset}`  指定偏移量(默认为`+0+0`)。下面的`{size}`是指以上任何形式。
+ `{size}{+-}x{+-}y`    水平和垂直偏移`x`和`y`,以像素为单位。两者都需要`+-`号(sign)。偏移量受`-gravity`设置的影响。
偏移不受`％`或其他大小运算符的影响。请注意,除了`center`选项,对于所有重力选项,正`X`和`Y`偏移都朝向图像中心。对于`East`,`+X`是左边。
对于`South`,`+Y`是上。对于`SouthEast`,`+X`是左,`+Y`是上。对于`center`,使用常规的`X`和`Y`方向约定(`+X`向左,`+Y`向下)。

## Output Filename

### 文件名引用

使用`embedded formatting character `输出图像列表。 
假设我们的输出文件名是`image-%d.jpg`，并且我们的输入的图像列表包括3张图像。 您可以期望输出以下图像文件：

```bash
image-0.jpg
image-1.jpg
image-2.jpg
```

或检索图像属性以修改图像文件名。 例如，

```bash
magick rose: -set filename:area '%wx%h' 'rose-%[filename:area].png'
```

用以下文件名写入图像：

```bash
rose-70x46.png
```

最后，要将多个JPEG图像转换为单独的PDF页面，请使用：

```bash
magick *.jpg +adjoin page-%d.pdf
```

### crop 剪切图像

[Imagemagick 命令行工具](https://imagemagick.org/script/command-line-tools.php)

`-crop geometry{@}{!}`

切出图像的一个或多个矩形区域。

有关几何参数的完整详细信息,请参见图像几何。

`geometry`参数的宽度和高度给出了裁剪后剩余图像的大小,偏移量中的`x`和`y`(如果存在)给出了裁剪图像相对于原始图像的左上角的位置。
如果要指定删除的数量,请改用`-shave`。

如果存在x和y偏移,则生成单个图像,该图像由裁剪区域中的像素组成。偏移量指定：裁减区域的左上角相对于图像的左上角,向右和向下。
可以通过`-gravity`改变默认的方向, `-gravity`可以设置为
`NorthEast`, `East`, or `SouthEast`
`SouthWest`, `South`, or `SouthEast `

如果省略`x`和`y`偏移,则生成指定几何形状的`tiles`(平铺,瓷砖),这些图块覆盖整​​个`input`图像。
如果指定的几何形状超出输入图像的尺寸,则最右边的图块和底部的图块将较小。

您可以在几何参数中添加`@`,以将图像平均划分为生成的图块数量。

通过将`!`惊叹号标志添加到几何参数,将适当设置裁剪后的图像虚拟画布页面大小和偏移,表现成`viewport`or `window`的效果。
这意味着画布页面大小设置为与您指定的大小完全相同,图像偏移设置为裁剪区域的相对左上角。

如果裁剪后的图像在其虚拟画布上`missed`了实际图像,则会返回一个特殊的单像素透明`missed`图像,并给出`crop missed`警告。

在裁剪图像之前,可能需要`+repage `图像,以确保将裁剪坐标框重定位到可见图像的左上角。
同样,您可能希望在裁剪后使用``+repage ``来删除遗留的页面偏移量。当您要写入支持图像偏移量的图像格式(例如`PNG`)时,尤其如此。

### Inline Image Crop

有时在读取图像时裁剪图像很方便。 假设您有数百张要转换为PNG缩略图的大JPEG图像：

```bash
magick '*.jpg' -crop 120x120+10+5 thumbnail%03d.png
```

此处读取所有图像，然后裁剪。 读取每个图像时，裁剪图像的速度更快且资源占用更少：

```bash
magick '*.jpg[120x120+10+5]' thumbnail%03d.png
```

在`ubuntu-20`上使用上面的命令转换`pdf`可能会报错，

```bash
gs: symbol lookup error: /usr/lib/x86_64-linux-gnu/libgs.so.9: undefined symbol: cmsCreateContext
```

下面的帖子建议更新`ghostscript`
[Errors converting PDF with Imagemagick on Ubuntu 18](https://askubuntu.com/questions/1258602/errors-converting-pdf-with-imagemagick-on-ubuntu-18)

从 [ArtifexSoftware/ghostpdl ](https://github.com/ArtifexSoftware/ghostpdl) 下载`ghostscript`的最新版本，比如`ghostscript-9.53.3-linux-x86_64`，
用它替换`/usr/bin/gs`即可。

## density

-density width
-density widthxheight

设置图像的水平和垂直分辨率，以渲染到设备。

此选项指定在对光栅图像进行编码时要存储的图像分辨率，或在将Postscript，PDF，WMF和SVG等矢量格式渲染(reading)到光栅图像时指定要存储的图像分辨率。
图像分辨率提供了渲染到输出设备或光栅图像时要应用的度量单位。默认的度量单位是每英寸点数（`DPI`）。 `-units` 选项可用于选择每厘米点数(不同单位)。

默认分辨率是每英寸72点，相当于每像素一个点（Macintosh和Postscript标准）。计算机屏幕通常每英寸72或96点，而打印机通常每英寸支持150、300、600或1200点。
要确定显示器的分辨率，请使用标尺测量屏幕的宽度（以英寸为单位），然后除以水平像素数（在1024x768显示器上为1024）。

如果文件格式支持，则此选项可用于更新存储的图像分辨率。请注意，Photoshop存储并从专有的嵌入式配置文件中获取图像分辨率。
如果未从图像中删除此配置文件，则Photoshop将继续使用其以前的分辨率来处理图像，而忽略标准文件头中指定的图像分辨率。

`-density`选项设置属性，并且不会更改基础栅格图像。它可用于通过调整应用于像素的比例来调整渲染尺寸以用于桌面发布。
要调整图像的大小，以使其具有相同的大小，但分辨率不同，请使用`-resample`选项。
