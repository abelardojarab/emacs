(use-package projectile
  :defer t
  :ensure t
  :config
  (load-file "~/.emacs.d/modules/packages/prog/projectile/projectile_settings.el"))

(use-package counsel-projectile
  :ensure t
  :after nswbuff
  :config
  (counsel-projectile-mode 1))
