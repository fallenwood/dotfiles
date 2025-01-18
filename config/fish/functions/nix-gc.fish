function nix-gc --wraps='nix-collect-garbage -d' --description 'alias nix-gc=nix-collect-garbage -d'
  nix-collect-garbage -d $argv
        
end
