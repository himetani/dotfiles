{ pkgs }: with pkgs; [
  # Fonts
  nerd-fonts.jetbrains-mono
  noto-fonts-cjk-sans

  # Shell
  starship
  zsh-autosuggestions
  direnv
  fzf

  # CLI tools
  mise
  git
  git-extras
  tig
  htop
  tree
  fd
  jq
  ripgrep
  nkf
  gnused
  ninja
  kubectl
  ngrok
  _1password-cli

  # Editor
  neovim
  universal-ctags

  # Language-agnostic LSP
  lua-language-server
  bash-language-server
]
