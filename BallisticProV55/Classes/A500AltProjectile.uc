//=============================================================================
// A500AltProjectile.
//
// Blob fired by A500.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500AltProjectile extends BallisticGrenade;

var int AcidLoad, BaseImpactDamage, BonusImpactDamage;

const ACIDMAX = 8.0f;

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	local int DirectDamage;

	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Other == HitActor)
		return;
	if (Base != None)
		return;
		
	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	DirectDamage = BaseImpactDamage + (BonusImpactDamage * (AcidLoad / ACIDMAX));

	class'BallisticDamageType'.static.GenericHurt (Other, DirectDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
	ReduceHP(Other);
	HitActor = Other;
	Explode(HitLocation, Normal(HitLocation-Other.Location));
}

function ReduceHP (Actor Other)
{
	local A500HPReducer hpReducer;
	
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		hpReducer= A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
	
		if (hpReducer == None)
		{
			Pawn(Other).CreateInventory("BallisticProV55.A500HPReducer");
			hpReducer = A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
		}
	
		hpReducer.AddStack(12 * (AcidLoad / ACIDMAX));
	}
}
simulated function BlowUp(vector HitLocation)
{
	local vector Start;

	Start = Location/* + 10 * HitNormal*/;
	ConsistentHurtRadius(Damage, DamageRadius * (AcidLoad/ACIDMAX), MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function ConsistentHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			//Cover penetration code for explosives.
			if (!FastTrace(Victims.Location, Location))
				continue;
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;

			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(Momentum * dir),
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local A500AcidControl F;
	local Teleporter TB;

	Super.Explode(HitLocation,HitNormal);

	if(Role == ROLE_Authority)
	{
		//No teleporter camping, die die die
		foreach RadiusActors(class'Teleporter', TB, 256)
		{
			if (Instigator != None)
				Level.Game.Broadcast(self, "A500 Acid Bomb fired by"@Instigator.PlayerReplicationInfo.PlayerName@"too close to a teleporter!");
			return;
		}
		F = Spawn(class'A500AcidControl',self,,HitLocation+HitNormal*4, rot(0,0,0));
		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize(HitNormal, AcidLoad);
		}
	}

	Destroy();
}

function AdjustSpeed()
{
	Velocity = Vector(Rotation) * ((default.Speed * 0.25) + (default.Speed * 0.75 * (float(AcidLoad) / ACIDMAX)));
}

defaultproperties
{
     DetonateOn=DT_Impact
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
	 DetonateDelay=1.000000
	 BaseImpactDamage=50
     BonusImpactDamage=100
     ImpactDamageType=Class'BallisticProV55.DTA500Impact'
     ImpactManager=Class'BallisticProV55.IM_A500AcidExplode'
     TrailClass=Class'BallisticProV55.A500AltProjectileTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BallisticProV55.DTA500Splash'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=6000.000000
     MaxSpeed=6000.000000
     Damage=25.000000
     DamageRadius=768.000000
     MomentumTransfer=0.000000
     MyDamageType=Class'BallisticProV55.DTA500Splash'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=54
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=8.000000
     bDynamicLight=True
     DrawScale=1.000000
}
