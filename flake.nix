{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    elephant.url = "github:abenz1267/elephant";
    nixgl.url = "github:nix-community/nixGL";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    astal.url = "github:aylur/astal";

    hyprland-config = {
      url = "path:./systems/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flashpoint = {
      url = "path:./flakes/flashpoint";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    veadotube-mini = {
      url = "path:./flakes/veadotube-mini";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    bolchevim.url = "github:AugustoMegener/bolchevim"; 

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      elephant,
      walker,
      astal,
      nixgl,
      hyprland-config,
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

          ./configuration.nix
          ./sys-configs
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
            disabledModules = [ "services/misc/elephant.nix" ];
          }
          walker.nixosModules.default
          {
            nix.settings = {
              extra-substituters = [
                "https://walker.cachix.org"
                "https://walker-git.cachix.org"
              ];
              extra-trusted-public-keys = [
                "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
                "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
              ];
            };
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
