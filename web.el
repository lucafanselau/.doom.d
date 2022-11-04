
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



;; testing some textobj
(map!
 (:map +tree-sitter-inner-text-objects-map
       "d" (evil-textobj-tree-sitter-get-textobj "declaration.inner" '((typescript-tsx-mode . [(lexical_declaration (variable_declarator (identifier) (_) @declaration.inner)  )])))
       )
 (:map +tree-sitter-outer-text-objects-map
       "i" (evil-textobj-tree-sitter-get-textobj "import" '((typescript-tsx-mode . [(import_statement) @import])))
       "d" (evil-textobj-tree-sitter-get-textobj "declaration.outer" '((typescript-tsx-mode . [(lexical_declaration) @declaration.outer])))
       )

 )
