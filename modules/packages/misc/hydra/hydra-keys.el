(general-nvmap
  :keymaps 'override
  :prefix "SPC"
  "0" 'delete-window
  "SPC" 'hydra-text-main/body
  ;; "v" 'hydra-more-commands/body
  "z" 'hydra-window/body

  "s"    'hydra-search/body
  ;; "h" 'split-window-horizontally
  ;; "j" 'my/split-vertically
  ;; "l" 'my/split-right
  ;; "k" 'split-window-below

  "p" 'hydra-projectile-mode/body
  ";" 'hydra-text-main/body
  "m" 'hydra-modes/body
  "c" 'hydra-commands/body
  "d" 'hydra-quick-commands/body
  "b" 'my/evil-botright
  "a" 'my/ranger-find-math-dir
  ;; "y" 'hydra-org-agenda/body
  "y" 'org-refile
  "q" 'my/kill-this-buffer)

(general-nvmap
  :keymaps 'override
  "C-o" 'hydra-find-file/body)

(general-imap
  :keymaps 'override
  "C-o" 'hydra-find-file/body)

(general-define-key
 "C-o" 'hydra-find-file/body)

(general-nvmap
  :keymaps 'override
  "C-h" 'hydra-help/body)

(general-define-key
 :keymaps 'override
 "M-;" 'hydra-yasnippet/body
 "C-s" 'evil-ex-search-forward
 "<f1>" 'hydra-help/body)
