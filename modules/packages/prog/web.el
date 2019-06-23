(use-package web-mode
  :if window-system
  :defer t
  :ensure t
  :init
  (add-hook 'web-mode-hook 'my/web-mode-hooks)
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :config
  (defun my/web-mode-hooks ()
    (interactive)
    (emmet-mode +1)
    (flycheck-mode +1)
    (evil-swap-keys-swap-double-single-quotes)
    (my/company-idle-one-prefix-one))

  (general-define-key
   :keymaps 'web-mode-map
   "<C-M-return>" 'browse-url-of-file)

  (general-unbind 'web-mode-map
    :with 'my/clear-html-macro
    [remap web-mode-comment-indent-new-line]))

(use-package web-beautify
:defer t
:ensure t)

(use-package emmet-mode
  :defer t
  :ensure t
  :config

  (imap
    :keymaps 'emmet-mode-keymap
    "C-M-h" 'emmet-prev-edit-point
    "C-M-l" 'emmet-next-edit-point)

  (general-define-key
   :keymaps 'emmet-mode-keymap
   "C-M-h" 'my/emmet-prev
   "C-M-l" 'my/emmet-next)

(defun my/emmet-prev ()
(interactive)
(emmet-prev-edit-point 1)
(evil-insert-state))

(defun my/emmet-next ()
(interactive)
(emmet-next-edit-point 1)
(evil-insert-state))

  (setq emmet-move-cursor-between-quotes t)
  (emmet-mode +1))
