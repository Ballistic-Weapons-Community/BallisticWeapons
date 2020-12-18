//=============================================================================
// A500Attachment.
//
// 3rd person weapon attachment for A500 Reptile
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.425000
     BrassMode=MU_None
     FlashMode=MU_Both
     LightMode=MU_Both
     WaterTracerMode=MU_None
     ReloadAnim="Reload_AR"
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims_25.Reptile_3rd'
     DrawScale=0.175000
}
