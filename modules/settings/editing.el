(defun my/erase-kill-ring ()
(interactive)
(setq kill-ring nil))

(defun my/insert-space ()
  (interactive)
  (insert " "))

(defun my/capitalize ()
  (interactive)
  (fix-word-capitalize)
  (insert " "))


(defun indent-buffer ()
  (interactive)
  (save-excursion
    (let ((inhibit-message t))
      (evil-indent
       (point-min)
       (point-max))
      (xah-clean-empty-lines))))

(defun copy-whole-buffer ()
  "Copy entire buffer to clipboard"
  (interactive)
  (clipboard-kill-ring-save
   (point-min)
   (point-max)))

(defun copy-to-chrome ()
  "Paste buffer on Chrome"
  (interactive)
  (copy-whole-buffer)
  (let ((inhibit-message t))
    (shell-command "~/scripts/i3_scripts/paste_to_chrome.sh")))

(defun copy-to-messenger ()
  (interactive)
  (copy-whole-buffer)
  (let ((inhibit-message t))
    (shell-command "~/scripts/i3_scripts/paste_to_im.sh")))

(defun my/unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn
		 (barf-if-buffer-read-only)
		 (list t)))
  (let ((fill-column (point-max)))
    (fill-paragraph nil region)))

(defun my/super-unfill-buffer ()
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (my/unfill-paragraph t)))

(defun my/super-fill-buffer ()
  (interactive)
  (fill-region
   (point-min)
   (point-max)))

(defun my/truncate-off ()
(interactive)
(setq truncate-lines nil))

(defun my/truncate-on ()
(interactive)
(setq truncate-lines t))



(defun my/company-show-options ()
  (interactive)
  (counsel-M-x "^my/company-idle-"))

(defun my/company-show-options ()
  (interactive)
  (counsel-M-x "^my/company-idle-"))

