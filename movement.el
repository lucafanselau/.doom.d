
;; Some movement specific setup
(after! avy
  (setq avy-all-windows t))
(after! evil-snipe
  (setq evil-snipe-scope 'buffer))

;; remove s/S t/T keybindings
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(defun avy-goto-web-tag ()
  (interactive)
  (avy-jump "<[[:alnum:]]+"));
