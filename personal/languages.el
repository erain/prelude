;;;;
;; Python
;;;;
(custom-set-variables
 '(python-guess-indent nil)
 '(python-indent-offset 2))



;;;;
;; Bazel Mode
;;;;
(add-to-list 'auto-mode-alist '("\\.bazel\\'" . bazel-mode))
(add-to-list 'auto-mode-alist '("\\.bzl\\'" . bazel-mode))
(add-to-list 'auto-mode-alist '("WORKSPACE\\'" . bazel-mode))
(add-to-list 'auto-mode-alist '("BUILD\\'" . bazel-mode))
(add-hook 'bazel-mode-hook
          (lambda () (add-hook 'before-save-hook #'bazel-format nil t)))



;;;;
;; Octave Mode
;;;;
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))



;;;;
;; Latex Mode
;;;;
(setq latex-run-command "xelatex")



;;;;
;; JSON Mode
;;;;
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))
