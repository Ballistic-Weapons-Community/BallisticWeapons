class UTComp_OverlayUpdate extends Info
	config;

struct VehicleIcon
{
	var int IconID;
	var name VehicleClass;
};

var config array<VehicleIcon> CustomVehicleIcons;

var MutUTComp UTCompMutator;
var bool bVariablesCleared;

const UPDATE_TIME = 1.0;
const MAX_PLAYERS = 16;

function InitializeOverlay()
{
	if(Level.Game.bTeamGame)
		SetTimer(UPDATE_TIME, true);
}

function Timer()
{
	if(UTCompMutator.bEnableTeamOverlay)
		UpdateVariables();
	else if(!bVariablesCleared)
		ClearVariables();
}

function ClearVariables()
{
	local UTComp_PRI uPRI;
	local int i;
	
	foreach DynamicActors(class'UTComp_PRI', uPRI)
	{
		for(i = 0; i < MAX_PLAYERS; i++)
		{
			uPRI.OverlayInfo[i].PRI = None;
			uPRI.OverlayInfo[i].Weapon = 0;
			uPRI.OverlayInfo[i].Health = 0;
			uPRI.OverlayInfo[i].Armor = 0;
			uPRI.bHasDD[i] = 0;
		}
	}
	
	bVariablesCleared = true;
}

function UpdateVariables()
{
	local int i, j, k, l;
	local Controller C;
	local UTComp_PRI uPRI;
	
	local PlayerReplicationInfo PRI_Red[MAX_PLAYERS];
	local byte Weapon_Red[MAX_PLAYERS];
	local int Health_Red[MAX_PLAYERS];
	local byte Armor_Red[MAX_PLAYERS];
	local byte bHasDD_Red[MAX_PLAYERS];
	
	local PlayerReplicationInfo PRI_Blue[MAX_PLAYERS];
	local byte Weapon_Blue[MAX_PLAYERS];
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
				if(UpdateVariablesFor(C, Weapon_Red[i], Health_Red[i], Armor_Red[i], PRI_Red[i], bHasDD_Red[i]))
					i++;
			}
			else if (C.GetTeamNum() == 1)
			{
				if(UpdateVariablesFor(C, Weapon_Blue[j], Health_Blue[j], Armor_Blue[j], PRI_Blue[j], bHasDD_Blue[j]))
					j++;
			}
			
	  }
	}
	
	for(C = Level.ControllerList; C != None; C = C.NextController)
	{    	
		if( (xPlayer(C) != None || xBot(C) != None) && C.PlayerReplicationInfo != None)
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(C.PlayerReplicationInfo);
			
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

function bool UpdateVariablesFor(Controller C, out byte Weapon, out int Health, out byte Armor, out PlayerReplicationInfo PRI, out byte IsDD)
{
	if(C.PlayerReplicationInfo == None)
		return false;
	
	PRI = C.PlayerReplicationInfo;
	
	if(C.Pawn == None)
		return true;
	else if(xPawn(C.Pawn) != None)
	{
		Health = C.Pawn.Health;
		Armor = C.Pawn.ShieldStrength;
		
		if(C.Pawn.Weapon != None)
			Weapon = FindWeaponID(C.Pawn.Weapon);
			
		if(xPawn(C.Pawn).UDamageTime - Level.TimeSeconds > 0)
			IsDD = 1;
	}
	else if(ONSWeaponPawn(C.Pawn) != None)
	{
		Health = C.Pawn.Health;
		Armor = 0;
		if(ONSWeaponPawn(C.Pawn).VehicleBase != None)
			Weapon=FindVehicleID(ONSWeaponPawn(C.Pawn).VehicleBase);
	}
	else if(Vehicle(C.Pawn) != None)
	{
		Health = C.Pawn.Health;
		Armor = 0;
		Weapon = FindVehicleID(Vehicle(C.Pawn));
	}
	else if(RedeemerWarHead(C.Pawn) != None)
	{
		if(RedeemerWarhead(C.Pawn).OldPawn != None)
		{
		   Health = RedeemerWarhead(C.Pawn).OldPawn.Health;
		   Armor = RedeemerWarhead(C.Pawn).OldPawn.ShieldStrength;
		}
		
		Weapon = 15;
	}
	else
	{
		Health = C.Pawn.Health;
		Armor = C.Pawn.ShieldStrength;
	}
	
	return true;
}

function byte FindWeaponID(Weapon aWeapon)
{
	if(ShieldGun(aWeapon) != None)
		return 1;
	else if(AssaultRifle(aWeapon) != None)
	{
		if(AssaultRifle(aWeapon).bDualMode)
			return 11;
		else
			return 2;
	}
	else if(BioRifle(aWeapon) != None)
		return 3;
	else if(ShockRifle(aWeapon) != None)
		return 4;
	else if(LinkGun(aWeapon) != None)
		return 5;
	else if(MiniGun(aWeapon) != None)
		return 6;
	else if(FlakCannon(aWeapon) != None)
		return 7;
	else if(RocketLauncher(aWeapon) != None)
		return 8;
	else if(SniperRifle(aWeapon) != None)
		return 9;
	else if(ClassicSniperRifle(aWeapon) != None)
		return 10;
	else if(ONSMineLayer(aWeapon) != None)
		return 12;
	else if(ONSGrenadeLauncher(aWeapon) != None)
		return 13;
	else if(ONSAVRiL(aWeapon) != None)
		return 14;
	else if(Redeemer(aWeapon) != None)
		return 15;
	else if(Painter(aWeapon) != None)
		return 16;
	else if(TransLauncher(aWeapon) != None)
		return 17;
}

function byte FindVehicleID(Vehicle aVehicle)
{
	local int i;
	
	if(aVehicle.IsA('ONSHoverBike'))
		return 21;
	else if(aVehicle.IsA('ONSHoverTank'))
		return 22;
	else if(aVehicle.IsA('ONSRV'))
		return 23;
	else if(aVehicle.IsA('ONSPRV'))
		return 24;
	else if(aVehicle.IsA('ONSMobileAssaultStation'))
		return 25;
	else if(aVehicle.IsA('ONSDualAttackCraft'))
		return 27;
	else if(aVehicle.IsA('ONSAttackCraft'))
		return 26;
	else if(aVehicle.IsA('ONSShockTank'))
		return 28;
	else if(aVehicle.IsA('ONSArtillery'))
		return 29;
	else
	{
		for (i = 0; i < CustomVehicleIcons.Length; i++)
		{
			if (aVehicle.IsA(CustomVehicleIcons[i].VehicleClass))
				return CustomVehicleIcons[i].IconID;
		}
	}
	
	return 0;
}

defaultproperties
{
}
