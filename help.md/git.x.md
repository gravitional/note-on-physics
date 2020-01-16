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
