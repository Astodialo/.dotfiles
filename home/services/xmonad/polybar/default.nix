{ config, lib, pkgs, ... }:

let
  openCalendar = "${pkgs.xfce.orage}/bin/orage";

  mainBar = pkgs.callPackage ./bar.nix { };

  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    # githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  home-manager.enable = true;
  # theme adapted from: https://github.com/adi1090x/polybar-themes#-polybar-5
  bars = lib.readFile ./bars.ini;
  colors = lib.readFile ./colors.ini;
  mods1 = lib.readFile ./modules.ini;
  mods2 = lib.readFile ./user_modules.ini;

  bluetoothScript = pkgs.callPackage ./scripts/bluetooth.nix {};
  klsScript       = pkgs.callPackage ../../../scripts/keyboard-layout-switch.nix {};
  monitorScript   = pkgs.callPackage ./scripts/monitor.nix {};
  mprisScript     = pkgs.callPackage ./scripts/mpris.nix {};
  networkScript   = pkgs.callPackage ./scripts/network.nix {};

  bctl = ''
    [module/bctl]
    type = custom/script
    exec = ${bluetoothScript}/bin/bluetooth-ctl
    tail = true
    click-left = ${bluetoothScript}/bin/bluetooth-ctl --toggle &
  '';

  cal = ''
    [module/clickable-date]
    inherit = module/date
    label = %{A1:${openCalendar}:}%time%%{A}
  '';

  keyboard = ''
    [module/clickable-keyboard]
    inherit = module/keyboard
    label-layout = %{A1:${klsScript}/bin/kls:}  %layout% %icon% %{A}
  '';

  mpris = ''
    [module/mpris]
    type = custom/script

    exec = ${mprisScript}/bin/mpris
    tail = true

    label-maxlen = 60

    interval = 2
    format =  <label>
    format-padding = 2
  '';

  xmonad = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log

    tail = true
  '';

  customMods =  mainBar + bctl + cal + keyboard + mpris + xmonad;
in
{
  home.packages = with pkgs; [
    font-awesome
    material-design-icons
    xfce.orage
  ];

  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./config.ini;
    extraConfig = bars + colors + mods1 + mods2 + customMods;
    # polybar top -l trace (or info) for debugging purposes
    script = ''
      export MONITOR=$(${monitorScript}/bin/monitor)
      echo "Running polybar on $MONITOR"
      export ETH_INTERFACE=$(${networkScript}/bin/check-network eth)
      export WIFI_INTERFACE=$(${networkScript}/bin/check-network wifi)
      echo "Network interfaces $ETH_INTERFACE & $WIFI_INTERFACE"
      polybar top
      polybar bottom
    '';
  };
}