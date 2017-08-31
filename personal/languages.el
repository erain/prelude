;;;;
;; Python
;;;;
(elpy-enable)
(elpy-use-ipython)



;;;;
;; Haskell Indentation
;;;;
(custom-set-variables
 '(haskell-mode-hook '(turn-on-haskell-indentation)))



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




(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes



;;;;
;; JSON Mode
;;;;
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;;;;
;; Google related
;;;;
;; -- general --
(require 'google)
;; -- p4 --
(require 'p4-google)                ;; g4-annotate, improves find-file-at-point
(require 'p4-files)                 ;; transparent support for Perforce filesystem
(p4-enable-file-name-handler)
;; -- google3 --
(require 'google3)                  ;; magically set paths for compiling google3 code
(require 'google3-build)            ;; support for blaze builds
;; -- cs --
(require 'csearch)                  ;; Search the whole Google code base.
(global-set-key [f6] #'csearch)
;; -- others --
(require 'compilation-colorization) ;; colorizes output of (i)grep
