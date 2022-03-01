;; -*- mode: emacs-lisp; lexical-binding: t -*-

(require 'cl-lib)

(require 'evil-commands)

(defun evil-looking-at (ptn)
  "When 'evil-state' is 'visual', 'looking-at' function sees one point ahead.
This function compasate for the difference.
"
  (interactive)
  (cond
   ((eq 'visual evil-state)
    (save-excursion
      (evil-goto-char (1- (point)))
      (looking-at ptn)
      )
    )
   (t
    (looking-at ptn)
    )
   )
  )

(cl-defun evil-kakoune-move (&key key action expanding-key pre)
  (define-key evil-normal-state-map key
    (lambda ()
      (interactive)
      (if pre (funcall pre))
      (evil-visual-char)
      (funcall action)
      ))
  (define-key evil-visual-state-map key
    (lambda ()
      (interactive)
      (if pre (funcall pre))
      (evil-exit-visual-state)
      (evil-visual-char)
      (funcall action)
      ))
  (cond
   (expanding-key
    (define-key evil-normal-state-map expanding-key
      (lambda ()
        (interactive)
        (if pre (funcall pre))
        (evil-visual-char)
        (funcall action)
        ))
    (define-key evil-visual-state-map expanding-key
      (lambda ()
        (interactive)
        (if pre (funcall pre))
        (funcall action)
        ))
    ))
  )


(defun evil-kakoune ()
  (define-key evil-normal-state-map (kbd "d") 'evil-delete-char)
  (define-key evil-normal-state-map (kbd "U") 'evil-redo)
  (define-key evil-normal-state-map (kbd "M-j") 'evil-join)
  (define-key evil-visual-state-map (kbd "d") 'evil-delete)
  (define-key evil-visual-state-map (kbd ";") 'evil-exit-visual-state)
  (define-key evil-visual-state-map (kbd "R") 'spacemacs/evil-mc-paste-after)

  (define-key evil-normal-state-map (kbd "g h") 'evil-beginning-of-line)
  (define-key evil-normal-state-map (kbd "g l") 'evil-end-of-line)
  (define-key evil-normal-state-map (kbd "g k") 'evil-goto-first-line)
  (define-key evil-normal-state-map (kbd "g j") 'evil-goto-line)
  (define-key evil-normal-state-map (kbd "m") 'evil-jump-item)

  (evil-kakoune-move
   :key (kbd "w")
   :expanding-key (kbd "W")
   :action
   (lambda ()
     (let ((last (point))
           (bol (line-beginning-position))
           (eol (line-end-position))
           )
       (cond
        ((< bol eol)
         (evil-forward-word-begin)
         (cond
          ((< last eol (point))
           (evil-goto-char (1- eol))
           )
          ((or
            (evil-looking-at "[^[:word:]][[:word:]]")
            (evil-looking-at "[[:space:]][^[:space:]]")
            )
           (evil-backward-char)
           ))))))
   :pre
   (lambda ()
     (let ((last (point))
           (bol (line-beginning-position))
           (eol (line-end-position))
           )
       (cond
        ((= bol eol)
         (evil-goto-char (+ 1 (point)))
         )
        ((= last eol)
         (evil-goto-char (+ 2 (point)))
         )
        ((or
          (evil-looking-at "[[:word:]][[:word:]]")
          (evil-looking-at "[[:space:]][[:space:]]")
          )
         )
        (t
         (evil-forward-char 1 nil t)
         )
        ))))

  (evil-kakoune-move
   :key (kbd "b")
   :expanding-key (kbd "B")
   :action
   (lambda ()
    (evil-backward-word-begin)
    )
   :pre
   (lambda ()
     (let ((last (point))
           (bol (line-beginning-position))
           (eol (line-end-position))
           )
       (cond
        ((or
          (= bol eol)
          (= last eol)
          (evil-looking-at "[[:word:]]")
          (evil-looking-at "[[:space:]][[:space:]]")
          )
         )
        (t
         (evil-backward-char 1 nil t)
         )
        ))))

  (evil-kakoune-move
   :key (kbd "e")
   :expanding-key (kbd "E")
   :action
   (lambda ()
     (evil-forward-word-end)
     )
   :pre
   (lambda ()
     (let ((last (point))
           (bol (line-beginning-position))
           (eol (line-end-position))
           )
       (cond
        ((= bol eol)
         (evil-goto-char (+ 1 (point)))
         )
        ((= last eol)
         (evil-goto-char (+ 2 (point)))
         )
        ((or
          (evil-looking-at "[[:word:]][[:word:]]")
          (evil-looking-at "[[:space:]][[:space:]]")
          )
         )
        (t
         (evil-forward-char 1 nil t)
         )
        )))
   )

  (define-key evil-normal-state-map (kbd "x")
    (lambda () (interactive)
      (evil-beginning-of-line)
      (evil-visual-line)
      (evil-end-of-line)
      ))
  (define-key evil-normal-state-map (kbd "X")
    (lambda () (interactive)
      (evil-beginning-of-line)
      (evil-visual-line)
      (evil-end-of-line)
      ))

  (define-key evil-visual-state-map (kbd "x")
    (lambda () (interactive)
      (evil-exit-visual-state)
      (evil-beginning-of-line)
      (evil-visual-line)
      ))
  (define-key evil-visual-state-map (kbd "X") 'evil-next-line)

  (define-key evil-normal-state-map (kbd "H")
    (lambda () (interactive)
      (evil-visual-char)
      (evil-backward-char)
      ))
  (define-key evil-normal-state-map (kbd "J")
    (lambda () (interactive)
      (evil-visual-char)
      (evil-next-line)
      ))
  (define-key evil-normal-state-map (kbd "K")
    (lambda () (interactive)
      (evil-visual-char)
      (evil-previous-line)
      ))
  (define-key evil-normal-state-map (kbd "L")
    (lambda () (interactive)
      (evil-visual-char)
      (evil-forward-char)
      ))

  (define-key evil-visual-state-map (kbd "h")
    (lambda () (interactive)
      (evil-exit-visual-state)
      (evil-backward-char)
      ))
  (define-key evil-visual-state-map (kbd "H")
    (lambda () (interactive)
      (evil-backward-char)
      ))

  (define-key evil-visual-state-map (kbd "j")
    (lambda () (interactive)
      (evil-exit-visual-state)
      (evil-next-line)
      ))
  (define-key evil-visual-state-map (kbd "J")
    (lambda () (interactive)
      (evil-next-line)
      ))

  (define-key evil-visual-state-map (kbd "k")
    (lambda () (interactive)
      (evil-exit-visual-state)
      (evil-previous-line)
      ))
  (define-key evil-visual-state-map (kbd "K")
    (lambda () (interactive)
      (evil-previous-line)
      ))

  (define-key evil-visual-state-map (kbd "l")
    (lambda () (interactive)
      (evil-exit-visual-state)
      (evil-forward-char)
      ))
  (define-key evil-visual-state-map (kbd "L")
    (lambda () (interactive)
      (evil-forward-char)
      ))

)

(defun evil-kakoune-activate ()
  (with-eval-after-load 'evil
    (evil-kakoune)
    )
  )

(provide 'evil-kakoune)
