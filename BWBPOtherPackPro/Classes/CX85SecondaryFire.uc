class CX85SecondaryFire extends BallisticProProjectileFire;

simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (CX85AssaultWeapon(BW).AltAmmo < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

function DoFireEffect()
{
	Super.DoFireEffect();
	CX85AssaultWeapon(BW).AltAmmo--;
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		CX85Dart(Proj).Master = CX85AssaultWeapon(BW);
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=15.000000,Z=-2.000000)
     bUseWeaponMag=False
     FlashBone="tip2"
     FireRecoil=256.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
     bModeExclusive=False
     PreFireAnim=
     FireAnim="FireAlt"
     FireForce="AssaultRifleAltFire"
     FireRate=0.350000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_CX85Darts'
     AmmoPerFire=0
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPOtherPackPro.CX85Dart'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
