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
; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq mouse-wheel-progressive-speed nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; set font size
(set-face-attribute 'default nil :height 150)

(dolist (charset '(koi8))
  (set-fontset-font (frame-parameter nil 'font)
    charset (font-spec :family "Fira Code" :height 140)))
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



(use-package evil-collection
  :after evil
  :custom (evil-collection-want-find-usages-bindings t)
  :init (evil-collection-init))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)

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

  ;; Latex TOC pagebreak
  (setq org-latex-toc-command "\\tableofcontents \\clearpage")

  (setq org-babel-C-compiler "gcc -lm")
  (evil-org-agenda-set-keys))

(use-package multiple-cursors
  :defer
  :init
  (add-hook 'multiple-cursors-mode-hook
            (defun my/work-around-multiple-cursors-issue ()
              (load "multiple-cursors-core.el")
              (remove-hook 'multiple-cursors-mode-hook #'my/work-around-multiple-cursors-issue))))


;; Tab commands
(require 'org-roam-export)

(add-hook 'persp-before-deactivate-functions
            (defun +workspaces-save-tab-bar-data-h (_)
              (when (get-current-persp)
                (set-persp-parameter
                 'tab-bar-tabs (tab-bar-tabs)))))

(add-hook 'persp-activated-functions
        (defun +workspaces-load-tab-bar-data-h (_)
        (tab-bar-tabs-set (persp-parameter 'tab-bar-tabs))
        (tab-bar--update-tab-bar-lines t)))

(add-hook 'persp-before-save-state-to-file-functions
              (defun +workspaces-save-tab-bar-data-to-file-h (&rest _)
                (when (get-current-persp)
                  (set-persp-parameter 'tab-bar-tabs (frameset-filter-tabs (tab-bar-tabs) nil nil t)))))

(defun tab-move-back ()
  (interactive)
  (tab-move -1))

(defun tab-bar-toggle ()
  (interactive)
  (setq tab-bar-show (not tab-bar-show))
  (tab-bar--update-tab-bar-lines))

(defun tab-new-rename ()
  (interactive)
        (tab-new)
        (tab-rename))

(map! "M-j" #'tab-previous)
(map! "M-k" #'tab-next)
(map! "M-J" #'tab-move-back)
(map! "M-K" #'tab-move)
(map! :leader "W n" #'tab-new)
(map! :leader "W t" #'toggle-frame-tab-bar)
(map! :leader "W N" #'tab-new-rename)
(map! :leader "W r" #'tab-rename)
(map! :leader "W c" #'tab-close)

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

;; load internal topspace functions??
;;(topspace-default-active)
(advice-add 'topspace--enable :after #'zen-mode-bodge)
(advice-add 'topspace--disable :after #'zen-mode-clear)

;; (defun zen-mode-evil-scroll-up (&optional lines)
;;   (setq lines (or lines (max 0 evil-scroll-count)))
;;   (when (zerop lines)
;;     (setq lines (/ (window-body-height) 2)))
;;     (scroll-down lines)
;;     (print lines))

;; (defun zen-mode-evil-scroll-down (&optional lines)
;;   (setq lines (or lines (max 0 evil-scroll-count)))
;;   (when (zerop lines)
;;     (setq lines (/ (window-body-height) 2)))
;;     (scroll-up lines))

;; (advice-add #'evil-scroll-up :override #'zen-mode-evil-scroll-up)
;; (advice-add #'evil-scroll-down :override #'zen-mode-evil-scroll-down)

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

(map! "M-p" #'flycheck-previous-error)
(map! "M-n" #'flycheck-next-error)


; Ispell
(with-eval-after-load "ispell"
 (setenv "LANG" "en_US.UTF-8")
 (setq ispell-program-name "hunspell")
 (setq ispell-dictionary "de_DE,en_US,en_GB")
 (ispell-set-spellchecker-params)
 (ispell-hunspell-add-multi-dic "de_DE,en_US,en_GB"))

(map! :leader "pl" 'ispell-hunspell-add-multi-dic)

;; Git
(map! :leader "gm" 'smerge-keep-current)

;;selection transpose
;;previous selection is stored on evil-visual exit
;;use M-T to activate
(defvar secondary-selection)

(defun transpose-selections ()
    (interactive)
    (if (and (mark) (car secondary-selection))
        (transpose-regions (mark) (point) (car secondary-selection) (nth 1 secondary-selection) t)))

(defun set-secondary-selection ()
    (interactive)
    (setq secondary-selection (list (mark) (1+ (point)))))

(advice-add 'evil-visual-deactivate-hook :before #'set-secondary-selection)
(map! :map 'override "M-T" 'transpose-selections)

  ;; :config
  (define-key evil-normal-state-map "gb" 'evil-switch-to-windows-last-buffer)
  (define-key evil-normal-state-map (kbd "C-q") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-s") 'evil-numbers/dec-at-pt)
;; edit-indirect
(map! "C-c '" 'edit-indirect-region)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))
;; latex
(setq latex-run-command "lualatex")
(setq pdf-latex-command "lualatex")
;; (setq latex-run-command "latex")
;; (setq pdf-latex-command "latex")

(map! :leader "pw" 'org-agenda-file-to-front)
(map! :leader "pW" 'org-remove-file)

;; TODO Open Project.org in buffer

(set-ligatures! 'rustic-mode
        :true "true" :false "false"
        ; this will replace not only definitions
        ; but coresponding functions aswell
        :int "int" :str "str"
        :float "float" :bool "bool"
        :and "&&"
        :def "fn"
        :or "||")

(plist-put! +ligatures-extra-symbols
  ;; org
  ;;
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
  :true          "𝕋"
  :false         "𝔽"
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
  :union         "⋃"
  :intersect     "∩"
  :diff          "∖"
  :tuple         "⨂"
  :dot           "•")  ;; you could also add your own if you want
