;;; checkers/grammarly/config.el -*- lexical-binding: t; -*-

(use-package lsp-grammarly
  :ensure t
  :hook (text-mode . (lambda ()
                       (require 'lsp-grammarly)
                       (lsp-deferred))))  ; or lsp-deferred
