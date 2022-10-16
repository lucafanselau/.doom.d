(use-package! ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 't '("-->" "->" "->>" "-<" "--<"
                               "-~" "]#" ".-" "!=" "!=="
                               "#(" "#{" "#[" "#_" "#_("
                               "/=" "/==" "|||" "||" ;; "|"
                               "==" "===" "==>" "=>" "=>>"
                               "=<<" "=/" ">-" ">->" ">="
                               ">=>" "<-" "<--" "<->" "<-<"
                               "<!--" "<|" "<||" "<|||"
                               "<|>" "<=" "<==" "<==>" "<=>"
                               "<=<" "<<-" "<<=" "<~" "<~>"
                               "<~~" "~-" "~@" "~=" "~>"
                               "~~" "~~>" ".=" "..=" "---"
                               "{|" "[|" ".."  "..."  "..<"
                               ".?"  "::" ":::" "::=" ":="
                               ":>" ":<" ";;" "!!"  "!!."
                               "!!!"  "?."  "?:" "??"  "?="
                               "*>" "*/" "#:"
                               "#!"  "#?"  "##" "###" "####"
                               "#=" "/*" "/>" "//" "///"
                               "&&" "|}" "|]" "$>" "++"
                               "+++" "+>" "=:=" "=!=" ">:"
                               ">>" ">>>" "<:" "<*" "<*>"
                               "<$" "<$>" "<+" "<+>" "<>"
                               "<<" "<<<" "</" "</>" "^="
                               "%%" "'''" "\"\"\"" ))
  (ligature-set-ligatures 'prog-mode '("**" "***"))
  (ligature-set-ligatures '(html-mode nxml-mode web-mode) '("<!--" "-->" "</>" "</" "/>" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))
