//=============================================================================
// XOXOProjectile
//=============================================================================
class XOXOProjectile extends BallisticProjectile;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	
	if (FRand() > 0.5)
		SetStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.X');
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;
	local Vector ClosestLocation, BoneTestLocation, temp;

	if (Instigator != None && Instigator.Weapon != None && Instigator.Weapon.IsA('RSDarkStar'))
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
	}

	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
		

	if (xPawn(Other) != None)
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
		temp = Normal(Velocity);
		temp *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation = temp;
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
		BoneTestLocation += HitLocation;
		
		Victim = GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT);;
	}

	else Victim = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);

	if (bWasAlive && Pawn(Victim).Health <= 0)
		class'XOXOLewdness'.static.DistributeLewd(HitLocation, Instigator, Pawn(Victim), self);
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
			GotoState('NetTrapped');
		else
			Destroy();
	}

	else if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry && (Pawn(Wall) == None || Vehicle (Wall) != None)) // ignore pawns when using HitWall
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			DoDamage(Wall, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

	HurtWall = None;
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
    WeaponClass=Class'BWBP_OP_Pro.XOXOStaff'
     ImpactManager=Class'BWBP_OP_Pro.IM_XOXO'
     PenetrateManager=Class'BWBP_OP_Pro.IM_XOXO'
     bRandomStartRotation=False
     AccelSpeed=100000.000000
     TrailClass=Class'BWBP_OP_Pro.XOXOShotTrail'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTXOXOFast'
     bUsePositionalDamage=True
     
     MaxDamageGainFactor=0.6
     DamageGainStartTime=0.05
     DamageGainEndTime=0.25

     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=5500.000000
     MaxSpeed=14000.000000
     bSwitchToZeroCollision=True
     Damage=38.000000
     DamageRadius=48.000000
     MomentumTransfer=-1000.000000
     MyDamageType=Class'BWBP_OP_Pro.DTXOXOFast'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=220
     LightSaturation=120
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BWBP_OP_Static.XOXO.O'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2FlyBy'
     LifeSpan=4.000000
     DrawScale=1.500000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}
