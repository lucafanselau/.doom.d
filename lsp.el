
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
            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            ;; Show all eldoc feedback.
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))

;; (after! eglot
;;   (advice-add 'json-parse-buffer :around
;;               (lambda (orig &rest rest)
;;                 (while (re-search-forward "\\u0000" nil t)
;;                   (replace-match ""))
;;                 (apply orig rest))))
