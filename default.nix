let
  pkgs = import ./nix;
in with pkgs.haskell.packages.ghcjs810;
  pkgs.stdenv.mkDerivation {
    name = "dagger";
    inherit (dagger) src;
    buildCommand = ''
      mkdir $out
      ${pkgs.closurecompiler}/bin/closure-compiler \
        --compilation_level ADVANCED_OPTIMIZATIONS \
        --jscomp_off=checkVars \
        --externs=${dagger}/bin/dagger-js.jsexe/all.js.externs \
        ${dagger}/bin/dagger-js.jsexe/all.js > $out/all.js
    '';
  }
