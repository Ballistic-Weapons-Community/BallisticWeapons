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
     MeleeAltStrikeAnim="Blade_Smack"
     ImpactManager=Class'BallisticProV55.IM_Knife'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     MeleeStrikeAnim="Blade_Stab"
     bHeavy=True
     Mesh=SkeletalMesh'BallisticAnims2.Knife3rd'
     DrawScale=0.110000
}
