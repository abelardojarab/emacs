(add-hook 'org-mode-hook 'my/org-mode-hooks)

(add-hook 'org-agenda-mode-hook
	  (lambda ()
	    (setq display-line-numbers nil)
	    (setq truncate-lines t)))

(add-hook 'org-capture-mode-hook (lambda ()
				   (evil-insert-state)
				   (evil-window-move-very-bottom)))

(remove-hook 'org-cycle-hook #'org-optimize-window-after-visibility-change)

(add-hook 'org-src-mode-hook 'my/org-src-hooks)

(defun my/org-src-hooks ()
  (interactive)
  (indent-buffer)
  (olivetti-mode +1))

;; (add-hook 'org-cycle-hook #'org-cycle-hide-drawers)
