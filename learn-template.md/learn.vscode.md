
# learn.vscode.md

## Preview mode

When you `single-click` or select a file in the Explorer, it is shown in a `preview mode` and reuses an existing `Tab`. This is useful if you are quickly browsing files and don't want every visited file to have its own Tab. When you start editing the file or use `double-click` to open the file from the Explorer, a new Tab is dedicated to that file.

**Preview mode is indicated by italics in the Tab heading**

## split

Pro Tip: 

If you `press` and hold the `Alt` key while hovering over the **toolbar action** to split an editor, it will offer to split to the **other orientation**. This is a fast way to split either to the right or to the bottom.

# Playground

In the bottom right of the Welcome page, there is a link to the **Interactive playground** where you can interactively try out VS Code's features.
`Help > Interactive Playground`.

## multi-cursor editing

Multi-Cursor Editing

1. `C+A+S+ up down left right`, or `S+A+mouse drag`
2. `C+A+Up`, `C+A+down`
3. `A+click`
4. `C+A+L` select all occurrence

## intelli-sense

`C+space`

## line-actions

Since it's very common to work with the entire text in a line we provide a set of useful shortcuts to help with this.

1. Copy a line and insert it above or below the current position
`S+A+down or S+A+up`
1. Move an entire line or selection of lines up or down with `A+up` `A+down` respectively.
1. Delete the entire line with `C+S+k`

## Rename Refactoring

It's easy to rename a symbol such as a function name or variable name.  
press `F2`  
this will occur across all files in a project.  
You can also see refactoring in the right-click context menu.

## Formatting

Keeping your code looking great is hard without a good formatter.

either for the entire document with `S+A+F`

or for the current selection with `C+K C+F` .

Both of these options are also available through the right-click context menu.

## Code Folding

In a large file it can often be useful to collapse sections of code to increase readability.

To do this, you can simply press `C+S+[` `C+S+]`, to fold or unfold

Folding can also be done with the +/- icons in the left gutter.

To fold all sections use `C+K C+0`  or to unfold all use `C+K C+J`.

## Errors and Warnings

Errors and warnings are highlighted with squiggles as you edit your code .

In the sample below you can see a number of syntax errors.

By pressing `F8` you can navigate across them in sequence and see the detailed error message.

## Snippets

You can greatly accelerate your editing through the use of snippets.

Simply start typing `try` and select `trycatch` from the suggestion list and press `tab` to create a `try->catch` block.

Your cursor will be placed on the text `error` for easy editing. If more than one parameter exists then press `tab` to jump to it.

## Emmet

`Emmet` takes the snippets idea to a whole new level:

you can type CSS-like expressions that can be dynamically parsed, and produce output depending on what you type in the abbreviation.

Try it by selecting `Emmet: Expand Abbreviation` from the `Edit` menu with the cursor at the end of a valid Emmet abbreviation or snippet and the expansion will occur.

`ul>li.item$*5`

## JavaScript Type Checking

Sometimes type checking your JavaScript code can help you spot mistakes you might have not caught otherwise.  
You can run the TypeScript type checker against your existing JavaScript code by simply adding a `// @ts-check` comment to the top of your file.

```JavaScript
// @ts-nocheck

let easy = true;
easy = 42;
```

Tip:  
You can also enable the checks workspace or application wide by adding `"javascript.implicitProjectConfig.checkJs"`: true  
to your workspace or user settings  
and explicitly ignoring files or lines using `// @ts-nocheck` and `// @ts-ignore`.  
Check out the docs on JavaScript in VS Code to learn more.

## others

Open the Integrated Terminal by pressing `C+`,  
then see what's possible by reviewing the [terminal documentation][]

Work with version control by pressing `C+S+G G`.  
Understand how to stage, commit, change branches, and view diffs and more by reviewing the [version control documentation][]

Browse thousands of extensions in our integrated gallery by pressing `C+S+X`.  
 The [documentation][] will show you how to see the most popular extensions, disable installed ones and more.

[terminal documentation]: https://code.visualstudio.com/docs/editor/integrated-terminal

[version control documentation]: https://code.visualstudio.com/docs/editor/versioncontrol

[documentation]: https://code.visualstudio.com/docs/editor/extension-gallery