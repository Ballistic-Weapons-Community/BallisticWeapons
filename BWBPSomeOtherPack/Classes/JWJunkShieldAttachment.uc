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
     IdleHeavyAnim="RifleHip_Idle"
     IdleRifleAnim="RifleHip_Idle"
     bHeavy=True
     AttachmentBone="bip01 l hand"	 
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.JWJunkShield_Third'
	 RelativeLocation=(X=-10.000000)
     RelativeRotation=(Yaw=-16384,Pitch=-16384)
     DrawScale=0.450000
	 MeleeAltStrikeAnim="Blade_Swing"
}
