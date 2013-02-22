;; -*- coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ frame

(setq initial-frame-alist
      (append  '((width . 240)
                 (height . 80)
                 (alpha . 90)
                 (fullscreen . fullboth))
               initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

(setq split-width-threshold 100)

(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))
(global-set-key [f11] 'toggle-fullscreen)
