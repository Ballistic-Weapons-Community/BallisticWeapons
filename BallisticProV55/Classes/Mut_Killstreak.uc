//=============================================================================
// Mut_Killstreak
//
// Allows players to set and obtain killstreak weapons
//=============================================================================
class Mut_Killstreak extends Mutator
	transient
	HideDropDown
	CacheExempt;
	
const NUM_GROUPS = 2;

var() array<string>			Streak1s;	// Killstreak One
var() array<string>			Streak2s;	// Killstreak Two

function PreBeginPlay()
{
	local int i;
	local class<BC_GameStyle> game_style;
	local WeaponList_Killstreak streaks;

	Super.PreBeginPlay();

	game_style = class'BallisticGameStyles'.static.GetReplicatedStyle();

	log("Loading killstreak weapon list from "$game_style.default.StyleName);

	streaks = new(None, game_style.default.StyleName) class'WeaponList_Killstreak';

	Streak1s.Length = streaks.Streak1s.Length;
	Streak2s.Length = streaks.Streak2s.Length;

	for (i = 0; i < streaks.Streak1s.Length; ++i)
	{
		Streak1s[i] = streaks.Streak1s[i];
	}

	for (i = 0; i < streaks.Streak2s.Length; ++i)
	{
		Streak2s[i] = streaks.Streak2s[i];	
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Invasion(Level.Game) != None)
		SpawnInvStreakGR();
	else 
		SpawnStreakGR();
}

