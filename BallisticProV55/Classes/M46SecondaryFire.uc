//=============================================================================
// M46SecondaryFire.
//
// A grenade that attaches itself to walls, players, and vehicles.
// Blows up when approached by players if stuck to a wall, otherwise it blows up shortly after being attached.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46SecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if(!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if(seq == M46AssaultRifle(Weapon).GrenadeLoadAnim)
			return false;

		M46AssaultRifle(Weapon).LoadGrenade();
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
	bLoaded = false;
	PreFireTime = 0;
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

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		M46Grenade(Proj).M46 = M46AssaultRifle(BW);
	}
}

defaultproperties
{
     bLoaded=True
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="tip2"
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-AR.OA-AR_FireGren',Volume=1.750000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=True
     PreFireTime=0.450000
     PreFireAnim="GrenadePrepFire"
     FireAnim="GrenadeFire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_M46Grenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BallisticProV55.M46Grenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
