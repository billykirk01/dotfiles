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

# vi keybindings
bindkey -v

# local bin in path
export PATH="$HOME/.local/bin:$PATH"

# cursor to blinking block
print -Pn "\e[1 q"

# helper function to source the first readable file from a list
_zsh_source_first() {
    local f
    for f in "$@"; do
        [[ -r "$f" ]] && source "$f" && return 0
    done
    return 1
}

# Homebrew prefixes
_HB1="/opt/homebrew"      # apple silicon
_HB2="/usr/local"         # intel

# zsh-autosuggestions
_zsh_source_first \
    "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "$_HB1/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "$_HB2/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
_zsh_source_first \
    "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "$HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "$_HB1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "$_HB2/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unset -f _zsh_source_first
unset _HB1 _HB2

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

    source <(fzf --zsh)
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
alias gs='git status'
alias gc='git commit'
alias gp="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"

# rust
if [[ $(command -v cargo) != "" ]]; then
    source ~/.cargo/env

    # sccache
    if [[ $(command -v sccache) != "" ]]; then
        export RUSTC_WRAPPER=$(which sccache)
    fi
fi

# go
export PATH=$PATH:/usr/local/go/bin
if [[ $(command -v go) != "" ]]; then
    export GOPATH=$HOME/development/go/
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# daisy
if [[ $(command -v daisy) != "" ]]; then
    . <(daisy completion zsh)
fi

# nvm
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"

    if [[ -s "$NVM_DIR/bash_completion" ]]; then
        source "$NVM_DIR/bash_completion"  # works for zsh as well
    fi
fi

# starship
if [[ $(command -v starship) != "" ]]; then
    eval "$(starship init zsh)"
fi
