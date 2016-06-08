(eval-when-compile
  (require 'use-package))

(require 'bind-key)

(use-package org
  :defer t
  :config
  (setq-default org-src-fontify-natively t)
  (setq-default org-html-doctype "html5")
  (setq-default org-latex-pdf-process
        '("ptex2pdf -l %f" "ptex2pdf -l %f" "ptex2pdf -l %f"))
  (setq-default org-latex-classes
        '(("jsarticle"
           "\\documentclass{jsarticle}"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
  (setq-default org-latex-default-class "jsarticle")
  (bind-key "C-M-t" nil org-mode-map)
  )
