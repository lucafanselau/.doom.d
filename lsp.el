
;; setup for the eglot client
(after! eglot
  (setq eglot-confirm-server-initiated-edits nil)
  (setq eglot-events-buffer-size 0))

(use-package! eglot-grammarly
  :after eglot
  :hook ((text-mode markdown-mode). (lambda ()
                                      (require 'eglot-grammarly)
                                      (eglot-ensure))))


(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (print "eglot-managed-mode-hook")
            (require 'flymake)
            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            ;; Show all eldoc feedback.
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))

;; same definition as mentioned earlier
;; (advice-add 'json-parse-string :around
;;             (lambda (orig string &rest rest)
;;               (apply orig (s-replace "\\u0000" "" string)
;;                      rest)))

;; ;; minor changes: saves excursion and uses search-forward instead of re-search-forward
(advice-add 'json-parse-buffer :around
            (lambda (oldfn &rest args)
	      (save-excursion
                (while (search-forward "\\u0000" nil t)
                  (replace-match "" nil t)))
	      (apply oldfn args)))



(add-hook! prog-mode #'flymake-mode)

(after! lsp-mode
  (setq lsp-ui-sideline-mode nil)
  (setq lsp-ui-mode nil)
  (setq lsp-diagnostics-provider :flycheck)
  (setq lsp-auto-execute-action nil))

(after! flymake
(add-hook 'lsp-mode-hook
          (lambda ()
            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            ;; Show all eldoc feedback.
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose))))

;; (add-hook 'lsp-mode-hook
;;           (lambda ()
;;             ;; Show flymake diagnostics first.
;;             (setq eldoc-documentation-functions
;;                   (cons #'flymake-eldoc-function
;;                         (remove #'flymake-eldoc-function eldoc-documentation-functions)))
;;             ;; Show all eldoc feedback.
;;             (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
