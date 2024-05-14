//=============================================================================
// A73Attachment.
//
// 3rd person weapon attachment for A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73Attachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'A73SkrithRifle'
	MuzzleFlashClass=class'A73FlashEmitter'
	ImpactManager=class'IM_A73Knife'
	MeleeImpactManager=class'IM_A73Knife'
	FlashScale=0.100000
	BrassMode=MU_None
	ReloadAnim="Reload_MG"
	ReloadAnimRate=1.50000
	bRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_A73'
	DrawScale=1.700000
}
