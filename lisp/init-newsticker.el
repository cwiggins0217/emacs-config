;;; init-newsticker.el -- Newsticker RSS Feeds -*- lexical-binding: t -*- 
(use-package newsticker
  :defer t
  :bind ("C-c n" . newsticker-show-news)
  :custom
  (newsticker-retrieval-interval 3600))

(setq newsticker-url-list '(
                            ("Feeds"
                             ("Blogs"
                            ("Luke Smith" "https://lukesmith.xyz/rss.xml")
                            ("Lindy Press News" "https://lindypress.net/rss.xml")
                            ("Ian LeCorbeau" "https://ianlecorbeau.github.io/feed.xml")
                            ("Death Metal Underground" "https://deathmetal.org/feed"))
                             ("Tech"
                            ("Arch Linux News" "https://archlinux.org/feeds/news/")
                            ("Planet Arch" "https://archlinux.org/feeds/planet/")
                            ("Gentoo News" "https://gentoo.org/feeds/news.xml"))
                             ("Videos"
                              ("Luke Smith" "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFH61tmytImy1mTYvhA")))))

(defun wigmacs/close-newsticker()
  "Kill all tree-view related buffers"
  (kill-buffer "*Newsticker List*")
  (kill-buffer "*Newsticker Item*")
  (kill-buffer "*Newsticker Tree*"))

(advice-add 'newsticker-treeview-quit :after 'wigmacs/close-newsticker)

(provide 'newsticker-config)
;;; init-newsticker.el ends here
