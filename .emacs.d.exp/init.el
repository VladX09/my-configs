;; Bootstrap `use-package'

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

; Path to ~/.emacs.d
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory) user-emacs-directory)
        ((boundp 'user-init-directory)  user-init-directory)
        (t "~/.emacs.d/")))

; Config loader
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))


(load-user-file "basic.el")
(load-user-file "keyboard.el")
(load-user-file "helm-conf.el")
(load-user-file "theme.el")
(load-user-file "python-conf.el")
(load-user-file "org.el")
;; (load-user-file "python-ls.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centered-window-mode t)
 '(custom-safe-themes
   (quote
	("6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" default)))
 '(cwm-centered-window-width 150)
 '(package-selected-packages
   (quote
	(helm-ag py-isort yapfify centered-window exec-path-from-shell sdev-mypy olivetti evil-magit pyenv-mode which-key use-package move-text helm-projectile general evil-surround evil-nerd-commenter evil-leader evil-indent-textobject evil-escape dracula-theme doom-themes dired-sidebar darktooth-theme cyberpunk-theme company-anaconda ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#282c34")))))
(put 'dired-find-alternate-file 'disabled nil)
