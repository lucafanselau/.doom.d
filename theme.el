;; Theme setup and my small little dark mode switcher

(setq doom-theme 'one-dark-doom)
(defvar default-light-theme 'doom-nord-light)

;; a small little dark mode switcher

(defvar dark-mode t
  "Controls wheter dark mode is enabled or not")

(defun toggle-dark-mode ()
  (interactive)
  (when (eq dark-mode t) (load-theme 'default-light-theme))
  (when (eq dark-mode nil) (load-theme 'doom-theme))
  ;; reset icons, because that doesn't work automatically after the theme switch
  (kind-icon-reset-cache)
  (setq dark-mode (not dark-mode)))
