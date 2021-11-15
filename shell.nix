with (import ./nix);
with pkgs.lib;
let
  dagger = pkgs.haskell.packages.ghc8107.dagger;
  deps = dagger.getBuildInputs.haskellBuildInputs;
  filteredDeps = filter (x: x != dagger) deps;
  inputs = pkgs.haskell.packages.ghc8107.ghcWithHoogle (p: filteredDeps);
  shell = pkgs.stdenv.mkDerivation {
    name = "shell";
    buildInputs = with pkgs; [ inputs cabal-install ];
  };
in
  shell
