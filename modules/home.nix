{ config, pkgs, ... }:
{
  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/";
    download = "${config.home.homeDirectory}/down";
    templates = "${config.home.homeDirectory}/media";
    publicShare = "${config.home.homeDirectory}/";
    documents = "${config.home.homeDirectory}/media";
    music = "${config.home.homeDirectory}/media";
    pictures = "${config.home.homeDirectory}/media";
    videos = "${config.home.homeDirectory}/media";
  };

  xdg.configFile."alacritty".source = ../dotfiles/alacritty;
  xdg.configFile."niri".source = ../dotfiles/niri;  
  xdg.configFile."fuzzel".source = ../dotfiles/fuzzel;
  xdg.configFile."waybar".source = ../dotfiles/waybar;
  xdg.configFile."helix".source = ../dotfiles/helix;
  xdg.configFile."dunst".source = ../dotfiles/dunst;

  gtk = {
    enable = true;  

    cursorTheme = {
      package = pkgs.catppuccin-cursors.latteMauve;
      name = "catppuccin-latte-mauve-cursors";
      size = 16;
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;  
      name = "Adwaita";
    };
  };
  
  programs.git = {
    enable = true;
    includes = [
      {
        condition = "gitdir:~/dev/gitlab-vub/";
        path = "~/dev/gitlab-vub/.gitconfig";
      }
      {
        condition = "gitdir:~/dev/github/";
        path = "~/dev/github/.gitconfig";
      }
    ];
    aliases = {
      "a" = "add --all";
      "b" = "branch";
      "c" = "commit";
      "cm" = "commit -m";
      "l" = "log --oneline";
      "lg" = "log --oneline --graph --decorate";
      "ps" = "push";
      "pl" = "pull";
      "s" = "status";
      "t" = "tag";
    };
    ignores = [
      # Linux Hidden Files
      "*~"
      ".fuse_hidden*"
      ".directory"
      ".Trash-*"
      ".nfs*"

      # Windows Hidden files
      "Thumbs.db"
      "Thumbs.db:encryptable"
      "ehthumbs.db"
      "ehthumbs_vista.db"
      "*.stackdump"
      "[Dd]esktop.ini"
      "$RECYCLE.BIN/"
      "*.cab"
      "*.msi"
      "*.msix"
      "*.msm"
      "*.msp"
      "*.lnk"

      # MacOS Hidden Files
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "._*"
      "DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachines.donotpresent"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # Vim Hidden Files
      "[._]*.s[a-v][a-z]"
      "!*.svg"
      "[._]*.sw[a-p]"
      "[._]s[a-rt-v][a-z]"
      "[._]ss[a-gi-z]"
      "[._]sw[a-p]"
      "Session.vim"
      "Sessionx.vim"
      ".netrwhist"
      "tags"
      "[._]*.un~"

      # Private Key Files
      "*.der"
      "*.key"
      "*.pem"
      "*.ppk"
    ];
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/hypr/hyprlock.conf;
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ "${../media/marathon-1.png}" ];
      wallpaper = [ ",${../media/marathon-1.png}" ];
    };
  };

  # services.hypridle = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       lock_cmd = "pidof hyprlock || hyprlock";
  #       after_sleep_cmd = "niri msg action power-on-monitors";
  #     };

  #     listener = [
  #       {
  #         timeout = 300;
  #         on-timeout = "hyprlock";
  #       } 
  #       {
  #         timeout = 500;
  #         on-timeout = "niri msg action power-off-monitors";
  #         on-resume = "niri msg action power-on-monitors";
  #       }
  #     ];
  #   };
  # };
}
