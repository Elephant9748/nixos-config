{ pkgs, ... }: {
    home.packages = with pkgs; [ htop ];
    home.stateVersion = "24.05";

    home.file.".config/nvim" ={
        source = ../../modules/dotfiles/.config/nvim;
	recursive = true;
	onChange = builtins.readFile ../../modules/dotfiles/.config/nvim;
    };
}
