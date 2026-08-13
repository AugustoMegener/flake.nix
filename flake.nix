{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixgl.url = "github:nix-community/nixGL";

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

    sops-nix.url = "github:Mic92/sops-nix";
    audiorelay.url = "github:AugustoMegener/audiorelay-flake";

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

    bolchevim.url = "github:AugustoMegener/bolchevim"; 


    home-utils = {
      url = "path:AugustoMegener/home-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flashpoint = {
      url = "github:AugustoMegener/flashpoint-archive-flake";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    veadotube-mini = {
      url = "github:AugustoMegener/veadotube-mini-flake";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      nixgl,
      desktop,
      bolcheflow,
      hytale-launcher,
      flashpoint,
      veadotube-mini,
      sops-nix,
      ...
    }@inputs:
    {
      nixosConfigurations.PrimaryOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system
          ./hardware-configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              sops-nix.homeManagerModules.sops
            ];
            home-manager.users.kito = import ./home;
          }
          {
            nixpkgs.overlays = [
              nixgl.overlay
            ];
            environment.systemPackages = [
              nixgl.packages.x86_64-linux.nixGLIntel
            ];
          }
        ];
      };
    };
}
