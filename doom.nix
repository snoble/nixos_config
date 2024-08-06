{ pkgs ? import <nixpkgs> { } }:

let
  myEmacsOverlay = self: super: {
    copilot = self.trivialBuild {
      pname = "copilot";
      ename = "copilot";
      version = "gh-2023-11-13";

      src = pkgs.fetchFromGitHub {
        owner = "zerolfx";
        repo = "copilot.el";
        rev = "30a054f8569550853a9b6f947a2fe1ded7e7cc6b";
        sha256 = "0zxx75wwp4yhi4mn6f7lv1qp4xx8nyhyfff10mlxgnvzx1v6inxq";
      };
      propagatedBuildInputs = [
        pkgs.emacsPackages.dash
        pkgs.emacsPackages.s
        pkgs.emacsPackages.editorconfig
      ];
    };
  };

  repo = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nix-doom-emacs";
    rev = "c1c99cf";
    sha256 = "01kbhy08xk4awnh2v0v630icxr7kwradk27fk23ipgd68v52c14v";
  };
  nix-doom-emacs = pkgs.callPackage (import repo) {
    doomPrivateDir = ./doom.d;
    emacsPackagesOverlay = myEmacsOverlay;
  };
  awscli2-custom = pkgs.awscli2.overrideAttrs (oldAttrs: {
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];

    doCheck = false;

    # Run any postInstall steps from the original definition, and then wrap the
    # aws program with a wrapper that sets the PYTHONPATH env var to the empty
    # string
    postInstall = ''
      ${oldAttrs.postInstall}
      wrapProgram $out/bin/aws --set PYTHONPATH=
    '';
  });
  #  python = pkgs.python3.withPackages
  #    (ps:
  #      with ps;
  #      [
  #        (pkgs.python311Packages.urllib3.overridePythonAttrs (oldAttrs: rec {
  #          version = "1.26.18";
  #          src = oldAttrs.src.override {
  #            inherit version;
  #            sha256 =
  #              "0000000000000000000000000000000000000000000000000000"; # replace with the correct hash
  #          };
  #        }))
  #      ]);

in pkgs.mkShell {
  buildInputs = [ nix-doom-emacs ];
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = [
    pkgs.neovim
    pkgs.nixfmt
    pkgs.tmux
    pkgs.git
    pkgs.gnumake
    pkgs.pipenv
    pkgs.wget
    pkgs.nodejs_20
    pkgs.autossh
    pkgs.google-cloud-sdk
    pkgs.go
    pkgs.fswatch
    pkgs.nodePackages.yarn
    pkgs.sbt
    pkgs.inetutils
    awscli2-custom
    # pkgs.python3
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
      set-option -g xterm-keys on
      set -g default-terminal "screen-256color"
      set -g mouse on
      set-window-option -g mode-keys vi
      set-option -g default-shell ${pkgs.fish}/bin/fish
    '';
  in ''
    tmux -f ${tmuxConf}
  '';
}

