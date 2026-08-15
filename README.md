# dotfiles

macOS dotfiles managed with [chezmoi](https://www.chezmoi.io/).
Packages are managed with Homebrew Bundle and tmux plugins with TPM. Nix and
home-manager are not used.

## Where a tool belongs

Every tool sits in one of three layers, and each layer has a single place where
it is declared.

| Layer | Declared in | Scope |
| --- | --- | --- |
| System foundation | `Brewfile` | Global; available in any directory |
| Editor toolchain | `dot_config/nvim/lazyvim.json` and `dot_config/nvim/lua/plugins/mason.lua` | Neovim only; Mason keeps these off the global `PATH` |
| Language runtimes | each project's own `mise.toml` | One project |

A tool belongs in the `Brewfile` only when it has to work regardless of the
current directory and needs no per-project version. Language servers, formatters
and linters are editor tooling, so they go to Mason instead.

Mason packages must be self-contained binaries. Packages from the npm and pypi
backends need a runtime that Mason does not manage, and language servers start
even outside a project directory, so that runtime would have to be installed
globally. Keeping the Mason set runtime-free is what allows the global
environment to stay minimal.

## Initial setup

Install Homebrew first, then set up chezmoi and this repository.

```sh
brew install chezmoi
git clone git@github.com:himetani/dotfiles.git "$HOME/git/dotfiles"
chezmoi init --source="$HOME/git/dotfiles"
chezmoi diff
chezmoi apply
```

`chezmoi apply` also performs the following:

- Applies the contents of `Brewfile` with `brew bundle`
- Fetches TPM and installs the tmux plugins
- Places the dotfiles into the home directory

If the repository is already cloned, run only the steps from `brew install chezmoi`
onwards.

## Routine maintenance

The source state lives in `$HOME/git/dotfiles`. Edit the repository, review the
diff, then apply it.

```sh
chezmoi diff
chezmoi apply
```

When a file is changed in the home directory instead, bring it back into chezmoi
before committing.

```sh
chezmoi re-add ~/.zshrc
chezmoi diff
```

To add or remove a package, edit `Brewfile`. To change tmux plugins, edit the
`@plugin` lines in `dot_config/tmux/tmux.conf`. The corresponding run scripts are
re-executed only when their input files change.

## Keeping Homebrew current

Homebrew is a rolling release and
[deliberately has no lockfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile), so
the `Brewfile` cannot pin versions and there is no version state for chezmoi to
apply. Staying current is only a matter of running `brew upgrade` often enough.

`chezmoi apply` therefore offers to run it, at most once a week:

```
Homebrew was last upgraded 9 days ago. Upgrade now? [y/N]
```

Declining postpones the question rather than dismissing it, so the prompt does
not reappear on every apply. The interval is `INTERVAL_DAYS` in
`run_after_30-brew-upgrade.sh`, and the last answer is recorded in
`~/.local/state/chezmoi/brew-upgrade-last`. The prompt is skipped when chezmoi
runs without a terminal.

Pulling and applying in one step, which is where this prompt usually appears:

```sh
chezmoi update
```

Upgrading by hand at any other time is fine and needs no coordination: there is
no central version state to drift from.

## Verification

```sh
chezmoi doctor
chezmoi managed
chezmoi diff
brew bundle check --file="$HOME/git/dotfiles/Brewfile"
tmux -f "$HOME/.config/tmux/tmux.conf" start-server \; show-options -g >/dev/null
```

The chezmoi source state and the home directory are separate. As a rule, have AI
coding agents edit this repository, then review `chezmoi diff` before running
`chezmoi apply`.
