;; Author: WANG Ying
;; About Paste: Meta-y
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Author: WAMG Ying
;; Match the parentheses
;; When press % on a parenthese, then go to the matching parenthese
;; Otherwise input an parenthese
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Author: WANG Ying
;; go-to-char
;; When you press C-c a x, then you go to the next 'x'
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.Typing `wy-go-to-char-key' again will move forwad to the next Nth occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
                     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c a") 'wy-go-to-char)

;; IDO:
;; (require 'ido)
(autoload 'ido "loading ido" t)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; erase-buffer
(defun my-clear ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(defun my-shell-hook ()
  (local-set-key "\C-cl" 'my-clear))
(add-hook 'shell-mode-hook 'my-shell-hook)

;; save desktop:
(desktop-save-mode t)

;; ibuffer:
;; (require 'ibuffer)
(autoload 'ibuffer "loading ibuffer" t)
(setq ibuffer-default-sorting-mode 'major-mode)
(setq ibuffer-always-show-last-buffer t)
(setq ibuffer-view-ibuffer t)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

;; backup files:
(setq backup-by-copying t    ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves")))            ; don't litter my fs tree
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)

;; instead of save desktop, rather save last editing place in files,
;; as well as minibuffer:
(require 'saveplace)
;; (setq-default save-place t)
(autoload 'saveplace "loading saveplace" t)
(savehist-mode t)

;; change the prefix of outline-minor-mode
(setq outline-minor-mode-prefix [(control o)])

;;;;;;
;; key bindings section
;;;;;;
(global-set-key (kbd "M-1") 'delete-other-windows) ; expand current pan
(global-set-key (kbd "M-2") 'split-window-vertically) ; split pan top/bottom
(global-set-key (kbd "M-s") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "C-c C-k") 'copy-line)

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;;;;;;
;; el-get configurations
;;;;;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)


;;;;;;
;; package.el repos
;;;;
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
