{ pkgs, stdenv
, cmakeFlags ? ""
, isStatic ? false
, buildPkgs ? pkgs
, ... }:

let
  hostPkgs = if isStatic then pkgs.pkgsStatic else pkgs;
in hostPkgs.stdenv.mkDerivation {
  inherit cmakeFlags;

  name = "aasdk";
  src = ./.;

  nativeBuildInputs = with buildPkgs;
  [ cmake
    git
  ];

  propagatedBuildInputs = with hostPkgs;
  [ libusb
    protobuf
  ];

  buildInputs = with hostPkgs;
  [ boost168
    openssl_1_1
  ];
}
