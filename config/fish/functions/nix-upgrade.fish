function nix-upgrade --wraps='nix-channel --update && nix-env -uf /home/vbox/.env.nix' --description 'alias nix-upgrade=nix-channel --update && nix-env -uf /home/vbox/.env.nix'
  nix-channel --update && nix-env -uf /home/vbox/.env.nix $argv
        
end
