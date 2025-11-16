# import & decrypt secrets in `mysecrets` in this module
{ config, pkgs, agenix, ... }:

{
  # if you changed this key, you need to regenerate all encrypt files from the decrypt contents!
  age.identityPaths = [
    # using the host key for decryption
    # the host key is generated on every host locally by openssh, and will never leave the host.
    "/root/.ssh/id_ed25519"
  ];

  # age.secrets."xxx" = {
  #   # whether secrets are symlinked to age.secrets.<name>.path
  #   symlink = true;
  #   # target path for decrypted file
  #   path = "/etc//";
  #   # encrypted file path
  #   file =  "${mysecrets}/xxx.age";  # refer to ./xxx.age located in `mysecrets` repo
  #   mode = "0400";
  #   owner = "root";
  #   group = "root";
  # };
}
