{ config, pkgs, ... }: {
  imports = [
    ../modules/shell.nix
  ];

  home.username = "ryan.heath";
  home.homeDirectory = "/Users/ryan.heath";
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.bat
    pkgs.tmux
    pkgs.ripgrep
    pkgs.eza
    pkgs.zoxide
    pkgs.tree
    pkgs.htop
    pkgs.neovim
    pkgs.nodejs_20
    pkgs.pandoc
    pkgs.terminus-nerdfont
    pkgs.iosevka
    pkgs.sshpass
  ];

  programs.git = {
    enable = true;
    userName = "Ryan Heath";
    userEmail = "ryan@example.com";
  };
}

