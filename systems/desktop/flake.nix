{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    bolcshell.url = "github:AugustoMegener/bolcshell"; 

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };
  outputs =
    inputs@{ home-manager, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {

      homeModules.default = { pkgs, ... }: {
        imports = [ ./config ];
        home.packages = [ 
          inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
          inputs.bolcshell.packages.${pkgs.stdenv.hostPlatform.system}.default 
        ];
      };

      homeConfigurations = forAllSystems (
          system:
          home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./config
          ];
        }
      );
    };
}
