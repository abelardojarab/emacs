(use-package url-shortener
  :defer t
  :ensure t
  :config
  (setq bitly-access-token "3026d7e8b1a0f89da10740c69fd77b4b3293151e"))

(use-package keyfreq
  :defer 2
  :ensure t
  :config
  (setq keyfreq-autosave-timeout 180)
  (setq keyfreq-excluded-commands '("self-insert-command" "org-self-insert-command" "save-buffer"))
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(setq keyfreq-excluded-commands '("self-insert-command" "org-self-insert-command" "save-buffer"))

(setq keyfreq-excluded-commands nil)

(use-package zoom
  :defer t
  :ensure t)

(use-package link-hint
  :defer t
  :ensure t)

(use-package clipmon
  :defer t
  :ensure t
  :config
  (setq clipmon-timer-interval 0.1)
  (clipmon-mode-start))

(use-package undo-propose
  :defer t
  :ensure t
  :config

  (defun my/undo-propose ()
    (interactive)
    (widen)
    (undo-propose))

  (general-define-key
   :keymaps 'override

   (general-unbind 'undo-propose-mode-map
     :with 'undo-propose-finish
     [remap evil-org-org-insert-heading-respect-content-below])

   (general-unbind 'undo-propose-mode-map
     :with 'undo-propose-cancel
     [remap org-meta-return]))

   (undo-propose-mode))

(use-package wordnut
  :defer t
  :ensure t)

(use-package adaptive-wrap
  :after wordnut
  :ensure t)


;; ;; (package-install-file "~/.emacs.d/lisp/buffer-expose/buffer-expose.el")
;; (use-package buffer-expose
;;   :ensure t
;;   :config
;;   (load-file "~/.emacs.d/lisp/buffer-expose/buffer-expose-settings.el")

;;   (general-define-key
;;    :keymaps 'buffer-expose-mode-map
;;    "<s-tab>"     'buffer-expose
;;    "<C-tab>"     'buffer-expose-no-stars
;;    "C-c <C-tab>" 'buffer-expose-current-mode
;;    "C-c C-d"     'buffer-expose-dired-buffers
;;    "C-c C-*"     'buffer-expose-stars)

;;   (general-define-key
;;    :keymaps 'buffer-expose-grid-map
;;    "h" 'buffer-expose-left-window
;;    "k" 'windmove-up
;;    "j" 'windmove-down
;;    "l" 'buffer-expose-right-window
;;    "m" 'buffer-expose-choose)

;;   (buffer-expose-mode 1))

(use-package sr-speedbar
  :defer t
  :init
(setq sr-speedbar-right-side nil)
  :ensure t)

(use-package auto-compile
  :defer t
  :ensure t
  :config
  (setq auto-compile-display-buffer nil)
  (setq auto-compile-mode-line-counter t)
  (setq load-prefer-newer t)
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package which-key
  :defer t
  :ensure t
  :config
(which-key-add-key-based-replacements
  "C-c C-j" "journal"
  "C-c M-g" "magit popup"
  "C-c w" "evil window"
  "C-c L" "load stuff"
  "C-c f" "filesets"
  "C-c f e" "edit"
  "C-c f c" "close"
  "C-c f o" "open"
  "C-c C-s" "md code"
  "C-c m" "modes"
  "C-c m e" "evil"
  "C-c m g" "writegood"
  "C-c m w" "which-key"
  "C-c l" "load"
  "C-c u" "load"
  "C-c i" "editing"
  "C-c e" "evil commands"
  "C-c b" "buffers"
  "C-c b" "commands"
  "C-c o" "org"
  "C-c C-v" "babel"
  "C-c C-x" "org extras"
  "C-c &" "yasnippet"
  "C-c \"" "org plot"
  "C-c q" "filling"
  "C-c q j" "justify"
  "C-c q f" "fit"
  "C-c q f" "fit"
  "C-c q j 5" "just 59"
  "C-c q j 7" "just 79"
  "C-c q j 8" "just 85"
  "C-c q j 9" "just 95"
  "C-c q j 0" "just 100"
  "C-c q f 5" "fit  59"
  "C-c q f 7" "fit  79"
  "C-c q f 8" "fit  85"
  "C-c q f 9" "fit  95"
  "C-c q f 0" "fit  100"
  "C-c q a" "fill mode"
  "C-c q g" "agg par mode"
  "C-c m g g"  "writegood mode"
  "C-c m g e" "writegood reading ease"
  "C-c m 2" "org2blog"
  "C-c m 2 b" "wp buffer"
  "C-c m 2 b p" "post draft"
  "C-c m 2 b u" "publish"
  "C-c m 2 s" "wp subtree"
  "C-c m 2 s p" "post draft"
  "C-c m 2 s u" "publish"
  "C-c m 2 l" "wp login"
  "C-c m 2 o" "wp logout"
  "C-c m 2 n" "wp new")
(which-key-add-key-based-replacements

;;;; C-c p REPLACEMENTS ;;;;

"C-c p !"        "run-sh-command-in-root"
"C-c p &"        "run-async-sh-command-in-root"
"C-c p 4"	 "other window"
"C-c p 4 C-o"    "display-buffer"
"C-c p 4 D"      "dired-other-window"
"C-c p 4 a"      "fof-other-window"
"C-c p 4 b"      "switch-to-buffer-other-window"
"C-c p 4 d"      "fd-other-window"
"C-c p 4 f"      "ff-other-window"
"C-c p 4 g"      "ff-dwim-other-window"
"C-c p 4 t"      "f-implementation-or-test-other-window"
"C-c p 5"	 "other frame"
"C-c p 5 D"      "dired-other-frame"
"C-c p 5 a"      "fof-other-frame"
"C-c p 5 b"      "switch-to-buffer-other-frame"
"C-c p 5 d"      "fd-other-frame"
"C-c p 5 f"      "ff-other-frame"
"C-c p 5 g"      "ff-dwim-other-frame"
"C-c p 5 t"      "f-implementation-or-test-other-frame"
"C-c p <left>"   "prev-proj-buffer"
"C-c p <right>"  "next-proj-buffer"
"C-c p C"        "config-proj"
"C-c p D"	 "dired"
"C-c p E"        "edit-dir-locals"
"C-c p ESC"	 "proj-buffers-other-buffer"
"C-c p F"        "ff-in-known-projs"
"C-c p I"	 "ibuffer"
"C-c p P"        "test-proj"
"C-c p R"        "regenerate-tags"
"C-c p S"        "save-proj-buffers"
"C-c p T"        "f-test-file"
"C-c p V"        "browse-dirty-projs"
"C-c p a"	 "fof"
"C-c p b"        "switch-to-buffer"
"C-c p c"        "compile-proj"
"C-c p d"	 "fd"
"C-c p e"	 "recentf"
"C-c p f"	 "ff"
"C-c p g"        "ff-dwim"
"C-c p i"        "invalidate-cache"
"C-c p j"        "f-tag"
"C-c p k"        "kill-buffers"
"C-c p l"        "ff-in-directory"
"C-c p m"	 "commander"
"C-c p o"        "multi-occur"
"C-c p p"        "switch-proj"
"C-c p q"        "switch-open-proj"
"C-c p r"	 "replace"
"C-c p s"  	 "search"
"C-c p s g"	 "grep"
"C-c p s r"	 "ripgrep"
"C-c p s s"	 "ag"
"C-c p t"        "toggle-between-implementation-and-test"
"C-c p u"        "run-proj"
"C-c p v"	 "vc"
"C-c p x"	 "sh"
"C-c p x e"      "run-esh"
"C-c p x i"      "run-ielm"
"C-c p x s"      "run-sh"
"C-c p x t"      "run-term"
"C-c p O"        "counsel"
"C-c p O a"        "org agenda"
"C-c p O c"        "org capture"
"C-c p z"        "cache-current-file"

;;;; SPC REPLACEMENTS ;;;;

"SPC"        "projectile"
"SPC SPC !"        "run-sh-command-in-root"
"SPC SPC &"        "run-async-sh-command-in-root"
"SPC SPC 4"	 "other window"
"SPC SPC 4 C-o"    "display-buffer"
"SPC SPC 4 D"      "dired-other-window"
"SPC SPC 4 a"      "fof-other-window"
"SPC SPC 4 b"      "switch-to-buffer-other-window"
"SPC SPC 4 d"      "fd-other-window"
"SPC SPC 4 f"      "ff-other-window"
"SPC SPC 4 g"      "ff-dwim-other-window"
"SPC SPC 4 t"      "f-implementation-or-test-other-window"
"SPC SPC 5"	 "other frame"
"SPC SPC 5 D"      "dired-other-frame"
"SPC SPC 5 a"      "fof-other-frame"
"SPC SPC 5 b"      "switch-to-buffer-other-frame"
"SPC SPC 5 d"      "fd-other-frame"
"SPC SPC 5 f"      "ff-other-frame"
"SPC SPC 5 g"      "ff-dwim-other-frame"
"SPC SPC 5 t"      "f-implementation-or-test-other-frame"
"SPC SPC <left>"   "prev-proj-buffer"
"SPC SPC <right>"  "next-proj-buffer"
"SPC SPC C"        "config-proj"
"SPC SPC D"	 "dired"
"SPC SPC E"        "edit-dir-locals"
"SPC SPC ESC"	 "proj-buffers-other-buffer"
"SPC SPC F"        "ff-in-known-projs"
"SPC SPC I"	 "ibuffer"
"SPC SPC P"        "test-proj"
"SPC SPC R"        "regenerate-tags"
"SPC SPC S"        "save-proj-buffers"
"SPC SPC T"        "f-test-file"
"SPC SPC V"        "browse-dirty-projs"
"SPC SPC a"	 "fof"
"SPC SPC b"        "switch-to-buffer"
"SPC SPC c"        "compile-proj"
"SPC SPC d"	 "fd"
"SPC SPC e"	 "recentf"
"SPC SPC f"	 "ff"
"SPC SPC g"        "ff-dwim"
"SPC SPC i"        "invalidate-cache"
"SPC SPC j"        "f-tag"
"SPC SPC k"        "kill-buffers"
"SPC SPC l"        "ff-in-directory"
"SPC SPC m"	 "commander"
"SPC SPC o"        "multi-occur"
"SPC SPC p"        "switch-proj"
"SPC SPC q"        "switch-open-proj"
"SPC SPC r"	 "replace"
"SPC SPC s"  	 "search"
"SPC SPC s g"	 "grep"
"SPC SPC s r"	 "ripgrep"
"SPC SPC s s"	 "ag"
"SPC SPC s i"	 "counsel grep"
"SPC SPC t"        "toggle-between-implementation-and-test"
"SPC SPC u"        "run-proj"
"SPC SPC v"	 "vc"
"SPC SPC x"	 "sh"
"SPC SPC x e"      "run-esh"
"SPC SPC x i"      "run-ielm"
"SPC SPC x s"      "run-sh"
"SPC SPC x t"      "run-term"
"SPC SPC O"        "counsel"
"SPC SPC O a"        "org agenda"
"SPC SPC O c"        "org capture"
"SPC SPC z"        "cache-current-file")
  (setq which-key-special-keys '("SPC" "TAB" "RET" "ESC" "DEL" "C" "M"))
  (setq which-key-max-display-columns nil)
  (setq which-key-add-column-padding 4)
  (setq which-key-show-remaining-keys t)
  (setq which-key-allow-evil-operators nil)
  (setq which-key--god-mode-support-enabled t)
  (setq which-key-lighter " wk")
  (setq which-key-max-description-length 15)
  (setq which-key-enable-extended-define-key nil)
  (setq which-key-idle-delay 0.2)
  (setq which-key-idle-secondary-delay 0)
  (setq which-key-use-C-h-commands t)
  (setq which-key-is-verbose t)
  (general-define-key
   :keymaps 'which-key-C-h-map
   "C-n" nil
   "C-l" 'which-key-abort
   "C-p" nil))

(use-package elmacro
  :defer t
  :ensure t
  :config
  (general-define-key
   "C-c m l m" 'elmacro-show-last-macro
   "C-c m l c" 'elmacro-show-last-commands))

(use-package evil-swap-keys
  :after evil
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




(use-package beacon
  :defer t
  :init
  (add-hook 'beacon-dont-blink-predicates
	    (lambda () (bound-and-true-p centered-cursor-mode)))

  :ensure t
  :config
  (setq beacon-dont-blink-commands '(find-packs find-keys find-misc find-functions find-macros find-hydras find-file counsel-find-file))
  (setq beacon-size 20)
  (setq beacon-blink-when-point-moves-vertically nil)
  (setq beacon-blink-when-point-moves-horizontally nil)
  (setq beacon-blink-when-focused t)
  (setq beacon-blink-duration 0.2)
  (setq beacon-blink-delay 0.2)
  (setq beacon-blink-when-window-scrolls t)
  (setq beacon-blink-when-window-changes t))

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

(use-package god-mode
:defer t
:ensure t)

(use-package evil-god-state
  :after god-mode
  :ensure t
  :config
  ;; (general-nvmap
  ;;   :keymaps 'override
  ;;   "," 'evil-execute-in-god-state)
  (evil-define-key 'god global-map [escape] 'evil-god-state-bail))

(use-package bug-hunter
:defer t
:ensure t)

(use-package recursive-narrow
  :ensure t)

(use-package caps-lock
:defer t
:ensure t)

(use-package aggressive-fill-paragraph
:defer t
:ensure t)

(use-package helpful
  :defer nil
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

(use-package benchmark-init
  :ensure t
  :init
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  :config
  (general-unbind 'benchmark-init/tree-mode-map
    :with 'quit-window
    [remap my/quiet-save-buffer])

  (general-unbind 'benchmark-init/tabulated-mode-map
    :with 'quit-window
    [remap my/quiet-save-buffer]))

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
:ensure t)

(use-package unkillable-scratch
  :ensure t
  :config
  ;; (setq unkillable-buffers '("^\\*scratch\\*$"))
  (setq unkillable-scratch-behavior 'bury)
  :config
  (unkillable-scratch))

(use-package sudo-edit
:defer t
:ensure t)

(use-package activity-watch-mode
:ensure t
:config
(global-activity-watch-mode +1))
