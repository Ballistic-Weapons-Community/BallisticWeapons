//=============================================================================
// Game_BallisticTDM.
//
// Ballistic adjustment for Team Deathmatch
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Game_BallisticTDM extends xTeamGame
	transient
	HideDropDown
	CacheExempt;

var   globalconfig string	InventoryMode;		// The mutator to use for modifying pickups and how inventory is acquired
var() localized Array<string>	InventoryModes;	// Display Text associated with Inventory mutator options
var() Array<string>			InventoryMuts;		// Mutators used to modify inventory and pickups. Only one is used at a time

var	  globalconfig string	ArenaConfigVar;		// Just some var for the arena config setting
var	  globalconfig string	BWConfigVar;		// Just some var for the ballistic config setting

var   localized string		ModeDisplayText,ModeDescText;

static function bool AllowMutator( string MutatorClassName )
{
	local byte bAllow;

	bAllow = class'Game_BallisticDeathmatch'.static.BallisticAllowMutator( MutatorClassName );
	if (bAllow == 1)
		return true;
	else if (bAllow == 0)
		return false;
	return super.AllowMutator(MutatorClassName);
}

//Support for Simple Death Messages detecting whether a kill was from sights or not
function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> damageType)
{
    if ( (Killer == Other) || (Killer == None) )
        BroadcastLocalized(self,DeathMessageClass, 1, None, Other.PlayerReplicationInfo, damageType);
	else if (Killer.Pawn != None && BallisticWeapon(Killer.Pawn.Weapon) != None && BallisticWeapon(Killer.Pawn.Weapon).bHasPenetrated)
		BroadcastLocalized(self,DeathMessageClass, 3, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);	
    else if (Killer.Pawn != None && BallisticWeapon(Killer.Pawn.Weapon) != None && BallisticWeapon(Killer.Pawn.Weapon).bScopeView)
		BroadcastLocalized(self,DeathMessageClass, 2, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
    else BroadcastLocalized(self,DeathMessageClass, 0, Killer.PlayerReplicationInfo, Other.PlayerReplicationInfo, damageType);
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	class'Game_BallisticDeathmatch'.static.FillBallisticPlayInfo(PlayInfo);
}
static event string GetDescriptionText(string PropName)
{
	local string s;

	s = class'Game_BallisticDeathmatch'.static.GetBallisticDescriptionText(PropName);
	if (s != "")
		return s;
	return Super.GetDescriptionText(PropName);
}

event InitGame( string Options, out string Error )
{
	super.InitGame(Options, Error);

    if (InventoryMode != "")
    	AddMutator(InventoryMode);
}
event PlayerController Login( string Portal, string Options, out string Error )
{
	local PlayerController pc;

	pc = Super.Login(Portal, Options, Error);
	if (pc != None)
		pc.PawnClass = class'BallisticProV55.BallisticPawn';
	return pc;
}
function Bot SpawnBot(optional string botName)
{
	local Bot B;

	B = Super.SpawnBot(botName);
	if (B != None)
		B.PawnClass = class'BallisticProV55.BallisticPawn';
	return B;
}

static function array<string> GetAllLoadHints(optional bool bThisClassOnly)
{
	local int i;
	local array<string> Hints, Hints2;

	if ( !bThisClassOnly )
		Hints = Super.GetAllLoadHints();

	Hints2 = class'Game_BallisticDeathmatch'.static.GetAllLoadHints();
	for ( i = 0; i < Hints2.Length; i++ )
		Hints[Hints.Length] = Hints2[i];

	return Hints;
}

defaultproperties
{
     InventoryMode="BallisticProV55.Mut_BallisticDM"
     InventoryModes(0)="Normal"
     InventoryModes(1)="Loadout"
     InventoryModes(2)="Arena"
     InventoryModes(3)="Melee"
     InventoryMuts(0)="BallisticProV55.Mut_BallisticDM"
     InventoryMuts(1)="BallisticProV55.Mut_OutfittingDM"
     InventoryMuts(2)="BallisticProV55.Mut_BallisticArenaDM"
     InventoryMuts(3)="BallisticProV55.Mut_BallisticMeleeDM"
     ModeDisplayText="Pickup Mode"
     ModeDescText="Choose how you want pickups to be added to game"
     DefaultPlayerClassName="BallisticProV55.BallisticPawn"
     DeathMessageClass=Class'BallisticProV55.Ballistic_DeathMessage'
     PlayerControllerClassName="BallisticProV55.BallisticPlayer"
     GameName="BallisticPro: Team DM"
     Description="Standard Team Deathmatch with Ballistic Weapons in Normal, Loadout, Arena or Melee configuration and other features such as Dark Players."
     DecoTextName="BallisticProV55.Game_BallisticTDM"
}
