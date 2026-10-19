{ ... }:

{
  imports = [
    ./configuration.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
}
