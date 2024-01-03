### Flake on fresh install
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

