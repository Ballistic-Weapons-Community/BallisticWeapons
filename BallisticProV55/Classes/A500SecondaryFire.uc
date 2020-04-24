//=============================================================================
// A500SecondaryFire.
//
// A500 Secondary fire is a blob projectile that causes a residual effect where it lands,
// damaging players in the area, and chewing away their armor.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500SecondaryFire extends BallisticProProjectileFire;

var Sound ChargingSound;
var int AcidLoad;

const ACIDMAX = 8;

function ModeHoldFire()
{
    if ( BW.HasMagAmmo(ThisModeNum) )
    {
        Super.ModeHoldFire();
		BW.bPreventReload = True;
        GotoState('Hold');
    }
}

state Hold
{
    simulated function BeginState()
    {
        AcidLoad = 0;
        SetTimer(0.75, true);
        Instigator.AmbientSound = ChargingSound;
		Instigator.SoundRadius = 256;
		Instigator.SoundVolume = 255;
        Timer();
    }

    simulated function Timer()
    {
		if (BW.HasMagAmmo(ThisModeNum))
			AcidLoad++;
        BW.ConsumeMagAmmo(ThisModeNum, 1);
        if (AcidLoad == ACIDMAX || !BW.HasMagAmmo(ThisModeNum))
            SetTimer(0.0, false);
    }

    simulated function EndState()
    {
		if ( Weapon != None && Instigator != None)
		{
			BW.bPreventReload = False;
			Instigator.AmbientSound = None;
			Instigator.SoundRadius = Instigator.default.SoundRadius;
			Instigator.SoundVolume = Instigator.default.SoundVolume;
		}
    }
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	GoToState('');
	
	if (AcidLoad == 0)
		return;
		
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		A500AltProjectile(Proj).AcidLoad = AcidLoad;
		A500AltProjectile(Proj).AdjustSpeed();
	}
}

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    	local Rotator R;

	if (BW.bScopeView)
		return super(BallisticProjectileFire).GetFireSpread();

	fX = frand();
	R.Yaw =  1536 * sin (FMin(sqrt(frand()), 1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Yaw = -R.Yaw;
	R.Pitch = 1536 * sin (FMin(sqrt(frand()), 1)  * 1.5707963267948966) * cos(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Pitch = -R.Pitch;
	return Vector(R);
}

defaultproperties
{
     ChargingSound=Sound'GeneralAmbience.texture22'
     MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.Reptile.Rep_AltFire',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
     bFireOnRelease=True
     MaxHoldTime=6.000000
     FireEndAnim=
     FireRate=1.500000
     AmmoClass=Class'BallisticProV55.Ammo_A500Cells'
     AmmoPerFire=0
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.A500AltProjectile'
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=True
	 bTossed=True
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.5
     WarnTargetPct=0.800000
}
