{
  lib,
  pkgs,
  stdenv,
  sources,
}:

stdenv.mkDerivation {
  pname = "zen-browser";
  version = "unstable";

  src = sources.zen-browser;

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpm
  ];

  buildPhase = ''
    pnpm install
    pnpm build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r dist/* $out/
  '';

  meta = with lib; {
    description = "Zen Browser";
    platforms = platforms.linux;
  };
}
