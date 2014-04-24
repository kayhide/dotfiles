(eval-when-compile (require 'cl))

(defvar installing-package-list
  '(open-junk-file
    redo+
    sequential-command
    wgrep
    color-moccur
    igrep
    migemo
    color-theme
    auto-complete
    yasnippet
    helm
    helm-descbinds
    helm-c-yasnippet
    lispxmp
    paredit
    auto-async-byte-compile
    enh-ruby-mode
    rinari
    motion-mode
    emmet-mode
    scss-mode
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
(setq wgrep-enable-key (kbd "r"))

(require 'color-moccur)

(require 'igrep)
(igrep-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-Ou8"))
(igrep-find-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-Ou8"))

(require 'migemo)

(projectile-global-mode)

