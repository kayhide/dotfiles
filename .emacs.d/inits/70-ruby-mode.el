;; ------------------------------------------------------------------------
;; @ rbenv
(add-to-list 'exec-path (expand-file-name "~/.rbenv/shims"))
(add-to-list 'exec-path (expand-file-name "~/.rbenv/bin"))


;; ------------------------------------------------------------------------
;; @ enh-ruby
(autoload 'enh-ruby-mode "enh-ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '(".rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '(".cap$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '(".thor$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '(".pryrc$" . enh-ruby-mode))

(setq-default ruby-insert-encoding-magic-comment nil)

(custom-set-variables
 '(enh-ruby-add-encoding-comment-on-save nil)
 '(enh-ruby-deep-indent-paren nil)
 )
(custom-set-faces
 '(erm-syn-errline ((t (:underline (:color "red")))))
 '(erm-syn-warnline ((t (:underline (:color "orange"))))))

(eval-after-load 'align
  '(progn
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
                    (modes  . '(enh-ruby-mode))))))

;; ------------------------------------------------------------------------
;; @ inf-ruby
(require 'inf-ruby)
(setq-default inf-ruby-default-implementation "pry")
(setq-default inf-ruby-eval-binding "Pry.toplevel_binding")

(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

;; ------------------------------------------------------------------------
;; @ motion
(require 'motion-mode)
;; following adding of hook is very important.
(add-hook 'enh-ruby-mode-hook 'motion-recognize-project)
(add-to-list 'ac-modes 'motion-mode)
(add-to-list 'ac-sources 'ac-source-dictionary)

(let ((map motion-mode-map))
  (define-key map (kbd "C-c C-c") 'motion-execute-rake)
  (define-key map (kbd "C-c C-d") 'motion-dash-at-point)
  map)
