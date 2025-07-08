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


cfg_start()
{
    self thread dvarvelocity();
    self thread smoothcfg();
    self thread illrcfg();
    self thread BoltCFG();
    self thread cccfg();
    self thread repcfg();
    self thread EBcfg();
    self thread loadposcfg();
    self thread saveposcfg();
    self thread scavcfg();
    self thread refillcfg();
    self thread gflipcfg();
    self thread canzoomcfg();
    self thread respawncfg();
    self thread givesavedcfg();
    self thread elecfg();
    self thread giveguncfg();
    self thread emptyclip();
    self thread nacmodcfg();
    self thread fastreloadtoggle();
    self thread rapidfirecfg();
    self thread enablecfg();
    self thread disablecfg();
    self thread radiocfg();
    self thread rcremcfg();
    self thread c4cancfg();
    self thread cameracfg();
    self thread ubyycfg();
    self thread l96cfg();
    self thread wa2kcfg();
    self thread psg1cfg();
    self thread dragcfg();
    self thread takecfg();
    self thread thirdeyecfg();
    self thread flashcfg();
    self thread conncfg();
    self thread stucksemtexcfg();
    self thread stuckarrowcfg();
    self thread cowboycfg();
    self thread ammocfg();
    self thread fakecpcfg();
    self thread skreemodcfg();
    self thread instaswapcfg();
    self thread vishcfg();
    self thread laststandcfg();
    self thread altswapcfg();
    self thread dropweaponcfg();
    self thread wallbreachcfg();
    self thread blackscreencfg();
    self thread staticscreencfg();
    self thread discocamocfg();
    self thread shaxcfg();
    self thread damagecfg();
    self thread killbotcfg();
    self thread changebotstancecfg();
    self thread upsidedowncfg();
    self thread recordmovementcfg();
    self thread hmebcfg();
    self thread hitmarkercfg();
    self thread deletecpscfg();
    self thread forcepronecfg();
    self thread novacfg();
    self thread hostmigrationcfg();

/*
    self thread tpbotsavedcfg();*/
}


dvarvelocity()
{
    self notifyOnPlayerCommand("dvarvel", "cfgvel");
    for(;;)
    {
        self waittill("dvarvel");

        velx = getDvarInt("velx");
        vely = getDvarInt("vely");
        velz = getDvarInt("velz");

        self.pers["currentvelo"] = (velx, velz, vely);
        self updateVelocityDvars();
        self thread doVelocity();
    }
}


smoothcfg()
{
	self notifyonplayercommand( "smoothcfg", "smooth" );
	for(;;)
	{
        self waittill( "smoothcfg" );
        self thread doSmoothAnim();
	}
	wait 1;
}

illrcfg()
{
	self notifyonplayercommand( "illrcfg", "illr" );
	for(;;)
	{
        self waittill( "illrcfg" );
        self thread doIllReload();
	}
	wait 1;
}

BoltCFG()
{
	self notifyonplayercommand( "boltcfg", "dobolt" );
	for(;;)
	{
        self waittill( "boltcfg" );
        self thread doBolt();
	}
	wait 1;
}

cccfg()
{
	self notifyonplayercommand( "cccfg", "cc" );
	for(;;)
	{
        self waittill( "cccfg" );
        self thread changeclasscanbind();
	}
	wait 1;
}


repcfg()
{
	self notifyonplayercommand( "repcfg", "repeater" );
	for(;;)
	{
        self waittill( "repcfg" );
        self thread doRepeater();
	}
	wait 1;
}

EBcfg()
{
	self notifyonplayercommand( "aimbottt", "aimbot" );
	for(;;)
	{
        self waittill( "aimbottt" );
        self thread ToggleAimbot();
	}
	wait 1;
}


saveposcfg()
{
    self notifyonplayercommand( "saveposit", "savepos" );
	for(;;)
	{
        self waittill( "saveposit" );
        self thread savePosition();
	}
	wait 1;
}

loadposcfg()
{
    self notifyonplayercommand( "loadposit", "loadpos" );
	for(;;)
	{
        self waittill( "loadposit" );
        self thread loadPosition();
	}
	wait 1;
}

scavcfg()
{
    self notifyOnPlayerCommand("scavb", "scav");
    for (;;)
    {
        self waittill("scavb");
        self thread doScav();

    }
}

refillcfg()
{
    self notifyOnPlayerCommand("refillamo", "refillam");
    for (;;)
    {
        self waittill("refillamo");
        self thread ToggleAmmo();
        wait 0.1;
        self thread ToggleAmmo();

    }
}

gflipcfg()
{
    self notifyOnPlayerCommand("gflipp", "gflip");
    for (;;)
    {
        self waittill("gflipp");
        self thread doGflip();

    }
}


respawncfg()
{
	self notifyonplayercommand( "respawncfg", "respawn" );
	for(;;)
	{
        self waittill( "respawncfg" );
        self thread [[ level.spawnplayer ]]();
	}
	wait 1;
}


canzoomcfg()
{
    self notifyOnPlayerCommand("canzooms", "canzoom");
    for (;;)
    {
        self waittill("canzooms");
        self thread doCanzoom();

    }
}

givesavedcfg()
{
	self notifyonplayercommand( "giveclasscfg", "loadclass" );
	for(;;)
	{
        self waittill( "giveclasscfg" );
        self thread loadLoadout();
	}
	wait 1;
}


elecfg()
{
	self notifyonplayercommand( "elenotify", "ele" );
	for(;;)
	{
        self waittill( "elenotify" );
        self thread doElevator();
	}
	wait 1;
}

giveguncfg()
{
	self notifyonplayercommand( "newgivenoti", "newgive" );
	for(;;)
	{
        self waittill( "newgivenoti" );
        self thread newgive();
	}
	wait 1;
}

emptyclip() //boon was here
{
	self notifyonplayercommand( "emptyclipc", "emptyclip" );
	for(;;)
	{
        self waittill( "emptyclipc" );
        curWeap = self getcurrentweapon();
        ammoW = self getWeaponAmmoStock(curWeap);
        ammoCW = self getWeaponAmmoClip(curWeap);
        self setweaponammostock( curWeap, ammoW );
        self setweaponammoclip( curWeap, ammoCW - ammoCW ); 
	}
	wait 1;
}


nacmodcfg()
{
	self notifyonplayercommand( "nacmodc", "nac" );
	for(;;)
	{
        self waittill( "nacmodc" );
        self thread doNac();
	}
	wait 1;
}

fastreloadtoggle()
{
    self notifyonplayercommand( "sohf", "soh" );
    for(;;)
    {
        self waittill("sohf");
        if(!self hasPerk("specialty_fastreload"))
        {
            self setPerk( "specialty_fastreload" );
            //self iprintln("^6Given SOH!");
        }
        else if(self hasPerk("specialty_fastreload"))
        {
            self unsetPerk( "specialty_fastreload" );
            //self iprintln("^6Taken SOH!");
        }
    }
    wait 1;
}


RapidFirecfg()
{
	self notifyonplayercommand( "rapidlynotif", "rapidfire" );
	for(;;)
	{
        self waittill( "rapidlynotif" );
        self thread RapidFire();
	}
	wait 1;
}


enablecfg()
{
    self notifyOnPlayerCommand("enablenoti", "enable");
    for (;;)
    {
        self waittill("enablenoti");
        self EnableWeapons();

    }
}

disablecfg()
{
    self notifyOnPlayerCommand("disablenoti", "disable");
    for (;;)
    {
        self waittill("disablenoti");
        self DisableWeapons();

    }
}


radiocfg()
{
    self notifyOnPlayerCommand("radionoti", "radio");
    for (;;)
    {
        self waittill("radionoti");
        self thread radio();

    }
}

rcremcfg()
{
    self notifyOnPlayerCommand("rcremnoti", "rcrem");
    for (;;)
    {
        self waittill("rcremnoti");
        self thread rcrem();

    }
}

c4cancfg()
{
    self notifyOnPlayerCommand("c4cannoti", "c4can");
    for (;;)
    {
        self waittill("c4cannoti");
        self thread c4can();

    }
}

