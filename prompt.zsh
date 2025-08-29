autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
tux=$(echo "\Uebc6")
git=$(echo "\Ue702")
zstyle ':vcs_info:git:*' formats " $git %b"
setopt prompt_subst
PROMPT='[%F{yellow}${tux} %F{cyan}%n%f %f%F{blue}%~%f%F{red}${vcs_info_msg_0_}%f]$ '
