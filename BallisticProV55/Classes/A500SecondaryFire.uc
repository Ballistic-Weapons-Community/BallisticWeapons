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

var Sound 			ChargingSound;
var int 			AcidLoad;
var const int 		MaxAcidLoad;

function ModeHoldFire()
{
    if ( BW.HasMagAmmo(ThisModeNum) && (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsTactical()))
    {
        Super.ModeHoldFire();
		BW.bPreventReload = True;
		// (a hold always starts afresh: going to the state it is already in runs no BeginState)
		if (IsInState('Hold'))
			GotoState('');
        GotoState('Hold');
    }
}

// The blob is spawned on the server only, and SpawnProjectile leaves Hold there. The owner's machine leaves it here,
// as the A49 does: kept in it, the shot's own timer ran Hold's Timer and took one cell more than the server did, and
// every later hold found it still in Hold, so it never charged on that machine again
simulated event ModeDoFire()
{
	Super.ModeDoFire();
	if (IsInState('Hold'))
		GotoState('');
}

state Hold
{
	simulated function bool AllowFire()
	{
		if (!CheckReloading())
			return false;		// Is weapon busy reloading
		if (!CheckWeaponMode())
			return false;		// Will weapon mode allow further firing

		if (BW.MagAmmo == 0 && HoldTime == 0)
		{
			if (!bPlayedDryFire && DryFireSound.Sound != None)
			{
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
				bPlayedDryFire=true;
			}
			if (bDryUncock)
				BW.bNeedCock=true;

			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

			BW.EmptyFire(ThisModeNum);

			return false;		// Is there ammo in weapon's mag
		}
		else if (BW.bNeedReload)
			return false;
		else if (BW.bNeedCock)
			return false;		// Is gun cocked

		return true;
	}

    simulated function BeginState()
    {
        AcidLoad = 0;
        SetTimer(0.5, true);
        Instigator.AmbientSound = ChargingSound;
		Instigator.SoundRadius = 256;
		Instigator.SoundVolume = 255;
        Timer();
    }

    simulated function Timer()
    {
		if (BW.HasMagAmmo(ThisModeNum))
		{
			AcidLoad++;
        	BW.ConsumeMagAmmo(ThisModeNum, 1);
		}
		
        if (AcidLoad == MaxAcidLoad || !BW.HasMagAmmo(ThisModeNum))
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
		A500AltProjectile(Proj).AcidLoad = float(AcidLoad)/float(MaxAcidLoad);
		A500AltProjectile(Proj).AdjustSpeed();
	}
}

defaultproperties
{
	AcidLoad=1
	MaxAcidLoad=8
	AmmoPerFire=0
	ChargingSound=Sound'GeneralAmbience.texture22'
	bFireOnRelease=True
	AmmoClass=Class'BallisticProV55.Ammo_A500Cells'

	ShakeRotMag=(X=32.000000,Y=8.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=1.500000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=1.500000

	// AI
	bInstantHit=True
	bLeadTarget=True
	bTossed=True

	BotRefireRate=0.5
}
