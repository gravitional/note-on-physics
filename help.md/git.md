# learn.git.md

reference: [廖雪峰git教程][] and [git-scm-book][]

[廖雪峰git教程]: https://www.liaoxuefeng.com/wiki/896043488029600
[git-scm-book]: https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-Git-%E5%88%AB%E5%90%8D

## SSH配置

第1步：创建`SSH Key`。
在用户主目录下，看看有没有`.ssh`目录，如果有，再看看这个目录下有没有`id_rsa`和`id_rsa.pub`这两个文件，如果已经有了，可直接跳到下一步。如果没有，打开`Shell`（ `Windows`下打开`Git Bash`），创建`SSH Key`：

```bash
$ ssh-keygen -t rsa -C "youremail@example.com"
"nothing"
```

你需要把邮件地址换成你自己的邮件地址，然后一路回车，使用默认值即可，由于这个`Key`也不是用于军事目的，所以也无需设置密码。
如果一切顺利的话，可以在用户主目录里找到`.ssh`目录，里面有`id_rsa`和`id_rsa.pub`两个文件，这两个就是`SSH Key`的秘钥对，`id_rsa`是私钥，不能泄露出去，`id_rsa.pub`是公钥，可以放心地告诉任何人。

第2步：登陆`GitHub`，打开“`Account settings`”，“`SSH Keys`”页面：

然后，点“`Add SSH Key`”，填上任意`Title`，在`Key`文本框里粘贴`id_rsa.pub`文件的内容：

### SSH警告

当你第一次使用`Git`的`clone`或者`push`命令连接`GitHub`时，会得到一个警告：

```bash
The authenticity of host 'github.com (xx.xx.xx.xx)' can't be established.
RSA key fingerprint is xx.xx.xx.xx.xx.
Are you sure you want to continue connecting (yes/no)?
```

这是因为`Git`使用`SSH`连接，而`SSH`连接在第一次验证`GitHub`服务器的`Key`时，需要你确认`GitHub`的`Key`的指纹信息是否真的来自`GitHub`的服务器，输入`yes`回车即可。
`Git`会输出一个警告，告诉你已经把`GitHub`的`Key`添加到本机的一个信任列表里了：

```bash
Warning: Permanently added 'github.com' (RSA) to the list of known hosts.
```

这个警告只会出现一次，后面的操作就不会有任何警告了。
如果你实在担心有人冒充`GitHub`服务器，输入`yes`前可以对照`GitHub`的`RSA Key`的指纹信息是否与`SSH`连接给出的一致。

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

## basics

### 初始化一个git仓库

`git init`

初始化一个`git`仓库

### 添加文件

`git add`

`git add -A` 和 `git add .`   `git add -u`
在功能上看似很相近，但还是存在一点差别

`git add .` ：他会监控工作区的状态树，使用它会把工作时的所有变化提交到`stage`，包括文件内容修改(`modified`)以及新文件(`new`)，但不包括被删除的文件。

`git add -u` ：他仅监控已经被`add`的文件（即`tracked file`），他会将被修改的文件提交到`stage`。`add -u` 不会提交新文件（`untracked file`）。（`git add --update`的缩写）

`git add -A` ：是上面两个功能的合集（`git add --all`的缩写）

