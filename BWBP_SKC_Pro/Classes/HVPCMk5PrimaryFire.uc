//=============================================================================
// HVPCMk5PrimaryFire.
//
// Large plasma charges. Travel fairly fast and pack a punch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk5PrimaryFire extends BallisticProProjectileFire;

var float	StopFireTime;
var byte	ProjectileCount;
var float HipSpreadFactor;

//return spread in radians
simulated function float GetCrosshairInaccAngle()
{
	return YInaccuracy * HipSpreadFactor * 0.000095873799;
}


simulated function bool AllowFire()
{
	if ((HVPCMk5PlasmaCannon(BW).HeatLevel >= 11.5) || HVPCMk5PlasmaCannon(BW).bIsVenting || !super.AllowFire())
		return false;
	return true;
}


function PlayFiring()
{
	Super.PlayFiring();
	if (!HVPCMk5PlasmaCannon(BW).bMilSpec)
		HVPCMk5PlasmaCannon(BW).AddHeat(HeatPerShot);
}


function StopFiring()
{
	bIsFiring=false;
	StopFireTime = level.TimeSeconds;
}

simulated state SingleShot
{

	function DoFireEffect()
	{
		Super.DoFireEffect();
		if (level.Netmode == NM_DedicatedServer && !HVPCMk5PlasmaCannon(BW).bMilSpec)
			HVPCMk5PlasmaCannon(BW).AddHeat(HeatPerShot);
	}
}

simulated state SpreadShot
{
	// Get aim then spawn projectile
	function DoFireEffect()
	{
		local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;
		local int i;

		Weapon.GetViewAxes(X,Y,Z);
		// the to-hit trace always starts right in front of the eye
		Start = Instigator.Location + Instigator.EyePosition();

		StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
		if(!Weapon.WeaponCentered())
			StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

		for(i=0; i < ProjectileCount; i++)
		{
			Aim = GetFireAim(StartTrace);
			Aim = Rotator(GetFireSpread() >> Aim);

			End = Start + (Vector(Aim)*MaxRange());
			Other = Trace (HitLocation, HitNormal, End, Start, true);

			if (Other != None)
				Aim = Rotator(HitLocation-StartTrace);
			SpawnProjectile(StartTrace, Aim);
		}

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		Super(BallisticFire).DoFireEffect();
		if (level.Netmode == NM_DedicatedServer && !HVPCMk5PlasmaCannon(BW).bMilSpec)
			HVPCMk5PlasmaCannon(BW).AddHeat(HeatPerShot);
	}

	// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
	simulated function vector GetFireSpread()
	{
		local float fX;
		local Rotator R;

		if (BW.bScopeView || BW.bAimDisabled)
			return super.GetFireSpread();
		else
		{
			fX = frand();
			R.Yaw =  XInaccuracy * HipSpreadFactor * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
			R.Pitch = YInaccuracy * HipSpreadFactor *sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
			return Vector(R);
		}
	}
}

//Accessor for stats
static function FireEffectParams.FireModeStats GetStats() 
{
	local FireEffectParams.FireModeStats FS;
	
	FS.DamageInt = default.ProjectileClass.default.Damage * default.ProjectileCount;
	FS.Damage = String(FS.DamageInt);


    FS.HeadMult = class<BallisticProjectile>(default.ProjectileClass).default.HeadMult;
    FS.LimbMult = class<BallisticProjectile>(default.ProjectileClass).default.LimbMult;

	FS.DPS = default.ProjectileClass.default.Damage * default.ProjectileCount / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.ProjectileClass.default.Damage) - 1);
	FS.RPM = String(int((1 / default.FireRate) * 60))@"shots/min";
	FS.RPShot = default.FireRecoil;
	FS.RPS = default.FireRecoil / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.RangeOpt = "Max:"@(10000 / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
     ProjectileCount=3
	 HeatPerShot=1.5
     HipSpreadFactor=1.100000
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
     FireRecoil=700.000000
     FireChaos=0.400000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="FireAlt"
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     AmmoPerFire=5
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
     WarnTargetPct=0.200000
}
