{
  lib,
  stdenv,
  mpv,
  makeWrapper,
  writeShellScriptBin,
}:

let
  wrappedMpv = writeShellScriptBin "mpv" ''
    export __NV_PRIME_RENDER_OFFLOAD=0  # Force Intel GPU
    exec ${mpv}/bin/mpv \
      --gpu-context=wayland \
      --vo=gpu \
      --hwdec=no \
      "$@"
  '';
in
stdenv.mkDerivation {
  pname = "mpv-wrapped";
  version = mpv.version;
  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/share/applications $out/share/icons

    # Install wrapped mpv
    ln -s ${wrappedMpv}/bin/mpv $out/bin/mpv

    # Install and patch desktop file
    cp ${mpv}/share/applications/mpv.desktop \
       $out/share/applications/mpv.desktop

    substituteInPlace $out/share/applications/mpv.desktop \
      --replace "Exec=mpv" "Exec=$out/bin/mpv" \
      --replace "TryExec=mpv" "TryExec=$out/bin/mpv"

    # Install icons if present
    if [ -d ${mpv}/share/icons ]; then
      cp -r ${mpv}/share/icons/* $out/share/icons/
    fi
  '';

  meta = with lib; {
    description = "mpv wrapped to force Intel GPU and custom Wayland options";
    homepage = "https://mpv.io";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    mainProgram = "mpv";
  };
}
