//=============================================================================
// X8 Attachment.
//
// 3rd person weapon attachment for the X8 knife.
//=============================================================================
class X8Attachment extends BallisticMeleeAttachment;

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
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.TP_BalKnife'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.500000
}
