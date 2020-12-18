//=============================================================================
// ICISAttachment.
//
// 3rd person weapon attachment for the stimpack
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISAttachment extends BallisticAttachment;

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_Knife'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Primary
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.TP_Stimpack'
     DrawScale=0.500000
}
