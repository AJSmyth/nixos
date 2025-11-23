{
  description = "Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
          inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    mysecrets = { url = "git+ssh://git@github.com/AJSmyth/nix-secrets"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... }@inputs: {
    nixosConfigurations = {
      # T480 - Acrid
      t480 = let
        username = "aj";
      in
        nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; inherit username; };
        system = "x86_64-linux";
        # The Nixpkgs module system provides the parameter imports, which
        # accepts a list of .nix files and merges all the configuration
        # defined in these files into the current Nix module.
        modules = [
          ./hosts/t480

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {inherit username;};
            home-manager.users.${username} = import ./users/${username}/home.nix;
          }
        ];
      };

      # T430 - Lemurian
      t430 = let
        username = "aj";
      in
        nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; inherit username; };
        system = "x86_64-linux";
        # The Nixpkgs module system provides the parameter imports, which
        # accepts a list of .nix files and merges all the configuration
        # defined in these files into the current Nix module.
        modules = [
          ./hosts/t430
          ./secrets

          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {inherit username;};
            home-manager.users.${username} = import ./users/${username}/home.nix;
          }
        ];
      };
    };
  };
}
