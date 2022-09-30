;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Luca Fanselau"
      user-mail-address "luca.fanselau@outlook.com"
      )
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode t))

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

(load! "gtd")

(after! eglot
  (setq eglot-confirm-server-initiated-edits nil)
  (setq eglot-events-buffer-size 0))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            (message "Hi from eglot callback")
            ;; Show all eldoc feedback.
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
(after! smerge-mode
  (map! :map smerge-mode-map
        :n "SPC g m" smerge-basic-map))


;; (use-package! org-roam-ui
;;   :after org-roam ;; or :after org
;;   ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;   ;;         a hookable mode anymore, you're advised to pick something yourself
;;   ;;         if you don't care about startup time, use
;;   ;;  :hook (after-init . org-roam-ui-mode)
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-update-on-save t
;;         org-roam-ui-open-on-start t))

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
 ;;:i "TAB" #'completion-at-point
 :i "C-SPC" #'completion-at-point
 (:prefix "C-c"
  :i "s" #'cape-ispell
  :i "t" #'cape-tex
  :i "l" #'cape-line
  :i "w" #'cape-dabbrev
  )


 :leader
 :n "c c" 'completion-at-point
 :n "t t" 'treemacs-select-window)

;; (add-hook! 'lsp-mode-hook (setq-local completion-at-point-functions
;;             (list (cape-super-capf #'cape-dabbrev #'cape-ispell #'lsp-completion-at-point))))
;; (add-hook! 'text-mode-hook (add-to-list 'completion-at-point-functions #'cape-dabbrev))


(setq-hook! '(typescript-mode-hook web-mode-hook)
  +format-with-lsp nil)
;; (after! lsp-treemacs
;;   (load-library "doom-themes-ext-treemacs"))

;; (setq pixel-scroll-precision-mode t)
;; (use-package! lsp-tailwindcss :init (setq! lsp-tailwindcss-add-on-mode t))
(setenv "DICTIONARY" "en_US")

(after! tex
  (setq TeX-master 'nil))

(define-derived-mode astro-mode js-jsx-mode "astro")

(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(set-eglot-client! 'astro-mode '("astro-ls" "--stdio" :initalizationOptions (:typescript (:serverPath "~/dev/web/website/apps/website/tsconfig.json"))))
(add-hook! 'astro-mode-hook 'eglot-ensure)

(after! eglot
  (advice-add 'json-parse-buffer :around
              (lambda (orig &rest rest)
                (while (re-search-forward "\\u0000" nil t)
                  (replace-match ""))
                (apply orig rest))))
;; (map! :map flycheck-mode-map
;;       (:leader
;;        (:prefix ("c". "code")
;;         :desc "Goto next error" "e" #'flycheck-next-error
;;         :desc "Goto previous error" "E" #'flycheck-previous-error)))


(map!
 :after flymake
 :map flymake-mode-map
 :mn "]e" #'flymake-goto-next-error
 :mn "[e" #'flymake-goto-prev-error
 (:leader
  :mn "b e" #'flymake-show-buffer-diagnostics))
;; (after! lsp
;;   (add-to-list 'lsp-language-id-configuration '(astro-mode . "astro")))


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
