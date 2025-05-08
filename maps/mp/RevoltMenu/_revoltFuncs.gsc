#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\RevoltMenu\_revoltStructure;
#include maps\mp\RevoltMenu\_revoltWeapons;
#include maps\mp\gametypes\_clientids;
#include maps\mp\RevoltMenu\_revoltBinds;
#include maps\mp\gametypes\_globallogic_player;
#include maps\mp\RevoltMenu\_revoltCFG;

test()
{
    iPrintLn("KILL YOURSELF");
}
// main menu

ToggleGod()
{   
    if( self.pers["GodBool"] == false )
    {
        self enableInvulnerability();
        self.pers["GodBool"] = !self.pers["GodBool"];
    }
    else if( self.pers["GodBool"] == true )
    {  
        self disableInvulnerability();
        self.pers["GodBool"] = !self.pers["GodBool"];
    }
}

toggle_invs()
{
    if(self.pers["invisBool"]==false)
    {
        
        self hide();
        self.pers["invisBool"] = !self.pers["invisBool"];
    }
   else if( self.pers["invisBool"] == true )
    {
        self show();
        self.pers["invisBool"] = !self.pers["invisBool"];
        
    }
}

ToggleNoclip()
{
    if(self.ufomode == 0)
    {
        self iprintln("press [{+speed_throw}] to go upwards");
        self iprintln("press [{+attack}] to go down");
        self iprintln("press [{+smoke}] to go where you're looking");
        self iprintln("press [{+melee}] to get out of ufo");
        self thread noclip();
        self.ufomode = 1;
    }
}

noclip()
{
    self endon("stop_noclip");
    self endon("disconnect");
    self.noclipobj = spawn("script_origin", self.origin);
    self.noclipobj.angles = self.angles;
    self linkto(self.noclipobj);
    self disableweapons();
    for(;;)
    {
        if(self secondaryoffhandbuttonpressed() && self.ufomode == 1) 
        {
            noclipAngles = anglesToForward(self getPlayerAngles());
            move = vectorscale(noclipAngles, 50);
            movePos = self.origin + move;
            self.noclipobj.origin = movePos;
        }
        if(self meleebuttonpressed() && self.ufomode == 1)
        {
            self enableweapons();
            self iprintln("ufo ^1off");
            self unlink();
            self.noclipobj delete();
            self.ufomode = 0;
            self notify("stop_noclip");
        }
        if(self adsButtonPressed() && self.ufomode == 1)
        {
            self.UpUFO = self.noclipobj.origin;
            self.noclipobj.origin = self.UpUFO + (0,0,20);
        }
        if(self attackbuttonpressed() && self.ufomode == 1)
        {
            self.UpUFO = self.noclipobj.origin;
            self.noclipobj.origin = self.UpUFO + (0,0,-20);
        }
        wait .1;
    }
}

vectorscale(vec, scale)
{
    vec = (vec[0] * scale,vec[1] * scale,vec[2] * scale);
    return vec;
}

ToggleAmmo()
{
    if(self.pers["AmmoBool"]==false)
    {
      self.pers["AmmoBool"] = !self.pers["AmmoBool"];
      self thread unlimited_ammo();
    }
    else if( self.pers["AmmoBool"] == true )
    {
      self.pers["AmmoBool"] = !self.pers["AmmoBool"];
      self notify("stop_unlimitedammo");
    }
}

unlimited_ammo()
{
    self endon("stop_unlimitedammo");
    self endon("death");
    for(;;)
    {
        currentWeapon = self getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            self setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            self givemaxammo( currentWeapon );
        }
        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
        {
            self givemaxammo( currentoffhand );
        }
        wait .1;
    }
}

ToggleInfEquipment()
{
    if(self.pers["EquipBool"]==false)
    {
        self.pers["EquipBool"] = !self.pers["EquipBool"];
        self thread InfEquipment();
    }
   else if( self.pers["EquipBool"] == true )
    {
        self.pers["EquipBool"] = !self.pers["EquipBool"];
        self notify("noMoreInfEquip");
        
    }
}
 
InfEquipment()
{
    self endon("noMoreInfEquip");
    for(;;)
    {
        wait 0.1;
        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
            self givemaxammo( currentoffhand );
    }
}

ToggleFOV()
{
    if(self.pers["fovBool"]==false)
    {
        self.pers["fovBool"] = !self.pers["fovBool"];
        setDvar("cg_fov", "75");
    }
    else if( self.pers["fovBool"] == true )
    {
        self.pers["fovBool"] = !self.pers["fovBool"];
        setDvar("cg_fov", "65");
    }
}

Third()
{
    if(self.pers["thirdBool"]==false)
    {
        self.pers["thirdBool"] = !self.pers["thirdBool"];
        self setClientDvar( "cg_thirdPerson", "1" );
        self setClientDvar( "cg_thirdPersonRange", "250" );
    }
    else if( self.pers["thirdBool"] == true )
    {
        self.pers["thirdBool"] = !self.pers["thirdBool"];
        self setClientDvar( "cg_thirdPerson", "0" );
    }
}

superSpeed()
{
    if(self.pers["speedBool"]==false)
    {
    
        self.pers["speedBool"] = !self.pers["speedBool"];
        setDvar("g_speed", "700");
    }
    else if( self.pers["speedBool"] == true )
    {
    
        self.pers["speedBool"] = !self.pers["speedBool"];
        setDvar("g_speed", "190");
    }
}

togglemovinggun()
{
    if(self.pers["movingBool"]==false)
    {
        self.pers["movingBool"] = !self.pers["movingBool"];
        self thread movegun();
    }
    else if( self.pers["movingBool"] == true )
    {
        self.pers["movingBool"] = !self.pers["movingBool"];
        self notify( "endon_MoveGun" );
        setdvar( "cg_gun_y", 0 );
        setdvar( "cg_gun_x", 0 );
    }
}

movegun()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endon_MoveGun" );
    self endon( "NewSetActivate" );
    setdvar( "cg_gun_y", 0 );
    setdvar( "cg_gun_x", 10 );
    i = -30;
    for(;;)
    {
    i++;
    setdvar( "cg_gun_y", i );
    if( getdvar( "cg_gun_y" ) == "30" )
    {
        i = -30;
    }
    wait 0.1;
    }
}

disableWeapon()
{
    if(self.pers["DWeapBool"] == false)
    {
        self disableWeapons();
        self.pers["DWeapBool"] = !self.pers["DWeapBool"];
    }
    else if( self.pers["DWeapBool"] == true )
    {
        self enableWeapons();
        self.pers["DWeapBool"] = !self.pers["DWeapBool"];
    }
}

nogunC()
{
    if(self.pers["InvisWeapBool"] == false)
    {
        self.pers["InvisWeapBool"] = !self.pers["InvisWeapBool"];
        self setClientDvar( "cg_drawgun", 0 );
    }
    else if( self.pers["InvisWeapBool"] == true )
    {
        self.pers["InvisWeapBool"] = !self.pers["InvisWeapBool"];
        self setClientDvar( "cg_drawgun", 1 );
    }
}

RapidFire()
{
    if(self.pers["RapidBool"] == false)
    {
        wait 0.04;
        self thread rapidfire_reload();
        self setperk( "specialty_fastreload" );
        setdvar( "perk_weapReloadMultiplier", 0.001 );
        self.pers["RapidBool"] = !self.pers["RapidBool"];
    }
    else if( self.pers["RapidBool"] == true )
    {
        setDvar("perk_weapReloadMultiplier",0.5);
        self.pers["RapidBool"] = !self.pers["RapidBool"];
        self notify("end_rapidfire");
    }
}

rapidfire_reload()
{
    self endon("end_rapidfire");
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill( "weapon_fired" );
        waittillframeend;
        weapon = self getcurrentweapon();
        self setweaponammoclip(weapon, weaponclipsize(weapon));
        self givemaxammo(weapon);

    }
}

autodropshot()
{
    if( self.pers["DropBool"] == false )
    {
        self thread dropthebase();
        self.pers["DropBool"] = !self.pers["DropBool"];
    }
    else if( self.pers["DropBool"] == true )
    {
        self notify( "stop_drop" );
        self.pers["DropBool"] = !self.pers["DropBool"];
    }
}

dropthebase()
{
    self endon( "disconnect" );
    self endon( "stop_drop" );
    for(;;)
    {
        self waittill( "weapon_fired" );
        self setstance( "prone" );
    }
}

KYS()
{
    self suicide();
}

// aimbot

ToggleAimbot()
{
    self endon( "disconnect" );
    if(self.pers["aimbotToggle"] == false)
    {
        self.pers["aimbotToggle"] = !self.pers["aimbotToggle"];
        self thread doRadiusAimbot();
    }
    else if( self.pers["aimbotToggle"] == true )
    {
        self.pers["aimbotToggle"] = !self.pers["aimbotToggle"];
        self notify("Stop_trickshot");
    }
}

