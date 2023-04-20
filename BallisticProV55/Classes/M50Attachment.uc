//=============================================================================
// M50Attachment.
//
// 3rd person weapon attachment for M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50Attachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'M50AssaultRifle'
     MuzzleFlashClass=class'M50FlashEmitter'
     AltMuzzleFlashClass=class'M50M900FlashEmitter'
     ImpactManager=class'IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=class'Brass_Rifle'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=class'TraceEmitter_Default'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=1.400000
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.M50_TPm'
     DrawScale=0.160000
}
