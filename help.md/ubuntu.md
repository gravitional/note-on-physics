# ubuntu

## 常用命令

查看所有可用的字体

```bash
fc-list :lang=zh
```

修复应用

```bash
apt-get -f install pkg
```

安装应用 deb pkg

```bash
dpkg -i pkg
```

`-i`== `--install`

查看应用安装信息

```bash
dpkg -l pkg
dpkg -L pkg
```
