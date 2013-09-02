(show-paren-mode 1)
(tool-bar-mode -1)
(find-function-setup-keys)
(ffap-bindings)

(setq-default indent-tabs-mode nil)
(global-auto-revert-mode t)

;; ------------------------------------------------------------------------
;; @ dired
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
;; @ align
(require 'align)

;; ------------------------------------------------------------------------
;; @ server
(require 'server)
(unless (server-running-p)
  (server-start))
