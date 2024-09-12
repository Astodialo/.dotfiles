{ pkgs, specialArgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
      };
      keyboard.bindings = [
        { key = 53; mods = "Shift"; mode = "Vi"; action = "SearchBackward"; }
        #{ key = "Return"; mods = "Shift"; chars = "\\x1b[13;2u"; }
        #{ key = "Return"; mods = "Control"; chars = "\\x1b[13;5u"; }
      ];
      hints.enabled = [
        {
          regex = ''(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>"\\s{-}\\^⟨⟩`]+'';
          command = "${pkgs.mimeo}/bin/mimeo";
          post_processing = true;
          mouse.enabled = true;
        }
      ];
      selection.save_to_clipboard = true;
      window = {
        decorations = "full";
        opacity = 0.75;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
