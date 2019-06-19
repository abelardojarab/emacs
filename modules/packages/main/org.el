(use-package org
  :ensure t
  :init
  ;; (add-hook 'before-save-hook 'org-align-all-tags)
  ;; (add-hook 'org-archive-hook 'org-hide-other)

  (add-hook 'org-mode-hook 'my/org-mode-hooks)

  (defun my/org-mode-hooks ()
    (interactive)
    (evil-org-mode +1)
    (org-bullets-mode +1))

  (remove-hook 'org-cycle-hook #'org-optimize-window-after-visibility-change)
  ;; (remove-hook 'calendar-mode-hook (lambda ()
  ;;                                    (evil-window-move-very-bottom)))
  (add-hook 'org-agenda-mode-hook
	      (lambda ()
		(setq display-line-numbers nil)
		(setq truncate-lines t)))

  (add-hook 'org-capture-mode-hook (lambda ()
				       (evil-insert-state)
				       (evil-window-move-very-bottom)))
  (add-hook 'org-cycle-hook #'org-cycle-hide-drawers)

  :config
  (load-file "~/.emacs.d/modules/packages/main/org/org_keys.el")
  (load-file "~/.emacs.d/modules/packages/main/org/org_functions.el")

  ;;; http://bit.ly/2KJHooJ
  (setq org-agenda-files (apply 'append
				  (mapcar
				   (lambda (directory)
				     (directory-files-recursively
				      directory org-agenda-file-regexp))
				   '("~/org/Agenda"))))

  (setq org-deadline-warning-days 7)
  (setq org-enforce-todo-checkbox-dependencies nil)
  (setq org-link-file-path-type 'relative)
  (setq org-export-with-toc nil)
  (setq calendar-date-style 'european)

  ;; (setq org-clock-persist nil)
  ;; (org-clock-persistence-insinuate)
  (setq org-clock-in-resume t)
  (setq org-pretty-entities t)
  (setq org-clock-into-drawer t)
  (setq org-clock-out-when-done t)
  (setq org-clock-history-length 10)
  (setq org-clock-mode-line-total 'auto)
  (setq org-clock-clocked-in-display t)
  (setq org-clock-persist-query-resume t)
  (setq org-clock-out-remove-zero-time-clocks nil)
  (setq org-clock-report-include-clocking-task t)
  (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
  (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))  ;; Separate drawers for clocking and logs
  (setq org-log-into-drawer t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)))

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

  (add-hook 'org-src-mode-hook 'olivetti-mode)

  (setq org-time-stamp-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %H:%M %a>"))
  (setq org-time-stamp-custom-formats '("<%d/%m/%Y %a>" . "<%d/%m/%Y %H:%M %a>"))

  (setq org-display-custom-times t)
  (setq-default org-display-custom-times t)
  (setq org-pretty-entities-include-sub-superscripts nil)
  (setq org-format-latex-options
	  (plist-put org-format-latex-options :scale 1.3))
  (setq org-archive-location "~/org/Info/Config/archive.org::* From %s")
  (setq org-export-html-postamble nil)
  (setq org-indent-mode t)
  (setq org-link-frame-setup ( quote ((file . find-file))))
  (setq org-allow-promoting-top-level-subtree nil)
  (setq org-image-actual-width nil)
  (setq org-use-speed-commands t)
  (setq org-cycle-level-faces t)
  (setq org-return-follows-link t)
  (setq org-fontify-whole-heading-line t)
  (setq org-hide-emphasis-markers t)
  (setq org-startup-indented t)
  (setq org-replace-disputed-keys t)
  (setq org-ellipsis ".")
  (setq org-babel-temporary-directory "~/.emacs.d/babel-temp")
  (setq org-fontify-done-headline t)

  (setq org-todo-keywords
	  '((sequence "TODO(t!)" "STARTED(s!)" "|"  "DONE(d!)")))

  (setq org-tags-column -79)
  (setq org-agenda-tags-column -80)

  (setq org-refile-targets '((nil :maxlevel . 9)
			       (org-agenda-files :maxlevel . 9)))

  ;; (setq org-refile-targets '((nil :maxlevel . 9)))

  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  ;; (setq org-refile-use-outline-path file)                  ; Show full paths for refiling
  (setq org-refile-use-outline-path 'file)
  (setq org-refile-allow-creating-parent-nodes (quote confirm))

  (setq org-file-apps (quote ((auto-mode . emacs)
				("\\.mm\\'" . default)
				("\\.x?html?\\'" . default)
				("\\.jpg\\'" . "~/scripts/cline_scripts/my_feh %s")
				("\\.mp4\\'" . "vlc %s")
				("\\.pdf\\'" . default))))

  (add-to-list 'org-structure-template-alist '("ll" "\\begin{equation*}\n\\begin{split}\n?\n\\end{split}\n\\end{equation*}"))
  (add-to-list 'org-structure-template-alist '("cc" "#+BEGIN_SRC C\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("s" "#+BEGIN_SRC shell \n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("use" nil))
  (add-to-list 'org-structure-template-alist '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("lisp" "#+BEGIN_SRC lisp\n\n?\n\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("p" "#+BEGIN_SRC python\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("u" "#+begin_quote\n?\n#+end_quote"))
;;;; See:
;;;;; https://orgmode.org/manual/Template-expansion.html#Template-expansion
  (setq org-capture-templates
	  '(("a" "Agenda" entry  (file+headline "~/org/Agenda/agenda.org" "Tasks") "* TODO %i%^{1|Title}\nDEADLINE: %^t\n%?")
	    ("p" "Planning" entry  (file+headline "~/org/Agenda/planning.org" "Tasks") "* TODO %i%^{1|Title}\nDEADLINE: %^t\n%?")))

  )

(use-package org-bullets
:ensure t)
;; :init
;; (setq org-bullets-bullet-list (quote ("◐" "◑" "◒" "◓" "☉" "◎" "◉")))

(use-package org-noter
  :defer t
  :ensure t
  :config
  (add-hook 'org-noter-insert-heading-hook 'evil-insert-state)

  ;; (defun my/org-noter-insert-note ()
  ;;   (interactive)
  ;;   (switch-to-buffer-other-window "Notes")
  ;;   (org-noter-insert-precise-note))

  (defun my/org-noter-insert-note ()
    (interactive)
    (switch-to-buffer-other-window "Notes")
    (org-noter-insert-note))

  (general-nvmap
    :keymaps 'org-noter-notes-mode-map
    "C-z" 'my/org-noter-insert-note))

(use-package ox-asciidoc
  :after org
  :ensure t)

(use-package org-web-tools
  :after org
  :ensure t)

(use-package ox-epub
  :after org
  :ensure t)

(use-package toc-org
  :defer t
  :ensure t)

(use-package org2blog
  :init
  (setq org2blog/wp-blog-alist
	'(("daviramos-en"
	   :url "http://daviramos.com/en/xmlrpc.php"
	   :username "daviramos"
	   :default-title "Hello World"
	   :default-categories ("sci-fi")
	   :tags-as-categories nil)
	  ("daviramos-br"
	   :url "http://daviramos.com/br/xmlrpc.php"
	   :username "daviramos"
	   :default-title "Hello World"
	   :default-categories ("sci-fi")
	   :tags-as-categories nil)))
  :ensure t)

(use-package org-pdfview
  :defer t
  :ensure t)
