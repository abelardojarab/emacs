;;;; KEYMAPPINGS ;;;;;

(general-define-key
 :keymaps 'inferior-python-mode-map
 "M-e" 'counsel-shell-history
 "C-c j" 'my/evil-shell-bottom
 "C-c u" 'universal-argument
 "C-u" 'comint-kill-input
 "C-l" 'comint-clear-buffer
 "C-j" 'counsel-M-x
 "C-;" 'kill-buffer-and-window
 "C-n" 'comint-next-input
 "C-p" 'comint-previous-input)

(general-nvmap
  :keymaps 'inferior-python-mode-map
  "C-j" 'counsel-M-x)

(general-unbind 'inferior-python-mode-map
  :with 'ignore
  [remap my/quiet-save-buffer])

(general-unbind 'python-mode-map
  :with 'my/python-shebang
  [remap my/bash-shebang])

;; (general-unbind 'python-mode-map
;;   :with 'my/python-save-buffer
;;   [remap my/quiet-save-buffer])

(general-define-key
 :keymaps 'python-mode-map
 "C-=" 'string-inflection-python-style-cycle
 "C--" 'quickrun
 "<tab>" 'yafolding-toggle-element
 "C-." 'my/indent-tools-hydra/body
 "M-e" 'python-nav-forward-statement
 "M-a" 'python-nav-backward-statement)

(general-unbind 'python-mode-map
  :with 'my/python-save-buffer
  [remap my/quiet-save-buffer])

(general-nvmap
  :keymaps 'python-mode-map
  "<C-return>" 'elpy-goto-definition
  "<tab>" 'yafolding-toggle-element
  "C--" 'quickrun
  "C-." 'my/indent-tools-hydra/body
  "<tab>" 'hs-toggle-hiding
  "RET" 'hydra-python-mode/body
  "zm" 'evil-close-folds
  "M-e" 'python-nav-forward-statement
  "M-a" 'python-nav-backward-statement
  "gh" 'outline-up-heading
  "gl" 'outline-next-heading
  "zl" 'outline-show-subtree
  ;; "<M-return>" 'indent-buffer-python
  "<" 'python-indent-shift-left
  ">" 'python-indent-shift-right
  "gj" 'outline-forward-same-level
  "gk" 'outline-backward-same-level)

(general-imap
  :keymaps 'python-mode-map
  "C--" 'my/my-quickrun
  "M-e" 'python-nav-forward-statement
  "M-a" 'python-nav-backward-statement)
