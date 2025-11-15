{ config, pkgs, username, email, ... }:

{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.cowsay
    pkgs.discord
    pkgs.alacritty
  ];

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
      set tabstop=4
      set shiftwidth=4
      set expandtab
    '';
  };

  programs.git = {
    userName = "AJ Smyth";
    userEmail = "alexander.j.smyth@gmail.com";
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

