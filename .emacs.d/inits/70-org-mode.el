(eval-after-load 'org
  '(progn
     (setq org-src-fontify-natively t)))

(eval-after-load 'org
  '(let ((map org-mode-map))
     (define-key map (kbd "C-M-t") nil)
     map))
