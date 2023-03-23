//=============================================================================
// SK410Attachment.
//
// 3rd person weapon attachment for SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ARAttachment extends BallisticShotgunAttachment;

defaultproperties
{
     WeaponClass=Class'BWBP_OP_Pro.ARShotgun'
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=0.6
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
     Mesh=SkeletalMesh'BWBP_OP_Anim.AssaultShotgun_TPm'
     RelativeRotation=(Pitch=32768,Roll=-16384)
     DrawScale=0.500000
     PrePivot=(X=1.000000,Z=-5.000000)
}
