(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-auto-configure t)
  (setq lsp-prefer-flymake nil)
  (use-package dap-mode)
  )

(use-package lsp-ui
  :commands lsp-ui-mode
  :config (setq lsp-ui-sideline-enable nil))

(use-package company-lsp
  :commands company-lsp
  :config (setq company-lsp-async t)
  )

(use-package lsp-python-ms
  :load-path "site/lsp-python-ms"
  :ensure nil
  :hook (python-mode . lsp)
  :config

  ;; for dev build of language server
  (setq lsp-python-ms-dir
        (expand-file-name "~/python-language-server/output/bin/Release/"))

  (setq lsp-python-ms-executable
        "~/python-language-server/output/bin/Release/ubuntu-x64/publish/Microsoft.Python.LanguageServer"))
    
(use-package yapfify)
(use-package py-isort)
 
(defun python-init ()
  (require 'lsp-python-ms)
  (require 'cl) ;; DAP uses CL's functions `first` and `last`
  (require 'dap-python)
  (flycheck-mode)
  (linum-mode 1)
  (dap-mode 1)
  (dap-ui-mode 1)
  (general-def 'normal 'local
    :prefix "SPC"
    "m" '("major mode")
    "m TAB" 'completion-at-point
    "mg" 'lsp-find-definition
    "ma" 'lsp-workspace-folders-add
    "mr" 'lsp-ui-peek-find-references
    "mR" 'lsp-find-references
    "mR" 'lsp-rename
    "mh" 'lsp-describe-thing-at-point
	"m=" 'yapfify-buffer
	"mi" 'py-isort-buffer
	"d" '("DAP debugging")
	"dd" 'dap-debug
	"db" 'dap-breakpoint-toggle
	"dB" 'dap-ui-breakpoints
	"dL" 'dap-ui-locals
	"dS" 'dap-ui-sessions
	"dR" 'dap-ui-repl
	"dI" 'dap-ui-inspect
    )
  )

;; Python hooks
(add-hook 'python-mode-hook 'python-init)
