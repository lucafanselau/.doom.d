;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'one-dark-doom)

;; (setq doom-theme 'doom-city-lights)
;; (setq doom-theme 'one-dark)
(setq doom-font (font-spec :family "MonoLisa" :size 14 :weight 'regular))
(setq doom-big-font (font-spec :family "MonoLisa" :size 16 :weight 'bold))
;;(setq doom-font (font-spec :family "Jetbrains Mono" :size 12 :weight 'medium))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; Set org latex preview images to be double in scale
(after! org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.2))
  (global-set-key (kbd "M-c") 'org-edit-latex-fragment))

;; This Determines The style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(after! lsp-ui
  (setq lsp-ui-peek-mode t))

(after! centaur-tabs
  (global-set-key (kbd "M-<prior>") 'centaur-tabs-backward)
  (global-set-key (kbd "M-<next>") 'centaur-tabs-forward))

(setq lsp-julia-package-dir nil)
(setq lsp-julia-default-environment "~/.julia/environments/v1.6")
;;(setq eglot-connect-timeout 240)
;;(setq eglot-jl-language-server-project "~/.julia/environments/v1.6")
;;(setq lsp-julia-default-depot "~/.julia")

(after! treemacs
  (setq treemacs-read-string-input 'from-minibuffer))


(map! :localleader
        :map tide-mode-map
        "RET"   #'tide-fix)


(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x B") 'projectile-switch-to-buffer)

(global-set-key (kbd "C-#") 'enlarge-window-horizontally)
(global-set-key (kbd "C-ä") 'shrink-window-horizontally)

;; Here are some additional functions/macros that help could you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; This should increase lsp performance
(setq read-process-output-max (* 1024 4096)) ;; 4mb

(after! (:or typescript-mode web-mode)
  (setq +format-with-lsp nil))

(after! avy
  (map! :leader
        (:prefix ("j" . "jump")
         :desc "Avy goto char" "c" #'avy-goto-char
         :desc "Goto next match" "n" #'avy-next
         :desc "Goto previous match" "p" #'avy-prev)))

;; General UI Stuff
(setq-hook! 'lsp-ui-mode-hook lsp-ui-sideline-mode 'nil)
(use-package! lsp-treemacs
  :after lsp
  :config
  (lsp-treemacs-sync-mode 1))

(after! lsp-treemacs
  (load-library "doom-themes-ext-treemacs"))

(after! rustic
  (setq lsp-rust-server 'rust-analyzer))

(use-package! lsp-rust
  :config
  (setq! lsp-rust-analyzer-cargo-watch-enable t
         lsp-rust-analyzer-cargo-watch-command "clippy"
         lsp-rust-analyzer-proc-macro-enable t
         rust-analyzer-check-inlay-hints-mode t
         lsp-rust-analyzer-display-chaining-hints t
         lsp-rust-analyzer-display-parameter-hints t
         lsp-rust-analyzer-server-display-inlay-hints t))

(after! lsp-mode
(global-set-key (kbd "M-RET") 'lsp-execute-code-action))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.next\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.yarn\\'"))


;; flycheck
(after! flycheck
  (global-flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(add-to-list 'exec-path (concat (getenv "HOME") "/.node_modules/bin"))

(use-package! ron-mode
  :mode "\\.pipe\\'")

(use-package! visual-regexp-steroids
  :defer 3
  :config
  (require 'pcre2el)
  (setq vr/engine 'pcre2el)
  (map! "C-c s r" #'vr/replace)
  (map! "C-c s q" #'vr/query-replace))

;; GLSL
(use-package! glsl-mode
  :defer t)

(use-package! company-glsl  ; for `glsl-mode'
  :after glsl-mode
  :config (set-company-backend! 'glsl-mode 'company-glsl))

(use-package! good-scroll
  :config (good-scroll-mode 1))

(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook! 'prog-mode-hook #'rainbow-mode)

(use-package! ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("-->" "->" "->>" "-<" "--<"
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
                                       "**" "***" "*>" "*/" "#:"
                                       "#!"  "#?"  "##" "###" "####"
                                       "#=" "/*" "/>" "//" "///"
                                       "&&" "|}" "|]" "$>" "++"
                                       "+++" "+>" "=:=" "=!=" ">:"
                                       ">>" ">>>" "<:" "<*" "<*>"
                                       "<$" "<$>" "<+" "<+>" "<>"
                                       "<<" "<<<" "</" "</>" "^="
                                       "%%" "'''" "\"\"\"" ))
  (ligature-set-ligatures '(html-mode nxml-mode web-mode) '("<!--" "-->" "</>" "</" "/>" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))
