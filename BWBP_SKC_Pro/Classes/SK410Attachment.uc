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
     WeaponClass=Class'BWBP_SKC_Pro.SK410Shotgun'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
     ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
     MeleeImpactManager=class'IM_GunHit'
     FlashScale=1.800000
     BrassClass=Class'BWBP_SKC_Pro.Brass_ShotgunHE'
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_SK410'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     PrePivot=(X=1.000000,Z=-5.000000)
}
