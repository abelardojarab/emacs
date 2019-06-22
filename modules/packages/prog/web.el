;; (use-package web-mode
;;   :if window-system
;;   :defer t
;;   :ensure t
;;   ;; :init
;;   ;; (remove-hook 'web-mode-hook 'emmet-mode)
;;   ;; (remove-hook 'web-mode-hook 'flycheck-mode)
;;   :config
;;  (general-define-key
;;   :keymaps 'web-mode-map
;;   "<C-M-return>" 'browse-url-of-file)

;;   (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . html-mode))

(use-package emmet-mode
:defer t
:ensure t
:config
(emmet-mode +1))
