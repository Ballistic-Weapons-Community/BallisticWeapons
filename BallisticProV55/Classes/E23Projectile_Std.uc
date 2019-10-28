//=============================================================================
// E23Projectile_Std.
//
// Normal E23 plasma projectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23Projectile_Std extends BallisticProjectile;

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super.GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	if (default.LifeSpan - LifeSpan > 0.1)
		Dmg *= 1 + 1.5 * FMin(default.LifeSpan - LifeSpan - 0.1, 0.7) / 0.7;
		
	return Other;
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority && Other != HitActor)		// Do damage for direct hits
		DoDamage(Other, HitLocation);

	HitActor = Other;
	Explode(HitLocation, Normal(HitLocation - Other.Location));
}

simulated function HitWall(vector HitNormal, actor Wall)
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
		Destroy();
	}
	else
		Super.HitWall(HitNormal, Wall);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local byte Flags;

	if (bExploded)
		return;
	if ( HitActor != None && (Vehicle(HitActor)!=None || DestroyableObjective(HitActor)!=None || DestroyableObjective(HitActor.Owner)!=None) && Instigator!= None && HitActor.TeamLink(Instigator.GetTeamNum()) )
	{
	}
	else if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (HitActor != None && (Vehicle(HitActor)!=None || DestroyableObjective(HitActor)!=None || DestroyableObjective(HitActor.Owner)!=None))
			Flags=4;//No Decals
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/, Flags);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator, Flags);
	}
	BlowUp(HitLocation);
	bExploded=true;

	Destroy();
}

// Plasma-based weapons heal vehicles and PowerCores
simulated function DoDamage(Actor Other, vector HitLocation)
{
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * myDamageType.default.VehicleDamageScaling;
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
	super.DoDamage(Other, HitLocation);
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_E23Projectile'
     bRandomStartRotaion=False
     AccelSpeed=100000.000000
     MyRadiusDamageType=Class'BallisticProV55.DTE23Plasma'
     bUsePositionalDamage=True
     DamageHead=31.000000
     DamageLimb=31.000000
     DamageTypeHead=Class'BallisticProV55.DTE23PlasmaHead'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=5500.000000
     MaxSpeed=14000.000000
     Damage=31.000000
     DamageRadius=16.000000
     MomentumTransfer=100.000000
     MyDamageType=Class'BallisticProV55.DTE23Plasma'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=64
     LightSaturation=96
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.VPR.VPRProjectile'
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.A73.A73ProjFly'
     LifeSpan=4.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}
