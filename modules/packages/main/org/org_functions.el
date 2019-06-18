;; (defun org-cycle-hide-drawers (state)
;;   "Re-hide all drawers after a visibility state change."
;;   (when (and (derived-mode-p 'org-mode)
;; 	       (not (memq state '(overview folded contents))))
;;     (save-excursion
;; 	(let* ((globalp (memq state '(contents all)))
;; 	       (beg (if globalp
;; 			(point-min)
;; 		      (point)))
;; 	       (end (if globalp
;; 			(point-max)
;; 		      (if (eq state 'children)
;; 			  (save-excursion
;; 			    (outline-next-heading)
;; 			    (point))
;; 			(org-end-of-subtree t)))))
;; 	  (goto-char beg)
;; 	  (while (re-search-forward org-drawer-regexp end t)
;; 	    (save-excursion
;; 	      (beginning-of-line 1)
;; 	      (when (looking-at org-drawer-regexp)
;; 		(let* ((start (1- (match-beginning 0)))
;; 		       (limit
;; 			(save-excursion
;; 			  (outline-next-heading)
;; 			  (point)))
;; 		       (msg (format
;; 			     (concat
;; 			      "org-cycle-hide-drawers:  "
;; 			      "`:END:`"
;; 			      " line missing at position %s")
;; 			     (1+ start))))
;; 		  (if (re-search-forward "^[ \t]*:END:" limit t)
;; 		      (outline-flag-region start (point-at-eol) t)
;; 		    (user-error msg))))))))))


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

(defun my/org-archive ()
  (interactive)
  (org-todo "DONE")
  (org-archive-subtree-default)
  (message " todo archived"))

(defun my/org-started ()
  (interactive)
  (org-todo "STARTED")
  (org-clock-in))

(defun my/org-done ()
  (interactive)
  (org-todo "DONE"))

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
  (org-align-all-tags))

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

(defun my/save-archive ()
  (interactive)
  (save-buffer "~/org/Config/.archive.org::* From %s"))

(defun my/custom-time-formats-on ()
  (interactive)
  (setq org-display-custom-times t))

(defun my/custom-time-formats-off ()
  (interactive)
  (setq org-display-custom-times nil))
