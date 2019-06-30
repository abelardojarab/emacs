
(defalias 'sp 'start-process-shell-command)

(defun tangle-py-all ()
  (interactive)
  (my/save-all)
  (sp "tangle init" nil "~/.e/ntangle-all")
  (message " all files tangled"))


(defun tangle-py-all-recompile ()
  (interactive)
  (my/save-all)
   (sp "tangle recompile" nil "~/.e/tangle-and-recompile")
   (message " all files tangled"))

(defun my/tangle-default ()
  (interactive)
  (widenToCenter)
  (my/quiet-save-buffer)
  (org-babel-tangle-file (prelude-copy-file-name-to-clipboard))
  (message "this file was tangled"))

(defun tangle-py-all-debug ()
  (interactive)
  (my/save-all)
  (start-process-shell-command "tangle init" nil "nt ~/.emacs.d/*.org")
  (start-process-shell-command "new emacs" nil "emacs --debug-init"))

(defun tangle-py-all-new ()
  (interactive)
  (my/save-all)
  (start-process-shell-command "tangle init" nil "nt ~/.emacs.d/*.org")
  (start-process-shell-command "new emacs" nil "emacs"))

(defun my/tangle-reload-keys ()
  (interactive)
  (my/quiet-save-buffer)
  (defvar foo)
  (setq foo (concat "nt " (prelude-copy-file-name-to-clipboard)))
  (shell-command foo)
  (load-file "~/.emacs.d/modules/packages/main/general.el")
  (message "keys reloaded"))

(defun my/tangle-this-file ()
  (interactive)
  (my/quiet-save-buffer)
  (defvar foo)
  (setq foo (concat "nt " (prelude-copy-file-name-to-clipboard)))
  (shell-command foo)
  (message " file tangled"))

(defun tangle-and-eval-block ()
  (interactive)
  (save-excursion
    (let ((inhibit-message t))
      (org-narrow-to-subtree)
      (xah-clean-empty-lines)
      (org-babel-execute-src-block)
      (org-babel-remove-result)
      (start-process-shell-command "tangle" nil "nt ~/.emacs.d/*.org")
      (my/save-all))
    (message " block evaluated")))

(defun i3-reload ()
  (interactive)
  (my/save-all)
  (sp "tangle-i3" nil "~/scripts/i3_scripts/tangle-i3-reload")
  (message " i3 reloaded"))

(defun i3-restart ()
  (interactive)
  (my/save-all)
  (sp "tangle-i3" nil "~/scripts/i3_scripts/tangle-i3-restart")
  (message " i3 reloaded"))


