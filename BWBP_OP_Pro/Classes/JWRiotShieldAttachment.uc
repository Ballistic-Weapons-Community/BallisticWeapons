//=============================================================================
// RiotAttachment
//
// Attachment for the riot shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class JWRiotShieldAttachment extends BallisticMeleeAttachment;

var Actor ShieldWeapon;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Instigator != None)
	{
		ShieldWeapon = Spawn(class'JWRiotShieldTruncheon');
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
	WeaponClass=class'JWRiotShieldWeapon'
     ImpactManager=class'IM_GunHit'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     AttachmentBone="bip01 l hand"	 
     Mesh=SkeletalMesh'BWBP_OP_Anim.TPm_CivShield'
	 RelativeLocation=(X=-10.000000)
     RelativeRotation=(Yaw=-16384,Pitch=25000)
     DrawScale=0.450000
	 IdleHeavyAnim="Blade_Idle"
     IdleRifleAnim="Blade_Idle"
	 MeleeStrikeAnim="Blade_Smack"
	 MeleeAltStrikeAnim="Blade_Swing"
	 MeleeBlockAnim="Blade_ShieldBlock"
}
