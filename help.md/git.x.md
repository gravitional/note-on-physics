# git.x.md

## 恢复文件

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

先运行 co -b 命令创建新分支

`git checkout -b "branchname" "startpoint"`

然后用 push -u 命令推送到远程

`git push -u origin branchname` 

第一次推送`branchname`分支的所有内容，并把本地的`branchname`分支和远程的`branchname`分支关联起来

## git diff

`git-diff` - Show changes between commits, commit and working tree, etc

`commit` 可以用`HEAD~2`的格式，
`HEAD~2`最后的数字`2`指的是显示到倒数第几次，比如`2`指定倒数第二次

### SYNOPSIS

```git
git diff [<options>] [<commit>] [--] [<path>…​]
git diff [<options>] --cached [<commit>] [--] [<path>…​]
git diff [<options>] <commit> <commit> [--] [<path>…​]
git diff [<options>] <blob> <blob>
git diff [<options>] --no-index [--] <path> <path>
```

***
`git diff [--options] [--] [<path>...]`

changes 相对于`index`(`stage`)

***
`git diff --no-index [--options] [--] [<path>...]`

文件系统上的两个`path`，如果其中一个不是Git 控制的working tree，可以不加`--no-index`

***
`git diff [--options] --cached [<commit>] [--] [<path>...]`

比较`staged` and `<commit>`，默认commi 是 HEAD。`--staged` is a synonym of `--cached`.

***
`git diff [--options] <commit> [--] [<path>...]`

比较 working tree 相对于`<commit>`，commit可以是HEAD，也可以是分支名字，就是比较 分支的顶端。

***
`git diff [--options] <commit> <commit> [--] [<path>...]`

比较任意两个 `<commit>`.

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

### DESCRIPTION

Show:

+ changes between the `working tree` and the `index` or a `tree`,
+ changes between the `index` and `a tree`,
+ changes between two trees,
+ changes between two `blob` objects,
+ changes between two `files` on disk.

### checkout还原文件

```bash
git checkout [<tree-ish>] [--] <pathspec>…​
```

用 **index**或者`<tree-ish>`（通常是一个`commit`）里面的内容替换working tree里面的 paths。
当给出一个`<tree-ish>`的时候，the **paths** that match the `<pathspec>`会在**index** and in the **working tree**里面都更新。

index 中可能包含有之前合并失败的entries。默认情况下，如果你想checkout 一个这样的entries，会失败，什么都不会发生。
使用`-f`选项忽略未合并的entries。

The contents from a specific side of the merge can be checked out of the `index` by using `--ours` or `--theirs`.

With `-m`, changes made to the working tree file can be discarded to re-create the original conflicted merge result.
