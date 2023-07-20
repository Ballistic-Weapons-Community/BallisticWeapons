//=============================================================================
// Cryo Rocket.
//=============================================================================
class BRINKRocket extends BallisticProjectile;

var array<Actor> PokedControls;

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;
	
	SetTimer(0.5, false);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function Timer()
{
	SetCollision(true,true);

	InitProjectile();
	
	Velocity = vector(Rotation) * MaxSpeed;
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    Super.ApplyImpactEffect(Other, HitLocation);

	if (Pawn(Other) != None)
		ApplySlowdown(Pawn(Other), Damage/8);
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
				ApplySlowdown(Pawn(Victims), Damage/8);
		 }
		 
	}
	bHurtEntry = false;
}

function ApplySlowdown(Pawn Target, float Duration)
{
	class'BCSprintControl'.static.AddSlowTo(Target, 0.7, Duration);
}

defaultproperties
{
	WeaponClass=Class'BWBP_SWC_Pro.BRINKAssaultRifle'
	ModeIndex=1
	TrailClass=Class'BallisticProV55.MRLTrailEmitter'
	TrailOffset=(X=-4.000000)
	MyRadiusDamageType=Class'BWBP_SWC_Pro.DTBRINKGrenade'
	ImpactManager=Class'BWBP_SWC_Pro.IM_BRINKGrenade'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Speed=600.000000
	MaxSpeed=14000.000000
	Damage=100.000000
	DamageRadius=500.000000
	MomentumTransfer=20000.000000
	MotionBlurRadius=768.000000
	MotionBlurFactor=2.000000
	MotionBlurTime=10.000000
	MyDamageType=Class'BWBP_SWC_Pro.DTBRINKGrenade'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
	AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
	SoundVolume=64
	bCollideActors=False
	bFixedRotationDir=True
	RotationRate=(Roll=32768)
}
