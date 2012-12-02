;; -*- coding: utf-8 -*-

(show-paren-mode 1)
(tool-bar-mode -1)
(find-function-setup-keys)
(ffap-bindings)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-;") 'dabbrev-expand)
(global-set-key (kbd "<f8>") 'shell-command)
(global-set-key (kbd "C-<f8>") 'shell-command-on-region)
(global-set-key (kbd "S-<f11>") 'delete-other-windows)
(global-set-key (kbd "<next>") 'scroll-other-window)
(global-set-key (kbd "<prior>") 'scroll-other-window-down)
(global-set-key (kbd "S-<next>") (lambda () (interactive) (scroll-other-window 1)))
(global-set-key (kbd "S-<prior>") (lambda () (interactive) (scroll-other-window -1)))
(define-key emacs-lisp-mode-map (kbd "C-.") 'completion-at-point)
(define-key lisp-interaction-mode-map (kbd "C-.") 'completion-at-point)

(require 'wdired)
(define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)

(add-to-list 'load-path "~/.emacs.d/auto-install/")
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(require 'open-junk-file)
(global-set-key (kbd "C-x C-z") 'open-junk-file)

(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(eval-after-load 'paredit
  '(let ((map paredit-mode-map))
    (define-key map (kbd "C-j") nil)
    (define-key map (kbd "M-;") nil)
    (define-key map (kbd "C-h") 'paredit-backward-delete)
    (define-key map (kbd "M-h") 'paredit-backward-kill-word)
    map))

(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

(require 'anything-startup)
(global-set-key (kbd "C-x b") 'anything-for-files)
;; (setq anything-c-filelist-file-name "/tmp/all.filelist")
;; (setq anything-grep-candidates-fast-directory-regexp "^/tmp")

(require 'anything-c-moccur)
(setq moccur-split-word t)
(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)

(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)

(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'grep-edit)

(require 'color-moccur)
(require 'moccur-edit)
(setq moccur-split-word t)

(require 'migemo)
(setq migemo-command "/usr/bin/ruby")


(setq initial-frame-alist
      (append  '((width . 240)
 		 (height . 80)
		 (alpha . 90)
		 (fullscreen . fullboth))
	       initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

(setq split-width-threshold 100)

(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))
(global-set-key [f11] 'toggle-fullscreen)


;; ------------------------------------------------------------------------
;; @ skk

(setq skk-user-directory "~/.skk")
(global-set-key (kbd "<zenkaku-hankaku>") 'skk-mode)

;; (require 'context-skk)

;; ------------------------------------------------------------------------
;; @ buffer

   ;; バッファ画面外文字の切り詰め表示
   (setq truncate-lines nil)

   ;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
   (setq truncate-partial-width-windows t)

   ;; 同一バッファ名にディレクトリ付与
   (require 'uniquify)
   (setq uniquify-buffer-name-style 'forward)
   (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
   (setq uniquify-ignore-buffers-re "*[^*]+*")

;; ------------------------------------------------------------------------
;; @ fringe

   ;; バッファ中の行番号表示
   (global-linum-mode t)

   ;; 行番号のフォーマット
   ;; (set-face-attribute 'linum nil :foreground "red" :height 0.8)
   (set-face-attribute 'linum nil :height 0.8)
   (setq linum-format "%4d")

;; ------------------------------------------------------------------------
;; @ modeline

   ;; 行番号の表示
   (line-number-mode t)

   ;; 列番号の表示
   (column-number-mode t)

   ;; 時刻の表示
   (require 'time)
   (setq display-time-24hr-format t)
   (setq display-time-string-forms '(24-hours ":" minutes))
   (display-time-mode t)

   ;; cp932エンコード時の表示を「P」とする
   (coding-system-put 'cp932 :mnemonic ?P)
   (coding-system-put 'cp932-dos :mnemonic ?P)
   (coding-system-put 'cp932-unix :mnemonic ?P)
   (coding-system-put 'cp932-mac :mnemonic ?P)

;; ------------------------------------------------------------------------
;; @ cursor

   ;; カーソル点滅表示
   (blink-cursor-mode 0)

   ;; スクロール時のカーソル位置の維持
   (setq scroll-preserve-screen-position t)

   ;; スクロール行数（一行ごとのスクロール）
   (setq vertical-centering-font-regexp ".*")
   (setq scroll-conservatively 35)
   (setq scroll-margin 0)
   (setq scroll-step 1)

   ;; 画面スクロール時の重複行数
   (setq next-screen-context-lines 1)

;; ------------------------------------------------------------------------
;; @ default setting

   ;; 起動メッセージの非表示
   (setq inhibit-startup-message t)

   ;; スタートアップ時のエコー領域メッセージの非表示
   (setq inhibit-startup-echo-area-message -1)

;; ------------------------------------------------------------------------
;; @ backup

   ;; 変更ファイルのバックアップ
   (setq make-backup-files nil)

   ;; 変更ファイルの番号つきバックアップ
   (setq version-control nil)

   ;; 編集中ファイルのバックアップ
   (setq auto-save-list-file-name nil)
   (setq auto-save-list-file-prefix nil)

   ;; 編集中ファイルのバックアップ先
   (setq auto-save-file-name-transforms
         `((".*" ,temporary-file-directory t)))

   ;; 編集中ファイルのバックアップ間隔（秒）
   (setq auto-save-timeout 30)

   ;; 編集中ファイルのバックアップ間隔（打鍵）
   (setq auto-save-interval 500)

   ;; バックアップ世代数
   (setq kept-old-versions 1)
   (setq kept-new-versions 2)

   ;; 上書き時の警告表示
   ;; (setq trim-versions-without-asking nil)

   ;; 古いバックアップファイルの削除
   (setq delete-old-versions t)

;; ------------------------------------------------------------------------
;; @ hiwin-mode
   (require 'hiwin)

   ;; hiwin-modeを有効化
   ;; (hiwin-activate)

   ;; 非アクティブウィンドウの背景色を設定
   ;; (set-face-background 'hiwin-face "gray80")

;; ------------------------------------------------------------------------
;; @ color-theme
   (require 'color-theme)
   (color-theme-initialize)
   (color-theme-simple-1)

