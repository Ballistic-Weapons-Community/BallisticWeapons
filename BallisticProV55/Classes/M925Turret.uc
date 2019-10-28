//=============================================================================
// M925Turret.
//
// Vehicle pawn for deployed M925 machinegun. Uses turret version of M925 weapon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M925Turret extends BallisticTurret;

simulated function vector CalcDrawOffset(inventory Inv)
{
	return vect(0,0,1) * (Inv.CollisionHeight - CollisionHeight);
}

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

function float BotDesireability(Actor S, int TeamIndex, Actor Objective)
{
	if (Health <= 0 || Occupied() /*|| (bTeamLocked && !bSameTeam)*/)
		return 0;

	if (MagAmmoAmount == 0 && BotsNextDesireTime > level.timeseconds)
		return 0;

	if (bKeyVehicle)
		return 100;

	return MaxDesireability * 0.5 + (MaxDesireability * 0.5) * (MagAmmoAmount / 50.0);
}

defaultproperties
{
     UndeployedWeaponName="BallisticProV55.M925Machinegun"
     WeaponClassName="BallisticProV55.M925Machinegun_TW"
     GunYawBounds=(Min=-12000.000000,Max=12000.000000)
     GunPitchBounds=(Min=-10000.000000,Max=8192.000000)
     CamYawBounds=(Min=-12000.000000,Max=12000.000000)
     CamPitchBounds=(Max=12000.000000)
     GunYawSpeed=24000.000000
     GunPitchSpeed=32768.000000
     CamTrackYawSpeed=32768.000000
     CamTrackPitchSpeed=32768.000000
     AbandonedPitch=2600
     CameraOffset=(X=-55.000000,Y=-9.000000,Z=23.000000)
     CameraElevation=5.000000
     GunBone="M925"
     PivotBone="StandPivot"
     DriverBackOff=45.000000
     bDrawDriverInTP=True
     VehicleNameString="M925 Machinegun Turret"
     Mesh=SkeletalMesh'BallisticAnims2.M925Turret-3rd'
     DrawScale=0.180000
     CollisionHeight=15.000000
}
