(use-package focus
  :defer t
  :ensure t)

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

;; (use-package smart-mode-line
;;   :ensure t
;;   :config
;;   (load-file "~/.emacs.d/modules/packages/misc/sml/sml-replace.el")
;;   (load-file "~/.emacs.d/modules/packages/misc/sml/sml-blacklist.el")
;;   (setq sml/line-number-format " %3l")
;;   (setq sml/name-width '20)
;;   (setq sml/theme 'dark)
;;   (setq sml/show-file-name t)
;;   (setq sml/no-confirm-load-theme t)
;;   (setq sml/directory-truncation-string " ")
;;   (sml/setup))

(use-package doom-modeline
:ensure t
:config
(doom-modeline-mode 1)
(setq doom-modeline-icon nil)
(setq find-file-visit-truename t)
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-buffer-file-name-style 'buffer-name)
;; (setq doom-modeline-buffer-file-name-style 'relative-to-project)
;; (setq doom-modeline-buffer-file-name-style 'truncate-except-project)
)

;; (setq custom-safe-themes t)
;; (load-theme 'deeper-blue)

(use-package noctilux-theme
:ensure t
:config
(load-theme 'noctilux t)
(defun noctilux-on ()
  (interactive)
  (load-theme 'noctilux)))

;; (use-package poet-theme
;;   :defer t
;;   :ensure t)
