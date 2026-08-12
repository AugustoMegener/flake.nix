
{ ... }:

let
  inherit (builtins) attrNames filter match;
in {
  imports =
    map
      (fn: ./styles/${fn})
      (filter (fn: match ".*\\.nix" fn != null)
        (attrNames (builtins.readDir ./styles)));
}
