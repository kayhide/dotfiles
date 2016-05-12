(eval-when-compile
  (require 'use-package))

(require 'bind-key)

(use-package helm
  :functions (helm-mode helm-descbinds-mode)
  :defines (helm-find-files-map helm-read-file-map)

  :bind
  (("C-c i" . helm-imenu)
   ("M-x" . helm-M-x)
   ("M-y" . helm-show-kill-ring)
   ("C-x C-f" . helm-find-files)
   ("C-x C-r" . helm-recentf)
   ("C-x C-p" . helm-projectile)
   ("C-x b" . helm-buffers-list)
   ("C-x C-b" . helm-for-files)

   :map helm-map
   ("C-h" . delete-backward-char)
   ("C-M-n" . helm-next-source)
   ("C-M-p" . helm-previous-source)

   :map helm-find-files-map
   ("TAB" . helm-execute-persistent-action)

   :map helm-read-file-map
   ("TAB" . helm-execute-persistent-action)

   :map isearch-mode-map
   ("C-o" . helm-occur-from-isearch))

  :config
  (require 'helm-config)
  (require 'helm-descbinds)
  (helm-mode)
  (helm-descbinds-mode)

  (setq-default moccur-split-word t)
  (setq helm-split-window-default-side 'right)
  ;; (setq helm-c-filelist-file-name "/tmp/all.filelist")
  ;; (setq helm-grep-candidates-fast-directory-regexp "^/tmp")
  ;; (custom-set-variables '(helm-ff-auto-update-initial-value nil))

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
  )

(use-package helm-swoop
  :bind
  (("M-i" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)

   :map isearch-mode-map
   ;; When doing isearch, hand the word over to helm-swoop
   ("M-i" . helm-swoop-from-isearch)

   :map helm-swoop-map
   ;; From helm-swoop to helm-multi-swoop-all
   ("M-i" . helm-multi-swoop-all-from-helm-swoop)

   ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
   ("M-m" . helm-multi-swoop-current-mode-from-helm-swoop)

   ;; Move up and down like isearch
   ("C-r" . helm-previous-line)
   ("C-s" . helm-next-line)

   :map helm-multi-swoop-map
   ("C-r" . helm-previous-line)
   ("C-s" . helm-next-line))

  :config
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)
  )

(use-package helm-gtags
  :commands (helm-gtags-mode)
  :bind
  (("M-C-." . helm-gtags-dwim)
   ("M-C-," . helm-gtags-show-stack)
   ("M-," . helm-gtags-previous-history)
   ("M-." . helm-gtags-next-history)
   ("M-*" . helm-gtags-pop-stack)
   ;; ("M-." . helm-gtags-find-tag-from-here)
   )
  :init
  (add-hook 'ruby-mode-hook 'helm-gtags-mode)
  (add-hook 'enh-ruby-mode-hook 'helm-gtags-mode)
  :config
  (setq helm-gtags-path-style 'root)
  ;; (setq helm-gtags-auto-update t)
  )
