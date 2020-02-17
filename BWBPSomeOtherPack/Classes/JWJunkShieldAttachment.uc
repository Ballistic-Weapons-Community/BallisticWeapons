//=============================================================================
// RiotAttachment
//
// Attachment for the riot shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class JWJunkShieldAttachment extends BallisticMeleeAttachment;

var Actor ShieldWeapon;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Instigator != None)
	{
		ShieldWeapon = Spawn(class'JWJunkShieldBoard');
		Instigator.AttachToBone(ShieldWeapon,'righthand');
	}
}

simulated function Destroyed()
{
	if (ShieldWeapon != None)
		ShieldWeapon.Destroy();

	super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_GunHit'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     AttachmentBone="bip01 l hand"	 
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.JWJunkShield_Third'
	 RelativeLocation=(X=-10.000000)
     RelativeRotation=(Yaw=-16384,Pitch=25000)
     DrawScale=0.450000
	 IdleHeavyAnim="Blade_Idle"
     IdleRifleAnim="Blade_Idle"
	 MeleeStrikeAnim="Blade_Smack"
	 MeleeAltStrikeAnim="Blade_Swing"
	 MeleeBlockAnim="Blade_ShieldBlock"
}
