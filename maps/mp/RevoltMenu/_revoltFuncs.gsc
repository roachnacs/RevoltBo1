#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\RevoltMenu\_revoltStructure;
#include maps\mp\RevoltMenu\_revoltWeapons;
#include maps\mp\gametypes\_clientids;
#include maps\mp\RevoltMenu\_revoltBinds;
#include maps\mp\gametypes\_globallogic_player;

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
            self iprintln("ufo off");
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
    self iPrintLn("AMMO");
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

takegun()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
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
    if(self.pers["AimbotWeapon"] == "not saved")
    {
        self.SavedAimWeap = self getCurrentWeapon();
        self.pers["AimbotWeapon"] = self.SavedAimWeap;
    }
    else if (self.pers["AimbotWeapon"] != "not saved")
    {
        self.pers["AimbotWeapon"] = "not saved";
    }
}

aimbotRadius()
{
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


hitmarkerAimbot()
{
    if(self.pers["hitmarkerToggle"] == false)
    {
        self.pers["hitmarkerToggle"] = !self.pers["hitmarkerToggle"];
        self thread HmAimbot();
    }
    else if( self.pers["hitmarkerToggle"] == true )
    {
        self.pers["hitmarkerToggle"] = !self.pers["hitmarkerToggle"];
        self notify("Stop_trickshot");
    }
}

HmAimbot()
{
    self endon("disconnect");
    self endon("Stop_trickshot");
    while(self.pers["hitmarkerToggle"] == true)
    {   
        self waittill( "weapon_fired" );
        forward = self getTagOrigin("j_head");
        end = self thread vector_scal(anglestoforward(self getPlayerAngles()), 100000);
        bulletImpact = BulletTrace( forward, end, 0, self )[ "position" ];
        for(i=0;i<level.players.size;i++)
        {
            if(isDefined(self.pers["hitmarkerWeapon"]) && self getcurrentweapon() == self.pers["hitmarkerWeapon"])
            {
                player = level.players[i];
                playerorigin = player getorigin();
                if(level.teamBased && self.pers["team"] == level.players[i].pers["team"] && level.players[i] && level.players[i] == self)
                    continue;

                if(distance(bulletImpact, playerorigin) < self.pers["hitmarkerRadius"] && isAlive(level.players[i]))
                {
                    if(isDefined(self.pers["hitmarkerDelay"]))
                    wait (self.pers["hitmarkerDelay"]);
                    level.players[i] thread [[level.callbackPlayerDamage]]( self, self, 1, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
                }
            }
            if(!isDefined(self.pers["aimbotweapon"]))
            {
                player = level.players[i];
                playerorigin = player getorigin();
                if(level.teamBased && self.pers["team"] == level.players[i].pers["team"] && level.players[i] && level.players[i] == self)
                    continue;

                if(distance(bulletImpact, playerorigin) < self.pers["hitmarkerRadius"] && isAlive(level.players[i]))
                {
                    if(isDefined(self.pers["hitmarkerDelay"]))
                    wait (self.pers["hitmarkerDelay"]);
                    level.players[i] thread [[level.callbackPlayerDamage]]( self, self, 1, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
                }
            }
        }
        wait .1;    
    }
}

hitmarkerWeapon()
{
    if(self.pers["hitmarkerWeapon"] == "not saved")
    {
        self.SavedAimWeap = self getCurrentWeapon();
        self.pers["hitmarkerWeapon"] = self.SavedAimWeap;
    }
    else if (self.pers["hitmarkerWeapon"] != "not saved")
    {
        self.pers["hitmarkerWeapon"] = "not saved";
    }
}

hitmarkerRadius()
{
    if(self.pers["hitmarkerRadius"] == 100)
    {
        self.pers["hitmarkerRadius"] = 500;
    }
    else if(self.pers["hitmarkerRadius"] == 500)
    {
        self.pers["hitmarkerRadius"] = 1500;
    }
    else if(self.pers["hitmarkerRadius"] == 1500)
    {
        self.pers["hitmarkerRadius"] = 5000;
    }
    else if(self.pers["hitmarkerRadius"] == 5000)
    {
        self.pers["hitmarkerRadius"] = 100;
    }
}

hitmarkerDelay()
{
    if(self.pers["hitmarkerDelay"] == 0)
    {
        self.pers["hitmarkerDelay"] = .1;
    }
    else if(self.pers["hitmarkerDelay"] == .1)
    {
        self.pers["hitmarkerDelay"] = .2;
    }
    else if(self.pers["hitmarkerDelay"] == .2)
    {
        self.pers["hitmarkerDelay"] = .3;
    }
    else if(self.pers["hitmarkerDelay"] == .3)
    {
        self.pers["hitmarkerDelay"] = .4;
    }
    else if(self.pers["hitmarkerDelay"] == .4)
    {
        self.pers["hitmarkerDelay"] = .5;
    }
    else if(self.pers["hitmarkerDelay"]== .5)
    {
        self.pers["hitmarkerDelay"] = 0;
    }
}

equipAimbotTog()
{
    if(self.pers["equipAimbot"] == false)
    {
        self.pers["equipAimbot"] = !self.pers["equipAimbot"];
        self thread equipmentAimbot();
    }
    else if (self.pers["equipAimbot"] == true)
    {
        self.pers["equipAimbot"] = !self.pers["equipAimbot"];
       self notify("EquiAimbot");
    }
}

equipmentAimbot()
{
    self endon("disconnect");
    self endon("EquiAimbot");
    while(self.pers["equipAimbot"] == true)
    {    
        self waittill( "weapon_fired" );
        start = self getTagOrigin("j_head");
        end = self thread vector_scal( anglestoforward( self getPlayerAngles() ), 100000 );
        trace = BulletTrace( start, end, false, self )[ "position" ];
        for(i=0;i<level.c4array.size;i++)
        {
            c4 = level.c4array[i];
            if(distance(trace, c4 getorigin()) < 500)
            {
                c4 [[c4.detonate]]( self );
            }
        }
        wait .1;    
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
        self iprintln( "To ^?Save: ^7Crouch + [{+Actionslot 1}] + [{+speed_throw}]" );
        self iprintln( "To ^?Load: ^7Crouch + [{+Actionslot 4}]" );
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

savepoint()
{
    x = "function_savepoint";
    z = getDvarInt(x);

    if(z == 1)
        setDvar(x,2);
    else if(z == 2)
        setDvar(x,3);
    else if(z == 3)
        setDvar(x,4);
    else if(z == 4)
        setDvar(x,5);
    else setDvar(x,1);
}

savepos()
{
    x = getDvarInt("function_savepoint");
    setDvar("function_savex" + x,self.origin[0]);
    setDvar("function_savez" + x,self.origin[1]);
    setDvar("function_savey" + x,self.origin[2]);
    setDvar("function_savea" + x,self.angles[1]);
    setDvar("function_savemap" + x,getDvar("mapname"));
    self iPrintLn("position saved");
}

loadpos()
{
    x = getDvarInt("function_savepoint");
    if(getDvar("function_savemap" + x) == getDvar("mapname"))
    if(getDvar("function_savex"+ x != ""))
    {
        self setOrigin((getDvarFloat("function_savex"+ x),getDvarFloat("function_savez"+ x),getDvarFloat("function_savey"+ x)));
        self setPlayerAngles((0,getDvarFloat("function_savea"+ x),0));
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

RoachSavedSpots(num)
{
    if(num == 1)
    {
        self setorigin(self.StockpileSaved1);
    }
    else if(num == 2)
    {
        self setorigin(self.StockpileSaved2);
    }
}
MapSavedLocation()
{
    if( getdvar("mapname") == "mp_array")
    {
        if(!isDefined(self.ArraySaved))
        {
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
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
            self iPrintLn("This is not saved");
        }
        else
        {
            self setorigin(self.SiloSaved);
        }
    }
}

//spawnables

forgeMod()
{
    if(self.pers["ForgeBool"] == false )
    {
        self thread forgemodeon();
        self iprintln( "^?hold [{+speed_throw}] to move objects" );
        self.pers["ForgeBool"] = !self.pers["ForgeBool"];
    }
    else if(self.pers["ForgeBool"] == true )
    {
        self notify( "stop_forge" );
        self.pers["ForgeBool"] = !self.pers["ForgeBool"];
    }
}

ChangeForgeRad()
{
    if(self.pers["ForgeRad"] == 200)
    {
        self.pers["ForgeRad"] = 300;
    }
    else if(self.pers["ForgeRad"] == 300)
    {
        self.pers["ForgeRad"] = 400;
    }
    else if(self.pers["ForgeRad"] == 400)
    {
        self.pers["ForgeRad"] = 500;
    }
    else if(self.pers["ForgeRad"] == 500)
    {
        self.pers["ForgeRad"] = 50;
    }
    else if(self.pers["ForgeRad"] == 50)
    {
        self.pers["ForgeRad"] = 100;
    }
    else if(self.pers["ForgeRad"] == 100)
    {
        self.pers["ForgeRad"] = 200;
    }
}

forgemodeon()
{
    self endon( "death" );
    self endon( "stop_forge" );
    for(;;)
    {
    while( self adsbuttonpressed() )
    {
        trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
        while( self adsbuttonpressed() )
        {
            trace[ "entity"] setorigin( self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * self.pers["ForgeRad"] );
            trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* self.pers["ForgeRad"];
            wait 0.05;
        }
    }
    wait 0.05;
    }

}

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

createBounce()
{
    if (!isDefined(self.bounceActive) || !self.bounceActive)
    {
        bounceOrigin = self.origin;
        self.bounceActive = true;
        self iPrintln("bounce spawned: ^?" + bounceOrigin);
        level thread monitorBounce(bounceOrigin, self);
    }
    else
    {
        self iPrintln("delete current bounce first");
    }
}

deleteBounce()
{
    if (isDefined(self.bounceActive) && self.bounceActive)
    {
        self notify("stop_bounce");
        self.bounceActive = false;
        self iPrintln("bounce ^?deleted");
    }
}

monitorBounce(bounceOrigin, creator)
{
    creator endon("disconnect");
    level endon("game_ended");
    creator endon("stop_bounce");

    while (true)
    {
        players = getEntArray("player", "classname");
        for (i = 0; i < players.size; i++)
        {
            player = players[i];
            if (isDefined(player) && isAlive(player) && distance(player.origin, bounceOrigin) < 75)
            {
                if (!isDefined(player.lastBounceTime) || (getTime() - player.lastBounceTime) > 1500)
                {
                    velocity = player getVelocity();
                    player setVelocity(velocity + (0, 0, 450));
                    player.lastBounceTime = getTime();
                    //player iPrintln("Bounced!");
                }
            }
        }
        wait 0.05;
    }
}


spawnScavPack()
{
    self setPerk("specialty_scavenger");
    item = self dropScavengerItem( "scavenger_item_mp" );
    item thread maps\mp\gametypes\_weapons::scavenger_think();
}

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
}

SpawnHeli()
{
    self.DropZone2 = self.origin + (0,0,2500);
    self.DropZoneAngle2 = self.angle;
    players = level.players;
    bot = players[1];
    self thread maps\mp\gametypes\_supplydrop::NewHeli( self.DropZone2, "turret_drop_mp", bot, bot.team);
    self iprintln("Helicopter Spawned");
}

SpawnHeliFriend()
{
    self.DropZone2 = self.origin + (0,0,2500);
    self.DropZoneAngle2 = self.angle;
    self thread maps\mp\gametypes\_supplydrop::NewHeli( self.DropZone2, "turret_drop_mp", self, self.team);
    self iprintln("Helicopter Spawned");
}

deleteheli()
{
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
}


// binds


newgivegun()
{
    self.pers["newgivegun"] = self getCurrentWeapon();
    self iPrintln("Newgive gun is ^?"+self.pers["newgivegun"]);
}

newgive()
{
    x = self GetCurrentWeapon();
    y = self.pers["newgivegun"];
    self TakeWeapon(x);
    self GiveWeapon(y);
    self switchtoweapon(y);
}

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

InstaWeap1()
{  
    self.pers["instaweap1"] = self getCurrentWeapon();
}

InstaWeap2()
{
    self.pers["instaweap2"] = self getCurrentWeapon();
}

repeaterType()
{
    if(self.pers["RepeaterType"] == "default")
    {
        self.pers["RepeaterType"] = "real repeater";
    }
    else if(self.pers["RepeaterType"] == "real repeater")
    {
        self.pers["RepeaterType"] = "damage repeater";
    }
    else if(self.pers["RepeaterType"] == "damage repeater")
    {
        self.pers["RepeaterType"] = "frag repeater";
    }
    else if(self.pers["RepeaterType"] == "frag repeater")
    {
        self.pers["RepeaterType"] = "default";
    }
}

lastStandWeap()
{
	if(!isDefined(self.lsweap))
	{
		laststandweap = self getCurrentWeapon();
		level.laststandpistol = laststandweap;
		self.lsweap = true;
	}
	else if(isDefined(self.lsweap))
	{
		level.laststandpistol = "l96a1_mp";
		self.lsweap = undefined;
	}
}

get_next_weapon() 
{
    weapons_list = self getWeaponsListPrimaries();
    current_weapon = self getCurrentWeapon();
    for (i = 0; i < weapons_list.size; i++)
    {
        if (current_weapon == weapons_list[i])
        {
            if (isDefined(weapons_list[i + 1]))
            return weapons_list[i + 1];
            else
            return weapons_list[0];
        }
    }
}

elevatorSpeed()
{
    if(self.pers["elevatorSpeed"] == 8)
    {
        self.pers["elevatorSpeed"] = 3;
    }
	else
	{
		speed = (self.pers["elevatorSpeed"] + 1);
		self.pers["elevatorSpeed"] = speed;
	}
}

elevatorType()
{
    if(self.pers["elevatorType"] == "up")
    {
        self.pers["elevatorType"] = "down";
    }
    else if(self.pers["elevatorType"] == "down")
    {
        self.pers["elevatorType"] = "up";
    }
}

shaxTypeCycle()
{
    if(self.pers["shaxType"] == "default")
    {
        self.pers["shaxType"] = "real";
    }
    else if(self.pers["shaxType"] == "real")
    {
        self.pers["shaxType"] = "static screen";
    }
    else if(self.pers["shaxType"] == "static screen")
    {
        self.pers["shaxType"] = "black screen";
    }
    else if(self.pers["shaxType"] == "black screen")
    {
        self.pers["shaxType"] = "default";
    }
}

shaxSoH()
{
    if( self.pers["shaxSoH"] == false )
    {
        self.pers["shaxSoH"] = !self.pers["shaxSoH"];
    }
    else if( self.pers["shaxSoH"] == true )
    {  
        self.pers["shaxSoH"] = !self.pers["shaxSoH"];
    }
}

ShaxWeapon(weap)
{
    self iprintln("shax Weapon Set to ^?" + weap);
    self.pers["shaxGun"] = weap;
}

shaxKCCheck()
{
    self.isNotShaxWeapon = false;
    if(isSubStr(self.pers["shaxGun"], "skorpion"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.9;
            self.shaxTakeaway = 0.8;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.4;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "mp5k"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.6;
            self.shaxTakeaway = 0.9;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.9;
            self.shaxTakeaway = 0.46; 
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "ak74u"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.6;
            self.shaxTakeaway = 0.8;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.36;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "pm63"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.4;
            self.shaxTakeaway = 0.76;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.25;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "spectre"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.6;
            self.shaxTakeaway = 0.8;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.34;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "mac11"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.6;
            self.shaxTakeaway = 0.85;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.9;
            self.shaxTakeaway = 0.41;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "kiparis"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.4;
            self.shaxTakeaway = 0.78;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.78;
            self.shaxTakeaway = 0.4;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "mpl"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.74;
            self.shaxTakeaway = 0.78;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.9;
            self.shaxTakeaway = 0.4;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "uzi"))
    {

        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.64;
            self.shaxTakeaway = 0.93;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.85;
            self.shaxTakeaway = 0.56;
        }
    } 
    // ars
    else if(isSubStr(self.pers["shaxGun"], "m16"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.5;
            self.shaxTakeaway = 0.93;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.8;
            self.shaxTakeaway = 0.32;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "enfield"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.64;
            self.shaxTakeaway = 0.93;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.444;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "m14"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.79;
            self.shaxTakeaway = 1.21;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.52;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "famas"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.64;
            self.shaxTakeaway = 0.93;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.398;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "galil"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.78;
            self.shaxTakeaway = 1.502;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.594;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "aug"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.78;
            self.shaxTakeaway = 0.93;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.364;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "fnfal"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.78;
            self.shaxTakeaway = 0.92;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.45;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "ak47"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.78;
            self.shaxTakeaway = 1.1;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.43;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "commando"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 1.21;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.22;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "g11"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1.78;
            self.shaxTakeaway = 1.502;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.434;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "rottweil72"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.43;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.8;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "ithaca"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.18;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.71;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "spas"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 5.26;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.13;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "hs10"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 3.16;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 1.04;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "hk21"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 3.16;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1.2;
            self.shaxTakeaway = 0.746;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "rpk"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 3.92;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 1.51;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "m60"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 7;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 3.5;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "stoner63"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.27;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1.2;
            self.shaxTakeaway = 0.496;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "dragunov"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.09;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.53;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "wa2000"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.283;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.66;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "l96a1"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.27;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.7;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "psg1"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 2.07;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.526;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "asp"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.4;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.2;
            self.shaxTakeaway = 0.72;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "m1911"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.8;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.2;
            self.shaxTakeaway = 0.7;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "makarov"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.8;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.2;
            self.shaxTakeaway = 0.7;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "python"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 4.5;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 1.83;
        }
    }
    else if(isSubStr(self.pers["shaxGun"], "cz75"))
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shineShaxGunCheck = 1;
            self.shaxTakeaway = 0.793;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shineShaxGunCheck = 0.2;
        self.shaxTakeaway = 0.7;
        }
    }
    else
    {
        self.isNotShaxWeapon = true;
        self.shineShaxGunCheck = 0;
        self.shaxTakeaway = 0;
    }
}

doShax()
{
    currentWeapon = self getcurrentWeapon();
    self thread shaxKCCheck();
    self giveweapon(self.pers["shaxGun"]);
    self switchToWeapon(self.pers["shaxGun"]);
    self setWeaponAmmoClip(self.pers["shaxGun"], 0);
    doIt = self getWeaponAmmoStock(self.pers["shaxGun"]);
    wait 0.05;
    self setSpawnWeapon(self.pers["shaxGun"]);
    wait self.shineShaxGunCheck;
    self setWeaponAmmoStock(self.pers["shaxGun"], doIt);
    wait self.shaxTakeaway;
    self takeweapon(self.pers["shaxGun"]);
    wait 0.05;
    self switchToWeapon(currentWeapon);
}

shaxStatic()
{
    currentWeapon = self getcurrentWeapon();
    self thread shaxKCCheck();
    self thread doStaticScreen();
    self giveweapon(self.pers["shaxGun"]);
    self switchToWeapon(self.pers["shaxGun"]);
    self setWeaponAmmoClip(self.pers["shaxGun"], 0);
    doIt = self getWeaponAmmoStock(self.pers["shaxGun"]);
    wait 0.05;
    self setSpawnWeapon(self.pers["shaxGun"]);
    wait self.shineShaxGunCheck;
    self setWeaponAmmoStock(self.pers["shaxGun"], doIt);
    wait self.shaxTakeaway;
    self takeweapon(self.pers["shaxGun"]);
    wait 0.05;
    self switchToWeapon(currentWeapon);
}

shaxBlack() // sounds like jack black but shax, very funny stuff
{
    currentWeapon = self getcurrentWeapon();
    self thread shaxKCCheck();
    self thread BlackScreen();
    self giveweapon(self.pers["shaxGun"]);
    self switchToWeapon(self.pers["shaxGun"]);
    self setWeaponAmmoClip(self.pers["shaxGun"], 0);
    doIt = self getWeaponAmmoStock(self.pers["shaxGun"]);
    wait 0.05;
    self setSpawnWeapon(self.pers["shaxGun"]);
    wait self.shineShaxGunCheck;
    self setWeaponAmmoStock(self.pers["shaxGun"], doIt);
    wait self.shaxTakeaway;
    self takeweapon(self.pers["shaxGun"]);
    wait 0.05;
    self switchToWeapon(currentWeapon);
}

BlackScreen()
{
    if( !isdefined(self.blackscreen) )
    self.blackscreen = newclienthudelem( self );
    self.blackscreen.x = 0;
    self.blackscreen.y = 0; 
    self.blackscreen.horzAlign = "fullscreen";
    self.blackscreen.vertAlign = "fullscreen";
    self.blackscreen.foreground = false;
    self.blackscreen.hidewhendead = false;
    self.blackscreen.hidewheninmenu = true;
    self.blackscreen.sort = 50; 
    self.blackscreen SetShader( "black", 640, 480 ); 
    self.blackscreen.alpha = 0; 
    if( 0.01 >0  )
    self.blackscreen FadeOverTime( 0.001 ); 
    self.blackscreen.alpha = 1;
    wait( 0.001 );
    if( !isdefined(self.blackscreen) )
        return;

    wait( self.shineShaxGunCheck );
    if( !isdefined(self.blackscreen) )
        return;

    if( self.shineShaxGunCheck > 0 )
    self.blackscreen FadeOverTime( 0.3 ); 
    self.blackscreen.alpha = 0; 
    wait( 0.3 );

    if( isdefined(self.blackscreen) )           
    {
        self.blackscreen destroy();
        self.blackscreen = undefined;
    }
}

doStaticScreen()
{
    if( !isdefined(self.whitescreen) )
    self.whitescreen = newclienthudelem( self );
    self.whitescreen.x = 0;
    self.whitescreen.y = 0; 
    self.whitescreen.horzAlign = "fullscreen";
    self.whitescreen.vertAlign = "fullscreen";
    self.whitescreen.foreground = false;
    self.whitescreen.hidewhendead = false;
    self.whitescreen.hidewheninmenu = true;
    self.whitescreen.sort = 50; 
    self.whitescreen SetShader( "tow_filter_overlay_no_signal", 640, 480 ); 
    self.whitescreen.alpha = 0; 
    if( 0.01 > 0 )
    self.whitescreen FadeOverTime( 0.001 ); 
    self.whitescreen.alpha = 1; 
    wait( 0.001 );
    if( !isdefined(self.whitescreen) )
        return; 
    wait( self.shineShaxGunCheck );
    if( !isdefined(self.whitescreen) )
        return;
    if( self.shineShaxGunCheck > 0 )
    self.whitescreen FadeOverTime( 0.1 ); 
    self.whitescreen.alpha = 0; 
    wait( 0.1 );
    if( isdefined(self.whitescreen) )           
    { 
        self.whitescreen destroy();
        self.whitescreen = undefined;
    }
}

shaxstart()
{
    SetTimeScale( 20, getTime() + 1);
    self.prevelocity = self getVelocity();
    setDvar ("cg_drawGun", 0);
    self thread shaxmodel();
    self thread shaxammo();
    self disableWeapons();
    wait .005;
    self enableWeapons();
    self thread shaxtiming();
}

shaxmodel()
{
    shaxMODEL = spawn( "script_model", self.origin );
    self PlayerLinkToDelta(shaxMODEL);
    self waittill ("finishedshax");
    waittillframeend;
    self unlink();
    shaxMODEL Destroy();
    shaxMODEL Delete(); 
    wait .005;
    self SetVelocity(((self.prevelocity[0] / 2), (self.prevelocity[1] / 2), (self.prevelocity[2] / 4)));
}

shaxammo()
{
    self endon ("finishedshax");
    self.shaxwep = self getCurrentweapon();
    ammoW1 = self getWeaponAmmoClip( self.shaxwep );
    ammoW2 = self getWeaponAmmostock( self.shaxwep );
    self setweaponammoclip( self.shaxwep, 0 );
    self setweaponammostock( self.shaxwep, ammoW2 + ammoW1);
    wait .005;
}


shaxtiming(shaxWait)
{
    if(isSubStr(self.shaxwep, "skorpion"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.98;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.524;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "mac11"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.95;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.49;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "uzi"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.946;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.464;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "pm63"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.822;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.42;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "mpl"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.918;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.435;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "spectre"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.94;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.51;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "kiparis"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.908;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.5;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "mp5k"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.15;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.54;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "ak74u"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.918;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.5;
        }
        self thread shaxenddvars();
    }
    // ars
    else if(isSubStr(self.shaxwep, "m16"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.91;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.47;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "enfield"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.96;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.5;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "m14"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.27;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.61;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "famas"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.19;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.555;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "galil"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.32;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.595;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "aug"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.18;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.542;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "fnfal"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.28;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.5425;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "ak47"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.13;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.5425;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "commando"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.5;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "g11"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.43;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.555;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "hk21"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.7;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.865;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "rpk"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.953;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 1;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "m60"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 3.87;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 1.935;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "stoner63"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.362;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.7675;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "dragunov"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.3105;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.65525;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "wa2000"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.3105;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.7055;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "l96a1"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.3105;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.67255;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "psg1"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 1.3105;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.69725;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "asp"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.46;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.23;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "m1911"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.6;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.3;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "makarov"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.6;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.3;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "python"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 2.7;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 1.35;
        }
        self thread shaxenddvars();
    }
    else if(isSubStr(self.shaxwep, "cz75"))   
    {
        if( self.pers["shaxSoH"] == false )
        {
            self.shaxWait = 0.52;
        }
        else if( self.pers["shaxSoH"] == true )
        {  
            self.shaxWait = 0.26;
        }
        self thread shaxenddvars();
    }
    else
    {
        self thread shaxenddvars();
    }

}

shaxenddvars()
{
    wait (self.shaxWait - 0.05);
    SetTimeScale( 1, getTime() + 1 );
    waittillframeend;
    setDvar ("cg_drawGun", 1);
    self notify ("finishedshax");
}

CycleSelfDamage()
{
    if(self.pers["SelfDamage"] == 5)
    {
        self.pers["SelfDamage"] = 15;
    }
	else if(self.pers["SelfDamage"] == 15)
	{
        self.pers["SelfDamage"] = 30;
	}
    else if(self.pers["SelfDamage"] == 30)
	{
        self.pers["SelfDamage"] = 50;
	}
    else if(self.pers["SelfDamage"] == 50)
	{
        self.pers["SelfDamage"] = 75;
	}
    else if(self.pers["SelfDamage"] == 75)
	{
        self.pers["SelfDamage"] = 5;
	}
}

killbot_weapon()
{
    if(self.pers["killBotWeap"] == "not saved")
        self.pers["killBotWeap"] = self getCurrentWeapon();
    else if(self.pers["killBotWeap"] != "not saved")
        self.pers["killBotWeap"] = "not saved";
}

cycleGiveSniper()
{
    if(self.pers["GiveSniper"] == "l96a1_mp")
    {
        self.pers["GiveSniper"] = "wa2000_mp";
    }
    else if(self.pers["GiveSniper"] == "wa2000_mp")
    {
        self.pers["GiveSniper"] = "psg1_mp";
    }
    else if(self.pers["GiveSniper"] == "psg1_mp")
    {
        self.pers["GiveSniper"] = "dragunov_mp";
    }
    else if(self.pers["GiveSniper"] == "dragunov_mp")
    {
        self.pers["GiveSniper"] = "l96a1_mp";
    }
}

CycleStreakCanswap()
{
    if(self.pers["streakCanswap"] == "radio")
    {
        self.pers["streakCanswap"] = "remote";
    }
    else if(self.pers["streakCanswap"] == "remote")
    {
        self.pers["streakCanswap"] = "c4";
    }
    else if(self.pers["streakCanswap"] == "c4")
    {
        self.pers["streakCanswap"] = "camera";
    }
    else if(self.pers["streakCanswap"] == "camera")
    {
        self.pers["streakCanswap"] = "radio";
    }
}

CycleCPStreak()
{
    if(self.pers["CPType"] == "default")
    {
        self.pers["CPType"] = "give streak";
    }
    else if(self.pers["CPType"] == "give streak")
    {
        self.pers["CPType"] = "change class";
    }
    else if(self.pers["CPType"] == "change class")
    {
        self.pers["CPType"] = "default";
    }
}

CycleCPSpeed()
{
    if(self.pers["CPSpeed"] == 1)
		self.pers["CPSpeed"] = 6;
	else
	{
		self.pers["CPSpeed"] = self.pers["CPSpeed"] - 1;
	}
}

SetCPStreak(streak)
{
    self.pers["CPStreak"] = streak;
}



Ammobindtype()
{
    if(self.pers["ABType"] == "refill")
    {
        self.pers["ABType"] = "empty mag";
    }
    else if(self.pers["ABType"] == "empty mag")
    {
        self.pers["ABType"] = "one bullet left";
    }
    else if(self.pers["ABType"] == "one bullet left")
    {
        self.pers["ABType"] = "take one bullet";
    }
    else if(self.pers["ABType"] == "take one bullet")
    {
        self.pers["ABType"] = "half";
    }
    else if(self.pers["ABType"] == "half")
    {
        self.pers["ABType"] = "unlimited";
    }
    else if(self.pers["ABType"] == "unlimited")
    {
        self.pers["ABType"] = "refill";
    }
}


emptyammo()
{
  curWeap = self getcurrentweapon();
  ammoW = self getWeaponAmmoStock(curWeap);
  ammoCW = self getWeaponAmmoClip(curWeap);
  self setweaponammostock( curWeap, ammoW );
  self setweaponammoclip( curWeap, 0 ); 
}

halfammo()
{
  curWeap = self getcurrentweapon();
  ammoW = self getWeaponAmmoStock(curWeap);
  ammoCW = self getWeaponAmmoClip(curWeap);
  halfClip = int(ammoCW / 2);
  self setWeaponAmmoClip(curWeap, halfClip);
}


l96cfggun()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("l96a1_mp");
    self switchtoweapon("l96a1_mp");
}

wa2kcfggun()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("wa2000_mp");
    self switchtoweapon("wa2000_mp");
}

psg1cfggun()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("psg1_mp");
    self switchtoweapon("psg1_mp");
}

