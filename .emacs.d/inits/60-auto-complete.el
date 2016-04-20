(eval-when-compile
  (require 'use-package))

(use-package auto-complete-config
  :diminish (auto-complete-mode)
  :functions (ac-config-default)
  :defer t
  :init
  (ac-config-default)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

  (setq ac-auto-start 4)         ;; n文字以上の単語の時に補完を開始
  (setq ac-delay 0.1)            ;; n秒後に補完開始
  (setq ac-use-fuzzy t)          ;; 曖昧マッチ
  (setq ac-use-comphist nil)     ;; 補完推測機能
  (setq ac-auto-show-menu 0.1)   ;; n秒後に補完メニューを表示
  (setq ac-use-quick-help nil)   ;; クイックヘルプ
  (setq ac-quick-help-delay 1.0) ;; n秒後にクイックヘルプを表示
  (setq ac-ignore-case nil)      ;; 大文字・小文字を区別

  (add-to-list 'ac-modes 'enh-ruby-mode)
  (add-to-list 'ac-modes 'web-mode))
