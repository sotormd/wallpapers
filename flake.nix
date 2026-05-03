{
  description = "wallpapers flake";

  outputs =
    _:
    let
      wallpapersDir = ./wallpapers;

      # recursive function to collect wallpapers into nested attrs
      collect =
        dirPath:
        let
          entries = builtins.readDir dirPath;
          names = builtins.attrNames entries;
        in
        builtins.listToAttrs (
          builtins.concatMap (
            name:
            let
              type = entries.${name};
            in
            if type == "directory" then
              [
                {
                  name = name;
                  value = collect "${dirPath}/${name}";
                }
              ]
            else if type == "regular" && builtins.match ".*\\.png$" name != null then
              [
                {
                  name = builtins.replaceStrings [ ".png" ] [ "" ] name;
                  value = "${dirPath}/${name}";
                }
              ]
            else
              [ ]
          ) names
        );

      wallpapers = collect wallpapersDir;
    in
    {
      lib.wallpapers = wallpapers;

      nixosModules.wallpapers =
        { lib, ... }:
        {
          options.wallpapers = lib.mkOption {
            type = lib.types.attrs;
            readOnly = true;
            default = wallpapers;
            description = "Wallpaper collection exposed by the wallpapers flake.";
          };
        };
    };
}
