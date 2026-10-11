//=============================================================================
// BallisticImpactRelay.
//
// Shows the clients a projectile's impact that they would never have seen.
//
// A server moves a new projectile in the same frame it is fired in, and only
// sends it to the clients at the end of that frame. One that has hit something
// by then, a wall or a player right in front of the gun, is already gone, and
// no client was ever told of it: no impact effect and no sound. One that the
// server keeps and tears off when it blows up is not sent either, once it is
// torn off. The server spawns one of these in its place (see
// BallisticProjectile.RelayUnseenImpact) and each client plays the
// projectile's impact where this turns up.
//=============================================================================
class BallisticImpactRelay extends Actor;

// How far off the surface this is put. Somebody who did not fire the shot is only sent an actor he has a clear
// line to, and a point right on a wall does not always have one
const SurfaceGap = 4;

var class<BCImpactManager>	ImpactManager;
var byte					HitSurf;

replication
{
	reliable if (bNetInitial && Role == ROLE_Authority)
		ImpactManager, HitSurf;
}

// The hit normal travels as the rotation
static function Send(Actor Source, class<BCImpactManager> IM, vector HitLocation, vector HitNormal, int Surf)
{
	local BallisticImpactRelay R;

	R = Source.Spawn(class'BallisticImpactRelay',,, HitLocation + HitNormal * SurfaceGap, rotator(HitNormal));
	if (R == None)
		return;
	R.Instigator = Source.Instigator;
	R.ImpactManager = IM;
	R.HitSurf = Surf;
}

simulated function PostNetBeginPlay()
{
	local vector HitLocation, HitNormal;

	Super.PostNetBeginPlay();

	if (Level.NetMode != NM_Client || ImpactManager == None)
		return;
	// Back to the surface, but for a unit: the place arrives rounded, and must not end up inside the wall
	HitNormal = vector(Rotation);
	HitLocation = Location - HitNormal * (SurfaceGap - 1);
	if (Instigator == None)
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, Level.GetLocalPlayerController());
	else
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, Instigator);
}

defaultproperties
{
     DrawType=DT_None
     bNetTemporary=True
     bReplicateInstigator=True
     bNetInitialRotation=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=1.000000
}
