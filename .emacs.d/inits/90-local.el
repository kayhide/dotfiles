(eval-when-compile (require 'cl))

;; window split
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

;; kill-all-buffers
(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer
        (remove-if-not
         (lambda (buf)
           (with-current-buffer buf
             (or buffer-file-name
                 list-buffers-directory)))
         (buffer-list)))
  (delete-other-windows))

;; save-buffer
(defadvice save-buffer (around save-buffer-around)
  (and current-prefix-arg
       (set-buffer-modified-p t))
  ad-do-it)
(ad-activate 'save-buffer)

;; minibuffer
(defun strip-last-basename ()
  (interactive)
  (let ((current-pt (point)))
    (goto-char (point-max))
    (when (re-search-backward "/[^/]+/?" nil t)
      (forward-char 1)
      (delete-region (point) current-pt))))

;; deneb-mode
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'deneb-mode)
