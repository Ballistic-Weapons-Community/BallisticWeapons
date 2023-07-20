//=============================================================================
// AY90WaveProjectile.
//
// Powerful projectile that launches in a horizontal bisecting wave.
// Projectiles link to each other and heal ONS objects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90WaveProjectile extends BallisticProjectile;

var vector					StartLocation;
var bool					bScaleDone;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	StartLocation = Location;
}

// Projectile grows as it comes out the gun...
simulated function Tick(float DT)
{
	local vector DS;

	if (bScaleDone)
		return;

	DS.X = VSize(Location-StartLocation)/(384*DrawScale);
	DS.Y = 0.5;
	DS.Z = 0.5;
	if (DS.X >= 1)
	{
		DS.X = 1;
		bScaleDone=true;
	}
	SetDrawScale3D(DS);
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
			AdjustedDamage *= 4;
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
			AdjustedDamage *= 4;
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
	WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
	ModeIndex=1
	MyDamageType=Class'BWBP_SKC_Pro.DTAY90SkrithAlt'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTAY90SkrithAltHead'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTAY90SkrithRadius'
	ImpactManager=Class'BWBP_SKC_Pro.IM_SkrithbowWaveProjectile'
	PenetrateManager=Class'BWBP_SKC_Pro.IM_SkrithbowWaveProjectile'
	bPenetrate=False
	bRandomStartRotation=False
	bTearOnExplode=False
	AccelSpeed=70000.000000
	bUsePositionalDamage=True
	Damage=40
	HeadMult=2.0
	LimbMult=0.5
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Speed=85.000000
	MaxSpeed=4500.000000
	DamageRadius=96.000000
	MomentumTransfer=150.000000
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=150
	LightSaturation=0
	LightBrightness=192.000000
	LightRadius=6.000000
	TrailClass=Class'BWBP_SKC_Pro.AY90WaveTrailEmitter'
	bDynamicLight=True
	AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
	LifeSpan=4.000000
	//StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile'
	//Skins(1)=FinalBlend'BWBP_SKC_Tex.SkrithBow.AY90Wave1-Final'
	//Skins(0)=FinalBlend'BWBP_SKC_Tex.SkrithBow.AY90Wave2-Final'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
	Skins(0)=Texture'BW_Core_WeaponTex.Misc.Invisible'
	Skins(1)=FinalBlend'BWBP_SKC_Tex.SkrithBow.AY90Wave1-Final'
	Style=STY_Additive
	SoundVolume=255
	SoundRadius=75.000000
	CollisionRadius=15.000000
	CollisionHeight=10.000000
	bFixedRotationDir=True
	DrawScale=8.000000
}
