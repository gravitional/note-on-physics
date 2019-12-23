# learn.git.md

reference: [廖雪峰git教程][] and [git-scm-book][]

[廖雪峰git教程]: https://www.liaoxuefeng.com/wiki/896043488029600
[git-scm-book]: https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-Git-%E5%88%AB%E5%90%8D

## 配置文件

配置文件放哪了？每个仓库的`Git`配置文件都放在`.git/config`文件中：
而当前用户的`Git`配置文件放在用户主目录下的一个隐藏文件`.gitconfig`中：
别名就在[alias]后面，要删除别名，直接把对应的行删掉即可。
配置别名也可以直接修改这个文件，如果改错了，可以删掉文件重新通过命令配置。

## alias （别名）

### git status git st

`git config --global alias.st status`

### git unstage

例如，为了解决取消暂存文件的易用性问题，可以向`Git`中添加你自己的取消暂存别名：
`$ git config --global alias.unstage 'reset HEAD --'`
这会使下面的两个命令等价：
`$ git unstage fileA`
`$ git reset HEAD -- fileA`
这样看起来更清楚一些。

### git last

通常也会添加一个 `last` 命令，像这样：
`$ git config --global alias.last 'log -1 HEAD'`
这样，可以轻松地看到最后一次提交：

### logpretty

甚至还有人丧心病狂地把`lg`配置成了：

`git config --global alias.logpretty "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"`

## 初始化一个git仓库

`git init`

初始化一个`git`仓库

## 添加文件

`git add`

`git add -A` 和 `git add .`   `git add -u`
在功能上看似很相近，但还是存在一点差别

`git add .` ：他会监控工作区的状态树，使用它会把工作时的所有变化提交到暂存区，包括文件内容修改(`modified`)以及新文件(`new`)，但不包括被删除的文件。

`git add -u` ：他仅监控已经被`add`的文件（即`tracked file`），他会将被修改的文件提交到暂存区。`add -u` 不会提交新文件（`untracked file`）。（`git add --update`的缩写）

`git add -A` ：是上面两个功能的合集（`git add --all`的缩写）

