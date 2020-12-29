//=============================================================================
// AD_KnifeWood.
//=============================================================================
class AD_KnifeWood extends AD_ImpactDecal
	placeable;

simulated event PostBeginPlay()
{
	local int SliceAnim;
	local Rotator R;

	R = Rotation;
	R.Roll = -8192 - R.Yaw + Rotator(Owner.Location - Location).Yaw;
	if (Owner!=None && Pawn(Owner) != None && Pawn(Owner).Weapon != None && Pawn(Owner).Weapon.GetFireMode(0) != None && X3PrimaryFire(Pawn(Owner).Weapon.GetFireMode(0)) != None)
	{
		SliceAnim = X3PrimaryFire(Pawn(Owner).Weapon.GetFireMode(0)).SliceAnim;
		if (SliceAnim == 0)
			R.Roll -= 24768;
//		else if (SliceAnim == 1)
//			R.Roll += 0;
		else if (SliceAnim == 2)
			R.Roll += 32768;
		else if (SliceAnim == 3)
			R.Roll -= 8192;
	}
	else
		R.Roll = Rand(65536);

	SetRotation (R);

	Super.PostBeginPlay();
}

defaultproperties
{
     bRandomRotate=False
     DrawScaleVariance=0.050000
     ProjTexture=Texture'BallisticEffects2.Decals.KnifeCutWood'
     DrawScale=0.200000
}
