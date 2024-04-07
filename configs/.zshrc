# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# add to path $HOME/.local/bin/scripts
export PATH="$HOME/.local/bin/scripts:$PATH"

# Bind tmux-sessionizer to Ctrl-F
bindkey -s '^f' 'tmux-sessionizer\n's
bindkey -s '^g' 'tmux-sessionizer ~/.dotfiles\n's
# ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting aws docker docker-compose nvm rust fzf)
source $ZSH/oh-my-zsh.sh

# aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias code="flatpak run com.visualstudio.code"

# editor
EDITOR="nvim"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


function brightness() {
  displays=$(xrandr | grep " connected" | cut -f1 -d " ")
  displays=$(echo $displays | tr ' ' '\n' | fzf -m)

  for display in $displays; do
    echo "Setting brightness to $1 for $display"
    xrandr --output $display --brightness $1
  done
}
