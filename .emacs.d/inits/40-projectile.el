(require 'projectile)
(setq-default projectile-completion-system 'helm)

(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

