;;;;
;; Python
;; http://caisah.info/emacs-for-python/
;;;;
;; (add-hook 'python-mode-hook 'auto-complete-mode)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-hook 'python-mode-hook 'flymake-mode)

;; (setq pycodechecker "pylint_etc_wrapper.py")
;; (when (load "flymake" t)
;;   (load-library "flymake-cursor")
;;   (defun dss/flymake-pycodecheck-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list pycodechecker (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" dss/flymake-pycodecheck-init)))

;; (defun dss/pylint-msgid-at-point ()
;;   (interactive)
;;   (let (msgid
;;         (line-no (line-number-at-pos)))
;;     (dolist (elem flymake-err-info msgid)
;;       (if (eq (car elem) line-no)
;;           (let ((err (car (second elem))))
;;             (setq msgid (second (split-string (flymake-ler-text err)))))))))

;; (defun dss/pylint-silence (msgid)
;;   "Add a special pylint comment to silence a particular warning."
;;   (interactive (list (read-from-minibuffer "msgid: " (dss/pylint-msgid-at-point))))
;;   (save-excursion
;;     (comment-dwim nil)
;;     (if (looking-at "pylint:")
;;         (progn (end-of-line)
;;                (insert ","))
;;       (insert "pylint: disable-msg="))
;;     (insert msgid)))


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



;;;;
;; C Mode
;;;;
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(require 'compile)
(add-hook 'c-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   ;; emulate make's .c.o implicit pattern rule, but with
                   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
                   ;; variables:
                   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s -c -o %s.o %s %s %s"
                             (or (getenv "CC") "gcc")
                             (file-name-sans-extension file)
                             (or (getenv "CPPFLAGS") "-DDEBUG=9")
                             (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
                             file))))))
