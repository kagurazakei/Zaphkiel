{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "kureiji-ollie-cursor";
  src = fetchFromGitHub {
    repo = "kureiji-ollie-cursors";
    owner = "kagurazakei";
    rev = "a68837f6fb2bf30efb12b62f395e9897384cb9db";
    hash = "sha256-LzXB+FwaIsaO76Iv+rcnrNx4YiUpSzLxJvuKU83MMGA=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    cp -r Kureiji-Ollie-v2 $out/share/icons/ 
  '';
}
