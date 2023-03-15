//=============================================================================
// XMV500AutoTurret.
//
// Auto Turret for the XMB-500 minigun.
// By itself, the turret will scan for enemies in its FOV.
// The user can possess the turret by using scope fire while holding the XMB.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV500AutoTurret extends BallisticAutoTurret;

function SetAbandoned();

function InitAutoTurretWeapon(Weapon Weap)
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
     //DefaultWeaponClassName="BWBP_SKC_Pro.XMV500Minigun_TW"
     //AutoTurretControllerClass=Class'UT2k4AssaultFull.LinkTurretController'
	 TargetAcquiredSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn'
	 UndeployedWeaponName="BWBP_SKC_Pro.XMV500Minigun"
     WeaponClassName="BWBP_SKC_Pro.XMV500Minigun_TW"
     GunBone="Minigun"
     PivotBone="StandBase"
     bDrawDriverInTP=True
     VehicleNameString="[B] XMB-500 Sentry Gun"
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.XMB501Turret_TPm'
     DrawScale=0.350000
     CollisionHeight=22.400000
	 

     //TurretBaseClass=Class'UT2k4AssaultFull.ASTurret_LinkTurret_Base'
     //TurretSwivelClass=Class'UT2k4AssaultFull.ASTurret_LinkTurret_Swivel'
     RotationInertia=0.500000
     RotPitchConstraint=(Min=8000.000000,Max=5000.000000)
     RotationSpeed=5.000000
     CamRelLocation=(X=250.000000,Z=150.000000)
     CamDistance=(Z=0.000000)
     ZoomWeaponOffsetAdjust=275.000000
     WeaponInfoTexture=Texture'AS_FX_TX.HUD.SpaceHUD_Weapon_Solid_Skaarj'
     DefaultWeaponClassName="UT2k4AssaultFull.Weapon_LinkTurret"
     VehicleProjSpawnOffset=(X=220.000000,Y=0.000000,Z=15.000000)
     bCHZeroYOffset=False
     bRelativeExitPos=False
     bHideRemoteDriver=False
     AutoTurretControllerClass=Class'UT2k4AssaultFull.LinkTurretController'
     DriveAnim="Biggun_Aimed"
     VehiclePositionString="manning a Link Turret"
     //VehicleNameString="Link Turret"
     HealthMax=400.000000
     Health=400
     //Mesh=SkeletalMesh'AS_VehiclesFull_M.LinkBody'
     //DrawScale=0.300000
     //CollisionHeight=116.000000
     bNetNotify=True
}
