(use-package delight
  :ensure t)

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
  (setq doom-modeline-env-enable-python nil)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-icon t)
  (setq doom-modeline-project-root t)
  (setq find-file-visit-truename t)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-buffer-file-name-style 'buffer-name))

;; (use-package noctilux-theme
;;   :ensure t
;;   :config
;;   (load-theme 'noctilux t)
;;   (defun noctilux-on ()
;;     (interactive)
;;     (load-theme '
;;     noctilux)))

(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold 't)
  (setq custom-safe-themes t)
  :config
  (load-theme 'doom-dracula t))

(use-package poet-theme
  :defer t
  :ensure t
  :init
  (setq custom-safe-themes t)
  :config
  ;; https://emacs.stackexchange.com/a/45404
  (cl-loop for face in (face-list) do
           (unless (eq face 'default)
             (set-face-attribute face nil :height 1.0))))

(use-package cyberpunk-theme
  :defer t
  :ensure t
  :config
  (load-theme 'cyberpunk)
  ;; https://emacs.stackexchange.com/a/45404
  (cl-loop for face in (face-list) do
           (unless (eq face 'default)
             (set-face-attribute face nil :height 1.0))))

(use-package badwolf-theme
  :defer t
  :ensure t
  :config
  ;; https://emacs.stackexchange.com/a/45404
  (cl-loop for face in (face-list) do
           (unless (eq face 'default)
             (set-face-attribute face nil :height 1.0))))

(use-package kaolin-themes
  :defer t
  :ensure t
  :config
  ;; https://emacs.stackexchange.com/a/45404
  (cl-loop for face in (face-list) do
           (unless (eq face 'default)
             (set-face-attribute face nil :height 1.0))))
