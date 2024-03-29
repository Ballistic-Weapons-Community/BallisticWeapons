class XOXOBomb extends BallisticGrenade;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	
	if (FRand() > 0.5)
		SetStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.X');
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    DoDamage(Other, HitLocation);
}

simulated function bool Impact( actor Other, vector HitLocation )
{
	if (Other.bProjTarget && (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact))
        return false;

	if ( !Other.bProjTarget || PlayerImpactType == PIT_Bounce )
	{
		HitWall (Normal(HitLocation - Other.Location), Other);
        return true;
	}

    return false;
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
WeaponClass=Class'BWBP_OP_Pro.XOXOStaff'
	DampenFactor=0.150000
	DampenFactorParallel=0.300000
	ArmingDelay=0.75
	UnarmedDetonateOn=DT_ImpactTimed
	UnarmedPlayerImpactType=PIT_Bounce
	ArmedDetonateOn=DT_Impact
	ArmedPlayerImpactType=PIT_Detonate
	DetonateDelay=0.600000
	ImpactDamage=100
	ImpactDamageType=Class'BWBP_OP_Pro.DTXOXOBomb'
	ImpactManager=Class'BWBP_OP_Pro.IM_XOXO'
	PenetrateManager=Class'BWBP_OP_Pro.IM_XOXO'
	bRandomStartRotation=False
	TrailClass=Class'BWBP_OP_Pro.XOXOBombTrail'

	
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Speed=2500.000000
	MaxSpeed=2500.000000
	Damage=100.000000
	DamageRadius=768.000000
	MomentumTransfer=-30000.000000
	MyDamageType=Class'BWBP_OP_Pro.DTXOXOBomb'
	MyRadiusDamageType=Class'BWBP_OP_Pro.DTXOXOBomb'

	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=220
	LightSaturation=120
	LightBrightness=192.000000
	LightRadius=6.000000
	bDynamicLight=True

	StaticMesh=StaticMesh'BWBP_OP_Static.XOXO.O'
	DrawScale=3.000000
	Style=STY_Additive
	RotationRate=(Roll=16384)

	AmbientSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2FlyBy'
	SoundVolume=255
	SoundRadius=75.000000
	LifeSpan=8.000000

	CollisionRadius=2.000000
	CollisionHeight=2.000000

}
