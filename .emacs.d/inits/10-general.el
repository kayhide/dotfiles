(eval-when-compile
  (require 'use-package))

(require 'bind-key)
(require 'diminish)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  )

(use-package popwin
  :config
  (popwin-mode t)
  )

(use-package paren
  :config
  (show-paren-mode t)
  (setq show-paren-style 'mixed)
  )

(use-package open-junk-file
  :bind (("C-x C-z" . open-junk-file))
  )

(use-package sequential-command
  :config
  (require 'sequential-command-config)
  (sequential-command-setup-keys)
  )

(use-package wgrep
  :init
  (setq-default wgrep-enable-key "r")
  )

(use-package color-moccur)

;; (use-package migemo)

(use-package git-gutter-fringe
  :diminish git-gutter-mode
  :functions (global-git-gutter-mode)
  :config
  (global-git-gutter-mode t)
  )

(use-package cn-outline
  :config
  (setq-default cn-outline t)
  )

(use-package whitespace
  :diminish (whitespace-mode global-whitespace-mode)
  :config
  (setq whitespace-style
        '(face
          tabs spaces newline trailing space-before-tab space-after-tab
          space-mark tab-mark newline-mark))

  (set-face-attribute 'whitespace-space nil
                      :foreground "gray20"
                      :background 'unspecified)
  (set-face-attribute 'whitespace-tab nil
                      :foreground "gray20"
                      :background 'unspecified)
  (set-face-attribute 'whitespace-newline nil
                      :foreground "gray20")
  (set-face-attribute 'whitespace-trailing nil
                      :foreground "gray30"
                      :background "gray20")
  (setq whitespace-space-regexp "\\(　+\\)")
  (setq whitespace-display-mappings
        '((space-mark   ?　 [?□] [?＿]) ; full-width space - square
          (newline-mark ?\n [?¶ ?\n])   ; line feed
          (tab-mark     ?\t [?▷ ?\t])   ; tab
          ))
  (setq whitespace-global-modes '(not dired-mode tar-mode))
  (global-whitespace-mode t)
  )

(use-package undo-tree
  :diminish undo-tree-mode
  :functions (global-undo-tree-mode)
  :defines (undo-tree-map undo-tree-visualizer-mode-map)
  :bind
  (("C-x C-u" . undo-tree-visualize)
   ("C-/" . undo-tree-undo)
   ("C-M-/" . undo-tree-redo)
   :map undo-tree-map
   ("C-_" . nil)
   ("C-?" . nil)
   ("M-_" . nil)
   :map undo-tree-visualizer-mode-map
   ("<return>" . undo-tree-visualizer-quit)
   ("C-g" . undo-tree-visualizer-abort))
  :config
  (global-undo-tree-mode)
  )

(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-x C-<return>" . mc/mark-all-dwim))
  )
