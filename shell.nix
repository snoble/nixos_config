{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs =[
    pkgs.neovim
    pkgs.nixfmt
    pkgs.tmux
    pkgs.git
    pkgs.gnumake
    pkgs.python3
    pkgs.pipenv
    pkgs.wget
    pkgs.nodejs-14_x
    pkgs.autossh
    pkgs.google-cloud-sdk
    pkgs.fswatch
    pkgs.nodePackages.yarn
    pkgs.sbt
    pkgs.awscli2
    pkgs.nodePackages.pyright
    pkgs.nodePackages.typescript
    pkgs.fish
    pkgs.openssh
    pkgs.ruby
    pkgs.protobuf
    pkgs.mosh
  ];
  }

