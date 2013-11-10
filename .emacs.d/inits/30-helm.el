(require 'helm-config)
;; (setq helm-c-filelist-file-name "/tmp/all.filelist")
;; (setq helm-grep-candidates-fast-directory-regexp "^/tmp")
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
                  '(find-file-at-point . nil))))
(helm-mode)


(require 'helm-descbinds)
(helm-descbinds-mode)

(setq moccur-split-word t)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
