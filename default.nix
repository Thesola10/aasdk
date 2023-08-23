{ pkgs, stdenv, ... }:

stdenv.mkDerivation {
  name = "aasdk";
  src = ./.;

  nativeBuildInputs = with pkgs;
  [ cmake
    git
  ];

  propagatedBuildInputs = with pkgs;
  [ libusb
    protobuf
  ];

  buildInputs = with pkgs;
  [ boost168
    openssl_1_1
  ];
}
