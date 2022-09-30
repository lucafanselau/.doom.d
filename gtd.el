;; A simple implementation of concepts based on Get Things Done
;;

(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))

(after! org
  (setq org-directory "~/org/")
  (setq org-agenda-files (list "inbox.org" "agenda.org"))
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.1))
  (setq org-refile-targets
        '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE (d)")))
  (setq org-log-done 'time)
  (add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)
  (setq org-capture-templates
        `(("i" "Inbox" entry (file "inbox.org") ,(concat "* TODO %?\n" "/Entered On/ %U"))
          ("m" "Meeting" entry (file+heading "agenda.org" "Future") ,(concat "* %? :meeting:\n" "SCHEDULED: <%<%Y-%m-%d %a %H:00>>"))
          ("n" "Notes" entry (file "notes.org") ,(concat "* NOTE (%a)\n" "/Entered on/ %U\n" "\n" "%?"))
          )))
