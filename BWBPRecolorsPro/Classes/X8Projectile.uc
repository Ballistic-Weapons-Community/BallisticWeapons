//=============================================================================
// X8 projectile.
//
// A launched X8 knife.
//=============================================================================
class X8Projectile extends BallisticProjectile;

var   bool			bStuckInWall;
var   bool			bHitPlayer;


simulated function InitProjectile ()
{
	SetTimer(0.1, false);
	super.InitProjectile();
}
simulated event Timer()
{
	super.Timer();
	bFixedRotationDir = True;
	RotationRate.Pitch = -100000;
}
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None)
		return;

	if (bStuckInWall)
		return;

	else if (Other == Instigator || Other == Owner)
		return;
	if (bHitPlayer)
		return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);
	bHitPlayer = true;
	SetLocation(HitLocation);
	Velocity = Normal(HitLocation-Other.Location)*100;
	SetPhysics(PHYS_Falling);
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
     bRandomStartRotaion=False
     bUsePositionalDamage=True
	 bIgnoreTerminalVelocity=True
     
     
     DamageTypeHead=Class'BWBPRecolorsPro.DTX8KnifeRifleLaunchedHead'
     bWarnEnemy=False
     Speed=7500.000000
     MaxSpeed=7500.000000
     Damage=100.000000
     MyDamageType=Class'BWBPRecolorsPro.DTX8KnifeRifleLaunched'
     StaticMesh=StaticMesh'BWBP_SKC_Static.X8.X8Proj'
     bNetTemporary=False
     Physics=PHYS_Falling
     LifeSpan=0.000000
     DrawScale=0.150000
     bUnlit=False
}
