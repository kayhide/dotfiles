{ stdenv, fetchFromGitHub, coreutils, scrot, imagemagick, gawk
, i3lock-color, getopt, fontconfig, xrandr
}:

stdenv.mkDerivation rec {
  rev = "339970d66a945467b3b22476803e768de8caa933";
  name = "i3lock-fancy-multi-monitor-2020-06-04_rev${builtins.substring 0 7 rev}";
  src = fetchFromGitHub {
    owner = "kayhide";
    repo = "i3lock-fancy";
    inherit rev;
    sha256 = "1vxm9228rq5dc5j0pbjkasvpc4fw9l4mnq15359k4yx35l5pv8sj";
  };

  patchPhase = ''
    sed -i -e "s|mktemp|${coreutils}/bin/mktemp|" i3lock-fancy
    sed -i -e "s|'rm -f |'${coreutils}/bin/rm -f |" i3lock-fancy
    sed -i -e "s|scrot -z |${scrot}/bin/scrot -z |" i3lock-fancy
    sed -i -e "s|convert |${imagemagick.out}/bin/convert |" i3lock-fancy
    sed -i -e "s|awk -F|${gawk}/bin/awk -F|" i3lock-fancy
    sed -i -e "s| awk | ${gawk}/bin/awk |" i3lock-fancy
    sed -i -e "s|i3lock -i |${i3lock-color}/bin/i3lock-color -i |" i3lock-fancy
    sed -i -e 's|icon="/usr/share/i3lock-fancy/icons/lockdark.png"|icon="'$out'/share/i3lock-fancy/icons/lockdark.png"|' i3lock-fancy
    sed -i -e 's|icon="/usr/share/i3lock-fancy/icons/lock.png"|icon="'$out'/share/i3lock-fancy/icons/lock.png"|' i3lock-fancy
    sed -i -e "s|getopt |${getopt}/bin/getopt |" i3lock-fancy
    sed -i -e "s|fc-match |${fontconfig.bin}/bin/fc-match |" i3lock-fancy
    sed -i -e "s|shot=(import -window root)|shot=(${scrot}/bin/scrot -z -o)|" i3lock-fancy
    sed -i -e "s|xrandr --listmonitors|${xrandr}/bin/xrandr --listmonitors|" i3lock-fancy
    rm Makefile
  '';
  installPhase = ''
    mkdir -p $out/bin $out/share/i3lock-fancy/icons
    cp i3lock-fancy $out/bin/i3lock-fancy
    cp icons/lock*.png $out/share/i3lock-fancy/icons
  '';
  meta = with stdenv.lib; {
    description = "i3lock is a bash script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text.";
    homepage = "https://github.com/meskarune/i3lock-fancy";
    maintainers = with maintainers; [ ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
