{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    stylua
    prettierd
    rustfmt
    ormolu
    alejandra
  ];
}
