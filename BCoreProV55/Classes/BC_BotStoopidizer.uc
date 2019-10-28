//=============================================================================
// BC_BotStoopidizer.
//
// General purpose actor linkef to a bot to temporarily stun them and make them
// stoopid...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BC_BotStoopidizer extends Actor;

var float				EndTime;
var float				StoopidTime;
var float				StoopidFactor;
var bool				bNoFade;
var Pawn				LastHitPawn;
var AIController		AC;
var float				OldSkill;
var float				OldAlertness;
var float				OldAggresion;
var bool				bIsActive;

event PostBeginPlay()
{
	if (Owner != None && AIController(Owner) != None)
		AC = AIController(Owner);
	if (AC == None)
		Destroy();
	else
	{
		if (Bot(AC)!=None)
		{
			OldAlertness = Bot(AC).Pawn.default.Alertness;
			OldAggresion = Bot(AC).BaseAggressiveness;
		}
		OldSkill = AC.Skill;
	}
}

function AddImpulse(float NewIntensity, float NewTime, optional bool bNoFading, optional bool bNoAdd)
{
	if (AC == None)
		Destroy();
	else if (bNoAdd || EndTime < level.TimeSeconds)
	{
		StoopidFactor = NewIntensity;
		StoopidTime = NewTime;
		EndTime = level.TimeSeconds + NewTime;
		bNoFade = bNoFading;
		ScrewUpBot();
	}
	else if ((EndTime-level.TimeSeconds) + NewTime > 10)
	{
		StoopidFactor += NewIntensity;
		StoopidTime += NewTime;
		EndTime = level.TimeSeconds + 10;
		bNoFade = bNoFading;
		ScrewUpBot();
	}
	else
	{
		StoopidFactor += NewIntensity;
		StoopidTime += NewTime;
		EndTime += NewTime;
		bNoFade = bNoFading;
		ScrewUpBot();
	}
}

function ScrewUpBot()
{
	if (AC == None)
		return;
	LastHitPawn = AC.Pawn;

	Bot(AC).SetAlertness(-1);
	Bot(AC).LoseEnemy();

	bIsActive = true;
}

event Tick(float DT)
{
	local float BA;

	if (!bIsActive)
		return;
	if (AC != None)
	{
		if (level.TimeSeconds > EndTime || AC.Pawn == None || AC.Pawn != LastHitPawn)
		{
			bIsActive = false;
			FixBot();
			return;
		}

		if (bNoFade)
			BA = FMin(1, StoopidFactor);
		else
			BA = FMin(1, StoopidFactor * ((EndTime - level.TimeSeconds) / StoopidTime));

		AC.Skill = OldSkill - BA * OldSkill;
		if (Bot(AC)!=None)
		{
			Bot(AC).SetAlertness(Lerp(BA, OldAlertness, -1));
			Bot(AC).Aggressiveness = Lerp(BA, OldAggresion, -20);
		}
	}
}

event Destroyed()
{
	FixBot();
	super.Destroyed();
}

function FixBot()
{
	if (AC != None)
	{
		if (Bot(AC)!=None)
		{
			if (AC.Pawn != None)
				Bot(AC).SetAlertness(OldAlertness);
			Bot(AC).Aggressiveness = OldAggresion;
		}
		AC.Skill = OldSkill;
	}
}

static function BC_BotStoopidizer DoBotStun (AIController AC, float NewIntensity, float NewTime, optional bool bNoFading, optional bool bNoAdd)
{
	local BC_BotStoopidizer B;
	local int i;

	if (AC == None)
		return none;

	for (i=0;i<AC.Attached.length;i++)
		if (BC_BotStoopidizer(AC.Attached[i]) != None)
		{
			B = BC_BotStoopidizer(AC.Attached[i]);
			break;
		}
	if (B == None)
	{
		B = AC.Spawn(default.class, AC,,AC.Location);
		if (B == None)
			return None;
		B.SetBase(AC);
	}
	B.AddImpulse (NewIntensity, NewTime, bNoFading, bNoAdd);

	return B;
}

defaultproperties
{
     bHidden=True
     RemoteRole=ROLE_None
     LifeSpan=20.000000
}
