{ lib, stdenv, makeWrapper
, coreutils
, i3lock-color
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
      --prefix PATH : ${i3lock-color}/bin
  '';
  meta = with lib; {
    description = "i3lock is a bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text.";
    homepage = "https://github.com/meskarune/i3lock-fancy";
    maintainers = with maintainers; [ ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
