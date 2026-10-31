//=============================================================================
// BallisticAmmo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticAmmo extends Ammunition;

var AmmoParams	Params[4];
var bool		bScalesAsMagazine;	// The guns that use this have no magazine: Magazine Size Scale acts on this ammo instead

static final function bool ResuppliesFromPack()
{
	return default.Params[class'BallisticReplicationInfo'.default.GameStyle].bResuppliesFromPack;
}

static final function float GetKillInitialAmmoMult()
{
	return default.Params[class'BallisticReplicationInfo'.default.GameStyle].KillInitialAmmoMult;
}

// The most a player can carry
static final function int GetScaledMaxAmmo()
{
	if (default.bScalesAsMagazine)
		return class'BallisticReplicationInfo'.static.ScaleMagAmmo(default.MaxAmmo);
	return default.MaxAmmo;
}

// What a new gun comes with. A scale under 1 only brings it down to the cap: one HVPC Mk66 shot can take 100 cells
static final function int GetScaledInitialAmount()
{
	if (default.bScalesAsMagazine)
		return Min(Max(default.InitialAmount, class'BallisticReplicationInfo'.static.ScaleMagAmmo(default.InitialAmount)), GetScaledMaxAmmo());
	return default.InitialAmount;
}

static final function int GetKillResupplyAmmo()
{
    if (default.InitialAmount > 0)
	    return GetScaledInitialAmount() * GetKillInitialAmmoMult(); // usually one mag
        
    return GetScaledMaxAmmo() * GetKillInitialAmmoMult() * 0.5f;
}

// On clients too: MaxAmmo isn't replicated
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	MaxAmmo = GetScaledMaxAmmo();
	InitialAmount = GetScaledInitialAmount();
}

function bool AddAmmo(int AmmoToAdd)
{
	if (Pawn(Owner) != None && Pawn(Owner).DrivenVehicle != None && BallisticTurret(Pawn(Owner).DrivenVehicle) != None &&
		!BallisticTurret(Pawn(Owner).DrivenVehicle).DriverGetAmmo(self, AmmoToAdd))
		return true;

	return super.AddAmmo(AmmoToAdd);
}

simulated function CheckOutOfAmmo()
{
	if (AmmoAmount <= 0 && Pawn(Owner) != None && Pawn(Owner).Weapon != None)
		Pawn(Owner).Weapon.OutOfAmmo();
}

defaultproperties
{
	MaxAmmo=180
	InitialAmount=30
	PickupClass=Class'BCoreProV55.BallisticAmmoPickup'
	ItemName="Ballistic Ammo"

	Begin Object Class=AmmoParams Name=Def_ArenaParams
		KillInitialAmmoMult=0.34f
		bResuppliesFromPack=True
	End Object

	Begin Object Class=AmmoParams Name=Def_ClassicParams
		KillInitialAmmoMult=0.34f
		bResuppliesFromPack=True
	End Object

	Begin Object Class=AmmoParams Name=Def_RealismParams
		KillInitialAmmoMult=0.34f
		bResuppliesFromPack=True
	End Object

	Begin Object Class=AmmoParams Name=Def_TacticalParams
		KillInitialAmmoMult=0.34f
		bResuppliesFromPack=True
	End Object

	Params[0]=Def_ArenaParams
	Params[1]=Def_ClassicParams
	Params[2]=Def_RealismParams
	Params[3]=Def_TacticalParams
}
