{ pkgs, ...}:

let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
in
  pkgs.writeShellScriptBin "monitor" ''
    monitors=$(${xrandr} --listmonitors)

    if [[ $monitors == *"HDMI-1"* ]]; then
      echo "HDMI-1"
    elif [[ $monitors == *"DisplayPort-2"* ]]; then
      echo "DisplayPort-2"
    elif [[ $monitors == *"HDMI-A-0"* ]]; then
      echo "HDMI-A-0"
    elif [[ $monitors == *"HDMI-A-1-0"* ]]; then
      echo "HDMI-A-1-0"
    elif [[ $monitors == *"eDP-1"* ]]; then
      echo "eDP-1"
    else
      echo "eDP"
    fi
  ''
