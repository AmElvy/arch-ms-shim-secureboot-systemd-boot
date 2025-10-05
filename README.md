# arch-ms-shim-secureboot-systemd-boot
garbage scripts, hooks, entries for setting up secureboot on dualboot arch installs with ubuntu/fedora ms shim.

my weird messy version, mostly for me on reinstalling.

embrace the jank.

i've heavily borrowed from https://gist.github.com/devcexx/e1d168dc299540e9644af6f97cf5597f

# Why?
Resigning microsoft garbage EFI files is prone to breaking.
so let's use a shim.

# Is this secure?
LOL no.

but secureboot isn't really secure either.

it's security theatre.

but I need secureboot on windows for anti cheat games. (LAME)

# Requirements
  - Systemd-boot (either a new or existing install)
  - shim-signed (AUR)
  - efibootmgr
  - sbsigntools

# Assumptions
  - assumptions are a little different to the gist linked.
    - /dev/nvme0n1 is the drive used
    - /dev/nvme0n1p1 is boot partition at /boot/
    - /dev/nvme0n1p2 is a btrfs partition with root at the @ subvol.

Scripts are located at /etc/secureboot


# How to use

**Run the following commands as root!**

### Generate keys
```bash
  openssl req -newkey rsa:2048 -nodes -keyout MOK.key \
    -new -x509 -sha256 -days 3650 -subj "/CN=devcexx MOK/" \
    -out MOK.crt && \
  openssl x509 -outform DER -in MOK.crt -out MOK.cer) 
```
### Copy hooks
```bash
mkdir /etc/pacman.d/hooks
mv *.hooks /etc/pacman.d/hooks
!Optionally if you dont use zen you can delete "20-sign-linux-zen.hook" or adapt to whatever kernel you use
```
### Copy scripts
```bash
mkdir /etc/secureboot
mv *.sh /etc/secureboot
!optionally if you dont use zen you can delete "signlinuxzenkernal.sh" or adapt to whatever kernel you use
```

### Run scripts
```bash
./signsystemd-boot.sh
./signlinuxkernel.sh
./signlinuxzenkernel.sh (optional)
```

### Add UEFI entry
```bash
efibootmgr --unicode --disk /dev/nvme0n1 \
  --part 1 \
  --create \
  --label 'Shim' \
  --loader '\EFI\systemd\shimx64.efi'
```


### Add signed systemd-boot entries
make a copy of the entries you use.

I'd recommend prefixing either signed and/or unsigned for file names and titles.

prefix vmlinuz files with -signed.

for some reason the unsigned ones are also added in options??? I should test without but i'm lazy and if it works, it works

My systemd config is in the "example systemd install" folder.
