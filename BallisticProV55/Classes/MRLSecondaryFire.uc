//=============================================================================
// MRLSecondaryFire.
//
// JL21-MRL super speed fire. Fires rockets loaded barrels very rapidly, then
// reloads and fire barrels at a very high rate. The result is a swarm of JL21
// rockets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLSecondaryFire extends BallisticProjectileFire;

var float	WaitTime;
var bool	bFireRockets;
var MRocketLauncher MRL;
var int ConsumedLoadTwo;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	MRL = MRocketLauncher(Weapon);
}

simulated function bool AllowFire()
{
;
	if (OldAllowFire())
		return true;

	bFireRockets = false;
	return false;
}
// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool OldAllowFire()
{
	if (Instigator.Physics != PHYS_Walking)
		return false;
	if (!BW.bScopeHeld && BW.SightingState != SS_Active && Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None)
	{
		BW.ScopeView();
		if (!BW.bScopeView)
			return false;
	}
	if (MRL.LoadedFrontBarrels < AmmoPerFire && MRL.LoadedBackBarrels < AmmoPerFire)
	{
		if (MRL.MagAmmo+MRL.BigMagAmmo < AmmoPerFire)
		{
			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);
			BW.EmptyFire(ThisModeNum);
		}
		return false;
	}
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
		{
			if (DryFireSound.Sound != None)
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
		}
	}
	else if (MRL.MagAmmo+MRL.BigMagAmmo < AmmoPerFire)
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

event ModeTick(float DT)
{
	local int RocketsToFire;

	super.ModeTick(DT);

	if (IsFiring() && bFireRockets)
	{
		WaitTime += DT;
		RocketsToFire = WaitTime * 13;
		if (RocketsToFire > 0)
		{
			WaitTime = 0;
			FireRockets(RocketsToFire);
		}
	}
	else
	{
		bFireRockets=false;
		WaitTime = 0;
	}
}

function DoFireEffect()
{
	ConsumedLoad -= 1;
	bFireRockets = true;
	Super(BallisticFire).DoFireEffect();
}

function FireRockets(int RocketsToFire)
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim, R;
	local actor Other;
	local int i, L1, L2;

    Weapon.GetViewAxes(X,Y,Z);
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

	Aim = GetFireAim(StartTrace);

	End = Start + (Vector(Aim)*MaxRange());
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		Aim = Rotator(HitLocation-StartTrace);


	for (i=0; i<RocketsToFire && i<MRL.LoadedFrontBarrels+MRL.LoadedBackBarrels && i<BW.MagAmmo+MRL.BigMagAmmo; i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
	    SpawnProjectile(StartTrace, R);
		if (MRL.LoadedBackBarrels-L1 > 0 && (MRL.LoadedFrontBarrels-L2 < 1 || MRL.BigMagAmmo < 1 || float(MRL.BarrelIndex) / 3.0 == MRL.BarrelIndex / 3))
		{
			ConsumedLoad += 1;
			L1++;
		}
		else
		{
			ConsumedLoadTwo += 1;
			L2++;
		}

		MRL.BarrelIndex++;
		if (MRL.BarrelIndex >= 18)
			MRL.BarrelIndex=0;
	}
	
    if(InStr(Level.Game.GameName, "Freon") != -1 && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(RocketsToFire, 1);

	MRL.LoadedBackBarrels = Max(0, MRL.LoadedBackBarrels-L1);
	MRL.LoadedFrontBarrels = Max(0, MRL.LoadedFrontBarrels-L2);
	MRL.UpdateNetBarrels();
	SetTimer(firerate/2, false);

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
}

simulated event Timer()
{
	if (Weapon.Role == ROLE_Authority)
		MRL.ConsumeMRLAmmo(ThisModeNum, ConsumedLoad, ConsumedLoadTwo);
	ConsumedLoad=0;
	ConsumedLoadTwo=0;
}

function FlashMuzzleFlash()
{
	MRL.PrimaryFire.FlashMuzzleFlash();
}

defaultproperties
{
     SpawnOffset=(X=28.000000,Y=8.000000,Z=-6.000000)
     RecoilPerShot=96.000000
     FireChaos=0.080000
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.080000
     AmmoClass=Class'BallisticProV55.Ammo_MRL'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.MRLRocketSecondary'
     WarnTargetPct=0.200000
}
