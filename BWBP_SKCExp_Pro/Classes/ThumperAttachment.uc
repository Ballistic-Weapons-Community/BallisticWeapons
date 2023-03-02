//=============================================================================
// LS14Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ThumperAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashScale=0.650000
     BrassMode=MU_None
     InstantMode=MU_None
     WaterTracerMode=MU_None
     bHeavy=True
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.Thumper_TPm'
     RelativeLocation=(X=-3.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=1.100000
}
