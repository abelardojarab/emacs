(defun xah-clean-whitespace ()
  "Delete trailing whitespace, and replace repeated blank lines to just 1.
Only space and tab is considered whitespace here.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2017-09-22"
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "[ \t]+\n" nil "move")
            (replace-match "\n")))
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))
        (progn
          (goto-char (point-max))
          (while (equal (char-before) 32) ; char 32 is space
            (delete-char -1))))
      (message "white space cleaned"))))

;; (add-hook 'before-save-hook 'xah-clean-whitespace)

(defun xah-clean-empty-lines ()
  "Replace repeated blank lines to just 1.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2017-09-22"
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))))))

(define-generic-mode 'xmodmap-mode
  '(?!)
  '("add" "clear" "keycode" "keysym" "pointer" "remove")
  nil
  '("[xX]modmap.*\\(rc\\)?\\'")
  nil
  "Simple mode for xmodmap files.")

;; (setq display-time-default-load-average nil)
;; (setq display-time-format "%H:%M")

;; (require 'time)

;; (defvar title-time-mode t
;;   "This is set to t iff we are displaying the current time in the title bar.")

;; (defun title-time-set ()
;;   "Set `frame-title-format' to the local system name followed by date,
;; time, and load information (as per `display-time-string-forms') and perhaps
;; followed by an appointment notification."
;;   (setq frame-title-format '(" " display-time-string)))

;; (defun title-time-update ()
;;   "Update the time display in the title-bar.
;; Skips inferior frames, that is, those without a minibuffer (eg. speedbar). "
;;   (interactive)
;;   ;; remove time display from the mode line
;;   (delq 'display-time-string global-mode-string)
;;   (delq 'appt-mode-string global-mode-string)
;;   (let ((start-frame (selected-frame)))
;;     (save-excursion
;;       (save-window-excursion
;;         (let ((my/frame-list (frame-list))
;;               (my/frame nil))
;;           (while (setq my/frame (car my/frame-list))
;;             (when (frame-parameter my/frame 'minibuffer)
;;               '(select-frame my/frame)
;;               (title-time-set))
;;             (setq my/frame-list (cdr my/frame-list))))))
;;     (select-frame start-frame)))

;; (add-hook 'display-time-hook #'title-time-update)

;; (display-time-mode 1)

;; (provide 'title-time)
;; (require 'title-time)

;;; title-time.el ends here
