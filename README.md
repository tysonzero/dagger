# dagger
Visual IPLD DAG editor

## build
* GHC
  * `nix-shell`
  * `cabal repl`
  * `Dagger.Main.main`
  * go to `localhost:3758`
* GHCJS
  * `nix-build`
  * `cat result/all.js > static/script.js`
  * `open static/index.html`
