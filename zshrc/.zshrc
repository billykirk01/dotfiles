alias ls='ls --color=auto'
alias la='ls -ltrha --color=auto'
alias ll='ls -ltrh --color=auto'
alias gc='git commit'
alias vim="nvim"
alias vi="nvim"
alias view='nvim -R'
alias sudo='sudo '
alias remote-desktop='wlfreerdp -grab-keyboard /u:bkirk /gfx /sound /microphone /size:2560x1440 /v:epic95305.dhcp.epic.com'
alias r="ranger"

alias prune="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"

. ~/.cargo/env
export RUSTC_WRAPPER=/usr/bin/sccache

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/billy/.local/bin

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

precmd() {
    precmd() {
        echo
    }
}

export EDITOR=nvim
export VISUAL=nvim

HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

autoload -Uz compinit promptinit
compinit
promptinit

eval "$(starship init zsh)"
