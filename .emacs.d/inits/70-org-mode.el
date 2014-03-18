(eval-after-load 'org
  '(progn
     (setq org-src-fontify-natively t)
     (setq org-html-doctype "html5")
     (setq org-latex-pdf-process
           '("ptex2pdf -l %f" "ptex2pdf -l %f" "ptex2pdf -l %f"))
     (setq org-latex-classes
           '(("jsarticle"
              "\\documentclass{jsarticle}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
     (setq org-latex-default-class "jsarticle")
     ))

(eval-after-load 'org
  '(let ((map org-mode-map))
     (define-key map (kbd "C-M-t") nil)
     map))
