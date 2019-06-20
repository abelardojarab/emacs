(use-package elpy
  :ensure t
  :init
  (add-hook 'elpy-mode-hook
	    (lambda ()
	      (set (make-local-variable 'company-backends)
		   '((elpy-company-backend
		      company-dabbrev-code
		      company-yasnippet)))))

  :config

  (defun my/elpy-goto-definition ()
    (interactive)
    (elpy-goto-definition)
    (recenter))

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

(use-package importmagic
:defer t
:ensure t)
