;; completion
(define-key emacs-lisp-mode-map (kbd "C-.") 'completion-at-point)
(define-key lisp-interaction-mode-map (kbd "C-.") 'completion-at-point)


;; eldoc
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(eval-after-load 'eldoc
  '(progn
     (setq eldoc-idle-delay 0.5)
     (setq eldoc-minor-mode-string "")))


;; lispxmp
(autoload 'lispxmp "lispxmp" nil t)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)


;; predit
(autoload 'enable-paredit-mode "paredit" nil t)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(eval-after-load 'paredit
  '(let ((map paredit-mode-map))
     (define-key map (kbd "C-j") nil)
     (define-key map (kbd "M-;") nil)
     (define-key map (kbd "C-h") 'paredit-backward-delete)
     (define-key map (kbd "M-h") 'paredit-backward-kill-word)
     (define-key map (kbd "C-M-)") 'paredit-forward-barf-sexp)
     map))


;; auto-async-byte-compile
(autoload 'enable-auto-async-byte-compile-mode "auto-async-byte-compile" t)
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(eval-after-load 'auto-async-byte-compile
  '(progn
     (setq auto-async-byte-compile-exclude-files-regexp "/junk/")))