function SpawnStreakGR()
{
	local BallisticKillstreakRules G;
	
	G = spawn(class'BallisticKillstreakRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
	G.Mut = self;
}


function SpawnInvStreakGR()
{
	local BallisticInvKillstreakRules H;
	
	H = spawn(class'BallisticInvKillstreakRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = H;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(H);
	H.Mut = self;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local KillstreakLRI KLRI;
	
	local LinkedReplicationInfo LPRI;
	
	bSuperRelevant = 0;
		
	//shunt the lris down to make way for this one
	if (PlayerReplicationInfo(Other) != None)
	{
		KLRI = Spawn(class'KillstreakLRI', Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			LPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = KLRI;
			
			//this should be impossible?
			if (KLRI.NextReplicationInfo != None)
				KLRI.NextReplicationInfo.NextReplicationInfo = LPRI;
			else
				KLRI.NextReplicationInfo = LPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = KLRI;
	}
	
	return super.CheckReplacement(Other, bSuperRelevant);
}

simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
	switch (GroupNum)
	{
		case 0:	return Streak1s[ItemNum];
		case 1:	return Streak2s[ItemNum];
	}
}

simulated function array<string> GetGroup(byte GroupNum)
{
	switch (GroupNum)
	{
		case 0:	return Streak1s;
		case 1:	return Streak2s;
	}
}

//return Ballistic PRI (Izumo)
static function KillstreakLRI GetKLRI(PlayerReplicationInfo PRI)
{
	local LinkedReplicationInfo lPRI;
	
	if(PRI.CustomReplicationInfo == None)
	{
		log("No Custom PRI");
		return None;  //shouldn't happen
	}

	if(KillstreakLRI(PRI.CustomReplicationInfo) != None)
		return KillstreakLRI(PRI.CustomReplicationInfo);
	
	for(lPRI = PRI.CustomReplicationInfo.NextReplicationInfo; lPRI != None; lPRI = lPRI.NextReplicationInfo)
	{
		if(KillstreakLRI(lPRI) != None)
			return KillstreakLRI(lPRI);
			
		if (lPRI == lPRI.NextReplicationInfo)
		{
			log("A LinkedReplicationInfo links to itself, aborting");
			break;
		}
	}
	
	log("Couldn't find a KLRI");
	return None;
}

function byte GetStreakLevel(PlayerController C)
{
	return GetKLRI(C.PlayerReplicationInfo).RewardLevel;
}

function FlagStreak(PlayerController C, byte Level)
{
	GetKLRI(C.PlayerReplicationInfo).RewardLevel = GetKLRI(C.PlayerReplicationInfo).RewardLevel | Level;
}

function ResetActiveStreaks(PlayerController C)
{
	local KillstreakLRI KLRI;
	
	KLRI = GetKLRI(C.PlayerReplicationInfo);
	
	if (KLRI != None)
	{
		KLRI.ActiveStreak = 0;
		KLRI.InvKillScore = 0;
	}
}

//=================================================
// ModifyPlayer
// Outfits the player on spawn
//=================================================
function ModifyPlayer( pawn Other )
{
	local KillstreakLRI KLRI;
	local int i, j;
	local class<Inventory> InventoryClass;
	local Inventory Inv;
	local xPawn Pawn;

	Super.ModifyPlayer(Other);
	
	//ModifyPlayer isn't always called on spawn
	if (Other.LastStartTime > Level.TimeSeconds + 2)
		return;

	KLRI = GetKLRI(Other.PlayerReplicationInfo);
	
	if (KLRI == None)
		return;

	if (Other.PlayerReplicationInfo.bBot || xPawn(Other) == None)
		return;

	Pawn = xPawn(Other);

	if (KLRI.ActiveStreak > 0)
	{
		for (i=0; i < NUM_GROUPS; i++)
		{
			if (bool(KLRI.ActiveStreak & (2 ** i)))
			{
				//Check validity.
				for (j=0; j <= GetGroup(i).length; j++)
				{
					if ( j == GetGroup(i).length )
					{
						PlayerController(Pawn.Controller).ClientMessage("The selected Killstreak reward weapon ("$KLRI.Killstreaks[i]$") is not available on this server, giving the default weapon.");
						KLRI.Killstreaks[i] = GetGroup(i)[0];
						break;
					}
					
					if (GetGroup(i)[j] ~= KLRI.Killstreaks[i])
						break;
				}
				
				/*
				for (j = 0; j < ArrayCount(Pawn.RequiredEquipment); ++j)
				{
					if (Pawn.RequiredEquipment[j] == "")
					{
						Pawn.RequiredEquipment[j] = KLRI.Killstreaks[i];
						log("Mut_Killstreak: ModifyPlayer: Added "$KLRI.Killstreaks[i]$" as required equipment");
						break;
					}
				}
				*/

				InventoryClass = Level.Game.BaseMutator.GetInventoryClass(KLRI.Killstreaks[i]);
				Inv = Spawn(InventoryClass);

				if( Inv != None )
				{
					Inv.GiveTo(Pawn);
					if (Weapon(Inv) != None && Pawn.PendingWeapon == None && Pawn.Weapon == None)
					{
						Pawn.PendingWeapon = Weapon(Inv);
						Pawn.ChangedWeapon();
					}
					if (Inv != None)
						Inv.PickupFunction(Pawn);
				}
	
				if (BallisticPawn(Pawn) != None)
					BallisticPawn(Pawn).bActiveKillstreak = True;
			}
		}
	}
}

// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local KillstreakLRI KLRI;
	local int count;
	local array<String> split_string;
	
	if (MutateString ~= "Killstreak" && Sender != None)
	{
		KLRI = GetKLRI(Sender.PlayerReplicationInfo);
		
		if (KLRI != None && KLRI.RewardLevel > 0)
			GrantKillstreakReward(Sender.Pawn, KLRI);
	}

	else
	{
		count = Split(MutateString, " ", split_string);

		if (split_string[0] ~= "AddKillstreakWeapon")
			AddWeapon(Sender, split_string);
		else if (split_string[0] ~= "RemoveKillstreakWeapon")
			RemoveWeapon(Sender, split_string);
	}
	
	super.Mutate(MutateString, Sender);
}

function AddWeapon(PlayerController Sender, array<String> split_string)
{	
	local int i, loadout_group;
	local array<String> weapons;
	
	local BC_WeaponInfoCache.WeaponInfo WI;
	
	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate AddKillstreakWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 3)
	{
		Sender.ClientMessage("Mutate AddKillstreakWeapon: Usage: mutate addkillstreakweapon <loadout_group_index> <weapon_class_name>");
		return;
	}	
	
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(split_string[2]);
	
	if (!(WI.ClassName ~= split_string[2]))
	{
		Sender.ClientMessage("Mutate AddKillstreakWeapon: Weapon not found:"@split_string[2]);
		return;
	}

	loadout_group = int(split_string[1]);
	
	if (loadout_group >= NUM_GROUPS)
	{
		Sender.ClientMessage("Mutate AddKillstreakWeapon: Invalid loadout group"@loadout_group);
		return;
	}
	
	weapons = GetGroup(loadout_group);
	
	for (i = 0; i < weapons.Length; ++i)
	{
		if (weapons[i] ~= WI.ClassName)
		{
			Sender.ClientMessage("Mutate AddKillstreakWeapon: Loadout group"@loadout_group@"already contains"@WI.ClassName); 
			return;	
		}
	}
	
	weapons[weapons.Length] = split_string[2];
	
	switch(loadout_group)
	{
	case 0:
		class'Mut_Killstreak'.default.Streak1s = weapons;
		break;
	case 1:
		class'Mut_Killstreak'.default.Streak2s = weapons;
		break;
	}	
	
	Sender.ClientMessage("Mutate AddKillstreakWeapon: Success - added"@WI.ClassName@"to loadout group"@loadout_group); 
	
	class'Mut_Killstreak'.static.StaticSaveConfig();
}

