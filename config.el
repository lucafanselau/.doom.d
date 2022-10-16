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
 :nmo "s" #'avy-goto-char-2-below
 :nmo "S" #'avy-goto-char-2-above
 :n "g s c" 'avy-goto-web-tag

 ;; *Completion*
 :i "C-SPC" #'completion-at-point
 (:prefix "C-c"
  :i "s" #'cape-ispell
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

 ;; rebind smerge map for magit
 (:after smerge-mode
  :map smerge-mode-map
  :leader
  :n "g m" smerge-basic-map)

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
