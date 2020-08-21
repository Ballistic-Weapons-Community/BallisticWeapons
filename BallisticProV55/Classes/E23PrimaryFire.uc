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
		WarnTargetPct=0.20000;
		NextFireTime = NextSGFireTime;
	}

	else
	{
		MuzzleFlash = MuzzleFlashPulse;
		BotRefireRate=0.9000;
		WarnTargetPct=0.10000;
	}
}

function StartBerserk()
{
	if (BW.CurrentWeaponMode == 0)
	{
		FireRate = default.FireRate * 0.75;
		FireAnimRate = default.FireAnimRate * 0.75;
		RecoilPerShot = default.RecoilPerShot * 0.75;
		FireChaos = default.FireChaos * 0.75;
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate * 0.75;
    	FireAnimRate = default.FireAnimRate * 0.75;
    	RecoilPerShot = FireModes[BW.CurrentWeaponMode-1].mRecoil * 0.75;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos * 0.75;
	}
}

function StopBerserk()
{
	if (BW.CurrentWeaponMode == 0)
	{
		FireRate = default.FireRate;
		FireAnimRate = default.FireAnimRate;
		RecoilPerShot = default.RecoilPerShot;
		FireChaos = default.FireChaos;
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate;
    	FireAnimRate = default.FireAnimRate;
    	RecoilPerShot = FireModes[BW.CurrentWeaponMode-1].mRecoil;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos;
	}
}

function StartSuperBerserk()
{
	if (BW.CurrentWeaponMode == 3)
    	FireRate = 0.6;
	else if (BW.CurrentWeaponMode == 2)
    	FireRate = 0.08;
	else if (BW.CurrentWeaponMode == 1)
    	FireRate = 1.5;
	else
    	FireRate = 0.15;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
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

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

	FS.DamageInt = default.ProjectileClass.default.Damage;
	FS.Damage = String(FS.DamageInt)@"-"@String(Int(FS.DamageInt * 1.6));
	FS.DPS = default.ProjectileClass.default.Damage / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.ProjectileClass.default.Damage) - 1);
	FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	FS.RPShot = default.RecoilPerShot;
	FS.RPS = default.RecoilPerShot / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.Range = "Max dmg: 0.3s";
	
	return FS;
}

defaultproperties
{
     ZForce=(Z=5.000000)
     PushStopFactor=0.100000
     PushForce=800.000000
     SGFireCount=3
     SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     FireModes(0)=(mProjClass=Class'BallisticProV55.E23Projectile_SG',mFireRate=0.50000,mFireChaos=0.500000,mFireSound=Sound'BWBP4-Sounds.VPR.VPR-SGFire',mFireAnim="Fire2",mRecoil=768.000000,mAmmoPerFire=5,TargetState="Shotgun",bModeLead=True)
     FireModes(1)=(mProjClass=Class'BallisticProV55.E23Projectile_Snpr',mFireRate=0.650000,mFireChaos=0.350000,mFireSound=Sound'BWBP4-Sounds.VPR.VPR-Fire',mFireAnim="Fire",mRecoil=768.000000,mAmmoPerFire=20,bModeLead=True)
     MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
     FlashScaleFactor=0.750000
     RecoilPerShot=96.000000
     FireChaos=0.060000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.150000
     AmmoClass=Class'BallisticProV55.Ammo_E23Cells'
     AmmoPerFire=5
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.E23Projectile_Std'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.2
	 
     aimerror=400.000000
}
