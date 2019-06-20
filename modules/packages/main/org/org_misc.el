(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(add-to-list 'org-structure-template-alist '("use" nil))
(add-to-list 'org-structure-template-alist '("cc" "#+BEGIN_SRC C\n?\n#+END_SRC"))
(add-to-list 'org-structure-template-alist '("u" "#+begin_quote\n?\n#+end_quote"))
(add-to-list 'org-structure-template-alist '("s" "#+BEGIN_SRC shell \n?\n#+END_SRC"))
(add-to-list 'org-structure-template-alist '("p" "#+BEGIN_SRC python\n?\n#+END_SRC"))
(add-to-list 'org-structure-template-alist '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
(add-to-list 'org-structure-template-alist '("lisp" "#+BEGIN_SRC lisp\n\n?\n\n#+END_SRC"))
(add-to-list 'org-structure-template-alist '("ll" "\\begin{equation*}\n\\begin{split}\n?\n\\end{split}\n\\end{equation*}"))