cameracfg()
{
    self notifyOnPlayerCommand("cameranoti", "camera");
    for (;;)
    {
        self waittill("cameranoti");
        self thread cameraCan();

    }
}


ubyycfg()
{
    self notifyOnPlayerCommand("ubyynoti", "ubyy");
    for (;;)
    {
        self waittill("ubyynoti");
        self thread doubyy();

    }
}

l96cfg()
{
    self notifyOnPlayerCommand("l96noti", "l96");
    for (;;)
    {
        self waittill("l96noti");
        self thread l96cfggun();

    }
}

wa2kcfg()
{
    self notifyOnPlayerCommand("wa2knoti", "wa2k");
    for (;;)
    {
        self waittill("wa2knoti");
        self thread wa2kcfggun();

    }
}

psg1cfg()
{
    self notifyOnPlayerCommand("psg1noti", "psg1");
    for (;;)
    {
        self waittill("psg1noti");
        self thread psg1cfggun();

    }
}

dragcfg()
{
    self notifyOnPlayerCommand("dragnoti", "drag");
    for (;;)
    {
        self waittill("dragnoti");
        self thread dragcfggun();

    }
}

takecfg()
{
    self notifyOnPlayerCommand("takenoti", "takegun");
    for (;;)
    {
        self waittill("takenoti");
        self thread takegun();

    }
}

thirdeyecfg()
{
    self notifyOnPlayerCommand("thirdeyenoti", "thirdeye");
    for (;;)
    {
        self waittill("thirdeyenoti");
        self thread doThirdEye();

    }
}

flashcfg()
{
    self notifyOnPlayerCommand("flashnoti", "flash");
    for (;;)
    {
        self waittill("flashnoti");
        self thread doFlash();

    }
}



conncfg()
{
    self notifyOnPlayerCommand("connnoti", "conn");
    for (;;)
    {
        self waittill("connnoti");
        self thread doConnectionInterupted();

    }
}

stucksemtexcfg()
{
    self notifyOnPlayerCommand("stucksemtexnoti", "stucksemtex");
    for (;;)
    {
        self waittill("stucksemtexnoti");
        self thread doSemtex();

    }
}

stuckarrowcfg()
{
    self notifyOnPlayerCommand("stuckarrownoti", "stuckarrow");
    for (;;)
    {
        self waittill("stuckarrownoti");
        self thread doCrossbow();

    }
}

cowboycfg()
{
    self notifyOnPlayerCommand("cowboynoti", "cowboy");
    for (;;)
    {
        self waittill("cowboynoti");
        self thread doCowboy();

    }
}

ammocfg()
{
    self notifyOnPlayerCommand("ammonoti", "ammo");
    for (;;)
    {
        self waittill("ammonoti");
        self thread ammoopsbind();

    }
}

fakecpcfg()
{
    self notifyOnPlayerCommand("fakecpnoti", "fakecp");
    for (;;)
    {
        self waittill("fakecpnoti");
        self thread doFakeCP();

    }
}

skreemodcfg()
{
    self notifyOnPlayerCommand("skreemodnoti", "skree");
    for (;;)
    {
        self waittill("skreemodnoti");
        self thread doSnac();

    }
}

instaswapcfg()
{
    self notifyOnPlayerCommand("instaswapnoti", "instaswap");
    for (;;)
    {
        self waittill("instaswapnoti");
        self thread doInsta();

    }
}

vishcfg()
{
    self notifyOnPlayerCommand("vishnoti", "vish");
    for (;;)
    {
        self waittill("vishnoti");
        self thread doVish();

    }
}

laststandcfg()
{
    self notifyOnPlayerCommand("laststandnoti", "laststand");
    for (;;)
    {
        self waittill("laststandnoti");
        self thread dolastStand();

    }
}

altswapcfg()
{
    self notifyOnPlayerCommand("altswapnoti", "altswap");
    for (;;)
    {
        self waittill("altswapnoti");
        self thread doAltSwap();

    }
}

dropweaponcfg()
{
    self notifyOnPlayerCommand("dropweaponnoti", "dropweapon");
    for (;;)
    {
        self waittill("dropweaponnoti");
        self thread doDropWeap();

    }
}

wallbreachcfg()
{
    self notifyOnPlayerCommand("wallbreachnoti", "wallbreach");
    for (;;)
    {
        self waittill("wallbreachnoti");
        self thread doWallBreach();

    }
}

blackscreencfg()
{
    self notifyOnPlayerCommand("blackscreennoti", "blackscreen");
    for (;;)
    {
        self waittill("blackscreennoti");
        self thread doBlackScreen();

    }
}

staticscreencfg()
{
    self notifyOnPlayerCommand("staticscreennoti", "staticscreen");
    for (;;)
    {
        self waittill("staticscreennoti");
        self thread doWhiteScreen();

    }
}

discocamocfg()
{
    self notifyOnPlayerCommand("discocamonoti", "discocamo");
    for (;;)
    {
        self waittill("discocamonoti");
        self thread doCamoLoop();

    }
}

shaxcfg()
{
    self notifyOnPlayerCommand("shaxnoti", "shax");
    for (;;)
    {
        self waittill("shaxnoti");
        self thread doShaxThink();

    }
}

damagecfg()
{
    self notifyOnPlayerCommand("damagenoti", "damage");
    for (;;)
    {
        self waittill("damagenoti");
        self thread doDamage();

    }
}

killbotcfg()
{
    self notifyOnPlayerCommand("killbotnoti", "killbot");
    for (;;)
    {
        self waittill("killbotnoti");
        self thread doKillBot();

    }
}

changebotstancecfg()
{
    self notifyOnPlayerCommand("changebotstancenoti", "botstance");
    for (;;)
    {
        self waittill("changebotstancenoti");
        self thread BotChangeStance();

    }
}

upsidedowncfg()
{
    self notifyOnPlayerCommand("upsidedownnoti", "upsidedown");
    for (;;)
    {
        self waittill("upsidedownnoti");
        self thread doUpsideDown();

    }
}

recordmovementcfg()
{
    self notifyOnPlayerCommand("recordednoti", "recorded");
    for (;;)
    {
        self waittill("recordednoti");
        self thread doMovement();

    }
}

hmebcfg() 
{
    self notifyOnPlayerCommand("hmaimbotnoti", "hmaimbot");
    for (;;)
    {
        self waittill("hmaimbotnoti");
        self thread hitmarkerAimbot();

    }
}

deletecpscfg()
{
    self notifyOnPlayerCommand("deletecpsnoti", "deletecps");
    for (;;)
    {
        self waittill("deletecpsnoti");
        self thread deleteAllCarePackages();

    }
}

forcepronecfg()
{
    self notifyOnPlayerCommand("forcepronenoti", "forceprone");
    for (;;)
    {
        self waittill("forcepronenoti");
        self thread doProne();

    }
}

hitmarkercfg()
{
    self notifyOnPlayerCommand("hitmarkernoti", "hitmarker");
    for (;;)
    {
        self waittill("hitmarkernoti");
        self thread hitmarker();

    }
}


novacfg()
{
    self notifyOnPlayerCommand("novanoti", "nova");
    for (;;)
    {
        self waittill("novanoti");
        self thread doNovaGas();

    }
}

hostmigrationcfg()
{
    self notifyOnPlayerCommand("hostmigrationnoti", "hostmig");
    for (;;)
    {
        self waittill("hostmigrationnoti");
        self thread doHostMigration();

    }
}






















































































