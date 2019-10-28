//=============================================================================
// BloodMan_NovaLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_NovaLightning extends BloodMan_Bullet;

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

	if (Victim.Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.NoBlood())
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	HitRay = Normal(HitRay + VRand() * 0.7);

	ExtraBloodHitFX(BS, Victim, Bone, HitLoc, HitRay, Damage);
	// Spawn a decal within splat range and in the direction of the HitRay
	if (default.bUseBloodSplats && !class'GameInfo'.static.UseLowGore() && default.DecalChance > 0 && default.DecalChance > FRand())
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

static function DoSeverEffects(Pawn Victim, name Bone, vector HitRay, float GibPerterbation, float Damage)
{
	local class<BallisticBloodSet> BS;
	local array<actor> Gibs;
	local int i;

	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	if (!default.bUseChunks || class'GameInfo'.static.UseLowGore())
 		return;

//	BS.static.MakeGibsFor(Victim, Bone, HitRay, GibPerterbation, FMin(Damage / 40, 4), BS.static.GetGibInfoFor(Bone), true);
	Gibs = BS.static.MakeGibsFor(Victim, Bone, HitRay, GibPerterbation, FMin(Damage / 40, 4), BS.static.GetGibInfoFor(Bone), true);
	for (i=0;i<Gibs.length;i++)
		if (BallisticGib(Gibs[i]) != None)
			BallisticGib(Gibs[i]).FireTrailClass = class'BG_A73GibFireTrail';
}

static function DoSeverStump(Pawn Victim, name Bone, vector HitRay, float Damage)
{
	local Actor Stump;
	local class<BallisticBloodSet> BS;
	local Emitter Fire;

	if (Victim == None)
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;
	//Hide severed limb
	if (xPawn(Victim) != None)
		xPawn(Victim).HideBone(Bone);
	//Sound?
	Stump = BS.static.GetStumpFor(Victim, Bone, true);
	if (Stump != None && BallisticPawn(Victim) != None)
		BallisticPawn(Victim).Stumps[BallisticPawn(Victim).Stumps.length] = Stump;
	Fire = Victim.Spawn(class'BG_A73StumpFire', Victim, , Victim.Location);
	if (Bone == 'pelvis')
		Bone = 'spine';
	Victim.AttachToBone(Fire, Bone);
}

defaultproperties
{
     DecalChance=0.500000
}
