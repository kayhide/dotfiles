; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;;; package --- Summary

;;; Commentary:

;;; Code:
(eval-when-compile (require 'cl))

;; util-funcs
(defun merge-pathnames (name dir)
  (concat (file-name-as-directory dir) name)
  )

(defun root-directory-p (dir)
  (string= ""
           (file-name-nondirectory
            (directory-file-name dir))))


(defvar deneb-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<f5>") 'rake-preview)
    (define-key map (kbd "C-<f5>") 'rake-show)
    (define-key map (kbd "S-C-<f5>") 'rake-analyze)
    (define-key map (kbd "<f6>") 'rake-rebuild)
    (define-key map (kbd "C-<f6>") 'rake-deploy)
    (define-key map (kbd "<f7>") 'rake-material-build)
    (define-key map (kbd "C-<f7>") 'rake-material-rebuild)
    (define-key map (kbd "C-c 8 s") 'deneb-open-setting-file)
    (define-key map (kbd "C-c 8 r") 'deneb-open-rakefile)
    map)
  "Keymap used in deneb mode.")

(define-minor-mode deneb-mode
  "deneb Mode"
  nil
  " deneb"
  deneb-mode-map)

(defvar deneb-setting-entry ".deneb")
(defvar deneb-buffer-name "*deneb*")

(defvar deneb-debug-rake nil)

(defvar deneb-root-directory nil)
(set (make-local-variable 'deneb-root-directory) nil)

(defvar deneb-setting-file nil)
(set (make-local-variable 'deneb-setting-file) nil)

(defun deneb-initialize ()
  (when buffer-file-name
    (and
     (set (make-local-variable 'deneb-root-directory)
          (deneb-find-root-directory buffer-file-name))
     (set (make-local-variable 'deneb-setting-file)
          (deneb-find-setting-file))
     (deneb-mode))))

(defun deneb-find-root-directory (file)
  (loop
   for dir = file then (expand-file-name "../" dir)
   do (if (root-directory-p dir)
          (return nil))
   do (if (and (file-readable-p (merge-pathnames deneb-setting-entry dir))
               (file-readable-p (merge-pathnames "erb" dir))
               (file-readable-p (merge-pathnames "Rakefile" dir))
               )
          (return dir))))

(defun deneb-find-setting-file ()
  (let ((candidates (list (merge-pathnames "init.rb" deneb-setting-entry)
                          deneb-setting-entry)))
    (find-if 'file-readable-p
             (mapcar
              (lambda (arg) (merge-pathnames arg deneb-root-directory))
              candidates))))

(defun deneb-shell-command ()
  (interactive)
  (let ((buf (current-buffer))
        (dir default-directory))
    (setq default-directory deneb-root-directory)
    (call-interactively 'shell-command)
    (with-current-buffer buf
      (setq default-directory dir))))


(defun deneb-open-setting-file ()
  (interactive)
  (when deneb-root-directory
    (find-file (deneb-find-setting-file))))

(defun deneb-open-rakefile ()
  (interactive)
  (when deneb-root-directory
    (find-file (merge-pathnames "Rakefile" deneb-root-directory))))

;;;rake
(defun rake-call (arg)
  (apply 'start-process
         (append (list "deneb-process" deneb-buffer-name "rake" arg)
                 (if deneb-debug-rake (list "--trace"))))
  (display-buffer deneb-buffer-name))


(defun rake-rebuild ()
  (interactive) (rake-call "rebuild"))
(defun rake-deploy ()
  (interactive) (rake-call "deploy"))
(defun rake-material-build ()
  (interactive) (rake-call "material_build"))
(defun rake-material-rebuild ()
  (interactive) (rake-call "material_rebuild"))
(defun rake-preview ()
  (interactive) (rake-call "preview"))
(defun rake-show ()
  (interactive) (rake-call "show"))
(defun rake-analyze ()
  (interactive) (rake-call "analyze"))

;;;###autoload
(add-hook 'find-file-hooks 'deneb-initialize)

(provide 'deneb-mode)

;;; deneb-mode.el ends here