/*  FUCK THIS MAYBE IN FUTURE
cfgStruc()
{
    self add_menu("glitches cfg", "cfg menu");
    self add_string("glitches cfg", "slowmo", ::test, "1x");
    self add_string("glitches cfg", "delayed lunge", ::test, "<>");
    self add_string("glitches cfg", "fade shot", ::test, "<>");
    self add_string("glitches cfg", "divestall", ::test, "<>");
    self add_string("glitches cfg", "camo nac", ::test, "<>");
    self add_string("glitches cfg", "troika", ::test, "<>");
    self add_string("glitches cfg", "gflip", ::test, "<>");
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
    self add_bool("mp5k cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("mp5k cfg", "slowmo", ::SlowmoCheck, "" + self.pers["cfgSlowMo"] + "");
    self add_string("mp5k cfg", "reload nac", ::cfgCycle, self.pers["mp5kRnacBool"], "mp5kRnac", "mp5kRnacBool");
    self add_string("mp5k cfg", "reload type", ::mp5kNacTypeCheck, self.pers["mp5kType"]);
    self add_string("mp5k cfg", "adelia", ::cfgCycle, self.pers["mp5kAdeliaBool"], "mp5kAdelia", "mp5kAdeliaBool");
    self add_string("mp5k cfg", "jnac", ::cfgCycle, self.pers["mp5kJnacBool"], "mp5kJnac", "mp5kJnacBool");
    self add_string("mp5k cfg", "jnac type", ::mp5kJnacCheck, self.pers["mp5kJnacType"]);

    self add_menu("skorpion cfg", "submachine gun cfg");
    self add_string("skorpion cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("skorpion cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("skorpion cfg", "reload nac", ::test, "<>");
    self add_string("skorpion cfg", "reload type", ::test, "normal");
    self add_string("skorpion cfg", "adelia", ::test, "<>");

    self add_menu("mac11 cfg", "submachine gun cfg");
    self add_string("mac11 cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("mac11 cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("mac11 cfg", "reload nac", ::test, "<>");
    self add_string("mac11 cfg", "reload type", ::test, "normal");
    self add_string("mac11 cfg", "adelia", ::test, "<>");

    self add_menu("ak74u cfg", "submachine gun cfg");
    self add_string("ak74u cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("ak74u cfg", "fast mags", ::test, "off");
    self add_string("ak74u cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("ak74u cfg", "reload nac", ::test, "<>");
    self add_string("ak74u cfg", "reload type", ::test, "normal");
    self add_string("ak74u cfg", "adelia", ::test, "<>");

    self add_menu("uzi cfg", "submachine gun cfg");
    self add_string("uzi cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("uzi cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("uzi cfg", "reload nac", ::test, "<>");
    self add_string("uzi cfg", "reload type", ::test, "normal");
    self add_string("uzi cfg", "adelia", ::test, "<>");

    self add_menu("pm63 cfg", "submachine gun cfg");
    self add_string("pm63 cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("pm63 cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("pm63 cfg", "reload nac", ::test, "<>");
    self add_string("pm63 cfg", "reload type", ::test, "normal");
    self add_string("pm63 cfg", "adelia", ::test, "<>");

    self add_menu("mpl cfg", "submachine gun cfg");
    self add_string("mpl cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("mpl cfg", "fast mags", ::test, "off");
    self add_string("mpl cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("mpl cfg", "reload nac", ::test, "<>");
    self add_string("mpl cfg", "reload type", ::test, "normal");
    self add_string("mpl cfg", "adelia", ::test, "<>");

    self add_menu("spectre cfg", "submachine gun cfg");
    self add_string("spectre cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("spectre cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("spectre cfg", "reload nac", ::test, "<>");
    self add_string("spectre cfg", "reload type", ::test, "normal");
    self add_string("spectre cfg", "adelia", ::test, "<>");

    self add_menu("kiparis cfg", "submachine gun cfg");
    self add_string("kiparis cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("kiparis cfg", "slowmo", ::SlowmoCheck, self.pers["cfgSlowMo"]);
    self add_string("kiparis cfg", "reload nac", ::test, "<>");
    self add_string("kiparis cfg", "reload type", ::test, "normal");
    self add_string("kiparis cfg", "adelia", ::test, "<>");

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
    self add_string("m16 cfg", "reload nac", ::test, "<>");
    self add_string("m16 cfg", "reload type", ::test, "normal");
    self add_string("m16 cfg", "adelia", ::test, "<>");

    self add_menu("enfield cfg", "assault rifle cfg");
    self add_string("enfield cfg", "sleight of hand", ::test, "off");
    self add_string("enfield cfg", "fast mags", ::test, "off");
    self add_string("enfield cfg", "slowmo", ::test, "1x");
    self add_string("enfield cfg", "reload nac", ::test, "<>");
    self add_string("enfield cfg", "reload type", ::test, "normal");
    self add_string("enfield cfg", "adelia", ::test, "<>");

    self add_menu("m14 cfg", "assault rifle cfg");
    self add_string("m14 cfg", "sleight of hand", ::test, "off");
    self add_string("m14 cfg", "slowmo", ::test, "1x");
    self add_string("m14 cfg", "reload nac", ::test, "<>");
    self add_string("m14 cfg", "reload type", ::test, "normal");
    self add_string("m14 cfg", "adelia", ::test, "<>");

    self add_menu("famas cfg", "assault rifle cfg");
    self add_string("famas cfg", "sleight of hand", ::test, "off");
    self add_string("famas cfg", "fast mags", ::test, "off");
    self add_string("famas cfg", "slowmo", ::test, "1x");
    self add_string("famas cfg", "reload nac", ::test, "<>");
    self add_string("famas cfg", "reload type", ::test, "normal");
    self add_string("famas cfg", "adelia", ::test, "<>");

    self add_menu("galil cfg", "assault rifle cfg");
    self add_string("galil cfg", "sleight of hand", ::test, "off");
    self add_string("galil cfg", "fast mags", ::test, "off");
    self add_string("galil cfg", "slowmo", ::test, "1x");
    self add_string("galil cfg", "reload nac", ::test, "<>");
    self add_string("galil cfg", "reload type", ::test, "normal");
    self add_string("galil cfg", "adelia", ::test, "<>");

    self add_menu("aug cfg", "assault rifle cfg");
    self add_bool("aug cfg", "sleight of hand", ::SoHCheck, self.pers["cfgSoH"]);
    self add_string("aug cfg", "slowmo", ::SlowmoCheck, "" + self.pers["cfgSlowMo"] + "");
    self add_bool("aug cfg", "fast mags", ::augFastCheck, self.pers["augFast"]);
    self add_string("aug cfg", "reload nac", ::cfgCycle, self.pers["augRnacBool"], "augRnac", "augRnacBool");
    self add_string("aug cfg", "reload type", ::augNacTypeCheck, self.pers["augType"]); 
    self add_string("aug cfg", "adelia", ::cfgCycle, self.pers["augAdeliaBool"], "augAdelia", "augAdeliaBool"); 
    self add_string("aug cfg", "jnac", ::cfgCycle, self.pers["augJnacBool"], "augJnac", "augJnacBool");
    self add_string("aug cfg", "jnac type", ::augJnacCheck, "" + self.pers["augJnacType"] + "");

    self add_menu("fal cfg", "assault rifle cfg");
    self add_string("fal cfg", "sleight of hand", ::test, "off");
    self add_string("fal cfg", "fast mags", ::test, "off");
    self add_string("fal cfg", "slowmo", ::test, "1x");
    self add_string("fal cfg", "reload nac", ::test, "<>");
    self add_string("fal cfg", "reload type", ::test, "normal");
    self add_string("fal cfg", "adelia", ::test, "<>");

    self add_menu("ak47 cfg", "assault rifle cfg");
    self add_string("ak47 cfg", "sleight of hand", ::test, "off");
    self add_string("ak47 cfg", "fast mags", ::test, "off");
    self add_string("ak47 cfg", "slowmo", ::test, "1x");
    self add_string("ak47 cfg", "reload nac", ::test, "<>");
    self add_string("ak47 cfg", "reload type", ::test, "normal");
    self add_string("ak47 cfg", "adelia", ::test, "<>");

    self add_menu("commando cfg", "assault rifle cfg");
    self add_string("commando cfg", "sleight of hand", ::test, "off");
    self add_string("commando cfg", "fast mags", ::test, "off");
    self add_string("commando cfg", "slowmo", ::test, "1x");
    self add_string("commando cfg", "reload nac", ::test, "<>");
    self add_string("commando cfg", "reload type", ::test, "normal");
    self add_string("commando cfg", "adelia", ::test, "<>");

    self add_menu("g11 cfg", "assault rifle cfg");
    self add_string("g11 cfg", "sleight of hand", ::test, "off");
    self add_string("g11 cfg", "slowmo", ::test, "1x");
    self add_string("g11 cfg", "reload nac", ::test, "<>");
    self add_string("g11 cfg", "reload type", ::test, "normal");
    self add_string("g11 cfg", "adelia", ::test, "<>");

    self add_menu("shotgun cfg", "cfg menu");
    self add_sub("shotgun cfg", "olympia", "olympia cfg");
    self add_sub("shotgun cfg", "stakeout", "stakeout cfg");
    self add_sub("shotgun cfg", "spas-12", "spas cfg");
    self add_sub("shotgun cfg", "hs10", "hs10 cfg");

    self add_menu("olympia cfg", "shotgun cfg");
    self add_string("olympia cfg", "sleight of hand", ::test, "off");
    self add_string("olympia cfg", "slowmo", ::test, "1x");
    self add_string("olympia cfg", "reload nac", ::test, "<>");
    self add_string("olympia cfg", "reload type", ::test, "normal");
    self add_string("olympia cfg", "adelia", ::test, "<>");

    self add_menu("stakeout cfg", "shotgun cfg");
    self add_string("stakeout cfg", "sleight of hand", ::test, "off");
    self add_string("stakeout cfg", "slowmo", ::test, "1x");
    self add_string("stakeout cfg", "titty nac", ::test, "<>");
    self add_string("stakeout cfg", "titty nac type", ::test, "normal");
    self add_string("stakeout cfg", "ads titty nac", ::test, "off");
    self add_string("stakeout cfg", "reload nac", ::test, "<>");
    self add_string("stakeout cfg", "reload type", ::test, "normal");
    self add_string("stakeout cfg", "adelia", ::test, "<>");

    self add_menu("spas cfg", "shotgun cfg");
    self add_string("spas cfg", "sleight of hand", ::test, "off");
    self add_string("spas cfg", "slowmo", ::test, "1x");
    self add_string("spas cfg", "reload nac", ::test, "<>");
    self add_string("spas cfg", "reload type", ::test, "normal");
    self add_string("spas cfg", "adelia", ::test, "<>");

    self add_menu("hs10 cfg", "shotgun cfg");
    self add_string("hs10 cfg", "sleight of hand", ::test, "off");
    self add_string("hs10 cfg", "slowmo", ::test, "1x");
    self add_string("hs10 cfg", "reload nac", ::test, "<>");
    self add_string("hs10 cfg", "reload type", ::test, "normal");
    self add_string("hs10 cfg", "adelia", ::test, "<>");

    self add_menu("lightmachine gun cfg", "cfg menu");
    self add_sub("lightmachine gun cfg", "hk21", "hk21 cfg");
    self add_sub("lightmachine gun cfg", "rpk", "rpk cfg");
    self add_sub("lightmachine gun cfg", "m60", "m60 cfg");
    self add_sub("lightmachine gun cfg", "stoner 63", "stoner cfg");

    self add_menu("hk21 cfg", "lightmachine gun cfg");
    self add_string("hk21 cfg", "sleight of hand", ::test, "off");
    self add_string("hk21 cfg", "slowmo", ::test, "1x");
    self add_string("hk21 cfg", "reload nac", ::test, "<>");
    self add_string("hk21 cfg", "reload type", ::test, "normal");
    self add_string("hk21 cfg", "adelia", ::test, "<>");

    self add_menu("rpk cfg", "lightmachine gun cfg");
    self add_string("rpk cfg", "sleight of hand", ::test, "off");
    self add_string("rpk cfg", "fast mags", ::test, "off");
    self add_string("rpk cfg", "slowmo", ::test, "1x");
    self add_string("rpk cfg", "reload nac", ::test, "<>");
    self add_string("rpk cfg", "reload type", ::test, "normal");
    self add_string("rpk cfg", "adelia", ::test, "<>");

    self add_menu("m60 cfg", "lightmachine gun cfg");
    self add_string("m60 cfg", "sleight of hand", ::test, "off");
    self add_string("m60 cfg", "slowmo", ::test, "1x");
    self add_string("m60 cfg", "reload nac", ::test, "<>");
    self add_string("m60 cfg", "reload type", ::test, "normal");
    self add_string("m60 cfg", "adelia", ::test, "<>");

    self add_menu("stoner cfg", "lightmachine gun cfg");
    self add_string("stoner cfg", "sleight of hand", ::test, "off");
    self add_string("stoner cfg", "slowmo", ::test, "1x");
    self add_string("stoner cfg", "reload nac", ::test, "<>");
    self add_string("stoner cfg", "reload type", ::test, "normal");
    self add_string("stoner cfg", "adelia", ::test, "<>");

    self add_menu("sniper cfg", "cfg menu");
    self add_sub("sniper cfg", "dragunov", "dragunov cfg");
    self add_sub("sniper cfg", "wa2000", "wa2000 cfg");
    self add_sub("sniper cfg", "l96a1", "l96a1 cfg");
    self add_sub("sniper cfg", "psg1", "psg1 cfg");

    self add_menu("dragunov cfg", "sniper cfg");
    self add_string("dragunov cfg", "sleight of hand", ::test, "off");
    self add_string("dragunov cfg", "slowmo", ::test, "1x");
    self add_string("dragunov cfg", "reload nac", ::test, "<>");
    self add_string("dragunov cfg", "reload type", ::test, "normal");
    self add_string("dragunov cfg", "adelia", ::test, "<>");

    self add_menu("wa2000 cfg", "sniper cfg");
    self add_string("wa2000 cfg", "sleight of hand", ::test, "off");
    self add_string("wa2000 cfg", "slowmo", ::test, "1x");
    self add_string("wa2000 cfg", "reload nac", ::test, "<>");
    self add_string("wa2000 cfg", "reload type", ::test, "normal");
    self add_string("wa2000 cfg", "adelia", ::test, "<>");

    self add_menu("l96a1 cfg", "sniper cfg");
    self add_string("l96a1 cfg", "sleight of hand", ::test, "off");
    self add_string("l96a1 cfg", "slowmo", ::test, "1x");
    self add_string("l96a1 cfg", "titty nac", ::test, "<>");
    self add_string("l96a1 cfg", "titty nac type", ::test, "normal");
    self add_string("l96a1 cfg", "ads titty nac", ::test, "off");
    self add_string("l96a1 cfg", "reload nac", ::test, "<>");
    self add_string("l96a1 cfg", "reload type", ::test, "normal");
    self add_string("l96a1 cfg", "fast reload timings", ::test, "off");
    self add_string("l96a1 cfg", "l96a1 adelia", ::test, "<>");

    self add_menu("psg1 cfg", "sniper cfg");
    self add_string("psg1 cfg", "sleight of hand", ::test, "off");
    self add_string("psg1 cfg", "slowmo", ::test, "1x");
    self add_string("psg1 cfg", "reload nac", ::test, "<>");
    self add_string("psg1 cfg", "reload type", ::test, "normal");
    self add_string("psg1 cfg", "adelia", ::test, "<>");

    self add_menu("pistol cfg", "cfg menu");
    self add_sub("pistol cfg", "asp", "asp cfg");
    self add_sub("pistol cfg", "m1911", "m1911 cfg");
    self add_sub("pistol cfg", "makarov", "makarov cfg");
    self add_sub("pistol cfg", "python", "python cfg");
    self add_sub("pistol cfg", "cz75", "cz75 cfg");

    self add_menu("asp cfg", "pistol cfg");
    self add_string("asp cfg", "sleight of hand", ::test, "off");
    self add_string("asp cfg", "slowmo", ::test, "1x");
    self add_string("asp cfg", "reload nac", ::test, "<>");
    self add_string("asp cfg", "reload type", ::test, "normal");
    self add_string("asp cfg", "adelia", ::test, "<>");

    self add_menu("m1911 cfg", "pistol cfg");
    self add_string("m1911 cfg", "sleight of hand", ::test, "off");
    self add_string("m1911 cfg", "slowmo", ::test, "1x");
    self add_string("m1911 cfg", "reload nac", ::test, "<>");
    self add_string("m1911 cfg", "reload type", ::test, "normal");
    self add_string("m1911 cfg", "adelia", ::test, "<>");

    self add_menu("makarov cfg", "pistol cfg");
    self add_string("makarov cfg", "sleight of hand", ::test, "off");
    self add_string("makarov cfg", "slowmo", ::test, "1x");
    self add_string("makarov cfg", "reload nac", ::test, "<>");
    self add_string("makarov cfg", "reload type", ::test, "normal");
    self add_string("makarov cfg", "adelia", ::test, "<>");

    self add_menu("python cfg", "pistol cfg");
    self add_string("python cfg", "sleight of hand", ::test, "off");
    self add_string("python cfg", "speed reloader", ::test, "off");
    self add_string("python cfg", "slowmo", ::test, "1x");
    self add_string("python cfg", "reload nac", ::test, "<>");
    self add_string("python cfg", "reload type", ::test, "normal");
    self add_string("python cfg", "adelia", ::test, "<>");

    self add_menu("cz75 cfg", "pistol cfg");
    self add_string("cz75 cfg", "sleight of hand", ::test, "off");
    self add_string("cz75 cfg", "slowmo", ::test, "1x");
    self add_string("cz75 cfg", "reload nac", ::test, "<>");
    self add_string("cz75 cfg", "reload type", ::test, "normal");
    self add_string("cz75 cfg", "adelia", ::test, "<>");

    self add_menu("launcher cfg", "cfg menu");
    self add_sub("launcher cfg", "m72 law", "m72 law cfg");
    self add_sub("launcher cfg", "rpg", "rpg cfg");
    self add_sub("launcher cfg", "strela-3", "strela cfg");
    self add_sub("launcher cfg", "china lake", "china lake cfg");

    self add_menu("m72 law cfg", "launcher cfg");
    self add_string("m72 law cfg", "sleight of hand", ::test, "off");
    self add_string("m72 law cfg", "slowmo", ::test, "1x");
    self add_string("m72 law cfg", "reload nac", ::test, "<>");
    self add_string("m72 law cfg", "reload type", ::test, "normal");
    self add_string("m72 law cfg", "adelia", ::test, "<>");

    self add_menu("rpg cfg", "launcher cfg");
    self add_string("rpg cfg", "sleight of hand", ::test, "off");
    self add_string("rpg cfg", "slowmo", ::test, "1x");
    self add_string("rpg cfg", "reload nac", ::test, "<>");
    self add_string("rpg cfg", "reload type", ::test, "normal");
    self add_string("rpg cfg", "adelia", ::test, "<>");

    self add_menu("strela cfg", "launcher cfg");
    self add_string("strela cfg", "sleight of hand", ::test, "off");
    self add_string("strela cfg", "slowmo", ::test, "1x");
    self add_string("strela cfg", "reload nac", ::test, "<>");
    self add_string("strela cfg", "reload type", ::test, "normal");
    self add_string("strela cfg", "adelia", ::test, "<>");

    self add_menu("china lake cfg", "launcher cfg");
    self add_string("china lake cfg", "sleight of hand", ::test, "off");
    self add_string("china lake cfg", "slowmo", ::test, "1x");
    self add_string("china lake cfg", "reload nac", ::test, "<>");
    self add_string("china lake cfg", "reload type", ::test, "normal");
    self add_string("china lake cfg", "adelia", ::test, "<>");

    self add_menu("special cfg", "cfg menu");
    self add_sub("special cfg", "ballistic knife", "ballistic knife cfg");
    self add_sub("special cfg", "crossbow", "crossbow cfg");

    self add_menu("ballistic knife cfg", "special cfg");
    self add_string("ballistic knife cfg", "sleight of hand", ::test, "off");
    self add_string("ballistic knife cfg", "slowmo", ::test, "1x");
    self add_string("ballistic knife cfg", "reload nac", ::test, "<>");
    self add_string("ballistic knife cfg", "reload type", ::test, "normal");
    self add_string("ballistic knife cfg", "adelia", ::test, "<>");

    self add_menu("crossbow cfg", "special cfg");
    self add_string("crossbow cfg", "sleight of hand", ::test, "off");
    self add_string("crossbow cfg", "slowmo", ::test, "1x");
    self add_string("crossbow cfg", "reload nac", ::test, "<>");
    self add_string("crossbow cfg", "reload type", ::test, "normal");
    self add_string("crossbow cfg", "adelia", ::test, "<>");

    self add_menu("extras cfg", "cfg menu");
    self add_sub("extras cfg", "masterkey", "masterkey cfg");
    self add_sub("extras cfg", "flame thrower", "flame thrower cfg");
    self add_sub("extras cfg", "grenade launcher", "grenade launcher cfg");

    self add_menu("masterkey cfg", "extras cfg");
    self add_string("masterkey cfg", "sleight of hand", ::test, "off");
    self add_string("masterkey cfg", "slowmo", ::test, "1x");
    self add_string("masterkey cfg", "reload nac", ::test, "<>");
    self add_string("masterkey cfg", "reload type", ::test, "normal");
    self add_string("masterkey cfg", "adelia", ::test, "<>");
    self add_string("masterkey cfg", "nac", ::test, "<>");
    self add_string("masterkey cfg", "nac type", ::test, "normal");

    self add_menu("flame thrower cfg", "extras cfg");
    self add_string("flame thrower cfg", "sleight of hand", ::test, "off");
    self add_string("flame thrower cfg", "slowmo", ::test, "1x");
    self add_string("flame thrower cfg", "reload nac", ::test, "<>");
    self add_string("flame thrower cfg", "reload type", ::test, "normal");
    self add_string("flame thrower cfg", "adelia", ::test, "<>");

    self add_menu("grenade launcher cfg", "extras cfg");
    self add_string("grenade launcher cfg", "sleight of hand", ::test, "off");
    self add_string("grenade launcher cfg", "slowmo", ::test, "1x");
    self add_string("grenade launcher cfg", "reload nac", ::test, "<>");
    self add_string("grenade launcher cfg", "reload type", ::test, "normal");
    self add_string("grenade launcher cfg", "adelia", ::test, "<>");

}

CFGinit()
{
    SetPersIfUni("cfgSoH", false);
    SetPersIfUni("cfgSlowMo", 1);
    SetPersIfUni("mp5kType", "normal"); 
    SetPersIfUni("mp5kJnacType", "normal"); 
    SetPersIfUni("mp5kRnac", 0);
    SetPersIfUni("mp5kJnac", 0);
    SetPersIfUni("mp5kAdelia", 0);
    SetPersIfUni("augType", "normal");
    SetPersIfUni("augJnacType", "normal");
    SetPersIfUni("augRnac", 0);
    SetPersIfUni("augAdelia", 0); 
    SetPersIfUni("augJnac", 0); 
    SetPersIfUni("augFast", false);
    self thread cfgWatch();
}

cfgWatch()
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        command = self waittill_any_return("dpad1", "dpad2", "dpad3", "dpad4");
        if(!self.menuOpen && isSubStr(command,self.pers["mp5kRnac"]))
            self thread mp5kReloadNac();
        if(!self.menuOpen && isSubStr(command,self.pers["mp5kAdelia"]))
            self thread mp5kAdeila();
        if(!self.menuOpen && isSubStr(command,self.pers["mp5kJnac"]))
            self thread mp5kJnac();
        if(!self.menuOpen && isSubStr(command,self.pers["augRnac"]))
            self thread augReloadNac();
        if(!self.menuOpen && isSubStr(command,self.pers["augAdelia"]))
            self thread augAdelia();
        if(!self.menuOpen && isSubStr(command,self.pers["augJnac"]))
            self thread augJnac();
    }
}

cfgCycle(var, bool)
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

SoHCheck()
{
    if(self.pers["cfgSoH"] == false)
    {
        self.pers["cfgSoH"] = !self.pers["cfgSoH"];
    }
    else if(self.pers["cfgSoH"] == true)  
    {
        self.pers["cfgSoH"] = !self.pers["cfgSoH"];
    }
}

SlowmoCheck()
{
    if(self.pers["cfgSlowMo"] == 1)
		self.pers["cfgSlowMo"] = 0.5;
	else if(self.pers["cfgSlowMo"] == 0.5) 
		self.pers["cfgSlowMo"] = 0.25;
    else
        self.pers["cfgSlowMo"] = 1;
}

mp5kNacTypeCheck()
{
    if(self.pers["mp5kType"] == "normal")
    {
        self.pers["mp5kType"] = "equipment";
    }
    else if(self.pers["mp5kType"] == "equipment")  
    {
        self.pers["mp5kType"] = "streak";
    }
    else if(self.pers["mp5kType"] == "streak")  
    {
        self.pers["mp5kType"] = "lethal";
    }
    else if(self.pers["mp5kType"] == "lethal")  
    {
        self.pers["mp5kType"] = "tactical";
    }
    else if(self.pers["mp5kType"] == "tactical")  
    {
        self.pers["mp5kType"] = "normal";
    }
}

mp5kJnacCheck()
{
    if(self.pers["mp5kJnacType"] == "normal")
    {
        self.pers["mp5kJnacType"] = "equipment";
    }
    else if(self.pers["mp5kJnacType"] == "equipment")  
    {
        self.pers["mp5kJnacType"] = "streak";
    }
    else if(self.pers["mp5kJnacType"] == "streak")  
    {
        self.pers["mp5kJnacType"] = "lethal";
    }
    else if(self.pers["mp5kJnacType"] == "lethal")  
    {
        self.pers["mp5kJnacType"] = "tactical";
    }
    else if(self.pers["mp5kJnacType"] == "tactical")  
    {
        self.pers["mp5kJnacType"] = "normal";
    }
}

mp5kReloadNac()
{
    if(self.pers["mp5kType"] == "normal")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 249; // soh false slowmo 1 DONE
        self.waitTimes[0][1] = 124; // soh true slowmo 1 DONE
        self.waitTimes[1][0] = 498; // soh false slowmo 0.5 DONE
        self.waitTimes[1][1] = 249; // soh true slowmo 0.5 DONE
        self.waitTimes[2][0] = 998; // soh false slowmo 0.25 DONE
        self.waitTimes[2][1] = 498; // soh true slowmo 0.25 DONE
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";weapnext");
        
    }
    else if(self.pers["mp5kType"] == "equipment")  
    {
       slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 249; // soh false slowmo 1
        self.waitTimes[0][1] = 124; // soh true slowmo 1
        self.waitTimes[1][0] = 498; // soh false slowmo 0.5
        self.waitTimes[1][1] = 249; // soh true slowmo 0.5
        self.waitTimes[2][0] = 998; // soh false slowmo 0.25
        self.waitTimes[2][1] = 498; // soh true slowmo 0.25
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 1;");
    }
    else if(self.pers["mp5kType"] == "streak")  
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 249; // soh false slowmo 1
        self.waitTimes[0][1] = 124; // soh true slowmo 1
        self.waitTimes[1][0] = 498; // soh false slowmo 0.5
        self.waitTimes[1][1] = 249; // soh true slowmo 0.5
        self.waitTimes[2][0] = 998; // soh false slowmo 0.25
        self.waitTimes[2][1] = 498; // soh true slowmo 0.25
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 4;");
    }
    else if(self.pers["mp5kType"] == "lethal")  
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 251; // soh false slowmo 1
        self.waitTimes[0][1] = 126; // soh true slowmo 1
        self.waitTimes[0][2] = 60; // soh true slowmo 1 semtex cancel
        self.waitTimes[1][0] = 500; // soh false slowmo 0.5
        self.waitTimes[1][1] = 251; // soh true slowmo 0.5
        self.waitTimes[1][2] = 120; // soh true slowmo 0.5 semtex cancel
        self.waitTimes[2][0] = 1000; // soh false slowmo 0.25
        self.waitTimes[2][1] = 500; // soh true slowmo 0.25
        self.waitTimes[2][2] = 240; // soh true slowmo 0.25 semtex cancel
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+frag;-frag;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;");
    }
    else if(self.pers["mp5kType"] == "tactical")  
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 251; // soh false slowmo 1
        self.waitTimes[0][1] = 126; // soh true slowmo 1
        self.waitTimes[1][0] = 500; // soh false slowmo 0.5
        self.waitTimes[1][1] = 251; // soh true slowmo 0.5
        self.waitTimes[2][0] = 1000; // soh false slowmo 0.25
        self.waitTimes[2][1] = 500; // soh true slowmo 0.25
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+smoke;-smoke;");
    }
}

mp5kAdeila()
{
    slowMo = self.pers["cfgSlowMo"];
    soh = self.pers["cfgSoH"];
    slowMoIndex = 0;

    if(self.pers["cfgSlowMo"] == 1)
        slowMoIndex = 0;
    else if(self.pers["cfgSlowMo"] == 0.5)
        slowMoIndex = 1;
    else if(self.pers["cfgSlowMo"] == 0.25)
        slowMoIndex = 2;
    else
        return;

    self.waitTimes = [];
    self.waitTimes[0][0] = 251; // soh false slowmo 1
    self.waitTimes[0][1] = 126; // soh true slowmo 1
    self.waitTimes[1][0] = 500; // soh false slowmo 0.5
    self.waitTimes[1][1] = 251; // soh true slowmo 0.5
    self.waitTimes[2][0] = 1000; // soh false slowmo 0.25
    self.waitTimes[2][1] = 500; // soh true slowmo 0.25
    cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+forward;+breath_sprint;wait 20;-breath_sprint;-forward;");
}

mp5kJnac()
{
    if(self.pers["mp5kJnacType"] == "normal")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 250; // soh false slowmo 1 DONE
        self.waitTimes[0][1] = 126; // soh true slowmo 1 DONE
        self.waitTimes[0][2] = 100; // slowmo wait time
        self.waitTimes[1][0] = 500; // soh false slowmo 0.5 DONE
        self.waitTimes[1][1] = 250; // soh true slowmo 0.5 DONE
        self.waitTimes[1][2] = 150; // slowmo wait time
        self.waitTimes[2][0] = 1000; // soh false slowmo 0.25 DONE
        self.waitTimes[2][1] = 500; // soh true slowmo 0.25 DONE
        self.waitTimes[2][2] = 200; // slowmo wait time
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";weapnext;");
        
    }
    else if(self.pers["mp5kJnacType"] == "equipment")  
    {
       slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 250; // soh false slowmo 1 DONE
        self.waitTimes[0][1] = 126; // soh true slowmo 1 DONE
        self.waitTimes[0][2] = 100; // slowmo wait time
        self.waitTimes[1][0] = 500; // soh false slowmo 0.5 DONE
        self.waitTimes[1][1] = 250; // soh true slowmo 0.5 DONE
        self.waitTimes[1][2] = 150; // slowmo wait time
        self.waitTimes[2][0] = 1000; // soh false slowmo 0.25 DONE
        self.waitTimes[2][1] = 500; // soh true slowmo 0.25 DONE
        self.waitTimes[2][2] = 200; // slowmo wait time
        
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 1;");
    }
    else if(self.pers["mp5kJnacType"] == "streak")  
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 250; // soh false slowmo 1 DONE
        self.waitTimes[0][1] = 126; // soh true slowmo 1 DONE
        self.waitTimes[0][2] = 100; // slowmo wait time
        self.waitTimes[1][0] = 500; // soh false slowmo 0.5 DONE
        self.waitTimes[1][1] = 250; // soh true slowmo 0.5 DONE
        self.waitTimes[1][2] = 150; // slowmo wait time
        self.waitTimes[2][0] = 1000; // soh false slowmo 0.25 DONE
        self.waitTimes[2][1] = 500; // soh true slowmo 0.25 DONE
        self.waitTimes[2][2] = 200; // slowmo wait time
        
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 4;");
    }
    else if(self.pers["mp5kJnacType"] == "lethal")  
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 252; // soh false slowmo 1
        self.waitTimes[0][1] = 128; // soh true slowmo 1
        self.waitTimes[0][2] = 60; // soh true slowmo 1 semtex cancel
        self.waitTimes[0][3] = 100; // slowmo wait time
        self.waitTimes[1][0] = 501; // soh false slowmo 0.5
        self.waitTimes[1][1] = 252; // soh true slowmo 0.5
        self.waitTimes[1][2] = 120; // soh true slowmo 0.5 semtex cancel
        self.waitTimes[1][3] = 150; // slowmo wait time
        self.waitTimes[2][0] = 1001; // soh false slowmo 0.25
        self.waitTimes[2][1] = 502; // soh true slowmo 0.25
        self.waitTimes[2][2] = 240; // soh true slowmo 0.25 semtex cancel
        self.waitTimes[2][3] = 200; // slowmo wait time
        
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][3] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+frag;-frag;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;");
    }
    else if(self.pers["mp5kJnacType"] == "tactical")  
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 252; // soh false slowmo 1 DONE
        self.waitTimes[0][1] = 128; // soh true slowmo 1 DONE
        self.waitTimes[0][2] = 100; // slowmo wait time
        self.waitTimes[1][0] = 502; // soh false slowmo 0.5 DONE
        self.waitTimes[1][1] = 252; // soh true slowmo 0.5 DONE
        self.waitTimes[1][2] = 150; // slowmo wait time
        self.waitTimes[2][0] = 1002; // soh false slowmo 0.25 DONE
        self.waitTimes[2][1] = 502; // soh true slowmo 0.25 DONE
        self.waitTimes[2][2] = 200; // slowmo wait time
        
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+smoke;-smoke;");
    }
}

augReloadNac()
{
    if(self.pers["augType"] == "normal")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 237; // soh false slowmo 1
            self.waitTimes[0][1] = 118; // soh true slowmo 1
            self.waitTimes[1][0] = 474; // soh false slowmo 0.5
            self.waitTimes[1][1] = 237; // soh true slowmo 0.5
            self.waitTimes[2][0] = 948; // soh false slowmo 0.25
            self.waitTimes[2][1] = 474; // soh true slowmo 0.25
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 112; // soh false slowmo 1
            self.waitTimes[0][1] = 56; // soh true slowmo 1
            self.waitTimes[1][0] = 224; // soh false slowmo 0.5
            self.waitTimes[1][1] = 112; // soh true slowmo 0.5
            self.waitTimes[2][0] = 448; // soh false slowmo 0.25
            self.waitTimes[2][1] = 224; // soh true slowmo 0.25
        }
            cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";weapnext");
    }
    if(self.pers["augType"] == "equipment")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 237; // soh false slowmo 1
            self.waitTimes[0][1] = 118; // soh true slowmo 1
            self.waitTimes[1][0] = 474; // soh false slowmo 0.5
            self.waitTimes[1][1] = 237; // soh true slowmo 0.5
            self.waitTimes[2][0] = 948; // soh false slowmo 0.25
            self.waitTimes[2][1] = 474; // soh true slowmo 0.25
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 112; // soh false slowmo 1
            self.waitTimes[0][1] = 56; // soh true slowmo 1
            self.waitTimes[1][0] = 224; // soh false slowmo 0.5
            self.waitTimes[1][1] = 112; // soh true slowmo 0.5
            self.waitTimes[2][0] = 448; // soh false slowmo 0.25
            self.waitTimes[2][1] = 224; // soh true slowmo 0.25
        }
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 1;");
    }
    if(self.pers["augType"] == "streak")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 237; // soh false slowmo 1
            self.waitTimes[0][1] = 118; // soh true slowmo 1
            self.waitTimes[1][0] = 474; // soh false slowmo 0.5
            self.waitTimes[1][1] = 237; // soh true slowmo 0.5
            self.waitTimes[2][0] = 948; // soh false slowmo 0.25
            self.waitTimes[2][1] = 474; // soh true slowmo 0.25
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 112; // soh false slowmo 1
            self.waitTimes[0][1] = 56; // soh true slowmo 1
            self.waitTimes[1][0] = 224; // soh false slowmo 0.5
            self.waitTimes[1][1] = 112; // soh true slowmo 0.5
            self.waitTimes[2][0] = 448; // soh false slowmo 0.25
            self.waitTimes[2][1] = 224; // soh true slowmo 0.25
        }
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 4;");
    }
    if(self.pers["augType"] == "lethal")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 239; // soh false slowmo 1
            self.waitTimes[0][1] = 120; // soh true slowmo 1
            self.waitTimes[0][2] = 60; // slowmo 1 semtex cancel
            self.waitTimes[1][0] = 476; // soh false slowmo 0.5
            self.waitTimes[1][1] = 239; // soh true slowmo 0.5
            self.waitTimes[1][2] = 120; // slowmo 0.5 semtex cancel
            self.waitTimes[2][0] = 950; // soh false slowmo 0.25
            self.waitTimes[2][1] = 476; // soh true slowmo 0.25
            self.waitTimes[2][2] = 240; // slowmo 0.25 semtex cancel
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 114; // soh false slowmo 1
            self.waitTimes[0][1] = 58; // soh true slowmo 1
            self.waitTimes[0][2] = 60; // slowmo 1 semtex cancel
            self.waitTimes[1][0] = 226; // soh false slowmo 0.5
            self.waitTimes[1][1] = 114; // soh true slowmo 0.5
            self.waitTimes[1][2] = 120; // slowmo 0.5 semtex cancel
            self.waitTimes[2][0] = 450; // soh false slowmo 0.25
            self.waitTimes[2][1] = 226; // soh true slowmo 0.25
            self.waitTimes[2][2] = 240; // slowmo 0.25 semtex cancel
        }
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+frag;-frag;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;");
    }
    if(self.pers["augType"] == "tactical")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 239; // soh false slowmo 1
            self.waitTimes[0][1] = 120; // soh true slowmo 1
            self.waitTimes[0][2] = 60; // slowmo 1 semtex cancel
            self.waitTimes[1][0] = 476; // soh false slowmo 0.5
            self.waitTimes[1][1] = 239; // soh true slowmo 0.5
            self.waitTimes[1][2] = 120; // slowmo 0.5 semtex cancel
            self.waitTimes[2][0] = 950; // soh false slowmo 0.25
            self.waitTimes[2][1] = 476; // soh true slowmo 0.25
            self.waitTimes[2][2] = 240; // slowmo 0.25 semtex cancel
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 114; // soh false slowmo 1
            self.waitTimes[0][1] = 58; // soh true slowmo 1
            self.waitTimes[1][0] = 226; // soh false slowmo 0.5
            self.waitTimes[1][1] = 114; // soh true slowmo 0.5
            self.waitTimes[2][0] = 450; // soh false slowmo 0.25
            self.waitTimes[2][1] = 226; // soh true slowmo 0.25
        }
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+smoke;-smoke;");
    }
} 

augAdelia()
{
    if(self.pers["augFast"] == false)
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 239; // soh false slowmo 1
        self.waitTimes[0][1] = 120; // soh true slowmo 1
        self.waitTimes[0][2] = 20; // adelia slowmo 1
        self.waitTimes[1][0] = 476; // soh false slowmo 0.5
        self.waitTimes[1][1] = 239; // soh true slowmo 0.5
        self.waitTimes[1][2] = 40; // adelia slowmo 0.5
        self.waitTimes[2][0] = 950; // soh false slowmo 0.25
        self.waitTimes[2][1] = 476; // soh true slowmo 0.25
        self.waitTimes[2][2] = 60; // adelia slowmo 0.25
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+forward;+breath_sprint;wait " + self.waitTimes[slowMoIndex][2] + ";-breath_sprint;-forward;");
    }
    else if(self.pers["augFast"] == true)
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;

        self.waitTimes = [];
        self.waitTimes[0][0] = 114; // soh false slowmo 1
        self.waitTimes[0][1] = 58; // soh true slowmo 1
        self.waitTimes[0][2] = 20; // adelia slowmo 1
        self.waitTimes[1][0] = 226; // soh false slowmo 0.5
        self.waitTimes[1][1] = 114; // soh true slowmo 0.5
        self.waitTimes[1][2] = 40; // adelia slowmo 0.5
        self.waitTimes[2][0] = 450; // soh false slowmo 0.25
        self.waitTimes[2][1] = 226; // soh true slowmo 0.25
        self.waitTimes[2][2] = 60; // adelia slowmo 0.25
        
        cmdexec("+reload;-reload;wait " + self.waitTimes[slowMoIndex][soh] + ";+forward;+breath_sprint;wait " + self.waitTimes[slowMoIndex][2] + ";-breath_sprint;-forward;");
    }
}

augJnac()
{
    if(self.pers["augJnacType"] == "normal")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 239; // soh false slowmo 1
            self.waitTimes[0][1] = 120; // soh true slowmo 1
            self.waitTimes[0][2] = 100; // slowmo wait time
            self.waitTimes[1][0] = 476; // soh false slowmo 0.5
            self.waitTimes[1][1] = 239; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 950; // soh false slowmo 0.25
            self.waitTimes[2][1] = 476; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 114; // soh false slowmo 1
            self.waitTimes[0][1] = 58; // soh true slowmo 1
            self.waitTimes[0][2] = 50; // slowmo wait time
            self.waitTimes[1][0] = 226; // soh false slowmo 0.5
            self.waitTimes[1][1] = 114; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 450; // soh false slowmo 0.25
            self.waitTimes[2][1] = 226; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
            cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";weapnext;");
    }
    if(self.pers["augJnacType"] == "equipment")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 239; // soh false slowmo 1
            self.waitTimes[0][1] = 120; // soh true slowmo 1
            self.waitTimes[0][2] = 100; // slowmo wait time
            self.waitTimes[1][0] = 476; // soh false slowmo 0.5
            self.waitTimes[1][1] = 239; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 950; // soh false slowmo 0.25
            self.waitTimes[2][1] = 476; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 114; // soh false slowmo 1
            self.waitTimes[0][1] = 58; // soh true slowmo 1
            self.waitTimes[0][2] = 50; // slowmo wait time
            self.waitTimes[1][0] = 226; // soh false slowmo 0.5
            self.waitTimes[1][1] = 114; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 450; // soh false slowmo 0.25
            self.waitTimes[2][1] = 226; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 1;");
    }
    if(self.pers["augJnacType"] == "streak")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 239; // soh false slowmo 1
            self.waitTimes[0][1] = 120; // soh true slowmo 1
            self.waitTimes[0][2] = 100; // slowmo wait time
            self.waitTimes[1][0] = 476; // soh false slowmo 0.5
            self.waitTimes[1][1] = 239; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 950; // soh false slowmo 0.25
            self.waitTimes[2][1] = 476; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 114; // soh false slowmo 1
            self.waitTimes[0][1] = 58; // soh true slowmo 1
            self.waitTimes[0][2] = 50; // slowmo wait time
            self.waitTimes[1][0] = 226; // soh false slowmo 0.5
            self.waitTimes[1][1] = 114; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 450; // soh false slowmo 0.25
            self.waitTimes[2][1] = 226; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+actionslot 4;");
    }
    if(self.pers["augJnacType"] == "lethal")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 241; // soh false slowmo 1
            self.waitTimes[0][1] = 122; // soh true slowmo 1
            self.waitTimes[0][2] = 60; // soh true slowmo 1 semtex cancel
            self.waitTimes[0][3] = 100; // slowmo wait time
            self.waitTimes[1][0] = 478; // soh false slowmo 0.5
            self.waitTimes[1][1] = 241; // soh true slowmo 0.5
            self.waitTimes[1][2] = 120; // soh true slowmo 0.5 semtex cancel
            self.waitTimes[1][3] = 150; // slowmo wait time
            self.waitTimes[2][0] = 952; // soh false slowmo 0.25
            self.waitTimes[2][1] = 478; // soh true slowmo 0.25
            self.waitTimes[2][2] = 240; // soh true slowmo 0.25 semtex cancel
            self.waitTimes[2][3] = 200; // slowmo wait time
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 116; // soh false slowmo 1
            self.waitTimes[0][1] = 60; // soh true slowmo 1
            self.waitTimes[0][2] = 60; // slowmo semtex cancel
            self.waitTimes[0][3] = 50; // slowmo wait time
            self.waitTimes[1][0] = 228; // soh false slowmo 0.5
            self.waitTimes[1][1] = 116; // soh true slowmo 0.5
            self.waitTimes[1][2] = 120; // slowmo semtex cancel
            self.waitTimes[1][3] = 150; // slowmo wait time
            self.waitTimes[2][0] = 452; // soh false slowmo 0.25
            self.waitTimes[2][1] = 228; // soh true slowmo 0.25
            self.waitTimes[2][2] = 240; // slowmo semtex cancel
            self.waitTimes[2][3] = 200; // slowmo wait time
        }
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][3] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+frag;-frag;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;");
    }
    if(self.pers["augJnacType"] == "tactical")
    {
        slowMo = self.pers["cfgSlowMo"];
        soh = self.pers["cfgSoH"];
        slowMoIndex = 0;

        if(self.pers["cfgSlowMo"] == 1)
            slowMoIndex = 0;
        else if(self.pers["cfgSlowMo"] == 0.5)
            slowMoIndex = 1;
        else if(self.pers["cfgSlowMo"] == 0.25)
            slowMoIndex = 2;
        else
            return;
        if(self.pers["augFast"] == false)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 241; // soh false slowmo 1
            self.waitTimes[0][1] = 122; // soh true slowmo 1
            self.waitTimes[0][2] = 100; // slowmo wait time
            self.waitTimes[1][0] = 478; // soh false slowmo 0.5
            self.waitTimes[1][1] = 241; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 952; // soh false slowmo 0.25
            self.waitTimes[2][1] = 478; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        else if(self.pers["augFast"] == true)
        {
            self.waitTimes = [];
            self.waitTimes[0][0] = 116; // soh false slowmo 1
            self.waitTimes[0][1] = 60; // soh true slowmo 1
            self.waitTimes[0][2] = 50; // slowmo wait time
            self.waitTimes[1][0] = 228; // soh false slowmo 0.5
            self.waitTimes[1][1] = 116; // soh true slowmo 0.5
            self.waitTimes[1][2] = 150; // slowmo wait time
            self.waitTimes[2][0] = 452; // soh false slowmo 0.25
            self.waitTimes[2][1] = 228; // soh true slowmo 0.25
            self.waitTimes[2][2] = 200; // slowmo wait time
        }
        cmdexec("weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][2] + ";weapnext;wait 2;weapnext;wait " + self.waitTimes[slowMoIndex][soh] + ";+smoke;-smoke;");
    }
}

augFastCheck()
{
    if(self.pers["augFast"] == false)
    {
        self.pers["augFast"] = !self.pers["augFast"];
    }
    else if(self.pers["augFast"] == true)  
    {
        self.pers["augFast"] = !self.pers["augFast"];
    }
}

augNacTypeCheck()
{
    if(self.pers["augType"] == "normal")
    {
        self.pers["augType"] = "equipment";
    }
    else if(self.pers["augType"] == "equipment")  
    {
        self.pers["augType"] = "streak";
    }
    else if(self.pers["augType"] == "streak")  
    {
        self.pers["augType"] = "lethal";
    }
    else if(self.pers["augType"] == "lethal")  
    {
        self.pers["augType"] = "tactical";
    }
    else if(self.pers["augType"] == "tactical")  
    {
        self.pers["augType"] = "normal";
    }
}

augJnacCheck()
{
    if(self.pers["augJnacType"] == "normal")
    {
        self.pers["augJnacType"] = "equipment";
    }
    else if(self.pers["augJnacType"] == "equipment")  
    {
        self.pers["augJnacType"] = "streak";
    }
    else if(self.pers["augJnacType"] == "streak")  
    {
        self.pers["augJnacType"] = "lethal";
    }
    else if(self.pers["augJnacType"] == "lethal")  
    {
        self.pers["augJnacType"] = "tactical";
    }
    else if(self.pers["augJnacType"] == "tactical")  
    {
        self.pers["augJnacType"] = "normal";
    }
}

*/ 


