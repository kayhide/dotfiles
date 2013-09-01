;; -*- coding: utf-8 -*-

(add-to-list 'load-path "~/.emacs.d/elisp/")
(cond ((string-match "mingw" system-configuration)
       (load-library "init-cygwin.el"))
      ((string-match "apple" system-configuration)
       (load-library "init-apple.el"))
      ((string-match "linux" system-configuration)
       (load-library "init-linux.el")))

(show-paren-mode 1)
(tool-bar-mode -1)
(find-function-setup-keys)
(ffap-bindings)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-;") 'dabbrev-expand)
(global-set-key (kbd "C-<f4>") 'kill-this-buffer)
(global-set-key (kbd "<f8>") 'shell-command)
(global-set-key (kbd "C-<f8>") 'shell-command-on-region)
(global-set-key (kbd "C-\\") nil)
(global-set-key (kbd "C-z") nil)

(setq-default indent-tabs-mode nil)
(global-auto-revert-mode)

;; ------------------------------------------------------------------------
;; @ window split
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)
(global-set-key (kbd "C-M-t") 'delete-other-windows)
(global-set-key (kbd "<next>") 'scroll-other-window)
(global-set-key (kbd "<prior>") 'scroll-other-window-down)
(global-set-key (kbd "S-<next>") (lambda () (interactive) (scroll-other-window 1)))
(global-set-key (kbd "S-<prior>") (lambda () (interactive) (scroll-other-window -1)))

;; ------------------------------------------------------------------------
;; @ dired
(global-set-key (kbd "C-x C-o") 'dired-jump)
(put 'dired-find-alternate-file 'disabled nil)

;; ------------------------------------------------------------------------
;; @ wdired
(require 'wdired)
(define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)

;; ------------------------------------------------------------------------
;; @ ediff-util
(require 'ediff-util)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; ------------------------------------------------------------------------
;; @ eldoc
(require 'eldoc)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

;; ------------------------------------------------------------------------
;; @ align
(require 'align)


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
;; @ server
(require 'server)
(unless (server-running-p)
  (server-start))


;; ------------------------------------------------------------------------
;; @ whitespace-mode
(require 'whitespace)

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
(global-whitespace-mode 1)


;; ------------------------------------------------------------------------
;; @ package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; ------------------------------------------------------------------------
;; @ helm
(require 'helm-config)
(global-set-key (kbd "C-x b") 'helm-for-files)
;; (setq helm-c-filelist-file-name "/tmp/all.filelist")
;; (setq helm-grep-candidates-fast-directory-regexp "^/tmp")
(eval-after-load 'helm
  '(let ((map helm-map))
     (define-key map (kbd "C-h") 'delete-backward-char)
     (define-key map (kbd "C-M-n") 'helm-next-source)
     (define-key map (kbd "C-M-p") 'helm-previous-source)
     map))
(setq helm-split-window-default-side 'right)
(helm-mode)

(require 'helm-descbinds)
(helm-descbinds-mode)

(require 'helm-c-moccur)
(setq moccur-split-word t)
(define-key isearch-mode-map (kbd "C-o") 'helm-c-moccur-from-isearch)


(add-to-list
 'helm-completing-read-handlers-alist
 '(find-file-at-point . nil))


;; ------------------------------------------------------------------------
;; @ installed

(require 'open-junk-file)
(global-set-key (kbd "C-x C-z") 'open-junk-file)

(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)

(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'wgrep)

(require 'color-moccur)

(require 'igrep)
(igrep-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -Ou8"))
(igrep-find-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -Ou8"))

(require 'migemo)


;; ------------------------------------------------------------------------
;; @ skk
(require 'skk-autoloads)
(global-set-key (kbd "<zenkaku-hankaku>") 'skk-mode)
(global-set-key (kbd "C-x C-j") 'skk-mode)


;; ------------------------------------------------------------------------
;; @ color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-simple-1)

(set-face-attribute 'region nil
                    :foreground 'unspecified
                    :background "navy")


;; ------------------------------------------------------------------------
;; @ auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(setq ac-auto-start 3)         ;; n文字以上の単語の時に補完を開始
(setq ac-delay 0.1)            ;; n秒後に補完開始
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
(setq ac-use-comphist nil)     ;; 補完推測機能
(setq ac-auto-show-menu 0.1)   ;; n秒後に補完メニューを表示
(setq ac-use-quick-help nil)   ;; クイックヘルプ
(setq ac-quick-help-delay 1.0) ;; n秒後にクイックヘルプを表示
(setq ac-ignore-case nil)      ;; 大文字・小文字を区別


;; ------------------------------------------------------------------------
;; @ yanippet
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"
                         "~/.emacs.d/elpa/yasnippet-0.8.0/snippets"
                         "~/.emacs.d/snippets_imported"))
(yas-global-mode 1)
(setq yas-buffer-local-condition t)

(require 'helm-c-yasnippet)

(let ((map yas-minor-mode-map))
  (define-key map (kbd "C-<tab>") 'yas-expand)
  (define-key map (kbd "TAB") nil)
  (define-key map (kbd "<tab>") nil)
  (define-key map (kbd "C-x i i") 'helm-c-yas-complete)
  (define-key map (kbd "C-x i n") 'yas-new-snippet)
  (define-key map (kbd "C-x i v") 'yas-visit-snippet-file)
  map)

(let ((map yas-keymap))
  (define-key map (kbd "C-<tab>") 'yas-next-field-or-maybe-expand)
  (define-key map (kbd "TAB") nil)
  (define-key map (kbd "<tab>") nil)
  map)

;; (add-hook 'rinari-minor-mode-hook
;;           (lambda ()
;;             (add-to-list 'yas-extra-modes 'rails-mode)))


;; ------------------------------------------------------------------------
;; @ lisp-mode
(define-key emacs-lisp-mode-map (kbd "C-.") 'completion-at-point)
(define-key lisp-interaction-mode-map (kbd "C-.") 'completion-at-point)

(autoload 'enable-paredit-mode "paredit" nil t)
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

(autoload 'enable-auto-async-byte-compile-mode "auto-async-byte-compile" t)
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(eval-after-load 'auto-async-byte-compile
  '(progn
     (setq auto-async-byte-compile-exclude-files-regexp "/junk/")))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; ------------------------------------------------------------------------
;; @ ruby-mode
(autoload 'ruby-mode "ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
               (regexp . ",\\(\\s-*\\)[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-assignment-literal
               (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list          ;TODO add to rcodetools.el
             '(ruby-xmpfilter-mark
               (regexp . "\\(\\s-*\\)# => [^#\t\n]")
               (repeat . nil)
               (modes  . '(ruby-mode))))


;; ------------------------------------------------------------------------
;; @ rinari
(require 'rinari)
(global-rinari-mode)
(setq rinari-tags-file-name "TAGS")

(let ((map ruby-mode-map))
  (define-key map (kbd "C-x C-e") nil)
  map)


;; ------------------------------------------------------------------------
;; @ coffee-mode
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(eval-after-load 'coffee-mode
  '(progn
     (setq coffee-tab-width 2)))


;; ------------------------------------------------------------------------
;; @ emmet-mode
(autoload 'emmet-mode "emmet-mode" nil t)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'emmet-mode-hook
          (lambda ()
            (setq emmet-indentation 2)))


;; ------------------------------------------------------------------------
;; @ pov-mode
(autoload 'pov-mode "pov-mode" "PoVray scene file mode" t)
(add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))


;; ------------------------------------------------------------------------
;; @ deneb-mode
(require 'deneb-mode)

