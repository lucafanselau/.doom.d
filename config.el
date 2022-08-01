;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Luca Fanselau"
      user-mail-address "luca.fanselau@outlook.com")

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'one-dark-doom)
(after! all-the-icons
  (setq all-the-icons-color-icons nil))
;; (setq doom-theme 'doom-one)
;; (after! doom-modeline
;;   (setq doom-modeline-buffer-file-name-style 'file-name))

(setq doom-font (font-spec :family "MonoLisa" :size 13 :weight 'medium))
(setq doom-big-font (font-spec :family "MonoLisa" :size 16 :weight 'bold))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Some movement specific setup
(after! avy
  (setq avy-all-windows t))
(after! evil-snipe
  (setq evil-snipe-scope 'buffer))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(use-package! websocket
  :after org-roam)

(after! org
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.1)))

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

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
(defun avy-goto-web-tag ()
  (interactive)
  (avy-jump "<[[:alnum:]]+"));

(map!
 :n "g s c" 'avy-goto-web-tag
 ;; completion primitives
 :i "TAB" #'completion-at-point
 :i "C-SPC" #'completion-at-point
 :leader
 :n "c c" 'completion-at-point
 :n "t t" 'treemacs-select-window)

(setq-hook! '(typescript-mode-hook web-mode-hook)
  +format-with-lsp nil)
(after! lsp-treemacs
  (load-library "doom-themes-ext-treemacs"))

(setq pixel-scroll-precision-mode t)
(use-package! lsp-tailwindcss :init (setq! lsp-tailwindcss-add-on-mode t))
(setenv "DICTIONARY" "en_US")

(after! tex
  (setq TeX-master 'nil))

(define-derived-mode astro-mode js-jsx-mode "astro")

(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(after! lsp
  (add-to-list 'lsp-language-id-configuration '(astro-mode . "astro")))


(use-package! ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 't '("-->" "->" "->>" "-<" "--<"
                               "-~" "]#" ".-" "!=" "!=="
                               "#(" "#{" "#[" "#_" "#_("
                               "/=" "/==" "|||" "||" ;; "|"
                               "==" "===" "==>" "=>" "=>>"
                               "=<<" "=/" ">-" ">->" ">="
                               ">=>" "<-" "<--" "<->" "<-<"
                               "<!--" "<|" "<||" "<|||"
                               "<|>" "<=" "<==" "<==>" "<=>"
                               "<=<" "<<-" "<<=" "<~" "<~>"
                               "<~~" "~-" "~@" "~=" "~>"
                               "~~" "~~>" ".=" "..=" "---"
                               "{|" "[|" ".."  "..."  "..<"
                               ".?"  "::" ":::" "::=" ":="
                               ":>" ":<" ";;" "!!"  "!!."
                               "!!!"  "?."  "?:" "??"  "?="
                               "*>" "*/" "#:"
                               "#!"  "#?"  "##" "###" "####"
                               "#=" "/*" "/>" "//" "///"
                               "&&" "|}" "|]" "$>" "++"
                               "+++" "+>" "=:=" "=!=" ">:"
                               ">>" ">>>" "<:" "<*" "<*>"
                               "<$" "<$>" "<+" "<+>" "<>"
                               "<<" "<<<" "</" "</>" "^="
                               "%%" "'''" "\"\"\"" ))
  (ligature-set-ligatures 'prog-mode '("**" "***"))
  (ligature-set-ligatures '(html-mode nxml-mode web-mode) '("<!--" "-->" "</>" "</" "/>" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; turns out vertico mouse mode is kinda shit
;; (use-package! vertico
;;  :config
;;  (vertico-mouse-mode))
