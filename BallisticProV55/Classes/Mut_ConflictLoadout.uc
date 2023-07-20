//======================================================================
// Conflict Loadout
//
// Formerly the Ballistic Conflict gear handling, reimplemented as this class. Allows loadouts
// based on space as well as items and team-based loadouts.
// Adapted from RS code by Azarael.
//======================================================================
class Mut_ConflictLoadout extends Mut_Ballistic
	transient
	HideDropDown
	CacheExempt
	DependsOn(Mut_Loadout)
	DependsOn(WeaponList_ConflictLoadout);

const MAIN_SECTION_INDEX = 0;
const SUB_SECTION_INDEX = 1;

var() array<WeaponList_ConflictLoadout.Entry>	ConflictWeapons;	// Big list of all available weapons and the teams for which they are selectable
var() byte										LoadoutOption;		 //0: normal loadout, 1: Evolution skill requirements, 2: Purchasing system (not implemented yet)

var() config bool								bSeparateAssaultList;
// Assigned from game style
var protected int 								MaxInventorySize;
var protected int								MaxSlots[2];	
	
var	array<string> 								LoadoutOptionText;

var array<Mut_Loadout.LORequirements> 			FullRequirementsList;

//================================================
// PreBeginPlay
//================================================
function PreBeginPlay()
{
	local int i;
	local class<BC_GameStyle> game_style;
	local WeaponList_ConflictLoadout list;
	local string loader_string;

	Super.PreBeginPlay();

	game_style = class'BallisticGameStyles'.static.GetReplicatedStyle();

	MaxSlots[MAIN_SECTION_INDEX] = game_style.default.ConflictWeaponSlots;
	MaxSlots[SUB_SECTION_INDEX] = game_style.default.ConflictEquipmentSlots;
	MaxInventorySize = MaxSlots[MAIN_SECTION_INDEX] + MaxSlots[SUB_SECTION_INDEX];

	loader_string = game_style.default.StyleName;

	if (bSeparateAssaultList && ASGameInfo(Level.Game) != None)
		loader_string $= "Assault";

	log("Loading Conflict Loadout weapon list from "$loader_string);

	list = new(None, loader_string) class'WeaponList_ConflictLoadout';

	ConflictWeapons.Length = list.ConflictWeapons.Length;

	for (i = 0; i < list.ConflictWeapons.Length; ++i)
	{
		ConflictWeapons[i] = list.ConflictWeapons[i];
	}

	LoadoutOption = list.LoadoutOption;

/*
	for (i = 0; i < ConflictWeapons.Length; ++i)
	{
		log("Weapons: " $ ConflictWeapons[i].ClassName);	
	}
*/
}
//================================================
// PostBeginPlay
// Reads the evolution loadout requirements from either the 
// evo loadout mutator settings for speedup or from the weapon
// itself, then scales them according to the vars in the Evo
// config class. Adds the GameRules which track the various
// events and save them to the Elimination LRI.
//================================================
function PostBeginPlay()
{
	local int i, j;
	local GameRules G;

	Super.PostBeginPlay();

	if (LoadoutOption == 1)
	{
		G = spawn(class'Rules_SpLoadout');
		if ( Level.Game.GameRulesModifiers == None )
			Level.Game.GameRulesModifiers = G;
		else    
			Level.Game.GameRulesModifiers.AddGameRules(G);
	}
		
	for (i=0; i < ConflictWeapons.length; i++)
	{
		for (j=0;j<class'Mut_Loadout'.default.Items.Length;j++)
		{
			if (class'Mut_Loadout'.default.Items[j].ItemName ~= ConflictWeapons[i].ClassName)
				FullRequirementsList[i] = class'Mut_Loadout'.default.Items[j].Requirements;
		}

		if (j >= class'Mut_Loadout'.default.Items.Length)
		{
			FullRequirementsList.length = i+1;
			SetDefaultRequirements(ConflictWeapons[i].ClassName, i);
		}

		//Set team affiliation directly.
		if (ConflictWeapons[i].bBlue)
		{
			if(ConflictWeapons[i].bRed)
				FullRequirementsList[i].InTeam = 2;
			else FullRequirementsList[i].InTeam = 1;
		}
	}
	FullRequirementsList.length = ConflictWeapons.length;

	for (i=0;i<FullRequirementsList.length;i++)
	{
		FullRequirementsList[i].MatchTime	*= class'Mut_LoadoutConfig'.default.TimeScale;
		FullRequirementsList[i].Frags		*= class'Mut_LoadoutConfig'.default.FragScale;
		FullRequirementsList[i].Efficiency	*= class'Mut_LoadoutConfig'.default.EffyScale;
		FullRequirementsList[i].DamageRate	*= class'Mut_LoadoutConfig'.default.DmRtScale;
		FullRequirementsList[i].ShotgunEff	*= class'Mut_LoadoutConfig'.default.SgEfScale;
		FullRequirementsList[i].SniperEff	*= class'Mut_LoadoutConfig'.default.SrEfScale;
		FullRequirementsList[i].HazardEff	*= class'Mut_LoadoutConfig'.default.HzEfScale;
	}
}

