//-----------------------------------------------------------
//
//-----------------------------------------------------------
class DCTVThorTankCannon extends ONSHoverTankCannon;

var() Sound TurretTurnSound;
var   float	TurretStopTurnSoundTime;
var   int	LastTurretYaw;

function Projectile SpawnProjectile(class<Projectile> ProjClass, bool bAltFire)
{
    local Projectile P;
    local ONSWeaponPawn WeaponPawn;
    local vector StartLocation, HitLocation, HitNormal, Extent;

    if (bDoOffsetTrace)
    {
       	Extent = ProjClass.default.CollisionRadius * vect(1,1,0);
        Extent.Z = ProjClass.default.CollisionHeight;
       	WeaponPawn = ONSWeaponPawn(Owner);
    	if (WeaponPawn != None && WeaponPawn.VehicleBase != None)
    	{
    		if (!WeaponPawn.VehicleBase.TraceThisActor(HitLocation, HitNormal, WeaponFireLocation, WeaponFireLocation + vector(WeaponFireRotation) * (WeaponPawn.VehicleBase.CollisionRadius * 1.5), Extent))
			StartLocation = HitLocation;
		else
			StartLocation = WeaponFireLocation + vector(WeaponFireRotation) * (ProjClass.default.CollisionRadius * 1.1);
	}
	else
	{
		if (!Owner.TraceThisActor(HitLocation, HitNormal, WeaponFireLocation, WeaponFireLocation + vector(WeaponFireRotation) * (Owner.CollisionRadius * 1.5), Extent))
			StartLocation = HitLocation;
		else
			StartLocation = WeaponFireLocation + vector(WeaponFireRotation) * (ProjClass.default.CollisionRadius * 1.1);
	}
    }
    else
    	StartLocation = WeaponFireLocation;

//	GetAxes(WeaponFireRotation, X, Y, Z);

    P = spawn(ProjClass, self, , StartLocation + (vect(0,32,0)>>WeaponFireRotation), WeaponFireRotation);

    if (P != None)
    {
        if (bInheritVelocity)
            P.Velocity = Instigator.Velocity;
    }

    P = spawn(ProjClass, self, , StartLocation + (vect(0,-32,0)>>WeaponFireRotation), WeaponFireRotation);

    if (P != None)
    {
        if (bInheritVelocity)
            P.Velocity = Instigator.Velocity;

        FlashMuzzleFlash();

        // Play firing noise
        if (bAltFire)
        {
            if (bAmbientAltFireSound)
                AmbientSound = AltFireSoundClass;
            else
                PlayOwnedSound(AltFireSoundClass, SLOT_None, FireSoundVolume/255.0,, AltFireSoundRadius,, false);
        }
        else
        {
            if (bAmbientFireSound)
                AmbientSound = FireSoundClass;
            else
                PlayOwnedSound(FireSoundClass, SLOT_None, FireSoundVolume/255.0,, FireSoundRadius,, false);
        }
    }

    return P;
}

simulated event Tick(float DT)
{
	local Rotator R;

	super.Tick(DT);

	R = GetBoneRotation(YawBone);
	R = Normalize(R - Rotation);
	if (Abs(R.Yaw - LastTurretYaw) / DT > 2048)
//	if (R.Yaw != LastTurretYaw)
		TurretStopTurnSoundTime = level.Timeseconds + 0.15;
	LastTurretYaw = R.Yaw;

	if (level.Timeseconds >= TurretStopTurnSoundTime)
		AmbientSound = None;
	else
		AmbientSound = TurretTurnSound;
}

defaultproperties
{
     TurretTurnSound=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankTurret'
     YawBone="Turret"
     PitchBone="Cannon"
     PitchUpLimit=8000
     PitchDownLimit=62000
     WeaponFireAttachmentBone="Muzzle"
     WeaponFireOffset=0.000000
     RotationsPerSecond=0.080000
     RedSkin=Texture'BWBP_Vehicles_Tex.ThorTank.Tank'
     BlueSkin=Texture'BWBP_Vehicles_Tex.ThorTank.TankBlue'
     EffectEmitterClass=Class'BWBP_VPC_Pro.DCTVThorMuzzleFlash'
     FireSoundClass=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankCannon'
     ProjectileClass=Class'BWBP_VPC_Pro.DCTVThorTankShell'
     AIInfo(0)=(bTossed=True)
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.ThorTankTurret'
     SoundVolume=192
     SoundPitch=32
}
