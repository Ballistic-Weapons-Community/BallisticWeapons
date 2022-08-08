//=============================================================================
// AK91Attachment.
//
// 3rd person weapon attachment for AK91 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK91Attachment extends BallisticAttachment;



defaultproperties
{
     MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
     ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.300000)
     bRapidFire=True
     TrackAnimMode=MU_Secondary
     RelativeRotation=(Pitch=32768)
     Mesh=SkeletalMesh'BWBP_SKC_Anim.AK490_TPm'
     DrawScale=0.250000
	 TracerMix=1
     Skins(0)=Texture'BWBP_SKC_Tex.AK490.AK490-Misc'
     Skins(1)=Texture'BWBP_SKC_Tex.AK490.AK490-Main'
}
