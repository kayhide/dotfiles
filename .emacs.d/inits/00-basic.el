(show-paren-mode 1)
(tool-bar-mode -1)
(find-function-setup-keys)
(ffap-bindings)

(setq-default indent-tabs-mode nil)
(global-auto-revert-mode t)

(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(defadvice y-or-n-p (around prevent-dialog activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

;; ------------------------------------------------------------------------
;; @ dired
(eval-after-load 'dired
 '(progn
    (setq ls-lisp-dirs-first t)
    (setq dired-dwim-target t)
    (setq dired-recursive-copies 'always)
    (setq dired-recursive-deletes 'always)))

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
