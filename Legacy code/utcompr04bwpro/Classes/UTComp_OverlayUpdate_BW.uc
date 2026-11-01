class UTComp_OverlayUpdate_BW extends UTComp_OverlayUpdate;

function UpdateVariables()
{
	local int i, j, k, l;
	local Controller C;
	local UTComp_PRI_BW uPRI;
	
	local PlayerReplicationInfo PRI_Red[MAX_PLAYERS];
	local byte Weapon_Red[MAX_PLAYERS];
	local string WeaponStr_Red[MAX_PLAYERS];
	local int Health_Red[MAX_PLAYERS];
	local byte Armor_Red[MAX_PLAYERS];
	local byte bHasDD_Red[MAX_PLAYERS];
	
	local PlayerReplicationInfo PRI_Blue[MAX_PLAYERS];
	local byte Weapon_Blue[MAX_PLAYERS];
	local string WeaponStr_Blue[MAX_PLAYERS];
	local int Health_Blue[MAX_PLAYERS];
	local byte Armor_Blue[MAX_PLAYERS];
	local byte bHasDD_Blue[MAX_PLAYERS];
	
	for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		if(i >= MAX_PLAYERS)
			i--;
			
	  if(j >= MAX_PLAYERS)
			j--;
			
	  if((xPlayer(C) != None || xBot(C) != None))
	  {
	  	if (C.GetTeamNum() == 0)
	  	{
				if(UpdateVariablesFor_BW(C, Weapon_Red[i], WeaponStr_Red[i], Health_Red[i], Armor_Red[i], PRI_Red[i], bHasDD_Red[i]))
					i++;
			}
			else if (C.GetTeamNum() == 1)
			{
				if(UpdateVariablesFor_BW(C, Weapon_Blue[j], WeaponStr_Blue[j], Health_Blue[j], Armor_Blue[j], PRI_Blue[j], bHasDD_Blue[j]))
					j++;
			}
			
	  }
	}
	
	for(C = Level.ControllerList; C != None; C = C.NextController)
	{    	
		if( (xPlayer(C) != None || xBot(C) != None) && C.PlayerReplicationInfo != None)
			uPRI = UTComp_PRI_BW(class'UTComp_Util'.static.GetUTCompPRI(C.PlayerReplicationInfo));
			
		if(uPRI != None)
		{
			if (C.GetTeamNum() == 0)
			{
				k = 0;
				for(l = 0; l < MAX_PLAYERS; l++)
				{
					if(uPRI.bShowSelf || C.PlayerReplicationInfo != PRI_Red[l])
					{
						uPRI.OverlayInfo[k].Weapon = Weapon_Red[l];
						uPRI.OverlayInfo[k].Health = Health_Red[l];
						uPRI.OverlayInfo[k].Armor = Armor_Red[l];
						uPRI.OverlayInfo[k].PRI = PRI_Red[l];
						uPRI.OverlayInfoWeapons[k] = WeaponStr_Red[l];
						uPRI.bHasDD[k] = bHasDD_Red[l];
						k++;
					}
				}
			}
			else if (C.GetTeamNum() == 1)
			{
				k = 0;
				for(l = 0; l < MAX_PLAYERS; l++)
				{
					if(uPRI.bShowSelf || C.PlayerReplicationInfo != PRI_Blue[l])
					{
						uPRI.OverlayInfo[k].Weapon = Weapon_Blue[l];
						uPRI.OverlayInfo[k].Health = Health_Blue[l];
						uPRI.OverlayInfo[k].Armor = Armor_Blue[l];
						uPRI.OverlayInfo[k].PRI = PRI_Blue[l];
						uPRI.OverlayInfoWeapons[k] = WeaponStr_Blue[l];
						uPRI.bHasDD[k] = bHasDD_Blue[l];
						k++;
					}
				}
			}
			else if(C.PlayerReplicationInfo != None && C.PlayerReplicationInfo.bOnlySpectator)
			{
				for(i = 0; i < MAX_PLAYERS; i++)
					uPRI.OverlayInfo[i].PRI = None;  
			}		
		}
		
		uPRI = None;
	}
	
	bVariablesCleared = false;
}



function bool UpdateVariablesFor_BW(Controller C, out byte Weapon, out string WeaponStr, out int Health, out byte Armor, out PlayerReplicationInfo PRI, out byte IsDD)
{
	if (!UpdateVariablesFor(C, Weapon, Health, Armor, PRI, IsDD))
		return false;
	
	if (C.Pawn != None && C.Pawn.Weapon != None)
		WeaponStr = string(C.Pawn.Weapon.class);
	else
		WeaponStr = "";
	
	return true;
}

defaultproperties
{
}
