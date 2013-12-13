(autoload 'ruby-mode "ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(add-hook 'ruby-mode-hook
  '(lambda ()
     (electric-indent-mode t)
     (electric-layout-mode t)))

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

(defun flymake-ruby-init ()
  (progn
    (require 'flymake-easy)
    (require 'flymake-cursor)

    (defconst flymake-ruby-err-line-patterns
      '(("^\\(.*\.rb\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)))

    (defvar flymake-ruby-executable (concat (getenv "HOME") "/.rbenv/shims/ruby")
      "The ruby executable to use for syntax checking.")

    ;; Invoke ruby with '-c' to get syntax checking
    (defun flymake-ruby-command (filename)
      "Construct a command that flymake can use to check ruby source."
      (list flymake-ruby-executable "-w" "-c" filename))

    (defun flymake-ruby-load ()
      "Configure flymake mode to check the current buffer's ruby syntax."
      (interactive)
      (flymake-easy-load 'flymake-ruby-command
                         flymake-ruby-err-line-patterns
                         'tempdir
                         "rb"))
    (custom-set-variables
     '(help-at-pt-timer-delay 0.3)
     '(help-at-pt-display-when-idle '(flymake-overlay)))
    (flymake-ruby-load)
    ))

(add-hook 'ruby-mode 'flymake-ruby-init)


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
(add-hook 'ruby-mode-hook 'motion-recognize-project)
(add-to-list 'ac-modes 'motion-mode)
(add-to-list 'ac-sources 'ac-source-dictionary)

(let ((map motion-mode-map))
  (define-key map (kbd "C-c C-c") 'motion-execute-rake)
  (define-key map (kbd "C-c C-d") 'motion-dash-at-point)
  map)

