class RaygunPlagueChargedProjectile extends BallisticProjectile;

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);

	SetRotation(Rotation  + rot(0,0,250000) * DeltaTime);
}

function DoDamage (Actor Other, vector HitLocation)
{
	local RaygunPlagueEffect RPE;
	
	super.DoDamage (Other, HitLocation);
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None && Level.TimeSeconds - Pawn(Other).SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime)
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
	local RaygunPlagueEffect RPE;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
			{
				if (!bCoverPenetrator)
					continue;
				else DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			else DmgRadiusScale = 1;
			
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			if (bCoverPenetrator && DmgRadiusScale < 1 && VSize(dir) > DamageRadius * DmgRadiusScale)
				continue;
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ (DamageRadius * DmgRadiusScale));
			
			
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
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

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 1, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 1, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else 
		Destroy();
}

defaultproperties
{
     ImpactManager=Class'BWBPOtherPackPro.IM_Raygun'
     AccelSpeed=10000.000000
     TrailClass=Class'BWBPOtherPackPro.RaygunPlagueChargedShotTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTRaygunPlagueProjectile'
     DamageTypeHead=Class'BWBPOtherPackPro.DTRaygunPlagueProjectile'
     ShakeRadius=300.000000
     MotionBlurRadius=250.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=2.000000
     Speed=4500.000000
     MaxSpeed=15000.000000
     Damage=40.000000
     DamageRadius=200.000000
     MomentumTransfer=2500.000000
     MyDamageType=Class'BWBPOtherPackPro.DTRaygunPlagueProjectile'
     ExploWallOut=20.000000
     LightType=LT_Steady
     LightHue=70
     LightSaturation=50
     LightBrightness=96.000000
     LightRadius=64.000000
     bDynamicLight=True
     LifeSpan=9.000000
     Skins(0)=FinalBlend'BallisticEffects.GunFire.A73ProjFinal'
     Skins(1)=FinalBlend'BallisticEffects.GunFire.A73Proj2Final'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=128.000000
}
