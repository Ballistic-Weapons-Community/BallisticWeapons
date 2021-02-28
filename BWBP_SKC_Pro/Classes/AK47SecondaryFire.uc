//=============================================================================
// AK490 Secondary Fire
//
// Ballistic knife.
//=============================================================================
class AK47SecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated function bool CheckKnife()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == AK47AssaultRifle(Weapon).KnifeLoadAnim)
			return false;
		AK47AssaultRifle(Weapon).LoadKnife();
		bIsFiring=false;
		return false;
	}
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
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
	if (!CheckKnife())
		return;
	Super.ModeDoFire();

	PreFireTime = 0;
	AK47AssaultRifle(Weapon).BladeOut();
	bLoaded = false;
}

function StopFiring()
{
	local int channel;
	local name seq;
	local float frame, rate;
	
	weapon.GetAnimParams(channel, seq, frame, rate);
	if (Seq == PreFireAnim)
		Weapon.PlayAnim(Weapon.IdleAnim, 1.0, 0.5);
}

defaultproperties
{
     bLoaded=True
     SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
     bUseWeaponMag=False
     FlashBone="tip2"
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=1.350000)
     bTossed=True
     bFireOnRelease=True
     bWaitForRelease=True
     PreFireTime=0.450000
     PreFireAnim="PreKnifeFire"
     FireAnim="KnifeFire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.650000
     AmmoClass=Class'BallisticProV55.Ammo_XMK5Darts'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKC_Pro.AK47Knife'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
