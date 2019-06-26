(use-package org
  :ensure t
  :init
  (load-file "~/.emacs.d/modules/packages/main/org/org_hooks.el")
  :config
  (load-file "~/.emacs/modules/packages/main/org/org_keys.el")
  (load-file "~/.emacs.d/modules/packages/main/org/org_setqs.el")
  (load-file "~/.emacs.d/modules/packages/main/org/org_functions.el")
  (load-file "~/.emacs.d/modules/packages/main/org/org_misc.el"))


(use-package org-bullets
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
