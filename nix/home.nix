{ pkgs, config, ... }: {
  home.username = "tsukamoto";
  home.homeDirectory = "/Users/tsukamoto";
  home.stateVersion = "24.05";

  home.packages = import ./packages.nix { inherit pkgs; };

  xdg.configFile."ghostty/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/ghostty/config";

  programs.home-manager.enable = true;
}
