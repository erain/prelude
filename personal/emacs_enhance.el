;; mouse in terminal
;; (xterm-mouse-mode 1)

;; Author: WANG Ying
;; About Paste: Meta-y
;; (global-set-key [(meta ?/)] 'hippie-expand)
;; (setq hippie-expand-try-functions-list
;;       '(try-expand-dabbrev
;;         try-expand-dabbrev-visible
;;         try-expand-dabbrev-all-buffers
;;         try-expand-dabbrev-from-kill
;;         try-complete-file-name-partially
;;         try-complete-file-name
;;         try-expand-all-abbrevs
;;         try-expand-list
;;         try-expand-line
;;         try-complete-lisp-symbol-partially
;;         try-complete-lisp-symbol))


;; save desktop:
(desktop-save-mode t)


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


;; perform white space cleanup on save
(add-hook 'before-save-hook 'whitespace-cleanup)


;;;;;;
;; Org-mode
;;;;;;
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq-default prettify-symbols-alist
              '(("#+BEGIN_SRC" . "λ")
                ("#+END_SRC" . "λ")))
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(global-font-lock-mode 1)
;; (set-register ?o (cons 'file "~/Google Drive/org/notes.org"))
;; (set-register ?g (cons 'file "~/Google Drive/org/gtd.org"))


;;;;;;
;; key bindings section
;;;;;;
;; (global-set-key (kbd "M-SPC") 'set-mark-command)


;;;;;
;; expand-region the right way to select words
;;;;;
(use-package expand-region
  :config
  (global-set-key (kbd "M-z") 'er/expand-region))


;;;;;;
;; nerdtree
;;;;;;
(use-package neotree
  :config
  (global-set-key [f9] 'neotree-toggle)
  (global-set-key [f10] 'neotree-stretch-toggle))


;; Auto-refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)


;; Mac related setup in emacs 26.1
;; https://news.ycombinator.com/item?id=17172524
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
;; Mac - open the file directly in the current frame
(setq ns-pop-up-frames nil)


;; Change windows size
;; (global-set-key (kbd "C-x <left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "C-x <right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "C-x <down>") 'shrink-window)
;; (global-set-key (kbd "C-x <up>") 'enlarge-window)


;;;;
;; Some helm-mode
;;;;
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


;;;;;;
;; PATH related settings
;;;;;;

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))


;;;;;;
;; Other keybindings
;;;;;;
(global-key-binding (kbd "C-\[") 'pop-global-mark)


;;;;;;
;; Emacs start server -- disabled
;;;;
;; (load "server")
;; (unless (server-running-p) (server-start))
