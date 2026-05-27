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
    ags.url = "github:aylur/ags";

    hyprland-config = {
      url = "path:./systems/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";
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
      ags,
      nixgl,
      hyprland-config,
      hytale-launcher,
      ...
    }@inputs:
    {
      nixosConfigurations.PrimaryOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kito = import ./home/manager.nix;
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
