;; academic writing tool stuff
;; Set up org-mode export stuff
  ;; (add-to-list 'org-latex-classes
  ;;              '("apa6"
  ;;                "\\documentclass{apa6}"
  ;;                ("\\section{%s}" . "\\section*{%s}")
  ;;                ("\\subsection{%s}" . "\\subsection*{%s}")
  ;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
  ;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
  ;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; This is to use pdf-tools instead of doc-viewer
(use-package! pdf-tools
  :config
  (pdf-tools-install)
  ;; This means that pdfs are fitted to width by default when you open them
  (setq-default pdf-view-display-size 'fit-width)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

(use-package! org-ref)

(use-package! org-fragtog)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))
