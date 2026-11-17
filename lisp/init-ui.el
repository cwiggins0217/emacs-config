;;; init-ui.el --- graphical UI -*- lexical-binding: t; -*-
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1 )
(setq visible-bell nil
      scroll-conservatively 101)
(global-hl-line-mode 1)
(global-display-line-numbers-mode -1)
(show-paren-mode 1)
;;(load-theme 'modus-vivendi t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'wintermute t) 

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(setq-default indent-tabs-mode nil)

;; font
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 160
                    :weight 'regular)
(setq-default line-spacing 0.12)
;; don't go crazy with bold weight
(set-face-attribute 'bold nil :weight 'semibold)

;; padding
(add-to-list 'default-frame-alist '(internal-border-width . 18))
(set-frame-parameter nil 'internal-border-width 18)

(use-package colorful-mode
  :ensure t
  :hook (prog-mode text-mode))

(provide 'init-ui)
;;; init-ui.el ends here
