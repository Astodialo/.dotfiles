{config, lib, pkgs, ...}:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./fonts.nix
              ../hardware/bluetooth.nix
              ../hardware/time.nix
            ];


  services = {
    upower.enable = true;
    libinput = {
      enable = true;
    };
      
    displayManager.defaultSession = "none+xmonad";

    xserver = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
      
      xkb = {
        layout = "us";
        options = "ctrl:nocaps";
      };
    };
  };

  systemd.services.upower.enable = true;
}
