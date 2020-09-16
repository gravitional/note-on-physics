# git.x.md

## git 分支的目录结构

`.git`文件夹下，有`/refs/`文件夹，`/refs/`结构如下：

```bash
/heads/
   branch1
   branch2
   ...
/remotes/
   origin
       reomote_branch1
       HEAD
   origin2
   ...
/tags/
   tag1
   ...
```

$ git log origin/master
$ git log remotes/origin/master
$ git log refs/remotes/origin/master

## git 配置

[初次运行 Git 前的配置 ][]

[初次运行 Git 前的配置 ]: https://gitee.com/help/articles/4107

在新的系统上，我们一般都需要先配置下自己的 `Git` 工作环境。
配置工作只需一次，以后升级时还会沿用现在的配置。当然，如果需要，你随时可以用相同的命令修改已有的配置。

Git 提供了一个叫做 `git config` 的工具（译注：实际是 `git-config` 命令，只不过可以通过 `git` 加一个名字来呼叫此命令。），专门用来配置或读取相应的工作环境变量。
而正是由这些环境变量，决定了 Git 在各个环节的具体工作方式和行为。这些变量可以存放在以下三个不同的地方：

+ `/etc/gitconfig` 文件：系统中对所有用户都普遍适用的配置。若使用 `git config` 时用 `--system` 选项，读写的就是这个文件。
+ `~/.gitconfig` 文件：用户目录下的配置文件只适用于该用户。若使用 `git config` 时用 --global 选项，读写的就是这个文件。
+ 当前仓库的 `Git` 目录中的配置文件（也就是工作目录中的 `.git/config` 文件）：这里的配置仅仅针对当前仓库有效。每一个级别的配置都会覆盖上层的相同配置，所以 `.git/config` 里的配置会覆盖 `/etc/gitconfig` 中的同名变量。
外，Git 还会尝试找寻 /etc/gitconfig 文件，只不过看当初 Git 装在什么目录，就以此作为根目录来定位。

+ 用户信息配置

第一个要配置的是你个人的用户名称和电子邮件地址,说明是谁提交了更新，会随更新内容一起被永久纳入历史记录：

```bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

+ 文本编辑器配置

接下来要设置的是默认使用的文本编辑器。Git 需要你输入一些额外消息的时候，会自动调用一个外部文本编辑器给你用。如果你有其他偏好，比如 Emacs 的话，可以重新设置：

```bash
$ git config --global core.editor emacs
```

+ 差异分析工具

```bash
$ git config --global merge.tool vimdiff
```

+ 查看配置信息 : `git config --list`

### git 配置文件写法

以`#` or `;` 开头的将被看成是注释，到行末。
大部分空格将被忽略，空行也被忽略

文件包含`Sections` 和`variables`，类似下面这种格式，`[section]`，还可以有`[section "subsection"]`
所有名字都是大小写敏感的。其他的行被看成是设置变量值。

```gitconfig
[core]
   repositoryformatversion = 0
   filemode = true
[branch "master"]
   remote = origin
   merge = refs/heads/master
```

Named remote in configuration file

You can choose to provide the name of a remote which you had previously configured using git-remote[1], git-config[1] or even by a manual edit to the $GIT_DIR/config file. The URL of this remote will be used to access the repository. The refspec of this remote will be used by default when you do not provide a refspec on the command line. The entry in the config file would appear like this:

	[remote "<name>"]
		url = <url>
		pushurl = <pushurl>
		push = <refspec>
		fetch = <refspec>

The <pushurl> is used for pushes only. It is optional and defaults to <url>.



## 还原文件

### git restore

```git
git restore [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>…​
git restore (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>…​]
```

Restore specified paths in the working tree with some contents from a restore source.
If a path is tracked but does not exist in the restore source, it will be removed to match the source.

The command can also be used to restore the content in the index with `--staged`, or restore both the working tree and the index with `--staged --worktree`.

By default, the restore sources for working tree are the index, and for the `index` are `HEAD`. `--source` could be used to specify a commit as the restore source.

```git
-s <tree>
--source=<tree>
```

Restore the working tree files with the content from the given tree. It is common to specify the source tree by naming a `commit`, `branch` or `tag` associated with it.

If not specified, the default restore source for the `working tree` is the `index`, and the default restore source for the `index` is `HEAD`.
When both `--staged` and `--worktree` are specified, `--source` must also be specified.

