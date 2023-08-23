{
  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;

  outputs = { self, nixpkgs, ... }: {
    packages.x86_64-linux.default = (import nixpkgs { system = "x86_64-linux"; config.permittedInsecurePackages = ["openssl-1.1.1v"]; }).callPackage ./default.nix {};
  };
}
