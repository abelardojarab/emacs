(use-package web-mode
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
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  :config
  (defun my/web-mode-hooks ()
    (interactive)
    (emmet-mode +1)
    (flycheck-mode +1)
    (evil-swap-keys-swap-double-single-quotes)
    (my/company-idle-one-prefix-one-quiet)
    (my/set-web-theme))

  (general-nvmap
    :keymaps 'web-mode-map
    "C-ç" 'my/erase-buffer-yank
    "M-ç" 'copy-to-chrome
    "C-c ç" 'web-beautify-html)

  (defun my/set-web-theme ()
    (interactive)
    (disable-theme 'noctilux)
    (load-theme 'doom-dracula))

  (general-define-key
   :keymaps 'web-mode-map
   "C-ç" 'my/erase-buffer-yank
   "M-ç" 'copy-to-chrome
   "C-c ç" 'web-beautify-html
   "<C-M-return>" 'browse-url-of-file)

  (general-unbind 'web-mode-map
    :with 'my/clear-html-macro
    [remap web-mode-comment-indent-new-line])

  (defun my/erase-buffer-yank ()
    (interactive)
    (erase-buffer)
    ;; (insert "!")
    ;; (emmet-expand-line nil)
    (yank nil)
    (evil-window-middle)
    ;; (web-beautify-html)
    ))

(use-package web-beautify
:after web-mode
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

(use-package css
  :init
  (add-hook 'css-mode-hook  'emmet-mode)
  :ensure nil)

(use-package js2-mode
  :defer t
  :ensure t
  :init
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (general-define-key
   :keymaps '  js2-mode-map
   "<return>" 'js2-refactor-hydra/body)

  )

(use-package js2-refactor
  :defer t
  :ensure t)