```git
-W
--worktree
-S
--staged
```

Specify the restore location.
If neither option is specified, by default the working tree is restored.
Specifying `--staged` will only restore the index. Specifying both restores both.

example:

```git
git restore --source master~2 Makefile
```

```git
git restore --source=9ea00d1 parton.note.1.nb
```

### git checkout

git-checkout - Switch branches or restore working tree files

切换分支或者恢复`working tree`中的文件

```bash
git checkout [<tree-ish>] [--] <pathspec>…​
```

用 `index`或者`<tree-ish>`（通常是一个`commit`）里面的内容替换`working tree`里面的 `paths`。
当给出一个`<tree-ish>`的时候，the `paths` that match the `<pathspec>`会在 `index`and in the `working tree` 里面都更新。

`index` 中可能包含有之前合并失败的`entries`。
默认情况下，如果你想 `checkout` 一个这样的entries，会失败，什么都不会发生。使用`-f`选项忽略未合并的entries。

The contents from a specific side of the merge can be checked out of the `index` by using `--ours` or `--theirs`.

With `-m`, 对 `working tree` 所做的更改将会被丢弃，重新创建冲突的 merge 结果

### git reset

***
`git reset --hard <commit>` or 别名 `grhh <commit>` 

`--hard` 会清空`working tree`和`index`的改动.
彻底回退版本，连本地文件都会被回退到上个版本的内容

***
`git reset --soft xxxx` or 别名 `grh --soft <commit>` 

保留`working tree`和`index`，并合并到`index`中。
只回退`commit`，如果你想再次提交直接`git commit`即可。

`reset --soft` 会在重置 `HEAD` 和 `branch` 时，保留`working tree`和`index`中的内容，
并把重置 `HEAD` 所带来的新的差异放进`index`。

***
`reset 不加参数(--mixed)` or 别名 `grh <commit>` 

清空`index`,`mix`到`working tree`中

`reset` 如果不加参数，那么默认使用 `--mixed` 参数。它的行为是：保留`working tree`，并且清空`index`。
也就是说，`working tree`的修改、`index`的内容以及由 `reset` 所导致的新的文件差异，都会被放进`working tree`。
简而言之，就是把所有差异都混合（`mixed`）放在`working tree`中`。

***
同理，`reset --hard` 不仅可以撤销提交，还可以用来把 `HEAD` 和 `branch` 移动到其他的任何地方。

```bash
git reset --hard branch2
```

把 `HEAD` 和 `branch`移动到`branch2`指向的提交。

[Git Reset 三种模式][]
[git reset --hard xxx、git reset --soft 及git revert 的区别][]
[Git Reset 三种模式][]

## git重命名文件夹

不用先在本地修改文件夹名称

文件夹名称: `game`   文件夹修改后名称: `gamesdk`

+ `git mv game gamesdk`
+ `git commit -m 'rename dir game to gamesdk'`
+ `git push origin dev`  推送到`dev`分支

ref: [git重命名文件夹][]

[git重命名文件夹]: https://www.jianshu.com/p/e886fde18ba0

## 修改最后一次注释

如果你只想修改最后一次注释（就是最新的一次提交），

`git commit --amend`

## 远程仓库

### 添加ssh 公匙

[SSH 公钥设置 ][]

[SSH 公钥设置 ]: https://gitee.com/help/articles/4191#article-header0

用如下命令来生成 `sshkey`:

```bash
ssh-keygen -t rsa -C "xxxxx@xxxxx.com"  
# Generating public/private rsa key pair...
```

注意：这里的 `xxxxx@xxxxx.com` 只是生成的 `sshkey` 的名称，并不约束或要求具体命名为某个邮箱。

现网的大部分教程均讲解的使用邮箱生成，其一开始的初衷仅仅是为了便于辨识所以使用了邮箱
复制生成后的 `ssh key`，在仓库主页`管理`页面中，添加生成的 public key 添加到仓库中。

添加后，在终端中输入下面的命令，来检测是否能成功连接

```bash
ssh -T git@gitee.com
# -T      Disable pseudo-terminal allocation.
```

首次使用需要确认并添加主机到本机SSH可信列表。若返回 `Hi XXX! You've successfully authenticated,....` 内容，则证明添加成功。

添加成功后，就可以使用SSH协议对仓库进行操作了。

