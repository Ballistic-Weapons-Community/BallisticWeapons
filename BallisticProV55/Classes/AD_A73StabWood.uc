//=============================================================================
// AD_A73StabWood.
//=============================================================================
class AD_A73StabWood extends AD_ImpactDecal
	placeable;

simulated event PostBeginPlay()
{
	local Rotator R;

	R = Rotation;
	if (Owner != None)
		R.Roll = 8192 - R.Yaw + Rotator(Owner.Location - Location).Yaw;
	else
		R.Roll = Rand(65536);
	SetRotation (R);

	Super.PostBeginPlay();
}

defaultproperties
{
     bRandomRotate=False
     DrawScaleVariance=0.050000
     ProjTexture=Texture'BW_Core_WeaponTex.Decals.A73BladeCutWood'
     DrawScale=0.200000
}
