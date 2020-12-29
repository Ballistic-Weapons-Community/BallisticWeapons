//=============================================================================
// A42Attachment.
//
// 3rd person weapon attachment for A42 Skrith Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A49Attachment extends HandgunAttachment;

#EXEC OBJ LOAD FILE=BallisticRecolors4AnimPro.ukx

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
     ImpactManager=Class'BWBPRecolorsPro.IM_GRSXXLaser'
     BrassMode=MU_None
     TracerMode=MU_Secondary
     InstantMode=MU_Secondary
     FlashMode=MU_Both
     LightMode=MU_Both
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.200000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.3RD-A49'
     RelativeLocation=(X=-5.000000,Y=-3.000000,Z=10.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.250000
}
