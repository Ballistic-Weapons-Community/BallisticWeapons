//=============================================================================
// JunkThrowFireInfo.
//
// FIXME.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkThrowFireInfo extends JunkFireInfo;

var(Throw)	class<Projectile>		ProjectileClass;		//FIXME
var(Throw)	int						ProjSpeed;
var(Throw)	int						ProjMass;
var(Throw)	StaticMesh				ProjMesh;
var(Throw)	float					ProjScale;
var(Throw)	vector					ProjSpawnOffset;
var(Throw)	class<Actor>			TrailClass;
var(Throw)	EImpactType				WallImpactType;
var(Throw)	EImpactType				ActorImpactType;
var(Throw)	float					DampenFactor;
var(Throw)	float					DampenFactorParallel;
var(Throw)	Rotator					SpinRates;
var(Throw)	class<BCImpactManager>	ImpactManager;
var(Throw)	class<BCImpactManager>	ExplodeManager;
//							FI.SplashManager;
var(Throw)	float					DetonateTimer;
var(Throw)	float					DamageRadius;
//							FI.bCanBePickedUp;
var(Throw)	bool					bAlignToVelocity;
var(Throw)	rotator					StickRotation;
var(Throw)	bool					bCanBePickedUp;

defaultproperties
{
     ProjectileClass=Class'BWBP_JWC_Pro.JunkProjectile'
     projSpeed=1000
     ProjMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerA1'
     ProjScale=1.000000
     ProjSpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     DampenFactor=0.500000
     DampenFactorParallel=0.800000
     aimerror=600.000000
}
