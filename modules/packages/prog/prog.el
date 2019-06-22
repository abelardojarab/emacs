(use-package gitignore-mode
:defer t
:init
(add-hook 'gitignore-mode-hook 'my/prog-mode-hooks)
:ensure t)

(use-package elisp-mode
  :defer t
  :ensure nil
  :init
  (add-hook 'lisp-interaction-mode-hook 'line-numbers))

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
  (setq flycheck-display-errors-delay 1)
  (setq flycheck-idle-change-delay 0.5)
  (setq flycheck-clang-pedantic t)
  (setq flycheck-gcc-pedantic t))

(use-package subword
:defer 3
:ensure nil
:config
(global-subword-mode +1))

(use-package company
  :defer t
  :ensure t
  :init
  (setq company-auto-complete-chars '(46)) ;; only complete on dot "."
  (setq company-auto-complete t)
  (setq company-dabbrev-code-ignore-case t)
  (setq company-dabbrev-ignore-case t)
  (setq company-show-numbers t)
  (setq company-dabbrev-code-modes t)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-code-everywhere t)
  (setq company-dabbrev-other-buffers t)
  (setq company-dabbrev-ignore-buffers "nil")
  (setq company-selection-wrap-around t)

  :config

  (setq company-idle-delay 0.3)
  (setq-default company-idle-delay 0.3)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)

  ;; (advice-add 'company-complete-common :before (lambda () (setq my/company-point (point))))

  ;; (advice-add 'company-complete-common :after (lambda ()
  ;; 						(when (equal my/company-point (point))
  ;; 						  (yas-expand))))
  (general-define-key
   :keymaps 'company-active-map
   "1" 'company-complete-number
   "2" 'company-complete-number
   "3" 'company-complete-number
   "4" 'company-complete-number
   "5" 'company-complete-number
   "6" 'company-complete-number
   "7" 'company-complete-number
   "8" 'company-complete-number
   "9" 'company-complete-number
   "0" 'company-complete-number
   "M-f" 'company-filter-candidates
   "M-d" 'my/company-complete-paren
   "M-h" 'company-quickhelp-manual-begin
   "M-r" 'my/company-yasnippet
   "M-k" nil
   "M-l" nil
   ;; "M-w" 'company-select-next
   ;; "M-q" 'company-select-previous
   ;; "M-e" 'company-complete
   "C-w" 'evil-delete-backward-word
   "C-h" 'delete-backward-char
   "<tab>" 'my/company-complete-first
   "<escape>" nil
   "<return>" nil
   ;; "<return>" 'company-complete
   "M-j" 'my/company-complete-first-add-space
   "M-o" 'my/company-yasnippet)

  (general-define-key
   :keymaps 'company-filter-map
   "TAB" 'my/company-complete-first
   "M-h" 'company-quickhelp-manual-begin
   "M-d" 'company-filter-candidates
   ;; "C-l" 'company-complete
   "C-k" 'my/company-complete
   "M-o" 'my/company-yasnippet
   ;; "RET" 'company-complete
   "RET" nil)

  ;; (general-define-key
  ;;  :keymaps 'company-mode-map
  ;;  "C-x m" 'my/company-show-options)

  (general-imap
    :keymaps 'company-mode-map
    ;; "M-w" 'company-complete
    "C-l" 'company-complete
    "M-/" 'hippie-expand))

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
