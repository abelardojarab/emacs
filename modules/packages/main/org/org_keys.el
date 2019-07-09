;;;; ORG SRC KEYBINDINGS ;;;;

(general-define-key
 :keymaps 'org-src-mode-map
 "SPQ q" nil
 "M-m" 'org-edit-src-exit)

(general-unbind 'org-src-mode-map
  :with 'org-edit-src-exit
  [remap org-edit-src-exit])

(general-nmap
  :keymaps 'org-src-mode-map
  "SPQ q" 'my/org-src-exit
  "<backspace>" 'my/org-src-exit)

(general-nvmap
  :keymaps 'org-mode-map
  "M-m" 'org-edit-special
  "<backspace>" 'org-edit-special)

;;;; OTHER KEYBINDINGS ;;;;

(general-define-key
 :keymaps 'org-mode-map
 "<C-M-return>" 'zin/org-open-other-frame
 "C-c C-b" nil
 "C-c n" 'my/org-open-next-link
 "C-c p" 'my/org-open-prev-link
 "C-j" 'counsel-M-x
 "C-M-k" 'org-metaup
 "M-ç" 'indent-buffer
 "C-M-j" 'org-metadown
 "C-<" 'org-priority-up
 "C->" 'org-priority-down
 "C-c C-s" 'org-emphasize
 "<C-S-up>" 'org-priority-up
 "<C-S-down>" 'org-priority-down
 "C-c C-b C-t" 'org-toggle-checkbox
 "C-c t" 'org-toggle-timestamp-type
 "C-c C-b C-c" 'org-update-checkbox-count
 "C-c C-b C-b" 'org-reset-checkbox-state-subtree)

(general-define-key
 :keymaps 'org-agenda-mode-map
 "M-0" 'my/org-agenda
 "M-1" 'org-1-day-agenda
 "C-c g" 'my/agenda-goto
 "M-2" 'org-2-days-agenda
 "M-3" 'org-3-days-agenda
 "C-c m" 'my/agenda-switch-to)

(general-nvmap
  :keymaps 'org-mode-map
  "zm" 'org-hide-all
  "C-j" 'counsel-M-x
  "<insert>" 'org-insert-link
  "M-n" 'org-forward-paragraph
  "M-p" 'org-backward-paragraph
  "SPC TAB" 'outline-hide-subtree
  "M-e" 'evil-forward-sentence-begin
  "M-a" 'evil-backward-sentence-begin)

(general-define-key
 :keymaps 'org-mode-map
 "M-'" 'org-cycle-agenda-files)

(general-define-key
 :keymaps 'org-capture-mode-map
 :states '(normal visual insert)
 "<C-return>" 'org-capture-finalize)

(general-nvmap
  :keymaps 'org-mode-map
  :prefix "SPC"
  "a" 'hydra-org-clock/body
  "i" 'hydra-org-text-commands/body)

(general-unbind 'org-capture-mode-map
  :with 'org-capture-kill
  [remap my/quiet-save-buffer])

;;;; OTHER AGENDA ;;;;

(general-unbind 'org-agenda-mode-map
  :with 'windmove-up
  [remap org-agenda-drag-line-backward])

(general-unbind 'org-agenda-mode-map
  :with 'windmove-down
  [remap org-agenda-drag-line-forward])

(general-unbind 'org-agenda-mode-map
  :with 'my/agenda-return
  [remap org-agenda-switch-to])
