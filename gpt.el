(require 'gptai)
(setq gptai-model "gpt-3.5-turbo")
(setq gptai-username "lucafanselau")
(setq gptai-api-key "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")

(map!
:leader
:n :desc "GPT-3.5" "Q" #'gptai-turbo-query)
