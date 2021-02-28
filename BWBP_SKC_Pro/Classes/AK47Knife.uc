//=============================================================================
// Launched AK-47 knife.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK47Knife extends BallisticProjectile;

var   bool			bStuckInWall;
var   bool			bHitPlayer;

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None)
		return;

	else if (Other == Instigator || Other == Owner)
		return;
	if (bStuckInWall || bHitPlayer)
		return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);
	bHitPlayer = true;
	SetPhysics(PHYS_Falling);
	SetLocation(HitLocation);
	Velocity = Normal(HitLocation-Other.Location)*100;
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, None );
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local int Surf;
	if (bStuckInWall)
		return;
	if (Wall != None && !Wall.bWorldGeometry && !Wall.bStatic)
	{
		if (Role == ROLE_Authority && !bHitPlayer)
			DoDamage(Wall, Location);
		if (Mover(Wall) == None)
		{
			bHitPlayer = true;
			Velocity = HitNormal*100;
			return;
		}
	}
	SetRotation(Rotator(Velocity)/*+rot(32768,0,0)*/);
	OnlyAffectPawns(true);
	SetCollisionSize(40, 40);
	SetPhysics(PHYS_None);
	bFixedRotationDir=false;
	bStuckInWall=true;
	bHardAttach=true;
	CheckSurface(Location, HitNormal, Surf, Wall);
	LifeSpan=20.0;
	if (Wall != None)
		SetBase(Wall);
	if (Level.NetMode != NM_DedicatedServer && ImpactManager != None && /*(!Level.bDropDetail) && (Level.DetailMode != DM_Low) && */EffectIsRelevant(Location,false))
		ImpactManager.static.StartSpawn(Location, HitNormal, Surf, self);
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_KnifeThrown'
     bRandomStartRotation=False
     bUsePositionalDamage=True
	 bIgnoreTerminalVelocity=True
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
	 TrailOffset=(X=-2.000000)
     
     DamageTypeHead=Class'BWBP_SKC_Pro.DTX8KnifeRifleLaunchedHead'
     bWarnEnemy=False
     Speed=8500.000000
     MaxSpeed=8500.000000
     Damage=90.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTX8KnifeRifleLaunched'
     StaticMesh=StaticMesh'BWBP_SKC_Static.X8.X8Proj'
     Physics=PHYS_Falling
     LifeSpan=0.000000
     DrawScale=0.150000
     bUnlit=False
}
