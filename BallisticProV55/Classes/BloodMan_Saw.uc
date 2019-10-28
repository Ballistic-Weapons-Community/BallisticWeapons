//=============================================================================
// BloodMan_Saw.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Saw extends BloodMan_Bullet;

static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	if (Bone == 'head' && BS.default.SawHeadEffect != None)
		return BS.default.SawHeadEffect;
	return BS.default.SawEffect;
}

static function class<Projector> GetWallSplat(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.SawSplat;
}

static function class<actor> GetScreenEffect(class<BallisticBloodSet> BS)
{
	return BS.default.ScreenEffectSaw;
}

static function ExtraBloodHitFX(class<BallisticBloodSet> BS, Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	if (default.bUseScreenFX && !class'GameInfo'.static.UseLowGore() && FRand() < 0.25)
		BloodHitScreenFX(BS, Victim, Bone, HitLoc, HitRay, Damage);
}

static function DoBloodHit(Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	local Actor HitFX, T;
	local vector TraceHit, TraceNorm;
	local class<BallisticBloodSet> BS;
	local rotator DecalRot;

	if (Victim.Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.UseLowGore())
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	HitRay = Normal(HitRay + VRand() * 0.7);

	ExtraBloodHitFX(BS, Victim, Bone, HitLoc, HitRay, Damage);
	// Spawn a decal within splat range and in the direction of the HitRay
	if (default.bUseBloodSplats && default.DecalChance > 0 && default.DecalChance > FRand())
	{
		T = Victim.Trace(TraceHit, TraceNorm, HitLoc + HitRay * default.SplatRange, HitLoc, false);
		if (T != None && T.bWorldGeometry)
		{
			DecalRot = Rotator(-TraceNorm);
			DecalRot.Roll = Rand(65536);
			Victim.Spawn(GetWallSplat(BS),,,TraceHit, DecalRot);
		}
	}
	// Spawn an effect in the direction of the HitRay
	if (default.bUseBloodEffects && default.EffectChance > 0 && default.EffectChance > FRand())
	{
		HitFX = Victim.Spawn(GetBloodEffect(BS),Victim,,HitLoc, Rotator(HitRay));
	}
}

defaultproperties
{
     DecalChance=0.400000
}
