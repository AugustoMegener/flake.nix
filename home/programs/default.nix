{ ... }:

let
  inherit (builtins) attrNames filter match;
in {
  imports =
    map
      (fn: ./modules/${fn})
      (filter (fn: match ".*\\.nix" fn != null)
        (attrNames (builtins.readDir ./modules)));
}
