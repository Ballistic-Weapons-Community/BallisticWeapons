//=============================================================================
// Mointed FG50 Turret.
//
// Vehicle pawn for deployed FG50 sniepr.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class FG50Turret extends BallisticTurret;


function Fire( optional float F )
{
	super.Fire();
	if (Weapon!=None)
		Weapon.Fire(F);
}
function AltFire( optional float F )
{
	super.AltFire();
	if (Weapon!=None)
		Weapon.AltFire(F);
}

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

simulated function NextWeapon()
{
	if (Weapon != None && BallisticWeapon(Weapon) != None)
		super(Pawn).NextWeapon();
	else
		super.NextWeapon();
}

simulated function PrevWeapon()
{
	if (Weapon != None && BallisticWeapon(Weapon) != None)
		super(Pawn).PrevWeapon();
	else
		super.PrevWeapon();
}

defaultproperties
{
     UndeployedWeaponName="FG50MachineGun"
     WeaponClassName="FG50MG_TW"
     GunYawBounds=(Min=-7000.000000,Max=7000.000000)
     GunPitchBounds=(Min=-4000.000000,Max=4000.000000)
     CamYawBounds=(Min=-7000.000000,Max=7000.000000)
     CamPitchBounds=(Min=-4000.000000,Max=4000.000000)
     GunYawSpeed=24000.000000
     GunPitchSpeed=24000.000000
     CamTrackYawSpeed=24000.000000
     CamTrackPitchSpeed=24000.000000
     AbandonedPitch=2600
     CameraOffset=(X=-90.000000,Y=-14.000000,Z=14.000000)
     GunBone="GunPitch"
     PivotBone="Pitch"
     DriverBackOff=100.000000
     VehicleNameString="FG50 Mounted MG"
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.X83A1_Turret_3rd'
     DrawScale=0.420000
     CollisionHeight=18.000000
}
