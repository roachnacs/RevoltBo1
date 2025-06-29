#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

weaponNameToNumber(weaponName)
{
    weaponNameLower = toLower(weaponName);
	switch (weaponNameLower)
    {
        //MP
        case "mp5k":
            return 15;
        case "skorpion":
            return 18;
        case "mac11":
            return 14;
        case "ak74u":
            return 12;
        case "uzi":
            return 20;
        case "pm63":
            return 17;
        case "mpl":
            return 16;
        case "spectre":
            return 19;
        case "kiparis":
            return 13;
        //AR
        case "m16":
            return 35;
        case "enfield":
            return 29;
        case "m14":
            return 34;
        case "famas":
            return 30;
        case "galil":
            return 33;
        case "aug":
            return 27;
        case "fnfal":
            return 31;
        case "ak47":
            return 26;
        case "commando":
            return 28;
        case "g11":
            return 32;
        //Shotgun
        case "rottweil72":
            return 49;
        case "ithaca":
            return 48;
        case "spas":
            return 50;
        case "hs10":
            return 47;
        //LMG
        case "hk21":
            return 37;
        case "rpk":
            return 39;
        case "m60":
            return 38;
        case "stoner63":
            return 40;
        //Sniper
        case "dragunov":
            return 42;
        case "wa2000":
            return 45;
        case "l96a1":
            return 43;
        case "psg1":
            return 44;
        //Pistol
        case "asp":
            return 1;
        case "m1911":
            return 3;
        case "makarov":
            return 4;
        case "python":
            return 5;
        case "cz75":
            return 2;
        //Launcher
        case "m72_law":
            return 53;
        case "rpg":
            return 54;
        case "strela":
            return 55;
        case "china_lake":
            return 57;
        //Special
        case "crossbow_explosive":
            return 56;
        default:
            return 0;
    }
}

givePlayerAttachment(attachment) // shoutout century i aint doing all that
{
    weapon = self GetCurrentWeapon();

    opticAttach = "";
    underBarrelAttach = "";
    clipAttach = "";
	attachmentAttach = "";

    opticWeap = "";
    underBarrelWeap = "";
    clipWeap = "";
	attachmentWeap = "";

	weaponToArray = strTok(weapon, "_");
	for (i = 0; i < weaponToArray.size; i++)
	{
		if (isAttachmentOptic(weaponToArray[i]))
		{
			opticAttach = weaponToArray[i];
		}

		if (isAttachmentUnderBarrel(weaponToArray[i]))
		{
			underBarrelAttach = weaponToArray[i];
		}

		if (isAttachmentClip(weaponToArray[i]))
		{
			clipAttach = weaponToArray[i];
		}

        if (weaponToArray[i] != "mp" && !isAttachmentClip(weaponToArray[i]) && !isAttachmentUnderBarrel(weaponToArray[i]) && !isAttachmentOptic(weaponToArray[i]) && weaponToArray[i] != weaponToArray[0])
        {
            attachmentWeap = weaponToArray[i];
        }
	}

	baseWeapon = weaponToArray[0];
	number = weaponNameToNumber(baseWeapon);

	itemRow = tableLookupRowNum("mp/statsTable.csv", level.cac_numbering, number);
	compatibleAttachments = tableLookupColumnForRow("mp/statstable.csv", itemRow, level.cac_cstring);
	if (!isSubStr(compatibleAttachments, attachment))
	{
		return;
	}

	if (attachmentWeap == attachment)
	{
		return;
	}

	if (isSubStr(baseWeapon, "dw"))
	{
		baseWeapon = getSubStr(baseWeapon, 0, baseWeapon.size - 2);
	}

	if (isSubStr(attachment, "dw"))
	{
		newWeapon = baseWeapon + "dw_mp";

		if (isDefined(self.camo))
		{
			weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
		}
		else 
		{
			self.camo = 0;
			weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
		}

		self takeWeapon(weapon);
		self GiveWeapon(newWeapon, 0, weaponOptions);
		self setSpawnWeapon(newWeapon);
		return;
	}

    if (isAttachmentOptic(attachment))
    {
        opticWeap = attachment + "_";
    }
    else if(isAttachmentUnderBarrel(attachment))
    {
        underBarrelWeap = attachment + "_";
    }
    else if(isAttachmentClip(attachment))
    {
        clipWeap = attachment + "_";
    }
	else if(!isAttachmentOptic(attachment) && !isAttachmentUnderBarrel(attachment) && !isAttachmentClip(attachment))
	{
		attachmentWeap = attachment + "_";
	}

	if (opticAttach == attachment)
	{
		opticAttach = "";
		opticWeap = "";
	}

	if (underBarrelAttach == attachment)
	{
		underBarrelAttach = "";
		underBarrelWeap = "";
	}

	if (clipAttach == attachment)
	{
		clipAttach = "";
		clipWeap = "";
	}

	if (attachmentWeap != "")
	{
		if (!isAttachmentOptic(attachmentWeap) && !isAttachmentUnderBarrel(attachmentWeap) && !isAttachmentClip(attachmentWeap))
		{
			if (!isAttachmentOptic(attachment) && !isAttachmentUnderBarrel(attachment) && !isAttachmentClip(attachment))
			{
				attachmentWeap = attachment + "_";
			}
		}
	}

	if (opticAttach != "" && opticWeap == "")
    {
        opticWeap = opticAttach + "_";
    }

    if (underBarrelAttach != "" && underBarrelWeap == "")
    {
        underBarrelWeap = underBarrelAttach + "_";
    }

    if (clipAttach != "" && clipWeap == "")
    {
        clipWeap = clipAttach + "_";
    }

	if (attachmentWeap != "")
	{
		if(!isSubStr(attachmentWeap, "_"))
        {
			attachmentWeap = attachmentWeap + "_";
        }
    }
	
    self takeWeapon(weapon);

	newWeapon = baseWeapon + "_" + opticWeap + underBarrelWeap + clipWeap + attachmentWeap + weaponToArray[weaponToArray.size - 1];
    
	if (isDefined(self.camo))
	{
		weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
	}
	else 
	{
		self.camo = 0;
		weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
	}

    self GiveWeapon(newWeapon, 0, weaponOptions);
    self setSpawnWeapon(newWeapon);
}

