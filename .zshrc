alias ll='exa -lr'
alias la='exa -lra'
alias lt='exa -Tr'

alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin master'

alias vim='nvim'
alias top='htop'
alias fd='fdfind'

. ~/.cargo/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/billy/.local/bin

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.zsh

precmd() {
    precmd() {
        echo
    }
}

HISTFILE=~/.zsh/zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

eval "$(starship init zsh)"
