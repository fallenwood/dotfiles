export NIXPKGS_ALLOW_UNFREE=1
export PATH=$HOME/.nix-profile/bin:$PATH
source $HOME/.dotfiles/customrc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
