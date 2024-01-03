{ pkgs, ... }: {
    home.packages = with pkgs; [ htop ];

    home.file.".config/nvim" = {
        source = ../../modules/dotfiles/nvim;
        recursive = true;
    };

    home.file.".config/fish" = {
        source = ../../modules/dotfiles/fish;
        recursive = true;
    };

    home.stateVersion = "24.05";
}
