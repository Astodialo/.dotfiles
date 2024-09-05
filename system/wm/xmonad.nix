{config, lib, pkgs, ...}:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./fonts.nix
              ../hardware/opengl.nix
              ../hardware/bluetooth.nix
              ../hardware/time.nix
              ../stylix.nix
            ];


  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;
    
    xserver = {
      enable = true;
      layout = "us";
    
      libinput = {
        enable = true;
        disableWhileTyping = true;
      };

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkbOptions = "caps:ctrl_modifier";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}
