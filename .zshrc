# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


eval "$($(brew --prefix)/bin/brew shellenv)"
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
ln -sf $(gpgconf --list-dirs agent-ssh-socket) ~/.ssh/gpg.sock
gpgconf --launch gpg-agent

alias icat="kitten icat"
alias ssh="kitty +kitten ssh"
alias mon="bpytop"

export PYENV_ROOT="$HOME/.pyenv"
export LANG=en_US.UTF-8

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
