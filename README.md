# dotfiles

Ansible-based system configuration.

# Requirements

```bash
$ pip install -r requirements.txt
```

# Usage

```bash
$ ansible-playbook bootstrap.yaml
```

# Notes

If more space is needed on arch installation live media for any reason, the root
tmpfs should be remounted like so:

```bash
$ mount -o remount,size=2G /run/archiso/cowspace
```
