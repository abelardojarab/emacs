(use-package projectile
  :defer t
  :ensure t
  :config
  (defun my/counsel-projectile-commands ()
    (interactive)
    (counsel-M-x "^counsel-projectile "))

  (defun my/projectile-show-commands ()
    (interactive)
    (counsel-M-x "^projectile- "))

  ;; (general-define-key
  ;; :states '(normal visual)
  ;; :keymaps 'projectile-mode-map
  ;; "M-e" nil)

(general-nvmap
   "M-r" 'counsel-projectile-switch-to-buffer)

  (general-define-key
   :keymaps 'projectile-mode-map
   "M-r" nil
   ;; "M-r" 'counsel-projectile-switch-to-buffer
   "M-]" 'projectile-next-project-buffer
   "M-[" 'projectile-previous-project-buffer
   "C-c 0" 'my/projectile-show-commands)

  (setq projectile-globally-ignored-directories '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "~/.emacs.d/quelpa"))
  (setq projectile-globally-ignored-buffers '(".*Log.*"
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
                                              "*Shell Command Output*"
                                              "*Calculator*"
                                              "*Calendar*"
                                              "*cheatsheet*"
                                              "*Help*"
                                              "*Echo Area 0*"
                                              "*Echo Area 1"
                                              "*Minibuf 0*"
                                              "*Minibuf-1*"
                                              "bookmark-default.el"
                                              "info-history"
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
                                              ".*pdf"
                                              "*shell*"
                                              "*new*"
                                              "*Flycheck error messages*"
                                              "*clang-output*"
                                              "*Bongo Playlist*"
                                              "*eclim: problems*"
                                              "*eclimd*"
                                              "*compilation*"
                                              "*Bongo Library*"
                                              "*Outline pcc.pdf*"
                                              "*blacken*"
                                              "*server*"
                                              "*code-conversion-work*"
                                              "*blacken-error*"
                                              "*Outline pcc_2.pdf*"
                                              "*quickrun*"))
  (setq projectile-globally-ignored-modes '("erc-mode" "help-mode" "completion-list-mode" "Buffer-menu-mode" "gnus-.*-mode" "occur-mode"))
  (setq projectile-project-search-path '("~"))

  (setq projectile-mode-line-prefix " <p>")
  (setq projectile-mode-line-function '(lambda () (format " <p> [%s]" (projectile-project-name))))

  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "<f10>") 'projectile-command-map)

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
  :config
  (counsel-projectile-mode 1))
