(defun text-scale-reset ()
  (interactive)
  (text-scale-adjust 0)
  (message ""))

(defun disable-modeline ()
  (interactive)
  (setq-local mode-line-format nil))


(defun my/split-below ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun my/split-right ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun my/split-vertically ()
  (interactive)
  (split-window-vertically)
  (other-window 1))

(defun my/evil-botright ()
  (interactive)
  (evil-window-new 1 "*scratch*")
  (evil-window-move-very-bottom))

(defalias 'my/evil-very-bottom 'my/evil-botright)

(defun my/evil-very-right ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (evil-window-move-far-right))

(defun my/evil-very-left ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (evil-window-move-far-left))

(defun my/evil-very-top ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (evil-window-move-very-top))


(defun my/evil-inc-width-small ()
  (interactive)
  (let ((current-prefix-arg 6))
    (call-interactively 'evil-window-increase-width)))

(defun my/evil-dec-width-small ()
  (interactive)
  (let ((current-prefix-arg 6))
    (call-interactively 'evil-window-decrease-width)))

(defun my/evil-inc-height-small ()
  (interactive)
  (let ((current-prefix-arg 6))
    (call-interactively 'evil-window-increase-height)))

(defun my/evil-dec-height-small ()
  (interactive)
  (let ((current-prefix-arg 6))
    (call-interactively 'evil-window-decrease-height)))

(defun my/evil-inc-witdh-large ()
  (interactive)
  (let ((current-prefix-arg 12))
    (call-interactively 'evil-window-increase-witdh-large)))

(defun my/evil-dec-witdh-large ()
  (interactive)
  (let ((current-prefix-arg 12))
    (call-interactively 'evil-window-decrease-witdh-large)))

(defun my/evil-inc-height-large ()
  (interactive)
  (let ((current-prefix-arg 12))
    (call-interactively 'evil-window-increase-height-large)))

(defun my/evil-dec-height-large ()
  (interactive)
  (let ((current-prefix-arg 12))
    (call-interactively 'evil-window-decrease-height-large)))

(defun my/evil-inc-width ()
  (interactive)
  (let ((current-prefix-arg 8))
    (call-interactively 'evil-window-increase-width)))

(defun my/evil-dec-width ()
  (interactive)
  (let ((current-prefix-arg 8))
    (call-interactively 'evil-window-decrease-width)))

(defun my/evil-inc-height ()
  (interactive)
  (let ((current-prefix-arg 8))
    (call-interactively 'evil-window-increase-height)))

(defun my/evil-dec-height ()
  (interactive)
  (let ((current-prefix-arg 8))
    (call-interactively 'evil-window-decrease-height)))


(defun my/enlarge-window ()
  (interactive)
  (let ((current-prefix-arg 10))
    (call-interactively 'enlarge-window)))

(defun my/enlarge-window-horizontally ()
  (interactive)
  (let ((current-prefix-arg 10))
    (call-interactively 'enlarge-window-horizontally)))

(defun my/shrink-window ()
  (interactive)
  (let ((current-prefix-arg 10))
    (call-interactively 'shrink-window)))

(defun my/shrink-window-horizontally ()
  (interactive)
  (let ((current-prefix-arg 10))))
