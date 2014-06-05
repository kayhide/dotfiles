(eval-when-compile (require 'cl))

(defvar installing-package-list
  '(open-junk-file
    redo+
    sequential-command
    ag
    wgrep
    wgrep-ag
    color-moccur
    migemo
    color-theme
    auto-complete
    yasnippet
    projectile
    helm
    helm-ag
    helm-descbinds
    helm-c-yasnippet
    helm-projectile
    lispxmp
    smartparens
    auto-async-byte-compile
    magit
    git-gutter-fringe
    org
    enh-ruby-mode
    motion-mode
    emmet-mode
    slim-mode
    scss-mode
    markdown-mode
    pandoc-mode
    pov-mode
    ))

(let ((not-installed (loop for x in installing-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))



(require 'open-junk-file)

(require 'redo+)
(setq undo-no-redo t)

(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'wgrep)

(require 'color-moccur)

(require 'migemo)

(projectile-global-mode)

(require 'git-gutter-fringe)
(global-git-gutter-mode t)
