//=============================================================================
// LS14Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20Attachment extends BallisticAttachment;

simulated function EjectBrass(byte Mode);

function XM20UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 2;
	//FireCount++;
	ThirdPersonEffects();
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.GRSXXLaserFlashEmitter'
     AltMuzzleFlashClass=Class'BWBPRecolorsPro.GRSXXLaserFlashEmitter'
     ImpactManager=Class'BWBPSomeOtherPack.IM_XM20Impacted'
     BrassClass=Class'BallisticProV55.Brass_Railgun'
     FlashMode=MU_Both
     LightMode=MU_Both
	 InstantMode=MU_Both
	 TracerMode=MU_Both
     TracerClass=Class'BWBPSomeOtherPack.TraceEmitter_XM20Las'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-FlyBy',Volume=0.700000)
     FlyByBulletSpeed=-1.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.3RD-LS14'
     RelativeLocation=(X=-3.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
}
