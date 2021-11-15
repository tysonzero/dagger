self: super: {
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghc8107 = super.haskell.packages.ghc8107.override {
        overrides = import ./haskell/packages/ghc8107 self;
      };
      ghcjs810 = super.haskell.packages.ghcjs810.override {
        overrides = import ./haskell/packages/ghcjs810 self;
      };
    };
  };
}
