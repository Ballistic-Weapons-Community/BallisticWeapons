//=============================================================================
// EKS43Attachment.
//
// Attachment for EKS43 sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EKS43Attachment extends BallisticMeleeAttachment;

defaultproperties
{
	 IdleHeavyAnim="TwoHand_Idle"
     IdleRifleAnim="TwoHand_Idle"
	 MeleeStrikeAnim="TwoHand_Slam"
	 MeleeAltStrikeAnim="TwoHand_Smash"
     ImpactManager=Class'BallisticProV55.IM_Katana'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     bHeavy=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.Katana_TPm'
     DrawScale=0.100000
}
