{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  home.packages = with pkgs; [
    mangohud
    protonup
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = 
      "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
