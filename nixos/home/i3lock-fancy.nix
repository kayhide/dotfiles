{ stdenv, fetchFromGitHub, makeWrapper
, coreutils
, fontconfig
, gawk
, getopt
, gnused
, i3lock-color
, imagemagick
, scrot
, xrandr
}:

stdenv.mkDerivation rec {
  rev = "a13e5283e03674acd59d835b920ccf0c07cf248e";
  name = "i3lock-fancy-multi-monitor-2020-06-09_rev${builtins.substring 0 7 rev}";
  src = fetchFromGitHub {
    owner = "kayhide";
    repo = "i3lock-fancy";
    inherit rev;
    sha256 = "04mkq52qsmv1rncqcmfl7m0l93mi0n1vg95zj84nxbk94pb8cakq";
  };

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
  meta = with stdenv.lib; {
    description = "i3lock is a bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text.";
    homepage = "https://github.com/meskarune/i3lock-fancy";
    maintainers = with maintainers; [ ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