### 远程仓库操作

远程仓库可以在你的本地主机上

+ `git remote -v` 查看远程仓库
+ `git remote add <shortname> <url>` 添加远程仓库
+ `git fetch <remote>` 从远程仓库抓取
+ `git push origin master` 推送到远程仓库
+ `git remote show origin` 查看某个远程仓库
+ `git remote rename pb paul` 将远程仓库`pb`重命名为`paul`
+ `git remote remove paul` 删除失效的远程仓库
+ `git remote set-url origin` 修改仓库对应的远程仓库地址

### 设置多个远程分支

[git 本地仓库同时推送到多个远程仓库][]

[git 本地仓库同时推送到多个远程仓库]: https://blog.csdn.net/fox9916/article/details/79386169

先准备两个空的远程仓库, 如果远程仓库里有`readme`这样的文件，先`pull`一下，如果`pull`的时候失败，提示：`fatal: refusing to merge unrelated histories`

那么在进行 `git pull` 时，添加一个可选项
`git pull origin master --allow-unrelated-histories`

有两种方法

#### git remote add 命令

将本地仓库与远程仓库关联起来，再查看一下远程仓库情况

```bash
# 添加第一个仓库
git remote add github git@xxxx1
# 再添加另一个远程仓库
git remote add gitee git@xxxx2
# 查看远程仓库状态
git remote -v
```

查看远程仓库的情况，可以看到已经有两个远程仓库了。
然后再使用相应的命令 push 到对应的仓库就行了。这种方法的缺点是每次要 `push` 两次。

```bash
git  push github master:master
git  push gitee master:master
```

#### git remote set-url 命令

```bash
#删除方法一的 gitee 远程仓库。
git  remote rm gitee
#使用如下命令添加远程仓库。
git remote set-url --add  github git@xxxx2
```

查看远程仓库情况。可以看到 github 远程仓库有两个 push 地址。这种方法的好处是每次只需要 push 一次就行了。

```bash
git remote -v
git push origin master:master
```

另外手动更改本地仓库`/.git/config`文件也是可以的，改成如下格式

```bash
[remote "github"]
   url = git@github.com:xxx
   url = git@gitee.com:xxx
   fetch = +refs/heads/*:refs/remotes/github/*
```

下面介绍命令语法
***

```bash
git remote get-url [--push] [--all] <name>
git remote set-url [--push] <name> <newurl> [<oldurl>]
git remote set-url --add [--push] <name> <newurl>
git remote set-url --delete [--push] <name> <url>
```

为远程仓库设置新的链接,改变远程`<name>`的链接，可以通过给出` <oldurl>`进一步确认。

`--push `，设置push URLs 而不是 fetch URLs
`--add`，不改变已经存在的 URLs，添加新 URL
`--delete`, 不改变已经存在的 URLs, 删除`<name>`上匹配 regex `<url>`的URLs.Trying to delete all non-push URLs is an error.

### 远程分支

***
如果你的当前分支设置了`跟踪远程分支`, 那么可以用 `git pull` 命令来自动抓取后合并该远程分支到当前分支
***
推送工作使用`git push <remote> <branch>`，比如`$ git push origin serverfix`

这里有些工作被简化了。 
Git 自动将 `serverfix` 分支名字展开为 `refs/heads/serverfix:refs/heads/serverfix`， 意味着，推送本地的serverfix 分支来更新远程仓库上的 serverfix 分支。 
我们将会详细学习 Git 内部原理 的 `refs/heads/` 部分， 但是现在可以先把它放在儿。你也可以运行 `git push origin serverfix:serverfix`， 它会做同样的事,  可以通过这种格式来推送本地分支到一个命名不相同的远程分支。 如果并不想让远程仓库上的分支叫做 `serverfix`，可以运行 `git push origin serverfix:awesomebranch` 来将本地的 serverfix 分支推送到远程仓库上的 `awesomebranch` 分支。

使用 `git checkout -b serverfix origin/serverfix`来从设置的远程仓库里创建新分支

这会给你一个用于工作的本地分支，并且起点位于 `origin/serverfix`。

### 跟踪分支

从一个远程跟踪分支`checkout`一个本地分支会自动创建所谓的`跟踪分支`（它跟踪的分支叫做`上游分支`）。 跟踪分支是与远程分支有直接关系的本地分支。
如果在一个跟踪分支上输入 `git pull`，Git 能自动地识别去哪个服务器上抓取、合并到哪个分支。

