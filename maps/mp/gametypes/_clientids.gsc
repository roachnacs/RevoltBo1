/*
 _______  _______  _______  _______           _  _______ 
(  ____ )(  ___  )(  ___  )(  ____ \|\     /|( )(  ____ \
| (    )|| (   ) || (   ) || (    \/| )   ( ||/ | (    \/
| (____)|| |   | || (___) || |      | (___) |   | (_____ 
|     __)| |   | ||  ___  || |      |  ___  |   (_____  )
| (\ (   | |   | || (   ) || |      | (   ) |         ) |
| ) \ \__| (___) || )   ( || (____/\| )   ( |   /\____) |
|/   \__/(_______)|/     \|(_______/|/     \|   \_______)
 _______  _______           _______  _    _________      
(  ____ )(  ____ \|\     /|(  ___  )( \   \__   __/      
| (    )|| (    \/| )   ( || (   ) || (      ) (         
| (____)|| (__    | |   | || |   | || |      | |         
|     __)|  __)   ( (   ) )| |   | || |      | |         
| (\ (   | (       \ \_/ / | |   | || |      | |         
| ) \ \__| (____/\  \   /  | (___) || (____/\| |         
|/   \__/(_______/   \_/   (_______)(_______/)_(         
 _______  _______  _                                     
(       )(  ____ \( (    /||\     /|                     
| () () || (    \/|  \  ( || )   ( |                     
| || || || (__    |   \ | || |   | |                     
| |(_)| ||  __)   | (\ \) || |   | |                     
| |   | || (      | | \   || |   | |                     
| )   ( || (____/\| )  \  || (___) |                     
|/     \|(_______/|/    )_)(_______)                     
                 
Version: 0.0.1
Date: April 15, 2025
*/
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\RevoltMenu\_revoltStructure;
#include maps\mp\RevoltMenu\_revoltFuncs;
#include maps\mp\RevoltMenu\_revoltBots;
#include maps\mp\RevoltMenu\_revoltWeapons;
#include maps\mp\RevoltMenu\_revoltBinds;

init()
{
    level thread onPlayerConnect();
    precacheShader("emblem_bg_cemetary");
    level thread TeamName1("^?revolt");
    level thread TeamName2("^6by roach");
    setDvar("sv_cheats", 1);
    setDvar("sv_enableBounces", 1 );
    setDvar("killcam_final", 1);
    setDvar("com_maxfps", 60);
    level.player_out_of_playable_area_monitor = 0;
    level.prematchPeriod = 0;
    level.result = 0;
    level.rankedMatch = true;
    level.contractsEnabled = false;
    level.c4array = [];
    level.claymorearray = [];
    precacheItem( "scavenger_item_mp" ); 
    precacheShader( "hud_scavenger_pickup" ); 
    PreCacheModel("t5_veh_rcbomb_allies");
	PreCacheModel("t5_veh_rcbomb_axis");
    precacheItem( "scavenger_item_mp" );
    precacheShader( "hud_scavenger_pickup" );
    PrecacheShader("hud_icon_stuck_semtex");
    PrecacheShader("hud_icon_stuck_arrow");
    PrecacheShader("overlay_low_health");
    PrecacheShader("net_new_animation");
	PrecacheVehicle("rc_car_medium_mp");
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connecting", player);
        player thread onPlayerSpawned();
        player thread boolInit();
        player thread MapSaves();
        player notifyOnPlayerCommand("dpad1", "+actionslot 1");
        player notifyOnPlayerCommand("dpad2", "+actionslot 2");
        player notifyOnPlayerCommand("dpad3", "+actionslot 3");
        player notifyOnPlayerCommand("dpad4", "+actionslot 4");
        player notifyOnPlayerCommand("knife", "+melee");
        player notifyOnPlayerCommand("knife", "+melee_zoom");
        player notifyOnPlayerCommand("usereload", "+usereload");
        player notifyOnPlayerCommand("usereload", "+reload");
        player.pers["SavingandLoading"] = true;
        if(!isDefined(player.pers["first"]))
            player.pers["first"] = 1;
        player thread playerSetup();
        player thread menuinit();
        player thread bindsInit();
        player thread changeClass();
        player thread monitorPerks();
        player.InstaswapArray = [];
        player.InstaArrayNumber = 0;
        player.InstaCycle = 0;
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");
        if(self isHost())
        {
            self thread WelcomeText();
            if(self.pers["first"] == 1)
            {
                self thread spawnEnemyBot();
                self.pers["first"] = 0;
            }
            if(isDefined(self.pers["savedLocation"]))
            {
                self setOrigin(self.pers["savedLocation"]);
                self setplayerangles(self.pers["savedAngles"]);
            }
        }
        else
        {
            players = level.players;
            for ( i = 0; i < players.size; i++ )
            {   
                player = players[i];
                if(IsDefined(player.pers["isBot"]))
                {
                    player freezeControls(true);
                    self.frozenbots = 1;
                    wait 0.05;
                    self clearperks();
                    if(isDefined(self.pers["savedLocation"]))
                    {
                        self setOrigin(self.pers["savedLocation"]);
                        self setplayerangles(self.pers["savedAngles"]);
                    }
                }
                else
                {
                    self thread WelcomeText();
                }
            }
        }
        self.matchBonus = randomintrange(200,610);
    }
}

