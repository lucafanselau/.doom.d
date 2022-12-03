;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; <--------------[ Global constants & Setup ]-------------->
(setq user-full-name "Luca Fanselau"
      user-mail-address "luca.fanselau@outlook.com")

;; Fonts
(setq doom-font (font-spec :family "MonoLisa" :size 11 :weight 'medium))
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

;; <--------------[ External files ]-------------->
;; Additional modules and custom files
(load! "theme")
(load! "gtd") ;; this is our small attempt at managing my life
(load! "lsp")
(load! "web")
(load! "movement")
(load! "ligatures")

;; <--------------[ Keybindings ]-------------->
;;
;; Our big map tree

(map!
 ;; *Movement*
 ;; :nmo "s" #'avy-goto-char-2-below
 ;; :nmo "S" #'avy-goto-char-2-above
 :n "g s c" 'avy-goto-web-tag

 ;; *Completion*
 :i "C-SPC" #'completion-at-point
 (:prefix "C-c"
  :i "s" #'cape-ispell
  :i "f" #'cape-file
  :i "t" #'cape-tex
  :i "l" #'cape-line
  :i "w" #'cape-dabbrev)

 ;; flymake
 (:after flymake
  :map flymake-mode-map
  :mn "]e" #'flymake-goto-next-error
  :mn "[e" #'flymake-goto-prev-error
  (:leader
   :mn "b e" #'flymake-show-buffer-diagnostics) )

 ;; flycheck
 (:after flycheck
  :map flycheck-mode-map
  :mn "]e" #'flycheck-next-error
  :mn "[e" #'flycheck-previous-error
  (:leader
   :mn "b e" #'flycheck-list-errors))

 ;; rebind smerge map for magit
 (:after smerge-mode
  :map smerge-mode-map
  :leader
  :n "g m" smerge-basic-map)

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
