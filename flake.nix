{
  description = "Edward Li Blog Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo
          ];

          shellHook = ''
            # Set custom environment variables for Powerlevel10k
            export P10K_CUSTOM_CONTEXT="Edward Li Blog"
            export P10K_CUSTOM_COLOR="208"  # Orange color (ANSI color code)

            # Source your zsh configuration
            if [ -f ~/.zshrc ]; then
              export ZDOTDIR=$HOME
              export SHELL=${pkgs.zsh}/bin/zsh
              exec $SHELL -i
            else
              echo "Warning: ~/.zshrc not found."
            fi
          '';
        };
      }
    );
}
