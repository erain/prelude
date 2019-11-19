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
  :requires helm helm-lsp
  :hook ((c++-mode . lsp)
         (go-mode . lsp))
  :config

  (setq lsp-prefer-flymake nil)  ;; Prefer using lsp-ui (flycheck) over flymake
  (setq lsp-enable-xref t)
  )



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