当克隆一个仓库时，它通常会自动地创建一个跟踪 `origin/master` 的 `master` 分支。 
然而，如果你愿意的话可以设置这个远程库的其他分支，或是一个在其他远程仓库上的分支，又或者不跟踪`master` 分支。 

***
上游快捷方式

当设置好跟踪分支后，可以通过简写 `@{upstream}` 或 `@{u}` 来引用它的上游分支。
所以在 `master` 分支时并且它正在跟踪 `origin/master` 时，如果愿意的话可以使用 `git merge @{u}` 来取代 `git merge origin/master`。

## 删除远程分支

可以运行带有`--delete`选项的`git push`命令

```bash
$ git push origin --delete serverfix
To https://github.com/schacon/simplegit
- [deleted]         serverfix
```

```bash
git push [远程仓库] --delete [branchname]
```

## 创建新分支

`git checkout -b|-B <new_branch> [<start point>]`

指定`-b`选项，将会创建新分支，如同调用`git-branch(1)`，然后`checkout`一样。

在这种情况下，你可以使用`--track` or `--no-track` options，这些选项会传递给`git branch`
为方便起见，`--track` without `-b`意味着创建新分支；见`--track` 的描述

***
`git checkout`:
`-t, --track`

当创建新分支的时候，自动设置上游。
如果`-b` 选项没有给出，本地分支的名字会从`remote-tracking branch`推导。
git先查看本地中远程的`refspec`，然后把前面的初始部分去掉。
也就是说，如果远程名字是`origin/hack` (or `remotes/origin/hack`, or even `refs/remotes/origin/hack`)，
新的本地分支就叫做`hack`，如果查询到的名称中没有“slash”(`/`)，或者上面的猜测得到一个空字符串，那么猜测就会停止，
你可以用`-b`选项手动指定一个名字。

***
`git branch`:
`-t`, `--track`

当创建新分支的时候，设置`branch.<name>.remote`和`branch.<name>.merge`条目，
把`start-point branch`当作`upstream`（上游分支）。

这个配置会告诉git，在`git status` and `git branch -v`命令中显示两个分支的关系。
而且，当切换到新分支的时候，它指导不带参数的`git pull`从上游拉取更新。

如果 `start point` 是`remote-tracking`分支，会默认进行上面的设置。
可以配置变量`branch.autoSetupMerge`为`false`，如果你想让`git checkout` and `git branch`默认行为是`--no-track`，也就是不自动跟踪上游。也可以设置成`always`，这样不管`start-point`是本地还是远程分支，都会自动跟踪。

### 常见使用方法

先运行 `checkout -b` 命令创建新分支

`git checkout -b branchname startpoint`

然后用 `push -u` 命令推送到远程

`git push -u origin <refspec>` 

第一次推送`source`分支的所有内容，并把本地的`source`分支和远程的`destination`分支关联起来

***
`git push`:

`<refspec>...`

`<refspec>`指定用`source object`更新哪一个`destination ref`。
`<refspec> `的格式是：可选的`+`号，接着一个`source object <src>`，然后是`:`，
然后是the `destination ref <dst>`,就是`本地分支:远程分支`的格式，

推送一个空的`<src>`相当于删除远程库中的`<dst> ref`。
特殊的refspec `:` (or `+:` to allow non-fast-forward updates) ，
告诉Git推送匹配的分支：如果远程库里存在和本地名字一样的分支，就把本地分支推送过去。

`--all`
推送所有分支(i.e. `refs/heads/`下面的所有ref)；这时候不要再指定其他特定`<refspec>`。

## git diff

`git-diff` - Show changes between commits, commit and working tree, etc

`commit` 可以用`HEAD~2`的格式，
`HEAD~2`最后的数字`2`指的是显示到倒数第几次，比如`2`指定倒数第二次

### 语法

SYNOPSIS

```git
git diff [<options>] [<commit>] [--] [<path>…​]
git diff [<options>] --cached [<commit>] [--] [<path>…​]
git diff [<options>] <commit> <commit> [--] [<path>…​]
git diff [<options>] <blob> <blob>
git diff [<options>] --no-index [--] <path> <path>
```

***
working tree v.s. stage
`git diff [--options] [--] [<path>...]`