//==================================================
// Mutate
// Convenience editing function for servers
// No longer works
// Need compatibility with PerObjectConfig impl
//==================================================

/*
function Mutate(string MutateString, PlayerController Sender)
{
	local int count;
	local array<String> split_string;
	
	count = Split(MutateString, " ", split_string);

	if (split_string[0] ~= "AddWeapon")
		AddWeapon(Sender, split_string);
	else if (split_string[0] ~= "RemoveWeapon")
		RemoveWeapon(Sender, split_string);

	super.Mutate(MutateString, Sender);
}

function AddWeapon(PlayerController Sender, array<String> split_string)
{	
	local int i;
	local BC_WeaponInfoCache.WeaponInfo WI;

	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate AddWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 2)
	{
		Sender.ClientMessage("Mutate AddWeapon: Usage: mutate addweapon <weapon_class_name>");
		return;
	}	
	
	for (i = 0; i < class'Mut_ConflictLoadout'.default.ConflictWeapons.Length; ++i)
	{
		if (class'Mut_ConflictLoadout'.default.ConflictWeapons[i].ClassName ~= split_string[1])
		{
			class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bRed = true;
			class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bBlue = true;
			Sender.ClientMessage("Mutate AddWeapon: Successfully enabled "$split_string[1]$" for Conflict Loadout play."); 

			class'Mut_ConflictLoadout'.static.StaticSaveConfig();
			return;	
		}
	}

	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(split_string[1]);

	if (!(WI.ClassName ~= split_string[1]))
	{
		Sender.ClientMessage("Mutate AddWeapon: Couldn't find "$split_string[1]$" in the cache."); 
		return;
	}

	class'Mut_ConflictLoadout'.default.ConflictWeapons.Insert(i, 1);

	class'Mut_ConflictLoadout'.default.ConflictWeapons[i].ClassName = split_string[1];
	class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bRed = true;
	class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bBlue = true;

	class'Mut_ConflictLoadout'.static.StaticSaveConfig();

	Sender.ClientMessage("Mutate AddWeapon: Successfully added "$split_string[1]$" to the Conflict Loadout list."); 
}

function RemoveWeapon(PlayerController Sender, array<String> split_string)
{	
	local int i;

	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 2)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Usage: mutate addweapon <weapon_class_name>");
		return;
	}	
	
	for (i = 0; i < class'Mut_ConflictLoadout'.default.ConflictWeapons.Length; ++i)
	{
		if (class'Mut_ConflictLoadout'.default.ConflictWeapons[i].ClassName ~= split_string[1])
		{
			class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bRed = false;
			class'Mut_ConflictLoadout'.default.ConflictWeapons[i].bBlue = false;
			Sender.ClientMessage("Mutate RemoveWeapon: Successfully disabled "$split_string[1]); 

			class'Mut_ConflictLoadout'.static.StaticSaveConfig();
			return;	
		}
	}

	Sender.ClientMessage("Mutate RemoveWeapon: Couldn't find "$split_string[1]$" in the conflict list."); 
}
*/

