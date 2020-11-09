//=============================================================================
// M46StickyMine.
//
// Detonates automatically if it gets stuck to a player or vehicle, causing a short beeping before blowing the victim to pieces!.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46StickyMine extends M46Mine;


var() Class<DamageType>	StuckDamageType;// Type of Damage caused for sticking to players
var() bool bNoFXOnExplode; //Do FX in Destroyed and not in Explode

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
	SetTimer(1.0, false);
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
     Damage=125.000000
     DamageRadius=512.000000
}
