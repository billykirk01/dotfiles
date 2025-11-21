# add a line in between commands
precmd() {
    precmd() {
        echo
    }
}

# history
HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

# autocompletion
fpath=(~/.zsh/completion $fpath) #custom completion files go here
autoload -Uz compinit promptinit
compinit
promptinit
_comp_options+=(globdots) #include hidden files

# brew bundle
export HOMEBREW_BUNDLE_FILE=$HOME/.config/brewfile/Brewfile

# Homebrew on Linux
if [[ $(uname) == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# autosuggestions and vi-mode
if [[ $(command -v brew) != "" ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $(brew --prefix)/share/zsh-vi-mode/zsh-vi-mode.zsh
fi

# starship
if [[ $(command -v starship) != "" ]]; then
    eval "$(starship init zsh)"
fi

# eza
if [[ $(command -v eza) != "" ]]; then
    alias ll='eza -l'
    alias la='eza -la'
    alias lt='eza --tree --level 2'
fi

# bat
if [[ $(command -v bat) != "" ]]; then
    alias cat='bat -pP'
fi

# fzf
if [[ $(command -v fzf) != "" ]]; then
    # need to source these after the vi-mode plugin to avoid conflicts
    function zvm_after_init() {
        source <(fzf --zsh)
        bindkey -r '^G' # workaround to make fzf-git keybindings work 
        source $HOME/.config/fzf-git.sh/fzf-git.sh
    }

    # use fd instead of find if available
    if [[ $(command -v fd) != "" ]]; then
        export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

        _fzf_compgen_path() {
            fd --hidden --exclude .git . "$1"
        }

        _fzf_compgen_dir() {
            fd --type=d --hidden --exclude .git . "$1"
        }
    fi

fi

# neovim
if [[ $(command -v nvim) != "" ]]; then
    alias vim="nvim"
    alias vi="nvim"
    alias view='nvim -R'

    export EDITOR=nvim
    export VISUAL=nvim
    export MANPAGER="nvim +Man!"
fi

# git
alias gc='git commit'
alias gp="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"

# rust
if [[ $(command -v cargo) != "" ]]; then
    . ~/.cargo/env
    export RUSTC_WRAPPER=$(which sccache)
fi

# go
export PATH=$PATH:/usr/local/go/bin
if [[ $(command -v go) != "" ]]; then
    export GOPATH=$HOME/development/go/
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
