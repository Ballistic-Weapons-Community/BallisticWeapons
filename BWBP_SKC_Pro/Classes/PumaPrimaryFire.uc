//=============================================================================
// PumaSecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PumaPrimaryFire extends BallisticProProjectileFire;

var float ModifiedDetonateDelay; //For manual distance det
var byte LastFireMode;

simulated event ModeDoFire()
{

	if (!AllowFire())
		return;

	if (PumaRepeater(Weapon).bShieldUp)
		PumaRepeater(BW).ParamsClasses[PumaRepeater(BW).GameStyleIndex].static.OverrideFireParams(PumaRepeater(BW),3);
	else
		PumaRepeater(BW).ParamsClasses[PumaRepeater(BW).GameStyleIndex].static.OverrideFireParams(PumaRepeater(BW),LastFireMode);
	
		super.ModeDoFire();

}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float DetonateDelay;

	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;
	if (PumaProjectileRanged(Proj) != None)
	{

		if (ModifiedDetonateDelay != default.ModifiedDetonateDelay)
			DetonateDelay = ModifiedDetonateDelay;
		else
			DetonateDelay = PumaProjectileRanged(Proj).DetonateDelay;
//		PumaProjectileRanged(Proj).InitProgramming(DetonateDelay);
		PumaProjectileRanged(Proj).NewDetonateDelay= FMax(DetonateDelay,0.1);
	}
}


function SetDet(float DetDist)
{ 
//	log("Range:"$ModifiedDetonateDelay);
	ModifiedDetonateDelay=DetDist;
}

simulated function AdjustProps(byte NewMode)
{
	FireRate = Params.FireInterval;

	if (PumaRepeater(BW).PriDetRangeM < 30 && NewMode == 2) //Range
	{
		if (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsTactical())
			FireRate *= 1.2;
		else
			FireRate *= 2;
	}

	if (Weapon.bBerserk)
		FireRate *= 0.50;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}

simulated function SwitchCannonMode (byte NewMode)
{
	LastFireMode = NewMode;
	
	FireRate = Params.FireInterval;
	if (PumaRepeater(BW).PriDetRangeM < 30 && NewMode == 2) //Range
	{
		if (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsTactical())
			FireRate *= 1.2;
		else
			FireRate *= 2;
	}

	if (Weapon.bBerserk)
		FireRate *= 0.50;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}

function StartBerserk()
{
	FireRate = Params.FireInterval;

	if (PumaRepeater(BW).PriDetRangeM < 30 && BW.CurrentWeaponMode == 2)
	{
		if (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsTactical())
			FireRate *= 1.2;
		else
			FireRate *= 2;
	}
		
   	FireRate *= 0.50;
    FireAnimRate = default.FireAnimRate/0.75;
    ReloadAnimRate = default.ReloadAnimRate/0.75;
}

function StopBerserk()
{
	FireRate = Params.FireInterval;
	
	if (PumaRepeater(BW).PriDetRangeM < 30 && BW.CurrentWeaponMode == 2)
	{
		if (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsTactical())
			FireRate *= 1.2;
		else
			FireRate *= 2;
	}
	
    FireAnimRate = default.FireAnimRate;
    ReloadAnimRate = default.ReloadAnimRate;
}

function StartSuperBerserk()
{
	FireRate = Params.FireInterval;
	
	if (PumaRepeater(BW).PriDetRangeM < 30 && BW.CurrentWeaponMode == 2)
	{
		if (class'BallisticReplicationInfo'.static.IsArena() || class'BallisticReplicationInfo'.static.IsTactical())
			FireRate *= 1.2;
		else
			FireRate *= 2;
	}
			
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}

defaultproperties
{
	SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
	MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
	BrassClass=Class'BWBP_SKC_Pro.Brass_PUMA'
	BrassOffset=(X=-20.000000)
	FireRecoil=128.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
	bSplashDamage=True
	bRecommendSplashDamage=True
	bTossed=True
	bModeExclusive=False
	FireForce="AssaultRifleAltFire"
	FireRate=0.9500000
	AimedFireAnim="SightFire"
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_20mmPuma'
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=2.000000
	ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectile'
	BotRefireRate=0.300000
	WarnTargetPct=0.300000
	FireChaos=0.5
	XInaccuracy=32.000000
	YInaccuracy=32.000000
}
