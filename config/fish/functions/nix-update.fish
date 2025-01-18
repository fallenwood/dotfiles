function nix-update --wraps='nix-channel --update && nix-env -irf /home/vbox/.env.nix' --description 'alias nix-update=nix-channel --update && nix-env -irf /home/vbox/.env.nix'
  nix-channel --update && nix-env -irf /home/vbox/.env.nix $argv
        
end
