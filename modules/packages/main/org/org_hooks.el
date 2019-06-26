(add-hook 'org-mode-hook 'my/org-mode-hooks)

(add-hook 'org-agenda-mode-hook
	  (lambda ()
	    (setq display-line-numbers nil)
	    (setq truncate-lines t)))

(add-hook 'org-capture-mode-hook (lambda ()
				   (evil-insert-state)
				   (evil-window-move-very-bottom)))

;; (add-hook 'org-cycle-hook #'org-cycle-hide-drawers)

(add-hook 'org-src-mode-hook 'olivetti-mode)

(remove-hook 'org-cycle-hook #'org-optimize-window-after-visibility-change)
