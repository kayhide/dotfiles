(eval-when-compile
  (require 'use-package))

(use-package markdown-mode
  :commands markdown-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  :config
  (setq-default markdown-command "/usr/local/bin/multimarkdown")
  )
