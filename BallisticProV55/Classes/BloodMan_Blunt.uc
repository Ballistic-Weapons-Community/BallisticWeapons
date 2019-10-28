//=============================================================================
// BloodMan_Blunt.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Blunt extends BloodMan_Bullet;

static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.BluntEffect;
}

static function class<Projector> GetWallSplat(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.ShotgunSplat;
}

defaultproperties
{
     SplatRange=200.000000
     DripperThreshold=20.000000
}
