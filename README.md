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

If running on Arch Linux (with LUKS), an install partition will need to be
specified via `-e install_partition=...` to identify the device UUID to decrypt
during boot and configure refind.

## Installing pure prompt

Clone https://github.com/j4ns8i/pure, then create the following links somewhere in the
`$fpath`, like so:

```bash
$ ln -sf $(pwd)/pure.zsh ~/.config/zsh/functions/prompt_pure_setup
$ ln -sf $(pwd)/async.zsh ~/.config/zsh/functions/async
```

# New Installs

Use the install_archlinux.yaml playbook with an existing `install_esp` and
`install_partition` defined to install arch with LVM on LUKS. The partitions can
be created, if they do not exist already, like so:

```bash
# create an empty partition table
$ sfdisk /dev/sda <<< 'label: gpt'
# for an ESP - type=U corresponds to UEFI system partition
$ sfdisk --label gpt /dev/sda -N <part-num> <<< 'start=1MiB, size=512MiB, type=U'
# for a system partition - type=L is the common Linux partition type
$ sfdisk --label gpt /dev/sda -N <part-num> <<< 'start=513MiB, size=200GiB, type=L'
```

The LUKS container is generally referred to as cryptlvm in this setup.

## Install

```bash
$ ansible-playbook install_archlinux.yaml -e 'install_esp=/dev/sda1 install_partition=/dev/sda2'
```

## Maintenance

Opening the LUKS container can be done like so:

```bash
$ cryptsetup open <part-path> cryptlvm
```

If the LUKS container needs to be recreated, follow these steps to wipe it
first:

```bash
$ cryptsetup close cryptlvm
$ cryptsetup erase <part-path>
$ wipefs -a <part-path>
```

If more space is needed on arch installation live media for any reason (such as
ansible being too large to fit on the standard 256MiB, the root tmpfs should be
remounted like so:

```bash
$ mount -o remount,size=2G /run/archiso/cowspace
```

After the install_archlinux.yaml playbook, you must also run the bootstrap
playbook, not only to set up the standard shell environment and whatnot, but
also to finish setting up new systems which can't be done easily through chroot
hacks.

## Post-installation

Once both playbooks have been run to set up a new installation, make sure to
follow up with some other manual steps for securing the system.

### Change passwords

Unless the `bootstrap_password` variable was set differently than the
default, which in turn sets the main LUKS key password and the root login
password, you should change those values:

```bash
$ cryptsetup luksChangeKey <part-path> --key-slot 0
$ passwd
```
