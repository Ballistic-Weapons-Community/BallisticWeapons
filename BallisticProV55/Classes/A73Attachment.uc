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
     MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_A73Knife'
     MeleeImpactManager=Class'BallisticProV55.IM_A73Knife'
     FlashScale=0.100000
     BrassMode=MU_None
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.A73-3rd'
     DrawScale=1.700000
}
