//=============================================================================
// Cryo Rocket.
//=============================================================================
class SMATRocketIce extends BallisticProjectile;

var array<Actor> PokedControls;

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    Super.ApplyImpactEffect(Other, HitLocation);

	if (Pawn(Other) != None)
		ApplySlowdown(Pawn(Other), Damage/5);
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Excluded )
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
		else if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Excluded && Victims != HurtWall)
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
			if (Pawn(Victims) != None)
				ApplySlowdown(Pawn(Victims), Damage/6);
		 }
		 
	}
	bHurtEntry = false;
}

function ApplySlowdown(Pawn Target, float Duration)
{
	class'BCSprintControl'.static.AddSlowTo(Target, 0.3, Duration);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local SMATIceCloudControl C;
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

	if ( Role == ROLE_Authority )
	{
		C = Spawn(class'SMATIceCloudControl',self,,HitLocation-HitNormal*2);
		if (C!=None)
		{
			C.Instigator = Instigator;
		}
	}
	Destroy();
}

defaultproperties
{
	 WeaponClass=Class'BWBP_SKC_Pro.SMATLauncher'
     TrailClass=Class'BWBP_SKC_Pro.SMATRocketTrailIce'
     MyDamageType=Class'BWBP_SKC_Pro.DTSMAT_IceRocket'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTSMAT_IceRadius'
     TrailOffset=(X=-4.000000)
     ImpactManager=Class'BWBP_SKC_Pro.IM_SMATCryo'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=600.000000
     MaxSpeed=14000.000000
     Damage=100.000000
     DamageRadius=1024.000000
     MomentumTransfer=20000.000000
	 MotionBlurRadius=768.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=10.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     SoundVolume=64
     bCollideActors=False
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