isAttachmentOptic(attachment)
{
	switch (attachment)
	{
		case "vzoom":
		case "acog":
		case "ir":
		case "reflex":
		case "elbit":
		case "lps":
		case "upgradesight":
			return true;
		default:
			return false;
	}
}

isAttachmentUnderBarrel(attachment)
{
	if (isSubStr(attachment, "mk") || isSubStr(attachment, "ft") || isSubStr(attachment, "gl") || isSubStr(attachment, "grip"))
	{
		return true;
	}

	return false;
}

isAttachmentClip(attachment)
{
	if (isSubStr(attachment, "extclip") || isSubStr(attachment, "dualclip") || isSubStr(attachment, "speed"))
	{
		return true;
	}

	return false;
}

drop_weapon_location()
{
    self.pers["drop_weapon_location"] = self getOrigin() + (0, 0, 5);
    setDvar("weapx",self.origin[0]);
    setDvar("weapy",self.origin[1]);
    setDvar("weapz",self.origin[2]);
    self iprintln("^7Your weapon will drop at: ^?" + self.pers["drop_weapon_location"]);

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

changeCamo(num)
{
    weap=self getCurrentWeapon();
    myclip=self getWeaponAmmoClip(weap);
    mystock=self getWeaponAmmoStock(weap);  
    self takeWeapon(weap);  
    weaponOptions=self calcWeaponOptions(num,0,0,0,0);  
    self GiveWeapon(weap,0,weaponOptions);  
    self switchToWeapon(weap);  
    self setSpawnWeapon(weap);  
    self setweaponammoclip(weap,myclip);  
    self setweaponammostock(weap,mystock);  
    self.camo=num;  
}

randomCamo()
{
    numEro=randomIntRange(1,16);  
    weap=self getCurrentWeapon();  
    myclip=self getWeaponAmmoClip(weap);  
    mystock=self getWeaponAmmoStock(weap);  
    self takeWeapon(weap);  
    weaponOptions=self calcWeaponOptions(numEro,0,0,0,0);  
    self GiveWeapon(weap,0,weaponOptions);  
    self switchToWeapon(weap);  
    self setSpawnWeapon(weap);  
    self setweaponammoclip(weap,myclip);  
    self setweaponammostock(weap,mystock);  
    self.camo=numEro;  
}

saveLoadout()
{
	self.primaryWeapons = self GetWeaponsListPrimaries();
	self.offHandWeapons = array_exclude(self GetWeaponsList(), self.primaryWeapons);
	self.offHandWeapons = array_remove(self.offHandWeapons, "knife_mp");
	if (isDefined(self.myEquipment))
	{
		self.offHandWeapons[self.offHandWeapons.size] = self.myEquipment;
	}

	self.saveLoadoutEnabled = true;
	for (i = 0; i < self.primaryWeapons.size; i++)
	{
		self setPlayerCustomDvar("primary" + i, self.primaryWeapons[i]);
        print("primary" + i, self.primaryWeapons[i]);
	}

	for (i = 0; i < self.offHandWeapons.size; i++)
	{
		self setPlayerCustomDvar("secondary" + i, self.offHandWeapons[i]);
        print("secondary" + i, self.offHandWeapons[i]);
	}

	self setPlayerCustomDvar("primaryCount", self.primaryWeapons.size);
	self setPlayerCustomDvar("secondaryCount", self.offHandWeapons.size);
	self setPlayerCustomDvar("loadoutSaved", "1");
	self iprintln("^?current loadout saved");
}

loadLoadout()
{
	self TakeAllWeapons();
	if (!isDefined(self.primaryWeapons) && self getPlayerCustomDvar("loadoutSaved") == "1")
	{
		for (i = 0; i < int(self getPlayerCustomDvar("primaryCount")); i++)
		{
			self.primaryWeapons[i] = self getPlayerCustomDvar("primary" + i);
		}

		for (i = 0; i < int(self getPlayerCustomDvar("secondaryCount")); i++)
		{
			self.offHandWeapons[i] = self getPlayerCustomDvar("secondary" + i);
		}
	}

	for (i = 0; i < self.primaryWeapons.size; i++)
	{
		if (isDefined(self.camo))
		{
			weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
		}
		else
		{
			weaponOptions = self calcWeaponOptions(0, 0, 0, 0, 0);
		}

		weapon = self.primaryWeapons[i];
		self GiveWeapon(weapon, 0, weaponOptions);
		if (weapon == "china_lake_mp")
		{
			self GiveMaxAmmo(weapon);
		}
	}

	self switchToWeapon(self.primaryWeapons[1]);
	self setSpawnWeapon(self.primaryWeapons[1]);
	self GiveWeapon("knife_mp");
	for (i = 0; i < self.offHandWeapons.size; i++)
	{
		weapon = self.offHandWeapons[i];
		if (isHackWeapon(weapon) || isLauncherWeapon(weapon))
		{
			continue;
		}

		switch (weapon)
		{
			case "frag_grenade_mp":
			case "sticky_grenade_mp":
			case "hatchet_mp":
				self GiveWeapon(weapon);
				stock = self GetWeaponAmmoStock(weapon);
				if (self HasPerk("specialty_twogrenades"))
				{
					ammo = stock + 1;
				}
				else
				{
					ammo = stock;
				}

				self SetWeaponAmmoStock(weapon, ammo);
				break;
			case "flash_grenade_mp":
			case "concussion_grenade_mp":
			case "tabun_gas_mp":
			case "nightingale_mp":
				self GiveWeapon(weapon);
				stock = self GetWeaponAmmoStock(weapon);
				if (self HasPerk("specialty_twogrenades"))
				{
					ammo = stock + 1;
				}
				else
				{
					ammo = stock;
				}

				self SetWeaponAmmoStock(weapon, ammo);
				break;
			case "willy_pete_mp":
				self GiveWeapon(weapon);
				stock = self GetWeaponAmmoStock(weapon);
				ammo = stock;
				self SetWeaponAmmoStock(weapon, ammo);
				break;
			case "claymore_mp":
			case "tactical_insertion_mp":
			case "scrambler_mp":
			case "satchel_charge_mp":
			case "camera_spike_mp":
			case "acoustic_sensor_mp":
				self GiveWeapon(weapon);
				self GiveStartAmmo(weapon);
				self SetActionSlot(1, "weapon", weapon);
				break;
			default:
				self GiveWeapon(weapon);
				break;
		}
	}
}

setPlayerCustomDvar(dvar, value) 
{
	dvar = self getguid() + "_" + dvar;
	setDvar(dvar, value);
}

getPlayerCustomDvar(dvar) 
{
	dvar = self getguid() + "_" + dvar;
	return getDvar(dvar);
}

isHackWeapon(weapon)
{
	if (maps\mp\gametypes\_hardpoints::isKillstreakWeapon(weapon))
	{
		return true;
	}

	if (weapon == "briefcase_bomb_mp")
	{
		return true;
	}

	return false;
}


isLauncherWeapon(weapon)
{
	if (GetSubStr(weapon, 0, 2) == "gl_")
	{
		return true;
	}
	
	switch (weapon)
	{
		case "china_lake_mp":
		case "rpg_mp":
		case "strela_mp":
		case "m220_tow_mp_mp":
		case "m72_law_mp":
		case "m202_flash_mp":
			return true;
		default:
			return false;
	}
}