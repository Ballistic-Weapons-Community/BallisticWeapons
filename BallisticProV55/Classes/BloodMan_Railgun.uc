//=============================================================================
// BloodMan_Railgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Railgun extends BloodMan_Bullet;

static function DoSeverStump(Pawn Victim, name Bone, vector HitRay, float Damage)
{
	local Actor T;
	local vector TraceHit, TraceNorm;
	local class<BallisticBloodSet> BS;
	local BallisticDecal D;

	super.DoSeverStump(Victim, Bone, HitRay, Damage);

	if (Victim.Level.NetMode == NM_DedicatedServer || class'GameInfo'.static.UseLowGore() || (Bone != 'spine' && Bone != 'pelvis'))
		return;
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	if (default.bUseBloodExplodes)
	{
		T = Victim.Trace(TraceHit, TraceNorm, Victim.Location + HitRay * default.SplatRange, Victim.Location, false);
		if (T != None && T.bWorldGeometry)
		{
			class<BallisticDecal>(BS.default.ExplodeSplat).default.bWaitForInit = true;
			D = BallisticDecal(Victim.Spawn(BS.default.ExplodeSplat,,,TraceHit, Rotator(-TraceNorm)));
			if (D != None)
			{
				D.SetDrawScale(D.DrawScale * 0.6);
				D.InitDecal();
			}
			class<BallisticDecal>(BS.default.ExplodeSplat).default.bWaitForInit = false;
		}
	}
	// Spawn an effect in the direction of the HitRay
	Victim.Spawn(BS.default.ExplodeEffect,Victim,,Victim.Location, Rotator(HitRay));
}

defaultproperties
{
}
