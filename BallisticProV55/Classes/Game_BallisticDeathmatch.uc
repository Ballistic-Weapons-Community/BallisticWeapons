//=============================================================================
// Game_BallisticDeathmatch.
//
// Ballistic adjustment for standard DeathMatch.
// This class also holds a lot of teh stuff used by the other Ballistic
// altered gametypes.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Game_BallisticDeathmatch extends xDeathMatch
	transient
	HideDropDown
	CacheExempt;

var const localized string	BallisticGroup;

var   globalconfig string	InventoryMode;		// The mutator to use for modifying pickups and how inventory is acquired
var() localized Array<string>	InventoryModes;	// Display Text associated with Inventory mutator options
var() Array<string>			InventoryMuts;		// Mutators used to modify inventory and pickups. Only one is used at a time

var	  globalconfig string	ArenaConfigVar;		// Just some var for the arena config setting
var	  globalconfig string	BWConfigVar;		// Just some var for the ballistic config setting

var   localized string		ModeDisplayText,ModeDescText,ArenaConfigDisplayText,ArenaConfigDescText,BWConfigDisplayText,BWConfigDescText;

const BWHintCount = 21;
var(LoadingHints) private localized string BWHints[BWHintCount];

function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player)
{
    local PlayerStart P;
    local float Score, Dist;
    local Controller OtherPlayer;

    P = PlayerStart(N);

    if ( (P == None) || !P.bEnabled/* || P.PhysicsVolume.bWaterVolume */)
        return -10000000;
    if ( P.bPrimaryStart )
		Score = 20000;
    if ( (N == LastStartSpot) || (N == LastPlayerStartSpot) )
        Score -= 5000.0;
    else
        Score += 1000 * FRand(); //randomize

    for ( OtherPlayer=Level.ControllerList; OtherPlayer!=None; OtherPlayer=OtherPlayer.NextController)
        if ( OtherPlayer.bIsPlayer && (OtherPlayer.Pawn != None) )
        {
            if ( OtherPlayer.Pawn.Region.Zone == N.Region.Zone )
                Score -= 100;
			Dist = VSize(OtherPlayer.Pawn.Location - N.Location);
            if ( Dist < OtherPlayer.Pawn.CollisionRadius + OtherPlayer.Pawn.CollisionHeight )
                Score -= 15000;
			if (FastTrace(N.Location, OtherPlayer.Pawn.Location))
				Dist *= 0.2;
			Score += Dist;
        }
    return Score;
}

static function byte BallisticAllowMutator( string MutatorClassName )
{
	local int i;

	for (i=0;i<default.InventoryMuts.length;i++)
		if (MutatorClassName ~= default.InventoryMuts[i])
			return 1;

	if (InStr(MutatorClassName, "Mut_Ballistic") >= 0)
		return 0;
	if (InStr(MutatorClassName, "Mut_Outfitting") >= 0)
		return 0;
//	if (InStr(MutatorClassName, "Mut_BallisticArena") >= 0)
//		return 0;
//	if (InStr(MutatorClassName, "Mut_BallisticMelee") >= 0)
//		return 0;
	if (InStr(MutatorClassName, "Mut_Itemizer") >= 0)
		return 0;

	return 2;
}