默认相对于`index`(`stage`)的改动。

***
path v.s. path
`git diff --no-index [--options] [--] [<path>...]`

文件系统上的两个`path`，如果其中一个不是`Git`控制的`working tree`，可以不加`--no-index`

***
stage v.s. commit
`git diff [--options] --cached [<commit>] [--] [<path>...]`

比较`staged` and `<commit>`，默认commit 是 HEAD。`--staged` is a synonym of `--cached`.

***
commit v.s. working tree
`git diff [--options] <commit> [--] [<path>...]`

比较 `working tree` 相对于`<commit>`，commit可以是HEAD，也可以是分支名字，就是比较 分支的顶端。

***
commit v.s. commit
`git diff [--options] <commit> <commit> [--] [<path>...]`

比较任意两个 `<commit>`，前一个是base，后一个是改动

***
`git diff [--options] <commit>..<commit> [--] [<path>...]`

跟上一个相同，如果有一边的`<commit>`省略，则相当于`HEAD`

***
`git diff [--options] <commit>...<commit> [--] [<path>...]`

查看变化，从A，B的共同祖先开始，到B为止，"git diff A...B" 等价于`git diff $(git-merge-base A B) B`

You can omit any one of `<commit>`, which has the same effect as using HEAD instead.

为了避免你写的很奇怪，注意所有的`<commit>`，除了最后两个使用`..`记号的，都可以是任何`<tree>`

更完整的关于拼写`<commit>`的方法，见"SPECIFYING REVISIONS" in gitrevisions(7)
然而，`diff`比较的是两个 endpoints，而不是一个范围。
所以 `<commit>..<commit>`and `<commit>...<commit>`在这里指的不是范围。

### checkout 还原文件

```bash
git checkout [<tree-ish>] [--] <pathspec>…​
```

用 **index**或者`<tree-ish>`（通常是一个`commit`）里面的内容替换`working tree`里面的 `paths` 。
当给出一个`<tree-ish>`的时候，the **paths** that match the `<pathspec>`会在**index** and in the **working tree**里面都更新。

index 中可能包含有之前合并失败的entries。默认情况下，如果你想checkout 一个这样的entries，会失败，什么都不会发生。
使用`-f`选项忽略未合并的entries。

The contents from a specific side of the merge can be checked out of the `index` by using `--ours` or `--theirs`.

With `-m`, changes made to the working tree file can be discarded to re-create the original conflicted merge result.

## zsh 定义的 git别名

### short

+ `gst`='git status'
+ `gaa`='git add --all'
+ `gcam`='git commit -a -m'

+ `gco`='git checkout'
+ `gb`='git branch'
+ `gcb`='git checkout -b'

+ `gp`='git push'
+ `gpd`='git push --dry-run'
+ `gpoat`='git push origin --all && git push origin --tags'
+ `ggpull`='git pull origin "$(git_current_branch)"'
+ `gf`='git fetch'
+ `gl`='git pull'

+ `gd`='git diff'
+ `gdw`='git diff --word-diff'

### 查看状态

+ `gss`='git status -s' 
+ `gst`='git status'

`-s` : short

### branch

+ `gb`='git branch'
+ `gbD`='git branch -D'
+ `gba`='git branch -a'
+ `gbd`='git branch -d'
+ `gbr`='git branch --remote'

选项：

+ `-D`: Shortcut for `--delete --force`.
+ `-d, --delete` ;Delete a branch. The branch must be fully merged in its upstream branch, or in `HEAD` if no upstream was set with `--track` or `--set-upstream-to`.
+ `-f, --force`: Reset `<branchname>` to `<startpoint>`, even if `<branchname>` exists already. 
Without `-f`, git branch refuses to change an existing branch.
In combination with `-d` (or `--delete`), allow deleting the branch irrespective of its merged status.
In combination with `-m` (or `--move`), allow renaming the branch even if the new branch           name already exists, the same applies for `-c` (or `--copy`).
+ `-m` `-M`：对分支进行重命名，并且把`reflog`出现的分支名字一并更改。如果新分支已经存在，使用`-M`强迫重命名
+ `-r`,` --remotes` List or delete (if used with `-d`) the remote-tracking branches.

### add

+ `ga`='git add'
+ `gaa`='git add --all'
+ `gapa`='git add --patch'
+ `gau`='git add --update'
+ `gav`='git add --verbose'