WelcomeText()
{
    PlayerName = self.name;
    self iPrintLn("welcome ^?" + PlayerName + "^7 to ^?revolt");
    self IPrintLn("Press [{+speed_throw}] + [{+actionslot 2}] To Open");
}

MapSaves()
{
    self.ExampleSaved = (108.9,0.34,-1232.75); // use the hud element or dev menu to find your coords and save them like this 
    self.ArraySaved = undefined;
    self.CrackedSaved = undefined;
    self.CrisisSaved = undefined;
    self.FiringRangeSaved = undefined;
    self.GridSaved = undefined;
    self.HanoiSaved = undefined;
    self.HavanaSaved = undefined;
    self.JungleSaved = undefined;
    self.LaunchSaved = undefined;
    self.NuketownSaved = undefined;
    self.RadiationSaved = undefined;
    self.SummitSaved = undefined;
    self.VillaSaved = undefined;
    self.WMDSaved = undefined;
    self.BerlinWallSaved = undefined;
    self.DiscoverySaved = undefined;
    self.KowloonSaved = undefined;
    self.StadiumSaved = undefined;
    self.ConvoySaved = undefined;
    self.HotelSaved = undefined;
    self.StockpileSaved = undefined;
    self.ZooSaved = undefined;
    self.DriveInSaved = undefined;
    self.HangarSaved = undefined;
    self.HazardSaved = undefined;
    self.SiloSaved = undefined;
}

