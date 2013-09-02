;; @ window split
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))


;; @ deneb-mode
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'deneb-mode)
