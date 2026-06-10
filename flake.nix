{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = username: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "1password-cli"
              "databricks-cli"
            ];
        };
        extraSpecialArgs = { inherit username; };
        modules = [ ./nix/home.nix ];
      };
    in {
      homeConfigurations = {
        # private machine
        "tsukamoto" = mkHome "tsukamoto";
        # work machine
        "ttsukamoto" = mkHome "ttsukamoto";
      };
    };
}