function RemoveWeapon(PlayerController Sender, array<String> split_string)
{	
	local bool success;
	local int i, loadout_group;
	local array<String> weapons;

	success = false;
	
	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate RemoveKillstreakWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 3)
	{
		Sender.ClientMessage("Mutate RemoveKillstreakWeapon: Usage: mutate removekillstreakweapon <loadout_group_index> <weapon_class_name>");
		return;
	}	
	
	loadout_group = int(split_string[1]);
	
	if (loadout_group >= NUM_GROUPS)
	{
		Sender.ClientMessage("Mutate RemoveKillstreakWeapon: Invalid loadout group"@loadout_group);
		return;
	}
	
	weapons = GetGroup(loadout_group);
	
	for (i = 0; i < weapons.Length; ++i)
	{
		if (weapons[i] ~= split_string[2])
		{
			weapons.Remove(i, 1);
			--i;
			success = true;
		}
	}
	
	if (success)
	{
		switch(loadout_group)
		{
		case 0:
			class'Mut_Killstreak'.default.Streak1s = weapons;
			break;
		case 1:
			class'Mut_Killstreak'.default.Streak2s = weapons;
			break;
		}	
		
		class'Mut_Killstreak'.static.StaticSaveConfig();
		
		Sender.ClientMessage("Mutate RemoveKillstreakWeapon: Success - removed"@split_string[2]@"from loadout group"@loadout_group); 
	}
	
	else 
	{
		Sender.ClientMessage("Mutate RemoveKillstreakWeapon:"@split_string[2]@"not found in loadout group"@loadout_group); 
	}
}

function GrantKillstreakReward(Pawn Other, KillstreakLRI KLRI)
{
	local string S;
	local byte Index;

	if (bool(KLRI.RewardLevel & 2))
	{
		Index = 1;
	}
	else
	{
		Index = 0;
	}
	
	S = SpawnStreakWeapon(KLRI.Killstreaks[Index], KLRI.Layouts[Index], KLRI.Camos[Index], Other, Index);
	
	if (S != "")
	{
		if (InStr(S, "FMD") == -1 && InStr(S, "MAU") == -1)
			Level.Game.Broadcast(self, Other.PlayerReplicationInfo.PlayerName@"received a Level"@Index+1@"spree reward:"@S);
		
		KLRI.ActiveStreak = KLRI.ActiveStreak | (Index + 1);
		KLRI.RewardLevel = KLRI.RewardLevel & ~(Index + 1);
	}
}

