{
  description = "Language server for the Kernel configuration language used in Linux, U-boot, Zephyr, and coreboot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.stdenv.mkDerivation rec {
            pname = "kconfig-language-server";
            version = "1.0.1";

            src = pkgs.fetchFromGitHub {
              owner = "anakin4747";
              repo = pname;
              rev = version;
              sha256 = "sha256-c6GeIRMyXUkJ/Mffq0wM6ARVP3fLQdVLVVCvaLiqpqg=";
            };

            propagatedBuildInputs = with pkgs; [
              gawk
              gnused
              jq
              ripgrep
            ];

            dontBuild = true;

            installPhase = ''
              make install DESTDIR=$out PREFIX=
            '';

            meta = with pkgs.lib; {
              description = "Language server for the Kernel configuration language used in Linux, U-boot, Zephyr, and coreboot";
              homepage = "https://github.com/anakin4747/kconfig-language-server";
              license = licenses.gpl2;
              platforms = platforms.unix;
              maintainers = [ maintainers.anakin4747 ];
              mainProgram = pname;
            };
          };
        });
    };
}
