;;;;;;
;; Kill other buffers other than the current one
;;;;;;
(defun kill-other-buffers()
  "kill all other buffers"
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(provide 'kill-other-buffers)
;;; emacs_commands file ends here
