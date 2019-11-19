(use-package hydra)

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  :config
  (defun netrom/helm-lsp-workspacbe-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-workspace-symbol)))

  (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-global-workspace-symbol))))


(use-package lsp-ivy
  :ensure t)


(use-package yasnippet                  ; Snippets
  :ensure t
  :config
  (use-package yasnippet-snippets       ; Collection of snippets
    :ensure t)
  (yas-global-mode t))


(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))


(use-package lsp-mode
  :commands lsp
  :requires hydra helm helm-lsp
  :hook ((c++-mode . lsp)
         (go-mode . lsp))
  :config

  (setq lsp-prefer-flymake nil)  ;; Prefer using lsp-ui (flycheck) over flymake

  (setq netrom--general-lsp-hydra-heads
        '(;; Xref
          ("d" xref-find-definitions "Definitions" :column "Xref")
          ("D" xref-find-definitions-other-window "-> other win")
          ("r" xref-find-references "References")
          ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
          ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")

          ;; Peek
          ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
          ("C-r" lsp-ui-peek-find-references "References")
          ("C-i" lsp-ui-peek-find-implementation "Implementation")

          ;; LSP
          ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
          ("C-a" lsp-execute-code-action "Execute code action")
          ("R" lsp-rename "Rename")
          ("t" lsp-goto-type-definition "Type definition")
          ("i" lsp-goto-implementation "Implementation")
          ("f" helm-imenu "Filter funcs/classes (Helm)")
          ("C-c" lsp-describe-session "Describe session")

          ;; Flycheck
          ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

        netrom--misc-lsp-hydra-heads
        '(;; Misc
          ("q" nil "Cancel" :column "Misc")
          ("b" pop-tag-mark "Back")))

  ;; Create general hydra.
  (eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
           ,@(append
              netrom--general-lsp-hydra-heads
              netrom--misc-lsp-hydra-heads)))

  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body))))

(use-package lsp-ui
  :commands lsp-ui-mode
  :requires lsp-mode flycheck
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company
  :config
  (global-set-key (kbd "C-/") 'company-complete))

(use-package company-lsp
  :requires company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)

  ;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))

(use-package company-box
  :hook (company-mode . company-box-mode)
  :config

  (setq company-box-icons-unknown 'fa_question_circle)

  (setq company-box-icons-elisp
        '((fa_tag :face font-lock-function-name-face) ;; Function
          (fa_cog :face font-lock-variable-name-face) ;; Variable
          (fa_cube :face font-lock-constant-face) ;; Feature
          (md_color_lens :face font-lock-doc-face))) ;; Face

  (setq company-box-icons-yasnippet 'fa_bookmark)

  (setq company-box-icons-lsp
        '((1 . fa_text_height) ;; Text
          (2 . (fa_tags :face font-lock-function-name-face)) ;; Method
          (3 . (fa_tag :face font-lock-function-name-face)) ;; Function
          (4 . (fa_tag :face font-lock-function-name-face)) ;; Constructor
          (5 . (fa_cog :foreground "#FF9800")) ;; Field
          (6 . (fa_cog :foreground "#FF9800")) ;; Variable
          (7 . (fa_cube :foreground "#7C4DFF")) ;; Class
          (8 . (fa_cube :foreground "#7C4DFF")) ;; Interface
          (9 . (fa_cube :foreground "#7C4DFF")) ;; Module
          (10 . (fa_cog :foreground "#FF9800")) ;; Property
          (11 . md_settings_system_daydream) ;; Unit
          (12 . (fa_cog :foreground "#FF9800")) ;; Value
          (13 . (md_storage :face font-lock-type-face)) ;; Enum
          (14 . (md_closed_caption :foreground "#009688")) ;; Keyword
          (15 . md_closed_caption) ;; Snippet
          (16 . (md_color_lens :face font-lock-doc-face)) ;; Color
          (17 . fa_file_text_o) ;; File
          (18 . md_refresh) ;; Reference
          (19 . fa_folder_open) ;; Folder
          (20 . (md_closed_caption :foreground "#009688")) ;; EnumMember
          (21 . (fa_square :face font-lock-constant-face)) ;; Constant
          (22 . (fa_cube :face font-lock-type-face)) ;; Struct
          (23 . fa_calendar) ;; Event
          (24 . fa_square_o) ;; Operator
          (25 . fa_arrows)) ;; TypeParameter
        )
  )
