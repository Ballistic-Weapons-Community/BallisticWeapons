//=============================================================================
// A73Attachment.
//
// _TPm person weapon attachment for A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_A73Knife'
     MeleeImpactManager=Class'BallisticProV55.IM_A73Knife'
     FlashScale=0.100000
     BrassMode=MU_None
     ReloadAnim="Reload_MG"
     ReloadAnimRate=1.50000
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.A73_TPm'
     DrawScale=1.700000
}
