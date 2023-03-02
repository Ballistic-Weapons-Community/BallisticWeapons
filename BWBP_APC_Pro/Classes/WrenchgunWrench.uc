//=============================================================================
// Launched AK-47 knife.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class WrenchgunWrench extends BallisticProjectile;

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
     ModeIndex=1
	 ImpactManager=Class'BallisticProV55.IM_GunHit'
     bUsePositionalDamage=True
     DamageTypeHead=Class'BWBP_APC_Pro.DTWrenchgunShotHead'
     bWarnEnemy=False
     Speed=8500.000000
     MaxSpeed=8500.000000
     Damage=44.000000
     MomentumTransfer=75000.000000
     MyDamageType=Class'BWBP_APC_Pro.DTWrenchgunShot'
     StaticMesh=StaticMesh'BWBP_OP_Static.Wrench.WrenchPickup'
     Physics=PHYS_Falling
     LifeSpan=0.000000
     bIgnoreTerminalVelocity=True
}
