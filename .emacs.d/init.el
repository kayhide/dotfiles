(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

(require 'use-package)


;; 起動メッセージの非表示
(setq inhibit-startup-message t)

(tool-bar-mode 0)

(setq-default indent-tabs-mode nil)
(global-auto-revert-mode t)

;; バッファ画面外文字の切り詰め表示
(setq truncate-lines nil)

;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
(setq truncate-partial-width-windows t)

;; バッファ中の行番号表示
(global-linum-mode t)

;; 行番号のフォーマット
;; (set-face-attribute 'linum nil :foreground "red" :height 0.8)
(set-face-attribute 'linum nil :height 0.8)
(setq-default linum-format "%4d")

;; modeline
(line-number-mode t)                    ; 行番号の表示
(column-number-mode t)                  ; 列番号の表示

;; cp932エンコード時の表示を「P」とする
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;; cursor
(blink-cursor-mode 0)
(setq scroll-preserve-screen-position t)

;; スクロール行数（一行ごとのスクロール）
(setq vertical-centering-font-regexp ".*")
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)

;; 画面スクロール時の重複行数
(setq next-screen-context-lines 1)

;; 選択範囲をハイライト
(transient-mark-mode t)

;; (find-function-setup-keys)
(ffap-bindings)

(cua-mode t)
(setq-default cua-enable-cua-keys nil)

(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(defadvice y-or-n-p (around prevent-dialog activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(use-package dired
  :config
  (setq-default ls-lisp-dirs-first t)
  (setq-default dired-isearch-filenames t)
  (setq-default dired-dwim-target t)
  (setq-default dired-recursive-copies 'always)
  (setq-default dired-recursive-deletes 'always)
  ;; (put 'dired-find-alternate-file 'disabled nil)
  )

(use-package wdired
  :commands (wdired-change-to-wdired-mode)
  :bind
  (:map
   dired-mode-map
   ("r" . wdired-change-to-wdired-mode)))

(use-package ediff-util
  :config
  (setq-default ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package align)

;; 同一バッファ名にディレクトリ付与
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))

(use-package paren
  :config
  (show-paren-mode t)
  (setq show-paren-style 'mixed))

(use-package open-junk-file
  :bind (("C-x C-z" . open-junk-file)))

(use-package sequential-command
  :init
  (require 'sequential-command-config)
  (sequential-command-setup-keys))

(use-package wgrep)

(use-package color-moccur)

;; (use-package migemo)

(use-package git-gutter-fringe
  :diminish git-gutter-mode
  :functions (global-git-gutter-mode)
  :config
  (global-git-gutter-mode t))

(use-package cn-outline
  :config
  (setq-default cn-outline t))

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
  (global-whitespace-mode t))

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
  (global-undo-tree-mode))

(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-x C-<return>" . mc/mark-all-dwim)))

(require 'init-loader)
(init-loader-load)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(enh-ruby-add-encoding-comment-on-save nil)
 '(enh-ruby-deep-indent-paren nil)
 '(safe-local-variable-values
   (quote
    ((haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)
     (encoding . utf-8))))
 '(yas-prompt-functions (quote (helm-yas-prompt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erm-syn-errline ((t (:underline (:color "red")))))
 '(erm-syn-warnline ((t (:underline (:color "orange"))))))

