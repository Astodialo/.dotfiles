{ writeShellScriptBin, ripgrep, xorg, ... }:

let
  xkbmap = "${xorg.setxkbmap}/bin/setxkbmap";
  rg = "${ripgrep}/bin/rg";
in
writeShellScriptBin "kls" ''
  layout=$(${xkbmap} -query | ${rg} layout)

  if [[ $layout == *"us"* ]]; then
    ${xkbmap} -layout gr
  elif [[ $layout == *"es"* ]]; then
    ${xkbmap} -layout de
  else
    ${xkbmap} -layout us
  fi
''
