{ buildGoApplication
, pkg-config
, pcre
, buildType ? "release" }:

buildGoApplication rec {
  pname = "deej";
  version = "0.10.0";
  src = ./.;
  pwd = ./.;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    pcre
  ];

  subPackages = [ "pkg/deej/cmd" ];

  ldflags = [
    "-X main.buildType=${buildType}"
  ];

  postInstall = ''
    mv $out/bin/cmd $out/bin/${pname}
  '';
}
