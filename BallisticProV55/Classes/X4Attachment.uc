//=============================================================================
// X4Attachment.
//
// _TPm person weapon attachment for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class X4Attachment extends BallisticMeleeAttachment;

defaultproperties
{
     MeleeAltStrikeAnim="Blade_Smack"
     ImpactManager=Class'BallisticProV55.IM_Knife'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     MeleeStrikeAnim="Blade_Stab"
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.X4_TPm'
     DrawScale=0.175000
}
