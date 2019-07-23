(setq projectile-globally-ignored-directories '(".hg"
                                                ".git"
                                                ".old"
                                                ".bzr"
                                                ".tox"
                                                ".svn"
                                                ".idea"
                                                "~/.e/"
                                                "~/org"
                                                ".eunit"
                                                "_darcs"
                                                "~/maps"
                                                "~/.fzf/"
                                                "~/.tmux/"
                                                "_FOSSIL_"
                                                "~/.pyenv/"
                                                "~/.irssi/"
                                                ".fslckout"
                                                "~/scripts/"
                                                "~/.config/"
                                                "~/dotfiles"
                                                "~/.emacs.d"
                                                "~/.emacs.d/"
                                                ".stack-work"
                                                ".ensime_cache"
                                                "~/Studying/UFBA"
                                                "~/.emacs.d/quelpa"
                                                "~/.emacs_anywhere/"
                                                "~/.PyCharmCE2019.1/"
                                                "*PyCharmCE2019*"
                                                "~/maps/.emacs_anywhere"
                                                "/home/dotfiles/.emacs.d/"
                                                "~/Studying/Unifacs/Segundo_Semestre"))

(setq projectile-globally-ignored-buffers '("^\\*.*\\*"
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
                                            "*quickrun*"))

(setq projectile-project-search-path nil)

(setq projectile-sort-order 'recently-active)
(setq projectile-enable-caching t)
(setq projectile-mode-line-prefix " <p>")
(setq projectile-mode-line-function '(lambda () (format " <p> [%s]" (projectile-project-name))))

(defun my/counsel-projectile-commands ()
  (interactive)
  (counsel-M-x "^counsel-projectile "))

(defun my/projectile-show-commands ()
  (interactive)
  (counsel-M-x "^projectile- "))

(general-nvmap
  "M-r" 'counsel-projectile-switch-to-buffer)

(general-define-key
 :keymaps 'projectile-mode-map
 "M-r" nil
 ;; "M-r" 'counsel-projectile-switch-to-buffer
 "M-]" 'projectile-next-project-buffer
 "M-[" 'projectile-previous-project-buffer)

;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "<f10>") 'projectile-command-map)

(general-unbind 'projectile-command-map
  "ESC")

(general-define-key
 "M-u" 'counsel-projectile-switch-to-buffer)
(general-define-key
 :keymaps 'projectile-command-map
 "ESC" 'keyboard-quit
 "TAB" 'projectile-project-buffers-other-buffer)
