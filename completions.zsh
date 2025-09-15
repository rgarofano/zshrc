autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# cycle through tab completion options with vim keybindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Define custom completions below

_r() {
    local -a subcmds
    local -a gen_args
    local -a types

    subcmds=(generate)
    gen_args=(scaffold model controller migration)
    column_types=(string text "integer" bigint "float" decimal datetime "time" date binary boolean references)
    controller_actions=(index show new create edit update destroy)

    case $CURRENT in
        2)
            compadd $subcmds
            ;;
        3)
            [[ $words[2] == "generate" ]] && compadd $gen_args
            ;;
        *)
            if [[ $words[2] == "generate" ]]; then
                local cur    
                cur="$words[CURRENT]"

                if [[ "$cur" == *:* ]]; then
                    local prefix="${cur%%:*}" # text before colon ex. "name"
                    local typed="${cur#*:}" # text after colon ex. "str"
                    local -a matches
                    if [[ -n "$typed" ]]; then
                        matches=(${(@M)column_types:#${typed}*})
                    else
                        matches=(${column_types[@]})
                    fi
                    compadd -Q -U -o nosort -M 'r:|=*' -- "${matches[@]/#/$prefix:}"
                elif [[ $words[3] == "controller" ]]; then
                    matches=(${(@M)controller_actions:#${cur}*})
                    compadd -Q -U -o nosort -M 'r:|=*' -- "${matches[@]}"
                else
                    # fallback to default filename completion
                    compadd "$cur"
                fi
            fi
            ;;
    esac
}

compdef _r r
