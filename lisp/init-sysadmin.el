;;; init-sysadmin.el --- Reliable Unix administration -*- lexical-binding: t; -*-
;; keep long-running shells/SSH/kubectl processes in tmux, not emacs
(require 'project)
(require 'tramp)

(use-package project
  :ensure nil
  :bind (("C-c p f" . project-find-file)
         ("C-c p b" . project-switch-to-buffer)
         ("C-c p p" . project-switch-project)
         ("C-c p s" . project-shell)
         ("C-c p g" . project-find-regexp)))

(use-package tramp
  :ensure nil
  :custom
  (tramp-default-method "ssh")
  (tramp-verbose 1)
  :config
  ;; never disable remote safety checks globally for speed
  (setq remote-file-name-inhibit-cache nil))

(use-package dired
  :ensure nil
  :bind (("C-c d" . dired-jump))
  :custom
  (dired-listing-switches "-alh --group-directories-first")
  (dired-dwim-target t)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'top)
  (dired-hide-details-hide-symlink-targets nil))

(use-package wdired
  :ensure nil
  :custom (wdired-allow-to-change-permissions nil))

(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :config
  ;; prevent slow tramp status operations
  (setq magit-tramp-pipe-stty-settings 'pty))

(use-package diff-hl
  :ensure t
  :hook ((prog-mode . diff-hl-mode)
         (conf-mode . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode))
  :config
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(use-package which-key
  :ensure nil
  :init (which-key-mode 1))

;; read-only viewing, safe for large files
(defun my/view-log (file)
  "Visit file in view-mode, disabling undo for this buffer."
  (interactive "fLog file: ")
  (find-file-read-only file)
  (view-mode 1))
(global-set-key (kbd "C-c o l") #'my/view-log)

(provide 'init-sysadmin)
