{ pkgs, ... }:

let
in
{
  # lightweight wayland terminal emulator
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
    };
    theme = "Sakura Night";
    extraConfig = "  
      background_opacity 0.5
    ";

  };
}
