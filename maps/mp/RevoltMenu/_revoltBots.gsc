#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\RevoltMenu\_revoltStructure;
#include maps\mp\RevoltMenu\_revoltFuncs;
#include maps\mp\gametypes\_clientids;

spawnEnemyBot()
{
    team = self.pers["team"];
    bot = addtestclient();
    bot.pers["isBot"] = true;
    bot thread maps\mp\gametypes\_bot::bot_spawn_think(getOtherTeam(team));
    bot thread modelcfgtest();
    wait 0.2;
    bot setRank(49,15);
    wait 0.6;
    bot takeAllWeapons();
    bot giveweapon("rottweil72_mp");
    bot switchToWeapon("rottweil72_mp");
    bot.CurStance = "standing";

}

spawnFriendlyBot()
{
    team = self.pers["team"];
    bot = addtestclient();
    bot.pers["isBot"] = true;
    bot thread maps\mp\gametypes\_bot::bot_spawn_think( team );
    bot thread modelcfgtest();
    wait 0.2;
    bot setRank(49,15);
    wait 0.6;
    bot takeAllWeapons();
    bot giveweapon("rottweil72_mp");
    bot switchToWeapon("rottweil72_mp");
    bot.CurStance = "standing";
}

freezeAllBots()
{
    if(self.pers["frozenbots"] == false)
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(IsDefined(player.pers[ "isBot" ]) && player.pers["isBot"])
            {
                player freezeControls(true);
            }
            self.pers["frozenbots"] = !self.pers["frozenbots"];
            wait .025;
        }
        self iprintln("bots ^?frozen");
    }
    else if(self.pers["frozenbots"] == true)
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(IsDefined(player.pers[ "isBot" ]) && player.pers["isBot"])
            {
                player freezeControls(false);
            }
        }
        self.pers["frozenbots"] = !self.pers["frozenbots"];
    }
}

TeleportAllBots()
{
    players = level.players;
    for ( i = 0; i < players.size; i++ )
    {   
        player = players[i];
        if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
        {
            player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);

        }
    }
}

BotSpawns()
{
    self endon ("disconnect");
    players = level.players;
    for ( i = 0; i < players.size; i++ )
    {
        player = players[i];
        if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
        {
            player.pers["savedLocation"] = player.origin;
            player.pers["savedAngles"] = player.angles;
            self iprintln("bot location saved ^?" + player.pers["savedLocation"]);
        }
    }
}

kickAllBots()
{
    players = level.players;
    for ( i = 0; i < players.size; i++ )
    {
        player = players[i];    
        if(IsDefined(player.pers[ "isBot" ]) && player.pers["isBot"])
        {   
            kick( player getEntityNumber());
        }
    }  
}

MakeAllBotsLookAtYou()
{
    players = level.players;
    for ( i = 0; i < players.size; i++ )
    {   
        player = players[i];
        if(isDefined(player.pers["isBot"]) && player.pers["isBot"])
        {
            player setplayerangles(VectorToAngles((self.origin + (0,0,30)) - (player getTagOrigin("j_head"))));

        }
    }
}

BotChangeStance()
{
    if(self.pers["BotStanceStr"] == "standing")
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
            {
                player setstance("crouch");
            }
        }
        self.pers["BotStanceStr"] = "crouch";
    }
    else if(self.pers["BotStanceStr"] == "crouch")
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
            {
                player setstance("prone");
            }
        }
        self.pers["BotStanceStr"] = "prone";
    }
    else if(self.pers["BotStanceStr"] == "prone")
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
            {
                player setstance("stand");
            }
        }
        self.pers["BotStanceStr"] = "standing";
    }
}

GetBotLocation()
{
    players = level.players;
    for ( i = 0; i < players.size; i++ )
    {
        player = players[i];
        if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
        {
            self iPrintLn("^1" + player getOrigin());
        }
    }
}


modelcfgtest()
{
    // Ensure team is defined; default to "allies" if undefined
    if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
    {
        self.pers["team"] = "allies";
        self.team = "allies"; // Sync team properties
    }
    // Set body type
    self.cac_body_type = "standard_mp";
    // Apply faction-specific model adjustments
    if(isDefined(game["cac_faction_allies"]) && game["cac_faction_allies"] == "cub_rebels" && self.pers["team"] == "allies")
    {
        self.cac_body_type = "standard_mp"; // Use a different model for cub_rebels
    }
    // Set head and hat
    self.cac_head_type = self maps\mp\gametypes\_armor::get_default_head();
    self.cac_hat_type = "none";
    // Calculate and apply render options (minimized for performance)
    playerRenderOptions = self calcPlayerOptions(1, 1);
    self SetPlayerRenderOptions(int(playerRenderOptions));
    // Apply model
    self maps\mp\gametypes\_armor::set_player_model();
    // Keep print text as requested
    //self iprintln("changed");
}

