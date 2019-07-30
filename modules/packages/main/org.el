(use-package org
  :ensure nil
  :defer t
  :init
  (add-hook 'org-mode-hook 'my/org-mode-hooks)

  (add-hook 'org-agenda-mode-hook
            (lambda ()
              (hl-line-mode)
              (setq display-line-numbers nil)
              (setq truncate-lines t)
              (olivetti-mode +1)))

  (add-hook 'org-capture-mode-hook (lambda ()
                                     (evil-insert-state)
                                     (evil-window-move-very-bottom)
                                     (electric-operator-mode t)))

  (remove-hook 'org-cycle-hook #'org-optimize-window-after-visibility-change)

  (add-hook 'org-src-mode-hook 'my/org-src-hooks)

  ;; (add-hook 'org-cycle-hook #'org-cycle-hide-drawers)

  :config

  (load-file "~/.emacs.d/modules/packages/main/org_extras.el")

;;;; KEYBINDINGS ;;;;

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
   ;; "C-c n" 'my/org-open-next-link
   ;; "C-c p" 'my/org-open-prev-link
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

  (general-unbind 'org-agenda-mode-map
    :with 'my/agenda-return
    [remap evil-ret])

  (general-unbind 'org-agenda-mode-map
    :with 'org-agenda-previous-item
    [remap org-agenda-previous-line])

  (general-unbind 'org-agenda-mode-map
    :with 'org-agenda-next-item
    [remap org-agenda-next-line])

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

  (general-imap
    :keymaps 'org-capture-mode-map
    "C-k")

  (general-nvmap
    :keymaps 'org-mode-map
    :prefix "SPC"
    "i" 'hydra-org-text-commands/body)

  (general-unbind 'org-capture-mode-map
    :with nil
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

  (general-unbind 'org-agenda-mode-map
    :with 'org-agenda-quit
    [remap evil-repeat-find-char]
    [remap evil-ex-search-forward]
    [remap org-agenda-goto-today])

;;;; SETTINGS ;;;;
  (require 'org-tempo)
  (add-to-list 'org-src-lang-modes '("i3" . i3wm-config))
  (setq org-lowest-priority 73)
  (setq org-default-priority 65)
  (setq org-agenda-show-all-dates nil)
  (setq org-agenda-show-outline-path nil)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-timestamp-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-timestamp-if-deadline-is-shown t)
  (setq org-agenda-skip-unavailable-files 't)
  (setq org-agenda-skip-additional-timestamps-same-entry 't)
  (setq org-agenda-skip-archived-trees 't)

  ;; (setq org-footnote-section "Notas")
  (setq org-footnote-auto-adjust 't)

  (setq org-global-properties
        '(("Effort_ALL" .
           "00:05 00:10 00:15 00:25 00:30 00:45 01:00 01:30 02:00 02:30 03:00 03:40 04:00")))
  (setq org-modules '(org-w3m org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-eww org-habit))

;;; http://bit.ly/2KJHooJ
  (setq org-agenda-files (apply 'append
                                (mapcar
                                 (lambda (directory)
                                   (directory-files-recursively
                                    directory org-agenda-file-regexp))
                                 '("~/org/Agenda"))))

  ;; Refile to agenda
  (setq org-refile-targets '((nil :maxlevel . 3)
                             (org-agenda-files :maxlevel . 3)))

  (setq org-deadline-warning-days 7)
  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-link-file-path-type 'relative)
  (setq org-export-with-toc nil)
  (setq calendar-date-style 'european)

  ;;;; ORG CLOCK ;;;;

  (org-clock-persistence-insinuate)
  (setq org-clock-sound "~/george/Music/S/Sounds/cuckoo.au")
  (setq org-clock-persist t)
  (setq org-clock-in-resume t)
  (setq org-clock-persist-query-resume t)
  (setq org-pretty-entities t)
  (setq org-clock-into-drawer t)
  (setq org-clock-out-when-done t)
  (setq org-clock-history-length 10)
  (setq org-clock-update-period 60)
  (setq org-clock-mode-line-total 'auto)
  (setq org-clock-clocked-in-display 'frame-title)
  (setq org-clock-out-remove-zero-time-clocks t)
  (setq org-clock-report-include-clocking-task t)
  (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))

  (setq org-drawers (quote ("PROPERTIES" "LOGBOOK"))) ;; Separate drawers for clocking and logs
  (setq org-log-into-drawer t)

  (setq org-edit-src-content-indentation 1)
  (setq org-src-preserve-indentation t)
  (setq org-edit-src-persistent-message nil)
  (setq org-edit-src-auto-save-idle-delay 1)

  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-babel-no-eval-on-ctrl-c-ctrl-c t)
  (setq org-src-ask-before-returning-to-edit-buffer nil)
  (setq org-src-window-setup 'current-window)

  ;; (setq org-time-stamp-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %H:%M %a>"))
  ;; (setq org-time-stamp-custom-formats '("<%d/%m/%Y %a>" . "<%d/%m/%Y %H:%M %a>"))
  ;; (setq org-display-custom-times t)
  ;; (setq-default org-display-custom-times t)

  (setq org-pretty-entities-include-sub-superscripts nil)
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.3))
  ;; Archive on other location
  (setq org-archive-location "~/org/Data/archive.org::datetree/* From %s")

  ;; Archive on the same file
  ;; (setq org-archive-location "::* Archived %s")

  (setq org-export-with-archived-trees nil)
  (setq org-export-html-postamble nil)
  (setq org-indent-mode t)
  (setq org-link-frame-setup ( quote ((file . find-file))))
  (setq org-allow-promoting-top-level-subtree nil)
  (setq org-image-actual-width nil)
  (setq org-use-speed-commands t)
  (setq org-cycle-level-faces t)
  (setq org-return-follows-link t)
  (setq org-hide-emphasis-markers t)
  (setq org-startup-indented t)
  (setq org-replace-disputed-keys t)
  (setq org-ellipsis ".")
  (setq org-babel-temporary-directory "~/.emacs.d/babel-temp")

  (setq org-fontify-done-headline t)
  (setq org-fontify-whole-heading-line nil)

  (setq org-todo-keywords
        '((sequence "TODO(t!)" "MAYBE(m!)" "STRT(s!)" "|"  "DONE(d!)")))

  (setq org-tags-column -79)
  (setq org-agenda-tags-column -80)

  ;; Refile to same file
  ;; (setq org-refile-targets '((nil :maxlevel . 1)))

  ;; (setq org-refile-targets '((nil :maxlevel . 2)
  ;;                            (my/org-refile-targets :maxlevel . 2)))

  ;; Refile in a single go
  (setq org-outline-path-complete-in-steps nil)

  ;; No path on refilling
  ;; (setq org-refile-use-outline-path nil)

  ;; Show full paths for refiling
  (setq org-refile-use-outline-path 'file)

  ;; (setq org-refile-allow-creating-parent-nodes (quote confirm))
  (setq org-refile-allow-creating-parent-nodes nil)

  (setq org-file-apps (quote ((auto-mode . emacs)
                              ("\\.mm\\'" . default)
                              ("\\.x?html?\\'" . default)
                              ;; ("\\.jpg\\'" . "~/scripts/cline_scripts/my_feh %s")
                              ("\\.jpg\\'" . "viewnior %s")
                              ("\\.mp4\\'" . "vlc %s")
                              ("\\.pdf\\'" . default))))

;;;; See:
;;;;; https://orgmode.org/manual/Template-expansion.html#Template-expansion

  (setq org-capture-templates
        '(
          ("a" "Agenda" entry
           (file+headline "~/org/Agenda/active/agenda.org" "Tasks") "* TODO %i%^{1|Title}\nDEADLINE: %^t%?")

          ("f" "Fixed" entry
           (file+headline "~/org/Agenda/active/fixed.org" "Fixed") "* TODO %i%^{1|Title}\nDEADLINE: \%^t\n:from:\n%f\n:end:%?")

          ("m" "Math" entry
           (file+headline "~/org/Agenda/active/math.org" "Math") "* TODO %i%^{1|Title}\n\%u\n:from:\n%f\n:end:%?")

          ("p" "Posts" entry
           (file+headline "~/org/Agenda/active/posts.org" "Posts") "* TODO %i%^{1|Title}\n\%u\n:from:\n%f\n:end:%?")

          ("r" "Repeated" entry
           (file+headline "~/org/Agenda/active/repeated.org" "Repeated Tasks") "* TODO %i%^{1|Title}\nDEADLINE: \%^t\n:from:\n%f\n:end:%?")

          ("w" "WebDev Tasks" entry
           (file+headline "~/org/Agenda/active/webdev.org" "Tasks") "* TODO %i%^{1|Title}\nDEADLINE: \%^t\n:from:\n%f\n:end:%?")

          ("e" "WebDev Notes" entry
           (file+headline "~/org/Agenda/active/webdev.org" "Notes") "* %i%^{1|Title}\n\%u\n:from:\n%f\n:end:%?")

          ("i" "Inactive" entry
           (file+headline "~/org/Agenda/inactive.org" "Inactive") "* TODO %i%^{1|Title}\n\%u\n:from:\n%f\n:end:%?")

          ("t" "Tech" entry
           (file+headline "~/org/Data/tech.org" "Tech Notes") "* TODO %i%^{1|Title}\n\%u\n:from:\n%f\n:end:%?")))

  (org-babel-do-load-languages
   : t

   'org-babel-load-languages
   '((python . t)))

;;;; FUNCTIONS ;;;;

  (defun my/find-agenda-file ()
    (interactive)
    (find-file "/home/george/org/Agenda/active/agenda.org"))

  (defun my/agenda-files ()
    (interactive)
    (ranger-find-file "/home/Documents/Org/Agenda"))

  (defun my/org-agenda-agenda-file ()
    (interactive)
    (find-file "~/org/Agenda/active/agenda.org"))

  (defun my/org-agenda-webdev-file ()
    (interactive)
    (find-file "~/org/Agenda/active/webdev.org"))

  (defun my/org-agenda-repeated-file ()
    (interactive)
    (find-file "~/org/Agenda/active/repeated.org"))

  (defun my/org-agenda-posts-file ()
    (interactive)
    (find-file "~/org/Agenda/active/posts.org"))

  (defun my/org-agenda-math-file ()
    (interactive)
    (find-file "~/org/Agenda/active/math.org"))

  (defun my/org-agenda-fixed-file ()
    (interactive)
    (find-file "~/org/Agenda/active/fixed.org"))

  (defun my/org-agenda-fixed-file ()
    (interactive)
    (find-file "~/org/Agenda/active/fixed.org"))

  (defun my/org-agenda-tech-file ()
    (interactive)
    (find-file "~/org/Data/tech.org"))

  (defun my/org-agenda-links-file ()
    (interactive)
    (find-file "~/org/Data/links.org"))

  (defun my/org-goto-archive ()
    (interactive)
    (find-file "~/org/Data/archive.org"))

  (defun my/org-agenda-contacts-file ()
    (interactive)
    (find-file "~/org/Data/contacts.org"))

  (defun my/org-agenda-active-file ()
    (interactive)
    (find-file "~/org/Agenda/active.org"))

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
    (org-todo "STRT")
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
  ;; (setq org-bookmark-names-plist nil)

  (defun my/update-agenda-files ()
    (interactive)
    (setq org-agenda-files (apply 'append
                                  (mapcar
                                   (lambda (directory)
                                     (directory-files-recursively
                                      directory org-agenda-file-regexp))
                                   '("~/org/Agenda"))))
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
    (olivetti-mode +1)
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
    (find-file "~/org/Agenda/active/agenda.org"))

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
    (progn
      (org-edit-src-exit)
      (my/quiet-save-buffer)))

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

  (defun org-today-agenda ()
    (interactive)
    (let ((current-prefix-arg 1)
          (org-deadline-warning-days 0))
      (org-agenda t "a")))

  (defun org-1-day-agenda ()
    (interactive)
    (let ((current-prefix-arg 1)
          (org-deadline-warning-days -1))
      (org-agenda t "a")))

  (defun org-2-days-agenda ()
    (interactive)
    (let ((current-prefix-arg 2)
          (org-deadline-warning-days 0))
      (org-agenda t "a")))

  (defun org-3-days-agenda ()
    (interactive)
    (let ((current-prefix-arg 3)
          (org-deadline-warning-days 0))
      (org-agenda t "a")))

  (defun org-4-days-agenda ()
    (interactive)
    (let ((current-prefix-arg 4)
          (org-deadline-warning-days 0))
      (org-agenda t "a")))

  (defun org-5-days-agenda ()
    (interactive)
    (let ((current-prefix-arg 5)
          (org-deadline-warning-days 0))
      (org-agenda t "a")))

  (defun org-6-days-agenda ()
    (interactive)
    (let ((current-prefix-arg 6)
          (org-deadline-warning-days 0))
      (org-agenda t "a")))

  (defun org-7-days-agenda ()
    (interactive)
    (let ((current-prefix-arg 7)
          (org-deadline-warning-days 0))
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

  (defun my/org-capture-agenda ()
    (interactive)
    (org-capture t "a"))

  (defun my/org-capture-fixed ()
    (interactive)
    (org-capture t "f"))

  (defun my/org-capture-math ()
    (interactive)
    (org-capture t "m"))

  (defun my/org-capture-posts ()
    (interactive)
    (org-capture t "p"))

  (defun my/org-capture-repeated ()
    (interactive)
    (org-capture t "r"))

  (defun my/org-capture-webdev-tasks ()
    (interactive)
    (org-capture t "w"))

  (defun my/org-capture-webdev-notes ()
    (interactive)
    (org-capture t "e"))

  (defun my/org-capture-active ()
    (interactive)
    (org-capture t "i"))

  (defun my/org-capture-tech ()
    (interactive)
    (org-capture t "t"))

  (defun my/org-capture-links ()
    (interactive)
    (org-capture t "l"))

  (defun my/org-capture-contacts ()
    (interactive)
    (org-capture t "c"))

  (defun my/org-src-hooks ()
    (interactive)
    (indent-buffer)
    (olivetti-mode +1))

;;;; END OF ORG-MODE USE-PACKACE DECLARATION ;;;;
  (defun org-src--construct-edit-buffer-name (org-buffer-name lang)
    (concat "[S] " org-buffer-name "")))
