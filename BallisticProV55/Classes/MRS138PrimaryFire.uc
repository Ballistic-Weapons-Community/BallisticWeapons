//=============================================================================
// MRS138PrimaryFire.
//
// Stronger than the M763, but has a shorter range, wider spread and slower fire rate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138PrimaryFire extends BallisticProShotgunFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1 )
	{
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	else
	{
		if (class'BallisticReplicationInfo'.static.IsClassic()) //Slow cock anims
		{
			AimedFireAnim='AimedFire';
			FireAnim = 'Fire';
		}
		else
		{
			AimedFireAnim='SightFireCombined';
			FireAnim = 'FireCombined';
		}
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1 )
	{
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	else
	{
		if (class'BallisticReplicationInfo'.static.IsClassic())
		{
			AimedFireAnim='AimedFire';
			FireAnim = 'Fire';
		}
		else
		{
			AimedFireAnim='SightFireCombined';
			FireAnim = 'FireCombined';
		}
	}
	super.ServerPlayFiring();
}

simulated state Projectile
{
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ProjectileEffectParams effect_params;

		super(BallisticFire).ApplyFireEffectParams(params);

		effect_params = ProjectileEffectParams(params);

		ProjectileClass =  effect_params.ProjectileClass;
		SpawnOffset = effect_params.SpawnOffset;    
		default.ProjectileClass =  effect_params.ProjectileClass;
		default.SpawnOffset = effect_params.SpawnOffset;
	}

	// Became complicated when acceleration came into the picture
	// Override for even weirder situations
	function float MaxRange()
	{
		if (ProjectileClass.default.MaxSpeed > ProjectileClass.default.Speed)
		{
			// We know BW projectiles have AccelSpeed
			if (class<BallisticProjectile>(ProjectileClass) != None && class<BallisticProjectile>(ProjectileClass).default.AccelSpeed > 0)
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * 2) * 2);
				else
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * ProjectileClass.default.LifeSpan) * ProjectileClass.default.LifeSpan);
			}
			// For the rest, just use the max speed
			else
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return ProjectileClass.default.MaxSpeed * 2;
				else
					return ProjectileClass.default.MaxSpeed * ProjectileClass.default.LifeSpan*0.75;
			}
		}
		else // Hopefully this proj doesn't change speed.
		{
			if (ProjectileClass.default.LifeSpan <= 0)
				return ProjectileClass.default.Speed * 2;
			else
				return ProjectileClass.default.Speed * ProjectileClass.default.LifeSpan;
		}
	}

	// Get aim then spawn projectile
	function DoFireEffect()
	{
		local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;

	    Weapon.GetViewAxes(X,Y,Z);
    	// the to-hit trace always starts right in front of the eye
	    Start = Instigator.Location + Instigator.EyePosition();

	    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    	if ( !Weapon.WeaponCentered() )
		    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
	    SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		// Skip the instant fire version which would cause instant trace damage.
		Super(BallisticFire).DoFireEffect();
	}

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		Proj.Instigator = Instigator;
	}
}

defaultproperties
{
    SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
	HipSpreadFactor=1.500000
	TraceCount=8
	TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	TraceRange=(Min=2048.000000,Max=2048.000000)
	DamageType=Class'BallisticProV55.DTMRS138Shotgun'
	DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
	DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
	KickForce=400
	PenetrateForce=0
	bPenetrate=False
	MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
	BrassOffset=(X=45.000000,Y=-20.000000,Z=35.000000)
	bBrassOnCock=True
	bCockAfterFire=True
	FireRecoil=512.000000
	FireChaos=0.400000
	XInaccuracy=256.000000
	YInaccuracy=256.000000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
	FireAnim="FireCombined"
	FireEndAnim=
	FireRate=0.550000
	AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=2.000000

	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.7
	WarnTargetPct=0.5
}
