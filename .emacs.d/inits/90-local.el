(eval-when-compile
  (require 'use-package)
  (require 'cl))

(use-package bind-key)
(use-package dash)

;; window split
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(bind-key "C-t" 'other-window-or-split)
(bind-key "C-M-t" 'delete-other-windows)

;; kill-all-buffers
(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer
        (-filter
         (lambda (buf)
           (with-current-buffer buf
             (or buffer-file-name
                 list-buffers-directory
                 (string-match-p "\*ag " (buffer-name))
                 (string-match-p "\*vc" (buffer-name)))))
         (buffer-list)))
  (delete-other-windows))
(bind-key "<f12>" 'kill-all-buffers)

;; save-buffer
(defadvice save-buffer (around save-buffer-around)
  (and current-prefix-arg
       (set-buffer-modified-p t))
  ad-do-it)
(ad-activate 'save-buffer)

;; what-cursor-position
(defadvice what-cursor-position (around what-cursor-position-around)
  (if current-prefix-arg
      (describe-char (point))
    ad-do-it
    ))
(ad-activate 'what-cursor-position)

;; minibuffer
(defun strip-last-basename ()
  (interactive)
  (let ((current-pt (point)))
    (goto-char (point-max))
    (when (re-search-backward "/[^/]+/?" nil t)
      (forward-char 1)
      (delete-region (point) current-pt))))
(bind-key "C-l" 'strip-last-basename minibuffer-local-map)