function String SpawnStreakWeapon(string WeaponString, byte LI, byte CI, Pawn Other, byte GroupSlot)
{
	local class<Weapon> KR;
	local int j, k, m;

	//Check validity.
	for (j=0; j <= GetGroup(GroupSlot).length; j++)
	{
		if ( j == GetGroup(GroupSlot).length )
		{
			PlayerController(Other.Controller).ClientMessage("The selected Killstreak reward weapon ("$WeaponString$") is not available on this server, giving the default weapon.");
			WeaponString = GetGroup(GroupSlot)[0];
			break;
		}
		
		if (GetGroup(GroupSlot)[j] ~= WeaponString)
			break;
	}
	
	KR = class<Weapon>(DynamicLoadObject(WeaponString,class'Class'));
		
	if (KR == None)
		return "";
	
	SpawnWeapon(KR, Other, LI, CI);

	if (class<BallisticWeapon>(KR) != None && !class<BallisticWeapon>(KR).default.bNoMag)
	{
		class'Mut_Ballistic'.static.SpawnAmmo(KR.default.FireModeClass[0].default.AmmoClass, Other);
		if (KR.default.FireModeClass[0].default.AmmoClass != KR.default.FireModeClass[1].default.AmmoClass)
			class'Mut_Ballistic'.static.SpawnAmmo(KR.default.FireModeClass[1].default.AmmoClass, Other);
	}
	
	if (BallisticPawn(Other) != None)
		BallisticPawn(Other).bActiveKillstreak = True;
		
	return KR.default.ItemName;
}

static function Weapon SpawnWeapon(class<weapon> newClass, Pawn P, byte LayoutIndex, byte CamoIndex)
{
	local Weapon newWeapon;

    if( (newClass!=None) && P != None)
    {
		newWeapon = Weapon(P.FindInventoryType(newClass));
		if (newWeapon == None || BallisticHandgun(newWeapon) != None)
		{
			newWeapon = P.Spawn(newClass,,,P.Location);
			if( newWeapon != None )
			{
				if (BallisticWeapon(newWeapon) != None)
				{
					BallisticWeapon(newWeapon).GenerateLayout(LayoutIndex);
					BallisticWeapon(newWeapon).GenerateCamo(CamoIndex);
				}
				newWeapon.GiveTo(P);
			}
			if (BallisticHandgun(newWeapon) != None && BallisticHandgun(newWeapon).default.bShouldDualInLoadout)
			{
				newWeapon = P.Spawn(newClass,,,P.Location);
				if( newWeapon != None )
					newWeapon.GiveTo(P);
			}
			//Hack for bots - stops them complaining
			if (Bot(P.Controller) != None && P.Weapon == None && P.PendingWeapon == None)
			{
				P.PendingWeapon = newWeapon;
				P.ChangedWeapon();
			}
			
			return newWeapon;
		}
		else
		{
			newWeapon.AddAmmo(newClass.default.AmmoClass[0].default.InitialAmount, 0);
			newWeapon.AddAmmo(newClass.default.AmmoClass[1].default.InitialAmount, 1);
			if (BallisticWeapon(newWeapon) != None)
			{
				BallisticWeapon(newWeapon).MagAmmo = BallisticWeapon(newWeapon).default.MagAmmo;
				BallisticWeapon(newWeapon).bNeedReload = False;
				if (!P.IsLocallyControlled())
					BallisticWeapon(newWeapon).ClientWeaponReloaded();
			}
		}
    }
	
	return None;
}

defaultproperties
{
	FriendlyName="BallisticPro: Killstreaks"
	Description="Enables special weapons and effects which are granted when a certain kill streak has been obtained.||http://www.runestorm.com"
}