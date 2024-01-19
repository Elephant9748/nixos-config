
### Flake on fresh install
host:
```
rachel -> with desktop-*
rigel -> cli only
```

note: change uuid `/boot', matched lvm_vol!
structure disk on `vm` with just `lvm`:
```
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0                       11:0    1  477M  0 rom  
vda                      252:0    0  100G  0 disk 
├─vda1                   252:1    0  550M  0 part /boot
└─vda2                   252:2    0 99.5G  0 part 
  └─lvm_nix_vol-nix_root 254:0    0 99.5G  0 lvm  /nix/store
                                                  /
```
instruction first install
```
$ sudo su
# nix-env -iA nixos.git
# git clone <repo url>
# nixos-install --flake .#<user/host>
# reboot

/* move build to desired location */ 
/etc/nixos/*
/* to avoid build from /etc/nixos/configuration.nix
```


### Flake rebuild
```
$ sudo nixos-rebuild switch --flake .#<user/host>
```

### Flake update
```
$ nix flake update
```

#### other command
```
home-manager generations
nixos-rebuild list-generations
```
