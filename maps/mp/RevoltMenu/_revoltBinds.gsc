#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\gametypes\_clientids;
#include maps\mp\RevoltMenu\_revoltFuncs;
#include maps\mp\RevoltMenu\_revoltBots;
#include maps\mp\RevoltMenu\_revoltWeapons;
#include maps\mp\gametypes\_globallogic_player;
#include maps\mp\RevoltMenu\_revoltCFG;

bindsInit()
{
    self definepers("refillammoBind",0);
    self definepers("instashoot",false);
    self definepers("instashoot_type","off");
    self definepers("alwayscan",false);
    self definepers("alwayscan_type","off");
    self definepers("boltBind",0);
    self definepers("boltCount",0);
    self definepers("boltSpeed",1);
    self definePers("velocityBind",0);
    self definepers("velocityCount",0);
    self definepers("movementBind",0);  
    self definepers("CurMovePoint",0);
    self definepers("classBind",0); 
    self definepers("nacModBind",0);
    self definepers("instaBind",0);
    self definepers("canswapBind",0);
    self definepers("canzoomBind",0);
    self definepers("vishBind",0); 
    self definepers("repeaterBind",0);
    self definepers("RepeaterType","default");
    self definepers("cowboyBind", 0);
    self definepers("cowboyType","cowboy");
    self definepers("cowboyBind", 0);
    self definepers("cowboyType","cowboy");
    self definepers("smoothAnimBind", 0); 
    self definepers("illReloadBind", 0);
    self definepers("gflipBind", 0); 
    self definepers("scavBind", 0);
    self definepers("rapidFireBind", 0); 
    self definepers("laststandBind", 0); 
    self definepers("cGunBind", 0); 
    self definepers("dropWeapBind", 0); 
    self definepers("proneBind", 0); 
    self definepers("altSwapBind", 0);
    self definepers("elevatorBind", 0); 
    self definepers("wallBreachBind", 0); 
    self definepers("blackScreenBind", 0); 
    self definepers("whiteScreenBind", 0); 
    self definepers("discoCamoBind", 0);
    self definepers("shaxBind", 0); 
    self definepers("invisWeapBind", 0); 
    self definepers("damageBind", 0); 
    self definepers("semtexBind", 0); 
    self definepers("crossbowBind", 0);
    self thread bindwatch(); 
    self thread swapcheck();
}

definepers(var,value)
{
    if(!isDefined(self.pers[var]))
        self.pers[var] = value;
}

bindwatch()
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        command = self waittill_any_return("dpad1", "dpad2", "dpad3", "dpad4", "knife", "usereload", "jump", "shoot", "ads", "lethal", "tactical");
        if(!self.menuOpen && isSubStr(command,self.pers["refillammoBind"]))
            self thread refillammoBind();
        if(!self.menuopen && isSubStr(command,self.pers["boltBind"]))
            self thread doBolt();
        if(!self.menuopen && isSubStr(command,self.pers["velocityBind"]))
            self thread doVelocity();
        if(!self.menuopen && isSubStr(command,self.pers["movementBind"]))
            self thread doMovement();
        if(!self.menuopen && isSubStr(command,self.pers["classBind"]))
            self thread changeclasscanbind();
        if(!self.menuopen && isSubStr(command,self.pers["nacModBind"]))
            self thread doNac();
        if(!self.menuopen && isSubStr(command,self.pers["snacModBind"]))
            self thread doSnac();
        if(!self.menuopen && isSubStr(command,self.pers["instaBind"]))
            self thread doInsta();
        if(!self.menuopen && isSubStr(command,self.pers["canswapBind"]))
            self thread doCanswap();
        if(!self.menuopen && isSubStr(command,self.pers["canzoomBind"]))
            self thread doCanzoom();
        if(!self.menuopen && isSubStr(command,self.pers["vishBind"]))
            self thread doVish();
        if(!self.menuopen && isSubStr(command,self.pers["repeaterBind"]))
            self thread doRepeater();
        if(!self.menuopen && isSubStr(command,self.pers["cowboyBind"]))
            self thread doCowboy();
        if(!self.menuopen && isSubStr(command,self.pers["smoothAnimBind"]))
            self thread doSmoothAnim();
        if(!self.menuopen && isSubStr(command,self.pers["illReloadBind"]))
            self thread doIllReload();
        if(!self.menuopen && isSubStr(command,self.pers["rapidFireBind"]))
            self thread RapidFire();
        if(!self.menuopen && isSubStr(command,self.pers["scavBind"]))
            self thread doScav();
        if(!self.menuopen && isSubStr(command,self.pers["laststandBind"]))
            self thread dolastStand();
        if(!self.menuopen && isSubStr(command,self.pers["gflipBind"]))
            self thread doGflip();
        if(!self.menuopen && isSubStr(command,self.pers["cGunBind"]))
            self thread doCenterGun();
        if(!self.menuopen && isSubStr(command,self.pers["dropWeapBind"]))
            self thread doDropWeap(); 
        if(!self.menuopen && isSubStr(command,self.pers["proneBind"]))
            self thread doProne();
        if(!self.menuopen && isSubStr(command,self.pers["altSwapBind"]))
            self thread doAltSwap();
        if(!self.menuopen && isSubStr(command,self.pers["elevatorBind"]))
            self thread doElevator();
        if(!self.menuopen && isSubStr(command,self.pers["wallBreachBind"]))
            self thread doWallBreach();
        if(!self.menuopen && isSubStr(command,self.pers["blackScreenBind"]))
            self thread doBlackScreen();
        if(!self.menuopen && isSubStr(command,self.pers["whiteScreenBind"]))
            self thread doWhiteScreen(); 
        if(!self.menuopen && isSubStr(command,self.pers["discoCamoBind"]))
            self thread doCamoLoop();
        if(!self.menuopen && isSubStr(command,self.pers["shaxBind"]))
            self thread doShaxThink();
        if(!self.menuopen && isSubStr(command,self.pers["invisWeapBind"]))
            self thread doInvisWeap();
        if(!self.menuopen && isSubStr(command,self.pers["damageBind"]))
            self thread doDamage();
        if(!self.menuopen && isSubStr(command,self.pers["semtexBind"]))
            self thread doSemtex(); 
        if(!self.menuopen && isSubStr(command,self.pers["crossbowBind"]))
            self thread doCrossbow(); 
            
        wait 0.05;
    }
}

