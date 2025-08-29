alias vi="nvim"
alias ls="eza -lh --group-directories-first --icons=auto"
alias lsa="ls -a"
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"
