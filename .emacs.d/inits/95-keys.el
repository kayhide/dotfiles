;; built-in
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "C-m") 'newline)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-;") 'dabbrev-expand)
(global-set-key (kbd "C-<f4>") 'kill-this-buffer)
(global-set-key (kbd "<f8>") 'shell-command)
(global-set-key (kbd "C-<f8>") 'shell-command-on-region)
(global-set-key (kbd "C-x C-o") 'dired-jump)
(global-set-key (kbd "s-¥") 'split-window-right)
(global-set-key (kbd "s--") 'split-window-below)


(global-set-key (kbd "<next>") 'scroll-other-window)
(global-set-key (kbd "<prior>") 'scroll-other-window-down)
(global-set-key (kbd "S-<next>") (lambda () (interactive) (scroll-other-window 1)))
(global-set-key (kbd "S-<prior>") (lambda () (interactive) (scroll-other-window -1)))

(global-set-key (kbd "C-\\") nil)
(global-set-key (kbd "C-z") nil)

(let ((map dired-mode-map))
  (define-key map (kbd "C-t") nil))

;; packages
(eval-after-load 'open-junk-file
  '(progn
     (global-set-key (kbd "C-x C-z") 'open-junk-file)))

(eval-after-load 'redo+
  '(progn
     (global-set-key (kbd "C-M-/") 'redo)))

(eval-after-load 'skk-autoloads
  '(progn
     (global-set-key (kbd "<zenkaku-hankaku>") 'skk-mode)
     (global-set-key (kbd "C-x C-j") 'skk-mode)))

(eval-after-load 'helm-config
  '(progn
     (global-set-key (kbd "C-x b") 'helm-for-files)))


;; defined in 90-local.el
(global-set-key (kbd "C-t") 'other-window-or-split)
(global-set-key (kbd "C-M-t") 'delete-other-windows)

(global-set-key (kbd "<f12>") 'kill-all-buffers)

(let ((map minibuffer-local-map))
  (define-key map (kbd "C-l") 'strip-last-basename))

