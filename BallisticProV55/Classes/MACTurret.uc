//=============================================================================
// MACTurret.
//
// Turret for the HAMR
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACTurret extends BallisticTurret;

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
	{
		return 0;
	}

	if (bKeyVehicle)
		return 100;

	return MaxDesireability * 0.5 + (MaxDesireability * 0.5) * (MagAmmoAmount / 900.0);
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

simulated event Tick(float DT)
{
    local rotator newRot;

	if (Driver != None && bDriving)
	{
		if (level.netMode != NM_DedicatedServer)
		{
			newRot = Rotator(RightHandlePosition() - Driver.GetBoneCoords('Bip01 R UpperArm').Origin);
			Driver.SetBoneDirection('Bip01 R UpperArm', newRot,, 0.4, 1);
		}
	}
	Super.Tick(DT);
}

simulated event DrivingStatusChanged()
{
	local int i;

	super.DrivingStatusChanged();

	if (!bDriving && OldDriver != None)
	{
		OldDriver.bNoWeaponFiring = false;
		OldDriver.SetBoneDirection('Bip01 R UpperArm', Rotation,, 0, 0);
		if(IsLocallyControlled())
		{
			if(OldDriver.Controller != None)
				OldDriver.Controller.bRun = 0;
		}

		if(MACWeapon(Weapon) != None)
		{
			for (i=0;i<MACWeapon(Weapon).Beacons.length;i++)
			{
				if (MACWeapon(Weapon).Beacons[i].Trail != None)
					MACWeapon(Weapon).Beacons[i].Trail.bHidden = true;
				if (MACWeapon(Weapon).Beacons[i].Sphere != None)
					MACWeapon(Weapon).Beacons[i].Sphere.bHidden = true;
			}
		}
	}
}

function AdjustDriverDamage(out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if ( InGodMode() )
 		Damage = 0;

	/*
	else if (DamageType.default.bLocationalHit && CheckDefense(instigatedBy.Location))
 		Damage *= DriverDamageMult;
	*/
	
	Momentum = vect(0,0,0);
}

defaultproperties
{
     UndeployedWeaponName="BallisticProV55.MACWeapon"
     WeaponClassName="BallisticProV55.MACWeapon_TW"
     GunPitchBounds=(Max=10000.000000)
     CamPitchBounds=(Min=-5000.000000)
     GunYawSpeed=16000.000000
     GunPitchSpeed=12000.000000
     CamYawSpeed=24000.000000
     CamPitchSpeed=24000.000000
     CameraOffset=(X=-52.000000,Z=14.000000)
     CameraElevation=26.000000
     GunBone="GunSlide"
     PivotBone="StandPivot"
     bDrawDriverInTP=True
     VehicleNameString="J2329-HAMR Turret"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_HAMRTurret'
     DrawScale=0.250000
     PrePivot=(Z=8.000000)
     CollisionHeight=32.000000
}
