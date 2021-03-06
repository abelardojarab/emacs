(use-package elmacro
  :defer t
  :ensure t)

(use-package evil-swap-keys
  :defer t
  :ensure t
  :config
  (defun my/evil-swap-keys-on ()
    (interactive)
    (evil-swap-keys-swap-colon-semicolon)
    (evil-swap-keys-swap-double-single-quotes))

  (defun my/evil-swap-keys-swap-parens-numbers ()
    "Swap the square and curly brackets."
    (interactive)
    (evil-swap-keys-add-pair "(" "9")
    (evil-swap-keys-add-pair ")" "0"))

  (defun my/evil-swap-number-row ()
    "Swap the square and curly brackets."
    (interactive)
    (evil-swap-keys-add-pair "5" "%")
    (evil-swap-keys-add-pair "7" "&")
    (evil-swap-keys-add-pair "8" "*")
    (evil-swap-keys-add-pair "0" ")")
    (evil-swap-keys-add-pair "9" "("))

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
          eyebrowse-create-window-config))

  (setq super-save-auto-save-when-idle t)
  (setq super-save-idle-duration 2)

  (setq auto-save-default nil)
  (super-save-mode +1))

(use-package engine-mode
  :ensure t
  :config

  (defadvice browse-url
      (after browse-url-after activate) (my/focus-chrome-delayed))

  (defengine google
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")

  (defengine devdocs-io
    "https://devdocs.io/#q=%s")
  (defengine emacs-wiki
    "https://duckduckgo.com/?q=%s site:emacswiki.org")
  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s")
  (defengine stack-overflow
    "https://stackoverflow.com/search?q=%s")
  (defengine reddit
    "https://old.reddit.com/search?q=%s")
  (defengine dic-informal
    "https://www.dicionarioinformal.com.br/sinonimos/%s")
  (defengine michaelis
    "https://michaelis.uol.com.br/moderno-portugues/busca/portugues-brasileiro/%s")
  (defengine asimov-wikia
    "http://asimov.wikia.com/wiki/Special:Search?query=%s")
  (defengine wiki-en
    "https://en.wikipedia.org/wiki/%s")
  (defengine wiki-pt
    "https://pt.wikipedia.org/wiki/%s")
  (defengine plato
    "https://plato.stanford.edu/search/searcher.py?query=%s")
  (defengine translate
    "https://translate.google.com/?source=osdd#view=home&op=translate&sl=auto&tl=pt&text=%s")
  (defengine urban-dictionary
    "https://www.urbandictionary.com/define.php?term=%s")
  (defengine the-free-dictionary
    "https://www.thefreedictionary.com/%s")
  (defengine MDN
    "https://developer.mozilla.org/en-US/search?q=%s")
  (engine-mode t))

(use-package vertigo
  :defer t
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

  (general-nvmap
   :keymaps 'helpful-mode-map
   "gr" 'sel-to-end)

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
  :defer t
  :ensure t
  :init
  (add-hook 'pdf-view-mode-hook 'my/pdf-view-settings)
  (add-hook 'pdf-tools-enabled-hook 'my/pdf-view-settings)

  (add-hook 'pdf-outline-buffer-mode-hook 'my/pdf-outline-settings)

  :config
  (setq pdf-view-continuous t)
  (setq pdf-view-resize-factor 1.15)
  (setq pdf-view-display-size 'fit-page)
  (setq pdf-misc-size-indication-minor-mode t)
  (setq pdf-annot-activate-created-annotations t)

  (defun my/call-ranger-from-pdf ()
    (interactive)
    (last-buffer)
    (ranger))

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

  (general-unbind 'pdf-view-mode-map
    :with 'my/call-ranger-from-pdf
    [remap ranger])

  (general-unbind 'pdf-view-mode-map
    :with 'my/kill-this-buffer
    "Q")

  (nvmap :keymaps 'pdf-annot-list-mode-map
    "q" 'pdf-outline-quit-and-kill
    "<escape>" 'pdf-outline-quit)

  (nvmap :keymaps 'pdf-occur-buffer-mode-map
    "go" 'pdf-occur-goto-occurrence
    "<return>" 'pdf-occur-goto-quit)

  (general-define-key
   :keymaps 'pdf-view-mode-map
   "w" 'pdf-view-fit-width-to-window
   "<return>" 'quick-calc
   "<kp-enter>" 'quick-calc
   "J" 'pdf-view-next-page
   "j" 'pdf-view-next-line-or-next-page
   "K" 'pdf-view-previous-page
   "k" 'pdf-view-previous-line-or-previous-page
   "p" 'pdf-view-previous-page
   "n" 'pdf-view-next-page

   "C-x i" 'org-noter-insert-precise-note

   "C-c v v" 'pdf-view-set-slice-using-mouse
   "C-c v r" 'pdf-view-reset-slice
   "C-c C-c" 'pdf-annot-add-highlight-markup-annotation
   "M-o" 'pdf-history-backward
   "M-i" 'pdf-history-forward
   "H" 'pdf-history-backward
   "L" 'pdf-history-forward)

  (general-unbind 'pdf-view-mode-map
    :with 'pdf-view-fit-page-to-window
    [remap evil-beginning-of-visual-line])

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
    "<kp-enter>" 'quick-calc
    "i" 'org-noter-insert-note
    "I" 'org-noter-insert-precise-note
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
    "t" 'pdf-annot-add-text-annotation
    "gm" 'pdf-view-position-to-register
    "h" 'pdf-view-scroll-up-or-next-page
    "l" 'pdf-view-scroll-down-or-previous-page
    "<down>" 'pdf-view-next-line-or-next-page
    "<up>" 'pdf-view-previous-line-or-previous-page
    "J" 'pdf-view-next-page
    "j" 'pdf-view-next-line-or-next-page
    "K" 'pdf-view-previous-page
    "k" 'pdf-view-previous-line-or-previous-page
    "p" 'pdf-view-previous-page
    "n" 'pdf-view-next-page
    "w" 'pdf-view-fit-width-to-window
    ;; "<left>" 'eyebrowse-prev-window-config
    ;; "<right>" 'eyebrowse-next-window-config
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
  :defer nil
  :ensure t
  :config
  ;; (setq unkillable-buffers '("^\\*scratch\\*$" "webdev.org"))
  (setq unkillable-buffers '("^\\*scratch\\*$" "agenda.org" "webdev.org"))
  (setq unkillable-scratch-behavior 'bury)
  :config
  (unkillable-scratch))

;; (use-package activity-watch-mode
;; :ensure t
;; :config
;; (global-activity-watch-mode +1))

(use-package sudo-edit
:defer t
:ensure t)

(use-package beacon
  :defer t
  :init
  (add-hook 'beacon-dont-blink-predicates
            (lambda () (bound-and-true-p centered-cursor-mode)))
  :ensure t
  :config
  ;; (setq beacon-dont-blink-commands '(find-packs find-keys find-misc find-functions find-macros find-hydras find-file counsel-find-file))
  (setq beacon-size 10)
  (setq beacon-blink-when-point-moves-vertically nil)
  (setq beacon-blink-when-point-moves-horizontally t)
  (setq beacon-blink-when-focused t)
  (setq beacon-blink-duration 0.1)
  (setq beacon-blink-delay 0.1)
  (setq beacon-blink-when-window-scrolls nil)
  (setq beacon-blink-when-window-changes t))

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  ;; See https://github.com/dholm/benchmark-init-el
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package shut-up
:ensure t)

;; (use-package auto-compile
;;   :defer t
;;   :ensure t
;;   :config
;;   (setq auto-compile-mode-line-counter t)
;;   (setq auto-compile-display-buffer nil)
;;   (setq auto-compile-use-mode-line t)
;;   (setq auto-compile-on-load-mode t))

;; (use-package magit
;;   :defer 10
;;   :ensure t
;;   ;;;; PERFORMANCE TWEAKS ;;;;
;;   ;;;; https://magit.vc/manual/magit/Performance.html
;;   :config
;;   (setq vc-handled-backends nil)
;;   (remove-hook 'server-switch-hook 'magit-commit-diff)
;;   (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
;;   (setq magit-revision-insert-related-refs nil)
;;   (setq magit-refresh-status-buffer nil)
;;   (setq auto-revert-buffer-list-filter
;;         'magit-auto-revert-repository-buffers-p))

(use-package cheatsheet
  :ensure t
  :init
  (add-hook 'cheatsheet-mode-hook 'my/cheat-sheet-hooks)
  :config

  (defun my/cheat-sheet ()
    (interactive)
    (cheatsheet-show)
    (line-no-numbers)
    (beginning-of-buffer)
    (disable-modeline)
    (my/evil-dec-width-narrower))

  (defun my/cheat-sheet-hooks ()
    (interactive)
    (evil-window-move-far-right)
    (hl-line-mode))

  (general-define-key
   :keymaps 'cheatsheet-mode-map
   "q" 'kill-buffer-and-window)

  (general-nvmap
    :keymaps 'cheatsheet-mode-map
    "C-q" 'kill-buffer-and-window
    "q" 'kill-buffer-and-window)

  (cheatsheet-add-group 'Common
                        '(:key "u" :description "up")
                        '(:key "T" :description "toc")
                        '(:key "q" :description "exit")
                        '(:key "]" :description "node →")
                        '(:key "[" :description "node ←")
                        '(:key "s" :description "search")
                        '(:key "p" :description "Info ←")
                        '(:key "n" :description "Info →")
                        '(:key "L" :description "history")
                        '(:key "," :description "index →")
                        '(:key "l" :description "history ←")
                        '(:key "r" :description "history →")
                        '(:key "g" :description "goto node")
                        '(:key "DEL" :description "scroll ↓")
                        '(:key "SPC" :description "scroll ↑")
                        '(:key "TAB" :description "reference →")
                        '(:key "RET" :description "follow node")
                        '(:key "S+Tab" :description "reference ←")
                        '(:key "f" :description "follow reference")))

(use-package undo-propose
  :ensure t
  :config
  (defadvice undo-propose (after undo-propose-after activate) (my/erase-messages))

  (defun my/erase-messages ()
    (interactive)
    (message ""))

  (general-unbind 'undo-propose-mode-map
    :with 'ignore
    [remap evil-insert]
    [remap evil-visual-char]
    [remap evil-visual-line]
    [remap evil-visual-block]
    [remap evil-visual-state])

  (general-unbind 'undo-propose-mode-map
    :with 'undo-propose-cancel
    [remap undo-propose]
    [remap my/quiet-save-buffer])

  (general-unbind 'undo-propose-mode-map
    :with 'undo-propose-cancel
    [remap evil-record-macro]))
