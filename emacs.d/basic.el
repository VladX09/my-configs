(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(global-hl-line-mode +1)
(show-paren-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time(setq-default indent-tabs-mode nil)

;; add advices for window splitting during centered mode
(advice-add 'split-window-sensibly :around 'ensure-centered-mode)
(advice-add 'split-window-right :around #'ensure-centered-mode)

;; TODO: add nop when centered mode is disabled
(defun ensure-centered-mode (split-fun &rest args)
  (centered-window-mode-toggle)
  (apply split-fun args)
  (centered-window-mode-toggle)
  ) 

(defun kill-other-buffers ()
	"Kill all other buffers."
	(interactive)
	(mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun close-and-kill-this-pane ()
	"If there are multiple windows, then close this pane and kill the buffer in it also."
	(interactive)
	(kill-this-buffer)
	(if (not (one-window-p))
		(delete-window)))

(defun close-and-kill-next-pane ()
	"If there are multiple windows, then close the other pane and kill the buffer in it also."
	(interactive)
	(other-window 1)
	(kill-this-buffer)
	(if (not (one-window-p))
		(delete-window)))
;; Kills ledger/magit/etc... special (automatic) windows on 'q' kbd
(defun quit-and-kill-auxiliary-windows ()
  "Kill buffer and its window on quitting"
  (local-set-key (kbd "q") 'kill-buffer-and-window))
(add-hook 'special-mode-hook #'quit-and-kill-auxiliary-windows)
