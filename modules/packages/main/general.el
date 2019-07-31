(use-package general
  :ensure t

:config
(defun my/kill-previous-buffer ()
  (interactive)
  (kill-buffer (last-buffer)))

;; (define-key key-translation-map (kbd "<f12>") (kbd "C-c"))

(general-create-definer leader
  :prefix "SPC")

(leader
  :states '(normal visual)
  :keymaps 'override

;;;; SPLITTING ;;;;

  ;; "h" 'split-window-horizontally
  ;; "j" 'my/split-vertically
  ;; "k" 'split-window-below
  ;; "l" 'my/split-right
  "f" 'hydra-org-clock/body
  "R" 'eyebrowse-rename-window-config
  "r" 'ranger
  "g" 'my/ranger
  "k" 'hydra-kill/body
  "q" 'my/kill-this-buffer
  "0" 'delete-window
  "U" 'widenToCenter
  "u" 'hydra-find-emacs-files/body
  "o" 'hydra-org-mode/body
  "e" 'widen
  "t" 'counsel-recentf)

(leader
  :states '(normal)
  :keymaps 'prog-mode-map
  "w" 'widenToCenter
  "n" 'narrow-to-defun)

(leader
  :states '(normal visual)
  "w" 'recursive-widen
  "v" 'undo-propose
  "w" 'recursive-widen
  "n" 'recursive-narrow-or-widen-dwim)

(general-unbind 'global
  "<C-next>"
 ;; "[("
 ;; "[)"
 ;; "[{"
 ;; "[}"
 ;; "[]"
 ;; "]("
 ;; "])"
 ;; "]{"
 ;; "]}"
 ;; "]]"
 ;; "[["
 ;; "["
 ;; "[["
  "C-w"
  "C-c w"
  "M-u"
  "M-h"
  "M-o"
  "s-i"
  "S-SPC"
  "C-o")

(general-unbind 'override
  :with 'ignore
  "s-i"
  "s-u")

(general-unbind 'lisp-interaction-mode-map
  :with 'evil-ex-nohighlight
  [remap my/quiet-save-buffer])

(general-define-key
 "C-k" 'counsel-find-file
 "C-c 9" 'my/goto-info-eintr
 "C-c 0" 'my/goto-eintr-bookmark
 "M-1" 'org-1-day-agenda
 "M-2" 'org-2-days-agenda
 "M-3" 'org-3-days-agenda
 "M-4" 'org-4-days-agenda
 "M-5" 'org-5-days-agenda
 "M-6" 'org-6-days-agenda
 "M-7" 'org-7-days-agenda
 "<f7>" 'man
 "C-c C-l" 'org-insert-link-global
 "C-c o" 'my/org-open-link
 "C-c C-o" 'my/org-open-link
 "M-0" 'quit-window
 "C-0" 'delete-window
 "C-c DEL" 'my/bash-shebang
 "M-9" 'delete-other-windows
 "C-c E m" 'evil-record-macro
 "C-c E e" 'evil-execute-macro
 "<XF86Calculator>" 'quick-calc
 "M-p" 'my/paragraph-backwards
 "M-n" 'my/paragraph-forward
 "M-e" 'evil-forward-sentence-begin
 "M-a" 'evil-backward-sentence-begin)

(general-define-key
 :keymaps 'override

;;;; MODES ;;;;
"C-c c"       'caps-lock-mode
"C-c TAB" 'sr-speedbar-toggle

;;;; FILE COMMANDS ;;;;
"C-c F -" 'show-server
"C-c F a" 'my/save-all
"C-c F 9" 'my/man-kill
"C-c F 0" 'my/server-edit
"C-c F c" 'my/magit-commit
"C-c F t" 'my/reopen-kill-file
"C-c F s" 'my/magit-stage-modified
"C-x C-n" 'org-noter-insert-note
"C-x C-p" 'org-noter-insert-precise-note
"C-x p"    'my/counsel-projectile-commands
"C-c r"    'restart-emacs
"C-x g"    'magit-status
"C-c F r" 'byte-recompile-file
;; "C-c ç"   'my/goto-info-buffer-other-window

"C-c b" 'my/benchmark-init-commands
"C-c k" 'hydra-kill/body
"C-c ;" 'kill-buffer-and-window
;; "C-c p" 'my/search-pack
;; "C-c b i" 'emacs-init-time
;; "C-c b t" 'benchmark-init/show-durations-tree
;; "C-c b o" 'my/time-benchmark
"C-c x" 'my/show-variable-at-point
"C-c L n" 'noctilux-on

;;;; FILESETS ;;;;
"C-j" 'counsel-M-x
"C-c f" 'make-frame
"C-c e" 'my/eyebrowse-create-named-configs
;; "C-c p" 'my/kill-previous-buffer

;;;; EDITING ;;;;
"C-c i" 'ibuffer

;;;; QUICK KEYS ;;;;
"<f12>" 'org-journal-new-entry
"M-c" nil
"C-x l" nil
"<C-S-f10>" 'buffer-menu-open
"<mouse-3>" nil
"C-c u" 'universal-argument
"C-x u" 'my/undo-propose
"C-c s" 'hydra-shell/body
"C-," 'helpful-at-point
"C-." 'helpful-variable
"C-;" 'helpful-function
;; "C-c x" 'my/kill-buffer-and-workspace
"M-." 'nswbuff-switch-to-next-buffer
"M-," 'nswbuff-switch-to-previous-buffer
"C-SPC" nil
"M-s" 'last-buffer
"M-y" 'counsel-yank-pop
"C-t" 'transpose-chars
"C-x ," 'my/jump-to-register-91
"C-x ." 'my/jump-to-register-eight
"C-S-l" 'redraw-display
"C-9" 'delete-other-windows)

(general-define-key
 :keymaps 'minibuffer-local-map
 "C-u" 'backward-kill-line
 "C-w" 'backward-kill-word)

(general-evil-setup t))
