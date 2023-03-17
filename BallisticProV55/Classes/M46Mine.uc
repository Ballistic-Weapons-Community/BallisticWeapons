class M46Mine extends BallisticProjectile;

var() Sound				DetonateSound;
var 	bool			bManualMode;		// Requires manual activation
var   float				TriggerStartTime;	// Time when trigger will be active

simulated function ProcessTouch (Actor Other, vector HitLocation);
function SetManualMode (bool bManual);	

function bool IsStationary()
{
	return true;
}

defaultproperties
{
    WeaponClass=Class'BallisticProV55.M46AssaultRifle'
     ModeIndex=1
     DetonateSound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_GrenadeBeep'
     ImpactManager=Class'BallisticProV55.IM_Grenade'
     MyRadiusDamageType=Class'BallisticProV55.DTM46GrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     WallPenetrationForce=128
     MyDamageType=Class'BallisticProV55.DTM46GrenadeRadius'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-AR.OA-AR_Grenade'
     CullDistance=2500.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.450000
     bUnlit=False
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
}
