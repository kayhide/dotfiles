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
(global-whitespace-mode t)
