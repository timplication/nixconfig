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

  xdg.configFile."niri".source = ../dotfiles/niri;  
  xdg.configFile."fuzzel".source = ../dotfiles/fuzzel;
  xdg.configFile."waybar".source = ../dotfiles/waybar;
  xdg.configFile."dunst".source = ../dotfiles/dunst;
  xdg.configFile."ghostty".source = ../dotfiles/ghostty;
  xdg.configFile."starship.toml".source = ../dotfiles/starship/starship.toml;

  gtk = {
    enable = true;  

    iconTheme = {
      package = pkgs.adwaita-icon-theme;  
      name = "Adwaita";
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    }; 
    "org/gnome/desktop/interface" = {
      cursor-size = 16;
    };
  };

  home.shell.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"    
          external: {
            # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
            # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer 
          }
        }
      } 
      source ${../dotfiles/nushell/themes/catppuccin_latte.nu}
    '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_latte";
      editor = {
        true-color = true;
        cursorline = true;
        color-modes = true;
        soft-wrap.enable = true;
        soft-wrap.wrap-indicator = "";
        lsp.snippets = true;
      };   
    };
    languages = {
      language-server.rust-analyzer = {
        check = {
          command = "clippy";
        };
        cargo = {
          features = "all";
        };
      };

      language = [
        {
          name = "latex";
          text-width = 100;
          soft-wrap.wrap-at-text-width = true;
        }
        {
          name = "markdown";
          text-width = 100;
          soft-wrap.wrap-at-text-width = true;
        }
        {
          name = "typst";
          text-width = 100;
          soft-wrap.wrap-at-text-width = true;
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
          text-width = 100;
          soft-wrap.wrap-at-text-width = true;
        }
      ];
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
      preload = [ "${../media/sunflower.jpg}" ];
      wallpaper = [ ",${../media/sunflower.jpg}" ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        after_sleep_cmd = "niri msg action power-on-monitors";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
      ];
    };
  };
}
