{ pkgs ? import <nixpkgs> {}
}:

let
  inherit (pkgs) stdenv lib fetchurl autoconf boost systemd libusb1;
in

stdenv.mkDerivation {
  pname = "mayu";
  version = "0.12.1";

  # 2020-05-27T11:11:23+09:00
  src = builtins.fetchTarball {
    name = "mayu-master";
    url = "https://github.com/kayhide/mayu/archive/7ab25efd45e6ed19951c2a2e3675329d0635471d.tar.gz";
    sha256 = "0p4idrqhk5zfbnr6647z77kf66kcy4q2ly3ibl6mikj6gnny7l50";
  };

  buildInputs = [ boost boost.out systemd libusb1 ];

  nativeBuildInputs = [ autoconf ];

  preConfigure = ''
    autoconf
  '';

  configureFlags = [
    "--with-boost=${boost.out}"
  ];
}