(defun my/company-show-delay ()
  (interactive)
  (describe-variable 'company-idle-delay))

(defun my/company-show-prefix-length ()
  (interactive)
  (describe-variable 'company-minimum-prefix-length))

(defun my/company-idle-zero-prefix-one ()
  (interactive)
  (setq-local company-idle-delay 0.0)
  (setq-local company-minimum-prefix-length 1)
  (message "idle delay: 0, minimun prefix length: 1"))

(defun my/company-idle-zero-prefix-one-quiet ()
  (interactive)
  (setq-local company-idle-delay 0.0)
  (setq-local company-minimum-prefix-length 1))

(defun my/company-idle-zero-prefix-two ()
  (interactive)
  (setq-local company-idle-delay 0.0)
  (setq-local company-minimum-prefix-length 2)
  (message "idle delay: 0, minimun prefix length: 2"))

(defun my/company-idle-zero-prefix-two-quiet ()
  (interactive)
  (setq-local company-idle-delay 0.0)
  (setq-local company-minimum-prefix-length 2))

(defun my/company-idle-one-prefix-one ()
  (interactive)
  (setq-local company-idle-delay 0.1)
  (setq-local company-minimum-prefix-length 1)
  (message "idle delay: 0.1, minimun prefix length: 1"))

(defun my/company-idle-one-prefix-one-quiet ()
  (interactive)
  (setq-local company-idle-delay 0.1)
  (setq-local company-minimum-prefix-length 1))

(defun my/company-idle-one-prefix-two ()
  (interactive)
  (setq-local company-idle-delay 0.1)
  (setq-local company-minimum-prefix-length 2)
  (message "idle delay: 0.1, minimun prefix length: 2"))

(defun my/company-idle-one-prefix-two-quiet ()
  (interactive)
  (setq-local company-idle-delay 0.1)
  (setq-local company-minimum-prefix-length 2))

(defun my/company-idle-two-prefix-one ()
  (interactive)
  (setq-local company-idle-delay 0.2)
  (setq-local company-minimum-prefix-length 1)
  (message "idle delay: 0.2, minimun prefix length: 1"))

(defun my/company-idle-two-prefix-two ()
  (interactive)
  (setq-local company-idle-delay 0.2)
  (setq-local company-minimum-prefix-length 2)
  (message "idle delay: 0.2, minimun prefix length: 2"))

(defun my/company-idle-two-prefix-two-quiet ()
  (interactive)
  (setq-local company-idle-delay 0.2)
  (setq-local company-minimum-prefix-length 2))

(defun my/company-idle-three-prefix-one ()
  (interactive)
  (setq-local company-idle-delay 0.3)
  (setq-local company-minimum-prefix-length 1)
  (message "idle delay: 0.3, minimun prefix length: 1"))

(defun my/company-idle-three-prefix-two ()
  (interactive)
  (setq-local company-idle-delay 0.3)
  (setq-local company-minimum-prefix-length 2)
  (message "idle delay: 0.3, minimun prefix length: 2"))

(defun my/company-idle-four-prefix-two ()
  (interactive)
  (setq-local company-idle-delay 0.4)
  (setq-local company-minimum-prefix-length 2)
  (message "idle delay: 0.4, minimun prefix length: 2"))

(defun my/company-idle-four-prefix-two-silent ()
  (interactive)
  (setq-local company-idle-delay 0.4)
  (setq-local company-minimum-prefix-length 2))

(defun my/company-idle-five-prefix-two ()
  (interactive)
  (setq-local company-idle-delay 0.5)
  (setq-local company-minimum-prefix-length 2)
  (message "idle delay: 0.5, minimun prefix length: 2"))

(defun my/company-idle-five-prefix-two-silent ()
  (interactive)
  (setq-local company-idle-delay 0.5)
  (setq-local company-minimum-prefix-length 2))


(defun my/company-complete ()
  (interactive)
  (company-complete)
  (insert " "))

(defun my/company-complete-paren ()
  (interactive)
  (company-select-next)
  (company-complete)
  (insert "()")
  (backward-char))

(defun my/company-complete-first ()
  (interactive)
  (company-select-next)
  (company-complete))

(defun my/company-complete-first-add-space ()
  (interactive)
  (company-select-next)
  (company-complete)
  (insert " "))

(defun my/company-complete-first-comint ()
  (interactive)
  (company-select-next)
  (company-complete)
  (comint-send-input))

(defun my/company-complete-comint ()
  (interactive)
  (company-complete)
  (comint-send-input))


(defun my/company-yasnippet ()
  (interactive)
  (company-abort)
  (yas-expand))

(defun my/evil-substitute ()
  (interactive)
(evil-ex "%s/"))

(defun del-dup-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))

(defun del-dup-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))

(defun sel-to-end ()
(interactive)
(evil-visual-char)
(evil-last-non-blank))

(defun my/bash-shebang ()
  (interactive)
  (beginning-of-buffer)
  (insert "#!/usr/bin/env bash\n\n\n")
  (sh-mode)
  (sh-set-shell "bash")
  (previous-line)
  (delete-blank-lines)
  (forward-to-indentation))

(defun my/python-shebang ()
  (interactive)
  (beginning-of-buffer)
  (insert "#!/usr/bin/env python3\n\n\n")
  (previous-line)
  (delete-blank-lines)
  (forward-to-indentation))

(defun whack-whitespace (arg)
  "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word."
  (interactive "P")
  (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
    (re-search-forward regexp nil t)
    (replace-match "" nil nil)))

(defun endless/simple-get-word ()
  (car-safe (save-excursion (ispell-get-word nil))))

(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global.
If there's nothing wrong with the word at point, keep
looking for a typo until the beginning of buffer. You can
skip typos you don't want to fix with `SPC', and you can
abort completely with `C-g'."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (endless/simple-get-word))
		 ;; Word was corrected or used quit.
		 (if (ispell-word nil 'quiet)
		     nil ; End the loop.
		   ;; Also end if we reach `bob'.
		   (not (bobp)))
	       ;; If there's no word at point, keep looking
	       ;; until `bob'.
	       (not (bobp)))
	(backward-word)
	(backward-char))
      (setq aft (endless/simple-get-word)))
    (if (and aft bef (not (equal aft bef)))
	(let ((aft (downcase aft))
	      (bef (downcase bef)))
	  (define-abbrev
	    (if p local-abbrev-table global-abbrev-table)
	    bef aft)
	  (message "\"%s\" now expands to \"%s\" %sally"
		   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun brasileiro ()
(interactive)
(ispell-change-dictionary "brasileiro")
(flyspell-buffer)
(message " português"))

(defun american ()
(interactive)
(ispell-change-dictionary "american")
(flyspell-buffer)
(message " american"))

;; https://stackoverflow.com/a/30697761/9509067
(defun sort-lines-by-length (reverse beg end)
  "Sort lines by length."
  (interactive "P\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))))))
