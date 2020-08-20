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

## restore恢复文件

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

## checkout还原文件

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

用 **index**或者`<tree-ish>`（通常是一个`commit`）里面的内容替换working tree里面的 paths。
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
+ `-d, --delete` ;Delete a branch. The branch must be fully merged in its upstream branch, or in HEAD if no upstream was set with `--track` or `--set-upstream-to`.
+ `-f, --force`: Reset `<branchname>` to `<startpoint>`, even if `<branchname>` exists already. 
Without `-f`, git branch refuses to change an existing branch.
In combination with `-d` (or `--delete`), allow deleting the branch irrespective of its merged status.
In combination with `-m` (or `--move`), allow renaming the branch even if the new branch           name already exists, the same applies for `-c` (or `--copy`).
+ `-m` `-M`：对分支进行重命名，并且把`reflog`出现的分支名字一并更改。如果新分支已经存在，使用`-M`强迫重命名

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

给出一个或者多个已经存在的`commits`，然后apply每个的change，对于每个改变生成一个`commit`。
需要`working tree`是clean的。 (从 HEAD commit 之后没有修改过).

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
