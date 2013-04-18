;;;;
;; Python Syntax Check
;;;;


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
