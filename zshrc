export NIXPKGS_ALLOW_UNFREE=1
export PATH=$HOME/.nix-profile/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

test -f "$ZSH/oh-my-zsh.sh" && source $ZSH/oh-my-zsh.sh

source $HOME/.dotfiles/customrc

if [[ -z $ZSH_INITALIZED ]]; then
  export ZSH_INITALIZED=1
  exec fish
fi
