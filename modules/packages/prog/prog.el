(use-package gitignore-mode
:defer t
:init
(add-hook 'gitignore-mode-hook 'my/prog-mode-hooks)
:ensure t)

(use-package elisp-mode
  :defer t
  :ensure nil
  :init
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  (add-hook 'lisp-interaction-mode-hook 'line-numbers))

(use-package lispy
  :defer t
  :ensure t
  :config

  (general-unbind 'lispy-mode-map
    :with 'eyebrowse-prev-window-config
    [remap lispy-fill])

  (general-unbind 'lispy-mode-map
    :with 'indent-buffer
    [remap lispy-meta-return])

  (general-unbind 'lispy-mode-map
    :with 'org-edit-src-exit
    [remap lispy-mark-symbol])

  (general-unbind 'lispy-mode-map
    :states '(normal visual)
    :with 'org-edit-src-exit
    "<backspace>"))

(use-package lispyville
:defer t
:ensure nil
:init
(add-hook 'lispy-mode-hook #'lispyville-mode))

(use-package quickrun
  :defer t
  :ensure t
  :config

  (defun my/quickrun ()
    (interactive)
    (my/python-save-buffer)
    (quickrun))

  (general-unbind 'quickrun--mode-map
    :with 'quit-window
    [remap my/quiet-save-buffer])
  (general-unbind 'compilation-mode-map
    :with 'quit-window
    [remap my/quiet-save-buffer]))

(use-package smart-hungry-delete
  :defer 5
  :ensure t
  :config
  (general-nvmap
    :keymaps 'override
    "X" 'smart-hungry-delete-forward-char)
  (smart-hungry-delete-add-default-hooks))

(use-package dumb-jump
:defer t
:ensure t
:config
(setq dumb-jump-selector 'ivy))

(use-package highlight-numbers
:defer t
:ensure t)

(use-package highlight-operators
:defer t
:ensure t)

(use-package flycheck
  :defer t
  :init
  (eval-after-load 'flycheck
    '(flycheck-add-mode 'html-tidy 'web-mode))
  :ensure t
  ;; :init
  ;; (add-hook 'flycheck-mode-hook 'flycheck-buffer)
  :config
  (setq flycheck-mode-line nil)
  (setq flycheck-gcc-warnings nil)
  (setq flycheck-clang-warnings nil)
  (setq flycheck-display-errors-delay 0.3)
  (setq flycheck-idle-change-delay 0.1)
  (setq flycheck-clang-pedantic t)
  (setq flycheck-gcc-pedantic t))

(use-package flymake
  :defer t
  :ensure nil
  :init
  (setq-default flymake-no-changes-timeout 0.2))

(use-package subword
:defer 3
:ensure nil
:config
(global-subword-mode +1))

(use-package company
  :defer t
  :ensure t
  :config
(defun my/company-yasnippet ()
(interactive)
(company-abort)
(yas-expand))

  (load-file "~/.emacs.d/modules/packages/prog/misc/company_settings.el")
  (load-file "~/.emacs.d/modules/packages/prog/misc/company_keys.el")
  (global-company-mode t))

(use-package company-shell
  :after company
  :ensure t
  :init
  (add-to-list 'company-backends 'company-shell t)
  (setq company-shell-modes '(sh-mode fish-mode shell-mode eshell-mode text-mode prog-mode lisp-interaction-mode markdown-mode))
  :config
  (setq company-shell-delete-duplicates t)
  (setq company-fish-shell-modes nil))

(use-package pos-tip
:defer t
:ensure t
:config
(setq pos-tip-border-width 3)
(setq pos-tip-internal-border-width 3)
(setq pos-tip-background-color "grey9")
(setq pos-tip-foreground-color "yellow1"))

(use-package company-prescient
:after company
:ensure t
:config
(company-prescient-mode +1)
(prescient-persist-mode +1))

(use-package tab-jump-out
  :defer 3
  :ensure t
  :config
  (tab-jump-out-mode t))

(use-package electric-operator
:ensure t
:config
(electric-operator-add-rules-for-mode 'python-mode
                                      (cons "+" " + ")
                                      (cons "-" " - ")
                                      (cons "ndd" " and ")
                                      (cons "ntt" " not ")))

(use-package aggressive-indent
  :defer t
  :ensure t
  :config
  (setq aggressive-indent-sit-for-time 0.05))

(use-package yasnippet
  :defer 1
  :ensure t
  ;; from http://bit.ly/2TEkmif
  :bind (:map yas-minor-mode-map
	      ("TAB" . nil)
	      ("<tab>" . nil))
  :init
  (setq yas--default-user-snippets-dir "~/.emacs.d/etc/yasnippet/snippets")
  (add-hook 'yas-before-expand-snippet-hook 'my/yas-before-hooks)
  (add-hook 'yas-after-exit-snippet-hook 'my/yas-after-hooks)
  :config

  (defun my/company-yas-snippet ()
    (interactive)
    (company-abort)
    (evil-insert-state)
    (yas-expand))

  (general-imap
    "M-r" 'yas-expand)

  (general-unbind 'yas-keymap
    :with 'my/jump-out
    [remap kill-ring-save])

  (defun my/jump-out ()
    (interactive)
    (evil-append 1))

  (defun my/yas-load-other-window ()
    (interactive)
    (yas-load-snippet-buffer '## t)
    (other-window -1))

  (defun my/yas-load-other-kill-contents-other-window ()
    (interactive)
    (yas-load-snippet-buffer '## t)
    (other-window -1)
    (kill-buffer-contents)
    (evil-insert-state))

  (setq yas-also-auto-indent-first-line t)
  (setq yas-indent-line 'auto)

  (defun my/yas-before-hooks ()
    (interactive)
    (electric-operator-mode -1))

  (defun my/yas-after-hooks ()
    (interactive)
    (electric-operator-mode +1))

  (general-imap
    :keymaps 'yas-minor-mode-map
    "M-u" 'ivy-yasnippet)

  (general-nmap
    :keymaps 'yas-minor-mode-map
    "M-u" 'ivy-yasnippet)

  (general-unbind 'snippet-mode-map
    :with 'ignore
    [remap my/quiet-save-buffer])

  (general-nvmap
    :keymaps 'snippet-mode-map
    "<C-return>" 'yas-load-snippet-buffer-and-close
    "<M-return>" 'my/yas-load-other-window
    "<C-M-return>" 'my/yas-load-other-kill-contents-other-window
    "M-;" 'hydra-yasnippet/body)

  (general-imap
    :keymaps 'snippet-mode-map
    "M-;" 'hydra-yasnippet/body
    "DEL" 'evil-delete-backward-char-and-join)

  (setq yas-triggers-in-field nil)
  (yas-global-mode +1))

(use-package yasnippet-classic-snippets
  :after yasnippet
  :ensure t)

(use-package yasnippet-snippets
  :after yasnippet
  :ensure t
  :config
  (yasnippet-snippets-initialize))

(use-package ivy-yasnippet
  :after yasnippet
  :ensure t)

(use-package java-snippets
  :after yasnippet
  :ensure t)




(use-package rainbow-delimiters
:defer t
:ensure t)

(use-package highlight-indent-guides
:defer t
:ensure t)

(use-package string-inflection
  :defer t
  :ensure t
  :config
  (setq string-inflection-skip-backward-when-done nil))
