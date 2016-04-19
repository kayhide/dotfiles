;; js-mode
(add-to-list 'auto-mode-alist '("\\.js.erb\\'" . js-mode))

;; coffee-mode
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(eval-after-load 'coffee-mode
  '(progn
     (setq-default coffee-tab-width 2)))

;; scss-mode
(add-to-list 'auto-mode-alist '("\\.scss.erb\\'" . scss-mode))
(eval-after-load 'scss-mode
  '(progn
     (setq-default scss-compile-at-save nil)
     (setq-default css-indent-offset 2)
     ))

;; emmet-mode
(autoload 'emmet-mode "emmet-mode" nil t)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(eval-after-load 'emmet-mode
  '(progn
     (setq-default emmet-indentation 2)))


;; pov-mode
(autoload 'pov-mode "pov-mode" "PoVray scene file mode" t)
(add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))
