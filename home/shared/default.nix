{ config, pkgs, ... }:

let
  username = "delos";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  packages = with pkgs; [
    duf
    eza
    fd
    hyperfine
    libreoffice
    lnav
    ncdu
    nitch
    nyancat
    ripgrep
    tdesktop
    tree
    vlc
    xsel
    neofetch
    duf
    nitch

    clinfo

    lua-language-server
    rust-analyzer
    nil

    bottles
  ];

  myAliases = {
    ll = " ls -l";
    ".." = "cd ..";
    rsf = "sudo nixos-rebuild switch --flake .";
    hsf = "home-manager switch --flake .";
    pkgs = "cat ${pkgs.nix}";
    purrr = "cat ~/.purrr";
    nop = "nix develop";
  };
in 
{

  programs = { 
    home-manager.enable = true;

    bash = {
      enable = true;
      shellAliases = myAliases;
    };
  };

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory packages;

    sessionVariables = {
      BROWSER = "${pkgs.brave}";
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  news.display = "silent";
}
