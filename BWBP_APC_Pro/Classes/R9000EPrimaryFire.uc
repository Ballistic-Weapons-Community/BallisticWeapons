//=============================================================================
// R9000EPrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R9000EPrimaryFire extends BallisticProInstantFire;

var BUtil.FullSound IncFireSound, RADFireSound;

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
    if (BW.CurrentWeaponMode == 1)
	{
		BW.TargetedHurtRadius(5, 96, DamageType, 1, HitLocation,Pawn(Other));
		return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
	}
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
    local int i;
    local R9000EActorFire Burner;
    
    super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
    
    if (BW.CurrentWeaponMode == 1)
    {
		if (Pawn(Target) != None && Pawn(Target).Health > 0 && Vehicle(Target) == None)
		{
			for (i=0;i<Target.Attached.length;i++)
			{
				if (R9000EActorFire(Target.Attached[i])!=None)
				{
					R9000EActorFire(Target.Attached[i]).AddFuel(3);
					break;
				}
			}
			if (i>=Target.Attached.length)
			{
				Burner = Spawn(class'R9000EActorFire',Target,,Target.Location + vect(0,0,-30));
				Burner.Initialize(Target);
				if (Instigator!=None)
				{
					Burner.Instigator = Instigator;
					Burner.InstigatorController = Instigator.Controller;
				}
			}
		}
    }
	else if (BW.CurrentWeaponMode == 2)
	{
		if (Pawn(Target) != None && Pawn(Target).bProjTarget)
			TryPlague(Target);
	}
}

function TryPlague(Actor Other)
{
    local R9000EPlagueEffect RPE;
    
    if (AllowPlague(Other))
    {
		foreach Other.BasedActors(class'R9000EPlagueEffect', RPE)
        {
            RPE.ExtendDuration(2);
        }
        if (RPE == None)
        {
			RPE = Spawn(class'R9000EPlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
            RPE.Initialize(Other);
            if (Instigator!=None)
            {
				RPE.Instigator = Instigator;
                RPE.InstigatorController = Instigator.Controller;
            }
        }
    }
}

function bool AllowPlague(Actor Other)
{
    return 
        Pawn(Other) != None 
        && Pawn(Other).Health > 0 
        && Vehicle(Other) == None 
        && (Pawn(Other).GetTeamNum() == 255 || Pawn(Other).GetTeamNum() != Instigator.GetTeamNum())
        && Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime;
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		if (BW.CurrentWeaponMode == 1)
			Weapon.PlayOwnedSound(IncFireSound.Sound,BallisticFireSound.Slot,IncFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else if (BW.CurrentWeaponMode == 2)
			Weapon.PlayOwnedSound(RADFireSound.Sound,BallisticFireSound.Slot,RADFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	//if (!BW.bNoMeshInScope)
	//{
		if (AimedFireAnim != '')
		{
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
			if (BW.BlendFire())		
				BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
		}

		else
		{
			if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
				BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		}
	//}
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		if (BW.CurrentWeaponMode == 1)
			Weapon.PlayOwnedSound(IncFireSound.Sound,BallisticFireSound.Slot,IncFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else if (BW.CurrentWeaponMode == 2)
			Weapon.PlayOwnedSound(RADFireSound.Sound,BallisticFireSound.Slot,RADFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	CheckClipFinished();
}

defaultproperties
{
	TraceRange=(Min=30000.000000,Max=30000.000000)
	Damage=100.000000
    HeadMult=1.5f
    LimbMult=0.9f
	IncFireSound=(Sound=Sound'BW_Core_WeaponSound.FlyBys.Whizzing3',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
    RADFireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Fire2',Volume=0.700000,Radius=256.000000,Pitch=0.700000)
	WaterRangeAtten=0.800000
	DamageType=Class'BWBP_APC_Pro.DTR9000ERifle'
	DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleHead'
	DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifle'
	KickForce=3000
	PenetrateForce=0
	bPenetrate=False	
	WallPenetrationForce=0
	PDamageFactor=0.800000
	bCockAfterFire=True
	MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	bBrassOnCock=True
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	FireRecoil=378.000000
	FireChaos=0.500000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Fire',Volume=2.000000,Radius=1024.000000)
	FireEndAnim=
	FireRate=1.1
	AmmoClass=Class'BWBP_APC_Pro.Ammo_42ERifle'
	ShakeRotMag=(X=400.000000,Y=32.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	
	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.4
	WarnTargetPct=0.5
	
	aimerror=800.000000
}
