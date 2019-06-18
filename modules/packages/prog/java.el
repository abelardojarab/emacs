(use-package cc-mode
  :ensure nil
  :init
  (add-hook 'java-mode-hook
	    (lambda ()
	      (c-set-style "java")
	      (electric-operator-mode t)
	      (aggressive-indent-mode t)
	      (olivetti-mode t)
	      (eclim-mode t)))
  :config

  (general-nvmap
    :keymaps 'java-mode-map
    "RET" 'hydra-java-mode/body))

(use-package eclim
  :after java
  :ensure t
  :init
  (setq eclimd-autostart t)
  :config
  (custom-set-variables
   '(eclim-eclipse-dirs '("/home/large/eclipse/eclipse"))))

(use-package company-emacs-eclim
:after eclim
:ensure t
:config
(company-emacs-eclim-setup))
