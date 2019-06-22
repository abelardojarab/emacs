(use-package elmacro
  :defer t
  :ensure t
  :config
  (general-define-key
   "C-c m l m" 'elmacro-show-last-macro
   "C-c m l c" 'elmacro-show-last-commands))

(use-package evil-swap-keys
  :defer t
  :ensure t
  :config
  (defun my/evil-swap-keys-on ()
    (interactive)
    (evil-swap-keys-swap-colon-semicolon)
    (evil-swap-keys-swap-double-single-quotes))

  (defun my/evil-swap-keys-off ()
    (interactive)
    (setq evil-swap-keys--mappings nil)))

(use-package super-save
  :ensure t
  :config

  (defun super-save-command ()
    "Save the current buffer if needed."
    (shut-up
      (when (and buffer-file-name
		 (buffer-modified-p (current-buffer))
		 (file-writable-p buffer-file-name)
		 (if (file-remote-p buffer-file-name) super-save-remote-files t))
	(save-buffer))))

  (setq super-save-triggers
	'(switch-to-buffer
	  other-window
	  windmove-up
	  windmove-down
	  windmove-left
	  windmove-right
	  next-buffer
	  previous-buffer
	  evil-window-prev
	  evil-window-next
	  eyebrowse-next-window-config
	  eyebrowse-prev-window-config
	  eyebrowse-create-window-config
	  my/unpop-shell-other-window))
  (setq super-save-auto-save-when-idle t)
  (setq super-save-idle-duration 180)
  (setq auto-save-default nil)
  (super-save-mode +1))

(use-package engine-mode
  :defer t
  :ensure t
  :config
  (defengine google "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")
  (defengine devdocs-io "https://devdocs.io/#q=%s")
  (defengine emacs-wiki "https://duckduckgo.com/?q=%s site:emacswiki.org")
  (defengine github "https://github.com/search?ref=simplesearch&q=%s")
  (defengine stack-overflow "https://stackoverflow.com/search?q=%s")
  (defengine reddit "https://old.reddit.com/search?q=%s")
  (defengine dic-informal "https://www.dicionarioinformal.com.br/sinonimos/%s")
  (defengine michaelis "https://michaelis.uol.com.br/moderno-portugues/busca/portugues-brasileiro/%s")
  (defengine asimov-wikia "http://asimov.wikia.com/wiki/Special:Search?query=%s")
  (defengine wiki-en "https://en.wikipedia.org/wiki/%s")
  (defengine wiki-pt "https://pt.wikipedia.org/wiki/%s")
  (defengine plato "https://plato.stanford.edu/search/searcher.py?query=%s")
  (defengine translate "https://translate.google.com/?source=osdd#view=home&op=translate&sl=auto&tl=pt&text=%s")
  (defengine urban-dictionary "https://www.urbandictionary.com/define.php?term=%s")
  (defengine the-free-dictionary "https://www.thefreedictionary.com/%s")

  (engine-mode t))




(use-package vertigo
  :defer 2
  :ensure t
  :config
  (general-nvmap
    "," 'vertigo-visual-jump-down
    "." 'vertigo-visual-jump-up)
  (setq vertigo-cut-off 4)
  (setq vertigo-home-row '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?o)))

;; (setq vertigo-home-row '(?q ?w ?e ?r ?t ?y ?u ?i ?o ?p)

(use-package recursive-narrow
  :ensure t)

(use-package caps-lock
:defer t
:ensure t)

(use-package aggressive-fill-paragraph
:defer t
:ensure t)

(use-package helpful
  :defer t
  :ensure t
  :init
  (add-hook 'helpful-mode-hook 'line-numbers)
  (add-hook 'helpful-mode-hook 'hl-line-mode)
  :config
  (setq helpful-max-buffers 2)

  (general-nmap
    :keymaps 'helpful-mode-map
    "<escape>" 'evil-ex-nohighlight)

  (general-unbind 'helpful-mode-map
    :with 'quit-window
    [remap my/quiet-save-buffer])

  (general-define-key
   :keymaps 'helpful-mode-map
   "M-p" 'my/paragraph-backwards
   "M-n" 'my/paragraph-forward))

(use-package pdf-tools
  :defer 1
  :ensure t
  :init
  (add-hook 'pdf-view-mode-hook 'my/pdf-view-settings)
  (add-hook 'pdf-outline-buffer-mode-hook 'my/pdf-outline-settings)
  :config
  (setq pdf-view-continuous t)
  (setq pdf-view-resize-factor 1.15)
  (setq pdf-view-display-size 'fit-page)
  (setq pdf-misc-size-indication-minor-mode t)
  (setq pdf-annot-activate-created-annotations t)

  (defun pdf-occur-goto-quit ()
    (interactive)
    (pdf-occur-goto-occurrence)
    (quit-windows-on "*PDF-Occur*"))

  (defun my/pdf-delete-occur-window ()
    (interactive)
    (quit-windows-on "*PDF-Occur*"))

  (defun my/pdf-view-settings ()
    (interactive)
    (pdf-annot-minor-mode 1)
    (pdf-links-minor-mode 1)
    (line-no-numbers)
    (pdf-history-minor-mode 1))

  (defun my/pdf-outline-settings ()
    (interactive)
    (disable-modeline)
    (outline-minor-mode 1)
    (hl-line-mode 1))

  (general-define-key
   :keymaps 'pdf-outline-minor-mode-map
   "<tab>" 'evil-toggle-fold
   "<escape>" 'pdf-outline-quit)

  (general-define-key
   :keymaps 'pdf-outline-buffer-mode-map
   "gh" 'pdf-outline-up-heading
   "<tab>" 'evil-toggle-fold
   "<escape>" 'pdf-outline-quit)

  (general-nvmap
    :keymaps 'pdf-outline-buffer-mode-map
    "<tab>" 'evil-toggle-fold)

  (general-nmap
    :keymaps 'pdf-outline-buffer-mode-map
    "<escape>" 'pdf-outline-quit)

  (general-unbind 'pdf-outline-buffer-mode-map
    :with 'pdf-outline-quit
    [remap my/quiet-save-buffer])

  (nvmap :keymaps 'pdf-annot-list-mode-map
    "q" 'pdf-outline-quit-and-kill
    "<escape>" 'pdf-outline-quit)

  (nvmap :keymaps 'pdf-occur-buffer-mode-map
    "go" 'pdf-occur-goto-occurrence
    "<return>" 'pdf-occur-goto-quit)

  (general-unbind 'pdf-view-mode-map
    :with 'pdf-view-scale-reset
    [remap evil-beginning-of-visual-line])

  (general-define-key
   :keymaps 'pdf-view-mode-map
   "C-x i" 'org-noter-insert-precise-note
   "C-c v v" 'pdf-view-set-slice-using-mouse
   "C-c v r" 'pdf-view-reset-slice
   "C-c C-c" 'pdf-annot-add-highlight-markup-annotation
   "M-o" 'pdf-history-backward
   "M-i" 'pdf-history-forward
   "H" 'pdf-history-backward
   "L" 'pdf-history-forward)

  (general-unbind 'pdf-view-mode-map
    :with 'pdf-outline
    [remap evil-toggle-fold])

  (general-define-key
   :keymaps 'pdf-annot-edit-contents-minor-mode-map
   "C-c C-c" 'pdf-annot-edit-contents-abort
   "<C-return>" 'pdf-annot-edit-contents-commit)

  (nvmap :keymaps 'pdf-annot-edit-contents-minor-mode-map
    "c" 'pdf-annot-edit-contents-abort)

  (nvmap :keymaps 'pdf-view-mode-map
    "i" 'org-noter-insert-note
    "I" 'org-noter-insert-precise-note
    "0" 'pdf-view-scale-reset
    "C-l" 'counsel-bookmark
    "C-c C-c" 'pdf-annot-add-highlight-markup-annotation
    "c" 'pdf-annot-add-highlight-markup-annotation
    "H" 'pdf-history-backward
    "L" 'pdf-history-forward
    "C-j" 'counsel-M-x
    "S" 'pdf-occur
    "ss" 'my/pdf-delete-occur-window
    ;; "q" 'last-buffer
    "gf" 'find-pdf-keys
    "TAB" 'pdf-outline
    "D" 'pdf-annot-delete
    "gp" 'pdf-view-goto-page
    ";" 'hydra-org-noter/body
    "f" 'pdf-links-action-perform
    "gr" 'pdf-view-jump-to-register
    "p" 'pdf-view-fit-page-to-window
    "t" 'pdf-annot-add-text-annotation
    "gm" 'pdf-view-position-to-register
    "h" 'pdf-view-scroll-up-or-next-page
    "l" 'pdf-view-scroll-down-or-previous-page
    "<up>"  'pdf-view-scroll-up-or-next-page
    "<down>" 'pdf-view-scroll-down-or-previous-page
    "j" 'pdf-view-next-page
    "J" 'pdf-view-next-line-or-next-page
    "k" 'pdf-view-previous-page
    "K" 'pdf-view-previous-line-or-previous-page
    "<left>" 'pdf-view-next-page
    "<right>" 'pdf-view-previous-page
    "C-c h" 'pdf-annot-add-highlight-markup-annotation)

  (pdf-loader-install))

(use-package savehist
  :init
  (setq history-length 500)
  (setq savehist-autosave-interval (* 1 60))
  (setq savehist-file "~/.emacs.d/var/savehist.el")
  (setq savehist-additional-variables '(kill-ring search-ring filesets-data))
  :config
  (savehist-mode t))

(use-package no-littering
  :ensure t)

(use-package saveplace
  :ensure nil
  :init
  (setq save-place-file "~/.emacs.d/var/save-place.el")
  :config
  (setq save-place-limit 100)
  (save-place-mode 1))

(use-package vimrc-mode
  :defer t
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.vim\\'" . vimrc-mode)))

(use-package vlf
:defer t
:ensure t)

(use-package unkillable-scratch
:defer 1
  :ensure t
  :config
  ;; (setq unkillable-buffers '("^\\*scratch\\*$"))
  (setq unkillable-scratch-behavior 'bury)
  :config
  (unkillable-scratch))

;; (use-package activity-watch-mode
;; :ensure t
;; :config
;; (global-activity-watch-mode +1))
