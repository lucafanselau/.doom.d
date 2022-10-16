
;; Config related to typescript / web-mode and web stuff

(add-hook 'web-mode-hook
          (lambda ()
            (setq font-lock-mode nil)))


;; This should not be necessary anymore
(setq-hook! '(typescript-mode-hook web-mode-hook)
  +format-with-lsp nil)

(define-derived-mode astro-mode js-jsx-mode "astro")

(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(set-eglot-client! 'astro-mode '("astro-ls" "--stdio" :initalizationOptions (:typescript (:serverPath "~/dev/web/website/apps/website/tsconfig.json"))))
(add-hook! 'astro-mode-hook 'eglot-ensure)
