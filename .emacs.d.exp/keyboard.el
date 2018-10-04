;; Configure evil
(use-package evil
  :config
  (evil-mode 1)

  (use-package evil-escape
    :config
    (evil-escape-mode 1)
    (setq-default evil-escape-key-sequence "fd")
    (setq-default evil-escape-delay 0.2))

  (use-package evil-surround
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject)
  (use-package evil-nerd-commenter)
  )

;; Configure which-key
(use-package which-key
  :init
  (setq which-key-enable-extended-define-key t)
  :config
  (which-key-setup-side-window-bottom)
  (which-key-mode))

;; Install additional packages and functions
(use-package general)
(use-package move-text) 

(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))

(defun insert-line-above ()
  "Insert an empty line above the current line."
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))


(setq unwanted-buffer-names '("\\*.*\\*"))

(defun unwanted-buffer-p (name)
  (let (result)
    (dolist (bad-name unwanted-buffer-names result)
      (when (string-match-p bad-name name)
        (setq result t))
      )))

(defadvice next-buffer (after avoid-buffers-next)
  "Advice around `next-buffer' to avoid going into service buffers"
  (when (unwanted-buffer-p (buffer-name))
    (next-buffer)
    )
  )

(defadvice previous-buffer (after avoid-buffers-previous)
  "Advice around `previous-buffer' to avoid going into service buffers"
  (when (unwanted-buffer-p (buffer-name))
    (previous-buffer)
    )
  )

;; activate the advice
(ad-activate 'next-buffer)
(ad-activate 'previous-buffer)

(use-package centered-window
  :config
  (setq-default olivetti-body-width 0.85))

;; Set leader SPC prefix
(defconst leader-key "SPC")
(general-create-definer leader-def
 :states 'normal
 :keymaps 'override
 :prefix leader-key)

;; Define shut-up key :)
(general-def 'override
  "M-q" 'keyboard-escape-quit
  )

;; Set leader prefixes
(leader-def
  "f" '("files")
  "b" '("buffers")
  "q" '("quit")
  "w" '("window")
  "a" '("applications")
  "t" '("toggle")
)

;; Set leader keys
(leader-def
  "SPC" '("exec" . helm-M-x)
  "TAB" 'other-window

  "w3" 'split-window-right
  "w2" 'split-window-below
  "wd" 'delete-window
  "wc" 'centered-window-mode

  "ff" 'helm-find-files
  "bb" 'helm-mini

  "bd" 'kill-this-buffer
  "bx" 'kill-buffer-and-window
  "bn" 'next-buffer
  "bp" 'previous-buffer

  "qq" 'save-buffers-kill-emacs
  "qQ" 'kill-emacs

  "h" '("helm" . helm-command-prefix)

  "ad" 'dired

  "tn" 'linum-mode

  "/" '("search" . helm-do-grep-ag)

  "p" '("projectile" . projectile-command-map)

  "gs" 'magit-status
  "gm" 'magit-dispatch-popup
  )

(general-def 'normal 'with-editor-mode-map
  ",," 'with-editor-finish
  ",k" 'with-editor-cancel
  )

(general-def 'normal 'global
  "gc" 'evilnc-comment-operator
  "[e" 'move-text-up
  "]e" 'move-text-down
  "[[" 'evil-backward-section-begin
  "]]" 'evil-backward-section-end
  "]b" 'next-buffer
  "[b" 'previous-buffer
  "[ SPC" 'insert-line-above
  "] SPC" 'insert-line-below
  )


(general-def 'normal 'dired-mode-map
  "RET" 'dired-find-alternate-file
  "^" (lambda () (interactive) (find-alternate-file ".."))
  )

(general-def 'helm-map
  "ESC" 'keyboard-escape-quit
  "C-z" 'helm-select-action
  "<tab>" 'helm-execute-persistent-action
  )
