//=============================================================================
// SK410Attachment.
//
// 3rd person weapon attachment for SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SK410Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     FireClass=Class'BWBPRecolorsPro.SK410PrimaryFire'
     MuzzleFlashClass=Class'BWBPRecolorsPro.SK410HeatEmitter'
     ImpactManager=Class'BWBPRecolorsPro.IM_ShellHE'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=1.800000
     BrassClass=Class'BWBPRecolorsPro.Brass_ShotgunHE'
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_ShotgunHE'
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.SK410_TPm'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     PrePivot=(X=1.000000,Z=-5.000000)
}
