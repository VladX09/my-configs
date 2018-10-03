;; Autocomletion via company and anaconda
(use-package rx)

(use-package company
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0))

(add-hook 'after-init-hook 'global-company-mode)

(use-package pyenv-mode)
(use-package pyenv-mode-auto)
(use-package company-anaconda)

(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))

(use-package flycheck
  :config
  (flycheck-define-checker
    python-mypy ""
    :command ("mypy"
              "--ignore-missing-imports" "--fast-parser"
              "--python-version" "3.6"
              source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ": error:" (message) line-end))
    :modes python-mode)

  (add-to-list 'flycheck-checkers 'python-mypy t)
  (flycheck-add-next-checker 'python-flake8 'python-mypy t)
  :general
    (leader-def "ts" 'flycheck-mode)
	(leader-def "el" 'flycheck-list-errors)
	(leader-def "en" 'flycheck-next-error)
	(leader-def "ep" 'flycheck-previous-error)
	(leader-def "ed" 'flycheck-describe-checker)
	(leader-def "es" 'flycheck-select-checker)
	(leader-def "ev" 'flycheck-verify-setup)
  )

(defun python-init ()
  (company-mode)
  (anaconda-mode)
  (anaconda-eldoc-mode)
  (flycheck-mode)
  (linum-mode 1)
  (setq flychek-checker 'python-flake8)
  (general-def 'normal 'local
    :prefix "SPC"
    "m" '("major mode")
    "m TAB" 'anaconda-mode-complete
    "mg" 'anaconda-mode-find-definitions
    "mG" 'anaconda-mode-find-definitions-other-window
    "ma" 'anaconda-mode-find-assignments
    "mA" 'anaconda-mode-find-assignments-other-window
    "mr" 'anaconda-mode-find-references
    "mR" 'anaconda-mode-find-references-other-window
    "mh" 'anaconda-mode-show-doc
    )
  )

;; Python hooks
(add-hook 'python-mode-hook 'python-init)
