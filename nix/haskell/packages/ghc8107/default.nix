pkgs:
let
  source = import ../source.nix pkgs;
in
with pkgs.haskell.lib;
self: super:
{
  miso = self.callCabal2nix "miso" source.miso {};
  dagger = disableExecutableProfiling (
    disableLibraryProfiling (self.callCabal2nix "dagger" source.dagger {})
  );
}