//==================================================
// SetDefaultRequirements
// Read the evolution loadout requirements from the special string 
// and assign to the FullReqsList
//==================================================
function bool SetDefaultRequirements(string ClassName, int Index)
{
	local class<BallisticWeapon> BW;
	local string s;
	local array<string> RS;

	BW = class<BallisticWeapon>( DynamicLoadObject(ClassName, class'class') );
	if (BW == None)
		return false;

	s = BW.static.StaticGetSpecialInfo('EvoDefs');
	if (s == "")
		return false;
	Split(s, ";", RS);
	switch (RS.Length-1)
	{
		case 6:	FullRequirementsList[Index].HazardEff	= float(RS[6]);
		case 5:	FullRequirementsList[Index].ShotgunEff	= float(RS[5]);
		case 4:	FullRequirementsList[Index].SniperEff	= float(RS[4]);
		case 3:	FullRequirementsList[Index].DamageRate	= float(RS[3]);
		case 2:	FullRequirementsList[Index].Efficiency	= float(RS[2]);
		case 1:	FullRequirementsList[Index].Frags		= float(RS[1]);
		case 0:	FullRequirementsList[Index].MatchTime	= float(RS[0]);
	}
	return true;
}


static function int GetItemSize(class<Inventory> Item)
{
	if (class<BallisticWeapon>(Item) == None)
		return 1;

	return class<BallisticWeapon>(Item).static.GetParams().default.Layouts[0].InventorySize;
}

static function int GetSectionIndex(class<Inventory> Item)
{
	if (class<BallisticWeapon>(Item) == None)
		return SUB_SECTION_INDEX;

	if (class'BallisticGameStyles'.static.GetReplicatedStyle() == class'GameStyle_Classic')
		return MAIN_SECTION_INDEX;

    switch (class<BallisticWeapon>(Item).default.InventoryGroup)
    {
        case 0:
        case 1:
        case 11:
            return SUB_SECTION_INDEX;
        default:
            return MAIN_SECTION_INDEX;
    }
}

