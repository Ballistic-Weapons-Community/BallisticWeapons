//=============================================================================
// Mointed M99 Turret.
//
// Vehicle pawn for deployed M99 sniepr.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M99Turret extends BallisticTurret;

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
     UndeployedWeaponName="BWBP_JCF_Pro.M99Rifle"
     WeaponClassName="BWBP_JCF_Pro.M99_TW"
     GunYawBounds=(Min=-12000.000000,Max=12000.000000)
     GunPitchBounds=(Min=-2000.000000,Max=2000.000000)
     CamYawBounds=(Min=-12000.000000,Max=12000.000000)
     CamPitchBounds=(Min=-2000.000000,Max=2000.000000)
     GunYawSpeed=24000.000000
     GunPitchSpeed=32768.000000
     CamTrackYawSpeed=32768.000000
     CamTrackPitchSpeed=32768.000000
     AbandonedPitch=2600
     CameraOffset=(X=-75.000000,Y=-10.000000,Z=30.000000)
	 CameraElevation=5.000000
     GunBone="Weapon"
     PivotBone="StandPivot"
     DriverBackOff=65.000000
     bDrawDriverInTP=True
     VehicleNameString="M99 Mounted ECS Anti-MaterialRifle"
     Mesh=SkeletalMesh'BWBP_JCF_Anims.M99Turret_TPm'
     DrawScale=0.300000
     CollisionHeight=18.000000
}