[原文链接](https://blog.csdn.net/caseywei/article/details/90945295)

## 提交更改

`git commit -m [comment message]`

## 修改注释

[作者：筱湮][]

[作者：筱湮]: https://www.jianshu.com/p/098d85a58bf1

### 修改最后一次注释

如果你只想修改最后一次注释（就是最新的一次提交），

`git commit --amend`

出现有注释的界面（你的注释应该显示在第一行），输入`i`进入修改模式，修改好注释后，按`Esc`键退出编辑模式，输入`:wq`保存并退出。`ok`，修改完成。

### 修改之前的某次注释

[原文地址](https://www.jianshu.com/p/098d85a58bf1)

1. 输入：
`git rebase -i HEAD~2` 最后的数字`2`指的是显示到倒数第几次 比如这个输入的`2`就会显示倒数的两次注释（最上面两行）
1. 你想修改哪条注释 就把哪条注释前面的`pick`换成`edit`。
方法就是上面说的编辑方式：`i---`编辑，把`pick`换成`edit`---`Esc`---`:wq`
1. 然后：（接下来的步骤Terminal会提示）`git commit --amend`
1. 修改注释，保存并退出后，输入：`git rebase --continue`

其实这个原理我的理解就是先版本回退到你想修改的某次版本，然后修改当前的`commit`注释，然后再回到本地最新的版本

### 修改之前的某几次注释

修改多次的注释其实步骤和上面的一样，不同点在于：

1. 你可以将多个想修改的`commit`注释前面的`pick`换成`edit`
2. 依次修改你的注释（顺序是从旧到新），`Terminal`基本都会提示你接下来的操作，每修改一个注释都要重复上面的`3`和`4`步，直到修改完你所选择的所有注释

### 已经将代码push到远程仓库

首先，你把最新的版本从远程仓库先`pull`下来，修改的方法都如上，最后修改完成后，强制`push`到远程仓库：

`git push --force origin master`

注：很重要的一点是，你最好保证在你强制`push`之前没有人提交代码，如果在你`push`之前有人提交了新的代码到远程仓库，然后你又强制`push`，那么会被你的强制更新覆盖！！！

## git status

要随时掌握工作区的状态

## git diff

如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容。
查看和上一版本的具体变动内容 显示内容如下：

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

## git diff 详解

`diff --git a/test.txt b/test.txt`
——对比两个文件，其中`a`改动前，`b`是改动后，以`git`的`diff`格式显示；

`index 629d9c8..3d98a7f 100644`
——两个版本的`git`哈希值，`index`区域（`add`之后）的`629d9c8`对象和工作区域的`3d98a7f`对象，
`100`表示普通文件，`644`表示权限控制；

`--- a/test.txt`
`+++ b/test.txt`
——减号表示变动前，加号表示变动后；

```bash
@@ -4,8 +4,9 @@ test line3.
test line4.  test line5.  test line6.
```

`——@@`表示文件变动描述合并显示的开始和结束，一般在变动前后多显示3行，
其中`-+`表示变动前后，逗号前是起始行位置，逗号后为从起始行往后几行。
合起来就是变动前后都是从第`4`行开始，变动前文件往后数`8`行对应变动后文件往后数`9`行。
变动内容 `+`表示增加了这一行，`-`表示删除了这一行，没符号表示此行没有变动。

## 查看提交历史

`git log`

穿梭时光前，用`git log`可以查看提交历史，以便确定要回退到哪个版本

## 重返未来

`git reflog`

要重返未来，用`git reflog`查看命令历史，以便确定要回到未来的哪个版本。

## 丢弃工作区的修改

`git restore file`

## 大恢复 restore

`git reset HEAD file`

当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令 `git reset HEAD file`，就回到了`场景1`，第二步按`场景1`操作

## 恢复EXAMPLES

To restore all files in the current directory

```bash
git restore .
```

The following sequence switches to the master branch, reverts the Makefile to two revisions back, deletes `hello.c` by mistake, and gets it back from the index.

```bash
git switch master
git restore --source master~2 Makefile  (1)
rm -f hello.c
git restore hello.c                     (2)
```

1. take a file out of another commit
2. restore hello.c from the index

If you want to restore all `C` source files to match the version in the index, you can say

```bash
git restore '*.c'
```

Note the quotes around `*.c` The file `hello.c` will also be restored, even though it is no longer in the working tree, because the file globbing is used to match entries in the index (not in the working tree by the shell).

## 删除一个文件

`git rm`

命令`git rm`用于删除一个文件。
如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失最近一次提交后你修改的内容。

## 添加远程

`git remote add`

要关联一个远程库，使用命令
`git remote add origin git@server-name:path/repo-name.git`
`origin` 是远程仓库的名字

## 查看某个远程仓库

`git remote show [remote-name]` 命令。
`remote-name` 如 `origin`

## 从远程获取信息

`git fetch [remote-name]`

这个命令会访问远程仓库，从中拉取所有你还没有的数据。 执行完成后，你将会拥有那个远程仓库中所有分支的引用，可以随时合并或查看

`git fetch` 命令会将数据拉取到你的本地仓库——它并不会自动合并或修改你当前的工作。 当准备好时你必须手动将其合并入你的工作

现在 `Paul` 的 `master` 分支可以在本地通过 `pb/master` 访问到——你可以将它合并到自己的某个分支中，

## 克隆远程

`git clone`

要克隆一个仓库，首先必须知道仓库的地址，然后使用`git clone`命令克隆。

## 推到远程 push

当你想分享你的项目时，必须将其推送到上游。 这个命令很简单：
for example,

`git push [remote-name] [branch-name]`
`git push -u origin master`

`-u` == `--set-upstream`

`git push -u origin master`第一次推送`master`分支的所有内容
加上了`-u`参数，`Git`不但会把本地的`master`分支内容推送的远程新的`master`分支，还会把本地的`master`分支和远程的`master`分支关联起来，在以后的推送或者拉取时就可以简化命令
此后，每次本地提交后，就可以使用命令`git push origin master`推送最新修改

只有当你有所克隆服务器的写入权限，并且之前没有人推送过时，这条命令才能生效。 当你和其他人在同一时间克隆，他们先推送到上游然后你再推送到上游，你的推送就会毫无疑问地被拒绝。 你必须先将他们的工作拉取下来并将其合并进你的工作后才能推送

syntex:

`git push [-u | --set-upstream] [<repository> [<refspec>… ]]`

For every branch that is up to date or successfully pushed,
add upstream (tracking) reference,
used by argument-less `git-pull`[1] and other commands.
For more information, see `branch.<name>.merge` in git-config[1].

### push 详细语法

```bash
git push
[--all | --mirror | --tags] [--follow-tags] [--atomic]
[-n | --dry-run] [--receive-pack=<git-receive-pack>]
[--repo=<repository>] [-f | --force] [-d | --delete] [--prune]
[-v | --verbose]
[-u | --set-upstream] [-o <string> | --push-option=<string>]
[--[no-]signed|--signed=(true|false|if-asked)]
[--force-with-lease[=<refname>[:<expect>]]]
[--no-verify] [<repository> [<refspec>… ]]
```

the **current branch** is pushed to the corresponding **upstream branch**, but as a safety measure,
the push is aborted if the upstream branch does not have **the same name** as the local one.

Specify what destination ref to update with what source object.
The format of a `<refspec>` parameter is an optional plus `+`,
followed by the source object `<src>`, followed by a colon `:`,
followed by the destination ref `<dst>`.

i.e. `git push origin <src>:<dst>`

The `<src>` is often the name of the branch you would want to push, but it can be any arbitrary "SHA-1 expression", such as `master~4` or `HEAD`
The `<dst>` tells which ref on the remote side is updated with this push.
Arbitrary expressions **cannot** be used here, an actual ref must be named.

If `git push [<repository>]`
without any `<refspec>` argument
is set to update some ref at the destination
with `<src>`
with `remote.<repository>.push` configuration variable,
`:<dst>` part can be omitted
—such a push will update a ref that `<src>` normally updates
without any `<refspec>` on the command line.

Otherwise, missing `:<dst>` means to update the same ref as the `<src>`.

`git push origin :`

Push "matching" branches to origin. See `<refspec>`  in the OPTIONS section above for a
description of "matching" branches.

`git push origin master:refs/heads/experimental`

Create **the branch experimental in the origin** repository by copying the **current master branch**. This form is only needed to create a new branch or tag in the remote repository when the local name and the remote name are different; otherwise, the ref name on its own will work.

### push flag

A single character indicating the status of the ref:

+ `(space)` : for a successfully pushed fast-forward;
+ `+` : for a successful forced update;
+ `-` : for a successfully deleted ref;
+ `*` : for a successfully pushed new ref;
+ `!` : for a ref that was rejected or failed to push; and
+ `=` : for a ref that was up to date and did not need pushing.

### 强制推送

```bash
git push -f origin master
```

`-f`
`--force`

Usually, the command refuses to update a remote ref that is not an ancestor of the local ref used to overwrite it.
Also, when `--force-with-lease` option is used, the command refuses to update a remote ref whose current value does not match what is expected.

This flag disables these checks, and can cause the remote repository to lose commits; use it with care.

## 拉取远程仓库

`git pull [<options>] [<repository> [<refspec>…]]`

`<repository>` should be the name of a remote repository as passed to `git-fetch`.
`<refspec>` can name an arbitrary remote ref (for example, the name of a tag) or even a collection of refs with corresponding remote-tracking branches (e.g., `refs/heads/*:refs/remotes/origin/*`),
**but usually it is the name of a branch in the remote repository.**

More precisely,`git pull` runs git fetch with the given parameters and calls git merge to merge the retrieved branch heads into **the current branch**.

Default values for `<repository>` and `<branch>` are read from
the "remote" and "merge" configuration
for the current branch
as set by `git-branch --track`

`--all` : Fetch all remotes.

## 远程仓库的移除与重命名

`git remote rename`

如果想要重命名引用的名字可以运行 `git remote rename` 去修改一个远程仓库的简写名。
例如，想要将 `pb` 重命名为`paul`，可以用`git remote rename`这样做：

```bash
$ git remote rename pb paul
"no output"
$ git remote
origin
paul
```

值得注意的是这同样也会修改你的远程分支名字。那些过去引用`pb/master` 的现在会引用`paul/master`,
如果因为一些原因想要移除一个远程仓库——你已经从服务器上搬走了或不再想使用某一个特定的镜像了，又或者某一个贡献者不再贡献了——可以使用 `git remote rm` ：

```bash
$ git remote rm paul
"no output"
$ git remote
origin
```

## 清理无效远程追踪

如果在远程版本库上删除了某一分支，该命令并不会删除本地的远程追踪分支，
这时候，有另一个命令

```bash
git remote prune
```

该命令可以删除本地版本库上那些失效的远程追踪分支，具体用法是，假如你的远程版本库名是`origin`,则使用如下命令先查看哪些分支需要清理：

```bash
git remote prune origin --dry-run
```

然后执行

```bash
git remote prune origin
```

这样，就完成了无效的远程追踪分支的清理工作。
需要注意，这里远程追踪分支批位于

```bash
.git/refs/remote/origin
```

下的分支，如果有本地分支作为下游存在的话，还需要手动清理

## 远程分支

远程跟踪分支是远程分支状态的引用。 它们是你不能移动的本地引用，当你做任何网络通信操作时，它们会自动移动。 远程跟踪分支像是你上次连接到远程仓库时，那些分支所处状态的书签。

## 设置跟踪

`--set-upstream` **过时命令**

As this option had confusing syntax, it is no longer supported. Please use `--track` or `--set-upstream-to` instead.

### branch -u

```bash
git branch (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
```

`-u <upstream>`
`--set-upstream-to=<upstream>`

Set up `<branchname>`'s tracking information so `<upstream>` is considered `<branchname>`'s upstream branch. If no `<branchname>`  is specified, then it defaults to the current branch.

你可以在任意时间使用`-u`或`--set-upstream-to`选项运行`git branch`来显式地设置

下文有例子

### 移除上游

syntax:  `branch --unset-upstream [<branchname>]`

Remove the upstream information for `<branchname>`.
If no branch is specified it defaults to the current branch.

### checkout -- track

When you clone a repository, it generally automatically creates a master branch that tracks origin/master. However, you can set up other tracking branches if you wish — ones that track branches on other remotes, or don’t track the master branch. The simple case is the example you just saw, running git checkout -b `<branch> <remote>/<branch>`. This is a common enough operation that Git provides the `--track` shorthand:

```bash
$ git checkout --track origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
Switched to a new branch 'serverfix'
```

In fact, this is so common that there’s even a shortcut for that shortcut. If the branch name you’re trying to checkout (a) doesn’t exist and (b) exactly matches a name on only one remote, Git will create a tracking branch for you:

```bash
$ git checkout serverfix
Branch serverfix set up to track remote branch serverfix from origin.
Switched to a new branch 'serverfix'
```

To set up a local branch with a different name than the remote branch, you can easily use the first version with a different local branch name:

```bash
$ git checkout -b sf origin/serverfix
Branch sf set up to track remote branch serverfix from origin.
Switched to a new branch 'sf'
```

Now, your local branch sf will automatically pull from origin/serverfix

### branch -u example

If you already have a local branch and want to set it to a remote branch you just pulled down, or want to change the upstream branch you’re tracking, you can use the`-u` or `--set-upstream-to` option to git branch to explicitly set it at any time.

```bash
$ git branch -u origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
```

`git branch -vv`

如果想要查看设置的所有跟踪分支，可以使用`git branch`的`-vv`选项

## 删除远程分支

可以运行带有`--delete`选项的`git push`命令

```bash
$ git push origin --delete serverfix
To https://github.com/schacon/simplegit
- [deleted]         serverfix
```

## 分支管理

那么，`Git`又是怎么知道当前在哪一个分支上呢？ 也很简单，它有一个名为`HEAD`的特殊指针。请注意它和许多其它版本控制系统（如`Subversion`或`CVS`）里的 `HEAD` 概念完全不同。 在`Git`中，它是一个指针，指向当前所在的本地分支（译注：将 `HEAD` 想象为当前分支的别名）。在本例中，你仍然在`master`分支上。 因为`git branch`命令仅仅创建一个新分支，并不会自动切换到新分支中去。

由于`Git`的分支实质上仅是包含所指对象校验和（长度为`40`的`SHA-1`值字符串）的文件，所以它的创建和销毁都异常高效。创建一个新分支就相当于往一个文件中写入`41`个字节（`40`个字符和`1`个换行符），如此的简单能不快吗？

这与过去大多数版本控制系统形成了鲜明的对比，它们在创建分支时，将所有的项目文件都复制一遍，并保存到一个特定的目录。完成这样繁琐的过程通常需要好几秒钟，有时甚至需要好几分钟。所需时间的长短，完全取决于项目的规模。而在 `Git` 中，任何规模的项目都能在瞬间创建新分支。同时，由于每次提交都会记录父对象，所以寻找恰当的合并基础（译注：即共同祖先）也是同样的简单和高效。 这些高效的特性使得 `Git` 鼓励开发人员频繁地创建和使用分支。

## 各种本地分支命令

`Git`鼓励大量使用分支：

查看分支：`git branch`

创建分支：`git branch name`

切换分支： `git switch name`

新建+切换 到新分支： `git checkout -b branchname`

合并某分支到当前分支：`git merge name`

删除分支：`git branch -d name`

## 查看分支详情

`git branch`
`-v`
`-vv`
`-avv`
`--verbose`

If --list is given, or if there are no non-option arguments, existing branches are listed;
it is in list mode, show sha1 and commit subject line for each head, along with relationship to upstream branch (if any).
If given twice, print the path of the linked worktree (if any) and the name of the upstream branch, as well (see also git remote show `remote`).
Note that the current worktree’s `HEAD` will not have its path printed (it will always be your current directory).

## 创建并切换到分支

`git checkout -b`
`git checkout -b "branchname " "startpoint"`

The new branch **head**  will point to **this commit**. It may be given as a **branch name**, a **commit-id**, or **a tag**.
If this option is omitted, the **current HEAD** will be used instead.

`git branch [--track | --no-track] [-f] <branchname> [<start-point>]`
`-t`
`--track`

When creating a new branch, set up branch.`<name>.remote` and `branch.<name>.merge` configuration entries to mark the start-point branch as "upstream" from the new branch. This configuration will tell git to show the relationship between the two branches in `git status` and `git branch -v`. Furthermore, it directs git pull without arguments to pull from the upstream when the new branch is checked out.

This behavior is the default when the start point is a remote-tracking branch. Set the `branch.autoSetupMerge` configuration variable to `false` if you want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track` were given. Set it to `always` if you want this behavior when the start-point is either a local or remote-tracking branch.

## 重命名git分支名称

1. `git branch -m` 要改的本地分支名 修改后的分支名(修改本地分支)
1. `git push origin` :远程修改前的分支名（删除远程分支）
1. `git push origin` 修改后的分支名:远程分支名（`push`到远程分支）
1. `git branch -u  origin/修改后的分支名`绑定远程分支

## 解决冲突

解决冲突就是把`Git`合并失败的文件手动编辑为我们希望的内容，再提交。
用 `git log --graph` 命令可以看到分支合并图。

## 分支管理策略

`Git`分支十分强大，在团队开发中应该充分应用。
合并 **临时分支**到 **feature分支** 后(并删除 **临时分支** )，
如果加上了 `--no-ff` 参数就可以用普通模式合并，合并后的 **log** 有分支，能看出来曾经做过合并，
而默认的 `fast forward` 合并就看不出来曾经做过合并。

## git tag

`git tag`  列出已有的标签

`git tag -l 'v1.8.5*'` 查找  `'v1.8.5*'`

### 创建附注标签

即完整标签

```bash
git tag -a v1.4 -m "my version 1.4"
```

`-m` 选项指定了一条将会存储在标签中的信息

```bash
git show v1.4
```

`git show`命令可以看到标签信息与对应的提交信息

### 轻量标签

```bash
git tag v1.4-lw
```

轻量标签本质上是提交`校验和`, 将其存储到一个文件中——没有保存任何其他信息。  
创建轻量标签，不需要使用 `-a、-s` 或 `-m` 选项，只需要提供标签名字

### 后期打标签

`git tag -a v1.2 9fceb02`

在命令的末尾指定提交的校验和（或部分校验和)

### 推送标签

`git push origin v1.5`
`git push origin [tagname]`
`git push origin --tags`

默认情况下，`git push`命令并不会传送标签到远程仓库服务器上。
在创建完标签后你必须显式地推送标签到共享服务器上,这个过程就像共享`远程分支`一样

如果想要一次性推送很多标签，也可以使用带有`--tags`选项的`git push`命令。 这将会把所有不在远程仓库服务器上的标签全部传送到那里。

```bash
$ git push origin --tags
Counting objects: 1, done.
Writing objects: 100% (1/1), 160 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To git@github.com:schacon/simplegit.git
 * [new tag]         v1.4 -> v1.4
 * [new tag]         v1.4-lw -> v1.4-lw
```

现在，当其他人从仓库中克隆或拉取，他们也能得到你的那些标签。

### 删除标签

```bash
git tag -d <tagname>
```

for example `$ git tag -d v1.4-lw`
Deleted tag 'v1.4-lw' (was e7d5add)

```bash
git push <remote> :refs/tags/<tagname>
```

你必须使用 `git push <remote> :refs/tags/<tagname>` 来更新你的远程仓库：
`$ git push origin :refs/tags/v1.4-lw`
`To /git@github.com:schacon/simplegit.git`
`- [deleted]         v1.4-lw`

### checkout 到某个 标签

如果你想查看某个标签所指向的文件版本，可以使用`git checkout`命令，虽然说这会使你的仓库处于“分离头指针（`detacthed HEAD`）”状态——这个状态有些不好的副作用：

```bash
$ git checkout 2.0.0
Note: checking out '2.0.0'.
```

比如说你正在修复旧版本的错误——这通常需要创建一个新分支：

`$ git checkout -b version2 v2.0.0`
`Switched to a new branch 'version2'`

## 储藏 stash

`stash`
`stash list`
`git stash apply`
`stash drop`
`stash pop`

当工作只进行到一半，还没法提交，预计完成还需1天时间。但是，必须在两个小时内修复该bug，怎么办？
幸好，`Git`还提供了一个`stash`功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作：

```bash
$ git stash
Saved working directory and index state WIP on dev: f52c633 add merge
```

现在，用`git status`查看工作区，就是干净的（除非有没有被`Git`管理的文件），因此可以放心地创建分支来修复bug。

太棒了，原计划两个小时的bug修复只花了5分钟！现在，是时候接着回到`dev`分支干活了！

```bash
$ git checkout dev
Switched to branch 'dev'

$ git status
On branch dev
nothing to commit, working tree clean
```

工作区是干净的，刚才的工作现场存到哪去了？

用`git stash list`命令看看：

```bash
$ git stash list
stash@{0}: WIP on dev: f52c633 add merge
```

工作现场还在，`Git`把`stash`内容存在某个地方了，但是需要恢复一下，有两个办法：

一是用`git stash apply`恢复，但是恢复后，`stash`内容并不删除，你需要用`git stash drop`来删除；

另一种方式是用`git stash pop`，恢复的同时把`stash`内容也删了

## rebase 变基

在`Git`中整合来自不同分支的修改主要有两种方法：`merge`以及`rebase`

reference: [scm tutorial][]

[scm tutorial]: https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%8F%98%E5%9F%BA#rrbdiag_g

### 变基的风险

呃，奇妙的变基也并非完美无缺，要用它得遵守一条准则：

不要对在你的仓库外有副本的分支执行变基。

如果你遵循这条金科玉律，就不会出差错。 否则，人民群众会仇恨你，你的朋友和家人也会嘲笑你，唾弃你。

变基操作的实质是丢弃一些现有的提交，然后相应地新建一些内容一样但实际上不同的提交。 如果你已经将提交推送至某个仓库，而其他人也已经从该仓库拉取提交并进行了后续工作，此时，如果你用 `git rebase`命令重新整理了提交并再次推送，你的同伴因此将不得不再次将他们手头的工作与你的提交进行整合，如果接下来你还要拉取并整合他们修改过的提交，事情就会变得一团糟。

我自己理解的变基就是：

1. 先寻找一个命令参数中提到的 **提交** 使用的共同 **父节点**，
2. 计算所有在 **父节点** 之后各次 **提交** 进行的所有更改，然后按照 `git rebase` 命令的安排，
    把它们依次播放/运用/apply，
3. 然后重新生成各次提交，新生成的提交就按照我们希望的那样排列了

### scm-book 例子 1

在上面这个例子中，运行：

```bash
$ git checkout experiment
"no output"
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: added staged command
```

它的原理是首先找到这两个分支（即当前分支 `experiment`、变基操作的目标基底分支 `master`）的最近共同祖先 `C2`，然后对比当前分支相对于该祖先的历次提交，提取相应的修改并存为临时文件，然后将当前分支指向目标基底 `C3`, 最后以此将之前另存为临时文件的修改依序应用

### scm-book 例子 2

假设你希望将 `client` 中的修改合并到主分支并发布，但暂时并不想合并 `server` 中的修改，因为它们还需要经过更全面的测试。 这时，你就可以使用 `git rebase` 命令的 `--onto` 选项，选中在 `client` 分支里但不在 `server` 分支里的修改（即 `C8` 和 `C9`），将它们在 `master` 分支上重放：

```bash
git rebase --onto master server client
```

以上命令的意思是：
“取出 `client` 分支，
找出处于 `client` 分支和 `server`  分支的共同祖先之后的修改，
然后把它们在 `master` 分支上重放一遍”。
这理解起来有一点复杂，不过效果非常酷。

即

```bash
git rebase --onto master[被施加重放的分支] server[父节点/修改起始点 参考分支] client[提取重放内容的分支]
```

## 自定义 git

### 忽略特殊文件

忽略某些文件时，需要编写`.gitignore`；
`.gitignore`文件本身要放到版本库里，并且可以对`.gitignore`做版本管理！
