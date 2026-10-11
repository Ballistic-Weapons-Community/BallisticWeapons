//=============================================================================
// A73Attachment.
//
// 3rd person weapon attachment for A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73Attachment extends BallisticAttachment;

// The muzzle flash has the colour of the layout. Only the A73's own flash, not those of the weapons built on this attachment
simulated function ApplyModel()
{
	super.ApplyModel();

	if (MuzzleFlashClass != class'A73FlashEmitter')
		return;
	if (LayoutIndex == 1)
		ModeInfos[0].MuzzleFlashClass = class'A73FlashEmitterBal';
	else if (LayoutIndex == 2)
		ModeInfos[0].MuzzleFlashClass = class'A73FlashEmitterB';
}

defaultproperties
{
	WeaponClass=class'A73SkrithRifle'
	MuzzleFlashClass=class'A73FlashEmitter'
	ImpactManager=class'IM_A73Knife'
	MeleeImpactManager=class'IM_A73Knife'
	FlashScale=0.100000
	BrassMode=MU_None
	ReloadAnim="Reload_MG"
	ReloadAnimRate=1.950000
	bRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.A73_TPm'
	DrawScale=1.700000
}
