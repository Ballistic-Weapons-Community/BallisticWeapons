//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASPrimaryFire extends BallisticProShotgunFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

var() sound		SuperFireSound;
var() sound		ClassicFireSound;
var() sound		UltraFireSound;
var() sound		XR4FireSound;

var bool bRequireSpool;

var rotator OldLookDir, TurnVelocity;
var SKASShotgun MainGun;

var float	NextTVUpdateTime, OldFireRate;

simulated state SpinUpFire
{
	event ModeTick(float DT)
	{
		local Rotator BasePlayerView;

		BasePlayerView = BW.GetBasePlayerView();
		
		if (Instigator.IsLocallyControlled())
		{
			TurnVelocity = (BasePlayerView - OldLookDir) / DT;
			OldLookDir = BasePlayerView;
			if (level.NetMode == NM_Client && level.TimeSeconds > NextTVUpdateTime)
			{
				MainGun.SetServerTurnVelocity(TurnVelocity.Yaw, TurnVelocity.Pitch);
				NextTVUpdateTime = level.TimeSeconds + 0.15;
			}
		}

		OldFireRate = FireRate;

		if (MainGun.BarrelSpeed <= 0)
		{
			FireRate = 0.66;
		}
		else
		{
			FireRate = default.FireRate / (1 + 0.25*int(BW.bBerserk));
			FireRate = FMin(0.66, FireRate / MainGun.BarrelSpeed);
			NextFireTime += FireRate - OldFireRate;
		}

		super.ModeTick(DT);
	}

	simulated event ModeDoFire()
	{
		if (bRequireSpool && MainGun.BarrelSpeed < MainGun.DesiredSpeed)
			return;
			
		super.ModeDoFire();
	}
	
	simulated function bool AllowFire()
	{
		if (MainGun.GetSecCharge() > 0)
			return false;		
		
		return super.AllowFire();
	}
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

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 1)
	{
		//BallisticFireSound.Sound=SuperFireSound;
		//FireRate=1.75;
		//FireAnim='SemiFire';
		//FireAnimRate=1.45;
    	     KickForce=800;
		//FireRecoil=128;
     	//FireChaos=0.2;
          //bCockAfterFire=True;
     	//FlashScaleFactor=1.5;
     	XInaccuracy=35.000000;
     	YInaccuracy=35.000000;
	}
	
	else
	{
		//FireRate=default.FireRate;
		RangeAtten=Default.RangeAtten;
		//BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		//FireAnim=default.FireAnim;
		KickForce=Default.KickForce;
		//FireRecoil=Default.FireRecoil;
     	//FireChaos=Default.FireChaos;
		bCockAfterFire=False;
     	XInaccuracy=default.XInaccuracy;
     	YInaccuracy=default.YInaccuracy;
	}
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
    SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     SuperFireSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Power'
     ClassicFireSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Classic'
     UltraFireSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Ultra2'
     XR4FireSound=Sound'BWBP_SKC_Sounds.XR4.XR4-Fire'
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=2560.000000,Max=2560.000000)
     DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
     KickForce=400
     PenetrateForce=100
     bPenetrate=True
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     FireRecoil=450.000000
     FirePushbackForce=180.000000
     FireChaos=0.300000
     XInaccuracy=310.000000
     YInaccuracy=310.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Single',Volume=1.300000)
     FireAnim="Fire"
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-12.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.400000
}
