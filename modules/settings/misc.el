(defun my/save-all ()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'save-some-buffers))

(defun my/quiet-save-buffer () (interactive)
       (save-excursion
	 (evil-ex-nohighlight)
	 (let ((inhibit-message t))
	   (delete-trailing-whitespace)
	   (save-buffer))))

(defun my/quiet-save-buffer-markdown () (interactive)
       (save-excursion
	 (evil-ex-nohighlight)
	 (let ((inhibit-message t))
	   (save-buffer))))

(defun my/quiet-indent-and-save-buffer ()
  (interactive)
  (evil-ex-nohighlight)
  (indent-buffer-no-excursion)
  (let ((inhibit-message t))
    (save-buffer)))

(defun widenToCenter ()
  (interactive)
  (save-excursion
    (widen)
    (recenter)))

(defun my/date ()
  (interactive)
  (save-excursion
    (shell-command "date")))

(setq mouse-autoselect-window t)
(setq calc-display-trail nil)
(setq apropos-do-all t)

;; (defun my/ranger ()
;;   (interactive)
;;   (my/copy-dir)
;;   (start-process-shell-command "my/show-ranger" nil "~/scripts/emacs_scripts/show-ranger"))
