//=============================================================================
// Mointed MG36 Turret.
//
// Vehicle pawn for deployed MG36
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36Turret extends BallisticTurret;

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
     UndeployedWeaponName="BWBP_SKC_Pro.MG36Machinegun"
     WeaponClassName="BWBP_SKC_Pro.MG36MG_TW"
     GunYawBounds=(Min=-6000.000000,Max=6000.000000)
     GunPitchBounds=(Min=-8192.000000,Max=8192.000000)
     CamYawBounds=(Min=-6000.000000,Max=6000.000000)
     CamPitchBounds=(Min=-8192.000000,Max=8192.000000)
     GunYawSpeed=24000.000000
     GunPitchSpeed=32768.000000
     CamTrackYawSpeed=32768.000000
     CamTrackPitchSpeed=32768.000000
     AbandonedPitch=2000
     CameraOffset=(X=-60.000000,Y=-15.000000,Z=20.000000)
	 DriverOffset=(X=0,Y=0,Z=0)
     CameraElevation=5.000000
     GunBone="Weapon"
     PivotBone="StandPivot"
     DriverBackOff=100.000000
     bDrawDriverInTP=True
     VehicleNameString="MG36 Mounted Machinegun"
     Mesh=SkeletalMesh'BWBP_SKC_Anim.MG36_Turret_TPm'
     DrawScale=0.320000
     CollisionHeight=18.000000
}
