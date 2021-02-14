{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial;
  '';
  boot.loader.grub.forceInstall = true;
  boot.loader.timeout = 10;
  boot.cleanTmpDir = true;

  networking.hostName = "nixos-linode";

  time.timeZone = "America/Sao_Paulo";

  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.usePredictableInterfaceNames = false;
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  users.users.default = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDB3m/bdUSpSRJpX3MBV9XfDTkhqOVsf6QUjUc9sMdCtNKT95X/59+/OVT0mfjU0MabjphobwwkRaCi6BjDBY0aVpscB0F7e7zLn4DdmKqJXZiuYlRPu/lcQMcf9ukpxJjANbkaZRzB4bUIgdLKxHqHRGRBTUB39zWqh+zHUNnvrAn6UY1a3tba1f7jqhow88W031SvKsUo8zDHEm92mgouKE59BMDFovi15sNDDZ8k9GAYexGy0toM49+DZGWhkVtZUfao7pFJge41VgRmGTB/gSOVDcRPmVAoi00w+yR75L+2Qxg0NuMemSfZl6wqv3SXCOg6cuLqA7mc+fPTdAspVOVpEHkNyfPcuD9VLB/6GXkzJOaoJahiTOugSelJxjOmRn/FXCnv+0f8socXvAZcKTmabgylSWWZN/HpkIVXqKYjpTcL364x6wGBW8QOHDVdUuDDahq5LpS7aiP+SnXgkwTyZ17VyA9CAt4Q/UAExZmJtk6Fho+1CN34jI65Oh/sDNl2dtzUP9AMO8KRfnhZEj8FrfWD6Gb8v3CGkY+VelNsB/dheRhw2WOISJ1E5SEmCYJPKFGwQudtb9IZOzktnERjQZ4P5egO2RaG+P6flEwYAjyYU+jukKg7DofAKCJ+EYoVd3dyTj111O13CEhv3rSTCZ/mr6umBNqKPbsqOQ== mario@DESKTOP-G666QB6"
    ];
  };

  nixpkgs.config.allowUnfree = false;
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    inetutils
  ];

  programs.mtr.enable = true;
  programs.vim.defaultEditor = true;

  services.sysstat.enable = true;
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  environment.shellAliases = {
    c = "clear";
    e = "exit";
    q = "exit";
    h = "history";
    j = "jobs -l";
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.pki.certificates = [ ];

  system.stateVersion = "20.09";
}
