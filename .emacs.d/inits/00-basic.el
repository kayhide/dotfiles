(eval-when-compile
  (require 'use-package))

(require 'bind-key)

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

;; files
(setq make-backup-files nil)
(setq auto-save-default nil)

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

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))
