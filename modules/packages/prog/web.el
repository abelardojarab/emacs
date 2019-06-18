(use-package web-mode
  :if window-system
  :defer t
  :ensure t
  :init
  (add-hook 'web-mode-hook 'emmet-mode)
  :config
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

(use-package emmet-mode
:if window-system
:after web-mode
:ensure t)

(use-package json-mode
:defer t
:init
(add-hook 'json-mode-hook 'flymake-json-load)
(add-hook 'json-mode-hook 'flycheck-mode)
:ensure t)

(use-package flymake-json
:defer t
:ensure t)

