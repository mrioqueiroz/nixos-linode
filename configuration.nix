{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.copyKernels = true;
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.grub.forceInstall = true;
  boot.loader.timeout = 10;
  boot.cleanTmpDir = true;
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial;
  '';

  fileSystems."/" =
    { device = "/dev/sda";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/sdb"; }
    ];

  time.timeZone = "America/Sao_Paulo";

  networking.hostName = "nixos-linode";
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.usePredictableInterfaceNames = false;
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  users.users.root = {
    initialHashedPassword = "$6$6iyK0WLdCV$EJQZB2FQ5DwDPrY3WIG9TlPgaFquY50AJk8dlO0e8gbYHNJsUkgT.h1/shHZ/EMzXHRG0IvMeAbNmSQ/qDjNg/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDB3m/bdUSpSRJpX3MBV9XfDTkhqOVsf6QUjUc9sMdCtNKT95X/59+/OVT0mfjU0MabjphobwwkRaCi6BjDBY0aVpscB0F7e7zLn4DdmKqJXZiuYlRPu/lcQMcf9ukpxJjANbkaZRzB4bUIgdLKxHqHRGRBTUB39zWqh+zHUNnvrAn6UY1a3tba1f7jqhow88W031SvKsUo8zDHEm92mgouKE59BMDFovi15sNDDZ8k9GAYexGy0toM49+DZGWhkVtZUfao7pFJge41VgRmGTB/gSOVDcRPmVAoi00w+yR75L+2Qxg0NuMemSfZl6wqv3SXCOg6cuLqA7mc+fPTdAspVOVpEHkNyfPcuD9VLB/6GXkzJOaoJahiTOugSelJxjOmRn/FXCnv+0f8socXvAZcKTmabgylSWWZN/HpkIVXqKYjpTcL364x6wGBW8QOHDVdUuDDahq5LpS7aiP+SnXgkwTyZ17VyA9CAt4Q/UAExZmJtk6Fho+1CN34jI65Oh/sDNl2dtzUP9AMO8KRfnhZEj8FrfWD6Gb8v3CGkY+VelNsB/dheRhw2WOISJ1E5SEmCYJPKFGwQudtb9IZOzktnERjQZ4P5egO2RaG+P6flEwYAjyYU+jukKg7DofAKCJ+EYoVd3dyTj111O13CEhv3rSTCZ/mr6umBNqKPbsqOQ== mario@DESKTOP-G666QB6"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7pKPhPotWFledagP07MyfuKDGZUeq4+/hSpK2Kznvhq5csXZ98Vex/f8SCxb7YSo7hWgxstFlbwlQJGgtWCSYKA8VxD2geM1D97C4Ei4eF5nYLvmUoixxwcpQC3tmIEn8GvCENp2KAox3MpxQSMn38CtYqRn7uFLLdfwLCcsI8LufRQXYHHvzy2pHX/gQvC+/srUg/HbvxZT6CGQREO0CSQVkb0xXKeYsRquXgEFD0w9YjVZFccNJOxTOEnw66NRMOehqWMXdQsNhLvgJXC5PAFc3hUCl5ywKCFhWfWr5YBFV30KSNtV+kRyTg5QWCVbtum8DqgggejiTvMdn/OSOGPKdp3qUsVRYXcfxyeHUM/Vi2F9LHnixWVzJ1NH2F/hEP9zxbClDGWSyoBS6vxAEX1vTh6SQOfFmXGqj4aYjbLrGYA1avBIJOXb8h3wp8U+9Iua0FB96XdgU/Bq2LoLZ/H56VCdOoxJ6/xNIehk7gLR5FemgOmjrxlYgJxjra+A36uw3eYUXBOFjnwusQZDOKzHtsRzfR0UpzBM4Uy+hp/njWxp0xAT7+yFEhYaMYJSllEEEEkdbchy9Vw2A5HAtiMhWkEcrvkc5fBdQikRVJnm3YrFNGyKDiQYlX5Le5RQsOSi68fZdajtmnGv3SGHiaN7xH/09N6k6xLEGFyqvbQ== mario@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIObeiyTkBS+XFNqipAz2QcNyGcj9UfJke5MCdEsIQ2Og mario@nixos-dell"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    inetutils
  ];

  programs.mtr.enable = true;
  programs.vim.defaultEditor = true;

  services.sysstat.enable = false;
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.openssh.passwordAuthentication = false;
  services.openssh.ports = [ 50022 ];

  environment.shellAliases = {
    c = "clear";
    e = "exit";
    q = "exit";
    h = "history";
    j = "jobs -l";
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.pki.certificates = [ ];

  nix.gc.automatic = false;
  nix.gc.dates = "03:15";

  system.stateVersion = "20.09";
}
