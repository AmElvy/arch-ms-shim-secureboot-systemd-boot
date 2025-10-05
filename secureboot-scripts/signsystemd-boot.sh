#!/bin/bash

echo "update systemd boot"
bootctl update

echo "Signing systemd-boot...."
sbsign --key "/etc/secureboot/MOK.key" \
       --cert "/etc/secureboot/MOK.crt" \
       --output "/boot/EFI/systemd/grubx64.efi" \
       "/boot/EFI/systemd/systemd-bootx64.efi"
