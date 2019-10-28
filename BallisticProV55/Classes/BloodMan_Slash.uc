//=============================================================================
// BloodMan_Slash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Slash extends BloodMan_Bullet;

static function class<Projector> GetWallSplat(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.SlashSplat;
}
static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	if (Bone == 'head' && BS.default.SlashHeadEffect != None)
		return BS.default.SlashHeadEffect;
	return BS.default.SlashEffect;
}

static function class<actor> GetScreenEffect(class<BallisticBloodSet> BS)
{
	return BS.default.ScreenEffectSlice;
}

static function DoBloodHit(Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	local Actor HitFX, T;
	local vector TraceHit, TraceNorm, BoneLoc, BoneDir;
	local class<BallisticBloodSet> BS;
	local rotator DecalRot;

	if (Victim.Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.NoBlood())
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	ExtraBloodHitFX(BS, Victim, Bone, HitLoc, HitRay, Damage);

	// Spawn an effect in the direction of the HitRay
	if (default.bUseBloodEffects && default.EffectChance > 0 && default.EffectChance > FRand())
	{
		if (GetBloodEffect(BS, Bone) != None)
			HitFX = Victim.Spawn(GetBloodEffect(BS, Bone),Victim,,HitLoc, Rotator(HitRay));
	}
 	if (class'GameInfo'.static.UseLowGore())
 		return;
 	// Spawn dripping blood
	if (default.DripperChance > 0 && Damage >= default.DripperThreshold && default.DripperChance > FRand() && Victim.Health > 0 && BS.default.WoundDripper != None)
	{
		if (Bone == 'pelvis')
			Bone = 'spine';
		BoneLoc = Victim.GetBoneCoords(Bone).Origin;
		BoneDir = BoneLoc - HitLoc;
		BoneDir.Z = 0;
		if (Bone == 'head')
			HitLoc = (vect(0,0,1) * HitLoc.Z + BoneLoc * vect(1,1,0)) - Normal(BoneDir)*6;
		else
			HitLoc += BoneDir * 0.4;
		HitFX = Victim.Spawn(BS.default.WoundDripper,Victim,,HitLoc, Rotator(-HitRay));
		HitFX.SetBase(Victim);
	}
	// Spawn a decal within splat range and in the direction of the HitRay
	if (default.bUseBloodSplats && default.DecalChance > 0 && default.DecalChance > FRand() && GetWallSplat(BS)!=None)
	{
		HitRay = HitRay >> rot(6000,6000,0);
		DecalRot = Rotator(HitRay);
		DecalRot.Roll = -8192 + Rand(16384);
		T = Victim.Trace(TraceHit, TraceNorm, HitLoc + HitRay * default.SplatRange, HitLoc, false);
		if (T != None && T.bWorldGeometry)
			Victim.Spawn(GetWallSplat(BS),,,TraceHit, DecalRot);
	}
}

defaultproperties
{
     DripperThreshold=8.000000
     DripperChance=0.800000
}
