# niri - Wayland compositor configuration (~/.config/niri/)
# KDL files managed via xdg.configFile; source lives in niri/dot_config/niri/.

{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/config.kdl;
  };
  xdg.configFile."niri/environment.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/environment.kdl;
  };
  xdg.configFile."niri/workspaces.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/workspaces.kdl;
  };
  xdg.configFile."niri/input.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/input.kdl;
  };
  xdg.configFile."niri/outputs.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/outputs.kdl;
  };
  xdg.configFile."niri/layout.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/layout.kdl;
  };
  xdg.configFile."niri/animations.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/animations.kdl;
  };
  xdg.configFile."niri/rules.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/rules.kdl;
  };
  xdg.configFile."niri/binds.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/binds.kdl;
  };
  xdg.configFile."niri/dms/alttab.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/dms/alttab.kdl;
  };
  xdg.configFile."niri/dms/binds.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/dms/binds.kdl;
  };
  xdg.configFile."niri/dms/colors.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/dms/colors.kdl;
  };
  xdg.configFile."niri/dms/cursor.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/dms/cursor.kdl;
  };
  xdg.configFile."niri/dms/outputs.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/dms/outputs.kdl;
  };
  xdg.configFile."niri/dms/wpblur.kdl" = {
    force = true;
    source = ../../niri/dot_config/niri/dms/wpblur.kdl;
  };
}
