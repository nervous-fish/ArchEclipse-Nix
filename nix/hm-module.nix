self: {
  config,
  pkgs,
  lib,
  ...
}: let
  system = "${pkgs.stdenv.hostPlatform.system}";
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  cfg = config.programs.archeclipse;
  dataRoot = "${config.home.homeDirectory}/.local/share/archeclipse";
in {
  options.programs.archeclipse = {
    enable = mkEnableOption "archeclipse";
  };
  
  config = mkIf cfg.enable {
    home.sessionVariables = {
      ARCHECLDATA=dataRoot;
    };

    home.packages = [ 
      self.inputs.ags.packages.${system}.agsFull
      self.inputs.ags.packages.${system}.io
    ];

    home.file."${config.home.homeDirectory}/.config/uwsm".source = ../.config/uwsm;

    home.file."${config.home.homeDirectory}/.config/ags".source = ../.config/ags;
    home.file."${config.home.homeDirectory}/.config/aria2".source = ../.config/aria2;
    home.file."${config.home.homeDirectory}/.config/btop".source = ../.config/btop;
    home.file."${config.home.homeDirectory}/.config/fastfetch".source = ../.config/fastfetch;
    
    home.file."${config.home.homeDirectory}/.config/hypr".source = ../.config/hypr;

    home.file."${config.home.homeDirectory}/.config/kitty".source = ../.config/kitty;
    home.file."${config.home.homeDirectory}/.config/nvim".source = ../.config/nvim;
    home.file."${config.home.homeDirectory}/.config/pipewire".source = ../.config/pipewire;
    home.file."${config.home.homeDirectory}/.config/ranger".source = ../.config/ranger;
    home.file."${config.home.homeDirectory}/.config/wallpapers".source = ../.config/wallpapers;

    home.file."${config.home.homeDirectory}/.icons/theme_phinger-cursors-dark".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
    home.file."${config.home.homeDirectory}/.icons/theme_phinger-cursors-light".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-light";

    home.pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
    };
    home.activation = {
      init = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p ${dataRoot}/ags/assets/binaries
        mkdir -p ${dataRoot}/hypr/configs
        mkdir -p ${dataRoot}/hyprpaper/config
      '';
    };
  };
}