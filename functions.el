(defun my/settings-leituras.org ()
  (interactive)
  (progn
  (company-mode)
  (my/company-idle-one-prefix-one-quiet)
  (evil-close-folds)
  (save-place-local-mode -1)
  (org-next-visible-heading 2)))
