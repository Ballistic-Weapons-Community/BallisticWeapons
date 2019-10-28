//=============================================================================
// BX5PrimaryFire.
//
// Deploy a BX5 mine if possible by spawn wither a vehicle or spring mine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5PrimaryFire extends BallisticProjectileFire;

var   Actor 	LastTrace;
var   Vector	LastHitLoc, LastHitNorm;

function float MaxRange()
{
	return 5000;
}

simulated event ModeDoFire()
{
	local Vector Start, End;

	if (Weapon.Role == ROLE_Authority)
	{
    	if (!AllowFire())
        	return;
		// Check for wall
		Start = Instigator.Location + Instigator.EyePosition();
		if (AIController(Instigator.Controller) != None)
			End = Start + vect(0,0,-128);
		else
			End = Start + vector(Instigator.GetViewRotation()) * 90;
		LastTrace = Trace(LastHitLoc, LastHitNorm, End, Start, false);
		if (LastTrace == None || /*HitNorm.Z < 0.5 ||*/ (!LastTrace.bWorldGeometry && Mover(LastTrace) == None))
			return;
		if (!Instigator.IsLocallyControlled())
			BX5Mine(Weapon).ClientPlayMineDeploy();
	    super.ModeDoFire();
	}
}
simulated event ClientPlayMineDeploy()
{
    super.ModeDoFire();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local Rotator R;

	if (LastTrace == None)
		return;
	R = Rotator(LastHitNorm);
	R.Roll = Rand(65536);
	if (BX5Mine(Weapon).bSpringMode)
		Proj = Spawn (class'BX5SpringMine',,, LastHitLoc, R);
	else
		Proj = Spawn (class'BX5VehicleMine',,, LastHitLoc+LastHitNorm*2, R);
	if (Proj != None)
	{
		Proj.bHardAttach = true;
		Proj.SetBase(LastTrace);
		Proj.Instigator = Instigator;
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=-10.000000,Z=-5.000000)
     bUseWeaponMag=False
     bAISilent=True
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireAnim="Deploy"
     TweenTime=0.200000
     FireForce="AssaultRifleAltFire"
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_BX5Mines'
     ProjectileClass=Class'BallisticProV55.BX5VehicleMine'
     BotRefireRate=0.300000
}
