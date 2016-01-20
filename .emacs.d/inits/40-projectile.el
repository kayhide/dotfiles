(require 'projectile)
(setq-default projectile-switch-project-action 'projectile-dired)
(setq-default projectile-completion-system 'helm)
(setq-default helm-projectile-fuzzy-match nil)

(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

(require 'f)
(require 's)
(require 'dash)
(defun projectile-root-ruby-gem (dir &optional _)
  (let* ((patterns '("^ruby$" "^gems$" "^[0-9\.]+$" "^gems$" ".+"))
         (len (length patterns))
         (elms (f-split dir))
         (tail (and (> (length elms) len)
                    (-slice elms (- len)))))
    (and
     tail
     (or
      (and
       (-all? 'identity (-zip-with 's-matches? patterns tail))
       (f-slash dir))
      (projectile-root-ruby-gem (f-dirname dir))))))

(add-to-list 'projectile-project-root-files-functions 'projectile-root-ruby-gem)