static function bool AllowMutator( string MutatorClassName )
{
	local byte bAllow;

	bAllow = BallisticAllowMutator( MutatorClassName );
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

static function FillBallisticPlayInfo(PlayInfo PlayInfo)
{
	local string s;
	local int i;

	for (i=0;i<default.InventoryMuts.length;i++)
	{
		if (s == "")
			s = default.InventoryMuts[i];
		else
			s = s $ ";" $ default.InventoryMuts[i];
		s $= ";" $ default.InventoryModes[i];
	}

	PlayInfo.AddSetting(default.BallisticGroup, "InventoryMode", default.ModeDisplayText, 0, 1, "Select", s);
	PlayInfo.AddSetting(default.BallisticGroup, "ArenaConfigVar", default.ArenaConfigDisplayText, 60, 2, "Custom", ";;BallisticProV55.BallisticArenaMenu");
	PlayInfo.AddSetting(default.BallisticGroup, "BWConfigVar", default.BWConfigDisplayText, 60, 2, "Custom", ";;BallisticProV55.ConfigMenu_Rules");
//	Playinfo.AddSetting("Group", "Prop", "Description", SecLevel, Weight, "RenderType", "Extras", "ExtraPrivs", bMultiOnly, bAdvanced);
}

static function string GetBallisticDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "InventoryMode":		return default.ModeDescText;
		case "ArenaConfigVar":		return default.ArenaConfigDescText;
		case "BWConfigVar":			return default.BWConfigDescText;
	}
	return "";
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	FillBallisticPlayInfo(PlayInfo);
}
static event string GetDescriptionText(string PropName)
{
	local string s;

	s = GetBallisticDescriptionText(PropName);
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

static function string GetNextLoadHint( string MapName )
{
	local array<string> Hints;

	// Higher chance that we'll pull a loading hint from our own gametype
	if ( Rand(100) < 90 )
		Hints = GetAllLoadHints(true);
	else Hints = GetAllLoadHints();

	if ( Hints.Length > 0 )
		return Hints[Rand(Hints.Length)];

	return "";
}

static function array<string> GetAllLoadHints(optional bool bThisClassOnly)
{
	local int i;
	local array<string> Hints;

	if ( !bThisClassOnly )
		Hints = Super.GetAllLoadHints();

	for ( i = 0; i < BWHintCount; i++ )
		Hints[Hints.Length] = default.BWHints[i];

	return Hints;
}

defaultproperties
{
     BallisticGroup="Ballistic"
     InventoryMode="BallisticProV55.Mut_BallisticDM"
     InventoryModes(0)="Normal"
     InventoryModes(1)="Loadout"
     InventoryModes(2)="Conflict"
     InventoryModes(3)="Arena"
     InventoryModes(4)="Melee"
     InventoryMuts(0)="BallisticProV55.Mut_BallisticDM"
     InventoryMuts(1)="BallisticProV55.Mut_OutfittingDM"
     InventoryMuts(2)="BallisticProV55.Mut_SpatialLoadoutDM"
     InventoryMuts(3)="BallisticProV55.Mut_BallisticArenaDM"
     InventoryMuts(4)="BallisticProV55.Mut_BallisticMeleeDM"
     ModeDisplayText="Inventory Mode"
     ModeDescText="Choose how you want pickups and inventory to be added to game."
     ArenaConfigDisplayText="Configure Arena"
     ArenaConfigDescText="Choose the weapons you want in the match for the Arena inventory mode."
     BWConfigDisplayText="Ballistic Settings"
     BWConfigDescText="Options for Ballistic Weapons."
     BWHints(0)="Reloading:|Most Ballistic weapons have a limited ammo capacity and need to be reloaded. This can be done by pressing %FIRE% when the weapon is empty or reloading it anytime by pressing %RELOAD%."
     BWHints(1)="Heavy Weapons:|Heavier weapons generally have more fire power, but are less manouverable and slow to reload."
     BWHints(2)="Special Functions for Weapons:|Many Ballistic weapons have a Special function which can be used by pressing %WeaponSpecial%."
     BWHints(3)="Fire Modes can help you:|Some Ballistic weapons have various fire modes to limit how a weapon fires. They help to keep a weapon under control and can be cycled by pressing %SwitchWeaponMode%."
     BWHints(4)="Melee Weapons:|Melee weapons have very short range, but they don't need ammo, require little aiming, improve player manouverability and generally have high damage."
     BWHints(5)="How to use Hand Grenades:|Grenades can be tossed by pressing %FIRE% or rolled with %ALTFIRE%. Their throw range can be varied by holding either fire and the clip can be released to time the detonation by pressing %RELOAD% or %WeaponSpecial%."
     BWHints(6)="Chaos is bad for Accuracy:|Running, jumping and sprinting apply chaos to your weapons, making it harder to aim. Crouching, walking and remaining still all improve weapon stability. The crosshair will show you how much chaos is affecting your aim."
     BWHints(7)="Not all Injuries are the same:|Headshots are much more deadly than normal with any weapon while shots to limbs are far less effective than normal."
     BWHints(8)="Machineguns:|Machineguns are powerful and fire continuously with a high ammo capacity, but they are heavy and badly affected by recoil. Their performance can be greatly improved by switching to stand mode with %ALTFIRE%, crouching and remaining stationary while firing."
     BWHints(9)="Sniper Rifles:|The sniper rifle is very powerful, accurate and has very long range, but it has a slow rate of fire and low clip capacity. The scope makes this weapon devastating at long range, but leaves the sniper vulnerable to unseen enemies nearby."
     BWHints(10)="How to use Sniper Scopes:|Several weapons have scopes to help aiming at long range. Pressing %ALTFIRE% will activate a scope and holding it down will zoom in further. Use %NEXTWEAPON% and %PREVWEAPON% to make further adjustments to the zoom level. Press %ALTFIRE% again to deactivate the scope."
     BWHints(11)="Recoil hurts your aim:|When most weapons fire, they create recoil which causes them to aim off. Recoil usually causes a weapon to pitch up and move slightly randomly. The effects of recoil are far worse on rapid fire weapons because they accumulate as the weapon is fired. The crosshair will reflect the recoil level."
     BWHints(12)="Energy Weapons:|Energy weapons are generally unaffected by recoil, but may have other disadvantages such as slow moving and easily visible projectiles or low damage."
     BWHints(13)="Fully Automatic Weapons:|Highly automatic, rapid fire weapons fire many rounds each second, making it easier to hit a target, but they also make it harder by quickly generating lots of recoil, ruining your aim."
     BWHints(14)="Shotguns:|Shotguns are extremely powerful and fire many pellets with a wide spread, making it easy to hit a target, but have a low rate of fire, slow reloading and a relatively short range. The closer the target, the more damage a shotgun will do."
     BWHints(15)="Ballistic Weapons Information can help you:|You can find out lots of information and specific details for each weapon in the weapons section of the game's options menu. You can also find out lots of information about Ballistic Weapons in the mod's manual."
     BWHints(16)="Learn the Recoil Behavior for individual weapons:|Recoil behaves very differently for each weapon. Some weapons will pitch straight up, while others will follow a winding path. Learning how recoil affects individual weapons can give you a real edge."
     BWHints(17)="Special functions for Melee Weapons:|You can use %WeaponSpecial% to throw a knife or block melee attacks with the sword and wrist blades."
     BWHints(18)="Tricks for the G5 Rocket Launcher:|Use the scope on the G5 to lock on to enemies. When the targeting box is active, rockets will be guided towards the target. Use the %WeaponSpecial% key to see a Rocket's Eye View of things. If an enemy rocket has locked on to you, shoot it down to avoid death."
     BWHints(19)="Mine Sweeping:|You can avoid triggering enemy mines by facing them and moving very slowly or crouching."
     BWHints(20)="The FP9 has many secrets:|The FP9A5 is a highly versatile explosive device that can be tossed or deployed on surfaces. It can be detonated by remote control or by means of its own trip laser. Master this device by learning all its controls and you will be able to set up very effective traps."
     DefaultPlayerClassName="BallisticProV55.BallisticPawn"
     DeathMessageClass=Class'BallisticProV55.Ballistic_DeathMessage'
     PlayerControllerClassName="BallisticProV55.BallisticPlayer"
     GameName="BallisticPro: DeathMatch"
     Description="Standard Deathmatch, but with Ballistic Weapons. Inventory acquisition can be via swapping, Loadout, Conflict Loadout or Arena. Alternatively, a melee-only game can be played. When playing Ballistic gametypes, Simple Death Messages will notify you of when players are using iron sights or scopes to kill each other."
     DecoTextName="BallisticProV55.Game_BallisticDeathmatch"
}
