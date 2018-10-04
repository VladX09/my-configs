(use-package helm
  :config
  (require 'helm-config)
  (setq helm-split-window-in-side-p t)
  (setq helm-autoresize-max-height 40)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (helm-mode 1)
  )

(use-package projectile
  :config
  (projectile-mode +1)
  )

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package helm-ag)
(use-package magit)
(use-package evil-magit)
