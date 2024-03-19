//=============================================================================
// X3Attachment.
//
// 3rd person weapon attachment for the X3 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X3Attachment extends BallisticMeleeAttachment;

defaultproperties
{
	WeaponClass=class'X3Knife'
     MeleeAltStrikeAnim="Blade_Smack"
     ImpactManager=class'IM_Knife'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     MeleeStrikeAnim="Blade_Stab"
     bHeavy=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_X3'
     DrawScale=0.090000
	 RelativeLocation=(X=-6.000000,Y=-3.000000,Z=-3.500000)
}
