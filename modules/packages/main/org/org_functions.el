(defun my/agenda-files ()
  (interactive)
  (ranger-find-file "/home/Documents/Org/Agenda"))

(defun org-hide-drawers-enable ()
  (interactive)
  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers))

(defun org-hide-drawers-disable ()
  (interactive)
  (remove-hook 'org-cycle-hook 'org-cycle-hide-drawers))

(defun my/indent-src-block-function ()
  (interactive)
  (org-edit-special)
  (indent-buffer)
  (my/quiet-save-buffer)
  (org-edit-src-exit))

(defun my/org-started ()
  (interactive)
  (org-todo "STARTED")
  (org-clock-in))

(defun my/org-done ()
  (interactive)
  (org-todo "DONE"))

(defun my/org-done-go-below ()
  (interactive)
  (org-todo "DONE")
  (org-next-visible-heading 1))

(defun my/org-todo ()
  (interactive)
  (org-todo "TODO"))

(defun my/make-return-python ()
  (interactive)
  (general-nvmap
    :keymaps 'org-mode-map
    "RET" 'hydra-python-mode/body))

(defun my/make-return-spell ()
  (interactive)
  (general-nvmap
    :keymaps 'org-mode-map
    "RET" 'hydra-spell/body))

(defun my/org-align-tags ()
  (interactive)
  (org-align-tags))

(defun my/org-property-commands ()
  (interactive)
  (counsel-M-x "^org property "))
(plist-put org-format-latex-options :scale 2.0)
(setq org-bookmark-names-plist nil)

(defun my/update-agenda-files ()
  (interactive)
  (setq org-agenda-files (apply 'append
                                (mapcar
                                 (lambda (directory)
                                   (directory-files-recursively
                                    directory org-agenda-file-regexp))
                                 '("~/org/Agenda"
                                   "~/Studying/Unifacs/Segundo_Semestre/Matérias"))))
  (my/org-agenda))

(defun my/org-archive ()
  (interactive)
  (save-excursion
    (org-archive-subtree-default)))

(defun my/save-archive ()
  (interactive)
  (save-buffer "~/org/Config/.archive.org::* From %s"))

(defun my/custom-time-formats-on ()
  (interactive)
  (setq org-display-custom-times t))

(defun my/custom-time-formats-off ()
  (interactive)
  (setq org-display-custom-times nil))

(defun my/org-mode-hooks ()
  (interactive)
  (evil-org-mode +1)
  (visual-line-mode +1)
  (hl-line-mode +1)
  (org-bullets-mode +1))

(defun my/org-insert-file-link ()
  (interactive)
  (org-insert-link
   `(4)))

;; (defun my/()
;;   (interactive)

;;   )

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

(defun my/org-open-src-block ()
  (interactive)
  (org-babel-next-src-block)
  (org-edit-special))

;; Source:
;; https://stackoverflow.com/a/8933423

(defun zin/org-open-other-frame ()
  "Jump to bookmark in another frame. See `bookmark-jump' for more."
  (interactive)
  (let ((org-link-frame-setup
         (acons 'file 'find-file-other-frame org-link-frame-setup)))
    (org-open-at-point)))

(defun my/find-org-agenda-file ()
  (interactive)
  (find-file "~/org/Agenda/agenda.org"))

(defun my/org-open-next-link()
  (interactive)
  (save-excursion
    (org-next-link)
    (org-open-at-point-global)
    (sit-for 1)
    (focus-chrome)))

(defun my/org-open-link()
  (interactive)
  (save-excursion
    (org-open-at-point-global)
    (sit-for 1)
    (focus-chrome)))

(defun my/org-open-prev-link()
  (interactive)
  (org-previous-link)
  (org-open-at-point-global)
  (sit-for 1)
  (focus-chrome))

(defun my/org-src-exit ()
  (interactive)
  (org-edit-src-exit)
  (my/quiet-save-buffer))

(defun org-hide-other ()
  (interactive)
  (point-to-register 'z)
  (org-shifttab)
  (jump-to-register 'z)
  (org-cycle)
  (outline-show-subtree)
  (message ""))

(defun my/org-agenda ()
  (interactive)
  (org-agenda t "a"))

(defun my/org-agenda-single-window ()
  (interactive)
  (org-agenda t "a")
  (delete-other-windows))

(defun my/org-projectile-agenda ()
  (interactive)
  (counsel-projectile-org-agenda t "a"))

(defun org-1-day-agenda ()
  (interactive)
  (let ((current-prefix-arg 1)
        (org-deadline-warning-days -1))
    (org-agenda t "a")))

(defun org-2-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 2)
        (org-deadline-warning-days -2))
    (org-agenda t "a")))

(defun org-3-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 3)
        (org-deadline-warning-days -3))
    (org-agenda t "a")))

(defun org-4-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 4)
        (org-deadline-warning-days -4))
    (org-agenda t "a")))

(defun org-5-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 5)
        (org-deadline-warning-days -5))
    (org-agenda t "a")))

(defun org-6-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 6)
        (org-deadline-warning-days -6))
    (org-agenda t "a")))

(defun org-7-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 7)
        (org-deadline-warning-days -7))
    (org-agenda t "a")))

(defun my/agenda-enter ()
  (interactive)
  (let ((current-prefix-arg 4))
    (org-agenda-switch-to)))

(defun org-hide-emphasis ()
  (interactive)
  (save-excursion
    (setq org-hide-emphasis-markers t)
    (let ((inhibit-message t))
      (org-mode-restart)
      (org-cycle))))

(defun org-show-emphasis ()
  (interactive)
  (save-excursion
    (setq org-hide-emphasis-markers nil)
    (let ((inhibit-message t))
      (org-mode-restart)
      (org-cycle))))

(defun afs/org-remove-link ()
  "Replace an org link by its description or if empty its address"
  (interactive)
  (if (org-in-regexp org-bracket-link-regexp 1)
      (save-excursion
        (let ((remove (list (match-beginning 0) (match-end 0)))
              (description (if (match-end 3)
                               (org-match-string-no-properties 3)
                             (org-match-string-no-properties 1))))
          (apply 'delete-region remove)
          (insert description)))))

(defun org-clock-history ()
  "Show Clock History"
  (interactive)
  (let ((current-prefix-arg '(4))) (call-interactively 'org-clock-in)))

(defun eval-src-block ()
  (interactive)
  (org-edit-special nil)
  (eval-buffer)
  (org-edit-src-exit))

(defun my/org-capture-math-notes ()
  (interactive)
  (org-capture t "m"))

(defun org-src--construct-edit-buffer-name (org-buffer-name lang)
  (concat "[s] " org-buffer-name ""))
