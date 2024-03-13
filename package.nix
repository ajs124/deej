{ buildGoApplication
, pkg-config
, gtk3
, libappindicator-gtk3
, libayatana-appindicator
, webkitgtk }:

buildGoApplication rec {
  pname = "deej";
  version = "0.10.0";
  src = ./.;

  modules = ./gomod2nix.toml;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    gtk3
    libappindicator-gtk3
    libayatana-appindicator
    webkitgtk
  ];

  subPackages = [ "pkg/deej/cmd" ];

  postInstall = ''
    mv $out/bin/cmd $out/bin/${pname}
  '';
}
