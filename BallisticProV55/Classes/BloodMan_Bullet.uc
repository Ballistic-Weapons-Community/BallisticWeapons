//=============================================================================
// BloodMan_Bullet.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodMan_Bullet extends BloodManager;

// Figure out what blood set to use for the victim
static function class<BallisticBloodSet> GetBloodSet(Pawn Victim)
{
	return class'BWBloodSetHunter'.static.GetBloodSetFor(Victim);
}

static function BloodHitScreenFX(class<BallisticBloodSet> BS, Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	local PlayerController PC;
	local Actor A, E;
	local Vector CamLoc;
	local Rotator CamRot;

	PC = Victim.level.GetLocalPlayerController();
	if (PC != None)
	{
		PC.PlayerCalcView(A, CamLoc, CamRot);
		if (VSize(HitLoc - CamLoc) < 200 && vector(CamRot) dot normal(HitLoc-CamLoc) > 0.7)
		{
			if (GetScreenEffect(BS) != None)
				E = PC.Spawn(GetScreenEffect(BS),PC, , CamLoc + Vector(CamRot)*16, CamRot);
		}
	}
}

static function ExtraBloodHitFX(class<BallisticBloodSet> BS, Pawn Victim, name Bone, vector HitLoc, vector HitRay, int Damage)
{
	if (default.bUseScreenFX && !class'GameInfo'.static.UseLowGore() && Damage > 5 + Rand(30))
		BloodHitScreenFX(BS, Victim, Bone, HitLoc, HitRay, Damage);
}

static function DoSeverEffects(Pawn Victim, name Bone, vector HitRay, float GibPerterbation, float Damage)
{
	local BW_HitGoreEmitter GoreEffect;
	local class<Emitter> FXClass;
	local class<BallisticBloodSet> BS;

	BS = GetBloodSet(Victim);
	if (BS == None)
		return;

	ExtraBloodHitFX(BS, Victim, Bone, Victim.GetBoneCoords(Bone).Origin, HitRay, Damage);
	if (default.bUseBloodEffects)
	{
		FXClass = BS.static.GetDismemberEffectFor(Victim, Bone);
		if (FXClass!=None)	{
			GoreEffect = BW_HitGoreEmitter(Victim.Spawn(FXClass, Victim,, Victim.GetBoneCoords(Bone).Origin, Victim.Rotation));
			if (GoreEffect!=None)
				GoreEffect.InitHitForce(HitRay, GibPerterbation);	}
	}
	if (default.bUseChunks && !class'GameInfo'.static.UseLowGore())
		BS.static.MakeGibsFor(Victim, Bone, HitRay, GibPerterbation, FMin(Damage / 40, 4), BS.static.GetGibInfoFor(Bone));
}

static function DoSeverStump(Pawn Victim, name Bone, vector HitRay, float Damage)
{
	local Actor Stump;
	local class<BallisticBloodSet> BS;
	local Actor Spurty;
	local class<Emitter>	SC;

	if (Victim == None)
		return;
	//Hide severed limb
	if (xPawn(Victim) != None)
		xPawn(Victim).HideBone(Bone);
	BS = GetBloodSet(Victim);
	if (BS == None)
		return;
	//Spawn stump actor
	if (default.bUseStumps && !class'GameInfo'.static.UseLowGore())
	{
		Stump = BS.static.GetStumpFor(Victim, Bone, false);
		if (Stump != None)
		{
			if (BallisticPawn(Victim) != None)
				BallisticPawn(Victim).Stumps[BallisticPawn(Victim).Stumps.length] = Stump;
		}
	}
	//Spawn blood drips effect
	if (default.bUseBloodEffects)
		SC = BS.static.GetStumpDripper(Victim, Bone);
	if (SC != None)
	{
		Spurty = Victim.Spawn(SC,Victim,,Victim.Location, Victim.Rotation);
		if (Spurty != None)
		{
			if (Bone == 'pelvis')
			{
				Bone = 'spine';
				Victim.AttachToBone(Spurty, Bone);
				Spurty.SetRelativeRotation(rot(32768,0,0));
			}
			else
				Victim.AttachToBone(Spurty, Bone);
			if (BallisticPawn(Victim) != None)
				BallisticPawn(Victim).ListGoreEffect(Spurty);
		}
	}
}

defaultproperties
{
}
