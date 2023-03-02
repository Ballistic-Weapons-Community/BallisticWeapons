//-----------------------------------------------------------
//Bomber weapon for Albatross
//-----------------------------------------------------------
class AlbatrossBomber extends ONSWeapon;

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Material'XEffects.RocketFlare');
    L.AddPrecacheMaterial(Material'AS_FX_TX.Trails.Trail_Blue');
    L.AddPrecacheMaterial(Material'EpicParticles.Flares.FlickerFlare');
    L.AddPrecacheMaterial(Material'WeaponSkins.Skins.RocketShellTex');
    L.AddPrecacheMaterial(Material'XEffects.RocketFlare');
    L.AddPrecacheMaterial(Material'AS_FX_TX.Trails.Trail_Blue');
    L.AddPrecacheMaterial(Material'ExplosionTex.Framed.SmokeReOrdered');
    L.AddPrecacheMaterial(Material'ExplosionTex.Framed.exp2_frames');
    L.AddPrecacheMaterial(Material'XEffects.Skins.Rexpt');
    L.AddPrecacheMaterial(Material'EmitterTextures.MultiFrame.rockchunks02');

    L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.RocketProj');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'XEffects.RocketFlare');
    Level.AddPrecacheMaterial(Material'AS_FX_TX.Trails.Trail_Blue');
    Level.AddPrecacheMaterial(Material'EpicParticles.Flares.FlickerFlare');
    Level.AddPrecacheMaterial(Material'WeaponSkins.Skins.RocketShellTex');
    Level.AddPrecacheMaterial(Material'XEffects.RocketFlare');
    Level.AddPrecacheMaterial(Material'AS_FX_TX.Trails.Trail_Blue');
    Level.AddPrecacheMaterial(Material'ExplosionTex.Framed.SmokeReOrdered');
    Level.AddPrecacheMaterial(Material'ExplosionTex.Framed.exp2_frames');
    Level.AddPrecacheMaterial(Material'XEffects.Skins.Rexpt');
    Level.AddPrecacheMaterial(Material'EmitterTextures.MultiFrame.rockchunks02');

    Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.RocketProj');
	Super.UpdatePrecacheStaticMeshes();
}


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

	StartLocation += vector(Base.Rotation) * -32 + vect(0,0,-32);

    P = spawn(ProjClass, self, , StartLocation, Base.Rotation);

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

defaultproperties
{
     YawBone="GatlingGun"
     PitchBone="GatlingGun"
     PitchUpLimit=2000
     PitchDownLimit=-16000
     WeaponFireAttachmentBone="GatlingGunFirePoint"
     FireInterval=0.400000
     FireSoundClass=SoundGroup'BW_Core_WeaponSound.FP9A5.FP9-Bounce'
     FireForce="RocketLauncherFire"
     ProjectileClass=Class'BWBP_VPC_Pro.AlbatrossBomb'
     AIInfo(0)=(bTrySplash=True,bLeadTarget=True)
     Mesh=SkeletalMesh'ONSBPAnimations.DualAttackCraftGatlingGunMesh'
     CollisionRadius=60.000000
}
