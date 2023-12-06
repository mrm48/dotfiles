update:
    nix flake update

upgrade:
    sudo nixos-rebuild switch --flake .#$(printf '%s' $HOSTNAME) && home-manager switch --flake .#$(printf '%s' $HOSTNAME)
