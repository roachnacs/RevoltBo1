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
        command = self waittill_any_return("dpad1", "dpad2", "dpad3", "dpad4");
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
            
        wait 0.05;
    }
}

bindCycle(var, bool)
{
    if(self.pers[var] == 4)
        self.pers[var] = 0;
    else
        self.pers[var]++;

    if(self.pers[var] == 0)
    {
        self.pers[bool] = "<>";
    }
    else
    {
    self.pers[bool] = "[{+actionslot " + self.pers[var] + "}] ";
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

    }
    else if(self.pers["RepeaterType"] == "real repeater")
    {

    }
    else if(self.pers["RepeaterType"] == "damage repeater")
    {

    }
    else if(self.pers["RepeaterType"] == "real damage repeater")
    {

    }
}
