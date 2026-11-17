;;; init-completion.el --- Completion setup -*- lexical-binding: t; -*-
(use-package vertico
  :ensure t
  :init (vertico-mode 1))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :ensure t
  :init (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
         ("M-s l" . consult-line)
         ("M-s r" . consult-ripgrep)
         ("M-y" . consult-yank-pop)))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)))

(use-package corfu
  :ensure t
  :custom (corfu-auto t) (corfu-cycle t)
  :init (global-corfu-mode 1))
;; don't use <enter> to select completion
(with-eval-after-load 'corfu
  (keymap-unset corfu-map "RET"))

(use-package cape
  :ensure t
  :bind ("C-c p p" . completion-at-point))

(provide 'init-completion)
