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
