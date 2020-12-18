class XOXOBomb extends BallisticGrenade;

var Actor   LastHit;
var float   ArmingDelay;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	
	if (FRand() > 0.5)
		SetStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.X');
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(ArmingDelay, False);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (!bHasImpacted)
		DetonateOn=DT_Impact;
		
	else Explode(Location, vect(0,0,1));
}

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Other == HitActor)
		return;
	if (Base != None)
		return;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
	if (Other.bProjTarget && (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact))
	{
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		return;
	}
	if ( !Other.bProjTarget || PlayerImpactType == PIT_Bounce )
	{
		HitWall (Normal(HitLocation - Other.Location), Other);
		if (Other != LastHit)
		{
			class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
			LastHit = Other;
		}
	}
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, None );
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	Victim = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);

	if (bWasAlive && Pawn(Victim).Health <= 0)
		class'XOXOLewdness'.static.DistributeLewd(HitLocation, Instigator, Pawn(Other), self);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;
	
	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.2;
		DampenFactorParallel *= 0.2;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	
	Speed = VSize(Velocity/2);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    	}
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local bool bWasAlive;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		bWasAlive = False;
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if (xPawn(Victims) != None && Pawn(Victims).Health > 0)
			{
				if (Monster(Victims) == None || Pawn(Victims).default.Health > 275)
					bWasAlive = true;
			}
			else if (Vehicle(Victims) != None && Vehicle(Victims).Driver!=None && Vehicle(Victims).Driver.Health > 0)
				bWasAlive = true;
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);

			if (bWasAlive && Pawn(Victims).Health <= 0)
				class'XOXOLewdness'.static.DistributeLewd(Victims.Location, Instigator, Pawn(Victims), self);
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
     DampenFactor=0.150000
     DampenFactorParallel=0.300000
     ArmingDelay=0.75
     DetonateOn=DT_ImpactTimed
	 PlayerImpactType=PIT_Detonate
     DetonateDelay=0.600000
     ImpactDamage=60
     ImpactDamageType=Class'BWBPOtherPackPro.DTXOXOBomb'
     ImpactManager=Class'BWBPOtherPackPro.IM_XOXO'
     PenetrateManager=Class'BWBPOtherPackPro.IM_XOXO'
     bRandomStartRotaion=False
     TrailClass=Class'BWBPOtherPackPro.XOXOBombTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTXOXOBomb'
     
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=2500.000000
     MaxSpeed=2500.000000
     Damage=100.000000
     DamageRadius=768.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BWBPOtherPackPro.DTXOXOBomb'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=220
     LightSaturation=120
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BWBPOtherPackStatic.XOXO.O'
     bDynamicLight=True
     AmbientSound=Sound'BWBP4-Sounds.NovaStaff.Nova-Fire2FlyBy'
     LifeSpan=8.000000
     DrawScale=3.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     RotationRate=(Roll=16384)
}
