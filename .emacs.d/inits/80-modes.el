(eval-when-compile
  (require 'use-package))

(use-package js
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.js.erb\\'" . js-mode))
  )

(use-package coffee-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
  :config
  (setq-default coffee-tab-width 2)
  )

(use-package scss-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.scss.erb\\'" . scss-mode))
  :config
  (setq-default scss-compile-at-save nil)
  (setq-default css-indent-offset 2)
  )

(use-package pov-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
  (add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))
  )
