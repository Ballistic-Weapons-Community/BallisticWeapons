//=============================================================================
// BloodMan_Fire.
//
// General blood manager fiery dismemberment
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Fire extends BloodMan_Bullet;

static function class<Actor> GetBloodEffect(class<BallisticBloodSet> BS, optional name Bone)
{
	return BS.default.BluntEffect;
}

static function DoSeverEffects(Pawn Victim, name Bone, vector HitRay, float GibPerterbation, float Damage)
{
	local BW_HitGoreEmitter GoreEffect;
	local class<Emitter> FXClass;
	local class<BallisticBloodSet> BS;

	BS = GetBloodSet(Victim);
	if (BS == None)
		return;
	FXClass = BS.static.GetDismemberEffectFor(Victim, Bone);
	if (FXClass!=None)	{
		GoreEffect = BW_HitGoreEmitter(Victim.Spawn(FXClass, Victim,, Victim.GetBoneCoords(Bone).Origin, Victim.Rotation));
		if (GoreEffect!=None)
			GoreEffect.InitHitForce(HitRay, GibPerterbation);	}

	BS.static.MakeGibsFor(Victim, Bone, HitRay, GibPerterbation, FMin(Damage / 40, 4), BS.static.GetGibInfoFor(Bone), true);
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
	Fire = Victim.Spawn(class'BG_StumpFire', Victim, , Victim.Location);
	if (Bone == 'pelvis')
		Bone = 'spine';
	Victim.AttachToBone(Fire, Bone);
}

defaultproperties
{
}
