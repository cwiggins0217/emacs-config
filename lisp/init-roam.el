;;; init-roam.el --- Org-roam knowledge graph -*- lexical-binding: t; -*-
(defvar my/roam-directory (expand-file-name "roam/" my/org-directory))
(dolist (dir '("" "concepts" "runbooks" "projects" "daily"))
  (make-directory (expand-file-name dir my/roam-directory) t))

(use-package org-roam
  :ensure t
  :after org
  :init
  (setq org-roam-directory (file-truename my/roam-directory)
	org-roam-db-location
	(expand-file-name "var/org-roam.db" user-emacs-directory))
  :bind (("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n c" . org-roam-capture)
	 ("C-c n j" . org-roam-dailies-capture-today)
         ("C-c n d" . org-roam-dailies-goto-today)
         ("C-c n y" . org-roam-dailies-goto-yesterday)
         ("C-c n g" . org-roam-graph))
  :config
  (make-directory (file-name-directory org-roam-db-location) t)
  (setq org-roam-capture-templates
        '(("c" "Concept" plain
           "* Summary\n%?\n\n* Details \n\n* Related\n"
           :target (file+head "concepts/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :concept:\n\n")
           :unnarrowed t)
	  ("r" "Runbook" plain
             "* Purpose\n%?\n\n* Prerequisites\n\n* Procedure\n\n* Verification\n\n* Rollback\n"
	   :target (file+head "runbooks/%<%Y%m%d%H%M%Sj>-${slug}.org"
			     "#+title: ${title}\n#+filetags:  :runbook:\n\n")
	   :unnarrowed t)
          ("p" "Project note" plain
           "* Objetive\n%?\n\n* Context\n\n* Decisions\n\n* References\n"
           :target (file+head "projects/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :project:\n\n")
           :unnarrowed t)))
  (setq org-roam-dailies-capture-templates
        '(("j" "Journal" entry "* %<%H:%M> Journal\n%?\n"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n#+filetage: :daily:\n\n"))
          ("l" "Lab log" entry
           "* %<%H:%M> Lab: %^{System or project}\n** Goal\n%?\n** Commands / observations\n\n** Result\n"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n#+filetags: :daily:\n\n"))))
  (org-roam-db-autosync-mode 1))
(provide 'init-roam)
