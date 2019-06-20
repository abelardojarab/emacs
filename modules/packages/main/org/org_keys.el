(general-define-key
 :keymaps 'org-src-mode-map
 "M-m" 'org-edit-src-exit)

(general-nvmap
  :keymaps 'org-src-mode-map
  "M-m" 'org-edit-src-exit)

(defun my/agenda-return ()
  (interactive)
  (org-agenda-switch-to 'delete-other-windows))

(defun my/agenda-switch-to ()
  (interactive)
  (org-agenda-switch-to))

(defun my/agenda-goto ()
  (interactive)
  (org-agenda-goto)
  (other-window -1))

(general-unbind 'org-agenda-mode-map
  :with 'windmove-down
  [remap org-agenda-drag-line-forward])

(general-unbind 'org-agenda-mode-map
  :with 'windmove-up
  [remap org-agenda-drag-line-backward])

(general-unbind 'org-agenda-mode-map
  :with 'my/agenda-return
  [remap org-agenda-switch-to])

(general-define-key
 :keymaps 'org-agenda-mode-map
 "C-c g" 'my/agenda-goto
 "M-0" 'my/org-agenda
 "M-1" 'org-1-day-agenda
 "M-2" 'org-2-days-agenda
 "M-3" 'org-3-days-agenda
 "C-c m" 'my/agenda-switch-to)

(general-define-key
 :keymaps 'org-mode-map
 "M-'" 'org-cycle-agenda-files)

(general-define-key
 :keymaps 'org-mode-map
 "C-<" 'org-priority-up
 "C->" 'org-priority-down
 "<C-S-up>" 'org-priority-up
 "<C-S-down>" 'org-priority-down
 "C-c C-b" nil
 "C-j" 'counsel-M-x
 "C-M-k" 'org-metaup
 "C-M-j" 'org-metadown
 "C-c C-s" 'org-emphasize
 "C-c C-b C-t" 'org-toggle-checkbox
 "C-c t" 'org-toggle-timestamp-type
 "C-c C-b C-c" 'org-update-checkbox-count
 "C-c C-b C-b" 'org-reset-checkbox-state-subtree)

(general-imap
  :keymaps 'org-mode-map
  "M-m" 'org-edit-special)

(general-nvmap
  :keymaps 'org-mode-map
  "zm" 'org-hide-all
  "C-j" 'counsel-M-x
  "M-m" 'org-edit-special
  "<insert>" 'org-insert-link
  "M-n" 'org-forward-paragraph
  "RET" 'hydra-spell/body
  "M-p" 'org-backward-paragraph
  "M-e" 'evil-forward-sentence-begin
  "M-a" 'evil-backward-sentence-begin
  "SPC TAB" 'outline-hide-subtree)

(general-define-key
 :keymaps 'org-capture-mode-map
 :states '(normal visual insert)
 "<C-return>" 'org-capture-finalize)

(general-unbind 'org-capture-mode-map
  :with 'org-capture-kill
  [remap my/quiet-save-buffer])

(general-nvmap
  :keymaps 'org-mode-map
  :prefix "SPC"
  "a" 'hydra-org-clock/body
  "i" 'hydra-org-text-commands/body)
