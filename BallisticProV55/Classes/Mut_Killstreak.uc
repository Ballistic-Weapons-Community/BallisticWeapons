//=============================================================================
// Mut_Killstreak
//
// Allows players to set and obtain killstreak weapons
//=============================================================================
class Mut_Killstreak extends Mutator config(BallisticProV55);

const NUM_GROUPS = 2;

var() globalconfig array<string>	Streak1s;	// Killstreak One
var() globalconfig array<string>	Streak2s;	// Killstreak Two

struct dummypos
{
	var array<byte> Positions;
};

var()  array<dummypos>	DummyGroups[NUM_GROUPS];

var class<Weapon>					NetStreak1s;
var class<Weapon>					NetStreak2s;


//Find and save the position of any dummy weapons (for random weapon)

simulated function PreBeginPlay()
{
	local byte i, j;
	
	Super.PreBeginPlay();
	
	if (Role == ROLE_Authority)
		for (i=0; i < NUM_GROUPS; i++)
			for (j=0; j < GetGroup(i).Length; j++)
				if (Right(GetGroup(i)[j], 5) ~= "Dummy")
					DummyGroups[i].Positions[DummyGroups[i].Positions.Length] = j;
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

simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
	switch (GroupNum)
	{
		case	0:	return Streak1s[ItemNum];
		case	1:	return Streak2s[ItemNum];
	}
}

simulated function array<string> GetGroup(byte GroupNum)
{
	switch (GroupNum)
	{
		case	0:	return Streak1s;
		case	1:	return Streak2s;
	}
}

