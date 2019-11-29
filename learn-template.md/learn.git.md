# Git-Learn

[廖雪峰git教程](https://www.liaoxuefeng.com/wiki/896043488029600)
and
[git-scm.com/book/](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-Git-%E5%88%AB%E5%90%8D)

## alias （别名）

### 配置文件

>配置文件放哪了？每个仓库的Git配置文件都放在.git/config文件中：
>而当前用户的Git配置文件放在用户主目录下的一个隐藏文件.gitconfig中：
>别名就在[alias]后面，要删除别名，直接把对应的行删掉即可。
>配置别名也可以直接修改这个文件，如果改错了，可以删掉文件重新通过命令配置。

### git status git st

`git config --global alias.st status`

### git unstage

>例如，为了解决取消暂存文件的易用性问题，可以向 Git 中添加你自己的取消暂存别名：
>`$ git config --global alias.unstage 'reset HEAD --'`
>这会使下面的两个命令等价：
>`$ git unstage fileA`
>`$ git reset HEAD -- fileA`
>这样看起来更清楚一些。

### git last

>通常也会添加一个 `last` 命令，像这样：
>`$ git config --global alias.last 'log -1 HEAD'`
>这样，可以轻松地看到最后一次提交：

###  logpretty

>甚至还有人丧心病狂地把lg配置成了：

`git config --global alias.logpretty "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"`

## 创建版本库

### 初始化一个git仓库

`git init`

初始化一个git仓库

## 添加修改

###  添加文件 

`git add`

>git add -A 和 git add .   git add -u在功能上看似很相近，但还是存在一点差别

>git add . ：他会监控工作区的状态树，使用它会把工作时的所有变化提交到暂存区，包括文件内容修改(modified)以及新文件(new)，但不包括被删除的文件。

>git add -u ：他仅监控已经被add的文件（即tracked file），他会将被修改的文件提交到暂存区。add -u 不会提交新文件（untracked file）。（git add --update的缩写）

>git add -A ：是上面两个功能的合集（git add --all的缩写）

>[原文链接](https://blog.csdn.net/caseywei/article/details/90945295)

### 提交更改

`git commit -m [comment message]`

### 修改最后一次注释

>如果你只想修改最后一次注释（就是最新的一次提交），
>[那好办](https://www.jianshu.com/p/098d85a58bf1)：

`git commit --amend`

>出现有注释的界面（你的注释应该显示在第一行）， 输入i进入修改模式，修改好注释后，按Esc键 退出编辑模式，输入:wq保存并退出。ok，修改完成。

 

## 时光机穿梭

### git status

要随时掌握工作区的状态

### git diff

>如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容。
>查看和上一版本的具体变动内容 显示内容如下： 

```bash
diff --git a/test.txt b/test.txt 
index 629d9c8..3d98a7f 100644 
--- a/test.txt 
+++ b/test.txt 
@@ -4,8 +4,9 @@ 
test line3.  
test line4.  
test line5.  
test line6. 
-Git is a version control system. 
+Git is a distributed version control system.  
Git is free software.
+Very Good!  
test line7.  
test line8.  
test line9.
```

### git diff 详解

>`diff --git a/test.txt b/test.txt `
>——对比两个文件，其中a改动前，b是改动后，以git的diff格式显示； 

>index 629d9c8..3d98a7f 100644`
>——两个版本的git哈希值，index区域（add之后）的 629d9c8  对象和工作区域的 3d98a7f 对象， 
>100表示普通文件，644表示权限控制；

>`--- a/test.txt`
>`+++ b/test.txt`
>——减号表示变动前，加号表示变动后；

>`@@ -4,8 +4,9 @@ test line3.  
>test line4.  test line5.  test line6.  `
——@@表示文件变动描述合并显示的开始和结束，一般在变动前后多显示3行，
其中-+表示变动前后，逗号前是起始行位置，逗号后为从起始行往后几行。
合起来就是变动前后都是从第4行开始，变动前文件往后数8行对应变动后文件往后数9行。  
变动内容 ——+表示增加了这一行，-表示删除了这一行，没符号表示此行没有变动。

### 查看提交历史

`git log`

>穿梭前，用`git log`可以查看提交历史，以便确定要回退到哪个版本

### 重返未来

`git reflog`

>要重返未来，用git reflog查看命令历史，以便确定要回到未来的哪个版本。

### 丢弃工作区的修改

`git restore file`

###  大恢复

`git reset HEAD file`

> 当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令 `git reset HEAD file`，就回到了场景1，第二步按场景1操作


###  大恢复EXAMPLES

>The following sequence switches to the master branch, reverts the Makefile to two revisions back, deletes hello.c by mistake, and gets it back from the index.

```bash
$ git switch master
$ git restore --source master~2 Makefile  (1)
$ rm -f hello.c
$ git restore hello.c                     (2)
```
1. take a file out of another commit
2. restore hello.c from the index

> If you want to restore all C source files to match the version in the index, you can say

```bahs
$ git restore '*.c'
```

>Note the quotes around *.c. The file hello.c will also be restored, even though it is no longer in the working tree, because the file globbing is used to match entries in the index (not in the working tree by the shell).

> To restore all files in the current directory

```bahs
$ git restore .
```

### 删除一个文件

`git rm`

>命令`git rm`用于删除一个文件。
如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失最近一次提交后你修改的内容。

## 远程仓库

### 添加远程

`git remote add`

>要关联一个远程库，使用命令
>`git remote add origin git@server-name:path/repo-name.git`
>`origin` 是远程仓库的名字

### 查看某个远程仓库

`git remote show [remote-name]` 命令。
`remote-name` 如 `origin`


### 从远程获取信息

`git fetch [remote-name]`

>这个命令会访问远程仓库，从中拉取所有你还没有的数据。 执行完成后，你将会拥有那个远程仓库中所有分支的引用，可以随时合并或查看

>git fetch 命令会将数据拉取到你的本地仓库——它并不会自动合并或修改你当前的工作。 当准备好时你必须手动将其合并入你的工作

>现在 Paul 的 master 分支可以在本地通过 `pb/master` 访问到——你可以将它合并到自己的某个分支中，


### 克隆远程

`git clone`

> 要克隆一个仓库，首先必须知道仓库的地址，然后使用`git clone`命令克隆。

### 推到远程

>当你想分享你的项目时，必须将其推送到上游。 这个命令很简单：

`git push [remote-name] [branch-name]。`
`git push -u origin master`

`-u` == `--set-upstream`

>git push -u origin master第一次推送master分支的所有内容
加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令
此后，每次本地提交后，就可以使用命令`git push origin master`推送最新修改

>只有当你有所克隆服务器的写入权限，并且之前没有人推送过时，这条命令才能生效。 当你和其他人在同一时间克隆，他们先推送到上游然后你再推送到上游，你的推送就会毫无疑问地被拒绝。 你必须先将他们的工作拉取下来并将其合并进你的工作后才能推送

### 强制推送

git push -f origin master
`-f`
`--force`

>Usually, the command refuses to update a remote ref that is not an ancestor of the local ref used to overwrite it. Also, when --force-with-lease option is used, the command refuses to update a remote ref whose current value does not match what is expected.

> This flag disables these checks, and can cause the remote repository to lose commits; use it with care.

### default behavior

>the **current branch** is pushed to the corresponding **upstream branch**, but as a safety measure, the push is aborted if the upstream branch does not have **the same name** as the local one.

>Specify what destination ref to update with what source object. The format of a `<refspec>` parameter is an optional plus +, followed by the source object `<src>`, followed by a colon :, followed by the destination ref `<dst>`.

>The `<src>` is often the name of the branch you would want to push, but it can be any arbitrary "SHA-1 expression", such as `master~4` or `HEAD`

>If git push `[<repository>]` without any`<refspec>` argument is set to update some ref at the destination with `<src>` with remote

`git push origin :`

>Push "matching" branches to origin. See `<refspec>`  in the OPTIONS section above for a 
>description of "matching" branches.

`git push origin master:refs/heads/experimental`

>Create **the branch experimental in the origin** repository by copying the **current master branch**. This form is only needed to create a new branch or tag in the remote repository when the local name and the remote name are different; otherwise, the ref name on its own will work.

### push flag

>A single character indicating the status of the ref:

>`(space)`
for a successfully pushed fast-forward;

>`+`
for a successful forced update;

>`-`
for a successfully deleted ref;

>`*`
for a successfully pushed new ref;

>`!`
for a ref that was rejected or failed to push; and

>`=`
for a ref that was up to date and did not need pushing.


### 拉取远程仓库

`git pull [<options>] [<repository> [<refspec>…]]`

>`<repository>` should be the name of a remote repository as passed to `git-fetch`. 
`<refspec>` can name an arbitrary remote ref (for example, the name of a tag) or even a collection of refs with corresponding remote-tracking branches (e.g., refs/heads/*:refs/remotes/origin/*), 
**but usually it is the name of a branch in the remote repository.**

>More precisely,` git pull` runs git fetch with the given parameters and calls git merge to merge the retrieved branch heads into **the current branch**.

>Default values for `<repository>` and `<branch>` are read from 
>the "remote" and "merge" configuration 
>for the current branch
>as set by `git-branch --track`

`--all`

>Fetch all remotes.

### 远程仓库的移除与重命名

`git remote rename`

>如果想要重命名引用的名字可以运行 git remote rename 去修改一个远程仓库的简写名。 例如，想>要将 pb 重命名为 paul，可以用 git remote rename 这样做：

```bash
$ git remote rename pb paul
$ git remote
origin
paul
```

>值得注意的是这同样也会修改你的远程分支名字。 那些过去引用 pb/master 的现在会引用 
>如果因为一些原因想要移除一个远程仓库——你已经从服务器上搬走了或不再想使用某一个特定的镜像了，又或者某一个贡献者不再贡献了——可以使用 `git remote rm` ：

```bash
$ git remote rm paul
$ git remote
origin
```

### 清理无效远程追踪

> 如果在远程版本库上删除了某一分支，该命令并不会删除本地的远程追踪分支，
> 这时候，有另一个命令

`$ git remote prune`

> 该命令可以删除本地版本库上那些失效的远程追踪分支，具体用法是，假如你的远程版本库名是 origin,则使用如下命令先查看哪些分支需要清理：

`$ git remote prune origin --dry-run`

> 然后执行

`$ git remote prune origin`

> 这样，就完成了无效的远程追踪分支的清理工作。
> 需要注意，这里远程追踪分支批位于

`.git/refs/remote/origin`

> 下的分支，如果有本地分支作为下游存在的话，还需要手动清理

### 远程分支

> 远程跟踪分支是远程分支状态的引用。 它们是你不能移动的本地引用，当你做任何网络通信操作时，它们会自动移动。 远程跟踪分支像是你上次连接到远程仓库时，那些分支所处状态的书签。

### 跟踪分支

`git branch -u origin/serverfix`

>`-u <upstream>`
>`--set-upstream-to=<upstream>`

>Set up `<branchname>`'s tracking information so `<upstream>` is considered `<branchname>`'s upstream branch. If no `<branchname>` is specified, then it defaults to the current branch.


`git checkout -b [branch] [remotename]/[branch]`
`git checkout -b serverfix origin/serverfix`

> 这是一个十分常用的操作所以 Git 提供了 --track 快捷方式

```bash
$ git checkout --track origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
Switched to a new branch 'serverfix'
```

> 你可以在任意时间使用 -u 或 --set-upstream-to 选项运行 git branch 来显式地设置

```bash
$ git branch -u origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
```

`git branch -vv`

>如果想要查看设置的所有跟踪分支，可以使用 git branch 的 -vv 选项

### 删除远程分支

>可以运行带有 --delete 选项的 git push 命令

```bash
$ git push origin --delete serverfix
To https://github.com/schacon/simplegit
- [deleted]         serverfix
```

## 分支管理

>那么，Git 又是怎么知道当前在哪一个分支上呢？ 也很简单，它有一个名为 HEAD 的特殊指针。 请注意它和许多其它版本控制系统（如 Subversion 或 CVS）里的 HEAD 概念完全不同。 在 Git 中，它是一个指针，指向当前所在的本地分支（译注：将 HEAD 想象为当前分支的别名）。 在本例中，你仍然在 master 分支上。 因为 git branch 命令仅仅 创建 一个新分支，并不会自动切换到新分支中去。
>
>由于 Git 的分支实质上仅是包含所指对象校验和（长度为 40 的 SHA-1 值字符串）的文件，所以它的创建和销毁都异常高效。 创建一个新分支就相当于往一个文件中写入 41 个字节（40 个字符和 1 个换行符），如此的简单能不快吗？
>
>这与过去大多数版本控制系统形成了鲜明的对比，它们在创建分支时，将所有的项目文件都复制一遍，并保存到一个特定的目录。 完成这样繁琐的过程通常需要好几秒钟，有时甚至需要好几分钟。所需时间的长短，完全取决于项目的规模。而在 Git 中，任何规模的项目都能在瞬间创建新分支。 同时，由于每次提交都会记录父对象，所以寻找恰当的合并基础（译注：即共同祖先）也是同样的简单和高效。 这些高效的特性使得 Git 鼓励开发人员频繁地创建和使用分支。

### 各种本地分支命令

> Git鼓励大量使用分支：

> 查看分支：`git branch`

> 创建分支：`git branch name`

> 切换分支： `git switch name`

> 新建+切换 到新分支： `git checkout -b branchname`

> 合并某分支到当前分支：`git merge name`

> 删除分支：`git branch -d name`

### 查看分支

`git branch`
`-v`
`-vv`
`-avv`
`--verbose`

>If --list is given, or if there are no non-option arguments, existing branches are listed;
it is in list mode, show sha1 and commit subject line for each head, along with relationship to upstream branch (if any). 
If given twice, print the path of the linked worktree (if any) and the name of the upstream branch, as well (see also git remote show `remote`). 
Note that the current worktree’s HEAD will not have its path printed (it will always be your current directory).

### 创建并切换到分支

`git checkout -b`
`git checkout -b "branchname " "startpoint"`

>The new branch **head**  will point to **this commit**. It may be given as a **branch name**, a **commit-id**, or **a tag**. If this option is omitted, the **current HEAD** will be used instead.

### 解决冲突
> 解决冲突就是把Git合并失败的文件手动编辑为我们希望的内容，再提交。
> 用 `git log --graph` 命令可以看到分支合并图。

### 分支管理策略

> Git分支十分强大，在团队开发中应该充分应用。
> 合并 **临时分支 **到 **feature分支** 后(并删除 **临时分支** )，
> 如果加上了 `--no-ff` 参数就可以用普通模式合并，合并后的 **log** 有分支，能看出来曾经做过合并，
> 而默认的 `fast forward` 合并就看不出来曾经做过合并。

### 快进（fast-forward)

### git tag

`git tag`

列出已有的标签

`git tag -l 'v1.8.5*'`

查找  `'v1.8.5*'` 

### 创建附注标签

> 即完整标签

`git tag -a v1.4 -m "my version 1.4"`

> -m 选项指定了一条将会存储在标签中的信息

`git show v1.4`

> git show 命令可以看到标签信息与对应的提交信息

### 轻量标签

`git tag v1.4-lw`

> 轻量标签本质上是将提交校验和存储到一个文件中——没有保存任何其他信息。 
> 创建轻量标签，不需要使用 -a、-s 或 -m 选项，只需要提供标签名字

### 后期打标签

`git tag -a v1.2 9fceb02`

> 在命令的末尾指定提交的校验和（或部分校验和)

### 推送标签

`git push origin v1.5`
`git push origin [tagname]`
`git push origin --tags`

>默认情况下，git push 命令并不会传送标签到远程仓库服务器上。
>在创建完标签后你必须显式地推送标签到共享服务器上,这个过程就像共享远程分支一样

>如果想要一次性推送很多标签，也可以使用带有 --tags 选项的 git push 命令。 这将会把所有不在远程仓库服务器上的标签全部传送到那里。

```bash
$ git push origin --tags
Counting objects: 1, done.
Writing objects: 100% (1/1), 160 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To git@github.com:schacon/simplegit.git
 * [new tag]         v1.4 -> v1.4
 * [new tag]         v1.4-lw -> v1.4-lw
```
>现在，当其他人从仓库中克隆或拉取，他们也能得到你的那些标签。



### 删除标签

`git tag -d <tagname>`

>for example `$ git tag -d v1.4-lw`
>Deleted tag 'v1.4-lw' (was e7d5add)

`git push <remote> :refs/tags/<tagname>` 

>你必须使用 `git push <remote> :refs/tags/<tagname>` 来更新你的远程仓库：
>`$ git push origin :refs/tags/v1.4-lw`
>`To /git@github.com:schacon/simplegit.git`
>`- [deleted]         v1.4-lw`

### checkout 到某个 标签

>如果你想查看某个标签所指向的文件版本，可以使用 git checkout 命令，虽然说这会使你的仓库处于“分离头指针（detacthed HEAD）”状态——这个状态有些不好的副作用：

```bash
$ git checkout 2.0.0
Note: checking out '2.0.0'.
```

>比如说你正在修复旧版本的错误——这通常需要创建一个新分支：
>
>`$ git checkout -b version2 v2.0.0`
>`Switched to a new branch 'version2'`

## 自定义 git

### 忽略特殊文件

>忽略某些文件时，需要编写.gitignore；
>.gitignore文件本身要放到版本库里，并且可以对.gitignore做版本管理！


