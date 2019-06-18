(use-package elpy
  :ensure t
  :init
  (add-hook 'elpy-mode-hook
	    (lambda ()
	      (set (make-local-variable 'company-backends)
		   '((company-dabbrev-code company-yasnippet elpy-company-backend)))))

  :config
  (setq eldoc-idle-delay 2)
  (setq elpy-autodoc-delay 3)
  (setq elpy-eldoc-show-current-function nil)
  (setq python-shell-completion-native-enable nil)
  (elpy-enable)
  (general-define-key
   :keymaps 'elpy-mode-map
   "M-m" 'elpy-autopep8-fix-code
   "C-c C-c" 'elpy-multiedit-stop)
  (general-unbind 'elpy-mode-map
    :with 'ignore
    [remap elpy-shell-send-statement-and-step]))

(use-package blacken
  :unless window-system
  :defer t
  :ensure t
  :config
  (setq blacken-line-length 70))

(use-package pyenv-mode
  :defer t
  :ensure t
  :config
  (pyenv-mode)
(general-unbind 'pyenv-mode-map
  "C-c C-s"))

(use-package python
  :defer t
  :ensure nil
  :init
  (setq python-indent-offset 4)
  (setq python-indent-guess-indent-offset nil)
  (add-hook 'python-mode-hook 'my/python-mode-hooks)
  (add-hook 'python-mode-hook #'evil-swap-keys-swap-colon-semicolon)
  (add-hook 'python-mode-hook #'evil-swap-keys-swap-double-single-quotes)
  :config
  (auto-fill-mode 1)
  (setq comment-auto-fill-only-comments t)
  (defun my/python-save-buffer () (interactive)
	 (evil-ex-nohighlight)
	 (let ((inhibit-message t))
	   (delete-trailing-whitespace)
	   (save-buffer)))

  (load-file "~/.emacs.d/modules/packages/prog/python/python_keys.el")
  (load-file "~/.emacs.d/modules/packages/prog/python/python_functions.el"))

;; elpy-autopep8-fix-code
;; elpy-format-code
;; elpy-black-fix-code

;; elpy-enable
;; elpy-disable

;; elpy-doc

;; elpy-find-file

;; elpy-flymake-next-error
;; elpy-flymake-previous-error
;; elpy-flymake-show-error

;; elpy-goto-assignment
;; elpy-goto-assignment-other-window
;; elpy-goto-definition
;; elpy-goto-definition-other-window

;; elpy-multiedit
;; elpy-multiedit-add-overlay
;; elpy-multiedit-python-symbol-at-point
;; elpy-multiedit-stop

;; elpy-nav-backward-block
;; elpy-nav-backward-indent
;; elpy-nav-expand-to-indentation
;; elpy-nav-forward-block
;; elpy-nav-forward-indent

;; elpy-nav-indent-shift-left
;; elpy-nav-indent-shift-right
;; elpy-nav-move-line-or-region-down
;; elpy-nav-move-line-or-region-up

;; elpy-news

;; elpy-occur-definitions

;; elpy-refactor-mode
;; elpy-refactor-options

;; elpy-rgrep-symbol
;; elpy-set-project-root
;; elpy-set-project-variable

;; elpy-shell-switch-to-buffer
;; elpy-shell-switch-to-buffer-in-current-window
;; elpy-shell-switch-to-shell
;; elpy-shell-switch-to-shell-in-current-window
;; elpy-shell-toggle-dedicated-shell

(use-package importmagic
:defer t
:ensure t)
