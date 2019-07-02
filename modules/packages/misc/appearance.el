(use-package delight
  :defer t
  :ensure t
  :config
  (delight '((projectile-mode " <p>" "Projectile")
	     (sh-mode " sh " "Shell-script[bash]")
	     (org-mode "" "Org")
	     (overwrite-mode " Ovl" t)
	     (special-mode " special" "special")
	     (message-mode " messages" "Messages")
	     (markdown-mode " md" "Markdown")
	     (fundamental-mode " fund" "Fundamental")
	     (web-mode " web" "Web")
	     (undo-tree-mode " " "Undo-Tree")
	     (super-save-mode "" "super-save")
	     (counsel-mode "" "counsel")
	     (abbrev-mode "" "Abbrev")
	     (evil-org-mode "" " EvilOrg")
	     (elmacro-mode " " "elmacro")
	     (ivy-mode "" "ivy")
	     (python-mode " py" " Python")
	     (emacs-lisp-mode " elisp" "Emacs-Lisp")
	     (lisp-interaction-mode " lisp int" "Lisp Interaction"))))

(use-package dimmer
  :unless window-system
  :defer t
  :ensure t
  :init
  (setq dimmer-fraction 0.2))

(use-package doom-modeline
  :ensure t
  :config
  (setq auto-revert-check-vc-info t)
  (doom-modeline-mode 1)
  (setq doom-modeline-icon t)
  (setq doom-modeline-project-root t)
  (setq find-file-visit-truename t)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-buffer-file-name-style 'buffer-name))

(use-package rich-minority
  :defer t
  :ensure t
  :config
  (rich-minority-mode 1)

  (setq rm-blacklist
	(format "^ \\(%s\\)$"
		(mapconcat #'identity
			   '("Fly.*" "Projectile.*" "PgLn" "Python 3.7.3" "elmacro.*")
			   "\\|")))

  )

(use-package noctilux-theme
:ensure t
:config
(load-theme 'noctilux t)
(defun noctilux-on ()
  (interactive)
  (load-theme 'noctilux)))

(use-package doom-themes
:ensure t
:config
(defun dracula-on ()
  (interactive)
  (load-theme 'doom-dracula)))
