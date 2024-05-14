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
	WeaponClass=class'EKS43Katana'
	IdleHeavyAnim="TwoHand_Idle"
	IdleRifleAnim="TwoHand_Idle"
	MeleeStrikeAnim="TwoHand_Slam"
	MeleeAltStrikeAnim="TwoHand_Smash"
	ImpactManager=class'IM_Katana'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Both
	bHeavy=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_Katana'
	DrawScale=0.100000
	RelativeLocation=(Y=-2.000000,Z=-10.000000)
}
