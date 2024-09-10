{ pkgs, ... }:

let
  # obtained via `autorandr --fingerprint`
  screen1 = "00ffffffffffff0010ac8842553535312e20010380472878ea1e75af4f42a7240f5054a54b00714f81008180a940b300d1c0d100a9c008e80030f2705a80b0588a00c48f2100001e000000ff00345658585a4e330a2020202020000000fc0044454c4c204733323233510a20000000fd0030901eff3c000a2020202020200319f00270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009e02035af14e61603f101f5f5e5d22041312030123090707830100006d030c002000383c2000600102036dd85dc4017888330e3090c334146d1a0000020b3090e6047314732fe305c301e6060501737321e200d5e30e7675e20f03866f80a07038404030203500c48f2100001a6fc200a0a0a0555030203500c48f2100001e0053701279030003016447e80104ff0e4f00";
 
  screen2 = "00ffffffffffff00410c78c22d4200002c20010380351e782a0865ae4f3faa26175054bfef00d1c081803168317c4568457c6168617c023a801871382d40582c45000f282100001e000000ff00554b3032323434303136393431000000fc0032344d314e33323030560a2020000000fd0030a51ec83c000a2020202020200132020337f14c101f0514041303120211013f230907078301000067030c001000004267d85dc4017880006d1a0000020130a5e60000000000d09480a070381e40304035000f282100001a377f808870381440182035000f282100001e866f80a070384040302035000f282100001e00000000000000000000000000000000000026";


  notify = "${pkgs.libnotify}/bin/notify-send";
in
{
  programs.autorandr = {
    enable = true;

    hooks = {
      predetect = { };

      preswitch = { };

      postswitch = {
        "notify-xmonad" = ''
          ${notify} -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE"
        '';

        "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            away)
              DPI=96
              ;;
            home)
              DPI=178
              ;;
            *)
              ${notify} -i display "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac

          echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
      };
    };

    profiles = {
      "home" = {
        fingerprint = {
          DisplayPort-2 = screen1;
          HDMI-A-0 = screen2;
        };

        config = {
          DisplayPort-2 = {
            enable = true;
            crtc = 1;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            rate = "60.00";
          };
          HDMI-A-0 = {
            enable = true;
            crtc = 0;
            position = "0x0";
            mode = "1920x1080";
            rate = "60.00";
          };
        };
      };
    };

  };
}
