(use-package projectile
  :defer t
  :ensure t
  :config
  (load-file "~/.emacs.d/modules/packages/prog/projectile/projectile_settings.elc"))

(use-package counsel-projectile
  :defer t
  :ensure t
  :config
  (counsel-projectile-mode 1))
