{ system ? builtins.currentSystem, ... }:
let
  pkgs = import <nixpkgs> {
    inherit system;
    config.allowUnfree = true;
  };
in
rec {
  basic = [ bash genv ];
  base = basic ++ base_util;
  just = basic ++ util_pkgs;
  bash = pkgs.bashInteractive_5;
  genv = with pkgs; [
    terminus_font terminus_font_ttf
    ibus ibus-engines.table ibus-engines.uniemoji ibus-qt
    pulseaudio-ctl
  ];
  vim = pkgs.vim_configurable.override { python = pkgs.python3; };
  netsurf = pkgs.netsurf.browser.override { uilib = "gtk3"; };
  jetbrains = with pkgs; with jetbrains; {
    inherit goland;
    pycharm = pycharm-professional;
    idea = idea-ultimate;
    inherit rider;
    inherit webstorm;
  };
  base_util = with pkgs; [
    git
    xclip
    elinks links
    dillo
    firefox
    scrot
    leafpad
    pavucontrol
    pasystray
    file
    tdesktop
    pcmanfm
    discord
    spotify
    pass-otp passff-host
    qtpass
  ];
  util_pkgs = with pkgs; [
    git-hub
    # ly
    gwenview #TODO
    xfontsel
    x2goclient
    # powershell
    aerc
    android-file-transfer
    zathura
    mplayer
    vlc
    youtube-dl
    libreoffice
    # gimp
    leafpad
    pandoc
    xarchiver
    # brave
    stalonetray
    # feedreader
    # teams
    # texlive.combined.scheme-small
    # rubber
    # texworks
    zim
    graphviz python38Packages.xdot
    # texlive.combined.scheme-medium
    # chromium
    guvcview
    hugo
    imagemagick
    # thunderbird
    xorg.xev #TODO

    abiword
    amp
    # clojure leiningen
    # conda
    # dotnet-sdk
    # freemind
    gitAndTools.gh
    # go
    gtk2fontsel
    # nixpkgs-review
    # Patchwork
    pciutils

    write_stylus
    poppler_utils
    # texmaker
    # texlive.combined.scheme-full
    # vivaldi
    xournalpp
    xorg.xclock
    virt-manager
  ] ++ base_util;
  games = with pkgs; [
    minetest
    openarena
  ];
  cdda_undead = pkgs.cataclysm-dda.withMods [
    pkgs.cataclysm-dda.pkgs.tileset.UndeadPeople
  ];
}
