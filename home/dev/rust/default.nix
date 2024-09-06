{pkgs, stable, ...}:
let
  stable-pkgs = with stable; 
    [ xorg.libxcb.dev ];

  unstable-pkgs = with pkgs;
    [ alsa-lib
      binutils
      libressl
      pkg-config
      cmake
      python3
      vulkan-tools ];
in 
{
  home.packages =  stable-pkgs ++ unstable-pkgs; 
}
