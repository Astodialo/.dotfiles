{ lib, pkgs, inputs, ...}:

{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
  stylix.image = ./wallpapers/pink-trees.jpeg;
}