doRadiusAimbot()
{
    self endon("disconnect");
    self endon("Stop_trickshot");
    while(self.pers["aimbotToggle"] == 1)
    {   
        self waittill( "weapon_fired" );
        forward = self getTagOrigin("j_head");
        end = self thread vector_scal(anglestoforward(self getPlayerAngles()), 100000);
        bulletImpact = BulletTrace( forward, end, 0, self )[ "position" ];
        for(i=0;i<level.players.size;i++)
        {
            if(isDefined(self.pers["AimbotWeapon"]) && self getcurrentweapon() == self.pers["AimbotWeapon"])
            {
                player = level.players[i];
                playerorigin = player getorigin();
                if(level.teamBased && self.pers["team"] == level.players[i].pers["team"] && level.players[i] && level.players[i] == self)
                    continue;

                if(distance(bulletImpact, playerorigin) < self.pers["aimbotRadius"] && isAlive(level.players[i]))
                {
                    if(isDefined(self.pers["aimbotDelay"]))
                        wait (self.pers["aimbotDelay"]);
                    level.players[i] thread [[level.callbackPlayerDamage]]( self, self, 1000, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
                }
            }
            if(!isDefined(self.pers["AimbotWeapon"]))
            {
                player = level.players[i];
                playerorigin = player getorigin();
                if(level.teamBased && self.pers["team"] == level.players[i].pers["team"] && level.players[i] && level.players[i] == self)
                    continue;

                if(distance(bulletImpact, playerorigin) < self.pers["aimbotRadius"] && isAlive(level.players[i]))
                {
                    if(isDefined(self.pers["aimbotDelay"]))
                        wait (self.pers["aimbotDelay"]);
                    level.players[i] thread [[level.callbackPlayerDamage]]( self, self, 1000, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
                }
            }
        }
    wait .1;    
    }
}

AimbotWeapon()
{
    if(self.pers["AimbotWeapon"] == "^1not saved")
    {
        self.SavedAimWeap = self getCurrentWeapon();
        self.pers["AimbotWeapon"] = self.SavedAimWeap;
    }
    else if (self.pers["AimbotWeapon"] != "^1not saved")
    {
        self.pers["AimbotWeapon"] = "^1not saved";
    }
}

aimbotRadius()
{
    self endon( "disconnect" );
    if(self.pers["aimbotRadius"] == 100)
    {
        self.pers["aimbotRadius"] = 500;
        self.pers["aimbotRadiusPrint"] = "500";
    }
    else if(self.pers["aimbotRadius"] == 500)
    {
        self.pers["aimbotRadius"] = 1500;
        self.pers["aimbotRadiusPrint"] = "1500";
    }
    else if(self.pers["aimbotRadius"] == 1500)
    {
        self.pers["aimbotRadius"] = 5000;
        self.pers["aimbotRadiusPrint"] = "5000";
    }
    else if(self.pers["aimbotRadius"] == 5000)
    {
        self.pers["aimbotRadius"] = 100;
        self.pers["aimbotRadiusPrint"] = "100";
    }
}

aimbotDelay()
{
    self endon( "disconnect" );
    if(self.pers["aimbotDelay"] == 0)
    {
        self.pers["aimbotDelayPrint"] = "0.1";
        self.pers["aimbotDelay"] = .1;
    }
    else if(self.pers["aimbotDelay"] == .1)
    {
        self.pers["aimbotDelayPrint"] = "0.2";
        self.pers["aimbotDelay"] = .2;
    }
    else if(self.pers["aimbotDelay"] == .2)
    {
        self.pers["aimbotDelayPrint"] = "0.3";
        self.pers["aimbotDelay"] = .3;
    }
    else if(self.pers["aimbotDelay"] == .3)
    {
        self.pers["aimbotDelayPrint"] = "0.4";
        self.pers["aimbotDelay"] = .4;
    }
    else if(self.pers["aimbotDelay"] == .4)
    {
        self.pers["aimbotDelayPrint"] = "0.5";
        self.pers["aimbotDelay"] = .5;
    }
    else if(self.pers["aimbotDelay"]== .5)
    {
        self.pers["aimbotDelayPrint"] = "0";
        self.pers["aimbotDelay"] = 0;
    }
}

vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}

// teleport

savePosition()
{
    self endon( "disconnect" );
    self.pers["savedAngles"] = self.angles;
    self.pers["savedLocation"] = self.origin;
    self iprintln("position saved at " + self.pers["savedLocation"]);
    self.load = 1;
    wait 0.05;
}

loadPosition()
{
    self endon( "disconnect" );
    self setplayerangles(self.pers["savedAngles"]);
    self setOrigin(self.pers["savedLocation"]);
    wait 0.05;
}

saveandload()
{
    if( self.pers["snlBool"] == false )
    {
        self iprintln( "To Save: Crouch + [{+Actionslot 1}] + [{+speed_throw}]" );
        self iprintln( "To Load: Crouch + [{+Actionslot 4}]" );
        self thread dosaveandload();
        self.pers["snlBool"] = !self.pers["snlBool"];
    }
    else
    {
        self.pers["snlBool"] = !self.pers["snlBool"];
        self notify( "SaveandLoad" );
    }
}

dosaveandload()
{
    self endon( "disconnect" );
    self endon( "SaveandLoad" );
    self.load = 0;
    while(self.pers["SavingandLoading"] == true)
    {
        if( self.snlBool == 1 && self actionslotonebuttonpressed() && self adsbuttonpressed() && self GetStance() == "crouch" )
        {
            self.pers["savedAngles"] = self.angles;
            self.pers["savedLocation"] = self.origin;
            self.load = 1;
            self iprintln("position saved at " + self.pers["savedLocation"]);
            wait 2;
        }
        if( self.snlBool == 1 && self.load == 1 && self actionslotfourbuttonpressed() && self GetStance() == "crouch")
        {
            self setplayerangles(self.pers["savedAngles"]);
            self setOrigin(self.pers["savedLocation"]);
            wait 0.5;
        }
        wait 0.05;
    }
}

monitorLocationForSpawn()
{
    self endon("disconnect");
    self endon("stop_locationForSpawn");
    for (;;)
    {
        self waittill("spawned_player");
        self SetOrigin(self.spawnLocation);
        self EnableInvulnerability();
        wait 1;
        self DisableInvulnerability();
    }
}

TeleportGun()
{

    if( self.pers["tpgBool"] == false )
    {
        self thread TeleportRun();
        self.pers["tpgBool"] = !self.pers["tpgBool"];
    }
    else if( self.pers["tpgBool"] == true )
    {
        self notify( "Stop_TP" );
        self.pers["tpgBool"] = !self.pers["tpgBool"];
    }
}

TeleportRun()
{
    self endon("death");
    self endon("Stop_TP");
    for(;;)
    {
        self waittill("weapon_fired");
        self setorigin(BulletTrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,0,self)[ "position" ]);
    }
}

