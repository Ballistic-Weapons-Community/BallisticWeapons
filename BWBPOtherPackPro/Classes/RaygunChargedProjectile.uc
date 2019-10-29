class RaygunChargedProjectile extends BallisticProjectile;

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super.GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	Dmg *= 1 + 0.5 * FMin(default.LifeSpan - LifeSpan, 0.6) / 0.6;
	
	return Other;
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
	if (DamageRadius > 0)
		TargetedHurtRadius(Damage * (0.5 + 0.5 * FMin(default.LifeSpan - LifeSpan, 1)), DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	MakeNoise(1.0);
}

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);

	SetRotation(Rotation  + rot(0,0,250000) * DeltaTime);
}

function DoDamage (Actor Other, vector HitLocation)
{
	local RaygunPlagueEffect RPE;
	
	super.DoDamage (Other, HitLocation);
	
	if (Pawn(Other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None && Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime)
	{
		foreach Other.BasedActors(class'RaygunPlagueEffect', RPE)
		{
			RPE.ExtendDuration(4);
		}
		if (RPE == None)
		{
			RPE = Spawn(class'RaygunPlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
			RPE.Initialize(Other);
			if (Instigator!=None)
			{
				RPE.Instigator = Instigator;
				RPE.InstigatorController = Instigator.Controller;
			}
		}
	}
}

function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local RaygunPlagueEffect RPE;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Victim == None)
	{
		DamageAmount *= 0.5;
		DamageRadius *= 0.75;
	}
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
				continue;
					
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
				
				
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * 0.8 * dir),
				DamageType
			);
			
			if (Pawn(Victims) != None && Pawn(Victims).Health > 0 && Vehicle(Victims) == None)
			{
				foreach Victims.BasedActors(class'RaygunPlagueEffect', RPE)
				{
					if (Victim != None)
						RPE.ExtendDuration(8);
					else RPE.ExtendDuration(4 * Square(damageScale));
				}
				if (RPE == None)
				{
					RPE = Spawn(class'RaygunPlagueEffect',Victims,,Victims.Location);// + vect(0,0,-30));
					RPE.Initialize(Victims);
					if (Victim == None)
						RPE.Duration = FMax(1, 4 * Square(damageScale));
					else RPE.Duration = 8;
					if (Instigator!=None)
					{
						RPE.Instigator = Instigator;
						RPE.InstigatorController = Instigator.Controller;
					}
				}
			}
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
     ImpactManager=Class'BWBPOtherPackPro.IM_Raygun'
     AccelSpeed=11000.000000
     TrailClass=Class'BWBPOtherPackPro.RaygunChargedShotTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTRaygunChargedRadius'
     DamageTypeHead=Class'BWBPOtherPackPro.DTRaygunCharged'
     ShakeRadius=300.000000
     MotionBlurRadius=250.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=2.000000
     Speed=5500.000000
     MaxSpeed=17500.000000
     Damage=80.000000
     DamageRadius=256.000000
     MomentumTransfer=120000.000000
     MyDamageType=Class'BWBPOtherPackPro.DTRaygunCharged'
     ExploWallOut=24.000000
     LightType=LT_Steady
     LightHue=30
     LightSaturation=24
     LightBrightness=64.000000
     LightRadius=192.000000
     bDynamicLight=True
     LifeSpan=9.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=128.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
}
