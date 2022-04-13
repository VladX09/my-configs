;; Move out custom variables
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Config loader
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-emacs-directory)))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Packages list
;; use-package macro
(straight-use-package 'use-package)
(require 'use-package)

;; Theme
(straight-use-package 'doom-themes)

;; Keyboard
(straight-use-package 'evil)
(straight-use-package 'evil-escape)
(straight-use-package 'evil-surround)
(straight-use-package 'evil-collection)
(straight-use-package 'evil-indent-textobject)
(straight-use-package 'evil-nerd-commenter)
(straight-use-package 'which-key)
(straight-use-package 'general)
(straight-use-package 'move-text)

;; Organizational
(straight-use-package 'helm)
(straight-use-package 'projectile)
(straight-use-package 'helm-projectile)
(straight-use-package 'helm-ag)
(straight-use-package 'company)

;; Modes
(straight-use-package 'magit)
(straight-use-package 'markdown-mode)
(straight-use-package 'dockerfile-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'ledger-mode)
(straight-use-package 'org)

;; Config files
(load-user-file "basic.el")
(load-user-file "theme.el")
(load-user-file "keyboard.el")
(load-user-file "helm-conf.el")
(load-user-file "modes.el")
