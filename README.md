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

Answering yes hands the terminal to `brew`, which lists what it is about to
change and asks for its own confirmation, so nothing is upgraded without being
shown first. An upgrade that fails or is declined there does not fail the apply.

Declining postpones the question rather than dismissing it, so the prompt does
not reappear on every apply. The interval is `INTERVAL_DAYS` in
`run_after_30-brew-upgrade-prompt.sh`, and the last answer is recorded in
`~/.local/state/chezmoi/brew-upgrade-last`. The prompt is skipped when chezmoi
runs without a terminal.

Pulling and applying in one step, which is where this prompt usually appears:

```sh
chezmoi update
```

Upgrading by hand at any other time is fine and needs no coordination: there is
no central version state to drift from.

### Holding a package back

Homebrew has no supported way to downgrade. Old versions are deleted from the
Cellar automatically after every upgrade, `brew switch` no longer exists, and the
remaining route is `brew extract --version=` into a personal tap followed by a
build from source. A package that must not move therefore has to be held back
*before* it is upgraded, not restored afterwards.

```sh
brew pin neovim
```

A pinned package is skipped by both `brew upgrade` and `brew bundle install`, so
the prompt above will leave it alone.

```sh
brew list --pinned
brew unpin neovim
```

Pins are machine-local and are not recorded in this repository, which is what
makes them the right tool for "not on this machine yet" and the wrong one for a
decision that should apply everywhere. Note that pinning a package other
formulae depend on can keep those from installing or running correctly.

## Updating Neovim plugins

Plugin versions are decided in CI, not on each machine. A weekly workflow runs
`Lazy! sync` on a macOS runner, checks that the result still works, and opens a
pull request containing only the new `lazy-lock.json`. Merging it is what makes
an update real, and reverting that commit is what undoes one.

Applying the merged lockfile writes the file; the run script then moves the
installed plugins onto it, because lazy.nvim installs what is missing on the
next start but does not move existing plugins to match a lockfile that changed
underneath it.

```sh
chezmoi update
```

lazy.nvim's own update checker is off, so Neovim never reports that plugins are
out of date: that is the workflow's job, and a second way to update would only
produce changes nothing records. Updating locally with `:Lazy update` still
works but drifts from the lockfile, and the next apply restores the file without
moving the plugins back. Run `:Lazy restore` to return to the locked revisions.

The workflow can also be started by hand from the Actions tab, which is the way
to pick up an update without waiting for Monday.

### What the check actually checks

The workflow opens a Lua buffer and requires an LSP client to attach. That
exercises lazy.nvim, mason and lspconfig together.

It is deliberately not a search for error messages. lazy.nvim catches failures
and reports them through `vim.notify`, which does nothing in a headless session,
so a config with a Lua syntax error or a plugin whose `opts` throw still starts
silently and exits 0 with nothing on stderr or in `:messages`. Asserting on a
working LSP client was verified to fail when the configuration is broken.

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
