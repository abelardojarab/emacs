;;; tmuxconf-emacs.el --- tmux emacs mode

;; Copyright (C) 2014 Steven Knight

;; Author: Steven Knight <steven@knight.cx>
;; URL: https://github.com/skk/i3wm-emacs

(define-derived-mode tmuxconf-emacs text-mode
  "tmuxconf-emacs" "Major mode for editing configuration files for i3 (http://i3wm.org/)."

  (defvar tmux-config-keywords
    '("set" "setw" "set-window-option" "set-clipboard" "set-titles" "set-titles-string" "bind-key" "bind" "unbind")
    "tmux Config keywords")

  (defvar tmux-config-types
    '()
    "tmux Config types.")

  (defvar tmux-config-constants
    '()
    "tmux Config constants.")

  (defvar tmux-config-events
    '("-g" "-n" "@plugin")
    "tmux Config events.")

  (defvar tmux-config-functions
    '()
    "tmux Config functions.")

  (defvar tmux-config-keywords-regexp (regexp-opt tmux-config-keywords 'words))
  (defvar tmux-config-type-regexp (regexp-opt tmux-config-types 'words))
  (defvar tmux-config-constant-regexp (regexp-opt tmux-config-constants 'words))
  (defvar tmux-config-event-regexp (regexp-opt tmux-config-events 'words))
  (defvar tmux-config-functions-regexp (regexp-opt tmux-config-functions 'words))

  (setq tmux-config-font-lock-keywords
        `(
          (,tmux-config-type-regexp . font-lock-type-face)
          (,tmux-config-constant-regexp . font-lock-constant-face)
          (,tmux-config-event-regexp . font-lock-builtin-face)
          (,tmux-config-functions-regexp . font-lock-function-name-face)
          (,tmux-config-keywords-regexp . font-lock-keyword-face)
          ;; note: order above matters.
          ))

  ;; code for syntax highlighting
  (setq font-lock-defaults '((tmux-config-font-lock-keywords)))

  ;; clear memory
  (setq tmux-config-keywords nil)
  (setq tmux-config-types nil)
  (setq tmux-config-constants nil)
  (setq tmux-config-events nil)
  (setq tmux-config-functions nil))

(provide 'tmuxconf-emacs)

(add-to-list 'auto-mode-alist '("\\.*tmux.*\\'" . tmuxconf-emacs))

;;; tmuxconf-emacs.el ends here