[原文链接](https://blog.csdn.net/caseywei/article/details/90945295)

### 提交更改

`git commit -m [comment message]`

### 修改注释

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

### git status

要随时掌握工作区的状态

### 比较差别 git diff

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

### git diff 输出说明

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

### git diff 用法

`git-diff` - Show changes between commits, commit and working tree, etc

SYNOPSIS

```git
git diff [<options>] [<commit>] [--] [<path>…​]
git diff [<options>] --cached [<commit>] [--] [<path>…​]
git diff [<options>] <commit> <commit> [--] [<path>…​]
git diff [<options>] <blob> <blob>
git diff [<options>] --no-index [--] <path> <path>
```

DESCRIPTION

Show:

+ changes between the `working tree` and the `index` or a `tree`,
+ changes between the `index` and `a tree`,
+ changes between two trees,
+ changes between two `blob` objects,
+ changes between two `files` on disk.

use as:

| SYNOPSIS | explanation |
| ---- | ---- |
| `git diff [<options>] [--] [<path>…​]` | `working tree` and the `index` |
| `git diff [<options>] --no-index [--] <path> <path>` | two paths on the filesystem |
| `git diff [<options>] --cached [<commit>] [--] [<path>…​]` | changes you staged relative to the named `<commit>` |
| `git diff [<options>] <commit> [--] [<path>…​]` | changes in your working tree relative to the named `<commit>` |
| `git diff [<options>] <commit> <commit> [--] [<path>…​]` | changes between two arbitrary `<commit>` |
| `git diff [<options>] <commit>..<commit> [--] [<path>…​]` | This is synonymous to the previous form |

### the details

```git
git diff [<options>] [--] [<path>…​]
```

This form is to view the changes you made relative to the `index` (staging area for the next commit).
In other words, the differences are what you could tell `Git` to further add to the index but you still haven’t. You can stage these changes by using `git-add`.

```git
git diff [<options>] --no-index [--] <path> <path>
```

This form is to compare the given two paths on the filesystem.
You can omit the `--no-index` option when running the command in a working tree controlled by Git and at least one of the paths points outside the working tree,
or when running the command outside a working tree controlled by Git.

```bash
git diff [<options>] --cached [<commit>] [--] [<path>…​]
```

This form is to view the changes you staged for the next `commit` relative to the named `<commit>`.
Typically you would want comparison with the latest commit, so if you do not give `<commit>`, it defaults to `HEAD`.
If `HEAD` does not exist (e.g. unborn branches) and `<commit>` is not given, it shows all staged changes. `--staged` is a synonym( 同义词:) of `--cached`.

```git
git diff [<options>] <commit> [--] [<path>…​]
```

This form is to view the changes you have in your working tree relative to the named `<commit>`.
You can use `HEAD` to compare it with the latest commit, or a `branch name` to compare with the tip(尖端；尖儿；端) of a different branch.

```git
git diff [<options>] <commit> <commit> [--] [<path>…​]
```

This is to view the changes between two arbitrary `<commit>`.

```git
git diff [<options>] <commit>..<commit> [--] [<path>…​]
```

This is synonymous to the previous form. If `<commit>` on one side is omitted, it will have the same effect as using `HEAD` instead.

```git
git diff [<options>] <commit>...<commit> [--] [<path>…​]
```

This form is to view

+ the changes on the branch
+ containing and up to the second `<commit>`,
+ starting at a common ancestor of both `<commit>`.

"`git diff A...B`" is equivalent to "`git diff $(git merge-base A B) B`".
You can omit any one of `<commit>`, which has the same effect as using `HEAD` instead.

Just in case you are doing something exotic(来自异国(尤指热带国家)的；奇异的；异国情调的；异国风味的), it should be noted that all of the `<commit>` in the above description, except in the last two forms that use ".." notations, can be any `<tree>`.

For a more complete list of ways to spell `<commit>`, see "SPECIFYING REVISIONS( (一项、一轮等)修订,修改)" section in gitrevisions.

However, "`diff`" is about comparing two `endpoints`, not `ranges`, and the range notations ("`<commit>..<commit>`" and "`<commit>...<commit>`") do not mean a range as defined in the "SPECIFYING RANGES" section in gitrevisions.

```bash
git diff [<options>] <blob> <blob>
```

This form is to view the differences between the raw contents of two blob objects.

### log 查看提交历史

`git log`

穿梭时光前，用`git log`可以查看提交历史，以便确定要回退到哪个版本

```bash
-<number>
-n <number>
--max-count=<number>
```

Limit the number of commits to output.

```bash
--skip=<number>
```

Skip number commits before starting to show the commit output.

```bash
--since=<date>
--after=<date>
```

Show commits more recent than a specific date.

--until=<date>
--before=<date>

```bash
Show commits older than a specific date.
```

```bash
--author=<pattern>
--committer=<pattern>
```

Limit the commits output to ones with author/committer header lines that match the specified pattern (regular expression). With more than one --author=<pattern>, commits whose author matches any of the given patterns are chosen (similarly for multiple --committer=<pattern>).

```bash
--grep-reflog=<pattern>
```

Limit the commits output to ones with reflog entries that match the specified pattern (regular expression). With more than one --grep-reflog, commits whose reflog message matches any of the given patterns are chosen. It is an error to use this option unless --walk-reflogs is in use.

```bash
--grep=<pattern>
```

Limit the commits output to ones with log message that matches the specified pattern (regular expression). With more than one --grep=<pattern>, commits whose message matches any of the given patterns are chosen (but see --all-match).

When --show-notes is in effect, the message from the notes is matched as if it were part of the log message.

```bash
-<!-- markdownlint-capture -->all-match
```

Limit the commits output to ones that match all given --grep, instead of ones that match at least one.

```bash
--invert-grep
```

Limit the commits output to ones with log message that do not match the pattern specified with --grep=<pattern>.

```bash
-i
--regexp-ignore-case
```

Match the regular expression limiting patterns without regard to letter case.

```bash
--basic-regexp
```

 Consider the limiting patterns to be basic regular expressions; this is the default.

### 查看本地+远程所有分支的全部提交以及关系

[git查看本地+远程所有分支的全部提交以及关系][]

[git查看本地+远程所有分支的全部提交以及关系]: https://blog.csdn.net/wq6ylg08/article/details/89052225

当我们深入学习Git后，我们不仅在本地仓库有超多的分支，
还在远程仓库有超多的分支，如果我们只使用`git log`和`gitk`命令，我们会发现这两个命令只能显示当前所处分支的全部提交记录，并不能查看本地+远程所有分支的全部提交记录。

解决方案是我们采用git log和gitk命令的升级版

+ `git log --graph --all`
+ `gitk --all`

`gitk --all`是真实的画出本地+远程所有分支的全部提交的树状结构，看起来更全面。
强烈推荐以后查看整个项目的所有分支情况，使用这个命令`gitk --all`

## git 文件管理

`git reflog`

要重返未来，用`git reflog`查看命令历史，以便确定要回到未来的哪个版本。

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

### git revert

`git-revert` - 回复某些已经存在的提交

SYNOPSIS

+ `git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...`
+ `git revert --continue`
+ `git revert --quit`
+ `git revert --abort`

DESCRIPTION

给出一个或者多个提交，逆转相关的`patches` 引入的更改。并生成新的提交来记录这个操作。
前提是你的 `working tree` 是 `clean` 的(no modifications from the HEAD commit).

`git revert `用来记录撤销提交的操作（通常是错误的提交）。
如果只是想丢弃工作区的修改，可以使用`git-reset --hard`，或者用`git checkout <commit>  -- <filename>`从别的提交中提取文件（覆盖当前版本），不同于`git revert`，这些操作都会导致工作区未提交的更改丢失。

相比`git reset`，它不会改变现在的提交历史。因此，`git revert`可以用在公共分支上，`git reset`应该用在私有分支上。

[git reset --hard xxx、git reset --soft 及git revert 的区别]: https://www.jianshu.com/p/8be0cc35e672

[Git Reset 三种模式]: https://www.jianshu.com/p/c2ec5f06cf1a

### 恢复EXAMPLES

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

### 删除一个文件

`git rm`

命令`git rm`用于删除一个文件。
如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失最近一次提交后你修改的内容。

### checkout还原文件

```bash
git checkout [<tree-ish>] [--] <pathspec>…​
```

用 **index**或者`<tree-ish>`（通常是一个`commit`）里面的内容替换`working tree`里面的 paths。

当给出一个`<tree-ish>`的时候，the **paths** that match the `<pathspec>`会在**index** and in the **working tree**里面都更新。

`index `中可能包含有之前合并失败的`entries`。默认情况下，如果你想checkout 一个这样的`entries`，会失败，什么都不会发生。
使用`-f`选项忽略未合并的`entries`。

可以选择`merge`的特定一方的内容，使用选项`--ours` or `--theirs`.

使用`-m`选项，可以抛弃对`working tree`的更改，恢复到 the original conflicted merge result

## 分支管理

那么，`Git`又是怎么知道当前在哪一个分支上呢？ 也很简单，它有一个名为`HEAD`的特殊指针。请注意它和许多其它版本控制系统（如`Subversion`或`CVS`）里的 `HEAD` 概念完全不同。 在`Git`中，它是一个指针，指向当前所在的本地分支（译注：将 `HEAD` 想象为当前分支的别名）。在本例中，你仍然在`master`分支上。 因为`git branch`命令仅仅创建一个新分支，并不会自动切换到新分支中去。

由于`Git`的分支实质上仅是包含所指对象校验和（长度为`40`的`SHA-1`值字符串）的文件，所以它的创建和销毁都异常高效。创建一个新分支就相当于往一个文件中写入`41`个字节（`40`个字符和`1`个换行符），如此的简单能不快吗？

这与过去大多数版本控制系统形成了鲜明的对比，它们在创建分支时，将所有的项目文件都复制一遍，并保存到一个特定的目录。完成这样繁琐的过程通常需要好几秒钟，有时甚至需要好几分钟。所需时间的长短，完全取决于项目的规模。而在 `Git` 中，任何规模的项目都能在瞬间创建新分支。同时，由于每次提交都会记录父对象，所以寻找恰当的合并基础（译注：即共同祖先）也是同样的简单和高效。 这些高效的特性使得 `Git` 鼓励开发人员频繁地创建和使用分支。

### 各种本地分支命令

`Git`鼓励大量使用分支：

查看分支：`git branch`

`git br -a`
`git br -vv`
`git br -avv`

创建分支：`git branch name`

切换分支： `git switch name`

新建+切换 到新分支： `git checkout -b branchname`

合并某分支到当前分支：`git merge name`

删除分支：`git branch -d name`

### 创建分支

```bash
git branch [--track | --no-track] [-f] <branchname> [<start-point>]
```

The command’s above form creates a new branch head named `<branchname>` which points to the current HEAD, or `<start-point>` if given.
As a special case, for `<start-point>`, you may use "`A...B`" as a shortcut for the merge base of A and B if there is exactly one merge base.
You can leave out at most one of A and B, in which case it defaults to `HEAD`.

也可以用checkout 的特殊语法

`git checkout -b`
`git checkout -b "branchname " "startpoint"`

### 删除远程分支

可以运行带有`--delete`选项的`git push`命令

```bash
$ git push origin --delete serverfix
To https://github.com/schacon/simplegit
- [deleted]         serverfix
```

```bash
git push [远程仓库] --delete [branchname]
```

或者用

```bash
git push origin :分支名
```

例如删除远程分支`dev`，命令：`git push origin :dev`，注意`:`前的空格

### 查看分支详情

`git branch`
`-v`
`-vv`
`-avv`
`--verbose`

If --list is given, or if there are no non-option arguments, existing branches are listed;
it is in list mode, show sha1 and commit subject line for each head, along with relationship to upstream branch (if any).
If given twice, print the path of the linked worktree (if any) and the name of the upstream branch, as well (see also git remote show `remote`).
Note that the current worktree’s `HEAD` will not have its path printed (it will always be your current directory).

### 创建并切换到分支

`git checkout -b`
`git checkout -b "branchname " "startpoint"`

The new branch **head**  will point to **this commit**. It may be given as a **branch name**, a **commit-id**, or **a tag**.
If this option is omitted, the **current HEAD** will be used instead.

`git branch [--track | --no-track] [-f] <branchname> [<start-point>]`
`-t`
`--track`

当创建一个新分支的时候，设置 `branch.<name>.remote` and `branch.<name>.merge`项目来标记新分支的“上游”。
这个设置会告诉git如何在 `git status` and `git branch -v`显示两个分支的关系
此外，切换到新分支时，不带参数的`git pull`将从上游拉取更新

When creating a new branch, set up `branch.<name>.remote` and `branch.<name>.merge` configuration entries to mark the start-point branch as "upstream" from the new branch. This configuration will tell git to show the relationship between the two branches in `git status` and `git branch -v`.
Furthermore, it directs git pull without arguments to pull from the upstream when the new branch is checked out.

This behavior is the default when the start point is a remote-tracking branch.
Set the `branch.autoSetupMerge` configuration variable to `false` if you want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track` were given.
Set it to `always` if you want this behavior when the start-point is either a local or remote-tracking branch.

### 重命名git分支名称

1. `git branch -m local_oldbranch local_newbranch`(修改本地分支)
2. `git push origin :remote_branch`（删除远程分支）
3. `git push origin local_newbranch:remote_branch`（push到远程分支）
4. `git branch -u  origin/remote_branch`绑定远程分支

### merge-file 合并文件

`git-merge-file` - Run a three-way file merge

### 修改提交历史

reset是用来修改提交历史的，想象这种情况，如果你在`2`天前提交了一个东西，突然发现这次提交是有问题的。

这个时候你有两个选择，要么使用`git revert`（推荐），要么使用git reset。

[git的reset和checkout的区别][]

[git的reset和checkout的区别]: https://segmentfault.com/a/1190000006185954

### 借用其他分支的文件

经常被问到如何从一个分支合并特定的文件到另一个分支。
其实，只合并你需要的那些commits，不需要的commits就不合并进去了。

#### 合并单个commit

合并某个分支上的单个commit

首先，用`git log`或`sourcetree`工具查看一下你想选择哪些`commits`进行合并，例如：

比如`feature` 分支上的`commit 82ecb31` 非常重要，它含有一个`bug`的修改，或其他人想访问的内容。
无论什么原因，你现在只需要将`82ecb31` 合并到`master`，而不合并`feature`上的其他`commits`，所以我们用`git cherry-pick`命令来做：

```bash
git checkout master
git cherry-pick 82ecb31
```

这样就好啦。现在`82ecb31`就被合并到`master`分支，并在`master`中添加了`commit`（作为一个新的`commit`）。
`cherry-pick` 和`merge`比较类似，如果git不能合并代码改动（比如遇到合并冲突），git需要你自己来解决冲突并手动添加commit。

这里`git cherry-pick`每次合并过来会显示文件冲突(其实并没有冲突代码部分，只需手动解决既可)

#### 合并一系列commits

合并某个分支上的一系列commits

在一些特性情况下，合并单个commit并不够，你需要合并一系列相连的commits。这种情况下就不要选择`cherry-pick`了，`rebase` 更适合。
还以上例为例，假设你需要合并`feature`分支的`commit 76cada ~62ecb3` 到`master`分支。

首先需要基于`feature`创建一个新的分支，并指明新分支的最后一个`commit`：

```bash
git checkout featuregit
git checkout -b newbranch 62ecb3
```

然后，rebase这个新分支的`commit`到`master`（`--ontomaster`）。
`76cada^` 指明你想从哪个特定的commit开始。

```bash
git rebase --ontomaster 76cada^
```

得到的结果就是`feature`分支的`commit 76cada ~62ecb3` 都被合并到了master分支。

#### 合并某个文件

另外如果只想将master分支的某个文件`f.txt`合并到feature分支上。

```bash
1: git checkout feature
2: git checkout --patch master f.txt
```

第一个命令： 切换到feature分支；
第二个命令：合并master分支上`f`文件到`feature`分支上，
将`master`分支上 `f` 文件追加补丁到`feature`分支上的`f`文件。
你可以接受或者拒绝补丁内容。

如果只是简单的将`feature`分支的文件`f.txt` copy到`master`分支上；

```bash
git checkout master
git checkout feature f.txt
```

[Git合并指定文件到另一个分支][]

[Git合并指定文件到另一个分支]: https://www.cnblogs.com/yanglang/p/11436304.html

## 远程分支

远程跟踪分支是远程分支状态的引用。 它们是你不能移动的本地引用，当你做任何网络通信操作时，它们会自动移动。 远程跟踪分支像是你上次连接到远程仓库时，那些分支所处状态的书签。

+ 克隆远程

`git clone`

要克隆一个仓库，首先必须知道仓库的地址，然后使用`git clone`命令克隆。

+ 添加远程

`git remote add`

要关联一个远程库，使用命令
`git remote add origin git@server-name:path/repo-name.git`
`origin` 是远程仓库的名字

+ 查看某个远程仓库

`git remote show [remote-name]` 命令。
`remote-name` 如 `origin`

+ 从远程获取更新

`git fetch [remote-name]`

这个命令会访问远程仓库，从中拉取所有你还没有的数据。 执行完成后，你将会拥有那个远程仓库中所有分支的引用，可以随时合并或查看

`git fetch` 命令会将数据拉取到你的本地仓库——它并不会自动合并或修改你当前的工作。 当准备好时你必须手动将其合并入你的工作

现在 `Paul` 的 `master` 分支可以在本地通过 `pb/master` 访问到——你可以将它合并到自己的某个分支中，

+ 删除远程分支

可以运行带有`--delete`选项的`git push`命令

```bash
$ git push origin --delete serverfix
To https://github.com/schacon/simplegit
- [deleted]         serverfix
```

```bash
git push [远程仓库] --delete [branchname]
```

或者用

```bash
git push origin :分支名
```

例如删除远程分支`dev`，命令：`git push origin :dev`，注意`:`前的空格

### 设置跟踪/上游

`--set-upstream` **过时命令**

As this option had confusing syntax, it is no longer supported. Please use `--track` or `--set-upstream-to` instead.

`branch -u`

```bash
git branch (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
```

`-u <upstream>`
`--set-upstream-to=<upstream>`

`<branchname>` 指的是想要设置上游的本地branchname

Set up `<branchname>`'s tracking information so `<upstream>` is considered `<branchname>`'s upstream branch.
If no `<branchname>`  is specified, then it defaults to the current branch.

你可以在任意时间使用`-u`或`--set-upstream-to`选项运行`git branch`来显式地设置

例

```bash
$ git branch -u origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
```

### 移除upstream/上游

syntax:  `branch --unset-upstream [<branchname>]`

Remove the upstream information for `<branchname>`.
If no branch is specified it defaults to the current branch.

### checkout -- track

When you clone a repository, it generally automatically creates a master branch that tracks `origin/master`.
However, you can set up other tracking branches if you wish — ones that track branches on other remotes, or don't track the `master` branch.
The simple case is the example you just saw, running `git checkout -b` `<branch> <remote>/<branch>`. This is a common enough operation that Git provides the `--track` shorthand:

```bash
$ git checkout --track origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
Switched to a new branch 'serverfix'
```

In fact, this is so common that there's even a shortcut for that shortcut.
If the branch name you're trying to checkout
(a) doesn't exist and
(b) exactly matches a name on only one remote,
Git will create a tracking branch for you:

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

### push -u 推到远程

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

`git push origin master`

Find a ref that matches master in the source repository (most likely, it would find refs/heads/master),
and update the same ref (e.g. refs/heads/master) in origin repository with it. If master did not exist remotely, it would be created.

`git push origin HEAD`

A handy way to push the current branch to the same name on the remote.

`git push mothership master:satellite/master dev:satellite/dev`

Use the source ref that matches master (e.g. refs/heads/master) to update the ref that matches satellite/master (most probably refs/remotes/satellite/master) in the mothership repository;
do the same for dev and satellite/dev.

See the section describing `<refspec>`... above for a discussion of the matching semantics.

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

### 拉取远程仓库

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

### 远程仓库的移除与重命名

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

### 清理无效远程追踪

如果在远程版本库上删除了某一分支，该命令并不会删除本地的远程追踪分支，这时候，有另一个命令

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

## 解决冲突

解决冲突就是把`Git`合并失败的文件手动编辑为我们希望的内容，再提交。
用 `git log --graph` 命令可以看到分支合并图。

冲突的位置`git`会提醒并作标记，需要手动修改，然后提交。
注意，`git` 只会标出冲突的位置，并不能帮你解决冲突，也不能判断你是否正确解决了冲突，
所以下一次的提交，就会被视为冲突已经解决的提交--无论你的修改是否正确。
当然由于可以恢复，这也算不了什么问题。

也可以

```bash
git reset --hard commit
```

还原本地工作，然后`git pull`

### FAST-FORWARD MERGE

Often the current branch head is an ancestor of the named commit.
This is the most common case especially when invoked from git pull: you are tracking an upstream repository, you have committed no local changes, and now you want to update to a newer upstream revision.

In this case, a new commit is not needed to store the combined history; instead, the HEAD (along with the index) is updated to point at the named commit, without creating an extra merge commit.

This behavior can be suppressed with the `--no-ff` option.

### TRUE MERGE

Except in a `fast-forward merge` (see above), the branches to be merged must be tied together by a merge commit that has both of them as its parents.

A merged version reconciling(使和谐一致；调和；使配合) the changes from all branches to be merged is committed, and your `HEAD`, `index`, and `working tree` are updated to it.
It is possible to have modifications in the working tree as long as they do not overlap; the update will preserve them.

When it is not obvious how to reconcile the changes, the following happens:

+ The `HEAD` pointer stays the same.
+ The `MERGE_HEAD` ref is set to point to the other branch head.
+ Paths that merged cleanly are updated both in the index file and in your working tree.
+ For conflicting paths, the index file records up to three versions: stage 1 stores the version from the common ancestor, stage 2 from `HEAD`, and stage 3 from `MERGE_HEAD` (you can inspect the stages with `git ls-files -u`).
The working tree files contain the result of the "merge" program; i.e. 3-way merge results with familiar conflict markers `<<< === >>>`.
+ No other changes are made. In particular, the local modifications you had before you started merge will stay the same and the index entries for them stay as they were, i.e. matching `HEAD`.

If you tried a merge which resulted in complex conflicts and want to start over, you can recover with git `merge --abort`.

### HOW CONFLICTS ARE PRESENTED

During a merge, the working tree files are updated to reflect the result of the merge.
Among the changes made to the common ancestor’s version, non-overlapping ones (that is, you changed an area of the file while the other side left that area intact(完好无损；完整), or vice versa) are incorporated in the final result verbatim.
When both sides made changes to the same area, however, Git cannot randomly pick one side over the other, and asks you to resolve it by leaving what both sides did to that area.

By default, Git uses the same style as the one used by the "merge" program from the `RCS` suite to present such a conflicted hunk, like this:

```git
Here are lines that are either unchanged from the common
ancestor, or cleanly resolved because only one side changed.
<<<<<<< yours:sample.txt
Conflict resolution is hard;
let's go shopping.
=======
Git makes conflict resolution easy.
>>>>>>> theirs:sample.txt
And here is another line that is cleanly resolved or unmodified.
```

The area where a pair of conflicting changes happened is marked with markers `<<<<<<<`, `=======`, and `>>>>>>>`.
The part before the `=======` is typically your side, and the part afterwards is typically their side.

The default format does not show what the original said in the conflicting area. You cannot tell how many lines are deleted and replaced with Barbie’s remark on your side.
The only thing you can tell is that your side wants to say it is hard and you’d prefer to go shopping, while the other side wants to claim it is easy.

An alternative style can be used by setting the "merge.conflictStyle" configuration variable to "diff3".

### HOW TO RESOLVE CONFLICTS

After seeing a conflict, you can do two things:

+ Decide not to merge. The only clean-ups you need are to reset the index file to the HEAD commit to reverse 2. and to clean up working tree changes made by `2.` and `3.`;
`git merge --abort` can be used for this.
+ Resolve the conflicts. Git will mark the conflicts in the working tree.
Edit the files into shape and git add them to the index.
Use `git commit` or `git merge --continue` to seal the deal. The latter command checks whether there is a (interrupted) merge in progress before calling `git commit`.

You can work through the conflict with a number of tools:

+ Use a mergetool. `git mergetool` to launch a graphical mergetool which will work you through the merge.
+ Look at the diffs. `git diff` will show a three-way diff, highlighting changes from both the `HEAD` and `MERGE_HEAD` versions.
+ Look at the diffs from each branch. `git log --merge -p <path>` will show diffs first for the `HEAD` version and then the `MERGE_HEAD` version.
+ Look at the originals. `git show :1:filename` shows the common ancestor, `git show :2:filename` shows the `HEAD` version, and `git show :3:filename` shows the `MERGE_HEAD` version.

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

+ `stash` ：储存工作现场
+ `stash list`: 查看工作现场列表
+ `git stash apply`: 恢复，但是恢复后，`stash`内容并不删除
+ `stash drop`: 删除
+ `stash pop`: 恢复的同时把`stash`内容也删了

When no `<stash>` is given, stash@{0} is assumed, otherwise `<stash>` must be a reference of the form `stash@{<revision>}`.

当工作只进行到一半，还没法提交，预计完成还需1天时间。但是，必须在两个小时内修复该bug，怎么办？
幸好，`Git`还提供了一个`stash`功能，可以把g当前工作现场“储藏”起来，等以后恢复现场后继续工作：

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

Use git stash when you want to record the current state of the working directory and the index, but want to go
       back to a clean working directory. The command saves your local modifications away and reverts the working
       directory to match the HEAD commit.

       The modifications stashed away by this command can be listed with git stash list, inspected with git stash
       show, and restored (potentially on top of a different commit) with git stash apply. Calling git stash without
       any arguments is equivalent to git stash push. A stash is by default listed as "WIP on branchname ...", but
       you can give a more descriptive message on the command line when you create one.

       The latest stash you created is stored in refs/stash; older stashes are found in the reflog of this reference
       and can be named using the usual reflog syntax (e.g. stash@{0} is the most recently created stash, stash@{1}
       is the one before it, stash@{2.hours.ago} is also possible). Stashes may also be referenced by specifying just
       the stash index (e.g. the integer n is equivalent to stash@{n}).

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

它的原理是首先找到这两个分支（即当前分支 `experiment`、变基操作的目标基底分支 `master`）的最近共同祖先 `C2`，然后对比当前分支相对于该祖先的历次提交，提取相应的修改并存为临时文件，然后将**当前分支**指向目标基底 `C3`, 最后以此将之前另存为临时文件的修改依序应用

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

### gitignore

忽略某些文件时，需要编写`.gitignore`；
`.gitignore`文件本身要放到版本库里，并且可以对`.gitignore`做版本管理！

[git设置忽略文件和目录][]

[git设置忽略文件和目录]: https://www.cnblogs.com/wtil/p/11676092.html

1. 创建.gitignore
2. 修改文件，添加忽略正则

***

+ `.idea` //忽略`.idea`文件夹及文件夹下文件
+ `*.iml` //忽略以`.iml`结尾的文件

#### 例子

```git
# 忽略*.o和*.a文件
*.[oa]

# 忽略*.b和*.B文件，my.b除外
*.[bB]
!my.b

# 忽略dbg文件和dbg目录
dbg

# 只忽略dbg目录，不忽略dbg文件
dbg/

# 只忽略dbg文件，不忽略dbg目录
dbg
!dbg/

# 只忽略当前目录下的dbg文件和目录，子目录的dbg不在忽略范围内
/dbg
```

以`#`开始的行，被视为注释.

+ `?`：代表任意的一个字符
+ `＊`：代表任意数目的字符
+ `{!ab}`：必须不是此类型
+ `{ab,bb,cx}`：代表`ab`,`bb`,`cx`中任一类型即可
+ `[abc]`：代表`a`,`b`,`c`中任一字符即可
+ `[ ^abc]`：代表必须不是`a`,`b`,`c`中任一字符

***
添加忽略之后，已经提交到版本库中的文件是无法忽略的。
只能clone到本地，删除后，再进行忽略。

`.gitignore`只能忽略那些原来没有被track的文件，
如果某些文件已经被纳入了版本管理中，则修改`.gitignore`是无效的。

正确的做法是在每个clone下来的仓库中手动设置不要检查特定文件的更改情况。
`git update-index --assume-unchanged PATH` 在PATH处输入要忽略的文件。
另外 git 还提供了另一种 `exclude` 的方式来做同样的事情，
不同的是 `.gitignore` 这个文件本身会提交到版本库中去, 用来保存的是公共的需要排除的文件。
而 `.git/info/exclude` 这里设置的则是你自己本地需要排除的文件, 它不会影响到其他人，也不会提交到版本库中去

Python我一般添加这个三个

```git
.idea
*.iml
__pycache__
```

## git 术语

### index

[whats-the-deal-with-the-git-index][]

[whats-the-deal-with-the-git-index]: https://gitguys.com/topics/whats-the-deal-with-the-git-index/

The git “index” is where you place files you want committed to the git repository.

Before you “commit” (checkin) files to the git repository, you need to first place the files in the git “index”.

The git index goes by many names. But they all refer to the same thing. Some of the names you may have heard:

+ Index
+ Cache
+ Directory cache
+ Current directory cache
+ Staging area
+ Staged files

The Index Isn’t The Working Directory.

## Git 对象

Git Objects

Git is a content-addressable filesystem. Great. What does that mean?
It means that at the core of Git is a simple `key-value` data store.
What this means is that you can insert any kind of content into a Git repository, for which Git will hand you back a unique key you can use later to retrieve that content.

As a demonstration, let’s look at the plumbing command((建筑物的)管路系统,自来水管道)
`git hash-object`, which takes some data, stores it in your `.git/objects` directory (the object database), and gives you back the unique key that now refers to that data object.

First, you initialize a new Git repository and verify that there is (predictably) nothing in the objects directory:

```git
$ git init test
Initialized empty Git repository in /tmp/test/.git/
$ cd test
null
$ find .git/objects
.git/objects
.git/objects/info
.git/objects/pack
$ find .git/objects -type f
null
```

Git has initialized the objects directory and created pack and info subdirectories in it, but there are no regular files. Now, let’s use `git hash-object` to create a new data object and manually store it in your new Git database:

```git
$ echo 'test content' | git hash-object -w --stdin
d670460b4b4aece5915caf5c68d12f560a9fe3e4
```

In its simplest form, `git hash-object` would take the content you handed to it and merely return the unique key that would be used to store it in your Git database.
The `-w` option then tells the command to not simply return the key, but to write that object to the database.
Finally, the --stdin option tells `git hash-object` to get the content to be processed from stdin; otherwise, the command would expect a filename argument at the end of the command containing the content to be used.

The output from the above command is a `40-character checksum hash`. This is the SHA-1 hash — a checksum of the content you’re storing plus a header, which you’ll learn about in a bit. Now you can see how Git has stored your data:

```git
$ find .git/objects -type f
.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4
```

If you again examine your objects directory, you can see that it now contains a file for that new content.
This is how Git stores the content initially — as a single file per piece of content, named with the SHA-1 checksum of the content and its header. The subdirectory is named with the first 2 characters of the SHA-1, and the filename is the remaining 38 characters.

Once you have content in your object database, you can examine that content with the `git cat-file` command. This command is sort of a Swiss army knife for inspecting Git objects. Passing `-p` to `cat-file` instructs the command to first figure out the type of content, then display it appropriately:

```git
$ git cat-file -p d670460b4b4aece5915caf5c68d12f560a9fe3e4
test content
```

### Tree 对象

`tree`，解决了git中储存文件名的问题，并且允许你把一组文件存在一起。

git 存储文件的方式类似于`Unix`系统，但是有点简化。所有的内容被存储为`tree`and`blob`，`tree`对应UNIX 文件夹，
`blob`对应`inodes`or `file contents`

一个`tree`包含一个或多个条目，每一个条目是一个`SHA-1 hash`of a blob or `subtree`with its associated mode, type, and filename. 比如，项目中最新的一个tree看起来大概像：

```git
$ git cat-file -p master^{tree}
100644 blob a906cb2a4a904a152e80877d4088654daad0c859      README
100644 blob 8f94139338f9404f26296befa88755fc2598c289      Rakefile
040000 tree 99f1a6d12cb4b6f19c8655fca46c3ecf317074e0      lib
```

The `master^{tree}` syntax 指定了master分支的最新提交。
注意the `lib` subdirectory isn't a `blob` but a `pointer` to another `tree`:

```git
$ git cat-file -p 99f1a6d12cb4b6f19c8655fca46c3ecf317074e0
100644 blob 47c6340d6459e05787f644c2447d2595f5d3a54b      simplegit.rb
```

注意，取决于你用的shell，当你使用`master^{tree}` syntax时，可能会遇到一些错误

In CMD on Windows, the `^` character is used for escaping, so you have to double it to avoid this: `git cat-file -p master^^{tree}`.
When using PowerShell, parameters using `{}` characters have to be quoted to avoid the parameter being parsed incorrectly: `git cat-file -p 'master^{tree}'`.

If you’re using `ZSH`, the `^` character is used for globbing, so you have to enclose the whole expression in quotes: `git cat-file -p "master^{tree}"`.

*** 你可以相当容易的创建你自己的tree

git 通常用 `staging` area ( `index`)中的state创建`tree`，然后写入一系列tree对象。所以首先来`staging`一些文件

先创建一个`index`with a single entry--the first version of your `test.txt file`，使用管道命令`git update-index`，使用这个命令，手动添加earlier version of the `test.txt`to a new staging area.

你需要用`--add` option，因为这个文件在your staging area中还不存在，
还有`--cacheinfo`，because the file you're adding isn't in your directory but is in your database.

Then, you specify the `mode`, `SHA-1`, and `filename`:

```git
git update-index --add --cacheinfo 100644 \
83baae61804e65cc73a7201a7252750c76066a30 test.txt
```

在本例中，你指定的模式是`100644`，代表它是正常文件。其他选项有`100755`，代表可执行文件；
还有`120000`，代表符号链接。

这些模式来自于 普通Unix mode，但是比较简化--这是对files（blobs）合法的三个mode。

现在，用 `git write-tree` 把`stage`写入到一个`tree` object 中。
不用加上`-w` option--这个命令会自动创建一个tree from the state of the index ，如果它还不存在。

```git
$ git write-tree
d8329fc1cc938780ffdd9f94e0d364e0ea74f579
$ git cat-file -p d8329fc1cc938780ffdd9f94e0d364e0ea74f579
100644 blob 83baae61804e65cc73a7201a7252750c76066a30      test.txt
```

你可以验证，它的确是一个tree object，using `git cat-file -t` command you saw earlier:

```git
$ git cat-file -t d8329fc1cc938780ffdd9f94e0d364e0ea74f579
tree
```

你可以创建一个新tree，包含 `test.txt`的新版本和一个新文件：

```git
$ git read-tree --prefix=bak d8329fc1cc938780ffdd9f94e0d364e0ea74f579
null
$ git write-tree
3c4e9cd789d88d8d89c1073707c3585e41b0e614
$ git cat-file -p 3c4e9cd789d88d8d89c1073707c3585e41b0e614
040000 tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579      bak
100644 blob fa49b077972391ad58037050f2a75f74e3671e92      new.txt
100644 blob 1f7a7a472abf3dd9643fd615f6da379c4acb3e3a      test.txt
```

### Commit 对象

To create a commit object, you call `commit-tree` and specify a single tree `SHA-1` and which commit objects, if any, directly preceded it. Start with the first tree you wrote:

```git
$ echo 'first commit' | git commit-tree d8329f
fdf4fc3344e67ab068f836878b6c4951e3b15f3d
```

You will get a different hash value because of different creation time and author data. Replace commit and tag hashes with your own checksums further in this chapter. Now you can look at your new commit object with `git cat-file`:

```git
$ git cat-file -p fdf4fc3
tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579
author Scott Chacon <schacon@gmail.com> 1243040974 -0700
committer Scott Chacon <schacon@gmail.com> 1243040974 -0700

first commit
```

The format for a commit object is simple:
it specifies the top-level tree for the snapshot of the project at that point;
the parent commits if any (the commit object described above does not have any parents);the author/committer information (which uses your user.name and user.email configuration settings and a timestamp);
a blank line, and then the commit message.

Next, you’ll write the other two commit objects, each referencing the commit that came directly before it:

$ echo 'second commit' | git commit-tree 0155eb -p fdf4fc3
cac0cab538b970a37ea1e769cbbde608743bc96d
$ echo 'third commit'  | git commit-tree 3c4e9c -p cac0cab
1a410efbd13591db07496601ebc7a059dd55cfe9

Each of the three commit objects points to one of the three snapshot trees you created. Oddly enough, you have a real Git history now that you can view with the git log command, if you run it on the last commit SHA-1:

```git
$ git log --stat 1a410e
commit 1a410efbd13591db07496601ebc7a059dd55cfe9
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:15:24 2009 -0700

    third commit

 bak/test.txt | 1 +
 1 file changed, 1 insertion(+)

commit cac0cab538b970a37ea1e769cbbde608743bc96d
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:14:29 2009 -0700

    second commit

 new.txt  | 1 +
 test.txt | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

commit fdf4fc3344e67ab068f836878b6c4951e3b15f3d
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:09:34 2009 -0700

    first commit

 test.txt | 1 +
 1 file changed, 1 insertion(+)
```

Amazing.
You’ve just done the low-level operations to build up a Git history without using any of the front end commands.
This is essentially what Git does when you run the `git add` and `git commit` commands — it stores blobs for the files that have changed, updates the index, writes out trees, and writes commit objects that reference the top-level trees and the commits that came immediately before them.
These three main Git objects — the blob, the tree, and the commit — are initially stored as separate files in your `.git/objects` directory. Here are all the objects in the example directory now, commented with what they store:

```git
$ find .git/objects -type f
.git/objects/01/55eb4229851634a0f03eb265b69f5a2d56f341 # tree 2
.git/objects/1a/410efbd13591db07496601ebc7a059dd55cfe9 # commit 3
.git/objects/1f/7a7a472abf3dd9643fd615f6da379c4acb3e3a # test.txt v2
.git/objects/3c/4e9cd789d88d8d89c1073707c3585e41b0e614 # tree 3
.git/objects/83/baae61804e65cc73a7201a7252750c76066a30 # test.txt v1
.git/objects/ca/c0cab538b970a37ea1e769cbbde608743bc96d # commit 2
.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4 # 'test content'
.git/objects/d8/329fc1cc938780ffdd9f94e0d364e0ea74f579 # tree 1
.git/objects/fa/49b077972391ad58037050f2a75f74e3671e92 # new.txt
.git/objects/fd/f4fc3344e67ab068f836878b6c4951e3b15f3d # commit 1
```

### Tree-ish

"Tree-ish" 是一个术语，指的是一个标识符，最终指引到一个（子）目录树（Git 把目录成为"tree" and "tree objects"）

如果想指定文件夹`foo`，正确的方法是使用`git`的"tree-ish"语法:

```bash
HEAD:README, :README, master:./README
```

`:`（冒号）前面是tree-ish object，冒号后面是具体的路径，也就是说`master:foo`是正确的语法，而不能写成`master/foo`。
注：`master`是分支的名字，`foo`是具体的路径。

### refspec

应该是`Reference Specification`的缩写，字面意思就是具体的引用。
它其实是一种格式，`git`通过这种格式的判断来获取不同引用下的数据。

你可以具体参考：[Reference Specification][]

`Refspec` 的格式是一个可选的 `+` 号，接着是 `<src>:<dst>` 的格式，这里 `<src>` 是远端上的引用格式，`<dst>` 是将要记录在本地的引用格式。

可选的 `+` 号告诉 `Git` 在即使不能"Fast Forward"的情况下，也去强制更新它。
缺省情况下 `refspec` 会被 `git remote add` 命令所自动生成，
`Git` 会获取远端上 `refs/heads/` 下面的所有引用，并将它写入到本地的 `refs/remotes/origin/`. 所以，如果远端上有一个 `master` 分支，你在本地可以通过下面这种方式来访问它的历史记录：

```bash
$ git log origin/master
$ git log remotes/origin/master
$ git log refs/remotes/origin/master
```

它们全是等价的，因为 Git 把它们都扩展成 `refs/remotes/origin/master`.
如果你想让 Git 每次只拉取远程的 `master` 分支，而不是远程的所有分支，你可以把 `fetch` 这一行修改成这样：
`fetch = +refs/heads/master:refs/remotes/origin/master`

[git中的refspec是什么意思?][]

[git中的refspec是什么意思?]: http://www.imooc.com/wenda/detail/503063

[Reference Specification]: http://git-scm.com/book/zh/ch9-5.html

### 路径指定



### pack 包文件



### 仓库瘦身

[仓库体积过大，如何减小？ ][]

[仓库体积过大，如何减小？ ]: https://gitee.com/help/articles/4232#article-header2

查看存储库中的大文件

```bash
git rev-list --objects --all | grep -E $(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -10 | awk '{print$1}' | sed ':a;N;$!ba;s/\n/|/g')
```

或

```bash
git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -15 | awk '{print$1}')"
```

改写历史，去除大文件

注意：下方命令中的 `path/to/large/files` 是大文件所在的路径，千万不要弄错！

```bash
git filter-branch --tree-filter 'rm -f path/to/large/files' --tag-name-filter cat -- --all
git push origin --tags --force
git push origin --all --force
```

git filter-branch --tree-filter 'rm -f "latex/doc/LaTeX2e完全学习手册-胡伟 清华大学出版社 2011.pdf"' --tag-name-filter cat -- --all


如果在 `git filter-branch` 操作过程中遇到如下提示，需要在 `git filter-branch` 后面加上参数 -f

```bash
Cannot create a new backup.
A previous backup already exists in refs/original/
Force overwriting the backup with -f
```

并告知所有组员，push 代码前需要 pull rebase，而不是 merge，否则会从该组员的本地仓库再次引入到远程库中，导致仓库在此被码云系统屏蔽。

git filter-branch --tree-filter 'rm -f path/to/large/files' --tag-name-filter cat -- --all
git push origin --tags --force
git push origin --all --force


## revision 的写法

A revision parameter  `<rev>`一般是`commit`，它使用what is called an extended `SHA-1` syntax

### sha1

`<sha1>`, e.g. `dae86e1950b1277e545cee180551750029cfe735`, `dae86e`

The full SHA-1 object name (40-byte hexadecimal string), or a leading substring that is  within the repository

***
`<describeOutput>`, e.g. `v1.7.4.2-679-g3bee7fb`

Output from git describe; 
i.e. a closest tag,  optionally followed by a dash and a number of commits,  followed by a dash, a g, and an abbreviated object name.

### refname

`<refname>`, e.g. `master`, `heads/master`, `refs/heads/master`

A symbolic `ref` name. E.g.  `master` typically means the commit object referenced by `refs/heads/master`.
If you happen to have both `heads/master` and `tags/master`,you can explicitly say heads/master to tell Git which one you mean. 

### @

`@`

`@` alone is a shortcut for `HEAD`.

***
`<refname>@{<date>}`, e.g. `master@{yesterday}`, `HEAD@{5 minutes ago}`

A ref followed by the suffix `@` with a 日期包围在大括号中 (e.g.  `{yesterday}`, `{1 month 2 weeks 3 days 1 hour 1 second ago}` or `{1979-02-26 18:30:00}`) specifies the value of the ref at a prior point in time. 

这个后缀只能用在 `ref name` 后面。它会寻找给定时间内的状态，比如上星期，
如果你想寻找时间段内的，用`--since` and `--until`.

***
`<refname>@{<n>}, e.g. master@{1}`

A `ref` followed by the suffix `@` with an 大括号中的顺序(e.g.  `{1}`, `{15}`) specifies the `n-th` prior value of that `ref`. 

For example `master@{1}` is the immediate prior value of `master` while `master@{5}` is the 5th prior value of master. 

This suffix may only be used immediately following a ref name and the ref must have an existing log (`$GIT_DIR/logs/<refname>`).

`@{<n>}`, e.g. `@{1}`

如果省略前面的`ref`指定的话，默认指的是当前分支

For example, if you are on branch blabla then @{1} means the same as blabla@{1}.

***
`@{-<n>}, e.g. @{-1}`
The construct `@{-<n>}` means the `<n>th branch/commit` checked out before the current one.

***
`<branchname>@{upstream}`, e.g. `master@{upstream}`, `@{u}`
`<branchname>@{push}`, e.g. `master@{push}`, `@{push}`

上游分支，推送分支，

Here’s an example to make it more clear:

```git
$ git config push.default current # 配置默认 
$ git config remote.pushdefault myfork #默认远程push 分支
$ git checkout -b mybranch origin/master #创建并切换到新分支 mybranch，上游是`origin/master`

$ git rev-parse --symbolic-full-name @{upstream} # 给出 上游分支
refs/remotes/origin/master

$ git rev-parse --symbolic-full-name @{push} #给出默认push分支
refs/remotes/myfork/mybranch
```

在这个例子中，我们建立了一个triangular workflow（三角形工作流），从一个位置pull然后push到另一个位置，如果是一个普通的工作流，那么`@{push}` is the same as `@{upstream}`。

后缀`@{push}` or `@{upstream}`大小写不敏感

### ^ caret and ~ tilde

`<rev>^`, e.g. `HEAD^`, `v1.5.1^0`

`<rev>^`等价于`<rev>^1`，`^<n>`意思是当前`ref`的第`n`个父节点，指的是同一个level上的，也就是水平方向的。

As a special rule,` <rev>^0` 指向自身，可以用`tag`（tag object）指向提交（commit object）

***
`<rev>~<n>`, e.g. `master~3`

A suffix `~<n>` to a revision parameter 之的是第`n`个首位父节点，
I.e.  `<rev>~3` is equivalent to `<rev>^^^` which is equivalent to `<rev>^1^1^1`. 

参见下面的图示

***
`<rev>^{<type>}`, e.g. `v0.99.8^{commit}`
       
A suffix `^` followed by 大括号中的类型名 means dereference the object at `<rev>`  recursively until an object of type `<type>` is found or the object cannot be dereferenced anymore (in which case, barf). 

For example, if `<rev>` is a commit-ish, `<rev>^{commit}` describes the corresponding commit object. 
Similarly, if `<rev>` is a tree-ish, `<rev>^{tree}` describes the corresponding tree object.  
`<rev>^0` is a short-hand for `<rev>^{commit}`.

`rev^{object}` can be used to make sure `rev` names an object that exists, 

without requiring `rev` to be a tag, and without dereferencing rev;  because a tag is already an object, it does not have to be dereferenced even once to get to an object.

`rev^{tag}` can be used to ensure that `rev` identifies an existing tag object.

***
`<rev>^{}`, e.g. `v0.99.8^{}`

`<rev>^{}` 意思是这个object可能是个tag, and  the tag recursively until a non-tag object is found.

***
`<rev>^{/<text>}`, e.g. `HEAD^{/fix nasty bug}`

这个形式等价于下面的`:/fix nasty bug` ，除了它返回  the youngest matching commit which is reachable from the `<rev>` before `^`.

### : colon

`:/<text>`, e.g. `:/fix nasty bug`

引用一个commit，它的 commit message matches the specified regular expression. 正则表达式可以匹配commit message的任意部分。

匹配某些字符开头，用`:/^foo`，序列`/!`有特殊含义，`:/!-foo` 反相匹配，`:/!!foo`匹配`!foo`本身，

Any other sequence beginning with :`/!`  is reserved for now.

***
`<rev>:<path>`, e.g. `HEAD:README`, `:README`, `master:./README`

给出tree-ish object `<rev>`下的`path`对应的文件（ blob or tree），

`:path` (`:`前面没有指定`rev`) 表示的是`index`中的内容， A path starting with `./` or `../` is relative to the current working directory. 

给出的路径会被转换成相对于 working tree的根目录，对于引用跟当前working tree 有相同目录结构的commit or tree是很有用的。

***
`:<n>:<path>`, e.g. `:0:README`, `:README`

冒号后面的数字可以取`0` to `3`，引用相应`index`中的`blob` object，缺省数字的话相当于`0`，
在`merge`的时候，`stage 1`(也就是index)指代common ancestor，stage 2是目标分支（一般是当前分支）
`stage 3`是被合并过来的分支

***
这里有一个图示, by Jon Loeliger. 

nodes B and C 是 A 的父节点，父亲的顺序从左到右。

```graph
G         H   I       J
 \        /       \    /
  D    E          F
   \     |       /     \
    \    |     /        |
     \   |  /           |
        B             C
        \            /
            \      /
                A
```

```git
A =      = A^0
B = A^   = A^1     = A~1
C = A^2  = A^2
D = A^^  = A^1^1   = A~2
E = B^2  = A^^2
F = B^3  = A^^3
G = A^^^ = A^1^1^1 = A~3
H = D^2  = B^^2    = A^^^2  = A~2^2
I = F^   = B^3^    = A^^3^
J = F^2  = B^3^2   = A^^3^2
```

## 比较二进制文件

你可以使用 `Git 属性`来有效地比较两个二进制文件。 
秘诀在于，告诉 Git 怎么把你的二进制文件转化为文本格式，从而能够使用普通的 diff 方式进行对比。

比如：对 Microsoft Word 文档进行版本控制。 大家都知道，Microsoft Word 几乎是世上最难缠的编辑器，尽管如此，大家还是在用它。 如果想对 Word 文档进行版本控制，你可以把文件加入到 Git 库中，每次修改后提交即可。
 把下面这行文本加到你的 `.gitattributes` 文件中：

```bash
*.docx diff=word
```

这告诉 Git 当你尝试查看包含变更的比较结果时，所有匹配 `.docx` 模式的文件都应该使用`word`过滤器。 
`word`过滤器是什么？ 我们现在就来设置它。 
我们会对 Git 进行配置，令其能够借助 `docx2txt` 程序将 Word 文档转为可读文本文件，这样不同的文件间就能够正确比较了。

首先，你需要安装 `docx2txt`；
它可以从 [https://sourceforge.net/projects/docx2txt](https://sourceforge.net/projects/docx2txt) 下载。 按照 `INSTALL` 文件的说明，把它放到你的可执行路径下。 
接下来，你还需要写一个脚本把输出结果包装成 `Git` 支持的格式。 在你的可执行路径下创建一个叫 `docx2txt` 文件，添加这些内容：

```bash
#!/bin/bash
docx2txt.pl "$1" -
```

别忘了用 `chmod a+x` 给这个文件加上可执行权限。 最后，你需要配置 `Git` 来使用这个脚本：

`$ git config diff.word.textconv docx2txt`

现在如果在两个快照之间进行比较，Git 就会对那些以 .docx 结尾的文件应用`word`过滤器，即 `docx2txt`。 
这样你的 Word 文件就能被高效地转换成文本文件并进行比较了。

你还能用这个方法比较图像文件。 
其中一个办法是，在比较时对图像文件运用一个过滤器，提炼出 `EXIF` 信息——这是在大部分图像格式中都有记录的一种元数据。 
如果你下载并安装了 `exiftool` 程序，可以利用它将图像转换为关于元数据的文本信息，这样比较时至少能以文本的形式显示发生过的变动： 将以下内容放到你的 `.gitattributes` 文件中：

`*.png diff=exif`

配置 Git 以使用此工具：

`$ git config diff.exif.textconv exiftool`
