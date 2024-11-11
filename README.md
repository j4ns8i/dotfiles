# dotfiles

Nix-based dotfiles and dev machine setup

# Requirements

## Nix

TODO

## Node

[Husky](https://typicode.github.io/husky/) is used to manage optional git hooks.
A [commitlint](https://commitlint.js.org/) git hook is used to standardize
commit message styling.

These can both be set up with:

```bash
$ pnpm i
```

# Usage

TODO

The guiding philosophy here is that changes made locally should be very easy and
safe to commit, otherwise divergence may creep in and conflict resolution
becomes a burden. For that reason, in most cases files or directories are
symlinked to this repo from their config locations (typically under
`$XDG_CONFIG_DIR`).
