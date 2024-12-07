//=============================================================================
// HVPCMk5ProjectileSmall_Green.
//
// Green flavored HVPC alt fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk5ProjectileSmall_Green extends BallisticProjectile;

var vector					StartLocation;
var bool					bScaleDone;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	StartLocation = Location;
}

// A73 heals vehicles and PowerCores
simulated function DoDamage(Actor Other, vector HitLocation)
{
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling;
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

simulated function HitWall(vector HitNormal, actor Wall)
{
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = Damage * Instigator.DamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		Destroy();
	}
	else
		Super.HitWall(HitNormal, Wall);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (level.DetailMode > DM_Low && level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Kill();
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
	WeaponClass=Class'BWBP_SKC_Pro.HVPCMk5PlasmaCannon'
	ImpactManager=Class'BWBP_SKC_Pro.IM_BFGProjectileSmall'
	PenetrateManager=Class'BWBP_SKC_Pro.IM_BFGProjectileSmall'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	bPenetrate=True
	bRandomStartRotation=False
	TrailClass=Class'BWBP_SKC_Pro.BFGSmallTrailEmitter'
	
	MyDamageType=Class'BWBP_SKC_Pro.DTPlasmaChargeSmall'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTPlasmaChargeSmall'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTPlasmaChargeHeadSmall'
	bUsePositionalDamage=True

	Speed=8000.000000
	MaxSpeed=8000.000000
	Damage=65.000000
	DamageRadius=128.000000
	MomentumTransfer=12500.000000
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=100
	LightSaturation=70
	LightBrightness=192.000000
	LightRadius=12.000000
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile'
	bDynamicLight=True
	AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
	LifeSpan=6.000000
	DrawScale3D=(X=0.250000,Y=1.500000,Z=1.500000)
	Skins(0)=FinalBlend'BWBP_SKC_Tex.BFG.BFGProjFB'
	Skins(1)=FinalBlend'BWBP_SKC_Tex.BFG.BFGProj2FB'
	Style=STY_Additive
	SoundVolume=255
	SoundRadius=75.000000
	bFixedRotationDir=True
	RotationRate=(Roll=12384)
	ModeIndex=1
}
