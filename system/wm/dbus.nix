{ pkgs, ... }:

{
  programs.dconf = {
    enable = true;
  };

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };
}
