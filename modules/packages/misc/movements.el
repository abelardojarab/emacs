(use-package dired
  :defer t
  :ensure nil
  :config
  ;; (setq dired-omit-mode t)
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
  ;;;; KEYS ;;;;
  (general-define-key
   :keymaps 'ranger-mode-map
   "," 'olivetti-mode
   "<S-return>" 'ranger-find-file-in-workspace
   "<escape>" 'ranger-close
   "<insert>" 'dired-create-empty-file
   "C-j" 'counsel-M-x
   "C-k" 'counsel-find-file
   "C-l" 'ranger-find-links-dir
   "C-n" 'ranger-next-file
   "C-p" 'ranger-prev-file
   "D" 'dired-do-flagged-delete
   "d" 'dired-flag-file-deletion
   "gg" 'ranger-goto-top
   "i" 'ranger-go
   "m" 'my/ranger-toggle-mark
   "tp" 'delete-file
   "<C-return>" 'my/dired-do-find-marked-files
   "C-c <return>" 'dired-do-find-marked-files
   "x" 'diredp-delete-this-file
   "zi" 'ranger-toggle-details
   "C-h" 'hydra-help/body
   "zp" 'ranger-preview-toggle
   "çcm" 'dired-create-directory)

  (general-define-key
   :keymaps 'ranger-mode-map
   :prefix "SPC"
   "f" 'hydra-find-file/body'
   "0" 'delete-window
   "q" 'ranger-close
   ;; "v" 'hydra-more-commands/body
   "z" 'hydra-window/body
   ";" 'hydra-text-main/body
   "m" 'hydra-modes/body
   "c" 'hydra-commands/body
   "o" 'hydra-org-mode/body
   "i" 'hydra-org-text-commands/body
   "a" 'hydra-org-clock/body
   "d" 'hydra-quick-commands/body
   "b" 'my/evil-botright)

  (general-create-definer leader
    :prefix "SPC")

  (general-unbind 'ranger-mode-map
    :with 'ranger-prev-file
    [remap ranger-to-dired])

  (leader
    :states '(normal visual)
    :keymaps 'override
    ;; "SPC" 'ranger-find-links-dir
    "r" 'ranger)

  ;;;; SETTINGS ;;;;
  (setq ranger-footer-delay nil)
  (setq ranger-minimal t)
  (setq ranger-footer-delay 0)
  (setq ranger-parent-depth 1)
  (setq ranger-preview-file nil)
  (setq ranger-override-dired t)
  (setq ranger-persistent-sort t)
  (setq ranger-cleanup-eagerly t)
  (setq ranger-dont-show-binary t)
  (setq ranger-width-preview 0.40)
  (setq ranger-width-parents 0.20)
  (setq ranger-max-preview-size 0.1)
  (setq ranger-cleanup-on-disable t)
  (setq ranger-return-to-ranger nil)
  (setq ranger-deer-show-details nil)
  (setq ranger-max-parent-width 0.45)
  (setq ranger-excluded-extensions '("mkv" "iso" "mp4" "bin" "exe" "msi" "pdf" "doc" "docx"))

  ;;;; FUNCTIONS ;;;;
  (defun my/ranger-go (path)
    (interactive
     (list
      (read-char-choice
       "

a : math
d : dotfiles
e : emacs.d
h : home
m : modules
o : org
s : scripts
t : studying
> "
       '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j ?l ?m ?n ?o ?p ?q ?r ?s ?t ?z))))
    (message nil)
    (let* ((c (char-to-string path))
           (new-path
            (cl-case (intern c)
              ('a "~/Math")
              ('d "~/dotfiles")
              ('e "~/.emacs.d")
              ('h "~")
              ('m "~/.emacs.d/modules")
              ('o "~/org")
              ('s "~/scripts")
              ('t "~/Studying")
              ('q nil)))
           (alt-option
            (cl-case (intern c)
              ;; Subdir Handlng
              ('j 'ranger-next-subdir)
              ('k 'ranger-prev-subdir)
              ;; Tab Handling
              ('n 'ranger-new-tab)
              ('T 'ranger-prev-tab)
              ('t 'ranger-next-tab)
              ('c 'ranger-close-tab))))
      (when (string-equal c "q")
        (keyboard-quit))
      (when (and new-path (file-directory-p new-path))
        (ranger-find-file new-path))
      (when (eq system-type 'windows-nt)
        (when (string-equal c "D")
          (ranger-show-drives)))
      (when alt-option
        (call-interactively alt-option))))
  (advice-add 'ranger-go :override #'my/ranger-go)

;;;; OPTIONS ;;;
  (defun my/ranger-options
      () (interactive)
      (let ((inhibit-message t))
        (setq truncate-lines t))
      (line-numbers)
      (olivetti-mode 1))

  (defun my/ranger-options-parent () (interactive)
         (let ((inhibit-message t))
           (setq truncate-lines t)
           (line-no-numbers)
           (dired-hide-details-mode)))

;;;; COMMANDS ;;;;
  (defun my/ranger-toggle-mark ()
    (interactive)
    (ranger-toggle-mark)
    (ranger-next-file 1))

  (defun my/ranger-toggle-mark ()
    (interactive)
    (ranger-toggle-mark)
    (ranger-next-file 1))

  (defun my/dired-do-find-marked-files ()
    (interactive)
    (dired-do-find-marked-files)
    (delete-other-windows))

;;;; FIND ;;;;
  (defun ranger-find-bashdot ()
    (interactive)
    (let ((inhibit-message t))
      (ranger-find-file "/home/dotfiles/bash/")))

  (defun ranger-find-nvim-dir ()
    (interactive)
    (let ((inhibit-message t))
      (ranger-find-file "~/.config/nvim")))

  (defun ranger-find-scripts-dir ()
    (interactive)
    (let ((inhibit-message t))
      (ranger-find-file "~/scripts")))

  (defun ranger-find-emacs-dir ()
    (interactive)
    (let ((inhibit-message t))
      (ranger-find-file "~/.emacs.d")))

  (defun my/ranger-find-math-dir ()
    (interactive)
    (let ((inhibit-message t))
      (ranger-find-file "~/Math")))

  (defun ranger-find-file-in-workspace ()
    (interactive)
    (ranger-find-file)
    (duplicate-workspace-buffer))

  (defun my/ranger ()
    (interactive)
    (my/copy-dir)
    (start-process-shell-command "my/show-ranger" nil "~/scripts/emacs_scripts/show-ranger")))

(use-package buffer-move
  :defer t
  :ensure t)

(use-package avy
  :defer t
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

  (setq avy-timeout-seconds 0.2)
  (setq avy-highlight-first t)
  (setq avy-single-candidate-jump t)

  (general-nvmap
    ;; "C-." 'my/avy-char-2-selecting-above
    ;; "C-," 'my/avy-char-2-selecting-below
    "f" 'avy-goto-char-2-below
    "F" 'avy-goto-char-2-above
    "gF" 'evil-find-char-backward
    "gf" 'evil-find-char
    "gl" 'avy-goto-word-0-below)

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

;;;; DECLARATION ;;;;
(use-package ivy
  :ensure t
  :after nswbuff
;;;; INIT ;;;;
  :init

  (setq ivy-ignore-buffers nswbuff-exclude-buffer-regexps)

  (setq ivy-ignore-buffers '(".*Log.*"
                             ".*log.*"
                             "*Completions*"
                             ".*help.*"
                             "^#.*#$"
                             "*Shell Command Output*"
                             "*slime-repl sbcl"
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
                             "bookmark-default.el"
                             "info-history"
                             "company-shell-autoloads.el"
                             "company-shell-autoloads.el"
                             "company.el"
                             "company.el"
                             "pos-tip-autoloads.el"
                             "pos-tip-autoloads.el"
                             "*Flycheck error messages*"
                             "*company-documentation*"
                             "^.archive.org$"
                             ".*magit.*"
                             ".*elc"
                             ".*el"
                             "*Bongo Playlist*"
                             "*Bongo Library*"
                             "text_scratch"
                             "markdown_scratch"
                             "fundamental_scratch"
                             "org_scratch"
                             "prog_scratch"
                             "*scratch*"
                             ;; "*scratch*"
                             "*Warning*"
                             "*Messages*"
                             "i3keys.org"
                             "info_keys.org"))

;;;; CONFIG ;;;;
  :config

  (defun my/enable-ivy-counsel ()
    (interactive)
    (ivy-mode +1)
    (counsel-mode +1)
    (message "ivy on"))

  (defun my/disable-ivy-counsel ()
    (interactive)
    (ivy-mode -1)
    (counsel-mode -1)
    (message "ivy off"))

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
  ;; (setq counsel-ag-base-command "ag --nocolor --nogroup --ignore *.el --ignore *.html %s")

  (setq counsel-ag-base-command "ag --filename --nocolor --nogroup --smart-case --skip-vcs-ignores --silent --ignore *.html %s")

  (setq ivy-use-virtual-buffers nil)
  (setq ivy-count-format "(%d/%d) ")
  (setq counsel-bookmark-avoid-dired t)
  (setq counsel-find-file-at-point t)
  (setq counsel-outline-display-style 'title)
  (setq counsel-find-file-ignore-regexp (regexp-opt '( "log")))
  (setq counsel-find-file-ignore-regexp nil)
  (setq ivy-extra-directories nil)
  (ivy-mode 1)

;;;; KEYBINDINGS ;;;;
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
    [remap counsel-projectile-switch-to-buffer]
    [remap transpose-chars]
    [remap transpose-words])

  (general-unbind 'ivy-minibuffer-map
    :with 'ivy-next-line
    [remap counsel-projectile-switch-to-buffer])

  "C-," 'ignore
  "C-." 'ignore
  "C-;" 'ignore

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
   ;; [escape] 'abort-recursive-edit
   "C-0" 'ivy-done
   "C--" 'ivy-next-line
   "C-=" 'ivy-previous-line
   "M-d" 'ivy-next-line
   "C-t" 'ivy-next-line
   "M-u" 'ivy-previous-line
   "C-w" 'ivy-backward-kill-word
   "C-u" 'backward-kill-line
   "<XF86Calculator>" 'abort-recursive-edit)

  (general-define-key
   :keymaps 'ivy-mode-map
   "C-c ." 'ivy-resume
   "C-c v p" 'ivy-push-view
   "C-c v P" 'ivy-pop-view
   "C-c v v" 'ivy-switch-view)

  (general-imap
    :keymaps 'ivy-mode-map
    "M-u" 'ivy-yasnippet)

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
   "C-x b" 'counsel-bookmark
   "M-y" 'counsel-yank-pop)

  (defun my/benchmark-init-commands ()
    (interactive)
    (counsel-M-x "^benchmark-init/"))

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

(use-package i3wm-config-mode
  :load-path "~/.emacs.d/modules/packages/lisp/"
  :config
  (general-nvmap
    :keymaps 'i3wm-config-mode-map
    "<backspace>" 'my/org-src-exit))

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

;; (add-hook 'ea-popup-hook 'popup-handler)

;; (defun popup-handler (app-name window-title x y w h)
;;   (markdown-mode))

;; (defun popup-handler (app-name window-title x y w h)
;;   (web-mode)
;;   (olivetti-mode)
;;   (evil-insert-state)
;;   (yank)
;;   (my/disable-save))

;; (defun my/disable-save ()
;;   (general-unbind 'web-mode-map
;;     :with 'ignore
;;     [remap my/quiet-save-buffer]))

(use-package atomic-chrome
  :ensure t
  :config
  (setq atomic-chrome-default-major-mode 'markdown-mode)
  (setq atomic-chrome-buffer-open-style 'full)
  (add-hook 'atomic-chrome-edit-mode-hook 'my/atomic-chrome-hooks)

  (general-unbind 'atomic-chrome-edit-mode-map
    :with 'atomic-chrome-close-current-buffer
    [remap my/kill-this-buffer])

  (general-unbind 'atomic-chrome-edit-mode-map
    :with 'ignore
    [remap my/quiet-save-buffer])

  (defun my/atomic-chrome-hooks ()
    (interactive)
    (focus-emacs)
    ;; (olivetti-mode)
    )

  (atomic-chrome-start-server))

(use-package nswbuff
  :ensure t
  :config
  (setq nswbuff-delay-switch nil)
  (setq nswbuff-display-intermediate-buffers t)
  (setq nswbuff-recent-buffers-first nil)
  (setq nswbuff-start-with-current-centered t)
  (setq nswbuff-clear-delay 4)
  (setq nswbuff-buffer-list-function 'nswbuff-projectile-buffer-list)
  (setq nswbuff-include-buffer-regexps '("*Org Src"
                                         "\.pdf$"
                                         "*shell*"
                                         "*info*"))

  (setq nswbuff-exclude-buffer-regexps '("^\\*.*\\*"
                                         "Dired"
                                         "*slime-repl sbcl"
                                         "erc-mode"
                                         "help-mode"
                                         "completion-list-mode"
                                         "/home/dotfiles/emacs/em/var/*.*"
                                         "/home/dotfiles/emacs/em/var/recentf-save.el"
                                         "custom.el"
                                         "Buffer-menu-mode"
                                         "gnus-.*-mode"
                                         "occur-mode"
                                         ".*Log.*"
                                         ".*log.*"
                                         "recentf-save.el"
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
                                         "epc con"
                                         "*Shell Command Output*"
                                         "*Calculator*"
                                         "*Calendar*"
                                         "*cheatsheet*"
                                         "*Help*"
                                         "*Echo Area 0*"
                                         "*Echo Area 1"
                                         "*Minibuf 0*"
                                         "*Minibuf-1*"
                                         "info-history"
                                         "bookmark-default.el"
                                         "company-shell-autoloads.el"
                                         "company.el"
                                         "pos-tip-autoloads.el"
                                         "bookmark-default.el"
                                         "company-shell-autoloads.el"
                                         "company.el"
                                         "pos-tip-autoloads.el"
                                         "*scratch*"
                                         "*Warning*"
                                         "*Messages*"
                                         "^init.org$"
                                         "^packs.org$"
                                         "^functions.org$"
                                         "^keys.org$"
                                         "^misc.org$"
                                         "^macros.org$"
                                         "^hydras.org$"
                                         "^links.org$"
                                         "^custom.el$"
                                         "*Flycheck error messages*"
                                         "*Flymake log*"
                                         "*company-documentation*"
                                         "^.archive.org$"
                                         ".*magit.*"
                                         ".*elc"
                                         "*shell*"
                                         "*new*"
                                         "*Flycheck error messages*"
                                         "*clang-output*"
                                         "*Bongo Playlist*"
                                         "*eclim: problems*"
                                         "*eclimd*"
                                         "*compilation*"
                                         "*Bongo Library*"
                                         ;; ".*pdf"
                                         "*Outline.*"
                                         "*blacken*"
                                         "*server*"
                                         "*code-conversion-work*"
                                         "*blacken-error*"
                                         "*quickrun*")))

(use-package link-hint
  :ensure t)
