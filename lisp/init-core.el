;;; init-core.el --- Safe defaults -*- lexical-binding: t; -*-
(setq inhibit-startup-message t
      ring-bell-function #'ignore
      use-short-answers t
      confirm-kill-processes t
      read-process-output-max (* 1024 1024))
(setq-default indent-tabs-mode nil)
(global-auto-revert-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(column-number-mode 1)
;; recoverable edits, keep autosaves out of project trees
(let ((dir (expand-file-name "var/auto-save/" user-emacs-directory)))
  (make-directory dir t)
  (setq auto-save-file-name-transforms `((".*" ,dir t))))
(let ((dir (expand-file-name "var/backups/" user-emacs-directory)))
  (make-directory dir t)
  (setq backup-directory-alist `(("." . ,dir))
	backup-by-copying t
	version-control t
	kept-new-versions 10
	kept-old-versions 3
	delete-old-versions t))
;; do not place unconditional daemon in charge of all shell processes
(provide 'init-core)
