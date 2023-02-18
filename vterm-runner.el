(defvar lf/npm-client "pnpm")

(defun lf/get-scripts ()
  (require 'json)
  (let* ((package-json (f-join (projectile-project-root) "package.json"))
         (parsed-json (json-read-file package-json)))
    (alist-get 'scripts parsed-json)))


(defun lf/vterm-run-command (cmd name)
  "Run the command CMD In a new vterm buffer with the name NAME if it not exists, otherwise switch to the existing buffer of name NAME and execute command CMD."
  (require 'vterm)
  (let ((buffer (get-buffer name))
        (default-directory (projectile-project-root)))
    (if buffer
        (progn
          (switch-to-buffer buffer)
          (vterm-send-C-c)
          (vterm-send-string cmd)
          (vterm-send-return))
      (vterm name)
      (vterm-send-string cmd)
      (vterm-send-return))))


(defun lf/run-scripts ()
  (interactive)
  (require 'consult)
  (require 'dash)
  (let* ((scripts (lf/get-scripts))
         (scripts (-map (lambda (s) (format "run %s" (car s))) scripts))
         (scripts (-concat scripts '("install")))
         (script (consult--read scripts :prompt "Script: "))
         (default-directory (projectile-project-root))
         (cmd (format "%s %s" lf/npm-client script)))
    (lf/vterm-run-command cmd (format "*script: %s*" script))))


(defun lf/open-current ()
  (interactive)
  (find-file (vterm--get-pwd)))


(map! :localleader
      :map vterm-mode-map
      "o" #'lf/open-current)

(map!
 :leader
 :desc "Run scripts" "o s" #'lf/run-scripts)
