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
    tint2
    terminus_font terminus_font_ttf
    rofi
    ibus ibus-engines.table ibus-engines.uniemoji ibus-qt
    xlockmore xss-lock
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
    rxvt_unicode
    git
    xclip
    elinks links
    dillo
    midori
    firefox
    scrot
    emacs
    leafpad
    pavucontrol
    pasystray
    file
  ];
  util_pkgs = with pkgs; [
    kakoune kak-lsp
    zsh
    git-hub
    pass-otp passff-host
    qtpass
    # ly
    gwenview
    xfontsel
    x2goclient
    powershell
    tdesktop
    aerc
    android-file-transfer
    pcmanfm
    zathura
    mplayer
    vlc
    youtube-dl
    libreoffice
    gimp
    leafpad
    pandoc
    xarchiver
    brave
    stalonetray
    feedreader
    teams
    # texlive.combined.scheme-small
    # rubber
    # texworks
    zim
    graphviz python38Packages.xdot
    # texlive.combined.scheme-medium
    chromium
    guvcview
    hugo
    imagemagick
    thunderbird
    xorg.xev

    abiword
    amp
    clojure leiningen
    conda
    discord
    dotnet-sdk
    freemind
    gitAndTools.gh
    go
    gtk2fontsel
    nixpkgs-review
    # Patchwork
    pciutils

    write_stylus
    poppler_utils
    texmaker
    texlive.combined.scheme-full
    spotify
    vivaldi
    xournalpp
    xorg.xclock
    virt-manager
    kmail
  ] ++ base_util;
  games = with pkgs; [
    minetest
    openarena
  ];
  cdda_undead = pkgs.cataclysm-dda.withMods [
    pkgs.cataclysm-dda.pkgs.tileset.UndeadPeople
  ];
}
