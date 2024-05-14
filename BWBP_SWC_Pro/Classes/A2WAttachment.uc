//=============================================================================
// A42Attachment.
//
// 3rd person weapon attachment for A42 Skrith Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A2WAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_A73Knife'
     MeleeImpactManager=Class'BallisticProV55.IM_A73Knife'
	 FlashScale=0.100000
     BrassMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_A42Beam'
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_A42'
     DrawScale=0.080000
}
