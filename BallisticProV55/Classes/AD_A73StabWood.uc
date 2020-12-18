//=============================================================================
// AD_A73StabWood.
//=============================================================================
class AD_A73StabWood extends AD_ImpactDecal
	placeable;

simulated event PostBeginPlay()
{
	local Rotator R;

	R = Rotation;
	R.Roll = 8192 - R.Yaw + Rotator(Owner.Location - Location).Yaw;
	SetRotation (R);

	Super.PostBeginPlay();
}

defaultproperties
{
     bRandomRotate=False
     DrawScaleVariance=0.050000
     ProjTexture=Texture'BallisticEffects2.Decals.A73BladeCutWood'
     DrawScale=0.200000
}
