//=============================================================================
// ICISAttachment.
//
// 3rd person weapon attachment for the stimpack
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISAttachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'ICISStimpack'
     ImpactManager=class'IM_Knife'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Primary
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     bRapidFire=True
	 RelativeLocation=(Z=6.50)
     RelativeRotation=(Roll=34000)	 
     Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_Stimpack'
     DrawScale=0.35000
}
