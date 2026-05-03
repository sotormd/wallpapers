# Wallpapers Flake

Exposes wallpapers in `wallpapers/` as nix expressions.

For example, `wallpapers/nord/mario.png` is `wallpapers.nord.mario`.

See [preview.md](./preview.md) for all wallpapers.

# Usage

1. Add `github:sotormd/wallpapers` as a flake input

2. Use the wallpapers exposed under `lib.wallpapers` or import the
   `nixosModules.wallpapers`, which provides all wallpapers under
   `config.wallpapers`.

# Sources

- [linuxdotexe/nordic-wallpapers](https://github.com/linuxdotexe/nordic-wallpapers/)
- [gruvbox-wallpapers.pages.dev](https://gruvbox-wallpapers.pages.dev/)
- [unsplash](https://unsplash.com/)

Some wallpapers were recolored using
[sotormd/nordify](https://github.com/sotormd/nordify).
