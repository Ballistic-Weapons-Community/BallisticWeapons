//=============================================================================
// XMK5SecondaryFire.
//
// A nice little Dart launcher to stun and poison two legged 'game'.
// Good for disorienting players while you fill them with holes!.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5SecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated function bool CheckDart()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == XMK5SubMachinegun(Weapon).DartLoadAnim)
			return false;
		XMK5SubMachinegun(Weapon).LoadDart();
		bIsFiring=false;
		return false;
	}
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	//Force noobs to scope.
	if ((BW.BCRepClass.default.bSightFireOnly || class'BallisticWeapon'.default.SightsRestrictionLevel > 0) && BW.bUseSights && BW.SightingState != SS_Active && !BW.bScopeHeld && Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None)
		BW.ScopeView();
	if (!BW.bScopeView && (class'BallisticWeapon'.default.SightsRestrictionLevel > 1 || (class'BallisticWeapon'.default.SightsRestrictionLevel > 0 && BW.ZoomType != ZT_Irons)))
		return false;
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	if(!Super.AllowFire() || !bLoaded)
	{
		if (DryFireSound.Sound != None)
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
		BW.EmptyFire(1);
		return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
	}

    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!CheckDart())
		return;
	Super.ModeDoFire();
	bLoaded = false;
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

	FS.DamageInt = default.ProjectileClass.default.Damage + class'XMK5DartPoisoner'.static.GetPoisonDamage();
	FS.Damage = String(int(default.ProjectileClass.default.Damage))@"+"@class'XMK5DartPoisoner'.static.GetPoisonDamage();
	FS.DPS = default.ProjectileClass.default.Damage / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.ProjectileClass.default.Damage) - 1);
	if (default.FireRate < 0.5)
		FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/default.FireRate@"times/second";
	FS.RPShot = default.RecoilPerShot;
	FS.RPS = default.RecoilPerShot / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.Range = "Max:"@(10000 / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
     bLoaded=True
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     FlashBone="tip2"
     XInaccuracy=512.000000
     YInaccuracy=512.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
     bTossed=True
     bModeExclusive=False
     PreFireAnim=
     FireAnim="Fire2"
     FireForce="AssaultRifleAltFire"
     FireRate=2.000000
     AmmoClass=Class'BallisticProV55.Ammo_XMK5Darts'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BallisticProV55.XMK5Dart'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
