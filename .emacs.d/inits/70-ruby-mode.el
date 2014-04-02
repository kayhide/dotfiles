;; ------------------------------------------------------------------------
;; @ rbenv
(add-to-list 'exec-path (expand-file-name "~/.rbenv/shims"))
(add-to-list 'exec-path (expand-file-name "~/.rbenv/bin"))


;; ------------------------------------------------------------------------
;; @ enh-ruby
(autoload 'enh-ruby-mode "enh-ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . enh-ruby-mode))

(add-hook 'enh-ruby-mode-hook
          (setq enh-ruby-deep-indent-paren nil)
          (custom-set-faces
           '(erm-syn-errline ((t (:underline (:color "red"))))))
          (custom-set-faces
           '(erm-syn-warnline ((t (:underline (:color "orange")))))))

(eval-after-load 'align
  '(progn
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
;; @ rinari
(require 'rinari)
(global-rinari-mode t)
(setq rinari-tags-file-name "TAGS")

(let ((map ruby-mode-map))
  (define-key map (kbd "C-x C-e") nil)
  map)


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

