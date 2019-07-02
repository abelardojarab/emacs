(general-define-key
   :keymaps 'company-active-map
   "1" 'company-complete-number
   "2" 'company-complete-number
   "3" 'company-complete-number
   "4" 'company-complete-number
   "5" 'company-complete-number
   "6" 'company-complete-number
   "7" 'company-complete-number
   "8" 'company-complete-number
   "9" 'company-complete-number
   "0" 'company-complete-number
   "M-f" 'company-filter-candidates
   "M-d" 'my/company-complete-paren
   "M-h" 'company-quickhelp-manual-begin
   "M-r" 'my/company-yasnippet
   "M-k" nil
   "M-l" nil
   "C-w" 'evil-delete-backward-word
   "C-h" 'delete-backward-char
   "<tab>" 'my/company-complete-first
   "<escape>" 'company-abort
   "<return>" 'company-complete
   "M-j" 'my/company-complete-first-add-space
   "M-o" 'my/company-yasnippet)

(general-define-key
   :keymaps 'company-filter-map
   "TAB" 'my/company-complete-first
   "M-h" 'company-quickhelp-manual-begin
   "M-d" 'company-filter-candidates
   "C-k" 'my/company-complete
   "M-o" 'my/company-yasnippet
   "RET" 'company-complete)

(general-imap
    :keymaps 'company-mode-map
    "C-l" 'company-complete
    "M-/" 'hippie-expand)