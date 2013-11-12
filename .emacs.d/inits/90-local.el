;; window split
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

;; kill-all-buffers
(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows)
  )

;; minibuffer
(defun strip-last-basename ()
  (interactive)
  (let ((current-pt (point)))
    (when (re-search-backward "/[^/]+/?" nil t)
      (forward-char 1)
      (delete-region (point) current-pt))))

;; deneb-mode
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'deneb-mode)
