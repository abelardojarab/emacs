;;;; GO TO ;;;;
(defun my/ranger-go (path)
  (interactive
   (list
    (read-char-choice
     "

a : math
d : dotfiles
e : emacs.d
h : home
m : modules
o : org
s : scripts
t : studying
> "
     '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j ?l ?m ?n ?o ?p ?q ?r ?s ?t ?z))))
  (message nil)
  (let* ((c (char-to-string path))
         (new-path
          (cl-case (intern c)
            ('a "~/Math")
            ('d "~/dotfiles")
            ('e "~/.emacs.d")
            ('h "~")
            ('m "~/.emacs.d/modules")
            ('o "~/org")
            ('s "~/scripts")
            ('t "~/Studying")
            ('q nil)))
         (alt-option
          (cl-case (intern c)
            ;; Subdir Handlng
            ('j 'ranger-next-subdir)
            ('k 'ranger-prev-subdir)
            ;; Tab Handling
            ('n 'ranger-new-tab)
            ('T 'ranger-prev-tab)
            ('t 'ranger-next-tab)
            ('c 'ranger-close-tab))))
    (when (string-equal c "q")
      (keyboard-quit))
    (when (and new-path (file-directory-p new-path))
      (ranger-find-file new-path))
    (when (eq system-type 'windows-nt)
      (when (string-equal c "D")
        (ranger-show-drives)))
    (when alt-option
      (call-interactively alt-option))))
(advice-add 'ranger-go :override #'my/ranger-go)

;;;; OPTIONS ;;;
(defun my/ranger-options
    () (interactive)
    (let ((inhibit-message t))
      (setq truncate-lines t))
    (line-numbers)
    (olivetti-mode 1))

(defun my/ranger-options-parent () (interactive)
       (let ((inhibit-message t))
         (setq truncate-lines t)
         (line-no-numbers)
         (dired-hide-details-mode)))

;;;; COMMANDS ;;;;
(defun my/ranger-toggle-mark ()
  (interactive)
  (ranger-toggle-mark)
  (ranger-next-file 1))

(defun my/ranger-toggle-mark ()
  (interactive)
  (ranger-toggle-mark)
  (ranger-next-file 1))

(defun my/dired-do-find-marked-files ()
  (interactive)
  (dired-do-find-marked-files)
  (delete-other-windows))

;;;; FIND ;;;;
(defun ranger-find-bashdot ()
  (interactive)
  (let ((inhibit-message t))
    (ranger-find-file "/home/dotfiles/bash/")))

(defun ranger-find-nvim-dir ()
  (interactive)
  (let ((inhibit-message t))
    (ranger-find-file "~/.config/nvim")))

(defun ranger-find-scripts-dir ()
  (interactive)
  (let ((inhibit-message t))
    (ranger-find-file "~/scripts")))

(defun ranger-find-emacs-dir ()
  (interactive)
  (let ((inhibit-message t))
    (ranger-find-file "~/.emacs.d")))

(defun ranger-find-file-in-workspace ()
  (interactive)
  (ranger-find-file)
  (duplicate-workspace-buffer))

(defun my/ranger ()
  (interactive)
  (my/copy-dir)
  (start-process-shell-command "my/show-ranger" nil "~/scripts/emacs_scripts/show-ranger"))
