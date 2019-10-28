//=============================================================================
// AD_BloodExplode
//=============================================================================
class AD_BloodExplode extends AD_BloodDecal
	placeable;

defaultproperties
{
     DecalTextures(0)=Texture'BallisticBloodPro.Decals.BloodExplode1'
     DecalTextures(1)=Texture'BallisticBloodPro.Decals.BloodExplode2'
     DecalTextures(2)=Texture'BallisticBloodPro.Decals.BloodExplode3'
     bRandomRotate=True
     StayTime=32.000000
     ZoomDist=-25.000000
     DrawScaleVariance=0.250000
     MaterialBlendingOp=PB_AlphaBlend
     FrameBufferBlendingOp=PB_None
     FOV=1
     MaxTraceDistance=80
     bProjectActor=False
     bStatic=False
     DrawScale=0.500000
}
