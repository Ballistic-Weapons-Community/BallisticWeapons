//=============================================================================
//:GHORNWAttachment.
//
// 3rd person weapon attachment for Longhorn Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LonghornAttachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'LonghornLauncher'
     MuzzleFlashClass=class'M50FlashEmitter'
     AltMuzzleFlashClass=class'M50FlashEmitter'
     ImpactManager=class'IM_Bullet'
     BrassClass=Class'BWBP_SKC_Pro.Brass_Longhorn'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=class'TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     bAltRapidFire=True
     CockingAnim"Cock_PumpSlow"
 	ReloadAnimRate=1.000000
	CockAnimRate=1.220000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.Longhorn_TPm'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
