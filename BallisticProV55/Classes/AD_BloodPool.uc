//=============================================================================
// AD_BloodPool
//=============================================================================
class AD_BloodPool extends AD_BloodDecal
	placeable;

defaultproperties
{
     DecalTextures(0)=Texture'BallisticBloodPro.Decals.BloodPool1'
     DecalTextures(1)=Texture'BallisticBloodPro.Decals.BloodPool2'
     bRandomRotate=True
     StayTime=32.000000
     ZoomDist=-8.000000
     DrawScaleVariance=0.700000
     bDynamicDecal=True
     MaxDrawScale=1.200000
     MinDrawScale=0.300000
     ExpandTime=10.000000
     bAbandonOnFinish=True
     bExpandingDecal=True
     MaterialBlendingOp=PB_AlphaBlend
     FrameBufferBlendingOp=PB_None
     FOV=1
     MaxTraceDistance=64
     bProjectActor=False
     bStatic=False
     DrawScale=0.250000
}
