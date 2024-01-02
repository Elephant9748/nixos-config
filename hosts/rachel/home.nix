{ pkgs, ... }: {
    home.packages = with pkgs; [ htop ];
    home.stateVersion = "24.05";
}
