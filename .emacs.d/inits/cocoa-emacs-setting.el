;; frame
(if window-system (set-frame-parameter nil 'alpha 75))

;; font
(let* ((height 140)
       (fontname "Ricty")
       (fontspec (font-spec :family fontname)))
  (set-face-attribute 'default nil :family fontname :height height)
  (set-fontset-font nil 'japanese-jisx0208 fontspec)
  (set-fontset-font nil 'japanese-jisx0212 fontspec)
  (set-fontset-font nil 'japanese-jisx0213-1 fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 fontspec)
  (set-fontset-font nil 'katakana-jisx0201 fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

;; dired
(setq-default dired-use-ls-dired nil)

;; migemo
(eval-after-load "migemo"
  '(progn
     (setq-default migemo-command "/usr/local/bin/cmigemo")
     (setq-default migemo-options '("-q" "--emacs" "-i" "\g"))
     (setq-default migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
     (setq-default migemo-coding-system 'utf-8-unix)))
