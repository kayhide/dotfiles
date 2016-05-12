(eval-when-compile
  (require 'use-package))

(require 'bind-key)
(require 'diminish)

(use-package yasnippet
  :diminish (yas-minor-mode yas-global-mode)
  :functions (yas-global-mode)
  :bind (:map
         yas-minor-mode-map
         ("C-<tab>" . yas-expand)
         ("TAB" . nil)
         ("<tab>" . nil)
         ("C-x i i" . helm-c-yas-complete)
         ("C-x i n" . yas-new-snippet)
         ("C-x i v" . yas-visit-snippet-file)
         :map
         yas-keymap
         ("C-<tab>" . yas-next-field-or-maybe-expand)
         ("TAB" . nil)
         ("<tab>" . nil))
  :init
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.snippets"
                           "~/.emacs.d/snippets"
                           "~/.emacs.d/snippets_imported"))
  (setq yas-buffer-local-condition t)
  (require 'helm-c-yasnippet))
