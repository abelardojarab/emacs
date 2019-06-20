(general-nvmap
  :keymaps 'override
  :prefix "SPC"
  "0" 'delete-window
  "v" 'hydra-more-commands/body
  "z" 'hydra-window/body
  "h" 'split-window-horizontally
  "j" 'my/split-vertically
  "p" 'hydra-projectile-mode/body
  "l" 'my/split-right
  "k" 'split-window-below
  ";" 'hydra-modes/body
  "m" 'hydra-modes/body
  "c" 'hydra-commands/body
  "d" 'hydra-quick-commands/body
  "b" 'my/evil-botright
  "y" 'hydra-org-agenda/body
  "q" 'my/kill-this-buffer)

(general-define-key
 "C-;" 'hydra-text-main/body)

(general-nvmap
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
 "C-s" 'hydra-search/body
 "<f1>" 'hydra-help/body
 "C-M-h" 'hydra-help/body)
