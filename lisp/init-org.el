;;; init-org.el --- Org and capture baseline -*- lexical-binding: t; -*-
(defvar my/org-directory (expand-file-name "~/knowledge/"))
(defvar my/org-agenda-directory (expand-file-name "agenda/" my/org-directory))
(dolist (dir (list my/org-directory my/org-agenda-directory))
  (make-directory dir t))

;; keep independent agenda files, separate from roam's indexed notes.
(setq org-directory my/org-directory)
(setq org-agenda-files
      (mapcar (lambda (name) (expand-file-name name my/org-agenda-directory))
              '("inbox.org" "tasks.org" "projects.org")))
(dolist (f org-agenda-files)
  (unless (file-exists-p f)
    (with-temp-file f (insert "#+title: " (file-name-base f) "\n\n"))))

(use-package org
  :ensure nil
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c l" . org-store-link))
  :custom
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-return-follows-link t)
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  (org-use-speed-commands t)
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@)" "|" "DONE(d)" "CANCELLED(c@)")))
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-agenda-start-on-weekday 1)
  (org-agenda-span 7)
  (org-agenda-start-with-log-mode t)
  :config
  (setq org-capture-templates
   `(("t" "Task inbox" entry
      (file ,(expand-file-name "inbox.org" my/org-agenda-directory))
      "* TODO %?\n:PROPERTIES:\n:CREATED:  %U\n:END:" :empty-lines 1)
     ("n" "Next action" entry
      (file ,(expand-file-name "tasks.org" my/org-agenda-directory))
      "* NEXT %?\nSCHEDULED: %^t\n" :empty-lines 1)
     ("p" "Project action" entry
      (file ,(expand-file-name "projects.org" my/org-directory))
      "" :empty-lines 1))))

(use-package org-modern
  :ensure t
  :after org
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda))

(provide 'init-org)
