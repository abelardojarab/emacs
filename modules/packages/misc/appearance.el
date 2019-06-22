(use-package delight
  :ensure t
  :config
  (delight 'projectile-mode " <p>" "Projectile")
  (delight 'sh-mode " sh " "Shell-script[bash]")
  (delight 'org-mode " org" "Org")
  (delight 'special-mode " special" "special")
  (delight 'message-mode " messages" "Messages")
  (delight 'markdown-mode " md" "Markdown")
  (delight 'fundamental-mode " fund" "Fundamental")
  (delight 'web-mode " web" "Web")
  (delight 'python-mode " py" " Python")
  (delight 'emacs-lisp-mode " elisp" "Emacs-Lisp")
  (delight 'lisp-interaction-mode " lisp int" "Lisp Interaction"))

(use-package dimmer
  :unless window-system
  :defer t
  :ensure t
  :init
  (setq dimmer-fraction 0.2))

(use-package doom-modeline
:ensure t
:config
(doom-modeline-mode 1)
(setq doom-modeline-icon nil)
(setq find-file-visit-truename t)
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-buffer-file-name-style 'buffer-name))

(use-package noctilux-theme
:ensure t
:config
(load-theme 'noctilux t)
(defun noctilux-on ()
  (interactive)
  (load-theme 'noctilux)))
