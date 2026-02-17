{
  description = "MTKClient Live Boot (x86_64)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        mtkclientIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit pkgs-unstable inputs; };
    
          modules = [
            ./configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager ={
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "mv -f \"$1\" \"$1.$(date +%s).bak\"";
              users.mtkclient = import ./home.nix;
              extraSpecialArgs = {
                inherit pkgs-unstable inputs;
              };

            };
          }
          ];
        };
      };

    };

}
