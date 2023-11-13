{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {

  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = [
    pkgs.neovim
    pkgs.nixfmt
    pkgs.tmux
    pkgs.git
    pkgs.gnumake
    pkgs.python3
    pkgs.pipenv
    pkgs.wget
    pkgs.nodejs-18_x
    pkgs.autossh
    pkgs.google-cloud-sdk
    pkgs.fswatch
    pkgs.nodePackages.yarn
    pkgs.sbt
    pkgs.awscli2
    pkgs.nodePackages.pyright
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.fish
    pkgs.openssh
    pkgs.protobuf
    pkgs.mosh
    pkgs.libdvdcss
    pkgs.rename
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.nodePackages.npm
    pkgs.arduino-cli
    pkgs.openjdk8_headless
    pkgs.hydra-check
    pkgs.jq
    pkgs.readline
    pkgs.gmp
    pkgs.docker
    pkgs.gh
    pkgs.time
    pkgs.node2nix
  ];
  shellHook = let
    tmuxConf = pkgs.writeText "tmux.conf" ''
      set-option -g default-shell ${pkgs.fish}/bin/fish
    '';
  in ''
    tmux -f ${tmuxConf}
  '';
}

