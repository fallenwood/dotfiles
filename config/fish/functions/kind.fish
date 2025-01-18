function kind --wraps="KIND_EXPERIMENTAL_PROVIDER=podman systemd-run --scope --user -p 'Delegate=yes'" --description "alias kind=KIND_EXPERIMENTAL_PROVIDER=podman systemd-run --scope --user -p 'Delegate=yes'"
  KIND_EXPERIMENTAL_PROVIDER=podman systemd-run --scope --user -p 'Delegate=yes' $argv
        
end
