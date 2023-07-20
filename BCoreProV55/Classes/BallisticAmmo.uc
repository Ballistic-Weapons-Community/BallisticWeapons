//=============================================================================
// BallisticAmmo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticAmmo extends Ammunition;

var AmmoParams	Params[4];

static final function bool ResuppliesFromPack()
{
	return default.Params[class'BallisticReplicationInfo'.default.GameStyle].bResuppliesFromPack;
}

static final function float GetKillInitialAmmoMult()
{
	return default.Params[class'BallisticReplicationInfo'.default.GameStyle].KillInitialAmmoMult;
}

static final function int GetKillResupplyAmmo()
{
    if (default.InitialAmount > 0)
	    return default.InitialAmount * GetKillInitialAmmoMult(); // usually one mag
        
    return default.MaxAmmo * GetKillInitialAmmoMult() * 0.5f;
}

function bool AddAmmo(int AmmoToAdd)
{
	if (Pawn(Owner) != None && Pawn(Owner).DrivenVehicle != None && BallisticTurret(Pawn(Owner).DrivenVehicle) != None &&
		!BallisticTurret(Pawn(Owner).DrivenVehicle).DriverGetAmmo(self, AmmoToAdd))
		return true;

	return super.AddAmmo(AmmoToAdd);
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
