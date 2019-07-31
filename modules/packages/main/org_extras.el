
(use-package org-bullets
  :ensure t
  :config
  (setq org-bullets-bullet-list (quote ("◐" "◑" "◒" "◓" "☉" "◉"))))

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
  :after org
  :ensure t)

(use-package org-journal
  :ensure t
  :init
  (add-hook 'org-journal-mode-hook 'my/hl-only-sentences)
  :custom
  (org-journal-dir "~/org/Agenda/journal")
  (org-journal-date-format "%A, %B %m, %Y")
  (org-journal-file-format "%d-%m-%Y")
  :config

  (setq org-journal-find-file 'find-file)

  (general-nvmap
    :keymaps 'org-journal-mode-map

    "C-M-p" 'org-journal-open-previous-entry
    "C-M-n" 'org-journal-open-next-entry))

(use-package org-pomodoro
  :after org
  :ensure t
  :config
  (setq org-pomodoro-manual-break nil)
  ;; (setq org-pomodoro-length 40)            ;; 100%
  ;; (setq org-pomodoro-short-break-length 8) ;; 20%
  ;; (setq org-pomodoro-long-break-length 32) ;; 80%

  (setq org-pomodoro-length 25)            ;; 100%
  (setq org-pomodoro-short-break-length 5) ;; 20%
  (setq org-pomodoro-long-break-length 20) ;; 80%
  (setq org-pomodoro-format "P: %s")
  (setq org-pomodoro-short-break-format "S: %s")
  (setq org-pomodoro-long-break-format "L: %s")

  (defun org-pomodoro-update-mode-line ()
    "Set the modeline accordingly to the current state."
    (let ((s (cl-case org-pomodoro-state
               (:pomodoro
                (propertize org-pomodoro-format 'face 'org-pomodoro-mode-line))
               (:overtime
                (propertize org-pomodoro-overtime-format
                            'face 'org-pomodoro-mode-line-overtime))
               (:short-break
                (propertize org-pomodoro-short-break-format
                            'face 'org-pomodoro-mode-line-break))
               (:long-break
                (propertize org-pomodoro-long-break-format
                            'face 'org-pomodoro-mode-line-break)))))
      (setq org-pomodoro-mode-line
            (when (and (org-pomodoro-active-p) (> (length s) 0))
              (list " " (format s (org-pomodoro-format-seconds)) " |"))))
    (force-mode-line-update t)))
