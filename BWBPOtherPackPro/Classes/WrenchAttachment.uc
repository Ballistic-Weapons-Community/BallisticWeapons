//=============================================================================
// X4Attachment.
//
// 3rd person weapon attachment for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class WrenchAttachment extends BallisticMeleeAttachment;

defaultproperties
{
     MeleeAltStrikeAnim="Blade_Smack"
     ImpactManager=Class'BWBPOtherPackPro.IM_Wrench'
     MeleeImpactManager=Class'BWBPOtherPackPro.IM_Wrench'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Secondary
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     MeleeStrikeAnim="Blade_Stab"
     bRapidFire=True
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Techwrench_TP'
     DrawScale=1.000000
}
