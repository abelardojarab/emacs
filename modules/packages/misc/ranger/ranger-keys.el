(general-define-key
 :keymaps 'ranger-mode-map
 "," 'olivetti-mode
 "<S-return>" 'ranger-find-file-in-workspace
 "<escape>" 'ranger-close
 "<insert>" 'dired-create-empty-file
 "C-j" 'counsel-M-x
 "C-k" 'counsel-find-file
 "C-l" 'ranger-find-links-dir
 "C-n" 'ignore
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
 "v" 'hydra-more-commands/body
 "z" 'hydra-window/body
 "h" 'split-window-horizontally
 "j" 'my/split-vertically
 "l" 'my/split-right
 "k" 'split-window-below
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

(leader
  :states '(normal visual)
  :keymaps 'override
  ;; "SPC" 'ranger-find-links-dir
  "r" 'ranger)
