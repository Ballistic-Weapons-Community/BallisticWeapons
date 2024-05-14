//=============================================================================
// AY90Attachment.
//
// 3rd person weapon attachment for Skrith Boltcaster
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90Attachment extends A73Attachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBP_SKC_Pro.A73BFlashEmitter'
     ImpactManager=class'IM_A73Knife'
     MeleeImpactManager=class'IM_A73Knife'
     FlashScale=0.100000
     BrassMode=MU_None
     ReloadAnim="Reload_MG"
     ReloadAnimRate=1.50000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_SkrithCrossbow'
     DrawScale=1.200000
	 RelativeRotation=(Pitch=32768)
}
