(use-package projectile
  :defer t
  :ensure t
  :config
  ;;;; SETTINGS ;;;;
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

  (setq projectile-enable-caching 't)
  (setq projectile-mode-line-prefix " <p>")
  (setq projectile-mode-line-function
        '(lambda () (format " <p> [%s]" (projectile-project-name))))

  (shut-up
    (defvaralias 'projectile-globally-ignored-buffers 'nswbuff-exclude-buffer))

  ;;;; FUNCTIONS ;;;;
  (defun my/counsel-projectile-commands ()
    (interactive)
    (counsel-M-x "^counsel-projectile "))

  (defun my/projectile-show-commands ()
    (interactive)
    (counsel-M-x "^projectile- "))

  ;;;; KEYBINDINGS ;;;;
  ;; (general-nvmap
  ;;   "M-r" 'counsel-projectile-switch-to-buffer)

  (general-define-key
   :keymaps 'projectile-mode-map
   "M-r" nil
   "M-]" 'projectile-next-project-buffer
   "M-[" 'projectile-previous-project-buffer)

  (general-unbind 'projectile-command-map
    "ESC")

  (general-define-key
   "M-u" 'counsel-projectile-switch-to-buffer)

  (general-define-key
   :keymaps 'projectile-command-map
   "ESC" 'keyboard-quit
   "TAB" 'projectile-project-buffers-other-buffer))

(use-package counsel-projectile
  :ensure t
  :after nswbuff
  :config
  (counsel-projectile-mode 1))
