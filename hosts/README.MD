Setup:

```
cd /etc/nixos
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hosts/desktop.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/samba.nix -O
```

Edit `/etc/nixos/configuration.nix` to include `./desktop.nix` in the import section.
Run:
`nixos-rebuild boot --upgrade-all`
Reboot system
