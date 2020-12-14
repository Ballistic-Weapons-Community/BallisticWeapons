//=============================================================================
// A500PrimaryFire.
//
// A500 primary fire is a shotgun blast that spawns corrosive projectiles.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500PrimaryFire extends BallisticProProjectileFire;

var byte	ProjectileCount;
var float HipSpreadFactor;

//return spread in radians
simulated function float GetCrosshairInaccAngle()
{
	return YInaccuracy * HipSpreadFactor * 0.000095873799;
}

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
	Super.DoFireEffect();
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

// Returns the normal of the player's aim with weapon aim/pitch applied. Also sets StartTrace vector
simulated function vector GetFireDir(out Vector StartTrace)
{
    // the to-hit trace always starts right in front of the eye
	if (StartTrace == vect(0,0,0))
		StartTrace = Instigator.Location + Instigator.EyePosition();
	return Vector(AdjustAim(StartTrace, AimError));
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
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
     ProjectileCount=5
     HipSpreadFactor=1.750000
     bNoRandomFire=True
     MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
     FireRecoil=378.000000
     FireChaos=0.400000
     XInaccuracy=220.000000
     YInaccuracy=220.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_Fire1',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
     FireEndAnim=
     FireAnimRate=1.300000
     FireRate=0.4
     AmmoClass=Class'BallisticProV55.Ammo_A500Cells'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.A500Projectile'
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=True
	 bTossed=True
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.200000
}
