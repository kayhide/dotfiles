(eval-after-load 'projectile
  '(progn
    (defun projectile-dirname-matching-count (file file-other)
      "Count matching dirnames ascending file paths."
      (length
       (--take-while it (-zip-with 's-equals?
                                   (reverse (f-split (f-dirname file)))
                                   (reverse (f-split (f-dirname file-other)))))))

    (defun projectile-find-matching-test (file)
      "Compute the name of the test matching FILE."
      (let* ((basename (file-name-nondirectory (file-name-sans-extension file)))
             (test-affix (projectile-test-affix (projectile-project-type)))
             (candidates (-filter (lambda (current-file)
                                    (let ((current-file-basename (file-name-nondirectory (file-name-sans-extension current-file))))
                                      (or (s-equals? current-file-basename (concat test-affix basename))
                                          (s-equals? current-file-basename (concat basename test-affix)))))
                                  (projectile-current-project-files))))
        (cond
         ((null candidates) nil)
         ((= (length candidates) 1) (car candidates))
         (t (let ((grouped-candidates (--sort (> (car it) (car other)) (--group-by (projectile-dirname-matching-count file it) candidates))))
              (cond
               ((= (length (cdar grouped-candidates)) 1) (cadar grouped-candidates))
               (t (projectile-completing-read "Switch to: " (--mapcat (cdr it) grouped-candidates)))))))))

    (defun projectile-find-matching-file (test-file)
      "Compute the name of a file matching TEST-FILE."
      (let* ((basename (file-name-nondirectory (file-name-sans-extension test-file)))
             (test-affix (projectile-test-affix (projectile-project-type)))
             (candidates (-filter (lambda (current-file)
                                    (let ((current-file-basename (file-name-nondirectory (file-name-sans-extension current-file))))
                                      (or (s-equals? (concat test-affix current-file-basename) basename)
                                          (s-equals? (concat current-file-basename test-affix) basename))))
                                  (projectile-current-project-files))))
        (cond
         ((null candidates) nil)
         ((= (length candidates) 1) (car candidates))
         (t (let ((grouped-candidates (--sort (> (car it) (car other)) (--group-by (projectile-dirname-matching-count test-file it) candidates))))
              (cond
               ((= (length (cdar grouped-candidates)) 1) (cadar grouped-candidates))
               (t (projectile-completing-read "Switch to: " (--mapcat (cdr it) grouped-candidates)))))))))))
