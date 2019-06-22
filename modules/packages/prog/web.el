(use-package web-mode
  :if window-system
  :defer t
  :ensure t
  :init
  (add-hook 'web-mode-hook 'my/web-mode-hooks)
  :config
(defun my/web-mode-hooks ()
(interactive)
(emmet-mode +1)
(flycheck-mode +1)
(my/company-idle-one-prefix-one))

  (general-define-key
   :keymaps 'web-mode-map
   "<C-M-return>" 'browse-url-of-file)

(general-unbind 'web-mode-map
  :with 'my/clear-html-macro
  [remap web-mode-comment-indent-new-line])

  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))
;; (add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . html-mode))

(use-package emmet-mode
:defer t
:ensure t
:config
(emmet-mode +1))
