{ pkgs, ... }:
let
  fuzzel-clip = pkgs.writeScriptBin "fuzzel-clip" (builtins.readFile ./fuzzel-clip.sh);
  rxfetch = pkgs.writeScriptBin "rxfetch" (builtins.readFile ./rxfetch.sh);
in
{
  environment.systemPackages = [
    fuzzel-clip
    rxfetch
  ];
}