选项：

+ `-p`, `--patch`: 交互式地选择更新的内容。能够使用户在增加文件前查看与`index`的不同。
+ `-u`,` --update`: 更新 `index` 中匹配 `working tree`的文件。移除相比`working tree`多余的，但是不会增加新的文件。如果没有给出具体的`<pathspec>`，`working tree`中所有被追踪的文件都会被更新，下同。
+ `-A`,`--all`,`--no-ignore-removal`: 添加，修改，删除`index entries`，使之完全匹配`working tree`.

### commit

+ `gc`='git commit -v'
+ `'gc!'`='git commit -v --amend'
+ `gca`='git commit -v -a'
+ `'gca!'`='git commit -v -a --amend'
+ `gcam`='git commit -a -m'

+ `gcs`='git commit -S'
+ `gcsm`='git commit -s -m'

选项：

+ `-a`, `--all`：自动`stage`所有被修改或删除的文件，但是还没有被Git追踪的文件不受影响。
+ `-v`, `--verbose`: 在提交信息的尾部，展示`HEAD`和将要提交`commit`的`diff`。这个`diff`的输出行没有前置的`#`。并且不是提交信息的一部分。See the commit.verbose configuration variable in git-config(1).
如果使用两次,i.e.`-vv`，则额外展示`working tree`和`next commit`的区别
+ `--amend`：创造一个新的`commit`，代替当前分支的`tip`。提交信息基于上次的`commit`。
+ `-m`: 添加提交信息，可以给出多个`-m`，会被当作多个段落被合并。
+ `-s`,`-S`:签名相关

### checkout cherry-pick

+ `gcb`='git checkout -b'
+ `gco`='git checkout'
+ `gcp`='git cherry-pick'
+ `gcpa`='git cherry-pick --abort'
+ `gcpc`='git cherry-pick --continue'

选项：

+ `git checkout -b|-B <new_branch> [<start point>]`:
指定`-b`选项会创建新分支，如同调用了`git branch`一样，然后check out到新分支一样。
可以使用`--track` or `--no-track`选项，它们会被传递给`git branch`。
为了方便起见，`--track` without `-b`意味着创建新分支。
如果给的是`-B`，新分支会被创建，或者直接`reset`已存在的分支,
相当于`git branch -f <branch> [<start point>] ; git checkout <branch>`

`git-cherry-pick` :从已经存在的一系列`commits`中应用改变

给出一个或者多个已经存在的`commits`，然后`apply`每个的`change`，对于每个改变生成一个`commit`。
需要`working tree`是`clean`的。 (从 HEAD commit 之后没有修改过).

选项:

`--abort`: 取消操作，回复到pre-sequence 状态。
`--continue`: 继续操作，利用`.git/sequencer.`中的信息。可以在`cherry-pick` or `revert`失败，解决冲突之后使用。

### log gitk

***

1. `git-shortlog` - 总结`git log`的输出。

选项:

`-n`, `--numbered`:对输出结果进行排序，按照每个提交者的提交数量，而不是字母顺序。
`-s`, `--summary`: 压缩`commit`描述，只总结`commit`数量。

***

2. `gk`='\gitk --all --branches'
3. `gke`='\gitk --all $(git log -g --pretty=%h)'

`--all`:假装`refs/`下的所有条目，包括`HEAD`都被列出 as `<commit>`
`--branches[=<pattern>]`：类似`--all`，但是要匹配shell `glob`模式，`?`, `*`, or `[`, `/*`
`--tags[=<pattern>]`：类似`--branches`

### remote

`git remote add <shortname> <url>`

+ `gr`='git remote'
+ `gra`='git remote add'
+ `grmv`='git remote rename'
+ `grrm`='git remote remove'
+ `grset`='git remote set-url'
+ `grup`='git remote update'
+ `grv`='git remote -v'

### push

+ `gp`='git push'
+ `gpd`='git push --dry-run'
+ `gpoat`='git push origin --all && git push origin --tags'
+ `'gpf!'`='git push --force'
+ `gpf`='git push --force-with-lease'

选项:

