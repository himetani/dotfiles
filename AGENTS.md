# Repository guidance

## Purpose and scope

This repository is the chezmoi source state for macOS dotfiles. Maintain it with
chezmoi and Homebrew. Do not reintroduce Nix, flakes, or home-manager.

Unless the user explicitly asks, do not opportunistically clean up or redesign
the existing shell, Neovim, Git, Ghostty, starship, tig, or tmux settings. Keep
changes limited to the requested configuration or to the mechanics required for
chezmoi to apply it.

## Source layout

- `dot_*` and `dot_config/*` map to files below the target user's home directory.
- `Brewfile` is the declarative package list and is excluded from the target by
  `.chezmoiignore`.
- `.chezmoiexternal.toml` installs TPM.
- `run_onchange_before_10-brew-bundle.sh.tmpl` applies package changes.
- `run_onchange_after_20-install-tmux-plugins.sh.tmpl` applies tmux plugin changes.

Edit the source files in this repository. Do not edit generated files in `$HOME`
and copy them back unless the task specifically concerns importing local state.

## Verification

After a change, run the narrowest relevant syntax check, then run:

```sh
chezmoi managed
chezmoi diff
```

For package changes, also run:

```sh
brew bundle check --file="$(chezmoi source-path)/Brewfile"
```

For tmux changes, apply to a temporary destination or run tmux's config parser
without attaching a session. Never run `chezmoi apply` when the user requested
only a review or diagnosis, because apply changes the user's home directory and
may install packages.
