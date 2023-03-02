//=============================================================================
// The .50 Calibre machinegun for the TMV Leopard

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class LeopardMG extends ONSWeapon
	placeable;

var(Bullet) class<Emitter>			ImpactEffect;
var(Bullet) class<Emitter>    		mTracerClass;
var			editinline Emitter 		mTracer;
var(Bullet) float					mTracerInterval;
var(Bullet) float					mTracerPullback;
var(Bullet) float					mTracerMinDistance;
var(Bullet) float					mTracerSpeed;
var 		float               	mLastTracerTime;

function byte BestMode()
{
	return 0;
}
// Destroys the tracer.
simulated function Destroyed()
{

	if (mTracer != None)
		mTracer.Destroy();

	Super.Destroyed();
}
// Sets and Updates the Tracer.
simulated function UpdateTracer()
{
	local vector SpawnDir, SpawnVel;
	local float hitDist;

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (mTracer == None)
	{
		mTracer = Spawn(mTracerClass);
	}

	if (Level.bDropDetail || Level.DetailMode == DM_Low)
		mTracerInterval = 2 * Default.mTracerInterval;
	else
		mTracerInterval = Default.mTracerInterval;

	if (mTracer != None && Level.TimeSeconds > mLastTracerTime + mTracerInterval)
	{
	        mTracer.SetLocation(WeaponFireLocation);

		hitDist = VSize(LastHitLocation - WeaponFireLocation) - mTracerPullback;

		if (Instigator != None && Instigator.IsLocallyControlled())
			SpawnDir = vector(WeaponFireRotation);
		else
			SpawnDir = Normal(LastHitLocation - WeaponFireLocation);

		if(hitDist > mTracerMinDistance)
		{
			SpawnVel = SpawnDir * mTracerSpeed;

			mTracer.Emitters[0].StartVelocityRange.X.Min = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.X.Max = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.Y.Min = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Y.Max = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Z.Min = SpawnVel.Z;
			mTracer.Emitters[0].StartVelocityRange.Z.Max = SpawnVel.Z;

			mTracer.Emitters[0].LifetimeRange.Min = hitDist / mTracerSpeed;
			mTracer.Emitters[0].LifetimeRange.Max = mTracer.Emitters[0].LifetimeRange.Min;

			mTracer.SpawnParticle(1);
		}

		mLastTracerTime = Level.TimeSeconds;
	}
}

// Sets what happens when it impacts with surfaces.
state InstantFireMode
{

    simulated function SpawnHitEffects(actor HitActor, vector HitLocation, vector HitNormal)
    {
		local PlayerController PC;

		PC = Level.GetLocalPlayerController();
		if (PC != None && ((Instigator != None && Instigator.Controller == PC) || VSize(PC.ViewTarget.Location - HitLocation) < 5000))
		{
    		Spawn(ImpactEffect,,,HitLocation + HitNormal*0, rotator(HitNormal) + rot(-16384,0,0));
		}
    }
}

// Muzzle flash stuff.
simulated function FlashMuzzleFlash()
{
	Super.FlashMuzzleFlash();

	if (Role < ROLE_Authority)
		DualFireOffset *= -1;

	if(Level.NetMode != NM_DedicatedServer && EffectEmitter != None)
		AttachToBone(EffectEmitter, WeaponFireAttachmentBone);

	UpdateTracer();
}

defaultproperties
{
     ImpactEffect=Class'BWBP_VPC_Pro.BulletHitEffect'
     mTracerClass=Class'XEffects.NewTracer'
     mTracerInterval=0.060000
     mTracerPullback=150.000000
     mTracerSpeed=15000.000000
     YawBone="BaseBone"
     PitchBone="GunBone"
     PitchUpLimit=12500
     PitchDownLimit=62500
     WeaponFireAttachmentBone="FireBone"
     RotationsPerSecond=0.400000
     bInstantFire=True
     bDoOffsetTrace=True
     bIsRepeatingFF=True
     Spread=0.010000
     RedSkin=Texture'BWBP_Vehicles_Tex.Leopard.LeopardTurretRed'
     BlueSkin=Texture'BWBP_Vehicles_Tex.Leopard.LeopardTurretBlue'
     FireInterval=0.100000
     EffectEmitterClass=Class'BWBP_VPC_Pro.LeopardMGMuzzleFlash'
     FireSoundClass=Sound'BWBP_Vehicles_Sound.Leopard.Leo-MGFire'
     FireSoundVolume=255.000000
     FireSoundRadius=150.000000
     AmbientSoundScaling=2.300000
     FireForce="minifireb"
     DamageType=Class'BWBP_VPC_Pro.LeopardDamType50Calibre'
     DamageMin=25
     DamageMax=25
     TraceRange=15000.000000
     AIInfo(0)=(bInstantHit=True,aimerror=750.000000)
     CullDistance=5000.000000
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.LeopardMG'
     ScaleGlow=0.750000
}
