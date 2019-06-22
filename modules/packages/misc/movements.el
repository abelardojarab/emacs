(use-package dired
  :defer t
  :ensure nil
  :config
  (setq dired-omit-mode t)
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches "-lsh")
  (setq dired-hide-details-mode t)
  (setq truncate-lines t)
  (add-hook 'dired-mode-hook 'line-numbers))

(use-package dired+
  :quelpa (dired+ :fetcher url :url "https://www.emacswiki.org/emacs/download/dired+.el")
  :after dired
  :ensure nil
  :config
  (setq diredp-hide-details-initially-flag t)
  (setq diredp-hide-details-propagate-flag t)
  (diredp-toggle-find-file-reuse-dir t))

(use-package ranger
  :ensure t
  :init
  (add-hook 'ranger-mode-hook 'my/ranger-options)
  (add-hook 'ranger-parent-dir-hook 'my/ranger-options-parent)
  :config
  (setq ranger-footer-delay nil)
  (load-file "~/.emacs.d/modules/packages/misc/ranger/ranger-keys.el")
  (load-file "~/.emacs.d/modules/packages/misc/ranger/ranger-settings.el")
  (load-file "~/.emacs.d/modules/packages/misc/ranger/ranger-functions.el"))

(use-package buffer-move
:defer t
:ensure t)

(use-package avy
  :defer 2
  :ensure t
  :config
  (defun my/avy-char-2-selecting-below ()
    (interactive)
    (evil-visual-state)
    (evil-avy-goto-char-2-below nil))

  (defun my/avy-char-2-selecting-above ()
    (interactive)
    (evil-visual-state)
    (evil-avy-goto-char-2-above nil))

  (setq avy-timeout-seconds 0.3)
  (setq avy-highlight-first t)
  (setq avy-single-candidate-jump t)

  (general-nvmap
    ;; "C-." 'my/avy-char-2-selecting-above
    ;; "C-," 'my/avy-char-2-selecting-below
    "f" 'avy-goto-char-2-below
    "F" 'avy-goto-char-2-above
    "gF" 'evil-find-char-backward
    "gf" 'evil-find-char)

  (setq avy-background nil)

  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l
		      ?q ?w ?e ?r ?t ?y ?u))
  (setq avy-all-windows nil))

