{
  description = "Modular nix-darwin + home-manager setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }: 

    let
      configuration = { pkgs, ... }: {
        environment.systemPackages = [
          pkgs.vim
          pkgs.git
        ];

        # Disable Nix management from nix-darwin to avoid conflicts with Determinate
        nix.enable = false;


        nix.settings.experimental-features = "nix-command flakes";
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 6;
        nixpkgs.hostPlatform = "aarch64-darwin";

        users.users."ryan.heath" = {
          home = "/Users/ryan.heath";
          shell = pkgs.zsh;
        };

      };
    in {
      darwinConfigurations."AHD-GCQ07Y369X" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."ryan.heath" = import ./users/ryan.nix;
          }
        ];
      };
    };
}

