{ pkgs, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nekomangini = {
    isNormalUser = true;
    description = "encar salazar";
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      # NOTE LAPTOP(VOID LINUX)
      # Maaaaaa! pa void
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKOlwmNBZHDXRpqpneubWYPGtMZaa2X+Fr5BMuzmkEOq nekomangini.dev@gmail.com"

      # NOTE vivo1920
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJg+EOqubgM3M6fIUFnhbXGwxXkQ1CsY7DTIi9k9JOy8 vivo1920"

      # NOTE samsong
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7fj7XtnxHt4KUVxrEbb8LIvnZhd8oODRmbm3f7/feI a05s"
    ];
  };
}