(use-package windmove
  :config
  (setq windmove-wrap-around nil)
  (general-nvmap
    :keymaps 'override
    "M-k" 'windmove-up
    "M-h" 'windmove-left
    "M-j" 'windmove-down
    "M-l" 'windmove-right)

  (general-define-key
   :keymaps 'override
   "M-k" 'windmove-up
   "M-h" 'windmove-left
   "M-j" 'windmove-down
   "M-l" 'windmove-right)

  (general-define-key
   :keymaps 'override
   "<M-up>" 'windmove-up
   "<M-left>" 'windmove-left
   "<M-down>" 'windmove-down
   "<M-right>" 'windmove-right))

(use-package ivy
:ensure t

:init
(setq ivy-ignore-buffers '(".*Log.*"
			     ".*log.*"
			     ".*help.*"
			     "^#.*#$"
			     "*Shell Command Output*"
			     "*Calculator*"
			     "*Calendar*"
			     "*Help*"
			     "*Calc Trail*"
			     "magit-process"
			     "magit-diff"
			     "*Org-Babel Error Output*"
			     "\\`\\*helm"
			     "\\`\\*Echo Area"
			     "\\`\\*Minibuf"
			     "Ibuffer"
			     "*cheatsheet*"
			     "*Echo Area 0*"
			     "*Echo Area 1"
			     "*Minibuf 0*"
			     "bookmark-default.el"
			     "info-history"
			     "company-shell-autoloads.el"
			     "company.el"
			     "pos-tip-autoloads.el"
			     "*Flycheck error messages*"
			     "*company-documentation*"
			     "^.archive.org$"
			     ".*magit.*"
			     ".*elc"
			     "*Bongo Playlist*"
			     "*Bongo Library*"
			     "text_scratch"
			     "markdown_scratch"
			     "fundamental_scratch"
			     "org_scratch"
			     "prog_scratch"
			     ;; "*scratch*"
			     "*Warning*"
			     "*Messages*"
			     "i3keys.org"
			     "info_keys.org"))

:config
(defun ivy-with-thing-at-point (cmd)
  (let ((ivy-initial-inputs-alist
	 (list
	  (cons cmd (thing-at-point 'symbol)))))
    (funcall cmd)))

(defun counsel-ag-thing-at-point ()
  (interactive)
  (ivy-with-thing-at-point 'counsel-ag))

(defun counsel-projectile-ag-thing-at-point ()
  (interactive)
  (ivy-with-thing-at-point 'counsel-projectile-ag))

(setq ivy-wrap t)
(setq ivy-on-del-error-function #'ignore)
(setq counsel-ag-base-command "ag --nocolor --nogroup --ignore *.el --ignore *.html %s")
;; (setq counsel-ag-base-command "ag --nocolor --nogroup --ignore *.html %s")
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq counsel-bookmark-avoid-dired t)
(setq counsel-find-file-at-point t)
(setq counsel-outline-display-style 'title)
(setq counsel-find-file-ignore-regexp (regexp-opt '( "log")))
(setq counsel-find-file-ignore-regexp nil)
(setq ivy-extra-directories nil)
(ivy-mode 1)

(general-unbind 'ivy-minibuffer-map
  :with 'ignore
  [remap windmove-up]
  [remap windmove-left]
  [remap windmove-right])

(general-unbind 'ivy-minibuffer-map
  :with 'ivy-kill-ring-save
  [remap eyebrowse-next-window-config])

(general-unbind 'ivy-minibuffer-map
  :with 'ivy-alt-done
  [remap windmove-down])

(general-unbind 'ivy-minibuffer-map
  :with 'ivy-next-line
  [remap counsel-projectile-switch-to-buffer])

(general-define-key
 :keymaps 'ivy-minibuffer-map
 "<insert>" 'clipboard-yank
 "<C-return>" 'ivy-immediate-done
 "C-h" 'ivy-backward-delete-char
 "TAB" 'ivy-alt-done
 "C-c -" 'my/ivy-done-and-narrow
 "M-m" 'ivy-done
 "C-m" 'ivy-done
 "C-c o" 'ivy-kill-ring-save
 [escape] 'abort-recursive-edit
 "C-0" 'ivy-done
 "C--" 'ivy-next-line
 "C-=" 'ivy-previous-line
 "M-d" 'ivy-next-line
 "M-u" 'ivy-previous-line
 "C-w" 'ivy-backward-kill-word
 "C-u" 'backward-kill-line
 "<XF86Calculator>" 'abort-recursive-edit)

(general-define-key
 :keymaps 'ivy-mode-map
 "C-c v p" 'ivy-push-view
 "C-c v P" 'ivy-pop-view
 "C-c v v" 'ivy-switch-view)

(general-nvmap
  :keymaps 'ivy-mode-map
  "M-d" 'ivy-switch-buffer))

(use-package counsel
  :ensure t
  :config
  ;; (setq counsel-fzf-cmd "fzf -f \"%s\"")
  (general-unbind '(normal visual insert)
    :with 'counsel-M-x
    "C-j")

  (general-nvmap
    :keymaps 'override
    "C-k" 'counsel-find-file)

  (general-nvmap
    "C--" 'counsel-org-tag)

  (general-unbind 'ivy-minibuffer-map
    :with 'minibuffer-keyboard-quit
    [remap counsel-yank-pop])

  (general-define-key
   :keymaps 'counsel-mode-map
   "M-y" 'counsel-yank-pop)

  (recentf-mode 1)
  (counsel-mode 1))

(use-package counsel-org-clock
:after counsel
:ensure t)

(use-package eyebrowse
  ;; :defer t
  :ensure t
  :config
  (setq eyebrowse-new-workspace nil)
  (setq eyebrowse-wrap-around t)
  (setq eyebrowse-new-workspace t)
  (setq eyebrowse-mode-line-style 'smart)
  (setq eyebrowse-switch-back-and-forth nil)
  (setq eyebrowse-mode-line-left-delimiter " [ ")
  (setq eyebrowse-mode-line-right-delimiter " ]  ")
  (setq eyebrowse-mode-line-separator " | ")
  (general-nvmap
    :prefix "SPC"
    :keymaps 'override
    "V" 'eyebrowse-create-window-config
    "x" 'eyebrowse-close-window-config
    "1" 'eyebrowse-switch-to-window-config-1
    "2" 'eyebrowse-switch-to-window-config-2
    "3" 'eyebrowse-switch-to-window-config-3
    "4" 'eyebrowse-switch-to-window-config-4
    "5" 'eyebrowse-switch-to-window-config-5)

  (general-define-key
   "M-q" 'eyebrowse-prev-window-config
   "M-w" 'eyebrowse-next-window-config)

  (general-unbind 'eyebrowse-mode-map
    "C-c C-w")
  (eyebrowse-mode t))

(use-package winner
  :defer 3
  :ensure nil
  :config

  (general-define-key
   :states '(visual normal insert)
   "M--" 'winner-undo
   "M-=" 'winner-redo)

  (winner-mode 1))

(use-package ivy-hydra
:after hydra
:ensure t)

(use-package targets
  :load-path "~/.emacs.d/modules/packages/lisp/"
  :config
  (targets-setup t))

(use-package cool-moves
:load-path "~/maps/cool-moves"
:config
(general-define-key
 :keymaps 'override
"<C-down>" 'cool-moves/paragraph-forward
"<C-up>" 'cool-moves/paragraph-backward
"C-S-j" 'cool-moves/line-forward
"C-S-k" 'cool-moves/line-backward
"C-M-n" 'cool-moves/word-forward
"C-M-p" 'cool-moves/word-backwards))
