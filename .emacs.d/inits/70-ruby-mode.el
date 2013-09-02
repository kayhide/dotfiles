(autoload 'ruby-mode "ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

(eval-after-load 'align
  '(progn
     (add-to-list 'align-rules-list
                  '(ruby-comma-delimiter
                    (regexp . ",\\(\\s-*\\)[^# \t\n]")
                    (repeat . t)
                    (modes  . '(ruby-mode))))
     (add-to-list 'align-rules-list
                  '(ruby-hash-literal
                    (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
                    (repeat . t)
                    (modes  . '(ruby-mode))))
     (add-to-list 'align-rules-list
                  '(ruby-assignment-literal
                    (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                    (repeat . t)
                    (modes  . '(ruby-mode))))
     (add-to-list 'align-rules-list     ;TODO add to rcodetools.el
                  '(ruby-xmpfilter-mark
                    (regexp . "\\(\\s-*\\)# => [^#\t\n]")
                    (repeat . nil)
                    (modes  . '(ruby-mode))))))


;; ------------------------------------------------------------------------
;; @ rinari
(require 'rinari)
(global-rinari-mode t)
(setq rinari-tags-file-name "TAGS")

(let ((map ruby-mode-map))
  (define-key map (kbd "C-x C-e") nil)
  map)
