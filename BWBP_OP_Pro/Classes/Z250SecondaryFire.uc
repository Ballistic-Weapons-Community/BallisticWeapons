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
     MuzzleFlashClass=Class'BWBP_OP_Pro.Z250GrenadeFlashEmitter'
     FlashBone="GLtip"
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.Z250.Z250-GrenadeFire')
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=False
     bWaitForRelease=False
     PreFireAnim=
     FireAnim="GLFire"
     FireForce="AssaultRifleAltFire"
     FireRate=0.800000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_Z250GasGrenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_OP_Pro.Z250Grenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
