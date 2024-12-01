{
  description = "A flake to develop AoC";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    flake-utils.url = "github:numtide/flake-utils/main";
  };


  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        apps.cabal-update = let
          cabal-update = pkgs.writeShellApplication {
            name = "cabal-update";
            runtimeInputs = [
	      pkgs.cabal-install
	      pkgs.ghc
            ];
            update = ''
	    cabal update
	    '';
          };
        in {
          type = "app";
          program = "${cabal-update}/bin/cabal-update";
        };
        apps.cabal-test = let
          cabal-test = pkgs.writeShellApplication {
            name = "cabal-test";
            runtimeInputs = [
              pkgs.haskellPackages.hspec-discover
	      pkgs.cabal-install
	      pkgs.ghc
            ];
            text = ''
	    cabal test --enable-tests --test-show-details=direct
	    '';
          };
        in {
          type = "app";
          program = "${cabal-test}/bin/cabal-test";
        };
        apps.repl = let
          repl = pkgs.writeShellApplication {
            name = "repl";
            runtimeInputs = [
	      pkgs.cabal-install
	      pkgs.ghcid
            ];
            text = ''
	    ghcid -c "cabal repl aoc"
	    '';
          };
        in {
          type = "app";
          program = "${repl}/bin/repl";
        };

        apps.lint = let
          lint = pkgs.writeShellApplication {
            name = "lint";
            runtimeInputs = [
              pkgs.hlint
              pkgs.stylish-haskell
            ];
            text = ''
	    stylish-haskell -r .
	    hlint --git
	    '';
          };
        in {
          type = "app";
          program = "${lint}/bin/lint";
        };

        devShells.default = pkgs.mkShell{ 
          buildInputs = [
            pkgs.hlint
            pkgs.stylish-haskell
	    pkgs.cabal-install
	    pkgs.ghc
            pkgs.haskellPackages.hspec-discover
	    pkgs.nodejs_22 # because copilot
          ];
        };
      });
}