`-n`, `--dry-run`: 模拟运行所有步骤，但不实际发送更新。
`--all`: Push all branches (i.e. refs under `refs/heads/`); cannot be used with other `<refspec>`.
` --prune`: 删除远程分支，如果它没有local对应。
`--force-with-lease` 单独使用,不指定细节，将会保护所有远程分支，如果远程分支的名字和remote-tracking branch 一样才更新。
`-f`, `--force`: 通常，远程分支是本地分支祖先的时候，才会更新，并且名字需要和期望的一样。`-f`选项禁用这些检查，可能会使远程库丢失`commit`，小心使用。

### fetch

+ `gf`='git fetch'
+ `gfa`='git fetch --all --prune'
+ `gfo`='git fetch origin'

选项：

`--all`: Fetch 所有`remote`
`--prune`: Before fetching, remove any remote-tracking references，如果它们在远程上已经不存在。

### pull

+ `ggpull`='git pull origin "$(git_current_branch)"'
+ `gl`='git pull'
+ `gup`='git pull --rebase'

选项：

1.`--all`: fetch all remotes.
2. `-r`,` --rebase[=false|true|preserve|interactive]`:
当设置为`true`时，`rebase`当前分支on top of the upstream branch after fetching.
如果某一`remote-tracking branch`对应的`upstream`在上次`fetch`之后`rebase`过，`rebase`使用那些信息避免`rebase`非本地的改变。

### diff

+ `gd`='git diff'
+ `gdca`='git diff --cached'
+ `gdcw`='git diff --cached --word-diff'
+ `gds`='git diff --staged'
+ `gdw`='git diff --word-diff'

选项：

1. `--color[=<when>]`: 展示着色的diff. 
` --color` (i.e. `without =<when>`) is the same as `-color=always`. 
` <when>` can be one of `always`, `never`, or `auto`

2. `--word-diff[=<mode>]`: Show a word diff, 使用`<mode>`定界改变的`words`。
默认的定界符是`whitespace`,参见下面的`--word-diff-regex`。
`<mode>`默认是`plain`，可以是以下之一：

+ `color`: Highlight changed words using only colors. Implies --color.
+ `plain`: Show words as `[-removed-]` and `{+added+}`。不尝试`escape`定界符号，如果它们出现在input中，所以可能有歧义。
+ `porcelain`: 使用一种特殊的line-based格式for script consumption. 
Added/removed/unchanged runs are printed in the usual unified diff format,
starting with a `+/-/` character at the beginning of the line and extending to the end of the line. Newlines in the input are represented by a tilde `~` on a line of its own.
+ `none`: Disable word diff again.

注意：不管使用哪个模式，都会使用颜色标示改变，如果可用的话。

### others

+ `gpsup`='git push --set-upstream origin $(git_current_branch)'
+ `gpu`='git push upstream'
+ `gpv`='git push -v'
+ `ggpush`='git push origin "$(git_current_branch)"'
+ `gupa`='git pull --rebase --autostash'
+ `gupav`='git pull --rebase --autostash -v'
+ `gupv`='git pull --rebase -v'

+ `gm`='git merge'
+ `gma`='git merge --abort'
+ `gmom`='git merge origin/$(git_main_branch)'
+ `gmt`='git mergetool --no-prompt'
+ `gmtvim`='git mergetool --no-prompt --tool=vimdiff'
+ `gmum`='git merge upstream/$(git_main_branch)'

+ `gpristine`='git reset --hard && git clean -dffx'
+ `grh`='git reset'
+ `grhh`='git reset --hard'
+ `groh`='git reset origin/$(git_current_branch) --hard'
+ `grev`='git revert'
+ `grs`='git restore'

+ `grb`='git rebase'
+ `grba`='git rebase --abort'
+ `grbc`='git rebase --continue'
+ `grbd`='git rebase develop'
+ `grbi`='git rebase -i'
+ `grbm`='git rebase $(git_main_branch)'
+ `grbs`='git rebase --skip'

+ `gr`='git remote'
+ `gra`='git remote add'
+ `grmv`='git remote rename'
+ `grrm`='git remote remove'

+ `gsta`='git stash push'
+ `gstaa`='git stash apply'
+ `gstall`='git stash --all'
+ `gstc`='git stash clear'
+ `gstd`='git stash drop'
+ `gstl`='git stash list'
+ `gstp`='git stash pop'
+ `gsts`='git stash show --text'
+ `gstu`='git stash --include-untracked'

+ `grm`='git rm'
+ `grmc`='git rm --cached'
