//=============================================================================
// VSKActorPoison.
//
// Fire attached to players. This is spawned on server to do damage and on
// client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90ActorExploder extends BallisticEmitter
	placeable;

var   Actor				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() class<DamageType>	MyRadiusDamageType;		// DamageType done to people near the player
var() class<BCImpactManager>    ImpactManager;			// Impact manager to spawn on final hit
var() int				Damage;			// Damage done
var() int				StickDamage;			// Damage done
var() int				DamageRadius;	
var   bool				bDetonated;		// Been detonated, waiting for net syncronization or something
var		bool			bExploded;
var() Sound				ArmingSound;
var Controller	InstigatorController;
var() ProjectileEffectParams.ERadiusFallOffType        RadiusFallOffType;

replication
{
	reliable if(Role == ROLE_Authority)
		bDetonated;
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();
	if (bDetonated)
		Explode(Location, vector(Rotation));
}

function Reset()
{
	Destroy();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(1, true);

	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
	
	if (Role==ROLE_Authority)
	{
		PlaySound(ArmingSound,,2.0,,256,,);
	}
}

simulated event Timer()
{
	if (Role < ROLE_Authority)
		return;
	else
	{
		bDetonated = true;
		
		if (Victim != None && Level.NetMode != NM_Client)
		{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (Victim, StickDamage, Instigator, Location, vect(0,0,0), DamageType);
		}
		
		Explode(Location, vector(Rotation));
		Kill();
	}


}

simulated event Tick(float DT)
{
	Super.Tick(DT);
	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (level.netMode == NM_DedicatedServer)
		Destroy();
	if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		SetBase(None);
		Kill();
	}
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	if(DamageRadius > 0)
	{
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, 10000, HitLocation, Victim);
	}

	MakeNoise(1.0);
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	//if (ShakeRadius > 0 || MotionBlurRadius > 0)
	//	ShakeView(HitLocation);
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		/*if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);*/
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		GotoState('NetTrapped');
	else
		Destroy();
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
    local bool can_see;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( Victims.bCanBeDamaged && (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim )
		{
            can_see = FastTrace(Victims.Location, Location);

            damageScale = 1f;

            dir = Victims.Location;
            if (Victims.Location.Z > HitLocation.Z)
                dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
            else 
                dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
            dir -= HitLocation;
            dist = FMax(1, VSize(dir));
            dir /= dist;

            if (can_see)
            {
                if (RadiusFallOffType != RFO_None)
                    damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius) / DamageRadius);
                if (RadiusFallOffType == RFO_Quadratic)
                    damageScale = Square(damageScale);
            }

			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );

			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				damageScale * dir,
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
     ArmingSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-Fuse'
     DamageType=Class'BWBP_SKCExp_Pro.DT_VSKTranqPsn'
     MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DT_VSKTranqPsn'
     ImpactManager=Class'BWBP_SKCExp_Pro.IM_A73BPower'
     StickDamage=50
     Damage=150
     DamageRadius=256.000000
     RadiusFallOffType=RFO_Quadratic
     AutoDestroy=True
     bNoDelete=False
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
