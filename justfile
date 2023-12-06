update:
    nix flake update

upgrade:
    sudo nixos-rebuild switch --flake .#ankh && home-manager switch --flake .#matt

upgrade trinsic:
    sudo nixos-rebuild switch --flake .#trinsic && home-manager switch --flake .#trinsic
