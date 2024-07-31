(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e" "4990532659bb6a285fee01ede3dfa1b1bdf302c5c3c8de9fad9b6bc63a9252f7" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "dd4582661a1c6b865a33b89312c97a13a3885dc95992e2e5fc57456b4c545176" default))
 '(default-input-method "TeX")
 '(lsp-inlay-hint-enable t)
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-agenda-files
   '("~/org/roam/20240418120926-analina.org" "/home/new/org/roam/20240109113803-server_side_technologies.org" "/home/new/org/roam/20240206081810-cache.org" "/home/new/org/todo.org" "/home/new/org/roam/20231130143243-trie_baum.org" "/home/new/org/roam/20231114081552-digital_entwurf.org" "/home/new/org/tu/RO/VL4.org" "/home/new/org/tu/EI/Tut4.org" "/home/new/org/tu/RO/Tut3.org" "/home/new/org/tu/mfmt.org"))
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
     ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-latex-packages-alist '(("inkscapelatex=false" "svg" nil nil)))
 '(org-latex-pdf-process
   '("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f -shell-escape"))
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(warning-suppress-types '((ox-latex) (initialization) (defvaralias))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ts-fold-replacement-face ((t (:foreground unspecified :box nil :inherit font-lock-comment-face :weight light)))))
(put 'narrow-to-region 'disabled nil)
(put 'customize-option 'disabled nil)
