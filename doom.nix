{ pkgs ? import <nixpkgs> { } }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nix-doom-emacs";
    rev = "c1c99cf";
    sha256 = "01kbhy08xk4awnh2v0v630icxr7kwradk27fk23ipgd68v52c14v";
  };
  nix-doom-emacs =
    pkgs.callPackage (import repo) { doomPrivateDir = ./doom.d; };
in pkgs.mkShell {
  buildInputs = [ nix-doom-emacs ];
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
    pkgs.nix-prefetch-git
  ];
  shellHook = let
    tmuxConf = pkgs.writeText "tmux.conf" ''
      set-option -g default-shell ${pkgs.fish}/bin/fish
    '';
  in ''
    tmux -f ${tmuxConf}
  '';
}

