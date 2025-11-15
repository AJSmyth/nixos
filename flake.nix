{
  description = "Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
          inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      lemurian = let
	username = "aj";
        specialArgs = {inherit username;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./hosts/t430
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    };
  };
}
