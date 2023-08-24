{ description = "Android Auto server framework";

  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;

  outputs = { self, nixpkgs, ... }:
  let callpkg = pkgs: as: pkgs.callPackage ./default.nix as;
  in
    { packages.x86_64-linux.default =
        callpkg (import nixpkgs {
          system = "x86_64-linux";
          config.permittedInsecurePackages = ["openssl-1.1.1v"];
        }) {};
      packages.aarch64-linux.default =
        let pkgs = (import nixpkgs {
            system = "x86_64-linux";
            config.permittedInsecurePackages = ["openssl-1.1.1v"];
          });
        in callpkg pkgs.pkgsCross.aarch64-android-prebuilt
        { cmakeFlags = [ "-DBoost_USE_STATIC_LIBS=ON" "-DBoost_USE_STATIC_RUNTIME=ON" ];
          isStatic = true;
          buildPkgs = pkgs;
        };
    };
}
