{ firefox-addons, pkgs, ... }@inputs :

{
  # https://mozilla.github.io/policy-templates/
  ## https://mozilla.github.io/policy-templates/#extensions
  programs.firefox = {
    enable = true;
    # https://mynixos.com/home-manager/options/programs.firefox.profiles.%3Cname%3E
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      extensions.packages = with firefox-addons.packages.${pkgs.system}; [ 
        ublock-origin
        bitwarden 
        vimium
      ];
    };
  };
}
