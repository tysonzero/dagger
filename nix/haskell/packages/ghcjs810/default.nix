pkgs:
let
  source = import ../source.nix pkgs;
in
with pkgs.haskell.lib;
self: super:
{
  miso = self.callCabal2nix "miso" source.miso {};
  mkDerivation = args:
    super.mkDerivation (args // { doCheck = false; enableLibraryProfiling = false; });
  dagger = dontHaddock (disableExecutableProfiling (
    disableLibraryProfiling (self.callCabal2nix "dagger" source.dagger {})
  ));
  vector = self.callHackage "vector" "0.12.3.1" {};
}
