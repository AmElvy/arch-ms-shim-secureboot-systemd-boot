echo "Signing linux kernel"
sbsign --key "/etc/secureboot/MOK.key" \
       --cert "/etc/secureboot/MOK.crt" \
       --output "/boot/vmlinuz-linux-signed" \
       "/boot/vmlinuz-linux"