//=================================================
// ModifyPlayer
// Outfits the player on spawn
//=================================================
function ModifyPlayer( pawn Other )
{
	local int i, Size;
	local int SectionIndex;
	local int SpaceUsed[2];
	local int CamoIndex, LayoutIndex;
	local float BonusAmmo;
	local Inventory Inv;
	local Weapon W;
	local class<Inventory> InventoryClass;
	local ConflictLoadoutLRI CLRI;
	local string s;
	local class<ConflictItem> ItemClass;

	Super.ModifyPlayer(Other);
	
	//ModifyPlayer is sometimes called at times other than spawn time
	if (Other.LastStartTime > Level.TimeSeconds + 1)
		return;

	CLRI = ConflictLoadoutLRI(GetBPRI(Other.PlayerReplicationInfo));
	
	if (CLRI == None)
		return;

	if (Other.PlayerReplicationInfo.bBot)
		EquipBot(Other);
	else
	{
		CLRI.Validate(CLRI.Loadout, CLRI.Layouts, CLRI.Camos);
		if (CLRI.Loadout.length == 0)
		{
 			s = GetFallbackWeapon(CLRI);
	 		if (s != "")
 				CLRI.Loadout[0] = s;
	 	}
	}

	CLRI.AppliedItems.length = 0;

	if ( xPawn(Other) != None )
	{
		for (i = 0 ; i < Max(CLRI.Loadout.length,2); i++)
		{
			if (i >= CLRI.Loadout.length)
				xPawn(Other).RequiredEquipment[i] = "";
			else
			{
				InventoryClass = Level.Game.BaseMutator.GetInventoryClass(CLRI.Loadout[i]);

				if(InventoryClass != None)
				{
					SectionIndex = GetSectionIndex(InventoryClass);

					Size = GetItemSize(InventoryClass);

					if (SpaceUsed[SectionIndex] + Size > MaxSlots[SectionIndex])
						continue;
				
					if (class<BallisticWeapon>(InventoryClass) != None)
					{
						if ( i < CLRI.Layouts.length && CLRI.Layouts[i] != "")
							LayoutIndex = int(CLRI.Layouts[i]);
						if ( i < CLRI.Camos.length && CLRI.Camos[i] != "")
							CamoIndex = int(CLRI.Camos[i]);						
						SpawnConflictWeapon(class<BallisticWeapon>(InventoryClass), Other, 255, i == CLRI.InitialWeaponIndex, LayoutIndex, CamoIndex);
						LayoutIndex=0;
						CamoIndex=0;
					}
					else 
						SpawnInventoryItem(InventoryClass, Other);

					SpaceUsed[SectionIndex] += Size;
				}
				else
				{
					ItemClass = class<ConflictItem>(DynamicLoadObject(CLRI.Loadout[i],class'Class'));

					if (ItemClass != None)
					{
						SectionIndex = 1;
						Size = ItemClass.default.Size/5;

						if (SpaceUsed[SectionIndex] + Size > MaxSlots[SectionIndex])
							continue;

						CLRI.AppliedItems[CLRI.AppliedItems.length] = ItemClass;
						if (ItemClass.default.bBonusAmmo)
						{
							if (ItemClass.static.AddAmmoBonus(Other, BonusAmmo));
								SpaceUsed[SectionIndex] += Size;
						}
						else if (ItemClass.static.ApplyItem(Other))
							SpaceUsed[SectionIndex] += Size;
					}
				}
			}
		}
	}
	
	// check if need to give fallback weapon
	if (SpaceUsed[MAIN_SECTION_INDEX] < MaxSlots[MAIN_SECTION_INDEX])
	{
		for (Inv=Other.Inventory; Inv != None; Inv = Inv.Inventory)
			if (Weapon(Inv) != None)
				break;
		if (Inv == None)
		{
			s = GetFallbackWeapon(CLRI); //GetRandomWeapon(CLRI);

			InventoryClass = Level.Game.BaseMutator.GetInventoryClass(s);

			if( (InventoryClass!=None))
			{
				Inv = Spawn(InventoryClass);
				if( Inv != None )
				{
					Inv.GiveTo(Other);

					// Azarael 19/03/2023: added code from Freon variant
					if (Weapon(Inv) != None && Other.PendingWeapon == None && Other.Weapon == None)
					{
						Other.PendingWeapon = Weapon(Inv);
						Other.ChangedWeapon();
					}
					if ( Inv != None )
						Inv.PickupFunction(Other);
				}
			}
		}
	}

	for (Inv = Other.Inventory; Inv != None; Inv = Inv.Inventory)
	{
		W = Weapon(Inv);
		if (W != None && BonusAmmo > 0)
		{
			SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other, BonusAmmo);
			if (W.default.FireModeClass[1] != None && W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other, BonusAmmo);
		}
	}

	for (i = 0; i < CLRI.AppliedItems.length; i++)
		CLRI.AppliedItems[i].static.PostApply(Other);
}

function SpawnInventoryItem(class<Inventory> InvClass, Pawn Other)
{
	local Inventory Inv;

	Inv = Other.Spawn(InvClass,,,Other.Location);

	if( Inv != None )
	{
		Inv.GiveTo(Other);
		Inv.PickupFunction(Other);					
	}
}

function SpawnConflictWeapon(class<Weapon> WepClass, Pawn Other, int net_inventory_group, bool set_as_initial_weapon, int LayoutIndex, int CamoIndex)
{
	local Weapon newWeapon;
	local byte GameStyleIndex;

	GameStyleIndex = class'BallisticReplicationInfo'.default.GameStyle;
	newWeapon = Weapon(Other.FindInventoryType(WepClass));

	if (newWeapon == None || (BallisticHandgun(newWeapon) != None && !BallisticHandgun(newWeapon).default.ParamsClasses[GameStyleIndex].default.Layouts[LayoutIndex].bDualBlocked))/* && BallisticHandgun(newWeapon).bShouldDualInLoadout))*/
	{
		newWeapon = Other.Spawn(WepClass,,,Other.Location);
	
		if( newWeapon != None )
		{
            if (BallisticWeapon(newWeapon) != None)
            {
                BallisticWeapon(newWeapon).NetInventoryGroup = net_inventory_group;
                BallisticWeapon(newWeapon).bServerDeferInitialSwitch = !set_as_initial_weapon;
				BallisticWeapon(newWeapon).GenerateLayout(LayoutIndex);
				BallisticWeapon(newWeapon).GenerateCamo(CamoIndex);
            }
			newWeapon.GiveTo(Other);
			newWeapon.PickupFunction(Other);
				
			//Hack for bots - stops them complaining
			if (Bot(Other.Controller) != None && Other.PendingWeapon == None && Other.Weapon == None)
			{
				Other.PendingWeapon = newWeapon;
				Other.ChangedWeapon();
			}						
		}
	}

	else 
	{
		newWeapon.AddAmmo(WepClass.default.FireModeClass[0].default.AmmoClass.default.InitialAmount, 0);
		newWeapon.AddAmmo(WepClass.default.FireModeClass[1].default.AmmoClass.default.InitialAmount, 1);
	}
}
	
