# Wallpapers Flake

Exposes wallpapers in `wallpapers/` as nix expressions.

For example, `wallpapers/nord/mario.png` is `wallpapers.nord.mario`.

See [preview.md](./preview.md) for all wallpapers.

# Usage

1. Add `sotormd:wallpapers` as a flake input

   Also add `inherit (wallpapers.lib) wallpapers` in the `specialArgs` of your NixOS configuration outputs.

   <details>
   <summary>Click to expand example</summary>

   ```nix
   {
      description = "example nixos configuration flake";

      inputs = {
        nixpkgs = {
          url = "github:nixos/nixpkgs/nixos-unstable";
        };

        home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        wallpapers = {
          url = "github:sotormd/wallpapers";
        };

        # other inputs here
        # ...
      };

      outputs =
        {
          self,
          nixpkgs,
          home-manager,
          wallpapers,
          ...
        }@inputs:

        {

          # example nixos configuration
          nixosConfigurations.example = nixpkgs.lib.nixosSystem {
        
            specialArgs = {
              inherit inputs;
              inherit (wallpapers.lib) wallpapers;
            };
            
            modules = [
              # example entry point to configuration
              ./hosts/example.nix

              # home manager - to declaratively manage home directory
              home-manager.nixosModules.home-manager

              # other modules here
              # ...
            ];
          
          };

          # other outputs here
          # ...

        };
    }
   ```
   </details>

4. Use the wallpapers in your configuration.

   For example, to use `wallpapers/nord/building.png`, the nix expression is `wallpapers.nord.building`.
  
   <details>
    <summary>Click to expand example</summary>

    ```nix
     { wallpapers, ... }:

     {
       home-manager.users.myUsername = {
         wayland.windowManager.sway.config.output."*".bg = "${wallpapers.nord.building} fill";
       };
     }
    ```
    </details>

# Sources

- [linuxdotexe:nordic-wallpapers](https://github.com/linuxdotexe/nordic-wallpapers/)
- [gruvbox-wallpapers.pages.dev](https://gruvbox-wallpapers.pages.dev/)
- [unsplash](https://unsplash.com/)

Some wallpapers were recolored using [sotormd:nordify](https://github.com/sotormd/nordify).

