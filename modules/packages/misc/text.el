(use-package pabbrev
  :defer t
  :ensure t
  :config
  (setq pabbrev-idle-timer-verbose nil)
  (general-imap
    :keymaps 'pabbrev-mode-map
    "C-l" 'pabbrev-expand-maybe))

(use-package lorem-ipsum
:defer t
:ensure t)

(use-package hl-sentence
  :defer t
  :ensure t)

(use-package flyspell
  :defer t
  :config
  (setq flyspell-abbrev-p t)
  (setq flyspell-issue-message-flag nil)
  (setq flyspell-issue-welcome-flag nil)
  (setq flyspell-default-dictionary "american")

  (defun my/ispell-show-dictionary ()
    (interactive)
    (describe-variable 'ispell-current-dictionary))

  (general-define-key
   :keymaps 'flyspell-mode-map
   "C-c d" 'my/ispell-show-dictionary)

  (general-nvmap
    :keymaps 'flyspell-mode-map
    "z-" 'my/flyspell-insert-word))

(use-package ispell
:defer t
:ensure nil
:config
(general-nvmap
  :keymaps 'override
  "z[" 'ispell-insert-word))

(setq auto-capitalize-ask nil)
(autoload 'auto-capitalize-mode "auto-capitalize"
  "Toggle `auto-capitalize' minor mode in this buffer." t)
;; (autoload 'turn-on-auto-capitalize-mode "auto-capitalize"
;;   "Turn on `auto-capitalize' minor mode in this buffer." t)
(autoload 'enable-auto-capitalize-mode "auto-capitalize"
  "Enable `auto-capitalize' minor mode in this buffer." t)

(use-package fix-word
:defer t
:ensure t)

(use-package wc-mode
:defer t
:ensure t)

(use-package olivetti
  :defer t
  :ensure t
  :config
  (setq-default olivetti-body-width 100)
  (setq olivetti-body-width 100))

(use-package markdown-mode
  :defer t
  :ensure t
  :init
  (add-hook 'markdown-mode-hook 'my/markdown-hooks)
  (setq markdown-hide-urls 't)
  (setq-default markdown-hide-markup t)
  (setq markdown-enable-wiki-links t)
  :config
  (defun my/markdown-forward-paragraph ()
    (interactive)
    (markdown-forward-paragraph)
    (forward-to-indentation))

  (defun my/markdown-hooks ()
    (interactive)
    (prose-enable))

  (defun my/markdown-copy-buffer ()
    (interactive)
    (save-excursion
      (my/markdown-copy-buffer-macro)
      (message " buffer yanked without title")))

  (setq markdown-css-paths '("/home/mrbig/org/Creative/Web/md_themes/retro/css/retro.css"))

  (defun my/counsel-markdown-commands ()
    (interactive)
    (counsel-M-x "^markdown- "))

  (general-nmap
    :keymaps 'markdown-mode-map
    "<escape>" 'my/quiet-save-buffer-markdown)

  (general-imap
    :keymaps 'markdown-mode-map
    "C-;" 'helpful-function)

  (general-nvmap
    :keymaps 'markdown-mode-map
    "C-;" 'helpful-function
    ">" 'markdown-promote-subtree
    "<" 'markdown-demote-subtree
    "}" 'markdown-forward-paragraph
    "RET" 'hydra-spell/body
    "[" 'markdown-previous-link
    "]" 'markdown-next-link
    "<tab>" 'markdown-cycle
    "C-;" 'helpful-function
    "<insert>" 'markdown-insert-link)

  (general-define-key
   :keymaps 'markdown-mode-map
   "C-x y" 'my/markdown-copy-buffer
   "C-;" 'helpful-function
   "C-c l" 'markdown-toc-generate-or-refresh-toc
   "M-p" 'markdown-backward-paragraph
   "M-n" 'my/markdown-forward-paragraph
   "<tab>" 'markdown-cycle
   "<insert>" 'markdown-insert-link))

(use-package markdown-toc
  :ensure t)

(use-package bbcode-mode
:defer t
:ensure t)

(use-package all-the-icons
:defer t)
