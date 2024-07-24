{
  description = "kitty sessionizer flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "kitty-sessionizer";

      src = pkgs.fetchFromGitHub {
        repo = "kitty-sessionizer";
        owner = "mllac";
        rev = "1.0";

        hash = "sha256-c0F364rZpdPrwPNbsWDd3ZgeqQ9NbLuZlmrSj9JY4lc=";
      };

      buildInputs = [ pkgs.bash pkgs.subversion ];

      installPhase = ''
        mkdir -p $out/bin
        cp sessionizer.sh $out/bin/sessionizer.sh
        chmod +x $out/bin/sessionizer.sh
      '';

      meta = {
        platforms = pkgs.lib.platforms.linux;
        description = "kitty sessionizer";
        license = pkgs.lib.licenses.mit;
        mainProgram = "sessionizer.sh";
      };
    };
  };
}
