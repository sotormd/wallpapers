{
  description = "wallpapers flake";

  outputs = { self, ... }: let
    wallpapersDir = ./wallpapers;

    # recursive function to collect wallpapers into nested attrs
    collect = dirPath:
      let
        entries = builtins.readDir dirPath;
        validNames = builtins.attrNames entries;
      in builtins.listToAttrs (builtins.concatMap (name:
        let
          type = entries.${name};
        in
          if type == "directory" then [{
            name = name;
            value = collect "${dirPath}/${name}";
          }]
          else if type == "regular" && builtins.match ".*\\.png$" name != null then [{
            name = builtins.replaceStrings [ ".png" ] [ "" ] name;
            value = "${dirPath}/${name}";
          }]
          else []
      ) validNames);

    wallpapers = collect wallpapersDir;
  in {
    lib.wallpapers = wallpapers;
  };
}
