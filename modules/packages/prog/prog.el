(use-package gitignore-mode
  :defer t
  :init
  (add-hook 'gitignore-mode-hook 'my/prog-mode-hooks)
  :ensure t)

(use-package elisp-mode
  :defer t
  :ensure nil
  :init
  (add-hook 'lisp-mode-hook 'my/elisp-hooks)
  (add-hook 'emacs-lisp-mode-hook 'my/elisp-hooks)
  (add-hook 'lisp-interaction-mode 'my/elisp-hooks)
  :config
  (defun my/elisp-hooks ()
    (interactive)
    (lispy-mode +1)
    (electric-operator-mode -1)
    (line-numbers)))

(use-package lispy
  :defer t
  :ensure t
  :config

  (general-unbind 'lispy-mode-map
    :with 'eyebrowse-prev-window-config
    [remap lispy-fill])

  (general-unbind 'lispy-mode-map
    :states '(insert)
    :with 'tab-to-tab-stop
    "M-i")

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
  :ensure t
  :init
  (add-hook 'lispy-mode-hook #'lispyville-mode)

  :config

  (general-define-key
   :keymaps 'lispyville-mode-map
   "C-M-h" 'lispyville-beginning-of-defun
   "C-M-l" 'lispyville-end-of-defun
   "C-M-k" 'lispy-up-slurp
   "C-M-j" 'lispy-down-slurp)

  (general-nmap
    :keymaps 'lispyville-mode-map
    "<" 'lispyville-barf
    ">" 'lispyville-slurp)

  (general-unbind 'lispyville-mode-map
    :with 'lispyville-comment-or-uncomment
    [remap evil-commentary])

  (with-eval-after-load 'lispyville
    (lispyville-set-key-theme
     '(operators
       c-w
       (escape insert)
       (additional-movement normal visual motion)))))

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
  :defer t
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
  (setq flycheck-display-errors-delay 0.1)
  (setq flycheck-idle-change-delay 0.1)
  (setq flycheck-clang-pedantic t)
  (setq flycheck-gcc-pedantic t))

(use-package flymake
  :defer t
  :ensure nil
  :init
  (setq-default flymake-no-changes-timeout 0.2))

(use-package subword
  :defer t
  :ensure nil
  :config
  (global-subword-mode +1))

(use-package company
  :defer t
  :ensure t

:config

(general-define-key
 :keymaps 'company-active-map
 "M-1" 'company-complete-number
 "M-2" 'company-complete-number
 "M-3" 'company-complete-number
 "M-4" 'company-complete-number
 "M-5" 'company-complete-number
 "M-6" 'company-complete-number
 "M-7" 'company-complete-number
 "M-8" 'company-complete-number
 "M-9" 'company-complete-number
 "M-0" 'company-complete-number
 "M-d" 'my/company-complete-paren
 "M-r" 'my/company-yasnippet
 "M-k" nil
 "M-l" nil
 "C-w" 'evil-delete-backward-word
 "C-h" 'delete-backward-char
 "<tab>" nil
 "M-q" 'my/company-complete-first
 "M-w" 'company-filter-candidates
 "<escape>" 'company-abort
 "<return>" 'company-complete
 "M-j" 'my/company-complete-first-add-space
 "M-o" 'my/company-yasnippet)

(general-define-key
 :keymaps 'company-filter-map
 "<tab>" 'company-complete
 "M-h" 'company-quickhelp-manual-begin
 "M-d" 'company-filter-candidates
 "C-k" 'my/company-complete
 "M-o" 'my/company-yasnippet)

(general-imap
  :keymaps 'company-mode-map
  "C-SPC" 'company-complete
  ;; "C-l" 'company-complete
  "M-/" 'hippie-expand)

(setq company-show-numbers t)
(setq company-idle-delay 0.5)
(setq-default company-idle-delay 0.5)
(setq company-auto-complete nil)
(setq company-auto-complete-chars '(46 61))
(setq company-tooltip-limit 10)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case nil)
(setq company-dabbrev-other-buffers t)
(setq company-selection-wrap-around t)
(setq company-minimum-prefix-length 2)
(setq company-dabbrev-code-everywhere t)
(setq company-dabbrev-code-ignore-case nil)
(setq company-dabbrev-ignore-buffers "nil")

(defun my/company-yasnippet ()
  (interactive)
  (company-abort)
  (yas-expand)))

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
  :defer t
  :ensure t
  :config
  (tab-jump-out-mode t))

(use-package electric-operator
  :defer t
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
  :ensure t
  ;; from http://bit.ly/2TEkmif
  ;; :bind (:map yas-minor-mode-map
  ;;             ("TAB" . nil)
  ;;             ("<tab>" . nil))
  :init
  (setq yas--default-user-snippets-dir "~/.emacs.d/etc/yasnippet/snippets")
  ;; (add-hook 'yas-before-expand-snippet-hook 'my/yas-before-hooks)
  ;; (add-hook 'yas-after-exit-snippet-hook 'my/yas-after-hooks)
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

;; (use-package yasnippet-classic-snippets
;;   :after yasnippet
;;   :ensure t)

(use-package yasnippet-snippets
  :after yasnippet
  :ensure t
  :config
  (yasnippet-snippets-initialize))

(use-package ivy-yasnippet
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

(use-package prescient
  :defer t
  :ensure t
  :config
  (prescient-persist-mode +1))

(use-package ivy-prescient
  :after ivy
  :ensure t
  :config
  (setq ivy-prescient-sort-commands '(counsel-find-library
                                      counsel-find-file
                                      counsel-ag
                                      counsel-org-capture))
  (ivy-prescient-mode +1))

(use-package company-prescient
  :after company
  :ensure t
  :config
  (company-prescient-mode +1)
  (prescient-persist-mode +1))

(use-package elec-pair
  :defer t
  :config
  (electric-pair-mode +1))

(use-package slime
  :defer t
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy))

  (general-unbind 'slime-repl-mode-map
    :with 'slime-repl-clear-buffer
    [remap recenter-top-bottom])

  (general-unbind 'slime-repl-mode-map
    :with 'other-window
    [remap my/quiet-save-buffer])

  (general-define-key
   :keymaps 'slime-mode-map
   "C-l" 'slime-repl-clear-buffer))


(use-package gist
  :defer t
  :ensure t
  :config
  (defadvice browse-url (after browse-url-after activate) (my/focus-chrome-delayed))
  (setq gist-view-gist t))
