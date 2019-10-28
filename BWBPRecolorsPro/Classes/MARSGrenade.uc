//=============================================================================
// MARS-2 grenade. A chaff grenade launched via the MARS' launcher.
//=============================================================================
class MARSGrenade extends BallisticGrenade;

var array<Actor> PokedControls;

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	Destroy();
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local int i;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		//Put out fires.
		//We do this by notifying the FireControl for every fire we hit.
		//The FireControl will then use the info internally to remove the fires, and replicate
		//a function to the client so that the client may also remove the fires.
		if (FP7GroundFire(Victims) != None)
		{
			for (i=0; i < PokedControls.Length && FP7GroundFire(Victims).FireControl != PokedControls[i]; i++);
			
			if (i == PokedControls.Length)
			{
				PokedControls[PokedControls.Length] = FP7GroundFire(Victims).FireControl;
				FP7GroundFire(Victims).FireControl.NotifyPutOut(HitLocation, DamageRadius);
			}
		}
		/* RX22A shit */

		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		else if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		 }
		 
	}
	bHurtEntry = false;
}

defaultproperties
{
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     ImpactDamage=65
     ImpactDamageType=Class'BWBPRecolorsPro.DTChaffGrenade'
     ImpactManager=Class'BWBPRecolorsPro.IM_ChaffGrenade'
     TrailClass=Class'BWBPRecolorsPro.ChaffTrail'
     TrailOffset=(X=1.600000,Z=6.400000)
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTChaffGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=768.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=10.000000
     ShakeRotMag=(X=0.000000,Y=0.000000)
     ShakeRotRate=(X=0.000000,Z=0.000000)
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     Speed=3500.000000
     Damage=75.000000
     DamageRadius=350.000000
     MyDamageType=Class'BWBPRecolorsPro.DTChaffGrenadeRadius'
     StaticMesh=StaticMesh'BallisticHardware2.M900.M900Grenade'
     bUnlit=False
}
