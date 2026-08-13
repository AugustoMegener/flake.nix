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
      nixpkgs,
      home-manager,
      sops-nix,
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
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
