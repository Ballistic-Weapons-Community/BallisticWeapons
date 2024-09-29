//=============================================================================
// X4Attachment.
//
// 3rd person weapon attachment for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class WrenchAttachment extends BallisticMeleeAttachment;

defaultproperties
{
	WeaponClass=class'WrenchWarpDevice'
     MeleeAltStrikeAnim="Blade_Smack"
     ImpactManager=Class'BWBP_OP_Pro.IM_Wrench'
     MeleeImpactManager=Class'BWBP_OP_Pro.IM_Wrench'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Secondary
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     MeleeStrikeAnim="Blade_Stab"
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.Techwrench_TPm'
     DrawScale=0.750000
	 RelativeLocation=(X=-2.000000,Y=-4.000000)
}