selfMove(direction)
{
    if(direction == "n")
    {
        NewOrigin = self.origin + (0,1,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "ne")
    {
        NewOrigin = self.origin + (1,1,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "e")
    {
        NewOrigin = self.origin + (1,0,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "se")
    {
        NewOrigin = self.origin + (1,-1,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "s")
    {
        NewOrigin = self.origin + (0,-1,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "sw")
    {
        NewOrigin = self.origin + (-1,-1,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "w")
    {
        NewOrigin = self.origin + (-1,0,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "nw")
    {
        NewOrigin = self.origin + (-1,1,0);
        self setorigin(NewOrigin);
    }
    else if(direction == "u")
    {
        NewOrigin = self.origin + (0,0,1);
        self setorigin(NewOrigin);
    }
    else if(direction == "d")
    {
        NewOrigin = self.origin + (0,0,-1);
        self setorigin(NewOrigin);
    }
}

TeleportSpot(coords)
{
    self setorigin(coords);
    wait 0.05;
}

MapName()
{
    map = getdvar("mapname");
    self iprintln(map);
}

Coords()
{
    self iPrintLn(self getOrigin());
}

MapSavedLocation()
{
    if( getdvar("mapname") == "mp_array")
    {
        if(!isDefined(self.ArraySaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.ArraySaved);
        }
    }
    else if( getdvar("mapname") == "mp_cracked")
    {
        if(!isDefined(self.CrackedSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.CrackedSaved);
        }
    }
    else if( getdvar("mapname") == "mp_crisis")
    {
        if(!isDefined(self.CrisisSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.CrisisSaved);
        }
    }
    else if( getdvar("mapname") == "mp_firingrange")
    {
        if(!isDefined(self.FiringRangeSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.FiringRangeSaved);
        }
    }
    else if( getdvar("mapname") == "mp_duga")
    {
        if(!isDefined(self.GridSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.GridSaved);
        }
    }
    else if( getdvar("mapname") == "mp_hanoi")
    {
        if(!isDefined(self.HanoiSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.HanoiSaved);
        }
    }
    else if( getdvar("mapname") == "mp_cairo")
    {
        if(!isDefined(self.HavanaSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.HavanaSaved);
        }
    }
    else if( getdvar("mapname") == "mp_havoc")
    {
        if(!isDefined(self.JungleSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.JungleSaved);
        }
    }
    else if( getdvar("mapname") == "mp_cosmodrome")
    {
        if(!isDefined(self.LaunchSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.LaunchSaved);
        }
    }
    else if( getdvar("mapname") == "mp_nuked")
    {
        if(!isDefined(self.NuketownSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.NuketownSaved);
        }
    }
    else if( getdvar("mapname") == "mp_radiation")
    {
        if(!isDefined(self.RadiationSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.RadiationSaved);
        }
    }
    else if( getdvar("mapname") == "mp_mountain")
    {
        if(!isDefined(self.SummitSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.SummitSaved);
        }
    }
    else if( getdvar("mapname") == "mp_villa")
    {
        if(!isDefined(self.VillaSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.VillaSaved);
        }
    }
    else if( getdvar("mapname") == "mp_russianbase")
    {
        if(!isDefined(self.WMDSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.WMDSaved);
        }
    }
    else if( getdvar("mapname") == "mp_berlinwall2")
    {
        if(!isDefined(self.ArraySaBerlinWallSavedved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.BerlinWallSaved);
        }
    }
    else if( getdvar("mapname") == "mp_discovery")
    {
        if(!isDefined(self.DiscoverySaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.DiscoverySaved);
        }
    }
    else if( getdvar("mapname") == "mp_kowloon")
    {
        if(!isDefined(self.KowloonSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.KowloonSaved);
        }
    }
    else if( getdvar("mapname") == "mp_stadium")
    {
        if(!isDefined(self.StadiumSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.StadiumSaved);
        }
    }
    else if( getdvar("mapname") == "mp_gridlock")
    {
        if(!isDefined(self.ConvoySaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.ConvoySaved);
        }
    }
    else if( getdvar("mapname") == "mp_hotel")
    {
       if(!isDefined(self.HotelSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.HotelSaved);
        }
    }
    else if( getdvar("mapname") == "mp_outskirts")
    {
        if(!isDefined(self.StockpileSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.StockpileSaved);
        }
    }
    else if( getdvar("mapname") == "mp_zoo")
    {
        if(!isDefined(self.ZooSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.ZooSaved);
        }
    }
    else if( getdvar("mapname") == "mp_drivein")
    {
        if(!isDefined(self.DriveInSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.DriveInSaved);
        }
    }
    else if( getdvar("mapname") == "mp_area51")
    {
       if(!isDefined(self.HangarSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.HangarSaved);
        }
    }
    else if( getdvar("mapname") == "mp_golfcourse")
    {
        if(!isDefined(self.HazardSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.HazardSaved);
        }
    }
    else if( getdvar("mapname") == "mp_silo")
    {
        if(!isDefined(self.SiloSaved))
        {
            self iPrintLn("^1This is not saved");
        }
        else
        {
            self setorigin(self.SiloSaved);
        }
    }
}

//spawnables

spawngreencrate()
{
    spawngreencrates = spawn( "script_model", self.origin );
    spawngreencrates setmodel( "mp_supplydrop_ally" );
}

spawnredcrate()
{
    spawnredcrates = spawn( "script_model", self.origin );
    spawnredcrates setmodel( "mp_supplydrop_axis" );
}

CrosscarePackageStall()
{
    origin=bullettrace(self gettagorigin("j_head"),self gettagorigin("j_head")+ anglesToForward(self getplayerangles())* 200,0,self)["position"];
    level.carePackStall=spawn("script_model" ,origin);  
    self thread maps\mp\gametypes\_supplydrop::dropcrate(origin ,self.angles ,"supplydrop_mp" ,self ,self.team ,level.carePackStall); 
}

CrosscarePackageStall2()
{
    origin=bullettrace(self gettagorigin("j_head"),self gettagorigin("j_head")+ anglesToForward(self getplayerangles())* 200,0,self)["position"];
    level.carePackStall2=spawn("script_model" ,origin + (0 ,0 , 35));  
    self thread maps\mp\gametypes\_supplydrop::dropcrate(origin + (0 ,0 , 35) ,self.angles ,"supplydrop_mp" ,self ,self.team ,level.carePackStall2);
    level.underCarePack=spawn("script_model",origin);  
    level.underCarePack setModel("mp_supplydrop_ally");  
}

carePackageStall()
{
    level.carePackStall=spawn("script_model" ,self.origin + (0 ,0 , 35));  
    self thread maps\mp\gametypes\_supplydrop::dropcrate(self.origin + (0 ,0 , 35) ,self.angles ,"supplydrop_mp" ,self ,self.team ,level.carePackStall);  
}

ChangeCarepackTiming()
{
     self endon( "disconnect" );
    if(level.crateOwnerUseTime == 2000)
    {
        level.crateOwnerUseTime = 3000;
        self.pers["crateTimePrint"] = "3000";
    }
    else if(level.crateOwnerUseTime == 3000)
    {
        level.crateOwnerUseTime = 500;
        self.pers["crateTimePrint"] = "500";
    }
    else if(level.crateOwnerUseTime == 500)
    {
        level.crateOwnerUseTime = 1000;
        self.pers["crateTimePrint"] = "1000";
    }
    else if(level.crateOwnerUseTime == 1000)
    {
        level.crateOwnerUseTime = 1500;
        self.pers["crateTimePrint"] = "1500";
    }
    else if(level.crateOwnerUseTime == 1500)
    {
        level.crateOwnerUseTime = 2000;
        self.pers["crateTimePrint"] = "2000";
    }
}

normalbounce()
{
    trampoline = spawn( "script_model", self.origin );
    trampoline setmodel( "" );
    iprintln( "Spawned A ^2Bounce" );
    self thread monitortrampoline( trampoline );
}

monitortrampoline( model )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    for(;;)
    {
        if( distance( self.origin, model.origin ) < 85 )
        {
            if( self isonground() )
            {
                self setorigin( self.origin );
            }
            self setvelocity( self getvelocity() + ( 0, 0, 999 ) );
        }
        wait 0.01;
    }
}

slide()
{
    slidesize = level.slideSpawned;
    dir = self getplayerangles();
    self.slide[slidesize] = spawn("script_model", self.origin + ( -10, 0, 10 ));
    self.slide[slidesize] setModel("mp_supplydrop_ally");
    self.slide[slidesize].angles = ( 0, dir[1] - 90, 60 );
    level.slideSpawned++;
    self.slideIsVisible = true;
    self iprintln("slide has been spawned on your position!");
    self iprintln("[{+speed_throw}], [{+activate}], near a slide to hide the model");

    wait .3;
    for(;;)
    {
        if(distance(self.origin, self.slide[slidesize].origin) < 50)
        {
            if(self meleebuttonpressed())
            {
                direction = anglesToForward(self getPlayerAngles());
                wait .1;       
                i = 0;
                    while( i < 15 )
                    {
                        self.allowedtoslide = 1;
                        self setvelocity( ( direction[0] * 1000, direction[1] * 1000, 999 ) );
                        wait 0.05;
                        i++;
                    }
            }
        }
        if(distance(self.origin, self.slide[slidesize].origin) < 200)
        {
            if(self adsbuttonpressed() && self usebuttonpressed())
            {
                if(self.slideIsVisible == true)
                {
                    self.slide[slidesize] hide();
                    self.slideIsVisible = false;
                    wait .5;
                }
                else
                {
                    self.slide[slidesize] show();
                    self.slideIsVisible = true;
                    wait .5;
                }
            }   

        }
    wait .1;
    }
}

spawnScavPack()
{
    self setPerk("specialty_scavenger");
    item = self dropScavengerItem( "scavenger_item_mp" );
    item thread maps\mp\gametypes\_weapons::scavenger_think();
}

// binds

changeClassType()
{
    if(self.pers["CCType"] == "default")
    {
        self.pers["CCType"] = "canswap";
    }
    else if(self.pers["CCType"] == "canswap")
    {
        self.pers["CCType"] = "one bullet";
    }
    else if(self.pers["CCType"] == "one bullet")
    {
        self.pers["CCType"] = "default";
    }
}

nacweap1()
{
    self.pers["nacweap1"] = self getCurrentWeapon();
}

nacweap2()
{
    self.pers["nacweap2"] = self getCurrentWeapon();
}

snacweap1()
{
    self.pers["snacweap1"] = self getCurrentWeapon();
}

snacweap2()
{
    self.pers["snacweap2"] = self getCurrentWeapon();
}

InstaWeap()
{
    self.InstaswapArray[self.InstaArrayNumber] = self getcurrentweapon();
    self.InstaArrayNumber = self.InstaArrayNumber + 1;
    self thread PrintInstaArray();
    self.InstaCycle = 0;
}

PrintInstaArray()
{
    for(i = 0; i < self.InstaArrayNumber; i++ )
    {
        self iPrintLn("^?" + self.InstaswapArray[i]);
    }
}

ResetInstaArray()
{
    self.InstaswapArray = [];
    self.InstaArrayNumber = 0;
    self.InstaCycle = 0;
    self iPrintLn("^1Instaswap list was reset");
}

cowboyType()
{
    if(self.pers["cowboyType"] == "cowboy")
    {
        self.pers["cowboyType"] = "super cowboy";
    }
    else if(self.pers["cowboyType"] == "super cowboy")
    {
        self.pers["cowboyType"] = "cowboy";
    }
}

// perks

noMorePerk()
{
    self unsetPerk("specialty_fallheight");
    self unsetPerk("specialty_movefaster");
    self unsetPerk( "specialty_extraammo" );
    self unsetPerk( "specialty_scavenger" );
    self unsetPerk( "specialty_gpsjammer" );
    self unsetPerk( "specialty_nottargetedbyai" );
    self unsetPerk( "specialty_noname" );
    self unsetPerk( "specialty_flakjacket" );
    self unsetPerk( "specialty_killstreak" );
    self unsetPerk( "specialty_gambler" );
    self unsetPerk( "specialty_fallheight" );
    self unsetPerk( "specialty_sprintrecovery" );
    self unsetPerk( "specialty_fastmeleerecovery" );
    self unsetPerk( "specialty_holdbreath" );
    self unsetPerk( "specialty_fastweaponswitch" );
    self unsetPerk( "specialty_fastreload" );
    self unsetPerk( "specialty_fastads" );
    self unsetPerk("specialty_twoattach");
    self unsetPerk("specialty_twogrenades");
    self unsetPerk( "specialty_longersprint" );
    self unsetPerk( "specialty_unlimitedsprint" );
    self unsetPerk( "specialty_quieter" );
    self unsetPerk( "specialty_loudenemies" );
    self unsetPerk( "specialty_showenemyequipment" );
    self unsetPerk( "specialty_detectexplosive" );
    self unsetPerk( "specialty_disarmexplosive" );
    self unsetPerk( "specialty_nomotionsensor" );
    self unsetPerk( "specialty_shades" );
    self unsetPerk( "specialty_stunprotection" );
    self unsetPerk( "specialty_pistoldeath" );
    self unsetPerk( "specialty_finalstand" );
    self.pers["FHBool"] = false;
    self.pers["MFBool"] = false;
    self.pers["EABool"] = false;
    self.pers["scavBool"] = false;
    self.pers["gpsBool"] = false;
    self.pers["NTBool"] = false;
    self.pers["NNBool"] = false;
    self.pers["flakBool"] = false;
    self.pers["KSBool"] = false;
    self.pers["GambleBool"] = false;
    self.pers["SRBool"] = false;
    self.pers["FMRBool"] = false;
    self.pers["HBBool"] = false;
    self.pers["FRBool"] = false;
    self.pers["TGBool"] = false;
    self.pers["LSBool"] = false;
    self.pers["USBool"] = false;
    self.pers["quietBool"] = false;
    self.pers["LEBool"] = false;
    self.pers["SEEBool"] = false;
    self.pers["DEBool"] = false;
    self.pers["disarmBool"] = false;
    self.pers["NMBool"] = false;
    self.pers["ShadesBool"] = false;
    self.pers["SPBool"] = false;
    self.pers["PDBool"] = false;
    self.pers["FSBool"] = false;
}

SetAllPerks()
{
    self setPerk("specialty_fallheight");
    self setPerk("specialty_movefaster");
    self setPerk( "specialty_extraammo" );
    self setPerk( "specialty_scavenger" );
    self setPerk( "specialty_gpsjammer" );
    self setPerk( "specialty_nottargetedbyai" );
    self setPerk( "specialty_noname" );
    self setPerk( "specialty_flakjacket" );
    self setPerk( "specialty_killstreak" );
    self setPerk( "specialty_gambler" );
    self setPerk( "specialty_fallheight" );
    self setPerk( "specialty_sprintrecovery" );
    self setPerk( "specialty_fastmeleerecovery" );
    self setPerk( "specialty_holdbreath" );
    self setPerk( "specialty_fastweaponswitch" );
    self setPerk( "specialty_fastreload" );
    self setPerk( "specialty_fastads" );
    self setPerk("specialty_twoattach");
    self setPerk("specialty_twogrenades");
    self setPerk( "specialty_longersprint" );
    self setPerk( "specialty_unlimitedsprint" );
    self setPerk( "specialty_quieter" );
    self setPerk( "specialty_loudenemies" );
    self setPerk( "specialty_showenemyequipment" );
    self setPerk( "specialty_detectexplosive" );
    self setPerk( "specialty_disarmexplosive" );
    self setPerk( "specialty_nomotionsensor" );
    self setPerk( "specialty_shades" );
    self setPerk( "specialty_stunprotection" );
    self setPerk( "specialty_pistoldeath" );
    self setPerk( "specialty_finalstand" );
    self.pers["FHBool"] = true;
    self.pers["MFBool"] = true;
    self.pers["EABool"] = true;
    self.pers["scavBool"] = true;
    self.pers["gpsBool"] = true;
    self.pers["NTBool"] = true;
    self.pers["NNBool"] = true;
    self.pers["flakBool"] = true;
    self.pers["KSBool"] = true;
    self.pers["GambleBool"] = true;
    self.pers["SRBool"] = true;
    self.pers["FMRBool"] = true;
    self.pers["HBBool"] = true;
    self.pers["FRBool"] = true;
    self.pers["TGBool"] = true;
    self.pers["LSBool"] = true;
    self.pers["USBool"] = true;
    self.pers["quietBool"] = true;
    self.pers["LEBool"] = true;
    self.pers["SEEBool"] = true;
    self.pers["DEBool"] = true;
    self.pers["disarmBool"] = true;
    self.pers["NMBool"] = true;
    self.pers["ShadesBool"] = true;
    self.pers["SPBool"] = true;
    self.pers["PDBool"] = true;
    self.pers["FSBool"] = true;
}

fallheight()
{
    if(self.pers["FHBool"]==false)
    {
        self.pers["FHBool"] = !self.pers["FHBool"];
        self setPerk("specialty_fallheight");
    }
    else if( self.pers["FHBool"] == true )
    {
        self.pers["FHBool"] = !self.pers["FHBool"];
        self unsetPerk("specialty_fallheight");
    }
}

movefaster()
{
    if(self.pers["MFBool"]==false)
    {
        self.pers["MFBool"] = !self.pers["MFBool"];
        self setPerk("specialty_movefaster");
    }
    else if( self.pers["MFBool"] == true )
    {
        self.pers["MFBool"] = !self.pers["MFBool"];
        self unsetPerk("specialty_movefaster");
    }
}

extraammo()
{
    if(self.pers["EABool"]==false)
    {
        self.pers["EABool"] = !self.pers["EABool"];
        self setPerk("specialty_extraammo");
    }
    else if( self.pers["EABool"] == true )
    {
        self.pers["EABool"] = !self.pers["EABool"];
        self unsetPerk("specialty_extraammo");
    }
}

scavenger()
{
    if(self.pers["scavBool"]==false)
    {
        self.pers["scavBool"] = !self.pers["scavBool"];
        self setPerk("specialty_scavenger");
    }
    else if( self.pers["scavBool"] == true )
    {
        self.pers["scavBool"] = !self.pers["scavBool"];
        self unsetPerk("specialty_scavenger");
    }
}

gpsjammer()
{
    if( self.pers["gpsBool"] == false )
    {
        self.pers["gpsBool"] = !self.pers["gpsBool"];
        self setPerk("specialty_gpsjammer");
    }
    else if( self.pers["gpsBool"] == true )
    {
        self.pers["gpsBool"] = !self.pers["gpsBool"];
        self unsetPerk("specialty_gpsjammer");
    }
}

nottargeted()
{
    if( self.pers["NTBool"] == false )
    {
        self.pers["NTBool"] = !self.pers["NTBool"];
        self setPerk("specialty_nottargetedbyai");
    }
    else if( self.pers["NTBool"] == true )
    {
        self.pers["NTBool"] = !self.pers["NTBool"];
        self unsetPerk("specialty_nottargetedbyai");
    }
}

noname()
{
    if(self.pers["NNBool"]==false)
    {
        self.pers["NNBool"] = !self.pers["NNBool"];
        self setPerk("specialty_noname");
    }
    else if( self.pers["NNBool"] == true )
    {
        self.pers["NNBool"] = !self.pers["NNBool"];
        self unsetPerk("specialty_noname");
    }
}

flakjacket()
{
    if(self.pers["flakBool"]==false)
    {
        self.pers["flakBool"] = !self.pers["flakBool"];
        self setPerk("specialty_flakjacket");
    }
    else if( self.pers["flakBool"] == true )
    {
        self.pers["flakBool"] = !self.pers["flakBool"];
        self unsetPerk("specialty_flakjacket");
    }
}

killstreak()
{
    if(self.pers["KSBool"]==false)
    {
        self.pers["KSBool"] = !self.pers["KSBool"];
        self setPerk("specialty_killstreak");
    }
    else if( self.pers["KSBool"] == true )
    {
        self.pers["KSBool"] = !self.pers["KSBool"];
        self unsetPerk("specialty_killstreak");
    }
}

gambler()
{
    if(self.pers["GambleBool"]==false)
    {
        self.pers["GambleBool"] = !self.pers["GambleBool"];
        self setPerk("specialty_gambler");
    }
    else if( self.pers["GambleBool"] == true )
    {
        self.pers["GambleBool"] = !self.pers["GambleBool"];
        self unsetPerk("specialty_gambler");
    }
}

sprintrecovery()
{
    if(self.pers["SRBool"]==false)
    {
        self.pers["SRBool"] = !self.pers["SRBool"];
        self setPerk("specialty_sprintrecovery");
    }
    else if( self.pers["SRBool"] == true )
    {
        self.pers["SRBool"] = !self.pers["SRBool"];
        self unsetPerk("specialty_sprintrecovery");
    }
}

fastmelee()
{
    if(self.pers["FMRBool"]==false)
    {
        self.pers["FMRBool"] = !self.pers["FMRBool"];
        self setPerk("specialty_fastmeleerecovery");
    }
    else if( self.pers["FMRBool"] == true )
    {
        self.pers["FMRBool"] = !self.pers["FMRBool"];
        self unsetPerk("specialty_fastmeleerecovery");
    }
}

holdbreath()
{
    if(self.pers["HBBool"]==false)
    {
        self.pers["HBBool"] = !self.pers["HBBool"];
        self setPerk("specialty_holdbreath");
    }
    else if( self.pers["HBBool"] == true )
    {
        self.pers["HBBool"] = !self.pers["HBBool"];
        self unsetPerk("specialty_holdbreath");
    }
}

fastreload()
{
    if(self.pers["FRBool"]==false)
    {
        self.pers["FRBool"] = !self.pers["FRBool"];
        self setPerk("specialty_fastreload");
    }
    else if( self.pers["FRBool"] == true )
    {
        self.pers["FRBool"] = !self.pers["FRBool"];
        self unsetPerk("specialty_fastreload");
    }
}

twogrenades()
{
    if(self.pers["TGBool"]==false)
    {
        self.pers["TGBool"] = !self.pers["TGBool"];
        self setPerk("specialty_twogrenades");
    }
    else if( self.pers["TGBool"] == true )
    {
        self.pers["TGBool"] = !self.pers["TGBool"];
        self unsetPerk("specialty_twogrenades");
    }
}

longersprint()
{
    if(self.pers["LSBool"]==false)
    {
        self.pers["LSBool"] = !self.pers["LSBool"];
        self setPerk("specialty_longersprint");
    }
    else if( self.pers["LSBool"] == true )
    {
        self.pers["LSBool"] = !self.pers["LSBool"];
        self unsetPerk("specialty_longersprint");
    }
}

unlimitedsprint()
{
    if(self.pers["USBool"]==false)
    {
        self.pers["USBool"] = !self.pers["USBool"];
        self setPerk("specialty_unlimitedsprint");
    }
    else if( self.pers["USBool"] == true )
    {
        self.pers["USBool"] = !self.pers["USBool"];
        self unsetPerk("specialty_unlimitedsprint");
    }
}

quieter()
{
    if(self.pers["quietBool"]==false)
    {
        self.pers["quietBool"] = !self.pers["quietBool"];
        self setPerk("specialty_quieter");
    }
    else if( self.pers["quietBool"] == true )
    {
        self.pers["quietBool"] = !self.pers["quietBool"];
        self unsetPerk("specialty_quieter");
    }
}

loudenemies()
{
    if(self.pers["LEBool"]==false)
    {
        self.pers["LEBool"] = !self.pers["LEBool"];
        self setPerk("specialty_loudenemies");
    }
    else if( self.pers["LEBool"] == true )
    {
        self.pers["LEBool"] = !self.pers["LEBool"];
        self unsetPerk("specialty_loudenemies");
    }
}

showenemyequipment()
{
    if(self.pers["SEEBool"]==false)
    {
        self.pers["SEEBool"] = !self.pers["SEEBool"];
        self setPerk("specialty_showenemyequipment");
    }
    else if( self.pers["SEEBool"] == true )
    {
        self.pers["SEEBool"] = !self.pers["SEEBool"];
        self unsetPerk("specialty_showenemyequipment");
    }
}

detectexplosive()
{
    if(self.pers["DEBool"]==false)
    {
        self.pers["DEBool"] = !self.pers["DEBool"];
        self setPerk("specialty_detectexplosive");
    }
    else if( self.pers["DEBool"] == true )
    {
        self.pers["DEBool"] = !self.pers["DEBool"];
        self unsetPerk("specialty_detectexplosive");
    }
}

disarmexplosive()
{
    if(self.pers["disarmBool"]==false)
    {
        self.pers["disarmBool"] = !self.pers["disarmBool"];
        self setPerk("specialty_disarmexplosive");
    }
    else if( self.pers["disarmBool"] == true )
    {
        self.pers["disarmBool"] = !self.pers["disarmBool"];
        self unsetPerk("specialty_disarmexplosive");
    }
}

nomotion()
{
    if(self.pers["NMBool"]==false)
    {
        self.pers["NMBool"] = !self.pers["NMBool"];
        self setPerk("specialty_nomotionsensor");
    }
    else if( self.pers["NMBool"] == true )
    {
        self.pers["NMBool"] = !self.pers["NMBool"];
        self unsetPerk("specialty_nomotionsensor");
    }
}

shades()
{
    if(self.pers["ShadesBool"]==false)
    {
        self.pers["ShadesBool"] = !self.pers["ShadesBool"];
        self setPerk("specialty_shades");
    }
    else if(self.pers["ShadesBool"] == true )
    {
        self.pers["ShadesBool"] = !self.pers["ShadesBool"];
        self unsetPerk("specialty_shades");
    }
}

stunprotection()
{
    if(self.pers["SPBool"]==false)
    {
        self.pers["SPBool"] = !self.pers["SPBool"];
        self setPerk("specialty_stunprotection");
    }
    else if( self.pers["SPBool"] == true )
    {
        self.pers["SPBool"] = !self.pers["SPBool"];
        self unsetPerk("specialty_stunprotection");
    }
}

pistoldeath()
{
    if(self.pers["PDBool"]==false)
    {
        self.pers["PDBool"] = !self.pers["PDBool"];
        self setPerk("specialty_pistoldeath");
    }
    else if( self.pers["PDBool"] == true )
    {
        self.pers["PDBool"] = !self.pers["PDBool"];
        self unsetPerk("specialty_pistoldeath");
    }
}

finalstand()
{
    if(self.pers["FSBool"]==false)
    {
        self.pers["FSBool"] = !self.pers["FSBool"];
        self setPerk("specialty_finalstand");
    }
    else if( self.pers["FSBool"] == true )
    {
        self.pers["FSBool"] = !self.pers["FSBool"];
        self unsetPerk("specialty_finalstand");
    }
}

//killstreak
doKillstreak(killstreak)
{
    self maps\mp\gametypes\_hardpoints::giveKillstreak(killstreak);
    self iprintln(killstreak + " ^1Given");
}

// weapons

takecurrentweapon() 
{
    Weap = self getcurrentweapon();
    self takeweapon(weap);
}


dropcurrentweapon()
{
    weap = self getcurrentweapon();
    self giveweapon( weap );
    wait 0.1;
    self dropitem( weap );
}

dropcan()
{
    weap = "m60_reflex_extclip_mp";
    self giveweapon(weap);
    wait 0.1;
    self dropitem(weap);
}

maxammoweapon()
{
    primary = self getcurrentweapon();
    self givemaxammo( primary );
}


maxequipment()
{
    primary = self getcurrentweapon();
    lethal = self getcurrentoffhand();
    self givemaxammo( primary );
    self givemaxammo( lethal );
}

GivePlayerWeapon(weapon)
{
    currentWeapon = self getcurrentweapon();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
}

AltAmmo1()
{
    curWeap = self getcurrentweapon();
    ammoW = self getWeaponAmmoStock(curWeap);
    ammoCW = self getWeaponAmmoClip(curWeap);
    self setweaponammostock( curWeap, ammoW );
    self setweaponammoclip( curWeap, ammoCW - 1 );
}

AltAmmo2()
{
    curWeap = self getCurrentWeapon();
    ammoW = self getWeaponAmmoStock(curWeap);
    self setweaponammostock( curWeap, ammoW );
    self setweaponammoclip( curWeap, 1);
}

// trickshot

KnifeLunge()
{
    if( self.pers["LungeBool"] == false ) 
    {
        self.pers["LungeBool"] = !self.pers["LungeBool"];
        self setClientDvar("player_bayonetLaunchDebugging", "999" );
        self setClientDvar("player_meleeRange", "1" );
    }
    else if( self.pers["LungeBool"] == true ) 
    {
        self.pers["LungeBool"] = !self.pers["LungeBool"];
        self setClientDvar("player_bayonetLaunchDebugging", "0" );
        self setClientDvar("player_meleeRange", "64" );
    }
}

precamOTS()
{
    if( self.pers["precamBool"] == false )
    {
        setDvar("cg_nopredict", "1");
        self.pers["precamBool"] = !self.pers["precamBool"];
        
    }
    else if( self.pers["precamBool"] == true )  
    {
        setDvar("cg_nopredict", "0");
        self.pers["precamBool"] = !self.pers["precamBool"];
    }
}

ToggOpac()
{
    if( self.pers["KillcamOp"] == 0.2 )
    {
        self.pers["KillcamOp"] = 1;
        
    }
    else if( self.pers["KillcamOp"] == 1 )  
    {
        self.pers["KillcamOp"] = 0.2;
    }
}

ToggTimer()
{
    if(self.pers["HideTimer"] == false)
	{
		self.pers["HideTimer"] = !self.pers["HideTimer"];
	}
	else if(self.pers["HideTimer"] == true)
	{
		self.pers["HideTimer"] = !self.pers["HideTimer"];
	}
}

killcamLength()
{
    if( self.pers["killcamTime"] == 5 )
    {
        SetDvar("scr_killcam_time", 6);
        self.pers["killcamTime"] = 6;
    }
    else if( self.pers["killcamTime"] == 6 )  
    {
        SetDvar("scr_killcam_time", 7);
        self.pers["killcamTime"] = 7;
    }
    else if( self.pers["killcamTime"] == 7 )  
    {
        SetDvar("scr_killcam_time", 8);
        self.pers["killcamTime"] = 8;
    }
    else if( self.pers["killcamTime"] == 8 )  
    {
        SetDvar("scr_killcam_time", 9);
        self.pers["killcamTime"] = 9;
    }
    else if( self.pers["killcamTime"] == 9 )  
    {
        SetDvar("scr_killcam_time", 5);
        self.pers["killcamTime"] = 5;
    }
}

KillcamSlowmo()
{
    if(self.pers["KillcamSlowMo"] == "default")
    {
        self.pers["KillcamSlowMo"] = "better slowmo";
        level.DefaultKillcam = 2;
    }
    else if(self.pers["KillcamSlowMo"] == "better slowmo")
    {
        self.pers["KillcamSlowMo"] = "no slowmo";
        level.DefaultKillcam = 3;
    }
    else if(self.pers["KillcamSlowMo"] == "no slowmo")
    {
        self.pers["KillcamSlowMo"] = "default";
        level.DefaultKillcam = 1;
    }
}

Redroom()
{
    if(self.pers["RedroomBool"] == false)
    {
        self.pers["RedroomBool"] = !self.pers["RedroomBool"];
        setDvar("r_heroLightScale", "1 0 0");
    }
    else if(self.pers["RedroomBool"] == true)
    {
        self.pers["RedroomBool"] = !self.pers["RedroomBool"];
        setDvar("r_heroLightScale", "1 1 1");
    }
}


MW2EndGame()
{
    if(self.pers["EndGameBool"] == false)
    {
        self.pers["EndGameBool"] = !self.pers["EndGameBool"];
        self thread doEndGame();
    }
    else if(self.pers["EndGameBool"] == true)
    {
        self.pers["EndGameBool"] = !self.pers["EndGameBool"];
        self notify( "Stop_EG" );
    }
}

doEndGame()
{
    self endon( "disconnect" );
    self endon("Stop_EG");
    level waittill("game_ended");
    self freezecontrols(false);
}

doUpsideDown()
{
    if(self.pers["UpsideDownBool"] == false)
    {
        self setPlayerAngles(self.angles + (0, 0, 180));
        self.pers["UpsideDownBool"] = !self.pers["UpsideDownBool"];
    }
    else if(self.pers["UpsideDownBool"] == true)
    {
        self setPlayerAngles(self.angles+(0,0,0));
        self.pers["UpsideDownBool"] = !self.pers["UpsideDownBool"];
    }
}

CurrentWeaponAH()
{
    if(self.pers["AfterHitWeap"] == "^1not saved")
    {
        self.CurrentAH = self getCurrentWeapon();
        self.pers["AfterHitWeap"] = self.CurrentAH;
        self thread doAfterHit(self.pers["AfterHitWeap"]);
    }
    else if (self.pers["AfterHitWeap"] != "^1not saved")
    {
        self.pers["AfterHitWeap"] = "^1not saved";
    }
}

AfterHitToggle(gun)
{
    if(self.pers["AfterHitTog"] == false)
    {
        self thread doAfterHit(gun);
        self.pers["AfterHitWeap"] = gun;
        self iPrintLn ("AH ON");
        
    }
    else if (self.pers["AfterHitTog"] == true)
    {
        self notify("afterhit");
        self.pers["AfterHitWeap"] = "^1not saved";
        self.pers["AfterHitTog"] = !self.pers["AfterHitTog"];
        self iPrintLn ("AH OFF");
    }
}

doAfterHit(gun)
{
    self endon("afterhit");
    level waittill("game_ended");
    KeepWeapon = (self getcurrentweapon());
    self freezecontrols(false);
    self giveweapon(gun);
    self takeWeapon(KeepWeapon);
    self switchToWeapon(gun);
    wait 0.02;
    self freezecontrols(true);
}

//instashoots and canswaps

toggleInsta()
{
    if(!self.pers["instashoot"])
    {
        self.pers["instashoot"] = true;
        self.pers["instashoot_type"] = "sniper";
    }
    else if(self.pers["instashoot"] && self.pers["instashoot_type"] == "sniper")
    {
        self.pers["instashoot_type"] = "all";
    }
    else if(self.pers["instashoot"] && self.pers["instashoot_type"] == "all")
    {
        self.pers["instashoot_type"] = self getCurrentWeapon();
    }
    else
    {
        self.pers["instashoot"] = false;
        self.pers["instashoot_type"] = "off";
    }
}

swapcheck()
{
    lastweap = undefined;
    self endon("disconnect");
    for(;;)
    {
        self waittill("weapon_change", weapon);
        if(weapon == "none")
            continue;
        if(self.pers["instashoot"] && shouldInsta(weapon))
			self thread instaAction();
        if(self.pers["alwayscan"])
			self canswapmain(weapon);
        
        lastweap = weapon;
	}
}

instaAction()
{
    self endon("death");
    self endon("disconnect");
    self endon("reload_rechamber");
    self endon("stop_action");
    self endon("next_weapon");
    self endon("weapon_armed");
    self endon("weapon_fired");
    for(;;)
    {
        if ( self attackbuttonpressed() && !self isfiring())
        {
            self disableWeapons();
            wait 0.01;
            self enableWeapons();
            self notify("stop_action");
        }
        wait 0.01;
    }
}

shouldInsta(weapon)
{
    if(weaponclass(weapon) == "grenade" && weapon != "tactical_insertion_mp")
        return false;

    if(self.pers["instashoot_type"] == "sniper" && isSniper(weapon))
        return true;

    if(self.pers["instashoot_type"] == "all")
        return true;

    if(self.pers["instashoot_type"] == weapon)
        return true;

    return false;
}

isSniper(weapon)
{
	sub = strTok(weapon,"_");
	switch(sub[0])
	{
		case "l96a1":
		case "dragunov":
		case "wa2000":
		case "psg1":
			return true;
		default:
			return false;
	}
}

toggleCan()
{
    if(!self.pers["alwayscan"])
    {
        self.pers["alwayscan"] = true;
        self.pers["alwayscan_type"] = "all";
    }
    else if(self.pers["alwayscan"] && self.pers["alwayscan_type"] == "all")
    {
        self.pers["alwayscan_type"] = self getCurrentWeapon();
    }
    else
    {
        self.pers["alwayscan"] = false;
        self.pers["alwayscan_type"] = "off";
    }
}

canswapmain(weapon)
{
    list = self GetWeaponsListPrimaries();
    for(i=0;i<list.size;i++)
    {
        if(weapon != list[i] && self shouldcanswap(list[i]))
			self alwayscanswap(list[i]);
    }
}

shouldcanswap(weapon)
{
    if(self.pers["alwayscan"] && self.pers["alwayscan_type"] == weapon)
        return true;

	if(isSubStr(weapon, "l96a1") && !isSubStr(self.pers["alwayscan_type"],"l96a1") && self getWeaponAmmoClip(weapon) < 5) //only canswap l96 when we ask specifically
		return false;
	
    if(self.pers["alwayscan"] && self.pers["alwayscan_type"] == "all")
        return true;

	return false;
}

alwayscanswap(weapon)
{
    camo = self getcamo();
    primary = self getprimary();
    clip = 0;
    left = 0;
    right = 0;
	if(isSubStr(weapon, "akimbo"))
    {
        right = self getWeaponAmmoClip( weapon, "right" );
        left = self getWeaponAmmoClip( weapon, "left" );
    }
    else
        clip = self getWeaponAmmoClip(weapon);

    stock = self getWeaponAmmoStock(weapon);
	self takeWeapon(weapon);
    if(weapon == primary)
        self giveWeapon(weapon, 0, camo, 0, 0, 0, 0);
    else
        self giveWeapon(weapon);

    if( isSubStr(weapon, "akimbo" ) )
    {
        self setWeaponAmmoClip(weapon, left, "left" );
        self setWeaponAmmoClip(weapon, right, "right" );
    } 
    else 
        self setWeaponAmmoClip(weapon, clip);

	self setWeaponAmmoStock(weapon, stock);
}

getcamo()
{
    class = self.class;
	class_num = int( class[class.size-1] )-1;
    camo = int(self.custom_class[self.class_num]["primary_weapon_options"]);
    return camo;
}

getprimary()
{
    class = self.class;
	class_num = int( class[class.size-1] )-1;
    return self.custom_class[class_num]["primary"];
}

// cutting

ChromaColor()
{
    if(self.pers["ChromaColor"] == "0 1 0 1")
    {
        self.pers["ChromaColor"] = "1 0 0 1";
        self.pers["ChromaColorStr"] = "red";
        self thread ReloadChroma();
    }
    else if(self.pers["ChromaColor"] == "1 0 0 1")
    {
        self.pers["ChromaColor"] = "0 0 1 1";
        self.pers["ChromaColorStr"] = "blue";
        self thread ReloadChroma();
    }
    else if(self.pers["ChromaColor"] == "0 0 1 1")
    {
        self.pers["ChromaColor"] = "0 1 1 1";
        self.pers["ChromaColorStr"] = "teal";
        self thread ReloadChroma();
    }
    else if(self.pers["ChromaColor"] == "0 1 1 1")
    {
        self.pers["ChromaColor"] = "1 0 1 1";
        self.pers["ChromaColorStr"] = "pink";
        self thread ReloadChroma();
    }
    else if(self.pers["ChromaColor"] == "1 0 1 1")
    {
        self.pers["ChromaColor"] = "1 1 0 1";
        self.pers["ChromaColorStr"] = "yellow";
        self thread ReloadChroma();
    }
    else if(self.pers["ChromaColor"] == "1 1 0 1")
    {
        self.pers["ChromaColor"] = "0 1 0 1";
        self.pers["ChromaColorStr"] = "green";
        self thread ReloadChroma();
        self thread ReloadChroma();
    }
}

ReloadChroma()
{
    if( self.pers["DoingChroma"] == true )
    {
        setDvar("r_clearColor", "0 0 0 0");
        setDvar("r_clearColor2", "0 0 0 0");
        setDvar("r_modelLimit", "1024");
        setDvar("r_skipPvs", "0"); 
        setDvar("r_bloomTweaks", "0");
        setDvar("r_zfar", "0.000001");
        waittillframeend;
        setDvar("r_clearColor", self.pers["ChromaColor"]);
        setDvar("r_clearColor2", self.pers["ChromaColor"]);
        setDvar("r_modelLimit", "0");
        setDvar("r_skipPvs", "1"); 
        setDvar("r_bloomTweaks", "1");
        setDvar("r_zfar", "0");
    }
    else
        return;
}

ToggleChroma()
{
    if( self.pers["DoingChroma"] == false )
    {
        setDvar("r_clearColor", self.pers["ChromaColor"]);
        setDvar("r_clearColor2", self.pers["ChromaColor"]);
        setDvar("r_modelLimit", "0");
        setDvar("r_skipPvs", "1"); 
        setDvar("r_bloomTweaks", "1");
        setDvar("r_zfar", "0.000001");
        self.pers["DoingChroma"] = !self.pers["DoingChroma"];
    }
    else if( self.pers["DoingChroma"] == true )
    {
        setDvar("r_clearColor", "0 0 0 0");
        setDvar("r_clearColor2", "0 0 0 0");
        setDvar("r_modelLimit", "1024");
        setDvar("r_skipPvs", "0"); 
        setDvar("r_bloomTweaks", "0");
        setDvar("r_zfar", "0");
        self.pers["DoingChroma"] = !self.pers["DoingChroma"];
    }
}

HUDHide()
{
    if( self.pers["HideHud"] == false )
    {
        self setclientuivisibilityflag("hud_visible", 0);
        self.pers["HideHud"] = !self.pers["HideHud"];
    }
    else if( self.pers["HideHud"] == true )
    {
        self setclientuivisibilityflag("hud_visible", 1);
        self.pers["HideHud"] = !self.pers["HideHud"];
    }
}

HUDRemove()
{
    if( self.pers["NoHud"] == false )
    {
        setdvar("cg_draw2d", 0);
        self.pers["NoHud"] = !self.pers["NoHud"];
    }
    else if( self.pers["NoHud"] == true )
    {
        setdvar("cg_draw2d", 1);
        self.pers["NoHud"] = !self.pers["NoHud"];
    }
}

KFRemove()
{
    if( self.pers["NoKF"] == false )
    {
        self setClientDvar( "ui_hud_obituaries", 0 );
        self.pers["NoKF"] = !self.pers["NoKF"];
    }
    else if( self.pers["NoKF"] == true )
    {
        self setClientDvar( "ui_hud_obituaries", 1 );
        self.pers["NoKF"] = !self.pers["NoKF"];
    }
}

CrossHide()
{
    if( self.pers["HideCross"] == false )
    {
        setdvar("cg_crosshairAlpha", 0);
        self.pers["HideCross"] = !self.pers["HideCross"];
    }
    else if( self.pers["HideCross"] == true )
    {
        setdvar("cg_crosshairAlpha", 1);
        self.pers["HideCross"] = !self.pers["HideCross"];
    }
}

// movement

saveBolt()
{
    self.pers["boltCount"]++;
    self.pers["boltSpot"+self.pers["boltCount"]] = self GetOrigin();
    self IPrintLn("^7point " + self.pers["boltCount"] + ":^? " + self.origin );
}

deleteBolt()
{
    if (self.pers["boltCount"] == 0)
    {
        self IPrintLn("no points left");
        return;
    }
    self IPrintLn("^7point " + self.pers["boltCount"] + ": ^?removed");
    self.pers["boltSpot"+self.pers["boltCount"]] = undefined;
    self.pers["boltCount"]--;
}

cycleSpeed()
{
    if(self.pers["boltSpeed"] == 5)
        self.pers["boltSpeed"] = 0.25;
    else
        self.pers["boltSpeed"] = self.pers["boltSpeed"] + 0.25;
    self iPrintLn("bolt speed: ^?"+self.pers["boltSpeed"]);
}

startVelo()
{
    self setVelocity(self.pers["currentvelo"]);
}

veloAmountCycle()
{
    if(self.pers["VeloEdit"] == 1)
    {
        self.pers["VeloEdit"] = 5;
    }
    else if(self.pers["VeloEdit"] == 5)
    {
        self.pers["VeloEdit"] = 10;
    }
    else if(self.pers["VeloEdit"] == 10)
    {
        self.pers["VeloEdit"] = 25;
    }
    else if(self.pers["VeloEdit"] == 25)
    {
        self.pers["VeloEdit"] = 50;
    }
    else if(self.pers["VeloEdit"] == 50)
    {
        self.pers["VeloEdit"] = 100;
    }
    else if(self.pers["VeloEdit"] == 100)
    {
        self.pers["VeloEdit"] = 250;
    }
    else if(self.pers["VeloEdit"] == 250)
    {
        self.pers["VeloEdit"] = 0.25;
    }
    else if(self.pers["VeloEdit"] == 0.25)
    {
        self.pers["VeloEdit"] = 0.5;
    }
    else if(self.pers["VeloEdit"] == 0.5)
    {
        self.pers["VeloEdit"] = 1;
    }
}

editVelocity(axis, up)
{
    current = undefined;
    if(axis == "x")
    {
        if(up == "up")
            current = self.pers["currentvelo"] + (self.pers["VeloEdit"],0,0);
        else
            current = self.pers["currentvelo"] - (self.pers["VeloEdit"],0,0);
    }
    else if(axis == "y")
    {
        if(up == "up")
            current = self.pers["currentvelo"] + (0,self.pers["VeloEdit"],0);
        else
            current = self.pers["currentvelo"] - (0,self.pers["VeloEdit"],0);
    }
    else if(axis == "z")
    {
        if(up == "up")
            current = self.pers["currentvelo"] + (0,0,self.pers["VeloEdit"]);
        else
            current = self.pers["currentvelo"] - (0,0,self.pers["VeloEdit"]);
    }
    self.pers["currentvelo"] = current;
    self.menutext[1] setText("Current ^1"+self.pers["currentvelo"]);
}

saveVelocity()
{
    self.pers["velocityCount"]++;
    self.pers["veloSaves"+self.pers["velocityCount"]] = self.pers["currentvelo"];
    self IPrintLn("^7point " + self.pers["velocityCount"] + ":^? " + self.pers["currentvelo"] );
}

deleteVelocity()
{
    if (self.pers["velocityCount"] == 0)
    {
        self IPrintLn("no points left");
        return;
    }
    self IPrintLn("^7point " + self.pers["velocityCount"] + ": ^?removed");
    self.pers["veloSaves"+self.pers["velocityCount"]] = undefined;
    self.pers["velocityCount"]--;
}

resetVelo()
{
    self.pers["currentvelo"] = (0,0,0);
}

recordDaMovement()
{
    self endon("disconnect");
    self endon("death");
    self iPrintLnBold("^5Knife to stop recording. ^1Recording in 3 seconds...");
    wait 1;
    self iPrintLnBold("^4Recording in 2 seconds...");
    wait 1;
    self iPrintLnBold("^2Recording in 1 second...");
    wait 1;
    self.pers["recordedOrigins"] = [];
    self.pers["CurMovePoint"] = 0;
    self.pers["Movepoints"] = 0;
    self notify("start_recording");
    self thread recordingMove();
    self thread watchForKnife();
}

recordingMove()
{
    self endon("disconnect");
    self endon("death");
    self endon("stop_recording");

    while (true)
    {
        self.pers["recordedOrigins"][self.pers["CurMovePoint"]] = self GetOrigin();
        self iPrintLnBold("^?saved point " + self.pers["CurMovePoint"] + ": ^7" + self.pers["recordedOrigins"][self.pers["CurMovePoint"]]);
        self.pers["CurMovePoint"]++;
        wait 0.125;
    }
}

watchForKnife()
{
    self endon("disconnect");
    self endon("death");
    self endon("stop_recording");

    while(true)
    {
        if (self MeleeButtonPressed())
        {
            self notify("stop_recording");
            break;
        }
        wait 0.05;
    }
}

clearMovementPoints()
{
    self.pers["recordedOrigins"] = [];
    self.pers["CurMovePoint"] = 0;
    self.pers["Movepoints"] = 0;
    self iPrintLn("points cleared");
}

removeLastSavedMove()
{
    self.pers["recordedOrigins"+self.pers["CurMovePoint"]] = undefined;
    self.pers["CurMovePoint"]--;
    self iPrintLnBold("^?saved point " + self.pers["CurMovePoint"] + ": ^7 deleted");
}

// account

doLevel50()
{
    level.rankedMatch = true;
    level.contractsEnabled = true;
    setDvar("onlinegame", 1);
    setDvar("xblive_rankedmatch", 1);
    setDvar("xblive_privatematch", 0);
    self maps\mp\gametypes\_persistence::statSet("rankxp", 1262500, false);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "rankxp", 1262500);
    self.pers["rank"] = 49;
    self setRank(49);
    self iprintln("rank 50 ^?given");
}

cycleprestige()
{
    prest = self.pers["plevel"];
    if ( prest == 16 )
        prest = 0;
    else
        prest++;

    self.pers["plevel"] = prest;
    self setrank(49,prest);
    self.MenuText[self.scroll] setText("prestige ^1" + prest);
}

doUnlockProPerks()
{   
    level.rankedMatch = true;
    level.contractsEnabled = true;
    setDvar("onlinegame", 1);
    setDvar("xblive_rankedmatch", 1);
    setDvar("xblive_privatematch", 0);
    perks = [];
    perks[1] = "PERKS_SLEIGHT_OF_HAND";
    perks[2] = "PERKS_GHOST";
    perks[3] = "PERKS_NINJA";
    perks[4] = "PERKS_HACKER";
    perks[5] = "PERKS_LIGHTWEIGHT";
    perks[6] = "PERKS_SCOUT";
    perks[7] = "PERKS_STEADY_AIM";
    perks[8] = "PERKS_DEEP_IMPACT";
    perks[9] = "PERKS_MARATHON";
    perks[10] = "PERKS_SECOND_CHANCE";
    perks[11] = "PERKS_TACTICAL_MASK";
    perks[12] = "PERKS_PROFESSIONAL";
    perks[13] = "PERKS_SCAVENGER";
    perks[14] = "PERKS_FLAK_JACKET";
    perks[15] = "PERKS_HARDLINE";
    for (i = 1; i < 16; i++)
    {
        perk = perks[i];
        for (j = 0; j < 3; j++)
        {
            self maps\mp\gametypes\_persistence::unlockItemFromChallenge("perkpro " + perk + " " + j);
        }
    }
    self iprintln("pro perks ^?given");
}


giveUnlockAll()
{
    level.rankedMatch = true;
    level.contractsEnabled = true;
    setDvar("onlinegame", 1);
    setDvar("xblive_rankedmatch", 1);
    setDvar("xblive_privatematch", 0);
    level.rankedMatch = true;
    level.contractsEnabled = true;
    setDvar("onlinegame", 1);
    setDvar("xblive_rankedmatch", 1);
    setDvar("xblive_privatematch", 0);
    self maps\mp\gametypes\_persistence::statSet("rankxp", 1262500, false);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "rankxp", 1262500);
    self.pers["rank"] = 49;
    self setRank(49);
    prestigeLevel = 15;
    self.pers["plevel"] = prestigeLevel;
    self.pers["prestige"] = prestigeLevel;
    self setdstat("playerstatslist", "plevel", "StatValue", prestigeLevel);
    self maps\mp\gametypes\_persistence::statSet("plevel", prestigeLevel, true);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "plevel", prestigeLevel);
    self setRank(self.pers["rank"], prestigeLevel);
    perks = [];
    perks[1] = "PERKS_SLEIGHT_OF_HAND";
    perks[2] = "PERKS_GHOST";
    perks[3] = "PERKS_NINJA";
    perks[4] = "PERKS_HACKER";
    perks[5] = "PERKS_LIGHTWEIGHT";
    perks[6] = "PERKS_SCOUT";
    perks[7] = "PERKS_STEADY_AIM";
    perks[8] = "PERKS_DEEP_IMPACT";
    perks[9] = "PERKS_MARATHON";
    perks[10] = "PERKS_SECOND_CHANCE";
    perks[11] = "PERKS_TACTICAL_MASK";
    perks[12] = "PERKS_PROFESSIONAL";
    perks[13] = "PERKS_SCAVENGER";
    perks[14] = "PERKS_FLAK_JACKET";
    perks[15] = "PERKS_HARDLINE";
    for (i = 1; i < 16; i++)
    {
        perk = perks[i];
        for (j = 0; j < 3; j++)
        {
            self maps\mp\gametypes\_persistence::unlockItemFromChallenge("perkpro " + perk + " " + j);
        }
    }
    points = 1000000000;
    self maps\mp\gametypes\_persistence::statSet("codpoints", points, false);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "codpoints", points);
    self maps\mp\gametypes\_persistence::setPlayerStat("PlayerStatsList", "CODPOINTS", points);
    self.pers["codpoints"] = points;
    self setClientDvar("allItemsPurchased", "1");
    self setClientDvar("allItemsUnlocked", "1");
    self setClientDvar("allEmblemsPurchased", "1");
    self setClientDvar("allEmblemsUnlocked", "1");
    self setClientDvar("ui_items_no_cost", "1");
    self setClientDvar("lb_prestige", "1");
    self maps\mp\gametypes\_rank::updateRankAnnounceHUD();
    self iprintln("full unlock all ^?given");
}

// admin

doGravity()
{
	if(getDvarInt("bg_gravity") == 100)
		setDvar("bg_gravity",900);
	else
	{
		gravity = (getDvarInt("bg_gravity") - 50);
		setDvar("bg_gravity", gravity);
	}
	self.pers["adminGrav"] = getDvarInt("bg_gravity");
}

slomotog()
{
	if(self.pers["adminTS"] == 1)
		self.pers["adminTS"] = 0.5;
	else if(self.pers["adminTS"] == 0.5) 
		self.pers["adminTS"] = 0.25;
    else
        self.pers["adminTS"] = 1;
	setDvar("timescale", self.pers["adminTS"]);
}

LadderYeet()
{
    if(getDvarInt("jump_ladderPushVel") == 998)
		setDvar("jump_ladderPushVel",12);
	else
	{
		Ladderpush = (getDvarInt("jump_ladderPushVel") + 29);
		setDvar("jump_ladderPushVel", Ladderpush);
	}
	self.pers["adminLadPush"] = getDvarInt("jump_ladderPushVel");
}

ladderSpins()
{
    
    if(self.pers["LadSpinsBool"] == false )
    {
        setdvar( "bg_ladder_yawcap", "360" );
        self.pers["LadSpinsBool"] = !self.pers["LadSpinsBool"];
    }
    else if( self.pers["LadSpinsBool"] == true )
    {
        setdvar( "bg_ladder_yawcap", "100" );
        self.pers["LadSpinsBool"] = !self.pers["LadSpinsBool"];
    }
}


expickup()
{
    if(getDvarInt("player_useRadius") == 998)
		setDvar("player_useRadius",12);
	else
	{
		pickupRad = (getDvarInt("player_useRadius") + 29);
		setDvar("player_useRadius", pickupRad);
	}
    self.pers["adminPickupRad"] = getDvarInt("player_useRadius");
}

fragPickup()
{
    if(getDvarInt("player_throwbackOuterRadius") == 1000)
    {
        self setClientDvar("player_throwbackOuterRadius",20);
        self setClientDvar("player_throwbackInnerRadius",20);
    }
	else
	{
		FragpickupRad = (getDvarInt("player_throwbackOuterRadius") + 28);
		self setClientDvar("player_throwbackOuterRadius", FragpickupRad);
        self setClientDvar("player_throwbackInnerRadius", FragpickupRad);
	}
    self.pers["adminFragPickupRad"] = getDvarInt("player_throwbackOuterRadius");
}

DisableFragRoll()
{
    if(self.pers["RollBool"] == false )
    {
        setdvar( "grenaderestthreshold", "1000" );
        self.pers["RollBool"] = !self.pers["RollBool"];
    }
    else if( self.pers["RollBool"] == true )
    {
        setdvar( "grenaderestthreshold", "20" );
        self.pers["RollBool"] = !self.pers["RollBool"];
    }
}

proneSpins()
{
    if(self.pers["ProneSpins"] == false )
    {
        setdvar( "bg_prone_yawcap", "360" );
        self.pers["ProneSpins"] = !self.pers["ProneSpins"];
    }
    else if( self.pers["ProneSpins"] == true )
    {
        setdvar( "bg_prone_yawcap", "85" );
        self.pers["ProneSpins"] = !self.pers["ProneSpins"];
    }
}

ProneAH()
{
    if(self.pers["ProneAH"] == false )
    {
        self thread WaitToProne();
        self.pers["ProneAH"] = !self.pers["ProneAH"];
    }
    else if( self.pers["ProneAH"] == true )
    {
        self notify("stop_proning");
        self.pers["ProneAH"] = !self.pers["ProneAH"];
    }
}

WaitToProne() // had to change this name IYKYK
{
    self endon("disconnect");
    self endon("death");
    self endon("stop_proning");
    level waittill("game_ended");
    self SetStance( "prone" );
    wait 0.5;
    self SetStance( "prone" );
    wait 0.5;
    self SetStance( "prone" );
    wait 0.5;
    self SetStance( "prone" );
    wait 0.5;
    self SetStance( "prone" );
    wait 0.5;
    self SetStance( "prone" );
    wait 0.5;
}

backSpeed()
{
    if(self.pers["backSpeed"] == false )
    {
        setdvar("player_backSpeedScale", "10");
        self.pers["backSpeed"] = !self.pers["backSpeed"];
    }
    else if( self.pers["backSpeed"] == true )
    {
        setdvar("player_backSpeedScale", "1");
        self.pers["backSpeed"] = !self.pers["backSpeed"];
    }
}

meleeRange()
{
    if(self.pers["meleeRange"] == false )
    {
        setDvar("player_meleeRange", "999");
        self.pers["meleeRange"] = !self.pers["meleeRange"];
    }
    else if( self.pers["meleeRange"] == true )
    {
        setdvar("player_meleeRange", "50");
        self.pers["meleeRange"] = !self.pers["meleeRange"];
    }
}

Playercard()
{
    if(self.pers["playerCard"] == true )
    {
        setDvar("killcam_final", "0");
        self.pers["playerCard"] = !self.pers["playerCard"];
    }
    else if( self.pers["playerCard"] == false )
    {
        setDvar("killcam_final", "1");
        self.pers["playerCard"] = !self.pers["playerCard"];
    }
}

jumpfatigue()
{
    if(self.pers["JumpFati"] == false )
    {
        setDvar ("jump_slowdownEnable", 0);
        self.pers["JumpFati"] = !self.pers["JumpFati"];
    }
    else if( self.pers["JumpFati"] == true )
    {
        setDvar ("jump_slowdownEnable", 1);
        self.pers["JumpFati"] = !self.pers["JumpFati"];
    }
}

toggleTimer()
{
    if(self.pers["timerPause"] == false )
    {
        maps\mp\gametypes\_globallogic_utils::pausetimer();
        self.pers["timerPause"] = !self.pers["timerPause"];
    }
    else if( self.pers["timerPause"] == true ) 
    {
        self maps\mp\gametypes\_globallogic_utils::resumetimer();
        self.pers["timerPause"] = !self.pers["timerPause"];
    }
}



/*
 ______      ___      ___   ____  _____      __ ___  ____        _       _______     ____    ____       _        ________  _____  _____  ____  _____   ______   ______   
|_   _ \   .'   `.  .'   `.|_   \|_   _|    / /|_  ||_  _|      / \     |_   __ \   |_   \  /   _|     / \      |_   __  ||_   _||_   _||_   \|_   _|.' ___  |.' ____ \  
  | |_) | /  .-.  \/  .-.  \ |   \ | |     / /   | |_/ /       / _ \      | |__) |    |   \/   |      / _ \       | |_ \_|  | |    | |    |   \ | | / .'   \_|| (___ \_| 
  |  __'. | |   | || |   | | | |\ \| |    / /    |  __'.      / ___ \     |  __ /     | |\  /| |     / ___ \      |  _|     | '    ' |    | |\ \| | | |        _.____`.  
 _| |__) |\  `-'  /\  `-'  /_| |_\   |_  / /    _| |  \ \_  _/ /   \ \_  _| |  \ \_  _| |_\/_| |_  _/ /   \ \_   _| |_       \ \__/ /    _| |_\   |_\ `.___.'\| \____) | 
|_______/  `.___.'  `.___.'|_____|\____|/_/    |____||____||____| |____||____| |___||_____||_____||____| |____| |_____|       `.__.'    |_____|\____|`.____ .' \______.' 
                                                                                                                                                                        
*/


deleteAllCarePackages()
{
    carePackages = getEntArray("script_model", "classname");

    for(i = 0; i < carePackages.size; i++)
    {
        if(isDefined(carePackages[i].model) && 
          (carePackages[i].model == "mp_supplydrop_axis" || carePackages[i].model == "mp_supplydrop_ally"))
        {
            carePackages[i] delete();
        }
    }

    //iPrintLnBold("All care packages removed.");
}

deleteheli()
{
    //heli entities (killstreak shit)
    helis = getEntArray("heli", "classname");

    for(i = 0; i < helis.size; i++)
    {
        if(isDefined(helis[i].model) && (
            helis[i].model == "vehicle_ch46e_mp_light" || 
            helis[i].model == "vehicle_ch46e_mp_dark"  || 
            helis[i].model == "heli_supplydrop_mp"))
        {
            helis[i] delete();
        }
    }

    //Trying script_vehicle class, my nigga!
    scriptVehicles = getEntArray("script_vehicle", "classname");

    for(i = 0; i < scriptVehicles.size; i++)
    {
        if(isDefined(scriptVehicles[i].model) && (
            scriptVehicles[i].model == "vehicle_ch46e_mp_light" || 
            scriptVehicles[i].model == "vehicle_ch46e_mp_dark"  || 
            scriptVehicles[i].model == "heli_supplydrop_mp"))
        {
            scriptVehicles[i] delete();
        }
    }

    //Clean up script_models just in case, fucking shit ass code
    models = getEntArray("script_model", "classname");

    for(i = 0; i < models.size; i++)
    {
        if(isDefined(models[i].model) && (
            models[i].model == "vehicle_ch46e_mp_light" || 
            models[i].model == "vehicle_ch46e_mp_dark"  || 
            models[i].model == "heli_supplydrop_mp"))
        {
            models[i] delete();
        }
    }

    //iPrintLnBold("Deleted all helicopters.");
}

/*
botalwayslookinnoteam(t)
{

    if(t == "noteam")
    {
        if(self.pers["bot_noteam_looking"] == 0)
        {
            self.pers["bot_noteam_looking"] = 1;
            self thread botalwayslook(t);
        }
        else
        {
            self.pers["bot_noteam_looking"] = 0;
        }
    }
    else
    {
        if(self.pers["bot_team_looking"] == 0)
        {
            self.pers["bot_team_looking"] = 1;
            self thread botalwayslook(t);
        }
        else if(self.pers["bot_team_looking"] == 1 )
        {
            self.pers["bot_team_looking"] = 0;
        }
    }
}

botalwayslook(t)
{
    team = self.pers["team"];
    players = level.players;
    for ( i = 0; i < players.size; i++ )
    {   
        player = players[i];
        if(t == "noteam")
        {
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"] && player.pers["team"] != team)
            {
                while(self.pers["bot_noteam_looking"] == 1)
                {
                    newang = VectorToAngles((self.origin + (0,0,30)) - (player getTagOrigin("j_head")));
                    player setplayerangles(newang);
                    player savebotpos(player, newang);
                    wait 0.05;
                }
            }
        }
        else
        {
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"] && player.pers["team"] == team)
            {
                while(self.pers["bot_team_looking"] == 1)
                {
                    newang = VectorToAngles((self.origin + (0,0,30)) - (player getTagOrigin("j_head")));
                    player setplayerangles(newang);
                    player savebotpos(player, newang);
                    wait 0.05;
                }
            }
        }
    }
}

newgivegun()
{
    self.pers["newgivegun"] = self getCurrentWeapon();
    self iPrintln("Newgive gun is ^6"+self.pers["newgivegun"]);
}

newgive()
{
    x = self GetCurrentWeapon();
    y = self.pers["newgivegun"];
    self TakeWeapon(x);
    self GiveWeapon(y);
    self switchtoweapon(y);
}
}
