update:
    nix flake update

upgrade:
    sudo nixos-rebuild switch --flake .#$(printf '%s' $HOSTNAME) && home-manager switch --flake .#$(printf '%s' $HOSTNAME)

cleanup:
    sudo nix-collect-garbage --delete-older-than 15d