static function array<string> SGetGroup (byte GroupNum)
{
	switch (GroupNum)
	{
		case	0:	return default.Streak1s;
		case	1:	return default.Streak2s;
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
	local class<DummyWeapon> Dummy;
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

	log("Mut_Killstreak: ModifyPlayer: Pre streak check");
	
	if (KLRI.ActiveStreak > 0)
	{
		for (i=0; i < NUM_GROUPS; i++)
		{
			if (bool(KLRI.ActiveStreak & (2 ** i)))
			{
				log("Mut_Killstreak: ModifyPlayer: Got killstreak at "$i);

				//Handle dummies
				if (Right(GetItemName(KLRI.Killstreaks[i]), 5) ~= "Dummy")
				{
					Dummy = class<DummyWeapon>(DynamicLoadObject(KLRI.Killstreaks[i], class'Class'));
					if (Dummy != None)
						Dummy.static.ApplyEffect(Pawn, i);
				}

				else if (Right(KLRI.Killstreaks[i], 5) != "Dummy")
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
}

// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local KillstreakLRI KLRI;
	
	if (MutateString ~= "Killstreak" && Sender != None)
	{
		KLRI = GetKLRI(Sender.PlayerReplicationInfo);
		
		if (KLRI != None && KLRI.RewardLevel > 0)
			GrantKillstreakReward(Sender.Pawn, KLRI);
	}
	
	super.Mutate(MutateString, Sender);
}

function GrantKillstreakReward(Pawn Other, KillstreakLRI KLRI)
{
	local class<DummyWeapon> Dummy;
	local string S;
	local byte Index;
	
	log("GrantKillstreakReward: 1:"@KLRI.Killstreaks[0]$", 2:"@KLRI.Killstreaks[1]);
	
	if (bool(KLRI.RewardLevel & 2))
	{
		Index = 1;
	}
	else
	{
		Index = 0;
	}
	
	//Handle dummies
	if (InStr(KLRI.Killstreaks[Index], "Dummy") != -1)
	{
		if (KLRI.Killstreaks[Index] == "BallisticProV55.TeamLevelUpDummy")
		{
			PlayerController(Other.Controller).ClientMessage("Donations are currently disabled due to technical reasons.");
			return;
			
			if (!Level.Game.bTeamGame)
				PlayerController(Other.Controller).ClientMessage("You can only donate in a team game.");
			else if(!DonateWeapon(Index+1, Other, KLRI))
				PlayerController(Other.Controller).ClientMessage("Unable to donate at this time.");
			else	
				KLRI.RewardLevel = KLRI.RewardLevel & ~(Index + 1);
			return;
		}
		
		Dummy = class<DummyWeapon>(DynamicLoadObject(KLRI.Killstreaks[Index], class'Class'));
		if (Dummy != None && Dummy.static.ApplyEffect(Other, Index, true))
		{
			Level.Game.Broadcast(self, Other.PlayerReplicationInfo.PlayerName@"received a Level"@KLRI.RewardLevel@"spree reward:"@Dummy.default.ItemName);
			KLRI.ActiveStreak = KLRI.ActiveStreak | (Index + 1);
			KLRI.RewardLevel = KLRI.RewardLevel & ~(Index + 1);
		}
			
		return;
	}

	else
	{
		S = SpawnStreakWeapon(KLRI.Killstreaks[Index], Other, Index);
		
		if (S != "")
		{
			if (InStr(S, "FMD") == -1 && InStr(S, "MAU") == -1)
				Level.Game.Broadcast(self, Other.PlayerReplicationInfo.PlayerName@"received a Level"@Index+1@"spree reward:"@S);
			
			KLRI.ActiveStreak = KLRI.ActiveStreak | (Index + 1);
			KLRI.RewardLevel = KLRI.RewardLevel & ~(Index + 1);
		}
	}
}

function bool DonateWeapon(byte Index, Pawn Other, KillstreakLRI KLRI)
{

	return false;
	
	/*
	local int i;
	local PlayerController C;
	local array<Pawn> Options;
	local Pawn Used;
	local KillstreakLRI KLRI;
	
	for (i=0; i < CKIs.Length; i++)	
	{
		C = CKIs[i].PC;
		if (CKIs[i].Killstreaks[0] == "BallisticProV55.TeamLevelUpDummy" || CKIs[i].Killstreaks[1] == "BallisticProV55.TeamLevelUpDummy") //Donation isn't intended to be used as an advantage
			continue;
		if (BallisticPawn(C.Pawn) != None //ballisticpawn
		&& C != Other.Controller  //not us
		&& C.PlayerReplicationInfo != None //has pri
		&& C.PlayerReplicationInfo.Team == Other.PlayerReplicationInfo.Team) //on the same team
		{
			if (!bool(class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel & Index)) //doesn't already have a streak of the level we're trying to pass
				Options[Options.Length] = C.Pawn;
		}
	}
	
	if (Options.Length == 0)
		return false;
	
	if (Options.Length == 1)
		Used = Options[0];
	
	else Used = Options[Rand(Options.Length)];
		
	for (i=0;i<CKIs.length;i++)
	{
		if (CKIs[i].PC == Used.Controller)
		{
			BPRI = class'Mut_Ballistic'.static.GetBPRI(Used.PlayerReplicationInfo);
			if (BPRI != None)
				BPRI.RewardLevel = BPRI.RewardLevel | Index;
			else return false;
			Other.ClientMessage("You passed your Killstreak"@Index@"to"@Used.PlayerReplicationInfo.PlayerName$".");
			Used.ClientMessage("Received Killstreak"@Index@"from"@Other.PlayerReplicationInfo.PlayerName$".");
			Used.ReceiveLocalizedMessage(class'BallisticKillstreakMessage', -Index);
			Other.Controller.AwardAdrenaline(40 * Index);

			return true;
		}
	}
	return false;
	*/
}

function String SpawnStreakWeapon(string WeaponString, Pawn Other, byte GroupSlot)
{
	local class<Weapon> KR;
	local int j, k, m;

	log("Mut_Killstreak: SpawnStreakWeapon: "$WeaponString);
	
	//Dummies are likely to come in here if the target also has Donation set
	if (InStr(WeaponString, "Dummy") != -1)
	{
		k = Rand(GetGroup(GroupSlot).length - DummyGroups[GroupSlot].Positions.length);
				
		for (m = 0; m < DummyGroups[GroupSlot].Positions.Length; m++)
			if (k == DummyGroups[GroupSlot].Positions[m])
				k++;
			
		WeaponString = GetGroup(GroupSlot)[k];		
	}
	else
	{		
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
	}
	
	KR = class<Weapon>(DynamicLoadObject(WeaponString,class'Class'));
		
	if (KR == None)
		return "";
	
	else
	{
		SpawnWeapon(KR, Other);
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
}

static function Weapon SpawnWeapon(class<weapon> newClass, Pawn P)
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

defaultproperties
{
	Streak1s(0)=BWBPRecolorsPro.G28Grenade
	Streak1s(1)=BWBPRecolorsPro.AH208Pistol
	Streak1s(2)=BallisticProV55.G5Bazooka
	Streak1s(3)=BallisticProV55.MRocketLauncher
	Streak1s(4)=BallisticProV55.SKASShotgun
	Streak1s(5)=BallisticProV55.SRS600Rifle
	Streak1s(6)=BallisticProV55.TeamLevelUpDummys

	Streak2s(0)=BallisticProV55.RX22AFlamer
	Streak2s(1)=BallisticProV55.HVCMk9LightningGun
	Streak2s(2)=BallisticProV55.MACWeapon
	Streak2s(3)=BWBPRecolorsPro.MGLauncher
	Streak2s(4)=BWBPRecolorsPro.LAWLauncher
	Streak2s(5)=BWBPRecolorsPro.FLASHLauncher
	Streak2s(6)=BWBPAirstrikesPro.TargetDesignator
	Streak2s(7)=BallisticProV55.TeamLevelUpDummy

	FriendlyName="BallisticPro: Killstreaks"
	Description="Enables special weapons and effects which are granted when a certain kill streak has been obtained.||http://www.runestorm.com"
}