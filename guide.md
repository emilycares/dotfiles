# Guide

## shortcuts
search files --> <ctrl p> [keymaps while searching](https://github.com/nvim-telescope/telescope.nvim#default-mappings)
search open files --> <space b>
While seaching presss <ctrl q> these items will be thrown into a quickfixlist.
You can navigate the quickfixlist with <ctrl j> and <ctrl k>


open file browser --> ctrl b [How to navigate a the tree](https://github.com/kyazdani42/nvim-tree.lua#keybindings)

## Git

To open the git gui. Go into normal mode and type.
```
:Git 
```

Compare current file to last commit. (as a argument you can provide a commit id)
```
:Gvdiffsplit
```

If you want to execute any other git command you can just add the agruments like in a shell.
```
:Git checkout -b my_feature_branch
:Git log
:Git commit
:Git checkout main
:Git pull origin main
:Git checkout -
:Git rebase main
```
It allsow has some special commannds.
This will load all mergeconflicts into a quickfix list;
```
:Git mergetool
```


