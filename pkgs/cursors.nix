{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "cursors";
  src = fetchFromGitHub {
    repo = "kureiji-ollie-cursors";
    owner = "kagurazakei";
    rev = "1hrn5zihlyvg3ydk9zgmxrpj4czhnmhkxi9wwhfkgini42kjh8nv";
    hash = "sha256-ts43WiDBT5xG9TSdocvBx150oboEZhqtSI13Exr8CWQ=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    cp -r cursors/Kureiji-Ollie-v2 $out/share/icons/ 
  '';
}
