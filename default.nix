{ system ? builtins.currentSystem, ... }:
let
  pkgs = import <nixpkgs> {
    inherit system;
    config.allowUnfree = true;
  };
in
rec {
  basic = [ genv ];
  level_zero = basic ++ pkgs_level_zero;
  level_one = level_zero ++ pkgs_level_one;
  level_two = level_one ++ pkgs_level_two ++ [ code ];
  level_three = level_two ++ pkgs_level_three;
  level_four = level_three ++ pkgs_level_four;
  bash = pkgs.bashInteractive_5;
  genv = with pkgs; [
    terminus_font terminus_font_ttf
    ibus ibus-engines.table ibus-engines.uniemoji ibus-qt
    pulseaudio-ctl
  ];
  vim = pkgs.vim_configurable.override { python = pkgs.python3; };
  code = pkgs.vscode-fhsWithPackages (ps: with ps; [
    rustup zlib  # needed for rust lang server extension
    # (python39Full.withPackages (pp: with pp; [ pipenv ]))
    pipenv
    python39Full
    python310
  ]);
  netsurf = pkgs.netsurf.browser.override { uilib = "gtk3"; };
  jetbrains = with pkgs; with jetbrains; {
    inherit goland;
    pycharm = pycharm-professional;
    idea = idea-ultimate;
    inherit rider;
    inherit webstorm;
  };
  pkgs_level_zero = with pkgs; [
    git
    xclip
    elinks links
    dillo
    pasystray
    scrot
    pavucontrol
    file
    howl
  ];
  pkgs_level_one = with pkgs; [
    pass-otp
    pcmanfm
    zathura
    xorg.xev
    pciutils
    firefox
    geany
  ];
  pkgs_level_two = with pkgs; [
    # git-hub
    gitAndTools.hub gitAndTools.gh
    qtpass
    xorg.xclock
    leafpad
    discord
    tdesktop
    spotify
    gitAndTools.gh
    imagemagick
    xarchiver
    xfontsel
    gwenview
  ];
  pkgs_level_three = with pkgs; [
    libreoffice
    mplayer
    vlc
    youtube-dl
    poppler_utils
    zim
    pandoc
  ];
  pkgs_level_four = with pkgs; [
    emacs
    ly
    powershell
    x2goclient
    stalonetray
    feedreader
    graphviz python38Packages.xdot
    vivaldi
    xournalpp
    write_stylus
    freemind
    amp
    abiword
    go
    gtk2fontsel
    nixpkgs-review
    dotnet-sdk
    thunderbird
    hugo
    guvcview
    xorg.xclock
    virt-manager
  ];
  games = with pkgs; [
    minetest
    openarena
  ];
  cdda_undead = pkgs.cataclysm-dda.withMods [
    pkgs.cataclysm-dda.pkgs.tileset.UndeadPeople
  ];
}
