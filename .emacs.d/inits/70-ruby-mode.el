(eval-when-compile
  (require 'use-package))

(use-package enh-ruby-mode
  :mode
  ((".rb$" . enh-ruby-mode)
   (".ruby$" . enh-ruby-mode)
   ("Rakefile$" . enh-ruby-mode)
   (".rake$" . enh-ruby-mode)
   ("Gemfile$" . enh-ruby-mode)
   ("Guardfile$" . enh-ruby-mode)
   ("Capfile$" . enh-ruby-mode)
   (".cap$" . enh-ruby-mode)
   (".thor$" . enh-ruby-mode)
   (".pryrc$" . enh-ruby-mode))

  :interpreter
  (("ruby" . enh-ruby-mode))

  :config
  (setq-default ruby-insert-encoding-magic-comment nil)

  (custom-set-variables
   '(enh-ruby-add-encoding-comment-on-save nil)
   '(enh-ruby-deep-indent-paren nil)
   )
  (custom-set-faces
   '(erm-syn-errline ((t (:underline (:color "red")))))
   '(erm-syn-warnline ((t (:underline (:color "orange"))))))

  (defvar align-rules-list)
  (add-to-list 'align-rules-list
               '(ruby-comma-delimiter
                 (regexp . ",\\(\\s-*\\)[^# \t\n]")
                 (repeat . t)
                 (modes  . '(enh-ruby-mode))))
  (add-to-list 'align-rules-list
               '(ruby-hash-literal
                 (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
                 (repeat . t)
                 (modes  . '(enh-ruby-mode))))
  (add-to-list 'align-rules-list
               '(ruby-assignment-literal
                 (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                 (repeat . t)
                 (modes  . '(enh-ruby-mode))))
  (add-to-list 'align-rules-list     ;TODO add to rcodetools.el
               '(ruby-xmpfilter-mark
                 (regexp . "\\(\\s-*\\)# => [^#\t\n]")
                 (repeat . nil)
                 (modes  . '(enh-ruby-mode)))))

(use-package motion-mode
  :commands (motion-recognize-project)
  :bind
  (:map
   motion-mode-map
   ("C-c C-c" . motion-execute-rake)
   ("C-c C-d" . motion-dash-at-point)
   )

  :init
  (add-hook 'ruby-mode-hook 'motion-recognize-project)
  (add-hook 'enh-ruby-mode-hook 'motion-recognize-project)
  )
