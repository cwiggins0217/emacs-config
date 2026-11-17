(use-package erc
  :ensure nil
  :config
  (setq erc-nick "TGG")
  (setq erc-user-full-name "TheGreatGazoob")

  (setq erc-autojoin-channels-alist
	'(("Libera.Chat"
	   "#emacs"
	   "#linux")))

  (setq erc-log-channels-directory "~/.emacs.d/erc-logs/")
  (setq erc-save-buffer-on-part t)
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-track-mode 1)

  (setq erc-rename-buffers t)

  (add-hook 'erc-mode-hook #'erc-fill-mode)

  (setq erc-track-shorten-start 8))

(setq erc-prompt-for-nickserv-password nil)

(require 'erc-services)

(setq auth-sources '("~/.authinfo.gpg"))

(use-package erc-hl-nicks
  :after erc
  :config
  (add-to-list 'erc-modules 'hl-nicks))

(provide 'erc-config)
;;; erc-config.el ends here
