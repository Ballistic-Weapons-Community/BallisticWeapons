//=============================================================================
// X4Attachment.
//
// 3rd person weapon attachment for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X4Attachment extends BallisticMeleeAttachment;

defaultproperties
{
	WeaponClass=class'X4Knife'
     MeleeAltStrikeAnim="Blade_Smack"
     ImpactManager=class'IM_Knife'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     MeleeStrikeAnim="Blade_Stab"
     bRapidFire=True
     RelativeLocation=(X=5.000000,Z=10.000000)
     RelativeRotation=(Pitch=-40000)	 
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.X4_TPm'
     DrawScale=0.135000
}
