{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskell-language-server
    lua-language-server
    gopls
    nil
    python311Packages.python-lsp-server
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server
    nodePackages_latest.dockerfile-language-server-nodejs
  ];  
}
