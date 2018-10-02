(use-package helm
  :config
  (require 'helm-config)
  (setq helm-split-window-in-side-p t)
  (setq helm-autoresize-max-height 40)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (helm-mode 1)
  )

(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (defun dired-sidebar-sidebar-root()
    default-directory)
  )

(use-package projectile
  :config
  (projectile-mode +1)
  )

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package magit)
(use-package evil-magit)