telePlayer(player)
{
    player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
}

revivePlayer(player)
{
    if (!isAlive(player))
    {
        if (!isDefined(player.pers["class"]))
        {
            player.pers["class"] = "CLASS_CUSTOM1";
            player.class = player.pers["class"];
            player maps\mp\gametypes\_class::setClass(player.pers["class"]);
        }
        
        if (player.hasSpawned)
        {
            player.pers["lives"]++;
        }
        else 
        {
            player.hasSpawned = true;
        }

        if (player.sessionstate != "playing")
        {
            player.sessionstate = "playing";
        }
        
        player thread [[level.spawnClient]]();
        player thread modelcfgtest();
        self iprintln(player.name + " ^?revived");
        wait 0.3;
        player takeAllWeapons();
        player giveweapon("rottweil72_mp");
        player switchToWeapon("rottweil72_mp");
        player.CurStance = "standing";
    }
}

freezeClient(player)
{
    if(!isDefined(self.ClientFrozen))
    {
        player freezeControls(true);
        self iprintln(player.name + " ^?frozen");
        self.ClientFrozen = true;
    }
    else if(self.ClientFrozen == true)
    {
        player freezeControls(false);
        self iprintln(player.name + " ^?unfrozen");
        self.ClientFrozen = undefined;
    }
    
}

SpawnSavePlayer(player)
{
    player.pers["savedLocation"] = player.origin;
    player.pers["savedAngles"] = player.angles;
    self iprintln("bot location saved ^?" + player.pers["savedLocation"]);
}

CyclePlayerStance(player)
{
    if(player.CurStance == "standing")
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
            {
                player setstance("crouch");
            }
        }
        player.CurStance = "crouch";
    }
    else if(player.CurStance == "crouch")
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
            {
                player setstance("prone");
            }
        }
        player.CurStance = "prone";
    }
    else if(player.CurStance == "prone")
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
            {
                player setstance("stand");
            }
        }
        player.CurStance = "standing";
    }
}

movePlayerN(player)
{
    NewOrigin = player.origin + (0,1,0);
    player setorigin(NewOrigin);
}

movePlayerS(player)
{
    NewOrigin = player.origin + (0,-1,0);
    player setorigin(NewOrigin);
}

movePlayerE(player)
{
    NewOrigin = player.origin + (1,0,0);
    player setorigin(NewOrigin);
}

movePlayerW(player)
{
    NewOrigin = player.origin + (-1,0,0);
    player setorigin(NewOrigin);
}

killPlayer(player)
{
    player suicide();
}

kickPlayer(player)
{
    kick( player getEntityNumber());
}

/*botalwayslookinnoteam(t)
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
    else if (t == "team")
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
*/

/*botLookAtEnemies()
{
    if (self.pers["bot_noteam_looking"] == false)
    {
        self.pers["bot_noteam_looking"] = !self.pers["bot_noteam_looking"];
        team = self.pers["team"];
        players = level.players;
        
        for (i = 0; i < players.size; i++)
        {
            player = players[i];
            if (isDefined(player.pers["isBot"]) && player.pers["isBot"] && player.pers["team"] != team)
            {
                while (self.pers["bot_noteam_looking"] == 1)
                {
                    newang = VectorToAngles((self.origin + (0,0,30)) - (player getTagOrigin("j_head")));
                    player setplayerangles(newang);
                    player savebotpos(player, newang);
                    wait 0.05;
                }
            }
        }
    }
    else if ( self.pers["bot_noteam_looking"] == true)
    {
        self.pers["bot_noteam_looking"] = !self.pers["bot_noteam_looking"];
    }
}

botLookAtFriendlies()
{
    if (self.pers["bot_team_looking"] == 0)
    {
        self.pers["bot_team_looking"] = 1;
        team = self.pers["team"];
        players = level.players;
        
        for (i = 0; i < players.size; i++)
        {
            player = players[i];
            if (isDefined(player.pers["isBot"]) && player.pers["isBot"] && player.pers["team"] == team)
            {
                while (self.pers["bot_team_looking"] == 1)
                {
                    newang = VectorToAngles((self.origin + (0,0,30)) - (player getTagOrigin("j_head")));
                    player setplayerangles(newang);
                    player savebotpos(player, newang);
                    wait 0.05;
                }
            }
        }
    }
    else
    {
        self.pers["bot_team_looking"] = 0;
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

savebotpos(player, angles, both)
{
    if(!isDefined(angles))
        player.pers["botLocation"] = player getOrigin(); 
    else if(isDefined(angles))
        player.pers["location_angles"] = angles;
    else
    {
        player.pers["location_angles"] = angles;
        player.pers["botLocation"] = player getOrigin(); 

    }    
} */