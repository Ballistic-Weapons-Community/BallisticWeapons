// It's the M50 secondary fire
class Z250SecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated event ModeHoldFire()
{
	super.ModeHoldFire();
    CheckGrenade();
}

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == Z250Minigun(Weapon).GrenadeLoadAnim)
			return false;
		Z250Minigun(Weapon).LoadGrenade();
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

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Z250Grenade(Proj) != None)
	{
		Proj.Instigator = Instigator;
		Z250Grenade(Proj).FireControl = Z250Minigun(Weapon).FireControl;
	}
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
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BWBPOtherPackPro.Z250GrenadeFlashEmitter'
     FlashBone="GLtip"
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M50.M50GrenFire')
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=False
     bWaitForRelease=False
     PreFireAnim=
     FireAnim="GLFire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.800000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_Z250GasGrenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPOtherPackPro.Z250Grenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
