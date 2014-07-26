(require 'helm-config)
;; (setq helm-c-filelist-file-name "/tmp/all.filelist")
;; (setq helm-grep-candidates-fast-directory-regexp "^/tmp")
;; (custom-set-variables '(helm-ff-auto-update-initial-value nil))

(eval-after-load 'helm
  '(let ((map helm-map))
     (define-key map (kbd "C-h") 'delete-backward-char)
     (define-key map (kbd "C-M-n") 'helm-next-source)
     (define-key map (kbd "C-M-p") 'helm-previous-source)
     map))
(eval-after-load 'helm-mode
  '(progn
     (setq helm-split-window-default-side 'right)
     (add-to-list 'helm-completing-read-handlers-alist
                  '(find-file . nil))
     (add-to-list 'helm-completing-read-handlers-alist
                  '(find-file-at-point . nil))
     (add-to-list 'helm-completing-read-handlers-alist
                  '(dired-do-rename . nil))
     (add-to-list 'helm-completing-read-handlers-alist
                  '(dired-do-copy . nil))
     (add-to-list 'helm-completing-read-handlers-alist
                  '(dired-do-copy-regexp . nil))
     (add-to-list 'helm-completing-read-handlers-alist
                  '(dired-create-directory . nil))
     (add-to-list 'helm-completing-read-handlers-alist
                  '(lgrep . nil))
     ))
(helm-mode)

(require 'helm-descbinds)
(helm-descbinds-mode)

(setq moccur-split-word t)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
