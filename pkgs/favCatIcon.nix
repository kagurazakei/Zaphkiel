{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "catFavIcon";
  src = fetchFromGitHub {
    repo = "Catppuccin-SE";
    owner = "kagurazakei";
    rev = "0irwds6i6x927x0kg1vikgxrlhlc0nmygs6kyii4iyncfsdbciph";
    hash = "sha256-BEtPrAQU8HdTZ45tWR/i3vMWtJDuQ8mgoYE1D3EEhiw=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    cp -r catFavIcon/Catppuccin-SE $out/share/icons/
  '';
}
