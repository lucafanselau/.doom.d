;; Theme setup and my small little dark mode switcher

(setq doom-theme 'one-dark-doom)
(defvar default-dark-theme 'one-dark-doom)
(defvar default-light-theme 'doom-nord-light)

;; a small little dark mode switcher

(defvar dark-mode t
  "Controls wheter dark mode is enabled or not")

(defun toggle-dark-mode ()
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  (when (eq dark-mode t)  (load-theme 'doom-nord-light t) (message "Ohh, you're working outside. Good for you!"))
  (when (eq dark-mode nil)  (load-theme 'one-dark-doom t) (message "Aaaand your back again"))
  ;; reset icons, because that doesn't work automatically after the theme switch
  (kind-icon-reset-cache)
  (setq dark-mode (not dark-mode)))
