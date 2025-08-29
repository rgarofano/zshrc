HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY           # append, don’t overwrite, history file
setopt HIST_IGNORE_DUPS         # ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS     # remove old duplicates
setopt HIST_SAVE_NO_DUPS        # don’t save duplicates
setopt SHARE_HISTORY            # share history between sessions
setopt INC_APPEND_HISTORY       # write command to history immediately
setopt HIST_REDUCE_BLANKS       # remove extra blanks
