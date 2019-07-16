(use-package projectile
  :defer t
  :ensure t
  :config
  (load-file "~/.emacs.d/modules/packages/prog/projectile/projectile_settings.el"))

(use-package counsel-projectile
  :ensure t
  :config
  (setq counsel-projectile-org-capture-templates '(("n" "[${name}] Notes" entry
                                                    (file+headline "${root}/notes.org" "Notes")
                                                    "* TODO %?\n*From*: %f")))
  (counsel-projectile-mode 1))
