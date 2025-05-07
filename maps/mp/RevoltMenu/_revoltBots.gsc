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
    wait 0.2;
    bot setRank(49,13);
}

spawnFriendlyBot()
{
    team = self.pers["team"];
    bot = addtestclient();
    bot.pers["isBot"] = true;
    bot thread maps\mp\gametypes\_bot::bot_spawn_think( team );
    wait 0.2;
    bot setRank(49,13);
}

freezeAllBots()
{
    if(self.frozenbots == 0)
    {
        players = level.players;
        for ( i = 0; i < players.size; i++ )
        {   
            player = players[i];
            if(IsDefined(player.pers[ "isBot" ]) && player.pers["isBot"])
            {
                player freezeControls(true);
            }
            self.frozenbots = 1;
            wait .025;
        }
        self iprintln("bots ^?Frozen");
    }
    else
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
        self.frozenbots = 0;
        self iprintln("bots ^?unfrozen");
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
