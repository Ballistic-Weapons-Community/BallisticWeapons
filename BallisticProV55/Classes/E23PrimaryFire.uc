class E23PrimaryFire extends BallisticProProjectileFire;

var() sound		PulseFireSound;
var() sound		MultiFireSound;
var vector			ZForce;

var float PushStopFactor; //knockback
var float PushForce; //knockback

var   Actor		MuzzleFlashPulse;
var   Actor		MuzzleFlashMulti;

var() int		SGFireCount;
var   float		NextSGFireTime;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if (MuzzleFlashPulse == None || MuzzleFlashPulse.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashPulse, class'E23FlashEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if (MuzzleFlashMulti == None || MuzzleFlashMulti.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashMulti, class'E23SGFlashEmitter', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	MuzzleFlash = MuzzleFlashPulse;
}

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlashPulse);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashMulti);
}

//Disable fire anim when scoped
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
	// Slightly modified Code from original PlayFiring()
    if (!BW.bScopeView)
        if (FireCount > 0)
        {
            if (Weapon.HasAnim(FireLoopAnim))
                BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
            else
                BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
        }
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function SwitchWeaponMode (byte NewMode)
{
	Super.SwitchWeaponMode(NewMode);
	
	if (NewMode == 1)
	{
		MuzzleFlash = MuzzleFlashMulti;
		BotRefireRate=0.8000;
		NextFireTime = NextSGFireTime;
	}

	else
	{
		MuzzleFlash = MuzzleFlashPulse;
		BotRefireRate=0.9000;
	}
}

simulated state Shotgun
{
	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		local int i, j;
		local rotator R;

		j = Min(SGFireCount, BW.MagAmmo);
		ConsumedLoad = (AmmoPerFire * j);
		for (i=0;i<j;i++)
		{
			R.Roll = ((65536.0 / j) * i) -16384;

			if (BW.bScopeView || BW.bAimDisabled)
				Proj = Spawn (ProjectileClass,,, Start, rotator((Vector(rot(0,96,0)) >> R) >> Dir) );
			else Spawn (ProjectileClass,,, Start, rotator((Vector(rot(0,256,0)) >> R) >> Dir) );
			if (Proj != None)
				Proj.Instigator = Instigator;
		}
	}

	function PlayFiring()
	{
		if (ScopeDownOn == SDO_Fire)
			BW.TemporaryScopeDown(0.5, 0.9);
		// Slightly modified Code from original PlayFiring()
	    if (!BW.bScopeView)
	        if (FireCount > 0)
	        {
	            if (Weapon.HasAnim(FireLoopAnim))
	                BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	            else
	                BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	        }
	        else
	            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	    ClientPlayForceFeedback(FireForce);  // jdf
	    FireCount++;
		// End code from normal PlayFiring()
	
		if (BallisticFireSound.Sound != None)
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	
		CheckClipFinished();

		NextSGFireTime = NextFireTime + FireRate;
        NextSGFireTime = FMax(NextSGFireTime, Level.TimeSeconds);
	}

	simulated function EndState()
	{
		NextSGFireTime = NextFireTime;
		NextFireTime -= 1.3;
	}
}

// Used to delay ammo consumtion
simulated event Timer()
{
	super.Timer();
	if (Weapon.Role == ROLE_Authority && ConsumedLoad > 0)
	{
		if (BW != None)
			BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
		else
			Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
	}
	ConsumedLoad=0;
}

defaultproperties
{
     ZForce=(Z=5.000000)
     PushStopFactor=0.100000
     PushForce=800.000000
     SGFireCount=3
     bPawnRapidFireAnim=True
     AmmoClass=Class'BallisticProV55.Ammo_E23Cells'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000

	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
	 
     aimerror=400.000000
}