boolInit()
{
    SetPersIfUni("aimbotRadius", 500);
    SetPersIfUni("aimbotToggle", false);
    SetPersIfUni("invisBool", false);
    SetPersIfUni("GodBool", false);
    SetPersIfUni("AmmoBool", false);
    self.testbool = false;
    SetPersIfUni("EquipBool", false);
    SetPersIfUni("fovBool", false);
    SetPersIfUni("thirdBool", false);
    SetPersIfUni("speedBool", false);
    SetPersIfUni("movingBool", false);
    SetPersIfUni("DWeapBool", false);
    SetPersIfUni("InvisWeapBool", false);
    SetPersIfUni("RapidBool", false);
    SetPersIfUni("DropBool", false);
    SetPersIfUni("AimbotWeapon", "^1not saved");
    SetPersIfUni("aimbotRadiusPrint", "100");
    SetPersIfUni("aimbotDelayPrint", "0");
    SetPersIfUni("tpgBool", false);
    SetPersIfUni("snlBool", false);
    SetPersIfUni("crateTimePrint", "2000");
    SetPersIfUni("classBindBool", "<>");
    SetPersIfUni("nacModBool", "<>");
    SetPersIfUni("snacModBool", "<>");
    SetPersIfUni("instaBindBool", "<>");
    SetPersIfUni("FHBool", false);
    SetPersIfUni("MFBool", false);
    SetPersIfUni("EABool", false);
    SetPersIfUni("scavBool", false);
    SetPersIfUni("gpsBool", false);
    SetPersIfUni("NTBool", false);
    SetPersIfUni("NNBool", false);
    SetPersIfUni("flakBool", false);
    SetPersIfUni("KSBool", false);
    SetPersIfUni("GambleBool", false);
    SetPersIfUni("SRBool", false);
    SetPersIfUni("FMRBool", false);
    SetPersIfUni("HBBool", false);
    SetPersIfUni("FRBool", false);
    SetPersIfUni("TGBool", false);
    SetPersIfUni("LSBool", false);
    SetPersIfUni("USBool", false);
    SetPersIfUni("quietBool", false);
    SetPersIfUni("LEBool", false);
    SetPersIfUni("SEEBool", false);
    SetPersIfUni("DEBool", false);
    SetPersIfUni("disarmBool", false);
    SetPersIfUni("NMBool", false);
    SetPersIfUni("ShadesBool", false);
    SetPersIfUni("SPBool", false);
    SetPersIfUni("PDBool", false);
    SetPersIfUni("FSBool", false);
    SetPersIfUni("refillammoBindBool", "<>");
    SetPersIfUni("BotStanceStr", "standing");
    SetPersIfUni("LungeBool", false);
    SetPersIfUni("precamBool", false);
    SetPersIfUni("EndGameBool", false);
    SetPersIfUni("UpsideDownBool", false);
    SetPersIfUni("AfterHitWeap", "^1not saved");
    SetPersIfUni("AfterHitTog", false);
    SetPersIfUni("ChromaColorStr", "green");
    SetPersIfUni("ChromaColor", "0 1 0 1");
    SetPersIfUni("DoingChroma", false);
    SetPersIfUni("HideHud", false);
    SetPersIfUni("NoHud", false);
    SetPersIfUni("NoKF", false);
    SetPersIfUni("HideCross", false);
    SetPersIfUni("boltBindBool", "<>");
    self.pers["currentvelo"] = (0,0,0);
    SetPersIfUni("VeloEdit", 1);
    SetPersIfUni("velocityBindBool", "<>");
    SetPersIfUni("movementBindBool", "<>");
    SetPersIfUni("recordedOrigins", []);
    SetPersIfUni("CurMovePoint", 0);
    SetPersIfUni("Movepoints", 0);
    SetPersIfUni("plevel", 15);
    SetPersIfUni("adminGrav", 800);
    SetPersIfUni("adminTS", 1);
    SetPersIfUni("adminLadPush", 128);
    SetPersIfUni("LadSpinsBool", false);
    SetPersIfUni("adminPickupRad", 128);
    SetPersIfUni("adminFragPickupRad", 160);
    SetPersIfUni("RollBool", false);
    SetPersIfUni("ProneSpins", false);
    SetPersIfUni("ProneAH", false);
    SetPersIfUni("backSpeed", false);
    SetPersIfUni("meleeRange", false);
    SetPersIfUni("playerCard", true);
    SetPersIfUni("JumpFati", false);
    SetPersIfUni("timerPause", false);
    SetPersIfUni("HideTimer", true);
    SetPersIfUni("KillcamOp", 0.2);
    SetPersIfUni("KillcamSlowMo", "default");
    SetPersIfUni("killcamTime", 5);
    SetPersIfUni("RedroomBool", false);
    SetPersIfUni("CCType", "default");
    SetPersIfUni("nacweap1", "<>");
    SetPersIfUni("nacweap2", "<>");
    SetPersIfUni("snacweap1", "<>");
    SetPersIfUni("snacweap2", "<>");
}

TeamName1(inp)
{
    setDvar("g_TeamName_Allies", inp);
    setDvar("g_TeamIcon_Allies","rank_prestige15");
}

TeamName2(inp)
{
    setDvar("g_TeamName_Axis",inp);
    setDvar("g_TeamIcon_Axis","rank_prestige010");
}

