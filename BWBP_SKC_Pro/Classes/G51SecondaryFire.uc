//=============================================================================
// G51SecondaryFire.
//
// A grenade that detonates on impact and release lots of smoke
// Will blur screens and obstruct vision of people in it.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G51SecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!G51Carbine(Weapon).bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == G51Carbine(Weapon).GrenadeLoadAnim)
			return false;
		G51Carbine(Weapon).LoadGrenade();
		bIsFiring=false;
		return false;
	}
	return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!CheckGrenade())
		return;
	Super.ModeDoFire();
	G51Carbine(Weapon).bLoaded = false;
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     FireAnim="FireGrenade"
     FireForce="AssaultRifleAltFire"
     FireRate=0.600000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_Chaff'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Chaff'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
