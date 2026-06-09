# dotfiles

Managed with [home-manager](https://github.com/nix-community/home-manager) (flake).

Replace `<username>` below with the target machine's username
(`homeConfigurations` defined in [flake.nix](flake.nix)).

## Apply

```bash
nix run home-manager -- switch --flake .#<username>
```

## Verify without applying

```bash
nix build --no-link .#homeConfigurations.<username>.activationPackage
```
