//=============================================================================
// DT_HVCBurstLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_HVCBurstLightning extends DT_HVCLightning;

static function bool OverrideCanSever(Pawn Pawn, name Bone, int Damage, vector HitLoc, vector HitRay, bool bDirectHit, out byte bCanSever)
{
	switch (Bone)
	{
		case 'pelvis'	: if (80 + Rand(200) < Damage * default.GibModifier) bCanSever=1; break;
		case 'spine'	: if (80 + Rand(200) < Damage * default.GibModifier) bCanSever=1; break;
		case 'head'		: if (50 + Rand(150) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lshoulder': if (60 + Rand(140) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rshoulder': if (60 + Rand(140) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lfarm'	: if (40 + Rand(80) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rfarm'	: if (40 + Rand(80) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lhand'	: if (20 + Rand(40) < Damage * default.GibModifier) bCanSever=1; break;
		case 'righthand': if (20 + Rand(40) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rhand'	: if (20 + Rand(40) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lthigh'	: if (80 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rthigh'	: if (80 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lfoot'	: if (40 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rfoot'	: if (40 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
	}
	return true;
}
/*
static function bool OverrideCanSever(Pawn Pawn, name Bone, int Damage, vector HitLoc, vector HitRay, bool bDirectHit, out byte bCanSever)
{
	switch (Bone)
	{
		case 'pelvis'	: if (30 + Rand(10) < Damage * default.GibModifier) bCanSever=1; break;
		case 'spine'	: if (30 + Rand(10) < Damage * default.GibModifier) bCanSever=1; break;
		case 'head'		: if (10 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lshoulder': if (15 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rshoulder': if (15 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lfarm'	: if (10 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rfarm'	: if (10 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lhand'	: if (10 + Rand(15) < Damage * default.GibModifier) bCanSever=1; break;
		case 'righthand': if (10 + Rand(15) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rhand'	: if (10 + Rand(15) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lthigh'	: if (25 + Rand(15) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rthigh'	: if (25 + Rand(15) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lfoot'	: if (15 + Rand(10) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rfoot'	: if (15 + Rand(10) < Damage * default.GibModifier) bCanSever=1; break;
	}
	return true;
}
*/

defaultproperties
{
     GibModifier=25.000000
}
