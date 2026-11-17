;;; init-development.el --- Language tooling -*- lexical-binding: t; -*-
;; phase 4: local development only. Remote editing remains lightweight
(require 'subr-x)
(require 'project)

;; basic defaults. org mode unaffected.
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'electric-pair-local-mode)

;; perl : cperl-mode over perl-mode
(add-to-list 'auto-mode-alist '("\\.\\(?:pl\\|pm\\|t\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))

;; tree-sitter support optional: ask before installing grammars.
;; use M-x treesit-auto-install-all to manage grammars explicitly
(use-package treesit-auto
  :ensure t
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode 1))

;; perl LSP is opt-in: M-x eglot in a cperl-mode buffer after
;; installing Perl::LanguageServer (eglot has built-in server recipe).
;; modern LSP without additional depency. only start for local files,
;; only when ls is on exec-path.
(defun my/dev-local-buffer-p ()
  "return non-nil when the current buffer is not remote."
  (not (file-remote-p default-directory)))

(defun my/dev-maybe-eglot ()
  "Start with eglot in supported local buffers with available servers."
  (when (and (my/dev-local-buffer-p)
             (cond
              ((derived-mode-p 'go-mode 'go-ts-mode)
               (executable-find "gopls"))
               ((derived-mode-p 'python-mode 'python-ts-mode)
                (or (executable-find "basedpyright-langserver")
                    (executable-find "pylsp")))
               ((derived-mode-p 'sh-mode 'bash-ts-mode)
                (executable-find "bash-language-server"))
               ((derived-mode-p 'yaml-mode 'yaml-ts-mode)
                (executable-find "yaml-language-server"))
               ((derived-mode-p 'terraform-mode)
                (executable-find "terraform-ls"))))
    (eglot-ensure)))

(use-package eglot
  :ensure nil
  :commands (eglot eglot-esure eglot-rename eglot-code-actions)
  :hook ((go-mode go-ts-mode python-mode python-ts-mode
                  sh-mode bash-ts-mode yaml-mode yaml-ts-mode
                  terraform-mode) . my/dev-maybe-eglot)
  :config
  ;; prefer basedpyright when avialable, fallback to pylsp.
  (add-to-list 'eglot-server-programs
               (cons '(python-mode python-ts-mode)
                     #'my/dev-python-server)))

(defun my/dev-python-server (&rest _)
  "choose available python language server"
  (cond ((executable-find "basedpyright-langserver")
                          '("basedpyright-langserver" "--stdio"))
         ((executable-find "pylsp") '("pylsp"))
         (t (user-error "Install basedpyright or pylsp"))))

(use-package flymake
  :ensure nil
  :bind (("C-c ! l" . flymake-show-buffer-diagnostics)
         ("C-c ! n" . flymake-goto-next-error)
         ("C-c ! p" . flymake-goto-prev-error)))

;; save-time formatting is off by default.
;; format manually with M-x apheleia-format-buffer.
;; no formatters run on remote buffers.
(use-package apheleia
  :ensure (:host github :repo "radian-software/apheleia")
  :commands (apheleia-format-buffer)
  :custom (apheleia-remote-algorithm 'cancel)
  :config
  (setf (alist-get 'python-mode apheleia-mode-alist) 'ruff
        (alist-get 'python-ts-mode apheleia-mode-alist) 'ruff
        (alist-get 'go-mode apheleia-mode-alist) 'gofmt
        (alist-get 'go-ts-mode apheleia-mode-alist) 'gofmt
        (alist-get 'sh-mode apheleia-mode-alist) 'shfmt
        (alist-get 'bash-ts-mode apheleia-mode-alist) 'shfmt
        (alist-get 'cperl-mode apheleia-mode-alist) 'perltidy))
                   
(defun my/dev-compile ()
  "Prompt for a project-aware compile command."
  (interactive)
  (when (file-remote-p default-directory)
    (user-error "refusing to compile on a tramp buffer; use tmux/ssh explicitly"))
  (call-interactively #'compile))

(global-set-key (kbd "C-c m c") #'my/dev-compile)
(global-set-key (kbd "C-c m r") #'recompile)
(global-set-key (kbd "C-c m f") #'apheleia-format-buffer)

;; eat terminal
(use-package eat
  :ensure t)

(provide 'init-development)
;;; init-development.el ends here
