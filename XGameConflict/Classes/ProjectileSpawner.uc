
class ProjectileSpawner extends Actor
    placeable;

var() float ProjectileSpeed;
var() float SpawnRateMin;
var() float SpawnRateMax;
var() class<xEmitter> TrailEmitter;
var() class<xEmitter> ExplosionEmitter;
var() Mesh ProjectileMesh;
var() float ProjectileMeshScale;
var() Sound SpawnSound;
var() Sound ExplosionSound;
var() float Damage;
var() float DamageRadius;
var() class<DamageType> DamageType;
var() float ProjectileLifeSpan;
var() float RandomStartDelay;
var() bool GravityAffected;

replication
{
	reliable if( bNetInitial && Role==ROLE_Authority )
        ExplosionEmitter, TrailEmitter, ProjectileMesh, ExplosionSound, ProjectileMeshScale, ProjectileLifeSpan;
}

function PostBeginPlay()
{
    if (SpawnRateMin > 0)
        SetTimer(1.0/SpawnRateMin+RandomStartDelay*FRand(), false);
}

function Timer()
{
    SpawnProjectile();
    if (SpawnRateMin > 0 && SpawnRateMax > 0)
        SetTimer(1.0/RandRange(SpawnRateMin, SpawnRateMax), false);
}

function SpawnProjectile()
{
    local SpawnerProjectile Proj;

    Proj = Spawn(class'SpawnerProjectile', self,, Location, Rotation);
    Proj.Spawner = self;

    if (SpawnSound != None)
    {
        PlaySound(SpawnSound);
    }
}


function Trigger(Actor Other, Pawn EventInstigator)
{
    SpawnProjectile();
}

defaultproperties
{
    RemoteRole=ROLE_None
    Texture=S_Emitter
    bHidden=true
    bDirectional=true
    ProjectileLifeSpan=10.0
    SpawnRateMin=1.0
    SpawnRateMax=1.0
}
