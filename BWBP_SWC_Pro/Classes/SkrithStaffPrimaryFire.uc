//=============================================================================
// A73PrimaryFire.
//
// A73 primary fire is a fast moving projectile that goes through enemies and
// isn't hard to spot ITS ALSO A FIRE
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SkrithStaffPrimaryFire extends BallisticProProjectileFire;

var() sound		ChargeFireSound;
var() sound		PowerFireSound;

simulated event ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (Weapon.SoundPitch != 36)
	{
		if (Instigator.DrivenVehicle!=None)
			Weapon.SoundPitch = 36;
		else
			Weapon.SoundPitch = Max(36, Weapon.SoundPitch - 8*DT);
	}
}

function PlayFiring()
{
	Super.PlayFiring();

	Weapon.SoundPitch = Min(120, Weapon.SoundPitch + 8);
}

simulated function SwitchCannonMode (byte NewMode)
{
    if (NewMode == 0)
    {
        bSplashDamage=false;
        bRecommendSplashDamage=false;
    }
    
    else if (NewMode == 1)
    {
        bSplashDamage=true;
        bRecommendSplashDamage=true;
    }
    else
    if (Weapon.bBerserk)
        FireRate *= 0.75;
    if ( Level.GRI.WeaponBerserk > 1.0 )
        FireRate /= Level.GRI.WeaponBerserk;

    Load=AmmoPerFire;
}

defaultproperties
{
     ChargeFireSound=Sound'BWBP_SWC_Sounds.SkrithStaff.SkrithStaff-Shot'
     PowerFireSound=Sound'BWBP_SKC_Sounds.A73E.A73E-Power'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
     FireRecoil=128.000000
     XInaccuracy=64.000000
     YInaccuracy=64.000000
	 FireChaos=0.25000
     BallisticFireSound=(Sound=Sound'BWBP_SWC_Sounds.SkrithStaff.SkrithStaff-Shot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
	 FlashScaleFactor=0.200000
	 AimedFireAnim="FireSight"
	 FireAnim="Fire"
     FireEndAnim=
     FireRate=0.170000
	 FlashBone="Muzzle"
	 AmmoPerFire=2
	AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=32.000000,Y=10.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.750000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.750000
     ProjectileClass=Class'BWBP_SWC_Pro.SkrithStaffProjectile'
     WarnTargetPct=0.200000
}
