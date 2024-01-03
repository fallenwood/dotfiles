export NIXPKGS_ALLOW_UNFREE=1
export PATH=$HOME/.nix-profile/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

test -f "$ZSH/oh-my-bash.sh" && source $ZSH/oh-my-bash.sh

source $HOME/.dotfiles/customrc
