#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\gametypes\_clientids;
#include maps\mp\RevoltMenu\_revoltFuncs;
#include maps\mp\RevoltMenu\_revoltBots;
#include maps\mp\RevoltMenu\_revoltWeapons;
#include maps\mp\RevoltMenu\_revoltBinds;
#include maps\mp\RevoltMenu\_revoltTeleportStruc;

/*
TODO LIST
1. Fix the aimbot toggle
2. do spawn helicopter
3. do spawn rcxd
4. do spawn dog
5. change bots appearance
6. Fix afterhits
7. Do cfg
8. add 1 minute
9. remove 1 minute
*/

structure(){
	self thread menu_struct();
}

menu_struct(){
  self add_menu("revolt", "exit");
  self add_sub("revolt", "main menu", "main menu");
  self add_sub("revolt", "aimbot menu", "aimbot menu");
  self add_sub("revolt", "teleport menu", "teleport menu");
  self add_sub("revolt", "spawnables menu", "spawnables menu");
  self add_sub("revolt", "binds menu", "binds menu");
  self add_sub("revolt", "perks menu", "perks menu");
  self add_sub("revolt", "killstreak menu", "killstreak menu");
  self add_sub("revolt", "weapons menu", "weapons menu");
  self add_sub("revolt", "bots menu", "bots menu");
  self add_sub("revolt", "trickshot menu", "trickshot menu"); 
  //self add_sub("revolt", "cfg menu", "cfg menu");
  self add_sub("revolt", "green screen menu", "green screen menu");
  self add_sub("revolt", "movement menu", "movement menu");
  self add_sub("revolt", "account menu", "account menu");
  self add_sub("revolt", "admin menu", "admin menu");
  self add_sub("revolt", "clients menu", "clients menu");

  self add_menu("main menu", "revolt");
  self add_bool("main menu", "god mode", ::ToggleGod, self.pers["GodBool"]);
  self add_bool("main menu", "invisibility", ::toggle_invs, self.pers["invisBool"]);
  self add_option("main menu", "ufo mode", ::ToggleNoclip);
  self add_bool("main menu", "infinite ammo", ::ToggleAmmo, self.pers["AmmoBool"]);
  self add_bool("main menu", "infinite equipment", ::ToggleInfEquipment, self.pers["EquipBool"]);
  self add_bool("main menu", "pro mod", ::ToggleFOV, self.pers["fovBool"]);
  self add_bool("main menu", "third person", ::Third, self.pers["thirdBool"]);
  self add_bool("main menu", "movement speed", ::superSpeed, self.pers["speedBool"]);
  self add_bool("main menu", "moving gun", ::togglemovinggun, self.pers["movingBool"]);
  self add_bool("main menu", "disable weapon", ::disableWeapon, self.pers["DWeapBool"]);
  self add_bool("main menu", "invisible gun", ::nogunC, self.pers["InvisWeapBool"]);
  self add_bool("main menu", "rapid fire", ::RapidFire, self.pers["RapidBool"]);
  self add_bool("main menu", "drop shot", ::autodropshot, self.pers["DropBool"]);
  self add_option("main menu", "suicide", ::kys);

  self add_menu("aimbot menu", "revolt");
  self add_bool("aimbot menu", "toggle aimbot", ::ToggleAimbot, self.pers["aimbotToggle"]);
  self add_string("aimbot menu", "aimbot weapon", ::AimbotWeapon, self.pers["AimbotWeapon"]);
  self add_string("aimbot menu", "aimbot strength", ::aimbotRadius, self.pers["aimbotRadiusPrint"]);
  self add_string("aimbot menu", "aimbot delay", ::aimbotDelay, self.pers["aimbotDelayPrint"]);
  self add_bool("aimbot menu", "hitmarker aimbot", ::hitmarkerAimbot, self.pers["hitmarkerToggle"]);
  self add_string("aimbot menu", "hitmarker weapon", ::hitmarkerWeapon, self.pers["hitmarkerWeapon"]);
  self add_string("aimbot menu", "hitmarker strength", ::hitmarkerRadius, "" + self.pers["hitmarkerRadius"] + "");
  self add_string("aimbot menu", "hitmarker delay", ::hitmarkerDelay, "" + self.pers["hitmarkerDelay"] + "");

  self add_menu("teleport menu", "revolt");
  self add_option("teleport menu", "save location", ::savePosition);
  self add_option("teleport menu", "load location", ::loadPosition);
  self add_bool("teleport menu", "save and load bind", ::saveandload, self.pers["snlBool"]);
  self add_bool("teleport menu", "teleport gun", ::TeleportGun, self.pers["tpgBool"]);  
  self add_sub("teleport menu", "move yourself", "move yourself");
  self add_sub("teleport menu", "map teleports", "map teleports");
  self add_option("teleport menu", "load shot location", ::MapSavedLocation);

  self add_menu("move yourself", "teleport menu");
  self add_option("move yourself", "move north", ::selfMove, "n");
  self add_option("move yourself", "move north east", ::selfMove,"ne");
  self add_option("move yourself", "move east", ::selfMove, "e");
  self add_option("move yourself", "move south east", ::selfMove, "se");
  self add_option("move yourself", "move south", ::selfMove, "s");
  self add_option("move yourself", "move south west", ::selfMove, "sw");
  self add_option("move yourself", "move west", ::selfMove, "w");
  self add_option("move yourself", "move north west", ::selfMove, "nw");
  self add_option("move yourself", "move up", ::selfMove, "u");
  self add_option("move yourself", "move down", ::selfMove, "d");
  self thread mapTeleports();
  
  self add_menu("spawnables menu", "revolt");
  self add_option("spawnables menu", "spawn carepackage", ::carePackageStall);
  self add_option("spawnables menu", "crosshair carepackage", ::CrosscarePackageStall);
  self add_option("spawnables menu", "crosshair midair carepackage", ::CrosscarePackageStall2);
  self add_string("spawnables menu", "change capture speed", ::ChangeCarepackTiming, self.pers["crateTimePrint"]);
  self add_option("spawnables menu", "spawn friendly helicopter", ::SpawnHeli);
  self add_option("spawnables menu", "spawn enemy helicopter", ::SpawnHeli);
  self add_option("spawnables menu", "spawn scav pack", ::spawnScavPack);
  self add_option("spawnables menu", "spawn bounce", ::createBounce); 
  self add_option("spawnables menu", "spawn green crate", ::spawngreencrate);
  self add_option("spawnables menu", "spawn red crate", ::spawnredcrate);
  self add_bool("spawnables menu", "forge mod", ::forgeMod, self.pers["ForgeBool"]);
  self add_string("spawnables menu", "forge distance", ::ChangeForgeRad, "" + self.pers["ForgeRad"] + "");
  self add_option("spawnables menu", "remove carepacks", ::deleteAllCarePackages);
  self add_option("spawnables menu", "remove helicopters", ::deleteheli);
  self add_option("spawnables menu", "remove bounce", ::deleteBounce); 

  self add_menu("binds menu", "revolt");
  self add_sub("binds menu", "nac mod", "nac mod", self.pers["nacModBool"]);
  self add_sub("binds menu", "skree mod", "skree mod", self.pers["snacModBool"]);
  self add_sub("binds menu", "change class", "change class", self.pers["classBindBool"]);
  self add_sub("binds menu", "instaswap", "instaswap", self.pers["instaBindBool"]);
  self add_string("binds menu", "canswap", ::bindCycle, self.pers["canswapBool"], "canswapBind", "canswapBool");
  self add_string("binds menu", "canzoom", ::bindCycle, self.pers["canzoomBool"], "canzoomBind", "canzoomBool");
  self add_string("binds menu", "vish", ::bindCycle, self.pers["vishBool"], "vishBind", "vishBool");
  self add_sub("binds menu", "repeater", "repeater", self.pers["repeaterBindBool"]);
  self add_string("binds menu", "smooth action",::bindCycle, self.pers["smoothactionBool"], "smoothAnimBind", "smoothactionBool");
  self add_string("binds menu", "illusion reload", ::bindCycle, self.pers["illReloadBool"], "illReloadBind", "illReloadBool");
  self add_string("binds menu", "rapid fire", ::bindCycle, self.pers["rapidFireBool"], "rapidFireBind", "rapidFireBool");
  self add_string("binds menu", "fake scav", ::bindCycle, self.pers["scavBool2"], "scavBind", "scavBool2");
  self add_sub("binds menu", "last stand", "last stand", self.pers["laststandBool"]);
  self add_string("binds menu", "gflip", ::bindCycle, self.pers["gflipBool"], "gflipBind", "gflipBool");
  self add_string("binds menu", "cowboy", ::bindCycle, self.pers["cowboyBool"], "cowboyBind", "cowboyBool");
  self add_string("binds menu", "center gun", ::bindCycle, self.pers["cGunBool"], "cGunBind", "cGunBool");
  self add_string("binds menu", "alt swap", ::bindCycle, self.pers["altSwapBool"], "altSwapBind", "altSwapBool");
  self add_string("binds menu", "drop weapon", ::bindCycle, self.pers["dropWeapBool"], "dropWeapBind", "dropWeapBool");
  self add_string("binds menu", "prone", ::bindCycle, self.pers["proneBool"], "proneBind", "proneBool");
  self add_sub("binds menu", "elevator", "elevator", self.pers["elevatorBool"]);
  self add_sub("binds menu", "fake carepackage", "fake carepackage", self.pers["fakeCPBool"]);
  self add_string("binds menu", "wall breach", ::bindCycle, self.pers["wallBreachBool"], "wallBreachBind", "wallBreachBool");
  self add_string("binds menu", "black screen", ::bindCycle, self.pers["blackScreenBool"], "blackScreenBind", "blackScreenBool");
  self add_string("binds menu", "static screen", ::bindCycle, self.pers["whiteScreenBool"], "whiteScreenBind", "whiteScreenBool");
  self add_string("binds menu", "disco camo", ::bindCycle, self.pers["discoCamoBool"], "discoCamoBind", "discoCamoBool");
  self add_sub("binds menu", "shax", "shax", self.pers["shaxBool"]);
  self add_string("binds menu", "invisible gun", ::bindCycle, self.pers["invisWeapBool"], "invisWeapBind", "invisWeapBool");
  self add_sub("binds menu", "damage", "damage", self.pers["damageBool"]);
  self add_string("binds menu", "semtex stuck", ::bindCycle, self.pers["semtexBool"], "semtexBind", "semtexBool");
  self add_string("binds menu", "crossbow stuck", ::bindCycle, self.pers["crossbowBool"], "crossbowBind", "crossbowBool");
  self add_sub("binds menu", "kill bot", "kill bot", self.pers["killBotBool"]);
  self add_string("binds menu", "underbarrel yy", ::bindCycle, self.pers["underbarrelBool"], "underbarrelBind", "underbarrelBool");
  self add_sub("binds menu", "give sniper", "give sniper", self.pers["giveSniperBool"]);
  self add_string("binds menu", "connection interrupted", ::bindCycle, self.pers["conInterBool"], "doConInter", "conInterBool");
  self add_sub("binds menu", "misc canswaps", "misc canswaps", self.pers["streakCanBool"]);
  self add_string("binds menu", "flash", ::bindCycle, self.pers["flashBool"], "flashBind", "flashBool");
  self add_string("binds menu", "third eye", ::bindCycle, self.pers["thirdEyeBool"], "thirdEyeBind", "thirdEyeBool");

  self add_menu("fake carepackage", "binds menu");
  self add_string("fake carepackage", "fake carepackage", ::bindCycle, self.pers["fakeCPBool"], "fakeCPBind", "fakeCPBool"); 
  self add_string("fake carepackage", "carepackage type", ::CycleCPStreak, "" + self.pers["CPType"] + "");
  self add_string("fake carepackage", "carepackage speed", ::CycleCPSpeed, "" + self.pers["CPSpeed"] + "");
  self add_sub("fake carepackage", "carepackage streak", "carepackage streak", "" + self.pers["CPStreak"] + "");

  self add_menu("carepackage streak", "fake carepackage");
  self add_option("carepackage streak", "spy plane", ::SetCPStreak, "radar_mp");
  self add_option("carepackage streak", "rc-xde", ::SetCPStreak, "rcbomb_mp");
  self add_option("carepackage streak", "counter-spy plane", ::SetCPStreak, "counteruav_mp");
  self add_option("carepackage streak", "sam turret", ::SetCPStreak, "auto_tow_mp");
  self add_option("carepackage streak", "care package", ::SetCPStreak, "supply_drop_mp");
  self add_option("carepackage streak", "napalm strike", ::SetCPStreak, "napalm_mp");
  self add_option("carepackage streak", "sentry gun", ::SetCPStreak, "autoturret_mp");
  self add_option("carepackage streak", "mortar strike", ::SetCPStreak, "mortar_mp");
  self add_option("carepackage streak", "attack helicopter", ::SetCPStreak, "helicopter_comlink_mp");
  self add_option("carepackage streak", "valkyrie rockets", ::SetCPStreak, "m220_tow_mp");
  self add_option("carepackage streak", "rolling thunder", ::SetCPStreak, "airstrike_mp");
  self add_option("carepackage streak", "chopper gunner ", ::SetCPStreak, "helicopter_gunner_mp");
  self add_option("carepackage streak", "attack dogs", ::SetCPStreak, "dogs_mp");
  self add_option("carepackage streak", "gunship", ::SetCPStreak, "helicopter_player_firstperson_mp");
  self add_option("carepackage streak", "fortune", ::SetCPStreak, "m202_flash_mp");
  self add_option("carepackage streak", "death machine", ::SetCPStreak, "minigun_mp");

  self add_menu("misc canswaps", "binds menu");
  self add_string("misc canswaps", "misc canswaps", ::bindCycle, self.pers["streakCanBool"], "dostreakCan", "streakCanBool");
  self add_string("misc canswaps", "change canswap", ::CycleStreakCanswap, "" + self.pers["streakCanswap"] + "");

  self add_menu("give sniper", "binds menu");
  self add_string("give sniper", "give sniper", ::bindCycle, self.pers["giveSniperBool"], "giveSniperBind", "giveSniperBool");
  self add_string("give sniper", "change sniper", ::cycleGiveSniper, "" + self.pers["GiveSniper"] + "");

  self add_menu("kill bot", "binds menu");
  self add_string("kill bot", "kill bot", ::bindCycle, self.pers["killBotBool"], "killBotBind", "killBotBool");
  self add_string("kill bot", "kill bot weapon", ::killbot_weapon, "" + self.pers["killBotWeap"] + "");

  self add_menu("change class", "binds menu");
  self add_string("change class", "change class type", ::changeClassType, "" + self.pers["CCType"] + "");
  self add_string("change class", "change class", ::bindCycle, self.pers["classBindBool"], "classBind", "classBindBool");

  self add_menu("nac mod", "binds menu");
  self add_string("nac mod", "nac mod", ::bindCycle, self.pers["nacModBool"], "nacModBind", "nacModBool");
  self add_string("nac mod", "save weapon 1", ::nacweap1, "" + self.pers["nacweap1"] + "");
  self add_string("nac mod", "save weapon 2", ::nacweap2, "" + self.pers["nacweap2"] + "");

  self add_menu("skree mod", "binds menu");
  self add_string("skree mod", "skree mod", ::bindCycle, self.pers["snacModBool"], "snacModBind", "snacModBool");
  self add_string("skree mod", "save weapon 1", ::snacweap1, "" + self.pers["snacweap1"] + "");
  self add_string("skree mod", "save weapon 2", ::snacweap2, "" + self.pers["snacweap2"] + "");

  self add_menu("instaswap", "binds menu");
  self add_string("instaswap", "instaswap", ::bindCycle, self.pers["instaBindBool"], "instaBind", "instaBindBool");
  self add_option("instaswap", "save weapon", ::InstaWeap);
  self add_option("instaswap", "reset weapons", ::ResetInstaArray);

  self add_menu("repeater", "binds menu");
  self add_string("repeater", "repeater", ::bindCycle, self.pers["repeaterBindBool"], "repeaterBind", "repeaterBindBool");
  self add_string("repeater", "repeater type", ::repeaterType, self.pers["RepeaterType"]);

  self add_menu("last stand", "binds menu");
  self add_string("last stand", "last stand", ::bindCycle, self.pers["laststandBool"], "laststandBind", "laststandBool");
  self add_string("last stand", "last stand weapon", ::lastStandWeap, level.laststandpistol);

  self add_menu("elevator", "binds menu");
  self add_string("elevator", "elevator", ::bindCycle, self.pers["elevatorBool"], "elevatorBind", "elevatorBool");
  self add_string("elevator", "elevator speed", ::elevatorSpeed, "" + self.pers["elevatorSpeed"] + "");
  self add_string("elevator", "elevator type", ::elevatorType, "" + self.pers["elevatorType"] + "");

  self add_menu("shax", "binds menu");
  self add_string("shax", "shax", ::bindCycle, self.pers["shaxBool"], "shaxBind", "shaxBool");
  self add_sub("shax", "shax weapon", "shax weapon", self.pers["shaxGun"]);
  self add_bool("shax", "sleight of hand shax", ::shaxSoH, self.pers["shaxSoH"]);
  self add_string("shax", "shax type", ::shaxTypeCycle, "" + self.pers["shaxType"] + "");

  self add_menu("shax weapon", "shax");
  self add_sub("shax weapon", "shax smgs", "shax smgs");
	self add_sub("shax weapon", "shax ars", "shax ars");
	self add_sub("shax weapon", "shax shotguns", "shax shotguns");
	self add_sub("shax weapon", "shax lmgs", "shax lmgs");
	self add_sub("shax weapon", "shax snipers", "shax snipers");
	self add_sub("shax weapon", "shax pistols", "shax pistols");

  self add_menu("shax smgs", "shax weapon");
 	self add_option("shax smgs", "mp5k", ::ShaxWeapon, "mp5k_mp");
 	self add_option("shax smgs", "skorpion", ::ShaxWeapon, "skorpion_mp");
	self add_option("shax smgs", "mac11", ::ShaxWeapon, "mac11_mp");
 	self add_option("shax smgs", "ak74u", ::ShaxWeapon, "ak74u_mp");
 	self add_option("shax smgs", "uzi", ::ShaxWeapon, "uzi_mp");
 	self add_option("shax smgs", "pm63", ::ShaxWeapon, "pm63_mp");
 	self add_option("shax smgs", "mpl", ::ShaxWeapon, "mpl_mp");
 	self add_option("shax smgs", "spectre", ::ShaxWeapon, "spectre_mp");
 	self add_option("shax smgs", "kiparis", ::ShaxWeapon, "kiparis_mp");

  self add_menu("shax ars", "shax weapon");
 	self add_option("shax ars", "m16", ::ShaxWeapon, "m16_mp");
 	self add_option("shax ars", "enfield", ::ShaxWeapon, "enfield_mp");
 	self add_option("shax ars", "m14", ::ShaxWeapon, "m14_mp");
 	self add_option("shax ars", "famas", ::ShaxWeapon, "famas_mp");
 	self add_option("shax ars", "galil", ::ShaxWeapon, "galil_mp");
 	self add_option("shax ars", "aug", ::ShaxWeapon, "aug_mp");
 	self add_option("shax ars", "fn fal", ::ShaxWeapon, "fnfal_mp");
 	self add_option("shax ars", "ak47", ::ShaxWeapon, "ak47_mp");
 	self add_option("shax ars", "commando", ::ShaxWeapon, "commando_mp");
 	self add_option("shax ars", "g11", ::ShaxWeapon, "g11_mp");

  self add_menu("shax shotguns", "shax weapon");
	self add_option("shax shotguns", "olympia", ::ShaxWeapon, "rottweil72_mp");
	self add_option("shax shotguns", "stakeout", ::ShaxWeapon, "ithaca_grip_mp");
	self add_option("shax shotguns", "spas-12", ::ShaxWeapon, "spas_mp");
	self add_option("shax shotguns", "hs10", ::ShaxWeapon, "hs10_mp");

	self add_menu("shax lmgs", "shax weapon");
	self add_option("shax lmgs", "hk21", ::ShaxWeapon, "hk21_mp");
	self add_option("shax lmgs", "rpk", ::ShaxWeapon, "rpk_mp");
	self add_option("shax lmgs", "m60", ::ShaxWeapon, "m60_mp");
	self add_option("shax lmgs", "stoner 63", ::ShaxWeapon, "stoner63_mp");
	
	self add_menu("shax snipers", "shax weapon");
	self add_option("shax snipers", "dragunov", ::ShaxWeapon, "dragunov_mp");
	self add_option("shax snipers", "wa2000", ::ShaxWeapon, "wa2000_mp");
	self add_option("shax snipers", "l96a1", ::ShaxWeapon, "l96a1_mp");
	self add_option("shax snipers", "psg1", ::ShaxWeapon, "psg1_mp");

	self add_menu("shax pistols", "shax weapon");
	self add_option("shax pistols", "asp", ::ShaxWeapon, "asp_mp");
	self add_option("shax pistols", "m1911", ::ShaxWeapon, "m1911_mp");
	self add_option("shax pistols", "makarov", ::ShaxWeapon, "makarov_mp");
	self add_option("shax pistols", "python", ::ShaxWeapon, "python_mp");
	self add_option("shax pistols", "cz75", ::ShaxWeapon, "cz75_mp");

  self add_menu("damage", "binds menu");
  self add_string("damage", "damage", ::bindCycle, self.pers["damageBool"], "damageBind", "damageBool");
  self add_string("damage", "damage amount", ::CycleSelfDamage, "" + self.pers["SelfDamage"] + "");

  self add_menu("perks menu", "revolt");
  self add_option("perks menu", "unset all perks", ::noMorePerk);
  self add_option("perks menu", "set all perks", ::SetAllPerks);
  self add_bool("perks menu", "specialty_fallheight", ::fallheight, self.pers["FHBool"]);
  self add_bool("perks menu", "specialty_movefaster", ::movefaster, self.pers["MFBool"]);
  self add_bool("perks menu", "specialty_sprintrecovery", ::sprintrecovery, self.pers["SRBool"]);
  self add_bool("perks menu", "specialty_fastmeleerecovery", ::fastmelee, self.pers["FMRBool"]);
  self add_bool("perks menu", "specialty_fastads", ::fastAds, self.pers["FADSBool"]);
  self add_bool("perks menu", "specialty_fastreload", ::fastreload, self.pers["FRBool"]);
  self add_bool("perks menu", "specialty_holdbreath", ::holdbreath, self.pers["HBBool"]);
  self add_bool("perks menu", "specialty_fastweaponswitch", ::fastweaponswitch, self.pers["FWSBool"]);
  self add_bool("perks menu", "specialty_extraammo", ::extraammo, self.pers["EABool"]);
  self add_bool("perks menu", "specialty_scavenger", ::scavenger, self.pers["scavBool"]);
  self add_bool("perks menu", "specialty_gpsjammer", ::gpsjammer, self.pers["gpsBool"]);
  self add_bool("perks menu", "specialty_nottargetedbyai", ::nottargeted, self.pers["NTBool"]);
  self add_bool("perks menu", "specialty_noname", ::noname, self.pers["NNBool"]);
  self add_bool("perks menu", "specialty_flakjacket", ::flakjacket, self.pers["flakBool"]);
  self add_bool("perks menu", "specialty_killstreak", ::killstreak, self.pers["KSBool"]);
  self add_bool("perks menu", "specialty_gambler", ::gambler, self.pers["GambleBool"]);
  self add_bool("perks menu", "specialty_twogrenades", ::twogrenades, self.pers["TGBool"]);
  self add_bool("perks menu", "specialty_longersprint", ::longersprint, self.pers["LSBool"]);
  self add_bool("perks menu", "specialty_unlimitedsprint", ::unlimitedsprint, self.pers["USBool"]);
  self add_bool("perks menu", "specialty_quieter", ::quieter, self.pers["quietBool"]);
  self add_bool("perks menu", "specialty_loudenemies", ::loudenemies, self.pers["LEBool"]);
  self add_bool("perks menu", "specialty_showenemyequipment", ::showenemyequipment, self.pers["SEEBool"]);
  self add_bool("perks menu", "specialty_detectexplosive", ::detectexplosive, self.pers["DEBool"]);
  self add_bool("perks menu", "specialty_disarmexplosive", ::disarmexplosive, self.pers["disarmBool"]);
  self add_bool("perks menu", "specialty_nomotionsensor", ::nomotion, self.pers["NMBool"]);
  self add_bool("perks menu", "specialty_shades", ::shades, self.pers["ShadesBool"]);
  self add_bool("perks menu", "specialty_stunprotection", ::stunprotection, self.pers["SPBool"]);
  self add_bool("perks menu", "specialty_pistoldeath", ::pistoldeath, self.pers["PDBool"]);
  self add_bool("perks menu", "specialty_finalstand", ::finalstand, self.pers["FSBool"]);

  self add_menu("killstreak menu", "revolt");
  self add_option("killstreak menu", "spy plane", ::doKillstreak, "radar_mp");
  self add_option("killstreak menu", "rc-xde", ::doKillstreak, "rcbomb_mp");
  self add_option("killstreak menu", "counter-spy plane", ::doKillstreak, "counteruav_mp");
  self add_option("killstreak menu", "sam turret", ::doKillstreak, "auto_tow_mp");
  self add_option("killstreak menu", "care package", ::doKillstreak, "supply_drop_mp");
  self add_option("killstreak menu", "napalm strike", ::doKillstreak, "napalm_mp");
  self add_option("killstreak menu", "sentry gun", ::doKillstreak, "autoturret_mp");
  self add_option("killstreak menu", "mortar strike", ::doKillstreak, "mortar_mp");
  self add_option("killstreak menu", "attack helicopter", ::doKillstreak, "helicopter_comlink_mp");
  self add_option("killstreak menu", "valkyrie rockets", ::doKillstreak, "m220_tow_mp");
  self add_option("killstreak menu", "rolling thunder", ::doKillstreak, "airstrike_mp");
  self add_option("killstreak menu", "chopper gunner ", ::doKillstreak, "helicopter_gunner_mp");
  self add_option("killstreak menu", "attack dogs", ::doKillstreak, "dogs_mp");
  self add_option("killstreak menu", "gunship", ::doKillstreak, "helicopter_player_firstperson_mp");
  self add_option("killstreak menu", "fortune", ::doKillstreak, "m202_flash_mp");
  self add_option("killstreak menu", "death machine", ::doKillstreak, "minigun_mp");

  self add_menu("ammobindops", "weapons menu");
  self add_string("ammobindops", "ammo bind", ::bindCycle, self.pers["ammoBindBool"], "ammoBind", "ammoBindBool");
  self add_string("ammobindops", "ammo bind type", ::Ammobindtype, "" + self.pers["ABType"] + "");

  self add_menu("weapons menu", "revolt");
  self add_option("weapons menu", "take current weapon", ::takecurrentweapon);
  self add_option("weapons menu", "drop current weapon", ::dropcurrentweapon);
  self add_option("weapons menu", "drop canswap", ::dropcan);
  self add_sub("weapons menu", "ammo bind", "ammobindops", self.pers["ammoBindBool"]);
  self add_sub("weapons menu", "ammo options", "ammo options");
 	self add_option("weapons menu", "refill equipment", ::maxequipment);
  self add_option("weapons menu", "save class", ::saveLoadout);
  self add_option("weapons menu", "load class", ::loadLoadout);
  self add_sub("weapons menu", "change camo", "change camo");
  self add_sub("weapons menu", "manage attachments", "manage attachments");
  self add_bool("weapons menu", "replace weapon on give", ::repongive, self.pers["repongive"]);
  self add_sub("weapons menu", "submachine guns", "submachine guns");
	self add_sub("weapons menu", "assault rifles", "assault rifles");
	self add_sub("weapons menu", "shotguns", "shotguns");
	self add_sub("weapons menu", "lightmachine guns", "lightmachine guns");
	self add_sub("weapons menu", "sniper rifles", "sniper rifles");
	self add_sub("weapons menu", "pistols", "pistols");
	self add_sub("weapons menu", "launchers", "launchers");
	self add_sub("weapons menu", "specials", "specials");
	self add_sub("weapons menu", "other", "other");



  self add_menu("ammo options", "weapons menu");
  self add_option("ammo options", "refill ammo", ::maxammoweapon);
 	self add_option("ammo options", "take away one bullet", ::AltAmmo1);
  self add_option("ammo options", "one bullet left", ::AltAmmo2);
  self add_option("ammo options", "empty ammo", ::emptyammo);
  self add_option("ammo options", "half ammo", ::halfammo);





  self add_menu("change camo", "weapons menu");
 	self add_option("change camo", "remove camo", ::changeCamo, 0);
  self add_option("change camo", "random camo", ::randomCamo);
  self add_option("change camo", "give dusty", ::changeCamo, 1);
  self add_option("change camo", "give ice", ::changeCamo, 2);
  self add_option("change camo", "give red", ::changeCamo, 3);
  self add_option("change camo", "give olive", ::changeCamo, 4);
  self add_option("change camo", "give nevada", ::changeCamo, 5);
  self add_option("change camo", "give sahara", ::changeCamo, 6);
  self add_option("change camo", "give erdl", ::changeCamo, 7);
  self add_option("change camo", "give tiger", ::changeCamo, 8);
  self add_option("change camo", "give berlin", ::changeCamo, 9);
  self add_option("change camo", "give warsaw", ::changeCamo, 10);
  self add_option("change camo", "give siberia", ::changeCamo, 11);
  self add_option("change camo", "give yukon", ::changeCamo, 12);
  self add_option("change camo", "give woodland", ::changeCamo, 13);
  self add_option("change camo", "give flora", ::changeCamo, 14);
  self add_option("change camo", "give gold", ::changeCamo, 15);

  self add_menu("manage attachments", "weapons menu");
 	self add_option("manage attachments", "dual mags", ::givePlayerAttachment, "dualclip");
  self add_option("manage attachments", "extended mags", ::givePlayerAttachment, "extclip");
  self add_option("manage attachments", "speed reloader", ::givePlayerAttachment, "speed");
  self add_option("manage attachments", "dual wield", ::givePlayerAttachment, "dw");
  self add_option("manage attachments", "grip", ::givePlayerAttachment, "grip");
  self add_option("manage attachments", "masterkey", ::givePlayerAttachment, "mk");
  self add_option("manage attachments", "flamethrower", ::givePlayerAttachment, "ft");
  self add_option("manage attachments", "grenade launcher", ::givePlayerAttachment, "gl");
  self add_option("manage attachments", "acog sight", ::givePlayerAttachment, "acog");
  self add_option("manage attachments", "infrared scope", ::givePlayerAttachment, "ir");
  self add_option("manage attachments", "relex sight", ::givePlayerAttachment, "reflex");
  self add_option("manage attachments", "red dot sight", ::givePlayerAttachment, "elbit");
  self add_option("manage attachments", "variable zoom", ::givePlayerAttachment, "vzoom");
  self add_option("manage attachments", "low power scope", ::givePlayerAttachment, "lps");
  self add_option("manage attachments", "upgraded iron sights", ::givePlayerAttachment, "upgradesight");
  self add_option("manage attachments", "suppressor", ::givePlayerAttachment, "silencer");
  self add_option("manage attachments", "rapid fire", ::givePlayerAttachment, "rf");
  self add_option("manage attachments", "full auto upgrade", ::givePlayerAttachment, "auto");

  self add_menu("submachine guns", "weapons menu");
 	self add_option("submachine guns", "mp5k", ::GivePlayerWeapon, "mp5k_mp");
 	self add_option("submachine guns", "skorpion", ::GivePlayerWeapon, "skorpion_mp");
	self add_option("submachine guns", "mac11", ::GivePlayerWeapon, "mac11_mp");
 	self add_option("submachine guns", "ak74u", ::GivePlayerWeapon, "ak74u_mp");
 	self add_option("submachine guns", "uzi", ::GivePlayerWeapon, "uzi_mp");
 	self add_option("submachine guns", "pm63", ::GivePlayerWeapon, "pm63_mp");
 	self add_option("submachine guns", "mpl", ::GivePlayerWeapon, "mpl_mp");
 	self add_option("submachine guns", "spectre", ::GivePlayerWeapon, "spectre_mp");
 	self add_option("submachine guns", "kiparis", ::GivePlayerWeapon, "kiparis_mp");

  self add_menu("assault rifles", "weapons menu");
 	self add_option("assault rifles", "m16", ::GivePlayerWeapon, "m16_mp");
 	self add_option("assault rifles", "enfield", ::GivePlayerWeapon, "enfield_mp");
 	self add_option("assault rifles", "m14", ::GivePlayerWeapon, "m14_mp");
 	self add_option("assault rifles", "famas", ::GivePlayerWeapon, "famas_mp");
 	self add_option("assault rifles", "galil", ::GivePlayerWeapon, "galil_mp");
 	self add_option("assault rifles", "aug", ::GivePlayerWeapon, "aug_mp");
 	self add_option("assault rifles", "fn fal", ::GivePlayerWeapon, "fnfal_mp");
 	self add_option("assault rifles", "ak47", ::GivePlayerWeapon, "ak47_mp");
 	self add_option("assault rifles", "commando", ::GivePlayerWeapon, "commando_mp");
 	self add_option("assault rifles", "g11", ::GivePlayerWeapon, "g11_mp");

  self add_menu("shotguns", "weapons menu");
	self add_option("shotguns", "olympia", ::GivePlayerWeapon, "rottweil72_mp");
	self add_option("shotguns", "stakeout", ::GivePlayerWeapon, "ithaca_grip_mp");
	self add_option("shotguns", "spas-12", ::GivePlayerWeapon, "spas_mp");
	self add_option("shotguns", "hs10", ::GivePlayerWeapon, "hs10_mp");

	self add_menu("lightmachine guns", "weapons menu");
	self add_option("lightmachine guns", "hk21", ::GivePlayerWeapon, "hk21_mp");
	self add_option("lightmachine guns", "rpk", ::GivePlayerWeapon, "rpk_mp");
	self add_option("lightmachine guns", "m60", ::GivePlayerWeapon, "m60_mp");
	self add_option("lightmachine guns", "stoner 63", ::GivePlayerWeapon, "stoner63_mp");
	
	self add_menu("sniper rifles", "weapons menu");
	self add_option("sniper rifles", "dragunov", ::GivePlayerWeapon, "dragunov_mp");
	self add_option("sniper rifles", "wa2000", ::GivePlayerWeapon, "wa2000_mp");
	self add_option("sniper rifles", "l96a1", ::GivePlayerWeapon, "l96a1_mp");
	self add_option("sniper rifles", "psg1", ::GivePlayerWeapon, "psg1_mp");

	self add_menu("pistols", "weapons menu");
	self add_option("pistols", "asp", ::GivePlayerWeapon, "asp_mp");
	self add_option("pistols", "m1911", ::GivePlayerWeapon, "m1911_mp");
	self add_option("pistols", "makarov", ::GivePlayerWeapon, "makarov_mp");
	self add_option("pistols", "python", ::GivePlayerWeapon, "python_mp");
	self add_option("pistols", "cz75", ::GivePlayerWeapon, "cz75_mp");

	self add_menu("launchers", "weapons menu");
	self add_option("launchers", "m72 law", ::GivePlayerWeapon, "m72_law_mp");
	self add_option("launchers", "rpg", ::GivePlayerWeapon, "rpg_mp");
	self add_option("launchers", "strela-3", ::GivePlayerWeapon, "strela_mp");
	self add_option("launchers", "china lake", ::GivePlayerWeapon, "china_lake_mp");

	self add_menu("specials", "weapons menu");
	self add_option("specials", "ballistic knife", ::GivePlayerWeapon, "knife_ballistic_mp");
	self add_option("specials", "crossbow", ::GivePlayerWeapon, "crossbow_explosive_mp");

	self add_menu("other", "weapons menu");
	self add_option("other", "syrette", ::GivePlayerWeapon, "syrette_mp");
	self add_option("other", "care package", ::GivePlayerWeapon, "supplydrop_mp");
	self add_option("other", "valkyrie rocket", ::GivePlayerWeapon, "m220_tow_mp");
	self add_option("other", "rc-xd remote", ::GivePlayerWeapon, "rcbomb_mp");
	self add_option("other", "bomb", ::GivePlayerWeapon, "briefcase_bomb_mp");
	self add_option("other", "claymore", ::GivePlayerWeapon, "claymore_mp");
	self add_option("other", "jammer", ::GivePlayerWeapon, "scrambler_mp");
	self add_option("other", "tactical insertion", ::GivePlayerWeapon, "tactical_insertion_mp");
	self add_option("other", "motion sensor", ::GivePlayerWeapon, "acoustic_sensor_mp");
	self add_option("other", "camera spike", ::GivePlayerWeapon, "camera_spike_mp");

  self add_menu("bots menu", "revolt");
  self add_option("bots menu", "spawn enemy bot", ::spawnEnemyBot);
  self add_option("bots menu", "spawn friendly bot", ::spawnFriendlyBot);
  self add_bool("bots menu", "freeze all bots", ::freezeAllBots, self.pers["frozenbots"]);
  self add_option("bots menu", "teleport bots", ::TeleportAllBots);
  self add_option("bots menu", "make bots look at you", ::MakeAllBotsLookAtYou);
  //self add_bool("bots menu", "enemies always look", ::botLookAtEnemies, self.pers["bot_noteam_looking"]);
  //self add_bool("bots menu", "friendlies always look", ::botLookAtFriendlies, self.pers["bot_team_looking"]);
  self add_option("bots menu", "save bot location", ::BotSpawns);
  self add_string("bots menu", "change bots stance", ::BotChangeStance, self.pers["BotStanceStr"]);
  self add_option("bots menu", "kick all bots", ::kickAllBots); 
  self add_option("bots menu", "bot location", ::GetBotLocation);

  self add_menu("trickshot menu", "revolt");
  self add_string("trickshot menu", "always canswap", ::toggleCan, self.pers["alwayscan_type"]);
  self add_string("trickshot menu", "instashoots", ::toggleInsta, self.pers["instashoot_type"]);
  self add_bool("trickshot menu", "always knife lunge", ::KnifeLunge, self.pers["LungeBool"]);
  self add_bool("trickshot menu", "precam animations", ::precamOTS, self.pers["precamBool"]);
  self add_bool("trickshot menu", "killcam timer", ::ToggTimer, self.pers["HideTimer"]);
  self add_string("trickshot menu", "killcam length", ::killcamLength, "" + self.pers["killcamTime"] + "");
  self add_string("trickshot menu", "killcam slowmo", ::KillcamSlowmo, "" + self.pers["KillcamSlowMo"] + "");
  self add_bool("trickshot menu", "fake red room", ::Redroom, self.pers["RedroomBool"]);
  self add_bool("trickshot menu", "mw2 after game", ::MW2EndGame, self.pers["EndGameBool"]);
  self add_sub("trickshot menu", "rmala", "rmala" , self.pers["doingMala"]);
  self add_bool("trickshot menu", "usable tac insert", ::doAltTac, self.pers["AltTac"]);
  self add_bool("trickshot menu", "upside down screen", ::doUpsideDown, self.pers["UpsideDownBool"]);
  self add_sub("trickshot menu", "afterhits", "afterhits menu", self.pers["AfterHitWeap"]);

  self add_menu("rmala", "trickshot menu");
  self add_bool("rmala", "toggle rmala", ::doMalaMW2, self.pers["doingMala"]);
  self add_string("rmala", "change equipment", ::CycleRmala, "" + self.pers["malaEquip"] + "");
  self add_string("rmala", "save weapon", ::SaveMalaWeapon, "" + self.pers["malaWeap"] + "");
  self add_string("rmala", "flicker time", ::malaWait, "" + self.pers["malaTime"] + "");

  self add_menu("afterhits menu", "trickshot menu");
  self add_string("afterhits menu", "current afterhit", ::blank, self.pers["AfterHitWeap"]);
  self add_option("afterhits menu", "set current weapon", ::CurrentWeaponAH);
  self add_sub("afterhits menu", "submachine guns", "submachine gun afterhits");
	self add_sub("afterhits menu", "assault rifles", "assault rifle afterhits");
	self add_sub("afterhits menu", "shotguns", "shotgun afterhits");
	self add_sub("afterhits menu", "lightmachine guns", "lightmachine gun afterhits");
	self add_sub("afterhits menu", "sniper rifles", "sniper afterhits");
	self add_sub("afterhits menu", "pistols", "pistol afterhits");
	self add_sub("afterhits menu", "launchers", "launcher afterhits");
	self add_sub("afterhits menu", "specials", "special afterhits");
	self add_sub("afterhits menu", "other", "other afterhits");

  self add_menu("submachine gun afterhits", "afterhits menu");
 	self add_option("submachine gun afterhits", "mp5k", ::AfterHitToggle, "mp5k_mp");
 	self add_option("submachine gun afterhits", "skorpion", ::AfterHitToggle, "skorpion_mp");
	self add_option("submachine gun afterhits", "mac11", ::AfterHitToggle, "mac11_mp");
 	self add_option("submachine gun afterhits", "ak74u", ::AfterHitToggle, "ak74u_mp");
 	self add_option("submachine gun afterhits", "uzi", ::AfterHitToggle, "uzi_mp");
 	self add_option("submachine gun afterhits", "pm63", ::AfterHitToggle, "pm63_mp");
 	self add_option("submachine gun afterhits", "mpl", ::AfterHitToggle, "mpl_mp");
 	self add_option("submachine gun afterhits", "spectre", ::AfterHitToggle, "spectre_mp");
 	self add_option("submachine gun afterhits", "kiparis", ::AfterHitToggle, "kiparis_mp");

  self add_menu("assault rifle afterhits", "afterhits menu");
 	self add_option("assault rifle afterhits", "m16", ::AfterHitToggle, "m16_mp");
 	self add_option("assault rifle afterhits", "enfield", ::AfterHitToggle, "enfield_mp");
 	self add_option("assault rifle afterhits", "m14", ::AfterHitToggle, "m14_mp");
 	self add_option("assault rifle afterhits", "famas", ::AfterHitToggle, "famas_mp");
 	self add_option("assault rifle afterhits", "galil", ::AfterHitToggle, "galil_mp");
 	self add_option("assault rifle afterhits", "aug", ::AfterHitToggle, "aug_mp");
 	self add_option("assault rifle afterhits", "fn fal", ::AfterHitToggle, "fnfal_mp");
 	self add_option("assault rifle afterhits", "ak47", ::AfterHitToggle, "ak47_mp");
 	self add_option("assault rifle afterhits", "commando", ::AfterHitToggle, "commando_mp");
 	self add_option("assault rifle afterhits", "g11", ::AfterHitToggle, "g11_mp");

  self add_menu("shotgun afterhits", "afterhits menu");
	self add_option("shotgun afterhits", "olympia", ::AfterHitToggle, "rottweil72_mp");
	self add_option("shotgun afterhits", "stakeout", ::AfterHitToggle, "ithaca_grip_mp");
	self add_option("shotgun afterhits", "spas-12", ::AfterHitToggle, "spas_mp");
	self add_option("shotgun afterhits", "hs10", ::AfterHitToggle, "hs10_mp");

	self add_menu("lightmachine gun afterhits", "afterhits menu");
	self add_option("lightmachine gun afterhits", "hk21", ::AfterHitToggle, "hk21_mp");
	self add_option("lightmachine gun afterhits", "rpk", ::AfterHitToggle, "rpk_mp");
	self add_option("lightmachine gun afterhits", "m60", ::AfterHitToggle, "m60_mp");
	self add_option("lightmachine gun afterhits", "stoner 63", ::AfterHitToggle, "stoner63_mp");
	
	self add_menu("sniper afterhits", "afterhits menu");
	self add_option("sniper afterhits", "dragunov", ::AfterHitToggle, "dragunov_mp");
	self add_option("sniper afterhits", "wa2000", ::AfterHitToggle, "wa2000_mp");
	self add_option("sniper afterhits", "l96a1", ::AfterHitToggle, "l96a1_mp");
	self add_option("sniper afterhits", "psg1", ::AfterHitToggle, "psg1_mp");

	self add_menu("pistol afterhits", "afterhits menu");
	self add_option("pistol afterhits", "asp", ::AfterHitToggle, "asp_mp");
	self add_option("pistol afterhits", "m1911", ::AfterHitToggle, "m1911_mp");
	self add_option("pistol afterhits", "makarov", ::AfterHitToggle, "makarov_mp");
	self add_option("pistol afterhits", "python", ::AfterHitToggle, "python_mp");
	self add_option("pistol afterhits", "cz75", ::AfterHitToggle, "cz75_mp");

	self add_menu("launcher afterhits", "afterhits menu");
	self add_option("launcher afterhits", "m72 law", ::AfterHitToggle, "m72_law_mp");
	self add_option("launcher afterhits", "rpg", ::AfterHitToggle, "rpg_mp");
	self add_option("launcher afterhits", "strela-3", ::AfterHitToggle, "strela_mp");
	self add_option("launcher afterhits", "china lake", ::AfterHitToggle, "china_lake_mp");

	self add_menu("special afterhits", "afterhits menu");
	self add_option("special afterhits", "ballistic knife", ::AfterHitToggle, "knife_ballistic_mp");
	self add_option("special afterhits", "crossbow", ::AfterHitToggle, "crossbow_explosive_mp");

	self add_menu("other afterhits", "afterhits menu");
	self add_option("other afterhits", "syrette", ::AfterHitToggle, "syrette_mp");
	self add_option("other afterhits", "care package", ::AfterHitToggle, "supplydrop_mp");
	self add_option("other afterhits", "valkyrie rocket", ::AfterHitToggle, "m220_tow_mp");
	self add_option("other afterhits", "rc-xd remote", ::AfterHitToggle, "rcbomb_mp");
	self add_option("other afterhits", "bomb", ::AfterHitToggle, "briefcase_bomb_mp");
	self add_option("other afterhits", "claymore", ::AfterHitToggle, "claymore_mp");
	self add_option("other afterhits", "jammer", ::AfterHitToggle, "scrambler_mp");
	self add_option("other afterhits", "tactical insertion", ::AfterHitToggle, "tactical_insertion_mp");
	self add_option("other afterhits", "motion sensor", ::AfterHitToggle, "acoustic_sensor_mp");
	self add_option("other afterhits", "camera spike", ::AfterHitToggle, "camera_spike_mp");
  /*
  self add_menu("cfg menu", "revolt");
  self add_sub("cfg menu", "glitches", "glitches cfg");
  self add_sub("cfg menu", "submachine guns", "submachine gun cfg");
	self add_sub("cfg menu", "assault rifles", "assault rifle cfg");
	self add_sub("cfg menu", "shotguns", "shotgun cfg");
	self add_sub("cfg menu", "lightmachine guns", "lightmachine gun cfg");
	self add_sub("cfg menu", "sniper rifles", "sniper cfg");
	self add_sub("cfg menu", "pistols", "pistol cfg");
	self add_sub("cfg menu", "launchers", "launcher cfg");
	self add_sub("cfg menu", "specials", "special cfg");
  self add_sub("cfg menu", "extras", "extras cfg");
  self thread cfgStruc();
  */

  self add_menu("green screen menu", "revolt");
  self add_string("green screen menu", "chroma color", ::ChromaColor, self.pers["ChromaColorStr"]);
  self add_bool("green screen menu", "chroma screen", ::ToggleChroma, self.pers["DoingChroma"]);
  self add_bool("green screen menu", "disable hud", ::HUDHide, self.pers["HideHud"]);
  self add_bool("green screen menu", "disable killfeed", ::KFRemove, self.pers["NoKF"]);
  self add_bool("green screen menu", "invisible weapon", ::nogunC, self.pers["InvisWeapBool"]);
  self add_bool("green screen menu", "disable crosshair", ::CrossHide, self.pers["HideCross"]);
  self add_bool("green screen menu", "draw2d", ::HUDRemove, self.pers["NoHud"]); 
  self add_bool("green screen menu", "fake timer", ::FakeTimer, self.pers["NoHud"]);

  self add_menu("movement menu", "revolt");
  self add_option("movement menu", "ufo mode", ::ToggleNoclip);
  self add_sub("movement menu", "bolt movement", "bolt movement", self.pers["boltBindBool"]);
  self add_sub("movement menu", "velocity", "velocity", self.pers["velocityBindBool"]);
  self add_sub("movement menu", "record movement", "record movement", self.pers["movementBindBool"]);

  self add_menu("bolt movement", "movement menu");
  self add_option("bolt movement", "ufo mode", ::ToggleNoclip);
  self add_string("bolt movement", "bolt movement", ::bindCycle, self.pers["boltBindBool"], "boltBind", "boltBindBool");
  self add_string("bolt movement", "save point", ::saveBolt, "points saved: " + self.pers["boltCount"] + "");
  self add_string("bolt movement", "remove point", ::deleteBolt, "points saved: " + self.pers["boltCount"] + "");
  self add_string("bolt movement", "change speed", ::cycleSpeed, "bolt saved: " + self.pers["boltSpeed"] + "");

  self add_menu("velocity", "movement menu");
  self add_string("velocity", "velocity bind", ::bindCycle, self.pers["velocityBindBool"], "velocityBind", "velocityBindBool");
  self add_option("velocity", "play velocity", ::startVelo);
  self add_option("velocity", "reset velocity", ::resetVelo);
  self add_string("velocity", "change edit amount", ::veloAmountCycle, "" + self.pers["VeloEdit"]+ "");
  self add_option("velocity", "x+", ::editVelocity, "x", "up");
  self add_option("velocity", "x-", ::editVelocity, "x", "down");
  self add_option("velocity", "y+", ::editVelocity, "y", "up");
  self add_option("velocity", "y-", ::editVelocity, "y", "down");
  self add_option("velocity", "z+", ::editVelocity, "z", "up");
  self add_option("velocity", "z-", ::editVelocity, "z", "down");
  self add_option("velocity", "save velocity", ::saveVelocity);
  self add_string("velocity", "remove velocity", ::deleteVelocity, "points saved: "+ self.pers["velocityCount"] + "");

  self add_menu("record movement", "movement menu");
  self add_string("record movement", "record movement", ::bindCycle, self.pers["movementBindBool"], "movementBind", "movementBindBool");
  self add_option("record movement", "start recording", ::recordDaMovement);
  self add_option("record movement", "reset recording", ::clearMovementPoints);
  self add_option("record movement", "remove point ", ::removeLastSavedMove);

  self add_menu("account menu", "revolt");
  self add_option("account menu", "level 50", :: doLevel50);
  self add_string("account menu", "change prestige", :: cycleprestige, "" + self.pers["plevel"] + "");
  self add_option("account menu", "unlock all", :: giveUnlockAll);
  self add_option("account menu", "give pro perks", :: doUnlockProPerks);

  self add_menu("admin menu", "revolt");
  self add_string("admin menu", "gravity", :: doGravity, "" + self.pers["adminGrav"] + "");
  self add_string("admin menu", "slow mo", :: slomotog, "" + self.pers["adminTS"] + "");
  self add_string("admin menu", "ladder push", :: LadderYeet, "" + self.pers["adminLadPush"] + "");
  self add_bool("admin menu", "ladder spins", :: ladderSpins, self.pers["LadSpinsBool"]);
  self add_string("admin menu", "pickup radius", :: expickup, "" + self.pers["adminPickupRad"] + "");
  self add_string("admin menu", "granade radius", :: fragPickup, "" + self.pers["adminFragPickupRad"] + "");
  self add_bool("admin menu", "grande roll", :: DisableFragRoll, self.pers["RollBool"]);
  self add_bool("admin menu", "prone spins", :: proneSpins, self.pers["ProneSpins"]);
  self add_bool("admin menu", "prone after hit", :: ProneAH, self.pers["ProneAH"]);
  self add_bool("admin menu", "back speed", :: backSpeed, self.pers["backSpeed"]);
  self add_bool("admin menu", "melee range", :: meleeRange, self.pers["meleeRange"]);
  self add_bool("admin menu", "player cards", :: Playercard, self.pers["playerCard"]); 
  self add_bool("admin menu", "jump fatigue", :: jumpfatigue, self.pers["JumpFati"]);
  self add_bool("admin menu", "pause timer", :: toggleTimer, self.pers["timerPause"]);
  self add_bool("admin menu", "softland help", :: softlands, self.pers["softLands"]);
  self add_sub("admin menu", "edit rounds", "edit rounds");

  self add_menu("edit rounds", "admin menu");
  self add_option("edit rounds", "reset rounds", ::ResetRounds);
  self add_option("edit rounds", "set axis rounds", ::OneAxisRound);
  self add_option("edit rounds", "set allied rounds", ::OneAlliesRound);
  self add_option("edit rounds", "make last round", ::makeLastRound);

self add_menu("clients menu", "revolt");
self endon("Closed");
self endon("disconnect");

allies = [];
axis = [];

//sort players into teams
for(i = 0; i < level.players.size; i++)
{
    if(level.players[i].team == "allies")
        allies[allies.size] = level.players[i];
    else if(level.players[i].team == "axis")
        axis[axis.size] = level.players[i];
}

//add allies to the menu first
for(i = 0; i < allies.size; i++)
{
  self add_option("clients menu", "^?[Allies]^7 " + allies[i].name, ::_loadmenu, "^?[Allies]^7 " + allies[i].name);
  self add_menu("^?[Allies]^7 " + allies[i].name, "clients menu");
  self add_option("^?[Allies]^7 " + allies[i].name, "revive player", ::revivePlayer, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "freeze player", ::freezeClient, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "teleport player", ::telePlayer, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "save player spawn", ::SpawnSavePlayer, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "change stance", ::CyclePlayerStance, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "move player north", ::movePlayerN, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "move player south", ::movePlayerS, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "move player east", ::movePlayerE, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "move player west", ::movePlayerW, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "kill player", ::killPlayer, allies[i]);
  self add_option("^?[Allies]^7 " + allies[i].name, "kick player", ::kickPlayer, allies[i]);
}

//add axis to the menu second
for(i = 0; i < axis.size; i++)
{
  self add_option("clients menu", "^?[Axis]^7 " + axis[i].name, ::_loadmenu, "^?[Axis]^7 " + axis[i].name);
  self add_menu("^?[Axis]^7 " + axis[i].name, "clients menu");
  self add_option("^?[Axis]^7 " + axis[i].name, "revive player", ::revivePlayer, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "freeze player", ::freezeClient, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "teleport player", ::telePlayer, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "save player spawn", ::SpawnSavePlayer, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "change stance", ::CyclePlayerStance, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "move player north", ::movePlayerN, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "move player south", ::movePlayerS, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "move player east", ::movePlayerE, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "move player west", ::movePlayerW, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "kill player", ::killPlayer, axis[i]);
  self add_option("^?[Axis]^7 " + axis[i].name, "kick player", ::kickPlayer, axis[i]);

}

  self add_menu("closed");
  self add_option("closed", "");
}

blank()
{
  
}