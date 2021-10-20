{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  defaultUser = "steven";
  syschdemd = import ./syschdemd.nix { inherit lib pkgs config defaultUser; };
in {
  imports = [ "${modulesPath}/profiles/minimal.nix" ];

  # WSL is closer to a container than anything else
  boot.isContainer = true;

  environment.etc.hosts.enable = false;
  environment.etc."resolv.conf".enable = false;

  networking.dhcpcd.enable = false;

  users.users.${defaultUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  users.users.root = {
    shell = "${syschdemd}/bin/syschdemd";
    # Otherwise WSL fails to login as root with "initgroups failed 5"
    extraGroups = [ "root" ];
  };

  users.defaultUserShell = pkgs.fish;

  security.sudo.wheelNeedsPassword = false;

  # Disable systemd units that don't make sense on WSL
  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;

  systemd.services.firewall.enable = false;
  systemd.services.systemd-resolved.enable = false;
  systemd.services.systemd-udevd.enable = false;

  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;

  environment.noXlibs = lib.mkForce false;

  environment.systemPackages = [
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
  ];
}
