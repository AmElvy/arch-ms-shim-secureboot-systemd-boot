echo "Signing linux zen kernel"
sbsign --key "/etc/secureboot/MOK.key" \
       --cert "/etc/secureboot/MOK.crt" \
       --output "/boot/vmlinuz-linux-zen-signed" \
       "/boot/vmlinuz-linux-zen"