function EquipBot(Pawn P)
{
	local int i, j, Size, SpaceUsed;
	local ConflictLoadoutLRI CLRI;
	local array<string> Potentials;
	local string ClassName;
	local class<Weapon> W;
	local bool bAddedMiscs;
	local class<ConflictItem> CI;

	local array<float>	BandWidth;
	local float			BandTotal, BandRand, BandLoc;

	CLRI = ConflictLoadoutLRI(GetBPRI(P.PlayerReplicationInfo));
	if (CLRI == None)
		return;

	// Make a list of potential weapons
	for (i=0;i<ConflictWeapons.length;i++)
	{
		if (P.GetTeamNum() == 0 && !ConflictWeapons[i].bRed)
			continue;
		if (P.GetTeamNum() > 0 && !ConflictWeapons[i].bBlue)
			continue;
		// Only add weapons, not items yet. Make sure bot picks at least one weapon before getting items
		if (class<Weapon>(DynamicLoadObject(ConflictWeapons[i].ClassName, class'Class')) == None)
			continue;
		if (CLRI.WeaponRequirementsOk(FullRequirementsList[i]))
		{
			Potentials[Potentials.length] = ConflictWeapons[i].ClassName;
			if (LoadoutOption == 1)
			{	// Make Weight table so newer harder to get weapons are more likely to be chosen
				BandWidth[Potentials.length-1] = 3;
				if (FullRequirementsList[i].MatchTime > 0)
					BandWidth[Potentials.length-1] += sqrt(FullRequirementsList[i].MatchTime);
				if (FullRequirementsList[i].Frags > 0)
					BandWidth[Potentials.length-1] += sqrt(FullRequirementsList[i].Frags)*3;
				BandTotal += BandWidth[Potentials.length-1];
			}
		}
	}

	// Pick us some stuff
	CLRI.Loadout.length = 0;
	for (i=0; i < MaxInventorySize && SpaceUsed < MaxInventorySize; i++)
	{
		if (LoadoutOption == 1)
		{	// Randomly pick something using weights
			BandRand = FRand() * BandTotal;
			BandLoc = 0;
			for (j=0;j<BandWidth.length;j++)
			{
				BandLoc+=BandWidth[j];
				if (BandRand < BandLoc)
				{
					Classname = Potentials[j];
					break;
				}
			}
		}
		else	// Randomly pick anything
			ClassName = Potentials[Rand(Potentials.length)];

		// Try adding this weapon / item
		W = class<Weapon>(DynamicLoadObject(ClassName, class'Class'));
		if (W == None)
		{
			if (bAddedMiscs)
			{	// Add this item
				CI = class<ConflictItem>(DynamicLoadObject(ClassName, class'Class'));
				if (CI == None)
					continue;
				Size = CI.default.Size/5;

				if (Size + SpaceUsed > MaxInventorySize)
					continue;
				CLRI.Loadout[CLRI.Loadout.length] = ClassName;
				SpaceUsed += Size;
			}
			continue;
		}
		// We've got a weapon so add the items to the potential list
		if (!bAddedMiscs)
		{
			for (j=0;j<ConflictWeapons.length;j++)
			{
				if (class<ConflictItem>(DynamicLoadObject(ConflictWeapons[j].ClassName, class'Class')) == None)
					continue;
				Potentials[Potentials.length] = ConflictWeapons[j].ClassName;
				if (LoadoutOption == 1)
				{
					BandWidth[Potentials.length-1] = 3;
					BandTotal += BandWidth[Potentials.length-1];
				}
			}
			bAddedMiscs = true;
		}
		Size = GetItemSize(W);

		if (Size + SpaceUsed > MaxInventorySize)
			continue;
		CLRI.Loadout[CLRI.Loadout.length] = ClassName;
		CLRI.Layouts[CLRI.Loadout.length] = "255";
		CLRI.Camos[CLRI.Loadout.length] = "255";
		SpaceUsed += Size;
	}
}

