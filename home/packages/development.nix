{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang-tools
    lua-language-server
    rust-analyzer
    python3
    rustc
    cargo
    gcc
    gradle
    jdk
    jdk21
    tree-sitter
    nodejs_22
    codex
    better-commits
    cmake
    inih
    gnumake
    openssl.dev
  ];
}
