;;; checkers/grammarly/config.el -*- lexical-binding: t; -*-

(use-package lsp-grammarly
  :ensure t
  :init
  (setq lsp-grammarly-active-modes '(text-mode latex-mode org-mode markdown-mode mdx-mode))
  :hook (text-mode . (lambda ()
                       (require 'lsp-grammarly)
                       (lsp-deferred))))  ; or lsp-deferred
