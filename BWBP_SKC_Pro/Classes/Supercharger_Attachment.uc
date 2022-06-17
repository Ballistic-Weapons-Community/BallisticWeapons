//=============================================================================
// Supercharger_Attachment.
//
// by SK based on code by DC
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_Attachment extends BallisticAttachment;


defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
     AltFlashBone="tip3"
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Neither
     InstantMode=MU_Both
     TracerMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.300000)
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'NewWeapons2004.NewAssaultRifle_3rd'
     RelativeLocation=(X=-20.000000,Y=-5.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
