//=============================================================================
// FM13Attachment.
//
// TPm person weapon attachment for M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FM14Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBP_APC_Pro.FM14FlashEmitter'
	 ImpactManager=Class'BallisticProV55.IM_Shell'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=1.800000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     TracerMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerChance=0.500000
     MeleeStrikeAnim="Melee_swing"
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
     Mesh=SkeletalMesh'BWBP_CC_Anim.Pitbull_TPm'
     DrawScale=0.180000
}
