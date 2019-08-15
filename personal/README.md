# README

This folder contains my personal emacs settings on top of what prelude provided.

## Themes and Fonts

It could be tricky to set themes and fonts because some of the previous settings will be preserved at `personal/custom.el`.

So to have a fresh start, delete such file and `M-x enable-theme` for the theme you want.

To setup proper font, use `menu-set-font` to select one and `customize-face default` to persist one.

## Go setup

There are seveval go tools related to go-mode. To have it properly working:

``` shell
go get -u golang.org/x/tools/...
go get -u github.com/mdempsky/gocode
go get -u github.com/rogpeppe/godef
```

## Key tips

### Go back to a previous location

Sometimes we jump to a different location in Emacs, for example, in `go-mode` we can jump to a function definition by `C-x C-j`.

To jump back to a previous location, the most efficient way would be `pop-global-mark` which is bound to `C-x C-SPC`.

Reference: https://superuser.com/questions/241939/how-to-jump-back-to-the-last-position-of-the-cursor-in-emacs