// Do not spawn a default weapon yet...
function class<Weapon> MyDefaultWeapon()
{
	return None;
}

function Class<Inventory> GetInventoryClass(string InventoryClassName)
{
	return None;
}

static function SpawnAmmo(class<Ammunition> newClass, Pawn P, optional float Multiplier)
{
	local Ammunition Ammo;

	if (P==None || newClass == None)
		return;
	Ammo = Ammunition(P.FindInventoryType(newClass));
	if(Ammo == None)
    {
		Ammo = P.Spawn(newClass);
		P.AddInventory(Ammo);
    }
	if(Ammo == None)
		return;
    if (Multiplier > 0)
		Ammo.AddAmmo(Ammo.InitialAmount*Multiplier);
    else
		Ammo.AddAmmo(Ammo.InitialAmount);
	Ammo.GotoState('');
}

	/*
function string GetRandomWeapon (ConflictLoadoutLRI CLRI)
{
	local int i;
	local array<string> Potentials;

	for (i=0; i<ConflictWeapons.length; i++)
		if (CLRI.TeamAllowed(ConflictWeapons[i]) && CLRI.WeaponRequirementsOk(FullRequirementsList[i]) )
		{
			if (class<Weapon>(DynamicLoadObject(ConflictWeapons[i].ClassName, class'class')) != None)
				Potentials[Potentials.length] = ConflictWeapons[i].ClassName;
		}

	if (Potentials.length < 1)
		return "";
	return Potentials[Rand(Potentials.length)];
}
	*/

