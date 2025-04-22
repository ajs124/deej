{ buildGoApplication
, go_1_23
, pkg-config
, pcre
, buildType ? "release" }:

buildGoApplication rec {
  pname = "deej";
  version = "0.10.0";
  src = ./.;
  pwd = ./.;

  go = go_1_23;

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
