{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nixgl.url = "github:nix-community/nixGL";



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
    {
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosModules.default = {
        imports = [
          ./system
        ];
      };

      nixosConfigurations.PrimaryOS = nixpkgs.lib.nixosSystem {
        modules = [
          ./system
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
