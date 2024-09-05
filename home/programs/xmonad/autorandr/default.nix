{ pkgs, ... }:

let
  # obtained via `autorandr --fingerprint`
  msiOptixId = "00ffffffffffff0010ac8842553535312e20010380472878ea1e75af4f42a7240f5054a54b00714f81008180a940b300d1c0d100a9c008e80030f2705a80b0588a00c48f2100001e000000ff00345658585a4e330a2020202020000000fc0044454c4c204733323233510a20000000fd0030901eff3c000a2020202020200319f00270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009e02035af14e61603f101f5f5e5d22041312030123090707830100006d030c002000383c2000600102036dd85dc4017888330e3090c334146d1a0000020b3090e6047314732fe305c301e6060501737321e200d5e30e7675e20f03866f80a07038404030203500c48f2100001a6fc200a0a0a0555030203500c48f2100001e0053701279030003016447e80104ff0e4f00";
  
  # tongfangId = "00ffffffffffff004d10c31400000000091d0104a522137807de50a3544c99260f5054000000010101010101010101010101010101011a3680a070381d403020350058c210000018000000fd00303c42420d010a202020202020000000100000000000000000000000000000000000fc004c513135364d314a5730310a20006b";

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
          HDMI-A-1 = msiOptixId;
        };

        config = {
          HDMI-A-1 = {
            enable = true;
            crtc = 0;
            position = "0x0";
            mode = "3840x2160";
            rate = "30.00";
          };
        };
      };
    };

  };
}
