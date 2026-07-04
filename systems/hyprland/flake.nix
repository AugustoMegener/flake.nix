{
  description = "Standalone Home Manager Hyprland configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    bolcshell.url = "github:AugustoMegener/bolcshell"; 
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
      home.packages = [ inputs.bolcshell.packages.${pkgs.system}.default ];
    };

    homeConfigurations = forAllSystems (
        system:
        home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        extraSpecialArgs = { inherit inputs; };


        modules = [
          ./config
          {
            home.username = "kito";
            home.homeDirectory = "/home/kito";
            home.stateVersion = "25.05";
          }
        ];
      }
    );
  };
}
