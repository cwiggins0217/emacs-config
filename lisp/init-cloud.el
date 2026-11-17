;;; init-cloud.el --- Cloud and infrastructure file support -*- lexical-binding: t; -*-
;; file modes only for now; cluster actions remain kubectl commands.
(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package raku-mode
  :ensure t
  :mode ("\\.p6\\|.raku\\'" . raku-mode))

(use-package ansible
  :ensure t
  :defer t)

(use-package terraform-mode
  :ensure t
  :mode ("\\.tf\\'" . terraform-mode)
  :config
  (setq terraform-indent-level 2))

(use-package dockerfile-mode
  :ensure t
  :mode (("\\(?:Dockerfile\\|Containerfile\\)\\(?:\\..*\\)?\\'" . dockerfile-mode)))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode))

;; prefer built-in sh-mode for shell scripts, and conf-mode for service files
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.timer\\'"   . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.socket\\'"  . conf-unix-mode))

(provide 'init-cloud)
