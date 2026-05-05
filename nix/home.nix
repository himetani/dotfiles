{ pkgs, config, ... }: {
  home.username = "tsukamoto";
  home.homeDirectory = "/Users/tsukamoto";
  home.stateVersion = "24.05";

  home.packages = import ./packages.nix { inherit pkgs; };

  xdg.configFile."ghostty/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/ghostty/config";

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/starship.toml";

  home.file."Library/Fonts/JetBrainsMonoNerdFont".source = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts";
  home.file."Library/Fonts/NotoSansCJK".source = "${pkgs.noto-fonts-cjk-sans}/share/fonts/opentype/noto-cjk";

  programs.home-manager.enable = true;
}
