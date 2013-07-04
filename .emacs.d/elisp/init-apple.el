(if window-system (set-frame-parameter nil 'alpha 85))

(let* ((height 140)
       (fontname "Ricty")
       (fontspec (font-spec :family fontname))    
       )
  (set-face-attribute 'default nil :family fontname :height height)
  (set-fontset-font nil 'japanese-jisx0208 fontspec)
  (set-fontset-font nil 'japanese-jisx0212 fontspec)
  (set-fontset-font nil 'japanese-jisx0213-1 fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 fontspec)
  (set-fontset-font nil 'katakana-jisx0201 fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))



;; ------------------------------------------------------------------------
;; @ color-theme
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme")
(require 'color-theme)
(color-theme-initialize)


;; ------------------------------------------------------------------------
;; @ migemo
(add-to-list 'load-path "~/.emacs.d/elisp/migemo")
(require 'migemo)


;; ------------------------------------------------------------------------
;; @ skk
(add-to-list 'load-path "~/.emacs.d/elisp/skk") ; symlink to skk elisp dir
(require 'skk-autoloads)