dragcfggun()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("dragunov_mp");
    self switchtoweapon("dragunov_mp");
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
    self.pers["FADSBool"] = false;
    self.pers["FWSBool"] = false;
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
    self.pers["FADSBool"] = true;
    self.pers["FWSBool"] = true;
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

fastAds()
{
    if(self.pers["FADSBool"]==false)
    {
        self.pers["FADSBool"] = !self.pers["FADSBool"];
        self setPerk("specialty_fastads");
    }
    else if( self.pers["FADSBool"] == true )
    {
        self.pers["FADSBool"] = !self.pers["FADSBool"];
        self unsetPerk("specialty_fastads");
    }
}

fastweaponswitch()
{
    if(self.pers["FWSBool"]==false)
    {
        self.pers["FWSBool"] = !self.pers["FWSBool"];
        self setPerk("specialty_fastads");
    }
    else if( self.pers["FWSBool"] == true )
    {
        self.pers["FWSBool"] = !self.pers["FWSBool"];
        self unsetPerk("specialty_fastads");
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
    self iprintln(killstreak + " given");
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

repongive()
{
    if( self.pers["repongive"] == false )
    {
        self.givegunops = 1;
        self.pers["repongive"] = !self.pers["repongive"];
    }
    else if( self.pers["repongive"] == true )
    {  
        self.givegunops = 0;
        self.pers["repongive"] = !self.pers["repongive"];
    }
}



GivePlayerWeapon(weapon)
{
    if(self.givegunops == 0)
    {
    currentWeapon = self getcurrentweapon();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    }

    else if(self.givegunops == 1)
    {
    currentWeapon = self getcurrentweapon();
    self takeweapon(currentWeapon);
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    }

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

doAltTac()
{
    if(self.pers["AltTac"] == false)
    {
        self.pers["AltTac"] = !self.pers["AltTac"];
    }
    else if(self.pers["AltTac"] == true)
    {
        self.pers["AltTac"] = !self.pers["AltTac"];
        self notify( "Stop_AltTac" );
    }
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

CycleRmala()
{
    self endon ("disconnect");
    self endon ("game_ended");
    if(self.pers["malaEquip"] == "claymore_mp")
    {
        self.pers["malaEquip"] = "tactical_insertion_mp";
    }
    else if(self.pers["malaEquip"] == "tactical_insertion_mp")
    {
        self.pers["malaEquip"] = "camera_spike_mp";
    }
    else if(self.pers["malaEquip"] == "camera_spike_mp")
    {
        self.pers["malaEquip"] = "scrambler_mp";
    }
    else if(self.pers["malaEquip"] == "scrambler_mp")
    {
        self.pers["malaEquip"] = "acoustic_sensor_mp";
    }
    else if(self.pers["malaEquip"] == "acoustic_sensor_mp")
    {
        self.pers["malaEquip"] = "satchel_charge_mp";
    }
    else if(self.pers["malaEquip"] == "satchel_charge_mp")
    {
        self.pers["malaEquip"] = "claymore_mp";
    }
    wait 0.005;
}

SaveMalaWeapon()
{
    self.pers["malaWeap"] = self getCurrentWeapon();
}

doMalaMW2()
{
    if(self.pers["doingMala"] == false)
    {
        self takeWeapon(self.pw);  
        self takeWeapon(self.sw);  
        self giveWeapon(self.CurRmalaWeapon);  
        self switchToWeapon(self.CurRmalaWeapon);  
        self.curMalaWeap=self.sw;
        self thread malaMW2();
        self.pers["doingMala"] = !self.pers["doingMala"];
    }
    else if(self.pers["doingMala"] == true)
    {
        self notify("stop_mala"); 
        self.pers["doingMala"] = !self.pers["doingMala"];
    }
}

malaWait()
{
    if(self.pers["malaTime"] == 0.1)
    {
        self.pers["malaTime"] = 0.2;
    }
    else if(self.pers["malaTime"] == 0.2)
    {
        self.pers["malaTime"] = 0.5;
    }
    else if(self.pers["malaTime"] == 0.5)
    {
        self.pers["malaTime"] = 1;
    }
    else if(self.pers["malaTime"] == 1)
    {
        self.pers["malaTime"] = 0.1;
    }
}

malaMW2()
{
    self endon("disconnect");  
    self endon("death");  
    self endon("stop_mala");  
    for(;;)
    {
        if(self changeSeatButtonPressed() && self getCurrentWeapon()== self.pers["malaEquip"] && self.menuisOpen == false)
        {
            self takeweapon(self.pers["malaEquip"]);
            wait 0.1;
            self giveWeapon(self.pers["malaEquip"]);  
            self switchToWeapon(self.pers["malaEquip"]);  
            if(self.pers["malaWeap"] == self.sw)
            self.pers["malaWeap"] = self.pw;   
            else  if(self.pers["malaWeap"] == self.pw)
            self.pers["malaWeap"] = self.sw;  
            wait 0.25;  
        } 
        else  if(self attackbuttonpressed()&& self getCurrentWeapon()== self.pers["malaEquip"] && self.menuisOpen == false)
        {
            forward=anglestoforward(self getplayerangles());
            start=self geteye();  
            end=vectorScale(forward,9999);
            MagicBullet(self.pers["malaWeap"],start,bullettrace(start,start + end,false,undefined)["position"],self);
            self takeWeapon(self.pers["malaEquip"]);
            wait 0.01;
            self setSpawnWeapon(self.pers["malaWeap"]);
            wait self.pers["malaTime"];
            self giveWeapon(self.pers["malaEquip"]);
            self setSpawnWeapon(self.pers["malaEquip"]);
        }
    wait 0.05;
    }
}

CurrentWeaponAH()
{
    if(self.pers["AfterHitWeap"] == "not saved")
    {
        self.CurrentAH = self getCurrentWeapon();
        self.pers["AfterHitWeap"] = self.CurrentAH;
        self thread doAfterHit(self.pers["AfterHitWeap"]);
    }
    else if (self.pers["AfterHitWeap"] != "not saved")
    {
        self.pers["AfterHitWeap"] = "not saved";
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
        self.pers["AfterHitWeap"] = "not saved";
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
        {
            self setspawnweapon( weapon );
            self thread instaAction();
        }
        if(self.pers["alwayscan"])
        {
            self canswapmain(weapon);
            self thread instaAction();
        }
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

printVelocity()
{
    //createText(font, fontscale, align, relative, x, y, sort, color, alpha, text, glowAlpha, glowColor)
    self.velotext Destroy();
    self.velotext = createFontString("DEFAULT", 1.2);
    self.velotext setPoint("RIGHT", "CENTER", 362, -144);
    self.velotext setText("velocity: " + self.pers["currentvelo"] + " ");
}

startVelo()
{
    self setVelocity(self.pers["currentvelo"]);
    //self thread printVelocity();
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
        self.pers["VeloEdit"] = 0.1;
    }
    else if(self.pers["VeloEdit"] == 0.1)
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
    self thread printVelocity();
    self thread updateVelocityDvars();
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

updateVelocityDvars()
{
    setDvar("velx", self.pers["currentvelo"][0]);
    setDvar("vely", self.pers["currentvelo"][1]);
    setDvar("velz", self.pers["currentvelo"][2]);
}

resetVelo()
{
    self.pers["currentvelo"] = (0,0,0);
    self thread printVelocity();
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
    self.MenuText[self.scroll] setText("prestige " + prest);
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



ResetRoundTog()
{
    if( self.pers["ResetRoundBool"] == false )
    {
        self.pers["resetroundpers"] = true;
        self ResetRounds();
        self.pers["ResetRoundBool"] = !self.pers["ResetRoundBool"];
    }
    else if( self.pers["ResetRoundBool"] == true )
    {  
        self.pers["resetroundpers"] = false;
        self.pers["ResetRoundBool"] = !self.pers["ResetRoundBool"];
        return;
    }
}



ResetRounds()
{
    if(getDvar("g_gametype") != "sd")
		return;
    
    if( self.pers["resetroundpers"] == true)
    {
    scoreaxis = 0;
    scoreallies = 0;
    total = scoreaxis + scoreallies;
    wait 0.1;
    game["roundsWon"]["axis"] = scoreaxis;
    game["roundsWon"]["allies"] = scoreallies;
    game["roundsWon"]["roundsPlayed"] = total;
    game["teamScores"]["allies"] = scoreaxis;
	game["teamScores"]["axis"] = scoreallies;
    maps\mp\gametypes\_globallogic_score::resetTeamScores();
    wait 0.1;	
	maps\mp\gametypes\_globallogic_score::updateTeamScores("axis");
	maps\mp\gametypes\_globallogic_score::updateTeamScores("allies");
    }
    else if( self.pers["resetroundpers"] == false)
    {
        return;
    }
}

OneAxisRound()
{
    if(getDvar("g_gametype") != "sd")
		return;

    scoreaxis = 1;
    scoreallies = 0;
    total = 1;
    wait 0.1;
    game["roundsWon"]["axis"] = scoreaxis;
    game["roundsWon"]["roundsPlayed"] = total;
	game["teamScores"]["allies"] = scoreallies;
    wait 0.1;	
	maps\mp\gametypes\_globallogic_score::updateTeamScores("axis");
	maps\mp\gametypes\_globallogic_score::updateTeamScores("allies");
}

OneAlliesRound()
{
    if(getDvar("g_gametype") != "sd")
		return;

    scoreaxis = 0;
    scoreallies = 1;
    total = 1;
    wait 0.1;
    game["roundsWon"]["allies"] = scoreallies;
    game["roundsWon"]["roundsPlayed"] = total;
    game["teamScores"]["axis"] = scoreaxis;
    wait 0.1;	
	maps\mp\gametypes\_globallogic_score::updateTeamScores("axis");
	maps\mp\gametypes\_globallogic_score::updateTeamScores("allies");
}

makeLastRound()
{
    if(getDvar("g_gametype") != "sd")
		return;

    scoreaxis = 3;
    scoreallies = 3;
    total = scoreaxis + scoreallies;
    wait 0.1;
    game["roundsWon"]["axis"] = scoreaxis;
    game["roundsWon"]["allies"] = scoreallies;
    game["roundsWon"]["roundsPlayed"] = total;
    game["teamScores"]["allies"] = scoreaxis;
	game["teamScores"]["axis"] = scoreallies;
    wait 0.1;	
	maps\mp\gametypes\_globallogic_score::updateTeamScores("axis");
	maps\mp\gametypes\_globallogic_score::updateTeamScores("allies");
}

// TESTING SHIT
FakeTimer()
{
    self.kc_timer2 = createFontString( "extrabig", 3.0 );
    self.kc_timer2 setPoint( "TOP", undefined, 0, 45 );
    self.kc_timer2.archived = false;
    self.kc_timer2.foreground = true;
	self.kc_timer2.alpha = 0.2;
    self thread close_menu();
    wait 0.7;
    self.kc_timer2 setTenthsTimer(9.0);
    wait 9.1;
    self.kc_timer2 destroy();
}

softlands()
{
    if(self.pers["softLands"] == false )
    {
        setDvar( "bg_falldamageminheight", 1);
        self thread DoSoftland();
        self.pers["softLands"] = !self.pers["softLands"];
    }
    else if( self.pers["softLands"] == true ) 
    {
        setDvar("bg_falldamageminheight", 0);
        self notify("endsoftland");
        self.pers["softLands"] = !self.pers["softLands"];
    }
}

DoSoftland()
{
    self endon("endsoftland");
    softland = spawn( "script_origin", self.origin );
    for(;;) 
    {
        groundPosition = BulletTrace( self.origin, self.origin - (0, 0, 5000), false, self )[ "position" ];
        softland.origin = groundPosition;

        origin = self.origin[2]+5;   // Range to 
        gpos = groundPosition[2]+20; // active the link and unlinck

        if( self getVelocity()[2] <= -165 && ( origin <= gpos) )
        {
            self.CurVelo = self getVelocity();
            softland setVelocity( (self.curVelo[0], self.curVelo[1], 0) );
            self PlayerLinkToDelta( softland );
            wait 0.005;
            self unlink();
        }
       wait 0.01;
    }
}

novagastime(duration)
{
    if(self.pers["NovagasDuration"] == float(7))
    {
        self.pers["NovagasDuration"] = float(1);
        self.pers["NovagasDurationPrint"] = "1";
    }
    else if(self.pers["NovagasDuration"] == float(1))
    {
        self.pers["NovagasDuration"] = float(2);
        self.pers["NovagasDurationPrint"] = "2";
    }
    else if(self.pers["NovagasDuration"] == float(2))
    {
        self.pers["NovagasDuration"] = float(3);
        self.pers["NovagasDurationPrint"] = "3";
    }
    else if(self.pers["NovagasDuration"] == float(3))
    {
        self.pers["NovagasDuration"] = float(4);
        self.pers["NovagasDurationPrint"] = "4";
    }
    else if(self.pers["NovagasDuration"] == float(4))
    {
        self.pers["NovagasDuration"] = float(5);
        self.pers["NovagasDurationPrint"] = "5";
    }
    else if(self.pers["NovagasDuration"] == float(5))
    {
        self.pers["NovagasDuration"] = float(6);
        self.pers["NovagasDurationPrint"] = "6";
    }
    else if(self.pers["NovagasDuration"] == float(6))
    {
        self.pers["NovagasDuration"] = float(7);
        self.pers["NovagasDurationPrint"] = "7";
    }
    

}



unlimitedlivestog()
{
    if (self.pers["unlimitedlives"] == false)
    {
        self.pers["unlimitedlives"] = true;
        self thread unlimitedlives();
    } 
    else if (self.pers["unlimitedlives"] == true)
    {
        self.pers["unlimitedlives"] = false;
        self.pers["lives"] = 1;
        self notify("endunlimitedlives");
    }
}

unlimitedlives() 
{
    self endon("disconnect");
    self endon("endunlimitedlives");
    if ( self.pers["unlimitedlives"] == true ) 
    {
        self.pers["lives"] = 999;
    }
}

changeLethal(lethal)
{
    lethal = self.pers["GrenadeType"];
    primary_weapons = self getWeaponsListPrimaries();
    offhand_weapons = array_exclude(self getWeaponsList(), primary_weapons);
    offhand_weapons = array_remove(offhand_weapons, "knife_mp");
    for (i = 0; i < offhand_weapons.size; i++)
    {
        weapon = offhand_weapons[i];
        switch (weapon)
        {
            case "frag_grenade_mp":
            case "sticky_grenade_mp":
            case "hatchet_mp":
                self takeWeapon(weapon);
                self giveWeapon(lethal);
                self giveStartAmmo(lethal);
                break;
            default:
                break;
        }
    }
}

lethalType()
{
    if(self.pers["GrenadeType"] == "frag_grenade_mp")
    {
        self.pers["GrenadeType"] = "sticky_grenade_mp";
        self.pers["GrenadeTypePrint"] = "semtex";
        self thread changeLethal();
    }
    else if(self.pers["GrenadeType"] == "sticky_grenade_mp")
    {
        self.pers["GrenadeType"] = "hatchet_mp";
        self.pers["GrenadeTypePrint"] = "tomahawk";
        self thread changeLethal();
    }
    else if(self.pers["GrenadeType"] == "hatchet_mp")
    {
        self.pers["GrenadeType"] = "frag_grenade_mp";
        self.pers["GrenadeTypePrint"] = "frag";
        self thread changeLethal();
    }
}

changeTactical(tactical)
{
    tactical = self.pers["SpecialGrenadeType"];
    primary_weapons = self getWeaponsListPrimaries();
    offhand_weapons = array_exclude(self getWeaponsList(), primary_weapons);
    for (i = 0; i < offhand_weapons.size; i++)
    {
        weapon = offhand_weapons[i];
        switch (weapon)
        {
            case "willy_pete_mp":
            case "tabun_gas_mp":
            case "flash_grenade_mp":
            case "concussion_grenade_mp":
            case "nightingale_mp":
                self takeWeapon(weapon);
                self giveWeapon(tactical);
                self giveStartAmmo(tactical);
                break;
            default:
                break;
        }
    }
}

specialGrenadeType()
{
    if(self.pers["SpecialGrenadeType"] == "willy_pete_mp")
    {
        self.pers["SpecialGrenadeType"] = "tabun_gas_mp";
        self.pers["SpecialGrenadeTypePrint"] = "nova gas";
        self thread changeTactical();
    }
    else if(self.pers["SpecialGrenadeType"] == "tabun_gas_mp")
    {
        self.pers["SpecialGrenadeType"] = "flash_grenade_mp";
        self.pers["SpecialGrenadeTypePrint"] = "flashbang";
        self thread changeTactical();
    }
    else if(self.pers["SpecialGrenadeType"] == "flash_grenade_mp")
    {
        self.pers["SpecialGrenadeType"] = "concussion_grenade_mp";
        self.pers["SpecialGrenadeTypePrint"] = "concussion";
        self thread changeTactical();
    }
    else if(self.pers["SpecialGrenadeType"] == "concussion_grenade_mp")
    {
        self.pers["SpecialGrenadeType"] = "nightingale_mp";
        self.pers["SpecialGrenadeTypePrint"] = "decoy";
        self thread changeTactical();
    }
    else if(self.pers["SpecialGrenadeType"] == "nightingale_mp")
    {
        self.pers["SpecialGrenadeType"] = "willy_pete_mp";
        self.pers["SpecialGrenadeTypePrint"] = "willy pete";
        self thread changeTactical();
    }
}

lockMenu()
{
    self.menuLocked = true;
    self thread close_menu();
    self iPrintln("menu locked ^?prone + [{+speed_throw}] + melee ^7to unlock menu");
}

toggleCoords()
{
    self.coordsVisible = !self.coordsVisible;
    if(self.coordsVisible)
    {
        self.hud.currentLocation.alpha = 1;
        if(isDefined(self.hud.currentLocation))
        {
            origin = self.origin;
            self.hud.currentLocation SetSafeText("(" + origin[0] + ", " + origin[1] + ", " + origin[2] + ")");
        }
        if(self.menuOpen)
        {
            self notify("stop_coords_update");
            self thread updateLocation();
        }
    } 
    else 
    {
        self.hud.currentLocation.alpha = 0;
        self notify("stop_coords_update");
    }
}

printSavedVelocities()
{
    if(!isDefined(self.pers["velocityCount"]) || self.pers["velocityCount"] == 0){
        self iPrintLn("no saved velocity");
        return;
    }

    self iPrintLn("saved velocities:");
    for(i = 1; i <= self.pers["velocityCount"]; i++){
        if(isDefined(self.pers["veloSaves" + i])){
            velocity = self.pers["veloSaves" + i];
            self iPrintLn("^7point " + i + ": ^?(" + velocity[0] + ", " + velocity[1] + ", " + velocity[2] + ")");
        }
    }
}

changeHudColor()
{
    // Define colors array
    colors = [];
    colors[0] = (0.2431372549019608, 0.196078431372549, 0.5607843137254902); // Purple
    colors[1] = (1, 0, 0); // Red
    colors[2] = (0, 1, 0); // Green
    colors[3] = (0, 0, 1); // Blue
    colors[4] = (0.4117647058823529, 0.4705882352941176, 0.7098039215686275); // Alt Bloo (damn he left FaZe)
    colors[5] = (0.8705882352941176, 0.6156862745098039, 0.1725490196078431); // Orange
    colors[6] = (0.1725490196078431, 0.8705882352941176, 0.8588235294117647); // Cyan
    colors[7] = (0.7098039215686275, 0.4117647058823529, 0.6274509803921569); // Boof

    currentColor = self.pers["hudColor"];
    nextIndex = 0;
    for(i = 0; i < colors.size; i++)
    {
        if(currentColor == colors[i])
        {
            nextIndex = (i + 1) % colors.size;
            break;
        }
    }
    self.pers["hudColor"] = colors[nextIndex];
    if(self.menuOpen)
    {
        self.hud.vertright.color = self.pers["hudColor"];
        self.hud.vertleft.color = self.pers["hudColor"];
        self.hud.TopBanner.color = self.pers["hudColor"];
        self.hud.horztop.color = self.pers["hudColor"];
        self.hud.horzmid.color = self.pers["hudColor"];
        self.hud.horzbott.color = self.pers["hudColor"];
        self.hud.title.color = self.pers["hudColor"];
        self.hud.currentLocation.color = self.pers["hudColor"];
    }
}