bindCycle(var, bool)
{
    if(self.pers[var] == 11)
        self.pers[var] = 0;
    else
        self.pers[var]++;

    if(self.pers[var] == 0)
    {
        self.pers[bool] = "<>";
    }
    else
    {
        if(self.pers[var] == 1 || self.pers[var] == 2 || self.pers[var] == 3 || self.pers[var] == 4)
        {
            self.pers[bool] = "[{+actionslot " + self.pers[var] + "}] ";
        }
        else if(self.pers[var] == 5)
        {
            self.pers[bool] = "[{+melee}]";
        }
        else if(self.pers[var] == 6)
        {
            self.pers[bool] = "[{+usereload}]";
        }
        else if(self.pers[var] == 7)
        {
            self.pers[bool] = "[{+gostand}]";
        }
        else if(self.pers[var] == 8)
        {
            self.pers[bool] = "[{+attack}]";
        }
        else if(self.pers[var] == 9)
        {
            self.pers[bool] = "[{+speed_throw}]";
        }
        else if(self.pers[var] == 10)
        {
            self.pers[bool] = "[{+frag}]";
        }
        else if(self.pers[var] == 11)
        {
            self.pers[bool] = "[{+smoke}]";
        }
    }
}

refillammoBind()
{
    primary = self getcurrentweapon();
    lethal = self getcurrentoffhand();
    self givemaxammo( primary );
    self givemaxammo( lethal );
}

doBolt()
{
    if (self.pers["boltCount"] == 0)
    {
        self IPrintLnBold("no points saved");
        return;
    }
    boltModel = spawn("script_model", self.origin); 
	boltModel.origin = self.origin; 
    self linkto( boltModel );
    for (i=1 ; i < self.pers["boltCount"] + 1 ; i++)
    {
        boltModel MoveTo( self.pers["boltSpot"+i],  self.pers["boltSpeed"] / self.pers["boltCount"], 0, 0 );
        wait ( self.pers["boltSpeed"] / self.pers["boltCount"] );
    }
    self Unlink();
    boltModel delete();
}

doVelocity()
{
    if (self.pers["velocityCount"] == 0)
    {
        self thread startVelo();
    }
    else
    {
        if (!isDefined(self.pers["currentVeloIndex"]))
            self.pers["currentVeloIndex"] = 1;

        currentIndex = self.pers["currentVeloIndex"];
        self setVelocity(self.pers["veloSaves" + currentIndex]);

        self.pers["currentVeloIndex"]++;
        if (self.pers["currentVeloIndex"] > self.pers["velocityCount"])
            self.pers["currentVeloIndex"] = 1;
    }
}

doMovement()
{
    if (!isDefined(self.pers["recordedOrigins"]) || self.pers["CurMovePoint"] == 0)
    {
        self iPrintLnBold("^1no points saved!");
        return;
    }
    moveModel = spawn("script_model", self.origin);
    moveModel.origin = self.origin;
    self linkto(moveModel);
    for( i = 0; i<self.pers["CurMovePoint"]; i++)
    {
        moveModel MoveTo(self.pers["recordedOrigins"][i], 0.125, 0, 0);
        wait 0.125;
    }
    self unlink();
    moveModel delete();
}

changeclasscanbind()
{
    self endon("disconnect");
    self thread doChangeClass();
    waittillframeend;
    if(self.pers["CCType"] == "canswap")
    {
        self.CurWeap = self getCurrentweapon();
        ammoW     = self getWeaponAmmoStock( self.CurWeap );
        ammoCW    = self getWeaponAmmoClip( self.CurWeap );
        self TakeWeapon(self.CurWeap);
        self GiveWeapon( self.CurWeap);
        self setweaponammostock( self.CurWeap, ammoW );
        self setweaponammoclip( self.CurWeap, ammoCW);
    }
    else if(self.pers["CCType"] == "one bullet")
    {
        self.CurWeap = self getCurrentweapon();
        ammoW     = self getWeaponAmmoStock( self.CurWeap );
        ammoCW    = self getWeaponAmmoClip( self.CurWeap );
        self setweaponammostock( self.CurWeap, ammoW );
        self setweaponammoclip( self.CurWeap, 1 );
    }
    else
        wait 0.01;
}

