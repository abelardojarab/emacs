(use-package hideshow
  :ensure nil
  :config

  (general-unbind 'hs-minor-mode-map
    :with 'hs-toggle-hiding
    [remap evil-toggle-fold])

  (general-unbind 'hs-minor-mode-map
    :with 'hs-hide-all
    [remap evil-close-folds])

  (general-unbind 'hs-minor-mode-map
    :with 'hs-show-all
    [remap outline-show-all]))

(use-package filesets
  :ensure nil
  :config
  (load-file "~/.emacs.d/modules/settings/filesets.el")
  (filesets-init))

;; (use-package select
;;   :if (not window-system)
;;   :ensure nil
;;   :config
;;   (setq x-select-enable-primary nil))

(use-package ibuffer
  :ensure nil
  :init
  (remove-hook 'ibuffer-hook 'my/truncate-on))

(use-package info
  :ensure nil
  :init
  (add-hook 'Info-mode-hook 'my/info-hook-commands)
  :config

  (defun my/info-hook-commands ()
    (interactive)
    (line-numbers-absolute)
    (hl-line-mode +1))

  (defun my/info-commands ()
    (interactive)
    (counsel-M-x "^Info- "))

  ;; (general-unbind 'Info-mode-map
  ;;   :with 'ignore
  ;;   [remap evil-exit-emacs-state])

  ;; (general-unbind 'Info-mode-map
  ;;   :with 'ignore
  ;;   [remap evil-normal-state])

  (general-define-key
   :keymaps 'Info-mode-map
   "c" 'my/info-commands
   "C-x i" 'find-info-keys)

  (general-nvmap
    :keymaps 'Info-mode-map
    "gb" 'counsel-bookmark
    "m" 'Info-menu
    "l" 'forward-char
    "C-j" 'counsel-M-x
    ;; "C-c C-c" 'my/eval-next-sexp
    "h" 'backward-char
    "H" 'evil-window-top
    "M" 'evil-window-middle
    "L" 'evil-window-bottom
    "c" 'my/info-commands
    "o" 'link-hint-open-link
    "C-M-h" 'Info-history-back
    "C-M-l" 'Info-history-forward))

;; (general-define-key
;;  :keymaps 'Info-mode-map
;;  "j" 'next-line
;;  "k" 'previous-line
;;  "l" 'Info-history-forward
;;  "h" 'Info-history-back
;;  "G" 'end-of-buffer
;;  "<home>" 'beginning-of-buffer
;;  "<end>" 'end-of-buffer)

;; (use-package bs
;;   :ensure nil
;;   :init
;;   (setq bs-configurations '(("all" nil nil nil nil nil)

;; 			    ("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)

;; 			    ("files-and-scratch" "^\\*scratch\\*$" "^info_keys.org$" nil bs-visits-non-file bs-sort-buffer-interns-are-last)

;; 			    ("all-intern-last" nil nil nil nil bs-sort-buffer-interns-are-last))))

(use-package c-mode
  :defer t
  ;; :ensure cc-mode
  :init
  (setq-default c-default-style "linux")
  (add-hook 'c-mode-hook 'my/prog-mode-hooks)
  :config
  (defun my/execute-c-program ()
    (interactive)
    (defvar foo)
    (setq foo (concat "gcc " (buffer-name) " && ./a.out" ))
    (shell foo))

  (defun my/execute-c-program-shell ()
    (interactive)
    (progn
      (prelude-copy-file-name-to-clipboard)
      (shell)
      (insert "sp")
      (comint-send-input)
      (insert "gcc ")
      (yank)
      (insert " && ./a.out")
      (comint-send-input)
      (sit-for 0.3)
      (comint-clear-buffer)))

  (general-imap
    :keymaps 'c-mode-map
    "<M-return>" 'indent-buffer
    "C-;" 'my/c-semicolon-del-blank-lines)
  (general-nvmap
    :keymaps 'c-mode-map
    "zk" 'flycheck-previous-error
    "zj" 'flycheck-next-error
    "$" 'c-end-of-statement
    "0" 'c-beginning-of-statement
    "M-v" 'c-goto-vars
    "<C-backspace>" 'xah-clean-empty-lines
    "<escape>" 'my/quiet-save-buffer-c
    "<M-return>" 'indent-buffer
    "<backspace>" 'hydra-c-mode/body))

(use-package shell
  :defer t
  :ensure nil
  :init
  (setq comint-terminfo-terminal "ansi")
  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
  (add-hook 'shell-mode-hook 'my/shell-mode-hooks)
  (add-hook 'shell-mode-hook
	    (lambda ()
	      (face-remap-set-base 'comint-highlight-prompt :inherit nil)))
  :config

(defun my/shell-mode-hooks ()
  (interactive)
  (subword-mode 1)
  (company-mode 1)
  (smartparens-mode 1)
  (tab-jump-out-mode 1)
  (electric-pair-local-mode 1)
  (my/company-idle-one-prefix-one)
  (my/shell-source-bashrc))

(defun my/shell-go-up ()
  (interactive)
  (insert "cd ..")
  (comint-send-input)
  (comint-clear-buffer)
  (insert "ls")
  (comint-send-input))

(defun my/shell-go-back ()
  (interactive)
  (comint-clear-buffer)
  (insert "cd - && ls")
  (comint-send-input))

(defun my/shell-fasd-start ()
  (interactive)
  (insert "jj "))

(defun my/shell-fasd-complete ()
  (interactive)
  (comint-send-input)
  (comint-clear-buffer)
  (insert "ls")
  (comint-send-input))

(defun my/shell-go-previous ()
  (interactive)
  (comint-clear-buffer)
  (insert "my-shell-go-previous")
  (comint-send-input)
  (comint-clear-buffer)
  (insert "ls")
  (comint-send-input))
;;; shell_extras.el ends here

(general-imap
  :keymaps 'shell-mode-map
  "C-u" 'comint-kill-input
  "C-p" 'comint-previous-input
  "C-n" 'comint-next-input
  "C-c u" 'universal-argument
  "C-l" 'comint-clear-buffer
  "M-u" 'my/shell-go-up
  "C-t" 'my/shell-go-back
  "C-c ;" 'kill-buffer-and-window
  "C-/" 'my/shell-clear-and-list
  "M-p" 'my/shell-go-previous
  "C-c j" 'my/evil-shell-bottom)

(vmap
  :keymaps 'shell-mode-map
  "C-;" 'my/yank-shell-to-notes)

(nvmap
  :keymaps 'shell-mode-map
  "C-c u" 'universal-argument
  "C-l" 'comint-clear-buffer
  "M-u" 'my/shell-go-up
  "C-t" 'my/shell-go-back
  "C-c ;" 'kill-buffer-and-window
  "M-p" 'my/shell-go-previous
  "C-/" 'my/shell-clear-and-list
  "C-c ;" 'kill-buffer-and-window
  "C-j" 'counsel-M-x)

(general-define-key
 :keymaps 'shell-mode-map
 "C-j" 'counsel-M-x
 "M-u" 'my/shell-go-up
 "C-u" 'comint-kill-input
 "<M-return>" nil
 "C-;" 'kill-buffer-and-window
 "C-t" 'my/shell-go-back
 "C-c 0" 'my/jump-to-register-91
 "M-e" 'counsel-shell-history
 "C-n" 'comint-next-input
 "C-l" 'comint-clear-buffer
 "C-c u" 'universal-argument
 "M-p" 'my/shell-go-previous
 "C-p" 'comint-previous-input
 "C-c j" 'my/evil-shell-bottom)

(general-unbind 'shell-mode-map
  :with 'ignore
  [remap my/quiet-save-buffer])

(general-unbind 'shell-mode-map
  :with nil
  [remap hydra-text-main/body])

(defun my/shell-resync ()
  (interactive)
  (comint-kill-whole-line 1)
  (shell-resync-dirs)
  (comint-clear-buffer)
  (insert "ls")
  (comint-send-input))

(defun my/shell-list ()
  (interactive)
  (insert "ls")
  (comint-send-input))

(defun my/shell-clear-and-list ()
  (interactive)
  (comint-clear-buffer)
  (insert "ls")
  (comint-send-input))

(defun my/shell-source-bashrc ()
  (interactive)
  (insert "source ~/.bashrc")
  (comint-send-input)
  (comint-clear-buffer))
)

(use-package eshell
  :defer t
  :ensure nil
  :init
  (setq eshell-banner-message "")
  (setq comint-terminfo-terminal "ansi")
  (add-hook 'eshell-mode-hook 'my/load-eshell-keybindings)
  (defun my/load-eshell-keybindings ()
    (interactive)
    (load-file "~/.emacs.d/lisp/functions/eshell_keybindings.el")))

(use-package calc
:defer t
  :ensure nil
  :config

  (general-vmap
    :keymaps 'override
    "<XF86Calculator>" 'my/calc-region
    "X" 'my/calc-region)

  (general-nmap
    :keymaps 'override
    "C-c p" 'quick-calc
    "<XF86Calculator>" 'quick-calc)

  (general-nvmap
    :keymaps 'calc-mode-map
    "C-l" 'calc-reset
    "<escape>" 'calc-quit))

(use-package compilation-mode
  :defer t
  :ensure nil
  :config
  (general-unbind 'compilation-mode-map
    :with 'ignore
    [remap my/quiet-save-buffer]))

(use-package conf-mode
  :defer t
  :ensure nil
  :config
 (electric-pair-local-mode 1)
  (general-define-key
   :keymaps 'conf-mode-map
   "M-p" 'my/paragraph-backwards
   "M-n" 'my/paragraph-forward))

(use-package with-editor
  :defer t
  :ensure nil
  :config
  (general-define-key
   :keymaps 'with-editor-mode-map
   "<C-return>" 'with-editor-finish
   "<M-return>" 'with-editor-cancel))

;; (use-package desktop
;;   :ensure nil
;;   :init
;;   (setq desktop-load-locked-desktop nil)
;;   (setq desktop-save t)
;;   (setq desktop-dirname "~/.emacs.d/var/desktop")
;;   (setq desktop-auto-save-timeout 30)
;;   :config
;;   (desktop-save-mode t))

(use-package text-mode
  :init
  (add-hook 'text-mode-hook 'my/text-hooks)
  (defun my/text-hooks ()
    (interactive)
    (subword-mode 1)
    (tab-jump-out-mode 1)
    (olivetti-mode +1))

  :ensure nil
  :config

  (defun my/enable-auto-agg-fill ()
    (interactive)
    (auto-fill-mode +1)
    (aggressive-fill-paragraph-mode +1)
    (message " both fills enabled"))

  (defun my/disable-auto-agg-fill ()
    (interactive)
    (auto-fill-mode -1)
    (aggressive-fill-paragraph-mode -1)
    (message " both fills disabled"))

  (defun my/prose-brasileiro ()
    (interactive)
    (flyspell-mode 1)
    (ispell-change-dictionary "brasileiro")
    (auto-capitalize-mode 1)
    (tab-jump-out-mode 1)
    (electric-operator-mode 1)
    (wc-mode 1)
    (pabbrev-mode 1))

  (defun prose-enable ()
    (interactive)
    (flyspell-mode 1)
    (olivetti-mode +1)
    (auto-capitalize-mode 1)
    (tab-jump-out-mode 1)
    (electric-operator-mode 1)
    (wc-mode 1)
    (pabbrev-mode 1)
    (message "prose on"))

  (defun my/ispell-dict-options ()
    (interactive)
    (counsel-M-x "^my/ispell-ask-dict "))

  (defun my/ispell-ask-dict-br ()
    (interactive)
    (ispell-change-dictionary "brasileiro"))

  (defun my/ispell-ask-dict-en ()
    (interactive)
    (ispell-change-dictionary "american"))

  (general-nvmap
    :keymaps 'text-mode-map
    ;; "ç" 'flyspell-goto-next-error
    ;; "C-ç" 'ispell-word
    "RET" 'hydra-spell/body)
  (general-define-key
   :keymaps 'text-mode-map
   "C-c C-k" 'pdf-annot-edit-contents-abort
   "M-p" 'my/paragraph-backwards
   "M-n" 'my/paragraph-forward))

(use-package Custom-mode
  :defer t
  :ensure nil
  :config
  (general-nvmap
    :keymaps 'custom-mode-map
    "q" 'Custom-buffer-done)
  (general-nvmap
    :keymaps 'custom-mode-map
    "C-j" 'counsel-M-x
    "M-p" 'my/paragraph-backwards
    "M-n" 'my/paragraph-forward)
  (general-define-key
   :keymaps 'custom-mode-map
   "C-j" 'counsel-M-x
   "M-p" 'my/paragraph-backwards
   "M-n" 'my/paragraph-forward))

(use-package hippie-exp
:defer t
  :ensure nil
  :config
  (general-imap
    "M-/" 'hippie-expand))

(use-package term
  :defer t
  :init
  (defun my/term-mode-hooks ()
    (interactive)
    (subword-mode 1)
    (dimmer-mode 1)
    (smartparens-mode 1)
    (tab-jump-out-mode 1)
    (electric-pair-local-mode 1))

  (add-hook 'term-mode-hook 'my/term-mode-hooks)
  (setq comint-terminfo-terminal "ansi")
  :defer t
  :ensure nil
  :config
  (general-unbind 'term-mode-map
    :with 'ignore
    [remap my/quiet-save-buffer]
    [remap evil-emacs-state])

  (general-unbind 'term-raw-map
    :with 'term-send-raw
    [remap delete-backward-char]
    [remap evil-delete-backward-word]
    [remap delete-backward-word]
    [remap evil-paste-from-register]
    [remap backward-kill-word])

  (general-define-key
   :keymaps 'term-mode-map
   "C-j" 'counsel-M-x
   "C-l" 'term-send-raw
   "C-;" 'kill-buffer-and-window
   "C-p" 'term-send-raw
   "C-n" 'term-send-raw
   "C-a" 'term-send-raw
   "C-e" 'term-send-raw
   "C-k" 'kill-visual-line
   "C-u" 'term-send-raw
   "C-w" 'term-send-raw)

  (general-imap
    :keymaps 'term-mode-map
    "C-l" 'term-send-raw
    "C-;" 'kill-buffer-and-window
    "C-p" 'term-send-raw
    "C-n" 'term-send-raw
    "C-a" 'term-send-raw
    "C-e" 'term-send-raw
    "C-k" 'kill-visual-line
    "C-u" 'term-send-raw
    "C-w" 'term-send-raw)

  (general-nvmap
    :keymaps 'term-mode-map
    "C-j" 'counsel-M-x
    "C-l" 'term-send-raw
    "C-p" 'term-send-raw
    "C-n" 'term-send-raw
    "C-;" 'kill-buffer-and-window
    "C-u" 'term-send-raw
    "C-w" 'term-send-raw)

  (general-imap
    :keymaps 'term-raw-map
    "C-;" 'kill-buffer-and-window
    "M-r" nil))

(use-package abbrev
  :defer t
  :ensure nil
  :config
  (setq-default abbrev-mode t)
  (setq save-abbrevs 'silently)
  ;; (setq abbrev-file-name "~/.emacs.d/etc/abbrev_defs")
  (general-define-key
   :keymaps 'edit-abbrevs-map
   "<C-return>" 'abbrev-edit-save-close)
  (general-nvmap
    :keymaps 'edit-abbrevs-mode-map
    [escape] 'abbrev-edit-save-buffer
    "q" 'my/kill-this-buffer))

(use-package prog-mode
  :defer t
  :ensure nil
  :init
  (add-to-list 'auto-mode-alist '("\\prog\\'" . prog-mode))
  (add-hook 'prog-mode-hook 'my/prog-mode-hooks)
  :config
  (defun my/prog-mode-hooks ()
    (interactive)
    (company-mode 1)
    (electric-pair-local-mode 1)
    (smartparens-mode 1)
    (tab-jump-out-mode 1)
    (hs-minor-mode 1)
    (yas-minor-mode 1)
    (highlight-indent-guides-mode 1))

  ;; (setq comment-auto-fill-only-comments t)

  (general-imap
    :keymaps 'prog-mode-map
    "<M-return>" 'indent-buffer)

  (general-nvmap
    :keymaps 'prog-mode-map
    "<backspace>" 'org-edit-src-exit
    "<tab>" 'hs-toggle-hiding
    "RET" 'hydra-prog-mode/body)

  (general-nmap
    :keymaps 'prog-mode-map
    "M-p" 'my/paragraph-backwards
    "M-n" 'my/paragraph-forward)

  (general-define-key
   :keymaps 'prog-mode-map
   "C-c n" 'my/narrow-to-paren-macro
   "<C-return>" 'hydra-prog-mode/body
   "<M-return>" 'indent-buffer)

  (general-define-key
   :keymaps 'prog-mode-map
   "C-=" 'string-inflection-all-cycle
   "<C-return>" 'hydra-prog-mode/body
   "<M-return>" 'indent-buffer))

(use-package help-mode
  :defer 1
  :ensure nil
  :init
  (add-hook 'help-mode-hook 'line-numbers-absolute)
  (add-hook 'help-mode-hook 'hl-line-mode)
  :config

  (setq help-window-select t)

  (general-nmap
    :keymaps 'help-mode-map
    "<escape>" 'evil-ex-nohighlight)
  (general-nvmap
    :keymaps 'help-mode-map
    "M-p" 'my/paragraph-backwards
    "M-n" 'my/paragraph-forward
    "gs" 'evil-ex-nohighlight)
  (general-nmap
    :keymaps 'help-mode-map
    "<escape>" 'evil-ex-nohighlight)
  (general-define-key
   :keymaps 'help-mode-map
   "M-p" 'my/paragraph-backwards
   "M-n" 'my/paragraph-forward
   "gs" 'evil-ex-nohighlight))

(use-package man
  :defer t
  :ensure nil
  :init
  (add-hook 'Man-mode-hook 'my/man-internal)

  (defun my/man-internal ()
    (interactive)
    (other-window -1)
    (delete-other-windows))

  :config
  (set-face-attribute 'Man-overstrike nil :inherit 'bold :foreground "orange red")
  (set-face-attribute 'Man-underline nil :inherit 'underline :foreground "forest green")

  (general-nvmap
    :keymaps 'Man-mode-map
    "q" 'Man-kill
    "RET" 'my/push-button
    "C-n" 'my/Man-next-section
    "M-n" 'my/paragraph-forward
    "M-p" 'my/paragraph-backwards
    "C-p" 'my/Man-previous-section
    "C-c RET" 'Man-follow-manual-reference)

  (general-define-key
   :keymaps 'Man-mode-map
   "<f9>" 'Man-kill
   "q" 'Man-kill)

  (general-unbind 'Man-mode-map
    :with 'counsel-M-x
    [remap Man-next-section])

  (general-unbind 'Man-mode-map
    :with 'my/push-button
    [remap push-button])

  (general-unbind 'Man-mode-map
    :with 'evil-ex-nohighlight
    [remap my/quiet-save-buffer])

  (general-unbind 'Man-mode-map
    :with 'ignore
    [remap evil-insert]))

(use-package scroll-bar
  :defer 1
  :ensure nil
  :config
  (horizontal-scroll-bar-mode -1)
  (scroll-bar-mode -1))

(use-package tool-bar
  :ensure nil
  :config
  (setq tool-bar-mode nil)
  (tool-bar-mode -1))

(use-package eldoc
  :defer 1
  :ensure nil
  :config
  (global-eldoc-mode -1))

(use-package paren
  :defer 1
  :ensure nil
  :config
  (custom-set-faces '(show-paren-match ((t(
					   :background "#292929"
					   :foreground "dark orange"
					   :inverse-video nil
					   :underline nil
					   :slant normal
					   :weight bold)))))
  (show-paren-mode 1))

(use-package frame
  :defer 1
  :ensure nil
  :config
  (blink-cursor-mode 0))

(use-package autorevert
  :defer 1
  :ensure nil
  :config
  (global-auto-revert-mode 1))

(use-package mouse
  :defer 1
  :ensure nil
  :config
  (setq mouse-yank-at-point t))

;; (use-package paragraphs
;;   :defer 1
;;   :ensure nil
;;   :config
;;   (setq sentence-end-double-space nil)
;;   (setq sentence-end nil))
  (setq sentence-end-double-space nil)
  (setq sentence-end nil)

(use-package hl-line
  :defer 1
  :ensure nil
  :config
  (setq global-hl-line-mode nil))

(use-package simple
  :ensure nil
  :init
  (add-to-list 'auto-mode-alist '("\\fund\\'" . fundamental-mode))
  :config
  (setq truncate-lines t)
  (setq-default truncate-lines t)
  (setq save-interprogram-paste-before-kill nil)
  (setq backward-delete-char-untabify-method 'hungry)

  (general-unbind 'special-mode-map
    :with 'ignore
    [remap my/quiet-save-buffer])

  (general-define-key
   :keymaps 'messages-buffer-mode-map
   "M-d" 'ivy-switch-buffer)

  (general-unbind 'messages-buffer-mode-map
    :with 'ignore
    [remap my/quiet-save-buffer])

  (global-visual-line-mode t))

(use-package warning
  :defer 1
  :ensure nil
  :config
  (setq warning-minimum-level :emergency))

(use-package custom
  :defer 1
  :ensure nil
  :config
  (setq custom-safe-themes t))

(use-package comint
  :defer 1
  :ensure nil
  :config
  (setq comint-prompt-read-only t))

(use-package sh-script
  :defer t
  :ensure nil
  :init
  (add-hook 'sh-mode-hook 'my/sh-mode-hooks)
  :config

  (defun my/sh-mode-hooks ()
    (interactive)
    (flycheck-mode 1)
    (flymake-mode 1))

  (add-to-list 'auto-mode-alist '("\\.inputrc\\'" . sh-mode))
  (add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . sh-mode)))

(use-package files
  :defer 1
  :ensure nil
  :init
  (add-hook 'before-save-hook  'force-backup-of-buffer)
  :config
  (setq save-silently t)
  (setq delete-old-versions -1)
  ;; (add-to-list 'find-file-hook 'line-numbers-absolute)
  ;; (add-to-list 'find-file-hook 'olivetti-mode)

  (setq version-control t	        ;; Use version numbers for backups
        kept-new-versions 16		;; Number of newest versions to keep
        kept-old-versions 2		;; Number of oldest versions to keep
        delete-old-versions t		;; Do not aks to delete excess backup versions
        backup-by-copying-when-linked t	;; Copy linked files, don't rename.
        backup-directory-alist
        '(("." . "~/.emacs.d/.backups"))

        vc-make-backup-files t
        auto-save-visited-mode t
        auto-save-file-name-transforms `((".*" "~/.emacs.d/.auto-save-list/" t))
        auto-save-default t)

  (defun force-backup-of-buffer ()
    (let ((buffer-backed-up nil))
      (backup-buffer)))

  (setq large-file-warning-threshold nil)
  (setq buffer-save-without-query t)
  (setq find-file-suppress-same-file-warnings t)
  )

(use-package files
  :defer 1
  :ensure nil
  :config
  (setq bookmark-save-flag 1))

(use-package vc-mode
  :defer nil
  :ensure nil
  :init
  (setq vc-follow-symlinks t))

(use-package register
  :defer 1
  :ensure nil
  :config
(setq register-preview-delay 0.15))

(use-package doc-view
  :defer t
  :ensure nil
  :config
  (setq doc-view-continuous t))

(use-package loaddefs
  :defer 1
  :ensure nil
  :config
  (setq browse-url-generic-program "google-chrome-stable")
  (setq browse-url-browser-function 'browse-url-generic))

(use-package recentf
  :ensure nil
  :config
  (recentf-mode 1))
