;;; init-knowledge.el --- Org publishing helpers -*- lexical-binding: t; -*-
;; use build-in org exporters; avoid external processes on startup
(with-eval-after-load 'org
  (require 'ox)
  (require 'ox-md)
  (require 'ox-latex)
  (setq org-export-with-toc t
        org-export-with-section-numbers nil
        org-latex-compiler "xelatex"
        org-latex-pdf-process
        '("latexmk -xelatex -interaction=nonstopmode -f -output-directory=%o %f")))
(provide 'init-knowledge)
