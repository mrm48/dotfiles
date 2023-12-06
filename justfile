update:
    nix flake update

trinsic:
    sudo nixos-rebuild switch --flake .#$(printf '%s' $HOSTNAME) && home-manager switch --flake .#$(printf '%s' $HOSTNAME)