doChangeClass()
{
    if(self.cClass == 0)
    {
        self.cClass = 1;
        self notify( "menuresponse", "changeclass", "custom1" );
    }
    else if(self.cClass == 1)
    {
        self.cClass = 2;
        self notify( "menuresponse", "changeclass", "custom2" );
    }
    else if(self.cClass == 2)
    {
        self.cClass = 3;
        self notify( "menuresponse", "changeclass", "custom3" );
    }
    else if(self.cClass == 3)
    {
        self.cClass = 4;
        self notify( "menuresponse", "changeclass", "custom4" );
    }
    else if(self.cClass == 4)
    {
        self.cClass = 5;
        self notify( "menuresponse", "changeclass", "custom5" );
    }
    else if(self.cClass == 5)
    {
        self.cClass = 6;
        self notify( "menuresponse", "changeclass", "prestige1" );
    }
    else if(self.cClass == 6)
    {
        self.cClass = 7;
        self notify( "menuresponse", "changeclass", "prestige2" );
    }
    else if(self.cClass == 7)
    {
        self.cClass = 8;
        self notify( "menuresponse", "changeclass", "prestige3" );
    }
    else if(self.cClass == 8)
    {
        self.cClass = 9;
        self notify( "menuresponse", "changeclass", "prestige4" );
    }
    else if(self.cClass == 9)
    {
        self.cClass = 0;
        self notify( "menuresponse", "changeclass", "prestige5" );
    }
}

donac() // shoutout joey
{
    self endon("disconnect");
    camo = self getcamo();
    primary = self getprimary();
    right = 0;
    left = 0;
    clip = 0;
    stock = 0;
    if(self getCurrentWeapon() ==  self.pers["nacweap1"])
    {
        if(isSubStr(self.pers["nacweap1"], "akimbo"))
        {
            right = self getWeaponAmmoClip( self.pers["nacweap1"], "right" );
            left = self getWeaponAmmoClip( self.pers["nacweap1"], "left" );
        }
        else
            clip = self getWeaponAmmoClip(self.pers["nacweap1"]);

        stock = self getWeaponAmmoStock(self.pers["nacweap1"]);
        self takeWeapon(self.pers["nacweap1"]);
        self switchToWeapon(self.pers["nacweap2"]);
        wait 0.1;
        if(self.pers["nacweap1"] == primary)
            self giveWeapon(self.pers["nacweap1"], 0, camo, 0, 0, 0, 0);
        else
            self giveWeapon(self.pers["nacweap1"]);

        if( isSubStr( self.pers["nacweap1"], "akimbo" ) )
        {
            self setWeaponAmmoClip( self.pers["nacweap1"], right, "left" );
            self setWeaponAmmoClip( self.pers["nacweap1"], left, "right" );
        } 
        else 
            self setWeaponAmmoClip(self.pers["nacweap1"], clip);

        self setWeaponAmmoStock(self.pers["nacweap1"],stock);
    }
    else if(self getCurrentWeapon() ==  self.pers["nacweap2"])
    {
        if(isSubStr(self.pers["nacweap2"], "akimbo"))
        {
            right = self getWeaponAmmoClip( self.pers["nacweap2"], "right" );
            left = self getWeaponAmmoClip( self.pers["nacweap2"], "left" );
        }
        else
            clip = self getWeaponAmmoClip(self.pers["nacweap2"]);

        stock = self getWeaponAmmoStock(self.pers["nacweap2"]);
        self takeWeapon(self.pers["nacweap2"]);
        self switchToWeapon(self.pers["nacweap1"]);
        wait 0.1;
        if(self.pers["nacweap2"] == primary)
            self giveWeapon(self.pers["nacweap2"], 0, camo, 0, 0, 0, 0);
        else
            self giveWeapon(self.pers["nacweap2"]);

        if( isSubStr( self.pers["nacweap2"], "akimbo" ) )
        {
            self setWeaponAmmoClip( self.pers["nacweap2"], right, "left" );
            self setWeaponAmmoClip( self.pers["nacweap2"], left, "right" );
        } 
        else 
            self setWeaponAmmoClip(self.pers["nacweap2"], clip);

        self setWeaponAmmoStock(self.pers["nacweap2"],stock);
    }
}

doSnac()
{
    self endon("disconnect");
    if(self getCurrentWeapon() == self.pers["snacweap1"])
    {
        self SetSpawnWeapon( self.pers["snacweap2"] );
        wait .18;
        self SetSpawnWeapon( self.pers["snacweap1"] );
    }
    else if(self getCurrentWeapon() == self.pers["snacweap2"])
    {
        self SetSpawnWeapon( self.pers["snacweap1"] );
        wait .18;
        self SetSpawnWeapon( self.pers["snacweap2"] );
    } 
}

doInsta() 
{
    self endon("disconnect");
    if(self.InstaCycle < self.InstaArrayNumber)
    {
        self giveWeapon(self.InstaswapArray[self.InstaCycle]);
        self setSpawnWeapon(self.InstaswapArray[self.InstaCycle]);
        self.InstaCycle = self.InstaCycle + 1; 
    }
    else if(self.InstaCycle >= self.InstaArrayNumber)
    {
        self.InstaCycle = 0;
        self giveWeapon(self.InstaswapArray[self.InstaCycle]);
        self setSpawnWeapon(self.InstaswapArray[self.InstaCycle]);
        self.InstaCycle = self.InstaCycle + 1;
    }
}

doCanswap()
{
    self endon("disconnect");
    self.CurWeap = self getCurrentweapon();
    ammoW     = self getWeaponAmmoStock( self.CurWeap );
    ammoCW    = self getWeaponAmmoClip( self.CurWeap );
    self TakeWeapon(self.CurWeap);
    self GiveWeapon( self.CurWeap);
    self setweaponammostock( self.CurWeap, ammoW );
    self setweaponammoclip( self.CurWeap, ammoCW);
}

