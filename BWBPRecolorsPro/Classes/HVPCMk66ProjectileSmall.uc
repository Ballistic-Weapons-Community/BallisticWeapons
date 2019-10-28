//=============================================================================
// A73Projectile.
//
// Simple projectile for da A73.
//
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk66ProjectileSmall extends BallisticProjectile;

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
     ImpactManager=Class'BWBPRecolorsPro.IM_BFGProjectileSmall'
     PenetrateManager=Class'BWBPRecolorsPro.IM_BFGProjectileSmall'
     bPenetrate=True
     bRandomStartRotaion=False
     TrailClass=Class'BWBPRecolorsPro.BFGSmallTrailEmitter'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_BFGChargeSmall'
     bUsePositionalDamage=True
     DamageHead=130.000000
     DamageLimb=65.000000
     DamageTypeHead=Class'BWBPRecolorsPro.DT_BFGChargeSmall'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=8000.000000
     MaxSpeed=8000.000000
     Damage=65.000000
     DamageRadius=128.000000
     MomentumTransfer=12500.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_BFGChargeSmall'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=100
     LightSaturation=70
     LightBrightness=192.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'BallisticHardware2.A73.A73Projectile'
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.A73.A73ProjFly'
     LifeSpan=6.000000
     DrawScale3D=(X=0.250000,Y=1.500000,Z=1.500000)
     Skins(0)=FinalBlend'BallisticRecolors3TexPro.BFG.BFGProjFB'
     Skins(1)=FinalBlend'BallisticRecolors3TexPro.BFG.BFGProj2FB'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=12384)
}