function string GetFallbackWeapon (ConflictLoadoutLRI CLRI)
{
	return "BallisticProV55.SARAssaultRifle";
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j;
	local float OMA, NMA;
	local class<actor> NewItem;
	local BallisticPlayerReplicationInfo BPRI;

	local LinkedReplicationInfo LPRI;
	
	bSuperRelevant = 0;
	
	if(Controller(Other) != None && InStr(Caps(Level.Game.GameName),"FREON") == -1 && InStr(Caps(Level.Game.GameName),"ARENAMASTER") == -1) //bypass this in 3SPN, handled differently
	{
		if (PlayerController(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || bForceBallisticPawn))
			PlayerController(Other).PawnClass = class'BallisticPawn';
		else if (Bot(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || bForceBallisticPawn))
			Bot(Other).PreviousPawnClass = class'BallisticPawn';
	}
	
	//shunt the lris down to make way for this one
	else if (PlayerReplicationInfo(Other) != None)
	{
		BPRI = Spawn(class'ConflictLoadoutLRI', Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			lPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
			
			//this should be impossible?
			if (BPRI.NextReplicationInfo != None)
				BPRI.NextReplicationInfo.NextReplicationInfo = lPRI;
			else
				BPRI.NextReplicationInfo = lPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
	}
	
	// void required equipment before AddDefaultInventory call
	// we can't access the PlayerReplicationInfo from this point,
	// forcing the use of ModifyPlayer to equip the pawn
	else if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = "";
		xPawn(Other).RequiredEquipment[1] = "";
		return true;
	}

	// No weapon pickups unless they are dropped. Dropped BWs are owned by the weapon that dropped them
	else if (WeaponPickup(Other) != None && Other.Owner == None)
		return false;
	// No ammo pickups
	else if (Ammo(Other) != None && IP_AmmoPack(Other) == None)
	{
		Pickup(Other).myMarker.bBlocked = True;
		return false;
	}
	// Lockers replaced with ammo packs
	else if (WeaponLocker(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
		{
			WeaponLocker(Other).myMarker.bBlocked = True;
			Other.GotoState('Disabled');
			return false;
		}
	}
	// No bases. Weapon pickups replaced with ammo packs
	else if (xWeaponBase(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
			return false;
	}
	else if (xPickupBase(Other) != None)
	{
		Other.bHidden=true;
		if (xPickupBase(Other).myMarker != None)
			xPickupBase(Other).myMarker.bBlocked = True;
		if (xPickupBase(Other).myEmitter != None)
			xPickupBase(Other).myEmitter.Destroy();
	}
	
	else if (JumpSpot(Other) != None && BallisticRep != None && !BallisticRep.bAllowDodging)
	{
		JumpSpot(Other).bDodgeUp = false;
	}
	else
	{
	//Go through replacements list and see if there is a match
	for (i=0;i<Replacements.Length;i++)
	{
		// Swap weapons
		if (Weapon(Other) != None)
		{
			if (GetInventoryFor(Replacements[i].OldItem) == Weapon(Other).Class && (!Replacements[i].bSuper || !bLeaveSuper))
				SwapWeapon(Other, GetInventoryFor(Replacements[i].NewItems[Rand(Replacements[i].NewItems.length)]));
		}
		// Replace Weapon base
		else if (xWeaponBase(Other) != None && xWeaponBase(Other).WeaponType != None && xWeaponBase(Other).WeaponType == GetInventoryFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
		{
			if (Replacements[i].bUseBase)
			{
				NewItem = GetNewItem(i);
				xWeaponBase(Other).WeaponType = class<weapon>(GetInventoryFor(NewItem));
				xWeaponBase(Other).PowerUp = GetPickupFor(NewItem);
			}
			else if (!SpawnNewItem(i, Other))
				return false;
		}
		// Change pickup classes for WildcardBases
		else if (WildcardBase(Other) != None)
		{
//			Other.bHidden = true;
			for(j=0;j<ArrayCount(WildcardBase(Other).PickupClasses);j++)
			{
				if (WildcardBase(Other).PickupClasses[j] != None && WildcardBase(Other).PickupClasses[j] == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper) && class<TournamentPickup>(GetPickupFor(GetNewItem(i))) != None)
					WildcardBase(Other).PickupClasses[j] = class<TournamentPickup>(GetPickupFor(GetNewItem(i)));
			}
		}
		// Replace Pickup base
		else if (xPickupBase(Other) != None && xPickupBase(Other).PowerUp != None && xPickupBase(Other).PowerUp == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
		{
			if (Replacements[i].bUseBase)
				xPickupBase(Other).PowerUp = GetPickupFor(GetNewItem(i));
			else if (!SpawnNewItem(i, Other))
				return false;
		}
		// Change weapons in weaponlockers
		else if (WeaponLocker(Other) != None && (!Replacements[i].bSuper || !bLeaveSuper))
		{
			for (j=0;j<WeaponLocker(Other).Weapons.Length;j++)
			{
				if (WeaponLocker(Other).Weapons[j].WeaponClass == GetInventoryFor(Replacements[i].OldItem))
				{
					NewItem = GetNewItem(i);
					OMA = WeaponLocker(Other).Weapons[j].WeaponClass.default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;
					NMA = class<weapon>(GetInventoryFor(NewItem)).default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;
					WeaponLocker(Other).Weapons[j].ExtraAmmo = NMA * (WeaponLocker(Other).Weapons[j].ExtraAmmo / OMA);
					WeaponLocker(Other).Weapons[j].ExtraAmmo *= 2;
					WeaponLocker(Other).Weapons[j].WeaponClass = class<weapon>(GetInventoryFor(NewItem));
				}
			}
		}
		else if (Pickup(Other) != None && Pickup(Other).Class == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
			AddPickupSwap(Pickup(Other), i);
	}
	}
	return true;
}

defaultproperties
{
     LoadoutOptionText(0)="Standard"
     LoadoutOptionText(1)="Evolution"
	 LoadoutOptionText(2)="Purchasing (NOT IMPLEMENTED)"
     ConfigMenuClassName="BallisticProV55.ConfigMenu_Inventory"
     FriendlyName="BallisticPro: Conflict Loadout"
     Description="Play Ballistic Weapons with an expanded loadout system supporting Evolution configuration and inventory space."
	 
}
