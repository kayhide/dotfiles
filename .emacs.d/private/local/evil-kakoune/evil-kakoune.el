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

(defun evil-visual-before-pre-move (expanding)
  "When expanding and 'evil-state' is not 'visual', enter 'visual'."
    (interactive)
      (if (and expanding (not (eq 'visual evil-state)))
          (evil-visual-char)
        )
    )

(defun evil-visual-after-pre-move (expanding)
  "When not expanding and 'evil-state' is 'visual', exit and re-enter 'visual'.
Otherwise enter 'visual' if not.
"
    (interactive)
  (if (and (not expanding) (eq 'visual evil-state))
      (evil-exit-visual-state)
    )
  (if (not (eq 'visual evil-state))
      (evil-visual-char)
    )
    )


(defun evil-kakoune-forward-word-begin (&optional expanding)
  (interactive)
    (evil-visual-before-pre-move expanding)
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
     ))
    (evil-visual-after-pre-move expanding)


  (let ((last (point))
        (bol (line-beginning-position))
        (eol (line-end-position))
        )
    (cond
     ((< bol eol)
      (evil-forward-word-begin)
      (cond
       ((< last eol (point))
        (evil-goto-char eol)
        )
       ((or
         (evil-looking-at "[^[:word:]][[:word:]]")
         (evil-looking-at "[[:space:]][^[:space:]]")
         )
        (evil-backward-char)
        )))))
  )

(defun evil-kakoune-forward-word-end (&optional expanding)
  (interactive)
    (evil-visual-before-pre-move expanding)
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
     ))
    (evil-visual-after-pre-move expanding)
  (evil-forward-word-end)
  )

(defun evil-kakoune-backward-word-begin (&optional expanding)
  (interactive)
    (evil-visual-before-pre-move expanding)
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
       )))
    (evil-visual-after-pre-move expanding)
  (evil-backward-word-begin)
  )

(defun evil-kakoune-line (&optional expanding)
  (interactive)
  (let ((last (point))
        (bol (line-beginning-position))
        (eol (line-end-position))
       )
    (cond
     ((and (eq 'visual evil-state) (= last bol))
      (evil-goto-char (1+ bol))
      )
     (t
      (evil-beginning-of-line)
      )
     )
    )
  (if (and (not expanding) (eq 'visual evil-state))
      (evil-exit-visual-state)
    )
  (evil-visual-char)
  (evil-end-of-line)
  )


(defun expanding (action)
  (lambda ()
    (interactive)
    (funcall action t)
    )
  )

(defun evil-kakoune ()
  (define-key evil-normal-state-map (kbd "d") 'evil-delete-char)
  (define-key evil-normal-state-map (kbd "U") 'evil-redo)
  (define-key evil-normal-state-map (kbd "M-j") 'evil-join)
  (define-key evil-normal-state-map (kbd ">") 'eri-indent)
  (define-key evil-normal-state-map (kbd "<") 'eri-indent-reverse)
  (define-key evil-visual-state-map (kbd "d") 'evil-delete)
  (define-key evil-visual-state-map (kbd ";") 'evil-exit-visual-state)
  (define-key evil-visual-state-map (kbd "R") 'spacemacs/evil-mc-paste-after)

  (define-key evil-normal-state-map (kbd "g h") 'evil-beginning-of-line)
  (define-key evil-normal-state-map (kbd "g l") 'evil-end-of-line)
  (define-key evil-normal-state-map (kbd "g k") 'evil-goto-first-line)
  (define-key evil-normal-state-map (kbd "g j") 'evil-goto-line)
  (define-key evil-normal-state-map (kbd "m") 'evil-jump-item)

  (define-key evil-normal-state-map (kbd "w") 'evil-kakoune-forward-word-begin)
  (define-key evil-normal-state-map (kbd "W") (expanding 'evil-kakoune-forward-word-begin))
  (define-key evil-visual-state-map (kbd "w") 'evil-kakoune-forward-word-begin)
  (define-key evil-visual-state-map (kbd "W") (expanding 'evil-kakoune-forward-word-begin))

  (define-key evil-normal-state-map (kbd "e") 'evil-kakoune-forward-word-end)
  (define-key evil-normal-state-map (kbd "E") (expanding 'evil-kakoune-forward-word-end))
  (define-key evil-visual-state-map (kbd "e") 'evil-kakoune-forward-word-end)
  (define-key evil-visual-state-map (kbd "E") (expanding 'evil-kakoune-forward-word-end))

  (define-key evil-normal-state-map (kbd "b") 'evil-kakoune-backward-word-begin)
  (define-key evil-normal-state-map (kbd "B") (expanding 'evil-kakoune-backward-word-begin))
  (define-key evil-visual-state-map (kbd "b") 'evil-kakoune-backward-word-begin)
  (define-key evil-visual-state-map (kbd "B") (expanding 'evil-kakoune-backward-word-begin))

  (define-key evil-normal-state-map (kbd "x") 'evil-kakoune-line)
  (define-key evil-normal-state-map (kbd "X") (expanding 'evil-kakoune-line))
  (define-key evil-visual-state-map (kbd "x") 'evil-kakoune-line)
  (define-key evil-visual-state-map (kbd "X") (expanding 'evil-kakoune-line))


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