playerSetup()
{
    setdvar("safearea_vertical",0.85);
    setdvar("safearea_adjusted_vertical",0.85);
    setdvar("safearea_horizontal",0.85);
    setdvar("safearea_adjusted_horizontal",0.85);
    setDvar("testclients_watchkillcam",0);
    setDvar("vid_xpos",0);
    setDvar("vid_ypos",0);
}

changeClass()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill( "changed_class");
        self thread maps\mp\gametypes\_class::giveLoadout( self.team, self.class );
        self iprintlnbold("                                                     ");
        wait .1;
    }
}

monitorPerks()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill_either( "spawned_player", "changed_class" );
        wait .5;
        if(self hasPerk( "specialty_movefaster" )) // Lightweight
        {
            self setPerk( "specialty_fallheight" );
            self setPerk( "specialty_movefaster" );
        }
        if(self hasPerk( "specialty_scavenger" )) // Scavenger
        {
            self setPerk( "specialty_extraammo" );
            self setPerk( "specialty_scavenger" );
        }
        if(self hasPerk( "specialty_gpsjammer" )) // Ghost
        {
            self setPerk( "specialty_gpsjammer" );
            self setPerk( "specialty_nottargetedbyai" );
            self setPerk( "specialty_noname" );
        }
        if(self hasPerk( "specialty_flakjacket" )) // Flak Jacket
        {
            self setPerk( "specialty_flakjacket" );
            self setPerk( "specialty_flakjacket" );
            self setPerk( "specialty_flakjacket" );
        }
        if(self hasPerk( "specialty_killstreak" )) // Hardline
        {
            self setPerk( "specialty_killstreak" );
            self setPerk( "specialty_gambler" );
        }
        if(self hasPerk( "specialty_bulletaccuracy" )) // Steady Aim
        {
            self setPerk( "specialty_fallheight" );
            self setPerk( "specialty_sprintrecovery" );
            self setPerk( "specialty_fastmeleerecovery" );
        }
        if(self hasPerk( "specialty_holdbreath" )) // Scout
        {
            self setPerk( "specialty_holdbreath" );
            self setPerk( "specialty_fastweaponswitch" );
        }
        if(self hasPerk( "specialty_fastreload" )) // Sleight of Hand
        {
            self setPerk( "specialty_fastreload" );
            self setPerk( "specialty_fastads" );
        }
        if(self hasPerk( "specialty_twoattach" )) // War Lord
        {
            self setPerk("specialty_twoattach");
            self setPerk("specialty_twogrenades");
        }
        if(self hasPerk( "specialty_longersprint" )) // Marathon
        {
            self setPerk( "specialty_longersprint" );
            self setPerk( "specialty_unlimitedsprint" );
        }
        if(self hasPerk( "specialty_quieter" )) // Ninja
        {
            self setPerk( "specialty_quieter" );
            self setPerk( "specialty_loudenemies" );
        }
        if(self hasPerk( "specialty_showenemyequipment" )) // Hacker
        {
            self setPerk( "specialty_showenemyequipment" );
            self setPerk( "specialty_detectexplosive" );
            self setPerk( "specialty_disarmexplosive" );
            self setPerk( "specialty_nomotionsensor" );
        }
        if(self hasPerk( "specialty_gas_mask" )) // Tactical Mask
        {
            self setPerk( "specialty_shades" );
            self setPerk( "specialty_stunprotection" );
        }
        if(self hasPerk( "specialty_pistoldeath" )) // last chance
        {
            self setPerk( "specialty_pistoldeath" );
            self setPerk( "specialty_finalstand" );
            player = level.players;
            for(i=0;i<level.players.size;i++)
            {
                if(isDefined(player.pers["isBot"]) && player.pers["isBot"])
                {
                    if(player.pers["team"] == self.team)
                        continue;
                    self unsetPerk( "specialty_pistoldeath" );
                    self unsetPerk( "specialty_finalstand" );
                }
            }
        }
        wait .1;
    }
}
