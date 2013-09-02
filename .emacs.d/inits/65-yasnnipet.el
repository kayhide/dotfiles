(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"
                         "~/.emacs.d/snippets_imported"))
(yas-global-mode 1)
(setq yas-buffer-local-condition t)

(require 'helm-c-yasnippet)

(let ((map yas-minor-mode-map))
  (define-key map (kbd "C-<tab>") 'yas-expand)
  (define-key map (kbd "TAB") nil)
  (define-key map (kbd "<tab>") nil)
  (define-key map (kbd "C-x i i") 'helm-c-yas-complete)
  (define-key map (kbd "C-x i n") 'yas-new-snippet)
  (define-key map (kbd "C-x i v") 'yas-visit-snippet-file)
  map)

(let ((map yas-keymap))
  (define-key map (kbd "C-<tab>") 'yas-next-field-or-maybe-expand)
  (define-key map (kbd "TAB") nil)
  (define-key map (kbd "<tab>") nil)
  map)

;; (add-hook 'rinari-minor-mode-hook
;;           (lambda ()
;;             (add-to-list 'yas-extra-modes 'rails-mode)))


(defun helm-yas-prompt (prompt choices &optional display-fn)
   (let* ((names (loop for choice in choices
                       collect (or (and display-fn (funcall display-fn choice))
                                   choice)))
          (selected (helm-other-buffer
                     `(((name . ,(format "%s" prompt))
                        (candidates . names)
                        (action . (("insert snippet" . (lambda (arg) arg))))))
                     "*helm yas-prompt*")))
     (if selected
         (let ((n (position selected names :test 'equal)))
           (nth n choices))
       (signal 'quit "user quit!"))))
(custom-set-variables '(yas-prompt-functions '(helm-yas-prompt)))
