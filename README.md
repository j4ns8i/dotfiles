# dotfiles

Ansible-based dotfiles and dev machine setup

# Requirements

## Ansible

[Poetry](https://python-poetry.org/) is used to manage Python dependencies for
using Ansible. To minimize dependencies, only ansible-core is installed via
Poetry, and any other collections are installed using
[ansible-galaxy](https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html);
see the requirements.yml file for which collections are needed.

In general, most dependencies can be installed with:

```bash
$ make deps
```

For convenience while bootstrapping with pip, a requirements.txt file is
exported via Poetry.

## Node

[Husky](https://typicode.github.io/husky/) is used to manage optional git hooks.
A [commitlint](https://commitlint.js.org/) git hook is used to standardize
commit message styling.

These can both be set up with:

```bash
$ pnpm i
```

# Usage

```bash
$ make sync
```

The sync playbook configures a range of dev tools offered through different
Ansible roles. You can limit what is configured by specifying one or more roles
to run with the `TAGS` argument to make:

```bash
$ make sync TAGS=tmux,neovim
```

The guiding philosophy here is that changes made locally should be very easy and
safe to commit, otherwise divergence may creep in and conflict resolution
becomes a burden. For that reason, in most cases files or directories are
symlinked to this repo from their config locations (typically under
`$XDG_CONFIG_DIR`).
