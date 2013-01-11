; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;;; package --- Summary

;;; Commentary:

;;; Code:
(eval-when-compile (require 'cl))

(defvar deneb-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<f5>") 'rake-preview)
    (define-key map (kbd "C-<f5>") 'rake-show)
    (define-key map (kbd "<f6>") 'rake-rebuild)
    (define-key map (kbd "C-<f6>") 'rake-deploy)
    (define-key map (kbd "<f7>") 'rake-material-build)
    (define-key map (kbd "C-<f7>") 'rake-material-rebuild)
    (define-key map (kbd "C-8 C-s") 'deneb-open-setting-file)
    map)
  "Keymap used in deneb mode.")

(define-minor-mode deneb-mode
  "deneb Mode"
  )


(put 'deneb-root-directory 'safe-local-variable 'stringp)
(put 'deneb-setting-filename 'safe-local-variable 'stringp)
(defvar deneb-root-directory nil)
(set (make-local-variable 'deneb-root-directory) nil)
(defvar deneb-setting-filename ".deneb")
(defvar deneb-buffer-name "*deneb*")

(defvar deneb-debug-rake nil)

(defun merge-pathnames (name dir)
  (concat (file-name-as-directory dir) name)
  )

(defun root-directory-p (dir)
(string= ""
	 (file-name-nondirectory
	  (directory-file-name dir))))

(defun deneb-initialize ()
  (when buffer-file-name
    (set (make-local-variable 'deneb-root-directory)
	  (deneb-find-root-directory buffer-file-name))
    (if deneb-root-directory
	(deneb-mode))))

(defun deneb-find-root-directory (file)
  (loop
   for dir = file then (expand-file-name "../" dir)
   do (if (root-directory-p dir)
	  (return nil))
   do (if (file-readable-p (merge-pathnames deneb-setting-filename dir))
	  (return dir))))

(defun deneb-shell-command ()
  (interactive)
  (let ((buf (current-buffer))
	(dir default-directory))
    (setq default-directory deneb-root-directory)
    (call-interactively 'shell-command)
    (with-current-buffer buf
      (setq default-directory dir))
    ))

(defun deneb-open-setting-file ()
  (interactive)
  (when deneb-root-directory
    (find-file (merge-pathnames deneb-setting-filename deneb-root-directory))))

;;;rake
(defun call-rake (arg)
  (apply 'start-process
  	 (append (list "deneb-process" deneb-buffer-name "rake" arg)
  		 (if deneb-debug-rake (list "--trace"))))
  (display-buffer deneb-buffer-name))


(defun rake-rebuild ()
  (interactive) (call-rake "rebuild"))
(defun rake-deploy ()
  (interactive) (call-rake "deploy"))
(defun rake-material-build ()
  (interactive) (call-rake "material_build"))
(defun rake-material-rebuild ()
  (interactive) (call-rake "material_rebuild"))
(defun rake-preview ()
  (interactive) (call-rake "preview"))
(defun rake-show ()
  (interactive) (call-rake "show"))

;;;###autoload
(add-hook 'find-file-hooks 'deneb-initialize)

(provide 'deneb-mode)

;;; deneb-mode.el ends here
