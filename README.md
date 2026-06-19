# dotfiles

Nix-based dotfiles and dev machine setup

The guiding philosophy here is that changes made locally should be very easy and
safe to commit, otherwise divergence may creep in and conflict resolution
becomes a burden. For that reason, in most cases files or directories are
symlinked to this repo from their config locations (typically under
`$XDG_CONFIG_DIR`).

## Requirements

### NixOS

* [NixOS](https://nixos.org/download/)

```
$ sudo nixos-rebuild switch --flake <dotfiles>
```

### MacOS

* [Nix (Determinate Systems)](https://determinate.systems/nix-installer/)
* [nix-darwin](https://github.com/nix-darwin/nix-darwin)

```
$ sudo darwin-rebuild switch --flake <dotfiles>
```
