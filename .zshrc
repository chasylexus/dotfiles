# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# What OS are we running?
if [[ $(uname) == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    autoload -Uz compinit
    compinit
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
ln -sf $(gpgconf --list-dirs agent-ssh-socket) ~/.ssh/gpg.sock
gpgconf --launch gpg-agent


export LANG=ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8
export EDITOR=$(which nano)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

alias history="history 1"
alias icat="kitten icat"
alias ssh="kitty +kitten ssh"
alias mon="bpytop"


source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


SAVEHIST=999999999999  # Save most-recent 999999999999 lines
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"
