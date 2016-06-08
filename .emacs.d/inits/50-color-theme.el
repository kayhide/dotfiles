(eval-when-compile
  (require 'use-package))

(use-package color-theme
  :config
  (color-theme-initialize)
  (color-theme-simple-1)
  (set-face-attribute 'region nil
                      :foreground 'unspecified
                      :background "navy"))
