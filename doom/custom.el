(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1" default))
 '(lsp-clangd-download-url
   "https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip")
 '(lsp-clangd-version "19.1.2")
 '(org-agenda-files
   '("~/org/roam/20250424095209-datenbank.org"
     "/home/new/org/roam/20250415124329-stochastik.org"
     "/home/new/org/journal.org" "/home/new/org/notes.org"
     "/home/new/org/projects.org" "/home/new/org/todo.org"))
 '(org-latex-default-packages-alist
   '(("" "unicode-math" nil nil) ("" "amsmath" t ("lualatex" "xetex"))
     ("" "fontspec" t ("lualatex" "xetex")) ("AUTO" "inputenc" t ("pdflatex"))
     ("T1" "fontenc" t ("pdflatex")) ("" "graphicx" t nil)
     ("" "longtable" nil nil) ("" "wrapfig" nil nil) ("" "rotating" nil nil)
     ("normalem" "ulem" t nil) ("" "amsmath" t ("pdflatex"))
     ("" "amssymb" t ("pdflatex")) ("" "capt-of" nil nil)
     ("" "hyperref" nil nil)))
 '(org-latex-packages-alist '(("" "minted" nil nil) ("" "tikz" nil nil)))
 '(org-latex-pdf-process
   '("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f -shell-escape"))
 '(org-latex-to-mathml-convert-command "latexmlmath %i --presentationmathml=%o")
 '(org-pretty-entities-include-sub-superscripts nil)
 '(org-preview-latex-default-process 'dvisvgm)
 '(org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'customize-option 'disabled nil)
