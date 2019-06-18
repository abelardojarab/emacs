(use-package smartparens
  :defer 3
  :ensure t
  :config
  (setq sp-escape-quotes-after-insert nil)
  (smartparens-global-mode +1))

(use-package elec-pair
  :defer t)

(use-package lispyville
  :defer t
  :init
  (add-hook 'lisp-mode-hook #'lispyville-mode)
  (add-hook 'emacs-lisp-mode-hook #'lispyville-mode)
  :ensure t)