doCanzoom()
{
    self.CurWeap = self getCurrentweapon();
    ammoW     = self getWeaponAmmoStock( self.CurWeap );
    ammoCW    = self getWeaponAmmoClip( self.CurWeap );
    self TakeWeapon(self.CurWeap);
    self GiveWeapon( self.CurWeap);
    self setweaponammostock( self.CurWeap, ammoW );
    self setweaponammoclip( self.CurWeap, ammoCW);
    wait .1;
    self setSpawnWeapon( self.CurWeap);
}

doVish()
{
    if(!isDefined(self.VishStart))
    {
        self.VishStart = true;
        self thread VishTog();
        wait .1;
    }
    else if(isDefined(self.VishStart))
    {
        self.VishStart = undefined;
        self notify("Stop_Vish");
        wait .1;
    }
}

VishTog()
{
    self endon("Stop_Vish");
    weap = self getcurrentweapon();
    while(isDefined(self.VishStart))
    {
        self takeweapon(weap);
        self giveweapon(weap, 0, 0, 0, 0, 0, 0);
        self setspawnweapon(weap);
        wait 0.001;
    }
}

doRepeater()
{
    if(self.pers["RepeaterType"] == "default")
    {
        self thread defaultRepeater();
    }
    else if(self.pers["RepeaterType"] == "real repeater")
    {
        self thread realRepeater();
    }
    else if(self.pers["RepeaterType"] == "damage repeater")
    {
        self thread damageRepeater();
    }
    else if(self.pers["RepeaterType"] == "frag repeater")
    {
        self thread FragRepeater();
    }
}

doCowboy()
{
    x = self getCurrentWeapon();
    stock = self getWeaponAmmoStock(x);
    clip = self getWeaponAmmoClip(x);
    self setperk("specialty_fastreload");
    setDvar("perk_weapReloadMultiplier",0.001);
    self takeWeapon(x);
    self giveWeapon("pythondw_mp");
    self switchToWeapon("pythondw_mp");
    wait 0.1;
    self setWeaponAmmoClip("pythondw_mp",999);
    self setWeaponAmmoStock("pythondw_mp",999);
    cmdexec("weapprev;wait 2;weapnext;wait 3;+usereload;wait 2;+attack;wait 700;-usereload;-attack;");
    self setWeaponAmmoClip("pythondw_mp",999);
    self setWeaponAmmoStock("pythondw_mp",999);
    wait 5;
    self giveWeapon(x);
    self takeWeapon("pythondw_mp");
    self switchToWeapon(x);
    setDvar("perk_weapReloadMultiplier",0.5);
}

defaultRepeater()
{
    current = self getCurrentWeapon();
    self setSpawnWeapon(current);
    wait 0.001;
}

realRepeater()
{
    self.sessionstate = "spectator";
    waittillframeend;
    self.sessionstate = "playing";
}

