{ lib, stdenv, fetchFromGitHub, makeWrapper
, coreutils
, fontconfig
, gawk
, getopt
, gnused
, i3lock-color
, imagemagick
, scrot
, xrandr
, sources ? import ../sources.nix
}:

stdenv.mkDerivation rec {
  pname = "i3lock-fancy";
  version = "${sources.i3lock-fancy.branch}-rev${builtins.substring 0 7 src.rev}";
  src = sources.i3lock-fancy;

  buildInputs = [ makeWrapper ];

  patchPhase = ''
    rm Makefile
  '';
  installPhase = ''
    mkdir -p $out/bin $out/share/i3lock-fancy/icons
    cp i3lock-fancy $out/bin
    cp icons/lock*.png $out/share/i3lock-fancy/icons

    wrapProgram $out/bin/i3lock-fancy \
      --argv0 i3lock-fancy \
      --set i3lock_cmd i3lock-color \
      --set data_dir $out/share/i3lock-fancy \
      --prefix PATH : ${coreutils}/bin \
      --prefix PATH : ${fontconfig}/bin \
      --prefix PATH : ${gawk}/bin \
      --prefix PATH : ${getopt}/bin \
      --prefix PATH : ${gnused}/bin \
      --prefix PATH : ${i3lock-color}/bin \
      --prefix PATH : ${imagemagick}/bin \
      --prefix PATH : ${scrot}/bin \
      --prefix PATH : ${xrandr}/bin
  '';
  meta = with lib; {
    description = "i3lock is a bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text.";
    homepage = "https://github.com/meskarune/i3lock-fancy";
    maintainers = with maintainers; [ ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
