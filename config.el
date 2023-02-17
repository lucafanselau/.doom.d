;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; <--------------[ Global constants & Setup ]-------------->
(setq user-full-name "Luca Fanselau"
      user-mail-address "luca.fanselau@outlook.com")

;; Fonts
(setq doom-font (font-spec :family "MonoLisa" :size 11 :weight 'medium))
(setq doom-font-increment 1)
(setq doom-big-font (font-spec :family "MonoLisa" :size 16 :weight 'bold))

(setenv "DICTIONARY" "en_US")

;; <--------------[ Editor ]-------------->
;; Emacs and editor related setup

;; Enable precision scrolling if available
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode t))
;; Setup line numbers
(setq display-line-numbers-type 'relative)
;; Icons
(after! all-the-icons
  (setq all-the-icons-color-icons nil))

(after! evil
  (setq evil-want-minibuffer t))

(after! emojify
  (setq emojify-display-style 'unicode))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook ((prog-mode markdown-mode) . copilot-mode))

(after! company
  (setq company-idle-delay 1))

;; <--------------[ External files ]-------------->
;; Additional modules and custom files
(load! "theme")
(load! "gtd") ;; this is our small attempt at managing my life
(load! "lsp")
(load! "web")
(load! "movement")
(load! "ligatures")
(load! "vterm-runner")


;; <--------------[ Keybindings ]-------------->
;;
;; Our big map tree
;;
(after! evil-easymotion
  (defvar lf/fast-search-map (let ((map (make-sparse-keymap)))
                               (set-keymap-parent map evilem-map)
                               map))
  (map!
   :map lf/fast-search-map
   ;; :desc "search tags" :m "/c" #'avy-goto-web-tag
   ;; :desc "search closing tags" :m "/C" #'avy-goto-web-tag-closing)
   :desc "search buffer" "b" #'consult-line
   :desc "search project buffers" "B" #'consult-line-multi)

  (map!
   :m "/" lf/fast-search-map))

(map!
 ;; *Movement*
 ;;
 ;;
 ;; *Copilot*
 (:after copilot
  :i "C-<tab>" #'copilot-accept-completion-by-word
  :i "S-SPC" #'copilot-complete
  (:map copilot-completion-map
        "<tab>" 'copilot-accept-completion
        "TAB"  'copilot-accept-completion
        "C-RET" 'copilot-accept-completion
        "C-k"  'copilot-kill-completion
        "C-n"  'copilot-next-completion
        "C-p"  'copilot-previous-completion
        "C-g"  'copilot-abort-completion))


 ;; *Completion*
 (:after corfu
  :i "C-SPC" #'completion-at-point
  :i "C-," #'cape-dabbrev
  (:prefix "C-c"
   :i "s" #'cape-ispell
   :i "f" #'cape-file
   :i "t" #'cape-tex
   :i "l" #'cape-line
   :i "C-w" #'cape-dabbrev
   :i "w" #'cape-dabbrev)
  )


 ;; flymake
 (:after flymake
  :map flymake-mode-map
  :mn "]e" #'flymake-goto-next-error
  :mn "[e" #'flymake-goto-prev-error
  (:leader
   :mn "b e" #'flymake-show-buffer-diagnostics) )

 ;; flycheck
 ;; (:after flycheck
 ;;  :map flycheck-mode-map
 ;;  :mn "]e" #'flycheck-next-error
 ;;  :mn "[e" #'flycheck-previous-error
 ;;  (:leader
 ;;   :mn "b e" #'flycheck-list-errors))

 ;; rebind smerge map for magit
 ;; (:after smerge-mode
 ;;         (:map smerge-mode-map
 ;;          :leader
 ;;          :n "m" smerge-basic-map ))

 (:after vterm
  :map vterm-mode-map
  :n "C-j" #'vterm-send-down
  :n "C-k" #'vterm-send-up)


 :leader
 (:prefix-map ("i" . "insert")
  :desc "Gitmoji" "g" #'gitmoji-insert-emoji)
 (:prefix-map ("t" . "toggle")
  :desc "Dark mode" "t" 'toggle-dark-mode))

;; flycheck for reference, if we move back to lsp
;; (map! :map flycheck-mode-map
;;       (:leader
;;        (:prefix ("c". "code")
;;         :desc "Goto next error" "e" #'flycheck-next-error
;;         :desc "Goto previous error" "E" #'flycheck-previous-error)))

;; <--------------[ Misc ]-------------->
;;; Useful for https://github.com/dunn/company-emoji
;; https://www.reddit.com/r/emacs/comments/8ph0hq/i_have_converted_from_the_mac_port_to_the_ns_port/
;; not tested with emacs26 (requires a patched Emacs version for multi-color font support)
(if (version< "27.0" emacs-version)
    (set-fontset-font
     "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)
  (set-fontset-font
   t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))
