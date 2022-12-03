
;; Config related to typescript / web-mode and web stuff

(add-hook 'web-mode-hook
          (lambda ()
            (setq font-lock-mode nil)))


;; This should not be necessary anymore
(setq-hook! '(typescript-mode-hook web-mode-hook)
  +format-with-lsp nil)

(use-package lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t)
  (setq lsp-tailwindcss-major-modes '(rjsx-mode web-mode html-mode css-mode typescript-mode typescript-tsx-mode)))

(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(add-hook! 'astro-mode-hook #'lsp!)

(add-hook! 'astro-mode-hook
  (setq web-mode-enable-front-matter-block t))

;; (after! lsp-mode
;;   (add-to-list 'lsp-language-id-configuration
;;                '(astro-mode . "astro"))

;;   (defun astro-get-tsserver ()
;;     ""
;;     (f-join (lsp-workspace-root) "node_modules/typescript/lib/tsserverlibrary.js"))

;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
;;                     :activation-fn (lsp-activate-on "astro")
;;                     :initialization-options (lambda ()
;;                                               `(:typescript (:serverPath ,(astro-get-tsserver))))
;;                     :server-id 'astro-ls))
;;   (add-hook! 'astro-mode-hook '(lsp!)))

(after! eglot
  (defclass eglot-astro (eglot-lsp-server) ()
    :documentation "A custom class for astro-ls.")

  (defun eglot-astro--server-command ()
    "Generate startup command for astro-ls"
    (list 'eglot-astro "astro-ls" "--stdio"))

  (cl-defmethod eglot-initialization-options ((server eglot-astro))
    "Passes through required cquery initialization options"
    (let* ((root (car (project-roots (eglot--project server))))
           (tsslibrary (expand-file-name "node_modules/typescript/lib/tsserverlibrary.js" root)))
      (message tsslibrary)
      `(:typescript (:serverPath ,tsslibrary)
        :configuration ())))

  (add-to-list 'eglot-server-programs
               `(astro-mode . ,(eglot-astro--server-command))))
                                        ; (add-hook! 'astro-mode-hook 'eglot-ensure)



(define-derived-mode mdx-mode markdown-mode "mdx")
(setq auto-mode-alist
      (append '((".*\\.mdx\\'" . mdx-mode))
              auto-mode-alist))

(add-to-list 'lsp-grammarly-active-modes 'mdx-mode)

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(mdx-mode . "plaintext")))

(add-hook! 'mdx-mode-hook
  (lambda ()
    (require lsp-grammarly)
    (lsp-deferred)))

;; (AFTER! lsp-grammarly
;;   (add-to-list 'lsp-grammarly-active-modes 'mdx-mode))

;; testing some textobj
(map!
 (:map +tree-sitter-inner-text-objects-map
       "d" (evil-textobj-tree-sitter-get-textobj "declaration.inner" '((typescript-tsx-mode . [(lexical_declaration (variable_declarator (identifier) (_) @declaration.inner)  )])))

       "T" (evil-textobj-tree-sitter-get-textobj "type.inner" '((typescript-tsx-mode . [(type_alias_declaration (type_identifier) (_) @type.inner  )])))
       )
 (:map +tree-sitter-outer-text-objects-map
       "i" (evil-textobj-tree-sitter-get-textobj "import" '((typescript-tsx-mode . [(import_statement) @import])))
       "d" (evil-textobj-tree-sitter-get-textobj "declaration.outer" '((typescript-tsx-mode . [
                                                                                               (export_statement (lexical_declaration) @declaration.outer) @declaration.outer
                                                                                               ])))
       "T" (evil-textobj-tree-sitter-get-textobj "type.outer" '((typescript-tsx-mode . [(type_alias_declaration) @type.outer])))
       )

 )
