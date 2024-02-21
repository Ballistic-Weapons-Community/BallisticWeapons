//=============================================================================
// XMV850Turret.
//
// Turret for the XMV850 minigun. In this mode, its much more deadly
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV850Turret extends BallisticTurret;

function SetAbandoned();

function InitTurretWeapon(Weapon Weap)
{
	local Ammunition A;
	if (Driver != None)
	{
		A = Ammunition(Driver.FindInventoryType(Weap.GetAmmoClass(0)));
		if (A == None)
		{
			A = Driver.Spawn(Weap.GetAmmoClass(0), Driver);
			Driver.AddInventory(A);
//			if (BallisticWeapon(Weap).bNoReloading)
			if (class'BallisticReplicationInfo'.default.bNoReloading)
				A.AmmoAmount = BallisticWeapon(Weap).MagAmmo;
			else
				A.AmmoAmount = 0;
			AmmoAmount[0] = A.AmmoAmount;
		}
		else
        	AmmoAmount[0] = A.AmmoAmount;

	}
	super.InitTurretWeapon(Weap);
}

function SaveTurretWeaponInfo()
{
	local Ammunition A;

	super.SaveTurretWeaponInfo();
	if (Driver != None && Weapon != None)
	{
		A = Ammunition(Driver.FindInventoryType(Weapon.GetAmmoClass(0)));
		if (A == None)
		{
			A = Driver.Spawn(Weapon.GetAmmoClass(0), Driver);
			Driver.AddInventory(A);
			A.AmmoAmount = AmmoAmount[0];
		}
		else
        	A.AmmoAmount = AmmoAmount[0];

	}
}

//return a value indicating how useful this vehicle is to bots
function float BotDesireability(Actor S, int TeamIndex, Actor Objective)
{
//	local Ammunition A;

	if (Health <= 0 || Occupied() /*|| (bTeamLocked && !bSameTeam)*/)
		return 0;

//	BotsNextDesireTime = level.timeseconds + 30;

	if (MagAmmoAmount == 0 && BotsNextDesireTime > level.timeseconds)
	{
		return 0;
	}

	if (bKeyVehicle)
		return 100;

	return MaxDesireability * 0.5 + (MaxDesireability * 0.5) * (MagAmmoAmount / 900.0);
}

defaultproperties
{
     UndeployedWeaponName="BallisticProV55.XMV850Minigun"
     WeaponClassName="BallisticProV55.XMV850Minigun_TW"
     GunBone="Minigun"
     PivotBone="StandBase"
     bDrawDriverInTP=True
     VehicleNameString="Mounted XMV-850 Minigun"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_XMV850Turret'
     DrawScale=0.350000
     CollisionHeight=22.400000
}
