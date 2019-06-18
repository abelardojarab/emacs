(defun my/kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun focus-emacs ()
  (interactive)
  (let ((inhibit-message t))
    (shell-command "~/scripts/i3_scripts/focus_emacs.sh")))

(defun focus-chrome ()
  (interactive)
  (let ((inhibit-message t))
    (shell-command "~/scripts/i3_scripts/focus_chrome.sh")))

(defun my/focus-chrome-delayed ()
  (interactive)
  (let ((inhibit-message t))
    (progn
      (sit-for 2)
      (shell-command "~/scripts/i3_scripts/focus_chrome.sh"))))

(defun my/kill-buffer-and-workspace ()
  (interactive)
  (widen)
  (my/save-all)
  (my/kill-this-buffer)
  (eyebrowse-close-window-config))

(defun my/reload-keys ()
(interactive)
(load-file "~/.emacs.d/keys.el")
(message "keys reloaded"))

(defun my/blog-post ()
  (interactive)
  (my/quiet-save-buffer)
  (disable-theme 'noctilux)
  (org2blog/wp-post-buffer)
  (load-theme 'noctilux)
  (delete-other-windows)
  (start-process-shell-command "chrome-reload-focus" nil "~/scripts/i3_scripts/chrome_reload.sh"))

(defun my/blog-publish ()
  (interactive)
  (my/quiet-save-buffer)
  (disable-theme 'noctilux)
  (org2blog/wp-post-buffer-and-publish)
  (load-theme 'noctilux)
  (delete-other-windows)
  (start-process-shell-command "chrome-reload-focus" nil "~/scripts/i3_scripts/chrome_reload.sh"))

(defun my/search-pack ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/packs.org")
    (widen)
    (counsel-outline)))

(defun my/search-outline ()
  (interactive)
  (let ((inhibit-message t))
    (widen)
    (counsel-outline)))
(defun my/goto-ouline-and-narrow ()
(interactive)
(my/search-outline)
(org-narrow-to-subtree))

(defun my/search-pack ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/packs.org")
    (widen)
    (counsel-outline)))

(defun my/goto-i3-screen-configs ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.config/i3/config.org")
    (widen)
    (swiper "strachpads main")))

(defun my/pdf-view--rotate (&optional counterclockwise-p page-p)
  "Rotate PDF 90 degrees.  Requires pdftk to work.\n
Clockwise rotation is the default; set COUNTERCLOCKWISE-P to
non-nil for the other direction.  Rotate the whole document by
default; set PAGE-P to non-nil to rotate only the current page.
\nWARNING: overwrites the original file, so be careful!"
  ;; error out when pdftk is not installed
  (if (null (executable-find "pdftk"))
      (error "Rotation requires pdftk")
    ;; only rotate in pdf-view-mode
    (when (eq major-mode 'pdf-view-mode)
      (let* ((rotate (if counterclockwise-p "left" "right"))
	     (file   (format "\"%s\"" (pdf-view-buffer-file-name)))
	     (page   (pdf-view-current-page))
	     (pages  (cond ((not page-p)                        ; whole doc?
			    (format "1-end%s" rotate))
			   ((= page 1)                          ; first page?
			    (format "%d%s %d-end"
				    page rotate (1+ page)))
			   ((= page (pdf-info-number-of-pages)) ; last page?
			    (format "1-%d %d%s"
				    (1- page) page rotate))
			   (t                                   ; interior page?
			    (format "1-%d %d%s %d-end"
				    (1- page) page rotate (1+ page))))))
	;; empty string if it worked
	(if (string= "" (shell-command-to-string
			 (format (concat "pdftk %s cat %s "
					 "output %s.NEW "
					 "&& mv %s.NEW %s")
				 file pages file file file)))
	    (pdf-view-revert-buffer nil t)
	  (error "Rotation error!"))))))

(defun my/pdf-view-rotate-clockwise (&optional arg)
  "Rotate PDF page 90 degrees clockwise.  With prefix ARG, rotate
entire document."
  (interactive "P")
  (pdf-view--rotate nil (not arg)))

(defun my/pdf-view-rotate-counterclockwise (&optional arg)
  "Rotate PDF page 90 degrees counterclockwise.  With prefix ARG,
rotate entire document."
  (interactive "P")
  (pdf-view--rotate :counterclockwise (not arg)))


(defun find-bash-completion ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.bash_completion.sh")))

(defun find-agenda ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/org/Planning/agenda.org")))

(defun find-i3-keys ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/tmp/i3keys.org")))

(defun find-pcc-notes ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "/home/mrbig/PCC/pcc_notes/pcc_notes.org")))

(defun find-pt-spell ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.aspell.pt_BR.pws")))

(defun find-en-spell ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.aspell.en.pws")))

(defun my/find-java-scratch ()
 (interactive)
 (find-file "~/Studying/Unifacs/Segundo_Semestre/Matérias/POO/24/scratch.java"))

(defun my/find-godot-notes ()
 (interactive)
 (find-file "~/discg/notes/discg_notes.org"))

(defun my/find-scratch-buffer ()
  (interactive)
  (evil-save-state
    (switch-to-buffer "*scratch*")))

(defun find-i3-config ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.config/i3/config")))

(defun find-scratch-markdown ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/tmp/scratches/scratch.md")))

(defun find-scratch-elisp ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/tmp/scratches/scratch.el")))

(defun find-scratch-org ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/tmp/scratches/scratch.org")))

(defun find-bash-aliases ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.bash_aliases")))

(defun find-bashrc ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.bashrc")))

(defun find-profile ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.profile")))

(defun find-inputrc ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.inputrc")))

;; (defun find-bash-profile ()
;;   (interactive)
;;   (let ((inhibit-message t))
;;     (find-file "~/.bash_profile")))

(defun find-env_variables ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.env_variables.sh")))

(defun find-tmux-conf ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "/home/dotfiles/tmux/tmuxconf")))

(defun find-zathurarc ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "/home/dotfiles/zathura/zathurarc")))



(defun find-abbrevs ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/etc/abbrev_defs")))

(defun find-emacs-custom ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/etc/custom.el")))

(defun find-evil-keys ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/lisp/functions/evil_keys.el")))

(defun find-functions ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/functions.org")))

(defun find-functions.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/functions.el")))

(defun find-hydras ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/hydras.org")))

(defun find-hydras.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/hydras.el")))

(defun find-init ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/init.org")))

(defun find-init.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/init.el")))

(defun find-keys ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/keys.org")))

(defun find-keys.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/keys.el")))

(defun find-macros ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/macros.org")))

(defun find-macros.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/macros.el")))

(defun find-misc ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/misc.org")))

(defun find-misc.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/misc.el")))

(defun find-packs ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/packs.org")))

(defun find-packs.el ()
  (interactive)
  (let ((inhibit-message t))
    (find-file "~/.emacs.d/packs.el")))


(defun my/goto-scratch-buffer ()
(interactive)
(switch-to-buffer "*scratch*"))

(defun my/copy-dir ()
  "Put the current dir name on the clipboard"
  (interactive)
  (let ((filename default-directory))
    (setq kill-ring nil)
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun my/copy-filename-only ()
  (interactive)
  (let ((filename (buffer-name)))
    (setq kill-ring nil)
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

;;;; https://stackoverflow.com/questions/2416655/file-path-to-clipboard-in-emacs

(defun prelude-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename))
(message filename)))

(defun my/copy-python-path ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename))))




(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun my/goto-warnings-buffer ()
(interactive)
(switch-to-buffer "*Warning*"))

(defun my/goto-messages-buffer ()
(interactive)
(switch-to-buffer "*Messages*"))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
  (delete-other-windows)
  (message " other buffers killed"))

(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (progn
    (my/save-all)
    (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
    (my/kill-this-buffer)
    (delete-other-windows)
    (message " all buffers killed")))

(defun my/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(90 . 50) '(100 . 100)))))
