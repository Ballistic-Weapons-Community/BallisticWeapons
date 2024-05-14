//=============================================================================
// A909Attachment.
//
// 3rd person weapon attachment for A909 Skrith Blades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A909Attachment extends BallisticMeleeAttachment;

var Actor LeftOne;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Instigator != None)
	{
		LeftOne = Spawn(class'A909LeftBlades');
		Instigator.AttachToBone(LeftOne,'lfarm');
	}
}

simulated function Destroyed()
{
	if (LeftOne != None)
		LeftOne.Destroy();

	super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'A909SkrithBlades'
     MeleeOffhandStrikeAnim="Punchies_JabRight"
     MeleeAltStrikeAnim="Punchies_UppercutRight"
     ImpactManager=class'IM_A909Blade'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     IdleHeavyAnim="Punchies_Idle"
     IdleRifleAnim="Punchies_Idle"
     MeleeStrikeAnim="Punchies_JabLeft"
     bHeavy=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_A909Right'
     DrawScale=0.150000
}
