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

(defun my/move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun my/move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun widenToCenter ()
  (interactive)
  (save-excursion
    (widen)
    (recenter)))

(defun my/paragraph-backwards ()
  (interactive)
  (previous-line)
  (backward-paragraph)
  (next-line)
  (back-to-indentation))

(defun my/paragraph-forward ()
  (interactive)
  (forward-paragraph)
  (next-line)
  (back-to-indentation))

(defun my/markdown-forward-paragraph ()
(interactive)
(markdown-forward-paragraph)
(forward-to-indentation))

(defun last-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(add-hook 'ea-popup-hook 'popup-handler)
(defun popup-handler (app-name window-title x y w h)
  (markdown-mode)
  (evil-insert-state))

(defmacro measure-time (&rest body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time)))
     ,@body
     (message "%.06f" (float-time (time-since time)))))

(defun my/date ()
  (interactive)
  (save-excursion
    (shell-command "date")))

(defun show-major-mode ()
  (interactive)
  (describe-variable 'major-mode))

(defun show-server ()
  (interactive)
  (describe-variable 'server-name))

(defun show-fill-column ()
  (interactive)
  (describe-variable 'fill-column))

(defun delete-file-and-buffer ()
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
   (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))


(defun my/move-file-to-trash ()
  (interactive)
  (move-file-to-trash (buffer-name))
  (kill-buffer)
  (delete-window))

(defun my/move-file-to-trash-close-ws ()
  (interactive)
  (move-file-to-trash (buffer-name))
  (kill-buffer)
  (eyebrowse-close-window-config))


(defun enable-cursor ()
  (interactive)
  (setq cursor-type t))

(defun disable-cursor ()
  (interactive)
  (setq cursor-type nil))

(defun eval-src-block ()
  (interactive)
  (org-edit-special nil)
  (eval-buffer)
  (org-edit-src-exit))


(defun my/eval-buffer ()
  (interactive)
  (save-excursion
  (indent-buffer)
  (eval-buffer)
  (message " buffer evaluated")))

(defun my/eval-buffer-no-save ()
  (interactive)
  (save-excursion
  (indent-buffer)
  (eval-buffer)
  (message " buffer evaluated")))


(setq mouse-autoselect-window t)
(defalias 'org 'org-mode)
(defalias 'evil 'evil-mode)
(defalias 'par 'package-delete)
(defalias 'pai 'package-install)
(defalias 'cug 'customize-group)
(defalias 'path 'prelude-copy-file-name-to-clipboard)

(put 'narrow-to-region 'disabled nil)

(setq scroll-step 0)
(setq scroll-conservatively 0)

(defun my/scroll-conservatively-five ()
(interactive)
(setq scroll-conservatively 5)
(message " scroll-conservatively 5"))

(defun my/scroll-conservatively-zero ()
(interactive)
(setq scroll-conservatively 0)
(message " scroll-conservatively 0"))

(defun my/scroll-conservatively-ten ()
(interactive)
(setq scroll-conservatively 10)
(message " scroll-conservatively 10"))

(setq-default display-line-numbers nil)
(setq visible-bell nil)
(setq calc-display-trail nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default fringe-indicator-alist (assq-delete-all 'truncation fringe-indicator-alist))
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(setq apropos-do-all t)
(setq debug-on-error nil)
(setq use-dialog-box nil)
(setq window-resize-pixelwise t)
(add-hook 'after-change-major-mode-hook 'line-numbers)
(setq fill-column 60)

(defun my/ranger ()
  (interactive)
  (my/copy-dir)
  (start-process-shell-command "my/show-ranger" nil "~/scripts/emacs_scripts/show-ranger"))

(defun my/terminal ()
  (interactive)
  (my/copy-dir)
  (start-process-shell-command "my/show-ranger" nil "~/scripts/emacs_scripts/show-term"))
