
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="$HOME/.local/bin:$PATH"

# Git-aware prompt
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr $' %F{3}\uf040%f'
zstyle ':vcs_info:git:*' stagedstr   $' %F{2}\uf067%f'
zstyle ':vcs_info:git:*' formats       $' %F{8}on%f \e[3m%F{5}\uf126 %b%f\e[23m%u%c'
zstyle ':vcs_info:git:*' actionformats $' %F{8}on%f \e[3m%F{5}\uf126 %b%f\e[23m %F{1}(%a)%f'

setopt PROMPT_SUBST

PROMPT=$'\n%F{6}%~%f${vcs_info_msg_0_}\n%F{2}✦%f '


