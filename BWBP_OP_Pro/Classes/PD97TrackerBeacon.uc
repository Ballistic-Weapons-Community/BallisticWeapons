//=============================================================================
// PD97TrackerBeacon.
//
// Makes a noise and blinks.
//
// by SK
// uses code by Black Eagle and Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class PD97TrackerBeacon extends BallisticProjectile;


var() Class<DamageType>	StuckDamageType;// Type of Damage caused for sticking to players
var() bool bNoFXOnExplode; //Do FX in Destroyed and not in Explode
var() Sound				DetonateSound;
var   float				TriggerStartTime;	// Time when trigger will be active

var PD97Bloodhound Master;

simulated function ProcessTouch (Actor Other, vector HitLocation);
function SetManualMode (bool bManual);	

function bool IsStationary()
{
	return true;
}

simulated function Destroyed()
{
	local int Surf;
	
	if (bNoFXOnExplode && !bNoFX)
    {
		if (EffectIsRelevant(Location,false) && ImpactManager != None && level.NetMode != NM_DedicatedServer)
		{
			if (bCheckHitSurface)
				CheckSurface(Location, -Vector(Rotation), Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(Location, -Vector(Rotation), Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(Location, -Vector(Rotation), Surf, Instigator);
		}
	}
	
	Super.Destroyed();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
		
	if (!bNoFXOnExplode)
	{
   		if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
		{
			if (bCheckHitSurface)
				CheckSurface(HitLocation, HitNormal, Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
		}
	}

	BlowUp(HitLocation);
	bExploded = True;
	
	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else Destroy();
}

simulated function InitProjectile()
{
	super.InitProjectile();

	PlaySound(DetonateSound,,2.0,,256,,);
	SetTimer(30.0, false);
	return;
}

simulated event Timer()
{
	if (StartDelay > 0)
		super.Timer();
	else
		Explode(Location, vector(Rotation));
}

simulated singular function HitWall(vector HitNormal, actor Wall);

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
	if(DamageRadius > 0)
	{
		if(Pawn(Base) != None)
		{
			class'BallisticDamageType'.static.GenericHurt
			(
				Base,
				Damage,
				Instigator,
				HitLocation,
				MomentumTransfer * Normal(Base.Location-Location),
				StuckDamageType
			);
			
			TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, Base);
		}
		else
			TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation);
	}
//	HitActor = None;
	MakeNoise(1.0);
}

defaultproperties
{
	 StuckDamageType=Class'BallisticProV55.DTM46GrenadeStuck'
	 bNoFXOnExplode=True
	 bTearOnExplode=False
	 Damage=5.000000
	 DamageRadius=1.000000
	 ModeIndex=1
	 DetonateSound=Sound'MenuSounds.select3'
     ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornShatter'
	 MyRadiusDamageType=Class'BallisticProV55.DTM46GrenadeRadius'
	 SplashManager=Class'BallisticProV55.IM_ProjWater'
     TrailClass=Class'BWBP_OP_Pro.PD97BeaconEffect'
	 ShakeRadius=512.000000
	 MotionBlurRadius=384.000000
	 MotionBlurFactor=3.000000
	 MotionBlurTime=4.000000
	 WallPenetrationForce=128
	 MyDamageType=Class'BallisticProV55.DTM46GrenadeRadius'
	 StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-AR.OA-AR_Grenade'
	 CullDistance=2500.000000
	 bNetTemporary=False
	 Physics=PHYS_None
	 LifeSpan=0.000000
	 DrawScale=0.450000
	 bUnlit=False
	 CollisionRadius=16.000000
	 CollisionHeight=16.000000
	 bCollideWorld=False
	 bProjTarget=True
	 bNetNotify=True
	 
}
