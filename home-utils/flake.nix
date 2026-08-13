{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";

    desktop = {
      url = "github:AugustoMegener/comra-de";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    bolcheflow = {
      url = "github:AugustoMegener/bolcheflow";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs =
    inputs@{ home-manager, nixpkgs, desktop, bolcheflow, ... }:
    let
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {

      homeModules.default = { pkgs, ... }: {
        imports = [ 
          ./programs
          inputs.desktop.homeModules.default
          inputs.bolcheflow.homeModules.default
        ];
      };

      homeConfigurations = forAllSystems (
          system:
          home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = { inherit inputs; };

            home.stateVersion = "25.05";
            home.sessionVariables.TERMINAL = "kitty";

            modules = [
              ./programs
              inputs.desktop.homeModules.default
              inputs.bolcheflow.homeModules.default
            ];
          }
      );
    };
}
