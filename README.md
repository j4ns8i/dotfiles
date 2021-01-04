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

# Installing arch

If an ESP is given along with an install partition, a full installation will be
attempted with LVM on LUKS. These partitions must be created in advance, which
can be done like so:

```bash
# create an empty partition table
$ sfdisk /dev/sda <<< 'label: gpt'
# for an ESP - type=U corresponds to UEFI system partition
$ sfdisk --label gpt /dev/sda -N <part-num> <<< 'start=1MiB, size=512MiB, type=U'
# for a system partition - type=L is the common Linux partition type
$ sfdisk --label gpt /dev/sda -N <part-num> <<< 'start=513MiB, size=200GiB, type=L'
```

If the LUKS container needs to be recreated, follow these steps:

```bash
$ cryptsetup close <crypt-name>
$ cryptsetup erase <crypt-name>
$ wipefs -a <part-path>
```

If more space is needed on arch installation live media for any reason (such as
ansible being too large to fit on the standard 256MiB, the root tmpfs should be
remounted like so:

```bash
$ mount -o remount,size=2G /run/archiso/cowspace
```
