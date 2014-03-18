;; markdown-mode
(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(eval-after-load 'markdown-mode
  '(progn
     (setq markdown-command-needs-filename t)))
