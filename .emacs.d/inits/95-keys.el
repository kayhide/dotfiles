(require 'bind-key)

;; built-in
(bind-key "C-j" 'newline-and-indent)
(bind-key "C-m" 'newline)
(bind-key "C-;" 'dabbrev-expand)
(bind-key "C-<f4>" 'kill-this-buffer)
(bind-key "<f8>" 'shell-command)
(bind-key "C-<f8>" 'shell-command-on-region)
(bind-key "C-x C-o" 'dired-jump)
(bind-key "s-¥" 'split-window-right)
(bind-key "s--" 'split-window-below)
(bind-key "s-0" 'delete-window)
(bind-key "M-_" 'fixup-whitespace)
(bind-key "<f9>" 'next-error)
(bind-key "S-<f9>" 'previous-error)

(bind-key "<next>" 'scroll-other-window)
(bind-key "<prior>" 'scroll-other-window-down)
(bind-key "s-<next>" (lambda () (interactive) (scroll-other-window 1)))
(bind-key "s-<prior>" (lambda () (interactive) (scroll-other-window -1)))

(bind-key "C-\\" nil)
(bind-key "C-z" nil)

(bind-key "s-c" nil)
(bind-key "s-t" nil)

(let ((map dired-mode-map))
  (bind-key "C-t" nil map)
  (bind-key "C-l" 'revert-buffer map)
  )

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
