(require 'helm)
(require 'helm-config)
(require 'helm-descbinds)
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
     (defvar helm-completing-read-handlers-alist)
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
(helm-descbinds-mode)

(setq-default moccur-split-word t)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)



(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)
