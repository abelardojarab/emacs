(use-package evil
  :after general
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-vsplit-window-right t)
  (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  (setq evil-want-fine-undo t)
  (setq evil-ex-substitute-global t)
  (setq evil-jumps-cross-buffers nil)
  (setq evil-disable-insert-state-bindings t)
  (setq evil-want-Y-yank-to-eol t)
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist
	'(("." .
	   "~/.emacs.d/var/undo-tree-hist/")))
  (setq evil-insert-state-message nil)
  (setq evil-respect-visual-line-mode nil)
  (general-nmap
    "-" 'evil-next-line
    "DEL" nil
    "gr" 'sel-to-end
    "g'" 'evil-goto-mark-line
    "; " 'evil-ex
    "zn" 'org-hide-other
    "g]" 'evil-set-marker
    "zi" 'outline-show-all
    "}" 'my/paragraph-forward
    "go" 'cool-moves/open-line-below
    "gi" 'cool-moves/open-line-above
    "{" 'my/paragraph-backwards
    "zj" 'evil-backward-word-end
    "zk" 'evil-backward-WORD-end
    "X" 'whack-whitespace
    "ge" 'evil-end-of-visual-line
    [escape] 'my/quiet-save-buffer)

  (general-nvmap
    :prefix "SPC"
    "key" 'command
    "H" 'evil-window-move-far-left
    "K" 'evil-window-move-very-top
    "L" 'evil-window-move-far-right
    "J" 'evil-window-move-very-bottom)

  (general-imap
    "C-u" 'backward-kill-line
    "C-c SPC" 'fix-word-capitalize
    "C-c n" 'fix-word-upcase
    "C-c d" 'fix-word-downcase)

  (general-imap
    :keymaps 'override
    "C-w" 'evil-delete-backward-word
    "M-/" 'hippie-expand
    "C-h" 'delete-backward-char
    "C-v " nil)

  (general-nvmap
    "k" 'evil-previous-visual-line
    "j" 'evil-next-visual-line
    "m" 'hydra-text-motions/body
    "M-e" 'evil-forward-sentence-begin
    "M-a" 'evil-backward-sentence-begin)

  (general-nvmap
    :keymaps 'override
    ;; "u" 'undo-only
    "gn" 'my/evil-format-paragraph-function
    "K" 'ignore
    "C-u" 'hydra-find-emacs-files/body
    "!" 'delete-frame
    "Q" 'save-buffers-kill-terminal
    "z=" 'endless/ispell-word-then-abbrev
    "C-S-j" 'cool-moves/move-line-down
    "C-S-k" 'cool-moves/move-line-up
    "C-c k" nil
    "<S-SPC>" nil
    "z," 'evil-repeat
    "gM" 'evil-set-marker
    "gm" 'evil-middle-of-visual-line
    "gI" 'evil-insert-line
    "gt" 'fix-word-capitalize
    "gA" 'evil-append-line
    "\\" 'evil-execute-in-god-state
    ;; "g," 'evil-execute-in-god-state
    "M-i" 'evil-jump-forward
    "M-o" 'evil-jump-backward
    "<M-S-f11>" 'my/evil-botright
    "M-s" 'last-buffer
    "$" 'evil-end-of-visual-line
    "zd" 'evil-scroll-line-to-bottom
    "0" 'evil-beginning-of-visual-line
    "M-." 'evil-window-next
    "M-," 'evil-window-prev)

  (general-define-key
   "C-c w" 'evil-window-next
   "C-c W" 'evil-window-prev)

  (general-define-key
   :keymaps 'global
   :states '(normal visual)
   "DEL"  'ignore)

  (general-imap
    :keymaps 'i3wm-emacs-map
    "<escape>" 'evil-normal-state)
  (general-define-key
   :keymaps 'evil-emacs-state-map
   "<escape>" 'evil-normal-state)

  (general-define-key
   :keymaps '(evil-ex-search-keymap evil-ex-completion-map)
   "C-h" 'delete-backward-char
   "C-h" 'delete-backward-char)

  (general-nvmap
    :keymaps 'override
    "C-S-a" 'evil-numbers/inc-at-pt
    "C-S-x" 'evil-numbers/dec-at-pt)

  (evil-mode 1))

(use-package evil-org
  :ensure t
  :after org
  :init

  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))

  (require 'evil-org-agenda)

  (evil-org-agenda-set-keys)
  :config

  (general-nmap
    :keymaps 'evil-org-mode-map
    "o" 'my/quiet-evil-org-open-below
    "O" 'my/quiet-evil-org-above)

  (general-unbind 'override
    :keymaps 'evil-org-mode-map
    :with 'my/quiet-evil-org-open-below
    [remap evil-org-open-below])

  (general-unbind 'override
    :keymaps 'evil-org-mode-map
    :with 'my/quiet-evil-org-above
    [remap evil-org-open-above])

  (defun my/quiet-evil-org-open-below ()
    (interactive)
    (shut-up
      (evil-org-open-below 1)))

  (defun my/quiet-evil-org-above ()
    (interactive)
    (shut-up
      (evil-org-open-above 1))))

(use-package evil-commentary
  :after evil
  :ensure t
  :config
  (evil-commentary-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-exchange
  :after (evil general)
  :ensure t
  :config
  (setq evil-exchange-key "gx")
  (general-nvmap
    "gx" 'evil-exchange
    "gX" 'evil-exchange-cancel)

  (evil-exchange-cx-install))

(use-package evil-numbers
  :defer t
  :ensure t)

(use-package evil-mc
:after evil
:ensure t
:config
 (general-define-key
  "C-c m" 'evil-mc-make-all-cursors
  "C-x m" 'evil-mc-undo-all-cursors)

 (general-nvmap
  "C-c m" 'evil-mc-make-all-cursors
  "C-x m" 'evil-mc-undo-all-cursors)
(global-evil-mc-mode  1))
