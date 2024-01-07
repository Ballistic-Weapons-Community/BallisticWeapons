//=============================================================================
// BOGPAttachment.
//
// 3rd person weapon attachment for BOGP Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class HB4Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBP_APC_Pro.HB4FlashEmitter'
     FlashScale=0.200000
     BrassMode=MU_None
     InstantMode=MU_None
     WaterTracerMode=MU_None
     bHeavy=True
     Mesh=SkeletalMesh'BWBP_CC_Anim.TPm_HoloBlaster'
     DrawScale=1.000000
	 CockingAnim="Reload_BreakOpen"
}
