#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltFuncs;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\gametypes\_clientids;

cfgStruc()
{
    self add_menu("glitches cfg", "cfg menu");
    self add_string("glitches cfg", "slowmo", ::test, "1x");
    self add_string("glitches cfg", "delayed lunge", ::test, "<>");
    self add_string("glitches cfg", "fade shot", ::test, "<>");
    self add_string("glitches cfg", "divestall", ::test, "<>");
    self add_string("glitches cfg", "camo nac", ::test, "<>");
    self add_string("glitches cfg", "troika", ::test, "<>");
    self add_string("glitches cfg", "gl camo swap", ::test, "<>");

    self add_menu("submachine gun cfg", "cfg menu");
    self add_sub("submachine gun cfg", "mp5k", "mp5k cfg");
    self add_sub("submachine gun cfg", "skorpion", "skorpion cfg");
    self add_sub("submachine gun cfg", "mac11", "mac11 cfg");
    self add_sub("submachine gun cfg", "ak74u", "ak74u cfg");
    self add_sub("submachine gun cfg", "uzi", "uzi cfg");
    self add_sub("submachine gun cfg", "pm63", "pm63 cfg");
    self add_sub("submachine gun cfg", "mpl", "mpl cfg");
    self add_sub("submachine gun cfg", "spectre", "spectre cfg");
    self add_sub("submachine gun cfg", "kiparis", "kiparis cfg");

    self add_menu("mp5k cfg", "submachine gun cfg");
    self add_string("mp5k cfg", "sleight of hand", ::test, "off");
    self add_string("mp5k cfg", "slowmo", ::test, "1x");
    self add_string("mp5k cfg", "mp5k reload nac", ::test, "<>");
    self add_string("mp5k cfg", "mp5k reload equipment", ::test, "<>");
    self add_string("mp5k cfg", "mp5k reload lethal", ::test, "<>");
    self add_string("mp5k cfg", "mp5k reload tactical", ::test, "<>");
    self add_string("mp5k cfg", "mp5k reload carepack", ::test, "<>");
    self add_string("mp5k cfg", "mp5k adelia", ::test, "<>");

    self add_menu("skorpion cfg", "submachine gun cfg");
    self add_string("skorpion cfg", "sleight of hand", ::test, "off");
    self add_string("skorpion cfg", "slowmo", ::test, "1x");
    self add_string("skorpion cfg", "skorpion reload nac", ::test, "<>");
    self add_string("skorpion cfg", "skorpion reload equipment", ::test, "<>");
    self add_string("skorpion cfg", "skorpion reload lethal", ::test, "<>");
    self add_string("skorpion cfg", "skorpion reload tactical", ::test, "<>");
    self add_string("skorpion cfg", "skorpion reload carepack", ::test, "<>");
    self add_string("skorpion cfg", "skorpion adelia", ::test, "<>");

    self add_menu("mac11 cfg", "submachine gun cfg");
    self add_string("mac11 cfg", "sleight of hand", ::test, "off");
    self add_string("mac11 cfg", "slowmo", ::test, "1x");
    self add_string("mac11 cfg", "mac11 reload nac", ::test, "<>");
    self add_string("mac11 cfg", "mac11 reload equipment", ::test, "<>");
    self add_string("mac11 cfg", "mac11 reload lethal", ::test, "<>");
    self add_string("mac11 cfg", "mac11 reload tactical", ::test, "<>");
    self add_string("mac11 cfg", "mac11 reload carepack", ::test, "<>");
    self add_string("mac11 cfg", "mac11 adelia", ::test, "<>");

    self add_menu("ak74u cfg", "submachine gun cfg");
    self add_string("ak74u cfg", "sleight of hand", ::test, "off");
    self add_string("ak74u cfg", "fast mags", ::test, "off");
    self add_string("ak74u cfg", "slowmo", ::test, "1x");
    self add_string("ak74u cfg", "ak74u reload nac", ::test, "<>");
    self add_string("ak74u cfg", "ak74u reload equipment", ::test, "<>");
    self add_string("ak74u cfg", "ak74u reload lethal", ::test, "<>");
    self add_string("ak74u cfg", "ak74u reload tactical", ::test, "<>");
    self add_string("ak74u cfg", "ak74u reload carepack", ::test, "<>");
    self add_string("ak74u cfg", "ak74u adelia", ::test, "<>");

    self add_menu("uzi cfg", "submachine gun cfg");
    self add_string("uzi cfg", "sleight of hand", ::test, "off");
    self add_string("uzi cfg", "slowmo", ::test, "1x");
    self add_string("uzi cfg", "uzi reload nac", ::test, "<>");
    self add_string("uzi cfg", "uzi reload equipment", ::test, "<>");
    self add_string("uzi cfg", "uzi reload lethal", ::test, "<>");
    self add_string("uzi cfg", "uzi reload tactical", ::test, "<>");
    self add_string("uzi cfg", "uzi reload carepack", ::test, "<>");
    self add_string("uzi cfg", "uzi adelia", ::test, "<>");

    self add_menu("pm63 cfg", "submachine gun cfg");
    self add_string("pm63 cfg", "sleight of hand", ::test, "off");
    self add_string("pm63 cfg", "slowmo", ::test, "1x");
    self add_string("pm63 cfg", "pm63 reload nac", ::test, "<>");
    self add_string("pm63 cfg", "pm63 reload equipment", ::test, "<>");
    self add_string("pm63 cfg", "pm63 reload lethal", ::test, "<>");
    self add_string("pm63 cfg", "pm63 reload tactical", ::test, "<>");
    self add_string("pm63 cfg", "pm63 reload carepack", ::test, "<>");
    self add_string("pm63 cfg", "pm63 adelia", ::test, "<>");

    self add_menu("mpl cfg", "submachine gun cfg");
    self add_string("mpl cfg", "sleight of hand", ::test, "off");
    self add_string("mpl cfg", "fast mags", ::test, "off");
    self add_string("mpl cfg", "slowmo", ::test, "1x");
    self add_string("mpl cfg", "mpl reload nac", ::test, "<>");
    self add_string("mpl cfg", "mpl reload equipment", ::test, "<>");
    self add_string("mpl cfg", "mpl reload lethal", ::test, "<>");
    self add_string("mpl cfg", "mpl reload tactical", ::test, "<>");
    self add_string("mpl cfg", "mpl reload carepack", ::test, "<>");
    self add_string("mpl cfg", "mpl adelia", ::test, "<>");

    self add_menu("spectre cfg", "submachine gun cfg");
    self add_string("spectre cfg", "sleight of hand", ::test, "off");
    self add_string("spectre cfg", "slowmo", ::test, "1x");
    self add_string("spectre cfg", "spectre reload nac", ::test, "<>");
    self add_string("spectre cfg", "spectre reload equipment", ::test, "<>");
    self add_string("spectre cfg", "spectre reload lethal", ::test, "<>");
    self add_string("spectre cfg", "spectre reload tactical", ::test, "<>");
    self add_string("spectre cfg", "spectre reload carepack", ::test, "<>");
    self add_string("spectre cfg", "spectre adelia", ::test, "<>");

    self add_menu("kiparis cfg", "submachine gun cfg");
    self add_string("kiparis cfg", "sleight of hand", ::test, "off");
    self add_string("kiparis cfg", "slowmo", ::test, "1x");
    self add_string("kiparis cfg", "kiparis reload nac", ::test, "<>");
    self add_string("kiparis cfg", "kiparis reload equipment", ::test, "<>");
    self add_string("kiparis cfg", "kiparis reload lethal", ::test, "<>");
    self add_string("kiparis cfg", "kiparis reload tactical", ::test, "<>");
    self add_string("kiparis cfg", "kiparis reload carepack", ::test, "<>");
    self add_string("kiparis cfg", "kiparis adelia", ::test, "<>");

    self add_menu("assault rifle cfg", "cfg menu");
    self add_sub("assault rifle cfg", "m16", "m16 cfg");
    self add_sub("assault rifle cfg", "enfield", "enfield cfg");
    self add_sub("assault rifle cfg", "m14", "m14 cfg");
    self add_sub("assault rifle cfg", "famas", "famas cfg");
    self add_sub("assault rifle cfg", "galil", "galil cfg");
    self add_sub("assault rifle cfg", "aug", "aug cfg");
    self add_sub("assault rifle cfg", "fn fal", "fal cfg");
    self add_sub("assault rifle cfg", "ak47", "ak47 cfg");
    self add_sub("assault rifle cfg", "commando", "commando cfg");
    self add_sub("assault rifle cfg", "g11", "g11 cfg");

    self add_menu("m16 cfg", "assault rifle cfg");
    self add_string("m16 cfg", "sleight of hand", ::test, "off");
    self add_string("m16 cfg", "fast mags", ::test, "off");
    self add_string("m16 cfg", "slowmo", ::test, "1x");
    self add_string("m16 cfg", "m16 reload nac", ::test, "<>");
    self add_string("m16 cfg", "m16 reload equipment", ::test, "<>");
    self add_string("m16 cfg", "m16 reload lethal", ::test, "<>");
    self add_string("m16 cfg", "m16 reload tactical", ::test, "<>");
    self add_string("m16 cfg", "m16 reload carepack", ::test, "<>");
    self add_string("m16 cfg", "m16 adelia", ::test, "<>");

    self add_menu("enfield cfg", "assault rifle cfg");
    self add_string("enfield cfg", "sleight of hand", ::test, "off");
    self add_string("enfield cfg", "fast mags", ::test, "off");
    self add_string("enfield cfg", "slowmo", ::test, "1x");
    self add_string("enfield cfg", "enfield reload nac", ::test, "<>");
    self add_string("enfield cfg", "enfield reload equipment", ::test, "<>");
    self add_string("enfield cfg", "enfield reload lethal", ::test, "<>");
    self add_string("enfield cfg", "enfield reload tactical", ::test, "<>");
    self add_string("enfield cfg", "enfield reload carepack", ::test, "<>");
    self add_string("enfield cfg", "enfield adelia", ::test, "<>");

    self add_menu("m14 cfg", "assault rifle cfg");
    self add_string("m14 cfg", "sleight of hand", ::test, "off");
    self add_string("m14 cfg", "slowmo", ::test, "1x");
    self add_string("m14 cfg", "m14 reload nac", ::test, "<>");
    self add_string("m14 cfg", "m14 reload equipment", ::test, "<>");
    self add_string("m14 cfg", "m14 reload lethal", ::test, "<>");
    self add_string("m14 cfg", "m14 reload tactical", ::test, "<>");
    self add_string("m14 cfg", "m14 reload carepack", ::test, "<>");
    self add_string("m14 cfg", "m14 adelia", ::test, "<>");

    self add_menu("famas cfg", "assault rifle cfg");
    self add_string("famas cfg", "sleight of hand", ::test, "off");
    self add_string("famas cfg", "fast mags", ::test, "off");
    self add_string("famas cfg", "slowmo", ::test, "1x");
    self add_string("famas cfg", "famas reload nac", ::test, "<>");
    self add_string("famas cfg", "famas reload equipment", ::test, "<>");
    self add_string("famas cfg", "famas reload lethal", ::test, "<>");
    self add_string("famas cfg", "famas reload tactical", ::test, "<>");
    self add_string("famas cfg", "famas reload carepack", ::test, "<>");
    self add_string("famas cfg", "famas adelia", ::test, "<>");

    self add_menu("galil cfg", "assault rifle cfg");
    self add_string("galil cfg", "sleight of hand", ::test, "off");
    self add_string("galil cfg", "fast mags", ::test, "off");
    self add_string("galil cfg", "slowmo", ::test, "1x");
    self add_string("galil cfg", "galil reload nac", ::test, "<>");
    self add_string("galil cfg", "galil reload equipment", ::test, "<>");
    self add_string("galil cfg", "galil reload lethal", ::test, "<>");
    self add_string("galil cfg", "galil reload tactical", ::test, "<>");
    self add_string("galil cfg", "galil reload carepack", ::test, "<>");
    self add_string("galil cfg", "galil adelia", ::test, "<>");

    self add_menu("aug cfg", "assault rifle cfg");
    self add_string("aug cfg", "sleight of hand", ::test, "off");
    self add_string("aug cfg", "fast mags", ::test, "off");
    self add_string("aug cfg", "slowmo", ::test, "1x");
    self add_string("aug cfg", "aug reload nac", ::test, "<>");
    self add_string("aug cfg", "aug reload equipment", ::test, "<>");
    self add_string("aug cfg", "aug reload lethal", ::test, "<>");
    self add_string("aug cfg", "aug reload tactical", ::test, "<>");
    self add_string("aug cfg", "aug reload carepack", ::test, "<>");
    self add_string("aug cfg", "aug adelia", ::test, "<>");

    self add_menu("fal cfg", "assault rifle cfg");
    self add_string("fal cfg", "sleight of hand", ::test, "off");
    self add_string("fal cfg", "fast mags", ::test, "off");
    self add_string("fal cfg", "slowmo", ::test, "1x");
    self add_string("fal cfg", "fal reload nac", ::test, "<>");
    self add_string("fal cfg", "fal reload equipment", ::test, "<>");
    self add_string("fal cfg", "fal reload lethal", ::test, "<>");
    self add_string("fal cfg", "fal reload tactical", ::test, "<>");
    self add_string("fal cfg", "fal reload carepack", ::test, "<>");
    self add_string("fal cfg", "fal adelia", ::test, "<>");

    self add_menu("ak47 cfg", "assault rifle cfg");
    self add_string("ak47 cfg", "sleight of hand", ::test, "off");
    self add_string("ak47 cfg", "fast mags", ::test, "off");
    self add_string("ak47 cfg", "slowmo", ::test, "1x");
    self add_string("ak47 cfg", "ak47 reload nac", ::test, "<>");
    self add_string("ak47 cfg", "ak47 reload equipment", ::test, "<>");
    self add_string("ak47 cfg", "ak47 reload lethal", ::test, "<>");
    self add_string("ak47 cfg", "ak47 reload tactical", ::test, "<>");
    self add_string("ak47 cfg", "ak47 reload carepack", ::test, "<>");
    self add_string("ak47 cfg", "ak47 adelia", ::test, "<>");

    self add_menu("commando cfg", "assault rifle cfg");
    self add_string("commando cfg", "sleight of hand", ::test, "off");
    self add_string("commando cfg", "fast mags", ::test, "off");
    self add_string("commando cfg", "slowmo", ::test, "1x");
    self add_string("commando cfg", "commando reload nac", ::test, "<>");
    self add_string("commando cfg", "commando reload equipment", ::test, "<>");
    self add_string("commando cfg", "commando reload lethal", ::test, "<>");
    self add_string("commando cfg", "commando reload tactical", ::test, "<>");
    self add_string("commando cfg", "commando reload carepack", ::test, "<>");
    self add_string("commando cfg", "commando adelia", ::test, "<>");

    self add_menu("g11 cfg", "assault rifle cfg");
    self add_string("g11 cfg", "sleight of hand", ::test, "off");
    self add_string("g11 cfg", "slowmo", ::test, "1x");
    self add_string("g11 cfg", "g11 reload nac", ::test, "<>");
    self add_string("g11 cfg", "g11 reload equipment", ::test, "<>");
    self add_string("g11 cfg", "g11 reload lethal", ::test, "<>");
    self add_string("g11 cfg", "g11 reload tactical", ::test, "<>");
    self add_string("g11 cfg", "g11 reload carepack", ::test, "<>");
    self add_string("g11 cfg", "g11 adelia", ::test, "<>");

    self add_menu("shotgun cfg", "cfg menu");
    self add_sub("shotgun cfg", "olympia", "olympia cfg");
    self add_sub("shotgun cfg", "stakeout", "stakeout cfg");
    self add_sub("shotgun cfg", "spas-12", "spas cfg");
    self add_sub("shotgun cfg", "hs10", "hs10 cfg");

    self add_menu("olympia cfg", "shotgun cfg");
    self add_string("olympia cfg", "sleight of hand", ::test, "off");
    self add_string("olympia cfg", "slowmo", ::test, "1x");
    self add_string("olympia cfg", "olympia reload nac", ::test, "<>");
    self add_string("olympia cfg", "olympia reload equipment", ::test, "<>");
    self add_string("olympia cfg", "olympia reload lethal", ::test, "<>");
    self add_string("olympia cfg", "olympia reload tactical", ::test, "<>");
    self add_string("olympia cfg", "olympia reload carepack", ::test, "<>");
    self add_string("olympia cfg", "olympia adelia", ::test, "<>");

    self add_menu("stakeout cfg", "shotgun cfg");
    self add_string("stakeout cfg", "sleight of hand", ::test, "off");
    self add_string("stakeout cfg", "ads titty nac", ::test, "off");
    self add_string("stakeout cfg", "slowmo", ::test, "1x");
    self add_string("stakeout cfg", "stakeout titty nac", ::test, "<>");
    self add_string("stakeout cfg", "stakeout titty nac equipment", ::test, "<>");
    self add_string("stakeout cfg", "stakeout titty nac lethal", ::test, "<>");
    self add_string("stakeout cfg", "stakeout titty nac tactical", ::test, "<>");
    self add_string("stakeout cfg", "stakeout titty nac carepack", ::test, "<>");
    self add_string("stakeout cfg", "stakeout reload nac", ::test, "<>");
    self add_string("stakeout cfg", "stakeout reload equipment", ::test, "<>");
    self add_string("stakeout cfg", "stakeout reload lethal", ::test, "<>");
    self add_string("stakeout cfg", "stakeout reload tactical", ::test, "<>");
    self add_string("stakeout cfg", "stakeout reload carepack", ::test, "<>");
    self add_string("stakeout cfg", "stakeout adelia", ::test, "<>");

    self add_menu("spas cfg", "shotgun cfg");
    self add_string("spas cfg", "sleight of hand", ::test, "off");
    self add_string("spas cfg", "slowmo", ::test, "1x");
    self add_string("spas cfg", "spas reload nac", ::test, "<>");
    self add_string("spas cfg", "spas reload equipment", ::test, "<>");
    self add_string("spas cfg", "spas reload lethal", ::test, "<>");
    self add_string("spas cfg", "spas reload tactical", ::test, "<>");
    self add_string("spas cfg", "spas reload carepack", ::test, "<>");
    self add_string("spas cfg", "spas adelia", ::test, "<>");

    self add_menu("hs10 cfg", "shotgun cfg");
    self add_string("hs10 cfg", "sleight of hand", ::test, "off");
    self add_string("hs10 cfg", "slowmo", ::test, "1x");
    self add_string("hs10 cfg", "hs10 reload nac", ::test, "<>");
    self add_string("hs10 cfg", "hs10 reload equipment", ::test, "<>");
    self add_string("hs10 cfg", "hs10 reload lethal", ::test, "<>");
    self add_string("hs10 cfg", "hs10 reload tactical", ::test, "<>");
    self add_string("hs10 cfg", "hs10 reload carepack", ::test, "<>");
    self add_string("hs10 cfg", "hs10 adelia", ::test, "<>");

    self add_menu("lightmachine gun cfg", "cfg menu");
    self add_sub("lightmachine gun cfg", "hk21", "hk21 cfg");
    self add_sub("lightmachine gun cfg", "rpk", "rpk cfg");
    self add_sub("lightmachine gun cfg", "m60", "m60 cfg");
    self add_sub("lightmachine gun cfg", "stoner 63", "stoner cfg");

    self add_menu("hk21 cfg", "lightmachine gun cfg");
    self add_string("hk21 cfg", "sleight of hand", ::test, "off");
    self add_string("hk21 cfg", "slowmo", ::test, "1x");
    self add_string("hk21 cfg", "hk21 reload nac", ::test, "<>");
    self add_string("hk21 cfg", "hk21 reload equipment", ::test, "<>");
    self add_string("hk21 cfg", "hk21 reload lethal", ::test, "<>");
    self add_string("hk21 cfg", "hk21 reload tactical", ::test, "<>");
    self add_string("hk21 cfg", "hk21 reload carepack", ::test, "<>");
    self add_string("hk21 cfg", "hk21 adelia", ::test, "<>");

    self add_menu("rpk cfg", "lightmachine gun cfg");
    self add_string("rpk cfg", "sleight of hand", ::test, "off");
    self add_string("rpk cfg", "fast mags", ::test, "off");
    self add_string("rpk cfg", "slowmo", ::test, "1x");
    self add_string("rpk cfg", "rpk reload nac", ::test, "<>");
    self add_string("rpk cfg", "rpk reload equipment", ::test, "<>");
    self add_string("rpk cfg", "rpk reload lethal", ::test, "<>");
    self add_string("rpk cfg", "rpk reload tactical", ::test, "<>");
    self add_string("rpk cfg", "rpk reload carepack", ::test, "<>");
    self add_string("rpk cfg", "rpk adelia", ::test, "<>");

    self add_menu("m60 cfg", "lightmachine gun cfg");
    self add_string("m60 cfg", "sleight of hand", ::test, "off");
    self add_string("m60 cfg", "slowmo", ::test, "1x");
    self add_string("m60 cfg", "m60 reload nac", ::test, "<>");
    self add_string("m60 cfg", "m60 reload equipment", ::test, "<>");
    self add_string("m60 cfg", "m60 reload lethal", ::test, "<>");
    self add_string("m60 cfg", "m60 reload tactical", ::test, "<>");
    self add_string("m60 cfg", "m60 reload carepack", ::test, "<>");
    self add_string("m60 cfg", "m60 adelia", ::test, "<>");

    self add_menu("stoner cfg", "lightmachine gun cfg");
    self add_string("stoner cfg", "sleight of hand", ::test, "off");
    self add_string("stoner cfg", "slowmo", ::test, "1x");
    self add_string("stoner cfg", "stoner reload nac", ::test, "<>");
    self add_string("stoner cfg", "stoner reload equipment", ::test, "<>");
    self add_string("stoner cfg", "stoner reload lethal", ::test, "<>");
    self add_string("stoner cfg", "stoner reload tactical", ::test, "<>");
    self add_string("stoner cfg", "stoner reload carepack", ::test, "<>");
    self add_string("stoner cfg", "stoner adelia", ::test, "<>");

    self add_menu("sniper cfg", "cfg menu");
    self add_sub("sniper cfg", "dragunov", "dragunov cfg");
    self add_sub("sniper cfg", "wa2000", "wa2000 cfg");
    self add_sub("sniper cfg", "l96a1", "l96a1 cfg");
    self add_sub("sniper cfg", "psg1", "psg1 cfg");

    self add_menu("dragunov cfg", "sniper cfg");
    self add_string("dragunov cfg", "sleight of hand", ::test, "off");
    self add_string("dragunov cfg", "slowmo", ::test, "1x");
    self add_string("dragunov cfg", "dragunov reload nac", ::test, "<>");
    self add_string("dragunov cfg", "dragunov reload equipment", ::test, "<>");
    self add_string("dragunov cfg", "dragunov reload lethal", ::test, "<>");
    self add_string("dragunov cfg", "dragunov reload tactical", ::test, "<>");
    self add_string("dragunov cfg", "dragunov reload carepack", ::test, "<>");
    self add_string("dragunov cfg", "dragunov adelia", ::test, "<>");

    self add_menu("wa2000 cfg", "sniper cfg");
    self add_string("wa2000 cfg", "sleight of hand", ::test, "off");
    self add_string("wa2000 cfg", "slowmo", ::test, "1x");
    self add_string("wa2000 cfg", "wa2000 reload nac", ::test, "<>");
    self add_string("wa2000 cfg", "wa2000 reload equipment", ::test, "<>");
    self add_string("wa2000 cfg", "wa2000 reload lethal", ::test, "<>");
    self add_string("wa2000 cfg", "wa2000 reload tactical", ::test, "<>");
    self add_string("wa2000 cfg", "wa2000 reload carepack", ::test, "<>");
    self add_string("wa2000 cfg", "wa2000 adelia", ::test, "<>");

    self add_menu("l96a1 cfg", "sniper cfg");
    self add_string("l96a1 cfg", "sleight of hand", ::test, "off");
    self add_string("l96a1 cfg", "fast reload nac", ::test, "off");
    self add_string("l96a1 cfg", "ads titty nac", ::test, "off");
    self add_string("l96a1 cfg", "slowmo", ::test, "1x");
    self add_string("l96a1 cfg", "l96a1 titty nac", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 titty nac equipment", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 titty nac lethal", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 titty nac tactical", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 titty nac carepack", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 reload nac", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 reload equipment", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 reload lethal", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 reload tactical", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 reload carepack", ::test, "<>");
    self add_string("l96a1 cfg", "l96a1 adelia", ::test, "<>");

    self add_menu("psg1 cfg", "sniper cfg");
    self add_string("psg1 cfg", "sleight of hand", ::test, "off");
    self add_string("psg1 cfg", "slowmo", ::test, "1x");
    self add_string("psg1 cfg", "psg1 reload nac", ::test, "<>");
    self add_string("psg1 cfg", "psg1 reload equipment", ::test, "<>");
    self add_string("psg1 cfg", "psg1 reload lethal", ::test, "<>");
    self add_string("psg1 cfg", "psg1 reload tactical", ::test, "<>");
    self add_string("psg1 cfg", "psg1 reload carepack", ::test, "<>");
    self add_string("psg1 cfg", "psg1 adelia", ::test, "<>");

    self add_menu("pistol cfg", "cfg menu");
    self add_sub("pistol cfg", "asp", "asp cfg");
    self add_sub("pistol cfg", "m1911", "m1911 cfg");
    self add_sub("pistol cfg", "makarov", "makarov cfg");
    self add_sub("pistol cfg", "python", "python cfg");
    self add_sub("pistol cfg", "cz75", "cz75 cfg");

    self add_menu("asp cfg", "pistol cfg");
    self add_string("asp cfg", "sleight of hand", ::test, "off");
    self add_string("asp cfg", "slowmo", ::test, "1x");
    self add_string("asp cfg", "asp reload nac", ::test, "<>");
    self add_string("asp cfg", "asp reload equipment", ::test, "<>");
    self add_string("asp cfg", "asp reload lethal", ::test, "<>");
    self add_string("asp cfg", "asp reload tactical", ::test, "<>");
    self add_string("asp cfg", "asp reload carepack", ::test, "<>");
    self add_string("asp cfg", "asp adelia", ::test, "<>");

    self add_menu("m1911 cfg", "pistol cfg");
    self add_string("m1911 cfg", "sleight of hand", ::test, "off");
    self add_string("m1911 cfg", "slowmo", ::test, "1x");
    self add_string("m1911 cfg", "m1911 reload nac", ::test, "<>");
    self add_string("m1911 cfg", "m1911 reload equipment", ::test, "<>");
    self add_string("m1911 cfg", "m1911 reload lethal", ::test, "<>");
    self add_string("m1911 cfg", "m1911 reload tactical", ::test, "<>");
    self add_string("m1911 cfg", "m1911 reload carepack", ::test, "<>");
    self add_string("m1911 cfg", "m1911 adelia", ::test, "<>");

    self add_menu("makarov cfg", "pistol cfg");
    self add_string("makarov cfg", "sleight of hand", ::test, "off");
    self add_string("makarov cfg", "slowmo", ::test, "1x");
    self add_string("makarov cfg", "makarov reload nac", ::test, "<>");
    self add_string("makarov cfg", "makarov reload equipment", ::test, "<>");
    self add_string("makarov cfg", "makarov reload lethal", ::test, "<>");
    self add_string("makarov cfg", "makarov reload tactical", ::test, "<>");
    self add_string("makarov cfg", "makarov reload carepack", ::test, "<>");
    self add_string("makarov cfg", "makarov adelia", ::test, "<>");

    self add_menu("python cfg", "pistol cfg");
    self add_string("python cfg", "sleight of hand", ::test, "off");
    self add_string("python cfg", "speed reloader", ::test, "off");
    self add_string("python cfg", "slowmo", ::test, "1x");
    self add_string("python cfg", "python reload nac", ::test, "<>");
    self add_string("python cfg", "python reload equipment", ::test, "<>");
    self add_string("python cfg", "python reload lethal", ::test, "<>");
    self add_string("python cfg", "python reload tactical", ::test, "<>");
    self add_string("python cfg", "python reload carepack", ::test, "<>");
    self add_string("python cfg", "python adelia", ::test, "<>");

    self add_menu("cz75 cfg", "pistol cfg");
    self add_string("cz75 cfg", "sleight of hand", ::test, "off");
    self add_string("cz75 cfg", "slowmo", ::test, "1x");
    self add_string("cz75 cfg", "cz75 reload nac", ::test, "<>");
    self add_string("cz75 cfg", "cz75 reload equipment", ::test, "<>");
    self add_string("cz75 cfg", "cz75 reload lethal", ::test, "<>");
    self add_string("cz75 cfg", "cz75 reload tactical", ::test, "<>");
    self add_string("cz75 cfg", "cz75 reload carepack", ::test, "<>");
    self add_string("cz75 cfg", "cz75 adelia", ::test, "<>");

    self add_menu("launcher cfg", "cfg menu");
    self add_sub("launcher cfg", "m72 law", "m72 law cfg");
    self add_sub("launcher cfg", "rpg", "rpg cfg");
    self add_sub("launcher cfg", "strela-3", "strela cfg");
    self add_sub("launcher cfg", "china lake", "china lake cfg");

    self add_menu("m72 law cfg", "launcher cfg");
    self add_string("m72 law cfg", "sleight of hand", ::test, "off");
    self add_string("m72 law cfg", "slowmo", ::test, "1x");
    self add_string("m72 law cfg", "m72 law reload nac", ::test, "<>");
    self add_string("m72 law cfg", "m72 law reload equipment", ::test, "<>");
    self add_string("m72 law cfg", "m72 law reload lethal", ::test, "<>");
    self add_string("m72 law cfg", "m72 law reload tactical", ::test, "<>");
    self add_string("m72 law cfg", "m72 law reload carepack", ::test, "<>");
    self add_string("m72 law cfg", "m72 law adelia", ::test, "<>");

    self add_menu("rpg cfg", "launcher cfg");
    self add_string("rpg cfg", "sleight of hand", ::test, "off");
    self add_string("rpg cfg", "slowmo", ::test, "1x");
    self add_string("rpg cfg", "rpg reload nac", ::test, "<>");
    self add_string("rpg cfg", "rpg reload equipment", ::test, "<>");
    self add_string("rpg cfg", "rpg reload lethal", ::test, "<>");
    self add_string("rpg cfg", "rpg reload tactical", ::test, "<>");
    self add_string("rpg cfg", "rpg reload carepack", ::test, "<>");
    self add_string("rpg cfg", "rpg adelia", ::test, "<>");

    self add_menu("strela cfg", "launcher cfg");
    self add_string("strela cfg", "sleight of hand", ::test, "off");
    self add_string("strela cfg", "slowmo", ::test, "1x");
    self add_string("strela cfg", "strela reload nac", ::test, "<>");
    self add_string("strela cfg", "strela reload equipment", ::test, "<>");
    self add_string("strela cfg", "strela reload lethal", ::test, "<>");
    self add_string("strela cfg", "strela reload tactical", ::test, "<>");
    self add_string("strela cfg", "strela reload carepack", ::test, "<>");
    self add_string("strela cfg", "strela adelia", ::test, "<>");

    self add_menu("china lake cfg", "launcher cfg");
    self add_string("china lake cfg", "sleight of hand", ::test, "off");
    self add_string("china lake cfg", "slowmo", ::test, "1x");
    self add_string("china lake cfg", "china lake reload nac", ::test, "<>");
    self add_string("china lake cfg", "china lake reload equipment", ::test, "<>");
    self add_string("china lake cfg", "china lake reload lethal", ::test, "<>");
    self add_string("china lake cfg", "china lake reload tactical", ::test, "<>");
    self add_string("china lake cfg", "china lake reload carepack", ::test, "<>");
    self add_string("china lake cfg", "china lake adelia", ::test, "<>");

    self add_menu("special cfg", "cfg menu");
    self add_sub("special cfg", "ballistic knife", "ballistic knife cfg");
    self add_sub("special cfg", "crossbow", "crossbow cfg");

    self add_menu("ballistic knife cfg", "special cfg");
    self add_string("ballistic knife cfg", "sleight of hand", ::test, "off");
    self add_string("ballistic knife cfg", "slowmo", ::test, "1x");
    self add_string("ballistic knife cfg", "ballistic knife reload nac", ::test, "<>");
    self add_string("ballistic knife cfg", "ballistic knife reload equipment", ::test, "<>");
    self add_string("ballistic knife cfg", "ballistic knife reload lethal", ::test, "<>");
    self add_string("ballistic knife cfg", "ballistic knife reload tactical", ::test, "<>");
    self add_string("ballistic knife cfg", "ballistic knife reload carepack", ::test, "<>");
    self add_string("ballistic knife cfg", "ballistic knife adelia", ::test, "<>");

    self add_menu("crossbow cfg", "special cfg");
    self add_string("crossbow cfg", "sleight of hand", ::test, "off");
    self add_string("crossbow cfg", "slowmo", ::test, "1x");
    self add_string("crossbow cfg", "crossbow reload nac", ::test, "<>");
    self add_string("crossbow cfg", "crossbow reload equipment", ::test, "<>");
    self add_string("crossbow cfg", "crossbow reload lethal", ::test, "<>");
    self add_string("crossbow cfg", "crossbow reload tactical", ::test, "<>");
    self add_string("crossbow cfg", "crossbow reload carepack", ::test, "<>");
    self add_string("crossbow cfg", "crossbow adelia", ::test, "<>");

    self add_menu("extras cfg", "cfg menu");
    self add_sub("extras cfg", "masterkey", "masterkey cfg");
    self add_sub("extras cfg", "flame thrower", "flame thrower cfg");
    self add_sub("extras cfg", "grenade launcher", "grenade launcher cfg");

    self add_menu("masterkey cfg", "extras cfg");
    self add_string("masterkey cfg", "sleight of hand", ::test, "off");
    self add_string("masterkey cfg", "slowmo", ::test, "1x");
    self add_string("masterkey cfg", "masterkey reload nac", ::test, "<>");
    self add_string("masterkey cfg", "masterkey reload equipment", ::test, "<>");
    self add_string("masterkey cfg", "masterkey reload lethal", ::test, "<>");
    self add_string("masterkey cfg", "masterkey reload tactical", ::test, "<>");
    self add_string("masterkey cfg", "masterkey reload carepack", ::test, "<>");
    self add_string("masterkey cfg", "masterkey adelia", ::test, "<>");
    self add_string("masterkey cfg", "masterkey nac", ::test, "<>");
    self add_string("masterkey cfg", "masterkey nac equipment", ::test, "<>");
    self add_string("masterkey cfg", "masterkey nac streak", ::test, "<>");

    self add_menu("flame thrower cfg", "extras cfg");
    self add_string("flame thrower cfg", "sleight of hand", ::test, "off");
    self add_string("flame thrower cfg", "slowmo", ::test, "1x");
    self add_string("flame thrower cfg", "ft reload nac", ::test, "<>");
    self add_string("flame thrower cfg", "ft reload equipment", ::test, "<>");
    self add_string("flame thrower cfg", "ft reload lethal", ::test, "<>");
    self add_string("flame thrower cfg", "ft reload tactical", ::test, "<>");
    self add_string("flame thrower cfg", "ft reload carepack", ::test, "<>");
    self add_string("flame thrower cfg", "ft adelia", ::test, "<>");

    self add_menu("grenade launcher cfg", "extras cfg");
    self add_string("grenade launcher cfg", "sleight of hand", ::test, "off");
    self add_string("grenade launcher cfg", "slowmo", ::test, "1x");
    self add_string("grenade launcher cfg", "gl reload nac", ::test, "<>");
    self add_string("grenade launcher cfg", "gl reload equipment", ::test, "<>");
    self add_string("grenade launcher cfg", "gl reload lethal", ::test, "<>");
    self add_string("grenade launcher cfg", "gl reload tactical", ::test, "<>");
    self add_string("grenade launcher cfg", "gl reload carepack", ::test, "<>");
    self add_string("grenade launcher cfg", "gl adelia", ::test, "<>");
}