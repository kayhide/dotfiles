(eval-when-compile
  (require 'use-package))

(require 'bind-key)

(bind-key "C-." 'completion-at-point emacs-lisp-mode-map)
(bind-key "C-." 'completion-at-point lisp-interaction-mode-map)


(use-package eldoc
  :commands (eldoc-mode)
  :init
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  :config
  (setq-default eldoc-idle-delay 0.5)
  (setq-default eldoc-minor-mode-string "")
  )

(use-package lispxmp
  :commands (lispxmp)
  :init
  (bind-key "C-c C-d" 'lispxmp emacs-lisp-mode-map)
  )

(use-package paredit
  :commands (enable-paredit-mode)
  :init
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'ielm-mode-hook 'enable-paredit-mode)
  :bind
  (:map
   paredit-mode-map
   ("C-j" . nil)
   ("M-;" . nil)
   ("C-h" . paredit-backward-delete)
   ("M-h" . paredit-backward-kill-word)
   ("C-M-)" . paredit-forward-barf-sexp)
   ))

(use-package auto-async-byte-compile
  :commands (enable-auto-async-byte-compile-mode)
  :init
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  :config
  (setq-default auto-async-byte-compile-exclude-files-regexp "/junk/")
  )
