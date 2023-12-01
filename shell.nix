{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {}
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cabal-install
    ghc
  ];
  LC_ALL = "C.UTF-8";
}

