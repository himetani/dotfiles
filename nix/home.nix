{ pkgs, config, ... }:
{
  imports = [ ./tmux.nix ];
  home.username = "tsukamoto";
  home.homeDirectory = "/Users/tsukamoto";
  home.stateVersion = "24.05";

  home.packages = import ./packages.nix { inherit pkgs; };

  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/zshrc";

  home.file.".tigrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/tigrc";

  home.file.".gitconfig".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/gitconfig";

  home.file."git/private/gitconfig".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/gitconfig-private";

  home.file.".taplo.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/taplo.toml";

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nvim";

  xdg.configFile."ghostty/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/ghostty/config";

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/starship.toml";

  home.file."Library/Fonts/JetBrainsMonoNerdFont".source = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts";
  home.file."Library/Fonts/NotoSansCJK".source = "${pkgs.noto-fonts-cjk-sans}/share/fonts/opentype/noto-cjk";

  programs.home-manager.enable = true;
}
