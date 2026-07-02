{ ... }:

let
  inherit (builtins) attrNames filter match;
in {
  imports =
    map
      (fn: ./items/${fn})
      (filter (fn: match ".*\\.nix" fn != null)
        (attrNames (builtins.readDir ./items)));
}
