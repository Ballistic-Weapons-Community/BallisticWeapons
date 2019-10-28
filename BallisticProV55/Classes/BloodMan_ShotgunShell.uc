//=============================================================================
// BloodMan_ShotgunShell.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_ShotgunShell extends BloodMan_Bullet;

static function class<Projector> GetWallSplat(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.ShotgunSplat;
}
static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.ShotgunEffect;
}

static function ExtraBloodHitFX(class<BallisticBloodSet> BS, Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	if (default.bUseScreenFX && !class'GameInfo'.static.UseLowGore() && FRand() < 0.25)
		BloodHitScreenFX(BS, Victim, Bone, HitLoc, HitRay, Damage);
}

defaultproperties
{
     DecalChance=0.300000
}
