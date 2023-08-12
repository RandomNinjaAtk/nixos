Setup:

1. Run the following commands:
```
cd /etc/nixos \
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hosts/desktop.nix -O \
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O \
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/samba.nix -O
```
2. Edit: `/etc/nixos/configuration.nix` to include `./desktop.nix` in the import section.
3. Run: `nixos-rebuild boot --upgrade-all`
4. Reboot system
