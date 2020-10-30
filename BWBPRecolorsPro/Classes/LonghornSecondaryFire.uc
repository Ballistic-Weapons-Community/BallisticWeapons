//=============================================================================
// Longhorn secondary fire
//
// Sprays clusters of death in a similar manner to a shotgun
//
// by Casey "The Xavious" Johnson
//=============================================================================
class LonghornSecondaryFire extends BallisticProProjectileFire;

var byte ProjectileCount;
var float HipMultiplier;

function ServerPlayFiring()
{
	super.ServerPlayFiring();
	LonghornLauncher(Weapon).LonghornFired();
}

//Do the spread on the client side
function PlayFiring()
{
	super.PlayFiring();
	LonghornLauncher(Weapon).LonghornFired();
}

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();
	else
	{
		fX = frand();
		R.Yaw =  XInaccuracy * HipMultiplier * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = YInaccuracy * HipMultiplier *sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
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
}

defaultproperties
{
     ProjectileCount=6
	 HipMultiplier=2
     bNoRandomFire=True
     bCockAfterFire=True
     AimedFireAnim="SightFire"
     FireRecoil=1024.000000
     FirePushbackForce=800.000000
     FireChaos=1.000000
     XInaccuracy=256.000000
     YInaccuracy=256.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Longhorn.Longhorn-FireAlt',Volume=1.700000)
     FireAnimRate=2.00000
     FireRate=0.800000
     ProjectileClass=Class'BWBPRecolorsPro.LonghornClusterGrenadeAlt'
	 
	  // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.3
}
