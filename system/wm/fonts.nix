{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    font-awesome
    nerdfonts
    # powerline # FIXME broken by python 311 -> 312 nixpkgs update
  ];

}
