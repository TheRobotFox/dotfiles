;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;
; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Tomke Pfoch"
      user-mail-address "pfoch.tomke@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 22 )
     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 23))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'whiteboard)
(setq mouse-wheel-progressive-speed nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; (setq doom-font (font-spec :family "Parchment MF" :size 22 )
;;      doom-variable-pitch-font (font-spec :family "Parchment MF" :size 23))
;; set font size
(set-face-attribute 'default nil :height 150)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



;; (use-package evil-collection
;;   :after evil
;;   :custom (evil-collection-want-find-usages-bindings t)
;;   :init (evil-collection-init))

;; (use-package evil-org
;;   :ensure t
;;   :after org
;;   :hook (org-mode . (lambda () evil-org-mode))
;;   :config
;;   (require 'evil-org-agenda)

  (evil-define-key 'normal evil-org-mode-map
                  (kbd "<up>") 'org-previous-visible-heading
                  (kbd "<down>") 'org-next-visible-heading
                  (kbd "<S-up>") 'org-previous-item
                  (kbd "<S-down>") 'org-next-item
                  (kbd "<C-M-down>") 'org-table-move-cell-down
                  (kbd "<C-M-up>") 'org-table-move-cell-up
                  (kbd "<C-M-left>") 'org-table-move-cell-left
                  (kbd "<C-M-right>") 'org-table-move-cell-right
                  (kbd "M-p") 'evil-prev-flyspell-error
                  (kbd "M-n") 'evil-next-flyspell-error)

  ;; ;; Babel
  (defun org-babel-edit-prep:C (babel-info)
  (setq-local buffer-file-name (->> babel-info caddr (alist-get :tangle)))
  (lsp))
  (defun org-babel-edit-prep:Rust (babel-info)
  (setq-local buffer-file-name (->> babel-info caddr (alist-get :tangle)))
  (lsp))
  (defun org-babel-edit-prep:java (babel-info)
  (setq-local buffer-file-name (->> babel-info caddr (alist-get :tangle)))
  (lsp))

  (setq org-plantuml-exec-mode 'plantuml)
  (setq org-plantuml-executable-path (expand-file-name "/usr/bin/plantuml"))
  ;; (setq plantuml-jar-args '("-charset" "UTF-8" "-tsvg" "-theme" "crt-amber"))
  (setq org-plantuml-args '("-charset" "UTF-8" "-tsvg")) ;;-theme" "crt-amber"))

 (org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)))



  (setq org-babel-C-compiler "gcc -std=c2x -lm -I .")
  (setq org-babel-C++-compiler "g++ -std=c++23 -I .")

  (evil-org-agenda-set-keys))
(use-package multiple-cursors
  :defer
  :init
  (add-hook 'multiple-cursors-mode-hook
            (defun my/work-around-multiple-cursors-issue ()
              (load "multiple-cursors-core.el")
              (remove-hook 'multiple-cursors-mode-hook #'my/work-around-multiple-cursors-issue))))


;; Buffer movement
(map! "<C-left>" #'next-buffer)
(map! "<C-right>" #'previous-buffer)

;; Make
(map! :leader "cm" #'evil-make)

;; DIRED

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

;; Zen mode
(defun zen-mode-bodge ()
  (let ((ov (make-overlay 1 1 nil t t)))
    (overlay-put ov 'priority 9999999)
    (overlay-put ov 'before-string (propertize "   1 " 'face 'line-number))
    (overlay-put ov 'zen--remove-from-buffer-tag t))
  (let ((ov (make-overlay 1 2)))
    (overlay-put ov 'display-line-numbers-disable t)
    (overlay-put ov 'zen--remove-from-buffer-tag t))
  )


(defun zen-mode-clear ()
  (remove-overlays 1 2 'zen--remove-from-buffer-tag t))

(setq pixel-scroll-precision-large-scroll-height 40.0)

(advice-remove #'evil-scroll-up #'zen-mode-evil-scroll-up)
(advice-remove #'evil-scroll-down #'zen-mode-evil-scroll-down)

(add-hook 'writeroom-mode-enable-hook (lambda () (topspace-mode 1)))
(add-hook 'writeroom-mode-disable-hook (lambda () (topspace-mode -1)))

;; Error list
(defun switch-flycheck-list-errors ()
(interactive)
(flycheck-list-errors)
(pop-to-buffer "*Flycheck errors*"))

(map! "M-p" #'flycheck-previous-error)
(map! "M-n" #'flycheck-next-error)
(map! :leader "cx" #'switch-flycheck-list-errors)

; Ispell
;; (with-eval-after-load "ispell"
;;  (setenv "LANG" "en_US.UTF-8")
;;  (setq ispell-program-name "hunspell")
 ;; (setq ispell-dictionary "de_DE en_US")
;;  (ispell-set-spellchecker-params)
;;  (ispell-hunspell-add-multi-dic "de_DE,en_US,en_GB"))

;; (map! :leader "pl" 'ispell-hunspell-add-multi-dic)

;; Git
(map! :leader "gm" 'smerge-keep-current)

  ;; :config
  (define-key evil-normal-state-map "gb" 'evil-switch-to-windows-last-buffer)
  (define-key evil-normal-state-map (kbd "C-q") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-s") 'evil-numbers/dec-at-pt)
  (define-key evil-insert-state-map (kbd "M-a") 'avy-goto-char-2)



  ;; (define-key evil-insert-state-map (kbd "M-TAB") 'yas-next-field)
  ;; (define-key evil-insert-state-map (kbd "S-TAB") 'yas-prev-field)
;; (defun my/org-tab-conditional ()
;;   (interactive)
;;   (if (yas-active-snippets)
;;       (yas-next-field-or-maybe-expand)
;;     (org-cycle)))

;; (map! :after evil-org
;;       :map evil-org-mode-map
;;       :i "<tab>" #'my/org-tab-conditional)

(evil-define-command evil-repeat-all ()
  :repeat abort
  :keep-visual t
  (interactive) (evil-ex-execute "'<,'>norm."))
  (define-key evil-visual-state-map (kbd ".") 'evil-repeat-all)
;; edit-indirect
(map! "C-c '" 'edit-indirect-region)
;; (skewer-setup)
;; (add-hook 'css-mode-hook 'skewer-reload-stylesheets-start-editing)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))



;; latex

  ;; Latex TOC pagebreak
(setq org-latex-toc-command "\\tableofcontents \\clearpage")
;; (setq latex-run-command "lualatex")
;; (setq pdf-latex-command "lualatex")
(setq latex-run-command "pdflatex")
(setq pdf-latex-command "pdflatex")
(setq TeX-command-extra-options "--shell-escape")
(setq shell-escape-mode "--shell-escape")
(setq org-latex-src-block-backend 'minted)
(setq org-reveal-hlevel 2)

(evil-define-key 'normal gdb-edit-locals-map-1 (kbd "c") 'gdb-edit-value)
(evil-define-key 'normal gdb-edit-locals-map-1 (kbd "RET") 'gdb-edit-value)
(evil-define-key 'normal gdb-breakpoints-mode-map (kbd "d") 'gdb-delete-breakpoint)
(evil-define-key 'normal gdb-breakpoints-mode-map (kbd "RET") 'gdb-goto-breakpoint)
(with-eval-after-load 'gud
        (define-key gud-mode-map (kbd "C-b") 'gud-break)
        (define-key gud-mode-map (kbd "C-n") 'gud-next)
        (define-key gud-mode-map (kbd "C-s") 'gud-step)
        (define-key gud-mode-map (kbd "C-u") 'gud-down)
        (define-key gud-mode-map (kbd "C-d") 'gud-up)
        (define-key gud-mode-map (kbd "C-x") 'gud-remove)
        (define-key gud-mode-map (kbd "M-j") 'gud-cont)
        (define-key gud-mode-map (kbd "C-r") 'gud-run)
        ;; (define-key gud-mode-map (kbd "C-u") 'gud-until)
        )

(map! :leader "pw" 'org-agenda-file-to-front)
(map! :leader "pW" 'org-remove-file)

;; TODO Open Project.org in buffer

(load-library "ox-gfm-autoloads")
(eval-after-load "org"
'(load-library "ox-gfm"))
(setq org-reveal-root "file:///usr/lib/node_modules/reveal.js")
(load-library "ox-reveal-autoloads")
(eval-after-load "org"
'(load-library "ox-reveal"))

(eval-after-load "org" '(progn
;; Load org-faces to make sure we can set appropriate faces
        (require 'org-faces)

        (set-face-attribute 'line-number nil :inherit '(fixed-pitch))
        (set-face-attribute 'line-number-current-line nil :inherit '(fixed-pitch))

        ;; NOTE: These settings might not be ideal for your machine, tweak them as needed!
        ;; (set-face-attribute 'default nil :font doom-font :weight 'medium :height 180)
        ;; (set-face-attribute 'fixed-pitch nil :font doom-font :weight 'medium :height 190)
        ;; (set-face-attribute 'variable-pitch nil :font doom-variable-pitch-font :weight 'semi-light :height 1.15)

        ;;; Org Mode Appearance ------------------------------------


        ;; Hide emphasis markers on formatted text
        (setq org-hide-emphasis-markers t)

        ;; Resize Org headings
        (dolist (face '((org-level-1 . 1.4)
                        (org-level-2 . 1.3)
                        (org-level-3 . 1.15)
                        (org-level-4 . 1.1)
                        (org-level-5 . 1.2)
                        (org-level-6 . 1.2)
                        (org-level-7 . 1.2)
                        (org-level-8 . 1.2)))
        (set-face-attribute (car face) nil :font doom-variable-pitch-font :weight 'medium :height (cdr face)))

        ;; Make the document title a bit bigger
        (set-face-attribute 'org-document-title nil :font doom-variable-pitch-font :weight 'bold :height 1.3)

        ;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
        (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
        (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
        (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
        (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
        (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
        (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
        (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
        (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)))

(defun my/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

(setq visual-fill-column-width 80
      visual-fill-column-center-text t)

(defun my/org-present-start ()
  ;; Center the presentation and wrap lines
(setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
                                   (header-line (:height 4.0) variable-pitch)
                                   (org-document-title (:height 1.75) org-document-title)
                                   (org-code (:height 1.1) org-code)
                                   (org-verbatim (:height 1.1) org-verbatim)
                                   (org-block (:height 1.1) org-block)
                                   (org-block-begin-line (:height 0.6) org-block)
                                   (org-level-1 (:height 1.3) org-level-1)
                                   (org-level-2 (:height 1.2) org-level-2)
                                   (org-level-3 (:height 1.1) org-level-3)
                                   (org-level-4 (:height 1.1) org-level-4)
                                   (org-level-5 (:height 1.1) org-level-5)
                                   (org-level-6 (:height 1.2) org-level-6)
                                   (org-level-7 (:height 1.1) org-level-7)
                                   (org-level-8 (:height 1.1) org-level-8)))
  (display-line-numbers-mode 0)
  (hl-line-mode 0)
(setq header-line-format " ")
(text-scale-set 0)
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my/org-present-end ()
  ;; Stop centering the document
  (display-line-numbers-mode 1)
  (setq-local face-remapping-alist '((default variable-pitch default)))
  (hl-line-mode 1)
(setq header-line-format nil)
  (visual-fill-column-mode 0))

;; Turn on variable pitch fonts in Org Mode buffers
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)
(add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)


(require 'org-roam-export)

;; ligatures
;; (set-ligatures! 'prog-mode :sqrt "sqrt" :infinity "INFINITY")
(plist-put! +ligatures-extra-symbols
    :name          "»"
    :src_block     "»"
    :src_block_end "«"
    :quote         "“"
    :quote_end     "”"
    ;; Functional
    :lambda        "λ"
    :def           "ƒ"
    :composition   "∘"
    :map           "↦"
    ;; Types
    :null          "∅"
    :true          "⊤"
    :false         "⊥"
    :int           "ℤ"
    :float         "ℝ"
    :str           "𝕊"
    :bool          "𝔹"
    :list          "𝕃"
    ;; Flow
    :not           "¬"
    :in            "∈"
    :not-in        "∉"
    :and           "∧"
    :or            "∨"
    :for           "∀"
    :some          "∃"
    :return        "⟼"
    :yield         "⟻"
    ;; Other
    :sqrt          "√"
    :infinity      "∞"
    :uint          "ℕ"
    :union         "⋃"
    :intersect     "∩"
    :diff          "∖"
    :tuple         "⨂"
    :pipe          "" ;; FIXME: find a non-private char
    :dot           "•")

(set-ligatures! 'c-mode
        :sqrt "sqrt"
        :infinity "INFINITY"
        :uint "unsigned int")
(set-ligatures! 'cpp-mode
        :sqrt "sqrt"
        :infinity "INFINITY"
        :infinity "std::numeric_limits<double>::infinity()"
        :infinity "std::numeric_limits<float>::infinity()"
        :uint "unsigned int")
(set-ligatures! 'c++-mode
        :sqrt "sqrt"
        :infinity "INFINITY"
        :infinity "std::numeric_limits<float>::infinity()"
        :infinity "std::numeric_limits<double>::infinity()"
        :uint "unsigned int")
