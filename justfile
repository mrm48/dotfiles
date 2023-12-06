update:
    nix flake update

upgrade:
    sudo nixos-rebuild switch --flake .#ankh && home-manager switch --flake .#matt
