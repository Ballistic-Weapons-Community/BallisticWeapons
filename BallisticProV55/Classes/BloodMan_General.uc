//=============================================================================
// BloodMan_General.
//
// The default BloodManager used when there's no other available
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_General extends BloodMan_Bullet;

static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.BluntEffect;
}

defaultproperties
{
}