damageRepeater()
{
    self.canswapWeap = self getCurrentWeapon();
    self.WeapClip    = self getWeaponAmmoClip(self.canswapWeap);
    self.WeapStock     = self getWeaponAmmoStock(self.canswapWeap);
    self thread [[level.callbackPlayerDamage]]( self, self, self.pers["SelfDamage"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
    wait 0.05;
    self takeWeapon(self.canswapWeap);
    self giveweapon(self.canswapWeap);
    self setweaponammostock(self.canswapWeap, self.WeapStock);
    self setweaponammoclip(self.canswapWeap, self.WeapClip);
    wait 0.05;
    self setSpawnWeapon(self.canswapWeap);
    wait 0.001;
}

FragRepeater()
{
    CurrentFragPickup = self.pers["adminFragPickupRad"];
    self setClientDvar( "player_throwbackOuterRadius",3);
    self setClientDvar( "player_throwbackInnerRadius",3);
    wait 1;
    self setClientDvar( "player_throwbackOuterRadius",CurrentFragPickup);
    self setClientDvar( "player_throwbackInnerRadius",CurrentFragPickup);
    wait 0.001;
}

doSmoothAnim()
{
    cmdexec("cg_nopredict 1;wait 4;weapnext;wait 2;weapprev;wait 5;cg_nopredict 0");
}

doIllReload()
{
    self.IllReload = self getCurrentWeapon();
    self.WeapClip    = self getWeaponAmmoClip(self.IllReload);
    self.WeapStock     = self getWeaponAmmoStock(self.IllReload);
    self setweaponammoclip(self.IllReload, 0);
    wait 0.03;
    self setweaponammostock(self.IllReload, self.WeapStock);
    self setweaponammoclip(self.IllReload, self.WeapClip);
    wait 0.05;
    self setSpawnWeapon(self.IllReload);
}

doGflip()
{
    x = self getCurrentweapon();
    stock = self getWeaponAmmoStock(x);
    clip = self getWeaponAmmoClip(x);
    self takeWeapon(x);
    self setStance("prone");
    self giveWeapon("m1911_mp");
    self switchToWeapon("m1911_mp");
    wait 0.01;
    self setStance("prone");
    self takeWeapon("m1911_mp");
    self giveWeapon(x);
    self setweaponammostock(x, 0);
    self setweaponammoclip(x, 0);
    self switchToWeapon(x);
    wait 0.12;
    self setStance("stand");
    self setweaponammostock(x, stock);
    self setweaponammoclip(x, clip);
}

doScav()
{
    self.EmptyWeap = self getCurrentweapon();
    WeapEmpClip    = self getWeaponAmmoClip(self.EmptyWeap);
    WeapEmpStock     = self getWeaponAmmoStock(self.EmptyWeap);
    self.scavenger_icon = NewClientHudElem( self );
    self.scavenger_icon.horzAlign = "center";
    self.scavenger_icon.vertAlign = "middle";
    self.scavenger_icon.x = -36;
    self.scavenger_icon.y = 32;
    width = 64;
    height = 32;
    self.scavenger_icon setShader( "hud_scavenger_pickup", width, height );
    self.scavenger_icon.alpha = 1;
    self.scavenger_icon fadeOverTime( 2.5 );
    self.scavenger_icon.alpha = 0;
    self setweaponammostock(self.EmptyWeap, WeapEmpStock);
    self setweaponammoclip(self.EmptyWeap, WeapEmpClip - WeapEmpClip);
    wait 0.5;
    self setweaponammostock(self.EmptyWeap, WeapEmpStock);
    wait 1.8;
    self.scavenger_icon destroy();
}

dolastStand()
{
    self setPerk( "specialty_pistoldeath" );
    self setPerk( "specialty_finalstand" );
    wait .1;
    self thread [[level.callbackPlayerDamage]]( self, self, self.health, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
    if(!self isOnGround())
    {
        self freezecontrolsallowlook( true );
        wait .3;
        self freezecontrolsallowlook( false );
    }
    wait .5;
}

doCenterGun()
{
    if( self.lg == 1 )
    {
        setdvar( "cg_gun_y", "4" );
        self.lg = 0;
    }
    else
    {
        setdvar( "cg_gun_y", "0" );
        self.lg = 1;
    }
}

doDropWeap()
{
    weap = self getcurrentweapon();
    self dropitem( weap );
}

doProne()
{
    self setStance("prone");
    wait 0.01;
    self setStance("prone");
}

doAltSwap()
{
    current_weapon = self get_next_weapon();
    asp = "asp_mp";
    self giveWeapon(asp);
    self switchToWeapon(asp);
    wait 0.001;
    self setSpawnWeapon(asp);
    waittillframeend;
    self switchToWeapon(current_weapon);
    waittillframeend;
    self takeWeapon(asp);
}

doElevator()
{
    if(self.pers["elevatorType"] == "up")
    {
        if(!isDefined(self.changle))
        {
            self endon("ebola");
            self.elevate = spawn( "script_origin", self.origin, 1 );
            self PlayerLinkToDelta( self.elevate, undefined );
            self.changle = true;
            for(;;)
            {
                self.UpEle = self.elevate.origin;
                wait 0.005;
                self.elevate.origin = self.UpEle + (0,0,self.pers["elevatorSpeed"]);
            }
            wait 0.005;
        }
        else
        {
            wait 0.01;
            self unlink();
            self.changle = undefined;
            self.elevate delete();
            self notify("ebola");
        }
    }
    else if(self.pers["elevatorType"] == "down")
    {
        if(!isDefined(self.changle))
        {
            self endon("ebola");
            self.elevate = spawn( "script_origin", self.origin, 1 );
            self PlayerLinkToDelta( self.elevate, undefined );
            downSpeed = 0 - self.pers["elevatorSpeed"];
            self.changle = true;
            for(;;)
            {
                self.UpEle = self.elevate.origin;
                wait 0.005;
                self.elevate.origin = self.UpEle + (0,0,downSpeed);
            }
            wait 0.005;
        }
        else
        {
            wait 0.01;
            self unlink();
            self.changle = undefined;
            self.elevate delete();
            self notify("ebola");
        }
    }
}

doWallBreach()
{
    if(!isDefined(self.WallBreachX))
    {
        self.WallBreachX = true;
        self setClientDvar("r_singleCell", "1");
        wait .001;
    }
    else if(isDefined(self.WallBreachX))
    {
        self.WallBreachX = undefined;
        self setClientDvar("r_singleCell", "0");
    }
    wait .001;
}

doBlackScreen()
{
    wait( 0.01 );
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
    self.blackscreen FadeOverTime( 0.01 ); 
    self.blackscreen.alpha = 1;
    wait( 0.01 );
    if( !isdefined(self.blackscreen) )
        return;

    wait( 0.7 );
    if( !isdefined(self.blackscreen) )
        return;

    if( 0.7>0 )
    self.blackscreen FadeOverTime( 0.3 ); 
    self.blackscreen.alpha = 0; 
    wait( 0.3 );

    if( isdefined(self.blackscreen) )           
    {
        self.blackscreen destroy();
        self.blackscreen = undefined;
    }
}

doWhiteScreen()
{
    wait( 0.01 );
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
    self.whitescreen FadeOverTime( 0.01 ); 
    self.whitescreen.alpha = 1; 
    wait( 0.01 );
    if( !isdefined(self.whitescreen) )
        return; 
    wait( 0.7 );
    if( !isdefined(self.whitescreen) )
        return;
    if( 0.7>0 )
    self.whitescreen FadeOverTime( 0.1 ); 
    self.whitescreen.alpha = 0; 
    wait( 0.1 );
    if( isdefined(self.whitescreen) )           
    { 
        self.whitescreen destroy();
        self.whitescreen = undefined;
    }
}

doCamoLoop()
{
    level endon("game_ended");
    self endon("death" );   
    if(!isDefined(self.DoingCamo))
    {
        self endon("Stop_CamoLoop");
        self.DoingCamo = true;
        for(;;)
        {
            rand = randomintrange(0, 16);
            weap = self getcurrentweapon();
            self takeweapon(weap);
            self giveweapon(weap, 0, rand, 0, 0, 0, 0);
            self setspawnweapon(weap);
            wait 0.001;
        }
        wait 0.001;
        
    }
    else
    {
        wait 0.01;
        self.DoingCamo = undefined;
        self notify("Stop_CamoLoop");
    }
}

doShaxThink()
{
    if(self.pers["shaxType"] == "default")
    {
        self thread doShax();
    }
    else if(self.pers["shaxType"] == "real")
    {
        self thread shaxstart();
    }
    else if(self.pers["shaxType"] == "static screen")
    {
        self thread shaxStatic();
    }
    else if(self.pers["shaxType"] == "black screen")
    {
        self thread shaxBlack();
    }
}

doInvisWeap()
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

doDamage()
{
    self thread [[level.callbackPlayerDamage]]( self, self, self.pers["SelfDamage"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
}

doSemtex()
{
    self.semtex["shader"] = createRectangle( "CENTER", "CENTER", 0, -85, "hud_icon_stuck_semtex", 73, 68, ( 1, 1, 1 ), 1, 1 );
    self.semtex["shaders"] = createRectangle( "CENTER", "CENTER", 0, -85, "overlay_low_health", 900, 1000, ( 1, 1, 1 ), 1, 1 );
    self thread pulseHudElement(self.semtex["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_semtex_alert", 0.3 );
    self.semtex["shader"] destroy();
    self.semtex["shaders"] destroy();
    self RadiusDamage( self.origin, 256, 300, 75, self, "MOD_EXPLOSIVE", "sticky_grenade_mp" );
    PlayFX( level._supply_drop_explosion_fx, self.origin );
    PlaySoundAtPosition( "wpn_grenade_explode", self.origin );
}

pulseHudElement(elem, minAlpha, maxAlpha, speed)
{
    while (1)
    {
        elem FadeOverTime(speed);
        elem.alpha = maxAlpha;
        wait(speed);

        elem FadeOverTime(speed);
        elem.alpha = minAlpha;
        wait(speed);
    }
}

doCrossbow()
{
    self thread [[level.callbackPlayerDamage]]( self, self, self.pers["SelfDamage"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
    self.arrow["shader"] = createRectangle( "CENTER", "CENTER", 0, -85, "hud_icon_stuck_arrow", 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.arrow["shaders"] = createRectangle( "CENTER", "CENTER", 0, -85, "overlay_low_health", 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.arrow["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_crossbow_alert", 0.3 );
    self.arrow["shader"] destroy();
    self.arrow["shaders"] destroy();
    self RadiusDamage( self.origin, 256, 300, 75, self, "MOD_EXPLOSIVE", "sticky_grenade_mp" );
    PlayFX( level._supply_drop_explosion_fx, self.origin );
    PlaySoundAtPosition( "wpn_grenade_explode", self.origin );
}

/*
 ______      ___      ___   ____  _____      __ ___  ____        _       _______     ____    ____       _        ______   _____  ____  _____  ______     ________  _____  _____  ____  _____   ______   ______   
|_   _ \   .'   `.  .'   `.|_   \|_   _|    / /|_  ||_  _|      / \     |_   __ \   |_   \  /   _|     / \      |_   _ \ |_   _||_   \|_   _||_   _ `.  |_   __  ||_   _||_   _||_   \|_   _|.' ___  |.' ____ \  
  | |_) | /  .-.  \/  .-.  \ |   \ | |     / /   | |_/ /       / _ \      | |__) |    |   \/   |      / _ \       | |_) |  | |    |   \ | |    | | `. \   | |_ \_|  | |    | |    |   \ | | / .'   \_|| (___ \_| 
  |  __'. | |   | || |   | | | |\ \| |    / /    |  __'.      / ___ \     |  __ /     | |\  /| |     / ___ \      |  __'.  | |    | |\ \| |    | |  | |   |  _|     | '    ' |    | |\ \| | | |        _.____`.  
 _| |__) |\  `-'  /\  `-'  /_| |_\   |_  / /    _| |  \ \_  _/ /   \ \_  _| |  \ \_  _| |_\/_| |_  _/ /   \ \_   _| |__) |_| |_  _| |_\   |_  _| |_.' /  _| |_       \ \__/ /    _| |_\   |_\ `.___.'\| \____) | 
|_______/  `.___.'  `.___.'|_____|\____|/_/    |____||____||____| |____||____| |___||_____||_____||____| |____| |_______/|_____||_____|\____||______.'  |_____|       `.__.'    |_____|\____|`.____ .' \______.' 
                                                                                                                                                                                                                 
                                                                                                                                                                                                                
flash()
{
    self thread maps\mp\_flashgrenades::applyFlash(1, 1);
}

thirdeye()
{
    self thread maps\mp\_flashgrenades::applyFlash(0, 0);
}


stucksemtex()
{
if(self.semmy == 1)
    {
    self.semtex["shader"] = createRectangle( "hud_icon_stuck_semtex", "CENTER", "CENTER", 0, -85, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.semtex["shaders"] = createRectangle( "overlay_low_health", "CENTER", "CENTER", 0, -85, 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.semtex["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_semtex_alert", 0.3 );
    self.semtex["shader"] destroy();
    self.semtex["shaders"] destroy();
    self suicide( self.origin, 256, 300, 75, self, "MOD_EXPLOSIVE", "sticky_grenade_mp" );
    PlayFX( level._supply_drop_explosion_fx, self.origin );
    PlaySoundAtPosition( "wpn_grenade_explode", self.origin );
    
    }

    else if(self.semmy == 2)
    {
    self.semtex["shader"] = createRectangle( "hud_icon_stuck_semtex", "CENTER", "CENTER", 0, -85, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.semtex["shaders"] = createRectangle( "overlay_low_health", "CENTER", "CENTER", 0, -85, 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.semtex["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_semtex_alert", 0.3 );
    self.semtex["shader"] destroy();
    self.semtex["shaders"] destroy();
    self RadiusDamage( self.origin, 256, 300, 75, self, "MOD_EXPLOSIVE", "sticky_grenade_mp" );
    PlayFX( level._supply_drop_explosion_fx, self.origin );
    PlaySoundAtPosition( "wpn_grenade_explode", self.origin );
    }
    else if(self.semmy == 3)
    {
    self.semtex["shader"] = createRectangle( "hud_icon_stuck_semtex", "CENTER", "CENTER", 0, -85, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.semtex["shaders"] = createRectangle( "overlay_low_health", "CENTER", "CENTER", 0, -85, 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.semtex["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_semtex_alert", 0.3 );
    self.semtex["shader"] destroy();
    self.semtex["shaders"] destroy();
    }
}


onsemmy(name)
{
    if(name == "Explodes/Kills You")
    {
        self.semmy = 1;
        self iprintln("Stuck Semtex Bind Action will ^6Explode/Kill You.");
    }
    if(name == "Explodes")
    {
        self.semmy = 2;
        self iprintln("Stuck Semtex Bind Action will ^6Explode.");
    }
    if(name == "Only Overlay")
    {
        self.semmy = 3;
        self iprintln("Stuck Semtex Bind Action will ^6Only Overlay.");
    }
}


stuckarrow()
{
if(self.arrow == 1)
    {
    self thread [[level.callbackPlayerDamage]]( self, self, self.pers["SelfDamage"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
    self.arrow["shader"] = createRectangle( "hud_icon_stuck_arrow", "CENTER", "CENTER", 0, -85, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.arrow["shaders"] = createRectangle( "overlay_low_health", "CENTER", "CENTER", 0, -85, 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.arrow["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_crossbow_alert", 0.3 );
    self.arrow["shader"] destroy();
    self.arrow["shaders"] destroy();
    self suicide( self.origin, 256, 300, 75, self, "MOD_EXPLOSIVE", "sticky_grenade_mp" );
    PlayFX( level._supply_drop_explosion_fx, self.origin );
    PlaySoundAtPosition( "wpn_grenade_explode", self.origin );
    
    }

    else if(self.arrow == 2)
    {
    self thread [[level.callbackPlayerDamage]]( self, self, self.pers["SelfDamage"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
    self.arrow["shader"] = createRectangle( "hud_icon_stuck_arrow", "CENTER", "CENTER", 0, -85, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.arrow["shaders"] = createRectangle( "overlay_low_health", "CENTER", "CENTER", 0, -85, 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.arrow["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_crossbow_alert", 0.3 );
    self.arrow["shader"] destroy();
    self.arrow["shaders"] destroy();
    self RadiusDamage( self.origin, 256, 300, 75, self, "MOD_EXPLOSIVE", "sticky_grenade_mp" );
    PlayFX( level._supply_drop_explosion_fx, self.origin );
    PlaySoundAtPosition( "wpn_grenade_explode", self.origin );
    }
    else if(self.arrow == 3)
    {
    self thread [[level.callbackPlayerDamage]]( self, self, self.pers["SelfDamage"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "body", 0 );
    self.arrow["shader"] = createRectangle( "hud_icon_stuck_arrow", "CENTER", "CENTER", 0, -85, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.arrow["shaders"] = createRectangle( "overlay_low_health", "CENTER", "CENTER", 0, -85, 900, 1000, ( 255, 255, 255 ), 1, 1 );
    self thread pulseHudElement(self.arrow["shaders"], 0.4, .75, 0.09);
    self maps\mp\gametypes\_supplydrop::loop_sound( "wpn_crossbow_alert", 0.3 );
    self.arrow["shader"] destroy();
    self.arrow["shaders"] destroy();
    }
}


onarrow(name)
{
    if(name == "Explodes/Kills You")
    {
        self.arrow = 1;
        self iprintln("Stuck Arrow Bind Action will ^6Explode/Kill You.");
    }
    if(name == "Explodes")
    {
        self.arrow = 2;
        self iprintln("Stuck Arrow Bind Action will ^6Explode.");
    }
    if(name == "Only Overlay")
    {
        self.arrow = 3;
        self iprintln("Stuck Arrow Bind Action will ^6Only Overlay.");
    }
}



dropscav()
{
    if(self.scav == 1)
    {
    self setPerk("specialty_scavenger");
    item = self dropScavengerItem( "scavenger_item_mp" );
    item thread maps\mp\gametypes\_weapons::scavenger_think();
    }

    else if(self.scav == 2)
    {
    self.EmptyWeap = self getCurrentweapon();
    WeapEmpClip    = self getWeaponAmmoClip(self.EmptyWeap);
    WeapEmpStock     = self getWeaponAmmoStock(self.EmptyWeap);
    self.scavenger_icon = NewClientHudElem( self );
    self.scavenger_icon.horzAlign = "center";
    self.scavenger_icon.vertAlign = "middle";
    self.scavenger_icon.x = -36;
    self.scavenger_icon.y = 32;
    width = 64;
    height = 32;
    self.scavenger_icon setShader( "hud_scavenger_pickup", width, height );
    self.scavenger_icon.alpha = 1;
    self.scavenger_icon fadeOverTime( 2.5 );
    self.scavenger_icon.alpha = 0;
    self setweaponammostock(self.EmptyWeap, WeapEmpStock);
    self setweaponammoclip(self.EmptyWeap, WeapEmpClip - WeapEmpClip);
    wait 0.5;
    self setweaponammostock(self.EmptyWeap, WeapEmpStock);
    wait 1.8;
    self.scavenger_icon destroy();
    }
}


onscav(name)
{
    if(name == "Real Scav")
    {
        self.scav = 1;
        self iprintln("Scav Bind Action will ^6drop scav.");
    }
    if(name == "Overlay")
    {
        self.scav = 2;
        self iprintln("Scav Bind Action will ^6overlay.");
    }
}

gflip()
{
    x = self getCurrentweapon();
    stock = self getWeaponAmmoStock(x);
    clip = self getWeaponAmmoClip(x);
    self takeWeapon(x);
    self setStance("prone");
    self giveWeapon("m1911_mp");
    self switchToWeapon("m1911_mp");
    wait 0.01;
    self setStance("prone");
    self takeWeapon("m1911_mp");
    self giveWeapon(x);
    self setweaponammostock(x, 0);
    self setweaponammoclip(x, 0);
    self switchToWeapon(x);
    wait 0.13;
    self setStance("stand");
    self setweaponammostock(x, stock);
    self setweaponammoclip(x, clip);
}

l96()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("l96a1_mp");
    self switchtoweapon("l96a1_mp");
}

wa2k()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("wa2000_mp");
    self switchtoweapon("wa2000_mp");
}

psg1()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("psg1_mp");
    self switchtoweapon("psg1_mp");
}

drag()
{
    x = self GetCurrentWeapon();
    self TakeWeapon(x);
    self GiveWeapon("dragunov_mp");
    self switchtoweapon("dragunov_mp");
}


conn()
{
    self.fakelag["Text"] = self createtext( "default", 2.4, "CENTER", "default", 2, -152, undefined, 1, 1, "Connection Interrupted" );
    self.fakelag["Guy"] = createRectangle( "net_new_animation", "CENTER", "CENTER", 0, 115, 73, 68, ( 255, 255, 255 ), 1, 1 );
    self.fakelag["Text"].alpha = 1;
    self.fakelag["Guy"].alpha = 1;
    wait 5;
    self.fakelag["Text"].alpha = 0;
    self.fakelag["Guy"].alpha = 0;
    self.fakelag["Text"] destroy();
    self.fakelag["Guy"] destroy();

}

drop_weapon_location()
{
    self.pers["drop_weapon_location"] = self getOrigin() + (0, 0, 20);
    setDvar("weapx",self.origin[0]);
    setDvar("weapy",self.origin[1]);
    setDvar("weapz",self.origin[2]);
    self iprintln("^7Your weapon will drop at: ^6" + self.pers["drop_weapon_location"]);

}

drop_weapon(new_location)
{
    level.weapon delete();
    level.weapon.placeholder delete();
    weapon = self.pers["drop_weapon_name"];
    type = self.pers["drop_weapon_type"];

    level.weapon = spawn("weapon_" + weapon, self.pers["drop_weapon_location"]);
    level.weapon.angles = (0, 0, 0);
    level.weapon.weapon = weapon;
    level.weapon itemWeaponSetAmmo(999, 999);

    level.weapon.placeholder = spawn("script_origin", self.pers["drop_weapon_location"]);
    level.weapon.placeholder enableLinkTo();
    level.weapon linkTo(level.weapon.placeholder);

    return weapon;
}

drop_weapon_name()
{
    self.pers["drop_weapon_name"] = self getCurrentWeapon();
}

enable()
{
    self enableWeapons();
}

disable()
{
    self disableWeapons();
}

radio()
{
    x = self getCurrentWeapon();
    self takeWeapon(x);
    self giveWeapon("helicopter_gunner_mp");
    self switchToWeapon("helicopter_gunner_mp");
    wait 0.2;
    self giveWeapon(x);
    self waittill("weapon_change");
    self takeWeapon("helicopter_gunner_mp");
}


rcrem()
{
    x = self getCurrentWeapon();
    stock = self getWeaponAmmoStock(x);
    clip = self getWeaponAmmoClip(x);
    self takeWeapon(x);
    self giveWeapon("rcbomb_mp");
    self switchToWeapon("rcbomb_mp");
    wait 0.2;
    self giveWeapon(x);
    self setweaponammostock(x, stock);
    self setweaponammoclip(x, clip);
    wait 0.7;
    self takeWeapon("rcbomb_mp");
    self switchToWeapon(x);
}


c4can()
{
    x = self getCurrentWeapon();
    stock = self getWeaponAmmoStock(x);
    clip = self getWeaponAmmoClip(x);
    self takeWeapon(x);
    self giveWeapon("satchel_charge_mp");
    self switchToWeapon("satchel_charge_mp");
    wait 0.2;
    self giveWeapon(x);
    self setweaponammostock(x, stock);
    self setweaponammoclip(x, clip);
    wait 0.45;
    self takeWeapon("satchel_charge_mp");
    self switchToWeapon(x);
}


ubyy()
{
    self disableweapons();
	wait 0.01;
	self enableweapons();
}



//(DEBUGGING BULLSHIT)
whatsmypers()
{
    self iPrintln("Your pers is: ^6"+self.pers["fuckfuckfuckfuck"]);
}

whatsmypers2()
{
    self iPrintln("Your pers is: ^6"+self.pers["HELP ME"]);
}

*/
