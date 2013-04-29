(if window-system (set-frame-parameter nil 'alpha 85))

(let* ((size 12)
       (asciifont "Menlo")
       (jpfont "Hiragino Maru Gothic ProN")
       (h (* size 10))
       (fontspec)
       (jp-fontspec))
  (set-face-attribute 'default nil :family asciifont :height h)
  (setq fontspec (font-spec :family asciifont))
  (setq jp-fontspec (font-spec :family jpfont))
  (set-fontset-font nil 'japanese-jisx0208 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0212 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
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
