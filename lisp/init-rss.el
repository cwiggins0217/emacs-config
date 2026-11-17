;;; init-rss.el --- Newsticker Rss and news reader -*- lexical-binding: t; -*-

(setq newsticker-url-list '(
			    ("Luke Smith" "https://lukesmith.xyz/rss.xml")
			    ("Death Metal Underground" "https://deathmetal.org/feed")
			    ("Void Linux News" "https://voidlinux.org/atom.xml")
			    ("Lunduke Journal" "https://api.substack.com/feed/podcast/462466.rss")
			    ("Gentoo News" "https://gentoo.org/feeds/news.xml")))

(defun wigmacs/close-newsticker ()
  "Kill all tree-view related buffers."
  (kill-buffer "*Newsticker List*")
  (kill-buffer "*Newsticker Item*")
  (kill-buffer "*Newsticker Tree*"))

(advice-add 'newsticker-treeview-quit :after 'wigmacs/close-newsticker)

(provide 'newsticker-config)
;;; newsticker-config.el ends here
