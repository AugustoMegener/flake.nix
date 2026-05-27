{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";

    gradle-nvim = {
      url = "github:oclay1st/gradle.nvim";
      flake = false;
    };

    nvim-dap-kotlin = {
      url = "github:Mgenuit/nvim-dap-kotlin";
      flake = false;
    };

    kotlin-nvim = {
      url = "github:AlexandrosAlexiou/kotlin.nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      nixvim,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs { inherit system; };
          nixvimLib = nixvim.lib.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;
        in
        {
          checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;

          packages.default = nvim;

          apps.default = {
            type = "app";
            program = "${nvim}/bin/nvim";
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
