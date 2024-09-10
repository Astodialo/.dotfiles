{ pkgs, config, ... }:

let
  extra = ''
    set +x
    ${pkgs.util-linux}/bin/setterm -blank 0 -powersave off -powerdown 0
    ${pkgs.xorg.xset}/bin/xset s off
    ${pkgs.xcape}/bin/xcape -e "Hyper_L=Tab;Hyper_R=backslash"
    ${pkgs.xorg.setxkbmap}/bin/setxkbmap -option ctrl:nocaps
    ${pkgs.autorandr}/bin/autorandr --change
    ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --mode 3840x2160 --rate 60.00
  '';


  polybarOpts = ''
    ${pkgs.nitrogen}/bin/nitrogen --restore &
    ${pkgs.pasystray}/bin/pasystray &
    ${pkgs.blueman}/bin/blueman-applet &
    ${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
  '';

  xmonadPkgs = with pkgs; [
    arandr # simple GUI for xrandr
    asciinema # record the terminal
    bitwarden-cli # command-line client for the password manager
    calibre # e-book reader
    #cobang               # qr-code scanner
    cowsay # cowsay fortune teller with random images
    dive # explore docker layers
    drawio # diagram design
    #gnomecast            # chromecast local files
    libnotify # notify-send command
    multilockscreen # fast lockscreen based on i3lock
    nix-index # locate packages containing certain nixpkgs
    ouch # painless compression and decompression for your terminal
    pavucontrol # pulseaudio volume control
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    pgcli # modern postgres client
    playerctl # music player controller
    prettyping # a nicer ping
    protonvpn-gui # official proton vpn client
    pulsemixer # pulseaudio mixer
    rage # encryption tool for secrets management
    simple-scan # scanner gui
    simplescreenrecorder # screen recorder gui
    tldr # summary of a man page
    flameshot # screen capture
    glxinfo

    # haskell packages
    haskellPackages.nix-tree # visualize nix dependencies

    # xmonad
    dialog # Dialog boxes on the terminal (to show key bindings)
    networkmanager_dmenu # networkmanager on dmenu
    networkmanagerapplet # networkmanager applet
    nitrogen # wallpaper manager
    xcape # keymaps modifier
    xorg.xkbcomp # keymaps modifier
    xorg.xmodmap # keymaps modifier
    xorg.xrandr # display manager (X Resize and Rotate protocol)
  ];

  gnomePkgs = with pkgs; [
    eog # image viewer
    evince # pdf reader
    gnome-disk-utility
    nautilus # file manager
  ];
in
{
  programs.home-manager.enable = true;


  imports = [
    ../../shared
    #../../dev/rust
    ../../programs/kitty
    ../../programs/xmonad/autorandr
    ../../programs/xmonad/orage
    ../../programs/xmonad/rofi
    ../../programs/xmonad/statix
    ../../services/networkmanager
    ../../services/dunst
    ../../services/xmonad/picom
    ../../services/xmonad/polybar
    ../../services/xmonad/screenlocker
  ];

  home = {
    stateVersion = "24.05";
    packages = xmonadPkgs ++ gnomePkgs;
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
  };

  xsession = {
    enable = true;

    initExtra = extra + polybarOpts;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
      ];
      config = ./config.hs;
    };
  };

  xresources.properties = {
    "Xft.dpi" = 180;
    "Xft.autohint" = 0;
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
    "Xcursor*theme" = "Vanilla-DMZ-AA";
    "Xcursor*size" = 24;
  };
}
