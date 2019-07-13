(use-package elpy
  :ensure t
  ;; :init
  ;; (add-hook 'elpy-mode-hook
  ;; 	    (lambda ()
  ;; 	      (set (make-local-variable 'company-backends)
  ;; 		   '((elpy-company-backend
  ;; 		      company-dabbrev-code
  ;; 		      company-yasnippet)))))

  :defer t
  :config

  (defun my/elpy-goto-definition ()
    (interactive)
    (elpy-goto-definition)
    (recenter))

  (setq eldoc-idle-delay 15)
  (setq elpy-autodoc-delay 15)
  (setq elpy-eldoc-show-current-function nil)
  (setq python-shell-completion-native-enable nil)

  (general-unbind 'elpy-mode-map
    :with 'elpy-nav-backward-block
    [remap cool-moves/word-backwards])

  (general-unbind 'elpy-mode-map
    :with 'elpy-nav-forward-block
    [remap cool-moves/word-forward])

  (general-define-key
   :keymaps 'elpy-mode-map
   "M-m" 'elpy-autopep8-fix-code
   "C-c C-c" 'elpy-multiedit-stop)

  (general-unbind 'elpy-mode-map
    :with 'pop-tag-mark
    [remap yafolding-toggle-all])

  (general-unbind 'elpy-mode-map
    :with nil
    [remap elpy-goto-definition])

  (general-unbind 'elpy-mode-map
    :with 'ignore
    [remap elpy-shell-send-statement-and-step])
  (elpy-enable))

(use-package blacken
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
  :after python
  :ensure t
  :config
  (setq importmagic-be-quiet t)
  (add-hook 'python-mode-hook 'importmagic-mode))

(use-package company-jedi
:defer t
:ensure t)

(use-package yafolding
:after python
:ensure t
:config

(general-unbind 'yafolding-mode-map
  :with 'yafolding-toggle-element
  [remap hs-toggle-hiding])

(general-unbind 'yafolding-mode-map
  :with 'yafolding-show-all
  [remap outline-show-all])

(general-unbind 'yafolding-mode-map
  :with 'yafolding-hide-all
  [remap evil-close-folds])

(yafolding-mode +1))

;; (use-package live-py-mode
;;   :defer t
;;   :ensure t
;;   :config
;;   (setq live-py-update-all-delay 0.3)
;;   (live-py-mode))
